.data
newline: .asciz "\n"
.text

.globl main


main:
li s0, 0 # s0 is now x
li s1, 0 # s1 is now y

li s2, 0x10010000 # s2 bitmap display start
li s3, 0x10010400 # s3 bitmap display end

li s4, 2 # direction N 0  W 1  S 2  E 3

li s5, 0xFFFF0004

li t0, 0xFFFFFF 



draw_loop:
slli t1, s1, 6 # y offset
slli t2, s0, 2 # x offset    

add  t3, t1, t2 # t3 = total offset
add  t3, t3, s2 # t3 = memory address

sw   t0, 0(t3)
call move_loop
j draw_loop


move_loop:
add t4, x0, x0
beq t4, s4, move_north
addi t4, t4, 1
beq t4, s4, move_west
addi t4, t4, 1
beq t4, s4, move_south
addi t4, t4, 1
beq t4, s4, move_east
ret
 

move_north:
addi s1, s1, -1
ret

move_west:
addi s0, s0, 1
ret

move_south:
addi s1, s1, 1
ret

move_east:
addi s0, s0, -1
ret

end:
li a7, 10  # syscall for proper exit, bye bye
ecall

