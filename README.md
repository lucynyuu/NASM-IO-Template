# NASM-IO-Template
32bit NASM Input-Output template that I use for competitive programming.

# Compile
nasm -f elef32 *filename*.asm -o *filename*.o

# Link (Without libc)
ld -m elf_i386 *filename*.o -o *filename*
