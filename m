Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A778CEBF60
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 00:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A4188F68;
	Fri, 27 Sep 2024 02:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZVypsomT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864B388FBD; Fri, 27 Sep 2024 02:13:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC00B88E7E
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 02:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3c7c=QZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727396020;
 bh=CoP6r5bBhEQA/AuBvOTVjhVK1PUsJ0xLLUXkyaPZrnI=;
 b=ZVypsomT2HCOUJ/IKa6Ca531Y2gxoIukAqnlTn4cd62AS/ITXpJLtoLMYmPdhoFnss5cugkxm
 hHmVX+QdaBSjKZW686zP98dScug/TSn90ZOYPmzxI5ExbKGGtYN2mhIyask5BpgU4l2kCxy3v1h
 Lo/jqLGauqdjAHbmi8Row83SzHjZjyuDKxOwKhQrq8QLWdNw1ZRm5SyVMrGlxEpoSM//DQRj7a9
 ysPqnZp82efdoaTgM/rZFPJyertbThulp6SO/H07KH6geYt/AEK4m1wQ1K6t7PW1iP2bULWZiht
 6C7kgagkq8QhkKfWEqk5SXmyBF6/AfPjiDxFLPWfbh9w==
Message-ID: <8615c7b6-37b2-4c2f-989a-b1780310ff86@kwiboo.se>
Date: Fri, 27 Sep 2024 02:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/42] rockchip: Simplify check for SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Tim Lunn <tim@feathertop.org>,
 huang lin <hl@rock-chips.com>
References: <20240926223814.1276764-1-sjg@chromium.org>
 <20240926223814.1276764-15-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240926223814.1276764-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f5f8b38735f533539b2c53
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

On 2024-09-27 00:35, Simon Glass wrote:
> Now that SPL means SPL (only) and is not defined for TPL, simplify some
> checks for SPL.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/include/asm/arch-rockchip/boot0.h |  3 +--
>  arch/arm/mach-rockchip/rk3399/rk3399.c     |  2 +-
>  drivers/clk/rockchip/clk_rk3368.c          |  8 ++++----
>  drivers/ram/rockchip/sdram_rk3288.c        | 10 +++++-----
>  drivers/ram/rockchip/sdram_rk3399.c        |  2 +-
>  drivers/ram/rockchip/sdram_rv1126.c        |  9 +++------
>  6 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
> index edb2a31c348..918f0495fa0 100644
> --- a/arch/arm/include/asm/arch-rockchip/boot0.h
> +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
> @@ -54,7 +54,6 @@ _start:
>  	ARM_VECTORS
>  #endif
>  
> -#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
> -	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
> +#if defined(CONFIG_SPL_BUILD) && (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)

This was changed from SPL to XPL just to be changed back to SPL in this
patch?, such change probably just clutter git blame, was the change to
use XPL really necessary in the first place?

Because SPL_BUILD was used together with !TPL_BUILD it is pretty obvious
that SPL_BUILD did not need to change to XPL_BUILD in the first place.

>  	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for the ATF data */
>  #endif
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index edccb2a3980..47bcc71038b 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -169,7 +169,7 @@ void board_debug_uart_init(void)
>  }
>  #endif
>  
> -#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> +#if defined(CONFIG_SPL_BUILD)

Same.

>  static void rk3399_force_power_on_reset(void)
>  {
>  	ofnode node;
> diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
> index 630253fbb1d..5ba19bce7b2 100644
> --- a/drivers/clk/rockchip/clk_rk3368.c
> +++ b/drivers/clk/rockchip/clk_rk3368.c
> @@ -50,7 +50,7 @@ struct pll_div {
>  		       (_nr * _no) == hz, #hz "Hz cannot be hit with PLL " \
>  		       "divisors on line " __stringify(__LINE__));
>  
> -#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
>  static const struct pll_div apll_l_init_cfg = PLL_DIVISORS(APLL_L_HZ, 12, 2);
>  static const struct pll_div apll_b_init_cfg = PLL_DIVISORS(APLL_B_HZ, 1, 2);
>  #if !defined(CONFIG_TPL_BUILD)
> @@ -88,7 +88,7 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
>  	}
>  }
>  
> -#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
>  static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
>  			 const struct pll_div *div)
>  {
> @@ -130,7 +130,7 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
>  }
>  #endif
>  
> -#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
>  static void rkclk_init(struct rk3368_cru *cru)
>  {
>  	u32 apllb, aplll, dpll, cpll, gpll;
> @@ -586,7 +586,7 @@ static int rk3368_clk_probe(struct udevice *dev)
>  
>  	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
>  #endif
> -#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
>  	rkclk_init(priv->cru);
>  #endif
>  
> diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
> index 25ceab98ee9..b6d51068baa 100644
> --- a/drivers/ram/rockchip/sdram_rk3288.c
> +++ b/drivers/ram/rockchip/sdram_rk3288.c
> @@ -84,7 +84,7 @@ const int ddrconf_table[] = {
>  #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
>  
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
>  {
>  	int i;
> @@ -1041,7 +1041,7 @@ static int conv_of_plat(struct udevice *dev)
>  static int rk3288_dmc_probe(struct udevice *dev)
>  {
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  	struct rk3288_sdram_params *plat = dev_get_plat(dev);
>  	struct udevice *dev_clk;
>  	struct regmap *map;
> @@ -1051,7 +1051,7 @@ static int rk3288_dmc_probe(struct udevice *dev)
>  
>  	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  	ret = conv_of_plat(dev);
>  	if (ret)
> @@ -1119,13 +1119,13 @@ U_BOOT_DRIVER(rockchip_rk3288_dmc) = {
>  	.of_match = rk3288_dmc_ids,
>  	.ops = &rk3288_dmc_ops,
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  	.of_to_plat = rk3288_dmc_of_to_plat,
>  #endif
>  	.probe = rk3288_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  	.plat_auto	= sizeof(struct rk3288_sdram_params),
>  #endif
>  };
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index c3745f9445b..45270e27184 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -3196,7 +3196,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
>  	.probe = rk3399_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
>  #if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))

Same.

>  	.plat_auto	= sizeof(struct rockchip_dmc_plat),
>  #endif
>  };
> diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
> index b371f597d23..58fd589f68e 100644
> --- a/drivers/ram/rockchip/sdram_rv1126.c
> +++ b/drivers/ram/rockchip/sdram_rv1126.c
> @@ -33,8 +33,7 @@
>  #define DESKEW_MDF_DIFF_VAL		(1)
>  
>  struct dram_info {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)

This changes meaning of the code, similar to other rockchip sdram code
this should only change CONFIG_XPL_BUILD back to CONFIG_SPL_BUILD.

DRAM on rockchip platform is initialized by TPL, or SPL when CONFIG_TPL
is not enabled, not both in TPL and SPL.

>  	void __iomem *pctl;
>  	void __iomem *phy;
>  	struct rv1126_cru *cru;
> @@ -48,8 +47,7 @@ struct dram_info {
>  	struct rv1126_pmugrf *pmugrf;
>  };
>  
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)

Same.

>  
>  #define GRF_BASE_ADDR			0xfe000000
>  #define PMU_GRF_BASE_ADDR		0xfe020000
> @@ -3506,8 +3504,7 @@ error:
>  
>  static int rv1126_dmc_probe(struct udevice *dev)
>  {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +#if defined(CONFIG_TPL_BUILD) || defined(CONFIG_SPL_BUILD)

Same.

Regards,
Jonas

>  	if (rv1126_dmc_init(dev))
>  		return 0;
>  #else

