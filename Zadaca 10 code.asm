N DS 1 ;дефинираме бројач

 MVI B,0 ;го користиме како флег регистар дали сме во низа

 MVI C,1 ;за јамка

 MVI A,0

 STA N ;бројач на податоци

 MVI L,0 ;иницијален максимум

 MVI H,255d ;иницијален минимум

VRTI: MOV A,C ;креираме јамка

 ANI FFh

 JNZ VRTI

 PUSH H ;на врв на стек ги сместуваме max и min

 END

2Ch: CALL SERVIS ;Се појавил интерапт 5.5

 RET

SERVIS: LDA N ;рутина за RST 5.5

 INR A ;дошол карактер

 STA N

 CPI 128d ;да не е 128-миот

 JZ ZAPRI_MPS

 MOV A,B ;дали сме во низа или не

 CPI 1d

 JZ VO_NIZA_SME

 IN 0Ah ;ако не сме се чита карактерот

 CPI AAh ;и се проверува дали е почетниот

 JNZ KRAJ

 INR B ;ако е почетниот го сетираме флегот

 JMP KRAJ ;и излегуваме од процедурата

VO_NIZA_SME:IN 0Ah ;ако сме во низа

 CPI 55h ;провери да не е последниот карактер

 JZ GOTOVO

 CALL MAXMIN ;провери дали е min или max

 JMP KRAJ

GOTOVO: MVI C,O ;се сетира флег за крај

 JMP KRAJ

ZAPRI_MPS: HLT

 KRAJ: NOP

 RET

 MAXMIN: CMP H ;процедура за проверка дали е min или max

 JM NOV_MIN

 CMP L

 JP NOV_MAX

 JMP KRAJ1

 NOV_MAX: MOV L,A

 JMP KRAJ1

 NOV_MIN: MOV H,A

 KRAJ1: NOP

 RET 
