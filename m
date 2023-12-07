Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9993C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 16:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18598722C;
	Thu,  7 Dec 2023 17:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GDlmk2bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9441B87207; Thu,  7 Dec 2023 17:52:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476ED86E42
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 17:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqMcg006405;
 Thu, 7 Dec 2023 10:52:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701967942;
 bh=PSybsUacZmYI1Ln6ry7IZ09NoG/oMAk4yNRMDy4MpG4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GDlmk2bz5N8dZ4yl4bHWk0SMx1f3tlFCY9xnNhdswo9md9p7FwXhIRl0jhrqyIEFF
 6yaBsiw8/IZ+H7Lzb28a8OtOLTOBMO44CB8Vy9z2KCRC7cVaSeQ+Q+kpJMx7eQAdSC
 2t04z7Mm+Uf08AHCWOswbY+3Hzwgu/eMbzdhlDNU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7GqMcq099452
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Dec 2023 10:52:22 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 10:52:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 10:52:21 -0600
Received: from localhost (reidt-hp-z2.dhcp.ti.com [128.247.81.215])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqLMI057777;
 Thu, 7 Dec 2023 10:52:21 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH v3 1/2] arm: mach-k3: j72xx: add new 'virtual' mux
Date: Thu, 7 Dec 2023 10:52:10 -0600
Message-ID: <20231207165211.2319475-2-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207165211.2319475-1-reidt@ti.com>
References: <20231207165211.2319475-1-reidt@ti.com>
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

From: Bryan Brattlof <bb@ti.com>

In order for the Cortex-A72s to operate at different frequencies other
than the default 2GHz, add in a new 'virtual' mux (a mux that does not
physically exist in the clock tree) that can be selected.

CC: Vishal Mahaveer <vishalm@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Reid Tonking <reidt@ti.com>
---
 arch/arm/mach-k3/j7200/clk-data.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j7200/clk-data.c b/arch/arm/mach-k3/j7200/clk-data.c
index 9b45786a2d4..eb8436decbd 100644
--- a/arch/arm/mach-k3/j7200/clk-data.c
+++ b/arch/arm/mach-k3/j7200/clk-data.c
@@ -141,6 +141,11 @@ static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
 	"hsdiv4_16fft_main_0_hsdivout0_clk",
 };
 
+static const char * const main_pll8_sel_extwave_out0_parents[] = {
+	"pllfracf_ssmod_16fft_main_8_foutvcop_clk",
+	"hsdiv0_16fft_main_8_hsdivout0_clk",
+};
+
 static const char * const mcu_obsclk_outmux_out0_parents[] = {
 	"mcu_obsclk_div_out0",
 	"gluelogic_hfosc0_clkout",
@@ -396,6 +401,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("hsdiv4_16fft_main_3_hsdivout2_clk", "pllfracf_ssmod_16fft_main_3_foutvcop_clk", 0x683088, 0, 7, 0, 0),
 	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_main_0_sysclkout_clk", k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
 	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
+	CLK_MUX("main_pll8_sel_extwave_out0", main_pll8_sel_extwave_out0_parents, 2, 0x688040, 0, 1, 0),
 	CLK_DIV("mcu_obsclk_div_out0", "wkup_obsclk_mux_out0", 0x43008000, 8, 4, 0, 0),
 	CLK_MUX("mcu_obsclk_outmux_out0", mcu_obsclk_outmux_out0_parents, 2, 0x43008000, 24, 1, 0),
 	CLK_PLL("pllfracf_ssmod_16fft_main_4_foutvcop_clk", "main_pll4_xref_sel_out0", 0x684000, 0),
@@ -545,11 +551,14 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(288, 14, "board_0_hfosc1_clk_out"),
 	DEV_CLK(288, 15, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(288, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(323, 0, "main_pll8_sel_extwave_out0"),
+	DEV_CLK(323, 1, "pllfracf_ssmod_16fft_main_8_foutvcop_clk"),
+	DEV_CLK(323, 2, "hsdiv0_16fft_main_8_hsdivout0_clk"),
 };
 
 const struct ti_k3_clk_platdata j7200_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 109,
+	.clk_list_cnt = ARRAY_SIZE(clk_list),
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 129,
+	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
 };
-- 
2.34.1

