Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EACC87FCA
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 00:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E166083093;
	Sat, 26 Jul 2025 02:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9728391A; Sat, 26 Jul 2025 02:06:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 04C328307F
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 02:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F881764;
 Fri, 25 Jul 2025 17:06:45 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142D23F6A8;
 Fri, 25 Jul 2025 17:06:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Yixun Lan <dlan@gentoo.org>, Paul Kocialkowski <paulk@sys-base.io>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>
Subject: [PATCH] FIXUP! a523: DDR3: rework
Date: Sat, 26 Jul 2025 01:04:41 +0100
Message-ID: <20250726000441.7200-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250717235455.32528-15-andre.przywara@arm.com>
References: <20250717235455.32528-15-andre.przywara@arm.com>
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

The equations used to calculate the timing values for the DDR3 setup on
the Allwinner A523 SoC were copied from the LPDDR4 code, but DDR3 is
significantly different, so the results don't match what boot0 wrote and
they wouldn't work. Consequently the current code ignored the
calculations and used hardcoded values matching those from the BSP, but
that leads to compiler warnings due to the unused code.

Use the equations from the H6 and H616 DDR3 timings code instead, with
some slight adjustments, to generate the exact same values the hardcoded
writes were producing before.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c | 163 ++++++++-----------
 1 file changed, 71 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
index 6db0ea30f7c..67e1af9cd66 100644
--- a/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * sun55i A523 DDR3 timings, as programmed by Allwinner's boot0
+ * sun55i A523 DDR3 timings, as programmed by Allwinner's boot0 on
+ * the X96QPro+ TV box. As usual very conservative timings, but probably
+ * the most compatible and reliable.
  *
  * (C) Copyright 2024 Mikhail Kalashnikov <iuncuim@gmail.com>
- *   Based on H6 DDR3 timings:
+ *   Based on H616 DDR3 timings:
  *   (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
  */
 
@@ -14,121 +16,98 @@ void mctl_set_timing_params(u32 clk)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-	u8 tcl, tcwl, t_rdata_en, trtp, twr, tphy_wrlat;
-	unsigned int mr1, mr2;
 
-	u8 tccd		= 4;
-	u8 tfaw		= ns_to_t(40, clk);
-	u8 trrd		= max(ns_to_t(10, clk), 2);
-	u8 twtr		= max(ns_to_t(10, clk), 4);
-	u8 trcd		= max(ns_to_t(18, clk), 2);
-	u8 trc		= ns_to_t(65, clk);
-	u8 txp		= max(ns_to_t(8, clk), 2);
-	u8 trp		= ns_to_t(21, clk);
-	u8 tras		= ns_to_t(42, clk);
-	u16 trefi	= ns_to_t(3904, clk) / 32;
-	u16 trfc	= ns_to_t(280, clk);
-	u16 txsr	= ns_to_t(290, clk);
+	/*
+	 *					formulas and constraints as of
+	 *					JEDEC DDR3 specification, for
+	 *					DDR3-1600, per JESD79-3F
+	 */
+	u8 tccd		= 2;				/* 4nCK */
+	u8 tfaw		= ns_to_t(50, clk);
+	u8 trrd		= max(ns_to_t(6, clk), 4);	/* max(6 ns, 4nCK) */
+	u8 twtr		= max(ns_to_t(8, clk), 4); 	/* max(7.5 ns, 4nCK) */
+	u8 trcd		= ns_to_t(15, clk);		/* 13.5 ns */
+	u8 trc		= ns_to_t(53, clk);
+	u8 txp		= max(ns_to_t(8, clk), 2); 	/* max(6 ns, 3nCK) */
+	u8 trtp		= max(ns_to_t(8, clk), 4); 	/* max(7.5 ns, 4nCK) */
+	u8 trp		= ns_to_t(15, clk);		/* >= 13.75 ns */
+	u8 tras		= ns_to_t(38, clk);
+	u16 trefi	= ns_to_t(11350, clk) / 32;
+	u16 trfc	= ns_to_t(360, clk);		/* 160 ns for 2Gb */
+	u16 txsr	= 4;
 
-	u8 tmrw		= max(ns_to_t(14, clk), 5);
-	u8 tmod		= 12;
-	u8 tcke		= max(ns_to_t(15, clk), 2);
-	u8 tcksrx	= max(ns_to_t(2, clk), 2);
-	u8 tcksre	= max(ns_to_t(5, clk), 2);
-	u8 trasmax	= (trefi * 9) / 32;
+	u8 tmrw		= 0;
+	u8 tmrd		= 4;				/* 4nCK */
 
-	if (clk <= 936) {
-		mr1 = 0x34;
-		mr2 = 0x1b;
-		tcl = 10;
-		tcwl = 5;
-		t_rdata_en = 17;
-		trtp = 4;
-		tphy_wrlat = 5;
-		twr = 10;
-	} else if (clk <= 1200) {
-		mr1 = 0x54;
-		mr2 = 0x2d;
-		tcl = 14;
-		tcwl = 7;
-		t_rdata_en = 25;
-		trtp = 6;
-		tphy_wrlat = 9;
-		twr = 15;
-	} else {
-		mr1 = 0x64;
-		mr2 = 0x36;
-		tcl = 16;
-		tcwl = 8;
-		t_rdata_en = 29;
-		trtp = 7;
-		tphy_wrlat = 11;
-		twr = 17;
-	}
+	u8 tmod		= max(ns_to_t(15, clk), 12); 	/* max(15 ns, 12nCK) */
+	u8 tcke		= max(ns_to_t(6, clk), 4); 	/* max(5.625 ns, 3nCK)*/
+	u8 tcksrx	= max(ns_to_t(10, clk), 4);	/* max(10 ns, 5nCK) */
+	u8 tcksre	= max(ns_to_t(10, clk), 4);	/* max(10 ns, 5nCK) */
+	u8 trasmax	= (clk / 2) / 15;		/* tREFI * 9 */
 
-	u8 tmrd		= tmrw;
-	u8 tckesr	= tcke;
-	u8 twtp		= twr + 9 + tcwl;
-	u8 twr2rd	= twtr + 9 + tcwl;
-	u8 trd2wr	= ns_to_t(4, clk) + 7 - ns_to_t(1, clk) + tcl;
-	u8 txs		= 4;
-	u8 txsdll	= 16;
+	/*
+	 * TODO: support multiple DDR3 speed grades, these values below match
+	 * the worst case for DDR3-2133, so should be good for all frequencies,
+	 * but use the most conversative timings.
+	 * DDR3-1866 (DRAM_CLK=912) should also work, or tcl=6 and tcwl=4 with
+	 * DRAM_CLK=792. Maybe even the combination of both, depending on the
+	 * particular device.
+	 */
+	u8 tcl		= 7;			/* CAS latency: 14 */
+	u8 tcwl		= 5;			/* CAS write latency: 10 */
+	u8 t_rdata_en	= 9;
+	u8 tphy_wrlat	= 5;
+	u8 twr		= 7;
+
+	u8 tckesr	= tcke + 1;			/* tCKE(min) + 1nCK */
+
+	u8 twtp		= twr + 2 + tcwl;
+	u8 twr2rd	= twtr + 2 + tcwl;	/* (WL + BL / 2 + tWTR) / 2 */
+	u8 trd2wr	= tcl + 3 - tcwl;
+	u8 txs		= ns_to_t(360, clk) / 32;	/* max(5nCK,tRFC+10ns)*/
+	u8 txsdll	= 512 / 32;			/* 512 nCK */
 	u8 txsabort	= 4;
 	u8 txsfast	= 4;
 
 	/* set DRAM timing */
-	// writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
-	//        &mctl_ctl->dramtmg[0]);
-	// writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
-	// writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
-	//        &mctl_ctl->dramtmg[2]);
-	// writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
-	// writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
-	//        &mctl_ctl->dramtmg[4]);
-	// writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
-	//        &mctl_ctl->dramtmg[5]);
-	writel(0x0e141a10, &mctl_ctl->dramtmg[0]);
-	writel(0x00040415, &mctl_ctl->dramtmg[1]);
-	writel(0x0507050b, &mctl_ctl->dramtmg[2]);
-	writel(0x0000400c, &mctl_ctl->dramtmg[3]);
-	writel(0x06020406, &mctl_ctl->dramtmg[4]);
-	writel(0x04040504, &mctl_ctl->dramtmg[5]);
+	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
+	       &mctl_ctl->dramtmg[0]);
+	writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
+	writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
+	       &mctl_ctl->dramtmg[2]);
+	writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
+	writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
+	       &mctl_ctl->dramtmg[4]);
+	writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
+	       &mctl_ctl->dramtmg[5]);
 	/* Value suggested by ZynqMP manual and used by libdram */
 	writel((txp + 2) | 0x02020000, &mctl_ctl->dramtmg[6]);
 	writel((txsfast << 24) | (txsabort << 16) | (txsdll << 8) | txs,
 	       &mctl_ctl->dramtmg[8]);
 	writel(0x00020208, &mctl_ctl->dramtmg[9]);
-	writel(0xE0C05, &mctl_ctl->dramtmg[10]);
-	writel(0x440C021C, &mctl_ctl->dramtmg[11]);
+	writel(0xe0c05, &mctl_ctl->dramtmg[10]);
+	writel(0x440c021c, &mctl_ctl->dramtmg[11]);
 	writel(8, &mctl_ctl->dramtmg[12]);
-	writel(0xA100002, &mctl_ctl->dramtmg[13]);
-	//writel(txsr, &mctl_ctl->dramtmg[14]);
-	writel(4, &mctl_ctl->dramtmg[14]);
+	writel(0xa100002, &mctl_ctl->dramtmg[13]);
+	writel(txsr, &mctl_ctl->dramtmg[14]);
 
-	//clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x558);
-	clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x156);
+	clrsetbits_le32(&mctl_ctl->init[0], 0xc0000fff, 0x156);
 	writel(0x01f20000, &mctl_ctl->init[1]);
-	//writel(0x00001705, &mctl_ctl->init[2]);
 	writel(0x00001700, &mctl_ctl->init[2]);
 	writel(0, &mctl_ctl->dfimisc);
-	//writel((mr1 << 16) | mr2, &mctl_ctl->init[3]);
 	writel(0x1f140004, &mctl_ctl->init[3]);
-	//writel(0x00330000, &mctl_ctl->init[4]);
-	//writel(0x00040072, &mctl_ctl->init[6]);
-	//writel(0x00260008, &mctl_ctl->init[7]);
 	writel(0x00200000, &mctl_ctl->init[4]);
-	writel(0, &mctl_ctl->init[6]);
-	writel(0, &mctl_ctl->init[7]);
+	writel(0, &mctl_ctl->init[6]);	/* ? */
+	writel(0, &mctl_ctl->init[7]);	/* ? */
 
 	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
 
 	/* Configure DFI timing */
-	//writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
-	//       &mctl_ctl->dfitmg0);
-	writel(0x02898005, &mctl_ctl->dfitmg0);
+	writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
+	       &mctl_ctl->dfitmg0);
 	writel(0x100202, &mctl_ctl->dfitmg1);
 
 	/* set refresh timing */
-	//writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
-	writel(0x008c0000, &mctl_ctl->rfshtmg);
+	trfc = 0;	/* as written so by boot0 */
+	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
 }
-- 
2.46.3

