Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B107C54E49
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B3287EA9;
	Fri,  8 Mar 2024 03:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nklor0La";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1949787DCD; Fri,  8 Mar 2024 03:19:42 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2342A87E40
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5a142375987so608815eaf.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709864343; x=1710469143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY83/aewu1NrqrNFUzUGztsd2S2F+ViVwKnJhWqcS3Q=;
 b=Nklor0LaCibWxuyHxoS1gLim7/sBHYpF4UzbHkIfIfzWDTRhV/3osEqNzs4x+9qtD/
 8QtU5rtEbv5d/ZXGcCcY9tgfINCqYu1IbOg4973ReK7P14Tuei3XG2UHFLX4hvdj0+A0
 rU3LFr4unmPZzoApIDuo/4X+dOTO5xeTmdiBdVHWeZzVrFgr13kxqUWF+14Bx26vIUqf
 I9CkZvC6UkC22Jt6K8YbUxjCVa9TyyOkDT6XGk8CTNMMMZ8a/hg2hcU4nkr/4hTpotH8
 rnr/dlEFmOA8eQx+PhvQegFOP0Of8YVMZ9OQ0iOM4p82lM/P8pLzYaljTyf1Qx8yPWjR
 QEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709864343; x=1710469143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mY83/aewu1NrqrNFUzUGztsd2S2F+ViVwKnJhWqcS3Q=;
 b=EKQf/hx4/gXR62Q5JMThyGZUhWad7GdvkIM9sf/dxm4qQJs8PxRSeapo80yHAiYNVY
 f+fu3wJO2hj6vmhMmPEyIQrAT3lRNO4igKXtjSijjX0L7Qqa/BkJ8bXOtUrZDzFD7+8b
 gINgacXMsuhUKOwq44TrGtuwgEphmjir+2IRFwXPufevmoNwiflzdL1Odu9q3ENipNz3
 2FYUDn67inmKiLRRmbwJ5HSb27ANsStZnsanHkhcR5kYWXFqla5hra6dY7KSxXQfnfMr
 WU8F/rnwKjq/cq6Bk+qVW3D1MF5+OHnabVOCYovhbJHY+s28P54y6/IPRh5fEBGYPVVD
 UkEA==
X-Gm-Message-State: AOJu0YyHjig3wadljt3Hh2vhqbtLBGmw/Xv90r4NBLcnTrB0PYW7c1yy
 irnTTHQ45ahzIZS0pAkXvuBmHDpTPahZlfjjy9QTosTWvZ8imTptDrjv7gSwzCk=
X-Google-Smtp-Source: AGHT+IEawM/6BW5XkrkAEVf0I45oUPLcPI/hQBiZN7IzJxRA0ik8ofkJTDHw42Q6PL0Axo/dQN8o+A==
X-Received: by 2002:a4a:3452:0:b0:5a1:c993:275d with SMTP id
 n18-20020a4a3452000000b005a1c993275dmr52811oof.1.1709864342774; 
 Thu, 07 Mar 2024 18:19:02 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 by18-20020a056820201200b0059a096ee494sm2145380oob.47.2024.03.07.18.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:19:02 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 4/4] clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850
Date: Thu,  7 Mar 2024 20:18:58 -0600
Message-Id: <20240308021858.28249-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308021858.28249-1-semen.protsenko@linaro.org>
References: <20240308021858.28249-1-semen.protsenko@linaro.org>
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

CMU_CORE generates clocks needed for eMMC enablement, and CMU_HSI
provides clocks for SD card and USB. Most of the code is copied from the
Linux kernel counterpart driver.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/clk-exynos850.c | 252 +++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/drivers/clk/exynos/clk-exynos850.c b/drivers/clk/exynos/clk-exynos850.c
index f11c1ff29bdd..0c09ba02de4a 100644
--- a/drivers/clk/exynos/clk-exynos850.c
+++ b/drivers/clk/exynos/clk-exynos850.c
@@ -13,6 +13,8 @@
 enum exynos850_cmu_id {
 	CMU_TOP,
 	CMU_PERI,
+	CMU_CORE,
+	CMU_HSI,
 };
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
@@ -24,9 +26,23 @@ enum exynos850_cmu_id {
 #define PLL_CON3_PLL_SHARED0			0x014c
 #define PLL_CON0_PLL_SHARED1			0x0180
 #define PLL_CON3_PLL_SHARED1			0x018c
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS		0x1014
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD	0x101c
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_SSS		0x1020
+#define CLK_CON_MUX_MUX_CLKCMU_HSI_BUS		0x103c
+#define CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD	0x1040
+#define CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD	0x1044
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1070
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_IP		0x1074
 #define CLK_CON_MUX_MUX_CLKCMU_PERI_UART	0x1078
+#define CLK_CON_DIV_CLKCMU_CORE_BUS		0x1820
+#define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1824
+#define CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD	0x1828
+#define CLK_CON_DIV_CLKCMU_CORE_SSS		0x182c
+#define CLK_CON_DIV_CLKCMU_HSI_BUS		0x1848
+#define CLK_CON_DIV_CLKCMU_HSI_MMC_CARD		0x184c
+#define CLK_CON_DIV_CLKCMU_HSI_USB20DRD		0x1850
 #define CLK_CON_DIV_CLKCMU_PERI_BUS		0x187c
 #define CLK_CON_DIV_CLKCMU_PERI_IP		0x1880
 #define CLK_CON_DIV_CLKCMU_PERI_UART		0x1884
@@ -36,6 +52,13 @@ enum exynos850_cmu_id {
 #define CLK_CON_DIV_PLL_SHARED1_DIV2		0x1898
 #define CLK_CON_DIV_PLL_SHARED1_DIV3		0x189c
 #define CLK_CON_DIV_PLL_SHARED1_DIV4		0x18a0
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS	0x201c
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD	0x2024
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_SSS	0x2028
+#define CLK_CON_GAT_GATE_CLKCMU_HSI_BUS		0x2044
+#define CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD	0x2048
+#define CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD	0x204c
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x2080
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_IP		0x2084
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_UART	0x2088
@@ -44,6 +67,25 @@ enum exynos850_cmu_id {
 PNAME(mout_shared0_pll_p)	= { "clock-oscclk", "fout_shared0_pll" };
 PNAME(mout_shared1_pll_p)	= { "clock-oscclk", "fout_shared1_pll" };
 PNAME(mout_mmc_pll_p)		= { "clock-oscclk", "fout_mmc_pll" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_CORE */
+PNAME(mout_core_bus_p)		= { "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "dout_shared0_div4" };
+PNAME(mout_core_cci_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared1_div3" };
+PNAME(mout_core_mmc_embd_p)	= { "clock-oscclk", "dout_shared0_div2",
+				    "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "mout_mmc_pll",
+				    "clock-oscclk", "clock-oscclk" };
+PNAME(mout_core_sss_p)		= { "dout_shared0_div3", "dout_shared1_div3",
+				    "dout_shared0_div4", "dout_shared1_div4" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_HSI */
+PNAME(mout_hsi_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2" };
+PNAME(mout_hsi_mmc_card_p)	= { "clock-oscclk", "dout_shared0_div2",
+				    "dout_shared1_div2", "dout_shared0_div3",
+				    "dout_shared1_div3", "mout_mmc_pll",
+				    "clock-oscclk", "clock-oscclk" };
+PNAME(mout_hsi_usb20drd_p)	= { "clock-oscclk", "dout_shared0_div4",
+				    "dout_shared1_div4", "clock-oscclk" };
 /* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
 PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
 PNAME(mout_peri_uart_p)		= { "clock-oscclk", "dout_shared0_div4",
@@ -86,6 +128,70 @@ static const struct samsung_div_clock top_pure_div_clks[] = {
 	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
 };
 
+/* CORE */
+
+static const struct samsung_mux_clock top_core_mux_clks[] = {
+	MUX(CLK_MOUT_CORE_BUS, "mout_core_bus", mout_core_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_BUS, 0, 2),
+	MUX(CLK_MOUT_CORE_CCI, "mout_core_cci", mout_core_cci_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_CCI, 0, 2),
+	MUX(CLK_MOUT_CORE_MMC_EMBD, "mout_core_mmc_embd", mout_core_mmc_embd_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD, 0, 3),
+	MUX(CLK_MOUT_CORE_SSS, "mout_core_sss", mout_core_sss_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_SSS, 0, 2),
+};
+
+static const struct samsung_gate_clock top_core_gate_clks[] = {
+	GATE(CLK_GOUT_CORE_BUS, "gout_core_bus", "mout_core_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_CORE_CCI, "gout_core_cci", "mout_core_cci",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_CCI, 21, 0, 0),
+	GATE(CLK_GOUT_CORE_MMC_EMBD, "gout_core_mmc_embd", "mout_core_mmc_embd",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD, 21, 0, 0),
+	GATE(CLK_GOUT_CORE_SSS, "gout_core_sss", "mout_core_sss",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_SSS, 21, 0, 0),
+};
+
+static const struct samsung_div_clock top_core_div_clks[] = {
+	DIV(CLK_DOUT_CORE_BUS, "dout_core_bus", "gout_core_bus",
+	    CLK_CON_DIV_CLKCMU_CORE_BUS, 0, 4),
+	DIV(CLK_DOUT_CORE_CCI, "dout_core_cci", "gout_core_cci",
+	    CLK_CON_DIV_CLKCMU_CORE_CCI, 0, 4),
+	DIV(CLK_DOUT_CORE_MMC_EMBD, "dout_core_mmc_embd", "gout_core_mmc_embd",
+	    CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD, 0, 9),
+	DIV(CLK_DOUT_CORE_SSS, "dout_core_sss", "gout_core_sss",
+	    CLK_CON_DIV_CLKCMU_CORE_SSS, 0, 4),
+};
+
+/* HSI */
+
+static const struct samsung_mux_clock top_hsi_mux_clks[] = {
+	MUX(CLK_MOUT_HSI_BUS, "mout_hsi_bus", mout_hsi_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_HSI_BUS, 0, 1),
+	MUX(CLK_MOUT_HSI_MMC_CARD, "mout_hsi_mmc_card", mout_hsi_mmc_card_p,
+	    CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD, 0, 3),
+	MUX(CLK_MOUT_HSI_USB20DRD, "mout_hsi_usb20drd", mout_hsi_usb20drd_p,
+	    CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD, 0, 2),
+};
+
+static const struct samsung_gate_clock top_hsi_gate_clks[] = {
+	GATE(CLK_GOUT_HSI_BUS, "gout_hsi_bus", "mout_hsi_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_HSI_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_HSI_MMC_CARD, "gout_hsi_mmc_card", "mout_hsi_mmc_card",
+	     CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD, 21, 0, 0),
+	GATE(CLK_GOUT_HSI_USB20DRD, "gout_hsi_usb20drd", "mout_hsi_usb20drd",
+	     CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD, 21, 0, 0),
+};
+
+static const struct samsung_div_clock top_hsi_div_clks[] = {
+	DIV(CLK_DOUT_HSI_BUS, "dout_hsi_bus", "gout_hsi_bus",
+	    CLK_CON_DIV_CLKCMU_HSI_BUS, 0, 4),
+	DIV(CLK_DOUT_HSI_MMC_CARD, "dout_hsi_mmc_card", "gout_hsi_mmc_card",
+	    CLK_CON_DIV_CLKCMU_HSI_MMC_CARD, 0, 9),
+	DIV(CLK_DOUT_HSI_USB20DRD, "dout_hsi_usb20drd", "gout_hsi_usb20drd",
+	    CLK_CON_DIV_CLKCMU_HSI_USB20DRD, 0, 4),
+};
+
 /* PERI */
 
 static const struct samsung_mux_clock top_peri_mux_clks[] = {
@@ -121,6 +227,16 @@ static const struct samsung_clk_group top_cmu_clks[] = {
 	{ S_CLK_MUX, top_pure_mux_clks, ARRAY_SIZE(top_pure_mux_clks) },
 	{ S_CLK_DIV, top_pure_div_clks, ARRAY_SIZE(top_pure_div_clks) },
 
+	/* CMU_TOP clocks for CMU_CORE */
+	{ S_CLK_MUX, top_core_mux_clks, ARRAY_SIZE(top_core_mux_clks) },
+	{ S_CLK_GATE, top_core_gate_clks, ARRAY_SIZE(top_core_gate_clks) },
+	{ S_CLK_DIV, top_core_div_clks, ARRAY_SIZE(top_core_div_clks) },
+
+	/* CMU_TOP clocks for CMU_HSI */
+	{ S_CLK_MUX, top_hsi_mux_clks, ARRAY_SIZE(top_hsi_mux_clks) },
+	{ S_CLK_GATE, top_hsi_gate_clks, ARRAY_SIZE(top_hsi_gate_clks) },
+	{ S_CLK_DIV, top_hsi_div_clks, ARRAY_SIZE(top_hsi_div_clks) },
+
 	/* CMU_TOP clocks for CMU_PERI */
 	{ S_CLK_MUX, top_peri_mux_clks, ARRAY_SIZE(top_peri_mux_clks) },
 	{ S_CLK_GATE, top_peri_gate_clks, ARRAY_SIZE(top_peri_gate_clks) },
@@ -201,3 +317,139 @@ U_BOOT_DRIVER(exynos850_cmu_peri) = {
 	.probe		= exynos850_cmu_peri_probe,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
+
+/* ---- CMU_CORE ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_CORE (0x12000000) */
+#define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER	0x0600
+#define PLL_CON0_MUX_CLKCMU_CORE_MMC_EMBD_USER	0x0620
+#define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
+#define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK	0x20e8
+#define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN	0x20ec
+
+/* List of parent clocks for Muxes in CMU_CORE */
+PNAME(mout_core_bus_user_p)		= { "clock-oscclk", "dout_core_bus" };
+PNAME(mout_core_mmc_embd_user_p)	= { "clock-oscclk",
+					    "dout_core_mmc_embd" };
+
+static const struct samsung_mux_clock core_mux_clks[] = {
+	MUX(CLK_MOUT_CORE_BUS_USER, "mout_core_bus_user", mout_core_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_CORE_BUS_USER, 4, 1),
+	MUX_F(CLK_MOUT_CORE_MMC_EMBD_USER, "mout_core_mmc_embd_user",
+	      mout_core_mmc_embd_user_p, PLL_CON0_MUX_CLKCMU_CORE_MMC_EMBD_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_div_clock core_div_clks[] = {
+	DIV(CLK_DOUT_CORE_BUSP, "dout_core_busp", "mout_core_bus_user",
+	    CLK_CON_DIV_DIV_CLK_CORE_BUSP, 0, 2),
+};
+
+static const struct samsung_gate_clock core_gate_clks[] = {
+	GATE(CLK_GOUT_MMC_EMBD_ACLK, "gout_mmc_embd_aclk", "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_EMBD_SDCLKIN, "gout_mmc_embd_sdclkin",
+	     "mout_core_mmc_embd_user", CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN,
+	     21, CLK_SET_RATE_PARENT, 0),
+};
+
+static const struct samsung_clk_group core_cmu_clks[] = {
+	{ S_CLK_MUX, core_mux_clks, ARRAY_SIZE(core_mux_clks) },
+	{ S_CLK_DIV, core_div_clks, ARRAY_SIZE(core_div_clks) },
+	{ S_CLK_GATE, core_gate_clks, ARRAY_SIZE(core_gate_clks) },
+};
+
+static int exynos850_cmu_core_probe(struct udevice *dev)
+{
+	return samsung_register_cmu(dev, CMU_CORE, core_cmu_clks,
+				    exynos850_cmu_top);
+}
+
+static const struct udevice_id exynos850_cmu_core_ids[] = {
+	{ .compatible = "samsung,exynos850-cmu-core" },
+	{ }
+};
+
+SAMSUNG_CLK_OPS(exynos850_cmu_core, CMU_CORE);
+
+U_BOOT_DRIVER(exynos850_cmu_core) = {
+	.name		= "exynos850-cmu-core",
+	.id		= UCLASS_CLK,
+	.of_match	= exynos850_cmu_core_ids,
+	.ops		= &exynos850_cmu_core_clk_ops,
+	.probe		= exynos850_cmu_core_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+/* ---- CMU_HSI ------------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_HSI (0x13400000) */
+#define PLL_CON0_MUX_CLKCMU_HSI_BUS_USER			0x0600
+#define PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER			0x0610
+#define PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER			0x0620
+#define CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50		0x200c
+#define CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26		0x2010
+#define CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK			0x2024
+#define CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN			0x2028
+#define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20	0x203c
+#define CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY		0x2040
+
+/* List of parent clocks for Muxes in CMU_HSI */
+PNAME(mout_hsi_bus_user_p)	= { "clock-oscclk", "dout_hsi_bus" };
+PNAME(mout_hsi_mmc_card_user_p)	= { "clock-oscclk", "dout_hsi_mmc_card" };
+PNAME(mout_hsi_usb20drd_user_p)	= { "clock-oscclk", "dout_hsi_usb20drd" };
+
+static const struct samsung_mux_clock hsi_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_HSI_BUS_USER, "mout_hsi_bus_user", mout_hsi_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI_BUS_USER, 4, 1),
+	MUX_F(CLK_MOUT_HSI_MMC_CARD_USER, "mout_hsi_mmc_card_user",
+	      mout_hsi_mmc_card_user_p, PLL_CON0_MUX_CLKCMU_HSI_MMC_CARD_USER,
+	      4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX(CLK_MOUT_HSI_USB20DRD_USER, "mout_hsi_usb20drd_user",
+	    mout_hsi_usb20drd_user_p, PLL_CON0_MUX_CLKCMU_HSI_USB20DRD_USER,
+	    4, 1),
+};
+
+static const struct samsung_gate_clock hsi_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_USB_REF_CLK, "gout_usb_ref", "mout_hsi_usb20drd_user",
+	     CLK_CON_GAT_HSI_USB20DRD_TOP_I_REF_CLK_50, 21, 0, 0),
+	GATE(CLK_GOUT_USB_PHY_REF_CLK, "gout_usb_phy_ref", "clock-oscclk",
+	     CLK_CON_GAT_HSI_USB20DRD_TOP_I_PHY_REFCLK_26, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_CARD_ACLK, "gout_mmc_card_aclk", "mout_hsi_bus_user",
+	     CLK_CON_GAT_GOUT_HSI_MMC_CARD_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_MMC_CARD_SDCLKIN, "gout_mmc_card_sdclkin",
+	     "mout_hsi_mmc_card_user",
+	     CLK_CON_GAT_GOUT_HSI_MMC_CARD_SDCLKIN, 21, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_GOUT_USB_PHY_ACLK, "gout_usb_phy_aclk", "mout_hsi_bus_user",
+	     CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_ACLK_PHYCTRL_20, 21, 0, 0),
+	GATE(CLK_GOUT_USB_BUS_EARLY_CLK, "gout_usb_bus_early",
+	     "mout_hsi_bus_user",
+	     CLK_CON_GAT_GOUT_HSI_USB20DRD_TOP_BUS_CLK_EARLY, 21, 0, 0),
+};
+
+static const struct samsung_clk_group hsi_cmu_clks[] = {
+	{ S_CLK_MUX, hsi_mux_clks, ARRAY_SIZE(hsi_mux_clks) },
+	{ S_CLK_GATE, hsi_gate_clks, ARRAY_SIZE(hsi_gate_clks) },
+};
+
+static int exynos850_cmu_hsi_probe(struct udevice *dev)
+{
+	return samsung_register_cmu(dev, CMU_HSI, hsi_cmu_clks,
+				    exynos850_cmu_hsi);
+}
+
+static const struct udevice_id exynos850_cmu_hsi_ids[] = {
+	{ .compatible = "samsung,exynos850-cmu-hsi" },
+	{ }
+};
+
+SAMSUNG_CLK_OPS(exynos850_cmu_hsi, CMU_HSI);
+
+U_BOOT_DRIVER(exynos850_cmu_hsi) = {
+	.name		= "exynos850-cmu-hsi",
+	.id		= UCLASS_CLK,
+	.of_match	= exynos850_cmu_hsi_ids,
+	.ops		= &exynos850_cmu_hsi_clk_ops,
+	.probe		= exynos850_cmu_hsi_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.39.2

