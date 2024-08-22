Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C230C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 10:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9AF88E9E;
	Thu, 22 Aug 2024 12:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="UPdJHZ2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1B388E79; Thu, 22 Aug 2024 12:33:47 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7C588ECC
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 12:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so90088066b.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724322824; x=1724927624;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUDJOFvGdW6i65ZrLCuEhNu4zedBeegyOOjXqY4FGUk=;
 b=UPdJHZ2abZpBrGKoBzQUjONhaylKU+kExO+g/AmAzrr8KLWpeucToSw+zhuAUdmf7S
 VKye4tuK+4p5JRgJu1N5m+I9dILFPrPTkdFIUStQ1MMVxHjGwKTVux9Tkh2DZb03SCnJ
 76IQ42kcbFadvP3qk+WbawC+QPy7RMfblU5+4yWIG9lN9qO0sg7/d4NFyj+qR5SIjCfZ
 G0LhzwwE6eqFxmIcTppNmSsZPOh8nwJVGsstc+EKHUd5unRsjtByNETGfBKI9L6QAjPf
 8qlsXD8Jev1mgpD9GfMH1B3u6+NnHgLwoXPaExQdjIHQgEUX5FMR5zUXvXJk4/OVkn6q
 ROew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724322824; x=1724927624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUDJOFvGdW6i65ZrLCuEhNu4zedBeegyOOjXqY4FGUk=;
 b=XIrw9ShRGtzlnlrFzprSmnh743Ei7YyiIJI1A9baPYRFc4g7GqP8xWJcmcdpKHzyXT
 iP7jqL41vbdOLpG20Z7wMT0kMfXBVt1zRWaKGGKUhDJCvjbWtjDjmtrBO20jqMrH5481
 mNd3kVHulSL9CIaBSI1rx3LP5nmGN+ro/xBaoywkmEOzJiLmKLy2o0QNceMxoh0fj/Zp
 bKwnd+9ktFJu4i027YNPGoY3C73zScXJRZm2IejCqwYU/Ocpw2gu/witn/yno1/iJf+Y
 jWsKrqdn6+d9+eJ9cLS+F6HOQM8PBPqHnhcUn3TI46aIJlX+Ki/pGEkiwydZ8O551u5x
 ib1A==
X-Gm-Message-State: AOJu0YzGkL02/pzOH7DjQihrfM/TG0moOahGgYhcnGNSYZ1oH9+D5w+u
 dV/cR2XDdR+w5aL5fXAQA9T5PFMAXFz832ZwbeSldvYRegVFsYrsc4HIh4aD3lOUzxok1lt6GgZ
 X1rY=
X-Google-Smtp-Source: AGHT+IG4ObM5NB0EY80nYLimaneL+puLAIJ8aXozfi88lgclR8gwTTj1BBLMCUrZq0gsItbCyOkM5g==
X-Received: by 2002:a17:907:e88:b0:a86:73cd:8c9d with SMTP id
 a640c23a62f3a-a8691cb7f53mr141285866b.59.1724322823610; 
 Thu, 22 Aug 2024 03:33:43 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f484dc5sm100653066b.171.2024.08.22.03.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 03:33:43 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3] rockchip: px30: clk: add UART0 clock getter/setter
Date: Thu, 22 Aug 2024 12:33:15 +0200
Message-ID: <20240822103315.393063-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
References: <20240812162728.460138-1-lukasz.czechowski@thaumatec.com>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_px30.h |   7 ++
 drivers/clk/rockchip/clk_px30.c               | 105 ++++++++++++++++++
 2 files changed, 112 insertions(+)

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
index 2875c152b20..e5c004cfcc8 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1589,6 +1589,105 @@ static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
 	return priv->gpll_hz;
 }
 
+static ulong px30_pmu_uart0_get_clk(struct px30_pmuclk_priv *priv)
+{
+	struct px30_pmucru *pmucru = priv->pmucru;
+	u32 clk_div_con;
+	u32 clk_pll_sel;
+	ulong pll_rate;
+	u32 clk_sel;
+	ulong clk;
+	u32 con;
+
+	con = readl(&pmucru->pmu_clksel_con[3]);
+	clk_div_con = bitfield_extract_by_mask(con, UART0_DIV_CON_MASK);
+	clk_pll_sel = bitfield_extract_by_mask(con, UART0_PLL_SEL_MASK);
+
+	switch (clk_pll_sel) {
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
+	clk = DIV_TO_RATE(pll_rate, clk_div_con);
+	con = readl(&pmucru->pmu_clksel_con[4]);
+	clk_sel = bitfield_extract_by_mask(con, UART0_CLK_SEL_MASK);
+
+	switch (clk_sel) {
+	case UART0_CLK_SEL_UART0:
+		return clk;
+	case UART0_CLK_SEL_UART0_NP5:{
+			u32 clk_divnp5_div_con;
+
+			clk_divnp5_div_con =
+			    bitfield_extract_by_mask(con, UART0_DIVNP5_MASK);
+			return 2 * (u64) clk / (2 * clk_divnp5_div_con + 3);
+		}
+	case UART0_CLK_SEL_UART0_FRAC:{
+			u32 fracdiv, n, m;
+
+			fracdiv = readl(&pmucru->pmu_clksel_con[5]);
+			n = bitfield_extract_by_mask(fracdiv,
+						     CLK_UART_FRAC_NUMERATOR_MASK);
+			m = bitfield_extract_by_mask(fracdiv,
+						     CLK_UART_FRAC_DENOMINATOR_MASK);
+			return (u64) clk * n / m;
+		}
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong px30_pmu_uart0_set_clk(struct px30_pmuclk_priv *priv, ulong rate)
+{
+	struct px30_pmucru *pmucru = priv->pmucru;
+	ulong m = 0, n = 0;
+	ulong gpll_rate;
+	u32 clk_div_con;
+	u32 clk_pll_sel;
+	u32 clk_sel;
+
+	gpll_rate = px30_pmuclk_get_gpll_rate(priv);
+	if (gpll_rate % rate == 0) {
+		clk_pll_sel = UART0_PLL_SEL_GPLL;
+		clk_sel = UART0_CLK_SEL_UART0;
+		clk_div_con = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else if (rate == OSC_HZ) {
+		clk_pll_sel = UART0_PLL_SEL_24M;
+		clk_sel = UART0_CLK_SEL_UART0;
+		clk_div_con = 1;
+	} else {
+		clk_pll_sel = UART0_PLL_SEL_GPLL;
+		clk_sel = UART0_CLK_SEL_UART0_FRAC;
+		clk_div_con = 1;
+		rational_best_approximation(rate, priv->gpll_hz,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0), &m, &n);
+	}
+
+	rk_clrsetreg(&pmucru->pmu_clksel_con[3],
+		     UART0_PLL_SEL_MASK | UART0_DIV_CON_MASK,
+		     clk_pll_sel << UART0_PLL_SEL_SHIFT | (clk_div_con - 1));
+	rk_clrsetreg(&pmucru->pmu_clksel_con[4], UART0_CLK_SEL_MASK,
+		     clk_sel << UART0_CLK_SEL_SHIFT);
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
@@ -1602,6 +1701,9 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
 	case PCLK_PMU_PRE:
 		rate = px30_pclk_pmu_get_pmuclk(priv);
 		break;
+	case SCLK_UART0_PMU:
+		rate = px30_pmu_uart0_get_clk(priv);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -1622,6 +1724,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
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

