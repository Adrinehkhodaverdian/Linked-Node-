;Adrineh Khodaverdian
;Professor Tony Biehl
;CS/IS 165
;November 11, lab 4

br main
;struct node
next: .equate 0 ; struct field #2h
data: .equate 2 ; stuct field #2d

;------Void insert(node* & ptr, int val)---
ptr: .equate 6 ;formal parameter #2h
val: .equate 4 ;formal parameter #2d
temp: .equate 0 ;local variable #2h

insert: subsp 2,i ;push #temp
        ldwa 4,i ; temp = struct node*
        call malloc ;allocate #next #data
        stwx temp,s
        ldwa val,s    ;temp->data = val;
        ldwx data,i
        stwa temp,sfx
        ldwa ptr, sf 
        ldwx next,i   ;temp->next = ptr;
        stwa temp,sfx 
        ldwa temp,s
        stwa ptr,sf    ;  ptr = temp;
       addsp 2,i ;pop #temp
       ret


;---main()------
root: .equate 4 ; local variable #2h
p: .equate 2    ; local variable #2h
value: .equate 0; local variable #2d

main: subsp 6,i ; push #root #p #value
      ldwa 0,i
      stwa root,s ;root = NULL
      stro input,d
      deci value,s
while: ldwa value,s 
       cpwa 0,i
       brle endW
       ldwa value,s
       stwa -4,s 
       movspa
       adda root,i  ;insert(root,value)
       stwa -2,s        
       subsp 4,i ; #ptr #val 
       call insert
       addsp 4,i ;#val #ptr
       stro input,d
       deci value,s
       br while

endW:ldwa root,s  ;set p = root
     stwa p,s
 
for: ldwa p,s 
     cpwa 0,i
     breq endfor
     ldwx data,i
     deco p,sfx ;print out data
     ldba ' ',i
     stba charOut,d
     ldwx next,i  ;temp->next= ptr
     ldwa p,sfx
     stwa p,s
     br for

endfor: stro nl,d
      addsp 6,i ; pop #value #p #root
      stop

nl: .ascii "\x0A\x00"
input: .ascii "Input num: \x00"

;-----the Malloc()------
malloc: ldwx hpPtr,d ;returned ptr
        adda hpPtr,d ;allocate from heap
        stwa hpPtr,d ;update hpPtr
        ret
hpPtr: .addrss heap ;address of the next free byte
heap: .block 1;first two bytes in the heap 
.end
         