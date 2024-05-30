Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDFCC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 10:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6A288681;
	Thu, 30 May 2024 12:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="HYbqqNkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D767688684; Thu, 30 May 2024 12:42:20 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3F48867C
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 12:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-62a2424ec50so6718737b3.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1717065737; x=1717670537;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSNxBU7hYRlUbG4eCNuayU1ctM8LGUiuMclBCwnvVb8=;
 b=HYbqqNkJ9X3CNo50cwPVGe0AfdJglRDybGBjtY5yFKs0zzqbwcwW6By391b8P9S2Gh
 5F6iREoOk7WpwV0ca1iQskT6Vyevx9kLmWxjL4VnB7PVb9kbVWVlUQXkYP6/61GvoPB1
 yecTkVPYGRCIvVJG9beZknlO4hJfK+ld4E6zFKIYwxVnOtFQQIv6nlBtrnyabIsHbrD2
 9iDW58Nc3EK3X8evakpPnmE4JC2eLf1XBw3/FVzwboccaF43/PE/TCeKf5ivmpu23HgM
 h9YtOELrS4wOzb1ALoBmls+X0ycuH4/Cwukprged6odop7xy4wAYh4Z6L4Vm/WnMr7Y2
 oeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717065737; x=1717670537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSNxBU7hYRlUbG4eCNuayU1ctM8LGUiuMclBCwnvVb8=;
 b=iktWPZkHxpiFICqsqZIYS5izCHzmzhymGf6PE7hMaW/jJRu4qqb2uyEbDGZ2g089eG
 wQywCV+VeSw/FDT500eH08jobjEeA3AAZZwLec2yiY9vrT12qdT6Ba15pMIykXe4gRhF
 2kr/3UDabOE9Jfq6Uy6IbHMMj1phe+2SgjKxc45fCZwZSQHSzx+cWudCrZQLhcR12A/3
 VOm8ZP4WKlVLBWBqE7qym9SIjTvlTE24YL34bHRopgUB9641Qi/ntzsaISrWTGUS4VwT
 iJUltQhm4aviPLIZe6gG4J8N8Y4aR8ZB0ZpbPszmsM6s/iChKxnjP2TCEj09DgOodTiz
 QG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHDKp7ex7h0ACk4fuZMxiQlBDlkFGVROwsO19xrGHnLuxzTY6+UZoXiPr1uFzHIadeCmAgk/ocemCpjPG4+lyFcToa/Q==
X-Gm-Message-State: AOJu0YyIzyFfEB+SgtXzTVO0sV4YxW87r6LBd6Z+xYl2GbTb/hg1+y5L
 e4pkb4/EDKGnJxJ+op+YKL2feIy9exBOk74Q6YKRXIaGCoBpk25L3UFgIZq2YXdFkH+h3pLipqO
 328PZ/DzhAB1BFMu4nIxURu1gVAiYG7xUrbEh
X-Google-Smtp-Source: AGHT+IEt7o5G12huZHsLe6BzR3J7MnQzMnekaThEGzaRVUxdxja3IWCKd5Q7ujkxlX8JuCLDEBdEo5JNtuAJMTXiL7c=
X-Received: by 2002:a0d:fe81:0:b0:627:e963:2bcf with SMTP id
 00721157ae682-62c6bd4fa20mr15272727b3.51.1717065737308; Thu, 30 May 2024
 03:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
 <476510ce-8a1a-4ed1-ae98-04beb9c75607@amd.com>
 <3e51141e-6c0d-4955-a9dc-89d2c5e94279@amd.com>
 <070937d2-ee25-4a63-a4fd-56a073353887@weidmueller.com>
In-Reply-To: <070937d2-ee25-4a63-a4fd-56a073353887@weidmueller.com>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 30 May 2024 12:42:06 +0200
Message-ID: <CAHTX3d+02QMB7_B+eVu_Qj_mEfxToBCo1jBBaNy3FK8-2D_Q6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Introduce spl_soc_init() for SoC specific
 initialization
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
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

Hi,

p=C3=A1 3. 5. 2024 v 8:10 odes=C3=ADlatel Lukas Funke
<lukas.funke-oss@weidmueller.com> napsal:
>
> Hi Michal,
>
> On 10.04.2024 09:06, Michal Simek wrote:
> > Hi,
> >
> > On 4/8/24 14:59, Michal Simek wrote:
> >>
> >>
> >> On 3/27/24 13:11, lukas.funke-oss@weidmueller.com wrote:
> >>> From: Lukas Funke <lukas.funke@weidmueller.com>
> >>>
> >>>
> >>> Currently some vendors use spl_board_init() for their SoC
> >>> specific initialization. This prohibits board developers from adding
> >>> board init code using said function. This series introduces a new
> >>> function in order to separate SoC init code from board init code.
> >>>
> >>>
> >>> Changes in v3:
> >>>   - Rephrase Kconfig description and correct minor typo
> >>>
> >>> Changes in v2:
> >>>   - Change spl_arch_init() to spl_soc_init()
> >>>
> >>> Lukas Funke (2):
> >>>    spl: Introduce SoC specific init function
> >>>    arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()
> >>>
> >>>   arch/arm/Kconfig           | 4 ++--
> >>>   arch/arm/mach-zynq/spl.c   | 4 ++--
> >>>   arch/arm/mach-zynqmp/spl.c | 4 ++--
> >>>   common/spl/Kconfig         | 7 +++++++
> >>>   common/spl/spl.c           | 3 +++
> >>>   include/spl.h              | 8 ++++++++
> >>>   6 files changed, 24 insertions(+), 6 deletions(-)
> >>>
> >>
> >> Applied.
> >
> > Actually I need to drop these two patches.
> > I pushed it to CI and got this error.
> >
> > Building current source for 1 boards (1 thread, 32 jobs per thread)
> >     riscv64:  +   sifive_unleashed
> > +In file included from board/sifive/unleashed/spl.c:17:
> > +include/asm/arch/spl.h:12:5: error: conflicting types for
> > 'spl_soc_init'; have 'int(void)'
> > +   12 | int spl_soc_init(void);
> > +      |     ^~~~~~~~~~~~
> > +In file included from board/sifive/unleashed/spl.c:10:
> > +include/spl.h:825:6: note: previous declaration of 'spl_soc_init' with
> > type 'void(void)'
> > +  825 | void spl_soc_init(void);
> > +      |      ^~~~~~~~~~~~
> > +make[3]: *** [scripts/Makefile.build:257:
> > spl/board/sifive/unleashed/spl.o] Error 1
> > +make[2]: *** [scripts/Makefile.spl:533: spl/board/sifive/unleashed]
> > Error 2
> > +make[1]: *** [Makefile:2055: spl/u-boot-spl] Error 2
> > +make: *** [Makefile:177: sub-make] Error 2
> >
> > And it is valid because Risc-V guys are already using it.
>
> The issue should be fixed on master. The function name was changed from
> spl_soc_init to spl_dram_init. The patch should apply now. Could you
> give it another try?

Looks good now.

Applied.
M

---
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
