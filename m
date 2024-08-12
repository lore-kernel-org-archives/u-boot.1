Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480CC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 16:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60D4884C3;
	Mon, 12 Aug 2024 18:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="MjR0uMGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283D487CF8; Mon, 12 Aug 2024 18:30:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E94B884C3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 18:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so5278150a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1723480204; x=1724085004;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tAkFVH3obLpdJT51vFey8hN7IhqEvq6nER5s2rHnoI=;
 b=MjR0uMGb5dpn/rHgwqCYTc5iJdQqKOLOoipsRXEnBhtqr8y85FQn2kC1aa0hZ8R/7K
 iHsfFvajh6Ctkq3msChkWJcvTpOSMuT9LEIV9cMZ2DLsIqmCV4clPYAa0tXn5GzEJ7RO
 ajiaQMBCp7K+G9jaiDGv4HQx2E7w2oy9IwiiiN86TGWhd3w/inyxilZEABvIBP2g6Cdh
 ipRE/GttBIivOIo58fcuaVHoPZsQZNIw7X3CgdsXX0aU7Yww3TMfA2x7rhiVD+2h/yjY
 d8nZaXzzzfiT52+c7pSWlStPsZOtyZwVEv7PyNsKjUUPR+8TFDktOgFYkau7nAEv5rEg
 Mukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723480204; x=1724085004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tAkFVH3obLpdJT51vFey8hN7IhqEvq6nER5s2rHnoI=;
 b=KppS1Y4Y6MaFQqWS98eIZ4xuXBzSQ3AAAQw+VUHPzIV6gEDzLiBk0HeJGwM9byvXTs
 NqMoHKsSwBmo8LWAPlCPipkybohTCTUIfWjAxOyP4jnlv30NEzQnOyuA3/KPSmaNJ0d6
 bKLfOMBGnTQ6GmenKaBKEjXNXCGFDltCYJys2pyA/s2V4n2uVWf9DvJhftJzyy66cP81
 Mm5D7MVupI5NwagqDZqEnlBvG8DEquyp7BkRpAgGD747QjZngUc6AxMzospmlfpX8hV+
 1SlTJ75ZeLSKGHj/v6OzjCoRhnNtK1KCOWewxoHzUOfGUIT7B+0kHsQyjwG5bBGUN1M8
 8r8g==
X-Gm-Message-State: AOJu0Yyx7P2K6W+vAhM8hFS5UdtkQEsTuo+eoyeLdpRxPjL8CaEZ0BMR
 OIOwd0Cz7bV/G4uzYrMN0cw2Npf6Xsn94M0G2Ka+bQ26LOZ9fohT/TLi1HxLYozoTc8ez7juSOW
 Ob8k=
X-Google-Smtp-Source: AGHT+IHYQsRQS6A9g/WOz9bwoiHxFQZipVC3fy9zEr+kL3p1Tiykyxp3rCTyyp356guzNl+aHo+jfA==
X-Received: by 2002:a17:907:86aa:b0:a7a:9c1c:1890 with SMTP id
 a640c23a62f3a-a80ed2c86bcmr68401666b.55.1723480204113; 
 Mon, 12 Aug 2024 09:30:04 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb21317csm242852766b.150.2024.08.12.09.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 09:30:03 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2] rockchip: px30: clk: add UART0 clock getter/setter
Date: Mon, 12 Aug 2024 18:27:28 +0200
Message-ID: <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
References: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add dedicated getter and setter for SCLK_UART0_PMU.
This allows the driver to correctly handle UART0 clocks, and thus
it fixes the issues with UART0 not working in case DEBUG_UART is
disabled.
Unlike other Rockchip SoCs, i.e. rk3399, in the PX30 the default
clock source for UART is GPLL, instead of external oscillator.
If the DEBUG_UART is enabled, the clock source is changed in
board_debug_uart_init function to 24Mhz oscillator, which also
matches the fallback value obtained from DT node.
In case the DEBUG_UART is disabled, the UART clock source remains
default, and the DM serial driver wrongly configures the baud rate,
resulting in broken communication.
By implementing the UART clock getter/setter, the serial driver
can probe the actual configuration and corectly configure itself.
The DEBUG_UART settings now should not affect it.

The driver supports GPLL and 24M oscillator. NPLL and USBPHY480M
sources, that are managed by CRU, are not yet handled, as likely
they won't be used in real scenarios.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
 drivers/clk/rockchip/clk_px30.c               | 108 ++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_px30.h b/arch/arm/include/asm/arch-rockchip/cru_px30.h
index b66277fc7f3..504459bd93d 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_px30.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_px30.h
@@ -464,5 +464,12 @@ enum {
 	UART0_CLK_SEL_UART0_FRAC,
 	UART0_DIVNP5_SHIFT		= 0,
 	UART0_DIVNP5_MASK		= 0x1f << UART0_DIVNP5_SHIFT,
+
+	/* CRU_PMU_CLKSEL5_CON */
+	CLK_UART_FRAC_NUMERATOR_SHIFT	= 16,
+	CLK_UART_FRAC_NUMERATOR_MASK	= 0xffff << CLK_UART_FRAC_NUMERATOR_SHIFT,
+	CLK_UART_FRAC_DENOMINATOR_SHIFT	= 0,
+	CLK_UART_FRAC_DENOMINATOR_MASK =
+	    0xffff << CLK_UART_FRAC_DENOMINATOR_SHIFT,
 };
 #endif
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index 2875c152b20..6768ef21b68 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1589,6 +1589,108 @@ static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
 	return priv->gpll_hz;
 }
 
+static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
+{
+	struct px30_pmucru *pmucru = priv->pmucru;
+	u32 clk_uart0_div_con;
+	u32 clk_uart0_pll_sel;
+	u32 clk_uart0_sel;
+	ulong clk_uart0;
+	ulong pll_rate;
+	u32 con;
+
+	con = readl(&pmucru->pmu_clksel_con[3]);
+	clk_uart0_div_con = bitfield_extract_by_mask(con, UART0_DIV_CON_MASK);
+	clk_uart0_pll_sel = bitfield_extract_by_mask(con, UART0_PLL_SEL_MASK);
+
+	switch (clk_uart0_pll_sel) {
+	case UART0_PLL_SEL_GPLL:
+		pll_rate = px30_pmuclk_get_gpll_rate(priv);
+		break;
+	case UART0_PLL_SEL_24M:
+		pll_rate = OSC_HZ;
+		break;
+	case UART0_PLL_SEL_480M:
+	case UART0_PLL_SEL_NPLL:
+		/* usbphy480M and NPLL clocks, generated by CRU, are not supported yet */
+	default:
+		return -ENOENT;
+	}
+
+	clk_uart0 = DIV_TO_RATE(pll_rate, clk_uart0_div_con);
+	con = readl(&pmucru->pmu_clksel_con[4]);
+	clk_uart0_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
+
+	switch (clk_uart0_sel) {
+	case UART0_CLK_SEL_UART0:
+		return clk_uart0;
+	case UART0_CLK_SEL_UART0_NP5:{
+			u32 clk_uart0_divnp5_div_con;
+
+			clk_uart0_divnp5_div_con =
+			    bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
+			return 2 * (u64) clk_uart0 / (2 *
+						      clk_uart0_divnp5_div_con +
+						      3);
+		}
+	case UART0_CLK_SEL_UART0_FRAC:{
+			u32 fracdiv, n, m;
+
+			fracdiv = readl(&pmucru->pmu_clksel_con[5]);
+			n = bitfield_extract_by_mask(fracdiv,
+						     CLK_UART_FRAC_NUMERATOR_MASK);
+			m = bitfield_extract_by_mask(fracdiv,
+						     CLK_UART_FRAC_DENOMINATOR_MASK);
+			return (u64) clk_uart0 * n / m;
+		}
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv, ulong rate)
+{
+	struct px30_pmucru *pmucru = priv->pmucru;
+	u32 clk_uart0_div_con;
+	u32 clk_uart0_pll_sel;
+	u32 clk_uart0_sel;
+	ulong gpll_rate;
+	ulong m = 0, n = 0;
+
+	gpll_rate = px30_pmuclk_get_gpll_rate(priv);
+	if (gpll_rate % rate == 0) {
+		clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
+		clk_uart0_sel = UART0_CLK_SEL_UART0;
+		clk_uart0_div_con = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else if (rate == OSC_HZ) {
+		clk_uart0_pll_sel = UART0_PLL_SEL_24M;
+		clk_uart0_sel = UART0_CLK_SEL_UART0;
+		clk_uart0_div_con = 1;
+	} else {
+		clk_uart0_pll_sel = UART0_PLL_SEL_GPLL;
+		clk_uart0_sel = UART0_CLK_SEL_UART0_FRAC;
+		clk_uart0_div_con = 1;
+		rational_best_approximation(rate, priv->gpll_hz,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0), &m, &n);
+	}
+
+	rk_clrsetreg(&pmucru->pmu_clksel_con[3],
+		     UART0_PLL_SEL_MASK | UART0_DIV_CON_MASK,
+		     clk_uart0_pll_sel << UART0_PLL_SEL_SHIFT |
+		     (clk_uart0_div_con - 1));
+	rk_clrsetreg(&pmucru->pmu_clksel_con[4], UART0_CLK_SEL_MASK,
+		     clk_uart0_sel << UART0_CLK_SEL_SHIFT);
+	if (m && n) {
+		u32 fracdiv;
+
+		fracdiv = m << CLK_UART_FRAC_NUMERATOR_SHIFT | n;
+		writel(fracdiv, &pmucru->pmu_clksel_con[5]);
+	}
+
+	return px30_pmu_uart0_get_clk(priv);
+}
+
 static ulong px30_pmuclk_get_rate(struct clk *clk)
 {
 	struct px30_pmuclk_priv *priv = dev_get_priv(clk->dev);
@@ -1602,6 +1704,9 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
 	case PCLK_PMU_PRE:
 		rate = px30_pclk_pmu_get_pmuclk(priv);
 		break;
+	case SCLK_UART0_PMU:
+		rate = px30_pmu_uart0_get_clk(priv);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -1622,6 +1727,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
 	case PCLK_PMU_PRE:
 		ret = px30_pclk_pmu_set_pmuclk(priv, rate);
 		break;
+	case SCLK_UART0_PMU:
+		ret = px30_pmu_uart0_set_clk(priv, rate);
+		break;
 	default:
 		return -ENOENT;
 	}
-- 
2.43.0

