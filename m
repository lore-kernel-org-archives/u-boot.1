Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C425C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB52833C8;
	Fri, 23 May 2025 19:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E6F8337A; Fri, 23 May 2025 19:20:32 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B44C83303
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4I-0076pt-Sx;
 Fri, 23 May 2025 17:20:27 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 03/13] board: venice: move soc-specific dram config into
 soc-specific files
Date: Fri, 23 May 2025 10:20:08 -0700
Message-Id: <20250523172018.4164647-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
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

Move the determination of the dram timings into the soc-specific files.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/lpddr4_timing.h        | 14 +--
 board/gateworks/venice/lpddr4_timing_imx8mm.c | 57 ++++++++----
 board/gateworks/venice/lpddr4_timing_imx8mn.c | 31 ++++++-
 board/gateworks/venice/lpddr4_timing_imx8mp.c | 23 ++++-
 board/gateworks/venice/spl.c                  | 86 ++++---------------
 5 files changed, 108 insertions(+), 103 deletions(-)

diff --git a/board/gateworks/venice/lpddr4_timing.h b/board/gateworks/venice/lpddr4_timing.h
index d19902f10ec3..21997f6fb2a1 100644
--- a/board/gateworks/venice/lpddr4_timing.h
+++ b/board/gateworks/venice/lpddr4_timing.h
@@ -6,18 +6,6 @@
 #ifndef __LPDDR4_TIMING_H__
 #define __LPDDR4_TIMING_H__
 
-#ifdef CONFIG_IMX8MM
-extern struct dram_timing_info dram_timing_512mb;
-extern struct dram_timing_info dram_timing_1gb;
-extern struct dram_timing_info dram_timing_2gb;
-extern struct dram_timing_info dram_timing_4gb;
-#elif CONFIG_IMX8MN
-extern struct dram_timing_info dram_timing_1gb_single_die;
-extern struct dram_timing_info dram_timing_2gb_single_die;
-extern struct dram_timing_info dram_timing_2gb_dual_die;
-#elif CONFIG_IMX8MP
-extern struct dram_timing_info dram_timing_1gb_single_die;
-extern struct dram_timing_info dram_timing_4gb_dual_die;
-#endif
+extern struct dram_timing_info *spl_dram_init(const char *model, int sizemb);
 
 #endif /* __LPDDR4_TIMING_H__ */
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gateworks/venice/lpddr4_timing_imx8mm.c
index 3f2c090a94fc..39e4e46490fd 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
@@ -1830,7 +1830,7 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_512mb[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_512mb = {
+static struct dram_timing_info dram_timing_512mb = {
 	.ddrc_cfg = ddr_ddrc_cfg_512mb,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_512mb),
 	.ddrphy_cfg = ddr_ddrphy_cfg_512mb,
@@ -2489,7 +2489,7 @@ static struct dram_fsp_msg lpddr4_dram_fsp_msg_1gb[] = {
 };
 
 /* lpddr4 timing config params */
-struct dram_timing_info dram_timing_1gb = {
+static struct dram_timing_info dram_timing_1gb = {
 	.ddrc_cfg = lpddr4_ddrc_cfg_1gb,
 	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg_1gb),
 	.ddrphy_cfg = lpddr4_ddrphy_cfg_1gb,
@@ -3005,7 +3005,7 @@ static struct dram_fsp_msg lpddr4_dram_fsp_msg_4gb[] = {
 };
 
 /* lpddr4 timing config params */
-struct dram_timing_info dram_timing_4gb = {
+static struct dram_timing_info dram_timing_4gb = {
 	.ddrc_cfg = lpddr4_ddrc_cfg_4gb,
 	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg_4gb),
 	.ddrphy_cfg = lpddr4_ddrphy_cfg_4gb,
@@ -3140,12 +3140,12 @@ static struct dram_cfg_param lpddr4_ddrphy_cfg_2gb[] = {
 	{ 0x100a7, 0x7 },
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
 	{ 0x120a2, 0x3 },
@@ -3156,12 +3156,12 @@ static struct dram_cfg_param lpddr4_ddrphy_cfg_2gb[] = {
 	{ 0x120a7, 0x6 },
 	{ 0x130a0, 0x0 },
 	{ 0x130a1, 0x1 },
-	{ 0x130a2, 0x5 },
-	{ 0x130a3, 0x2 },
-	{ 0x130a4, 0x3 },
-	{ 0x130a5, 0x4 },
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
@@ -3521,7 +3521,7 @@ static struct dram_fsp_msg lpddr4_dram_fsp_msg_2gb[] = {
 };
 
 /* lpddr4 timing config params */
-struct dram_timing_info dram_timing_2gb = {
+static struct dram_timing_info dram_timing_2gb = {
 	.ddrc_cfg = lpddr4_ddrc_cfg_2gb,
 	.ddrc_cfg_num = ARRAY_SIZE(lpddr4_ddrc_cfg_2gb),
 	.ddrphy_cfg = lpddr4_ddrphy_cfg_2gb,
@@ -3534,3 +3534,28 @@ struct dram_timing_info dram_timing_2gb = {
 	.ddrphy_pie_num = ARRAY_SIZE(lpddr4_phy_pie),
 	.fsp_table = { 3000, 400, 100, },
 };
+
+struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+{
+	struct dram_timing_info *dram_timing;
+
+	switch (sizemb) {
+	case 512:
+		dram_timing = &dram_timing_512mb;
+		break;
+	case 1024:
+		dram_timing = &dram_timing_1gb;
+		break;
+	case 2048:
+		dram_timing = &dram_timing_2gb;
+		break;
+	case 4096:
+		dram_timing = &dram_timing_4gb;
+		break;
+	default:
+		printf("unsupported");
+		dram_timing = &dram_timing_1gb;
+	}
+
+	return dram_timing;
+}
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mn.c b/board/gateworks/venice/lpddr4_timing_imx8mn.c
index 9ba2d2571ce5..e7d04822c9cf 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mn.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mn.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
+#include <string.h>
 #include <asm/arch/ddr.h>
 
 /*
@@ -1425,7 +1426,7 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_1gb_single_die[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_1gb_single_die = {
+static struct dram_timing_info dram_timing_1gb_single_die = {
 	.ddrc_cfg = ddr_ddrc_cfg_1gb_single_die,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_1gb_single_die),
 	.ddrphy_cfg = ddr_ddrphy_cfg_1gb_single_die,
@@ -1890,7 +1891,7 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_2gb_single_die[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_2gb_single_die = {
+static struct dram_timing_info dram_timing_2gb_single_die = {
 	.ddrc_cfg = ddr_ddrc_cfg_2gb_single_die,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_2gb_single_die),
 	.ddrphy_cfg = ddr_ddrphy_cfg_2gb_single_die,
@@ -2354,7 +2355,7 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_2gb_dual_die[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_2gb_dual_die = {
+static struct dram_timing_info dram_timing_2gb_dual_die = {
 	.ddrc_cfg = ddr_ddrc_cfg_2gb_dual_die,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_2gb_dual_die),
 	.ddrphy_cfg = ddr_ddrphy_cfg_2gb_dual_die,
@@ -2367,3 +2368,27 @@ struct dram_timing_info dram_timing_2gb_dual_die = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 3200, 400, 100, },
 };
+
+struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+{
+	struct dram_timing_info *dram_timing;
+
+	switch (sizemb) {
+	case 1024:
+		dram_timing = &dram_timing_1gb_single_die;
+		break;
+	case 2048:
+		if (!strcmp(model, "GW7902-SP466-A") ||
+		    !strcmp(model, "GW7902-SP466-B")) {
+			dram_timing = &dram_timing_2gb_dual_die;
+		} else {
+			dram_timing = &dram_timing_2gb_single_die;
+		}
+		break;
+	default:
+		printf("unsupported");
+		dram_timing = &dram_timing_2gb_dual_die;
+	}
+
+	return dram_timing;
+}
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mp.c b/board/gateworks/venice/lpddr4_timing_imx8mp.c
index 56c6e2b5cff7..36c4cb147e82 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mp.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mp.c
@@ -1832,7 +1832,7 @@ struct dram_fsp_msg ddr_dram_fsp_msg_1gb_single_die[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_1gb_single_die = {
+static struct dram_timing_info dram_timing_1gb_single_die = {
 	.ddrc_cfg = ddr_ddrc_cfg_1gb_single_die,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_1gb_single_die),
 	.ddrphy_cfg = ddr_ddrphy_cfg_1gb_single_die,
@@ -2364,7 +2364,7 @@ static struct dram_fsp_msg ddr_dram_fsp_msg_4gb_dual_die[] = {
 };
 
 /* ddr timing config params */
-struct dram_timing_info dram_timing_4gb_dual_die = {
+static struct dram_timing_info dram_timing_4gb_dual_die = {
 	.ddrc_cfg = ddr_ddrc_cfg_4gb_dual_die,
 	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg_4gb_dual_die),
 	.ddrphy_cfg = ddr_ddrphy_cfg_4gb_dual_die,
@@ -2377,3 +2377,22 @@ struct dram_timing_info dram_timing_4gb_dual_die = {
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
 	.fsp_table = { 4000, 400, 100, },
 };
+
+struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+{
+	struct dram_timing_info *dram_timing;
+
+	switch (sizemb) {
+	case 1024:
+		dram_timing = &dram_timing_1gb_single_die;
+		break;
+	case 4096:
+		dram_timing = &dram_timing_4gb_dual_die;
+		break;
+	default:
+		printf("unsupported");
+		dram_timing = &dram_timing_4gb_dual_die;
+	}
+
+	return dram_timing;
+}
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index bcdc1a2a4685..275f9d3453ea 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -32,69 +32,6 @@
 
 #define PCIE_RSTN IMX_GPIO_NR(4, 6)
 
-static void spl_dram_init(int size)
-{
-	struct dram_timing_info *dram_timing;
-
-	switch (size) {
-#ifdef CONFIG_IMX8MM
-	case 512:
-		dram_timing = &dram_timing_512mb;
-		break;
-	case 1024:
-		dram_timing = &dram_timing_1gb;
-		break;
-	case 2048:
-		dram_timing = &dram_timing_2gb;
-		break;
-	case 4096:
-		dram_timing = &dram_timing_4gb;
-		break;
-	default:
-		printf("Unknown DDR configuration: %d MiB\n", size);
-		dram_timing = &dram_timing_1gb;
-		size = 1024;
-#elif CONFIG_IMX8MN
-	case 1024:
-		dram_timing = &dram_timing_1gb_single_die;
-		break;
-	case 2048:
-		if (!strcmp(eeprom_get_model(), "GW7902-SP466-A") ||
-		    !strcmp(eeprom_get_model(), "GW7902-SP466-B")) {
-			dram_timing = &dram_timing_2gb_dual_die;
-		} else {
-			dram_timing = &dram_timing_2gb_single_die;
-		}
-		break;
-	default:
-		printf("Unknown DDR configuration: %d MiB\n", size);
-		dram_timing = &dram_timing_2gb_dual_die;
-		size = 2048;
-#elif CONFIG_IMX8MP
-	case 1024:
-		dram_timing = &dram_timing_1gb_single_die;
-		break;
-	case 4096:
-		dram_timing = &dram_timing_4gb_dual_die;
-		break;
-	default:
-		printf("Unknown DDR configuration: %d GiB\n", size);
-		dram_timing = &dram_timing_4gb_dual_die;
-		size = 4096;
-#endif
-	}
-
-	printf("DRAM    : LPDDR4 ");
-	if (size > 512)
-		printf("%d GiB", size / 1024);
-	else
-		printf("%d MiB", size);
-	printf(" %dMT/s %dMHz\n",
-	       dram_timing->fsp_msg[0].drate,
-	       dram_timing->fsp_msg[0].drate / 2);
-	ddr_init(dram_timing);
-}
-
 /*
  * Model specific PMIC adjustments necessary prior to DRAM init
  *
@@ -118,9 +55,8 @@ static int dm_i2c_clrsetbits(struct udevice *dev, uint reg, uint clr, uint set)
 	return dm_i2c_write(dev, reg, &val, 1);
 }
 
-static int power_init_board(struct udevice *gsc)
+static int power_init_board(const char *model, struct udevice *gsc)
 {
-	const char *model = eeprom_get_model();
 	struct udevice *bus;
 	struct udevice *dev;
 	int ret;
@@ -251,9 +187,11 @@ static int power_init_board(struct udevice *gsc)
 
 void board_init_f(ulong dummy)
 {
+	struct dram_timing_info *dram_timing;
 	struct udevice *bus, *dev;
+	const char *model;
+	int dram_szmb;
 	int i, ret;
-	int dram_sz;
 
 	arch_cpu_init();
 
@@ -311,13 +249,23 @@ void board_init_f(ulong dummy)
 			break;
 		mdelay(1);
 	}
-	dram_sz = venice_eeprom_init(0);
+	dram_szmb = venice_eeprom_init(0);
+	model = eeprom_get_model();
 
 	/* PMIC */
-	power_init_board(dev);
+	power_init_board(model, dev);
 
 	/* DDR initialization */
-	spl_dram_init(dram_sz);
+	printf("DRAM    : LPDDR4 ");
+	if (dram_szmb > 512)
+		printf("%d GiB", dram_szmb / 1024);
+	else
+		printf("%d MiB", dram_szmb);
+	dram_timing = spl_dram_init(model, dram_szmb);
+	printf(" %dMT/s %dMHz\n",
+	       dram_timing->fsp_msg[0].drate,
+	       dram_timing->fsp_msg[0].drate / 2);
+	ddr_init(dram_timing);
 
 	board_init_r(NULL, 0);
 }
-- 
2.25.1

