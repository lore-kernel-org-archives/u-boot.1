Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8135AC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0BC87807;
	Wed, 13 Dec 2023 04:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TpJXqS8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8B187831; Wed, 13 Dec 2023 04:17:03 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138B6877EF
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59082c4aadaso3221582eaf.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437414; x=1703042214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WsrJKB2LReO2HLQEmttdV0f5TMHaNdjFjNb7bFSaxs=;
 b=TpJXqS8KquJ52t355yCACGYhbm1FV9y4EHNDAl4D52BeKmWIuyj4ate0xH7GVfbJCN
 ytipMVx7Vpq4qgMTm/QFPE+07OrOuvGVI7GIue7q3s4b30KJxF4IPg8XtmfvZW3EI1zk
 2+Lwt7T/FPPAJ+KIvCluJP7RZrmPmnL0FYeRp94gmxfgwYeg6c7y30NWVOoAPQAX83Av
 qTKY2cu6O5mg2eRUuBWRU7c5ZKrmWlQKK8EDn54qS8HTolPUA9ogupcsd0F3u9L9zC2f
 6A7TMWQa5UATmFKwt+Fep+HiefdOLGlRdF9nSt6ncAuHkiutsw5Ji54g46ZwUzIfdkJ0
 PCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437414; x=1703042214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WsrJKB2LReO2HLQEmttdV0f5TMHaNdjFjNb7bFSaxs=;
 b=A3C+aqedA0R94Nd2B0NZFbDkcngl3gTYLACzMC+pYCRe7PqAvxDBgLvPjVcF3mAr+2
 /oMzlOdyYC4MBxOpWcbp5TTSMNAqDljkj7bLlACR5vwUXPo6XXeyX/JJRZedRj49aaeT
 /NtnEsz3aDu8tdYF+02OqSk/j8aw01PUUJiMLUpRS4RmZiTSEIw/ddJVE8JbYb2cxVs0
 jsNUGJ5lm+u2WhP4N1H7BhTC48gSR8k8g5ioDaojl8dtupgP4OjUGWNhL8KjOEOAk72a
 NwQuEyXTubRWE0gr/05uH4ZcwzFtEh8X10WZpq+Dk1UromQRPjYBp5T6e0b7jaMVKiYF
 yEgQ==
X-Gm-Message-State: AOJu0YwZH0EzTMqBHms+zViHdtJrKJvyuZ9kbkyA2ZIc5FURDuZJzOXo
 QHDF/PLW/1A/OBWNWPZhUu8hgw==
X-Google-Smtp-Source: AGHT+IGh4AQmw2ADj8UKzH1oUwpJ17iLMBSqk1XishDQK2Y5n3my7qjKxo5zVFPZbJeltLLU6d/CRw==
X-Received: by 2002:a05:6871:5b09:b0:1fb:75a:de75 with SMTP id
 op9-20020a0568715b0900b001fb075ade75mr8647165oac.99.1702437414644; 
 Tue, 12 Dec 2023 19:16:54 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 eg46-20020a05687098ae00b002030e38887dsm592394oab.41.2023.12.12.19.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:54 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 08/13] clk: exynos: Add Exynos850 clock driver
Date: Tue, 12 Dec 2023 21:16:41 -0600
Message-Id: <20231213031646.28828-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Heavily influenced by its Linux kernel counterpart. It's implemented on
top of recently added Samsung CCF clock framework API. For now only UART
leaf clocks are implemented, along with all preceding clocks in CMU_TOP
and CMU_PERI. The UART baud clock is required in the serial driver, to
get its rate for the consequent baud rate calculation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/Kconfig         |   7 ++
 drivers/clk/exynos/Makefile        |   1 +
 drivers/clk/exynos/clk-exynos850.c | 189 +++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 drivers/clk/exynos/clk-exynos850.c

diff --git a/drivers/clk/exynos/Kconfig b/drivers/clk/exynos/Kconfig
index eb0efa97d15c..85ce9d6e2418 100644
--- a/drivers/clk/exynos/Kconfig
+++ b/drivers/clk/exynos/Kconfig
@@ -15,4 +15,11 @@ config CLK_EXYNOS7420
 	  This enables common clock driver support for platforms based
 	  on Samsung Exynos7420 SoC.
 
+config CLK_EXYNOS850
+	bool "Clock driver for Samsung's Exynos850 SoC"
+	select CLK_CCF
+	help
+	  This enables common clock driver support for platforms based
+	  on Samsung Exynos850 SoC.
+
 endmenu
diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
index 04c5b9a39e16..734100e2bff3 100644
--- a/drivers/clk/exynos/Makefile
+++ b/drivers/clk/exynos/Makefile
@@ -9,3 +9,4 @@
 
 obj-$(CONFIG_$(SPL_TPL_)CLK_CCF)	+= clk.o clk-pll.o
 obj-$(CONFIG_CLK_EXYNOS7420)		+= clk-exynos7420.o
+obj-$(CONFIG_CLK_EXYNOS850)		+= clk-exynos850.o
diff --git a/drivers/clk/exynos/clk-exynos850.c b/drivers/clk/exynos/clk-exynos850.c
new file mode 100644
index 000000000000..cf94a3e1b646
--- /dev/null
+++ b/drivers/clk/exynos/clk-exynos850.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Samsung Exynos850 clock driver.
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#include <dm.h>
+#include <asm/io.h>
+#include <dt-bindings/clock/exynos850.h>
+#include "clk.h"
+
+/* ---- CMU_TOP ------------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_TOP (0x120e0000) */
+#define PLL_CON0_PLL_MMC			0x0100
+#define PLL_CON3_PLL_MMC			0x010c
+#define PLL_CON0_PLL_SHARED0			0x0140
+#define PLL_CON3_PLL_SHARED0			0x014c
+#define PLL_CON0_PLL_SHARED1			0x0180
+#define PLL_CON3_PLL_SHARED1			0x018c
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1070
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_IP		0x1074
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART	0x1078
+#define CLK_CON_DIV_CLKCMU_PERI_BUS		0x187c
+#define CLK_CON_DIV_CLKCMU_PERI_IP		0x1880
+#define CLK_CON_DIV_CLKCMU_PERI_UART		0x1884
+#define CLK_CON_DIV_PLL_SHARED0_DIV2		0x188c
+#define CLK_CON_DIV_PLL_SHARED0_DIV3		0x1890
+#define CLK_CON_DIV_PLL_SHARED0_DIV4		0x1894
+#define CLK_CON_DIV_PLL_SHARED1_DIV2		0x1898
+#define CLK_CON_DIV_PLL_SHARED1_DIV3		0x189c
+#define CLK_CON_DIV_PLL_SHARED1_DIV4		0x18a0
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x2080
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_IP		0x2084
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART	0x2088
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
+/* List of parent clocks for Muxes in CMU_TOP */
+PNAME(mout_shared0_pll_p)	= { "clock-oscclk", "fout_shared0_pll" };
+PNAME(mout_shared1_pll_p)	= { "clock-oscclk", "fout_shared1_pll" };
+PNAME(mout_mmc_pll_p)		= { "clock-oscclk", "fout_mmc_pll" };
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
+PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
+PNAME(mout_peri_uart_p)		= { "clock-oscclk", "dout_shared0_div4",
+				    "dout_shared1_div4", "clock-oscclk" };
+PNAME(mout_peri_ip_p)		= { "clock-oscclk", "dout_shared0_div4",
+				    "dout_shared1_div4", "clock-oscclk" };
+
+static const struct samsung_mux_clock top_pure_mux_clks[] = {
+	MUX(CLK_MOUT_SHARED0_PLL, "mout_shared0_pll", mout_shared0_pll_p,
+	    PLL_CON0_PLL_SHARED0, 4, 1),
+	MUX(CLK_MOUT_SHARED1_PLL, "mout_shared1_pll", mout_shared1_pll_p,
+	    PLL_CON0_PLL_SHARED1, 4, 1),
+	MUX(CLK_MOUT_MMC_PLL, "mout_mmc_pll", mout_mmc_pll_p,
+	    PLL_CON0_PLL_MMC, 4, 1),
+};
+
+static const struct samsung_mux_clock top_peri_mux_clks[] = {
+	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
+	MUX(CLK_MOUT_PERI_UART, "mout_peri_uart", mout_peri_uart_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART, 0, 2),
+	MUX(CLK_MOUT_PERI_IP, "mout_peri_ip", mout_peri_ip_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_IP, 0, 2),
+};
+
+static const struct samsung_div_clock top_pure_div_clks[] = {
+	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "mout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
+	DIV(CLK_DOUT_SHARED0_DIV2, "dout_shared0_div2", "mout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
+	DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "mout_shared1_pll",
+	    CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
+	DIV(CLK_DOUT_SHARED1_DIV2, "dout_shared1_div2", "mout_shared1_pll",
+	    CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
+	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "dout_shared0_div2",
+	    CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
+	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "dout_shared1_div2",
+	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
+};
+
+static const struct samsung_div_clock top_peri_div_clks[] = {
+	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
+	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
+	DIV(CLK_DOUT_PERI_UART, "dout_peri_uart", "gout_peri_uart",
+	    CLK_CON_DIV_CLKCMU_PERI_UART, 0, 4),
+	DIV(CLK_DOUT_PERI_IP, "dout_peri_ip", "gout_peri_ip",
+	    CLK_CON_DIV_CLKCMU_PERI_IP, 0, 4),
+};
+
+static const struct samsung_gate_clock top_peri_gate_clks[] = {
+	GATE(CLK_GOUT_PERI_BUS, "gout_peri_bus", "mout_peri_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_UART, "gout_peri_uart", "mout_peri_uart",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_UART, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_IP, "gout_peri_ip", "mout_peri_ip",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_IP, 21, 0, 0),
+};
+
+static const struct samsung_clk_group top_cmu_clks[] = {
+	/* CMU_TOP_PURECLKCOMP */
+	{ S_CLK_PLL, top_pure_pll_clks, ARRAY_SIZE(top_pure_pll_clks) },
+	{ S_CLK_MUX, top_pure_mux_clks, ARRAY_SIZE(top_pure_mux_clks) },
+	{ S_CLK_DIV, top_pure_div_clks, ARRAY_SIZE(top_pure_div_clks) },
+
+	/* CMU_TOP clocks for CMU_PERI */
+	{ S_CLK_MUX, top_peri_mux_clks, ARRAY_SIZE(top_peri_mux_clks) },
+	{ S_CLK_GATE, top_peri_gate_clks, ARRAY_SIZE(top_peri_gate_clks) },
+	{ S_CLK_DIV, top_peri_div_clks, ARRAY_SIZE(top_peri_div_clks) },
+};
+
+static int exynos850_cmu_top_probe(struct udevice *dev)
+{
+	return samsung_cmu_register_one(dev, top_cmu_clks,
+					ARRAY_SIZE(top_cmu_clks));
+}
+
+static const struct udevice_id exynos850_cmu_top_ids[] = {
+	{ .compatible = "samsung,exynos850-cmu-top" },
+	{ }
+};
+
+U_BOOT_DRIVER(exynos850_cmu_top) = {
+	.name		= "exynos850-cmu-top",
+	.id		= UCLASS_CLK,
+	.of_match	= exynos850_cmu_top_ids,
+	.ops		= &ccf_clk_ops,
+	.probe		= exynos850_cmu_top_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+/* ---- CMU_PERI ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_PERI (0x10030000) */
+#define PLL_CON0_MUX_CLKCMU_PERI_BUS_USER	0x0600
+#define PLL_CON0_MUX_CLKCMU_PERI_UART_USER	0x0630
+#define CLK_CON_GAT_GOUT_PERI_UART_IPCLK	0x20a8
+#define CLK_CON_GAT_GOUT_PERI_UART_PCLK		0x20ac
+
+/* List of parent clocks for Muxes in CMU_PERI */
+PNAME(mout_peri_bus_user_p)	= { "clock-oscclk", "dout_peri_bus" };
+PNAME(mout_peri_uart_user_p)	= { "clock-oscclk", "dout_peri_uart" };
+
+static const struct samsung_mux_clock peri_mux_clks[] = {
+	MUX(CLK_MOUT_PERI_BUS_USER, "mout_peri_bus_user", mout_peri_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_PERI_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_UART_USER, "mout_peri_uart_user",
+	    mout_peri_uart_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART_USER, 4, 1),
+};
+
+static const struct samsung_gate_clock peri_gate_clks[] = {
+	GATE(CLK_GOUT_UART_IPCLK, "gout_uart_ipclk", "mout_peri_uart_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_IPCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART_PCLK, "gout_uart_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_PCLK, 21, 0, 0),
+};
+
+static const struct samsung_clk_group peri_cmu_clks[] = {
+	{ S_CLK_MUX, peri_mux_clks, ARRAY_SIZE(peri_mux_clks) },
+	{ S_CLK_GATE, peri_gate_clks, ARRAY_SIZE(peri_gate_clks) },
+};
+
+static int exynos850_cmu_peri_probe(struct udevice *dev)
+{
+	return samsung_register_cmu(dev, peri_cmu_clks, exynos850_cmu_top);
+}
+
+static const struct udevice_id exynos850_cmu_peri_ids[] = {
+	{ .compatible = "samsung,exynos850-cmu-peri" },
+	{ }
+};
+
+U_BOOT_DRIVER(exynos850_cmu_peri) = {
+	.name		= "exynos850-cmu-peri",
+	.id		= UCLASS_CLK,
+	.of_match	= exynos850_cmu_peri_ids,
+	.ops		= &ccf_clk_ops,
+	.probe		= exynos850_cmu_peri_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.39.2

