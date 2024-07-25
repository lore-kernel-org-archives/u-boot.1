Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FC0C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191EA884AC;
	Fri, 26 Jul 2024 01:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dmKZxM/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDD98841E; Fri, 26 Jul 2024 01:32:39 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8AC884E2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1da7cafccso5502885a.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950356; x=1722555156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emg4TvXoGBI/Oyu3czhdV7w848y+VetrTIEm5tWn3yQ=;
 b=dmKZxM/jTkymlMXsrtP/dVhDW2+bqEy7xRUESTTTTDv4GRt/zZJjsQPUw2gWTF9hPF
 X8S/rmXV5gL7JrOvmNYhox3biGd/As+n11mGeRzwVxJvl6XuLPnxFKP+iS0I66T4zNpX
 44+4mSKZJqc23m1ZirCWfaac8ejTS+RJM6Lqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950356; x=1722555156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emg4TvXoGBI/Oyu3czhdV7w848y+VetrTIEm5tWn3yQ=;
 b=lb4+KIcvkS9bAnUC4FOolzLbNA7gqZI31gfeWP7ppvG6m2Wtaqt4mlYgxLz3h1Jui4
 pR+mMBLadkyIesRZt0TE1tMZmoAhaRlnlsgzapcrVnDLR7lPy/mxs9hMSS4svQPmziDQ
 WzoyMKVRHrZrAcfxkgJXaUls83hiJZ6AVhZRooVWwc/IGEztjoirmiO5pkD/gH3MZj4p
 QakeUvsaKGASwGTn6UQFoSZRNB83Y0AA6wPv7CoLFxqxNKhF5UBI2LwXCmNQUN9d54Mq
 EUi9cOfsDH8bH+8D+vZKDG3f7mREKVI4/+Pa+Td6VNedlMcF0hOJ7vBfiokwLx1jjv04
 +FOQ==
X-Gm-Message-State: AOJu0YxO3nEWdxmEtHdNqckGTb/5CeOY1+/Y/WWc0AUkzyotR+7AsY1v
 gw5ktadYZx7Zz1A9yA8gkclSLAt0ic1gqce6Hb3QRY586znngyhz3n47xn/Z7VCJ1Atj8FkjUQ1
 fA6NiG2Ba3KjmQ4Nz9qYDqwMoJ7FFVmGZ9F1Y
X-Google-Smtp-Source: AGHT+IF+xe00Ge/6+8ChZyEBAbGtrUU7/ZMxc69RrADo5pIIhHFRUszCHfD6vOIZ0RiiJT+05o1/CL9HUW03gQ/o3nA=
X-Received: by 2002:ad4:5c8a:0:b0:6b5:d90d:ea3c with SMTP id
 6a1803df08f44-6bb406d2da9mr45421386d6.3.1721950356588; Thu, 25 Jul 2024
 16:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-12-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-12-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:25 -0600
Message-ID: <CAFLszTi+zHHQErpBx+_6g5OP7xX1soWAUDLLzvtv1O7SSO-P+w@mail.gmail.com>
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

On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The current LMB API's for allocating and reserving memory use a
> per-caller based memory view. Memory allocated by a caller can then be
> overwritten by another caller. Make these allocations and reservations
> persistent using the alloced list data structure.
>
> Two alloced lists are declared -- one for the available(free) memory,
> and one for the used memory. Once full, the list can then be extended
> at runtime.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc:
> * Squash patches 9 - 11, 13  from the rfc v2 series into a single
>   patch to make it bisectable.
>
>  arch/arc/lib/cache.c                 |   4 +-
>  arch/arm/lib/stack.c                 |   4 +-
>  arch/arm/mach-apple/board.c          |  17 +-
>  arch/arm/mach-snapdragon/board.c     |  17 +-
>  arch/arm/mach-stm32mp/dram_init.c    |   8 +-
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
>  arch/m68k/lib/bootm.c                |   7 +-
>  arch/microblaze/lib/bootm.c          |   4 +-
>  arch/mips/lib/bootm.c                |  11 +-
>  arch/nios2/lib/bootm.c               |   4 +-
>  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
>  arch/powerpc/include/asm/mp.h        |   4 +-
>  arch/powerpc/lib/bootm.c             |  14 +-
>  arch/riscv/lib/bootm.c               |   4 +-
>  arch/sh/lib/bootm.c                  |   4 +-
>  arch/x86/lib/bootm.c                 |   4 +-
>  arch/xtensa/lib/bootm.c              |   4 +-
>  board/xilinx/common/board.c          |   8 +-
>  boot/bootm.c                         |  26 +-
>  boot/bootm_os.c                      |   5 +-
>  boot/image-board.c                   |  34 +--
>  boot/image-fdt.c                     |  36 ++-
>  cmd/bdinfo.c                         |   6 +-
>  cmd/booti.c                          |   2 +-
>  cmd/bootz.c                          |   2 +-
>  cmd/elf.c                            |   2 +-
>  cmd/load.c                           |   7 +-
>  drivers/iommu/apple_dart.c           |   8 +-
>  drivers/iommu/sandbox_iommu.c        |  16 +-
>  fs/fs.c                              |   7 +-
>  include/image.h                      |  28 +-
>  include/lmb.h                        | 114 +++-----
>  lib/efi_loader/efi_dt_fixup.c        |   2 +-
>  lib/efi_loader/efi_helper.c          |   2 +-
>  lib/lmb.c                            | 395 +++++++++++++++------------
>  net/tftp.c                           |   5 +-
>  net/wget.c                           |   5 +-
>  test/cmd/bdinfo.c                    |   2 +-
>  test/lib/lmb.c                       | 205 ++++++--------
>  39 files changed, 477 insertions(+), 560 deletions(-)

I might have missed it, but I didn't see a response to my comment on
the previous patch. I think we should have the lmb state in a struct
so that sandbox tests can reset it as needed.

Regards,
Simon
