Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9ECC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0662F887EB;
	Mon, 15 Jul 2024 11:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M3qqKkFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262F1887F5; Mon, 15 Jul 2024 11:29:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E941F87D87
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77af4cd570so249086266b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721035783; x=1721640583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OHS6xIC5mx8U73/H1j753eTvXdbNxLjYqSLPBZVCGRs=;
 b=M3qqKkFyTJ0M6YHuRv/jzGrFUALshWV/RcEFbCaYaXDxmgSy3LPLI8snti1j/pbCn/
 oQuszokbLh0T5AC+lsDn4aFS514ESwPrVANsZa6aif1ByRG4kjz40m5oncQknfY+wekP
 aaGgayC2AVycp+oe+mmq5/s+6nWueOzK9bFD7L+irc62X3pfn/yiDvFsAbUvCIh4p9A6
 BBV6WM6sPc/rQ0D+tW+tKoyed5uIvo/BxyNtWeFfRTmmgG/W8ot54225oP2gTG8jT+wc
 jUcPRwVCe0vNbfKWBjvdcAwY6CwfgSvTdXnVaVhjCLq62zwWo3L2DiKNSMA8kFCsoXgf
 8qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721035783; x=1721640583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHS6xIC5mx8U73/H1j753eTvXdbNxLjYqSLPBZVCGRs=;
 b=Is7PyMjWXTeqByIIjXfqCm/6VkMAzj2KEvcnDjUV6pqk103tMo/p29MHQCvvpIQG+q
 y/yMrI1GBsr6VtHL+WixgXU6ooWJgLMcU68iCwJeYFkCYReTYVfSrvVTBVnQ+KJ06QuX
 fsTIPPzedfoPRW1nv2MdiVJ3QMetY7H9rNzZdh2QjtYdt5t9rS/BjZndgfcQEmPOfda0
 j47ojbb/Hx+zw+tQ6te2tmQG+ijBQhN6sQKOn3tvyNrOTn8/alU9nf4iXxpzQVUcHPwQ
 M0E6opVSqvtCrnoEMTOJn9TIQYj5Nx91AQKXAOHuoaBFAX97NfWSsMjRqCQP9ENQeeUw
 tqcQ==
X-Gm-Message-State: AOJu0YwTwCorYQunn3JqoGfNJIOiOgdVjB+vqobIKa4610I4GDjMGER+
 ZjdspJEHGOM+8Kmr0QVUPX3xbI/5Oa1UgcHRxh4jQZc6FfLO/eCdLA4f+prJ7IzVXlx2aAGFf1D
 lEMbM9ArjfeP8ucjCivUVtVrS0uxl9Fr+WQ4djA==
X-Google-Smtp-Source: AGHT+IFfYHabqyNbRqBtMWxB/QbI1zhf2e5KRqLzBzmxrMcZCqm7O7XheFTWd6Etv4zWF3XQR2lIv/sibe8XlYpRFvI=
X-Received: by 2002:aa7:d0d5:0:b0:58e:2f7c:a9c with SMTP id
 4fb4d7f45d1cf-594bc7cab19mr13330372a12.26.1721035783339; Mon, 15 Jul 2024
 02:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-11-sughosh.ganu@linaro.org>
 <CAFLszTgR4SbhdpT-jNgR+XUNu4B3bH4ijTapOw5w1q2fxfxGMQ@mail.gmail.com>
In-Reply-To: <CAFLszTgR4SbhdpT-jNgR+XUNu4B3bH4ijTapOw5w1q2fxfxGMQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 14:59:32 +0530
Message-ID: <CADg8p97zTQGddF-=xc20VHMaMnFP6iWYSRLK4vxoKsmNsn5x1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/48] lmb: remove local instances of the lmb
 structure variable
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > With the move of the LMB structure to a persistent state, there is no
> > need to declare the variable locally, and pass it as part of the LMB
> > API's. Remove all local variable instances and change the API's
> > correspondingly.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: None
> >
> >  arch/arc/lib/cache.c                 |   4 +-
> >  arch/arm/lib/stack.c                 |   4 +-
> >  arch/arm/mach-apple/board.c          |  17 ++-
> >  arch/arm/mach-snapdragon/board.c     |  17 ++-
> >  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
> >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >  arch/m68k/lib/bootm.c                |   7 +-
> >  arch/microblaze/lib/bootm.c          |   4 +-
> >  arch/mips/lib/bootm.c                |   9 +-
> >  arch/nios2/lib/bootm.c               |   4 +-
> >  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >  arch/powerpc/include/asm/mp.h        |   4 +-
> >  arch/powerpc/lib/bootm.c             |  14 +-
> >  arch/riscv/lib/bootm.c               |   4 +-
> >  arch/sh/lib/bootm.c                  |   4 +-
> >  arch/x86/lib/bootm.c                 |   4 +-
> >  arch/xtensa/lib/bootm.c              |   4 +-
> >  board/xilinx/common/board.c          |   7 +-
> >  boot/bootm.c                         |  26 ++--
> >  boot/bootm_os.c                      |   5 +-
> >  boot/image-board.c                   |  32 ++---
> >  boot/image-fdt.c                     |  29 ++---
> >  cmd/bdinfo.c                         |   6 +-
> >  cmd/booti.c                          |   2 +-
> >  cmd/bootz.c                          |   2 +-
> >  cmd/load.c                           |   7 +-
> >  drivers/iommu/apple_dart.c           |   7 +-
> >  drivers/iommu/sandbox_iommu.c        |  15 +--
> >  fs/fs.c                              |   7 +-
> >  include/image.h                      |  22 +---
> >  include/lmb.h                        |  39 +++---
> >  lib/lmb.c                            |  81 ++++++------
> >  net/tftp.c                           |   5 +-
> >  net/wget.c                           |   5 +-
> >  test/cmd/bdinfo.c                    |   2 +-
> >  test/lib/lmb.c                       | 187 +++++++++++++--------------
> >  36 files changed, 270 insertions(+), 333 deletions(-)
>
> From this commit until 'test: bdinfo: dump the global LMB memory map'
> ,snow breaks.

Okay, I am making certain changes to the patches to see that the
patches are bisectable. I will check that on snow as well.

-sughosh

>
> Regards,
> Simon
