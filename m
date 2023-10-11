Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03F9CD98E0
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 00:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B1F863F9;
	Wed, 11 Oct 2023 02:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JSjxInoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E028386459; Wed, 11 Oct 2023 02:35:12 +0200 (CEST)
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com
 [101.71.155.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6238615A
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 02:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JSjxInoEKdEbIxacJjjnWBXE/AWyI2hyFk7vGbLxGoLygoIav6fcPktqBYcrmp7QLb1PbgVsfZRHmsxK46knQ0Jy3vrL3NphKkyyWZgoBhwomt7JO6p/eMIp9c7N3Va9k0ygoh0XrJiSOe6fiZKAFCDxbOmbDSJ7Xb5ahkZbf0s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=USwkRxH5Z+u4fVZwHwHJ3y6ZqRwchsSwA6A1KzBNBnQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 032AF4001D9;
 Wed, 11 Oct 2023 08:34:51 +0800 (CST)
Message-ID: <5ec54ea0-23e4-ddc0-1eee-021a0c6c8989@rock-chips.com>
Date: Wed, 11 Oct 2023 08:34:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/7] clk: rockchip: rk3568: add i2s3 clk
Content-Language: en-US
To: Elaine Zhang <zhangqing@rock-chips.com>, lukma@denx.de,
 seanga2@gmail.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
 <20231010085155.31027-3-zhangqing@rock-chips.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231010085155.31027-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT09PVktOGUofQk4ZTkNJGlUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSVVKS0tVSkJZBg++
X-HM-Tid: 0a8b1c286b782eb3kusn032af4001d9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Chw5Izw5DBBWNSgKLy40
 GA4aCyFVSlVKTUJNQkNPT0JITUJJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpJSE5INwY+
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

Hi Elaine,

     Please add commit message, and remove the change id.

     same for other patches.

Thanks,

- Kever

On 2023/10/10 16:51, Elaine Zhang wrote:
> Change-Id: If20fe16260d2b584d4216d1dbabffcb25478fb1d
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   .../include/asm/arch-rockchip/cru_rk3568.h    |  36 +++
>   drivers/clk/rockchip/clk_rk3568.c             | 218 ++++++++++++++++++
>   2 files changed, 254 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> index 9c7ddd751f72..0306ce57e369 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
> @@ -211,6 +211,31 @@ enum {
>   	ACLK_PERIMID_SEL_100M,
>   	ACLK_PERIMID_SEL_24M,
>   
> +	/* CRU_CLK_SEL21_CON */
> +	I2S3_MCLKOUT_TX_SEL_SHIFT	= 15,
> +	I2S3_MCLKOUT_TX_SEL_MASK	= 1 << I2S3_MCLKOUT_TX_SEL_SHIFT,
> +	I2S3_MCLKOUT_TX_SEL_MCLK	= 0,
> +	I2S3_MCLKOUT_TX_SEL_12M,
> +	CLK_I2S3_SEL_SHIFT		= 10,
> +	CLK_I2S3_SEL_MASK		= 0x3 << CLK_I2S3_SEL_SHIFT,
> +	CLK_I2S3_SEL_SRC		= 0,
> +	CLK_I2S3_SEL_FRAC,
> +	CLK_I2S3_SEL_CLKIN,
> +	CLK_I2S3_SEL_XIN12M,
> +	CLK_I2S3_SRC_SEL_SHIFT		= 8,
> +	CLK_I2S3_SRC_SEL_MASK		= 0x3 << CLK_I2S3_SRC_SEL_SHIFT,
> +	CLK_I2S3_SRC_SEL_GPLL		= 0,
> +	CLK_I2S3_SRC_SEL_CPLL,
> +	CLK_I2S3_SRC_SEL_NPLL,
> +	CLK_I2S3_SRC_DIV_SHIFT		= 0,
> +	CLK_I2S3_SRC_DIV_MASK		= 0x7f << CLK_I2S3_SRC_DIV_SHIFT,
> +
> +	/* CRU_CLK_SEL22_CON */
> +	CLK_I2S3_FRAC_NUMERATOR_SHIFT	= 16,
> +	CLK_I2S3_FRAC_NUMERATOR_MASK	= 0xffff << 16,
> +	CLK_I2S3_FRAC_DENOMINATOR_SHIFT	= 0,
> +	CLK_I2S3_FRAC_DENOMINATOR_MASK	= 0xffff,
> +
>   	/* CRU_CLK_SEL27_CON */
>   	CLK_CRYPTO_PKA_SEL_SHIFT	= 6,
>   	CLK_CRYPTO_PKA_SEL_MASK		= 3 << CLK_CRYPTO_PKA_SEL_SHIFT,
> @@ -502,5 +527,16 @@ enum {
>   	/* CRU_CLK_SEL82_CON */
>   	CPLL_100M_DIV_SHIFT		= 0,
>   	CPLL_100M_DIV_MASK		= 0x1f << CPLL_100M_DIV_SHIFT,
> +
> +	/* GRF_SOC_CON2 */
> +	I2S3_MCLKOUT_SEL_SHIFT		= 15,
> +	I2S3_MCLKOUT_SEL_MASK		= 0x1 << I2S3_MCLKOUT_SEL_SHIFT,
> +	I2S3_MCLKOUT_SEL_RX		= 0,
> +	I2S3_MCLKOUT_SEL_TX,
> +	I2S3_MCLK_IOE_SEL_SHIFT		= 3,
> +	I2S3_MCLK_IOE_SEL_MASK		= 0x1 << I2S3_MCLK_IOE_SEL_SHIFT,
> +	I2S3_MCLK_IOE_SEL_CLKIN		= 0,
> +	I2S3_MCLK_IOE_SEL_CLKOUT,
> +
>   };
>   #endif
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 599b7b130eb9..469014439be4 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -13,6 +13,7 @@
>   #include <asm/arch-rockchip/cru_rk3568.h>
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/hardware.h>
> +#include <asm/arch-rockchip/grf_rk3568.h>
>   #include <asm/io.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> @@ -2326,6 +2327,170 @@ static ulong rk3568_uart_set_rate(struct rk3568_clk_priv *priv,
>   	return rk3568_uart_get_rate(priv, clk_id);
>   }
>   
> +#ifndef CONFIG_SPL_BUILD
> +static ulong rk3568_i2s3_get_rate(struct rk3568_clk_priv *priv, ulong clk_id)
> +{
> +	struct rk3568_cru *cru = priv->cru;
> +	struct rk3568_grf *grf = priv->grf;
> +	u32 con, div, src, p_rate;
> +	u32 reg, fracdiv, p_src;
> +	unsigned long m, n;
> +
> +	switch (clk_id) {
> +	case I2S3_MCLKOUT_TX:
> +		con = readl(&cru->clksel_con[21]);
> +		src = (con & I2S3_MCLKOUT_TX_SEL_MASK) >>
> +		      I2S3_MCLKOUT_TX_SEL_SHIFT;
> +		if (src == I2S3_MCLKOUT_TX_SEL_12M)
> +			p_rate = 12000000;
> +		else
> +			p_rate = rk3568_i2s3_get_rate(priv, MCLK_I2S3_2CH_TX);
> +		return p_rate;
> +	case I2S3_MCLKOUT_RX:
> +		con = readl(&cru->clksel_con[83]);
> +		src = (con & I2S3_MCLKOUT_TX_SEL_MASK) >>
> +		      I2S3_MCLKOUT_TX_SEL_SHIFT;
> +		if (src == I2S3_MCLKOUT_TX_SEL_12M)
> +			p_rate = 12000000;
> +		else
> +			p_rate = rk3568_i2s3_get_rate(priv, MCLK_I2S3_2CH_RX);
> +		return p_rate;
> +	case I2S3_MCLKOUT:
> +		con = readl(&grf->soc_con2);
> +		src = (con & I2S3_MCLKOUT_SEL_MASK)
> +		      >> I2S3_MCLKOUT_SEL_SHIFT;
> +		if (src == I2S3_MCLKOUT_SEL_RX)
> +			p_rate = rk3568_i2s3_get_rate(priv, I2S3_MCLKOUT_RX);
> +		else
> +			p_rate = rk3568_i2s3_get_rate(priv, I2S3_MCLKOUT_TX);
> +		return p_rate;
> +	case MCLK_I2S3_2CH_RX:
> +		reg = 83;
> +		break;
> +	case MCLK_I2S3_2CH_TX:
> +		reg = 21;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	con = readl(&cru->clksel_con[reg]);
> +	src = (con & CLK_I2S3_SEL_MASK) >> CLK_I2S3_SEL_SHIFT;
> +	div = (con & CLK_I2S3_SRC_DIV_MASK) >> CLK_I2S3_SRC_DIV_SHIFT;
> +	p_src = (con & CLK_I2S3_SRC_SEL_MASK) >> CLK_I2S3_SRC_SEL_SHIFT;
> +	if (p_src == CLK_I2S3_SRC_SEL_GPLL)
> +		p_rate = priv->gpll_hz;
> +	else if (p_src == CLK_I2S3_SRC_SEL_CPLL)
> +		p_rate = priv->cpll_hz;
> +	else
> +		p_rate = priv->npll_hz;
> +	if (src == CLK_I2S3_SEL_SRC) {
> +		return DIV_TO_RATE(p_rate, div);
> +	} else if (src == CLK_I2S3_SEL_FRAC) {
> +		fracdiv = readl(&cru->clksel_con[reg + 1]);
> +		n = fracdiv & CLK_I2S3_FRAC_NUMERATOR_MASK;
> +		n >>= CLK_I2S3_FRAC_NUMERATOR_SHIFT;
> +		m = fracdiv & CLK_I2S3_FRAC_DENOMINATOR_MASK;
> +		m >>= CLK_I2S3_FRAC_DENOMINATOR_SHIFT;
> +		return DIV_TO_RATE(p_rate, div) * n / m;
> +	} else {
> +		return OSC_HZ / 2;
> +	}
> +}
> +
> +static ulong rk3568_i2s3_set_rate(struct rk3568_clk_priv *priv,
> +				  ulong clk_id, ulong rate)
> +{
> +	struct rk3568_cru *cru = priv->cru;
> +	struct rk3568_grf *grf = priv->grf;
> +	u32 reg, con, clk_src, i2s_src, div;
> +	unsigned long m = 0, n = 0, val;
> +
> +	if (priv->gpll_hz % rate == 0) {
> +		clk_src = CLK_I2S3_SRC_SEL_GPLL;
> +		i2s_src = CLK_I2S3_SEL_SRC;
> +		div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +	} else if (priv->cpll_hz % rate == 0) {
> +		clk_src = CLK_I2S3_SRC_SEL_CPLL;
> +		i2s_src = CLK_I2S3_SEL_SRC;
> +		div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +	} else if (rate == OSC_HZ / 2) {
> +		clk_src = CLK_I2S3_SRC_SEL_GPLL;
> +		i2s_src = CLK_I2S3_SEL_XIN12M;
> +		div = 1;
> +	} else {
> +		clk_src = CLK_I2S3_SRC_SEL_GPLL;
> +		i2s_src = CLK_I2S3_SEL_FRAC;
> +		div = 1;
> +		rational_best_approximation(rate, priv->gpll_hz / div,
> +					    GENMASK(16 - 1, 0),
> +					    GENMASK(16 - 1, 0),
> +					    &m, &n);
> +	}
> +
> +	switch (clk_id) {
> +	case I2S3_MCLKOUT_TX:
> +		if (rate == 12000000) {
> +			rk_clrsetreg(&cru->clksel_con[21],
> +				     I2S3_MCLKOUT_TX_SEL_MASK,
> +				     I2S3_MCLKOUT_TX_SEL_12M <<
> +				     I2S3_MCLKOUT_TX_SEL_SHIFT);
> +		} else {
> +			rk3568_i2s3_set_rate(priv, MCLK_I2S3_2CH_TX, rate),
> +			rk_clrsetreg(&cru->clksel_con[21],
> +				     I2S3_MCLKOUT_TX_SEL_MASK,
> +				     I2S3_MCLKOUT_TX_SEL_MCLK <<
> +				     I2S3_MCLKOUT_TX_SEL_SHIFT);
> +		}
> +		return rk3568_i2s3_get_rate(priv, clk_id);
> +	case I2S3_MCLKOUT_RX:
> +		if (rate == 12000000) {
> +			rk_clrsetreg(&cru->clksel_con[83],
> +				     I2S3_MCLKOUT_TX_SEL_MASK,
> +				     I2S3_MCLKOUT_TX_SEL_12M <<
> +				     I2S3_MCLKOUT_TX_SEL_SHIFT);
> +		} else {
> +			rk3568_i2s3_set_rate(priv, MCLK_I2S3_2CH_RX, rate),
> +			rk_clrsetreg(&cru->clksel_con[21],
> +				     I2S3_MCLKOUT_TX_SEL_MASK,
> +				     I2S3_MCLKOUT_TX_SEL_MCLK <<
> +				     I2S3_MCLKOUT_TX_SEL_SHIFT);
> +		}
> +		return rk3568_i2s3_get_rate(priv, clk_id);
> +	case I2S3_MCLKOUT:
> +		con = readl(&grf->soc_con2);
> +		clk_src = (con & I2S3_MCLKOUT_SEL_MASK)
> +		      >> I2S3_MCLKOUT_SEL_SHIFT;
> +		if (clk_src == I2S3_MCLKOUT_SEL_RX)
> +			rk3568_i2s3_set_rate(priv, I2S3_MCLKOUT_RX, rate);
> +		else
> +			rk3568_i2s3_set_rate(priv, I2S3_MCLKOUT_TX, rate);
> +		return rk3568_i2s3_get_rate(priv, clk_id);
> +	case MCLK_I2S3_2CH_RX:
> +		reg = 83;
> +		break;
> +	case MCLK_I2S3_2CH_TX:
> +		reg = 21;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	rk_clrsetreg(&cru->clksel_con[reg],
> +		     CLK_I2S3_SEL_MASK | CLK_I2S3_SRC_SEL_MASK |
> +		     CLK_I2S3_SRC_DIV_MASK,
> +		     (clk_src << CLK_I2S3_SRC_SEL_SHIFT) |
> +		     (i2s_src << CLK_I2S3_SEL_SHIFT) |
> +		     ((div - 1) << CLK_I2S3_SRC_DIV_SHIFT));
> +	if (m && n) {
> +		val = m << CLK_I2S3_FRAC_NUMERATOR_SHIFT | n;
> +		writel(val, &cru->clksel_con[reg + 1]);
> +	}
> +	return rk3568_i2s3_get_rate(priv, clk_id);
> +}
> +
> +#endif
> +
>   static ulong rk3568_clk_get_rate(struct clk *clk)
>   {
>   	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -2463,6 +2628,13 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
>   	case TCLK_WDT_NS:
>   		rate = OSC_HZ;
>   		break;
> +	case I2S3_MCLKOUT_RX:
> +	case I2S3_MCLKOUT_TX:
> +	case MCLK_I2S3_2CH_RX:
> +	case MCLK_I2S3_2CH_TX:
> +	case I2S3_MCLKOUT:
> +		rate = rk3568_i2s3_get_rate(priv, clk->id);
> +		break;
>   #endif
>   	case SCLK_UART1:
>   	case SCLK_UART2:
> @@ -2648,6 +2820,13 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
>   	case TCLK_WDT_NS:
>   		ret = OSC_HZ;
>   		break;
> +	case I2S3_MCLKOUT_RX:
> +	case I2S3_MCLKOUT_TX:
> +	case MCLK_I2S3_2CH_RX:
> +	case MCLK_I2S3_2CH_TX:
> +	case I2S3_MCLKOUT:
> +		ret = rk3568_i2s3_set_rate(priv, clk->id, rate);
> +		break;
>   #endif
>   	case SCLK_UART1:
>   	case SCLK_UART2:
> @@ -2824,6 +3003,42 @@ static int rk3568_rkvdec_set_parent(struct clk *clk, struct clk *parent)
>   	return 0;
>   }
>   
> +static int __maybe_unused rk3568_i2s3_set_parent(struct clk *clk,
> +						 struct clk *parent)
> +{
> +	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
> +	struct rk3568_grf *grf = priv->grf;
> +
> +	switch (clk->id) {
> +	case I2S3_MCLK_IOE:
> +		if (parent->id == I2S3_MCLKOUT) {
> +			rk_clrsetreg(&grf->soc_con2, I2S3_MCLK_IOE_SEL_MASK,
> +				     I2S3_MCLK_IOE_SEL_CLKOUT <<
> +				     I2S3_MCLK_IOE_SEL_SHIFT);
> +		} else {
> +			rk_clrsetreg(&grf->soc_con2, I2S3_MCLK_IOE_SEL_MASK,
> +				     I2S3_MCLK_IOE_SEL_CLKIN <<
> +				     I2S3_MCLK_IOE_SEL_SHIFT);
> +		}
> +		break;
> +	case I2S3_MCLKOUT:
> +		if (parent->id == I2S3_MCLKOUT_RX) {
> +			rk_clrsetreg(&grf->soc_con2, I2S3_MCLKOUT_SEL_MASK,
> +				     I2S3_MCLKOUT_SEL_RX <<
> +				     I2S3_MCLKOUT_SEL_SHIFT);
> +		} else {
> +			rk_clrsetreg(&grf->soc_con2, I2S3_MCLKOUT_SEL_MASK,
> +				     I2S3_MCLKOUT_SEL_TX <<
> +				     I2S3_MCLKOUT_SEL_SHIFT);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
>   {
>   	switch (clk->id) {
> @@ -2848,6 +3063,9 @@ static int rk3568_clk_set_parent(struct clk *clk, struct clk *parent)
>   	case SCLK_GMAC1_RGMII_SPEED:
>   	case SCLK_GMAC1_RMII_SPEED:
>   		break;
> +	case I2S3_MCLK_IOE:
> +	case I2S3_MCLKOUT:
> +		return rk3568_i2s3_set_parent(clk, parent);
>   	default:
>   		return -ENOENT;
>   	}
