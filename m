Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97996C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E6087F51;
	Tue, 30 Jul 2024 21:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFrnz1B+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19A6888A1; Tue, 30 Jul 2024 21:47:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26E287919
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b791cddfcbso21073476d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722368845; x=1722973645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DJ3i96JTkjFHcMl1SbR02zm4BMU/CRCUrl40oUuuZZg=;
 b=CFrnz1B+UwcQCUjJoHNAerVyuTEm4aIt96ltsgJzoJXC6dSr8ZoZQxI+pulj1LTQa9
 M1nr2HKzEa41jIdNNqD4rK7VIVwuTzEJGblHWYYrUzTl7goHnflYe+rP+Lo1gf5c4jjj
 4iI47422pom2+tLtGZd+BpRNqpWMG5aeRnoK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368845; x=1722973645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJ3i96JTkjFHcMl1SbR02zm4BMU/CRCUrl40oUuuZZg=;
 b=G0FnrpMDnUNL+IVcEyUzi3OGGHNme+bEJ9VOvwIIbPdj7WumNvaUpu6LS5LdWhcnUR
 OC8Xp5Kojz8lEBTSVFnjBydHH5m48HaskkL2VZYJ1E8URVBLgk5Dkc4LzV3xWPpZ8G4v
 BwPuyb0i0jY5QuVdkWwqk/2VWNFkCYj2030fgS+HCNMwr9kQHdMSsIvp9cE8DZqjT26W
 66QleSt2XMgaoZTVAxTdX/zJTzLJbDu4K3i6aRBae8XuPK8qdTYCzyl7fj+v8qtTHIhX
 ZOWzEBwLedSA/x4r9vJJhwe0/M1oyO1EEmreKRY2ryfu4a62dowUNa3AtvCe+DLbDunt
 XjlQ==
X-Gm-Message-State: AOJu0YzwmwRSkFPTTlr0yBkZLN0R7auO4uUPvLl6kT2lU9WFoPEgypRR
 0PyRF5B80cKETvKfQYjGRAxY8VG60ATO7Jrj4eIM+8unKz3RLUYesurznBGV8C1meT8eGJofVJZ
 lyfxZwBfsQVKhV6zSKlAJE1U2X1FcyTQb5oEb
X-Google-Smtp-Source: AGHT+IFeKb5yQwAZ6X45aVUwrebLpJz3t3xHPy7q28EseBOTr/BsjpmQL3jYXRNg7woo2JCwJsvg6F9sUFiq9Sq9hLs=
X-Received: by 2002:a05:6214:c4f:b0:6b7:a36e:294c with SMTP id
 6a1803df08f44-6bb55ae6817mr76887416d6.57.1722368845610; Tue, 30 Jul 2024
 12:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-12-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-12-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 13:47:14 -0600
Message-ID: <CAFLszTigqxP-wbxmxUUSkrHauL2UrSpQV4e9XK8gDJ4H=e7a2g@mail.gmail.com>
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

[..]

> diff --git a/lib/lmb.c b/lib/lmb.c
> index 4d39c0d1f9..dd6f22654c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
[..]
> -static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
> +static void lmb_remove_region(struct alist *lmb_rgn_lst, unsigned long r)
>  {
>         unsigned long i;
> +       struct lmb_region *rgn = lmb_rgn_lst->data;
>
> -       for (i = r; i < rgn->cnt - 1; i++) {
> -               rgn->region[i].base = rgn->region[i + 1].base;
> -               rgn->region[i].size = rgn->region[i + 1].size;
> -               rgn->region[i].flags = rgn->region[i + 1].flags;
> +       for (i = r; i < lmb_rgn_lst->count - 1; i++) {
> +               rgn[i].base = rgn[i + 1].base;
> +               rgn[i].size = rgn[i + 1].size;
> +               rgn[i].flags = rgn[i + 1].flags;

This should be:

rgn[i] = rgn[i+1]
[..]

Regards,
Simon
