Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D98C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D7288786;
	Tue, 11 Jun 2024 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BwBXoWAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B4E88783; Tue, 11 Jun 2024 20:52:31 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CFE8870E
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d21ebe1c3aso787209b6e.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131948; x=1718736748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jywJacPV+q23TwsucqceBC8WfGSi1tt5YNCCEboPdo8=;
 b=BwBXoWAwFS46WwEA7KbQ5lS7mpcyPbAlutHEn8+xYmyk/aTUGRlPMdqzJ4Yk1ZlqND
 U5Qc5pfHxGwzboc6BnPhztztzeVHcZ0QcKEcbdR6yjlol5SSFHyb3cXvMGepXgrMHlKZ
 Lzvt4RvBvc54tCExLChbgvr71S5GOZLOLLjPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131948; x=1718736748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jywJacPV+q23TwsucqceBC8WfGSi1tt5YNCCEboPdo8=;
 b=dZqZNTsiajopPFycZf7GAkhy8nImCb+o9swpYBHnen35dOUORKifw6bhHdk1I74y9H
 JPAEeRPx98B4XDyzfoQkuIVdVl6OkzPg7fuoEKaxILSCEZzLkmrNJkYCWdOeRlwlZjcz
 GjQTYakm8RB8PJ78MuBaH/K1x1V0wYbmLBq1yTTbjcqh50YdWktgWLxWi9S44mQTEitV
 Yfpx3hY8wy4gaY9feNA/9vS3v/w3uW4FtBt9pONYrZ1LGjBm9+a5dKL8nXDYZO/k3UL3
 p3TnUdbjSvBT3io2mTC/Ywi10r6Kms3RFQ+5ZbXrgilJqXaauS62HCVwbVcfBuxErleB
 68xg==
X-Gm-Message-State: AOJu0YwGhLHznx3CwWDK/jVUeJxt8loBTO13KXmowvFVgkCGL+gPh2eH
 uZUj2bDK1iteYVArrv+e+Skw24yy49bJyRBsUVmaqqufDH/BA2GvxsMmqhzBpJE4HfC0hs0TYKl
 s/WJ59dkJIGmhYmIYT4fc7thpTckqAPsVNHWL
X-Google-Smtp-Source: AGHT+IGLJfNkS7r3RbIGP9sKh6nM4m3nHxvq2NDbeKX8PQ3EDglUQ7NwsEA4vsdPFe2632CeqMkmF74F7IpHZBroRvo=
X-Received: by 2002:a05:6359:5f90:b0:19f:569e:673 with SMTP id
 e5c5f4694b2df-19f569e0737mr617592255d.29.1718131947949; Tue, 11 Jun 2024
 11:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-4-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:17 -0600
Message-ID: <CAFLszTgGpJOVuwmtD4M5hZb1MFtxgCmTaU0ejy2bafEwP26xYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/31] lmb: make the lmb reservations persistent
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

HI Sughosh,

On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The current LMB API's for allocating and reserving memory use a
> per-caller based memory view. Memory allocated by a caller can then be
> overwritten by another caller. Make these allocations and reservations
> persistent. With this, memory allocated or reserved will not be
> overwritten.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>
> Note: @Mark Kettenis, please review the changes made in the apple dart
> driver. I have removed the driver-local LMB instance, but I am not
> sure if the current logic makes sense. I would think that it would be
> possible to simply use memory region allocated by the LMB module(maybe
> using the max address argument), instead of adding specific memory
> region with lmb_add().
>
>  arch/arm/mach-stm32mp/dram_init.c |  1 -
>  board/xilinx/common/board.c       |  1 -
>  drivers/iommu/apple_dart.c        |  1 -
>  drivers/iommu/sandbox_iommu.c     |  1 -
>  include/lmb.h                     | 17 ++----
>  lib/lmb.c                         | 91 ++++++++++++++++---------------
>  test/lib/lmb.c                    | 18 ------
>  7 files changed, 50 insertions(+), 80 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
> index fb1208fc5d..86d6577b35 100644
> --- a/arch/arm/mach-stm32mp/dram_init.c
> +++ b/arch/arm/mach-stm32mp/dram_init.c
> @@ -59,7 +59,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>         gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
>
>         /* found enough not-reserved memory to relocated U-Boot */
> -       lmb_init(&lmb);
>         lmb_add(&lmb, gd->ram_base, gd->ram_top - gd->ram_base);
>         boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
>         /* add 8M for reserved memory for display, fdt, gd,... */
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index b47d2d23f9..ebe57da7f8 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -685,7 +685,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>                 panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
>
>         /* found enough not-reserved memory to relocated U-Boot */
> -       lmb_init(&lmb);
>         lmb_add(&lmb, gd->ram_base, gd->ram_size);
>         boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
>         size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 6ecd84303b..ef385d9c9f 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -214,7 +214,6 @@ static int apple_dart_probe(struct udevice *dev)
>         priv->dvabase = DART_PAGE_SIZE;
>         priv->dvaend = SZ_4G - DART_PAGE_SIZE;
>
> -       lmb_init(&priv->lmb);
>         lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
>
>         /* Disable translations. */
> diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> index 6ceb7fd5ec..31ce91345c 100644
> --- a/drivers/iommu/sandbox_iommu.c
> +++ b/drivers/iommu/sandbox_iommu.c
> @@ -55,7 +55,6 @@ static int sandbox_iommu_probe(struct udevice *dev)
>  {
>         struct sandbox_iommu_priv *priv = dev_get_priv(dev);
>
> -       lmb_init(&priv->lmb);
>         lmb_add(&priv->lmb, 0x89abc000, SZ_16K);
>
>         return 0;
> diff --git a/include/lmb.h b/include/lmb.h
> index 7b87181b9e..bbe1c5299c 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -49,8 +49,7 @@ struct lmb_property {
>   *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
>   *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
>   *         lmb_region.region is only a pointer to the correct buffer,
> - *         initialized in lmb_init(). This configuration is useful to manage
> - *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
> + *         initialized with these values.
>   */
>
>  /**
> @@ -73,26 +72,18 @@ struct lmb_region {
>  /**
>   * struct lmb - Logical memory block handle.
>   *
> - * Clients provide storage for Logical memory block (lmb) handles.
> - * The content of the structure is managed by the lmb library.
> - * A lmb struct is  initialized by lmb_init() functions.
> - * The lmb struct is passed to all other lmb APIs.
> + * The Logical Memory Block structure which is used to keep track
> + * of available memory which can be used for stuff like loading
> + * images(kernel, initrd, fdt).
>   *
>   * @memory: Description of memory regions.
>   * @reserved: Description of reserved regions.
> - * @memory_regions: Array of the memory regions (statically allocated)
> - * @reserved_regions: Array of the reserved regions (statically allocated)
>   */
>  struct lmb {
>         struct lmb_region memory;
>         struct lmb_region reserved;
> -#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> -       struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> -       struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> -#endif
>  };
>
> -void lmb_init(struct lmb *lmb);
>  void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob);
>  void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
>                                 phys_size_t size, void *fdt_blob);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 4d39c0d1f9..7f34d4a8b0 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -20,6 +20,25 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  #define LMB_ALLOC_ANYWHERE     0
>
> +#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> +struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> +struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> +#endif
> +
> +struct lmb lmb = {
> +#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> +       .memory.max = CONFIG_LMB_MAX_REGIONS,
> +       .reserved.max = CONFIG_LMB_MAX_REGIONS,
> +#else
> +       .memory.max = CONFIG_LMB_MEMORY_REGIONS,
> +       .reserved.max = CONFIG_LMB_RESERVED_REGIONS,
> +       .memory.region = memory_regions,
> +       .reserved.region = reserved_regions,
> +#endif
> +       .memory.cnt = 0,
> +       .reserved.cnt = 0,
> +};

Please use a pointer in global_data, so we can handle tests.

Also for bootstd we likely want to create a new one and 'own
everything'. I haven't thought it through fully, though.

Regards,
Simon
