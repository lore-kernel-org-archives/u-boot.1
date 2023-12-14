Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B4AC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66EC87AB8;
	Thu, 14 Dec 2023 17:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB6F87AB4; Thu, 14 Dec 2023 17:22:36 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C048807E2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1rDoTm-00BWOQ-GN; Thu, 14 Dec 2023 16:22:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/3] imx8mp-venice: update DRAM config for 2000MHz
Date: Thu, 14 Dec 2023 08:22:27 -0800
Message-Id: <20231214162227.1199831-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214162227.1199831-1-tharvey@gateworks.com>
References: <20231214162227.1199831-1-tharvey@gateworks.com>
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

The imx8mp venice boards can support 2000Mhz DRAM.
Update the DRAM config to support this.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/lpddr4_timing_imx8mp.c | 214 +++++++++---------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/board/gateworks/venice/lpddr4_timing_imx8mp.c b/board/gateworks/venice/lpddr4_timing_imx8mp.c
index 221296f9a626..56c6e2b5cff7 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mp.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mp.c
@@ -1211,9 +1211,9 @@ static struct dram_cfg_param ddr_phy_pie[] = {
 	{ 0x400d7, 0x20b },
 	{ 0x2003a, 0x2 },
 	{ 0x200be, 0x3 },
-	{ 0x2000b, 0x34b },
-	{ 0x2000c, 0xbb },
-	{ 0x2000d, 0x753 },
+	{ 0x2000b, 0x465 },
+	{ 0x2000c, 0xfa },
+	{ 0x2000d, 0x9c4 },
 	{ 0x2000e, 0x2c },
 	{ 0x12000b, 0x70 },
 	{ 0x12000c, 0x19 },
@@ -1323,42 +1323,42 @@ struct dram_cfg_param ddr_ddrc_cfg_1gb_single_die[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa1080020 },
-	{ 0x3d400020, 0x1223 },
-	{ 0x3d400024, 0x16e3600 },
-	{ 0x3d400064, 0x5b0087 },
+	{ 0x3d400020, 0x1323 },
+	{ 0x3d400024, 0x1e84800 },
+	{ 0x3d400064, 0x7a00b4 },
 	{ 0x3d400070, 0x7027f90 },
 	{ 0x3d400074, 0x790 },
-	{ 0x3d4000d0, 0xc00305ba },
-	{ 0x3d4000d4, 0x940000 },
-	{ 0x3d4000dc, 0xd4002d },
-	{ 0x3d4000e0, 0x310000 },
+	{ 0x3d4000d0, 0xc00307a3 },
+	{ 0x3d4000d4, 0xc50000 },
+	{ 0x3d4000dc, 0xf4003f },
+	{ 0x3d4000e0, 0x330000 },
 	{ 0x3d4000e8, 0x660048 },
 	{ 0x3d4000ec, 0x160048 },
-	{ 0x3d400100, 0x191e1920 },
-	{ 0x3d400104, 0x60630 },
-	{ 0x3d40010c, 0xb0b000 },
-	{ 0x3d400110, 0xe04080e },
-	{ 0x3d400114, 0x2040c0c },
-	{ 0x3d400118, 0x1010007 },
-	{ 0x3d40011c, 0x402 },
-	{ 0x3d400130, 0x20600 },
-	{ 0x3d400134, 0xc100002 },
-	{ 0x3d400138, 0x8d },
-	{ 0x3d400144, 0x96004b },
-	{ 0x3d400180, 0x2ee0017 },
-	{ 0x3d400184, 0x2605b8e },
+	{ 0x3d400100, 0x2028222a },
+	{ 0x3d400104, 0x8083f },
+	{ 0x3d40010c, 0xe0e000 },
+	{ 0x3d400110, 0x12040a12 },
+	{ 0x3d400114, 0x2050f0f },
+	{ 0x3d400118, 0x1010009 },
+	{ 0x3d40011c, 0x502 },
+	{ 0x3d400130, 0x20800 },
+	{ 0x3d400134, 0xe100002 },
+	{ 0x3d400138, 0xbc },
+	{ 0x3d400144, 0xc80064 },
+	{ 0x3d400180, 0x3e8001e },
+	{ 0x3d400184, 0x3207a12 },
 	{ 0x3d400188, 0x0 },
-	{ 0x3d400190, 0x497820a },
+	{ 0x3d400190, 0x49f820e },
 	{ 0x3d400194, 0x80303 },
-	{ 0x3d4001b4, 0x170a },
+	{ 0x3d4001b4, 0x1f0e },
 	{ 0x3d4001a0, 0xe0400018 },
 	{ 0x3d4001a4, 0xdf00e4 },
 	{ 0x3d4001a8, 0x80000000 },
 	{ 0x3d4001b0, 0x11 },
 	{ 0x3d4001c0, 0x1 },
 	{ 0x3d4001c4, 0x1 },
-	{ 0x3d4000f4, 0x699 },
-	{ 0x3d400108, 0x70e1617 },
+	{ 0x3d4000f4, 0x799 },
+	{ 0x3d400108, 0x9121b1c },
 	{ 0x3d400200, 0x1f },
 	{ 0x3d400208, 0x0 },
 	{ 0x3d40020c, 0x0 },
@@ -1500,7 +1500,7 @@ struct dram_cfg_param ddr_ddrphy_cfg_1gb_single_die[] = {
 	{ 0x7055, 0x1ff },
 	{ 0x8055, 0x1ff },
 	{ 0x9055, 0x1ff },
-	{ 0x200c5, 0x19 },
+	{ 0x200c5, 0x18 },
 	{ 0x1200c5, 0x7 },
 	{ 0x2200c5, 0x7 },
 	{ 0x2002e, 0x2 },
@@ -1509,11 +1509,11 @@ struct dram_cfg_param ddr_ddrphy_cfg_1gb_single_die[] = {
 	{ 0x90204, 0x0 },
 	{ 0x190204, 0x0 },
 	{ 0x290204, 0x0 },
-	{ 0x20024, 0x1a3 },
+	{ 0x20024, 0x1e3 },
 	{ 0x2003a, 0x2 },
-	{ 0x120024, 0x1a3 },
+	{ 0x120024, 0x1e3 },
 	{ 0x2003a, 0x2 },
-	{ 0x220024, 0x1a3 },
+	{ 0x220024, 0x1e3 },
 	{ 0x2003a, 0x2 },
 	{ 0x20056, 0x3 },
 	{ 0x120056, 0x3 },
@@ -1579,7 +1579,7 @@ struct dram_cfg_param ddr_ddrphy_cfg_1gb_single_die[] = {
 	{ 0x20018, 0x3 },
 	{ 0x20075, 0x4 },
 	{ 0x20050, 0x0 },
-	{ 0x20008, 0x2ee },
+	{ 0x20008, 0x3e8 },
 	{ 0x120008, 0x64 },
 	{ 0x220008, 0x19 },
 	{ 0x20088, 0x9 },
@@ -1644,7 +1644,7 @@ struct dram_cfg_param ddr_ddrphy_cfg_1gb_single_die[] = {
 /* P0 message block paremeter for training firmware */
 struct dram_cfg_param ddr_fsp0_cfg_1gb_single_die[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xbb8 },
+	{ 0x54003, 0xfa0 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
@@ -1653,26 +1653,26 @@ struct dram_cfg_param ddr_fsp0_cfg_1gb_single_die[] = {
 	{ 0x5400b, 0x2 },
 	{ 0x5400f, 0x100 },
 	{ 0x54012, 0x110 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, 0x31 },
+	{ 0x54019, 0x3ff4 },
+	{ 0x5401a, 0x33 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, 0x31 },
+	{ 0x5401f, 0x3ff4 },
+	{ 0x54020, 0x33 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, 0x312d },
+	{ 0x54032, 0xf400 },
+	{ 0x54033, 0x333f },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, 0x312d },
+	{ 0x54038, 0xf400 },
+	{ 0x54039, 0x333f },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1763,7 +1763,7 @@ struct dram_cfg_param ddr_fsp2_cfg_1gb_single_die[] = {
 /* P0 2D message block paremeter for training firmware */
 struct dram_cfg_param ddr_fsp0_2d_cfg_1gb_single_die[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xbb8 },
+	{ 0x54003, 0xfa0 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
@@ -1773,26 +1773,26 @@ struct dram_cfg_param ddr_fsp0_2d_cfg_1gb_single_die[] = {
 	{ 0x5400f, 0x100 },
 	{ 0x54010, 0x1f7f },
 	{ 0x54012, 0x110 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, 0x31 },
+	{ 0x54019, 0x3ff4 },
+	{ 0x5401a, 0x33 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, 0x31 },
+	{ 0x5401f, 0x3ff4 },
+	{ 0x54020, 0x33 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, 0x312d },
+	{ 0x54032, 0xf400 },
+	{ 0x54033, 0x333f },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, 0x312d },
+	{ 0x54038, 0xf400 },
+	{ 0x54039, 0x333f },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1802,8 +1802,8 @@ struct dram_cfg_param ddr_fsp0_2d_cfg_1gb_single_die[] = {
 
 struct dram_fsp_msg ddr_dram_fsp_msg_1gb_single_die[] = {
 	{
-		/* P0 3000mts 1D */
-		.drate = 3000,
+		/* P0 4000mts 1D */
+		.drate = 4000,
 		.fw_type = FW_1D_IMAGE,
 		.fsp_cfg = ddr_fsp0_cfg_1gb_single_die,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg_1gb_single_die),
@@ -1823,8 +1823,8 @@ struct dram_fsp_msg ddr_dram_fsp_msg_1gb_single_die[] = {
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg_1gb_single_die),
 	},
 	{
-		/* P0 3000mts 2D */
-		.drate = 3000,
+		/* P0 4000mts 2D */
+		.drate = 4000,
 		.fw_type = FW_2D_IMAGE,
 		.fsp_cfg = ddr_fsp0_2d_cfg_1gb_single_die,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg_1gb_single_die),
@@ -1843,7 +1843,7 @@ struct dram_timing_info dram_timing_1gb_single_die = {
 	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
 	.ddrphy_pie = ddr_phy_pie,
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
-	.fsp_table = { 3000, 400, 100, },
+	.fsp_table = { 4000, 400, 100, },
 };
 
 /*
@@ -1856,42 +1856,42 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa3080020 },
-	{ 0x3d400020, 0x1223 },
-	{ 0x3d400024, 0x16e3600 },
-	{ 0x3d400064, 0x5b00d2 },
+	{ 0x3d400020, 0x1323 },
+	{ 0x3d400024, 0x1e84800 },
+	{ 0x3d400064, 0x7a0118 },
 	{ 0x3d400070, 0x7027f90 },
 	{ 0x3d400074, 0x790 },
-	{ 0x3d4000d0, 0xc00305ba },
-	{ 0x3d4000d4, 0x940000 },
-	{ 0x3d4000dc, 0xd4002d },
-	{ 0x3d4000e0, 0x310000 },
+	{ 0x3d4000d0, 0xc00307a3 },
+	{ 0x3d4000d4, 0xc50000 },
+	{ 0x3d4000dc, 0xf4003f },
+	{ 0x3d4000e0, 0x330000 },
 	{ 0x3d4000e8, 0x660048 },
 	{ 0x3d4000ec, 0x160048 },
-	{ 0x3d400100, 0x191e1920 },
-	{ 0x3d400104, 0x60630 },
-	{ 0x3d40010c, 0xb0b000 },
-	{ 0x3d400110, 0xe04080e },
-	{ 0x3d400114, 0x2040c0c },
-	{ 0x3d400118, 0x1010007 },
-	{ 0x3d40011c, 0x402 },
-	{ 0x3d400130, 0x20600 },
-	{ 0x3d400134, 0xc100002 },
-	{ 0x3d400138, 0xd8 },
-	{ 0x3d400144, 0x96004b },
-	{ 0x3d400180, 0x2ee0017 },
-	{ 0x3d400184, 0x2605b8e },
+	{ 0x3d400100, 0x2028222a },
+	{ 0x3d400104, 0x8083f },
+	{ 0x3d40010c, 0xe0e000 },
+	{ 0x3d400110, 0x12040a12 },
+	{ 0x3d400114, 0x2050f0f },
+	{ 0x3d400118, 0x1010009 },
+	{ 0x3d40011c, 0x502 },
+	{ 0x3d400130, 0x20800 },
+	{ 0x3d400134, 0xe100002 },
+	{ 0x3d400138, 0x120 },
+	{ 0x3d400144, 0xc80064 },
+	{ 0x3d400180, 0x3e8001e },
+	{ 0x3d400184, 0x3207a12 },
 	{ 0x3d400188, 0x0 },
-	{ 0x3d400190, 0x497820a },
+	{ 0x3d400190, 0x49f820e},
 	{ 0x3d400194, 0x80303 },
-	{ 0x3d4001b4, 0x170a },
+	{ 0x3d4001b4, 0x1f0e },
 	{ 0x3d4001a0, 0xe0400018 },
 	{ 0x3d4001a4, 0xdf00e4 },
 	{ 0x3d4001a8, 0x80000000 },
 	{ 0x3d4001b0, 0x11 },
 	{ 0x3d4001c0, 0x1 },
 	{ 0x3d4001c4, 0x1 },
-	{ 0x3d4000f4, 0x699 },
-	{ 0x3d400108, 0x70e1617 },
+	{ 0x3d4000f4, 0x799 },
+	{ 0x3d400108, 0x9121b1c },
 	{ 0x3d400200, 0x17 },
 	{ 0x3d400208, 0x0 },
 	{ 0x3d40020c, 0x0 },
@@ -2033,7 +2033,7 @@ static struct dram_cfg_param ddr_ddrphy_cfg_4gb_dual_die[] = {
 	{ 0x7055, 0x1ff },
 	{ 0x8055, 0x1ff },
 	{ 0x9055, 0x1ff },
-	{ 0x200c5, 0x19 },
+	{ 0x200c5, 0x18 },
 	{ 0x1200c5, 0x7 },
 	{ 0x2200c5, 0x7 },
 	{ 0x2002e, 0x2 },
@@ -2042,11 +2042,11 @@ static struct dram_cfg_param ddr_ddrphy_cfg_4gb_dual_die[] = {
 	{ 0x90204, 0x0 },
 	{ 0x190204, 0x0 },
 	{ 0x290204, 0x0 },
-	{ 0x20024, 0x1a3 },
+	{ 0x20024, 0x1e3 },
 	{ 0x2003a, 0x2 },
-	{ 0x120024, 0x1a3 },
+	{ 0x120024, 0x1e3 },
 	{ 0x2003a, 0x2 },
-	{ 0x220024, 0x1a3 },
+	{ 0x220024, 0x1e3 },
 	{ 0x2003a, 0x2 },
 	{ 0x20056, 0x3 },
 	{ 0x120056, 0x3 },
@@ -2112,7 +2112,7 @@ static struct dram_cfg_param ddr_ddrphy_cfg_4gb_dual_die[] = {
 	{ 0x20018, 0x3 },
 	{ 0x20075, 0x4 },
 	{ 0x20050, 0x0 },
-	{ 0x20008, 0x2ee },
+	{ 0x20008, 0x3e8 },
 	{ 0x120008, 0x64 },
 	{ 0x220008, 0x19 },
 	{ 0x20088, 0x9 },
@@ -2176,7 +2176,7 @@ static struct dram_cfg_param ddr_ddrphy_cfg_4gb_dual_die[] = {
 
 static struct dram_cfg_param ddr_fsp0_cfg_4gb_dual_die[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xbb8 },
+	{ 0x54003, 0xfa0 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
@@ -2185,26 +2185,26 @@ static struct dram_cfg_param ddr_fsp0_cfg_4gb_dual_die[] = {
 	{ 0x5400b, 0x2 },
 	{ 0x5400f, 0x100 },
 	{ 0x54012, 0x310 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, 0x31 },
+	{ 0x54019, 0x3ff4 },
+	{ 0x5401a, 0x33 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, 0x31 },
+	{ 0x5401f, 0x3ff4 },
+	{ 0x54020, 0x33 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x3 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, 0x312d },
+	{ 0x54032, 0xf400 },
+	{ 0x54033, 0x333f },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, 0x312d },
+	{ 0x54038, 0xf400 },
+	{ 0x54039, 0x333f },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -2295,7 +2295,7 @@ static struct dram_cfg_param ddr_fsp2_cfg_4gb_dual_die[] = {
 /* P0 2D message block paremeter for training firmware */
 static struct dram_cfg_param ddr_fsp0_2d_cfg_4gb_dual_die[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xbb8 },
+	{ 0x54003, 0xfa0 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
@@ -2305,26 +2305,26 @@ static struct dram_cfg_param ddr_fsp0_2d_cfg_4gb_dual_die[] = {
 	{ 0x5400f, 0x100 },
 	{ 0x54010, 0x1f7f },
 	{ 0x54012, 0x310 },
-	{ 0x54019, 0x2dd4 },
-	{ 0x5401a, 0x31 },
+	{ 0x54019, 0x3ff4 },
+	{ 0x5401a, 0x33 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x2dd4 },
-	{ 0x54020, 0x31 },
+	{ 0x5401f, 0x3ff4 },
+	{ 0x54020, 0x33 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x3 },
-	{ 0x54032, 0xd400 },
-	{ 0x54033, 0x312d },
+	{ 0x54032, 0xf400 },
+	{ 0x54033, 0x333f },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xd400 },
-	{ 0x54039, 0x312d },
+	{ 0x54038, 0xf400 },
+	{ 0x54039, 0x333f },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -2334,8 +2334,8 @@ static struct dram_cfg_param ddr_fsp0_2d_cfg_4gb_dual_die[] = {
 
 static struct dram_fsp_msg ddr_dram_fsp_msg_4gb_dual_die[] = {
 	{
-		/* P0 3000mts 1D */
-		.drate = 3000,
+		/* P0 4000mts 1D */
+		.drate = 4000,
 		.fw_type = FW_1D_IMAGE,
 		.fsp_cfg = ddr_fsp0_cfg_4gb_dual_die,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg_4gb_dual_die),
@@ -2355,8 +2355,8 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_4gb_dual_die[] = {
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg_4gb_dual_die),
 	},
 	{
-		/* P0 3000mts 2D */
-		.drate = 3000,
+		/* P0 4000mts 2D */
+		.drate = 4000,
 		.fw_type = FW_2D_IMAGE,
 		.fsp_cfg = ddr_fsp0_2d_cfg_4gb_dual_die,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg_4gb_dual_die),
@@ -2375,5 +2375,5 @@ struct dram_timing_info dram_timing_4gb_dual_die = {
 	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
 	.ddrphy_pie = ddr_phy_pie,
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
-	.fsp_table = { 3000, 400, 100, },
+	.fsp_table = { 4000, 400, 100, },
 };
-- 
2.25.1

