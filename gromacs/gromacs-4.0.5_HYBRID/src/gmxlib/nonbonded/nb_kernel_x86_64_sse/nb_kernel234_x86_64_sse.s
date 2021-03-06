##
## $Id: nb_kernel234_x86_64_sse.s,v 1.8 2006/09/22 08:50:48 lindahl Exp $
##
## Gromacs 4.0                         Copyright (c) 1991-2003 
## David van der Spoel, Erik Lindahl
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 2
## of the License, or (at your option) any later version.
##
## To help us fund GROMACS development, we humbly ask that you cite
## the research papers on the package. Check out http://www.gromacs.org
## 
## And Hey:
## Gnomes, ROck Monsters And Chili Sauce
##





.globl nb_kernel234_x86_64_sse
.globl _nb_kernel234_x86_64_sse
nb_kernel234_x86_64_sse:        
_nb_kernel234_x86_64_sse:       
##      Room for return address and rbp (16 bytes)
.set nb234_fshift, 16
.set nb234_gid, 24
.set nb234_pos, 32
.set nb234_faction, 40
.set nb234_charge, 48
.set nb234_p_facel, 56
.set nb234_argkrf, 64
.set nb234_argcrf, 72
.set nb234_Vc, 80
.set nb234_type, 88
.set nb234_p_ntype, 96
.set nb234_vdwparam, 104
.set nb234_Vvdw, 112
.set nb234_p_tabscale, 120
.set nb234_VFtab, 128
.set nb234_invsqrta, 136
.set nb234_dvda, 144
.set nb234_p_gbtabscale, 152
.set nb234_GBtab, 160
.set nb234_p_nthreads, 168
.set nb234_count, 176
.set nb234_mtx, 184
.set nb234_outeriter, 192
.set nb234_inneriter, 200
.set nb234_work, 208
        ## stack offsets for local variables  
        ## bottom of stack is cache-aligned for sse use 
.set nb234_ixO, 0
.set nb234_iyO, 16
.set nb234_izO, 32
.set nb234_ixH1, 48
.set nb234_iyH1, 64
.set nb234_izH1, 80
.set nb234_ixH2, 96
.set nb234_iyH2, 112
.set nb234_izH2, 128
.set nb234_ixM, 144
.set nb234_iyM, 160
.set nb234_izM, 176
.set nb234_jxO, 192
.set nb234_jyO, 208
.set nb234_jzO, 224
.set nb234_jxH1, 240
.set nb234_jyH1, 256
.set nb234_jzH1, 272
.set nb234_jxH2, 288
.set nb234_jyH2, 304
.set nb234_jzH2, 320
.set nb234_jxM, 336
.set nb234_jyM, 352
.set nb234_jzM, 368
.set nb234_dxOO, 384
.set nb234_dyOO, 400
.set nb234_dzOO, 416
.set nb234_dxH1H1, 432
.set nb234_dyH1H1, 448
.set nb234_dzH1H1, 464
.set nb234_dxH1H2, 480
.set nb234_dyH1H2, 496
.set nb234_dzH1H2, 512
.set nb234_dxH1M, 528
.set nb234_dyH1M, 544
.set nb234_dzH1M, 560
.set nb234_dxH2H1, 576
.set nb234_dyH2H1, 592
.set nb234_dzH2H1, 608
.set nb234_dxH2H2, 624
.set nb234_dyH2H2, 640
.set nb234_dzH2H2, 656
.set nb234_dxH2M, 672
.set nb234_dyH2M, 688
.set nb234_dzH2M, 704
.set nb234_dxMH1, 720
.set nb234_dyMH1, 736
.set nb234_dzMH1, 752
.set nb234_dxMH2, 768
.set nb234_dyMH2, 784
.set nb234_dzMH2, 800
.set nb234_dxMM, 816
.set nb234_dyMM, 832
.set nb234_dzMM, 848
.set nb234_qqMM, 864
.set nb234_qqMH, 880
.set nb234_qqHH, 896
.set nb234_two, 912
.set nb234_c6, 928
.set nb234_c12, 944
.set nb234_tsc, 960
.set nb234_fstmp, 976
.set nb234_vctot, 992
.set nb234_Vvdwtot, 1008
.set nb234_fixO, 1024
.set nb234_fiyO, 1040
.set nb234_fizO, 1056
.set nb234_fixH1, 1072
.set nb234_fiyH1, 1088
.set nb234_fizH1, 1104
.set nb234_fixH2, 1120
.set nb234_fiyH2, 1136
.set nb234_fizH2, 1152
.set nb234_fixM, 1168
.set nb234_fiyM, 1184
.set nb234_fizM, 1200
.set nb234_fjxO, 1216
.set nb234_fjyO, 1232
.set nb234_fjzO, 1248
.set nb234_fjxH1, 1264
.set nb234_fjyH1, 1280
.set nb234_fjzH1, 1296
.set nb234_fjxH2, 1312
.set nb234_fjyH2, 1328
.set nb234_fjzH2, 1344
.set nb234_fjxM, 1360
.set nb234_fjyM, 1376
.set nb234_fjzM, 1392
.set nb234_half, 1408
.set nb234_three, 1424
.set nb234_rsqOO, 1440
.set nb234_rsqH1H1, 1456
.set nb234_rsqH1H2, 1472
.set nb234_rsqH1M, 1488
.set nb234_rsqH2H1, 1504
.set nb234_rsqH2H2, 1520
.set nb234_rsqH2M, 1536
.set nb234_rsqMH1, 1552
.set nb234_rsqMH2, 1568
.set nb234_rsqMM, 1584
.set nb234_rinvOO, 1600
.set nb234_rinvH1H1, 1616
.set nb234_rinvH1H2, 1632
.set nb234_rinvH1M, 1648
.set nb234_rinvH2H1, 1664
.set nb234_rinvH2H2, 1680
.set nb234_rinvH2M, 1696
.set nb234_rinvMH1, 1712
.set nb234_rinvMH2, 1728
.set nb234_rinvMM, 1744
.set nb234_krf, 1776
.set nb234_crf, 1792
.set nb234_is3, 1808
.set nb234_ii3, 1812
.set nb234_innerjjnr, 1816
.set nb234_nri, 1824
.set nb234_iinr, 1832
.set nb234_jindex, 1840
.set nb234_jjnr, 1848
.set nb234_shift, 1856
.set nb234_shiftvec, 1864
.set nb234_facel, 1872
.set nb234_innerk, 1880
.set nb234_n, 1884
.set nb234_nn1, 1888
.set nb234_nouter, 1892
.set nb234_ninner, 1896

        push %rbp
        movq %rsp,%rbp
        push %rbx


        emms

        push %r12
        push %r13
        push %r14
        push %r15

        subq $1912,%rsp         ## local variable stack space (n*16+8)

        ## zero 32-bit iteration counters
        movl $0,%eax
        movl %eax,nb234_nouter(%rsp)
        movl %eax,nb234_ninner(%rsp)

        movl (%rdi),%edi
        movl %edi,nb234_nri(%rsp)
        movq %rsi,nb234_iinr(%rsp)
        movq %rdx,nb234_jindex(%rsp)
        movq %rcx,nb234_jjnr(%rsp)
        movq %r8,nb234_shift(%rsp)
        movq %r9,nb234_shiftvec(%rsp)
        movq nb234_p_facel(%rbp),%rsi
        movss (%rsi),%xmm0
        movss %xmm0,nb234_facel(%rsp)

        movq nb234_p_tabscale(%rbp),%rax
        movss (%rax),%xmm3
        shufps $0,%xmm3,%xmm3
        movaps %xmm3,nb234_tsc(%rsp)

        movq nb234_argkrf(%rbp),%rsi
        movq nb234_argcrf(%rbp),%rdi
        movss (%rsi),%xmm1
        movss (%rdi),%xmm2
        shufps $0,%xmm1,%xmm1
        shufps $0,%xmm2,%xmm2
        movaps %xmm1,nb234_krf(%rsp)
        movaps %xmm2,nb234_crf(%rsp)

        ## create constant floating-point factors on stack
        movl $0x3f000000,%eax   ## half in IEEE (hex)
        movl %eax,nb234_half(%rsp)
        movss nb234_half(%rsp),%xmm1
        shufps $0,%xmm1,%xmm1  ## splat to all elements
        movaps %xmm1,%xmm2
        addps  %xmm2,%xmm2      ## one
        movaps %xmm2,%xmm3
        addps  %xmm2,%xmm2      ## two
        addps  %xmm2,%xmm3      ## three
        movaps %xmm1,nb234_half(%rsp)
        movaps %xmm2,nb234_two(%rsp)
        movaps %xmm3,nb234_three(%rsp)

        ## assume we have at least one i particle - start directly 
        movq  nb234_iinr(%rsp),%rcx     ## rcx = pointer into iinr[]
        movl  (%rcx),%ebx               ## ebx =ii 

        movq  nb234_charge(%rbp),%rdx
        movss 4(%rdx,%rbx,4),%xmm5
        movss 12(%rdx,%rbx,4),%xmm3
        movss %xmm3,%xmm4
        movq nb234_p_facel(%rbp),%rsi
        movss (%rsi),%xmm0
        movss nb234_facel(%rsp),%xmm6
        mulss  %xmm3,%xmm3
        mulss  %xmm5,%xmm4
        mulss  %xmm5,%xmm5
        mulss  %xmm6,%xmm3
        mulss  %xmm6,%xmm4
        mulss  %xmm6,%xmm5
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        movaps %xmm3,nb234_qqMM(%rsp)
        movaps %xmm4,nb234_qqMH(%rsp)
        movaps %xmm5,nb234_qqHH(%rsp)

        xorps %xmm0,%xmm0
        movq  nb234_type(%rbp),%rdx
        movl  (%rdx,%rbx,4),%ecx
        shll  %ecx
        movl  %ecx,%edx
        movq nb234_p_ntype(%rbp),%rdi
        imull (%rdi),%ecx ## rcx = ntia = 2*ntype*type[ii0] 
        addq  %rcx,%rdx
        movq  nb234_vdwparam(%rbp),%rax
        movlps (%rax,%rdx,4),%xmm0
        movaps %xmm0,%xmm1
        shufps $0,%xmm0,%xmm0
        shufps $0x55,%xmm1,%xmm1
        movaps %xmm0,nb234_c6(%rsp)
        movaps %xmm1,nb234_c12(%rsp)

_nb_kernel234_x86_64_sse.nb234_threadloop: 
        movq  nb234_count(%rbp),%rsi            ## pointer to sync counter
        movl  (%rsi),%eax
_nb_kernel234_x86_64_sse.nb234_spinlock: 
        movl  %eax,%ebx                         ## ebx=*count=nn0
        addl  $1,%ebx                          ## ebx=nn1=nn0+10
        lock 
        cmpxchgl %ebx,(%rsi)                    ## write nn1 to *counter,
                                                ## if it hasnt changed.
                                                ## or reread *counter to eax.
        pause                                   ## -> better p4 performance
        jnz _nb_kernel234_x86_64_sse.nb234_spinlock

        ## if(nn1>nri) nn1=nri
        movl nb234_nri(%rsp),%ecx
        movl %ecx,%edx
        subl %ebx,%ecx
        cmovlel %edx,%ebx                       ## if(nn1>nri) nn1=nri
        ## Cleared the spinlock if we got here.
        ## eax contains nn0, ebx contains nn1.
        movl %eax,nb234_n(%rsp)
        movl %ebx,nb234_nn1(%rsp)
        subl %eax,%ebx                          ## calc number of outer lists
        movl %eax,%esi                          ## copy n to esi
        jg  _nb_kernel234_x86_64_sse.nb234_outerstart
        jmp _nb_kernel234_x86_64_sse.nb234_end

_nb_kernel234_x86_64_sse.nb234_outerstart: 
        ## ebx contains number of outer iterations
        addl nb234_nouter(%rsp),%ebx
        movl %ebx,nb234_nouter(%rsp)

_nb_kernel234_x86_64_sse.nb234_outer: 
        movq  nb234_shift(%rsp),%rax            ## eax = pointer into shift[] 
        movl  (%rax,%rsi,4),%ebx                ## ebx=shift[n] 

        lea  (%rbx,%rbx,2),%rbx        ## rbx=3*is 
        movl  %ebx,nb234_is3(%rsp)      ## store is3 

        movq  nb234_shiftvec(%rsp),%rax     ## eax = base of shiftvec[] 

        movss (%rax,%rbx,4),%xmm0
        movss 4(%rax,%rbx,4),%xmm1
        movss 8(%rax,%rbx,4),%xmm2

        movq  nb234_iinr(%rsp),%rcx             ## ecx = pointer into iinr[]    
        movl  (%rcx,%rsi,4),%ebx                ## ebx =ii 

        lea  (%rbx,%rbx,2),%rbx        ## rbx = 3*ii=ii3 
        movq  nb234_pos(%rbp),%rax      ## eax = base of pos[]  
        movl  %ebx,nb234_ii3(%rsp)

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5
        movaps %xmm0,%xmm6
        movaps %xmm1,%xmm7

        addss (%rax,%rbx,4),%xmm3       ## ox
        addss 4(%rax,%rbx,4),%xmm4     ## oy
        addss 8(%rax,%rbx,4),%xmm5     ## oz
        addss 12(%rax,%rbx,4),%xmm6    ## h1x
        addss 16(%rax,%rbx,4),%xmm7    ## h1y
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        shufps $0,%xmm6,%xmm6
        shufps $0,%xmm7,%xmm7
        movaps %xmm3,nb234_ixO(%rsp)
        movaps %xmm4,nb234_iyO(%rsp)
        movaps %xmm5,nb234_izO(%rsp)
        movaps %xmm6,nb234_ixH1(%rsp)
        movaps %xmm7,nb234_iyH1(%rsp)

        movss %xmm2,%xmm6
        movss %xmm0,%xmm3
        movss %xmm1,%xmm4
        movss %xmm2,%xmm5
        addss 20(%rax,%rbx,4),%xmm6    ## h1z
        addss 24(%rax,%rbx,4),%xmm0    ## h2x
        addss 28(%rax,%rbx,4),%xmm1    ## h2y
        addss 32(%rax,%rbx,4),%xmm2    ## h2z
        addss 36(%rax,%rbx,4),%xmm3    ## mx
        addss 40(%rax,%rbx,4),%xmm4    ## my
        addss 44(%rax,%rbx,4),%xmm5    ## mz

        shufps $0,%xmm6,%xmm6
        shufps $0,%xmm0,%xmm0
        shufps $0,%xmm1,%xmm1
        shufps $0,%xmm2,%xmm2
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        movaps %xmm6,nb234_izH1(%rsp)
        movaps %xmm0,nb234_ixH2(%rsp)
        movaps %xmm1,nb234_iyH2(%rsp)
        movaps %xmm2,nb234_izH2(%rsp)
        movaps %xmm3,nb234_ixM(%rsp)
        movaps %xmm4,nb234_iyM(%rsp)
        movaps %xmm5,nb234_izM(%rsp)

        ## clear vctot and i forces 
        xorps %xmm4,%xmm4
        movaps %xmm4,nb234_vctot(%rsp)
        movaps %xmm4,nb234_Vvdwtot(%rsp)
        movaps %xmm4,nb234_fixO(%rsp)
        movaps %xmm4,nb234_fiyO(%rsp)
        movaps %xmm4,nb234_fizO(%rsp)
        movaps %xmm4,nb234_fixH1(%rsp)
        movaps %xmm4,nb234_fiyH1(%rsp)
        movaps %xmm4,nb234_fizH1(%rsp)
        movaps %xmm4,nb234_fixH2(%rsp)
        movaps %xmm4,nb234_fiyH2(%rsp)
        movaps %xmm4,nb234_fizH2(%rsp)
        movaps %xmm4,nb234_fixM(%rsp)
        movaps %xmm4,nb234_fiyM(%rsp)
        movaps %xmm4,nb234_fizM(%rsp)

        movq  nb234_jindex(%rsp),%rax
        movl  (%rax,%rsi,4),%ecx                ## jindex[n] 
        movl  4(%rax,%rsi,4),%edx               ## jindex[n+1] 
        subl  %ecx,%edx                 ## number of innerloop atoms 

        movq  nb234_pos(%rbp),%rsi
        movq  nb234_faction(%rbp),%rdi
        movq  nb234_jjnr(%rsp),%rax
        shll  $2,%ecx
        addq  %rcx,%rax
        movq  %rax,nb234_innerjjnr(%rsp)        ## pointer to jjnr[nj0] 
        movl  %edx,%ecx
        subl  $4,%edx
        addl  nb234_ninner(%rsp),%ecx
        movl  %ecx,nb234_ninner(%rsp)
        addl  $0,%edx
        movl  %edx,nb234_innerk(%rsp)   ## number of innerloop atoms 
        jge   _nb_kernel234_x86_64_sse.nb234_unroll_loop
        jmp   _nb_kernel234_x86_64_sse.nb234_single_check
_nb_kernel234_x86_64_sse.nb234_unroll_loop: 
        ## quad-unroll innerloop here 
        movq  nb234_innerjjnr(%rsp),%rdx        ## pointer to jjnr[k] 

        movl  (%rdx),%eax
        movl  4(%rdx),%ebx
        movl  8(%rdx),%ecx
        movl  12(%rdx),%edx             ## eax-edx=jnr1-4 

        addq $16,nb234_innerjjnr(%rsp)             ## advance pointer (unroll 4) 

        movq nb234_pos(%rbp),%rsi       ## base of pos[] 

        lea  (%rax,%rax,2),%rax        ## replace jnr with j3 
        lea  (%rbx,%rbx,2),%rbx
        lea  (%rcx,%rcx,2),%rcx        ## replace jnr with j3 
        lea  (%rdx,%rdx,2),%rdx

        ## load j O coordinates 
    movlps (%rsi,%rax,4),%xmm0 ## jxOa jyOa  -   -
    movlps (%rsi,%rcx,4),%xmm1 ## jxOc jyOc  -   -
    movhps (%rsi,%rbx,4),%xmm0 ## jxOa jyOa jxOb jyOb 
    movhps (%rsi,%rdx,4),%xmm1 ## jxOc jyOc jxOd jyOd 

    movss  8(%rsi,%rax,4),%xmm2    ## jzOa  -  -  -
    movss  8(%rsi,%rcx,4),%xmm3    ## jzOc  -  -  -
    movhps 8(%rsi,%rbx,4),%xmm2    ## jzOa  -  jzOb  -
    movhps 8(%rsi,%rdx,4),%xmm3    ## jzOc  -  jzOd -

    movaps %xmm0,%xmm4
    unpcklps %xmm1,%xmm0 ## jxOa jxOc jyOa jyOc        
    unpckhps %xmm1,%xmm4 ## jxOb jxOd jyOb jyOd
    movaps %xmm0,%xmm1
    unpcklps %xmm4,%xmm0 ## x
    unpckhps %xmm4,%xmm1 ## y

    shufps $136,%xmm3,%xmm2 ## 10001000 => jzOa jzOb jzOc jzOd

    ## xmm0 = Ox
    ## xmm1 = Oy
    ## xmm2 = Oz

    subps nb234_ixO(%rsp),%xmm0
    subps nb234_iyO(%rsp),%xmm1
    subps nb234_izO(%rsp),%xmm2

    ## store dx/dy/dz
    movaps %xmm0,%xmm13
    movaps %xmm1,%xmm14
    movaps %xmm2,%xmm15

    ## square it
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2

        addps  %xmm0,%xmm1
        addps  %xmm2,%xmm1
    ## rsq in xmm1

    ## calculate rinv=1/sqrt(rsq)
        rsqrtps %xmm1,%xmm5
        movaps %xmm5,%xmm2
        mulps %xmm5,%xmm5
        movaps nb234_three(%rsp),%xmm4
        mulps %xmm1,%xmm5       ## rsq*lu*lu    
    subps %xmm5,%xmm4   ## 30-rsq*lu*lu 
        mulps %xmm2,%xmm4
        mulps nb234_half(%rsp),%xmm4
        movaps %xmm4,%xmm2
        mulps  %xmm4,%xmm1
    ## xmm2=rinv
    ## xmm1=r

    mulps nb234_tsc(%rsp),%xmm1   ## rtab

    ## truncate and convert to integers
    cvttps2dq %xmm1,%xmm5

    ## convert back to float
    cvtdq2ps  %xmm5,%xmm4

    ## multiply by 8
    pslld   $3,%xmm5

    ## calculate eps
    subps     %xmm4,%xmm1

    ## move to integer registers
    movhlps %xmm5,%xmm6
    movd    %xmm5,%r8d
    movd    %xmm6,%r10d
    pshufd $1,%xmm5,%xmm5
    pshufd $1,%xmm6,%xmm6
    movd    %xmm5,%r9d
    movd    %xmm6,%r11d
    ## table indices in r8-r11

    ## xmm1=eps
    ## xmm2=rinv

        movq nb234_VFtab(%rbp),%rsi
    ## load LJ dispersion and repulsion in parallel
    movlps (%rsi,%r8,4),%xmm5
        movlps 16(%rsi,%r8,4),%xmm9
        movlps (%rsi,%r10,4),%xmm7
        movlps 16(%rsi,%r10,4),%xmm11
        movhps (%rsi,%r9,4),%xmm5
        movhps 16(%rsi,%r9,4),%xmm9
        movhps (%rsi,%r11,4),%xmm7
        movhps 16(%rsi,%r11,4),%xmm11

    movaps %xmm5,%xmm4
    movaps %xmm9,%xmm8
        shufps $136,%xmm7,%xmm4 ## 10001000
        shufps $136,%xmm11,%xmm8 ## 10001000
        shufps $221,%xmm7,%xmm5 ## 11011101
        shufps $221,%xmm11,%xmm9 ## 11011101

        movlps 8(%rsi,%r8,4),%xmm7
        movlps 24(%rsi,%r8,4),%xmm11
        movlps 8(%rsi,%r10,4),%xmm0
        movlps 24(%rsi,%r10,4),%xmm3
        movhps 8(%rsi,%r9,4),%xmm7
        movhps 24(%rsi,%r9,4),%xmm11
        movhps 8(%rsi,%r11,4),%xmm0
        movhps 24(%rsi,%r11,4),%xmm3

    movaps %xmm7,%xmm6
    movaps %xmm11,%xmm10

        shufps $136,%xmm0,%xmm6 ## 10001000
        shufps $136,%xmm3,%xmm10 ## 10001000
        shufps $221,%xmm0,%xmm7 ## 11011101
        shufps $221,%xmm3,%xmm11 ## 11011101
    ## dispersion table in xmm4-xmm7, repulsion table in xmm8-xmm11

    mulps  %xmm1,%xmm7   ## Heps
    mulps  %xmm1,%xmm11
    mulps  %xmm1,%xmm6  ## Geps
    mulps  %xmm1,%xmm10
    mulps  %xmm1,%xmm7  ## Heps2
    mulps  %xmm1,%xmm11
    addps  %xmm6,%xmm5 ## F+Geps
    addps  %xmm10,%xmm9
    addps  %xmm7,%xmm5  ## F+Geps+Heps2 = Fp
    addps  %xmm11,%xmm9
    addps  %xmm7,%xmm7   ## 2*Heps2
    addps  %xmm11,%xmm11
    addps  %xmm6,%xmm7  ## 2*Heps2+Geps
    addps  %xmm10,%xmm11

    addps  %xmm5,%xmm7 ## FF = Fp + 2*Heps2 + Geps
    addps  %xmm9,%xmm11
    mulps  %xmm1,%xmm5 ## eps*Fp
    mulps  %xmm1,%xmm9
    addps  %xmm4,%xmm5 ## VV
    addps  %xmm8,%xmm9

    mulps  nb234_c6(%rsp),%xmm5    ## VV*c6 = vnb6
    mulps  nb234_c12(%rsp),%xmm9    ## VV*c12 = vnb12
    addps  %xmm9,%xmm5
    addps  nb234_Vvdwtot(%rsp),%xmm5
    movaps %xmm5,nb234_Vvdwtot(%rsp)

    mulps  nb234_c6(%rsp),%xmm7     ## FF*c6 = fnb6
    mulps  nb234_c12(%rsp),%xmm11     ## FF*c12  = fnb12
    addps  %xmm11,%xmm7

    mulps  nb234_tsc(%rsp),%xmm7
    mulps  %xmm2,%xmm7
    xorps  %xmm9,%xmm9

    subps  %xmm7,%xmm9

    ## fx/fy/fz
    mulps  %xmm9,%xmm13
    mulps  %xmm9,%xmm14
    mulps  %xmm9,%xmm15

    ## increment i force
    movaps nb234_fixO(%rsp),%xmm0
    movaps nb234_fiyO(%rsp),%xmm1
    movaps nb234_fizO(%rsp),%xmm2
    addps  %xmm13,%xmm0
    addps  %xmm14,%xmm1
    addps  %xmm15,%xmm2
    movaps %xmm0,nb234_fixO(%rsp)
    movaps %xmm1,nb234_fiyO(%rsp)
    movaps %xmm2,nb234_fizO(%rsp)

        ## move j O forces to local temp variables 
        movq nb234_faction(%rbp),%rdi
    movlps (%rdi,%rax,4),%xmm4 ## jxOa jyOa  -   -
    movlps (%rdi,%rcx,4),%xmm5 ## jxOc jyOc  -   -
    movhps (%rdi,%rbx,4),%xmm4 ## jxOa jyOa jxOb jyOb 
    movhps (%rdi,%rdx,4),%xmm5 ## jxOc jyOc jxOd jyOd 

    movss  8(%rdi,%rax,4),%xmm6    ## jzOa  -  -  -
    movss  8(%rdi,%rcx,4),%xmm7    ## jzOc  -  -  -
    movhps 8(%rdi,%rbx,4),%xmm6    ## jzOa  -  jzOb  -
    movhps 8(%rdi,%rdx,4),%xmm7    ## jzOc  -  jzOd -

    shufps $136,%xmm7,%xmm6 ## 10001000 => jzOa jzOb jzOc jzOd

    ## xmm4: jxOa jyOa jxOb jyOb 
    ## xmm5: jxOc jyOc jxOd jyOd
    ## xmm6: jzOa jzOb jzOc jzOd

    ## update O forces
    movaps %xmm13,%xmm12
    unpcklps %xmm14,%xmm13  ## (local) fjx1 fjx1 fjy1 fjy2
    unpckhps %xmm14,%xmm12  ## (local) fjx3 fjx4 fjy3 fjy4

    addps %xmm13,%xmm4
    addps %xmm12,%xmm5
    addps %xmm15,%xmm6

    movhlps  %xmm6,%xmm7 ## fH1zc fH1zd

    movlps %xmm4,(%rdi,%rax,4)
    movhps %xmm4,(%rdi,%rbx,4)
    movlps %xmm5,(%rdi,%rcx,4)
    movhps %xmm5,(%rdi,%rdx,4)
    movss  %xmm6,8(%rdi,%rax,4)
    movss  %xmm7,8(%rdi,%rcx,4)
    shufps $1,%xmm6,%xmm6
    shufps $1,%xmm7,%xmm7
    movss  %xmm6,8(%rdi,%rbx,4)
    movss  %xmm7,8(%rdi,%rdx,4)
    ## done with OO interaction

    ## move j H1 coordinates to local temp variables 
        movq nb234_pos(%rbp),%rsi       ## base of pos[] 
    movlps 12(%rsi,%rax,4),%xmm0    ## jxH1a jyH1a  -   -
    movlps 12(%rsi,%rcx,4),%xmm1    ## jxH1c jyH1c  -   -
    movhps 12(%rsi,%rbx,4),%xmm0    ## jxH1a jyH1a jxH1b jyH1b 
    movhps 12(%rsi,%rdx,4),%xmm1    ## jxH1c jyH1c jxH1d jyH1d 

    movss  20(%rsi,%rax,4),%xmm2    ## jzH1a  -  -  -
    movss  20(%rsi,%rcx,4),%xmm3    ## jzH1c  -  -  -
    movhps 20(%rsi,%rbx,4),%xmm2    ## jzH1a  -  jzH1b  -
    movhps 20(%rsi,%rdx,4),%xmm3    ## jzH1c  -  jzH1d -

    movaps %xmm0,%xmm4
    unpcklps %xmm1,%xmm0 ## jxH1a jxH1c jyH1a jyH1c        
    unpckhps %xmm1,%xmm4 ## jxH1b jxH1d jyH1b jyH1d
    movaps %xmm0,%xmm1
    unpcklps %xmm4,%xmm0 ## x
    unpckhps %xmm4,%xmm1 ## y

    shufps $136,%xmm3,%xmm2 ## 10001000 => jzH1a jzH1b jzH1c jzH1d

    ## xmm0 = H1x
    ## xmm1 = H1y
    ## xmm2 = H1z

    movaps %xmm0,%xmm3
    movaps %xmm1,%xmm4
    movaps %xmm2,%xmm5
    movaps %xmm0,%xmm6
    movaps %xmm1,%xmm7
    movaps %xmm2,%xmm8

    subps nb234_ixH1(%rsp),%xmm0
    subps nb234_iyH1(%rsp),%xmm1
    subps nb234_izH1(%rsp),%xmm2
    subps nb234_ixH2(%rsp),%xmm3
    subps nb234_iyH2(%rsp),%xmm4
    subps nb234_izH2(%rsp),%xmm5
    subps nb234_ixM(%rsp),%xmm6
    subps nb234_iyM(%rsp),%xmm7
    subps nb234_izM(%rsp),%xmm8

        movaps %xmm0,nb234_dxH1H1(%rsp)
        movaps %xmm1,nb234_dyH1H1(%rsp)
        movaps %xmm2,nb234_dzH1H1(%rsp)
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        movaps %xmm3,nb234_dxH2H1(%rsp)
        movaps %xmm4,nb234_dyH2H1(%rsp)
        movaps %xmm5,nb234_dzH2H1(%rsp)
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        movaps %xmm6,nb234_dxMH1(%rsp)
        movaps %xmm7,nb234_dyMH1(%rsp)
        movaps %xmm8,nb234_dzMH1(%rsp)
        mulps  %xmm6,%xmm6
        mulps  %xmm7,%xmm7
        mulps  %xmm8,%xmm8
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
    addps  %xmm7,%xmm6
    addps  %xmm8,%xmm6

        ## start doing invsqrt for jH1 atoms
        rsqrtps %xmm0,%xmm1
        rsqrtps %xmm3,%xmm4
    rsqrtps %xmm6,%xmm7

        movaps  %xmm1,%xmm2
        movaps  %xmm4,%xmm5
    movaps  %xmm7,%xmm8

        mulps   %xmm1,%xmm1 ## lu*lu
        mulps   %xmm4,%xmm4 ## lu*lu
    mulps   %xmm7,%xmm7 ## lu*lu

        movaps  nb234_three(%rsp),%xmm9
        movaps  %xmm9,%xmm10
    movaps  %xmm9,%xmm11

        mulps   %xmm0,%xmm1 ## rsq*lu*lu
        mulps   %xmm3,%xmm4 ## rsq*lu*lu 
    mulps   %xmm6,%xmm7 ## rsq*lu*lu

        subps   %xmm1,%xmm9
        subps   %xmm4,%xmm10
    subps   %xmm7,%xmm11 ## 3-rsq*lu*lu

        mulps   %xmm2,%xmm9
        mulps   %xmm5,%xmm10
    mulps   %xmm8,%xmm11 ## lu*(3-rsq*lu*lu)

        movaps  nb234_half(%rsp),%xmm4
        mulps   %xmm4,%xmm9 ## rinvH1H1 
        mulps   %xmm4,%xmm10 ## rinvH2H1
    mulps   %xmm4,%xmm11 ## rinvMH1

        ## H1 interactions 
    ## rsq in xmm0,xmm3,xmm6  
    ## rinv in xmm9, xmm10, xmm11

    movaps %xmm9,%xmm1 ## copy of rinv
    movaps %xmm10,%xmm4
    movaps %xmm11,%xmm7
    movaps nb234_krf(%rsp),%xmm2
    mulps  %xmm9,%xmm9  ## rinvsq
    mulps  %xmm10,%xmm10
    mulps  %xmm11,%xmm11
    mulps  %xmm2,%xmm0 ## k*rsq
    mulps  %xmm2,%xmm3
    mulps  %xmm2,%xmm6
    movaps %xmm0,%xmm2 ## copy of k*rsq
    movaps %xmm3,%xmm5
    movaps %xmm6,%xmm8
    addps  %xmm1,%xmm2 ## rinv+krsq
    addps  %xmm4,%xmm5
    addps  %xmm7,%xmm8
    movaps nb234_crf(%rsp),%xmm14
    subps  %xmm14,%xmm2  ## rinv+krsq-crf
    subps  %xmm14,%xmm5
    subps  %xmm14,%xmm8
    movaps nb234_qqHH(%rsp),%xmm12
    movaps nb234_qqMH(%rsp),%xmm13
    mulps  %xmm12,%xmm2 ## voul=qq*(rinv+ krsq-crf)
    mulps  %xmm12,%xmm5 ## voul=qq*(rinv+ krsq-crf)
    mulps  %xmm13,%xmm8 ## voul=qq*(rinv+ krsq-crf)
    addps  %xmm0,%xmm0 ## 2*krsq
    addps  %xmm3,%xmm3
    addps  %xmm6,%xmm6
    subps  %xmm0,%xmm1 ## rinv-2*krsq
    subps  %xmm3,%xmm4
    subps  %xmm6,%xmm7
    mulps  %xmm12,%xmm1  ## (rinv-2*krsq)*qq
    mulps  %xmm12,%xmm4
    mulps  %xmm13,%xmm7
    addps  nb234_vctot(%rsp),%xmm2
    addps  %xmm8,%xmm5
    addps  %xmm5,%xmm2
    movaps %xmm2,%xmm15

    mulps  %xmm9,%xmm1  ## fscal
    mulps  %xmm10,%xmm4
    mulps  %xmm11,%xmm7

        ## move j H1 forces to local temp variables 
        movq nb234_faction(%rbp),%rdi
    movlps 12(%rdi,%rax,4),%xmm9    ## jxH1a jyH1a  -   -
    movlps 12(%rdi,%rcx,4),%xmm10    ## jxH1c jyH1c  -   -
    movhps 12(%rdi,%rbx,4),%xmm9    ## jxH1a jyH1a jxH1b jyH1b 
    movhps 12(%rdi,%rdx,4),%xmm10    ## jxH1c jyH1c jxH1d jyH1d 

    movss  20(%rdi,%rax,4),%xmm11    ## jzH1a  -  -  -
    movss  20(%rdi,%rcx,4),%xmm12    ## jzH1c  -  -  -
    movhps 20(%rdi,%rbx,4),%xmm11    ## jzH1a  -  jzH1b  -
    movhps 20(%rdi,%rdx,4),%xmm12    ## jzH1c  -  jzH1d -

    shufps $136,%xmm12,%xmm11 ## 10001000 => jzH1a jzH1b jzH1c jzH1d

    ## xmm9: jxH1a jyH1a jxH1b jyH1b 
    ## xmm10: jxH1c jyH1c jxH1d jyH1d
    ## xmm11: jzH1a jzH1b jzH1c jzH1d

    movaps %xmm1,%xmm0
    movaps %xmm1,%xmm2
    movaps %xmm4,%xmm3
    movaps %xmm4,%xmm5
    movaps %xmm7,%xmm6
    movaps %xmm7,%xmm8

        mulps nb234_dxH1H1(%rsp),%xmm0
        mulps nb234_dyH1H1(%rsp),%xmm1
        mulps nb234_dzH1H1(%rsp),%xmm2
        mulps nb234_dxH2H1(%rsp),%xmm3
        mulps nb234_dyH2H1(%rsp),%xmm4
        mulps nb234_dzH2H1(%rsp),%xmm5
        mulps nb234_dxMH1(%rsp),%xmm6
        mulps nb234_dyMH1(%rsp),%xmm7
        mulps nb234_dzMH1(%rsp),%xmm8

    movaps %xmm0,%xmm13
    movaps %xmm1,%xmm14
    addps %xmm2,%xmm11
    addps nb234_fixH1(%rsp),%xmm0
    addps nb234_fiyH1(%rsp),%xmm1
    addps nb234_fizH1(%rsp),%xmm2

    addps %xmm3,%xmm13
    addps %xmm4,%xmm14
    addps %xmm5,%xmm11
    addps nb234_fixH2(%rsp),%xmm3
    addps nb234_fiyH2(%rsp),%xmm4
    addps nb234_fizH2(%rsp),%xmm5

    addps %xmm6,%xmm13
    addps %xmm7,%xmm14
    addps %xmm8,%xmm11
    addps nb234_fixM(%rsp),%xmm6
    addps nb234_fiyM(%rsp),%xmm7
    addps nb234_fizM(%rsp),%xmm8

    movaps %xmm0,nb234_fixH1(%rsp)
    movaps %xmm1,nb234_fiyH1(%rsp)
    movaps %xmm2,nb234_fizH1(%rsp)
    movaps %xmm3,nb234_fixH2(%rsp)
    movaps %xmm4,nb234_fiyH2(%rsp)
    movaps %xmm5,nb234_fizH2(%rsp)
    movaps %xmm6,nb234_fixM(%rsp)
    movaps %xmm7,nb234_fiyM(%rsp)
    movaps %xmm8,nb234_fizM(%rsp)

    ## xmm9 = fH1x
    ## xmm10 = fH1y
    ## xmm11 = fH1z
    movaps %xmm13,%xmm0
    unpcklps %xmm14,%xmm13
    unpckhps %xmm14,%xmm0

    addps %xmm13,%xmm9
    addps %xmm0,%xmm10

    movhlps  %xmm11,%xmm12 ## fH1zc fH1zd

    movlps %xmm9,12(%rdi,%rax,4)
    movhps %xmm9,12(%rdi,%rbx,4)
    movlps %xmm10,12(%rdi,%rcx,4)
    movhps %xmm10,12(%rdi,%rdx,4)
    movss  %xmm11,20(%rdi,%rax,4)
    movss  %xmm12,20(%rdi,%rcx,4)
    shufps $1,%xmm11,%xmm11
    shufps $1,%xmm12,%xmm12
    movss  %xmm11,20(%rdi,%rbx,4)
    movss  %xmm12,20(%rdi,%rdx,4)

        ## move j H2 coordinates to local temp variables 
        movq nb234_pos(%rbp),%rsi       ## base of pos[] 
    movlps 24(%rsi,%rax,4),%xmm0    ## jxH2a jyH2a  -   -
    movlps 24(%rsi,%rcx,4),%xmm1    ## jxH2c jyH2c  -   -
    movhps 24(%rsi,%rbx,4),%xmm0    ## jxH2a jyH2a jxH2b jyH2b 
    movhps 24(%rsi,%rdx,4),%xmm1    ## jxH2c jyH2c jxH2d jyH2d 

    movss  32(%rsi,%rax,4),%xmm2    ## jzH2a  -  -  -
    movss  32(%rsi,%rcx,4),%xmm3    ## jzH2c  -  -  -
    movhps 32(%rsi,%rbx,4),%xmm2    ## jzH2a  -  jzH2b  -
    movhps 32(%rsi,%rdx,4),%xmm3    ## jzH2c  -  jzH2d -

    movaps %xmm0,%xmm4
    unpcklps %xmm1,%xmm0 ## jxH2a jxH2c jyH2a jyH2c        
    unpckhps %xmm1,%xmm4 ## jxH2b jxH2d jyH2b jyH2d
    movaps %xmm0,%xmm1
    unpcklps %xmm4,%xmm0 ## x
    unpckhps %xmm4,%xmm1 ## y

    shufps  $136,%xmm3,%xmm2  ## 10001000 => jzH2a jzH2b jzH2c jzH2d

    ## xmm0 = H2x
    ## xmm1 = H2y
    ## xmm2 = H2z

    movaps %xmm0,%xmm3
    movaps %xmm1,%xmm4
    movaps %xmm2,%xmm5
    movaps %xmm0,%xmm6
    movaps %xmm1,%xmm7
    movaps %xmm2,%xmm8


    subps nb234_ixH1(%rsp),%xmm0
    subps nb234_iyH1(%rsp),%xmm1
    subps nb234_izH1(%rsp),%xmm2
    subps nb234_ixH2(%rsp),%xmm3
    subps nb234_iyH2(%rsp),%xmm4
    subps nb234_izH2(%rsp),%xmm5
    subps nb234_ixM(%rsp),%xmm6
    subps nb234_iyM(%rsp),%xmm7
    subps nb234_izM(%rsp),%xmm8

        movaps %xmm0,nb234_dxH1H2(%rsp)
        movaps %xmm1,nb234_dyH1H2(%rsp)
        movaps %xmm2,nb234_dzH1H2(%rsp)
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        movaps %xmm3,nb234_dxH2H2(%rsp)
        movaps %xmm4,nb234_dyH2H2(%rsp)
        movaps %xmm5,nb234_dzH2H2(%rsp)
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        movaps %xmm6,nb234_dxMH2(%rsp)
        movaps %xmm7,nb234_dyMH2(%rsp)
        movaps %xmm8,nb234_dzMH2(%rsp)
        mulps  %xmm6,%xmm6
        mulps  %xmm7,%xmm7
        mulps  %xmm8,%xmm8
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
    addps  %xmm7,%xmm6
    addps  %xmm8,%xmm6

        ## start doing invsqrt for jH2 atoms
        rsqrtps %xmm0,%xmm1
        rsqrtps %xmm3,%xmm4
    rsqrtps %xmm6,%xmm7

        movaps  %xmm1,%xmm2
        movaps  %xmm4,%xmm5
    movaps  %xmm7,%xmm8

        mulps   %xmm1,%xmm1 ## lu*lu
        mulps   %xmm4,%xmm4 ## lu*lu
    mulps   %xmm7,%xmm7 ## lu*lu

        movaps  nb234_three(%rsp),%xmm9
        movaps  %xmm9,%xmm10
    movaps  %xmm9,%xmm11

        mulps   %xmm0,%xmm1 ## rsq*lu*lu
        mulps   %xmm3,%xmm4 ## rsq*lu*lu 
    mulps   %xmm6,%xmm7 ## rsq*lu*lu

        subps   %xmm1,%xmm9
        subps   %xmm4,%xmm10
    subps   %xmm7,%xmm11 ## 3-rsq*lu*lu

        mulps   %xmm2,%xmm9
        mulps   %xmm5,%xmm10
    mulps   %xmm8,%xmm11 ## lu*(3-rsq*lu*lu)

        movaps  nb234_half(%rsp),%xmm4
        mulps   %xmm4,%xmm9 ## rinvH1H2
        mulps   %xmm4,%xmm10 ## rinvH2H2
    mulps   %xmm4,%xmm11 ## rinvMH2

        ## H2 interactions 
    ## rsq in xmm0,xmm3,xmm6  
    ## rinv in xmm9, xmm10, xmm11

    movaps %xmm9,%xmm1 ## copy of rinv
    movaps %xmm10,%xmm4
    movaps %xmm11,%xmm7
    movaps nb234_krf(%rsp),%xmm2
    mulps  %xmm9,%xmm9  ## rinvsq
    mulps  %xmm10,%xmm10
    mulps  %xmm11,%xmm11
    mulps  %xmm2,%xmm0 ## k*rsq
    mulps  %xmm2,%xmm3
    mulps  %xmm2,%xmm6
    movaps %xmm0,%xmm2 ## copy of k*rsq
    movaps %xmm3,%xmm5
    movaps %xmm6,%xmm8
    addps  %xmm1,%xmm2 ## rinv+krsq
    addps  %xmm4,%xmm5
    addps  %xmm7,%xmm8
    movaps nb234_crf(%rsp),%xmm14
    subps  %xmm14,%xmm2  ## rinv+krsq-crf
    subps  %xmm14,%xmm5
    subps  %xmm14,%xmm8
    movaps nb234_qqHH(%rsp),%xmm12
    movaps nb234_qqMH(%rsp),%xmm13
    mulps  %xmm12,%xmm2 ## xmm6=voul=qq*(rinv+ krsq-crf)
    mulps  %xmm12,%xmm5 ## xmm6=voul=qq*(rinv+ krsq-crf)
    mulps  %xmm13,%xmm8 ## xmm6=voul=qq*(rinv+ krsq-crf)
    addps  %xmm0,%xmm0 ## 2*krsq
    addps  %xmm3,%xmm3
    addps  %xmm6,%xmm6
    subps  %xmm0,%xmm1 ## rinv-2*krsq
    subps  %xmm3,%xmm4
    subps  %xmm6,%xmm7
    mulps  %xmm12,%xmm1  ## (rinv-2*krsq)*qq
    mulps  %xmm12,%xmm4
    mulps  %xmm13,%xmm7
    addps  %xmm2,%xmm15
    addps  %xmm8,%xmm5
    addps  %xmm5,%xmm15

    mulps  %xmm9,%xmm1  ## fscal
    mulps  %xmm10,%xmm4
    mulps  %xmm11,%xmm7

        ## move j H2 forces to local temp variables 
        movq nb234_faction(%rbp),%rdi
    movlps 24(%rdi,%rax,4),%xmm9    ## jxH2a jyH2a  -   -
    movlps 24(%rdi,%rcx,4),%xmm10    ## jxH2c jyH2c  -   -
    movhps 24(%rdi,%rbx,4),%xmm9    ## jxH2a jyH2a jxH2b jyH2b 
    movhps 24(%rdi,%rdx,4),%xmm10    ## jxH2c jyH2c jxH2d jyH2d 

    movss  32(%rdi,%rax,4),%xmm11    ## jzH2a  -  -  -
    movss  32(%rdi,%rcx,4),%xmm12    ## jzH2c  -  -  -
    movhps 32(%rdi,%rbx,4),%xmm11    ## jzH2a  -  jzH2b  -
    movhps 32(%rdi,%rdx,4),%xmm12    ## jzH2c  -  jzH2d -

    shufps $136,%xmm12,%xmm11 ## 10001000 => jzH2a jzH2b jzH2c jzH2d

    ## xmm9: jxH2a jyH2a jxH2b jyH2b 
    ## xmm10: jxH2c jyH2c jxH2d jyH2d
    ## xmm11: jzH2a jzH2b jzH2c jzH2d

    movaps %xmm1,%xmm0
    movaps %xmm1,%xmm2
    movaps %xmm4,%xmm3
    movaps %xmm4,%xmm5
    movaps %xmm7,%xmm6
    movaps %xmm7,%xmm8

        mulps nb234_dxH1H2(%rsp),%xmm0
        mulps nb234_dyH1H2(%rsp),%xmm1
        mulps nb234_dzH1H2(%rsp),%xmm2
        mulps nb234_dxH2H2(%rsp),%xmm3
        mulps nb234_dyH2H2(%rsp),%xmm4
        mulps nb234_dzH2H2(%rsp),%xmm5
        mulps nb234_dxMH2(%rsp),%xmm6
        mulps nb234_dyMH2(%rsp),%xmm7
        mulps nb234_dzMH2(%rsp),%xmm8

    movaps %xmm0,%xmm13
    movaps %xmm1,%xmm14
    addps %xmm2,%xmm11
    addps nb234_fixH1(%rsp),%xmm0
    addps nb234_fiyH1(%rsp),%xmm1
    addps nb234_fizH1(%rsp),%xmm2

    addps %xmm3,%xmm13
    addps %xmm4,%xmm14
    addps %xmm5,%xmm11
    addps nb234_fixH2(%rsp),%xmm3
    addps nb234_fiyH2(%rsp),%xmm4
    addps nb234_fizH2(%rsp),%xmm5

    addps %xmm6,%xmm13
    addps %xmm7,%xmm14
    addps %xmm8,%xmm11
    addps nb234_fixM(%rsp),%xmm6
    addps nb234_fiyM(%rsp),%xmm7
    addps nb234_fizM(%rsp),%xmm8

    movaps %xmm0,nb234_fixH1(%rsp)
    movaps %xmm1,nb234_fiyH1(%rsp)
    movaps %xmm2,nb234_fizH1(%rsp)
    movaps %xmm3,nb234_fixH2(%rsp)
    movaps %xmm4,nb234_fiyH2(%rsp)
    movaps %xmm5,nb234_fizH2(%rsp)
    movaps %xmm6,nb234_fixM(%rsp)
    movaps %xmm7,nb234_fiyM(%rsp)
    movaps %xmm8,nb234_fizM(%rsp)

    ## xmm9  = fH2x
    ## xmm10 = fH2y
    ## xmm11 = fH2z
    movaps %xmm13,%xmm0
    unpcklps %xmm14,%xmm13
    unpckhps %xmm14,%xmm0

    addps %xmm13,%xmm9
    addps %xmm0,%xmm10

    movhlps  %xmm11,%xmm12 ## fH2zc fH2zd

    movlps %xmm9,24(%rdi,%rax,4)
    movhps %xmm9,24(%rdi,%rbx,4)
    movlps %xmm10,24(%rdi,%rcx,4)
    movhps %xmm10,24(%rdi,%rdx,4)
    movss  %xmm11,32(%rdi,%rax,4)
    movss  %xmm12,32(%rdi,%rcx,4)
    shufps $1,%xmm11,%xmm11
    shufps $1,%xmm12,%xmm12
    movss  %xmm11,32(%rdi,%rbx,4)
    movss  %xmm12,32(%rdi,%rdx,4)

        ## move j M coordinates to local temp variables 
    movlps 36(%rsi,%rax,4),%xmm0    ## jxMa jyMa  -   -
    movlps 36(%rsi,%rcx,4),%xmm1    ## jxMc jyMc  -   -
    movhps 36(%rsi,%rbx,4),%xmm0    ## jxMa jyMa jxMb jyMb 
    movhps 36(%rsi,%rdx,4),%xmm1    ## jxMc jyMc jxMd jyMd 

    movss  44(%rsi,%rax,4),%xmm2    ## jzMa  -  -  -
    movss  44(%rsi,%rcx,4),%xmm3    ## jzMc  -  -  -
    movss  44(%rsi,%rbx,4),%xmm5    ## jzMb  -  -  -
    movss  44(%rsi,%rdx,4),%xmm6    ## jzMd  -  -  -
    movlhps %xmm5,%xmm2 ## jzMa  -  jzMb  -
    movlhps %xmm6,%xmm3 ## jzMc  -  jzMd -

    movaps %xmm0,%xmm4
    unpcklps %xmm1,%xmm0 ## jxMa jxMc jyMa jyMc        
    unpckhps %xmm1,%xmm4 ## jxMb jxMd jyMb jyMd
    movaps %xmm0,%xmm1
    unpcklps %xmm4,%xmm0 ## x
    unpckhps %xmm4,%xmm1 ## y

    shufps $136,%xmm3,%xmm2 ## 10001000 => jzMa jzMb jzMc jzMd

    ## xmm0 = Mx
    ## xmm1 = My
    ## xmm2 = Mz

    movaps %xmm0,%xmm3
    movaps %xmm1,%xmm4
    movaps %xmm2,%xmm5
    movaps %xmm0,%xmm6
    movaps %xmm1,%xmm7
    movaps %xmm2,%xmm8

    subps nb234_ixH1(%rsp),%xmm0
    subps nb234_iyH1(%rsp),%xmm1
    subps nb234_izH1(%rsp),%xmm2
    subps nb234_ixH2(%rsp),%xmm3
    subps nb234_iyH2(%rsp),%xmm4
    subps nb234_izH2(%rsp),%xmm5
    subps nb234_ixM(%rsp),%xmm6
    subps nb234_iyM(%rsp),%xmm7
    subps nb234_izM(%rsp),%xmm8

        movaps %xmm0,nb234_dxH1M(%rsp)
        movaps %xmm1,nb234_dyH1M(%rsp)
        movaps %xmm2,nb234_dzH1M(%rsp)
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        movaps %xmm3,nb234_dxH2M(%rsp)
        movaps %xmm4,nb234_dyH2M(%rsp)
        movaps %xmm5,nb234_dzH2M(%rsp)
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        movaps %xmm6,nb234_dxMM(%rsp)
        movaps %xmm7,nb234_dyMM(%rsp)
        movaps %xmm8,nb234_dzMM(%rsp)
        mulps  %xmm6,%xmm6
        mulps  %xmm7,%xmm7
        mulps  %xmm8,%xmm8
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
    addps  %xmm7,%xmm6
    addps  %xmm8,%xmm6

        ## start doing invsqrt for jM atoms
        rsqrtps %xmm0,%xmm1
        rsqrtps %xmm3,%xmm4
    rsqrtps %xmm6,%xmm7

        movaps  %xmm1,%xmm2
        movaps  %xmm4,%xmm5
    movaps  %xmm7,%xmm8

        mulps   %xmm1,%xmm1 ## lu*lu
        mulps   %xmm4,%xmm4 ## lu*lu
    mulps   %xmm7,%xmm7 ## lu*lu

        movaps  nb234_three(%rsp),%xmm9
        movaps  %xmm9,%xmm10
    movaps  %xmm9,%xmm11

        mulps   %xmm0,%xmm1 ## rsq*lu*lu
        mulps   %xmm3,%xmm4 ## rsq*lu*lu 
    mulps   %xmm6,%xmm7 ## rsq*lu*lu

        subps   %xmm1,%xmm9
        subps   %xmm4,%xmm10
    subps   %xmm7,%xmm11 ## 3-rsq*lu*lu

        mulps   %xmm2,%xmm9
        mulps   %xmm5,%xmm10
    mulps   %xmm8,%xmm11 ## lu*(3-rsq*lu*lu)

        movaps  nb234_half(%rsp),%xmm4
        mulps   %xmm4,%xmm9 ## rinvH1M
        mulps   %xmm4,%xmm10 ## rinvH2M
    mulps   %xmm4,%xmm11 ## rinvMM

        ## M interactions 
    ## rsq in xmm0,xmm3,xmm6  
    ## rinv in xmm9, xmm10, xmm11

    movaps %xmm9,%xmm1 ## copy of rinv
    movaps %xmm10,%xmm4
    movaps %xmm11,%xmm7
    movaps nb234_krf(%rsp),%xmm2
    mulps  %xmm9,%xmm9  ## rinvsq
    mulps  %xmm10,%xmm10
    mulps  %xmm11,%xmm11
    mulps  %xmm2,%xmm0 ## k*rsq
    mulps  %xmm2,%xmm3
    mulps  %xmm2,%xmm6
    movaps %xmm0,%xmm2 ## copy of k*rsq
    movaps %xmm3,%xmm5
    movaps %xmm6,%xmm8
    addps  %xmm1,%xmm2 ## rinv+krsq
    addps  %xmm4,%xmm5
    addps  %xmm7,%xmm8
    movaps nb234_crf(%rsp),%xmm14
    subps  %xmm14,%xmm2  ## rinv+krsq-crf
    subps  %xmm14,%xmm5
    subps  %xmm14,%xmm8
    movaps nb234_qqMH(%rsp),%xmm12
    movaps nb234_qqMM(%rsp),%xmm13
    mulps  %xmm12,%xmm2 ## xmm6=voul=qq*(rinv+ krsq-crf)
    mulps  %xmm12,%xmm5 ## xmm6=voul=qq*(rinv+ krsq-crf)
    mulps  %xmm13,%xmm8 ## xmm6=voul=qq*(rinv+ krsq-crf)
    addps  %xmm0,%xmm0 ## 2*krsq
    addps  %xmm3,%xmm3
    addps  %xmm6,%xmm6
    subps  %xmm0,%xmm1 ## rinv-2*krsq
    subps  %xmm3,%xmm4
    subps  %xmm6,%xmm7
    mulps  %xmm12,%xmm1  ## (rinv-2*krsq)*qq
    mulps  %xmm12,%xmm4
    mulps  %xmm13,%xmm7
    addps  %xmm8,%xmm5
    addps  %xmm15,%xmm2
    addps  %xmm5,%xmm2
    movaps %xmm2,nb234_vctot(%rsp)

    mulps  %xmm9,%xmm1  ## fscal
    mulps  %xmm10,%xmm4
    mulps  %xmm11,%xmm7

        ## move j M forces to local temp variables 
        movq nb234_faction(%rbp),%rdi
    movlps 36(%rdi,%rax,4),%xmm9    ## jxMa jyMa  -   -
    movlps 36(%rdi,%rcx,4),%xmm10    ## jxMc jyMc  -   -
    movhps 36(%rdi,%rbx,4),%xmm9    ## jxMa jyMa jxMb jyMb 
    movhps 36(%rdi,%rdx,4),%xmm10    ## jxMc jyMc jxMd jyMd 

    movss  44(%rdi,%rax,4),%xmm11    ## jzMa  -  -  -
    movss  44(%rdi,%rcx,4),%xmm12    ## jzMc  -  -  -
    movss  44(%rdi,%rbx,4),%xmm2     ## jzMb  -  -  -
    movss  44(%rdi,%rdx,4),%xmm3     ## jzMd  -  -  -
    movlhps %xmm2,%xmm11 ## jzMa  -  jzMb  -
    movlhps %xmm3,%xmm12 ## jzMc  -  jzMd -

    shufps $136,%xmm12,%xmm11 ## 10001000 => jzMa jzMb jzMc jzMd

    ## xmm9: jxMa jyMa jxMb jyMb 
    ## xmm10: jxMc jyMc jxMd jyMd
    ## xmm11: jzMa jzMb jzMc jzMd

    movaps %xmm1,%xmm0
    movaps %xmm1,%xmm2
    movaps %xmm4,%xmm3
    movaps %xmm4,%xmm5
    movaps %xmm7,%xmm6
    movaps %xmm7,%xmm8

        mulps nb234_dxH1M(%rsp),%xmm0
        mulps nb234_dyH1M(%rsp),%xmm1
        mulps nb234_dzH1M(%rsp),%xmm2
        mulps nb234_dxH2M(%rsp),%xmm3
        mulps nb234_dyH2M(%rsp),%xmm4
        mulps nb234_dzH2M(%rsp),%xmm5
        mulps nb234_dxMM(%rsp),%xmm6
        mulps nb234_dyMM(%rsp),%xmm7
        mulps nb234_dzMM(%rsp),%xmm8

    movaps %xmm0,%xmm13
    movaps %xmm1,%xmm14
    addps %xmm2,%xmm11
    addps nb234_fixH1(%rsp),%xmm0
    addps nb234_fiyH1(%rsp),%xmm1
    addps nb234_fizH1(%rsp),%xmm2

    addps %xmm3,%xmm13
    addps %xmm4,%xmm14
    addps %xmm5,%xmm11
    addps nb234_fixH2(%rsp),%xmm3
    addps nb234_fiyH2(%rsp),%xmm4
    addps nb234_fizH2(%rsp),%xmm5

    addps %xmm6,%xmm13
    addps %xmm7,%xmm14
    addps %xmm8,%xmm11
    addps nb234_fixM(%rsp),%xmm6
    addps nb234_fiyM(%rsp),%xmm7
    addps nb234_fizM(%rsp),%xmm8

    movaps %xmm0,nb234_fixH1(%rsp)
    movaps %xmm1,nb234_fiyH1(%rsp)
    movaps %xmm2,nb234_fizH1(%rsp)
    movaps %xmm3,nb234_fixH2(%rsp)
    movaps %xmm4,nb234_fiyH2(%rsp)
    movaps %xmm5,nb234_fizH2(%rsp)
    movaps %xmm6,nb234_fixM(%rsp)
    movaps %xmm7,nb234_fiyM(%rsp)
    movaps %xmm8,nb234_fizM(%rsp)

    ## xmm0 = fMx
    ## xmm1 = fMy
    ## xmm2 = fMz
    movaps %xmm13,%xmm0
    unpcklps %xmm14,%xmm13
    unpckhps %xmm14,%xmm0

    addps %xmm13,%xmm9
    addps %xmm0,%xmm10

    movhlps  %xmm11,%xmm12 ## fMzc fMzd

    movlps %xmm9,36(%rdi,%rax,4)
    movhps %xmm9,36(%rdi,%rbx,4)
    movlps %xmm10,36(%rdi,%rcx,4)
    movhps %xmm10,36(%rdi,%rdx,4)
    movss  %xmm11,44(%rdi,%rax,4)
    movss  %xmm12,44(%rdi,%rcx,4)
    shufps $1,%xmm11,%xmm11
    shufps $1,%xmm12,%xmm12
    movss  %xmm11,44(%rdi,%rbx,4)
    movss  %xmm12,44(%rdi,%rdx,4)

        ## should we do one more iteration? 
        subl $4,nb234_innerk(%rsp)
        jl    _nb_kernel234_x86_64_sse.nb234_single_check
        jmp   _nb_kernel234_x86_64_sse.nb234_unroll_loop
_nb_kernel234_x86_64_sse.nb234_single_check: 
        addl $4,nb234_innerk(%rsp)
        jnz   _nb_kernel234_x86_64_sse.nb234_single_loop
        jmp   _nb_kernel234_x86_64_sse.nb234_updateouterdata
_nb_kernel234_x86_64_sse.nb234_single_loop: 
        movq  nb234_innerjjnr(%rsp),%rdx        ## pointer to jjnr[k] 
        movl  (%rdx),%eax
        addq $4,nb234_innerjjnr(%rsp)

        movq nb234_pos(%rbp),%rsi
        lea  (%rax,%rax,2),%rax

        ## fetch j coordinates
        movlps (%rsi,%rax,4),%xmm3              ##  Ox  Oy  
        movlps 16(%rsi,%rax,4),%xmm4            ## H1y H1z 
        movlps 32(%rsi,%rax,4),%xmm5            ## H2z  Mx 
        movhps 8(%rsi,%rax,4),%xmm3             ##  Ox  Oy  Oz H1x
        movhps 24(%rsi,%rax,4),%xmm4            ## H1y H1z H2x H2y
        movhps 40(%rsi,%rax,4),%xmm5            ## H2z  Mx  My  Mz
        ## transpose
        movaps %xmm4,%xmm0
        movaps %xmm3,%xmm1
        movaps %xmm4,%xmm2
        movaps %xmm3,%xmm6
        shufps $18,%xmm5,%xmm4 ## (00010010)  h2x - Mx  - 
        shufps $193,%xmm0,%xmm3 ## (11000001)  Oy  - H1y - 
        shufps $35,%xmm5,%xmm2 ## (00100011) H2y - My  - 
        shufps $18,%xmm0,%xmm1 ## (00010010)  Oz  - H1z - 
        ##  xmm6: Ox - - H1x   xmm5: H2z - - Mz 
        shufps $140,%xmm4,%xmm6 ## (10001100) Ox H1x H2x Mx 
        shufps $136,%xmm2,%xmm3 ## (10001000) Oy H1y H2y My 
        shufps $200,%xmm5,%xmm1 ## (11001000) Oz H1z H2z Mz

        ## store all j coordinates in jO  
        movaps %xmm6,nb234_jxO(%rsp)
        movaps %xmm3,nb234_jyO(%rsp)
        movaps %xmm1,nb234_jzO(%rsp)

    movaps %xmm6,%xmm0  ## jxO
    movaps %xmm1,%xmm2  ## jzO
    movaps %xmm3,%xmm1  ## jyO
    movaps %xmm3,%xmm4  ## jyO
    movaps %xmm6,%xmm3  ## jxO
    movaps %xmm2,%xmm5  ## jzO

        ## do O and M in parallel
        subps  nb234_ixO(%rsp),%xmm0
        subps  nb234_iyO(%rsp),%xmm1
        subps  nb234_izO(%rsp),%xmm2
        subps  nb234_ixM(%rsp),%xmm3
        subps  nb234_iyM(%rsp),%xmm4
        subps  nb234_izM(%rsp),%xmm5

        movaps %xmm0,nb234_dxOO(%rsp)
        movaps %xmm1,nb234_dyOO(%rsp)
        movaps %xmm2,nb234_dzOO(%rsp)
        movaps %xmm3,nb234_dxMM(%rsp)
        movaps %xmm4,nb234_dyMM(%rsp)
        movaps %xmm5,nb234_dzMM(%rsp)

        mulps %xmm0,%xmm0
        mulps %xmm1,%xmm1
        mulps %xmm2,%xmm2
        addps %xmm1,%xmm0
        addps %xmm2,%xmm0       ## have rsq in xmm0 
        mulps %xmm3,%xmm3
        mulps %xmm4,%xmm4
        mulps %xmm5,%xmm5
        addps %xmm3,%xmm4
        addps %xmm5,%xmm4       ## have rsq in xmm4
        ## Save data 
        movaps %xmm0,nb234_rsqOO(%rsp)
        movaps %xmm4,nb234_rsqMM(%rsp)

        ## do 1/x for O
        rsqrtps %xmm0,%xmm1
        movaps  %xmm1,%xmm2
        mulps   %xmm1,%xmm1
        movaps  nb234_three(%rsp),%xmm3
        mulps   %xmm0,%xmm1     ## rsq*lu*lu 
        subps   %xmm1,%xmm3     ## constant 30-rsq*lu*lu 
        mulps   %xmm2,%xmm3     ## lu*(3-rsq*lu*lu) 
        mulps   nb234_half(%rsp),%xmm3
        movaps  %xmm3,nb234_rinvOO(%rsp)        ## rinvH2 

        ## 1/sqrt(x) for M
        rsqrtps %xmm4,%xmm5
        movaps  %xmm5,%xmm6
        mulps   %xmm5,%xmm5
        movaps  nb234_three(%rsp),%xmm7
        mulps   %xmm4,%xmm5
        subps   %xmm5,%xmm7
        mulps   %xmm6,%xmm7
        mulps   nb234_half(%rsp),%xmm7   ## rinv iH1 - j water 
        movaps %xmm7,nb234_rinvMM(%rsp)


        ## LJ table interaction
        movaps nb234_rinvOO(%rsp),%xmm0
        movss %xmm0,%xmm1
        mulss  nb234_rsqOO(%rsp),%xmm1   ## xmm1=r 
        mulss  nb234_tsc(%rsp),%xmm1

    cvttps2pi %xmm1,%mm6
    cvtpi2ps %mm6,%xmm3
        subss    %xmm3,%xmm1    ## xmm1=eps 
    movss %xmm1,%xmm2
    mulss  %xmm2,%xmm2      ## xmm2=eps2 
    pslld $3,%mm6

    movq nb234_VFtab(%rbp),%rsi
    movd %mm6,%r8d

    ## dispersion 
    movlps (%rsi,%r8,4),%xmm5
    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 8(%rsi,%r8,4),%xmm7
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## dispersion table ready, in xmm4-xmm7 
    mulss  %xmm1,%xmm6      ## xmm6=Geps 
    mulss  %xmm2,%xmm7      ## xmm7=Heps2 
    addss  %xmm6,%xmm5
    addss  %xmm7,%xmm5      ## xmm5=Fp 
    mulss  nb234_two(%rsp),%xmm7         ## two*Heps2 
    addss  %xmm6,%xmm7
    addss  %xmm5,%xmm7 ## xmm7=FF 
    mulss  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addss  %xmm4,%xmm5 ## xmm5=VV 

    movss nb234_c6(%rsp),%xmm4
    mulss  %xmm4,%xmm7   ## fijD 
    mulss  %xmm4,%xmm5   ## Vvdw6 
        xorps  %xmm3,%xmm3

        mulps  nb234_tsc(%rsp),%xmm7
        subss  %xmm7,%xmm3
        movss  %xmm3,nb234_fstmp(%rsp)

    addss  nb234_Vvdwtot(%rsp),%xmm5
    movss %xmm5,nb234_Vvdwtot(%rsp)

    ## repulsion 
    movlps 16(%rsi,%r8,4),%xmm5
    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 24(%rsi,%r8,4),%xmm7
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## table ready, in xmm4-xmm7 
    mulss  %xmm1,%xmm6      ## xmm6=Geps 
    mulss  %xmm2,%xmm7      ## xmm7=Heps2 
    addss  %xmm6,%xmm5
    addss  %xmm7,%xmm5      ## xmm5=Fp 
    mulss  nb234_two(%rsp),%xmm7         ## two*Heps2 
    addss  %xmm6,%xmm7
    addss  %xmm5,%xmm7 ## xmm7=FF 
    mulss  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addss  %xmm4,%xmm5 ## xmm5=VV 

    movss nb234_c12(%rsp),%xmm4
    mulss  %xmm4,%xmm7 ## fijR 
    mulss  %xmm4,%xmm5 ## Vvdw12 
        movaps nb234_fstmp(%rsp),%xmm3
        mulss  nb234_tsc(%rsp),%xmm7
        subss  %xmm7,%xmm3

    addss  nb234_Vvdwtot(%rsp),%xmm5
    movss %xmm5,nb234_Vvdwtot(%rsp)

        mulss %xmm3,%xmm0
        movaps %xmm0,%xmm1
        movaps %xmm0,%xmm2

        mulss  nb234_dxOO(%rsp),%xmm0
        mulss  nb234_dyOO(%rsp),%xmm1
        mulss  nb234_dzOO(%rsp),%xmm2
        xorps   %xmm3,%xmm3
        xorps   %xmm4,%xmm4
        xorps   %xmm5,%xmm5
        addss   %xmm0,%xmm3
        addss   %xmm1,%xmm4
        addss   %xmm2,%xmm5
        movaps  %xmm3,nb234_fjxO(%rsp)
        movaps  %xmm4,nb234_fjyO(%rsp)
        movaps  %xmm5,nb234_fjzO(%rsp)
        addss   nb234_fixO(%rsp),%xmm0
        addss   nb234_fiyO(%rsp),%xmm1
        addss   nb234_fizO(%rsp),%xmm2
        movss  %xmm0,nb234_fixO(%rsp)
        movss  %xmm1,nb234_fiyO(%rsp)
        movss  %xmm2,nb234_fizO(%rsp)

        ## do  M coulomb interaction
        movaps nb234_rinvMM(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234_qqMH(%rsp),%xmm3
        movhps  nb234_qqMM(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234_rsqMM(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 
        mulps nb234_two(%rsp),%xmm5
        subps  %xmm5,%xmm7      ## xmm7=rinv-2*krsq 
        mulps  %xmm3,%xmm7 ## xmm7 = coul part of fscal 

        addps  nb234_vctot(%rsp),%xmm6
        movaps %xmm6,nb234_vctot(%rsp)
        mulps  %xmm7,%xmm0

        movaps %xmm0,%xmm1
        movaps %xmm0,%xmm2

        mulps   nb234_dxMM(%rsp),%xmm0
        mulps   nb234_dyMM(%rsp),%xmm1
        mulps   nb234_dzMM(%rsp),%xmm2
        ## update forces M - j water 
        movaps  nb234_fjxO(%rsp),%xmm3
        movaps  nb234_fjyO(%rsp),%xmm4
        movaps  nb234_fjzO(%rsp),%xmm5
        addps   %xmm0,%xmm3
        addps   %xmm1,%xmm4
        addps   %xmm2,%xmm5
        movaps  %xmm3,nb234_fjxO(%rsp)
        movaps  %xmm4,nb234_fjyO(%rsp)
        movaps  %xmm5,nb234_fjzO(%rsp)
        addps   nb234_fixM(%rsp),%xmm0
        addps   nb234_fiyM(%rsp),%xmm1
        addps   nb234_fizM(%rsp),%xmm2
        movaps  %xmm0,nb234_fixM(%rsp)
        movaps  %xmm1,nb234_fiyM(%rsp)
        movaps  %xmm2,nb234_fizM(%rsp)

        ## i H1 & H2 simultaneously first get i particle coords: 
    movaps  nb234_jxO(%rsp),%xmm0
    movaps  nb234_jyO(%rsp),%xmm1
    movaps  nb234_jzO(%rsp),%xmm2
    movaps  %xmm0,%xmm3
    movaps  %xmm1,%xmm4
    movaps  %xmm2,%xmm5
        subps   nb234_ixH1(%rsp),%xmm0
        subps   nb234_iyH1(%rsp),%xmm1
        subps   nb234_izH1(%rsp),%xmm2
        subps   nb234_ixH2(%rsp),%xmm3
        subps   nb234_iyH2(%rsp),%xmm4
        subps   nb234_izH2(%rsp),%xmm5
        movaps %xmm0,nb234_dxH1H1(%rsp)
        movaps %xmm1,nb234_dyH1H1(%rsp)
        movaps %xmm2,nb234_dzH1H1(%rsp)
        movaps %xmm3,nb234_dxH2H2(%rsp)
        movaps %xmm4,nb234_dyH2H2(%rsp)
        movaps %xmm5,nb234_dzH2H2(%rsp)
        mulps %xmm0,%xmm0
        mulps %xmm1,%xmm1
        mulps %xmm2,%xmm2
        mulps %xmm3,%xmm3
        mulps %xmm4,%xmm4
        mulps %xmm5,%xmm5
        addps %xmm1,%xmm0
        addps %xmm3,%xmm4
        addps %xmm2,%xmm0       ## have rsqH1 in xmm0 
        addps %xmm5,%xmm4       ## have rsqH2 in xmm4 
        movaps  %xmm0,nb234_rsqH1H1(%rsp)
        movaps  %xmm4,nb234_rsqH2H2(%rsp)

        ## start doing invsqrt use rsq values in xmm0, xmm4 
        rsqrtps %xmm0,%xmm1
        rsqrtps %xmm4,%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   %xmm0,%xmm1
        mulps   %xmm4,%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234_half(%rsp),%xmm3   ## rinvH1H1
        mulps   nb234_half(%rsp),%xmm7   ## rinvH2H2
        movaps  %xmm3,nb234_rinvH1H1(%rsp)
        movaps  %xmm7,nb234_rinvH2H2(%rsp)

        ## Do H1 coulomb interaction
        movaps nb234_rinvH1H1(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234_qqHH(%rsp),%xmm3
        movhps  nb234_qqMH(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234_rsqH1H1(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 
        mulps nb234_two(%rsp),%xmm5
        subps  %xmm5,%xmm7      ## xmm7=rinv-2*krsq 
        mulps  %xmm3,%xmm7 ## xmm7 = coul part of fscal 

        addps  nb234_vctot(%rsp),%xmm6
        movaps %xmm6,nb234_vctot(%rsp)

        mulps  %xmm7,%xmm0

        movaps %xmm0,%xmm1
        movaps %xmm0,%xmm2

        mulps   nb234_dxH1H1(%rsp),%xmm0
        mulps   nb234_dyH1H1(%rsp),%xmm1
        mulps   nb234_dzH1H1(%rsp),%xmm2
        ## update forces H1 - j water 
        movaps  nb234_fjxO(%rsp),%xmm3
        movaps  nb234_fjyO(%rsp),%xmm4
        movaps  nb234_fjzO(%rsp),%xmm5
        addps   %xmm0,%xmm3
        addps   %xmm1,%xmm4
        addps   %xmm2,%xmm5
        movaps  %xmm3,nb234_fjxO(%rsp)
        movaps  %xmm4,nb234_fjyO(%rsp)
        movaps  %xmm5,nb234_fjzO(%rsp)
        addps   nb234_fixH1(%rsp),%xmm0
        addps   nb234_fiyH1(%rsp),%xmm1
        addps   nb234_fizH1(%rsp),%xmm2
        movaps  %xmm0,nb234_fixH1(%rsp)
        movaps  %xmm1,nb234_fiyH1(%rsp)
        movaps  %xmm2,nb234_fizH1(%rsp)

        ## H2 Coulomb
        movaps nb234_rinvH2H2(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234_qqHH(%rsp),%xmm3
        movhps  nb234_qqMH(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234_rsqH2H2(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 
        mulps nb234_two(%rsp),%xmm5
        subps  %xmm5,%xmm7      ## xmm7=rinv-2*krsq 
        mulps  %xmm3,%xmm7 ## xmm7 = coul part of fscal 

        addps  nb234_vctot(%rsp),%xmm6   ## local vctot summation variable
        movaps %xmm6,nb234_vctot(%rsp)
        mulps  %xmm7,%xmm0

        movaps %xmm0,%xmm1
        movaps %xmm0,%xmm2

        mulps   nb234_dxH2H2(%rsp),%xmm0
        mulps   nb234_dyH2H2(%rsp),%xmm1
        mulps   nb234_dzH2H2(%rsp),%xmm2
        ## update forces H2 - j water 
        movaps  nb234_fjxO(%rsp),%xmm3
        movaps  nb234_fjyO(%rsp),%xmm4
        movaps  nb234_fjzO(%rsp),%xmm5
        addps   %xmm0,%xmm3
        addps   %xmm1,%xmm4
        addps   %xmm2,%xmm5
        movaps  %xmm3,nb234_fjxO(%rsp)
        movaps  %xmm4,nb234_fjyO(%rsp)
        movaps  %xmm5,nb234_fjzO(%rsp)
        addps   nb234_fixH2(%rsp),%xmm0
        addps   nb234_fiyH2(%rsp),%xmm1
        addps   nb234_fizH2(%rsp),%xmm2
        movaps  %xmm0,nb234_fixH2(%rsp)
        movaps  %xmm1,nb234_fiyH2(%rsp)
        movaps  %xmm2,nb234_fizH2(%rsp)

        movq    nb234_faction(%rbp),%rsi
        ## update j water forces from local variables.
        ## transpose back first
        movaps  nb234_fjxO(%rsp),%xmm0   ## Ox H1x H2x Mx 
        movaps  nb234_fjyO(%rsp),%xmm1   ## Oy H1y H2y My
        movaps  nb234_fjzO(%rsp),%xmm2   ## Oz H1z H2z Mz

        movaps  %xmm0,%xmm3
        movaps  %xmm0,%xmm4
        unpcklps %xmm1,%xmm3            ## Ox Oy - -
        shufps $0x1,%xmm2,%xmm4        ## h1x - Oz -
        movaps  %xmm1,%xmm5
        movaps  %xmm0,%xmm6
        unpcklps %xmm2,%xmm5            ## - - H1y H1z
        unpckhps %xmm1,%xmm6            ## h2x h2y - - 
        unpckhps %xmm2,%xmm1            ## - - My Mz

        shufps  $50,%xmm0,%xmm2 ## (00110010) h2z - Mx -
        shufps  $36,%xmm4,%xmm3 ## constant 00100100 ;# Ox Oy Oz H1x 
        shufps  $78,%xmm6,%xmm5 ## constant 01001110 ;# h1y h1z h2x h2y
        shufps  $232,%xmm1,%xmm2 ## constant 11101000 ;# h2z mx my mz

        movlps  (%rsi,%rax,4),%xmm0
        movlps  16(%rsi,%rax,4),%xmm1
        movlps  32(%rsi,%rax,4),%xmm4
        movhps  8(%rsi,%rax,4),%xmm0
        movhps  24(%rsi,%rax,4),%xmm1
        movhps  40(%rsi,%rax,4),%xmm4
        addps   %xmm3,%xmm0
        addps   %xmm5,%xmm1
        addps   %xmm2,%xmm4
        movlps   %xmm0,(%rsi,%rax,4)
        movlps   %xmm1,16(%rsi,%rax,4)
        movlps   %xmm4,32(%rsi,%rax,4)
        movhps   %xmm0,8(%rsi,%rax,4)
        movhps   %xmm1,24(%rsi,%rax,4)
        movhps   %xmm4,40(%rsi,%rax,4)

        decl nb234_innerk(%rsp)
        jz    _nb_kernel234_x86_64_sse.nb234_updateouterdata
        jmp   _nb_kernel234_x86_64_sse.nb234_single_loop
_nb_kernel234_x86_64_sse.nb234_updateouterdata: 
        movl  nb234_ii3(%rsp),%ecx
        movq  nb234_faction(%rbp),%rdi
        movq  nb234_fshift(%rbp),%rsi
        movl  nb234_is3(%rsp),%edx

        ## accumulate  Oi forces in xmm0, xmm1, xmm2 
        movaps nb234_fixO(%rsp),%xmm0
        movaps nb234_fiyO(%rsp),%xmm1
        movaps nb234_fizO(%rsp),%xmm2

        movhlps %xmm0,%xmm3
        movhlps %xmm1,%xmm4
        movhlps %xmm2,%xmm5
        addps  %xmm3,%xmm0
        addps  %xmm4,%xmm1
        addps  %xmm5,%xmm2 ## sum is in 1/2 in xmm0-xmm2 

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5

        shufps $1,%xmm3,%xmm3
        shufps $1,%xmm4,%xmm4
        shufps $1,%xmm5,%xmm5
        addss  %xmm3,%xmm0
        addss  %xmm4,%xmm1
        addss  %xmm5,%xmm2      ## xmm0-xmm2 has single force in pos0 

        ## increment i force 
        movss  (%rdi,%rcx,4),%xmm3
        movss  4(%rdi,%rcx,4),%xmm4
        movss  8(%rdi,%rcx,4),%xmm5
        subss  %xmm0,%xmm3
        subss  %xmm1,%xmm4
        subss  %xmm2,%xmm5
        movss  %xmm3,(%rdi,%rcx,4)
        movss  %xmm4,4(%rdi,%rcx,4)
        movss  %xmm5,8(%rdi,%rcx,4)

        ## accumulate force in xmm6/xmm7 for fshift 
        movaps %xmm0,%xmm6
        movss %xmm2,%xmm7
        movlhps %xmm1,%xmm6
        shufps $8,%xmm6,%xmm6 ## constant 00001000      

        ## accumulate H1i forces in xmm0, xmm1, xmm2 
        movaps nb234_fixH1(%rsp),%xmm0
        movaps nb234_fiyH1(%rsp),%xmm1
        movaps nb234_fizH1(%rsp),%xmm2

        movhlps %xmm0,%xmm3
        movhlps %xmm1,%xmm4
        movhlps %xmm2,%xmm5
        addps  %xmm3,%xmm0
        addps  %xmm4,%xmm1
        addps  %xmm5,%xmm2 ## sum is in 1/2 in xmm0-xmm2 

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5

        shufps $1,%xmm3,%xmm3
        shufps $1,%xmm4,%xmm4
        shufps $1,%xmm5,%xmm5
        addss  %xmm3,%xmm0
        addss  %xmm4,%xmm1
        addss  %xmm5,%xmm2      ## xmm0-xmm2 has single force in pos0 

        ## increment i force 
        movss  12(%rdi,%rcx,4),%xmm3
        movss  16(%rdi,%rcx,4),%xmm4
        movss  20(%rdi,%rcx,4),%xmm5
        subss  %xmm0,%xmm3
        subss  %xmm1,%xmm4
        subss  %xmm2,%xmm5
        movss  %xmm3,12(%rdi,%rcx,4)
        movss  %xmm4,16(%rdi,%rcx,4)
        movss  %xmm5,20(%rdi,%rcx,4)

        ## accumulate force in xmm6/xmm7 for fshift 
        addss %xmm2,%xmm7
        movlhps %xmm1,%xmm0
        shufps $8,%xmm0,%xmm0 ## constant 00001000      
        addps   %xmm0,%xmm6

        ## accumulate H2i forces in xmm0, xmm1, xmm2 
        movaps nb234_fixH2(%rsp),%xmm0
        movaps nb234_fiyH2(%rsp),%xmm1
        movaps nb234_fizH2(%rsp),%xmm2

        movhlps %xmm0,%xmm3
        movhlps %xmm1,%xmm4
        movhlps %xmm2,%xmm5
        addps  %xmm3,%xmm0
        addps  %xmm4,%xmm1
        addps  %xmm5,%xmm2 ## sum is in 1/2 in xmm0-xmm2 

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5

        shufps $1,%xmm3,%xmm3
        shufps $1,%xmm4,%xmm4
        shufps $1,%xmm5,%xmm5
        addss  %xmm3,%xmm0
        addss  %xmm4,%xmm1
        addss  %xmm5,%xmm2      ## xmm0-xmm2 has single force in pos0 

        ## increment i force 
        movss  24(%rdi,%rcx,4),%xmm3
        movss  28(%rdi,%rcx,4),%xmm4
        movss  32(%rdi,%rcx,4),%xmm5
        subss  %xmm0,%xmm3
        subss  %xmm1,%xmm4
        subss  %xmm2,%xmm5
        movss  %xmm3,24(%rdi,%rcx,4)
        movss  %xmm4,28(%rdi,%rcx,4)
        movss  %xmm5,32(%rdi,%rcx,4)

        ## accumulate force in xmm6/xmm7 for fshift 
        addss %xmm2,%xmm7
        movlhps %xmm1,%xmm0
        shufps $8,%xmm0,%xmm0 ## constant 00001000      
        addps   %xmm0,%xmm6

        ## accumulate Mi forces in xmm0, xmm1, xmm2 
        movaps nb234_fixM(%rsp),%xmm0
        movaps nb234_fiyM(%rsp),%xmm1
        movaps nb234_fizM(%rsp),%xmm2

        movhlps %xmm0,%xmm3
        movhlps %xmm1,%xmm4
        movhlps %xmm2,%xmm5
        addps  %xmm3,%xmm0
        addps  %xmm4,%xmm1
        addps  %xmm5,%xmm2 ## sum is in 1/2 in xmm0-xmm2 

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5

        shufps $1,%xmm3,%xmm3
        shufps $1,%xmm4,%xmm4
        shufps $1,%xmm5,%xmm5
        addss  %xmm3,%xmm0
        addss  %xmm4,%xmm1
        addss  %xmm5,%xmm2      ## xmm0-xmm2 has single force in pos0 

        ## increment i force 
        movss  36(%rdi,%rcx,4),%xmm3
        movss  40(%rdi,%rcx,4),%xmm4
        movss  44(%rdi,%rcx,4),%xmm5
        subss  %xmm0,%xmm3
        subss  %xmm1,%xmm4
        subss  %xmm2,%xmm5
        movss  %xmm3,36(%rdi,%rcx,4)
        movss  %xmm4,40(%rdi,%rcx,4)
        movss  %xmm5,44(%rdi,%rcx,4)

        ## accumulate force in xmm6/xmm7 for fshift 
        addss %xmm2,%xmm7
        movlhps %xmm1,%xmm0
        shufps $8,%xmm0,%xmm0 ## constant 00001000      
        addps   %xmm0,%xmm6

        ## increment fshift force  
        movlps  (%rsi,%rdx,4),%xmm3
        movss  8(%rsi,%rdx,4),%xmm4
        subps  %xmm6,%xmm3
        subss  %xmm7,%xmm4
        movlps  %xmm3,(%rsi,%rdx,4)
        movss  %xmm4,8(%rsi,%rdx,4)

        ## get n from stack
        movl nb234_n(%rsp),%esi
        ## get group index for i particle 
        movq  nb234_gid(%rbp),%rdx              ## base of gid[]
        movl  (%rdx,%rsi,4),%edx                ## ggid=gid[n]

        ## accumulate total potential energy and update it 
        movaps nb234_vctot(%rsp),%xmm7
        ## accumulate 
        movhlps %xmm7,%xmm6
        addps  %xmm6,%xmm7      ## pos 0-1 in xmm7 have the sum now 
        movaps %xmm7,%xmm6
        shufps $1,%xmm6,%xmm6
        addss  %xmm6,%xmm7

        ## add earlier value from mem 
        movq  nb234_Vc(%rbp),%rax
        addss (%rax,%rdx,4),%xmm7
        ## move back to mem 
        movss %xmm7,(%rax,%rdx,4)

        ## accumulate total lj energy and update it 
        movaps nb234_Vvdwtot(%rsp),%xmm7
        ## accumulate 
        movhlps %xmm7,%xmm6
        addps  %xmm6,%xmm7      ## pos 0-1 in xmm7 have the sum now 
        movaps %xmm7,%xmm6
        shufps $1,%xmm6,%xmm6
        addss  %xmm6,%xmm7

        ## add earlier value from mem 
        movq  nb234_Vvdw(%rbp),%rax
        addss (%rax,%rdx,4),%xmm7
        ## move back to mem 
        movss %xmm7,(%rax,%rdx,4)

        ## finish if last 
        movl nb234_nn1(%rsp),%ecx
        ## esi already loaded with n
        incl %esi
        subl %esi,%ecx
        jz _nb_kernel234_x86_64_sse.nb234_outerend

        ## not last, iterate outer loop once more!  
        movl %esi,nb234_n(%rsp)
        jmp _nb_kernel234_x86_64_sse.nb234_outer
_nb_kernel234_x86_64_sse.nb234_outerend: 
        ## check if more outer neighborlists remain
        movl  nb234_nri(%rsp),%ecx
        ## esi already loaded with n above
        subl  %esi,%ecx
        jz _nb_kernel234_x86_64_sse.nb234_end
        ## non-zero, do one more workunit
        jmp   _nb_kernel234_x86_64_sse.nb234_threadloop
_nb_kernel234_x86_64_sse.nb234_end: 
        movl nb234_nouter(%rsp),%eax
        movl nb234_ninner(%rsp),%ebx
        movq nb234_outeriter(%rbp),%rcx
        movq nb234_inneriter(%rbp),%rdx
        movl %eax,(%rcx)
        movl %ebx,(%rdx)

        addq $1912,%rsp
        emms


        pop %r15
        pop %r14
        pop %r13
        pop %r12

        pop %rbx
        pop    %rbp
        ret



.globl nb_kernel234nf_x86_64_sse
.globl _nb_kernel234nf_x86_64_sse
nb_kernel234nf_x86_64_sse:      
_nb_kernel234nf_x86_64_sse:     
##      Room for return address and rbp (16 bytes)
.set nb234nf_fshift, 16
.set nb234nf_gid, 24
.set nb234nf_pos, 32
.set nb234nf_faction, 40
.set nb234nf_charge, 48
.set nb234nf_p_facel, 56
.set nb234nf_argkrf, 64
.set nb234nf_argcrf, 72
.set nb234nf_Vc, 80
.set nb234nf_type, 88
.set nb234nf_p_ntype, 96
.set nb234nf_vdwparam, 104
.set nb234nf_Vvdw, 112
.set nb234nf_p_tabscale, 120
.set nb234nf_VFtab, 128
.set nb234nf_invsqrta, 136
.set nb234nf_dvda, 144
.set nb234nf_p_gbtabscale, 152
.set nb234nf_GBtab, 160
.set nb234nf_p_nthreads, 168
.set nb234nf_count, 176
.set nb234nf_mtx, 184
.set nb234nf_outeriter, 192
.set nb234nf_inneriter, 200
.set nb234nf_work, 208
        ## stack offsets for local variables  
        ## bottom of stack is cache-aligned for sse use 
.set nb234nf_ixO, 0
.set nb234nf_iyO, 16
.set nb234nf_izO, 32
.set nb234nf_ixH1, 48
.set nb234nf_iyH1, 64
.set nb234nf_izH1, 80
.set nb234nf_ixH2, 96
.set nb234nf_iyH2, 112
.set nb234nf_izH2, 128
.set nb234nf_ixM, 144
.set nb234nf_iyM, 160
.set nb234nf_izM, 176
.set nb234nf_jxO, 192
.set nb234nf_jyO, 208
.set nb234nf_jzO, 224
.set nb234nf_jxH1, 240
.set nb234nf_jyH1, 256
.set nb234nf_jzH1, 272
.set nb234nf_jxH2, 288
.set nb234nf_jyH2, 304
.set nb234nf_jzH2, 320
.set nb234nf_jxM, 336
.set nb234nf_jyM, 352
.set nb234nf_jzM, 368
.set nb234nf_qqMM, 384
.set nb234nf_qqMH, 400
.set nb234nf_qqHH, 416
.set nb234nf_tsc, 432
.set nb234nf_c6, 448
.set nb234nf_c12, 464
.set nb234nf_vctot, 480
.set nb234nf_Vvdwtot, 496
.set nb234nf_half, 512
.set nb234nf_three, 528
.set nb234nf_rsqOO, 544
.set nb234nf_rsqH1H1, 560
.set nb234nf_rsqH1H2, 576
.set nb234nf_rsqH1M, 592
.set nb234nf_rsqH2H1, 608
.set nb234nf_rsqH2H2, 624
.set nb234nf_rsqH2M, 640
.set nb234nf_rsqMH1, 656
.set nb234nf_rsqMH2, 672
.set nb234nf_rsqMM, 688
.set nb234nf_rinvOO, 704
.set nb234nf_rinvH1H1, 720
.set nb234nf_rinvH1H2, 736
.set nb234nf_rinvH1M, 752
.set nb234nf_rinvH2H1, 768
.set nb234nf_rinvH2H2, 784
.set nb234nf_rinvH2M, 800
.set nb234nf_rinvMH1, 816
.set nb234nf_rinvMH2, 832
.set nb234nf_rinvMM, 848
.set nb234nf_krf, 864
.set nb234nf_crf, 880
.set nb234nf_is3, 896
.set nb234nf_ii3, 900
.set nb234nf_innerjjnr, 904
.set nb234nf_nri, 912
.set nb234nf_iinr, 920
.set nb234nf_jindex, 928
.set nb234nf_jjnr, 936
.set nb234nf_shift, 944
.set nb234nf_shiftvec, 952
.set nb234nf_facel, 960
.set nb234nf_innerk, 968
.set nb234nf_n, 972
.set nb234nf_nn1, 976
.set nb234nf_nouter, 980
.set nb234nf_ninner, 984


        push %rbp
        movq %rsp,%rbp
        push %rbx

        emms

        push %r12
        push %r13
        push %r14
        push %r15

        subq $1000,%rsp         ## local variable stack space (n*16+8)

        ## zero 32-bit iteration counters
        movl $0,%eax
        movl %eax,nb234nf_nouter(%rsp)
        movl %eax,nb234nf_ninner(%rsp)

        movl (%rdi),%edi
        movl %edi,nb234nf_nri(%rsp)
        movq %rsi,nb234nf_iinr(%rsp)
        movq %rdx,nb234nf_jindex(%rsp)
        movq %rcx,nb234nf_jjnr(%rsp)
        movq %r8,nb234nf_shift(%rsp)
        movq %r9,nb234nf_shiftvec(%rsp)
        movq nb234nf_p_facel(%rbp),%rsi
        movss (%rsi),%xmm0
        movss %xmm0,nb234nf_facel(%rsp)

        movq nb234nf_p_tabscale(%rbp),%rax
        movss (%rax),%xmm3
        shufps $0,%xmm3,%xmm3
        movaps %xmm3,nb234nf_tsc(%rsp)

        movq nb234nf_argkrf(%rbp),%rsi
        movq nb234nf_argcrf(%rbp),%rdi
        movss (%rsi),%xmm1
        movss (%rdi),%xmm2
        shufps $0,%xmm1,%xmm1
        shufps $0,%xmm2,%xmm2
        movaps %xmm1,nb234nf_krf(%rsp)
        movaps %xmm2,nb234nf_crf(%rsp)

        ## create constant floating-point factors on stack
        movl $0x3f000000,%eax   ## half in IEEE (hex)
        movl %eax,nb234nf_half(%rsp)
        movss nb234nf_half(%rsp),%xmm1
        shufps $0,%xmm1,%xmm1  ## splat to all elements
        movaps %xmm1,%xmm2
        addps  %xmm2,%xmm2      ## one
        movaps %xmm2,%xmm3
        addps  %xmm2,%xmm2      ## two
        addps  %xmm2,%xmm3      ## three
        movaps %xmm1,nb234nf_half(%rsp)
        movaps %xmm3,nb234nf_three(%rsp)

        ## assume we have at least one i particle - start directly 
        movq  nb234nf_iinr(%rsp),%rcx     ## rcx = pointer into iinr[]
        movl  (%rcx),%ebx               ## ebx =ii 

        movq  nb234nf_charge(%rbp),%rdx
        movss 4(%rdx,%rbx,4),%xmm5
        movss 12(%rdx,%rbx,4),%xmm3
        movss %xmm3,%xmm4
        movq nb234nf_p_facel(%rbp),%rsi
        movss (%rsi),%xmm0
        movss nb234nf_facel(%rsp),%xmm6
        mulss  %xmm3,%xmm3
        mulss  %xmm5,%xmm4
        mulss  %xmm5,%xmm5
        mulss  %xmm6,%xmm3
        mulss  %xmm6,%xmm4
        mulss  %xmm6,%xmm5
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        movaps %xmm3,nb234nf_qqMM(%rsp)
        movaps %xmm4,nb234nf_qqMH(%rsp)
        movaps %xmm5,nb234nf_qqHH(%rsp)

        xorps %xmm0,%xmm0
        movq  nb234nf_type(%rbp),%rdx
        movl  (%rdx,%rbx,4),%ecx
        shll  %ecx
        movl  %ecx,%edx
        movq nb234nf_p_ntype(%rbp),%rdi
        imull (%rdi),%ecx ## rcx = ntia = 2*ntype*type[ii0] 
        addq  %rcx,%rdx
        movq  nb234nf_vdwparam(%rbp),%rax
        movlps (%rax,%rdx,4),%xmm0
        movaps %xmm0,%xmm1
        shufps $0,%xmm0,%xmm0
        shufps $0x55,%xmm1,%xmm1
        movaps %xmm0,nb234nf_c6(%rsp)
        movaps %xmm1,nb234nf_c12(%rsp)

_nb_kernel234nf_x86_64_sse.nb234nf_threadloop: 
        movq  nb234nf_count(%rbp),%rsi            ## pointer to sync counter
        movl  (%rsi),%eax
_nb_kernel234nf_x86_64_sse.nb234nf_spinlock: 
        movl  %eax,%ebx                         ## ebx=*count=nn0
        addl  $1,%ebx                          ## ebx=nn1=nn0+10
        lock 
        cmpxchgl %ebx,(%rsi)                    ## write nn1 to *counter,
                                                ## if it hasnt changed.
                                                ## or reread *counter to eax.
        pause                                   ## -> better p4 performance
        jnz _nb_kernel234nf_x86_64_sse.nb234nf_spinlock

        ## if(nn1>nri) nn1=nri
        movl nb234nf_nri(%rsp),%ecx
        movl %ecx,%edx
        subl %ebx,%ecx
        cmovlel %edx,%ebx                       ## if(nn1>nri) nn1=nri
        ## Cleared the spinlock if we got here.
        ## eax contains nn0, ebx contains nn1.
        movl %eax,nb234nf_n(%rsp)
        movl %ebx,nb234nf_nn1(%rsp)
        subl %eax,%ebx                          ## calc number of outer lists
        movl %eax,%esi                          ## copy n to esi
        jg  _nb_kernel234nf_x86_64_sse.nb234nf_outerstart
        jmp _nb_kernel234nf_x86_64_sse.nb234nf_end

_nb_kernel234nf_x86_64_sse.nb234nf_outerstart: 
        ## ebx contains number of outer iterations
        addl nb234nf_nouter(%rsp),%ebx
        movl %ebx,nb234nf_nouter(%rsp)

_nb_kernel234nf_x86_64_sse.nb234nf_outer: 
        movq  nb234nf_shift(%rsp),%rax          ## eax = pointer into shift[] 
        movl  (%rax,%rsi,4),%ebx                ## ebx=shift[n] 

        lea  (%rbx,%rbx,2),%rbx        ## rbx=3*is 
        movl  %ebx,nb234nf_is3(%rsp)            ## store is3 

        movq  nb234nf_shiftvec(%rsp),%rax     ## eax = base of shiftvec[] 

        movss (%rax,%rbx,4),%xmm0
        movss 4(%rax,%rbx,4),%xmm1
        movss 8(%rax,%rbx,4),%xmm2

        movq  nb234nf_iinr(%rsp),%rcx           ## ecx = pointer into iinr[]    
        movl  (%rcx,%rsi,4),%ebx                ## ebx =ii 

        lea  (%rbx,%rbx,2),%rbx        ## rbx = 3*ii=ii3 
        movq  nb234nf_pos(%rbp),%rax    ## eax = base of pos[]  
        movl  %ebx,nb234nf_ii3(%rsp)

        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5
        movaps %xmm0,%xmm6
        movaps %xmm1,%xmm7

        addss (%rax,%rbx,4),%xmm3       ## ox
        addss 4(%rax,%rbx,4),%xmm4     ## oy
        addss 8(%rax,%rbx,4),%xmm5     ## oz
        addss 12(%rax,%rbx,4),%xmm6    ## h1x
        addss 16(%rax,%rbx,4),%xmm7    ## h1y
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        shufps $0,%xmm6,%xmm6
        shufps $0,%xmm7,%xmm7
        movaps %xmm3,nb234nf_ixO(%rsp)
        movaps %xmm4,nb234nf_iyO(%rsp)
        movaps %xmm5,nb234nf_izO(%rsp)
        movaps %xmm6,nb234nf_ixH1(%rsp)
        movaps %xmm7,nb234nf_iyH1(%rsp)

        movss %xmm2,%xmm6
        movss %xmm0,%xmm3
        movss %xmm1,%xmm4
        movss %xmm2,%xmm5
        addss 20(%rax,%rbx,4),%xmm6    ## h1z
        addss 24(%rax,%rbx,4),%xmm0    ## h2x
        addss 28(%rax,%rbx,4),%xmm1    ## h2y
        addss 32(%rax,%rbx,4),%xmm2    ## h2z
        addss 36(%rax,%rbx,4),%xmm3    ## mx
        addss 40(%rax,%rbx,4),%xmm4    ## my
        addss 44(%rax,%rbx,4),%xmm5    ## mz

        shufps $0,%xmm6,%xmm6
        shufps $0,%xmm0,%xmm0
        shufps $0,%xmm1,%xmm1
        shufps $0,%xmm2,%xmm2
        shufps $0,%xmm3,%xmm3
        shufps $0,%xmm4,%xmm4
        shufps $0,%xmm5,%xmm5
        movaps %xmm6,nb234nf_izH1(%rsp)
        movaps %xmm0,nb234nf_ixH2(%rsp)
        movaps %xmm1,nb234nf_iyH2(%rsp)
        movaps %xmm2,nb234nf_izH2(%rsp)
        movaps %xmm3,nb234nf_ixM(%rsp)
        movaps %xmm4,nb234nf_iyM(%rsp)
        movaps %xmm5,nb234nf_izM(%rsp)

        ## clear vctot 
        xorps %xmm4,%xmm4
        movaps %xmm4,nb234nf_vctot(%rsp)
        movaps %xmm4,nb234nf_Vvdwtot(%rsp)

        movq  nb234nf_jindex(%rsp),%rax
        movl  (%rax,%rsi,4),%ecx                ## jindex[n] 
        movl  4(%rax,%rsi,4),%edx               ## jindex[n+1] 
        subl  %ecx,%edx                 ## number of innerloop atoms 

        movq  nb234nf_pos(%rbp),%rsi
        movq  nb234nf_jjnr(%rsp),%rax
        shll  $2,%ecx
        addq  %rcx,%rax
        movq  %rax,nb234nf_innerjjnr(%rsp)      ## pointer to jjnr[nj0] 
        movl  %edx,%ecx
        subl  $4,%edx
        addl  nb234nf_ninner(%rsp),%ecx
        movl  %ecx,nb234nf_ninner(%rsp)
        addl  $0,%edx
        movl  %edx,nb234nf_innerk(%rsp)         ## number of innerloop atoms 
        jge   _nb_kernel234nf_x86_64_sse.nb234nf_unroll_loop
        jmp   _nb_kernel234nf_x86_64_sse.nb234nf_single_check
_nb_kernel234nf_x86_64_sse.nb234nf_unroll_loop: 
        ## quad-unroll innerloop here 
        movq  nb234nf_innerjjnr(%rsp),%rdx      ## pointer to jjnr[k] 

        movl  (%rdx),%eax
        movl  4(%rdx),%ebx
        movl  8(%rdx),%ecx
        movl  12(%rdx),%edx             ## eax-edx=jnr1-4 

        addq $16,nb234nf_innerjjnr(%rsp)             ## advance pointer (unroll 4) 

        movq nb234nf_pos(%rbp),%rsi     ## base of pos[] 

        lea  (%rax,%rax,2),%rax        ## replace jnr with j3 
        lea  (%rbx,%rbx,2),%rbx
        lea  (%rcx,%rcx,2),%rcx        ## replace jnr with j3 
        lea  (%rdx,%rdx,2),%rdx

        ## move j coordinates to local temp variables
        ## Load Ox, Oy, Oz, H1x 
        movlps (%rsi,%rax,4),%xmm1      ##  Oxa   Oya    -    -
        movlps (%rsi,%rcx,4),%xmm4      ##  Oxc   Oyc    -    -
        movhps (%rsi,%rbx,4),%xmm1      ##  Oxa   Oya   Oxb   Oyb 
        movhps (%rsi,%rdx,4),%xmm4      ##  Oxc   Oyc   Oxd   Oyd 
        movaps %xmm1,%xmm0              ##  Oxa   Oya   Oxb   Oyb 
        shufps $0x88,%xmm4,%xmm0       ##  Oxa   Oxb   Oxc   Oxd
        shufps $0xDD,%xmm4,%xmm1       ##  Oya   Oyb   Oyc   Oyd
        movlps 8(%rsi,%rax,4),%xmm3     ##  Oza  H1xa    -    -
        movlps 8(%rsi,%rcx,4),%xmm5     ##  Ozc  H1xc    -    -
        movhps 8(%rsi,%rbx,4),%xmm3     ##  Oza  H1xa   Ozb  H1xb 
        movhps 8(%rsi,%rdx,4),%xmm5     ##  Ozc  H1xc   Ozd  H1xd 
        movaps %xmm3,%xmm2              ##  Oza  H1xa   Ozb  H1xb 
        shufps $0x88,%xmm5,%xmm2       ##  Oza   Ozb   Ozc   Ozd
        shufps $0xDD,%xmm5,%xmm3       ## H1xa  H1xb  H1xc  H1xd
        ## coordinates in xmm0-xmm3     
        ## store
        movaps %xmm0,nb234nf_jxO(%rsp)
        movaps %xmm1,nb234nf_jyO(%rsp)
        movaps %xmm2,nb234nf_jzO(%rsp)
        movaps %xmm3,nb234nf_jxH1(%rsp)

        ## Load H1y H1z H2x H2y 
        movlps 16(%rsi,%rax,4),%xmm1
        movlps 16(%rsi,%rcx,4),%xmm4
        movhps 16(%rsi,%rbx,4),%xmm1
        movhps 16(%rsi,%rdx,4),%xmm4
        movaps %xmm1,%xmm0
        shufps $0x88,%xmm4,%xmm0
        shufps $0xDD,%xmm4,%xmm1
        movlps 24(%rsi,%rax,4),%xmm3
        movlps 24(%rsi,%rcx,4),%xmm5
        movhps 24(%rsi,%rbx,4),%xmm3
        movhps 24(%rsi,%rdx,4),%xmm5
        movaps %xmm3,%xmm2
        shufps $0x88,%xmm5,%xmm2
        shufps $0xDD,%xmm5,%xmm3
        ## coordinates in xmm0-xmm3     
        ## store
        movaps %xmm0,nb234nf_jyH1(%rsp)
        movaps %xmm1,nb234nf_jzH1(%rsp)
        movaps %xmm2,nb234nf_jxH2(%rsp)
        movaps %xmm3,nb234nf_jyH2(%rsp)

        ## Load H2z Mx My Mz 
        movlps 32(%rsi,%rax,4),%xmm1
        movlps 32(%rsi,%rcx,4),%xmm4
        movhps 32(%rsi,%rbx,4),%xmm1
        movhps 32(%rsi,%rdx,4),%xmm4
        movaps %xmm1,%xmm0
        shufps $0x88,%xmm4,%xmm0
        shufps $0xDD,%xmm4,%xmm1
        movlps 40(%rsi,%rax,4),%xmm3
        movlps 40(%rsi,%rcx,4),%xmm5
        movhps 40(%rsi,%rbx,4),%xmm3
        movhps 40(%rsi,%rdx,4),%xmm5
        movaps %xmm3,%xmm2
        shufps $0x88,%xmm5,%xmm2
        shufps $0xDD,%xmm5,%xmm3
        ## coordinates in xmm0-xmm3     
        ## store
        movaps %xmm0,nb234nf_jzH2(%rsp)
        movaps %xmm1,nb234nf_jxM(%rsp)
        movaps %xmm2,nb234nf_jyM(%rsp)
        movaps %xmm3,nb234nf_jzM(%rsp)

        ## start calculating pairwise distances
        movaps nb234nf_ixO(%rsp),%xmm0
        movaps nb234nf_iyO(%rsp),%xmm1
        movaps nb234nf_izO(%rsp),%xmm2
        movaps nb234nf_ixH1(%rsp),%xmm3
        movaps nb234nf_iyH1(%rsp),%xmm4
        movaps nb234nf_izH1(%rsp),%xmm5
        subps  nb234nf_jxO(%rsp),%xmm0
        subps  nb234nf_jyO(%rsp),%xmm1
        subps  nb234nf_jzO(%rsp),%xmm2
        subps  nb234nf_jxH1(%rsp),%xmm3
        subps  nb234nf_jyH1(%rsp),%xmm4
        subps  nb234nf_jzH1(%rsp),%xmm5
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
        movaps %xmm0,nb234nf_rsqOO(%rsp)
        movaps %xmm3,nb234nf_rsqH1H1(%rsp)

        movaps nb234nf_ixH1(%rsp),%xmm0
        movaps nb234nf_iyH1(%rsp),%xmm1
        movaps nb234nf_izH1(%rsp),%xmm2
        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5
        subps  nb234nf_jxH2(%rsp),%xmm0
        subps  nb234nf_jyH2(%rsp),%xmm1
        subps  nb234nf_jzH2(%rsp),%xmm2
        subps  nb234nf_jxM(%rsp),%xmm3
        subps  nb234nf_jyM(%rsp),%xmm4
        subps  nb234nf_jzM(%rsp),%xmm5
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
        movaps %xmm0,nb234nf_rsqH1H2(%rsp)
        movaps %xmm3,nb234nf_rsqH1M(%rsp)

        movaps nb234nf_ixH2(%rsp),%xmm0
        movaps nb234nf_iyH2(%rsp),%xmm1
        movaps nb234nf_izH2(%rsp),%xmm2
        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5
        subps  nb234nf_jxH1(%rsp),%xmm0
        subps  nb234nf_jyH1(%rsp),%xmm1
        subps  nb234nf_jzH1(%rsp),%xmm2
        subps  nb234nf_jxH2(%rsp),%xmm3
        subps  nb234nf_jyH2(%rsp),%xmm4
        subps  nb234nf_jzH2(%rsp),%xmm5
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm4,%xmm3
        addps  %xmm5,%xmm3
        movaps %xmm0,nb234nf_rsqH2H1(%rsp)
        movaps %xmm3,nb234nf_rsqH2H2(%rsp)

        movaps nb234nf_ixH2(%rsp),%xmm0
        movaps nb234nf_iyH2(%rsp),%xmm1
        movaps nb234nf_izH2(%rsp),%xmm2
        movaps nb234nf_ixM(%rsp),%xmm3
        movaps nb234nf_iyM(%rsp),%xmm4
        movaps nb234nf_izM(%rsp),%xmm5
        subps  nb234nf_jxM(%rsp),%xmm0
        subps  nb234nf_jyM(%rsp),%xmm1
        subps  nb234nf_jzM(%rsp),%xmm2
        subps  nb234nf_jxH1(%rsp),%xmm3
        subps  nb234nf_jyH1(%rsp),%xmm4
        subps  nb234nf_jzH1(%rsp),%xmm5
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm3,%xmm4
        addps  %xmm5,%xmm4
        movaps %xmm0,nb234nf_rsqH2M(%rsp)
        movaps %xmm4,nb234nf_rsqMH1(%rsp)

        movaps nb234nf_ixM(%rsp),%xmm0
        movaps nb234nf_iyM(%rsp),%xmm1
        movaps nb234nf_izM(%rsp),%xmm2
        movaps %xmm0,%xmm3
        movaps %xmm1,%xmm4
        movaps %xmm2,%xmm5
        subps  nb234nf_jxH2(%rsp),%xmm0
        subps  nb234nf_jyH2(%rsp),%xmm1
        subps  nb234nf_jzH2(%rsp),%xmm2
        subps  nb234nf_jxM(%rsp),%xmm3
        subps  nb234nf_jyM(%rsp),%xmm4
        subps  nb234nf_jzM(%rsp),%xmm5
        mulps  %xmm0,%xmm0
        mulps  %xmm1,%xmm1
        mulps  %xmm2,%xmm2
        mulps  %xmm3,%xmm3
        mulps  %xmm4,%xmm4
        mulps  %xmm5,%xmm5
        addps  %xmm1,%xmm0
        addps  %xmm2,%xmm0
        addps  %xmm3,%xmm4
        addps  %xmm5,%xmm4
        movaps %xmm0,nb234nf_rsqMH2(%rsp)
        movaps %xmm4,nb234nf_rsqMM(%rsp)

        ## start by doing invsqrt for OO
        rsqrtps nb234nf_rsqOO(%rsp),%xmm1
        movaps  %xmm1,%xmm2
        mulps   %xmm1,%xmm1
        movaps  nb234nf_three(%rsp),%xmm3
        mulps   nb234nf_rsqOO(%rsp),%xmm1
        subps   %xmm1,%xmm3
        mulps   %xmm2,%xmm3
        mulps   nb234nf_half(%rsp),%xmm3
        movaps  %xmm3,nb234nf_rinvOO(%rsp)

        ## more invsqrt ops - do two at a time.
        rsqrtps nb234nf_rsqH1H1(%rsp),%xmm1
        rsqrtps nb234nf_rsqH1H2(%rsp),%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   nb234nf_rsqH1H1(%rsp),%xmm1
        mulps   nb234nf_rsqH1H2(%rsp),%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm3   ## rinvH1H1 
        mulps   nb234nf_half(%rsp),%xmm7   ## rinvH1H2 
        movaps  %xmm3,nb234nf_rinvH1H1(%rsp)
        movaps  %xmm7,nb234nf_rinvH1H2(%rsp)

        rsqrtps nb234nf_rsqH1M(%rsp),%xmm1
        rsqrtps nb234nf_rsqH2H1(%rsp),%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   nb234nf_rsqH1M(%rsp),%xmm1
        mulps   nb234nf_rsqH2H1(%rsp),%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm3
        mulps   nb234nf_half(%rsp),%xmm7
        movaps  %xmm3,nb234nf_rinvH1M(%rsp)
        movaps  %xmm7,nb234nf_rinvH2H1(%rsp)

        rsqrtps nb234nf_rsqH2H2(%rsp),%xmm1
        rsqrtps nb234nf_rsqH2M(%rsp),%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   nb234nf_rsqH2H2(%rsp),%xmm1
        mulps   nb234nf_rsqH2M(%rsp),%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm3
        mulps   nb234nf_half(%rsp),%xmm7
        movaps  %xmm3,nb234nf_rinvH2H2(%rsp)
        movaps  %xmm7,nb234nf_rinvH2M(%rsp)

        rsqrtps nb234nf_rsqMH1(%rsp),%xmm1
        rsqrtps nb234nf_rsqMH2(%rsp),%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   nb234nf_rsqMH1(%rsp),%xmm1
        mulps   nb234nf_rsqMH2(%rsp),%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm3
        mulps   nb234nf_half(%rsp),%xmm7
        movaps  %xmm3,nb234nf_rinvMH1(%rsp)
        movaps  %xmm7,nb234nf_rinvMH2(%rsp)

        rsqrtps nb234nf_rsqMM(%rsp),%xmm1
        movaps  %xmm1,%xmm2
        mulps   %xmm1,%xmm1
        movaps  nb234nf_three(%rsp),%xmm3
        mulps   nb234nf_rsqMM(%rsp),%xmm1
        subps   %xmm1,%xmm3
        mulps   %xmm2,%xmm3
        mulps   nb234nf_half(%rsp),%xmm3
        movaps  %xmm3,nb234nf_rinvMM(%rsp)

        ## start with OO LJ interaction
        movaps nb234nf_rinvOO(%rsp),%xmm0
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqOO(%rsp),%xmm1   ## xmm1=r 
        mulps  nb234nf_tsc(%rsp),%xmm1

        movhlps %xmm1,%xmm2
    cvttps2pi %xmm1,%mm6
    cvttps2pi %xmm2,%mm7    ## mm6/mm7 contain lu indices 
    cvtpi2ps %mm6,%xmm3
    cvtpi2ps %mm7,%xmm2
        movlhps  %xmm2,%xmm3
        subps    %xmm3,%xmm1    ## xmm1=eps 
    movaps %xmm1,%xmm2
    mulps  %xmm2,%xmm2      ## xmm2=eps2 
    pslld $3,%mm6
    pslld $3,%mm7

    movd %mm6,%eax
    psrlq $32,%mm6
    movd %mm7,%ecx
    psrlq $32,%mm7
    movd %mm6,%ebx
    movd %mm7,%edx

    movq nb234nf_VFtab(%rbp),%rsi

    ## dispersion 
    movlps (%rsi,%rax,4),%xmm5
    movlps (%rsi,%rcx,4),%xmm7
    movhps (%rsi,%rbx,4),%xmm5
    movhps (%rsi,%rdx,4),%xmm7 ## got half table 

    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 8(%rsi,%rax,4),%xmm7
    movlps 8(%rsi,%rcx,4),%xmm3
    movhps 8(%rsi,%rbx,4),%xmm7
    movhps 8(%rsi,%rdx,4),%xmm3    ## other half of table  
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## dispersion table ready, in xmm4-xmm7 
    mulps  %xmm1,%xmm6      ## xmm6=Geps 
    mulps  %xmm2,%xmm7      ## xmm7=Heps2 
    addps  %xmm6,%xmm5
    addps  %xmm7,%xmm5      ## xmm5=Fp 
    mulps  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addps  %xmm4,%xmm5 ## xmm5=VV 

    movaps nb234nf_c6(%rsp),%xmm4
    mulps  %xmm4,%xmm5   ## Vvdw6 

    addps  nb234nf_Vvdwtot(%rsp),%xmm5
    movaps %xmm5,nb234nf_Vvdwtot(%rsp)

    ## repulsion 
    movlps 16(%rsi,%rax,4),%xmm5
    movlps 16(%rsi,%rcx,4),%xmm7
    movhps 16(%rsi,%rbx,4),%xmm5
    movhps 16(%rsi,%rdx,4),%xmm7    ## got half table 

    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 24(%rsi,%rax,4),%xmm7
    movlps 24(%rsi,%rcx,4),%xmm3
    movhps 24(%rsi,%rbx,4),%xmm7
    movhps 24(%rsi,%rdx,4),%xmm3    ## other half of table  
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## repulsion table ready, in xmm4-xmm7 
    mulps  %xmm1,%xmm6      ## xmm6=Geps 
    mulps  %xmm2,%xmm7      ## xmm7=Heps2 
    addps  %xmm6,%xmm5
    addps  %xmm7,%xmm5      ## xmm5=Fp 
    mulps  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addps  %xmm4,%xmm5 ## xmm5=VV 

    movaps nb234nf_c12(%rsp),%xmm4
    mulps  %xmm4,%xmm5 ## Vvdw12 

    addps  nb234nf_Vvdwtot(%rsp),%xmm5
    movaps %xmm5,nb234nf_Vvdwtot(%rsp)

        ## Coulomb interactions 
        ## start with H1-H1 interaction 
        movaps nb234nf_rinvH1H1(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        mulps  nb234nf_rsqH1H1(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm6
        mulps  nb234nf_qqHH(%rsp),%xmm6   ## xmm6=voul=qq*(rinv+ krsq-crf) 
        addps  nb234nf_vctot(%rsp),%xmm6   ## local vctot summation variable 

        ## H1-H2 interaction 
        movaps nb234nf_rinvH1H2(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqH1H2(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps  %xmm0,%xmm0
        mulps  nb234nf_qqHH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## H1-M interaction  
        movaps nb234nf_rinvH1M(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=Rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqH1M(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqMH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## H2-H1 interaction 
        movaps nb234nf_rinvH2H1(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqH2H1(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqHH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## H2-H2 interaction 
        movaps nb234nf_rinvH2H2(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqH2H2(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqHH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## H2-M interaction 
        movaps nb234nf_rinvH2M(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqH2M(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqMH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## M-H1 interaction 
        movaps nb234nf_rinvMH1(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqMH1(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqMH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## M-H2 interaction 
        movaps nb234nf_rinvMH2(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqMH2(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqMH(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 

        ## M-M interaction 
        movaps nb234nf_rinvMM(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        movaps %xmm0,%xmm1
        mulps  nb234nf_rsqMM(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm4
        addps  %xmm7,%xmm4      ## xmm4=r inv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm4
        mulps %xmm0,%xmm0
        mulps  nb234nf_qqMM(%rsp),%xmm4   ## xmm4=voul=qq*(rinv+ krsq-crf) 
        addps  %xmm4,%xmm6      ## add to local vctot 
        movaps %xmm6,nb234nf_vctot(%rsp)

        ## should we do one more iteration? 
        subl $4,nb234nf_innerk(%rsp)
        jl    _nb_kernel234nf_x86_64_sse.nb234nf_single_check
        jmp   _nb_kernel234nf_x86_64_sse.nb234nf_unroll_loop
_nb_kernel234nf_x86_64_sse.nb234nf_single_check: 
        addl $4,nb234nf_innerk(%rsp)
        jnz   _nb_kernel234nf_x86_64_sse.nb234nf_single_loop
        jmp   _nb_kernel234nf_x86_64_sse.nb234nf_updateouterdata
_nb_kernel234nf_x86_64_sse.nb234nf_single_loop: 
        movq  nb234nf_innerjjnr(%rsp),%rdx      ## pointer to jjnr[k] 
        movl  (%rdx),%eax
        addq $4,nb234nf_innerjjnr(%rsp)

        movq nb234nf_pos(%rbp),%rsi
        lea  (%rax,%rax,2),%rax

        ## fetch j coordinates
        movlps (%rsi,%rax,4),%xmm3              ##  Ox  Oy  
        movlps 16(%rsi,%rax,4),%xmm4            ## H1y H1z 
        movlps 32(%rsi,%rax,4),%xmm5            ## H2z  Mx 
        movhps 8(%rsi,%rax,4),%xmm3             ##  Ox  Oy  Oz H1x
        movhps 24(%rsi,%rax,4),%xmm4            ## H1y H1z H2x H2y
        movhps 40(%rsi,%rax,4),%xmm5            ## H2z  Mx  My  Mz
        ## transpose
        movaps %xmm4,%xmm0
        movaps %xmm3,%xmm1
        movaps %xmm4,%xmm2
        movaps %xmm3,%xmm6
        shufps $18,%xmm5,%xmm4 ## (00010010)  h2x - Mx  - 
        shufps $193,%xmm0,%xmm3 ## (11000001)  Oy  - H1y - 
        shufps $35,%xmm5,%xmm2 ## (00100011) H2y - My  - 
        shufps $18,%xmm0,%xmm1 ## (00010010)  Oz  - H1z - 
        ##  xmm6: Ox - - H1x   xmm5: H2z - - Mz 
        shufps $140,%xmm4,%xmm6 ## (10001100) Ox H1x H2x Mx 
        shufps $136,%xmm2,%xmm3 ## (10001000) Oy H1y H2y My 
        shufps $200,%xmm5,%xmm1 ## (11001000) Oz H1z H2z Mz

        ## store all j coordinates in jO  
        movaps %xmm6,nb234nf_jxO(%rsp)
        movaps %xmm3,nb234nf_jyO(%rsp)
        movaps %xmm1,nb234nf_jzO(%rsp)

        ## do O and M in parallel
        movaps nb234nf_ixO(%rsp),%xmm0
        movaps nb234nf_iyO(%rsp),%xmm1
        movaps nb234nf_izO(%rsp),%xmm2
        movaps nb234nf_ixM(%rsp),%xmm3
        movaps nb234nf_iyM(%rsp),%xmm4
        movaps nb234nf_izM(%rsp),%xmm5
        subps  nb234nf_jxO(%rsp),%xmm0
        subps  nb234nf_jyO(%rsp),%xmm1
        subps  nb234nf_jzO(%rsp),%xmm2
        subps  nb234nf_jxO(%rsp),%xmm3
        subps  nb234nf_jyO(%rsp),%xmm4
        subps  nb234nf_jzO(%rsp),%xmm5

        mulps %xmm0,%xmm0
        mulps %xmm1,%xmm1
        mulps %xmm2,%xmm2
        addps %xmm1,%xmm0
        addps %xmm2,%xmm0       ## have rsq in xmm0 
        mulps %xmm3,%xmm3
        mulps %xmm4,%xmm4
        mulps %xmm5,%xmm5
        addps %xmm3,%xmm4
        addps %xmm5,%xmm4       ## have rsq in xmm4
        ## Save data 
        movaps %xmm0,nb234nf_rsqOO(%rsp)
        movaps %xmm4,nb234nf_rsqMM(%rsp)

        ## do 1/x for O
        rsqrtps %xmm0,%xmm1
        movaps  %xmm1,%xmm2
        mulps   %xmm1,%xmm1
        movaps  nb234nf_three(%rsp),%xmm3
        mulps   %xmm0,%xmm1     ## rsq*lu*lu 
        subps   %xmm1,%xmm3     ## constant 30-rsq*lu*lu 
        mulps   %xmm2,%xmm3     ## lu*(3-rsq*lu*lu) 
        mulps   nb234nf_half(%rsp),%xmm3
        movaps  %xmm3,nb234nf_rinvOO(%rsp)      ## rinvH2 

        ## 1/sqrt(x) for M
        rsqrtps %xmm4,%xmm5
        movaps  %xmm5,%xmm6
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm7
        mulps   %xmm4,%xmm5
        subps   %xmm5,%xmm7
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm7   ## rinv iH1 - j water 
        movaps %xmm7,nb234nf_rinvMM(%rsp)


        ## LJ table interaction
        movaps nb234nf_rinvOO(%rsp),%xmm0
        movss %xmm0,%xmm1
        mulss  nb234nf_rsqOO(%rsp),%xmm1   ## xmm1=r 
        mulss  nb234nf_tsc(%rsp),%xmm1

    cvttps2pi %xmm1,%mm6
    cvtpi2ps %mm6,%xmm3
        subss    %xmm3,%xmm1    ## xmm1=eps 
    movss %xmm1,%xmm2
    mulss  %xmm2,%xmm2      ## xmm2=eps2 
    pslld $3,%mm6

    movq nb234nf_VFtab(%rbp),%rsi
    movd %mm6,%r8d

    ## dispersion 
    movlps (%rsi,%r8,4),%xmm5
    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 8(%rsi,%r8,4),%xmm7
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## dispersion table ready, in xmm4-xmm7 
    mulss  %xmm1,%xmm6      ## xmm6=Geps 
    mulss  %xmm2,%xmm7      ## xmm7=Heps2 
    addss  %xmm6,%xmm5
    addss  %xmm7,%xmm5      ## xmm5=Fp 
    mulss  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addss  %xmm4,%xmm5 ## xmm5=VV 

    movss nb234nf_c6(%rsp),%xmm4
    mulss  %xmm4,%xmm5   ## Vvdw6 

    addss  nb234nf_Vvdwtot(%rsp),%xmm5
    movss %xmm5,nb234nf_Vvdwtot(%rsp)

    ## repulsion 
    movlps 16(%rsi,%rax,4),%xmm5
    movaps %xmm5,%xmm4
    shufps $136,%xmm7,%xmm4 ## constant 10001000
    shufps $221,%xmm7,%xmm5 ## constant 11011101

    movlps 24(%rsi,%rax,4),%xmm7
    movaps %xmm7,%xmm6
    shufps $136,%xmm3,%xmm6 ## constant 10001000
    shufps $221,%xmm3,%xmm7 ## constant 11011101
    ## table ready, in xmm4-xmm7 
    mulss  %xmm1,%xmm6      ## xmm6=Geps 
    mulss  %xmm2,%xmm7      ## xmm7=Heps2 
    addss  %xmm6,%xmm5
    addss  %xmm7,%xmm5      ## xmm5=Fp 
    mulss  %xmm1,%xmm5 ## xmm5=eps*Fp 
    addss  %xmm4,%xmm5 ## xmm5=VV 

    movss nb234nf_c12(%rsp),%xmm4
    mulss  %xmm4,%xmm5 ## Vvdw12 
    addss  nb234nf_Vvdwtot(%rsp),%xmm5
    movss %xmm5,nb234nf_Vvdwtot(%rsp)

        ## do  M coulomb interaction
        movaps nb234nf_rinvMM(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234nf_qqMH(%rsp),%xmm3
        movhps  nb234nf_qqMM(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234nf_rsqMM(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 
        addps  nb234nf_vctot(%rsp),%xmm6
        movaps %xmm6,nb234nf_vctot(%rsp)

        ## i H1 & H2 simultaneously first get i particle coords: 
        movaps  nb234nf_ixH1(%rsp),%xmm0
        movaps  nb234nf_iyH1(%rsp),%xmm1
        movaps  nb234nf_izH1(%rsp),%xmm2
        movaps  nb234nf_ixH2(%rsp),%xmm3
        movaps  nb234nf_iyH2(%rsp),%xmm4
        movaps  nb234nf_izH2(%rsp),%xmm5
        subps   nb234nf_jxO(%rsp),%xmm0
        subps   nb234nf_jyO(%rsp),%xmm1
        subps   nb234nf_jzO(%rsp),%xmm2
        subps   nb234nf_jxO(%rsp),%xmm3
        subps   nb234nf_jyO(%rsp),%xmm4
        subps   nb234nf_jzO(%rsp),%xmm5
        mulps %xmm0,%xmm0
        mulps %xmm1,%xmm1
        mulps %xmm2,%xmm2
        mulps %xmm3,%xmm3
        mulps %xmm4,%xmm4
        mulps %xmm5,%xmm5
        addps %xmm1,%xmm0
        addps %xmm3,%xmm4
        addps %xmm2,%xmm0       ## have rsqH1 in xmm0 
        addps %xmm5,%xmm4       ## have rsqH2 in xmm4 
        movaps  %xmm0,nb234nf_rsqH1H1(%rsp)
        movaps  %xmm4,nb234nf_rsqH2H2(%rsp)

        ## start doing invsqrt use rsq values in xmm0, xmm4 
        rsqrtps %xmm0,%xmm1
        rsqrtps %xmm4,%xmm5
        movaps  %xmm1,%xmm2
        movaps  %xmm5,%xmm6
        mulps   %xmm1,%xmm1
        mulps   %xmm5,%xmm5
        movaps  nb234nf_three(%rsp),%xmm3
        movaps  %xmm3,%xmm7
        mulps   %xmm0,%xmm1
        mulps   %xmm4,%xmm5
        subps   %xmm1,%xmm3
        subps   %xmm5,%xmm7
        mulps   %xmm2,%xmm3
        mulps   %xmm6,%xmm7
        mulps   nb234nf_half(%rsp),%xmm3   ## rinvH1H1
        mulps   nb234nf_half(%rsp),%xmm7   ## rinvH2H2
        movaps  %xmm3,nb234nf_rinvH1H1(%rsp)
        movaps  %xmm7,nb234nf_rinvH2H2(%rsp)

        ## Do H1 coulomb interaction
        movaps nb234nf_rinvH1H1(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234nf_qqHH(%rsp),%xmm3
        movhps  nb234nf_qqMH(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234nf_rsqH1H1(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 
        addps  nb234nf_vctot(%rsp),%xmm6
        movaps %xmm6,nb234nf_vctot(%rsp)

        ## H2 Coulomb
        movaps nb234nf_rinvH2H2(%rsp),%xmm0
        movaps %xmm0,%xmm7      ## xmm7=rinv 
        movaps nb234nf_krf(%rsp),%xmm5
        mulps  %xmm0,%xmm0      ## xmm0=rinvsq 

        ## fetch charges to xmm3 (temporary) 
        xorps  %xmm3,%xmm3
        movss   nb234nf_qqHH(%rsp),%xmm3
        movhps  nb234nf_qqMH(%rsp),%xmm3
        shufps $193,%xmm3,%xmm3 ## constant 11000001 

        mulps  nb234nf_rsqH2H2(%rsp),%xmm5   ## xmm5=krsq 
        movaps %xmm5,%xmm6
        addps  %xmm7,%xmm6      ## xmm6=rinv+ krsq 
        subps  nb234nf_crf(%rsp),%xmm6
        mulps  %xmm3,%xmm6 ## xmm6=voul=qq*(rinv+ krsq-crf) 

        addps  nb234nf_vctot(%rsp),%xmm6   ## local vctot summation variable
        movaps %xmm6,nb234nf_vctot(%rsp)

        decl nb234nf_innerk(%rsp)
        jz    _nb_kernel234nf_x86_64_sse.nb234nf_updateouterdata
        jmp   _nb_kernel234nf_x86_64_sse.nb234nf_single_loop
_nb_kernel234nf_x86_64_sse.nb234nf_updateouterdata: 
        ## get n from stack
        movl nb234nf_n(%rsp),%esi
        ## get group index for i particle 
        movq  nb234nf_gid(%rbp),%rdx            ## base of gid[]
        movl  (%rdx,%rsi,4),%edx                ## ggid=gid[n]

        ## accumulate total potential energy and update it 
        movaps nb234nf_vctot(%rsp),%xmm7
        ## accumulate 
        movhlps %xmm7,%xmm6
        addps  %xmm6,%xmm7      ## pos 0-1 in xmm7 have the sum now 
        movaps %xmm7,%xmm6
        shufps $1,%xmm6,%xmm6
        addss  %xmm6,%xmm7

        ## add earlier value from mem 
        movq  nb234nf_Vc(%rbp),%rax
        addss (%rax,%rdx,4),%xmm7
        ## move back to mem 
        movss %xmm7,(%rax,%rdx,4)

        ## accumulate total lj energy and update it 
        movaps nb234nf_Vvdwtot(%rsp),%xmm7
        ## accumulate 
        movhlps %xmm7,%xmm6
        addps  %xmm6,%xmm7      ## pos 0-1 in xmm7 have the sum now 
        movaps %xmm7,%xmm6
        shufps $1,%xmm6,%xmm6
        addss  %xmm6,%xmm7

        ## add earlier value from mem 
        movq  nb234nf_Vvdw(%rbp),%rax
        addss (%rax,%rdx,4),%xmm7
        ## move back to mem 
        movss %xmm7,(%rax,%rdx,4)

        ## finish if last 
        movl nb234nf_nn1(%rsp),%ecx
        ## esi already loaded with n
        incl %esi
        subl %esi,%ecx
        jz _nb_kernel234nf_x86_64_sse.nb234nf_outerend

        ## not last, iterate outer loop once more!  
        movl %esi,nb234nf_n(%rsp)
        jmp _nb_kernel234nf_x86_64_sse.nb234nf_outer
_nb_kernel234nf_x86_64_sse.nb234nf_outerend: 
        ## check if more outer neighborlists remain
        movl  nb234nf_nri(%rsp),%ecx
        ## esi already loaded with n above
        subl  %esi,%ecx
        jz _nb_kernel234nf_x86_64_sse.nb234nf_end
        ## non-zero, do one more workunit
        jmp   _nb_kernel234nf_x86_64_sse.nb234nf_threadloop
_nb_kernel234nf_x86_64_sse.nb234nf_end: 
        movl nb234nf_nouter(%rsp),%eax
        movl nb234nf_ninner(%rsp),%ebx
        movq nb234nf_outeriter(%rbp),%rcx
        movq nb234nf_inneriter(%rbp),%rdx
        movl %eax,(%rcx)
        movl %ebx,(%rdx)

        addq $1000,%rsp
        emms


        pop %r15
        pop %r14
        pop %r13
        pop %r12

        pop %rbx
        pop    %rbp
        ret




