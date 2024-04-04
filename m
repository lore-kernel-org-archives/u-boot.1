Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B18CCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AC688418;
	Thu,  4 Apr 2024 11:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YC9WT/7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7262488417; Thu,  4 Apr 2024 11:01:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5528688437
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490qBJ122432;
 Thu, 4 Apr 2024 04:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221252;
 bh=4SFSqRb/QQt0Amcyh5PpPmFULpKZBwfsXqTsM/AL1ak=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YC9WT/7pxA1KKvkOSVHzkjaHpPSTxQ0zFirTIhJYS+W47WmnxLCuEhMdr6EeUDHji
 AfticbK/WErYSe6MOYDFLXXQMsGKA8uE8BS08aCggIpzm1xLg9ZrblvVUUYX8P8gHI
 qjjF8Pp88OVTpYVthi7pHc0bqLF+NQK+smM7Ohz8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490qvq030271
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:52 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:52 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490pOh010938;
 Thu, 4 Apr 2024 04:00:52 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 08/15] arm: mach-k3: j722s: introduce clock and device
 files for wkup spl
Date: Thu, 4 Apr 2024 14:30:32 +0530
Message-ID: <20240404090039.87458-9-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Include the clock and lpsc tree files needed for the wkup spl to
initialize the proper PLLs and power domains to boot the SoC.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/r5/Makefile           |   1 +
 arch/arm/mach-k3/r5/j722s/Makefile     |   6 +
 arch/arm/mach-k3/r5/j722s/clk-data.c   | 312 +++++++++++++++++++++++++
 arch/arm/mach-k3/r5/j722s/dev-data.c   |  69 ++++++
 drivers/clk/ti/clk-k3.c                |   6 +
 drivers/power/domain/ti-power-domain.c |   6 +
 include/k3-clk.h                       |   1 +
 include/k3-dev.h                       |   1 +
 8 files changed, 402 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/j722s/Makefile
 create mode 100644 arch/arm/mach-k3/r5/j722s/clk-data.c
 create mode 100644 arch/arm/mach-k3/r5/j722s/dev-data.c

diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index f1e61c8548..d3886caa06 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
 obj-$(CONFIG_SOC_K3_J721E) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
+obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
 
 obj-y += common.o
diff --git a/arch/arm/mach-k3/r5/j722s/Makefile b/arch/arm/mach-k3/r5/j722s/Makefile
new file mode 100644
index 0000000000..2a0dbf5f5a
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j722s/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+
+obj-y += clk-data.o
+obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/r5/j722s/clk-data.c b/arch/arm/mach-k3/r5/j722s/clk-data.c
new file mode 100644
index 0000000000..b4f27af333
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j722s/clk-data.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * J722S specific clock platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/clk-provider.h>
+#include "k3-clk.h"
+
+static const char * const gluelogic_hfosc0_clkout_parents[] = {
+	NULL,
+	NULL,
+	"osc_24_mhz",
+	"osc_25_mhz",
+	"osc_26_mhz",
+	NULL,
+};
+
+static const char * const clk_32k_rc_sel_out0_parents[] = {
+	"gluelogic_rcosc_clk_1p0v_97p65k",
+	"gluelogic_hfosc0_clkout",
+	"gluelogic_rcosc_clk_1p0v_97p65k",
+	"gluelogic_lfosc0_clkout",
+};
+
+static const char * const main_emmcsd1_io_clklb_sel_out0_parents[] = {
+	"board_0_mmc1_clklb_out",
+	"board_0_mmc1_clk_out",
+};
+
+static const char * const main_ospi_loopback_clk_sel_out0_parents[] = {
+	"board_0_ospi0_dqs_out",
+	"board_0_ospi0_lbclko_out",
+};
+
+static const char * const main_usb0_refclk_sel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"postdiv4_16ff_main_0_hsdivout8_clk",
+};
+
+static const char * const sam62_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"hsdiv4_16fft_main_0_hsdivout0_clk",
+};
+
+static const char * const sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"hsdiv4_16fft_mcu_0_hsdivout0_clk",
+};
+
+static const char * const clkout0_ctrl_out0_parents[] = {
+	"hsdiv4_16fft_main_2_hsdivout1_clk",
+	"hsdiv4_16fft_main_2_hsdivout1_clk",
+};
+
+static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_0_hsdivout5_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+};
+
+static const char * const main_emmcsd1_refclk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_0_hsdivout5_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+};
+
+static const char * const main_gtcclk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_2_hsdivout5_clk",
+	"postdiv4_16ff_main_0_hsdivout6_clk",
+	"board_0_cp_gemac_cpts0_rft_clk_out",
+	NULL,
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	"sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk",
+	"sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
+static const char * const main_ospi_ref_clk_sel_out0_parents[] = {
+	"hsdiv4_16fft_main_0_hsdivout1_clk",
+	"postdiv1_16fft_main_1_hsdivout5_clk",
+};
+
+static const char * const main_timerclkn_sel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"clk_32k_rc_sel_out0",
+	"postdiv4_16ff_main_0_hsdivout7_clk",
+	"gluelogic_rcosc_clkout",
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	NULL,
+	"board_0_cp_gemac_cpts0_rft_clk_out",
+	"hsdiv4_16fft_main_1_hsdivout3_clk",
+	"postdiv4_16ff_main_2_hsdivout6_clk",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static const char * const wkup_clkout_sel_out0_parents[] = {
+	NULL,
+	"gluelogic_lfosc0_clkout",
+	"hsdiv4_16fft_main_0_hsdivout2_clk",
+	"hsdiv4_16fft_main_1_hsdivout2_clk",
+	"postdiv4_16ff_main_2_hsdivout9_clk",
+	"clk_32k_rc_sel_out0",
+	"gluelogic_rcosc_clkout",
+	"gluelogic_hfosc0_clkout",
+};
+
+static const char * const wkup_clkout_sel_io_out0_parents[] = {
+	"wkup_clkout_sel_out0",
+	"gluelogic_hfosc0_clkout",
+};
+
+static const char * const wkup_clksel_out0_parents[] = {
+	"hsdiv3_16fft_main_15_hsdivout0_clk",
+	"hsdiv4_16fft_mcu_0_hsdivout0_clk",
+};
+
+static const char * const main_usart0_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out0",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
+static const struct clk_data clk_list[] = {
+	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
+	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
+	CLK_FIXED_RATE("osc_24_mhz", 24000000, 0),
+	CLK_MUX("gluelogic_hfosc0_clkout", gluelogic_hfosc0_clkout_parents, 6, 0x43000030, 0, 3, 0),
+	CLK_FIXED_RATE("gluelogic_rcosc_clkout", 12500000, 0),
+	CLK_FIXED_RATE("gluelogic_rcosc_clk_1p0v_97p65k", 97656, 0),
+	CLK_FIXED_RATE("board_0_cp_gemac_cpts0_rft_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_ext_refclk1_out", 0, 0),
+	CLK_FIXED_RATE("board_0_i2c0_scl_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_ext_refclk0_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mmc1_clklb_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_ospi0_dqs_out", 0, 0),
+	CLK_FIXED_RATE("board_0_ospi0_lbclko_out", 0, 0),
+	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
+	CLK_FIXED_RATE("dmtimer_dmc1ms_main_0_timer_pwm", 0, 0),
+	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
+	CLK_FIXED_RATE("fss_ul_main_0_ospi_0_ospi_oclk_clk", 0, 0),
+	CLK_FIXED_RATE("mshsi2c_main_0_porscl", 0, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_0_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x680000, 0),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", 0x680038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_1_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x681000, 0, 1920000000),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", 0x681038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_12_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x68c000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_15_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x68f000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_2_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x682000, 0),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk_subdiv", 0x682038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_8_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x688000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", "gluelogic_hfosc0_clkout", 0x4040000, 0),
+	CLK_DIV("postdiv1_16fft_main_1_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x681094, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_0_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x680094, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_0_hsdivout6_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x680098, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_0_hsdivout7_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x68009c, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_0_hsdivout8_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x6800a0, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_2_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk", 0x682094, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_2_hsdivout6_clk", "pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk", 0x682098, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_2_hsdivout8_clk", "pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk", 0x6820a0, 0, 7, 0, 0),
+	CLK_DIV("postdiv4_16ff_main_2_hsdivout9_clk", "pllfracf2_ssmod_16fft_main_2_foutpostdiv_clk", 0x6820a4, 0, 7, 0, 0),
+	CLK_MUX("clk_32k_rc_sel_out0", clk_32k_rc_sel_out0_parents, 4, 0x4508058, 0, 2, 0),
+	CLK_MUX("main_emmcsd1_io_clklb_sel_out0", main_emmcsd1_io_clklb_sel_out0_parents, 2, 0x108168, 16, 1, 0),
+	CLK_MUX("main_ospi_loopback_clk_sel_out0", main_ospi_loopback_clk_sel_out0_parents, 2, 0x108500, 4, 1, 0),
+	CLK_MUX("main_usb0_refclk_sel_out0", main_usb0_refclk_sel_out0_parents, 2, 0x43008190, 0, 1, 0),
+	CLK_DIV("hsdiv0_16fft_main_12_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_12_foutvcop_clk", 0x68c080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_8_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_8_foutvcop_clk", 0x688080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv3_16fft_main_15_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_15_foutvcop_clk", 0x68f080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout3_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x68008c, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680090, 0, 7, 0, 0),
+	CLK_DIV_DEFFREQ("hsdiv4_16fft_main_1_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681080, 0, 7, 0, 0, 192000000),
+	CLK_DIV("hsdiv4_16fft_main_1_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x68108c, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040080, 0, 7, 0, 0),
+	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_main_0_sysclkout_clk", sam62_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
+	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
+	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
+	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
+	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
+	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
+	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
+	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
+	CLK_MUX("main_timerclkn_sel_out0", main_timerclkn_sel_out0_parents, 16, 0x1081b0, 0, 4, 0),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
+	CLK_MUX("wkup_clkout_sel_io_out0", wkup_clkout_sel_io_out0_parents, 2, 0x43008020, 24, 1, 0),
+	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
+	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
+	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x402011c, 0, 5, 0, 0),
+};
+
+static const struct dev_clk soc_dev_clk_data[] = {
+	DEV_CLK(16, 0, "hsdiv4_16fft_main_0_hsdivout1_clk"),
+	DEV_CLK(16, 1, "hsdiv4_16fft_main_0_hsdivout2_clk"),
+	DEV_CLK(16, 2, "hsdiv4_16fft_main_0_hsdivout3_clk"),
+	DEV_CLK(16, 3, "hsdiv4_16fft_main_0_hsdivout4_clk"),
+	DEV_CLK(16, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(16, 5, "board_0_ext_refclk1_out"),
+	DEV_CLK(16, 6, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(16, 7, "postdiv4_16ff_main_2_hsdivout8_clk"),
+	DEV_CLK(16, 8, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(16, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(16, 10, "gluelogic_rcosc_clkout"),
+	DEV_CLK(16, 11, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(16, 12, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(36, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(36, 2, "main_timerclkn_sel_out0"),
+	DEV_CLK(36, 3, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(36, 4, "clk_32k_rc_sel_out0"),
+	DEV_CLK(36, 5, "postdiv4_16ff_main_0_hsdivout7_clk"),
+	DEV_CLK(36, 6, "gluelogic_rcosc_clkout"),
+	DEV_CLK(36, 7, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(36, 8, "board_0_ext_refclk1_out"),
+	DEV_CLK(36, 10, "board_0_cp_gemac_cpts0_rft_clk_out"),
+	DEV_CLK(36, 11, "hsdiv4_16fft_main_1_hsdivout3_clk"),
+	DEV_CLK(36, 12, "postdiv4_16ff_main_2_hsdivout6_clk"),
+	DEV_CLK(57, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(57, 2, "main_emmcsd0_refclk_sel_out0"),
+	DEV_CLK(57, 3, "postdiv4_16ff_main_0_hsdivout5_clk"),
+	DEV_CLK(57, 4, "hsdiv4_16fft_main_2_hsdivout2_clk"),
+	DEV_CLK(58, 0, "main_emmcsd1_io_clklb_sel_out0"),
+	DEV_CLK(58, 1, "board_0_mmc1_clklb_out"),
+	DEV_CLK(58, 2, "board_0_mmc1_clk_out"),
+	DEV_CLK(58, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(58, 6, "main_emmcsd1_refclk_sel_out0"),
+	DEV_CLK(58, 7, "postdiv4_16ff_main_0_hsdivout5_clk"),
+	DEV_CLK(58, 8, "hsdiv4_16fft_main_2_hsdivout2_clk"),
+	DEV_CLK(61, 0, "main_gtcclk_sel_out0"),
+	DEV_CLK(61, 1, "postdiv4_16ff_main_2_hsdivout5_clk"),
+	DEV_CLK(61, 2, "postdiv4_16ff_main_0_hsdivout6_clk"),
+	DEV_CLK(61, 3, "board_0_cp_gemac_cpts0_rft_clk_out"),
+	DEV_CLK(61, 5, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(61, 6, "board_0_ext_refclk1_out"),
+	DEV_CLK(61, 7, "sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk"),
+	DEV_CLK(61, 8, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(61, 9, "wkup_clksel_out0"),
+	DEV_CLK(61, 10, "hsdiv3_16fft_main_15_hsdivout0_clk"),
+	DEV_CLK(61, 11, "hsdiv4_16fft_mcu_0_hsdivout0_clk"),
+	DEV_CLK(75, 0, "board_0_ospi0_dqs_out"),
+	DEV_CLK(75, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(75, 2, "main_ospi_loopback_clk_sel_out0"),
+	DEV_CLK(75, 3, "board_0_ospi0_dqs_out"),
+	DEV_CLK(75, 4, "board_0_ospi0_lbclko_out"),
+	DEV_CLK(75, 6, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(75, 7, "main_ospi_ref_clk_sel_out0"),
+	DEV_CLK(75, 8, "hsdiv4_16fft_main_0_hsdivout1_clk"),
+	DEV_CLK(75, 9, "postdiv1_16fft_main_1_hsdivout5_clk"),
+	DEV_CLK(77, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(102, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(102, 1, "board_0_i2c0_scl_out"),
+	DEV_CLK(102, 2, "hsdiv4_16fft_main_1_hsdivout0_clk"),
+	DEV_CLK(135, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(146, 0, "main_usart0_fclk_sel_out0"),
+	DEV_CLK(146, 1, "usart_programmable_clock_divider_out0"),
+	DEV_CLK(146, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(146, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 54, "clkout0_ctrl_out0"),
+	DEV_CLK(157, 55, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 56, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 62, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 74, "mshsi2c_main_0_porscl"),
+	DEV_CLK(157, 135, "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk"),
+	DEV_CLK(157, 143, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 145, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 157, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 159, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 173, "sam62_pll_ctrl_wrap_main_0_sysclkout_clk"),
+	DEV_CLK(157, 174, "wkup_clkout_sel_io_out0"),
+	DEV_CLK(157, 175, "wkup_clkout_sel_out0"),
+	DEV_CLK(157, 176, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(157, 178, "dmtimer_dmc1ms_main_0_timer_pwm"),
+	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 3, "main_usb0_refclk_sel_out0"),
+	DEV_CLK(161, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(161, 5, "postdiv4_16ff_main_0_hsdivout8_clk"),
+	DEV_CLK(161, 10, "board_0_tck_out"),
+	DEV_CLK(166, 3, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(166, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(169, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(169, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(170, 1, "hsdiv0_16fft_main_12_hsdivout0_clk"),
+	DEV_CLK(170, 2, "board_0_tck_out"),
+	DEV_CLK(170, 3, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+};
+
+const struct ti_k3_clk_platdata j722s_clk_platdata = {
+	.clk_list = clk_list,
+	.clk_list_cnt = ARRAY_SIZE(clk_list),
+	.soc_dev_clk_data = soc_dev_clk_data,
+	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
+};
diff --git a/arch/arm/mach-k3/r5/j722s/dev-data.c b/arch/arm/mach-k3/r5/j722s/dev-data.c
new file mode 100644
index 0000000000..59176c9899
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j722s/dev-data.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * J722S specific device platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-dev.h"
+
+static struct ti_psc soc_psc_list[] = {
+	[0] = PSC(0, 0x00400000),
+};
+
+static struct ti_pd soc_pd_list[] = {
+	[0] = PSC_PD(0, &soc_psc_list[0], NULL),
+	[1] = PSC_PD(3, &soc_psc_list[0], &soc_pd_list[0]),
+	[2] = PSC_PD(4, &soc_psc_list[0], &soc_pd_list[1]),
+	[3] = PSC_PD(13, &soc_psc_list[0], &soc_pd_list[0]),
+};
+
+static struct ti_lpsc soc_lpsc_list[] = {
+	[0] = PSC_LPSC(0, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[1] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
+	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
+	[3] = PSC_LPSC(20, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[4] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[5] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[6] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[7] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[8] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[7]),
+	[9] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[8]),
+	[10] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[7]),
+	[11] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[10]),
+	[12] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+};
+
+static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(16, &soc_lpsc_list[0]),
+	PSC_DEV(77, &soc_lpsc_list[0]),
+	PSC_DEV(61, &soc_lpsc_list[0]),
+	PSC_DEV(178, &soc_lpsc_list[1]),
+	PSC_DEV(179, &soc_lpsc_list[2]),
+	PSC_DEV(57, &soc_lpsc_list[3]),
+	PSC_DEV(58, &soc_lpsc_list[4]),
+	PSC_DEV(161, &soc_lpsc_list[5]),
+	PSC_DEV(75, &soc_lpsc_list[6]),
+	PSC_DEV(36, &soc_lpsc_list[7]),
+	PSC_DEV(102, &soc_lpsc_list[7]),
+	PSC_DEV(146, &soc_lpsc_list[7]),
+	PSC_DEV(166, &soc_lpsc_list[8]),
+	PSC_DEV(135, &soc_lpsc_list[9]),
+	PSC_DEV(170, &soc_lpsc_list[10]),
+	PSC_DEV(177, &soc_lpsc_list[11]),
+	PSC_DEV(55, &soc_lpsc_list[12]),
+};
+
+const struct ti_k3_pd_platdata j722s_pd_platdata = {
+	.psc = soc_psc_list,
+	.pd = soc_pd_list,
+	.lpsc = soc_lpsc_list,
+	.devs = soc_dev_list,
+	.num_psc = ARRAY_SIZE(soc_psc_list),
+	.num_pd = ARRAY_SIZE(soc_pd_list),
+	.num_lpsc = ARRAY_SIZE(soc_lpsc_list),
+	.num_devs = ARRAY_SIZE(soc_dev_list),
+};
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index a3c6e79db7..c1fc4f426f 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -94,6 +94,12 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.data = &j721s2_clk_platdata,
 	},
 #endif
+#if IS_ENABLED(CONFIG_SOC_K3_J722S)
+	{
+		.family = "J722S",
+		.data = &j722s_clk_platdata,
+	},
+#endif
 #if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 	{
 		.family = "J784S4",
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index a280859aa5..79ae075a5c 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -106,6 +106,12 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.data = &j721s2_pd_platdata,
 	},
 #endif
+#if IS_ENABLED(CONFIG_SOC_K3_J722S)
+	{
+		.family = "J722S",
+		.data = &j722s_pd_platdata,
+	},
+#endif
 #if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 	{
 		.family = "J784S4",
diff --git a/include/k3-clk.h b/include/k3-clk.h
index 7bc42ecbb0..855d31c9ae 100644
--- a/include/k3-clk.h
+++ b/include/k3-clk.h
@@ -178,6 +178,7 @@ extern const struct ti_k3_clk_platdata am62x_clk_platdata;
 extern const struct ti_k3_clk_platdata am62ax_clk_platdata;
 extern const struct ti_k3_clk_platdata j784s4_clk_platdata;
 extern const struct ti_k3_clk_platdata am62px_clk_platdata;
+extern const struct ti_k3_clk_platdata j722s_clk_platdata;
 
 struct clk *clk_register_ti_pll(const char *name, const char *parent_name,
 				void __iomem *reg);
diff --git a/include/k3-dev.h b/include/k3-dev.h
index 0c5ae9aa42..23b316701e 100644
--- a/include/k3-dev.h
+++ b/include/k3-dev.h
@@ -82,6 +82,7 @@ extern const struct ti_k3_pd_platdata am62x_pd_platdata;
 extern const struct ti_k3_pd_platdata am62ax_pd_platdata;
 extern const struct ti_k3_pd_platdata j784s4_pd_platdata;
 extern const struct ti_k3_pd_platdata am62px_pd_platdata;
+extern const struct ti_k3_pd_platdata j722s_pd_platdata;
 
 u8 ti_pd_state(struct ti_pd *pd);
 u8 lpsc_get_state(struct ti_lpsc *lpsc);
-- 
2.25.1

