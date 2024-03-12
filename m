Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11416C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A77287FCA;
	Tue, 12 Mar 2024 21:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="unDwd28Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B86787F47; Tue, 12 Mar 2024 21:20:50 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704C287E6A
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTUc000702;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=EXHryaOwJC+f4m1qFqBxR0Ax+Vzgd5VqaPQg2ZVPEgE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=unDwd28QqrtxNe2/umgMDNKIQOM0mLzhoo4mATlY1AiiCfPaQVNz7A0miSVb/n2k2
 zrGc5fza8GxO82cyKSJpTY5GbxAOK0AvF/4T2yr90jNFlltwqJALjB5oF5CQdbdJVS
 nsT/RjDwNHMMlGYlCIdGfOzAVnOIVUfishor6PwA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTRF027347
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSl0091676;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:21 -0500
Subject: [PATCH v4 03/13] arm: mach-k3: am62px: introduce clock and device
 files for wkup spl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-3-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=24638; i=bb@ti.com;
 h=from:subject:message-id; bh=9INhYxFFhX8Igj+iFJ9200S0//UMManX9hpiUDLJ418=;
 b=owNCWmg5MUFZJlNZ4eJIcQAAaf///vZ/lvk//f/tj/3+3/X/st/+9Rzy/X/3y/3++75w09ewA
 RsWDtQADQBoA0AABpo0Gg0ADQA0GhoGjEGQNNAaAAaAGQAADT1PSHk1NGj2qIAAYgAAAAAaAaAG
 gNGgAADQB6gNqAxNHqBo9T1D1A3qg9QDJkHpAGQBtQyNNCNNNBpoNAAMmhkDQ9JoNAGgDTJoGmg
 MgyAwQAAAAaaaAAeoAAA9QAQQ9pEnSCoJrIMmw0C1PGkRfAYw4nkTxRwbgKAQDiGmvR1X1Zl6H3
 3cMMIM6iBFaSSox5ZpcY0iOLj+TxOTbB0rbJGBCbPnl7ZkU6lTVIQBxZk0dmfFmQE39KyxEJ/Gr
 M2ofDozWjJVItTscBFk8gRK+gUh7mhIKXeQhwk9ioGLFAOeBjhFPlj2VrGAm8uPe54tXE3iUQMh
 KkONvWsTGaA/gWHAqKB6AKDJW134mc1cH7FeYwlgiOJqk/0gB59+ghwWQvPlwi57D2uZ2Fht82z
 7/rG+E4r+MZmZSJXEiVbuIuDsVwwhckANULiieavxS39iWbE67tAdFGDOiJYgu9nCa1YNUIfVSQ
 4c8GL9BVi9kD9whzfyQuJsFygt4x/HUKAhzan9GWKh05GMD+sl55BokmXBAcqeGBIKhaC2FA/RP
 2D/F3JFOFCQ4eJIcQ==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/Makefile           |   1 +
 arch/arm/mach-k3/r5/am62px/Makefile    |   6 +
 arch/arm/mach-k3/r5/am62px/clk-data.c  | 325 +++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/r5/am62px/dev-data.c  |  71 +++++++
 drivers/clk/ti/clk-k3.c                |   6 +
 drivers/power/domain/ti-power-domain.c |   8 +-
 include/k3-clk.h                       |   1 +
 include/k3-dev.h                       |   1 +
 8 files changed, 418 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index ef0bf39d4503b..1cfc8e3ade966 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
+obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 
 obj-y += common.o
 obj-y += lowlevel_init.o
diff --git a/arch/arm/mach-k3/r5/am62px/Makefile b/arch/arm/mach-k3/r5/am62px/Makefile
new file mode 100644
index 0000000000000..50b0df20a3d1a
--- /dev/null
+++ b/arch/arm/mach-k3/r5/am62px/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier:	GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+
+obj-y += clk-data.o
+obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/r5/am62px/clk-data.c b/arch/arm/mach-k3/r5/am62px/clk-data.c
new file mode 100644
index 0000000000000..4b9892fe05167
--- /dev/null
+++ b/arch/arm/mach-k3/r5/am62px/clk-data.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AM62PX specific clock platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
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
+static const char * const main_usb1_refclk_sel_out0_parents[] = {
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
+	CLK_MUX("main_usb1_refclk_sel_out0", main_usb1_refclk_sel_out0_parents, 2, 0x43008194, 0, 1, 0),
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
+	DEV_CLK(157, 36, "clkout0_ctrl_out0"),
+	DEV_CLK(157, 37, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 38, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 40, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 54, "mshsi2c_main_0_porscl"),
+	DEV_CLK(157, 91, "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk"),
+	DEV_CLK(157, 101, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 103, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 143, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 145, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 161, "sam62_pll_ctrl_wrap_main_0_sysclkout_clk"),
+	DEV_CLK(157, 163, "dmtimer_dmc1ms_main_0_timer_pwm"),
+	DEV_CLK(157, 174, "wkup_clkout_sel_io_out0"),
+	DEV_CLK(157, 175, "wkup_clkout_sel_out0"),
+	DEV_CLK(157, 176, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 3, "main_usb0_refclk_sel_out0"),
+	DEV_CLK(161, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(161, 5, "postdiv4_16ff_main_0_hsdivout8_clk"),
+	DEV_CLK(161, 10, "board_0_tck_out"),
+	DEV_CLK(162, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(162, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(162, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(162, 3, "main_usb1_refclk_sel_out0"),
+	DEV_CLK(162, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(162, 5, "postdiv4_16ff_main_0_hsdivout8_clk"),
+	DEV_CLK(162, 10, "board_0_tck_out"),
+	DEV_CLK(166, 3, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(166, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(169, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(169, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(170, 1, "hsdiv0_16fft_main_12_hsdivout0_clk"),
+	DEV_CLK(170, 2, "board_0_tck_out"),
+	DEV_CLK(170, 3, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+};
+
+const struct ti_k3_clk_platdata am62px_clk_platdata = {
+	.clk_list = clk_list,
+	.clk_list_cnt = ARRAY_SIZE(clk_list),
+	.soc_dev_clk_data = soc_dev_clk_data,
+	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
+};
diff --git a/arch/arm/mach-k3/r5/am62px/dev-data.c b/arch/arm/mach-k3/r5/am62px/dev-data.c
new file mode 100644
index 0000000000000..3cc211ea20259
--- /dev/null
+++ b/arch/arm/mach-k3/r5/am62px/dev-data.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AM62PX specific device platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
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
+	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
+	[3] = PSC_LPSC(20, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[4] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[5] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[6] = PSC_LPSC(24, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[7] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[8] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[9] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[8]),
+	[10] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[9]),
+	[11] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[8]),
+	[12] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+	[13] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[12]),
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
+	PSC_DEV(162, &soc_lpsc_list[6]),
+	PSC_DEV(75, &soc_lpsc_list[7]),
+	PSC_DEV(36, &soc_lpsc_list[8]),
+	PSC_DEV(102, &soc_lpsc_list[8]),
+	PSC_DEV(146, &soc_lpsc_list[8]),
+	PSC_DEV(166, &soc_lpsc_list[9]),
+	PSC_DEV(135, &soc_lpsc_list[10]),
+	PSC_DEV(170, &soc_lpsc_list[11]),
+	PSC_DEV(177, &soc_lpsc_list[12]),
+	PSC_DEV(55, &soc_lpsc_list[13]),
+};
+
+const struct ti_k3_pd_platdata am62px_pd_platdata = {
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
index 10f60497973b3..7aa162c2f7029 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -92,6 +92,12 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.family = "J784S4",
 		.data = &j784s4_clk_platdata,
 	},
+#endif
+#ifdef CONFIG_SOC_K3_AM62P5
+	{
+		.family = "AM62PX",
+		.data = &am62px_clk_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 8fa9892c02c7a..8996c40ddc031 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -100,11 +100,17 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.data = &am62ax_pd_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_J784S4
+#if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 	{
 		.family = "J784S4",
 		.data = &j784s4_pd_platdata,
 	},
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
+	{
+		.family = "AM62PX",
+		.data = &am62px_pd_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/include/k3-clk.h b/include/k3-clk.h
index e161f09c0f59e..7bc42ecbb0c07 100644
--- a/include/k3-clk.h
+++ b/include/k3-clk.h
@@ -177,6 +177,7 @@ extern const struct ti_k3_clk_platdata j721s2_clk_platdata;
 extern const struct ti_k3_clk_platdata am62x_clk_platdata;
 extern const struct ti_k3_clk_platdata am62ax_clk_platdata;
 extern const struct ti_k3_clk_platdata j784s4_clk_platdata;
+extern const struct ti_k3_clk_platdata am62px_clk_platdata;
 
 struct clk *clk_register_ti_pll(const char *name, const char *parent_name,
 				void __iomem *reg);
diff --git a/include/k3-dev.h b/include/k3-dev.h
index a9d1ada804196..0c5ae9aa4263e 100644
--- a/include/k3-dev.h
+++ b/include/k3-dev.h
@@ -81,6 +81,7 @@ extern const struct ti_k3_pd_platdata j721s2_pd_platdata;
 extern const struct ti_k3_pd_platdata am62x_pd_platdata;
 extern const struct ti_k3_pd_platdata am62ax_pd_platdata;
 extern const struct ti_k3_pd_platdata j784s4_pd_platdata;
+extern const struct ti_k3_pd_platdata am62px_pd_platdata;
 
 u8 ti_pd_state(struct ti_pd *pd);
 u8 lpsc_get_state(struct ti_lpsc *lpsc);

-- 
2.43.2

