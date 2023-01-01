name "TanggalHari"

org 100h  

TAB EQU 9   

mov ah, 2ah                  
int 21h 
lea bx, week_table
xlat
mov week, al                   
add cx, 0f830h                
mov ax, cx 
call deci 
mov year, ax 
mov al, dh                  
call deci 
mov mont, ax 
mov al, dl                  
call deci 
mov day, ax 


mov ah, TAB 
mov dx, offset txt 
int 21h 


mov cx, 0                    
mov ax, 3c00h                
mov dx, offset fildat 
int 21h 
jb error                    

mov handle, ax

mov ax, 4200h 
mov bx, handle 
xor cx, cx                   
xor dx, dx                     
int 21h 
jb error 

mov ah, 40h                             
mov bx, handle 
mov cx, offset seco - offset txt        
mov dx, offset dat 
int 21h 
jb error 


mov ah, 3eh                 
mov bx, handle 
int 21h 

mov ah, 0
int 16h

error:                      
mov ax, 4c00h
int 21h


deci:                         
push cx
xor ah, ah 
mov cl, 10 
div cl 
add ax, 3030h
pop cx
ret 


fildat db "c:\date.txt",0    
handle db 0,0 

txt  db 0Dh, 0Ah, 0Ah, TAB, TAB           
dat  db "Hari: "
week db 0, TAB                          
     db "20"
year db 0, 0, '-'        
mont db 0, 0, '-' 
day  db 0, 0, TAB  

     db 0Dh, 0Ah, 24h        
                    
                    
week_table db "MSSRKJS"