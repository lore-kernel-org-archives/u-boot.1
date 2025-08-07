Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75316C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D3684485;
	Thu,  7 Aug 2025 10:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHuKxyIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9F983AD5; Thu,  7 Aug 2025 09:46:02 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E4683A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2429d9d3755so6768875ad.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552758; x=1755157558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H43aQy+agl5b0FuUcfiMMgSWbkbaRC9VbRcgwE5v7ok=;
 b=NHuKxyIGcGHn+mNCEsn4MtrRypQOeaS6J2HVhd0VtCUwFqJfEYl9iYSFoTGqnJDRBH
 tZ5plJnK3y9r/nuIwdGvKOKVQy/QD58dvtlaIorldxAozU11XMvjw2wRNGelRnLxcVT7
 I87aQLJSWKuGZyX84PIX2ns3dg3SmOs/TvJcNo2jRf4tgSNGBu8HcCElXrcEvqf5H6vO
 mnPDIewHb5xH4tSJY8PoafaW6uxpcrn461g6/MmUmnksB33cNv1Mym2cGYGcPtssSN4+
 WbKlNhF2Q6f5Vtv/lUpZ7i4oY5XYweFCDgnYnntlzJTd3/QwqFcVzy++qGs+QKutKzqj
 3CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552758; x=1755157558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H43aQy+agl5b0FuUcfiMMgSWbkbaRC9VbRcgwE5v7ok=;
 b=npKHTVvWIcQ9HJpt+c3pwYgoeIY6/hwHwuXb8E668CDAQ40Iv18rv2D06m6CVy94w8
 mBA1J4+DT0EEresVZGW9n2eNgHWZLOuoVW0q6ZCjc8OQYyV4YxUJv4OdxKJbsCO+Bj7A
 sn6OHTFm+CH9DpjaQ+4vBVAANz4JwRlpvN/JD5ZE1VyHU1IPGGsYF5zjD2SRniWPSoxW
 wzeWkf2tZYLm3mPvNnw70jpXv8T6lzpLxtq18j+GLrlB+0eg7RjKJHzdpdMovjwPO0LO
 Nk3fRDAorDgf9oVEo6AmW0iWla9v4ohQjYXaxfwSGe+NJdpoP+kVFwU/slBDuD/o67dN
 gkJg==
X-Gm-Message-State: AOJu0Yxsh1A5y7G7+QfzZ2FbTTFvE7FwFiVm+phof4MCIE8NvcOzuPDj
 MioN7sNNEygfs16RUOaGVEN+1HN8ywO8LL3mwbUZ3zJHurYV95lx8XUi53T7K2dg
X-Gm-Gg: ASbGncsHRuYbVkAz5xQeFy23Vrqb9t6ABVs5NWltc2KoFRfAYoe2/Lr3XvaeIQO4l77
 f5LnfJgm/PkZxTdzk06VABrGLTDFM+9zSFtJ445y678r+/GUcRa2fhB9YIdDdgpNF9v9H18dc2H
 Pk1Gvo/vuQELmJXVFSmubIlBjZp55J71T+3JZ6qAsY7e3QkCdRngddajRMstwb7rsGJmEDAdxOS
 yUeNsgWgHTj13OqIV9GtnKJhzJvZOQwf98ENRzkv8kMD6+wCetiLCWVh9AU10JBxUAEG7RC8rCq
 fjKD7Jd55fT6BdnHE9PKXTrGGn6WGomu88aJeP3danPFNOExCpeuUNtOg4kdJyhk96xuB14uqMg
 hRm73Gf162MivIpSf6PA+GiMjG0QH3z9lIeH1
X-Google-Smtp-Source: AGHT+IH2hTcX4RKVLKqHOMImm2l1GDJavZmG9jWt5hAht8urkLwmYn8YG/jSO2bO9MvmSU3sOZdMEw==
X-Received: by 2002:a17:902:e54e:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-2429f30aa5cmr64234075ad.28.1754552757690; 
 Thu, 07 Aug 2025 00:45:57 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:45:57 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 04/10] clk: rockchip: rk3368: Add bus clk get/set
Date: Thu,  7 Aug 2025 15:44:12 +0800
Message-Id: <20250807074419.336752-5-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Patch get form Rockchip downstream uboot repository.

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 .../include/asm/arch-rockchip/cru_rk3368.h    | 60 ++++++++++++
 drivers/clk/rockchip/clk_rk3368.c             | 94 +++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
index ed2a612185..29f90454d4 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
@@ -80,6 +80,49 @@ enum {
 	PLL_RESET			= 1,
 	PLL_RESET_MASK			= GENMASK(5, 5),
 
+	/* CLKSEL1CON */
+	CORE_ACLK_DIV_SHIFT		= 0,
+	CORE_ACLK_DIV_MASK		= 0x1f << CORE_ACLK_DIV_SHIFT,
+	CORE_DBG_DIV_SHIFT		= 8,
+	CORE_DBG_DIV_MASK		= 0x1f << CORE_DBG_DIV_SHIFT,
+
+	CORE_CLK_PLL_SEL_SHIFT		= 7,
+	CORE_CLK_PLL_SEL_MASK		= 1 << CORE_CLK_PLL_SEL_SHIFT,
+	CORE_CLK_PLL_SEL_APLL		= 0,
+	CORE_CLK_PLL_SEL_GPLL,
+	CORE_DIV_CON_SHIFT		= 0,
+	CORE_DIV_CON_MASK		= 0x1f << CORE_DIV_CON_SHIFT,
+
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
+	/* CLKSEL9CON */
+	PCLK_PERI_DIV_CON_SHIFT		= 12,
+	PCLK_PERI_DIV_CON_MASK		= 0x3 << PCLK_PERI_DIV_CON_SHIFT,
+	HCLK_PERI_DIV_CON_SHIFT		= 8,
+	HCLK_PERI_DIV_CON_MASK		= 3 << HCLK_PERI_DIV_CON_SHIFT,
+	CLK_PERI_PLL_SEL_CPLL		= 0,
+	CLK_PERI_PLL_SEL_GPLL,
+	CLK_PERI_PLL_SEL_SHIFT		= 7,
+	CLK_PERI_PLL_SEL_MASK		= 1 << CLK_PERI_PLL_SEL_SHIFT,
+	ACLK_PERI_DIV_CON_SHIFT		= 0,
+	ACLK_PERI_DIV_CON_MASK		= 0x1f,
+
+	/* CLKSEL10CON */
+	CLK_CRYPTO_DIV_CON_SHIFT	= 14,
+	CLK_CRYPTO_DIV_CON_MASK		= 0x3 << CLK_CRYPTO_DIV_CON_SHIFT,
+	PCLK_ALIVE_DIV_CON_SHIFT	= 8,
+	PCLK_ALIVE_DIV_CON_MASK		= 0x1f << PCLK_ALIVE_DIV_CON_SHIFT,
+
 	/* CLKSEL12_CON */
 	MCU_STCLK_DIV_SHIFT		= 8,
 	MCU_STCLK_DIV_MASK		= GENMASK(10, 8),
@@ -90,6 +133,23 @@ enum {
 	MCU_CLK_DIV_SHIFT		= 0,
 	MCU_CLK_DIV_MASK		= GENMASK(4, 0),
 
+	/* CLKSEL19_CON */
+	ACLK_VOP_PLL_SEL_SHIFT		= 6,
+	ACLK_VOP_PLL_SEL_MASK		= GENMASK(7, 6),
+	ACLK_VOP_PLL_SEL_CPLL		= 0,
+	ACLK_VOP_PLL_SEL_GPLL		= 1,
+	ACLK_VOP_DIV_SHIFT		= 0,
+	ACLK_VOP_DIV_MASK		= GENMASK(4, 0),
+
+	/* CLKSEL20_CON */
+	DCLK_VOP_PLL_SEL_SHIFT		= 8,
+	DCLK_VOP_PLL_SEL_MASK		= GENMASK(9, 8),
+	DCLK_VOP_PLL_SEL_CPLL		= 0,
+	DCLK_VOP_PLL_SEL_GPLL		= 1,
+	DCLK_VOP_PLL_SEL_NPLL		= 2,
+	DCLK_VOP_DIV_SHIFT		= 0,
+	DCLK_VOP_DIV_MASK		= GENMASK(7, 0),
+
 	/* CLKSEL_CON25 */
 	CLK_SARADC_DIV_CON_SHIFT	= 8,
 	CLK_SARADC_DIV_CON_MASK		= GENMASK(15, 8),
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 6691801384..aba7f2cd47 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -451,6 +451,82 @@ static ulong rk3368_saradc_set_clk(struct rk3368_cru *cru, uint hz)
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
@@ -467,6 +543,17 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
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
@@ -498,6 +585,13 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
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

