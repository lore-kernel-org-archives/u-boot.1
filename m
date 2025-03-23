Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4EAC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764E582075;
	Sun, 23 Mar 2025 12:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9C782074; Sun, 23 Mar 2025 12:36:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B42A281219
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3BD4106F;
 Sun, 23 Mar 2025 04:36:56 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30F4C3F694;
 Sun, 23 Mar 2025 04:36:49 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 31/34] sunxi: A523: add DDR3 DRAM support
Date: Sun, 23 Mar 2025 11:35:41 +0000
Message-ID: <20250323113544.7933-32-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add reverse engineered code to add support for DDR3 DRAM chips on the
Allwinner A523 DRAM controller.
---
 arch/arm/mach-sunxi/Kconfig                  |   8 ++
 arch/arm/mach-sunxi/dram_sun55i_a523.c       | 136 ++++++++++++++++++-
 arch/arm/mach-sunxi/dram_timings/Makefile    |   1 +
 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c | 135 ++++++++++++++++++
 4 files changed, 274 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index aeab2b3f6dd..345e685fc4b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -596,6 +596,14 @@ config SUNXI_DRAM_DDR2_V3S
 	This option is only for the DDR2 memory chip which is co-packaged in
 	Allwinner V3s SoC.
 
+config SUNXI_DRAM_A523_DDR3
+	bool "DDR3 DRAM chips on the A523/T527 DRAM controller"
+	select SUNXI_DRAM_DDR3
+	depends on DRAM_SUN55I_A523
+	help
+	  This option is the DDR3 timing used by the stock boot0 by
+	  Allwinner.
+
 config SUNXI_DRAM_A523_LPDDR4
 	bool "LPDDR4 DRAM chips on the A523/T527 DRAM controller"
 	select SUNXI_DRAM_LPDDR4
diff --git a/arch/arm/mach-sunxi/dram_sun55i_a523.c b/arch/arm/mach-sunxi/dram_sun55i_a523.c
index fae02062547..d5e3a2fa0eb 100644
--- a/arch/arm/mach-sunxi/dram_sun55i_a523.c
+++ b/arch/arm/mach-sunxi/dram_sun55i_a523.c
@@ -870,6 +870,24 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x48, 0xc0000000);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+	case SUNXI_DRAM_TYPE_DDR4:
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		low = val & 0xff;
+		high = (val >> 8) & 0xff;
+
+		val = (high << 24) | (high << 16) | (high << 8) | high;
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x104);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x108);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x10c);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x114);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x118);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x11c);
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x120);
+
+		val = (low << 24) | (low << 16) | (high << 8) | high;
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x11c);
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		low = val & 0xff;
 		high = (val >> 8) & 0xff;
@@ -921,6 +939,26 @@ static bool mctl_phy_init(const struct dram_para *para,
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x00, 0xf00, val);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		val = 9;
+		val2 = 13;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+		if (config->clk <= 936) {
+			val = 10;
+			val2 = 14;
+		} else if (config->clk <= 1200) {
+			val = 12;
+			val2 = 16;
+		} else {
+			val = 14;
+			val2 = 18;
+		}
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		val = 8;
+		val2 = 14;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		if (config->clk <= 936) {
 			val = 10;
@@ -942,6 +980,36 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x08);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		writel(0x150a0310, SUNXI_DRAM_PHY0_BASE + 0x54);
+		writel(0x13140816, SUNXI_DRAM_PHY0_BASE + 0x58);
+		writel(0x001c0d1b, SUNXI_DRAM_PHY0_BASE + 0x5c);
+		writel(0x050c1d1a, SUNXI_DRAM_PHY0_BASE + 0x60);
+		writel(0x0411060b, SUNXI_DRAM_PHY0_BASE + 0x64);
+		writel(0x09071217, SUNXI_DRAM_PHY0_BASE + 0x68);
+		writel(0x18190e01, SUNXI_DRAM_PHY0_BASE + 0x6c);
+		writel(0x020f1e00, SUNXI_DRAM_PHY0_BASE + 0x70);
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+		writel(0x090c1c14, SUNXI_DRAM_PHY0_BASE + 0x54);
+		writel(0x1300060f, SUNXI_DRAM_PHY0_BASE + 0x58);
+		writel(0x12030807, SUNXI_DRAM_PHY0_BASE + 0x5c);
+		writel(0x0b100a02, SUNXI_DRAM_PHY0_BASE + 0x60);
+		writel(0x1a110e05, SUNXI_DRAM_PHY0_BASE + 0x64);
+		writel(0x0d041617, SUNXI_DRAM_PHY0_BASE + 0x68);
+		writel(0x1819011b, SUNXI_DRAM_PHY0_BASE + 0x6c);
+		writel(0x151d1e00, SUNXI_DRAM_PHY0_BASE + 0x70);
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		writel(0x010a1a0f, SUNXI_DRAM_PHY0_BASE + 0x54);
+		writel(0x10081b07, SUNXI_DRAM_PHY0_BASE + 0x58);
+		writel(0x11061c12, SUNXI_DRAM_PHY0_BASE + 0x5c);
+		writel(0x00131409, SUNXI_DRAM_PHY0_BASE + 0x60);
+		writel(0x15030e16, SUNXI_DRAM_PHY0_BASE + 0x64);
+		writel(0x0b0c0d17, SUNXI_DRAM_PHY0_BASE + 0x68);
+		writel(0x18190204, SUNXI_DRAM_PHY0_BASE + 0x6c);
+		writel(0x051d1e00, SUNXI_DRAM_PHY0_BASE + 0x70);
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		writel(0x00010203, SUNXI_DRAM_PHY0_BASE + 0x54);
 		writel(0x04050607, SUNXI_DRAM_PHY0_BASE + 0x58);
@@ -962,6 +1030,15 @@ static bool mctl_phy_init(const struct dram_para *para,
 		mctl_phy_ca_bit_delay_compensation(para, config);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		val = 0x2bbd4900;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+		val = 0x3841b800;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		val = 0x19016300;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = 0x18fd6300;
 		break;
@@ -973,6 +1050,15 @@ static bool mctl_phy_init(const struct dram_para *para,
 	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x00, 0x70);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		val = 0x20;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+		val = 0x40;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		val = 0x30;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = 0x50;
 		break;
@@ -1003,17 +1089,22 @@ static bool mctl_phy_init(const struct dram_para *para,
 	udelay(10);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		val = para->tpr6 & 0xff;
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+		val = para->tpr6 >> 8 & 0xff;
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		val = para->tpr6 >> 16 & 0xff;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
-		val = para->tpr6 >> 24 & 0xff;
-		if (val)
-			val <<= 1;
-		else
-			val = 0x33;
+		val = para->tpr6 >> 24;
 		break;
 	default:
 		panic("This DRAM setup is currently not supported.\n");
 	};
-	val <<= 23;
+	val <<= 24;
 
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x300, 0xff800060, val | 0x40);
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x600, 0xff800060, val | 0x40);
@@ -1078,6 +1169,23 @@ static bool mctl_phy_init(const struct dram_para *para,
 	mctl_await_completion(&mctl_ctl->swstat, 1, 1);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		writel(0x1f14, &mctl_ctl->mrctrl1);
+		writel(0x800000f0, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(4, &mctl_ctl->mrctrl1);
+		writel(0x800010f0, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0x20, &mctl_ctl->mrctrl1);
+		writel(0x800020f0, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+		writel(0, &mctl_ctl->mrctrl1);
+		writel(0x800030f0, &mctl_ctl->mrctrl0);
+		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		if (config->clk <= 936) {
 			mr1 = 0x34;
@@ -1209,6 +1317,9 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 
 	reg_val = MSTR_ACTIVE_RANKS(config->ranks);
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		reg_val |= MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		reg_val |= MSTR_BURST_LENGTH(16) | MSTR_DEVICETYPE_LPDDR4;
 		break;
@@ -1227,6 +1338,9 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 		writel(0x0201, &mctl_ctl->odtmap);
 
 	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		reg_val = 0x06000400;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		reg_val = 0x04000400;
 		break;
@@ -1361,7 +1475,11 @@ static unsigned long long mctl_calc_size(const struct dram_config *config)
 }
 
 static const struct dram_para para = {
+#ifdef CONFIG_SUNXI_DRAM_A523_DDR3
+	.type = SUNXI_DRAM_TYPE_DDR3,
+#elif defined(CONFIG_SUNXI_DRAM_A523_LPDDR4)
 	.type = SUNXI_DRAM_TYPE_LPDDR4,
+#endif
 	.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
 	.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
 	.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
@@ -1435,6 +1553,12 @@ unsigned long sunxi_dram_init(void)
 
 	config.clk = 360;
 	switch (para.type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		config.odt_en = 0x90909090;
+		config.tpr11 = 0x8f919190;
+		config.tpr12 = 0x22222723;
+		config.tpr14 = 0x48484848;
+		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		config.odt_en = 0x84848484;
 		config.tpr11 = 0x9a9a9a9a;
diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-sunxi/dram_timings/Makefile
index 7bcda180d0a..7f1ee96b864 100644
--- a/arch/arm/mach-sunxi/dram_timings/Makefile
+++ b/arch/arm/mach-sunxi/dram_timings/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
 obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
 obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
+obj-$(CONFIG_SUNXI_DRAM_A523_DDR3)	+= a523_ddr3.o
 obj-$(CONFIG_SUNXI_DRAM_A523_LPDDR4)	+= a523_lpddr4.o
diff --git a/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
new file mode 100644
index 00000000000..b9fa5a89dd1
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
@@ -0,0 +1,135 @@
+/*
+ * sun55i A523 DDR3 timings, as programmed by Allwinner's boot0
+ *
+ * (C) Copyright 2024 Mikhail Kalashnikov <iuncuim@gmail.com>
+ *   Based on H6 DDR3 timings:
+ *   (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#include <asm/arch/dram.h>
+#include <asm/arch/cpu.h>
+
+void mctl_set_timing_params(u32 clk)
+{
+	struct sunxi_mctl_ctl_reg * const mctl_ctl =
+			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+	u8 tcl, tcwl, t_rdata_en, trtp, twr, tphy_wrlat;
+	unsigned int mr1, mr2;
+
+	u8 tccd		= 4;
+	u8 tfaw		= ns_to_t(40, clk);
+	u8 trrd		= max(ns_to_t(10, clk), 2);
+	u8 twtr		= max(ns_to_t(10, clk), 4);
+	u8 trcd		= max(ns_to_t(18, clk), 2);
+	u8 trc		= ns_to_t(65, clk);
+	u8 txp		= max(ns_to_t(8, clk), 2);
+	u8 trp		= ns_to_t(21, clk);
+	u8 tras		= ns_to_t(42, clk);
+	u16 trefi	= ns_to_t(3904, clk) / 32;
+	u16 trfc	= ns_to_t(280, clk);
+	u16 txsr	= ns_to_t(290, clk);
+
+	u8 tmrw		= max(ns_to_t(14, clk), 5);
+	u8 tmod		= 12;
+	u8 tcke		= max(ns_to_t(15, clk), 2);
+	u8 tcksrx	= max(ns_to_t(2, clk), 2);
+	u8 tcksre	= max(ns_to_t(5, clk), 2);
+	u8 trasmax	= (trefi * 9) / 32;
+
+	if (clk <= 936) {
+		mr1 = 0x34;
+		mr2 = 0x1b;
+		tcl = 10;
+		tcwl = 5;
+		t_rdata_en = 17;
+		trtp = 4;
+		tphy_wrlat = 5;
+		twr = 10;
+	} else if (clk <= 1200) {
+		mr1 = 0x54;
+		mr2 = 0x2d;
+		tcl = 14;
+		tcwl = 7;
+		t_rdata_en = 25;
+		trtp = 6;
+		tphy_wrlat = 9;
+		twr = 15;
+	} else {
+		mr1 = 0x64;
+		mr2 = 0x36;
+		tcl = 16;
+		tcwl = 8;
+		t_rdata_en = 29;
+		trtp = 7;
+		tphy_wrlat = 11;
+		twr = 17;
+	}
+
+	u8 tmrd		= tmrw;
+	u8 tckesr	= tcke;
+	u8 twtp		= twr + 9 + tcwl;
+	u8 twr2rd	= twtr + 9 + tcwl;
+	u8 trd2wr	= ns_to_t(4, clk) + 7 - ns_to_t(1, clk) + tcl;
+	u8 txs		= 4;
+	u8 txsdll	= 16;
+	u8 txsabort	= 4;
+	u8 txsfast	= 4;
+
+	/* set DRAM timing */
+	// writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
+	//        &mctl_ctl->dramtmg[0]);
+	// writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
+	// writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
+	//        &mctl_ctl->dramtmg[2]);
+	// writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
+	// writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
+	//        &mctl_ctl->dramtmg[4]);
+	// writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
+	//        &mctl_ctl->dramtmg[5]);
+	writel(0x0e141a10, &mctl_ctl->dramtmg[0]);
+	writel(0x00040415, &mctl_ctl->dramtmg[1]);
+	writel(0x0507050b, &mctl_ctl->dramtmg[2]);
+	writel(0x0000400c, &mctl_ctl->dramtmg[3]);
+	writel(0x06020406, &mctl_ctl->dramtmg[4]);
+	writel(0x04040504, &mctl_ctl->dramtmg[5]);
+	/* Value suggested by ZynqMP manual and used by libdram */
+	writel((txp + 2) | 0x02020000, &mctl_ctl->dramtmg[6]);
+	writel((txsfast << 24) | (txsabort << 16) | (txsdll << 8) | txs,
+	       &mctl_ctl->dramtmg[8]);
+	writel(0x00020208, &mctl_ctl->dramtmg[9]);
+	writel(0xE0C05, &mctl_ctl->dramtmg[10]);
+	writel(0x440C021C, &mctl_ctl->dramtmg[11]);
+	writel(8, &mctl_ctl->dramtmg[12]);
+	writel(0xA100002, &mctl_ctl->dramtmg[13]);
+	//writel(txsr, &mctl_ctl->dramtmg[14]);
+	writel(4, &mctl_ctl->dramtmg[14]);
+
+	//clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x558);
+	clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x156);
+	writel(0x01f20000, &mctl_ctl->init[1]);
+	//writel(0x00001705, &mctl_ctl->init[2]);
+	writel(0x00001700, &mctl_ctl->init[2]);
+	writel(0, &mctl_ctl->dfimisc);
+	//writel((mr1 << 16) | mr2, &mctl_ctl->init[3]);
+	writel(0x1f140004, &mctl_ctl->init[3]);
+	//writel(0x00330000, &mctl_ctl->init[4]);
+	//writel(0x00040072, &mctl_ctl->init[6]);
+	//writel(0x00260008, &mctl_ctl->init[7]);
+	writel(0x00200000, &mctl_ctl->init[4]);
+	writel(0, &mctl_ctl->init[6]);
+	writel(0, &mctl_ctl->init[7]);
+
+	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
+
+	/* Configure DFI timing */
+	//writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
+	//       &mctl_ctl->dfitmg0);
+	writel(0x02898005,&mctl_ctl->dfitmg0);
+	writel(0x100202, &mctl_ctl->dfitmg1);
+
+	/* set refresh timing */
+	//writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
+	writel(0x008c0000, &mctl_ctl->rfshtmg);
+}
-- 
2.46.3

