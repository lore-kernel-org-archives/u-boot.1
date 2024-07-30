Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2376C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23294887B9;
	Tue, 30 Jul 2024 17:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbFRAUzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9E888800; Tue, 30 Jul 2024 17:43:38 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAAC88747
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pladow@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc5296e214so34073965ad.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722354214; x=1722959014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZoHvu5GmMDr4utGS2FnPRD446RwsMf1FW6cPz7y2KI=;
 b=jbFRAUzl8pSnkeBSOKmSteT2l9GLdxb6/jSkgdUJ1Pny2zh+BCjDMk7OyINTbh0yq2
 v1b68ox9pJZXdtPgXHSoSfN3Ftzzo5ltwPgPi1KhMVDERwL1ByNTk/ldfI6ODeGrIRlk
 r90xv/vKfPGg+0yAyTIHFA6mnOVZYj9mhULTztbdf+O/vVtZzx3iNvj35/MjGAWI2MpW
 Ku6NRnlmiOGucnC8Z2YS0vDbWRBYWuXOnH7lGkYX+JUJ7klKi1FAEOUkzJegj5qaJ1tL
 8OYT96gOlSYkC4TwB9JDIgPy+8OkJSmbBkyi7dJV4mqYBGrc1JKFr8WoJM4OlTlg6jGU
 1vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722354214; x=1722959014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZoHvu5GmMDr4utGS2FnPRD446RwsMf1FW6cPz7y2KI=;
 b=giuMdQddLa7eWPt0PNJmMfGY1G0l1uLq8x/mztVx6BuHvkxxkwEB8rmfdUvthEu369
 9YCk6YHmbuO2ayrWq1BB2TLoz/2To/ukokIzmWLlCIcVGP1b2R9Zp32VLM81E24tlh9z
 OXixvE+wn1Tpa/xhMTisvcG2Asxo3OGSp2TBM5/FDe1bXMEOlp3CihLaincHN1g4U9uR
 AUS/1dJSlMIbVq3dcRltNP+H1CzCECZp+HqoVmsqaK/7XCuYiQdbqKMAj4HzbLedbZte
 +1ZphlnnvA7NojcBfnoF6/qfGgeUpmvH6lnPAeeUzD62fY/EIg1Dr+5mGxZvwpZj6oyp
 bTvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5wqCBDWGxyXAanTlbMVLxjADgagt/HgMQrkZy80QK7NmvW2ciZy+YhYnPD7YPKvAUVzsDmeY/OSPjcwvdS305gjVvg==
X-Gm-Message-State: AOJu0Yz6cuQ5PX3VfbqOwbQRNDUq9C2aLHbsUbAWfcugZW0jL3cnBV/V
 y9nIyTPEDgPSvhHHcHwD1/Z7//MpiZZ3gGQKVNRt2QWfYjIx8NR65ocRr1liKAP5tlBVwLzs6qZ
 oEn5rYMq/13NGlnV9/lmENLIBfOc=
X-Google-Smtp-Source: AGHT+IGhtsRjzh129AxcY5kxDqTrrYHOEcC557eGakm7zPyiYCT4fQxui4oXFTqFyn85edK/CnD5UoAPreSdFrKIOHE=
X-Received: by 2002:a17:902:fc44:b0:1fb:4b87:6e8e with SMTP id
 d9443c01a7336-1ff048a04eamr141274095ad.42.1722354213406; Tue, 30 Jul 2024
 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
 <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
 <CAN8Q1EfPghRrKtgeO_gr_VZ26_dHQUpRkBqbfYshZf0KeGm=oA@mail.gmail.com>
 <CAN8Q1EdCtmCE9HPhhjHakRk77Mw4AQ1-tPLm1SQcS0ELrgy3Lg@mail.gmail.com>
 <5587ef25-7694-4aa9-8a73-98e589b61cae@kernel-space.org>
 <CAN8Q1Ee6LhiLadKDjFzBghzENEDaWjLL9OBDiOpK_LnfN=DTdg@mail.gmail.com>
 <0ca9ef05-1de8-4c30-b1e7-084a57c97828@kernel-space.org>
In-Reply-To: <0ca9ef05-1de8-4c30-b1e7-084a57c97828@kernel-space.org>
From: Peter LaDow <pladow@gmail.com>
Date: Tue, 30 Jul 2024 08:43:22 -0700
Message-ID: <CAN8Q1EdrY9KfGG=RFGshEZGXhw1JNT6C_X6zs2kW8ecw3yut6w@mail.gmail.com>
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

Thank you for the feedback.

It looks like the mcf5441x executes from RAM.  At least looking at the
configuration for the stmark2, which defines CONFIG_SERIAL_BOOT and
CONFIG_SF_SBF.  This appears to copy from an external device using the
DSPI into RAM.  After loaded, _start finally executes.  Interestingly,
the offset to _start appears to be hard-coded.

First, it forces _start to offset 0x400:

.text
. =3D 0x400
.globl _start
_start:

Then the call to start is by a fixed offset:

/* jump to memory and execute */
move.l #(CONFIG_TEXT_BASE + 0x400), %a0
jmp (%a0)

Where CONFIG_TEXT_BASE is set to 0x47e00000.  The code is odd in this
case as it appears to use the vector table for the DSPI boot,
squeezing all that functionality into less than 1kbyte of memory.

However, once _start runs, the code is pretty much the same as the
other Coldfire variants.  It calls board_init_f_init_reserve, which
calls memset through the same PLT mechanism.  What isn't clear to me
(yet) is why that PLT mechanism works for you, but not for me.  But I
suspect it is because I'm trying to execute directly from flash.

Thanks,
Pete

On Tue, Jul 30, 2024 at 6:50=E2=80=AFAM Angelo Dureghello
<angelo@kernel-space.org> wrote:
>
> Hi Peter,
>
> unfortunately i don't have any of such 548x boards, so cannot
> help that much, but if you can manage to have it working, it will
> be great.
>
> Considering 548x is with mmu, mcf5441x startup code may be helpful,
> even if it's isa_C (your is isa_B).
>
> mcf5441x is tested here, and it is actually doing an elf32 relocation,
> as you can see in start.S "fixloop". It is done after the "copy to ram".
>
> I would proceed with small steps, setting some debug output (or gpio outp=
ut)
> to see where the startup code fails.
>
> Check also the makefile options in arch/m68k/cpu/Makefile, see the -fPIC.
>
> I follow the thread.
>
> Thanks,
> regards,
> angelo
>
>
> On 29/07/24 4:27 PM, Peter LaDow wrote:
> > It's not solved yet.  I forgot I had hard coded some items.
> >
> > I will give the flavors you suggest a try.
> >
> > I'm trying to add the MCF548x for a legacy board we have.  It's near
> > EOL, but we want to leverage uBoot from some in house work.
> >
> > Thanks,
> > Pete
> >
> > On Sun, Jul 28, 2024 at 2:04=E2=80=AFPM Angelo Dureghello
> > <angelo@kernel-space.org> wrote:
> >> Hi Peter,
> >>
> >> glad to hear you solved.
> >>
> >> As a toolchain i use those provided by kernel.org:
> >>
> >> /opt/toolchains/m68k/gcc-12.2.0-nolibc/m68k-linux/bin/m68k-linux-
> >>
> >> https://cdn.kernel.org/pub/tools/crosstool/
> >>
> >> Just out of curiosity, what's the cpu model you used ?
> >>
> >>
> >> Regards,
> >> Angelo Dureghello
> >>
> >>
> >> On 26/07/24 10:22 PM, Peter LaDow wrote:
> >>> Scratch that.  I forgot I hard coded the vector table with 0x400 to
> >>> test things.  Restoring _start still results in 0x00000000 for the
> >>> reset vector.
> >>>
> >>> On Fri, Jul 26, 2024 at 1:16=E2=80=AFPM Peter LaDow <pladow@gmail.com=
> wrote:
> >>>> I should mention I was using the gcc-m68k-linux-gnu package on Ubunt=
u
> >>>> 22.04.4, which pulled in gcc-11-m68k-linux-gnu.
> >>>>
> >>>> I just downloaded the bootlin m68k-coldfire--uclibc--stable-2024.02-=
1,
> >>>> and tried that.  It generates the proper value in the vector table
> >>>> (0x400 for _start).  But the call to memset is still bad:
> >>>>
> >>>> 0000f5da <board_init_f_init_reserve>:
> >>>>      f5da:       2f02            movel %d2,%sp@-
> >>>>      f5dc:       242f 0008       movel %sp@(8),%d2
> >>>>      f5e0:       4878 00c0       pea c0 <_vectors+0xc0>
> >>>>      f5e4:       42a7            clrl %sp@-
> >>>>      f5e6:       2f02            movel %d2,%sp@-
> >>>>      f5e8:       61ff 0001 4622  bsrl 23c0c <_etext+0x138>
> >>>>      f5ee:       2f02            movel %d2,%sp@-
> >>>>      f5f0:       61ff ffff ffd2  bsrl f5c4 <arch_setup_gd>
> >>>>      f5f6:       0682 0000 00c0  addil #192,%d2
> >>>>      f5fc:       4fef 0010       lea %sp@(16),%sp
> >>>>      f600:       2047            moveal %d7,%a0
> >>>>      f602:       2142 00a0       movel %d2,%a0@(160)
> >>>>      f606:       241f            movel %sp@+,%d2
> >>>>      f608:       4e75            rts
> >>>>
> >>>> Note "bsrl 23c0c" which points beyond _etext.
> >>>>
> >>>> On Fri, Jul 26, 2024 at 12:59=E2=80=AFPM Fabio Estevam <festevam@gma=
il.com> wrote:
> >>>>> Adding the Coldfire maintainers on Cc.
> >>>>>
> >>>>> On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.c=
om> wrote:
> >>>>>> After some digging it appears that this is a toolchain issue.  It =
seems the
> >>>>>> linker fixups are sometimes not computed correctly.  For example, =
in
> >>>>>> board_init_f_init_reserve, the object file disassembled has:
> >>>>>>
> >>>>>> 00000000 <board_init_f_init_reserve>:
> >>>>>>     0:   2f02            movel %d2,%sp@-
> >>>>>>     2:   242f 0008       movel %sp@(8),%d2
> >>>>>>     6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
> >>>>>>     a:   42a7            clrl %sp@-
> >>>>>>     c:   2f02            movel %d2,%sp@-
> >>>>>>     e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
> >>>>>>    14:   2f02            movel %d2,%sp@-
> >>>>>>    16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
> >>>>>>    1c:   0682 0000 00c0  addil #192,%d2
> >>>>>>    22:   4fef 0010       lea %sp@(16),%sp
> >>>>>>    26:   2047            moveal %d7,%a0
> >>>>>>    28:   2142 00a0       movel %d2,%a0@(160)
> >>>>>>    2c:   241f            movel %sp@+,%d2
> >>>>>>    2e:   4e75            rts
> >>>>>>
> >>>>>> But when I disassemble the final linked u-boot output:
> >>>>>>
> >>>>>> 0000f646 <board_init_f_init_reserve>:
> >>>>>>      f646:       2f02            movel %d2,%sp@-
> >>>>>>      f648:       242f 0008       movel %sp@(8),%d2
> >>>>>>      f64c:       4878 00c0       pea c0 <_vectors+0xc0>
> >>>>>>      f650:       42a7            clrl %sp@-
> >>>>>>      f652:       2f02            movel %d2,%sp@-
> >>>>>>      f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
> >>>>>>      f65a:       2f02            movel %d2,%sp@-
> >>>>>>      f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
> >>>>>>      f662:       0682 0000 00c0  addil #192,%d2
> >>>>>>      f668:       4fef 0010       lea %sp@(16),%sp
> >>>>>>      f66c:       2047            moveal %d7,%a0
> >>>>>>      f66e:       2142 00a0       movel %d2,%a0@(160)
> >>>>>>      f672:       241f            movel %sp@+,%d2
> >>>>>>      f674:       4e75            rts
> >>>>>>
> >>>>>> Note the pea c0 instruction.  The object file has
> >>>>>> board_init_f_init_reserve+0xc0 as the argument, but the final link=
er has
> >>>>>> 0xc0, meaning board_init_f_init_reserve is being set to 0 after li=
nking.
> >>>>>>
> >>>>>> Also, note the first bsrl instruction, which is not setup correctl=
y
> >>>>>> either.  This is a call to memset.  This points to _etext+0x138, w=
hich is
> >>>>>> not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in t=
he final
> >>>>>> uboot, memset is at 0x1f030.
> >>>>>>
> >>>>>> In the call to memset(),  objdump shows the relocation:
> >>>>>>
> >>>>>> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> >>>>>> OFFSET   TYPE              VALUE
> >>>>>> 00000010 R_68K_PLT32       memset
> >>>>>> 00000018 R_68K_PLT32       arch_setup_gd
> >>>>>>
> >>>>>> So it seems only when linking outside the same compilation unit th=
at the
> >>>>>> relocations aren't set correctly.
> >>>>>>
> >>>>>> I'm not sure where to look for a solution.  Or how to search for a=
n
> >>>>>> answer.  I've done some digging on Google, but nothing points to a=
 clear
> >>>>>> answer.  Anyone seen something similar?
> >>>>>>
> >>>>>> To love for the sake of being loved is human, but to love for the =
sake of
> >>>>>> loving is angelic. -- Alphonse de Lamartine.
> >>>>>>
> >>>>>>
> >>>>>> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote=
:
> >>>>>>> I'm trying to add support for a custom Colfire based board.  I ha=
ve
> >>>>>>> things building, but the final linked vectors in start.S do not p=
oint
> >>>>>>> to _start.  In start.S I have:
> >>>>>>>
> >>>>>>> _vectors:
> >>>>>>> .long   0x00000000              /* Flash offset is 0 until we set=
up CS0 */
> >>>>>>> .long   _START
> >>>>>>>
> >>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> >>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> >>>>>>> .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _=
FAULT
> >>>>>>>
> >>>>>>> Dumping the symbols in the final u-boot yields:
> >>>>>>>
> >>>>>>> $ m68k-linux-gnu-nm -n u-boot
> >>>>>>> 00000000 A __fixup_entries
> >>>>>>> 00000000 A __got2_entries
> >>>>>>> 00000000 t _vectors
> >>>>>>> 00000400 T _start
> >>>>>>> 0000047e T relocate_code
> >>>>>>> 000004ae t fixloop
> >>>>>>>
> >>>>>>> But then dumping the raw binary:
> >>>>>>>
> >>>>>>> u-boot:     file format elf32-m68k
> >>>>>>>
> >>>>>>> Contents of section .text:
> >>>>>>> 00000 00000000 00000000 00000516 00000516  ................
> >>>>>>> 00010 00000516 00000516 00000516 00000516  ................
> >>>>>>> 00020 00000516 00000516 00000516 00000516  ................
> >>>>>>> 00030 00000516 00000516 00000516 00000516  ................
> >>>>>>>
> >>>>>>> Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> >>>>>>>
> >>>>>>> The final linker script has:
> >>>>>>>
> >>>>>>> OUTPUT_ARCH(m68k)
> >>>>>>> ENTRY(_start)
> >>>>>>> SECTIONS
> >>>>>>> {
> >>>>>>> .text :
> >>>>>>> {
> >>>>>>>    arch/m68k/cpu/mcf548x/start.o (.text*)
> >>>>>>>    . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.te=
xt*);
> >>>>>>>    *(.text*)
> >>>>>>> }
> >>>>>>>
> >>>>>>>
> >>>>>>> It is difficult to search the archives, and so far I haven't foun=
d
> >>>>>>> anything.  Any help would be appreciated.
> >>>>>>>
> >>>>>>> --
> >>>>>>> To love for the sake of being loved is human, but to love for the=
 sake
> >>>>>>> of loving is angelic. -- Alphonse de Lamartine.
> >>>>
> >>>> --
> >>>> To love for the sake of being loved is human, but to love for the sa=
ke
> >>>> of loving is angelic. -- Alphonse de Lamartine.
> >>>
> >
> >



--
To love for the sake of being loved is human, but to love for the sake
of loving is angelic. -- Alphonse de Lamartine.
