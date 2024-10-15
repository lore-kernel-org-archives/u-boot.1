Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42AFCFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2CA892D3;
	Tue, 15 Oct 2024 06:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i4zVgqJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7969A892B9; Tue, 15 Oct 2024 06:29:03 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A78988FF6
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so13501015ad.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728966535; x=1729571335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPe1c5l18sEQMsut61z8xxj6+fo5A8HohKBAT+ORC4g=;
 b=i4zVgqJbNUB4fT+Q9A2m8sfgqqFtIuYNjqwi527fHlYp+RTxQsGUPlIzqExacM2/3L
 Ntayn4uKxyLHgJOuTvuvm7eIadS2YGhjlJQ6L1vrVrcz/Lfzf/6aaLYekLExny5E3LLU
 eR2bUBHaJM1Vs3HvoONr7V+M9gMHIu4UdRPYBaFBu5oSc0Wt1ibhOkWm+NjSJHnuOLuS
 xbBnqps/ctrMngHVooL5SPetv/NuCF+OCJI6I2B/cDQbLHm31rbwdTxLayq5dWTiiWMX
 jR3T2FaV2ZjFjw3j7BHPPuykDi84DH00J0Mhy68ydE29rjj95w4nsrIGQ037twLXZEvu
 fjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728966535; x=1729571335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPe1c5l18sEQMsut61z8xxj6+fo5A8HohKBAT+ORC4g=;
 b=d8V6rvJ3chk5kqyp7YXk1xn2hqsc9dzyPgwVnJL5ZGVtMLqW8tX/xv3zVbONmMd2nH
 YWR7b29hhKpCrFBnEm7YudSC4pziHWdCwEfpyJlGM53fmiLX7+tS5V4PyVHAgPlsOmwH
 9y6UqoZl6F+hHYneIJRiAKr0K58867e1T7dETrgeIOj0jjUdr/ere/wuTgSNaDWnLrDV
 L9d5k4AlT+bYQu7XZtOMIJ4Qp1MaYISAAt+N8VaCD9HxMrjiJ8RykKDyz+lOubzPDZLo
 nG9wgu9VqjUPuGG6M+GrmKgS5t+VCkFQCMmyABz1fvvfMOUPVBWlCnB32PxZ4WgdfAft
 MDVg==
X-Gm-Message-State: AOJu0Yxfg5a2UYNVXhkeM9jWunFjHBfOF9JisRbz+3rujuDsDGZFbCCp
 eJfbZvLz1MgmykdZnwvfTbY8IVa2dV23ZyYKK4mGhf5fY3JnYTQ5L9MuRDHkXTc6JHRLbDuI2hc
 Phdc0VwXVOvrdEsyxr/q4/gZGTv+Awa7sGrUSJQ==
X-Google-Smtp-Source: AGHT+IEoBt3mhSXsFqbpHDDUmZtDPagZJCkmPM4jFxoNhBO4Zbd96AD/2hFfcP1Kb5JaVbFitCHuM3Xbr/u+wXRrIio=
X-Received: by 2002:a17:902:da81:b0:20c:89b1:e76c with SMTP id
 d9443c01a7336-20cbb1a994bmr142328295ad.30.1728966534891; Mon, 14 Oct 2024
 21:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 07:28:18 +0300
Message-ID: <CAC_iWjKD=05pf=gcfCPUA0mGNbAX+jjyx5D03y0MWJRgxYDPOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Artur Rojek <artur@conclusive.pl>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Simon,

On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wrote:
>
> U-Boot relocates itself to the top of memory and is supposed to avoid
> using any memory below that region. This allows the maximum amount of
> memory to be available for loading images.
>
> The lmb subsystem automatically protects U-Boot's code and data from
> being overwritten. It relies on this region being a contiguous area of
> memory. This setup has worked well for at least 15 years and has been
> documented in the README for as long.
>
> The EFI_LOADER subsystem currently uses memory outside the U-Boot region
> when starting up.
>
> Some of the downstream problems this causes are:
>
> 1. It can overwrite images that have been loaded

So can the load command

> 2. Requires lmb reservations to avoid (1) even if EFI_LOADER is not
>    being used
> 3. Uses regions which scripts expect to be available, e.g. the existing
>    kernel_addr_r variables
> 4. Introduces confusion as to what memory U-Boot can use for itself
>
> This series sets up a very small region of memory which EFI can used at
> start-up, thus avoiding touching memory outside the U-Boot region.

EFI *is* U-Boot memory region. It lies outside the U-Boot binary,
because some services are instantiated on boot. It also *is* U-Boot
executable code. We should start treating it as such

Thanks
/Ilias
>
> There are still a few tables which are not in the bloblist, but that
> will be resolved separately.
>
> Other than tables, the amount of API-visible memory allocated by EFI
> before booting is actually very small: 3 allocations, of a total of
> about 250 bytes. However, there are some areas where EFI allocations are
> done unnecessarily. For example efi_disk_add_dev() uses page-allocation
> to allocate an efi_device_path, then immediately frees it again. In this
> case it would be better to use malloc(). Since each allocation consumes
> a page (4KB), 256KB has been chosen for the size here, enough for 64
> allocations.
>
> As soon as efi_init_obj_list() is called, we know that the EFI subsystem
> is to be used, so we can relax the restrictions and allow EFI to use any
> memory it likes. This is handled using a simple boolean flag in BSS, since
> it cannot happen before relocation.
>
> Changes in v4:
> - Expand the commit message
> - Reword the commit message since this feature is needed
> - Use a different technique to keep the memory-usage in place
> - Drop changes to pool allocation
> - Reorder the patches
> - Rewrite the cover letter
> - Make it a debug message for now
>
> Changes in v3:
> - Add new patch to drop the memset() from efi_alloc()
> - Drop patch to convert device_path allocation to use malloc()
>
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
>
> Simon Glass (5):
>   efi: Drop the memset() from efi_alloc()
>   efi: Show the location of the bounce buffer when debugging
>   event: Add a generic way to reserve memory
>   efi: Reserve some memory for initial use
>   efi: Keep early allocations to the U-Boot region
>
>  common/board_f.c                  |  1 +
>  common/event.c                    |  1 +
>  include/asm-generic/global_data.h |  6 ++++
>  include/efi_loader.h              | 24 +++++++++++++-
>  include/event.h                   | 11 +++++++
>  lib/efi_loader/efi_bootbin.c      |  9 ++++++
>  lib/efi_loader/efi_memory.c       | 54 ++++++++++++++++++++++++-------
>  lib/efi_loader/efi_setup.c        |  5 +++
>  test/py/tests/test_event_dump.py  |  1 +
>  9 files changed, 100 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>
