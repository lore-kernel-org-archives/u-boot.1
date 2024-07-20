Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC8FC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8C388BF2;
	Sat, 20 Jul 2024 08:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ccu697OZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7256C88BFC; Sat, 20 Jul 2024 08:33:18 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED2788648
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1721457195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bd+dyirFEcQvNdKxiEc6yr/FVne4XU5Ko0EQyumnRY=;
 b=ccu697OZ9pdR/3wzKSGIXMxlnEQ+3vZzyH4PMfGPqm1dAgyxktwvSlMOZYsRrZUmTNsIpC
 K5Bs9b0Epl1bvxRDOfujotFeZIJttZZUbM45F582dGisYm3GBrEPj7llkFveLu9Ea8e53H
 pe1Ts7ZjEvt33GoWMoiIgthSjHjrL7W5Gzm1W6ih120jbzcDnyTdAM2zJieIw6Lur6YIHM
 dPvGtTU7A1FvzfkgysliJb4ILzft6d33TXbxntFgLIty+dPHS75VNBR6IYQXFM8CmVQJWV
 cv/itxtpd062pSCRVWl98oYlOnVvXsdsShCU45f1jO7EwuDH7wxv6TGbAQXCdQ==
Date: Sat, 20 Jul 2024 08:33:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jeffy Chen
 <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Massimo Pegorer <massimo.pegorer@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, huang lin
 <hl@rock-chips.com>
Subject: Re: [PATCH 01/14] rockchip: Move the default timer init to a common
 file
In-Reply-To: <20240720061706.2644229-2-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-2-sjg@chromium.org>
Message-ID: <38a3ad583968cd5d1f1525baccefb982@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Simon,

On 2024-07-20 08:16, Simon Glass wrote:
> Rather than repeating the same code in two files (SPL and TPL), move it
> to a shared filed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Looking good to me.  Thanks for the patch.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
>  arch/arm/include/asm/arch-rockchip/timer.h |  3 ++
>  arch/arm/mach-rockchip/Makefile            |  4 +--
>  arch/arm/mach-rockchip/spl.c               | 21 +------------
>  arch/arm/mach-rockchip/spl_common.c        | 36 ++++++++++++++++++++++
>  arch/arm/mach-rockchip/tpl.c               | 30 +-----------------
>  5 files changed, 43 insertions(+), 51 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/spl_common.c
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/timer.h
> b/arch/arm/include/asm/arch-rockchip/timer.h
> index 77b54220447..b5fc738c98c 100644
> --- a/arch/arm/include/asm/arch-rockchip/timer.h
> +++ b/arch/arm/include/asm/arch-rockchip/timer.h
> @@ -15,4 +15,7 @@ struct rk_timer {
>  	u32 timer_int_status;
>  };
> 
> +/** rockchip_stimer_init() - Set up the timer ready for use */
> +void rockchip_stimer_init(void);
> +
>  #endif
> diff --git a/arch/arm/mach-rockchip/Makefile 
> b/arch/arm/mach-rockchip/Makefile
> index c07bdaee4c3..3b13891ec24 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -8,9 +8,9 @@
>  # inaccessible/protected memory (and the bootrom-helper assumes that
>  # the stack-pointer is valid before switching to the U-Boot stack).
>  obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
> +obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
> spl_common.o
>  obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o
> +obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
>  obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> 
>  obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> diff --git a/arch/arm/mach-rockchip/spl.c 
> b/arch/arm/mach-rockchip/spl.c
> index 3ce7e792b5a..bbd223bc524 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -13,6 +13,7 @@
>  #include <ram.h>
>  #include <spl.h>
>  #include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/timer.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> @@ -86,26 +87,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 
> boot_device)
>  #define	TIMER_FMODE	BIT(0)
>  #define	TIMER_RMODE	BIT(1)
> 
> -__weak void rockchip_stimer_init(void)
> -{
> -#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
> -	/* If Timer already enabled, don't re-init it */
> -	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> -
> -	if (reg & TIMER_EN)
> -		return;
> -#ifndef CONFIG_ARM64
> -	asm volatile("mcr p15, 0, %0, c14, c0, 0"
> -		     : : "r"(CONFIG_COUNTER_FREQUENCY));
> -#endif
> -	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
> -	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
> -	       TIMER_CONTROL_REG);
> -#endif
> -}
> -
>  __weak int board_early_init_f(void)
>  {
>  	return 0;
> diff --git a/arch/arm/mach-rockchip/spl_common.c
> b/arch/arm/mach-rockchip/spl_common.c
> new file mode 100644
> index 00000000000..b29f33448ab
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/spl_common.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2019 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +
> +#define TIMER_LOAD_COUNT_L	0x00
> +#define TIMER_LOAD_COUNT_H	0x04
> +#define TIMER_CONTROL_REG	0x10
> +#define TIMER_EN	0x1
> +#define	TIMER_FMODE	BIT(0)
> +#define	TIMER_RMODE	BIT(1)
> +
> +__weak void rockchip_stimer_init(void)
> +{
> +#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
> +	/* If Timer already enabled, don't re-init it */
> +	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> +
> +	if (reg & TIMER_EN)
> +		return;
> +
> +#ifndef CONFIG_ARM64
> +	asm volatile("mcr p15, 0, %0, c14, c0, 0"
> +		     : : "r"(CONFIG_COUNTER_FREQUENCY));
> +#endif
> +
> +	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
> +	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
> +	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
> +	       TIMER_CONTROL_REG);
> +#endif
> +}
> diff --git a/arch/arm/mach-rockchip/tpl.c 
> b/arch/arm/mach-rockchip/tpl.c
> index 50f04f9474a..0e1da8c1c89 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -14,41 +14,13 @@
>  #include <version.h>
>  #include <asm/io.h>
>  #include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/timer.h>
>  #include <linux/bitops.h>
> 
>  #if CONFIG_IS_ENABLED(BANNER_PRINT)
>  #include <timestamp.h>
>  #endif
> 
> -#define TIMER_LOAD_COUNT_L	0x00
> -#define TIMER_LOAD_COUNT_H	0x04
> -#define TIMER_CONTROL_REG	0x10
> -#define TIMER_EN	0x1
> -#define	TIMER_FMODE	BIT(0)
> -#define	TIMER_RMODE	BIT(1)
> -
> -__weak void rockchip_stimer_init(void)
> -{
> -#if defined(CONFIG_ROCKCHIP_STIMER_BASE)
> -	/* If Timer already enabled, don't re-init it */
> -	u32 reg = readl(CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> -
> -	if (reg & TIMER_EN)
> -		return;
> -
> -#ifndef CONFIG_ARM64
> -	asm volatile("mcr p15, 0, %0, c14, c0, 0"
> -		     : : "r"(CONFIG_COUNTER_FREQUENCY));
> -#endif
> -
> -	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
> -	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
> -	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
> -	       TIMER_CONTROL_REG);
> -#endif
> -}
> -
>  void board_init_f(ulong dummy)
>  {
>  	struct udevice *dev;
