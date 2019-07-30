       ORG 50H ;ROM ADRESS
       ARRAY1: DB 10, 5, 120, 255, 240, 70, 40, 255; array a
       ORG 60H
       ARRAY2:  DB  5, 20, 2, 50, 100, 240, 250, 200; array x
       ORG 0
       MOV R0, #8H;set the filter degree, N, here.(your code goes here)
       MOV R3, #00H ; initialize R3
       MOV R4, #00H ; initialize R4 
       MOV R5, #00H ; initialize R5
       MOV R6, #00H ; initialize R6
    
       CLR A        ;clear Acc

LOOP:  MOV DPTR, #ARRAY2    ; move the pointer to array2
       MOV A,R6             ; A <- R6 (R6 increase as redo loop)
       MOVC A,@A + DPTR     ; A <- array2 related number value
       MOV B,A              ; B <- A
       MOV DPTR, #ARRAY1    ; move the pointer to array2
       MOV A,R6             ; A <- R6 (R6 increase as redo loop)
       MOVC A,@A + DPTR     ; A <- array1 related number value
       MUL AB               ; do A*B = BA   lower byte into A,higher byte into B
       ADD A,R3             ; do A=A+R3
       JNC NEXT1            ; if C=0, goto NEXT1 
       INC R4               ; otherwise R4++ (the byte higher than R3)
       MOV R3,A             ; R3 <- A
       MOV A,R4             ; A <- R4
       ADD A,B              ; A=A+B
       JNC NEXT3            ; if C=0, goto NEXT3
       INC R5               ; otherwise R5++ (the byte that higher than R4)
       MOV R4,A             ; R4 <- A
       INC R6               ; R6++ and ready to redo loop
       DJNZ R0,LOOP         ; --R0 not = 0 redo loop

NEXT1: MOV R3,A             ; R3 <- A
       MOV A,R4             ; A <- R4
       ADD A,B              ; do A= A+B
       JNC NEXT3            ; if C=0, goto R3
       INC R5               ; otherwise R5++
       MOV R4,A             ; R4 <- A
       INC R6               ; R6++ and reday to redo loop
       DJNZ R0,LOOP         ; --RO not = 0 redo loop


NEXT3: MOV R4,A             ; R4 <- A
       INC R6               ;  R6++ and ready to redo loop
       DJNZ R0,LOOP         ; --R0 not = 0 redo loop

END 

