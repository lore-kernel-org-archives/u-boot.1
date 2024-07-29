Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB562C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E15D887B9;
	Mon, 29 Jul 2024 09:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y4rZwEmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D01887D4; Mon, 29 Jul 2024 09:50:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1083885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so4892961a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722239408; x=1722844208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wltkL6iGi+j+afMYkS2ZbnCFhnceRLy2Wgzu8AkR/1k=;
 b=Y4rZwEmmRftncAUUXxOOmwfTweo9Uygawa8DccoeXfzi8FJHBmu2foQ5pZDm2G77yp
 DCkN8na6p9NUpv80Xp2WJlbcnVisvyjxG53UIaJBdyyRnHJlst1NrYYm755SsfjdfuA1
 kGuipl2cIpxX/eDbIhHJ87VX/Pqj7WQw5NaNLQir+5fvFAfVoKTl0S1gSiBylCG7YJPY
 Lo+JEICsPPWRsZajWFBH8I8v7t7MyEDY7A0vWb76i7vEsYVmKSlJc1/JgK6SFXW+phCy
 L9DWBnPaebUhdsyCPfEYRz893p281V8rAGxV4kP0uVyy+J1eLGmUp20zqUG/zJuLG34y
 oF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722239408; x=1722844208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wltkL6iGi+j+afMYkS2ZbnCFhnceRLy2Wgzu8AkR/1k=;
 b=lbl/ILb6FiNsHbeJ1JC9mM0gnoTN5c5LApNyJzHHixTli3GOKAGc53THXkPupIuxa5
 mA0KtB7zacz+T2QrXTz9/HSoxf7WqW5Xuo44aMzjtaPI2eAmmoTI4j5OsicmDXDyXci4
 4tuw6idMKA+n75YGFZlsDKkq3E1i69HAtCSTAQRhGk2Cn0fFUGx7v5X8kxOG3DRXtsGO
 3jqxhqp47TLornZh2PHU9Is6EQadg4Cfb6fbeQVxBfpnNbLfH2aoYOpGKqwQ8ybn+1kN
 +YckVc1LS8yup5CHb4mgTqYWXlgzwNGWsS+35FlcFFEh2+Rs6h8sYeLu3/vSwpkfGG6T
 4/LA==
X-Gm-Message-State: AOJu0YxbptCDZUMdT6/iuOJT7xzSD0E7nLQZi4T28DLN430WsAZ3QD1S
 2BI4K82ULhciEgj+VJb1msf+p6GKkQJeGFMet5gm8pr5hN8Q+d38RKQmRrXhqlgRC9HoVSYf+Z+
 masE2N+83AtWo7pu5H0gyuyM6qFk3ujUEPiLBiQ==
X-Google-Smtp-Source: AGHT+IE4kkuBvpvJyeALyU+0sRcVcA02zY5s8EgcQ0aEf4i3VlFjBgcQ1kv0BVAE4W3DrhR7QABnpC342XCpDWbLODM=
X-Received: by 2002:a05:6402:26c2:b0:5a3:3553:9aaf with SMTP id
 4fb4d7f45d1cf-5b0201034a1mr4914055a12.2.1722239407924; Mon, 29 Jul 2024
 00:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-12-sughosh.ganu@linaro.org>
 <CAFLszTi+zHHQErpBx+_6g5OP7xX1soWAUDLLzvtv1O7SSO-P+w@mail.gmail.com>
In-Reply-To: <CAFLszTi+zHHQErpBx+_6g5OP7xX1soWAUDLLzvtv1O7SSO-P+w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 13:19:56 +0530
Message-ID: <CADg8p95ZWorCTJ21EcEOAORdeZWDGCvo7MXjFBD6DcWwtA_W8A@mail.gmail.com>
Subject: Re: [PATCH 11/40] lmb: make LMB memory map persistent and global
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc:
> > * Squash patches 9 - 11, 13  from the rfc v2 series into a single
> >   patch to make it bisectable.
> >
> >  arch/arc/lib/cache.c                 |   4 +-
> >  arch/arm/lib/stack.c                 |   4 +-
> >  arch/arm/mach-apple/board.c          |  17 +-
> >  arch/arm/mach-snapdragon/board.c     |  17 +-
> >  arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >  arch/m68k/lib/bootm.c                |   7 +-
> >  arch/microblaze/lib/bootm.c          |   4 +-
> >  arch/mips/lib/bootm.c                |  11 +-
> >  arch/nios2/lib/bootm.c               |   4 +-
> >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >  arch/powerpc/include/asm/mp.h        |   4 +-
> >  arch/powerpc/lib/bootm.c             |  14 +-
> >  arch/riscv/lib/bootm.c               |   4 +-
> >  arch/sh/lib/bootm.c                  |   4 +-
> >  arch/x86/lib/bootm.c                 |   4 +-
> >  arch/xtensa/lib/bootm.c              |   4 +-
> >  board/xilinx/common/board.c          |   8 +-
> >  boot/bootm.c                         |  26 +-
> >  boot/bootm_os.c                      |   5 +-
> >  boot/image-board.c                   |  34 +--
> >  boot/image-fdt.c                     |  36 ++-
> >  cmd/bdinfo.c                         |   6 +-
> >  cmd/booti.c                          |   2 +-
> >  cmd/bootz.c                          |   2 +-
> >  cmd/elf.c                            |   2 +-
> >  cmd/load.c                           |   7 +-
> >  drivers/iommu/apple_dart.c           |   8 +-
> >  drivers/iommu/sandbox_iommu.c        |  16 +-
> >  fs/fs.c                              |   7 +-
> >  include/image.h                      |  28 +-
> >  include/lmb.h                        | 114 +++-----
> >  lib/efi_loader/efi_dt_fixup.c        |   2 +-
> >  lib/efi_loader/efi_helper.c          |   2 +-
> >  lib/lmb.c                            | 395 +++++++++++++++------------
> >  net/tftp.c                           |   5 +-
> >  net/wget.c                           |   5 +-
> >  test/cmd/bdinfo.c                    |   2 +-
> >  test/lib/lmb.c                       | 205 ++++++--------
> >  39 files changed, 477 insertions(+), 560 deletions(-)
>
> I might have missed it, but I didn't see a response to my comment on
> the previous patch. I think we should have the lmb state in a struct
> so that sandbox tests can reset it as needed.

Based on your comment [1], my understanding was that you were okay
with not introducing a struct for this. I believe Tom too was not very
keen on including the lmb struct into gd.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-July/558843.html
