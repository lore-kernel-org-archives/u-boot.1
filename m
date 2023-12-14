Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C573C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A438387AAB;
	Thu, 14 Dec 2023 17:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6236D87AB9; Thu, 14 Dec 2023 17:22:34 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90D187AAB
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1rDoTm-00BWOQ-11; Thu, 14 Dec 2023 16:22:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/3] imx8mp-venice: fix DRAM bus configuration
Date: Thu, 14 Dec 2023 08:22:26 -0800
Message-Id: <20231214162227.1199831-2-tharvey@gateworks.com>
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

The DRAM configuration for the 1GB and 4GB imx8mp venice boards had a
bus mapping issue (channel A and B swapped) which creates an invalid
deskewing configuration during training causing the DRAM to not be able
to run at its full bus speed.

Update the various config structures to resolve this.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/lpddr4_timing_imx8mp.c | 121 +++++++++---------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/board/gateworks/venice/lpddr4_timing_imx8mp.c b/board/gateworks/venice/lpddr4_timing_imx8mp.c
index 7bfd1b556bb3..221296f9a626 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mp.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mp.c
@@ -1323,7 +1323,7 @@ struct dram_cfg_param ddr_ddrc_cfg_1gb_single_die[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa1080020 },
-	{ 0x3d400020, 0x1203 },
+	{ 0x3d400020, 0x1223 },
 	{ 0x3d400024, 0x16e3600 },
 	{ 0x3d400064, 0x5b0087 },
 	{ 0x3d400070, 0x7027f90 },
@@ -1379,7 +1379,7 @@ struct dram_cfg_param ddr_ddrc_cfg_1gb_single_die[] = {
 	{ 0x3d400498, 0x620096 },
 	{ 0x3d40049c, 0x1100e07 },
 	{ 0x3d4004a0, 0xc8012c },
-	{ 0x3d402020, 0x1001 },
+	{ 0x3d402020, 0x1021 },
 	{ 0x3d402024, 0x30d400 },
 	{ 0x3d402050, 0x20d000 },
 	{ 0x3d402064, 0xc0012 },
@@ -1404,7 +1404,7 @@ struct dram_cfg_param ddr_ddrc_cfg_1gb_single_die[] = {
 	{ 0x3d402194, 0x80303 },
 	{ 0x3d4021b4, 0x100 },
 	{ 0x3d4020f4, 0x599 },
-	{ 0x3d403020, 0x1001 },
+	{ 0x3d403020, 0x1021 },
 	{ 0x3d403024, 0xc3500 },
 	{ 0x3d403050, 0x20d000 },
 	{ 0x3d403064, 0x30005 },
@@ -1436,36 +1436,36 @@ struct dram_cfg_param ddr_ddrc_cfg_1gb_single_die[] = {
 struct dram_cfg_param ddr_ddrphy_cfg_1gb_single_die[] = {
 	{ 0x100a0, 0x0 },
 	{ 0x100a1, 0x1 },
-	{ 0x100a2, 0x3 },
-	{ 0x100a3, 0x2 },
-	{ 0x100a4, 0x5 },
-	{ 0x100a5, 0x4 },
-	{ 0x100a6, 0x7 },
-	{ 0x100a7, 0x6 },
+	{ 0x100a2, 0x2 },
+	{ 0x100a3, 0x3 },
+	{ 0x100a4, 0x4 },
+	{ 0x100a5, 0x5 },
+	{ 0x100a6, 0x6 },
+	{ 0x100a7, 0x7 },
 	{ 0x110a0, 0x0 },
 	{ 0x110a1, 0x1 },
-	{ 0x110a2, 0x2 },
-	{ 0x110a3, 0x3 },
-	{ 0x110a4, 0x4 },
-	{ 0x110a5, 0x5 },
-	{ 0x110a6, 0x6 },
-	{ 0x110a7, 0x7 },
+	{ 0x110a2, 0x3 },
+	{ 0x110a3, 0x4 },
+	{ 0x110a4, 0x5 },
+	{ 0x110a5, 0x2 },
+	{ 0x110a6, 0x7 },
+	{ 0x110a7, 0x6 },
 	{ 0x120a0, 0x0 },
 	{ 0x120a1, 0x1 },
-	{ 0x120a2, 0x2 },
-	{ 0x120a3, 0x3 },
-	{ 0x120a4, 0x4 },
-	{ 0x120a5, 0x5 },
-	{ 0x120a6, 0x6 },
-	{ 0x120a7, 0x7 },
+	{ 0x120a2, 0x3 },
+	{ 0x120a3, 0x2 },
+	{ 0x120a4, 0x5 },
+	{ 0x120a5, 0x4 },
+	{ 0x120a6, 0x7 },
+	{ 0x120a7, 0x6 },
 	{ 0x130a0, 0x0 },
 	{ 0x130a1, 0x1 },
-	{ 0x130a2, 0x3 },
-	{ 0x130a3, 0x4 },
-	{ 0x130a4, 0x5 },
-	{ 0x130a5, 0x2 },
-	{ 0x130a6, 0x7 },
-	{ 0x130a7, 0x6 },
+	{ 0x130a2, 0x2 },
+	{ 0x130a3, 0x3 },
+	{ 0x130a4, 0x4 },
+	{ 0x130a5, 0x5 },
+	{ 0x130a6, 0x6 },
+	{ 0x130a7, 0x7 },
 	{ 0x1005f, 0x1ff },
 	{ 0x1015f, 0x1ff },
 	{ 0x1105f, 0x1ff },
@@ -1856,7 +1856,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa3080020 },
-	{ 0x3d400020, 0x1203 },
+	{ 0x3d400020, 0x1223 },
 	{ 0x3d400024, 0x16e3600 },
 	{ 0x3d400064, 0x5b00d2 },
 	{ 0x3d400070, 0x7027f90 },
@@ -1873,7 +1873,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d400110, 0xe04080e },
 	{ 0x3d400114, 0x2040c0c },
 	{ 0x3d400118, 0x1010007 },
-	{ 0x3d40011c, 0x401 },
+	{ 0x3d40011c, 0x402 },
 	{ 0x3d400130, 0x20600 },
 	{ 0x3d400134, 0xc100002 },
 	{ 0x3d400138, 0xd8 },
@@ -1890,9 +1890,10 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d4001b0, 0x11 },
 	{ 0x3d4001c0, 0x1 },
 	{ 0x3d4001c4, 0x1 },
-	{ 0x3d4000f4, 0xc99 },
+	{ 0x3d4000f4, 0x699 },
 	{ 0x3d400108, 0x70e1617 },
 	{ 0x3d400200, 0x17 },
+	{ 0x3d400208, 0x0 },
 	{ 0x3d40020c, 0x0 },
 	{ 0x3d400210, 0x1f1f },
 	{ 0x3d400204, 0x80808 },
@@ -1911,7 +1912,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d400498, 0x620096 },
 	{ 0x3d40049c, 0x1100e07 },
 	{ 0x3d4004a0, 0xc8012c },
-	{ 0x3d402020, 0x1001 },
+	{ 0x3d402020, 0x1021 },
 	{ 0x3d402024, 0x30d400 },
 	{ 0x3d402050, 0x20d000 },
 	{ 0x3d402064, 0xc001c },
@@ -1926,7 +1927,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d402110, 0x2040202 },
 	{ 0x3d402114, 0x2030202 },
 	{ 0x3d402118, 0x1010004 },
-	{ 0x3d40211c, 0x301 },
+	{ 0x3d40211c, 0x302 },
 	{ 0x3d402130, 0x20300 },
 	{ 0x3d402134, 0xa100002 },
 	{ 0x3d402138, 0x1d },
@@ -1935,8 +1936,8 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d402190, 0x3818200 },
 	{ 0x3d402194, 0x80303 },
 	{ 0x3d4021b4, 0x100 },
-	{ 0x3d4020f4, 0xc99 },
-	{ 0x3d403020, 0x1001 },
+	{ 0x3d4020f4, 0x599 },
+	{ 0x3d403020, 0x1021 },
 	{ 0x3d403024, 0xc3500 },
 	{ 0x3d403050, 0x20d000 },
 	{ 0x3d403064, 0x30007 },
@@ -1951,7 +1952,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d403110, 0x2040202 },
 	{ 0x3d403114, 0x2030202 },
 	{ 0x3d403118, 0x1010004 },
-	{ 0x3d40311c, 0x301 },
+	{ 0x3d40311c, 0x302 },
 	{ 0x3d403130, 0x20300 },
 	{ 0x3d403134, 0xa100002 },
 	{ 0x3d403138, 0x8 },
@@ -1960,7 +1961,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 	{ 0x3d403190, 0x3818200 },
 	{ 0x3d403194, 0x80303 },
 	{ 0x3d4031b4, 0x100 },
-	{ 0x3d4030f4, 0xc99 },
+	{ 0x3d4030f4, 0x599 },
 	{ 0x3d400028, 0x0 },
 };
 
@@ -1968,36 +1969,36 @@ static struct dram_cfg_param ddr_ddrc_cfg_4gb_dual_die[] = {
 static struct dram_cfg_param ddr_ddrphy_cfg_4gb_dual_die[] = {
 	{ 0x100a0, 0x0 },
 	{ 0x100a1, 0x1 },
-	{ 0x100a2, 0x3 },
-	{ 0x100a3, 0x2 },
-	{ 0x100a4, 0x5 },
-	{ 0x100a5, 0x4 },
-	{ 0x100a6, 0x7 },
-	{ 0x100a7, 0x6 },
+	{ 0x100a2, 0x2 },
+	{ 0x100a3, 0x3 },
+	{ 0x100a4, 0x4 },
+	{ 0x100a5, 0x5 },
+	{ 0x100a6, 0x6 },
+	{ 0x100a7, 0x7 },
 	{ 0x110a0, 0x0 },
 	{ 0x110a1, 0x1 },
-	{ 0x110a2, 0x2 },
-	{ 0x110a3, 0x3 },
-	{ 0x110a4, 0x4 },
-	{ 0x110a5, 0x5 },
-	{ 0x110a6, 0x6 },
-	{ 0x110a7, 0x7 },
+	{ 0x110a2, 0x3 },
+	{ 0x110a3, 0x4 },
+	{ 0x110a4, 0x5 },
+	{ 0x110a5, 0x2 },
+	{ 0x110a6, 0x7 },
+	{ 0x110a7, 0x6 },
 	{ 0x120a0, 0x0 },
 	{ 0x120a1, 0x1 },
-	{ 0x120a2, 0x2 },
-	{ 0x120a3, 0x3 },
-	{ 0x120a4, 0x4 },
-	{ 0x120a5, 0x5 },
-	{ 0x120a6, 0x6 },
-	{ 0x120a7, 0x7 },
+	{ 0x120a2, 0x3 },
+	{ 0x120a3, 0x2 },
+	{ 0x120a4, 0x5 },
+	{ 0x120a5, 0x4 },
+	{ 0x120a6, 0x7 },
+	{ 0x120a7, 0x6 },
 	{ 0x130a0, 0x0 },
 	{ 0x130a1, 0x1 },
-	{ 0x130a2, 0x3 },
-	{ 0x130a3, 0x4 },
-	{ 0x130a4, 0x5 },
-	{ 0x130a5, 0x2 },
-	{ 0x130a6, 0x7 },
-	{ 0x130a7, 0x6 },
+	{ 0x130a2, 0x2 },
+	{ 0x130a3, 0x3 },
+	{ 0x130a4, 0x4 },
+	{ 0x130a5, 0x5 },
+	{ 0x130a6, 0x6 },
+	{ 0x130a7, 0x7 },
 	{ 0x1005f, 0x1ff },
 	{ 0x1015f, 0x1ff },
 	{ 0x1105f, 0x1ff },
-- 
2.25.1

