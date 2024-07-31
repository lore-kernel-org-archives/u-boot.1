Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F52C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 09:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD3E8899D;
	Wed, 31 Jul 2024 11:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="X1/xpSQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128A98894E; Wed, 31 Jul 2024 11:43:28 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140B888970
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 11:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so614092166b.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1722419005; x=1723023805;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZSNQyr7aZkATcE3ay8gjoXC31qKmLXNgpOoAJWCTVY=;
 b=X1/xpSQaPrfvjIJejbTHbcltOUMrkAgAJt9JUCtin6c0qvahDY0aE6uVK6hcdmOVNQ
 sUT/c2iF77cG4FBp1dy17P0sahBLUeLIhEYwNfJ55y2Uw1zKClK6W07DVrin51lalZ9t
 61fMrkmFg86UxgMHSYHc4QmpmPM0B4Chug32I35nc08Cx6oVh4+1PnsRe1ZX0ipk7WwY
 axoRWrOr57Wc3Eox/ChgerWd8J6UnCo+jz5TbAuvhKnkqwSLyjseelQykVk5Hfae4htw
 e7xDylbx+HcrobFDSXr5rPg3UJHkcUoIBCfcks9ONa8XC04QFd5A+fhZihH5Qt8JuFPD
 ZxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722419005; x=1723023805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ZSNQyr7aZkATcE3ay8gjoXC31qKmLXNgpOoAJWCTVY=;
 b=nvcwFfCBfmZahGlGl3pYPTIA7hpqh6RDk30DySqir8nnVgl02QIX3oCtbiKwOba24B
 9SbbCdxPcRiJgKccelBzJ7E99tsSqrx0uLw2Z36tJLdT7s+aVldS/ZnY5Y/lQAXx/CJC
 o2kV2hFhYRa8XAVnZD++4i2UGLJkmtiTLN6jFjNJO1rqT3l5ETlrTfh1DNi07w5bTa0N
 Zqjl2qSODn3egFkqyppjy8tUOzkN411qMoa3rfpXUU0FvnksGr+0I2HPG4UQsaNPLlCd
 cynIzEfeKTzb7auuRKOwna9l+3DA4d1gJoWI1tLo27vd1I5iCEGnMNaE9J31DBnPclG+
 Nz/A==
X-Gm-Message-State: AOJu0YwDH06zuSTdvW2bkSemN/CDVgKYig52Mn5WgnAm8xIa3KO8FGlC
 r5MPXAnyM9Z5rUG1fKsbPp9PzjNk0roz+wcVU3l9kV7HbWkdFuUzA0mTJR2mCeKHjM7wKEzI1tJ
 TS/q4vQ==
X-Google-Smtp-Source: AGHT+IFvXc8r2z4aqVVtdvYbRTj1nkCOw2uflkdrBfRLHoKXEo0UDjrMti2AcL7IaKARW2CwbofzJA==
X-Received: by 2002:a17:907:9403:b0:a77:b516:3023 with SMTP id
 a640c23a62f3a-a7d3ff57aa5mr1105740766b.4.1722419004770; 
 Wed, 31 Jul 2024 02:43:24 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acada27ddsm740338466b.184.2024.07.31.02.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 02:43:24 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH] rockchip: clk: add UART0 clock getter/setter
Date: Wed, 31 Jul 2024 11:43:07 +0200
Message-ID: <20240731094307.65307-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/clk/rockchip/clk_px30.c               | 107 ++++++++++++++++++
 2 files changed, 114 insertions(+)

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
index 2875c152b20..64f1a335cb0 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1589,6 +1589,107 @@ static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
 	return priv->gpll_hz;
 }
 
+static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
+{
+	struct px30_pmucru *pmucru = priv->pmucru;
+	u32 clk_uart0_div_con;
+	u32 clk_uart0_pll_sel;
+	u32 clk_uart0_sel;
+	u32 con;
+	ulong pll_rate;
+	ulong clk_uart0;
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
+			return DIV_TO_RATE((2 * clk_uart0),
+					   (2 * clk_uart0_divnp5_div_con + 3));
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
+	ulong gpll_rate;
+	u32 clk_uart0_div_con;
+	u32 clk_uart0_pll_sel;
+	u32 clk_uart0_sel;
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
@@ -1602,6 +1703,9 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
 	case PCLK_PMU_PRE:
 		rate = px30_pclk_pmu_get_pmuclk(priv);
 		break;
+	case SCLK_UART0_PMU:
+		rate = px30_pmu_uart0_get_clk(priv);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -1622,6 +1726,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
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

