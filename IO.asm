section .data

section .bss 
    I_SIZE equ 0x1000
    O_SIZE equ I_SIZE+0x40
    _o: RESB O_SIZE-I_SIZE
    _i: RESB I_SIZE+0xc
    _i0: RESD 0x1
    _o0: RESD 0x1

section .text
    global _start

_su: ; put _i in eax ; destroys eax,ebx,edx ; Thank you https://dmoj.ca/user/d
    mov edx, [_i0]
    movzx eax, byte[_i+edx]
    .1: inc edx
    cmp byte[_i+edx], '0'
    jl .2
    lea ebx, [eax+eax*4]
    movzx eax, byte[_i+edx]
    lea eax, [eax+ebx*2-480]
    jmp .1
    .2: sub eax, 0x30
    inc edx
    mov [_i0], edx
    ret

_si: ; put _i in eax ; destroys eax,ebx,edx
    mov edx, [_i0]
    cmp byte[_i+edx], '-'
    jne .3
    inc edx
    .3: movzx eax, byte[_i+edx]
    .1: inc edx
    cmp byte[_i+edx], '0'
    jl .2
    lea ebx, [eax+eax*4]
    movzx eax, byte[_i+edx]
    lea eax, [eax+ebx*2-480]
    jmp .1
    .2: sub eax, 0x30
    mov ebx, [_i0]
    cmp byte[_i+ebx], '-'
    jne .4
    neg eax
    .4: inc edx
    mov [_i0], edx
    ret

_pu: ; put eax in _o0 + destroys eax,ebx,edi,edx
    xor edi, edi
    mov ebx, 0xa
    .1: xor edx, edx
    div ebx
    add dl, 0x30
    mov [_o+O_SIZE+edi], dl
    inc edi
    cmp eax, 0x0
    jnz .1
    mov ebx, [_o0]
    .2: mov al, [_o+O_SIZE+edi-1]
    mov [_o+ebx], al
    inc ebx
    dec edi
    jnz .2
    mov byte[_o+ebx], 0xa
    inc ebx
    mov [_o0], ebx
    ret

_pi: ; put eax in _o0 + destroys eax,ebx,edi,edx
    xor edi, edi
    mov ebx, 0xa
    cmp eax, 0
    jge .1
    mov edx, [_o0]
    mov byte[_o+edx], 0x2d
    inc edx
    mov [_o0], edx
    neg eax
    .1: xor edx, edx
    div ebx
    add dl, 0x30
    mov [_o+O_SIZE+edi], dl
    inc edi
    cmp eax, 0x0
    jnz .1
    mov ebx, [_o0]
    .2: mov al, [_o+O_SIZE+edi-1]
    mov [_o+ebx], al
    inc ebx
    dec edi
    jnz .2
    mov byte[_o+ebx], 0x20
    inc ebx
    ret

_start:
    mov edx, I_SIZE
    mov ecx, _i
    xor ebx, ebx
    mov eax, 0x3
    int 0x80

    ; Code Goes here
    ; call _su, _si for input
    ; call _pu, _pi for output
    
    mov edx, [_o0]
    mov ecx, _o
    xor ebx, ebx
    inc ebx
    mov eax, 0x4
    int 0x80

    xor ebx, ebx
    xor eax, eax
    inc eax
    int 0x80
