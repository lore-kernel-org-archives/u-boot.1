Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9DF327C8
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2CF843FA;
	Tue, 21 Apr 2026 11:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="O55S5f6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD18B84390; Tue, 21 Apr 2026 11:05:18 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92193843FA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from y14 (unknown [IPv6:2a01:e0a:2af:22b0:6ee8:ae48:54aa:4eff])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id D73A278051F;
 Tue, 21 Apr 2026 11:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1776762316;
 bh=tMXP17C05OvG5RgO5mS5m0ak4uy0vsSprQnH3bAFcSc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O55S5f6ZoBcMXwWNZZBe4TF778JaL5Jr+qHKpWuo+SV7XPIjO1QcKIKbHH/zDNbFs
 imt+jKILn7ql0RNNmdtBSvNhNDdwExPnvuFNANIATsVJxNwWXSsNtNlvNnyxyzAihF
 Md29yMdJUUs3FTHRbxSlr6pCT5+HRuQccSKe0iKAi1aSx03X2COLuT/enGELUO2Y93
 kshETFlTzmm2uWpMTD9Q3+1uTTm3/cuXCKd8ckg/UxUWB96SEdHt4yeKJlZk8UbnIC
 Scb5khKdoDolbIZfIJq/ko/9CF2nedkWktMRp26xG2c4ARcBr4E77bRWbwSBGyzc2J
 k0B0LfXAcjBqA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 1/5] arm: mach-mvebu: armada8k: cpuinfo and SAR
Date: Tue, 21 Apr 2026 11:04:55 +0200
Message-ID: <ec9c17433b715d3f6aefca0f4713b8cb59b9a76b.1776762022.git.vjardin@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776762022.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
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

Add CPU information display for Armada 8040 platforms.

The soc_info.c reads the AP806 Sample-At-Reset (SAR) register to
determine the PLL clock configuration and converts it to actual
CPU, DDR, and Fabric frequencies using the PLL frequency table.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
---
 arch/arm/mach-mvebu/armada8k/Makefile   |   2 +-
 arch/arm/mach-mvebu/armada8k/cpu.c      |  12 ++
 arch/arm/mach-mvebu/armada8k/soc_info.c | 194 ++++++++++++++++++++++++
 arch/arm/mach-mvebu/armada8k/soc_info.h |  14 ++
 4 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.c
 create mode 100644 arch/arm/mach-mvebu/armada8k/soc_info.h

diff --git a/arch/arm/mach-mvebu/armada8k/Makefile b/arch/arm/mach-mvebu/armada8k/Makefile
index 0a4756717a3..723239d9894 100644
--- a/arch/arm/mach-mvebu/armada8k/Makefile
+++ b/arch/arm/mach-mvebu/armada8k/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright (C) 2016 Stefan Roese <sr@denx.de>
 
-obj-y = cpu.o cache_llc.o dram.o
+obj-y = cpu.o cache_llc.o dram.o soc_info.o
diff --git a/arch/arm/mach-mvebu/armada8k/cpu.c b/arch/arm/mach-mvebu/armada8k/cpu.c
index 3eb93c82387..220b32dd025 100644
--- a/arch/arm/mach-mvebu/armada8k/cpu.c
+++ b/arch/arm/mach-mvebu/armada8k/cpu.c
@@ -15,6 +15,8 @@
 #include <asm/armv8/mmu.h>
 #include <mach/fw_info.h>
 
+#include "soc_info.h"
+
 /* Armada 7k/8k */
 #define MVEBU_RFU_BASE			(MVEBU_REGISTER(0x6f0000))
 #define RFU_GLOBAL_SW_RST		(MVEBU_RFU_BASE + 0x84)
@@ -111,3 +113,13 @@ int mmc_get_env_dev(void)
 
 	return CONFIG_ENV_MMC_DEVICE_INDEX;
 }
+
+int print_cpuinfo(void)
+{
+	if (!IS_ENABLED(CONFIG_DISPLAY_CPUINFO))
+		return 0;
+
+	soc_print_clock_info();
+	soc_print_soc_info();
+	return 0;
+}
diff --git a/arch/arm/mach-mvebu/armada8k/soc_info.c b/arch/arm/mach-mvebu/armada8k/soc_info.c
new file mode 100644
index 00000000000..18cc083c0db
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada8k/soc_info.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2015 Marvell International Ltd.
+ *
+ * Marvell Armada 8K SoC info: SAR, Clock frequencies, LLC status
+ * Ported from Marvell U-Boot 2015.01 to mainline U-Boot.
+ */
+
+#include <config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <stdio.h>
+#include <asm/io.h>
+#include <asm/arch/soc.h>
+
+/* Clock frequency units */
+#define KHz			1000
+#define MHz			1000000
+#define GHz			1000000000
+
+/* AP806 SAR (Sample-At-Reset) register */
+#define AP806_SAR_REG_BASE		(SOC_REGS_PHY_BASE + 0x6F4400)
+#define SAR_CLOCK_FREQ_MODE_OFFSET	0
+#define SAR_CLOCK_FREQ_MODE_MASK	(0x1f << SAR_CLOCK_FREQ_MODE_OFFSET)
+
+/* LLC (Last Level Cache) registers */
+#define LLC_BASE			(SOC_REGS_PHY_BASE + 0x8000)
+#define LLC_CTRL			0x100
+#define LLC_CTRL_EN			0x1
+#define LLC_EXCLUSIVE_EN		0x100
+
+/* MSS clock is fixed at 200MHz on AP806 */
+#define AP806_MSS_CLOCK			(200 * MHz)
+
+/* Clock ID indices in PLL frequency table */
+#define CPU_CLOCK_ID	0
+#define DDR_CLOCK_ID	1
+#define RING_CLOCK_ID	2
+
+/* Clocking options (SAR field values) */
+enum clocking_options {
+	CPU_2000_DDR_1200_RCLK_1200 = 0x0,
+	CPU_2000_DDR_1050_RCLK_1050 = 0x1,
+	CPU_1600_DDR_800_RCLK_800 = 0x4,
+	CPU_1800_DDR_1200_RCLK_1200 = 0x6,
+	CPU_1800_DDR_1050_RCLK_1050 = 0x7,
+	CPU_1600_DDR_900_RCLK_900 = 0x0b,
+	CPU_1600_DDR_1050_RCLK_1050 = 0x0d,
+	CPU_1600_DDR_900_RCLK_900_2 = 0x0e,
+	CPU_1000_DDR_650_RCLK_650 = 0x13,
+	CPU_1300_DDR_800_RCLK_800 = 0x14,
+	CPU_1300_DDR_650_RCLK_650 = 0x17,
+	CPU_1200_DDR_800_RCLK_800 = 0x19,
+	CPU_1400_DDR_800_RCLK_800 = 0x1a,
+	CPU_600_DDR_800_RCLK_800 = 0x1b,
+	CPU_800_DDR_800_RCLK_800 = 0x1c,
+	CPU_1000_DDR_800_RCLK_800 = 0x1d,
+};
+
+/*
+ * PLL frequency table: maps SAR clock mode to actual frequencies.
+ * Format: { CPU_freq, DDR_freq, RING_freq, SAR_value }
+ */
+static const u32 pll_freq_tbl[16][4] = {
+	/* CPU */	/* DDR */	/* Ring */
+	{2000 * MHz,	1200 * MHz,	1200 * MHz,	CPU_2000_DDR_1200_RCLK_1200},
+	{2000 * MHz,	1050 * MHz,	1050 * MHz,	CPU_2000_DDR_1050_RCLK_1050},
+	{1800 * MHz,	1200 * MHz,	1200 * MHz,	CPU_1800_DDR_1200_RCLK_1200},
+	{1800 * MHz,	1050 * MHz,	1050 * MHz,	CPU_1800_DDR_1050_RCLK_1050},
+	{1600 * MHz,	1050 * MHz,	1050 * MHz,	CPU_1600_DDR_1050_RCLK_1050},
+	{1600 * MHz,	900 * MHz,	900 * MHz,	CPU_1600_DDR_900_RCLK_900_2},
+	{1300 * MHz,	800 * MHz,	800 * MHz,	CPU_1300_DDR_800_RCLK_800},
+	{1300 * MHz,	650 * MHz,	650 * MHz,	CPU_1300_DDR_650_RCLK_650},
+	{1600 * MHz,	800 * MHz,	800 * MHz,	CPU_1600_DDR_800_RCLK_800},
+	{1600 * MHz,	900 * MHz,	900 * MHz,	CPU_1600_DDR_900_RCLK_900},
+	{1000 * MHz,	650 * MHz,	650 * MHz,	CPU_1000_DDR_650_RCLK_650},
+	{1200 * MHz,	800 * MHz,	800 * MHz,	CPU_1200_DDR_800_RCLK_800},
+	{1400 * MHz,	800 * MHz,	800 * MHz,	CPU_1400_DDR_800_RCLK_800},
+	{600 * MHz,	800 * MHz,	800 * MHz,	CPU_600_DDR_800_RCLK_800},
+	{800 * MHz,	800 * MHz,	800 * MHz,	CPU_800_DDR_800_RCLK_800},
+	{1000 * MHz,	800 * MHz,	800 * MHz,	CPU_1000_DDR_800_RCLK_800}
+};
+
+/*
+ * Get the clock frequency mode index from SAR register.
+ * Returns index into pll_freq_tbl, or -1 if not found.
+ */
+static int sar_get_clock_freq_mode(void)
+{
+	u32 i;
+	u32 clock_freq;
+
+	clock_freq = (readl(AP806_SAR_REG_BASE) & SAR_CLOCK_FREQ_MODE_MASK)
+			>> SAR_CLOCK_FREQ_MODE_OFFSET;
+
+	for (i = 0; i < ARRAY_SIZE(pll_freq_tbl); i++) {
+		if (pll_freq_tbl[i][3] == clock_freq)
+			return i;
+	}
+
+	pr_err("SAR: unsupported clock freq mode %d\n", clock_freq);
+	return -1;
+}
+
+/*
+ * Get CPU clock frequency in Hz.
+ */
+static u32 soc_cpu_clk_get(void)
+{
+	int mode = sar_get_clock_freq_mode();
+
+	if (mode < 0)
+		return 0;
+	return pll_freq_tbl[mode][CPU_CLOCK_ID];
+}
+
+/*
+ * Get DDR clock frequency in Hz.
+ */
+static u32 soc_ddr_clk_get(void)
+{
+	int mode = sar_get_clock_freq_mode();
+
+	if (mode < 0)
+		return 0;
+	return pll_freq_tbl[mode][DDR_CLOCK_ID];
+}
+
+/*
+ * Get Ring (Fabric) clock frequency in Hz.
+ */
+static u32 soc_ring_clk_get(void)
+{
+	int mode = sar_get_clock_freq_mode();
+
+	if (mode < 0)
+		return 0;
+	return pll_freq_tbl[mode][RING_CLOCK_ID];
+}
+
+/*
+ * Get MSS clock frequency in Hz.
+ */
+static u32 soc_mss_clk_get(void)
+{
+	return AP806_MSS_CLOCK;
+}
+
+/*
+ * Get LLC status and mode.
+ * Returns 1 if LLC is enabled, 0 otherwise.
+ * If excl_mode is not NULL, sets it to 1 if exclusive mode is enabled.
+ */
+static int llc_mode_get(int *excl_mode)
+{
+	u32 val;
+	int ret = 0, excl = 0;
+
+	val = readl(LLC_BASE + LLC_CTRL);
+	if (val & LLC_CTRL_EN) {
+		ret = 1;
+		if (val & LLC_EXCLUSIVE_EN)
+			excl = 1;
+	}
+	if (excl_mode)
+		*excl_mode = excl;
+
+	return ret;
+}
+
+/*
+ * Print SoC clock information.
+ */
+void soc_print_clock_info(void)
+{
+	printf("Clock:  CPU     %-4d [MHz]\n", soc_cpu_clk_get() / MHz);
+	printf("\tDDR     %-4d [MHz]\n", soc_ddr_clk_get() / MHz);
+	printf("\tFABRIC  %-4d [MHz]\n", soc_ring_clk_get() / MHz);
+	printf("\tMSS     %-4d [MHz]\n", soc_mss_clk_get() / MHz);
+}
+
+/*
+ * Print SoC-specific information: DDR width and LLC status.
+ */
+void soc_print_soc_info(void)
+{
+	int llc_en, llc_excl_mode;
+
+	printf("\tDDR 64 Bit width\n");
+
+	llc_en = llc_mode_get(&llc_excl_mode);
+	printf("\tLLC %s%s\n", llc_en ? "Enabled" : "Disabled",
+	       llc_excl_mode ? " (Exclusive Mode)" : "");
+}
diff --git a/arch/arm/mach-mvebu/armada8k/soc_info.h b/arch/arm/mach-mvebu/armada8k/soc_info.h
new file mode 100644
index 00000000000..41afe7a2508
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada8k/soc_info.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015 Marvell International Ltd.
+ *
+ * Marvell Armada 8K SoC info functions
+ */
+
+#ifndef _ARMADA8K_SOC_INFO_H_
+#define _ARMADA8K_SOC_INFO_H_
+
+void soc_print_clock_info(void);
+void soc_print_soc_info(void);
+
+#endif /* _ARMADA8K_SOC_INFO_H_ */
-- 
2.53.0

