Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D413CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5174583939;
	Thu, 14 Aug 2025 15:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOsnS9mS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFCF83939; Thu, 14 Aug 2025 15:13:11 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5C4838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b47174beccfso656287a12.2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755177187; x=1755781987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=My9Nxb6n7nXWpTRMwMLyYK8Xz9Tge5Gq01wqXT/NLOA=;
 b=AOsnS9mSHkMVYWeETO73p72qcTXrju7qqTVVMlegxb339fHTpg4PKWi7gqCarrbK9p
 E5manVGVdc6RF2dHcGZ2lhapIedwsukRlWqbKqHh8zR0Y+rALvcseOe84ONamlluD2R8
 qprmstJIUR2GHZciGqd4/ieDjz//YGiNRPqE9ZnfpzIWzTCgaq7XdsO/DgA6Fwoif7sO
 Hv6hvKgbTHBHoifoHs13duGri8kapmvbq6RkQDXyYGqyZxB+Fq1sPP6VaOrm0PSSy4Oj
 BCTssV/Po0TLON+knMIB/ZX0n0mtogMU14weNO/NlGq/TfPRLJyx2NJIzKf6rlhQkH2i
 evCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755177187; x=1755781987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=My9Nxb6n7nXWpTRMwMLyYK8Xz9Tge5Gq01wqXT/NLOA=;
 b=VNBRkMi/7UfAMY/al+Ys6KPw93rUWxNs7Zl/I+GoeZFD0BokAevVhF855lTG0/4MJ8
 DSc27OSNJmJc0PqHVbpsdyn9D6ukrFaNVBeuaSjsCebakhMIFG/gaF2tJY33Ndq5EoQU
 05vBTBZuLco4dHX+LdLfYa0B9z1R9JGxD2/V3lGBd50aONQoTOxZF13LJohrJTVBEMYv
 RoBcoJPnYIceSOtB5dsZc5EdaTeUDIghPt7N6NFUZRC2Tz4baT5+zV5QcNgP7nXJmvvP
 kcNOgv8MRAdwzt0jlykwiTvCNaPwPSsa/zml69tHDpouIQM1F3O8KO6na/o6maFjFa/8
 2LYA==
X-Gm-Message-State: AOJu0YyphnFZciu4hR0YUXf43A9QguOxvP1SLfnS/jSiCM2mJTcynPzK
 0W5uTrxuqXwhDsgts6EEeW6CMNw+3o1JPxyL6hZXZOZChenSiYwqJrpJbUpfVKMJXsuFTrBN
X-Gm-Gg: ASbGncsGIJPVjcklTYWXq6La5aMRJ9uOoaCVBNCCLHHWFrpkmbcM7xY+ncDvjOhP7Md
 Xl2XxhdjnshP3BDuCH7aqj9yo4JB1BYPREnu4w1yyA9gTEa1c2o6EHzuGewIqN/iUktHaseC2Nj
 FQSZpP3dEfpa7teHL6Am6AhagTwyUmvDXAt1fHuhRQFOgMkTzxK5F11NO8VRM3wlxKYWE7f0W9T
 Q/QTNwnnF0j4ezXgocx9LPxqzxdf+9Efqsp9vRFTX21JrccapvxCUO7gGPLXcxqixEv6/b04JKB
 ZES+9iGlDtGE2sxDNUWBW8qY8fiDFWghzbqJJThEWsp+Th/5o51snNLZ98xFkLk180WF+GCCR7q
 QB2ht5dmMJO2wIU95ZZj+EHdI1peDmuCcM2fZbQ==
X-Google-Smtp-Source: AGHT+IF3ERF3soZjMW9PGnoSEMaK6ooD5YN0hrNRo9iEHNEIY4N3Q9JUHjsGczq/giRB5RnovY0KUg==
X-Received: by 2002:a17:902:f786:b0:242:abc2:7f1e with SMTP id
 d9443c01a7336-244585089eemr49115295ad.22.1755177186571; 
 Thu, 14 Aug 2025 06:13:06 -0700 (PDT)
Received: from localhost.localdomain ([104.28.159.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24300f8c9d1sm67902195ad.129.2025.08.14.06.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:13:05 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, lukma@denx.de, seanga2@gmail.com,
 ag.dev.uboot@gmail.com, muratdemirtaseu@outlook.com,
 WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH 1/5] clk: rockchip: rk3368: Add bus clk get/set
Date: Thu, 14 Aug 2025 21:12:33 +0800
Message-Id: <20250814131237.8135-2-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814131237.8135-1-cn.liweihao@gmail.com>
References: <20250814131237.8135-1-cn.liweihao@gmail.com>
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

Some of board need operate PMIC like RK808-B for power supply. It's
depends on I2C peripheral, this patch add bus clock get/set function
which include I2C clock support.

This patch get form Rockchip downstream uboot repository.

Link: https://github.com/rockchip-linux/u-boot

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../include/asm/arch-rockchip/cru_rk3368.h    | 12 +++
 drivers/clk/rockchip/clk_rk3368.c             | 94 +++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
index ed2a61218..845113f13 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
@@ -80,6 +80,18 @@ enum {
 	PLL_RESET			= 1,
 	PLL_RESET_MASK			= GENMASK(5, 5),
 
+	/* CLKSEL8CON */
+	PCLK_BUS_DIV_CON_SHIFT		= 12,
+	PCLK_BUS_DIV_CON_MASK		= 0x7 << PCLK_BUS_DIV_CON_SHIFT,
+	HCLK_BUS_DIV_CON_SHIFT		= 8,
+	HCLK_BUS_DIV_CON_MASK		= 0x3 << HCLK_BUS_DIV_CON_SHIFT,
+	CLK_BUS_PLL_SEL_CPLL		= 0,
+	CLK_BUS_PLL_SEL_GPLL		= 1,
+	CLK_BUS_PLL_SEL_SHIFT		= 7,
+	CLK_BUS_PLL_SEL_MASK		= 1 << CLK_BUS_PLL_SEL_SHIFT,
+	ACLK_BUS_DIV_CON_SHIFT		= 0,
+	ACLK_BUS_DIV_CON_MASK		= 0x1f << ACLK_BUS_DIV_CON_SHIFT,
+
 	/* CLKSEL12_CON */
 	MCU_STCLK_DIV_SHIFT		= 8,
 	MCU_STCLK_DIV_MASK		= GENMASK(10, 8),
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb..994330162 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -453,6 +453,82 @@ static ulong rk3368_saradc_set_clk(struct rk3368_cru *cru, uint hz)
 	return rk3368_saradc_get_clk(cru);
 }
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+static ulong rk3368_bus_get_clk(struct rk3368_cru *cru, ulong clk_id)
+{
+	u32 div, con, parent;
+
+	switch (clk_id) {
+	case ACLK_BUS:
+		con = readl(&cru->clksel_con[8]);
+		div = (con & ACLK_BUS_DIV_CON_MASK) >> ACLK_BUS_DIV_CON_SHIFT;
+		parent = rkclk_pll_get_rate(cru, GPLL);
+		break;
+	case HCLK_BUS:
+		con = readl(&cru->clksel_con[8]);
+		div = (con & HCLK_BUS_DIV_CON_MASK) >> HCLK_BUS_DIV_CON_SHIFT;
+		parent = rk3368_bus_get_clk(cru, ACLK_BUS);
+		break;
+	case PCLK_BUS:
+	case PCLK_PWM0:
+	case PCLK_PWM1:
+	case PCLK_I2C0:
+	case PCLK_I2C1:
+		con = readl(&cru->clksel_con[8]);
+		div = (con & PCLK_BUS_DIV_CON_MASK) >> PCLK_BUS_DIV_CON_SHIFT;
+		parent = rk3368_bus_get_clk(cru, ACLK_BUS);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3368_bus_set_clk(struct rk3368_cru *cru,
+				ulong clk_id, ulong hz)
+{
+	int src_clk_div;
+
+	/*
+	 * select gpll as pd_bus bus clock source and
+	 * set up dependent divisors for PCLK/HCLK and ACLK clocks.
+	 */
+	switch (clk_id) {
+	case ACLK_BUS:
+		src_clk_div = DIV_ROUND_UP(rkclk_pll_get_rate(cru, GPLL), hz);
+		assert(src_clk_div - 1 < 31);
+		rk_clrsetreg(&cru->clksel_con[8],
+			     CLK_BUS_PLL_SEL_MASK | ACLK_BUS_DIV_CON_MASK,
+			     CLK_BUS_PLL_SEL_GPLL << CLK_BUS_PLL_SEL_SHIFT |
+			     (src_clk_div - 1) << ACLK_BUS_DIV_CON_SHIFT);
+		break;
+	case HCLK_BUS:
+		src_clk_div = DIV_ROUND_UP(rk3368_bus_get_clk(cru,
+							      ACLK_BUS),
+					   hz);
+		assert(src_clk_div - 1 < 3);
+		rk_clrsetreg(&cru->clksel_con[8],
+			     HCLK_BUS_DIV_CON_MASK,
+			     (src_clk_div - 1) << HCLK_BUS_DIV_CON_SHIFT);
+		break;
+	case PCLK_BUS:
+		src_clk_div = DIV_ROUND_UP(rk3368_bus_get_clk(cru,
+							      ACLK_BUS),
+					   hz);
+		assert(src_clk_div - 1 < 3);
+		rk_clrsetreg(&cru->clksel_con[8],
+			     PCLK_BUS_DIV_CON_MASK,
+			     (src_clk_div - 1) << PCLK_BUS_DIV_CON_SHIFT);
+		break;
+	default:
+		printf("do not support this bus freq\n");
+		return -EINVAL;
+	}
+	return rk3368_bus_get_clk(cru, clk_id);
+}
+#endif
+
 static ulong rk3368_clk_get_rate(struct clk *clk)
 {
 	struct rk3368_clk_priv *priv = dev_get_priv(clk->dev);
@@ -469,6 +545,17 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 	case SCLK_SPI0 ... SCLK_SPI2:
 		rate = rk3368_spi_get_clk(priv->cru, clk->id);
 		break;
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	case ACLK_BUS:
+	case HCLK_BUS:
+	case PCLK_BUS:
+	case PCLK_PWM0:
+	case PCLK_PWM1:
+	case PCLK_I2C0:
+	case PCLK_I2C1:
+		rate = rk3368_bus_get_clk(priv->cru, clk->id);
+		break;
+#endif
 #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
@@ -500,6 +587,13 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 		ret = rk3368_ddr_set_clk(priv->cru, rate);
 		break;
 #endif
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	case ACLK_BUS:
+	case HCLK_BUS:
+	case PCLK_BUS:
+		rate = rk3368_bus_set_clk(priv->cru, clk->id, rate);
+		break;
+#endif
 #if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
-- 
2.39.5

