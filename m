Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB42CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF3288246;
	Thu, 11 Apr 2024 06:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="IN3aHzq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8668B88244; Thu, 11 Apr 2024 06:33:33 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7175288216
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Thu, 11 Apr 2024 14:31:02 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712810010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8+AXP59DavwgU9PbtXWkM6bR6n185MAl+ONevsoMhQ=;
 b=IN3aHzq1qK/EtiUdxzDGmWaeTfQrlEhEsvrxpSfauYtkE7WQscQDIjx4+Mg1LhgPy1Xtjo
 R/vT+t5cariFcy7WC9NmID6G2ppFi7q7FXzAOGJJuh/KJ1Q6vasIyblFDwPIeXPUokPz5y
 Ezlq5K8y8jqpWO9pQ8VWcO4znp2kbmz/7z/fzMGdXIwfeoOYZf68nK93EvoLX5HrnKAjak
 OS03R0gJF87pCrGRod21UGxua8pJL5qU9oEEClcxKtNF1W9R4CZ8CtvUrUHHSHULnD6DWL
 nZzFwu8AD/42ZIDMvlOJyABbKmlMc+Wah4rQ7R1GVpMusmT3aY4guMoE6E/HqA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Sam Edwards <CFSworks@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v1 1/2] sunxi: SPL SPI: Add SPI boot support for the
 Allwinner R528/T113 SoCs
Message-ID: <ZhdnhgKlz3fAsKm6@titan>
References: <20231111133432.755363-1-bigunclemax@gmail.com>
 <20231111133432.755363-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111133432.755363-2-bigunclemax@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

Hi there,

I've been using my own independent implementation of this patch but
today I gave this one a test in my tree and found out it works.

The code looks fine in comparison, so here's a Tested-by and a
Reviewed-by.

John.

Tested-by: John Watts <contact@jookia.org>
Reviewed-by: John Watts <contact@jookia.org>

On Sat, Nov 11, 2023 at 04:33:07PM +0300, Maksim Kiselev wrote:
> R528/T113 SoCs uses the same SPI IP as the H6, also have the same clocks
> and reset bits layout, but the CCU base is different. Another difference
> is that the new SoCs do not have a clock divider inside. Instead of this
> we should configure sample mode depending on input clock rate.
> 
> The pin assignment is also different: the H6 uses PC0, the R528/T113 PC4
> instead. This makes for a change in spi0_pinmux_setup() routine.
> 
> This patch extends the H6/H616 #ifdef guards to also cover the R528/T113,
> using the shared CONFIG_SUNXI_GEN_NCAT2 and CONFIG_MACH_SUN8I_R528
> symbols. Also use CONFIG_SUNXI_GEN_NCAT2 symbol for the Kconfig
> dependency.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Tested-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig         |  2 +-
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 78 +++++++++++++++++++++--------
>  2 files changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index a10e4c06b6..732f60821a 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1044,7 +1044,7 @@ config SPL_STACK_R_ADDR
>  
>  config SPL_SPI_SUNXI
>  	bool "Support for SPI Flash on Allwinner SoCs in SPL"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
>  	help
>  	  Enable support for SPI Flash. This option allows SPL to read from
>  	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> index c2410dd7bb..ba3b1579f0 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -73,18 +73,27 @@
>  #define SUN6I_CTL_ENABLE            BIT(0)
>  #define SUN6I_CTL_MASTER            BIT(1)
>  #define SUN6I_CTL_SRST              BIT(31)
> +#define SUN6I_TCR_SDM               BIT(13)
>  #define SUN6I_TCR_XCH               BIT(31)
>  
>  /*****************************************************************************/
>  
> -#define CCM_AHB_GATING0             (0x01C20000 + 0x60)
> -#define CCM_H6_SPI_BGR_REG          (0x03001000 + 0x96c)
> -#ifdef CONFIG_SUN50I_GEN_H6
> -#define CCM_SPI0_CLK                (0x03001000 + 0x940)
> +#if IS_ENABLED(CONFIG_SUN50I_GEN_H6)
> +#define CCM_BASE                    0x03001000
> +#elif IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
> +#define CCM_BASE                    0x02001000
>  #else
> -#define CCM_SPI0_CLK                (0x01C20000 + 0xA0)
> +#define CCM_BASE                    0x01C20000
>  #endif
> -#define SUN6I_BUS_SOFT_RST_REG0     (0x01C20000 + 0x2C0)
> +
> +#define CCM_AHB_GATING0             (CCM_BASE + 0x60)
> +#define CCM_H6_SPI_BGR_REG          (CCM_BASE + 0x96c)
> +#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
> +#define CCM_SPI0_CLK                (CCM_BASE + 0x940)
> +#else
> +#define CCM_SPI0_CLK                (CCM_BASE + 0xA0)
> +#endif
> +#define SUN6I_BUS_SOFT_RST_REG0     (CCM_BASE + 0x2C0)
>  
>  #define AHB_RESET_SPI0_SHIFT        20
>  #define AHB_GATE_OFFSET_SPI0        20
> @@ -102,17 +111,22 @@
>   */
>  static void spi0_pinmux_setup(unsigned int pin_function)
>  {
> -	/* All chips use PC0 and PC2. */
> -	sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
> +	/* All chips use PC2. And all chips use PC0, except R528/T113 */
> +	if (!IS_ENABLED(CONFIG_MACH_SUN8I_R528))
> +		sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
> +
>  	sunxi_gpio_set_cfgpin(SUNXI_GPC(2), pin_function);
>  
> -	/* All chips except H6 and H616 use PC1. */
> -	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
> +	/* All chips except H6/H616/R528/T113 use PC1. */
> +	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
> +	    !IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>  		sunxi_gpio_set_cfgpin(SUNXI_GPC(1), pin_function);
>  
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6))
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>  		sunxi_gpio_set_cfgpin(SUNXI_GPC(5), pin_function);
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>  		sunxi_gpio_set_cfgpin(SUNXI_GPC(4), pin_function);
>  
>  	/* Older generations use PC23 for CS, newer ones use PC3. */
> @@ -126,7 +140,8 @@ static void spi0_pinmux_setup(unsigned int pin_function)
>  static bool is_sun6i_gen_spi(void)
>  {
>  	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
> -	       IS_ENABLED(CONFIG_SUN50I_GEN_H6);
> +	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> +	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
>  }
>  
>  static uintptr_t spi0_base_address(void)
> @@ -137,6 +152,9 @@ static uintptr_t spi0_base_address(void)
>  	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
>  		return 0x05010000;
>  
> +	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
> +		return 0x04025000;
> +
>  	if (!is_sun6i_gen_spi() ||
>  	    IS_ENABLED(CONFIG_MACH_SUNIV))
>  		return 0x01C05000;
> @@ -152,23 +170,30 @@ static void spi0_enable_clock(void)
>  	uintptr_t base = spi0_base_address();
>  
>  	/* Deassert SPI0 reset on SUN6I */
> -	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
> +	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> +	    IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  		setbits_le32(CCM_H6_SPI_BGR_REG, (1U << 16) | 0x1);
>  	else if (is_sun6i_gen_spi())
>  		setbits_le32(SUN6I_BUS_SOFT_RST_REG0,
>  			     (1 << AHB_RESET_SPI0_SHIFT));
>  
>  	/* Open the SPI0 gate */
> -	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
> +	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
> +	    !IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  		setbits_le32(CCM_AHB_GATING0, (1 << AHB_GATE_OFFSET_SPI0));
>  
>  	if (IS_ENABLED(CONFIG_MACH_SUNIV)) {
>  		/* Divide by 32, clock source is AHB clock 200MHz */
>  		writel(SPI0_CLK_DIV_BY_32, base + SUN6I_SPI0_CCTL);
>  	} else {
> -		/* Divide by 4 */
> -		writel(SPI0_CLK_DIV_BY_4, base + (is_sun6i_gen_spi() ?
> -					  SUN6I_SPI0_CCTL : SUN4I_SPI0_CCTL));
> +		/* New SoCs do not have a clock divider inside */
> +		if (!IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
> +			/* Divide by 4 */
> +			writel(SPI0_CLK_DIV_BY_4,
> +			       base + (is_sun6i_gen_spi() ? SUN6I_SPI0_CCTL :
> +			       SUN4I_SPI0_CCTL));
> +		}
> +
>  		/* 24MHz from OSC24M */
>  		writel((1 << 31), CCM_SPI0_CLK);
>  	}
> @@ -180,6 +205,14 @@ static void spi0_enable_clock(void)
>  		/* Wait for completion */
>  		while (readl(base + SUN6I_SPI0_GCR) & SUN6I_CTL_SRST)
>  			;
> +
> +		/*
> +		 * For new SoCs we should configure sample mode depending on
> +		 * input clock. As 24MHz from OSC24M is used, we could use
> +		 * normal sample mode by setting SDM bit in the TCR register
> +		 */
> +		if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
> +			setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_SDM);
>  	} else {
>  		/* Enable SPI in the master mode and reset FIFO */
>  		setbits_le32(base + SUN4I_SPI0_CTL, SUN4I_CTL_MASTER |
> @@ -206,11 +239,13 @@ static void spi0_disable_clock(void)
>  		writel(0, CCM_SPI0_CLK);
>  
>  	/* Close the SPI0 gate */
> -	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6))
> +	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
> +	    !IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  		clrbits_le32(CCM_AHB_GATING0, (1 << AHB_GATE_OFFSET_SPI0));
>  
>  	/* Assert SPI0 reset on SUN6I */
> -	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6))
> +	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> +	    IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  		clrbits_le32(CCM_H6_SPI_BGR_REG, (1U << 16) | 0x1);
>  	else if (is_sun6i_gen_spi())
>  		clrbits_le32(SUN6I_BUS_SOFT_RST_REG0,
> @@ -224,7 +259,8 @@ static void spi0_init(void)
>  	if (IS_ENABLED(CONFIG_MACH_SUN50I) ||
>  	    IS_ENABLED(CONFIG_SUN50I_GEN_H6))
>  		pin_function = SUN50I_GPC_SPI0;
> -	else if (IS_ENABLED(CONFIG_MACH_SUNIV))
> +	else if (IS_ENABLED(CONFIG_MACH_SUNIV) ||
> +		 IS_ENABLED(CONFIG_MACH_SUN8I_R528))
>  		pin_function = SUNIV_GPC_SPI0;
>  
>  	spi0_pinmux_setup(pin_function);
> -- 
> 2.40.1
> 
