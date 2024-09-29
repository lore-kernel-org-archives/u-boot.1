Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244BCF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B086188815;
	Sun, 29 Sep 2024 13:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YzjKOC9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B768885D; Sun, 29 Sep 2024 13:00:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50488870D
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c70e=Q3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727607602;
 bh=ZvHd4LnOa1Sa9FDwHWyVJcfiwbzdshRTJqJMoj1BFgw=;
 b=YzjKOC9oA1ystOsWaqzOnlo99hn/pxf1dcdn4G8yx3OBDcdIWKpC92p81F9adjtTqYuO5DoVI
 CzsX+7s6+IZxUOCqg8CtZ0ViDIowmYgYj1VRffTGaqIiRJ3gFftMSmkiffXL+rnNeneAFirZCsO
 Tsd6aeptP+VxUHPNyz/wCvr2weArlpsCT5Y8bY8X/aSvDWdRarjnXTwEwa/of+Cm6gAA/oRPuLo
 MBaLgQUmjCIPlUNc/bjmLfMBWW+Hi5VB9KU+hKx5R9zSURmZh6STDPjP0Nwnbp4ZWtMKSfrJjko
 /jtmBqpyE54VOSPMPa7+nVjca13BwybWZ2W7CgY2ie4A==
Message-ID: <1099eb05-949a-41ec-9ffd-fad4498224a6@kwiboo.se>
Date: Sun, 29 Sep 2024 12:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/30] global: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-6-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240928200030.194546-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66f9332f07d6cfacc5036ed0
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

On 2024-09-28 22:00, Simon Glass wrote:
> Use the new symbol to refer to any 'SPL' build, including TPL and VPL
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 

[snip]

> diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
> index 0c375e543a5..edb2a31c348 100644
> --- a/arch/arm/include/asm/arch-rockchip/boot0.h
> +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
> @@ -12,7 +12,7 @@
>   * To make life easier for everyone, we build the SPL binary with
>   * space for this 4-byte header already included in the binary.
>   */
> -#ifdef CONFIG_SPL_BUILD
> +#ifdef CONFIG_XPL_BUILD
>  	/*
>  	 * We need to add 4 bytes of space for the 'RK33' at the
>  	 * beginning of the executable.	 However, as we want to keep
> @@ -39,7 +39,7 @@ entry_counter:
>  	.word   0
>  #endif
>  
> -#if (defined(CONFIG_SPL_BUILD) || defined(CONFIG_ARM64))
> +#if (defined(CONFIG_XPL_BUILD) || defined(CONFIG_ARM64))
>  	/* U-Boot proper of armv7 do not need this */
>  	b reset
>  #endif
> @@ -54,7 +54,7 @@ _start:
>  	ARM_VECTORS
>  #endif
>  
> -#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_SPL_BUILD) && \
> +#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \

This is meant to be for SPL where TF-A is loaded into part of SRAM,
and is only needed/used when CONFIG_TPL=n, so no need to replace it with
XPL_BUILD.

>  	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
>  	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for the ATF data */
>  #endif
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> index 49a1f763795..ae273de3144 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> @@ -11,7 +11,7 @@
>  #define KHz		1000
>  #define OSC_HZ		(24 * MHz)
>  
> -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
>  #define APLL_HZ		(1008 * MHz)
>  #else
>  #define APLL_HZ		(816 * MHz)
> @@ -20,7 +20,7 @@
>  #define CPLL_HZ		(500 * MHz)
>  #define HPLL_HZ		(1400 * MHz)
>  #define PCLK_PDPMU_HZ	(100 * MHz)
> -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
>  #define ACLK_PDBUS_HZ	(396 * MHz)
>  #else
>  #define ACLK_PDBUS_HZ	(500 * MHz)
> @@ -32,7 +32,7 @@
>  #define HCLK_PDCORE_HZ	(200 * MHz)
>  #define HCLK_PDAUDIO_HZ	(150 * MHz)
>  #define CLK_OSC0_DIV_HZ	(32768)
> -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
>  #define ACLK_PDVI_HZ	(297 * MHz)
>  #define CLK_ISP_HZ	(297 * MHz)
>  #define ACLK_PDISPP_HZ	(297 * MHz)
> @@ -324,7 +324,7 @@ enum {
>  	DCLK_VOP_DIV_SHIFT	= 0,
>  	DCLK_VOP_DIV_MASK	= 0xff,
>  
> -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
>  	/* CRU_CLK_SEL49_CON */
>  	ACLK_PDVI_SEL_SHIFT	= 6,
>  	ACLK_PDVI_SEL_MASK	= 0x3 << ACLK_PDVI_SEL_SHIFT,
> @@ -397,7 +397,7 @@ enum {
>  	CLK_GMAC_SRC_DIV_SHIFT	= 0,
>  	CLK_GMAC_SRC_DIV_MASK	= 0x1f << CLK_GMAC_SRC_DIV_SHIFT,
>  
> -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
>  	/* CRU_CLK_SEL68_CON */
>  	ACLK_PDISPP_SEL_SHIFT	= 6,
>  	ACLK_PDISPP_SEL_MASK	= 0x3 << ACLK_PDISPP_SEL_SHIFT,

I am pretty sure all these are meant for SPL where it is possible to
SPL_KERNEL_BOOT, so no need to replace these with XPL_BUILD.

[snip]

> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index 2d7d0f82a2f..edccb2a3980 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -51,7 +51,7 @@ static struct mm_region rk3399_mem_map[] = {
>  
>  struct mm_region *mem_map = rk3399_mem_map;
>  
> -#ifdef CONFIG_SPL_BUILD
> +#ifdef CONFIG_XPL_BUILD
>  
>  #define TIMER_END_COUNT_L	0x00
>  #define TIMER_END_COUNT_H	0x04
> @@ -83,7 +83,7 @@ void rockchip_stimer_init(void)
>  int arch_cpu_init(void)
>  {
>  
> -#ifdef CONFIG_SPL_BUILD
> +#ifdef CONFIG_XPL_BUILD
>  	struct rk3399_pmusgrf_regs *sgrf;
>  	struct rk3399_grf_regs *grf;
>  
> @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
>  	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
>  	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
>  
> -	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
> +	if (IS_ENABLED(CONFIG_XPL_BUILD) &&

This should not be changed to XPL, this part is meant for SPL and does
not even compile when CONFIG_TPL=y and TPL_BUILD is defined.

>  	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
>  	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
>  		rk_setreg(&grf->io_vsel, 1 << 0);
> @@ -169,7 +169,7 @@ void board_debug_uart_init(void)
>  }
>  #endif
>  
> -#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)

Following is intended for SPL as can be observed from the !TPL_BUILD,
please do not change this to XPL_BUILD.

>  static void rk3399_force_power_on_reset(void)
>  {
>  	ofnode node;

[snip]

> diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
> index c9f61e933e9..25ceab98ee9 100644
> --- a/drivers/ram/rockchip/sdram_rk3288.c
> +++ b/drivers/ram/rockchip/sdram_rk3288.c
> @@ -84,7 +84,7 @@ const int ddrconf_table[] = {
>  #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
>  
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

DRAM is initialized in TPL or SPL (when CONFIG_TPL=n) on Rockchip, so no
need to change this to XPL_BUILD.

>  static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
>  {
>  	int i;
> @@ -1013,7 +1013,7 @@ static int rk3288_dmc_of_to_plat(struct udevice *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_SPL_BUILD */
> +#endif /* CONFIG_XPL_BUILD */

This is related to the above #if so does not need to be changed.

>  
>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  static int conv_of_plat(struct udevice *dev)
> @@ -1041,7 +1041,7 @@ static int conv_of_plat(struct udevice *dev)
>  static int rk3288_dmc_probe(struct udevice *dev)
>  {
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same here.

>  	struct rk3288_sdram_params *plat = dev_get_plat(dev);
>  	struct udevice *dev_clk;
>  	struct regmap *map;
> @@ -1051,7 +1051,7 @@ static int rk3288_dmc_probe(struct udevice *dev)
>  
>  	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same.

>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  	ret = conv_of_plat(dev);
>  	if (ret)
> @@ -1119,13 +1119,13 @@ U_BOOT_DRIVER(rockchip_rk3288_dmc) = {
>  	.of_match = rk3288_dmc_ids,
>  	.ops = &rk3288_dmc_ops,
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same.

>  	.of_to_plat = rk3288_dmc_of_to_plat,
>  #endif
>  	.probe = rk3288_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same.

>  	.plat_auto	= sizeof(struct rk3288_sdram_params),
>  #endif
>  };
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 45270e27184..c3745f9445b 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -3196,7 +3196,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
>  	.probe = rk3399_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same on RK3399, DRAM is initialized in TPL or SPL, so no need to change
this.

>  	.plat_auto	= sizeof(struct rockchip_dmc_plat),
>  #endif
>  };
> diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
> index 4fbb088a8d9..b371f597d23 100644
> --- a/drivers/ram/rockchip/sdram_rv1126.c
> +++ b/drivers/ram/rockchip/sdram_rv1126.c
> @@ -34,7 +34,7 @@
>  
>  struct dram_info {
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

And same on RV1126, DRAM is initialized in TPL or SPL when CONFIG_TPL=n,
so no need to change this to XPL_BUILD.

>  	void __iomem *pctl;
>  	void __iomem *phy;
>  	struct rv1126_cru *cru;
> @@ -49,7 +49,7 @@ struct dram_info {
>  };
>  
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same.

>  
>  #define GRF_BASE_ADDR			0xfe000000
>  #define PMU_GRF_BASE_ADDR		0xfe020000
> @@ -3507,7 +3507,7 @@ error:
>  static int rv1126_dmc_probe(struct udevice *dev)
>  {
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))

Same.

>  	if (rv1126_dmc_init(dev))
>  		return 0;
>  #else

[snip]

> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index 2bc704e1104..a59f2a61e6a 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -40,7 +40,7 @@
>  #define _CONFIG_PREFIX TPL_
>  #elif defined(CONFIG_VPL_BUILD)
>  #define _CONFIG_PREFIX VPL_
> -#elif defined(CONFIG_SPL_BUILD)
> +#elif defined(CONFIG_XPL_BUILD)

There is most likely no need to replace this with XPL_BUILD, since we
already check for the other phases above.

>  #define _CONFIG_PREFIX SPL_
>  #else
>  #define _CONFIG_PREFIX
> @@ -53,8 +53,8 @@
>  /*
>   * CONFIG_VAL(FOO) evaluates to the value of
>   *  CONFIG_TOOLS_FOO if USE_HOSTCC is defined,
> - *  CONFIG_FOO if CONFIG_SPL_BUILD is undefined,
> - *  CONFIG_SPL_FOO if CONFIG_SPL_BUILD is defined.
> + *  CONFIG_FOO if CONFIG_XPL_BUILD is undefined,
> + *  CONFIG_SPL_FOO if CONFIG_XPL_BUILD is defined.

Similar here, there is no need to replace this with XPL_BUILD for the
CONFIG_SPL line.

>   *  CONFIG_TPL_FOO if CONFIG_TPL_BUILD is defined.
>   *  CONFIG_VPL_FOO if CONFIG_VPL_BUILD is defined.
>   */
> @@ -106,22 +106,22 @@ long invalid_use_of_IF_ENABLED_INT(void);
>  /*
>   * CONFIG_IS_ENABLED(FOO) expands to
>   *  1 if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
> - *  1 if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  1 if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  1 if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> + *  1 if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',

Same.

>   *  1 if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  0 otherwise.
>   *
>   * CONFIG_IS_ENABLED(FOO, (abc)) expands to
>   *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
> - *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> + *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',

Same.

>   *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  nothing otherwise.
>   *
>   * CONFIG_IS_ENABLED(FOO, (abc), (def)) expands to
>   *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
> - *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> + *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',

Same.

>   *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  def otherwise.
>   *

[snip]

> diff --git a/include/spl.h b/include/spl.h
> index de808ccd413..dd9aeeaf9cc 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -51,7 +51,7 @@ static inline bool u_boot_first_phase(void)
>  		if (IS_ENABLED(CONFIG_TPL_BUILD))
>  			return true;
>  	} else if (IS_ENABLED(CONFIG_SPL)) {
> -		if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		if (IS_ENABLED(CONFIG_XPL_BUILD))

Probably no need to replace SPL_BUILD with XPL_BUILD here.

This function should probably be fixed to properly support/report VPL
before this patch.

>  			return true;
>  	} else {
>  		return true;
> @@ -90,7 +90,7 @@ enum u_boot_phase {
>   *
>   * To include code only in SPL, you might do:
>   *
> - *    #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> + *    #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
>   *    ...
>   *    #endif
>   *
> @@ -102,7 +102,7 @@ enum u_boot_phase {
>   *
>   * To include code only in U-Boot proper, you might do:
>   *
> - *    #ifndef CONFIG_SPL_BUILD
> + *    #ifndef CONFIG_XPL_BUILD
>   *    ...
>   *    #endif
>   *
> @@ -120,7 +120,7 @@ static inline enum u_boot_phase spl_phase(void)
>  	return PHASE_TPL;
>  #elif defined(CONFIG_VPL_BUILD)
>  	return PHASE_VPL;
> -#elif defined(CONFIG_SPL_BUILD)
> +#elif defined(CONFIG_XPL_BUILD)

TPL_BUILD and VPL_BUILD is already checked the lines before this so
probably no need to replace SPL_BUILD with XPL_BUILD here.

>  	return PHASE_SPL;
>  #else
>  	DECLARE_GLOBAL_DATA_PTR;
> @@ -135,7 +135,7 @@ static inline enum u_boot_phase spl_phase(void)
>  /* returns true if in U-Boot proper, false if in SPL */
>  static inline bool spl_in_proper(void)
>  {
> -#ifdef CONFIG_SPL_BUILD
> +#ifdef CONFIG_XPL_BUILD
>  	return false;
>  #endif
>  
> @@ -154,7 +154,7 @@ static inline enum u_boot_phase spl_prev_phase(void)
>  	return PHASE_NONE;
>  #elif defined(CONFIG_VPL_BUILD)
>  	return PHASE_TPL;	/* VPL requires TPL */
> -#elif defined(CONFIG_SPL_BUILD)
> +#elif defined(CONFIG_XPL_BUILD)
>  	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL :
>  		IS_ENABLED(CONFIG_TPL) ? PHASE_TPL :
>  		PHASE_NONE;
> @@ -227,7 +227,7 @@ static inline const char *spl_phase_prefix(enum u_boot_phase phase)
>  }
>  
>  /* A string name for SPL or TPL */
> -#ifdef CONFIG_SPL_BUILD
> +#ifdef CONFIG_XPL_BUILD
>  # ifdef CONFIG_TPL_BUILD
>  #  define SPL_TPL_NAME	"TPL"
>  # elif defined(CONFIG_VPL_BUILD)

[snip]

> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index ad21d451a30..63d4ec334bc 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -31,7 +31,7 @@ include $(srctree)/scripts/Kbuild.include
>  UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
>  
>  KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
> -KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
> +KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD

This should not be changed to XPL_BUILD.

>  ifeq ($(CONFIG_TPL_BUILD),y)
>  KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
>  else
> @@ -55,7 +55,7 @@ endif
>  
>  export SPL_NAME
>  
> -ifdef CONFIG_SPL_BUILD
> +ifdef CONFIG_XPL_BUILD
>  SPL_ := SPL_
>  ifeq ($(CONFIG_VPL_BUILD),y)
>  SPL_TPL_ := VPL_

[snip]

Regards,
Jonas

