Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A0C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED6D83560;
	Thu, 31 Jul 2025 10:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jEZ6tA08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8C2833F6; Thu, 31 Jul 2025 10:02:00 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9338283429
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V81jj82955339;
 Thu, 31 Jul 2025 03:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948905;
 bh=hyeMqGe93b0vGaKUyzJuXMMOMAT3gWmQZK1DeJdHdLw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jEZ6tA08wJ6olZApu1TzqV2qllO2v0giqTMl533ODE75Z1n87lre0vSzsTS0u9MOn
 WxsdKr6UsurAQbQUwFMNaoTerOr5aYHDs4cJiajdTbmSw7smcEVw3eg4Jth5iNw6fY
 3KTAzHECMXyyXByltpD/N+jP2RmP+h5bU6wNFxt0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V81jBd4072312
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:01:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:01:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:01:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V80Olx2573075;
 Thu, 31 Jul 2025 03:00:24 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 10/21] arm: mach-k3: am62p: Update SoC auto-gen data to
 enable Ethernet boot
Date: Thu, 31 Jul 2025 13:29:45 +0530
Message-ID: <20250731075956.605474-11-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:19:27 +0200
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

Update dev-data and clk-data to enable Ethernet boot using CPSW on
SK-AM62P-LP.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
https://lore.kernel.org/u-boot/20250225114903.2080616-9-c-vankar@ti.com/

Changes from v3 to v4:
- No changes.

 arch/arm/mach-k3/r5/am62px/clk-data.c | 44 +++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/am62px/dev-data.c | 24 ++++++++-------
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62px/clk-data.c b/arch/arm/mach-k3/r5/am62px/clk-data.c
index bc62d1d0d08..b552a2be74d 100644
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
 	"hsdiv4_16fft_main_2_hsdivout1_clk10",
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
@@ -201,6 +217,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
 	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_cp_gemac_cpts_clk_sel_out0", main_cp_gemac_cpts_clk_sel_out0_parents, 8, 0x108140, 0, 3, 0),
 	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
 	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
@@ -216,6 +233,24 @@ static const struct clk_data clk_list[] = {
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
@@ -240,6 +275,8 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(36, 10, "board_0_cp_gemac_cpts0_rft_clk_out"),
 	DEV_CLK(36, 11, "hsdiv4_16fft_main_1_hsdivout3_clk"),
 	DEV_CLK(36, 12, "postdiv4_16ff_main_2_hsdivout6_clk"),
+	DEV_CLK(36, 13, "cpsw_3guss_am67_main_0_cpts_genf0"),
+	DEV_CLK(36, 14, "cpsw_3guss_am67_main_0_cpts_genf1"),
 	DEV_CLK(57, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(57, 2, "main_emmcsd0_refclk_sel_out0"),
 	DEV_CLK(57, 3, "postdiv4_16ff_main_0_hsdivout5_clk"),
@@ -286,6 +323,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
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

