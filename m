Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C01C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 20:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A068858C;
	Fri, 26 Jul 2024 22:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWh1SZSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D08A88591; Fri, 26 Jul 2024 22:16:29 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C830887B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 22:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so1028804b3a.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722024985; x=1722629785; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJl4sIkmqavIS9lzj2uh50I/9c2jjVxhdi90rIZOWwM=;
 b=XWh1SZSoLIbEjaemZb9r0AspG+Oglf6ZIvsSLReNEWm2zGI5kyjdSFNmsYBpJqM2Cy
 v8v76y2anAaL0JJnFSnTWpvzZBqoJ+MR7DB8bP6Q+WCkUwUGjGSORgG37hrJnAhdu6yo
 ov9UPbWFYGQTo44kchGbr0w8BKTEce5jIhgpiwat0Iv2BawxSFZT3LLDDuUGzKL9YB0C
 4RjySvL0aIntIVX56wX/GXEjJg0Wkc/lWj6zB1wWQKtlszeUFEZQEwjhGqEi+qEWBjXt
 0kcvH1PXzuCDU9ArlmUEA1dyZbt9QnOVsTA9dE3PQ2pmEaDP8DT18qhqxSjuWVLkh4Ff
 wnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722024985; x=1722629785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJl4sIkmqavIS9lzj2uh50I/9c2jjVxhdi90rIZOWwM=;
 b=RtOB9lHFhe+WAf20gLbzGCU8Q6+vc+X/24hWr8dxMJDw40hGvH/l39uKUqqZzBa9lX
 O93vlhiMxZBw6CcyPJZOb7aTAQ6tTRfT+qD4Yrwp40UyzfoohG2Xb3L4+HocOf9gtAgu
 68e1nazQqRdjuQ33v0AHT3fc/jb+x1LVNX6/R4zLanm+w4RdckFDeidY75A3z9ifR8+i
 lrPO7mqtQKAP0JIZfehuB0D+XiM2LqLUehlLh0gETxuqAXiASxeuQaDeCvIZNIBuHYuR
 WZbmeArJTUHVtnQNGCtnOrmbSOWOJKU0ndKkmRU/Y1yJuwxJiHbdbtohPGRMsW9mdT9X
 VsOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSjCn0h+RtTYHTjRIaU4DKEfJ+3Bd0thgBIP6UirivLElfv/gvoDkfGcwUKddIOYiAFrur095zXa8y5TB27KUpmCBSqA==
X-Gm-Message-State: AOJu0YxHsLiZCAQ/PUj8ooCpd8mqocCNNZPj4Ptdpg8035jzaES9sI2r
 1S/T03MDV5Fr+MCXDmha7ghgA4VzkuOmp2KUGypbUmr4tuq1j6s8Af31CJWz0XrWaTEKHrxTKSX
 pSy1MyNaF/2qfYiy7cUfq6sNG8xWj1S+e
X-Google-Smtp-Source: AGHT+IGVcEh45/DWLNUaMGpLTd+G/Owsg11SsKeFupuO6EAsi3xbYi4OkRXckH9XuELDCdyozh+Ie4VWzA2SBCs5daI=
X-Received: by 2002:a05:6a21:78a7:b0:1c4:21c0:e835 with SMTP id
 adf61e73a8af0-1c4a1179b4bmr933755637.2.1722024985168; Fri, 26 Jul 2024
 13:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
In-Reply-To: <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
From: Peter LaDow <pladow@gmail.com>
Date: Fri, 26 Jul 2024 13:16:13 -0700
Message-ID: <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
Subject: Re: M68K Vectors
To: Fabio Estevam <festevam@gmail.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>,
 Huan Wang <alison.wang@nxp.com>, u-boot@lists.denx.de
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

I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
22.04.4, which pulled in gcc-11-m68k-linux-gnu.

I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
and tried that.  It generates the proper value in the vector table
(0x400 for _start).  But the call to memset is still bad:

0000f5da <board_init_f_init_reserve>:
   f5da:       2f02            movel %d2,%sp@-
   f5dc:       242f 0008       movel %sp@(8),%d2
   f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
   f5e4:       42a7            clrl %sp@-
   f5e6:       2f02            movel %d2,%sp@-
   f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
   f5ee:       2f02            movel %d2,%sp@-
   f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
   f5f6:       0682 0000 00c0  addil #192,%d2
   f5fc:       4fef 0010       lea %sp@(16),%sp
   f600:       2047            moveal %d7,%a0
   f602:       2142 00a0       movel %d2,%a0@(160)
   f606:       241f            movel %sp@+,%d2
   f608:       4e75            rts

Note "bsrl 23c0c" which points beyond _etext.

On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Adding the Coldfire maintainers on Cc.
>
> On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.com> wr=
ote:
> >
> > After some digging it appears that this is a toolchain issue.  It seems=
 the
> > linker fixups are sometimes not computed correctly.  For example, in
> > board_init_f_init_reserve, the object file disassembled has:
> >
> > 00000000 <board_init_f_init_reserve>:
> >   0:   2f02            movel %d2,%sp@-
> >   2:   242f 0008       movel %sp@(8),%d2
> >   6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
> >   a:   42a7            clrl %sp@-
> >   c:   2f02            movel %d2,%sp@-
> >   e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
> >  14:   2f02            movel %d2,%sp@-
> >  16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
> >  1c:   0682 0000 00c0  addil #192,%d2
> >  22:   4fef 0010       lea %sp@(16),%sp
> >  26:   2047            moveal %d7,%a0
> >  28:   2142 00a0       movel %d2,%a0@(160)
> >  2c:   241f            movel %sp@+,%d2
> >  2e:   4e75            rts
> >
> > But when I disassemble the final linked u-boot output:
> >
> > 0000f646 <board_init_f_init_reserve>:
> >    f646:       2f02            movel %d2,%sp@-
> >    f648:       242f 0008       movel %sp@(8),%d2
> >    f64c:       4878 00c0       pea c0 <_vectors+0xc0>
> >    f650:       42a7            clrl %sp@-
> >    f652:       2f02            movel %d2,%sp@-
> >    f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
> >    f65a:       2f02            movel %d2,%sp@-
> >    f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
> >    f662:       0682 0000 00c0  addil #192,%d2
> >    f668:       4fef 0010       lea %sp@(16),%sp
> >    f66c:       2047            moveal %d7,%a0
> >    f66e:       2142 00a0       movel %d2,%a0@(160)
> >    f672:       241f            movel %sp@+,%d2
> >    f674:       4e75            rts
> >
> > Note the pea c0 instruction.  The object file has
> > board_init_f_init_reserve+0xc0 as the argument, but the final linker ha=
s
> > 0xc0, meaning board_init_f_init_reserve is being set to 0 after linking=
.
> >
> > Also, note the first bsrl instruction, which is not setup correctly
> > either.  This is a call to memset.  This points to _etext+0x138, which =
is
> > not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in the fi=
nal
> > uboot, memset is at 0x1f030.
> >
> > In the call to memset(),  objdump shows the relocation:
> >
> > RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> > OFFSET   TYPE              VALUE
> > 00000010 R_68K_PLT32       memset
> > 00000018 R_68K_PLT32       arch_setup_gd
> >
> > So it seems only when linking outside the same compilation unit that th=
e
> > relocations aren't set correctly.
> >
> > I'm not sure where to look for a solution.  Or how to search for an
> > answer.  I've done some digging on Google, but nothing points to a clea=
r
> > answer.  Anyone seen something similar?
> >
> > To love for the sake of being loved is human, but to love for the sake =
of
> > loving is angelic. -- Alphonse de Lamartine.
> >
> >
> > On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
> > >
> > > I'm trying to add support for a custom Colfire based board.  I have
> > > things building, but the final linked vectors in start.S do not point
> > > to _start.  In start.S I have:
> > >
> > > _vectors:
> > > .long   0x00000000              /* Flash offset is 0 until we setup C=
S0 */
> > > .long   _START
> > >
> > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAUL=
T
> > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAUL=
T
> > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAUL=
T
> > >
> > > Dumping the symbols in the final u-boot yields:
> > >
> > > $ m68k-linux-gnu-nm -n u-boot
> > > 00000000 A __fixup_entries
> > > 00000000 A __got2_entries
> > > 00000000 t _vectors
> > > 00000400 T _start
> > > 0000047e T relocate_code
> > > 000004ae t fixloop
> > >
> > > But then dumping the raw binary:
> > >
> > > u-boot:     file format elf32-m68k
> > >
> > > Contents of section .text:
> > > 00000 00000000 00000000 00000516 00000516  ................
> > > 00010 00000516 00000516 00000516 00000516  ................
> > > 00020 00000516 00000516 00000516 00000516  ................
> > > 00030 00000516 00000516 00000516 00000516  ................
> > >
> > > Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> > >
> > > The final linker script has:
> > >
> > > OUTPUT_ARCH(m68k)
> > > ENTRY(_start)
> > > SECTIONS
> > > {
> > > .text :
> > > {
> > >  arch/m68k/cpu/mcf548x/start.o (.text*)
> > >  . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
> > >  *(.text*)
> > > }
> > >
> > >
> > > It is difficult to search the archives, and so far I haven't found
> > > anything.  Any help would be appreciated.
> > >
> > > --
> > > To love for the sake of being loved is human, but to love for the sak=
e
> > > of loving is angelic. -- Alphonse de Lamartine.



--=20
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
