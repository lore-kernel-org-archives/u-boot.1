Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E9EC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F040B82A27;
	Tue, 15 Apr 2025 19:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HIiLQpnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3AF82B27; Tue, 15 Apr 2025 19:37:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E6982102
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53FHb4gC081591
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 12:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744738624;
 bh=NcaulaH+yjvS3kKhQYyaWOKanmX4YTRhy1lUGx6EYK0=;
 h=From:To:CC:Subject:Date;
 b=HIiLQpnksU11ULKdqUZDqZbB1rXbba1wnCNY/9M8L21paNsKOgHiG6keuaqB44hrk
 MjzGuYyUXUPaHhNW7Sq8LqDS2GbvhXfC6B4NM9FeIP8yvoFApt+0+LnHC3rR9ri75k
 TS3VV+Glf6eKxcxNXKz986EHOT27Wj/63bBdqUYw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53FHb3NG028076
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Apr 2025 12:37:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 12:37:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 12:37:02 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53FHax4J003858;
 Tue, 15 Apr 2025 12:37:00 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>, <m-shah@ti.com>,
 Bhavya Kapoor <b-kapoor@ti.com>, KEERTHY <j-keerthy@ti.com>
Subject: [PATCH] arm: mach-k3: r5: j7200: Add clk dev data for WKUP UART
Date: Tue, 15 Apr 2025 23:06:51 +0530
Message-ID: <20250415173651.88646-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Bhavya Kapoor <b-kapoor@ti.com>

Add clk and dev data for wakeup uart to enable wakeup
UART as console.

Reported-by: KEERTHY <j-keerthy@ti.com>
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm/mach-k3/r5/j7200/clk-data.c | 16 ++++++++++++++++
 arch/arm/mach-k3/r5/j7200/dev-data.c |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-k3/r5/j7200/clk-data.c b/arch/arm/mach-k3/r5/j7200/clk-data.c
index eb8436decbd..996ba2023fe 100644
--- a/arch/arm/mach-k3/r5/j7200/clk-data.c
+++ b/arch/arm/mach-k3/r5/j7200/clk-data.c
@@ -62,6 +62,16 @@ static const char * const wkup_i2c0_mcupll_bypass_clksel_out0_parents[] = {
 	"gluelogic_hfosc0_clkout",
 };
 
+static const char * const wkupusart_clk_sel_out0_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
+	"postdiv2_16fft_main_1_hsdivout5_clk",
+};
+
+static const char * const wkup_usart_mcupll_bypass_clksel_out0_parents[] = {
+	"wkupusart_clk_sel_out0",
+	"gluelogic_hfosc0_clkout",
+};
+
 static const char * const main_pll_hfosc_sel_out0_parents[] = {
 	"gluelogic_hfosc0_clkout",
 	"board_0_hfosc1_clk_out",
@@ -345,6 +355,8 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("mcuusart_clk_sel_out0", mcuusart_clk_sel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
 	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
 	CLK_MUX("wkup_i2c0_mcupll_bypass_clksel_out0", wkup_i2c0_mcupll_bypass_clksel_out0_parents, 2, 0x43008060, 0, 1, 0),
+	CLK_MUX("wkupusart_clk_sel_out0", wkupusart_clk_sel_out0_parents, 2, 0x43008064, 0, 1, 0),
+	CLK_MUX("wkup_usart_mcupll_bypass_clksel_out0", wkup_usart_mcupll_bypass_clksel_out0_parents, 2, 0x43008060, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out12", main_pll_hfosc_sel_out12_parents, 2, 0x430080b0, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out14", main_pll_hfosc_sel_out14_parents, 2, 0x430080b8, 0, 1, 0),
@@ -543,6 +555,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(203, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
 	DEV_CLK(278, 2, "usart_programmable_clock_divider_out1"),
 	DEV_CLK(278, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(287, 2, "wkup_usart_mcupll_bypass_clksel_out0"),
+	DEV_CLK(287, 3, "wkupusart_clk_sel_out0"),
+	DEV_CLK(287, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(287, 5, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(288, 3, "postdiv2_16fft_main_1_hsdivout7_clk"),
 	DEV_CLK(288, 4, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(288, 6, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
diff --git a/arch/arm/mach-k3/r5/j7200/dev-data.c b/arch/arm/mach-k3/r5/j7200/dev-data.c
index 8ce6796fd04..12a1386f9d1 100644
--- a/arch/arm/mach-k3/r5/j7200/dev-data.c
+++ b/arch/arm/mach-k3/r5/j7200/dev-data.c
@@ -66,6 +66,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(149, &soc_lpsc_list[12]),
 	PSC_DEV(113, &soc_lpsc_list[13]),
 	PSC_DEV(197, &soc_lpsc_list[13]),
+	PSC_DEV(287, &soc_lpsc_list[13]),
 	PSC_DEV(103, &soc_lpsc_list[14]),
 	PSC_DEV(104, &soc_lpsc_list[15]),
 	PSC_DEV(102, &soc_lpsc_list[16]),
-- 
2.34.1

