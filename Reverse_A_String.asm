print macro m
mov ah,09h
mov dx,offset m
int 21h
endm

.model small

.data

empty db 10,13, "   $"
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
mstring db 10,13, "Enter the string: $"
mstring2 db 10,13, "Enter second string: $"
mreverse db 10,13, "Reversed string: $"



.code

start:
mov ax,@data
mov ds,ax

        print mstring
        call accept_string


        mov si,offset str1
        mov di,offset str2



        mov al,[si]
        mov [di],al
        inc si
        inc di


        mov al,[si]
        mov [di],al
        inc si
        inc di

        mov cl,str1+1
        mov ch,00
        add si,cx
        dec si

move_more: mov al,[si]
           mov [di],al
           dec si
           inc di
           dec cl
           jnz move_more


        print mreverse
        print str2+2
        print empty

exit:
mov ah,4ch
int 21h



accept proc near

mov ah,01
int 21h
ret
accept endp

display1 proc near

   mov al,bl
   mov bl,al
   and al,0f0h
   mov cl,04
   rol al,cl

   cmp al,09
   jbe number
   add al,07
number:  add al,30h
         mov dl,al
         mov ah,02
         int 21h

         mov al,bl
         and al,00fh
         cmp al,09
         jbe number2
         add al,07
number2:  add al,30h
          mov dl,al
          mov ah,02
          int 21h
ret
display1 endp



accept_string proc near

mov ah,0ah
mov dx,offset str1  
int 21h
ret
accept_string endp

end start
end
