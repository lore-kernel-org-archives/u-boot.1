Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F2EC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542B788765;
	Tue, 11 Jun 2024 20:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c4x0xgDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873608878B; Tue, 11 Jun 2024 20:52:36 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB30A831A1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dfe1aa7cce2so134451276.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131953; x=1718736753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BOZOBcjQ5lrDxpY8up2SsDkrf4ejjbncCyHhMvmGu4o=;
 b=c4x0xgDzUkTi7c7dEpKpR4bIlgBfV2eSkZoQN2ozyhQmguNL6OsKkvwDrn+VpSphb+
 Scogi46pQaxzCXv63bE7tvMPjUCtmegQgrrgHhkGObqB5QxjfWZf8v/49InTsbrvGzg8
 EbiM2NdMI7L5gV3NRczBpUsJTnV2H1dVjkr5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131953; x=1718736753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOZOBcjQ5lrDxpY8up2SsDkrf4ejjbncCyHhMvmGu4o=;
 b=WHJlFpClt+MhYFRk2qCCQEnwNx9eXFjT5uRAedQmGaKFmYW4YXx/AwIK2Luw9Lwhg4
 Tk8Z4RdzCK7CoVl9800ZtlI+5DdG4kklWQw4bk6aXTGHySyUd5RK6OjiH3ltkOV6h03L
 4OhOeara/lm565f7kBenKhVTew0A+wQiWL24Cj896I4+8X6qNmsfoZ2olNabOB/Y7Ck8
 zwZCwtaFWIzrl11t45eXKaORX9yPzCeIwlv6+vaPLpaE20F1qcB5Bk2Bb/WIGVLkJeu5
 hdSp9Wh5gMTj/8884JHsh5QQu9cTMMW5q/DNMiQDojSBV2IPjcf8N2a9k08Vv2i5lW3C
 xkww==
X-Gm-Message-State: AOJu0YwG8oTJgGCw6SzYU9vISRBqboKyYr4lQOmV3KIodz6GXtpcVHLn
 qiOE3DQHCJuL5qh2974K/bUq99lHP1ayGOSPnUFw2yYTtS6H3CsUghddA76aM7G9Mrc+hUbi+cu
 whKTfJ6FgYRq28tzcxjAoEdMjXwmS+zNj8YUa
X-Google-Smtp-Source: AGHT+IEVaAUX+cCz0tT6E7W5rRWPxOLsO4VTwqI/BKA27ho/OiLTTWEjzBKAzxXstt/vAVH7GwhAlArAQ0FO1r5ubd0=
X-Received: by 2002:a25:740f:0:b0:dfb:c58:69ca with SMTP id
 3f1490d57ef6-dfb0c586adbmr9186080276.51.1718131952884; Tue, 11 Jun 2024
 11:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-5-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:22 -0600
Message-ID: <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the move of the LMB structure to a persistent state, there is no
> need to declare the variable locally, and pass it as part of the LMB
> API's. Remove all local variable instances and change the API's
> correspondingly.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  arch/arc/lib/cache.c                 |   4 +-
>  arch/arm/lib/stack.c                 |   4 +-
>  arch/arm/mach-apple/board.c          |  17 ++-
>  arch/arm/mach-snapdragon/board.c     |  17 ++-
>  arch/arm/mach-stm32mp/dram_init.c    |   7 +-
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
>  arch/m68k/lib/bootm.c                |   7 +-
>  arch/microblaze/lib/bootm.c          |   4 +-
>  arch/mips/lib/bootm.c                |   9 +-
>  arch/nios2/lib/bootm.c               |   4 +-
>  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
>  arch/powerpc/include/asm/mp.h        |   4 +-
>  arch/powerpc/lib/bootm.c             |  14 +-
>  arch/riscv/lib/bootm.c               |   4 +-
>  arch/sh/lib/bootm.c                  |   4 +-
>  arch/x86/lib/bootm.c                 |   4 +-
>  arch/xtensa/lib/bootm.c              |   4 +-
>  board/xilinx/common/board.c          |   7 +-
>  boot/bootm.c                         |  26 ++--
>  boot/bootm_os.c                      |   5 +-
>  boot/image-board.c                   |  32 ++---
>  boot/image-fdt.c                     |  29 ++---
>  cmd/bdinfo.c                         |   6 +-
>  cmd/booti.c                          |   2 +-
>  cmd/bootz.c                          |   2 +-
>  cmd/load.c                           |   7 +-
>  drivers/iommu/apple_dart.c           |   7 +-
>  drivers/iommu/sandbox_iommu.c        |  15 +--
>  fs/fs.c                              |   7 +-
>  include/image.h                      |  22 +---
>  include/lmb.h                        |  39 +++---
>  lib/lmb.c                            |  81 ++++++------
>  net/tftp.c                           |   5 +-
>  net/wget.c                           |   5 +-
>  test/cmd/bdinfo.c                    |   2 +-
>  test/lib/lmb.c                       | 187 +++++++++++++--------------
>  36 files changed, 270 insertions(+), 333 deletions(-)

This isn't necessary...and it will make things harder. You can have a
global 'lmb' while still allowing passing a different pointer when
needed.

Regards,
Simon
