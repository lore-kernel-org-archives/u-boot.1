Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45B9C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667D888919;
	Sat, 13 Jul 2024 17:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMl2wMQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57EB488914; Sat, 13 Jul 2024 17:15:53 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB3588901
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-78006198aeeso1845669a12.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883750; x=1721488550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K6+YP7vKi80MGJ/i3IuNjlIRmi47V2F+qxTecSeC9AQ=;
 b=BMl2wMQJlYkvZNgx9T8sRhn0J/G0ujdmCjW/8GEXi9niQQrbUbJGSzvfoEUD5jzvu8
 gA7g2X5uk/FEleJLusiSVWYAfuPSXaE3S/Sxm4oLBJz0v8IiK3oKNfBge9kj/Rn2EVxm
 TaGQuLrBlkd6FZlBEYSf9FqHRk3CsYa24i2zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883750; x=1721488550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K6+YP7vKi80MGJ/i3IuNjlIRmi47V2F+qxTecSeC9AQ=;
 b=Xbc7zWD93nZI9G/qevfsxETS87WAMFHLVLnKbic5jli+Ky0te+u1JmIn/DTlxr7ddB
 cPxalMP1yzCYTOT21aEnLScN5UJPXEhCwN+QIrZdJ+umo6a7ym94L0/hILW/jsBv3PWg
 d2VquS88jvurE2IUQy7u01G7GyesHV0pEpMEyQt2QTADVnW1mzHq1U4K0q1dYmMMR+hp
 Rc3jfUhcG/aCCrNv7zMtR8Q5LRzMzwjZO+dhw7JZIq/y3D9zaB1CQnMrpzNZl7DXJnL4
 ANyMwwl5mRcTXS+l06ZtOdJa4LRmR47P459dV9CC0SSsA/0WyqAXlJ/esrRpqXwtN6KI
 jzDQ==
X-Gm-Message-State: AOJu0YzKoohCLkYRwcmT1Zn3xfJfbwHhmN5QoMnlGjWVbEAjy9ruSird
 p1N7Og70qC5XdUiYPaDikJtOU9apZd5/GhVYOYxBUZTb5RF9fLDM6HnEpjbyzXp986OvCDMfMY9
 llEshf2pRM4cCYg4Sp3gIJ9RFYKvp02lan+xqfYnWk2XDYa0=
X-Google-Smtp-Source: AGHT+IG3vfTsyEHSVtmmqXnQl/uvxP7fjlPfIaGRVupRdIq5QcrZRVsRGNj4FvzhVAA/u2ftnCp+OaGh2fY5Yt/S344=
X-Received: by 2002:a17:90a:d485:b0:2c8:4b95:465d with SMTP id
 98e67ed59e1d1-2caeea90decmr2518065a91.11.1720883749788; Sat, 13 Jul 2024
 08:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-11-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-11-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:32 +0100
Message-ID: <CAFLszTgR4SbhdpT-jNgR+XUNu4B3bH4ijTapOw5w1q2fxfxGMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/48] lmb: remove local instances of the lmb
 structure variable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the move of the LMB structure to a persistent state, there is no
> need to declare the variable locally, and pass it as part of the LMB
> API's. Remove all local variable instances and change the API's
> correspondingly.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
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

From this commit until 'test: bdinfo: dump the global LMB memory map'
,snow breaks.

Regards,
Simon
