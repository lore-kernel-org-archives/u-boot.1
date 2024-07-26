Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7732CC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 20:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E4587C7E;
	Fri, 26 Jul 2024 22:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CniqjHZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECF78851E; Fri, 26 Jul 2024 22:23:11 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1804F878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 22:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d333d5890so1239364b3a.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722025387; x=1722630187; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZkHy+fCgdy7VV9fCXK+o6osbwX3q8PaogTpHe1lVbs=;
 b=CniqjHZsRLmyvmiShGeDbGYoaftiQMgDNsByokhnQP4d8mMwuZsz8dwcQWA8QLB/WQ
 6Iwk3hQcUC4AIbXjVAb6znG3H5YFDJtJSvwNEZy9thx+jDsngPSwzPzbk4GI11DvHpX5
 j2n1M+StAgAlD3Po+yL2UAeG9HSFeAD5hXY2dpgQv/2ssSpu53DU8Ef/97rh4ZVsElfT
 +4ROxqAAKCOv4Y5wO0IxBXKCOi12zg4awbjpIxY6XsGA1XvsZOd/acrxomWACYBMaVaB
 QzrWgQW7QNVnUPyEsWO4K1dqwbjtHz4ABkeKTKy9regyFLOVhK5rwMwiUp+kTTqLCASw
 W+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722025387; x=1722630187;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZkHy+fCgdy7VV9fCXK+o6osbwX3q8PaogTpHe1lVbs=;
 b=bCLhVMTz712iuEg+fVBmNMG4Ol6bL5n7lbu2DA3QytKf1LjTPeGouD+QU27GUo+8HK
 vX6ho3zYOKzJ0WgTp7bNEQRSXlmnZ3qTDmjv1lS1SMFYLxZR+E0NvpSk8QFORySzMXHf
 9czwiTPtnn+gTHQHEB9BZjYb4gxpf9oWDaF/rK9VJNDw6B+Byag0hyY0i1H3ynjHcFmy
 4V0UfIz7xPoUjFcZMpwL8ci/vCbibQahzr3XJYezPHX2hOnEonYsUszi+XFLhoLi1Pqu
 /WS3kKVfojdA4aSMPU2wrDTwvXR5F6dQ01VsbBZjpCkGcJp2ZR3oi2eFKILfRsWgGPXq
 0MBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZYEeRl1C9knhQWNDMsyHMiY0Xm+AZR83OiI56pDRPSKwXMVwGAtDUEtBJtzFlEUPBQFDAxTLEllL8rzS2RyLTBru4yA==
X-Gm-Message-State: AOJu0YzZunEnDaXwbMExU8siIvOqYebY5QWbtwikrxT4pNMLaelMYnhf
 v9sTOR3/4kZNHDNJfSse+ISIFaHtCV+A8PuKbWLZqdtdTf6/8qPbabjdI3dmThHAJvoQBh+WR2X
 8AxAcAVUBLM3o9gjtjluy/lguOLc=
X-Google-Smtp-Source: AGHT+IG8+Fg4cVGBLDEU/QDQPqRVN6i1DBITAb+vkQVuXsHIC0xgNhs5SBkI9Wu1De1HZfmFoQSUDpS2uKBrOcXEAWY=
X-Received: by 2002:a05:6a00:9167:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-70ecea1997emr718006b3a.7.1722025387204; Fri, 26 Jul 2024
 13:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
In-Reply-To: <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
From: Peter LaDow <pladow@gmail.com>
Date: Fri, 26 Jul 2024 13:22:56 -0700
Message-ID: <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
Subject: Re: M68K Vectors
To: Angelo Dureghello <angelo@kernel-space.org>,
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

Scratch that.  I forgot I hard coded the vector table with 0x400 to
test things.  Restoring _start still results in 0x00000000 for the
reset vector.

On Fri, Jul 26, 2024 at 1:16=E2=80=AFPM Peter LaDow <pladow@gmail.com> wrot=
e:
>
> I should mention I was using the gcc-m68k-linux-gnu package on Ubuntu
> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
>
> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-1,
> and tried that.  It generates the proper value in the vector table
> (0x400 for _start).  But the call to memset is still bad:
>
> 0000f5da <board_init_f_init_reserve>:
>    f5da:       2f02            movel %d2,%sp@-
>    f5dc:       242f 0008       movel %sp@(8),%d2
>    f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
>    f5e4:       42a7            clrl %sp@-
>    f5e6:       2f02            movel %d2,%sp@-
>    f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
>    f5ee:       2f02            movel %d2,%sp@-
>    f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
>    f5f6:       0682 0000 00c0  addil #192,%d2
>    f5fc:       4fef 0010       lea %sp@(16),%sp
>    f600:       2047            moveal %d7,%a0
>    f602:       2142 00a0       movel %d2,%a0@(160)
>    f606:       241f            movel %sp@+,%d2
>    f608:       4e75            rts
>
> Note "bsrl 23c0c" which points beyond _etext.
>
> On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Adding the Coldfire maintainers on Cc.
> >
> > On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.com> =
wrote:
> > >
> > > After some digging it appears that this is a toolchain issue.  It see=
ms the
> > > linker fixups are sometimes not computed correctly.  For example, in
> > > board_init_f_init_reserve, the object file disassembled has:
> > >
> > > 00000000 <board_init_f_init_reserve>:
> > >   0:   2f02            movel %d2,%sp@-
> > >   2:   242f 0008       movel %sp@(8),%d2
> > >   6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
> > >   a:   42a7            clrl %sp@-
> > >   c:   2f02            movel %d2,%sp@-
> > >   e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
> > >  14:   2f02            movel %d2,%sp@-
> > >  16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
> > >  1c:   0682 0000 00c0  addil #192,%d2
> > >  22:   4fef 0010       lea %sp@(16),%sp
> > >  26:   2047            moveal %d7,%a0
> > >  28:   2142 00a0       movel %d2,%a0@(160)
> > >  2c:   241f            movel %sp@+,%d2
> > >  2e:   4e75            rts
> > >
> > > But when I disassemble the final linked u-boot output:
> > >
> > > 0000f646 <board_init_f_init_reserve>:
> > >    f646:       2f02            movel %d2,%sp@-
> > >    f648:       242f 0008       movel %sp@(8),%d2
> > >    f64c:       4878 00c0       pea c0 <_vectors+0xc0>
> > >    f650:       42a7            clrl %sp@-
> > >    f652:       2f02            movel %d2,%sp@-
> > >    f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
> > >    f65a:       2f02            movel %d2,%sp@-
> > >    f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
> > >    f662:       0682 0000 00c0  addil #192,%d2
> > >    f668:       4fef 0010       lea %sp@(16),%sp
> > >    f66c:       2047            moveal %d7,%a0
> > >    f66e:       2142 00a0       movel %d2,%a0@(160)
> > >    f672:       241f            movel %sp@+,%d2
> > >    f674:       4e75            rts
> > >
> > > Note the pea c0 instruction.  The object file has
> > > board_init_f_init_reserve+0xc0 as the argument, but the final linker =
has
> > > 0xc0, meaning board_init_f_init_reserve is being set to 0 after linki=
ng.
> > >
> > > Also, note the first bsrl instruction, which is not setup correctly
> > > either.  This is a call to memset.  This points to _etext+0x138, whic=
h is
> > > not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in the =
final
> > > uboot, memset is at 0x1f030.
> > >
> > > In the call to memset(),  objdump shows the relocation:
> > >
> > > RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> > > OFFSET   TYPE              VALUE
> > > 00000010 R_68K_PLT32       memset
> > > 00000018 R_68K_PLT32       arch_setup_gd
> > >
> > > So it seems only when linking outside the same compilation unit that =
the
> > > relocations aren't set correctly.
> > >
> > > I'm not sure where to look for a solution.  Or how to search for an
> > > answer.  I've done some digging on Google, but nothing points to a cl=
ear
> > > answer.  Anyone seen something similar?
> > >
> > > To love for the sake of being loved is human, but to love for the sak=
e of
> > > loving is angelic. -- Alphonse de Lamartine.
> > >
> > >
> > > On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
> > > >
> > > > I'm trying to add support for a custom Colfire based board.  I have
> > > > things building, but the final linked vectors in start.S do not poi=
nt
> > > > to _start.  In start.S I have:
> > > >
> > > > _vectors:
> > > > .long   0x00000000              /* Flash offset is 0 until we setup=
 CS0 */
> > > > .long   _START
> > > >
> > > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> > > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> > > > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FA=
ULT
> > > >
> > > > Dumping the symbols in the final u-boot yields:
> > > >
> > > > $ m68k-linux-gnu-nm -n u-boot
> > > > 00000000 A __fixup_entries
> > > > 00000000 A __got2_entries
> > > > 00000000 t _vectors
> > > > 00000400 T _start
> > > > 0000047e T relocate_code
> > > > 000004ae t fixloop
> > > >
> > > > But then dumping the raw binary:
> > > >
> > > > u-boot:     file format elf32-m68k
> > > >
> > > > Contents of section .text:
> > > > 00000 00000000 00000000 00000516 00000516  ................
> > > > 00010 00000516 00000516 00000516 00000516  ................
> > > > 00020 00000516 00000516 00000516 00000516  ................
> > > > 00030 00000516 00000516 00000516 00000516  ................
> > > >
> > > > Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> > > >
> > > > The final linker script has:
> > > >
> > > > OUTPUT_ARCH(m68k)
> > > > ENTRY(_start)
> > > > SECTIONS
> > > > {
> > > > .text :
> > > > {
> > > >  arch/m68k/cpu/mcf548x/start.o (.text*)
> > > >  . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*)=
;
> > > >  *(.text*)
> > > > }
> > > >
> > > >
> > > > It is difficult to search the archives, and so far I haven't found
> > > > anything.  Any help would be appreciated.
> > > >
> > > > --
> > > > To love for the sake of being loved is human, but to love for the s=
ake
> > > > of loving is angelic. -- Alphonse de Lamartine.
>
>
>
> --
> To love for the sake of being loved is human, but to love for the sake
> of loving is angelic. -- Alphonse de Lamartine.



--=20
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
