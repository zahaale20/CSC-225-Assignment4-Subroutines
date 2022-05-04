; Implements stack operations.
; CSC 225, Assignment 4
; Given code, Spring '22

            .ORIG x4000

; NOTE: Do not alter the following lines. They are hardcoded in other files,
;       since the assembler cannot resolve cross-file labels.

            .FILL PUSH
            .FILL POP
            .FILL PEEK

; Pushes one element onto the stack.
;  Takes the stack pointer in R1, element to push in R2.
;  Returns the stack pointer in R1.
; TODO: Implement this subroutine.
PUSH    ADD R1, R1, #-1
        STR R2, R1, #0
        RET

; Pops one element off of the stack.
;  Takes the stack pointer in R1.
;  Returns the stack pointer in R1, popped element in R2.
; TODO: Implement this subroutine.
POP     LDR R2, R1, #0
        AND R3, R3, #0
        STR R3, R1, #0
	    ADD R1, R1, #1
        RET

; Peeks at one element on the stack.
;  Takes the stack pointer in R1.
;  Returns the stack pointer in R1, peeked element in R2.
; TODO: Implement this subroutine.
PEEK    LDR R2, R1, #0
        RET

            .END
