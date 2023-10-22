Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DBDC001DF
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 03:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DC987696;
	Sun, 22 Oct 2023 05:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="XWh05l84";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="OI2XUlWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE4887698; Sun, 22 Oct 2023 05:41:07 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CDC87695
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 05:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 524195C0126;
 Sat, 21 Oct 2023 23:41:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sat, 21 Oct 2023 23:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697946061; x=1698032461; bh=gwXidKBSU179e7nYuHposqRuFn3MOSY38aD
 9bZqZSG0=; b=XWh05l84QtQBeb5kV9RkFHcXaSfajPU4Diiy3/g+jFV4P3uxke8
 znbgebzkLqTAo/xua4KRumk8hqgqVliAzC/c/Z1ZKJAbnIigUyQEGtIrlUo9982z
 3PIz92TdqPZNdnyVtnTzz8q9cDf07xmOXM5PVmLrJB77RoOSj6sKvmV0NWwlIxds
 OD7M7lD4AZJjzxTbudUQPOEKbdoFVptBKIju3xsOass3nFhkSfKpwiSb0pxDlNhW
 LGD/XHICGRp1QtO/MYhFovwYvboIRc5gZjq5mrHbH5/jJDgZC6b7WeS2/Hyqav9h
 bYmTTUzIZBFZ75CIKra196L4xzAv78Hg4ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697946061; x=1698032461; bh=gwXidKBSU179e7nYuHposqRuFn3MOSY38aD
 9bZqZSG0=; b=OI2XUlWJ1hgfzJmf1CXCNa48KzlaKikP6ekaUD6bG9Ple2IQldK
 063ZHr/5QZI7Ltd0xP2LGoy+djFdKKwhL+HxJIEwtnsD3IjQpa4qU8MWxrHT8pqP
 9iMr4c1v0CuFB+/IJ8yMYYyxSh/HBE+7X6SQQXJfgnDYqY2uC7MFcDH+sxhgtGe8
 +lC48hS0RzUx7gHUyfsMywACaZqg9+8Wvfzh8WuUrEMP5LoF5GWtDzR2RcFHvSem
 M6qhJzDJpLzbaZpMm5AeOkyH/tWM/ZOuc82AWdt9tO8RbUxqLMBfhodsMSrxMoU/
 NzUZkViUvHfUNRrcGXRaEFr0Lo2//5uTAZg==
X-ME-Sender: <xms:zZk0ZXudHCmlxh2HcWqEw3odC835ymjMX_PNEYpJ0YLddNadR7lA4A>
 <xme:zZk0ZYerBVaWFhl7DVSwsCY84qA0WNZABmbhFCODMkfzeUrwn0085IJSYRz8eljgT
 IeFgehvFp4zYFgEkw>
X-ME-Received: <xmr:zZk0ZayqWeKGGyF39S3JcQT2KBzq4iqSJCMKTIwMGAr63VCbcNfon8BzyZ5yLwhNmLghUS3ZlbsoxIEvtuRTafNzljiLXbBSq_hV_vwwtU1fZDGoYm9Z6Us2Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugdejfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:zZk0ZWOf97J7Gt5YUhBAf1TtQYYx3bnVio1ZLPB5SdhdSGa9gT938g>
 <xmx:zZk0ZX-TKbI6KeG19tgjJIuYTvF5osGtR8NTzuOE6Aw-fody1jwyPw>
 <xmx:zZk0ZWWDMtLDRRZ99hZdOIqh2H6EStjo9jIe75fOamJb_UUimml0fw>
 <xmx:zZk0ZTSWuDne09B6oO8ehgQTqU3b4vZSnwi6laQmCZrXhyWtm_UDYg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 23:41:00 -0400 (EDT)
Message-ID: <3d807ad8-650e-e7a3-8067-99e01c5e0905@sholland.org>
Date: Sat, 21 Oct 2023 22:40:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 10/22] sunxi: introduce NCAT2 generation model
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-11-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Andre,

On 9/28/23 16:54, Andre Przywara wrote:
> Allwinner seems to typically stick to a common MMIO memory map for
> several SoCs, but from time to time does some breaking changes, which
> also introduce new generations of some peripherals. The last time this
> happened with the H6, which apart from re-organising the base addresses
> also changed the clock controller significantly. We added a
> CONFIG_SUN50I_GEN_H6 symbol back then to mark SoCs sharing those traits.
> 
> Now the Allwinner D1 changes the memory map again, and also extends the
> pincontroller, among other peripherals.
> To mark this generation of SoCs, add a CONFIG_SUNXI_GEN_NCAT2 symbol,
> this name is reportedly used in the Allwinner BSP code, and prevents us
> from inventing our own name.
> 
> Add this new symbol to some guards that were already checking for the H6
> generation, since many features are shared between the two (like the
> renovated clock controller).
> 
> This paves the way to introduce a first user of this generation.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/arch-sunxi/clock.h       |  2 +-
>  arch/arm/include/asm/arch-sunxi/cpu.h         |  2 +
>  .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  | 43 +++++++++++++++++++
>  arch/arm/include/asm/arch-sunxi/mmc.h         |  2 +-
>  arch/arm/include/asm/arch-sunxi/prcm.h        |  2 +-
>  arch/arm/include/asm/arch-sunxi/timer.h       |  2 +-
>  arch/arm/mach-sunxi/Kconfig                   | 12 +++++-
>  arch/arm/mach-sunxi/Makefile                  |  1 +
>  arch/arm/mach-sunxi/board.c                   | 22 ++++++----
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         |  7 ++-
>  common/spl/Kconfig                            |  2 +-
>  drivers/i2c/mvtwsi.c                          |  3 +-
>  drivers/mmc/sunxi_mmc.c                       |  7 +--
>  include/sunxi_gpio.h                          |  3 ++
>  14 files changed, 90 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock.h b/arch/arm/include/asm/arch-sunxi/clock.h
> index 2cfd5407423..3d34261b0e5 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock.h
> @@ -16,7 +16,7 @@
>  /* clock control module regs definition */
>  #if defined(CONFIG_MACH_SUN8I_A83T)
>  #include <asm/arch/clock_sun8i_a83t.h>
> -#elif defined(CONFIG_SUN50I_GEN_H6)
> +#elif defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>  #include <asm/arch/clock_sun50i_h6.h>
>  #elif defined(CONFIG_MACH_SUN6I) || defined(CONFIG_MACH_SUN8I) || \
>        defined(CONFIG_MACH_SUN50I) || defined(CONFIG_MACH_SUNIV)
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu.h b/arch/arm/include/asm/arch-sunxi/cpu.h
> index b08f2023748..768c6572d6b 100644
> --- a/arch/arm/include/asm/arch-sunxi/cpu.h
> +++ b/arch/arm/include/asm/arch-sunxi/cpu.h
> @@ -10,6 +10,8 @@
>  #include <asm/arch/cpu_sun9i.h>
>  #elif defined(CONFIG_SUN50I_GEN_H6)
>  #include <asm/arch/cpu_sun50i_h6.h>
> +#elif defined(CONFIG_SUNXI_GEN_NCAT2)
> +#include <asm/arch/cpu_sunxi_ncat2.h>
>  #else
>  #include <asm/arch/cpu_sun4i.h>
>  #endif
> diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> new file mode 100644
> index 00000000000..ca92c39927d
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> @@ -0,0 +1,43 @@
> +/*
> + * (C) Copyright 2022 Arm Limited
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#ifndef _SUNXI_CPU_SUNXI_NCAT2_H
> +#define _SUNXI_CPU_SUNXI_NCAT2_H
> +
> +#define SUNXI_CCM_BASE			0x02001000
> +#define SUNXI_TIMER_BASE		0x02050000
> +
> +#define SUNXI_UART0_BASE		0x02500000
> +#define SUNXI_UART1_BASE		0x02500400
> +#define SUNXI_UART2_BASE		0x02500800
> +#define SUNXI_UART3_BASE		0x02500C00
> +#define SUNXI_TWI0_BASE			0x02502000
> +#define SUNXI_TWI1_BASE			0x02502400
> +#define SUNXI_TWI2_BASE			0x02502800
> +#define SUNXI_TWI3_BASE			0x02502C00
> +
> +#define SUNXI_SRAMC_BASE		0x03000000
> +/* SID address space starts at 0x03006000, but e-fuse is at offset 0x200 */
> +#define SUNXI_SIDC_BASE			0x03006000
> +#define SUNXI_SID_BASE			0x03006200
> +#define SUNXI_GIC400_BASE		0x03020000
> +
> +#define SUNXI_MMC0_BASE			0x04020000
> +#define SUNXI_MMC1_BASE			0x04021000
> +#define SUNXI_MMC2_BASE			0x04022000
> +
> +#define SUNXI_R_CPUCFG_BASE		0x07000400
> +#define SUNXI_PRCM_BASE			0x07010000
> +
> +#define SUNXI_CPUCFG_BASE		0x09010000
> +
> +#ifndef __ASSEMBLY__
> +void sunxi_board_init(void);
> +void sunxi_reset(void);
> +int sunxi_get_sid(unsigned int *sid);
> +#endif
> +
> +#endif /* _SUNXI_CPU_SUNXI_NCAT2_H */
> diff --git a/arch/arm/include/asm/arch-sunxi/mmc.h b/arch/arm/include/asm/arch-sunxi/mmc.h
> index 5daacf10eb1..8ed3e0459c9 100644
> --- a/arch/arm/include/asm/arch-sunxi/mmc.h
> +++ b/arch/arm/include/asm/arch-sunxi/mmc.h
> @@ -45,7 +45,7 @@ struct sunxi_mmc {
>  	u32 chda;		/* 0x90 */
>  	u32 cbda;		/* 0x94 */
>  	u32 res2[26];
> -#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
> +#if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>  	u32 res3[17];
>  	u32 samp_dl;
>  	u32 res4[46];
> diff --git a/arch/arm/include/asm/arch-sunxi/prcm.h b/arch/arm/include/asm/arch-sunxi/prcm.h
> index 5106076f5e9..c5418cfd28d 100644
> --- a/arch/arm/include/asm/arch-sunxi/prcm.h
> +++ b/arch/arm/include/asm/arch-sunxi/prcm.h
> @@ -9,7 +9,7 @@
>  #define _SUNXI_PRCM_H
>  
>  /* prcm regs definition */
> -#if defined(CONFIG_SUN50I_GEN_H6)
> +#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>  #include <asm/arch/prcm_sun50i.h>
>  #else
>  #include <asm/arch/prcm_sun6i.h>
> diff --git a/arch/arm/include/asm/arch-sunxi/timer.h b/arch/arm/include/asm/arch-sunxi/timer.h
> index bb5626d893b..e17db8588e2 100644
> --- a/arch/arm/include/asm/arch-sunxi/timer.h
> +++ b/arch/arm/include/asm/arch-sunxi/timer.h
> @@ -76,7 +76,7 @@ struct sunxi_timer_reg {
>  	struct sunxi_tgp tgp[4];
>  	u8 res5[8];
>  	u32 cpu_cfg;
> -#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6)
> +#elif defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>  	u8 res3[16];
>  	struct sunxi_wdog wdog[5];	/* We have 5 watchdogs */
>  #endif
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index d73c5e67050..12eb51b2ea4 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -121,7 +121,7 @@ config AXP_PMIC_BUS
>  config SUNXI_SRAM_ADDRESS
>  	hex
>  	default 0x10000 if MACH_SUN9I || MACH_SUN50I || MACH_SUN50I_H5
> -	default 0x20000 if SUN50I_GEN_H6
> +	default 0x20000 if SUN50I_GEN_H6 || SUNXI_GEN_NCAT2
>  	default 0x0
>  	---help---
>  	Older Allwinner SoCs have their mask boot ROM mapped just below 4GB,
> @@ -189,6 +189,14 @@ config SUN50I_GEN_H6
>  	Select this for sunxi SoCs which have H6 like peripherals, clocks
>  	and memory map.
>  
> +config SUNXI_GEN_NCAT2
> +	bool
> +	select MMC_SUNXI_HAS_NEW_MODE
> +	select SUPPORT_SPL
> +	---help---
> +	Select this for sunxi SoCs which have D1 like peripherals, clocks
> +	and memory map.


This will eventually need to go in board/sunxi/Kconfig, so it can be
selected by D1 (ARCH_SUNXI=n). For now:

Tested-by: Samuel Holland <samuel@sholland.org>

