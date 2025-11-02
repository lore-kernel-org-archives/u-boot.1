Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36AECCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 00:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129318307F;
	Sun,  2 Nov 2025 01:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Kb+pEXii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76838307F; Sun,  2 Nov 2025 01:50:56 +0100 (CET)
Received: from mail-m1033.netease.com (mail-m1033.netease.com [154.81.10.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09A282A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 01:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 280888861;
 Sun, 2 Nov 2025 08:50:48 +0800 (GMT+08:00)
Message-ID: <fe161f4a-57e8-4914-a181-de76017414a3@rock-chips.com>
Date: Sun, 2 Nov 2025 08:50:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clk: rockchip: rk3368: Add bus clk get/set
To: WeiHao Li <cn.liweihao@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 lukma@denx.de, seanga2@gmail.com, ag.dev.uboot@gmail.com,
 muratdemirtaseu@outlook.com
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
 <20250814131237.8135-2-cn.liweihao@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250814131237.8135-2-cn.liweihao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a420b9d5203afkunm840419a5a1dcf0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEJPVh8eHx1LHUNIHU5KQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Kb+pEXiiN8+QBWc7VEVwDu0JD7HIOL0wOYo0ApFRqvE5RfwLA+HlC6vE4+90Ycj5pBJPk/o9dTQXAXv0LqhE6y0YKmKqciMiexUhXADdhtk7Hh1wfYsfuxAi1pWKd2teezJsGcqlzeHRy6B6zI9O1tdbb8SJYxvX/ma1bmYxyEc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=z7qr/nAKs+PvpE6c1nKC2ks7Wi8yYp1J4lEe8zRcLgw=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/8/14 21:12, WeiHao Li wrote:
> Some of board need operate PMIC like RK808-B for power supply. It's
> depends on I2C peripheral, this patch add bus clock get/set function
> which include I2C clock support.
>
> This patch get form Rockchip downstream uboot repository.
>
> Link: https://github.com/rockchip-linux/u-boot
>
> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../include/asm/arch-rockchip/cru_rk3368.h    | 12 +++
>   drivers/clk/rockchip/clk_rk3368.c             | 94 +++++++++++++++++++
>   2 files changed, 106 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
> index ed2a61218..845113f13 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
> @@ -80,6 +80,18 @@ enum {
>   	PLL_RESET			= 1,
>   	PLL_RESET_MASK			= GENMASK(5, 5),
>   
> +	/* CLKSEL8CON */
> +	PCLK_BUS_DIV_CON_SHIFT		= 12,
> +	PCLK_BUS_DIV_CON_MASK		= 0x7 << PCLK_BUS_DIV_CON_SHIFT,
> +	HCLK_BUS_DIV_CON_SHIFT		= 8,
> +	HCLK_BUS_DIV_CON_MASK		= 0x3 << HCLK_BUS_DIV_CON_SHIFT,
> +	CLK_BUS_PLL_SEL_CPLL		= 0,
> +	CLK_BUS_PLL_SEL_GPLL		= 1,
> +	CLK_BUS_PLL_SEL_SHIFT		= 7,
> +	CLK_BUS_PLL_SEL_MASK		= 1 << CLK_BUS_PLL_SEL_SHIFT,
> +	ACLK_BUS_DIV_CON_SHIFT		= 0,
> +	ACLK_BUS_DIV_CON_MASK		= 0x1f << ACLK_BUS_DIV_CON_SHIFT,
> +
>   	/* CLKSEL12_CON */
>   	MCU_STCLK_DIV_SHIFT		= 8,
>   	MCU_STCLK_DIV_MASK		= GENMASK(10, 8),
> diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
> index 630253fbb..994330162 100644
> --- a/drivers/clk/rockchip/clk_rk3368.c
> +++ b/drivers/clk/rockchip/clk_rk3368.c
> @@ -453,6 +453,82 @@ static ulong rk3368_saradc_set_clk(struct rk3368_cru *cru, uint hz)
>   	return rk3368_saradc_get_clk(cru);
>   }
>   
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +static ulong rk3368_bus_get_clk(struct rk3368_cru *cru, ulong clk_id)
> +{
> +	u32 div, con, parent;
> +
> +	switch (clk_id) {
> +	case ACLK_BUS:
> +		con = readl(&cru->clksel_con[8]);
> +		div = (con & ACLK_BUS_DIV_CON_MASK) >> ACLK_BUS_DIV_CON_SHIFT;
> +		parent = rkclk_pll_get_rate(cru, GPLL);
> +		break;
> +	case HCLK_BUS:
> +		con = readl(&cru->clksel_con[8]);
> +		div = (con & HCLK_BUS_DIV_CON_MASK) >> HCLK_BUS_DIV_CON_SHIFT;
> +		parent = rk3368_bus_get_clk(cru, ACLK_BUS);
> +		break;
> +	case PCLK_BUS:
> +	case PCLK_PWM0:
> +	case PCLK_PWM1:
> +	case PCLK_I2C0:
> +	case PCLK_I2C1:
> +		con = readl(&cru->clksel_con[8]);
> +		div = (con & PCLK_BUS_DIV_CON_MASK) >> PCLK_BUS_DIV_CON_SHIFT;
> +		parent = rk3368_bus_get_clk(cru, ACLK_BUS);
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	return DIV_TO_RATE(parent, div);
> +}
> +
> +static ulong rk3368_bus_set_clk(struct rk3368_cru *cru,
> +				ulong clk_id, ulong hz)
> +{
> +	int src_clk_div;
> +
> +	/*
> +	 * select gpll as pd_bus bus clock source and
> +	 * set up dependent divisors for PCLK/HCLK and ACLK clocks.
> +	 */
> +	switch (clk_id) {
> +	case ACLK_BUS:
> +		src_clk_div = DIV_ROUND_UP(rkclk_pll_get_rate(cru, GPLL), hz);
> +		assert(src_clk_div - 1 < 31);
> +		rk_clrsetreg(&cru->clksel_con[8],
> +			     CLK_BUS_PLL_SEL_MASK | ACLK_BUS_DIV_CON_MASK,
> +			     CLK_BUS_PLL_SEL_GPLL << CLK_BUS_PLL_SEL_SHIFT |
> +			     (src_clk_div - 1) << ACLK_BUS_DIV_CON_SHIFT);
> +		break;
> +	case HCLK_BUS:
> +		src_clk_div = DIV_ROUND_UP(rk3368_bus_get_clk(cru,
> +							      ACLK_BUS),
> +					   hz);
> +		assert(src_clk_div - 1 < 3);
> +		rk_clrsetreg(&cru->clksel_con[8],
> +			     HCLK_BUS_DIV_CON_MASK,
> +			     (src_clk_div - 1) << HCLK_BUS_DIV_CON_SHIFT);
> +		break;
> +	case PCLK_BUS:
> +		src_clk_div = DIV_ROUND_UP(rk3368_bus_get_clk(cru,
> +							      ACLK_BUS),
> +					   hz);
> +		assert(src_clk_div - 1 < 3);
> +		rk_clrsetreg(&cru->clksel_con[8],
> +			     PCLK_BUS_DIV_CON_MASK,
> +			     (src_clk_div - 1) << PCLK_BUS_DIV_CON_SHIFT);
> +		break;
> +	default:
> +		printf("do not support this bus freq\n");
> +		return -EINVAL;
> +	}
> +	return rk3368_bus_get_clk(cru, clk_id);
> +}
> +#endif
> +
>   static ulong rk3368_clk_get_rate(struct clk *clk)
>   {
>   	struct rk3368_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -469,6 +545,17 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
>   	case SCLK_SPI0 ... SCLK_SPI2:
>   		rate = rk3368_spi_get_clk(priv->cru, clk->id);
>   		break;
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +	case ACLK_BUS:
> +	case HCLK_BUS:
> +	case PCLK_BUS:
> +	case PCLK_PWM0:
> +	case PCLK_PWM1:
> +	case PCLK_I2C0:
> +	case PCLK_I2C1:
> +		rate = rk3368_bus_get_clk(priv->cru, clk->id);
> +		break;
> +#endif
>   #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
>   	case HCLK_SDMMC:
>   	case HCLK_EMMC:
> @@ -500,6 +587,13 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
>   		ret = rk3368_ddr_set_clk(priv->cru, rate);
>   		break;
>   #endif
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +	case ACLK_BUS:
> +	case HCLK_BUS:
> +	case PCLK_BUS:
> +		rate = rk3368_bus_set_clk(priv->cru, clk->id, rate);
> +		break;
> +#endif
>   #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
>   	case HCLK_SDMMC:
>   	case HCLK_EMMC:
