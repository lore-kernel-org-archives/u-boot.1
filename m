Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C175C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE62588827;
	Mon, 29 Jul 2024 17:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kw1ixoYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F0E88808; Mon, 29 Jul 2024 17:26:18 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC6D88806
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b5d42758a7so19025496d6.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266775; x=1722871575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKXknqlF5G6HJuCxNKbHJfyREua5GEDvMl6Sa8TRaVI=;
 b=kw1ixoYaQoasueGXcCfPI4OX5zRjA35amGzmplvQ1MVQLVDXVjPpxRB6ScdLEBE3kf
 N+uX1HNex8OSw1OhK8psC++m84H35x4NStWHajrBZqRE5SO+Jve5y31nhH5EI2zI1VuA
 glDNllBE8O03wCuy+prF2HtIJmzxb/oMMrv3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266775; x=1722871575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKXknqlF5G6HJuCxNKbHJfyREua5GEDvMl6Sa8TRaVI=;
 b=ZaClGmKeAZnIRFGgGi9zUBXyE97rx/GOjIjjf0dhRAVqdrhyTWJc/5pRbuTNsy81yy
 FXqfq4hB7wi79we+UGdEeMQJVkKBePQR+uM7n9VQ4oh71hhGoLWvXQ5eLsaRq8Gr14oO
 gXVg6I7AaKZCoVnK5loaQmGX/m4uJLALRawuIVlXt6eYRyoX901bJTU2mYi2BA+AI3m5
 jco+zBLayYNmc3Gdeh1Hko0uRXs3/Gz4xa4K6JcmPtdyCvEWEt1Y/s/KxR7ZP+tujnAy
 VGBI+iG6qlICxnHGfXCcySYOdPnXEUjjqCd9HeFmcIny3K8Vd1R5fgqaYuEiEpPu12Fv
 fugw==
X-Gm-Message-State: AOJu0YxrR//4NZDW5m8CKLBl6TOVuop43JoflGg2UO3HqXIjRPzsucaB
 dh6cdONnClsil6hjr9nCtRwtgy/zA9QtQRlYmANWBUq7U6LxAQ7ZoFLD8Ja2nNxU3BeH49B3LiG
 eh61c4cCrd5C2SE+RS0hHzt219WkSRa1luC13
X-Google-Smtp-Source: AGHT+IF3U6axqaEjvwtjHTSZjNcs4giGUn8KRjUOkoI+opm9b4PNeQJY1cLsuvm13g3K4WGSS1ZxNLctI5+2gVzN5Cw=
X-Received: by 2002:a05:6214:40c:b0:6b9:5fb9:113f with SMTP id
 6a1803df08f44-6bb55a7a9admr116037296d6.27.1722266775075; Mon, 29 Jul 2024
 08:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-12-sughosh.ganu@linaro.org>
 <CAFLszTi+zHHQErpBx+_6g5OP7xX1soWAUDLLzvtv1O7SSO-P+w@mail.gmail.com>
 <CADg8p95ZWorCTJ21EcEOAORdeZWDGCvo7MXjFBD6DcWwtA_W8A@mail.gmail.com>
In-Reply-To: <CADg8p95ZWorCTJ21EcEOAORdeZWDGCvo7MXjFBD6DcWwtA_W8A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:26:04 -0600
Message-ID: <CAFLszTjLkEPVSxSN6gb98khL-Nks3S3Eji4P6CGaEDVhdxpDVA@mail.gmail.com>
Subject: Re: [PATCH 11/40] lmb: make LMB memory map persistent and global
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 01:50, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The current LMB API's for allocating and reserving memory use a
> > > per-caller based memory view. Memory allocated by a caller can then be
> > > overwritten by another caller. Make these allocations and reservations
> > > persistent using the alloced list data structure.
> > >
> > > Two alloced lists are declared -- one for the available(free) memory,
> > > and one for the used memory. Once full, the list can then be extended
> > > at runtime.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc:
> > > * Squash patches 9 - 11, 13  from the rfc v2 series into a single
> > >   patch to make it bisectable.
> > >
> > >  arch/arc/lib/cache.c                 |   4 +-
> > >  arch/arm/lib/stack.c                 |   4 +-
> > >  arch/arm/mach-apple/board.c          |  17 +-
> > >  arch/arm/mach-snapdragon/board.c     |  17 +-
> > >  arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> > >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> > >  arch/m68k/lib/bootm.c                |   7 +-
> > >  arch/microblaze/lib/bootm.c          |   4 +-
> > >  arch/mips/lib/bootm.c                |  11 +-
> > >  arch/nios2/lib/bootm.c               |   4 +-
> > >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> > >  arch/powerpc/include/asm/mp.h        |   4 +-
> > >  arch/powerpc/lib/bootm.c             |  14 +-
> > >  arch/riscv/lib/bootm.c               |   4 +-
> > >  arch/sh/lib/bootm.c                  |   4 +-
> > >  arch/x86/lib/bootm.c                 |   4 +-
> > >  arch/xtensa/lib/bootm.c              |   4 +-
> > >  board/xilinx/common/board.c          |   8 +-
> > >  boot/bootm.c                         |  26 +-
> > >  boot/bootm_os.c                      |   5 +-
> > >  boot/image-board.c                   |  34 +--
> > >  boot/image-fdt.c                     |  36 ++-
> > >  cmd/bdinfo.c                         |   6 +-
> > >  cmd/booti.c                          |   2 +-
> > >  cmd/bootz.c                          |   2 +-
> > >  cmd/elf.c                            |   2 +-
> > >  cmd/load.c                           |   7 +-
> > >  drivers/iommu/apple_dart.c           |   8 +-
> > >  drivers/iommu/sandbox_iommu.c        |  16 +-
> > >  fs/fs.c                              |   7 +-
> > >  include/image.h                      |  28 +-
> > >  include/lmb.h                        | 114 +++-----
> > >  lib/efi_loader/efi_dt_fixup.c        |   2 +-
> > >  lib/efi_loader/efi_helper.c          |   2 +-
> > >  lib/lmb.c                            | 395 +++++++++++++++------------
> > >  net/tftp.c                           |   5 +-
> > >  net/wget.c                           |   5 +-
> > >  test/cmd/bdinfo.c                    |   2 +-
> > >  test/lib/lmb.c                       | 205 ++++++--------
> > >  39 files changed, 477 insertions(+), 560 deletions(-)
> >
> > I might have missed it, but I didn't see a response to my comment on
> > the previous patch. I think we should have the lmb state in a struct
> > so that sandbox tests can reset it as needed.
>
> Based on your comment [1], my understanding was that you were okay
> with not introducing a struct for this. I believe Tom too was not very
> keen on including the lmb struct into gd.

It should be in a struct, so that its state is all in one place...for
testing if nothing else.

Re gd, it doesn't need to be in there, if there is only one.

Regards,
Simon
