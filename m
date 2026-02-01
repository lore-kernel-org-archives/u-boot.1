Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A38E7C6F9
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A7C83BB1;
	Sun,  1 Feb 2026 01:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGWNhGLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667E583AAD; Sun,  1 Feb 2026 01:45:17 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D7583B85
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79495b1aaa7so26912127b3.1
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906713; x=1770511513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8AQUv52pL5zBO8qGYsf4Vt+TxWQ1+IK+fUKQPMiPPA=;
 b=lGWNhGLCzlx1E1P+v4bDhtZNGVyQMYNICd7Ty92RvKF2V62qGiGXFFHBOf7EwK35Lx
 M+GSxU90j8D9j6RLd1ZGPaS931LFP5K2IVaXHtkJ/KlizphP/Qxnszv/F2ZNQCI3EZFr
 xL+bbnuC7Y5ltDdWFt+3jyhyosBHEdTlDgfIgdVdKlBcsnt4bnE7Wl9XGYD6dudNTB74
 8wTYvOKo5FHwCwDSPmpP7i+HVmoGI8TwVtv5HCUyjwyuodvgO4z5W5qPZKn+QdcI7Lsj
 3SrStN0GxFgHA9/FXbfhxFbKDLOgKCPpbas5JKoozU4LCDPw9tOXq3z191E4cH4hImi1
 TNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906713; x=1770511513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p8AQUv52pL5zBO8qGYsf4Vt+TxWQ1+IK+fUKQPMiPPA=;
 b=jDt+14psKwcXGNGuqgK2O8PUsAnczJeJsc9prELCsE1jE6FDIrLRLiVgzdpxrAR9rZ
 pN8wG1BOJVavD+AnF+deBOCDH3cZlcXWsGqgTEGwU8sPu4PbO7VfZf4CLszFL0KL78IB
 RMy0JMasjbrIGkyu3Owy/S2nq3uxm2MoPSrmn0vugXuz+u4rCzybfkHotWlEbd3N3hvY
 MN6uhUXMnsleJ/rfkNO/KGh2IF1samURIfdDq8gd6RSwrZ8k8paKpRIiEPmIAkdhkAYg
 n7nQOj0fm6CIKefcS3BsUFgCc09r8cFzcrGJQh/Ip2yD563SEr4x41c81vamArsW8qHT
 +AbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUinHpYQSq1gvxrBlAttli1PQQ6nzTzHltvCMXfKzA66s7hWFaufkeLdlDQf2TUjqVL4u8k19g=@lists.denx.de
X-Gm-Message-State: AOJu0YyTfILaJBR1Ty0YTSAXdYf7chcpHS4yBFJpiBKQjwx1QLf0kJGj
 68riO2q1Tf3d52iFmvpIxbYSKD6gZa/UhXXHgkJf4ysp2trHxOScega4
X-Gm-Gg: AZuq6aIKa8XYgqNBxQUXnvRuxBdfIR24fvP1+KGM5/QRnQYd54IidgLReQuXDvBlemz
 +jIqskDALeiYRmBBqeBt1Lwsy3R2gkp7BFCyCrT7A+TKjL7fQCnTJoqc5NYPDA6dEUK/hzf5nx1
 7+6oIYSAn91cpuLMl/zCIV//kMfc5D+cCQfpgKDHR/FYz5enHorFIsmkaTWjAdy9Tgt10PvoRCP
 Yud+QeBwPyhHohdnRC1rcba+5ejY3/Vy8lCWEmAjRyxsJrt185ePiBjrsDelloUjviIhqIlqCpu
 3pZsxNJ1qIXkdMCsam9zymL/mEENIKsZmfUEeQLQO2CLSnZkPpoCINGhqU3A1ExFzog3ctA3K9X
 VsCqsjPE7lOvD9EgzJIky9KNvBKF+SvtPKSrvcz5u/9wn+0NZ/T6BtKwN7HjIq7L2Mi+zYZv21b
 sbyH6bVHUv5PzMgSbzJpYUSihL
X-Received: by 2002:a05:690c:9a85:b0:794:9c07:de16 with SMTP id
 00721157ae682-7949de84b1bmr61551707b3.6.1769906712523; 
 Sat, 31 Jan 2026 16:45:12 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:12 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 2/7] clk: rockchip: Add support for RV1103
Date: Sat, 31 Jan 2026 21:44:51 -0300
Message-Id: <20260201004456.763107-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add clock driver for RV1103.

Imported from Rockchip U-Boot 2017.09 next-dev branch.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 .../include/asm/arch-rockchip/cru_rv1103.h    |  271 +++++
 .../include/asm/arch-rockchip/grf_rv1103.h    |   31 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rv1103.c             | 1068 +++++++++++++++++
 4 files changed, 1371 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103.h
 create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103.h
 create mode 100644 drivers/clk/rockchip/clk_rv1103.c

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1103.h b/arch/arm/include/asm/arch-rockchip/cru_rv1103.h
new file mode 100644
index 000000000000..c082d697231e
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/cru_rv1103.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _ASM_ARCH_CRU_RV1103B_H
+#define _ASM_ARCH_CRU_RV1103B_H
+
+#define MHz		1000000
+#define KHz		1000
+#define OSC_HZ		(24 * MHz)
+#define RC_OSC_HZ	(125 * MHz)
+
+#define GPLL_HZ		(1188 * MHz)
+
+/* RV1103B pll id */
+enum rv1103b_pll_id {
+	GPLL,
+	PLL_COUNT,
+};
+
+struct rv1103b_clk_info {
+	unsigned long id;
+	char *name;
+	bool is_cru;
+};
+
+struct rv1103b_clk_priv {
+	struct rv1103b_cru *cru;
+	struct rv1103b_grf *grf;
+	ulong gpll_hz;
+	ulong armclk_hz;
+	ulong armclk_enter_hz;
+	ulong armclk_init_hz;
+	bool sync_kernel;
+	bool set_armclk_rate;
+};
+
+struct rv1103b_grf_clk_priv {
+	struct rv1103b_grf *grf;
+};
+
+struct rv1103b_pll {
+	unsigned int con0;
+	unsigned int con1;
+	unsigned int con2;
+	unsigned int con3;
+	unsigned int con4;
+	unsigned int reserved0[3];
+};
+
+struct rv1103_clk_priv {
+	struct rv1103b_cru *cru;
+	ulong rate;
+};
+
+struct rv1103b_cru {
+	unsigned int reserved0[192];
+	unsigned int peri_clksel_con[4];
+	unsigned int reserved1[316];
+	unsigned int peri_clkgate_con[12];
+	unsigned int reserved2[116];
+	unsigned int peri_softrst_con[12];
+	unsigned int reserved3[15924];
+	unsigned int vepu_clksel_con[3];
+	unsigned int reserved4[317];
+	unsigned int vepu_clkgate_con[1];
+	unsigned int reserved5[127];
+	unsigned int vepu_softrst_con[1];
+	unsigned int reserved6[15935];
+	unsigned int npu_clksel_con[3];
+	unsigned int reserved7[317];
+	unsigned int npu_clkgate_con[1];
+	unsigned int reserved8[127];
+	unsigned int npu_softrst_con[1];
+	unsigned int reserved9[15935];
+	unsigned int vi_clksel_con[1];
+	unsigned int reserved10[319];
+	unsigned int vi_clkgate_con[3];
+	unsigned int reserved11[125];
+	unsigned int vi_softrst_con[3];
+	unsigned int reserved12[15933];
+	unsigned int core_clksel_con[3];
+	unsigned int reserved13[16381];
+	unsigned int ddr_clksel_con[1];
+	unsigned int reserved14[16207];
+	struct rv1103b_pll pll[2];
+	unsigned int reserved15[128];
+	unsigned int mode;
+	unsigned int reserved16[31];
+	unsigned int clksel_con[42];
+	unsigned int reserved17[278];
+	unsigned int clkgate_con[7];
+	unsigned int reserved18[121];
+	unsigned int softrst_con[1];
+	unsigned int reserved19[127];
+	unsigned int glb_cnt_th;
+	unsigned int glb_rst_st;
+	unsigned int glb_srst_fst;
+	unsigned int glb_srst_snd;
+	unsigned int glb_rst_con;
+	unsigned int reserved20[15803];
+	unsigned int pmu_clksel_con[3];
+	unsigned int reserved21[317];
+	unsigned int pmu_clkgate_con[3];
+	unsigned int reserved22[125];
+	unsigned int pmu_softrst_con[3];
+	unsigned int reserved23[15933];
+	unsigned int pmu1_clksel_con[1];
+	unsigned int reserved24[319];
+	unsigned int pmu1_clkgate_con[2];
+	unsigned int reserved25[126];
+	unsigned int pmu1_softrst_con[2];
+};
+
+check_member(rv1103b_cru, pmu1_softrst_con[1], 0x80a04);
+
+struct pll_rate_table {
+	unsigned long rate;
+	unsigned int fbdiv;
+	unsigned int postdiv1;
+	unsigned int refdiv;
+	unsigned int postdiv2;
+	unsigned int dsmpd;
+	unsigned int frac;
+};
+
+#define RV1103B_TOPCRU_BASE		0x60000
+#define RV1103B_PERICRU_BASE		0x0
+#define RV1103B_VICRU_BASE		0x30000
+#define RV1103B_NPUCRU_BASE		0x20000
+#define RV1103B_CORECRU_BASE		0x40000
+#define RV1103B_VEPUCRU_BASE		0x10000
+#define RV1103B_DDRCRU_BASE		0x50000
+#define RV1103B_SUBDDRCRU_BASE		0x58000
+#define RV1103B_PMUCRU_BASE		0x70000
+#define RV1103B_PMU1CRU_BASE		0x80000
+
+#define RV1103B_CRU_BASE		0x20000000
+
+#define RV1103B_PLL_CON(x)		((x) * 0x4 + RV1103B_TOPCRU_BASE)
+#define RV1103B_MODE_CON		(0x280 + RV1103B_TOPCRU_BASE)
+#define RV1103B_CLKSEL_CON(x)		((x) * 0x4 + 0x300 + RV1103B_TOPCRU_BASE)
+#define RV1103B_SUBDDRMODE_CON		(0x280 + RV1103B_SUBDDRCRU_BASE)
+
+enum {
+	/* CORECRU_CLK_SEL0_CON */
+	CLK_CORE_SRC_SEL_SHIFT		= 1,
+	CLK_CORE_SRC_SEL_MASK		= 0x1 << CLK_CORE_SRC_SEL_SHIFT,
+	CLK_CORE_SRC_SEL_GPLL		= 0,
+	CLK_CORE_SRC_SEL_PVTPLL,
+
+	/* CRU_PERI_CLK_SEL0_CON */
+	CLK_TSADC_TSEN_DIV_SHIFT	= 10,
+	CLK_TSADC_TSEN_DIV_MASK		= 0x1f << CLK_TSADC_TSEN_DIV_SHIFT,
+	CLK_TSADC_DIV_SHIFT		= 4,
+	CLK_TSADC_DIV_MASK		= 0x1f << CLK_TSADC_DIV_SHIFT,
+	PCLK_PERI_DIV_SHIFT		= 0,
+	PCLK_PERI_DIV_MASK		= 0x3 << PCLK_PERI_DIV_SHIFT,
+
+	/* CRU_PERI_CLK_SEL1_CON */
+	CLK_SARADC_DIV_SHIFT		= 0,
+	CLK_SARADC_DIV_MASK		= 0x7 << CLK_SARADC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL5_CON */
+	CLK_UART2_SRC_DIV_SHIFT		= 10,
+	CLK_UART2_SRC_DIV_MASK		= 0x1f << CLK_UART2_SRC_DIV_SHIFT,
+	CLK_UART1_SRC_DIV_SHIFT		= 5,
+	CLK_UART1_SRC_DIV_MASK		= 0x1f << CLK_UART1_SRC_DIV_SHIFT,
+	CLK_UART0_SRC_DIV_SHIFT		= 0,
+	CLK_UART0_SRC_DIV_MASK		= 0x1f << CLK_UART0_SRC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL10_CON */
+	CLK_UART_FRAC_NUMERATOR_SHIFT	= 16,
+	CLK_UART_FRAC_NUMERATOR_MASK	= 0xffff << 16,
+	CLK_UART_FRAC_DENOMINATOR_SHIFT	= 0,
+	CLK_UART_FRAC_DENOMINATOR_MASK	= 0xffff,
+
+	/* CRU_CLK_SEL31_CON */
+	CLK_EMMC_SEL_SHIFT		= 15,
+	CLK_EMMC_SEL_MASK		= 0x1 << CLK_EMMC_SEL_SHIFT,
+	ACLK_PERI_SEL_SHIFT		= 10,
+	ACLK_PERI_SEL_MASK		= 0x3 << ACLK_PERI_SEL_SHIFT,
+	ACLK_PERI_SEL_600M		= 0,
+	ACLK_PERI_SEL_480M,
+	ACLK_PERI_SEL_400M,
+	LSCLK_PERI_SEL_SHIFT		= 9,
+	LSCLK_PERI_SEL_MASK		= 0x1 << LSCLK_PERI_SEL_SHIFT,
+	LSCLK_PERI_SEL_300M		= 0,
+	LSCLK_PERI_SEL_200M,
+	CLK_EMMC_DIV_SHIFT		= 0,
+	CLK_EMMC_DIV_MASK		= 0xff << CLK_EMMC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL32_CON */
+	CLK_SDMMC_SEL_SHIFT		= 15,
+	CLK_SDMMC_SEL_MASK		= 0x1 << CLK_SDMMC_SEL_SHIFT,
+	CLK_MMC_SEL_GPLL		= 0,
+	CLK_MMC_SEL_OSC,
+	CLK_UART2_SEL_SHIFT		= 12,
+	CLK_UART2_SEL_MASK		= 3 << CLK_UART2_SEL_SHIFT,
+	CLK_UART1_SEL_SHIFT		= 10,
+	CLK_UART1_SEL_MASK		= 3 << CLK_UART1_SEL_SHIFT,
+	CLK_UART0_SEL_SHIFT		= 8,
+	CLK_UART0_SEL_MASK		= 3 << CLK_UART0_SEL_SHIFT,
+	CLK_UART_SEL_SRC		= 0,
+	CLK_UART_SEL_FRAC,
+	CLK_UART_SEL_OSC,
+	CLK_SDMMC_DIV_SHIFT		= 0,
+	CLK_SDMMC_DIV_MASK		= 0xff << CLK_SDMMC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL33_CON */
+	CLK_SFC_SEL_SHIFT		= 15,
+	CLK_SFC_SEL_MASK		= 0x1 << CLK_SFC_SEL_SHIFT,
+	CLK_SFC_DIV_SHIFT		= 0,
+	CLK_SFC_DIV_MASK		= 0xff << CLK_SFC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL34_CON */
+	CLK_PWM2_SEL_SHIFT		= 14,
+	CLK_PWM2_SEL_MASK		= 1 << CLK_PWM2_SEL_SHIFT,
+	CLK_PWM1_SEL_SHIFT		= 13,
+	CLK_PWM1_SEL_MASK		= 1 << CLK_PWM1_SEL_SHIFT,
+	CLK_PWM0_SEL_SHIFT		= 12,
+	CLK_PWM0_SEL_MASK		= 1 << CLK_PWM0_SEL_SHIFT,
+	CLK_PWM_SEL_100M		= 0,
+	CLK_PWM_SEL_24M,
+	CLK_SPI0_SEL_SHIFT		= 2,
+	CLK_SPI0_SEL_MASK		= 3 << CLK_SPI0_SEL_SHIFT,
+	CLK_SPI0_SEL_200M		= 0,
+	CLK_SPI0_SEL_100M,
+	CLK_SPI0_SEL_50M,
+	CLK_SPI0_SEL_24M,
+	CLK_I2C1_SEL_SHIFT		= 1,
+	CLK_I2C1_SEL_MASK		= 0x1 << CLK_I2C1_SEL_SHIFT,
+	CLK_I2C0_SEL_SHIFT		= 0,
+	CLK_I2C0_SEL_MASK		= 0x1 << CLK_I2C0_SEL_SHIFT,
+	CLK_I2C_SEL_100M		= 0,
+	CLK_I2C_SEL_24M,
+
+	/* CRU_CLK_SEL35_CON */
+	CLK_PKA_CRYPTO_SEL_SHIFT	= 4,
+	CLK_PKA_CRYPTO_SEL_MASK		= 0x3 << CLK_PKA_CRYPTO_SEL_SHIFT,
+	CLK_CORE_CRYPTO_SEL_SHIFT	= 2,
+	CLK_CORE_CRYPTO_SEL_MASK	= 0x3 << CLK_CORE_CRYPTO_SEL_SHIFT,
+	CLK_CORE_CRYPTO_SEL_300M	= 0,
+	CLK_CORE_CRYPTO_SEL_200M,
+	CLK_CORE_CRYPTO_SEL_100M,
+	DCLK_DECOM_SEL_SHIFT		= 0,
+	DCLK_DECOM_SEL_MASK		= 0x3 << DCLK_DECOM_SEL_SHIFT,
+	DCLK_DECOM_SEL_480M		= 0,
+	DCLK_DECOM_SEL_400M,
+	DCLK_DECOM_SEL_300M,
+
+	/* CRU_CLK_SEL37_CON */
+	CLK_CORE_GPLL_DIV_SHIFT		= 13,
+	CLK_CORE_GPLL_DIV_MASK		= 0x7 << CLK_CORE_GPLL_DIV_SHIFT,
+	CLK_CORE_GPLL_SEL_SHIFT		= 12,
+	CLK_CORE_GPLL_SEL_MASK		= 0x1 << CLK_CORE_GPLL_SEL_SHIFT,
+	CLK_CORE_GPLL_SEL_GPLL		= 0,
+	CLK_CORE_GPLL_SEL_OSC,
+
+	/* CRU_PMU_CLK_SEL2_CON */
+	LSCLK_PMU_SEL_SHIFT		= 4,
+	LSCLK_PMU_SEL_MASK		= 0x1 << LSCLK_PMU_SEL_SHIFT,
+	LSCLK_PMU_SEL_24M		= 0,
+	LSCLK_PMU_SEL_RC_OSC,
+	LSCLK_PMU_DIV_SHIFT		= 0,
+	LSCLK_PMU_DIV_MASK		= 0x3 << LSCLK_PMU_DIV_SHIFT,
+
+};
+#endif
diff --git a/arch/arm/include/asm/arch-rockchip/grf_rv1103.h b/arch/arm/include/asm/arch-rockchip/grf_rv1103.h
new file mode 100644
index 000000000000..c5bcb8962bb5
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/grf_rv1103.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier:     GPL-2.0+ */
+
+/*
+ * (C) Copyright 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _ASM_ARCH_GRF_RV1103B_H
+#define _ASM_ARCH_GRF_RV1103B_H
+
+#define VEPU_GRF	0x20100000
+#define NPU_GRF		0x20110000
+#define VI_GRF		0x20120000
+#define CPU_GRF		0x20130000
+#define DDR_GRF		0x20140000
+#define SYS_GRF		0x20150000
+#define PMU_GRF		0x20160000
+
+struct rv1103_grf {
+	u32 reserved0[(SYS_GRF + 0xA0 - VEPU_GRF) / 4];
+	u32 gmac_con0;				/* address offset: 0x00a0 */
+	u32 gmac_clk_con;			/* address offset: 0x00a4 */
+	u32 gmac_st;				/* address offset: 0x00a8 */
+	u32 reserved00ac;			/* address offset: 0x00ac */
+	u32 macphy_con0;			/* address offset: 0x00b0 */
+	u32 macphy_con1;			/* address offset: 0x00b4 */
+	u32 reserved1[(PMU_GRF + 0x10000 - (SYS_GRF + 0xB4)) / 4];
+};
+
+check_member(rv1103_grf, macphy_con1, SYS_GRF + 0xB4 - VEPU_GRF);
+
+#endif /*  _ASM_ARCH_GRF_RV1103B_H  */
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 34b63d4df34a..bb1332542d52 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_ROCKCHIP_RK3528) += clk_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += clk_rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3576) += clk_rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += clk_rk3588.o
+obj-$(CONFIG_ROCKCHIP_RV1103) += clk_rv1103.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += clk_rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += clk_rv1126.o
diff --git a/drivers/clk/rockchip/clk_rv1103.c b/drivers/clk/rockchip/clk_rv1103.c
new file mode 100644
index 000000000000..b13f34cafccb
--- /dev/null
+++ b/drivers/clk/rockchip/clk_rv1103.c
@@ -0,0 +1,1068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#include <bitfield.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/io.h>
+#include <dm/lists.h>
+#include <dt-bindings/clock/rv1103-cru.h>
+
+#include <clk.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/global_data.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rv1103.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/delay.h>
+#include <linux/stringify.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
+
+#ifndef BITS_WITH_WMASK
+#define BITS_WITH_WMASK(bits, msk, shift) \
+	((bits) << (shift)) | ((msk) << ((shift) + 16))
+#endif
+
+static struct rockchip_pll_rate_table rv1103b_pll_rates[] = {
+	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
+	RK3036_PLL_RATE(1188000000, 1, 99, 2, 1, 1, 0),
+	RK3036_PLL_RATE(594000000, 1, 99, 4, 1, 1, 0),
+	{ /* sentinel */ },
+};
+
+static struct rockchip_pll_clock rv1103b_pll_clks[] = {
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RV1103B_PLL_CON(24),
+		     RV1103B_MODE_CON, 0, 10, 0, rv1103b_pll_rates),
+};
+
+static ulong rv1103b_peri_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 con, sel, div, rate, prate;
+
+	switch (clk_id) {
+	case ACLK_PERI_SRC:
+		con = readl(&cru->clksel_con[31]);
+		sel = (con & ACLK_PERI_SEL_MASK) >> ACLK_PERI_SEL_SHIFT;
+		if (sel == ACLK_PERI_SEL_600M)
+			rate = 600 * MHz;
+		else if (sel == ACLK_PERI_SEL_480M)
+			rate = 480 * MHz;
+		else
+			rate = 400 * MHz;
+		break;
+	case LSCLK_PERI_SRC:
+		con = readl(&cru->clksel_con[31]);
+		sel = (con & LSCLK_PERI_SEL_MASK) >> LSCLK_PERI_SEL_SHIFT;
+		if (sel == LSCLK_PERI_SEL_300M)
+			rate = 300 * MHz;
+		else
+			rate = 200 * MHz;
+		break;
+	case PCLK_PERI_ROOT:
+		con = readl(&cru->peri_clksel_con[0]);
+		div = (con & PCLK_PERI_DIV_MASK) >> PCLK_PERI_DIV_SHIFT;
+		rate = DIV_TO_RATE(rv1103b_peri_get_clk(priv, LSCLK_PERI_SRC),
+				   div);
+		break;
+	case PCLK_TOP_ROOT:
+		rate = DIV_TO_RATE(priv->gpll_hz, 11);
+		break;
+	case LSCLK_PMU_ROOT:
+	case PCLK_PMU:
+		con = readl(&cru->pmu_clksel_con[2]);
+		sel = (con & LSCLK_PMU_SEL_MASK) >> LSCLK_PMU_SEL_SHIFT;
+		div = (con & LSCLK_PMU_DIV_MASK) >> LSCLK_PMU_DIV_SHIFT;
+		if (sel == LSCLK_PMU_SEL_24M)
+			prate = OSC_HZ;
+		else
+			prate = RC_OSC_HZ;
+		rate = DIV_TO_RATE(prate, div);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+}
+
+static ulong rv1103b_peri_set_clk(struct rv1103b_clk_priv *priv,
+				  ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	int src_clk, div;
+
+	switch (clk_id) {
+	case ACLK_PERI_SRC:
+		if (rate >= 594 * MHz)
+			src_clk = ACLK_PERI_SEL_600M;
+		else if (rate >= 480 * MHz)
+			src_clk = ACLK_PERI_SEL_480M;
+		else
+			src_clk = ACLK_PERI_SEL_400M;
+		rk_clrsetreg(&cru->clksel_con[31],
+			     ACLK_PERI_SEL_MASK,
+			     src_clk << ACLK_PERI_SEL_SHIFT);
+		break;
+	case LSCLK_PERI_SRC:
+		if (rate >= 297 * MHz)
+			src_clk = LSCLK_PERI_SEL_300M;
+		else
+			src_clk = LSCLK_PERI_SEL_200M;
+		rk_clrsetreg(&cru->clksel_con[31],
+			     LSCLK_PERI_SEL_MASK,
+			     src_clk << LSCLK_PERI_SEL_SHIFT);
+		break;
+	case PCLK_PERI_ROOT:
+		div = DIV_ROUND_UP(rv1103b_peri_get_clk(priv, LSCLK_PERI_SRC),
+				   rate);
+		rk_clrsetreg(&cru->peri_clksel_con[0],
+			     PCLK_PERI_DIV_MASK,
+			     (div - 1) << PCLK_PERI_DIV_SHIFT);
+		break;
+	case PCLK_TOP_ROOT:
+		break;
+	case LSCLK_PMU_ROOT:
+	case PCLK_PMU:
+		if (!(OSC_HZ % rate)) {
+			src_clk = LSCLK_PMU_SEL_24M;
+			div = DIV_ROUND_UP(OSC_HZ, rate);
+		} else {
+			src_clk = LSCLK_PMU_SEL_RC_OSC;
+			div = DIV_ROUND_UP(RC_OSC_HZ, rate);
+		}
+		rk_clrsetreg(&cru->pmu_clksel_con[2],
+			     LSCLK_PMU_SEL_MASK | LSCLK_PMU_DIV_MASK,
+			     (src_clk << LSCLK_PMU_SEL_SHIFT) |
+			     ((div - 1) << LSCLK_PMU_DIV_SHIFT));
+		break;
+	default:
+		printf("do not support this permid freq\n");
+		return -EINVAL;
+	}
+
+	return rv1103b_peri_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_i2c_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, con;
+	ulong rate;
+
+	switch (clk_id) {
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C_PERI:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_I2C1_SEL_MASK) >> CLK_I2C1_SEL_SHIFT;
+		break;
+	case CLK_I2C0:
+	case CLK_I2C_PMU:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_I2C0_SEL_MASK) >> CLK_I2C0_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (sel == CLK_I2C_SEL_100M)
+		rate = 100 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rv1103b_crypto_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, con, rate;
+
+	switch (clk_id) {
+	case ACLK_CRYPTO:
+	case HCLK_CRYPTO:
+	case HCLK_RK_RNG_NS:
+	case HCLK_RK_RNG_S:
+		return rv1103b_peri_get_clk(priv, LSCLK_PERI_SRC);
+	case CLK_CORE_CRYPTO:
+		con = readl(&cru->clksel_con[35]);
+		sel = (con & CLK_CORE_CRYPTO_SEL_MASK) >>
+		      CLK_CORE_CRYPTO_SEL_SHIFT;
+		break;
+	case CLK_PKA_CRYPTO:
+		con = readl(&cru->clksel_con[35]);
+		sel = (con & CLK_PKA_CRYPTO_SEL_MASK) >>
+		      CLK_PKA_CRYPTO_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+	if (sel == CLK_CORE_CRYPTO_SEL_300M)
+		rate = 300 * MHz;
+	else if (sel == CLK_CORE_CRYPTO_SEL_200M)
+		rate = 200 * MHz;
+	else
+		rate = 100 * MHz;
+
+	return rate;
+}
+
+static ulong rv1103b_crypto_set_clk(struct rv1103b_clk_priv *priv,
+				    ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel;
+
+	if (rate >= 297 * MHz)
+		sel = CLK_CORE_CRYPTO_SEL_300M;
+	else if (rate >= 198 * MHz)
+		sel = CLK_CORE_CRYPTO_SEL_200M;
+	else
+		sel = CLK_CORE_CRYPTO_SEL_100M;
+
+	switch (clk_id) {
+	case ACLK_CRYPTO:
+	case HCLK_CRYPTO:
+	case HCLK_RK_RNG_NS:
+	case HCLK_RK_RNG_S:
+		rv1103b_peri_set_clk(priv, LSCLK_PERI_SRC, rate);
+	case CLK_CORE_CRYPTO:
+		rk_clrsetreg(&cru->clksel_con[35],
+			     CLK_CORE_CRYPTO_SEL_MASK,
+			     (sel << CLK_CORE_CRYPTO_SEL_SHIFT));
+		break;
+	case CLK_PKA_CRYPTO:
+		rk_clrsetreg(&cru->clksel_con[35],
+			     CLK_PKA_CRYPTO_SEL_MASK,
+			     (sel << CLK_PKA_CRYPTO_SEL_SHIFT));
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rv1103b_crypto_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_mmc_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 div, sel, con, prate;
+
+	switch (clk_id) {
+	case CCLK_SDMMC1:
+	case HCLK_SDMMC1:
+		con = readl(&cru->clksel_con[36]);
+		sel = (con & CLK_SDMMC_SEL_MASK) >>
+		      CLK_SDMMC_SEL_SHIFT;
+		div = (con & CLK_SDMMC_DIV_MASK) >>
+		      CLK_SDMMC_DIV_SHIFT;
+		if (sel == CLK_MMC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case CCLK_SDMMC0:
+	case HCLK_SDMMC0:
+		con = readl(&cru->clksel_con[32]);
+		sel = (con & CLK_SDMMC_SEL_MASK) >>
+		      CLK_SDMMC_SEL_SHIFT;
+		div = (con & CLK_SDMMC_DIV_MASK) >>
+		      CLK_SDMMC_DIV_SHIFT;
+		if (sel == CLK_MMC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case CCLK_EMMC:
+	case HCLK_EMMC:
+		con = readl(&cru->clksel_con[31]);
+		sel = (con & CLK_EMMC_SEL_MASK) >>
+		      CLK_EMMC_SEL_SHIFT;
+		div = (con & CLK_EMMC_DIV_MASK) >>
+		      CLK_EMMC_DIV_SHIFT;
+		if (sel == CLK_MMC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case SCLK_SFC_2X:
+	case HCLK_SFC:
+		con = readl(&cru->clksel_con[33]);
+		sel = (con & CLK_SFC_SEL_MASK) >>
+		      CLK_SFC_SEL_SHIFT;
+		div = (con & CLK_SFC_DIV_MASK) >>
+		      CLK_SFC_DIV_SHIFT;
+		if (sel == CLK_MMC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rv1103b_mmc_set_clk(struct rv1103b_clk_priv *priv,
+				 ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, src_clk_div;
+	ulong prate = 0;
+
+	if ((OSC_HZ % rate) == 0) {
+		sel = CLK_MMC_SEL_OSC;
+		prate = OSC_HZ;
+	} else {
+		sel = CLK_MMC_SEL_GPLL;
+		prate = priv->gpll_hz;
+	}
+	src_clk_div = DIV_ROUND_UP(prate, rate);
+
+	switch (clk_id) {
+	case CCLK_SDMMC1:
+	case HCLK_SDMMC1:
+		src_clk_div = DIV_ROUND_UP(prate, rate);
+		rk_clrsetreg(&cru->clksel_con[36],
+			     CLK_SDMMC_SEL_MASK |
+			     CLK_SDMMC_DIV_MASK,
+			     (sel << CLK_SDMMC_SEL_SHIFT) |
+			     ((src_clk_div - 1) <<
+			      CLK_SDMMC_DIV_SHIFT));
+		break;
+	case CCLK_SDMMC0:
+	case HCLK_SDMMC0:
+		src_clk_div = DIV_ROUND_UP(prate, rate);
+		rk_clrsetreg(&cru->clksel_con[32],
+			     CLK_SDMMC_SEL_MASK |
+			     CLK_SDMMC_DIV_MASK,
+			     (sel << CLK_SDMMC_SEL_SHIFT) |
+			     ((src_clk_div - 1) <<
+			      CLK_SDMMC_DIV_SHIFT));
+		break;
+	case CCLK_EMMC:
+	case HCLK_EMMC:
+		src_clk_div = DIV_ROUND_UP(prate, rate);
+		rk_clrsetreg(&cru->clksel_con[31],
+			     CLK_EMMC_SEL_MASK |
+			     CLK_EMMC_DIV_MASK,
+			     (sel << CLK_EMMC_SEL_SHIFT) |
+			     ((src_clk_div - 1) <<
+			      CLK_EMMC_DIV_SHIFT));
+		break;
+	case SCLK_SFC_2X:
+	case HCLK_SFC:
+		src_clk_div = DIV_ROUND_UP(prate, rate);
+		rk_clrsetreg(&cru->clksel_con[33],
+			     CLK_SFC_SEL_MASK |
+			     CLK_SFC_DIV_MASK,
+			     (sel << CLK_SFC_SEL_SHIFT) |
+			     ((src_clk_div - 1) <<
+			      CLK_SFC_DIV_SHIFT));
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rv1103b_mmc_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_i2c_set_clk(struct rv1103b_clk_priv *priv, ulong clk_id,
+				 ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate == OSC_HZ)
+		src_clk = CLK_I2C_SEL_24M;
+	else
+		src_clk = CLK_I2C_SEL_100M;
+
+	switch (clk_id) {
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C_PERI:
+		rk_clrsetreg(&cru->clksel_con[34], CLK_I2C1_SEL_MASK,
+			     src_clk << CLK_I2C1_SEL_SHIFT);
+		break;
+	case CLK_I2C0:
+	case CLK_I2C_PMU:
+		rk_clrsetreg(&cru->clksel_con[34], CLK_I2C0_SEL_MASK,
+			     src_clk << CLK_I2C0_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rv1103b_i2c_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_spi_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, con, rate;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_SPI0_SEL_MASK) >> CLK_SPI0_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+	if (sel == CLK_SPI0_SEL_200M)
+		rate = 200 * MHz;
+	else if (sel == CLK_SPI0_SEL_100M)
+		rate = 100 * MHz;
+	else if (sel == CLK_SPI0_SEL_50M)
+		rate = 50 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rv1103b_spi_set_clk(struct rv1103b_clk_priv *priv,
+				 ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate >= 198 * MHz)
+		src_clk = CLK_SPI0_SEL_200M;
+	else if (rate >= 99 * MHz)
+		src_clk = CLK_SPI0_SEL_100M;
+	else if (rate >= 48 * MHz)
+		src_clk = CLK_SPI0_SEL_50M;
+	else
+		src_clk = CLK_SPI0_SEL_24M;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		rk_clrsetreg(&cru->clksel_con[34], CLK_SPI0_SEL_MASK,
+			     src_clk << CLK_SPI0_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rv1103b_spi_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_pwm_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, con;
+
+	switch (clk_id) {
+	case CLK_PWM0:
+	case CLK_PWM0_SRC:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_PWM0_SEL_MASK) >> CLK_PWM0_SEL_SHIFT;
+		break;
+	case CLK_PWM1:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_PWM1_SEL_MASK) >> CLK_PWM1_SEL_SHIFT;
+		break;
+	case CLK_PWM2:
+		con = readl(&cru->clksel_con[34]);
+		sel = (con & CLK_PWM2_SEL_MASK) >> CLK_PWM2_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	switch (sel) {
+	case CLK_PWM_SEL_100M:
+		return 100 * MHz;
+	case CLK_PWM_SEL_24M:
+		return OSC_HZ;
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rv1103b_pwm_set_clk(struct rv1103b_clk_priv *priv,
+				 ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate >= 99 * MHz)
+		src_clk = CLK_PWM_SEL_100M;
+	else
+		src_clk = CLK_PWM_SEL_24M;
+
+	switch (clk_id) {
+	case CLK_PWM0:
+	case CLK_PWM0_SRC:
+		rk_clrsetreg(&cru->clksel_con[34],
+			     CLK_PWM0_SEL_MASK,
+			     src_clk << CLK_PWM0_SEL_SHIFT);
+		break;
+	case CLK_PWM1:
+		rk_clrsetreg(&cru->clksel_con[34],
+			     CLK_PWM1_SEL_MASK,
+			     src_clk << CLK_PWM1_SEL_SHIFT);
+		break;
+	case CLK_PWM2:
+		rk_clrsetreg(&cru->clksel_con[34],
+			     CLK_PWM2_SEL_MASK,
+			     src_clk << CLK_PWM2_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rv1103b_pwm_get_clk(priv, clk_id);
+}
+
+static ulong rv1103b_adc_get_clk(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 div, con;
+
+	switch (clk_id) {
+	case CLK_SARADC:
+		con = readl(&cru->peri_clksel_con[1]);
+		div = (con & CLK_SARADC_DIV_MASK) >>
+		      CLK_SARADC_DIV_SHIFT;
+		return DIV_TO_RATE(OSC_HZ, div);
+	case CLK_TSADC_TSEN:
+		con = readl(&cru->peri_clksel_con[0]);
+		div = (con & CLK_TSADC_TSEN_DIV_MASK) >>
+		      CLK_TSADC_TSEN_DIV_SHIFT;
+		return DIV_TO_RATE(OSC_HZ, div);
+	case CLK_TSADC:
+		con = readl(&cru->peri_clksel_con[0]);
+		div = (con & CLK_TSADC_DIV_MASK) >> CLK_TSADC_DIV_SHIFT;
+		return DIV_TO_RATE(OSC_HZ, div);
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rv1103b_adc_set_clk(struct rv1103b_clk_priv *priv,
+				 ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	int src_clk_div;
+
+	src_clk_div = DIV_ROUND_UP(OSC_HZ, rate);
+
+	switch (clk_id) {
+	case CLK_SARADC:
+		assert(src_clk_div - 1 <= 7);
+		rk_clrsetreg(&cru->peri_clksel_con[1],
+			     CLK_SARADC_DIV_MASK,
+			     (src_clk_div - 1) <<
+			     CLK_SARADC_DIV_SHIFT);
+		break;
+	case CLK_TSADC_TSEN:
+		assert(src_clk_div - 1 <= 32);
+		rk_clrsetreg(&cru->peri_clksel_con[0],
+			     CLK_TSADC_TSEN_DIV_MASK,
+			     (src_clk_div - 1) <<
+			     CLK_TSADC_TSEN_DIV_SHIFT);
+		break;
+	case CLK_TSADC:
+		assert(src_clk_div - 1 <= 32);
+		rk_clrsetreg(&cru->peri_clksel_con[0],
+			     CLK_TSADC_DIV_MASK,
+			     (src_clk_div - 1) <<
+			     CLK_TSADC_DIV_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rv1103b_adc_get_clk(priv, clk_id);
+}
+
+/*
+ *
+ * rational_best_approximation(31415, 10000,
+ *		(1 << 8) - 1, (1 << 5) - 1, &n, &d);
+ *
+ * you may look at given_numerator as a fixed point number,
+ * with the fractional part size described in given_denominator.
+ *
+ * for theoretical background, see:
+ * http://en.wikipedia.org/wiki/Continued_fraction
+ */
+static void rational_best_approximation(unsigned long given_numerator,
+					unsigned long given_denominator,
+					unsigned long max_numerator,
+					unsigned long max_denominator,
+					unsigned long *best_numerator,
+					unsigned long *best_denominator)
+{
+	unsigned long n, d, n0, d0, n1, d1;
+
+	n = given_numerator;
+	d = given_denominator;
+	n0 = 0;
+	d1 = 0;
+	n1 = 1;
+	d0 = 1;
+	for (;;) {
+		unsigned long t, a;
+
+		if (n1 > max_numerator || d1 > max_denominator) {
+			n1 = n0;
+			d1 = d0;
+			break;
+		}
+		if (d == 0)
+			break;
+		t = d;
+		a = n / d;
+		d = n % d;
+		n = t;
+		t = n0 + a * n1;
+		n0 = n1;
+		n1 = t;
+		t = d0 + a * d1;
+		d0 = d1;
+		d1 = t;
+	}
+	*best_numerator = n1;
+	*best_denominator = d1;
+}
+
+static ulong rv1103b_uart_get_rate(struct rv1103b_clk_priv *priv, ulong clk_id)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 reg, con, fracdiv, div, src, p_rate;
+	unsigned long m, n;
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		reg = 10;
+		con = readl(&cru->clksel_con[32]);
+		src = (con & CLK_UART0_SEL_MASK) >> CLK_UART0_SEL_SHIFT;
+		con = readl(&cru->clksel_con[5]);
+		div = (con & CLK_UART0_SRC_DIV_MASK) >> CLK_UART0_SRC_DIV_SHIFT;
+		break;
+	case SCLK_UART1:
+		reg = 11;
+		con = readl(&cru->clksel_con[32]);
+		src = (con & CLK_UART1_SEL_MASK) >> CLK_UART1_SEL_SHIFT;
+		con = readl(&cru->clksel_con[5]);
+		div = (con & CLK_UART1_SRC_DIV_MASK) >> CLK_UART1_SRC_DIV_SHIFT;
+		break;
+	case SCLK_UART2:
+		reg = 12;
+		con = readl(&cru->clksel_con[32]);
+		src = (con & CLK_UART2_SEL_MASK) >> CLK_UART2_SEL_SHIFT;
+		con = readl(&cru->clksel_con[5]);
+		div = (con & CLK_UART2_SRC_DIV_MASK) >> CLK_UART2_SRC_DIV_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	p_rate = priv->gpll_hz;
+	if (src == CLK_UART_SEL_SRC) {
+		return DIV_TO_RATE(p_rate, div);
+	} else if (src == CLK_UART_SEL_FRAC) {
+		fracdiv = readl(&cru->clksel_con[reg]);
+		n = fracdiv & CLK_UART_FRAC_NUMERATOR_MASK;
+		n >>= CLK_UART_FRAC_NUMERATOR_SHIFT;
+		m = fracdiv & CLK_UART_FRAC_DENOMINATOR_MASK;
+		m >>= CLK_UART_FRAC_DENOMINATOR_SHIFT;
+		return DIV_TO_RATE(p_rate, div) * n / m;
+	} else {
+		return OSC_HZ;
+	}
+}
+
+static ulong rv1103b_uart_set_rate(struct rv1103b_clk_priv *priv,
+				   ulong clk_id, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 reg, uart_src, div;
+	unsigned long m = 0, n = 0, val;
+
+	if (priv->gpll_hz % rate == 0) {
+		uart_src = CLK_UART_SEL_SRC;
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else if (rate == OSC_HZ) {
+		uart_src = CLK_UART_SEL_OSC;
+		div = 2;
+	} else {
+		uart_src = CLK_UART_SEL_FRAC;
+		div = 2;
+		rational_best_approximation(rate, priv->gpll_hz / div,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0),
+					    &m, &n);
+	}
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		reg = 10;
+		rk_clrsetreg(&cru->clksel_con[5],
+			     CLK_UART0_SRC_DIV_MASK,
+			     div << CLK_UART0_SRC_DIV_SHIFT);
+		rk_clrsetreg(&cru->clksel_con[32],
+			     CLK_UART0_SEL_MASK,
+			     uart_src << CLK_UART0_SEL_SHIFT);
+		break;
+	case SCLK_UART1:
+		reg = 11;
+		rk_clrsetreg(&cru->clksel_con[5],
+			     CLK_UART1_SRC_DIV_MASK,
+			     div << CLK_UART1_SRC_DIV_SHIFT);
+		rk_clrsetreg(&cru->clksel_con[32],
+			     CLK_UART1_SEL_MASK,
+			     uart_src << CLK_UART1_SEL_SHIFT);
+		break;
+	case SCLK_UART2:
+		reg = 12;
+		rk_clrsetreg(&cru->clksel_con[5],
+			     CLK_UART2_SRC_DIV_MASK,
+			     div << CLK_UART2_SRC_DIV_SHIFT);
+		rk_clrsetreg(&cru->clksel_con[32],
+			     CLK_UART2_SEL_MASK,
+			     uart_src << CLK_UART2_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+	if (m && n) {
+		val = m << CLK_UART_FRAC_NUMERATOR_SHIFT | n;
+		writel(val, &cru->clksel_con[reg]);
+	}
+
+	return rv1103b_uart_get_rate(priv, clk_id);
+}
+
+static ulong rv1103b_decom_get_clk(struct rv1103b_clk_priv *priv)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel, con, prate;
+
+	con = readl(&cru->clksel_con[35]);
+	sel = (con & DCLK_DECOM_SEL_MASK) >>
+	      DCLK_DECOM_SEL_SHIFT;
+	if (sel == DCLK_DECOM_SEL_480M)
+		prate = 480 * MHz;
+	else if (sel == DCLK_DECOM_SEL_400M)
+		prate = 400 * MHz;
+	else
+		prate = 300 * MHz;
+	return prate;
+}
+
+static ulong rv1103b_decom_set_clk(struct rv1103b_clk_priv *priv, ulong rate)
+{
+	struct rv1103b_cru *cru = priv->cru;
+	u32 sel;
+
+	if (rate >= 480 * MHz)
+		sel = DCLK_DECOM_SEL_480M;
+	else if (rate >= 396 * MHz)
+		sel = DCLK_DECOM_SEL_400M;
+	else
+		sel = DCLK_DECOM_SEL_300M;
+	rk_clrsetreg(&cru->clksel_con[35], DCLK_DECOM_SEL_MASK,
+		     (sel << DCLK_DECOM_SEL_SHIFT));
+
+	return rv1103b_decom_get_clk(priv);
+}
+
+static ulong rv1103b_clk_get_rate(struct clk *clk)
+{
+	struct rv1103b_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong rate = 0;
+
+	if (!priv->gpll_hz) {
+		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
+		return -ENOENT;
+	}
+
+	switch (clk->id) {
+	case PLL_GPLL:
+		rate = rockchip_pll_get_rate(&rv1103b_pll_clks[GPLL], priv->cru,
+					     GPLL);
+		break;
+	case ACLK_PERI_SRC:
+	case LSCLK_PERI_SRC:
+	case PCLK_PERI_ROOT:
+	case PCLK_TOP_ROOT:
+	case LSCLK_PMU_ROOT:
+	case PCLK_PMU:
+		rate = rv1103b_peri_get_clk(priv, clk->id);
+		break;
+	case ACLK_CRYPTO:
+	case HCLK_CRYPTO:
+	case HCLK_RK_RNG_NS:
+	case HCLK_RK_RNG_S:
+	case CLK_CORE_CRYPTO:
+	case CLK_PKA_CRYPTO:
+		rate = rv1103b_crypto_get_clk(priv, clk->id);
+		break;
+	case CCLK_SDMMC1:
+	case HCLK_SDMMC1:
+	case CCLK_SDMMC0:
+	case HCLK_SDMMC0:
+	case CCLK_EMMC:
+	case HCLK_EMMC:
+	case SCLK_SFC_2X:
+	case HCLK_SFC:
+		rate = rv1103b_mmc_get_clk(priv, clk->id);
+		break;
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C_PERI:
+	case CLK_I2C0:
+	case CLK_I2C_PMU:
+		rate = rv1103b_i2c_get_clk(priv, clk->id);
+		break;
+	case CLK_SPI0:
+		rate = rv1103b_spi_get_clk(priv, clk->id);
+		break;
+	case CLK_PWM0:
+	case CLK_PWM0_SRC:
+	case CLK_PWM1:
+	case CLK_PWM2:
+		rate = rv1103b_pwm_get_clk(priv, clk->id);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC_TSEN:
+	case CLK_TSADC:
+		rate = rv1103b_adc_get_clk(priv, clk->id);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+		rate = rv1103b_uart_get_rate(priv, clk->id);
+		break;
+	case DCLK_DECOM_SRC:
+	case DCLK_DECOM:
+		rate = rv1103b_decom_get_clk(priv);
+		break;
+	case TCLK_WDT_LPMCU:
+	case TCLK_WDT_HPMCU:
+	case TCLK_WDT_NS:
+	case TCLK_WDT_S:
+		rate = OSC_HZ;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+};
+
+static ulong rv1103b_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct rv1103b_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong ret = 0;
+
+	if (!priv->gpll_hz) {
+		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
+		return -ENOENT;
+	}
+
+	switch (clk->id) {
+	case PLL_GPLL:
+		ret = rockchip_pll_set_rate(&rv1103b_pll_clks[GPLL], priv->cru,
+					    GPLL, rate);
+		break;
+	case ACLK_PERI_SRC:
+	case LSCLK_PERI_SRC:
+	case PCLK_PERI_ROOT:
+	case PCLK_TOP_ROOT:
+	case LSCLK_PMU_ROOT:
+	case PCLK_PMU:
+		ret = rv1103b_peri_set_clk(priv, clk->id, rate);
+		break;
+	case ACLK_CRYPTO:
+	case HCLK_CRYPTO:
+	case HCLK_RK_RNG_NS:
+	case HCLK_RK_RNG_S:
+	case CLK_CORE_CRYPTO:
+	case CLK_PKA_CRYPTO:
+		ret = rv1103b_crypto_set_clk(priv, clk->id, rate);
+		break;
+	case CCLK_SDMMC1:
+	case HCLK_SDMMC1:
+	case CCLK_SDMMC0:
+	case HCLK_SDMMC0:
+	case CCLK_EMMC:
+	case HCLK_EMMC:
+	case SCLK_SFC_2X:
+	case HCLK_SFC:
+		ret = rv1103b_mmc_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C_PERI:
+	case CLK_I2C0:
+	case CLK_I2C_PMU:
+		ret = rv1103b_i2c_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SPI0:
+		ret = rv1103b_spi_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_PWM0:
+	case CLK_PWM0_SRC:
+	case CLK_PWM1:
+	case CLK_PWM2:
+		ret = rv1103b_pwm_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC_TSEN:
+	case CLK_TSADC:
+		ret = rv1103b_adc_set_clk(priv, clk->id, rate);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+		ret = rv1103b_uart_set_rate(priv, clk->id, rate);
+		break;
+	case DCLK_DECOM_SRC:
+	case DCLK_DECOM:
+		rate = rv1103b_decom_set_clk(priv, rate);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return ret;
+};
+
+static int rv1103b_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	switch (clk->id) {
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static struct clk_ops rv1103b_clk_ops = {
+	.get_rate = rv1103b_clk_get_rate,
+	.set_rate = rv1103b_clk_set_rate,
+#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+	.set_parent = rv1103b_clk_set_parent,
+#endif
+};
+
+static void rv1103b_clk_init(struct rv1103b_clk_priv *priv)
+{
+	int ret;
+	u32 div;
+
+	priv->sync_kernel = false;
+	priv->gpll_hz = rockchip_pll_get_rate(&rv1103b_pll_clks[GPLL],
+					      priv->cru, GPLL);
+	if (priv->gpll_hz != GPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rv1103b_pll_clks[GPLL], priv->cru,
+					    GPLL, GPLL_HZ);
+		if (!ret)
+			priv->gpll_hz = GPLL_HZ;
+	}
+
+	if (!priv->armclk_enter_hz) {
+		div = (readl(&priv->cru->clksel_con[37]) &
+		       CLK_CORE_GPLL_DIV_MASK) >>
+		      CLK_CORE_GPLL_DIV_SHIFT;
+		priv->armclk_enter_hz = DIV_TO_RATE(priv->gpll_hz, div);
+		priv->armclk_init_hz = priv->armclk_enter_hz;
+	}
+}
+
+static int rv1103b_clk_probe(struct udevice *dev)
+{
+	struct rv1103b_clk_priv *priv = dev_get_priv(dev);
+	int ret;
+
+#ifdef CONFIG_SPL_BUILD
+	/* fix lsclk_prei div */
+	writel(BITS_WITH_WMASK(1, 0x1U, 9), RV1103B_CRU_BASE + RV1103B_CLKSEL_CON(31));
+	/* fix cpu div */
+	writel(BITS_WITH_WMASK(1, 0x7U, 13), RV1103B_CRU_BASE + RV1103B_CLKSEL_CON(37));
+	/* fix gpll postdiv1 */
+	writel(BITS_WITH_WMASK(1, 0x7U, 12), RV1103B_CRU_BASE + RV1103B_PLL_CON(24));
+#endif
+
+	rv1103b_clk_init(priv);
+
+	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
+	ret = clk_set_defaults(dev, 1);
+	if (ret)
+		debug("%s clk_set_defaults failed %d\n", __func__, ret);
+	else
+		priv->sync_kernel = true;
+	return 0;
+}
+
+static int rv1103_clk_of_to_plat(struct udevice *dev)
+{
+	struct rv1103_clk_priv *priv = dev_get_priv(dev);
+
+	priv->cru = dev_read_addr_ptr(dev);
+
+	return 0;
+}
+
+static int rv1103b_clk_bind(struct udevice *dev)
+{
+	struct udevice *sys_child;
+	struct sysreset_reg *priv;
+	int ret;
+
+	/* The sysreset driver does not have a device node, so bind it here */
+	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset", &sys_child);
+	if (ret) {
+		debug("Warning: No sysreset driver: ret=%d\n", ret);
+	} else {
+		priv = malloc(sizeof(struct sysreset_reg));
+		priv->glb_srst_fst_value = offsetof(struct rv1103b_cru, glb_srst_fst);
+		priv->glb_srst_snd_value = offsetof(struct rv1103b_cru, glb_srst_snd);
+		dev_set_priv(sys_child, priv);
+	}
+
+#if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
+	ret = offsetof(struct rv1103b_cru, peri_softrst_con[0]);
+	ret = rockchip_reset_bind(dev, ret, 12); /* number of reset registers */
+	if (ret)
+		debug("Warning: software reset driver bind failed\n");
+#endif
+
+	return 0;
+}
+
+static const struct udevice_id rv1103b_clk_ids[] = {
+	{ .compatible = "rockchip,rv1103-cru" },
+	{ }
+};
+
+U_BOOT_DRIVER(clk_rv1103) = {
+	.name		= "clk_rv1103",
+	.id		= UCLASS_CLK,
+	.of_match	= rv1103b_clk_ids,
+	.priv_auto	= sizeof(struct rv1103b_clk_priv),
+	.of_to_plat	= rv1103_clk_of_to_plat,
+	.ops		= &rv1103b_clk_ops,
+	.bind		= rv1103b_clk_bind,
+	.probe		= rv1103b_clk_probe,
+};
-- 
2.34.1

