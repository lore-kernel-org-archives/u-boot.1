Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D4CC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 14:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076F088261;
	Mon, 29 Jul 2024 16:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6a5AVpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202D488261; Mon, 29 Jul 2024 16:27:37 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E77688271
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 16:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd78c165eeso26790505ad.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722263253; x=1722868053; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiEyYNaqbY6tw0t2I2GQYoSZVBRWZWQBJ8vV16uDFaQ=;
 b=N6a5AVpmDVSRmDGiOdw+HAa0vkhiW6TGP5vI7pAHNdR7tXXqmW7YBmz6fDdoTmf1PB
 rQArpMtj+TCJLfFm4sycC/0bD3/aOVZvAyW/+SYxonE6C7fQ8acnvoaQy2Jal6boHPId
 YUdkJTCK2cpFUerltGcrcgu4dr9PIB7Wle7stO85TUmSBRTqKduyHNoTHJ2yw4FxhcGE
 6WFiOtudgtkYEsqU76qGcH2QoIFthURC8XKMH6g+Zav0EHk39KM/1Egv4+MPQGjW4nAX
 G/yGjQL7fpT4G4ZCrpZyMjcl05wwxEfVcDtJEp5e5wA3re916mYeg/F2s9/HPKRNZ6DO
 w9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722263253; x=1722868053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iiEyYNaqbY6tw0t2I2GQYoSZVBRWZWQBJ8vV16uDFaQ=;
 b=vEmBbnLzfBJrGMkt0t1UwH4s5iENDHH37mwUr9yQBqHo+NEftIq2LjD6tQnAHc+BlT
 +JrSZG8GBISCrWChvf/b0bGLJIUxiKj+DXBtOcW7BsTMv53t8Qbd+XBvnrZQRmkQdQDH
 uBVez1z8tMaTBB8r13Q3HLXS75sL9LmOeCvuFlUFR1O9TbSbfUwt0wmMgRawYMyzZW2J
 bx9YE43ow3csTTxfM9V6VPZIN7T5pk+pe/t/y7Z4sDBJYI7mYSgLd9242AxXqmwwQznm
 SZ9ulRzrbOP9R9+fxhelQtAnPB3jU7gmKRn4dbXeZRRBOpKsEVQ14ezl9UrpSAgn3PKR
 h3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+toA3GCh5gp3NpqTAHmQhh27kuftqQbyWhxFm7i3yt/PWJk/uMrfAohrkIu0c07cgrmzRd/zfLp+RgdP9OVagKzxxHA==
X-Gm-Message-State: AOJu0YxMyyPcrC5ypjMKqzKwhlf/fXALLOzDqovVmmWhpVvxXNHxMTHq
 juhOEH6sgFZzio05qaVpSnwMANON7cYRmkPD2H90bt/vMU4sxeJ7e+XYYT84r54b0bttRPK5Fes
 0RJE4GIAvYObMxAhWhm9CnSL2RWyiIA==
X-Google-Smtp-Source: AGHT+IFe81/FH/5Le9WqIzq+V4kfddgF6X1RcCQo9QgZChIpbXZP03t52bVQ2JT+CYX6662+2Qpmqqu+EfV1lgJ6Gcw=
X-Received: by 2002:a17:90a:cc3:b0:2cd:619:6826 with SMTP id
 98e67ed59e1d1-2cf7e60bee6mr9348777a91.34.1722263252827; Mon, 29 Jul 2024
 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
 <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
In-Reply-To: <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
From: Peter LaDow <pladow@gmail.com>
Date: Mon, 29 Jul 2024 07:27:21 -0700
Message-ID: <CAN8Q1Ee6LhiLadKDjFzBghzENEDaWjLL9OBDiOpK_LnfN=DTdg@mail.gmail.com>
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

It's not solved yet.  I forgot I had hard coded some items.

I will give the flavors you suggest a try.

I'm trying to add the MCF548x for a legacy board we have.  It's near
EOL, but we want to leverage uBoot from some in house work.

Thanks,
Pete

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
