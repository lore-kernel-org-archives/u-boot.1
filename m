Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14529C54798
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9842287DF1;
	Fri,  8 Mar 2024 03:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C/kAMZLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E650987E75; Fri,  8 Mar 2024 03:19:10 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDABD87DB3
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c1f250e015so1230485b6e.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709864340; x=1710469140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQDiGj9buZARhmwBfIKiX7Xk1nC6sA+Vol4ePftjwqE=;
 b=C/kAMZLwpLNNGNzkwzkg14pIAnrbMFJNlfr5Sd74Dwp8mlW6lz1lCi+Ev98NF4cmAq
 229FLuFJAKweKz6t2t8nNPWj3GrpTS53gahqhKnzAHvxBSAt1xyH8OzvzaacYrMxDPvI
 ECkTHsVsq3vuwVqtqGLQ9vOYHsymd0mXu1VwW6ViMhTWRBR55NorY1skruugijnC/UgE
 CHCGeaNmdf0FQppaaJqO7bOSs9neL1g4FhFeLJDjX6PaUE7ziP/jIGqpJuebZQGBHT5x
 nBFChRxh4QsbKmfVzZ+7oOM1FleTtjKnotkaC2nNwbFqwB7teel0dhtj0sOGx/ldgYg3
 6M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709864340; x=1710469140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQDiGj9buZARhmwBfIKiX7Xk1nC6sA+Vol4ePftjwqE=;
 b=PDk8hFEV5A3mZ81vBvBbwnMF0zILJtb0m+mJDJf0evRjnlEdwV7015elFpG5HR5sjQ
 DDN3Ui3rma3EJbrAlVNXtqHerlcBnZX01wIQO6wXLyPuELwjfq+8n1IhJI7+Ane+NXAb
 dQusjttlkbzJ7pmGbqKSbZytEs/ScpaJpXy+Av/iZHt2iiRPfOphncWdluYjPTEe2a00
 zrJCeDHLPlZd4tsaffHun2YcDRivR0RQut8BnTdHEylOxwowpB/l5lN2r2WU2eWJnfV5
 LCsZSlrPB0NgPSgi/StWr49sjzSbsuMqsw9ntn8e1Y6nap5lyhhyUVfpLtZ/KDp5UY70
 WBCg==
X-Gm-Message-State: AOJu0Yyrbn0yuR9U3/1PKXZg3AQk8ZW4W/fN+2hbD5ECoJL/2/xUhPfO
 JAzA626uHNHEqggCnQlCLtTAarBL4Pcdeq/733rC68wjistw/uypGkodBBNrREM=
X-Google-Smtp-Source: AGHT+IETk0An+aqSgOESWRTZErKSkYKuE82IyUWaRohcWrk6X3r9KDseRlz34tXF9XRa39NG+RM40g==
X-Received: by 2002:a05:6808:bd1:b0:3c2:d2e:dcbd with SMTP id
 o17-20020a0568080bd100b003c20d2edcbdmr1691800oik.18.1709864340287; 
 Thu, 07 Mar 2024 18:19:00 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 cf7-20020a05680833c700b003c20c2562ddsm1100315oib.38.2024.03.07.18.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:18:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/4] clk: exynos: Re-arrange clocks in Exynos850 CMU_TOP
Date: Thu,  7 Mar 2024 20:18:55 -0600
Message-Id: <20240308021858.28249-2-semen.protsenko@linaro.org>
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

Group CMU_TOP clocks to make it easier to add the support for more CMUs.
No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/clk-exynos850.c | 56 ++++++++++++++++--------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/exynos/clk-exynos850.c b/drivers/clk/exynos/clk-exynos850.c
index cf94a3e1b646..de4170cdc2f3 100644
--- a/drivers/clk/exynos/clk-exynos850.c
+++ b/drivers/clk/exynos/clk-exynos850.c
@@ -35,16 +35,7 @@
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_IP		0x2084
 #define CLK_CON_GAT_GATE_CLKCMU_PERI_UART	0x2088
 
-static const struct samsung_pll_clock top_pure_pll_clks[] = {
-	PLL(pll_0822x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "clock-oscclk",
-	    PLL_CON3_PLL_SHARED0),
-	PLL(pll_0822x, CLK_FOUT_SHARED1_PLL, "fout_shared1_pll", "clock-oscclk",
-	    PLL_CON3_PLL_SHARED1),
-	PLL(pll_0831x, CLK_FOUT_MMC_PLL, "fout_mmc_pll", "clock-oscclk",
-	    PLL_CON3_PLL_MMC),
-};
-
-/* List of parent clocks for Muxes in CMU_TOP */
+/* List of parent clocks for Muxes in CMU_TOP: for PURECLKCOMP */
 PNAME(mout_shared0_pll_p)	= { "clock-oscclk", "fout_shared0_pll" };
 PNAME(mout_shared1_pll_p)	= { "clock-oscclk", "fout_shared1_pll" };
 PNAME(mout_mmc_pll_p)		= { "clock-oscclk", "fout_mmc_pll" };
@@ -55,6 +46,17 @@ PNAME(mout_peri_uart_p)		= { "clock-oscclk", "dout_shared0_div4",
 PNAME(mout_peri_ip_p)		= { "clock-oscclk", "dout_shared0_div4",
 				    "dout_shared1_div4", "clock-oscclk" };
 
+/* PURECLKCOMP */
+
+static const struct samsung_pll_clock top_pure_pll_clks[] = {
+	PLL(pll_0822x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "clock-oscclk",
+	    PLL_CON3_PLL_SHARED0),
+	PLL(pll_0822x, CLK_FOUT_SHARED1_PLL, "fout_shared1_pll", "clock-oscclk",
+	    PLL_CON3_PLL_SHARED1),
+	PLL(pll_0831x, CLK_FOUT_MMC_PLL, "fout_mmc_pll", "clock-oscclk",
+	    PLL_CON3_PLL_MMC),
+};
+
 static const struct samsung_mux_clock top_pure_mux_clks[] = {
 	MUX(CLK_MOUT_SHARED0_PLL, "mout_shared0_pll", mout_shared0_pll_p,
 	    PLL_CON0_PLL_SHARED0, 4, 1),
@@ -64,15 +66,6 @@ static const struct samsung_mux_clock top_pure_mux_clks[] = {
 	    PLL_CON0_PLL_MMC, 4, 1),
 };
 
-static const struct samsung_mux_clock top_peri_mux_clks[] = {
-	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
-	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
-	MUX(CLK_MOUT_PERI_UART, "mout_peri_uart", mout_peri_uart_p,
-	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART, 0, 2),
-	MUX(CLK_MOUT_PERI_IP, "mout_peri_ip", mout_peri_ip_p,
-	    CLK_CON_MUX_MUX_CLKCMU_PERI_IP, 0, 2),
-};
-
 static const struct samsung_div_clock top_pure_div_clks[] = {
 	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "mout_shared0_pll",
 	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
@@ -88,13 +81,15 @@ static const struct samsung_div_clock top_pure_div_clks[] = {
 	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
 };
 
-static const struct samsung_div_clock top_peri_div_clks[] = {
-	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
-	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
-	DIV(CLK_DOUT_PERI_UART, "dout_peri_uart", "gout_peri_uart",
-	    CLK_CON_DIV_CLKCMU_PERI_UART, 0, 4),
-	DIV(CLK_DOUT_PERI_IP, "dout_peri_ip", "gout_peri_ip",
-	    CLK_CON_DIV_CLKCMU_PERI_IP, 0, 4),
+/* PERI */
+
+static const struct samsung_mux_clock top_peri_mux_clks[] = {
+	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
+	MUX(CLK_MOUT_PERI_UART, "mout_peri_uart", mout_peri_uart_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART, 0, 2),
+	MUX(CLK_MOUT_PERI_IP, "mout_peri_ip", mout_peri_ip_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_IP, 0, 2),
 };
 
 static const struct samsung_gate_clock top_peri_gate_clks[] = {
@@ -106,6 +101,15 @@ static const struct samsung_gate_clock top_peri_gate_clks[] = {
 	     CLK_CON_GAT_GATE_CLKCMU_PERI_IP, 21, 0, 0),
 };
 
+static const struct samsung_div_clock top_peri_div_clks[] = {
+	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
+	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
+	DIV(CLK_DOUT_PERI_UART, "dout_peri_uart", "gout_peri_uart",
+	    CLK_CON_DIV_CLKCMU_PERI_UART, 0, 4),
+	DIV(CLK_DOUT_PERI_IP, "dout_peri_ip", "gout_peri_ip",
+	    CLK_CON_DIV_CLKCMU_PERI_IP, 0, 4),
+};
+
 static const struct samsung_clk_group top_cmu_clks[] = {
 	/* CMU_TOP_PURECLKCOMP */
 	{ S_CLK_PLL, top_pure_pll_clks, ARRAY_SIZE(top_pure_pll_clks) },
-- 
2.39.2

