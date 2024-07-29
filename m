Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F545C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 22:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8403588896;
	Tue, 30 Jul 2024 00:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VUdcA2gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4FDA888A4; Tue, 30 Jul 2024 00:27:17 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A74A88804
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 00:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-75a6c290528so2434583a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722292033; x=1722896833; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=427PCvKR47EVwP8uSo/NBRaCOfh0C3ndEtYNFptnQY8=;
 b=VUdcA2glNLlPjv5umIHmvT69NxbZs8HhCSp/r0b7VW53EEpPx626XXIoJPAUCJ5n0W
 LagFG18Xh6FsEtflnw7ZZRV7giA2lMMcerO+mLz9tgCSn9r06F9qcqQNroFXZzmSmUh6
 WQ1rxA/YMz0fRRtHfRTrxLwE6JbQQnJBnEubjQIIt/ByL+ktZbKdG8qkrsE+vJjcOh3Z
 YENwm+I0zzR6m762H50eGX2Q6vVvZkrwuxQbMj9dMmxyr81IJFyeWpBt0KJCPMsDfx8T
 8EPYVgZaR/uzTvyJpXgPY1Z+1swfILUvBVPYaaMUsnOWD2Ssy8fWcaP5bWOFwUgoxWwY
 kwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722292033; x=1722896833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=427PCvKR47EVwP8uSo/NBRaCOfh0C3ndEtYNFptnQY8=;
 b=O9z8PTEMtIR26v44/AUB9A1B5vk1XZQXLwaXm49m3CWiZfx/oKsz5E9i42lTbuMQCW
 NFw5ben2IlszM72TjYbbQkW9x/HeuRCC4DSKHgdH/0McH+fWqwi9KHOgFr8DAXplbMwV
 J6gwFfZhgROywDAbLywbg/ud3Zwi4sBR3QgT1NashDxe/2P8tbGHw76NRy6c9rdTDwsf
 OHkB9xjEoFoXSOG4is4mmkb+U2I53iBIMdPtJ/Zx8M1BzA8iktQchYPvr5LhPEQXBoqO
 eaK2P81QVEq/667RzHTCxP/Orzz51T61SCHtpGoYfiLi+mu9EFlRvwvj4qdeUg6+Dy0M
 ygCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLKydBHBNArgnPc+7YMAcCAKUxd7bVXYArh5OZoCRo9G8UGaRL4THus7+wyaTh6K/rVfa1hNNECKWFUE2sjey9ZtfJUA==
X-Gm-Message-State: AOJu0YwXjDlq84crsyzInqDO/gVPU0yQrL0e5o3s2lMAoCHAMTWVrqKT
 U40sMFYtNLXZVMo2KBSLxA8KiLHTPG7FPhz8M9ODwCsLhTq6n1AZVFMIUlZahHwo6u+FPJDup+n
 Z4xPYiFOlj43FB1dNggat507Uo88=
X-Google-Smtp-Source: AGHT+IFaWklSURYctf+BE+YWYFiY9pJnjRfwB5ILIwT5bLMqz5H5VvqbIAJ5ARIXehkyk9hIaOLm0RALI0Dd/GxsiUw=
X-Received: by 2002:a17:90a:4bc6:b0:2c9:a3ca:cc98 with SMTP id
 98e67ed59e1d1-2cf7e09cdcdmr6718935a91.7.1722292033280; Mon, 29 Jul 2024
 15:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
 <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
 <CAN8Q1Ed+T5JKAqD4vwXSZs3CGF6ockiNF5XCJfg3m9NXY=kZuA@mail.gmail.com>
In-Reply-To: <CAN8Q1Ed+T5JKAqD4vwXSZs3CGF6ockiNF5XCJfg3m9NXY=kZuA@mail.gmail.com>
From: Peter LaDow <pladow@gmail.com>
Date: Mon, 29 Jul 2024 15:27:02 -0700
Message-ID: <CAN8Q1EcBxsRzUxL+_Ofi0-erTLj1TcKCPwrLq1eH2CFmLHozug@mail.gmail.com>
Subject: Re: M68K Vectors
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Huan Wang <alison.wang@nxp.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A bit more digging.

I compiled common/init/board_init.c with -S to look at the generated
assembly.  I note the calls to memset are generated very differently.

For the -mcpu=3D5329 case:

       move.l memset@GOT(%a5),%a0
       ... (trimmed)
       jsr (%a0)

But for the -mcpu=3D548x case:

        bsr.l memset@PLTPC

So the 5329 is using the global offsets table, but the 548x is using
the procedure linkage table.  Now, my understanding of the GOT vs PLT
is not the best.  But IIRC, the PLT is a small trampoline to the
actual function, whereas the GOT is a list of offsets.  And it seems
the generated code for the 5329 is correct.  The final assembly loads
A5 with 0x40500, which maps to __got_start.

But the 548x is using the PLT.  But from what I remember about the PLT
trampoline code, it needs to be writable in order to write fixups as
the symbols are finalized.  Of course, this in flash, so that won't
work.  I tried using -fno-plt, but it still emits PLT relocations.
For some reason, the 548x uses only PLT32 relocations.

I also tried the M5272C3, M5235EVB, and amcore (MCF530x based), which
generate GOT160 relocations.  But the stmark2 (which uses the MCF5441x
cpu), does generate PLT32 relocations.  I do note, however, that
INITPC is populated with the correct offset, so the vectors here are
correct.  But I have no way to validate if the PLT link code works, as
I don't know about the system architecture.






On Mon, Jul 29, 2024 at 7:58=E2=80=AFAM Peter LaDow <pladow@gmail.com> wrot=
e:
>
> I tried both the gcc-12.2 and the gcc-14.1, and both exhibit the same
> problem I am seeing.  And I tried it with the M5373EVB which is
> included w/ u-boot.
>
> From the arch/m68k/cpu/mcf530x/start.S:
>
> _vectors:
> .long   0x00000000
> #if defined(CONFIG_M5307) && \
>           (CONFIG_TEXT_BASE =3D=3D CFG_SYS_INT_FLASH_BASE)
> .long   _start - CONFIG_TEXT_BASE
> #else
> .long   _START
> #endif
>
> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
>
> $ m68k-linux-objdump -s u-boot
> u-boot:     file format elf32-m68k
>
> Contents of section .text:
> 00000 00000000 00000000 0000050c 0000050c  ................
> 00010 0000050c 0000050c 0000050c 0000050c  ................
>
> Note the reset vector at offset 0x4 is 0x00000000, when it should be
> 0x00000400.  This is true in both cases.  But _start (and _START which
> is #defined to _start above)
>
> $ m68k-linux-nm -n u-boot
> 00000000 A __fixup_entries
> 00000000 A __got2_entries
> 00000000 t INITSP
> 00000000 t _vectors
> 00000004 t INITPC
> 00000008 t vector02_0F
> 00000040 t vector10_17
> 00000060 t vector18_1F
> 00000080 t vector20_2F
> 000000c0 t vector30_3F
> 00000100 t vector64_127
> 00000200 t vector128_191
> 00000300 t vector192_255
> 00000400 T _start
>
> So even here we see the _start relocation not set correctly.
>
> However, I do notice something very different in how board_init.c is
> compiled.  The M5373EVB compiles with what appear to be some sort of
> trampolines.
>
> From the 5373 (compiled with -mcpu=3D5329):
>
> 000114fe <board_init_f_init_reserve>:
>   114fe:       2f0d            movel %a5,%sp@-
>   11500:       206d 00a0       moveal %a5@(160),%a0
>   11504:       2f02            movel %d2,%sp@-
>   11506:       242f 000c       movel %sp@(12),%d2
>   1150a:       4878 00c0       pea c0 <vector30_3F>
>   1150e:       42a7            clrl %sp@-
>   11510:       2f02            movel %d2,%sp@-
>   11512:       4e90            jsr %a0@
>
> Notice at 0x11500 it loads %a0 with an offset from %a5.  And in
> _start, it loads %a5 with __got_start.  So some sort of global
> relocation table is used to call memset.
>
> But for my board, compiled with the exact same options except -mcpu=3D548=
x, I get:
>
> 0000f5da <board_init_f_init_reserve>:
>    f5da:       2f02            movel %d2,%sp@-
>    f5dc:       242f 0008       movel %sp@(8),%d2
>    f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
>    f5e4:       42a7            clrl %sp@-
>    f5e6:       2f02            movel %d2,%sp@-
>    f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
>
> Which is a relative branch (bsrl).
>
> The compilation command line is identical except for -mcpu.  Even the
> linker command line is identical except for paths to the object files.
>
> On Sun, Jul 28, 2024 at 2:04=E2=80=AFPM Angelo Dureghello
> <angelo@kernel-space.org> wrote:
> >
> > Hi Peter,
> >
> > glad to hear you solved.
> >
> > As a toolchain i use those provided by kernel.org:
> >
> > /opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-
> >
> > https://cdn.kernel.org/pub/tools/crosstool/
> >
> > Just out of curiosity, what's the cpu model you used ?
> >
> >
> > Regards,
> > Angelo Dureghello
> >
> >
> > On 26/07/24 10:22 PM, Peter LaDow wrote:
> > > Scratch that.  I forgot I hard coded the vector table with 0x400 to
> > > test things.  Restoring _start still results in 0x00000000 for the
> > > reset vector.
> > >
> > > On Fri, Jul 26, 2024 at 1:16=E2=80=AFPM Peter LaDow <pladow@gmail.com=
> wrote:
> > >> I should mention I was using the gcc-m68k-linux-gnu package on Ubunt=
u
> > >> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
> > >>
> > >> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-=
1,
> > >> and tried that.  It generates the proper value in the vector table
> > >> (0x400 for _start).  But the call to memset is still bad:
> > >>
> > >> 0000f5da <board_init_f_init_reserve>:
> > >>     f5da:       2f02            movel %d2,%sp@-
> > >>     f5dc:       242f 0008       movel %sp@(8),%d2
> > >>     f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
> > >>     f5e4:       42a7            clrl %sp@-
> > >>     f5e6:       2f02            movel %d2,%sp@-
> > >>     f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
> > >>     f5ee:       2f02            movel %d2,%sp@-
> > >>     f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
> > >>     f5f6:       0682 0000 00c0  addil #192,%d2
> > >>     f5fc:       4fef 0010       lea %sp@(16),%sp
> > >>     f600:       2047            moveal %d7,%a0
> > >>     f602:       2142 00a0       movel %d2,%a0@(160)
> > >>     f606:       241f            movel %sp@+,%d2
> > >>     f608:       4e75            rts
> > >>
> > >> Note "bsrl 23c0c" which points beyond _etext.
> > >>
> > >> On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Fabio Estevam <festevam@gma=
il.com> wrote:
> > >>> Adding the Coldfire maintainers on Cc.
> > >>>
> > >>> On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.c=
om> wrote:
> > >>>> After some digging it appears that this is a toolchain issue.  It =
seems the
> > >>>> linker fixups are sometimes not computed correctly.  For example, =
in
> > >>>> board_init_f_init_reserve, the object file disassembled has:
> > >>>>
> > >>>> 00000000 <board_init_f_init_reserve>:
> > >>>>    0:   2f02            movel %d2,%sp@-
> > >>>>    2:   242f 0008       movel %sp@(8),%d2
> > >>>>    6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
> > >>>>    a:   42a7            clrl %sp@-
> > >>>>    c:   2f02            movel %d2,%sp@-
> > >>>>    e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
> > >>>>   14:   2f02            movel %d2,%sp@-
> > >>>>   16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
> > >>>>   1c:   0682 0000 00c0  addil #192,%d2
> > >>>>   22:   4fef 0010       lea %sp@(16),%sp
> > >>>>   26:   2047            moveal %d7,%a0
> > >>>>   28:   2142 00a0       movel %d2,%a0@(160)
> > >>>>   2c:   241f            movel %sp@+,%d2
> > >>>>   2e:   4e75            rts
> > >>>>
> > >>>> But when I disassemble the final linked u-boot output:
> > >>>>
> > >>>> 0000f646 <board_init_f_init_reserve>:
> > >>>>     f646:       2f02            movel %d2,%sp@-
> > >>>>     f648:       242f 0008       movel %sp@(8),%d2
> > >>>>     f64c:       4878 00c0       pea c0 <_vectors+0xc0>
> > >>>>     f650:       42a7            clrl %sp@-
> > >>>>     f652:       2f02            movel %d2,%sp@-
> > >>>>     f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
> > >>>>     f65a:       2f02            movel %d2,%sp@-
> > >>>>     f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
> > >>>>     f662:       0682 0000 00c0  addil #192,%d2
> > >>>>     f668:       4fef 0010       lea %sp@(16),%sp
> > >>>>     f66c:       2047            moveal %d7,%a0
> > >>>>     f66e:       2142 00a0       movel %d2,%a0@(160)
> > >>>>     f672:       241f            movel %sp@+,%d2
> > >>>>     f674:       4e75            rts
> > >>>>
> > >>>> Note the pea c0 instruction.  The object file has
> > >>>> board_init_f_init_reserve+0xc0 as the argument, but the final link=
er has
> > >>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after li=
nking.
> > >>>>
> > >>>> Also, note the first bsrl instruction, which is not setup correctl=
y
> > >>>> either.  This is a call to memset.  This points to _etext+0x138, w=
hich is
> > >>>> not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in t=
he final
> > >>>> uboot, memset is at 0x1f030.
> > >>>>
> > >>>> In the call to memset(),  objdump shows the relocation:
> > >>>>
> > >>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> > >>>> OFFSET   TYPE              VALUE
> > >>>> 00000010 R_68K_PLT32       memset
> > >>>> 00000018 R_68K_PLT32       arch_setup_gd
> > >>>>
> > >>>> So it seems only when linking outside the same compilation unit th=
at the
> > >>>> relocations aren't set correctly.
> > >>>>
> > >>>> I'm not sure where to look for a solution.  Or how to search for a=
n
> > >>>> answer.  I've done some digging on Google, but nothing points to a=
 clear
> > >>>> answer.  Anyone seen something similar?
> > >>>>
> > >>>> To love for the sake of being loved is human, but to love for the =
sake of
> > >>>> loving is angelic. -- Alphonse de Lamartine.
> > >>>>
> > >>>>
> > >>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote=
:
> > >>>>> I'm trying to add support for a custom Colfire based board.  I ha=
ve
> > >>>>> things building, but the final linked vectors in start.S do not p=
oint
> > >>>>> to _start.  In start.S I have:
> > >>>>>
> > >>>>> _vectors:
> > >>>>> .long   0x00000000              /* Flash offset is 0 until we set=
up CS0 */
> > >>>>> .long   _START
> > >>>>>
> > >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> > >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> > >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> > >>>>>
> > >>>>> Dumping the symbols in the final u-boot yields:
> > >>>>>
> > >>>>> $ m68k-linux-gnu-nm -n u-boot
> > >>>>> 00000000 A __fixup_entries
> > >>>>> 00000000 A __got2_entries
> > >>>>> 00000000 t _vectors
> > >>>>> 00000400 T _start
> > >>>>> 0000047e T relocate_code
> > >>>>> 000004ae t fixloop
> > >>>>>
> > >>>>> But then dumping the raw binary:
> > >>>>>
> > >>>>> u-boot:     file format elf32-m68k
> > >>>>>
> > >>>>> Contents of section .text:
> > >>>>> 00000 00000000 00000000 00000516 00000516  ................
> > >>>>> 00010 00000516 00000516 00000516 00000516  ................
> > >>>>> 00020 00000516 00000516 00000516 00000516  ................
> > >>>>> 00030 00000516 00000516 00000516 00000516  ................
> > >>>>>
> > >>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> > >>>>>
> > >>>>> The final linker script has:
> > >>>>>
> > >>>>> OUTPUT_ARCH(m68k)
> > >>>>> ENTRY(_start)
> > >>>>> SECTIONS
> > >>>>> {
> > >>>>> .text :
> > >>>>> {
> > >>>>>   arch/m68k/cpu/mcf548x/start.o (.text*)
> > >>>>>   . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.tex=
t*);
> > >>>>>   *(.text*)
> > >>>>> }
> > >>>>>
> > >>>>>
> > >>>>> It is difficult to search the archives, and so far I haven't foun=
d
> > >>>>> anything.  Any help would be appreciated.
> > >>>>>
> > >>>>> --
> > >>>>> To love for the sake of being loved is human, but to love for the=
 sake
> > >>>>> of loving is angelic. -- Alphonse de Lamartine.
> > >>
> > >>
> > >> --
> > >> To love for the sake of being loved is human, but to love for the sa=
ke
> > >> of loving is angelic. -- Alphonse de Lamartine.
> > >
> > >
>
>
>
> --
> To love for the sake of being loved is human, but to love for the sake
> of loving is angelic. -- Alphonse de Lamartine.



--
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
