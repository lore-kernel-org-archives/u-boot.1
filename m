Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03A5E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D069806D8;
	Tue,  7 Jan 2025 10:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gT55TSfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B041D8066C; Tue,  7 Jan 2025 10:39:12 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6266B80619
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5079cssn003686;
 Tue, 7 Jan 2025 03:38:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736242734;
 bh=J5ozqCC4f1ggYEgsaf8b5cfovZK/W1hW3iKJvQlEN6g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gT55TSfM78IKNdSEwK5X2yw3pAlnLVesA75AKqM9FKsfZfaabHme4fwcIkCu0eft6
 B84NwJpB6z354neJ89kLrI/BNz16KiIVJW3QD4AfyyamP5QLDsCUZK29jmtl/Hylp9
 nDO5WiYbCCHJMfsAeuO4Lk6j+Vz6A+w5dD+evrzE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5079csuC035125
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 03:38:54 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 03:38:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 03:38:53 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5079cqLj057493;
 Tue, 7 Jan 2025 03:38:53 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 08/13] arm: mach-k3: am62p: Update SoC auto-gen data to enable
 CPSW boot
Date: Tue, 7 Jan 2025 15:08:35 +0530
Message-ID: <20250107093840.2211381-9-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107093840.2211381-1-c-vankar@ti.com>
References: <20250107093840.2211381-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Andreas Dannenberg <dannenberg@ti.com>

This data was generated using the ksswtool-autogen project with the
followig commit:

cd9dfa5 ("soc: am62px: Add cpsw_3guss_am67_main_0 id to the dev list")

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm/mach-k3/r5/am62px/clk-data.c | 44 +++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/am62px/dev-data.c | 24 ++++++++-------
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62px/clk-data.c b/arch/arm/mach-k3/r5/am62px/clk-data.c
index 4b9892fe051..24e912f2e25 100644
--- a/arch/arm/mach-k3/r5/am62px/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62px/clk-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -62,6 +62,17 @@ static const char * const clkout0_ctrl_out0_parents[] = {
 	"hsdiv4_16fft_main_2_hsdivout1_clk",
 };
 
+static const char * const main_cp_gemac_cpts_clk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_2_hsdivout5_clk",
+	"postdiv4_16ff_main_0_hsdivout6_clk",
+	"board_0_cp_gemac_cpts0_rft_clk_out",
+	NULL,
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	NULL,
+	"sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
 static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
 	"postdiv4_16ff_main_0_hsdivout5_clk",
 	"hsdiv4_16fft_main_2_hsdivout2_clk",
@@ -99,8 +110,8 @@ static const char * const main_timerclkn_sel_out0_parents[] = {
 	"board_0_cp_gemac_cpts0_rft_clk_out",
 	"hsdiv4_16fft_main_1_hsdivout3_clk",
 	"postdiv4_16ff_main_2_hsdivout6_clk",
-	NULL,
-	NULL,
+	"cpsw_3guss_am67_main_0_cpts_genf0",
+	"cpsw_3guss_am67_main_0_cpts_genf1",
 	NULL,
 	NULL,
 	NULL,
@@ -148,7 +159,12 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_ospi0_dqs_out", 0, 0),
 	CLK_FIXED_RATE("board_0_ospi0_lbclko_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rmii1_ref_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rmii2_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf0", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf1", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_mdio_mdclk_o", 0, 0),
 	CLK_FIXED_RATE("dmtimer_dmc1ms_main_0_timer_pwm", 0, 0),
 	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
 	CLK_FIXED_RATE("fss_ul_main_0_ospi_0_ospi_oclk_clk", 0, 0),
@@ -200,6 +216,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
 	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_cp_gemac_cpts_clk_sel_out0", main_cp_gemac_cpts_clk_sel_out0_parents, 8, 0x108140, 0, 3, 0),
 	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
 	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
@@ -215,6 +232,24 @@ static const struct clk_data clk_list[] = {
 };
 
 static const struct dev_clk soc_dev_clk_data[] = {
+	DEV_CLK(13, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(13, 3, "main_cp_gemac_cpts_clk_sel_out0"),
+	DEV_CLK(13, 4, "postdiv4_16ff_main_2_hsdivout5_clk"),
+	DEV_CLK(13, 5, "postdiv4_16ff_main_0_hsdivout6_clk"),
+	DEV_CLK(13, 6, "board_0_cp_gemac_cpts0_rft_clk_out"),
+	DEV_CLK(13, 8, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(13, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(13, 11, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(13, 13, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 14, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 15, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 16, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 17, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 19, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 20, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 21, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 22, "board_0_rmii1_ref_clk_out"),
+	DEV_CLK(13, 23, "board_0_rmii2_ref_clk_out"),
 	DEV_CLK(16, 0, "hsdiv4_16fft_main_0_hsdivout1_clk"),
 	DEV_CLK(16, 1, "hsdiv4_16fft_main_0_hsdivout2_clk"),
 	DEV_CLK(16, 2, "hsdiv4_16fft_main_0_hsdivout3_clk"),
@@ -239,6 +274,8 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(36, 10, "board_0_cp_gemac_cpts0_rft_clk_out"),
 	DEV_CLK(36, 11, "hsdiv4_16fft_main_1_hsdivout3_clk"),
 	DEV_CLK(36, 12, "postdiv4_16ff_main_2_hsdivout6_clk"),
+	DEV_CLK(36, 13, "cpsw_3guss_am67_main_0_cpts_genf0"),
+	DEV_CLK(36, 14, "cpsw_3guss_am67_main_0_cpts_genf1"),
 	DEV_CLK(57, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(57, 2, "main_emmcsd0_refclk_sel_out0"),
 	DEV_CLK(57, 3, "postdiv4_16ff_main_0_hsdivout5_clk"),
@@ -285,6 +322,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 40, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 54, "mshsi2c_main_0_porscl"),
 	DEV_CLK(157, 91, "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk"),
+	DEV_CLK(157, 96, "cpsw_3guss_am67_main_0_mdio_mdclk_o"),
 	DEV_CLK(157, 101, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 103, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 143, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
diff --git a/arch/arm/mach-k3/r5/am62px/dev-data.c b/arch/arm/mach-k3/r5/am62px/dev-data.c
index 3cc211ea202..63e6beb4d57 100644
--- a/arch/arm/mach-k3/r5/am62px/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62px/dev-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -31,11 +31,12 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[6] = PSC_LPSC(24, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
 	[7] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
 	[8] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
-	[9] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[8]),
-	[10] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[9]),
-	[11] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[8]),
-	[12] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
-	[13] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[12]),
+	[9] = PSC_LPSC(42, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[10] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[8]),
+	[11] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[10]),
+	[12] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[8]),
+	[13] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[12]),
+	[14] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[13]),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -52,11 +53,12 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[8]),
 	PSC_DEV(102, &soc_lpsc_list[8]),
 	PSC_DEV(146, &soc_lpsc_list[8]),
-	PSC_DEV(166, &soc_lpsc_list[9]),
-	PSC_DEV(135, &soc_lpsc_list[10]),
-	PSC_DEV(170, &soc_lpsc_list[11]),
-	PSC_DEV(177, &soc_lpsc_list[12]),
-	PSC_DEV(55, &soc_lpsc_list[13]),
+	PSC_DEV(13, &soc_lpsc_list[9]),
+	PSC_DEV(166, &soc_lpsc_list[10]),
+	PSC_DEV(135, &soc_lpsc_list[11]),
+	PSC_DEV(170, &soc_lpsc_list[12]),
+	PSC_DEV(177, &soc_lpsc_list[13]),
+	PSC_DEV(55, &soc_lpsc_list[14]),
 };
 
 const struct ti_k3_pd_platdata am62px_pd_platdata = {
-- 
2.34.1

