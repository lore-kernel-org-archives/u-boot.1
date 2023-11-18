Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DADCC5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6F687503;
	Sat, 18 Nov 2023 18:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izdKpY4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53EFC87252; Sat, 18 Nov 2023 18:12:02 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238D88749D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d9ca471cf3aso2897435276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/0eI9u2LIYAxdW4Tb6WlaLuJVVI3rApHcfV3Y+589aY=;
 b=izdKpY4Cz0RgzpdUPcYXxl2lJli+BiTSUyE2BLBDWrWSvVKRUXOO19Qepp5y6AMBnB
 PX1T3L8E/6AypDajxeLwpANQwBvY6yzFceKAv7Nd3gq+Qxo4BKy7pdBJ6o5FfGLBuKhd
 UA1IX6zZlQ+hZE+wqaqyQOPqz/yTkvYbDZHnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0eI9u2LIYAxdW4Tb6WlaLuJVVI3rApHcfV3Y+589aY=;
 b=xEr6kOSaYg06pkQv5bG5uSjlS7MceXlQAesXXvyBPSRCR4Lip7oXk+3W9tB8r/BPaj
 gjZ6oddXcJ2tHwYW2/ricpwl/vBEf9LDKA/3WoFx4TR9FNYRgS0j4QVcwPYpI3GRU4Yz
 0bhwg7vBkYfMDG8aCS8YjnsCvHiZWqmZojRIJxv0ynrPWwH/MXgqWCU3q4Nj9Dun5NxC
 sVpshfQrmZbhSeQO469ulUuP7kiVne77I2ki/15gFJjKN/I0qlBZbBRfr/wCoexvAc4z
 tpIlJwq6CxCyQbYYJ/kmhyMHnRfacyijetSyKd/AV0pKwc+GrphEJTm/Pdpiyf9Y9ruK
 kJZg==
X-Gm-Message-State: AOJu0YynLN//qe4cjBx8QDZ77ECN/kx7UYvOKNTI6HAizyIv4uvFoJt8
 Dqajl7HBMd62FRMfi3BfotCkH8P+mrR6KJecg63TNg==
X-Google-Smtp-Source: AGHT+IEtm1lvQFcX+dC5n/tnRqYePqauVSnqz+r41sYhCdjkPhEZsRUezaFniwun/TJjj8LsekZeUYQ6fKfUjcBRK8M=
X-Received: by 2002:a25:190b:0:b0:d9b:87f3:54fa with SMTP id
 11-20020a25190b000000b00d9b87f354famr2332040ybz.16.1700327504899; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20230804110448.24589-1-macpaul.lin@mediatek.com>
In-Reply-To: <20230804110448.24589-1-macpaul.lin@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:16 -0700
Message-ID: <CAPnjgZ1za7R0Th8baKTsF9GyEMwU0uiYgnZFEK29kwh_z09=TA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm: mediatek: add mt8195 SOC support
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.denx.de, Fabien Parent <fparent@baylibre.com>, 
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Bear Wang <bear.wang@mediatek.com>, 
 Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <Ryder.Lee@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
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

Hi,

On Fri, 4 Aug 2023 at 05:05, Macpaul Lin <macpaul.lin@mediatek.com> wrote:
>
> From: Fabien Parent <fparent@baylibre.com>
>
> The MediaTek MT8195 is a ARM64-based SoC with a quad-core Cortex-A73 and
> a quad-core Cortex-A53. It is including UART, SPI, USB3.0 device and hosts,
> SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
> and LPDDR4 options.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  MAINTAINERS                            |   2 +
>  arch/arm/dts/mt8195.dtsi               | 370 +++++++++++++++++++++++++
>  arch/arm/mach-mediatek/Kconfig         |  13 +-
>  arch/arm/mach-mediatek/Makefile        |   1 +
>  arch/arm/mach-mediatek/mt8195/Kconfig  |  13 +
>  arch/arm/mach-mediatek/mt8195/Makefile |   3 +
>  arch/arm/mach-mediatek/mt8195/init.c   |  97 +++++++
>  7 files changed, 498 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/mt8195.dtsi
>  create mode 100644 arch/arm/mach-mediatek/mt8195/Kconfig
>  create mode 100644 arch/arm/mach-mediatek/mt8195/Makefile
>  create mode 100644 arch/arm/mach-mediatek/mt8195/init.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

>
> Changes for v2:
>  - Correct node name to t-phy for u3phy0.
>  - Add platform compatible string "mediatek,mt8195-tphy" to all usb phy nodes.
>  - remove clock nodes that software cannot controlled in phy nodes.
>  - Test and add back "mac" for HOST only xhci nodes.
>
> Changes for v3:
>  - Revise device node name from "xhciX: xhciX@" to "xhciX: xhci@".
>
> Changes for v4:
>  - No change.
>
> Changes for v5:
>  - Fix Copyright year to 2023.
>  - Fix memory map in dram_init() to support 8GB onboard memory.
>  - Add '#if !IS_ENABLED(CONFIG_SYSRESET)' with reset_cpu().
>  - Correct reset_cpu() function prototype.
>  - rebase patchset to v2023-10.rc1
>  - Add missing arch/arm/mach-mediatek/mt8195/Kconfig.
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47581cf6fb..4d0f017e7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -369,8 +369,10 @@ ARM MEDIATEK
>  M:     Ryder Lee <ryder.lee@mediatek.com>
>  M:     Weijie Gao <weijie.gao@mediatek.com>
>  M:     Chunfeng Yun <chunfeng.yun@mediatek.com>
> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
>  R:     GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
>  S:     Maintained
> +F:     arch/arm/dts/mt8195.dtsi
>  F:     arch/arm/mach-mediatek/
>  F:     arch/arm/include/asm/arch-mediatek/
>  F:     board/mediatek/


> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 04aa2fd97f..3a2af1cdee 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -67,6 +67,15 @@ config TARGET_MT8183
>           SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
>           and LPDDR4 options.
>
> +config TARGET_MT8195
> +       bool "MediaTek MT8195 SoC"
> +       select ARM64
> +       help
> +         The MediaTek MT8195 is a ARM64-based SoC with a quad-core Cortex-A73 and
> +         a quad-core Cortex-A53. It is including UART, SPI, USB3.0 device and hosts,
> +         SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
> +         and LPDDR4 options.
> +
>  config TARGET_MT8512
>          bool "MediaTek MT8512 M1 Board"
>          select ARM64
> @@ -105,6 +114,7 @@ config SYS_BOARD
>         default "mt7981" if TARGET_MT7981
>         default "mt7986" if TARGET_MT7986
>         default "mt8183" if TARGET_MT8183
> +       default "mt8195" if TARGET_MT8195
>         default "mt8512" if TARGET_MT8512
>         default "mt8516" if TARGET_MT8516
>         default "mt8518" if TARGET_MT8518
> @@ -122,6 +132,7 @@ config SYS_CONFIG_NAME
>         default "mt7981" if TARGET_MT7981
>         default "mt7986" if TARGET_MT7986
>         default "mt8183" if TARGET_MT8183
> +       default "mt8195" if TARGET_MT8195
>         default "mt8512" if TARGET_MT8512
>         default "mt8516" if TARGET_MT8516
>         default "mt8518" if TARGET_MT8518
> @@ -134,7 +145,7 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>         string
>         default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629 || TARGET_MT7622
> -       default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183
> +       default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8195
>         default "media=snand;nandinfo=2k+64" if TARGET_MT7981 || TARGET_MT7986
>         default "lk=1" if TARGET_MT7623
>
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index fc85293f71..fbbb5431d1 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -10,5 +10,6 @@ obj-$(CONFIG_TARGET_MT7629) += mt7629/
>  obj-$(CONFIG_TARGET_MT7981) += mt7981/
>  obj-$(CONFIG_TARGET_MT7986) += mt7986/
>  obj-$(CONFIG_TARGET_MT8183) += mt8183/
> +obj-$(CONFIG_TARGET_MT8195) += mt8195/
>  obj-$(CONFIG_TARGET_MT8516) += mt8516/
>  obj-$(CONFIG_TARGET_MT8518) += mt8518/
> diff --git a/arch/arm/mach-mediatek/mt8195/Kconfig b/arch/arm/mach-mediatek/mt8195/Kconfig
> new file mode 100644
> index 0000000000..a34fa2cf2e
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8195/Kconfig
> @@ -0,0 +1,13 @@
> +if TARGET_MT8195
> +
> +config SYS_BOARD
> +       default "mt8195"
> +
> +config SYS_CONFIG_NAME
> +       default "mt8195"
> +
> +config MTK_BROM_HEADER_INFO
> +       string
> +       default "media=emmc"
> +
> +endif
> diff --git a/arch/arm/mach-mediatek/mt8195/Makefile b/arch/arm/mach-mediatek/mt8195/Makefile
> new file mode 100644
> index 0000000000..886ab7e4eb
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8195/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier:     GPL-2.0
> +
> +obj-y += init.o
> diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
> new file mode 100644
> index 0000000000..8d6b700e7e
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8195/init.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + * Copyright (C) 2023 BayLibre, SAS
> + * Author: Macpaul Lin <macpaul.lin@mediatek.com>
> + * Author: Fabien Parent <fparent@baylibre.com>
> + */
> +
> +#include <clk.h>
> +#include <common.h>
> +#include <cpu_func.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <ram.h>
> +#include <asm/arch/misc.h>
> +#include <asm/armv8/mmu.h>
> +#include <asm/sections.h>
> +#include <asm/system.h>
> +#include <dm/uclass.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +       int ret;
> +
> +       ret = fdtdec_setup_memory_banksize();
> +       if (ret)
> +               return ret;
> +
> +       fdtdec_setup_mem_size_base();
> +
> +       /*
> +        * Limit gd->ram_top not exceeding SZ_4G.
> +        * Because some periphals like mmc requires DMA buffer

spelling

> +        * allocaed below SZ_4G.

spelling

Also please don't put punctuation after SZ_4G as it makes it harder
for people to select it and search


> +        *
> +        * Note: SZ_2M is for adjusting gd->relocaddr,
> +        *       the reserved memory for u-boot itself.
> +        */
> +       if (gd->ram_base + gd->ram_size >= SZ_4G)
> +               gd->mon_len = SZ_4G + gd->ram_base + SZ_2M;
> +
> +       return 0;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +       gd->bd->bi_dram[0].start = gd->ram_base;
> +       gd->bd->bi_dram[0].size = gd->ram_size;
> +
> +       return 0;
> +}
> +
> +int mtk_pll_early_init(void)
> +{
> +       return 0;
> +}
> +
> +int mtk_soc_early_init(void)
> +{
> +       return 0;
> +}
> +
> +#if !IS_ENABLED(CONFIG_SYSRESET)
> +void reset_cpu(void)
> +{
> +       psci_system_reset();
> +}
> +#endif
> +
> +int print_cpuinfo(void)
> +{
> +       printf("CPU:   MediaTek MT8195\n");
> +       return 0;

You should use a sysinfo driver to provide this information

> +}
> +
> +static struct mm_region mt8195_mem_map[] = {
> +       {
> +               /* DDR */
> +               .virt = 0x40000000UL,
> +               .phys = 0x40000000UL,
> +               .size = 0x200000000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
> +       }, {
> +               .virt = 0x00000000UL,
> +               .phys = 0x00000000UL,
> +               .size = 0x20000000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               0,
> +       }
> +};
> +
> +struct mm_region *mem_map = mt8195_mem_map;
> --
> 2.18.0
>

Regards,
Simon
