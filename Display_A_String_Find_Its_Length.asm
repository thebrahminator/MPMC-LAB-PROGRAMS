.model small
.data
        msg1 db 10d,13d,"Enter a string: $"
        msg2 db 10d,13d,"Entered String: $"
        arr db 0Bh dup(0)
        len db 00h
        msg3 db 10d,13d,"Length: $"             

.code
        mov ax,@data
        mov ds,ax

        lea dx,msg1
        mov ah,09h
        int 21h
        lea si,arr
l1:     mov ah,01h
        int 21h
        cmp al,0Dh
        jz l2
        mov [si],al
        inc si
        inc len
        jmp l1

l2:     mov al,24h
        mov [si],al

        lea dx,msg2
        mov ah,09h
        int 21h
        lea dx,arr
        mov ah,09h
        int 21h
        lea dx,msg3
        mov ah,09h
        int 21h

        cmp len,09h
        jbe l3
        add len,07h

l3:     add len,30h
        mov dl,len
        mov ah,02h
        int 21h

        mov ah,4Ch
        int 21h
end
32 Bit Code
%macro scall 4
mov eax,%1
mov ebx,%2
mov ecx,%3
mov edx,%4
int 80h
%endmacro
section .data
        m1 db 10d,13d,"Enter a string: "
        l1 equ $-m1
        m2 db 10d,13d,"Entered String: "
        l2 equ $-m2
        m3 db 10d,13d,"Length: "
        l3 equ $-m3

section .bss
        buffer resb 50
        size equ $-buffer
        count resd 1
        dispnum resb 8

section .text
        global _start
        _start:
                scall 4,1,m1,l1
                scall 3,0,buffer,size
                mov [count],eax
                scall 4,1,m2,l2
                scall 4,1,buffer,[count]
                scall 4,1,m3,l3

                mov esi,dispnum+7
                mov eax,[count]
                mov ecx,8
                dec eax
        UP1:
                mov edx,0
                mov ebx,10
                div ebx
                add dl,30h
                mov [esi],dl
                dec esi
                loop UP1

                scall 4,1,dispnum,8

                mov eax,1
                mov ebx,0
                int 80h
