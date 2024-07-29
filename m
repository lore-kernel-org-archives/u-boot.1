Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA49C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 14:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBFF887D1;
	Mon, 29 Jul 2024 16:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuABNggh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A196887EB; Mon, 29 Jul 2024 16:59:05 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60588885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 16:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso21448695ad.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722265141; x=1722869941; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DiergR9WN8hHDH+PPLtTxoMZ5BIy3ewdoEAnni0tnE=;
 b=YuABNgghwwTdvvHZPMWVg9QiDzD8hKyVecHISiRx6ibyOov6LKgVdWgwQRqxCpHywR
 8kM+eSgbCFHj3/030b7SYtGpkBg+1cVLFcnTugQ8T/ELYzVSVS35hAG3nfmcUC63vnYt
 5Pi1W+5SAvl4C3VQbRIc653uzEipLCEoW2u3DUyTJBUX+s7r2MEfbskGBKEgWlHFTtRx
 kspzf90oE2DDYxuVlUHZP41QDtVnAMn6fqwfIuJjqCRY59EvV7J00O1ZPjVwnpSY/eo/
 p1QC20q9jiLQPquOV4eqk0D2C/p3hEELf1gE8xCJTzx6qdyaqZrXJYG2Jg9MFD507c8r
 ylwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722265141; x=1722869941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DiergR9WN8hHDH+PPLtTxoMZ5BIy3ewdoEAnni0tnE=;
 b=T6efx7iqaNJKNRzSiPLIIayu7U+yu+Vt7Pjk0vgox2Xz9oUQjRbkFBnilOYWhjLlwK
 QYAmaAyn7t68WSzvaaZR59c4eg/4QaxLxmX2nlRzMA1CzNKURHmPdIE6sJT4xNR3sc/s
 sQlc668HorZ54j/lSNvl9uxwECwvJ60SzypUpiYiGVxHielLINlMeT6aJs3mNlW8Nun+
 vPgyib+ov9aluBbJYlTgXbIQZF79Dri5bRbnX/fd3BDAifWQe3iWdQpeogETNau6IcI8
 eGV5nlbWFIagsPVIDrR1rHdD3DbW+ZdY7yJcMZTVMxVLU4N9NujOwf383HO/uaCKGwnJ
 MXcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH0HRQNaM6a0McZcL4XGyIEnmC+jQWTh2gDJ1i6f4Y5nX2W3FFwarc0TgXfdwsiCjBa6ojH+Z/rESRG2CAEovn4T1q5A==
X-Gm-Message-State: AOJu0Ywv6GRvxLoLyCZ9I+tyDVAX6GcKfnrfuT2ON/GNHSO2Hjv1ZPWt
 kOHiE1NfudpS8siramVgPFo8lrdotudpTms6L0e2SYTyet/PjmPyEwLs0O3u8zXMqR4Yzdo+utg
 42u48qXdhU9j3ELow/LTK+7GrIGc=
X-Google-Smtp-Source: AGHT+IGQpcgEfhxo2SClt45ZuX0/55ZpSPPeW9CjGXuPvzRkQ8pPdD8p+N+kQozxd+OIqChWtw9Ak9V0YZE+ivSNulI=
X-Received: by 2002:a17:903:2445:b0:1fb:67e0:2e0a with SMTP id
 d9443c01a7336-1ff048e5bc5mr66944475ad.48.1722265140636; Mon, 29 Jul 2024
 07:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
 <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
In-Reply-To: <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
From: Peter LaDow <pladow@gmail.com>
Date: Mon, 29 Jul 2024 07:58:49 -0700
Message-ID: <CAN8Q1Ed+T5JKAqD4vwXSZs3CGF6ockiNF5XCJfg3m9NXY=kZuA@mail.gmail.com>
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

I tried both the gcc-12.2 and the gcc-14.1, and both exhibit the same
problem I am seeing.  And I tried it with the M5373EVB which is
included w/ u-boot.

From the arch/m68k/cpu/mcf530x/start.S:

_vectors:
.long   0x00000000
#if defined(CONFIG_M5307) && \
          (CONFIG_TEXT_BASE =3D=3D CFG_SYS_INT_FLASH_BASE)
.long   _start - CONFIG_TEXT_BASE
#else
.long   _START
#endif

.long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT

$ m68k-linux-objdump -s u-boot
u-boot:     file format elf32-m68k

Contents of section .text:
00000 00000000 00000000 0000050c 0000050c  ................
00010 0000050c 0000050c 0000050c 0000050c  ................

Note the reset vector at offset 0x4 is 0x00000000, when it should be
0x00000400.  This is true in both cases.  But _start (and _START which
is #defined to _start above)

$ m68k-linux-nm -n u-boot
00000000 A __fixup_entries
00000000 A __got2_entries
00000000 t INITSP
00000000 t _vectors
00000004 t INITPC
00000008 t vector02_0F
00000040 t vector10_17
00000060 t vector18_1F
00000080 t vector20_2F
000000c0 t vector30_3F
00000100 t vector64_127
00000200 t vector128_191
00000300 t vector192_255
00000400 T _start

So even here we see the _start relocation not set correctly.

However, I do notice something very different in how board_init.c is
compiled.  The M5373EVB compiles with what appear to be some sort of
trampolines.

From the 5373 (compiled with -mcpu=3D5329):

000114fe <board_init_f_init_reserve>:
  114fe:       2f0d            movel %a5,%sp@-
  11500:       206d 00a0       moveal %a5@(160),%a0
  11504:       2f02            movel %d2,%sp@-
  11506:       242f 000c       movel %sp@(12),%d2
  1150a:       4878 00c0       pea c0 <vector30_3F>
  1150e:       42a7            clrl %sp@-
  11510:       2f02            movel %d2,%sp@-
  11512:       4e90            jsr %a0@

Notice at 0x11500 it loads %a0 with an offset from %a5.  And in
_start, it loads %a5 with __got_start.  So some sort of global
relocation table is used to call memset.

But for my board, compiled with the exact same options except -mcpu=3D548x,=
 I get:

0000f5da <board_init_f_init_reserve>:
   f5da:       2f02            movel %d2,%sp@-
   f5dc:       242f 0008       movel %sp@(8),%d2
   f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
   f5e4:       42a7            clrl %sp@-
   f5e6:       2f02            movel %d2,%sp@-
   f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>

Which is a relative branch (bsrl).

The compilation command line is identical except for -mcpu.  Even the
linker command line is identical except for paths to the object files.

On Sun, Jul 28, 2024 at 2:04=E2=80=AFPM Angelo Dureghello
<angelo@kernel-space.org> wrote:
>
> Hi Peter,
>
> glad to hear you solved.
>
> As a toolchain i use those provided by kernel.org:
>
> /opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-
>
> https://cdn.kernel.org/pub/tools/crosstool/
>
> Just out of curiosity, what's the cpu model you used ?
>
>
> Regards,
> Angelo Dureghello
>
>
> On 26/07/24 10:22 PM, Peter LaDow wrote:
> > Scratch that.  I forgot I hard coded the vector table with 0x400 to
> > test things.  Restoring _start still results in 0x00000000 for the
> > reset vector.
> >
> > On Fri, Jul 26, 2024 at 1:16=E2=80=AFPM Peter LaDow <pladow@gmail.com> =
wrote:
> >> I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
> >> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
> >>
> >> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
> >> and tried that.  It generates the proper value in the vector table
> >> (0x400 for _start).  But the call to memset is still bad:
> >>
> >> 0000f5da <board_init_f_init_reserve>:
> >>     f5da:       2f02            movel %d2,%sp@-
> >>     f5dc:       242f 0008       movel %sp@(8),%d2
> >>     f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
> >>     f5e4:       42a7            clrl %sp@-
> >>     f5e6:       2f02            movel %d2,%sp@-
> >>     f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
> >>     f5ee:       2f02            movel %d2,%sp@-
> >>     f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
> >>     f5f6:       0682 0000 00c0  addil #192,%d2
> >>     f5fc:       4fef 0010       lea %sp@(16),%sp
> >>     f600:       2047            moveal %d7,%a0
> >>     f602:       2142 00a0       movel %d2,%a0@(160)
> >>     f606:       241f            movel %sp@+,%d2
> >>     f608:       4e75            rts
> >>
> >> Note "bsrl 23c0c" which points beyond _etext.
> >>
> >> On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Fabio Estevam <festevam@gmail=
.com> wrote:
> >>> Adding the Coldfire maintainers on Cc.
> >>>
> >>> On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.com=
> wrote:
> >>>> After some digging it appears that this is a toolchain issue.  It se=
ems the
> >>>> linker fixups are sometimes not computed correctly.  For example, in
> >>>> board_init_f_init_reserve, the object file disassembled has:
> >>>>
> >>>> 00000000 <board_init_f_init_reserve>:
> >>>>    0:   2f02            movel %d2,%sp@-
> >>>>    2:   242f 0008       movel %sp@(8),%d2
> >>>>    6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
> >>>>    a:   42a7            clrl %sp@-
> >>>>    c:   2f02            movel %d2,%sp@-
> >>>>    e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
> >>>>   14:   2f02            movel %d2,%sp@-
> >>>>   16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
> >>>>   1c:   0682 0000 00c0  addil #192,%d2
> >>>>   22:   4fef 0010       lea %sp@(16),%sp
> >>>>   26:   2047            moveal %d7,%a0
> >>>>   28:   2142 00a0       movel %d2,%a0@(160)
> >>>>   2c:   241f            movel %sp@+,%d2
> >>>>   2e:   4e75            rts
> >>>>
> >>>> But when I disassemble the final linked u-boot output:
> >>>>
> >>>> 0000f646 <board_init_f_init_reserve>:
> >>>>     f646:       2f02            movel %d2,%sp@-
> >>>>     f648:       242f 0008       movel %sp@(8),%d2
> >>>>     f64c:       4878 00c0       pea c0 <_vectors+0xc0>
> >>>>     f650:       42a7            clrl %sp@-
> >>>>     f652:       2f02            movel %d2,%sp@-
> >>>>     f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
> >>>>     f65a:       2f02            movel %d2,%sp@-
> >>>>     f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
> >>>>     f662:       0682 0000 00c0  addil #192,%d2
> >>>>     f668:       4fef 0010       lea %sp@(16),%sp
> >>>>     f66c:       2047            moveal %d7,%a0
> >>>>     f66e:       2142 00a0       movel %d2,%a0@(160)
> >>>>     f672:       241f            movel %sp@+,%d2
> >>>>     f674:       4e75            rts
> >>>>
> >>>> Note the pea c0 instruction.  The object file has
> >>>> board_init_f_init_reserve+0xc0 as the argument, but the final linker=
 has
> >>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after link=
ing.
> >>>>
> >>>> Also, note the first bsrl instruction, which is not setup correctly
> >>>> either.  This is a call to memset.  This points to _etext+0x138, whi=
ch is
> >>>> not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in the=
 final
> >>>> uboot, memset is at 0x1f030.
> >>>>
> >>>> In the call to memset(),  objdump shows the relocation:
> >>>>
> >>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> >>>> OFFSET   TYPE              VALUE
> >>>> 00000010 R_68K_PLT32       memset
> >>>> 00000018 R_68K_PLT32       arch_setup_gd
> >>>>
> >>>> So it seems only when linking outside the same compilation unit that=
 the
> >>>> relocations aren't set correctly.
> >>>>
> >>>> I'm not sure where to look for a solution.  Or how to search for an
> >>>> answer.  I've done some digging on Google, but nothing points to a c=
lear
> >>>> answer.  Anyone seen something similar?
> >>>>
> >>>> To love for the sake of being loved is human, but to love for the sa=
ke of
> >>>> loving is angelic. -- Alphonse de Lamartine.
> >>>>
> >>>>
> >>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
> >>>>> I'm trying to add support for a custom Colfire based board.  I have
> >>>>> things building, but the final linked vectors in start.S do not poi=
nt
> >>>>> to _start.  In start.S I have:
> >>>>>
> >>>>> _vectors:
> >>>>> .long   0x00000000              /* Flash offset is 0 until we setup=
 CS0 */
> >>>>> .long   _START
> >>>>>
> >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> >>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> >>>>>
> >>>>> Dumping the symbols in the final u-boot yields:
> >>>>>
> >>>>> $ m68k-linux-gnu-nm -n u-boot
> >>>>> 00000000 A __fixup_entries
> >>>>> 00000000 A __got2_entries
> >>>>> 00000000 t _vectors
> >>>>> 00000400 T _start
> >>>>> 0000047e T relocate_code
> >>>>> 000004ae t fixloop
> >>>>>
> >>>>> But then dumping the raw binary:
> >>>>>
> >>>>> u-boot:     file format elf32-m68k
> >>>>>
> >>>>> Contents of section .text:
> >>>>> 00000 00000000 00000000 00000516 00000516  ................
> >>>>> 00010 00000516 00000516 00000516 00000516  ................
> >>>>> 00020 00000516 00000516 00000516 00000516  ................
> >>>>> 00030 00000516 00000516 00000516 00000516  ................
> >>>>>
> >>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> >>>>>
> >>>>> The final linker script has:
> >>>>>
> >>>>> OUTPUT_ARCH(m68k)
> >>>>> ENTRY(_start)
> >>>>> SECTIONS
> >>>>> {
> >>>>> .text :
> >>>>> {
> >>>>>   arch/m68k/cpu/mcf548x/start.o (.text*)
> >>>>>   . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*=
);
> >>>>>   *(.text*)
> >>>>> }
> >>>>>
> >>>>>
> >>>>> It is difficult to search the archives, and so far I haven't found
> >>>>> anything.  Any help would be appreciated.
> >>>>>
> >>>>> --
> >>>>> To love for the sake of being loved is human, but to love for the s=
ake
> >>>>> of loving is angelic. -- Alphonse de Lamartine.
> >>
> >>
> >> --
> >> To love for the sake of being loved is human, but to love for the sake
> >> of loving is angelic. -- Alphonse de Lamartine.
> >
> >



--=20
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
