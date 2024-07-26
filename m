Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0511AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 19:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62478878ED;
	Fri, 26 Jul 2024 21:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pt/Tzqch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E83884BE; Fri, 26 Jul 2024 21:59:54 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869C88780E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 21:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ef2c2dfaf9so3136161fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722023992; x=1722628792; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLomus3/X7NfBuUIgGmiVHnRaSMmCrMoIeNGwcvVh8A=;
 b=Pt/Tzqchn179prwMAwKreVSh232B60FO3GHKFruPwKbJ+Kw5dpm9eNSil+SxOIov3G
 mIQlhBW/ESzdwCe0Jm4M0QtwRSVvPQGAr1C9sGz95TZFwJd/g+QeEOzkkR35k8gknnSS
 4R5NO8DM2HhkSN+2BtPVufWHUeR3GV862oAlEFL67E9xINw4r/9QBT2VzCIor+GWFFvX
 3ROMcM/EK5f2UlC0pIS/EoZ/s8AUd9oUtvQlfCFUWAcdX58B0eR9+o5lznPKe0jMYQ+S
 RYDWG+utvOpyj4lXMKOrCEqGHZQYVdktiHNoCxUZWzwNRpqvl6e/lXCgKuOU9okm///N
 5imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722023992; x=1722628792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLomus3/X7NfBuUIgGmiVHnRaSMmCrMoIeNGwcvVh8A=;
 b=Smt0OIsfgHxzAHI5iBJD0w3sqO/UBITviJzwAwjaX+AK2/Us6WKTT0ounzqgQP2xGv
 JVQG51DLzI5iI33Cu0F6q3pzSZ2yCvrcXFaFPYXtiqkYuWJSAtgAQ84c1y6W2n0+uzKZ
 6XF/23/zYM4emV0dYCQvdokMLrGE/gEk9+R+sHaYUvgN0Lp7QEeqHsQp7QLOuLp9nmg9
 ha4z4nfj7DqxX/bNW+HqV+ty39vqf1bK2EFihvCjgtCxZnbZs2y/ueEiTCHlc3ZIG6s2
 ad31ppx27vMPJyAmMFRgzmX4xQSVTQN0UsWMQWlpALmrn1GehJVcwVZLl2FARQ5r1wu9
 UyPg==
X-Gm-Message-State: AOJu0YyVkpPBAjiA0uqI1xUOr4659OeEYvUu+GCWjK4TqF1oxhACNPHt
 +7dyAT3/09mgrz4ivXAsZZ1l8oiLTampTyihueYHfSpxLr+zC7tERZgXpLDcN7YrTTSv8rOtv61
 ZccABZhFBGlrUjzOlWNd877qz74XI5w==
X-Google-Smtp-Source: AGHT+IE6fboNMG6LFKoet27ZzzLiiCyI+Mox4o/r1rsI/NkHKNVznxRakeSqnSMnjuT7sPPphtYq0x7B6MGpjlVGs4c=
X-Received: by 2002:a2e:a7d6:0:b0:2ee:d55c:603 with SMTP id
 38308e7fff4ca-2f03c7c94fcmr32847081fa.7.1722023991235; Fri, 26 Jul 2024
 12:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Q1EeO0C-LcC1jC=XYZM3RbFbs6sUtjbR===VUe6FYe5Utrw@mail.gmail.com>
 <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
In-Reply-To: <CAN8Q1Ef=eUs9qfwzhCfHA2YrFFZnKVNQVA=5mQb5Hxqi6hs5cw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Jul 2024 16:59:39 -0300
Message-ID: <CAOMZO5BT2st6FdSx-QzmOee2pqTZ0PE_-Ek6p4KbZ+JJJ=HAvw@mail.gmail.com>
Subject: Re: M68K Vectors
To: Peter LaDow <pladow@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Huan Wang <alison.wang@nxp.com>
Cc: u-boot@lists.denx.de
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

Adding the Coldfire maintainers on Cc.

On Fri, Jul 26, 2024 at 4:46=E2=80=AFPM Peter LaDow <pladow@gmail.com> wrot=
e:
>
> After some digging it appears that this is a toolchain issue.  It seems t=
he
> linker fixups are sometimes not computed correctly.  For example, in
> board_init_f_init_reserve, the object file disassembled has:
>
> 00000000 <board_init_f_init_reserve>:
>   0:   2f02            movel %d2,%sp@-
>   2:   242f 0008       movel %sp@(8),%d2
>   6:   4878 00c0       pea c0 <board_init_f_init_reserve+0xc0>
>   a:   42a7            clrl %sp@-
>   c:   2f02            movel %d2,%sp@-
>   e:   61ff 0000 0000  bsrl 10 <board_init_f_init_reserve+0x10>
>  14:   2f02            movel %d2,%sp@-
>  16:   61ff 0000 0000  bsrl 18 <board_init_f_init_reserve+0x18>
>  1c:   0682 0000 00c0  addil #192,%d2
>  22:   4fef 0010       lea %sp@(16),%sp
>  26:   2047            moveal %d7,%a0
>  28:   2142 00a0       movel %d2,%a0@(160)
>  2c:   241f            movel %sp@+,%d2
>  2e:   4e75            rts
>
> But when I disassemble the final linked u-boot output:
>
> 0000f646 <board_init_f_init_reserve>:
>    f646:       2f02            movel %d2,%sp@-
>    f648:       242f 0008       movel %sp@(8),%d2
>    f64c:       4878 00c0       pea c0 <_vectors+0xc0>
>    f650:       42a7            clrl %sp@-
>    f652:       2f02            movel %d2,%sp@-
>    f654:       61ff 0001 44da  bsrl 23b30 <_etext+0x138>
>    f65a:       2f02            movel %d2,%sp@-
>    f65c:       61ff ffff ffd2  bsrl f630 <arch_setup_gd>
>    f662:       0682 0000 00c0  addil #192,%d2
>    f668:       4fef 0010       lea %sp@(16),%sp
>    f66c:       2047            moveal %d7,%a0
>    f66e:       2142 00a0       movel %d2,%a0@(160)
>    f672:       241f            movel %sp@+,%d2
>    f674:       4e75            rts
>
> Note the pea c0 instruction.  The object file has
> board_init_f_init_reserve+0xc0 as the argument, but the final linker has
> 0xc0, meaning board_init_f_init_reserve is being set to 0 after linking.
>
> Also, note the first bsrl instruction, which is not setup correctly
> either.  This is a call to memset.  This points to _etext+0x138, which is
> not a code region Note that 0x239f8 + 0x138 =3D 0x23b30.  But in the fina=
l
> uboot, memset is at 0x1f030.
>
> In the call to memset(),  objdump shows the relocation:
>
> RELOCATION RECORDS FOR [.text.board_init_f_init_reserve]:
> OFFSET   TYPE              VALUE
> 00000010 R_68K_PLT32       memset
> 00000018 R_68K_PLT32       arch_setup_gd
>
> So it seems only when linking outside the same compilation unit that the
> relocations aren't set correctly.
>
> I'm not sure where to look for a solution.  Or how to search for an
> answer.  I've done some digging on Google, but nothing points to a clear
> answer.  Anyone seen something similar?
>
> To love for the sake of being loved is human, but to love for the sake of
> loving is angelic. -- Alphonse de Lamartine.
>
>
> On Thu, Jul 25, 2024 at 14:35 Peter LaDow <pladow@gmail.com> wrote:
> >
> > I'm trying to add support for a custom Colfire based board.  I have
> > things building, but the final linked vectors in start.S do not point
> > to _start.  In start.S I have:
> >
> > _vectors:
> > .long   0x00000000              /* Flash offset is 0 until we setup CS0=
 */
> > .long   _START
> >
> > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
> > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
> > .long   _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT, _FAULT
> >
> > Dumping the symbols in the final u-boot yields:
> >
> > $ m68k-linux-gnu-nm -n u-boot
> > 00000000 A __fixup_entries
> > 00000000 A __got2_entries
> > 00000000 t _vectors
> > 00000400 T _start
> > 0000047e T relocate_code
> > 000004ae t fixloop
> >
> > But then dumping the raw binary:
> >
> > u-boot:     file format elf32-m68k
> >
> > Contents of section .text:
> > 00000 00000000 00000000 00000516 00000516  ................
> > 00010 00000516 00000516 00000516 00000516  ................
> > 00020 00000516 00000516 00000516 00000516  ................
> > 00030 00000516 00000516 00000516 00000516  ................
> >
> > Note at offset 4 it is 0x00000000, not 0x00000400 as I'd expect.
> >
> > The final linker script has:
> >
> > OUTPUT_ARCH(m68k)
> > ENTRY(_start)
> > SECTIONS
> > {
> > .text :
> > {
> >  arch/m68k/cpu/mcf548x/start.o (.text*)
> >  . =3D DEFINED(env_offset) ? env_offset : .; env/embedded.o(.text*);
> >  *(.text*)
> > }
> >
> >
> > It is difficult to search the archives, and so far I haven't found
> > anything.  Any help would be appreciated.
> >
> > --
> > To love for the sake of being loved is human, but to love for the sake
> > of loving is angelic. -- Alphonse de Lamartine.
