Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE39C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB989800D0;
	Fri, 31 Jan 2025 00:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I5c9Ss1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C26805FF; Fri, 31 Jan 2025 00:18:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52F2800B3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738279130;
 bh=xoYqJpAUfWy3AkelAzlAIQyqiTkTcDSi3l4eues+zRo=;
 b=I5c9Ss1mGTcZ21YFzCLcLig3JW/bBHZYXm32XSVDayug/3WAABPdP077+dJRsVuk2ECPkhR7e
 4n+rEcQZs04n7NtRtLIzIftRAMIjFB0f6Flm73inHK8FGIbWkDNvUWBbypQWmQ/pEBZJV8w/Y0v
 t5Urp5ZZJqjjwrfORaFjGe5/MzibczOcjTT+12UGB8YVBnqHAl7x+/qjjlNiF1OoXaV4TM/2nvb
 7bSKnbYz0gm6hIpoEQYMBR8DcUaPSTxSgRa553mCcnRO3P684PdoXqghfVTZ0tw6hK26IF4u+Oc
 stBqdkKvOrnweW0J1cw2lMc2k1HkGO6QC68GZtQrHU1g==
X-Forward-Email-ID: 679c08cf2d70e7e05884055c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f1f00c34-fd85-4163-9cdb-e0dff845e83e@kwiboo.se>
Date: Fri, 31 Jan 2025 00:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] clk: rockchip: Add rk3576 clk support
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Elaine Zhang <zhangqing@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-14-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241121142731.1202209-14-heiko@sntech.de>
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

Hi Heiko,

On 2024-11-21 15:27, Heiko Stuebner wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Add clock driver support for Rockchip RK3576 SoC.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> [adapted to mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../include/asm/arch-rockchip/cru_rk3576.h    |  486 ++++
>  drivers/clk/rockchip/Makefile                 |    1 +
>  drivers/clk/rockchip/clk_rk3576.c             | 2517 +++++++++++++++++
>  3 files changed, 3004 insertions(+)
>  create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
>  create mode 100644 drivers/clk/rockchip/clk_rk3576.c
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> new file mode 100644
> index 00000000000..893d92ff5f7
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> @@ -0,0 +1,486 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Rockchip Electronics Co. Ltd.
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + */
> +
> +#ifndef _ASM_ARCH_CRU_RK3576_H
> +#define _ASM_ARCH_CRU_RK3576_H
> +
> +#define MHz		1000000
> +#define KHz		1000
> +#define OSC_HZ		(24 * MHz)
> +
> +#define CPU_PVTPLL_HZ	(1008 * MHz)
> +#define LPLL_HZ		(816 * MHz)
> +#define GPLL_HZ		(1188 * MHz)
> +#define CPLL_HZ		(1000 * MHz)
> +#define PPLL_HZ		(1100 * MHz)
> +#define GMAC0_PTP_REFCLK_IN	(24 * MHz)
> +#define GMAC1_PTP_REFCLK_IN	(24 * MHz)
> +
> +/* RK3576 pll id */
> +enum rk3576_pll_id {
> +	BPLL,
> +	LPLL,
> +	DPLL,
> +	CPLL,
> +	GPLL,
> +	VPLL,
> +	AUPLL,
> +	SPLL,
> +	PPLL,
> +	PLL_COUNT,
> +};
> +
> +struct rk3576_clk_info {
> +	unsigned long id;
> +	char *name;
> +	bool is_cru;
> +};

rk3576_clk_info is not used for anything and can be dropped.

> +
> +struct rk3576_clk_priv {
> +	struct rk3576_cru *cru;
> +	struct rk3576_grf *grf;

This grf member is not used for anything in the clk driver and can be
dropped.

> +	ulong ppll_hz;
> +	ulong gpll_hz;
> +	ulong cpll_hz;
> +	ulong vpll_hz;
> +	ulong aupll_hz;
> +	ulong spll_hz;
> +	ulong lpll_hz;
> +	ulong bpll_hz;
> +	ulong armclk_hz;
> +	ulong armclk_enter_hz;
> +	ulong armclk_init_hz;
> +	bool sync_kernel;
> +	bool set_armclk_rate;
> +};
> +

[snip]

> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index 9e379cc2e3b..855bf318de7 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_ROCKCHIP_RK3328) += clk_rk3328.o
>  obj-$(CONFIG_ROCKCHIP_RK3368) += clk_rk3368.o
>  obj-$(CONFIG_ROCKCHIP_RK3399) += clk_rk3399.o
>  obj-$(CONFIG_ROCKCHIP_RK3568) += clk_rk3568.o
> +obj-$(CONFIG_ROCKCHIP_RK3576) += clk_rk3576.o
>  obj-$(CONFIG_ROCKCHIP_RK3588) += clk_rk3588.o
>  obj-$(CONFIG_ROCKCHIP_RV1108) += clk_rv1108.o
>  obj-$(CONFIG_ROCKCHIP_RV1126) += clk_rv1126.o
> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> new file mode 100644
> index 00000000000..c11dd594a72
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -0,0 +1,2517 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fuzhou Rockchip Electronics Co., Ltd
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + */
> +

[snip]

> +
> +static int rk3576_clk_probe(struct udevice *dev)
> +{
> +	struct rk3576_clk_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	priv->sync_kernel = false;
> +
> +#ifdef CONFIG_SPL_BUILD
> +	/* relase presetn_bigcore_biu/cru/grf */
> +	writel(0x1c001c00, 0x26010010);
> +	/* set spll to normal mode */
> +	writel(BITS_WITH_WMASK(2, 0x7U, 6),
> +	       RK3576_SCRU_BASE + RK3576_PLL_CON(137));
> +	writel(BITS_WITH_WMASK(1, 0x3U, 0),
> +	       RK3576_SCRU_BASE + RK3576_MODE_CON0);
> +	/* fix ppll\aupll\cpll */
> +	writel(BITS_WITH_WMASK(2, 0x7U, 6),
> +	       RK3576_CRU_BASE + RK3576_PMU_PLL_CON(129));
> +	writel(BITS_WITH_WMASK(2, 0x7U, 6),
> +	       RK3576_CRU_BASE + RK3576_PLL_CON(97));
> +	writel(BITS_WITH_WMASK(2, 0x7U, 6),
> +	       RK3576_CRU_BASE + RK3576_PLL_CON(105));
> +	writel(BITS_WITH_WMASK(1, 0x3U, 6),
> +	       RK3576_CRU_BASE + RK3576_MODE_CON0);
> +	writel(BITS_WITH_WMASK(1, 0x3U, 8),
> +	       RK3576_CRU_BASE + RK3576_MODE_CON0);
> +	/* init cci */
> +	writel(0xffff0000, RK3576_CRU_BASE + RK3576_CCI_CLKSEL_CON(4));
> +	rockchip_pll_set_rate(&rk3576_pll_clks[BPLL], priv->cru,
> +			      BPLL, LPLL_HZ);
> +	if (!priv->armclk_enter_hz) {
> +		ret = rockchip_pll_set_rate(&rk3576_pll_clks[LPLL], priv->cru,
> +					    LPLL, LPLL_HZ);
> +		priv->armclk_enter_hz =
> +			rockchip_pll_get_rate(&rk3576_pll_clks[LPLL],
> +					      priv->cru, LPLL);
> +		priv->armclk_init_hz = priv->armclk_enter_hz;
> +		rk_clrsetreg(&priv->cru->litclksel_con[0], CLK_LITCORE_DIV_MASK,
> +			     0 << CLK_LITCORE_DIV_SHIFT);
> +	}
> +	/* init cci */
> +	writel(0xffff20cb, RK3576_CRU_BASE + RK3576_CCI_CLKSEL_CON(4));
> +
> +	/* Change bigcore rm from 4 to 3 */
> +	writel(0x001c000c, RK3576_BIGCORE_GRF_BASE + 0x3c);
> +	writel(0x001c000c, RK3576_BIGCORE_GRF_BASE + 0x44);
> +	writel(0x00020002, RK3576_BIGCORE_GRF_BASE + 0x38);
> +	udelay(1);
> +	writel(0x00020000, RK3576_BIGCORE_GRF_BASE + 0x38);
> +	/* Change litcore rm from 4 to 3 */
> +	writel(0x001c000c, RK3576_LITCORE_GRF_BASE + 0x3c);
> +	writel(0x001c000c, RK3576_LITCORE_GRF_BASE + 0x44);
> +	writel(0x00020002, RK3576_LITCORE_GRF_BASE + 0x38);
> +	udelay(1);
> +	writel(0x00020000, RK3576_LITCORE_GRF_BASE + 0x38);
> +	/* Change cci rm form 4 to 3 */
> +	writel(0x001c000c, RK3576_CCI_GRF_BASE + 0x54);
> +#endif
> +
> +	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> +	if (IS_ERR(priv->grf))
> +		return PTR_ERR(priv->grf);

This driver is not using grf, so this can be dropped and should also
save a few ms of boot time.

Regards,
Jonas

> +
> +	rk3576_clk_init(priv);
> +
> +	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
> +	ret = clk_set_defaults(dev, 1);
> +	if (ret)
> +		debug("%s clk_set_defaults failed %d\n", __func__, ret);
> +	else
> +		priv->sync_kernel = true;
> +
> +	return 0;
> +}

[snip]
