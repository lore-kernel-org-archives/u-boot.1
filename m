Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1154ED0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8E6892E3;
	Mon, 21 Oct 2024 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BN9LcqLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F48892F4; Mon, 21 Oct 2024 10:19:33 +0200 (CEST)
Received: from mail-m17235.xmail.ntesmail.com (mail-m17235.xmail.ntesmail.com
 [45.195.17.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB29A8897F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BN9LcqLt3TjbRKpAQh7qDflum0nW5a/TBOQ3t+x5aoNdqOZ5gtCtbmWQAGP46sJGEFdHknwUXHsszoNSOMX/WKZef/3da5LRJDxcBERWhnt1t0AT9tRs8ETnLttSIf6fiT5+9Af4DpeGRI2iAKlS1ZmdIAntgius5ugd37dFKew=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Y+6k5ms2E1fdIurRbqAsKI+Rjczs71qPHXs8i8WrUxk=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id C6C375205D1;
 Mon, 21 Oct 2024 16:19:20 +0800 (CST)
Message-ID: <074f7659-5848-44b1-9d22-fd0af1da3dfa@rock-chips.com>
Date: Mon, 21 Oct 2024 16:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: clk: add UART0 clock getter/setter
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 lukma@denx.de, seanga2@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
 <20240822103315.393063-1-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240822103315.393063-1-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0YGFYZTUpJSB9LHk5LQkhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92ae28ccdb03afkunmc6c375205d1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N1E6Ngw4PTIpNS4QEw8qCxEY
 CCsKFEpVSlVKTElCT0JDTE1ISUxOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTEJDNwY+
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


On 2024/8/22 18:33, Lukasz Czechowski wrote:
> Add dedicated getter and setter for SCLK_UART0_PMU.
> This allows the driver to correctly handle UART0 clocks, and thus
> it fixes the issues with UART0 not working in case DEBUG_UART is
> disabled.
> Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
> clock source for UART is GPLL, instead of external oscillator.
> If the DEBUG_UART is enabled, the clock source is changed in
> board_debug_uart_init function to 24Mhz oscillator, which also
> matches the fallback value obtained from DT node.
> In case the DEBUG_UART is disabled, the UART clock source remains
> default, and the DM serial driver wrongly configures the baud rate,
> resulting in broken communication.
> By implementing the UART clock getter/setter, the serial driver
> can probe the actual configuration and corectly configure itself.
> The DEBUG_UART settings now should not affect it.
>
> The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
> sources, that are managed by CRU, are not yet handled, as likely
> they won't be used in real scenarios.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
>   drivers/clk/rockchip/clk_px30.c               | 105 ++++++++++++++++++
>   2 files changed, 112 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> index b66277fc7f3..504459bd93d 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
> @@ -464,5 +464,12 @@ enum {
>   	UART0_CLK_SEL_UART0_FRAC,
>   	UART0_DIVNP5_SHIFT		= 0,
>   	UART0_DIVNP5_MASK		= 0x1f << UART0_DIVNP5_SHIFT,
> +
> +	/* CRU_PMU_CLKSEL5_CON */
> +	CLK_UART_FRAC_NUMERATOR_SHIFT	= 16,
> +	CLK_UART_FRAC_NUMERATOR_MASK	= 0xffff << CLK_UART_FRAC_NUMERATOR_SHIFT,
> +	CLK_UART_FRAC_DENOMINATOR_SHIFT	= 0,
> +	CLK_UART_FRAC_DENOMINATOR_MASK =
> +	    0xffff << CLK_UART_FRAC_DENOMINATOR_SHIFT,
>   };
>   #endif
> diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
> index 2875c152b20..e5c004cfcc8 100644
> --- a/drivers/clk/rockchip/clk_px30.c
> +++ b/drivers/clk/rockchip/clk_px30.c
> @@ -1589,6 +1589,105 @@ static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
>   	return priv->gpll_hz;
>   }
>   
> +static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
> +{
> +	struct px30_pmucru *pmucru = priv->pmucru;
> +	u32 clk_div_con;
> +	u32 clk_pll_sel;
> +	ulong pll_rate;
> +	u32 clk_sel;
> +	ulong clk;
> +	u32 con;
> +
> +	con = readl(&pmucru->pmu_clksel_con[3]);
> +	clk_div_con = bitfield_extract_by_mask(con, UART0_DIV_CON_MASK);
> +	clk_pll_sel = bitfield_extract_by_mask(con, UART0_PLL_SEL_MASK);
> +
> +	switch (clk_pll_sel) {
> +	case UART0_PLL_SEL_GPLL:
> +		pll_rate = px30_pmuclk_get_gpll_rate(priv);
> +		break;
> +	case UART0_PLL_SEL_24M:
> +		pll_rate = OSC_HZ;
> +		break;
> +	case UART0_PLL_SEL_480M:
> +	case UART0_PLL_SEL_NPLL:
> +		/* usbphy480M and NPLL clocks, generated by CRU, are not supported yet */
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	clk = DIV_TO_RATE(pll_rate, clk_div_con);
> +	con = readl(&pmucru->pmu_clksel_con[4]);
> +	clk_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
> +
> +	switch (clk_sel) {
> +	case UART0_CLK_SEL_UART0:
> +		return clk;
> +	case UART0_CLK_SEL_UART0_NP5:{
> +			u32 clk_divnp5_div_con;
> +
> +			clk_divnp5_div_con =
> +			    bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
> +			return 2 * (u64) clk / (2 * clk_divnp5_div_con + 3);
> +		}
> +	case UART0_CLK_SEL_UART0_FRAC:{
> +			u32 fracdiv, n, m;
> +
> +			fracdiv = readl(&pmucru->pmu_clksel_con[5]);
> +			n = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_NUMERATOR_MASK);
> +			m = bitfield_extract_by_mask(fracdiv,
> +						     CLK_UART_FRAC_DENOMINATOR_MASK);
> +			return (u64) clk * n / m;
> +		}
> +	default:
> +		return -ENOENT;
> +	}
> +}
> +
> +static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv, ulong rate)
> +{
> +	struct px30_pmucru *pmucru = priv->pmucru;
> +	ulong m = 0, n = 0;
> +	ulong gpll_rate;
> +	u32 clk_div_con;
> +	u32 clk_pll_sel;
> +	u32 clk_sel;
> +
> +	gpll_rate = px30_pmuclk_get_gpll_rate(priv);
> +	if (gpll_rate % rate == 0) {
> +		clk_pll_sel = UART0_PLL_SEL_GPLL;
> +		clk_sel = UART0_CLK_SEL_UART0;
> +		clk_div_con = DIV_ROUND_UP(priv->gpll_hz, rate);
> +	} else if (rate == OSC_HZ) {
> +		clk_pll_sel = UART0_PLL_SEL_24M;
> +		clk_sel = UART0_CLK_SEL_UART0;
> +		clk_div_con = 1;
> +	} else {
> +		clk_pll_sel = UART0_PLL_SEL_GPLL;
> +		clk_sel = UART0_CLK_SEL_UART0_FRAC;
> +		clk_div_con = 1;
> +		rational_best_approximation(rate, priv->gpll_hz,
> +					    GENMASK(16 - 1, 0),
> +					    GENMASK(16 - 1, 0), &m, &n);
> +	}
> +
> +	rk_clrsetreg(&pmucru->pmu_clksel_con[3],
> +		     UART0_PLL_SEL_MASK | UART0_DIV_CON_MASK,
> +		     clk_pll_sel << UART0_PLL_SEL_SHIFT | (clk_div_con - 1));
> +	rk_clrsetreg(&pmucru->pmu_clksel_con[4], UART0_CLK_SEL_MASK,
> +		     clk_sel << UART0_CLK_SEL_SHIFT);
> +	if (m && n) {
> +		u32 fracdiv;
> +
> +		fracdiv = m << CLK_UART_FRAC_NUMERATOR_SHIFT | n;
> +		writel(fracdiv, &pmucru->pmu_clksel_con[5]);
> +	}
> +
> +	return px30_pmu_uart0_get_clk(priv);
> +}
> +
>   static ulong px30_pmuclk_get_rate(struct clk *clk)
>   {
>   	struct px30_pmuclk_priv *priv = dev_get_priv(clk->dev);
> @@ -1602,6 +1701,9 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
>   	case PCLK_PMU_PRE:
>   		rate = px30_pclk_pmu_get_pmuclk(priv);
>   		break;
> +	case SCLK_UART0_PMU:
> +		rate = px30_pmu_uart0_get_clk(priv);
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
> @@ -1622,6 +1724,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
>   	case PCLK_PMU_PRE:
>   		ret = px30_pclk_pmu_set_pmuclk(priv, rate);
>   		break;
> +	case SCLK_UART0_PMU:
> +		ret = px30_pmu_uart0_set_clk(priv, rate);
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
