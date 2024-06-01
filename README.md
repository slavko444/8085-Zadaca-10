# 8085-Zadaca-10

По исчитување на податок со вредност 09h од изолирана
порта со адреса 0Bh почнувајќи од адреса POCET, сериски со
брзина од 1200bps се пренесуваат 255 податока. По
пренесувањето на податоци, на излезна изолирана порта на
адреса 0Ah се пренесува податок 0Ch. Да се напише
асемблерска програма базирана µP 8085. Фреквенцијата на
осцилаторот е 4MHz. 

**Resenie:**

Ќе го искористиме тоа дека µP знае битот 7 да го пренесе при SIM
инструкција на SOD пинот, само доколку битот 6 е 1.
Ts=0,5 µS
1/1200=833µS X*7=833 X=119

```
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

```


 ![Screenshot (1)](https://github.com/slavko444/8085-Zadaca-9/blob/main/code%209.png)
 ![Screenshot (1)](https://github.com/slavko444/8085-Zadaca-9/blob/main/code%209.1.png)
 
**Develop by:**

[Slavko Srebrenoski ](https://github.com/slavko444)


**Subject**

Microcomputer's systems

**Built With**

This project is built using the following tools:

- [8085 simulator](https://github.com/8085simulator/8085simulator.github.io?tab=readme-ov-file): Assembler and emulator for the Intel 8085 microprocessor.

**Getting Started**

To get a local copy up and running, follow these steps.

**Prerequisites**

In order to run this project you need:

A working computer
Connection to internet
Setup

**How to Run**

To run the program, you need an 8085 emulator or assembler. You can use emulators like DOSBox or TASM (Turbo Assembler). Here's how to run the program using e8085.exe:

1. Download and install e8085.exe from [here](https://github.com/8085simulator/8085simulator.github.io?tab=readme-ov-file).
2. Clone this repository to your local machine.
3. Open e8085.exe and load the `Zadaca 9 code.asm` file.
4. Assemble the code by pressing the Assemble button.
5. Run the program by pressing the Run button or by pressing F10.
