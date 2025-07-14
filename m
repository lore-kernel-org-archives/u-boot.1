Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BE5C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485E683106;
	Mon, 14 Jul 2025 19:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E82830B3; Mon, 14 Jul 2025 19:23:12 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B168309C
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ubMtO-008k39-Ca;
 Mon, 14 Jul 2025 17:23:06 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 2/4] venice: lpddr4_timing_imx8mm: add 4gb single die
 support
Date: Mon, 14 Jul 2025 10:23:02 -0700
Message-Id: <20250714172304.4095241-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250714172304.4095241-1-tharvey@gateworks.com>
References: <20250714172304.4095241-1-tharvey@gateworks.com>
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

Add dram support for the MT53E1G32D2FW-046 RevC part which is a single die
32Gbit density part vs RevA/B which were dual-die parts:
 - use a previously unused EEPROM byte to denote a variant of the
   base config to be patched
 - add a dram description string
 - return the board struct from eeprom_init and pass it to the
   spl_dram_init function so that it has access to the EEPROM
 - move ddr_init into the spl_dram_init so that it can be patched
   in the per-soc init function

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 board/gateworks/venice/eeprom.c               |  6 +--
 board/gateworks/venice/eeprom.h               |  5 +-
 board/gateworks/venice/lpddr4_timing.h        |  3 +-
 board/gateworks/venice/lpddr4_timing_imx8mm.c | 49 ++++++++++++++++++-
 board/gateworks/venice/lpddr4_timing_imx8mn.c | 14 +++++-
 board/gateworks/venice/lpddr4_timing_imx8mp.c | 13 ++++-
 board/gateworks/venice/spl.c                  | 33 ++++++++-----
 7 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index d9a871934340..88bbc2e1af8c 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -356,7 +356,7 @@ static int eeprom_info(bool verbose)
 	return 0;
 }
 
-int venice_eeprom_init(int quiet)
+struct venice_board_info *venice_eeprom_init(int quiet)
 {
 	char rev_pcb;
 	int rev_bom;
@@ -466,10 +466,10 @@ int venice_eeprom_init(int quiet)
 
 	if (!strncmp(venice_model, "GW7901-SP486", 12) &&
 	    strcmp(venice_model, "GW7901-SP486-C")) {
-		return 2048;
+		som_info.sdram_size++;
 	}
 
-	return (16 << som_info.sdram_size);
+	return &som_info;
 }
 
 void board_gsc_info(void)
diff --git a/board/gateworks/venice/eeprom.h b/board/gateworks/venice/eeprom.h
index a0f449299aa3..817277f62767 100644
--- a/board/gateworks/venice/eeprom.h
+++ b/board/gateworks/venice/eeprom.h
@@ -18,13 +18,14 @@ struct venice_board_info {
 	u8 sdram_size;	/* 0x2B: (16 << n) MB */
 	u8 sdram_speed;	/* 0x2C: (33.333 * n) MHz */
 	u8 sdram_width;	/* 0x2D: (8 << n) bit */
-	u8 res3[2];	/* 0x2E */
+	u8 sdram_variant; /* 0x2E */
+	u8 res3[1];	/* 0x2D */
 	char model[16];		/* 0x30: model string */
 	u8 config[14];	/* 0x40: model config */
 	u8 chksum[2];	/* 0x4E */
 };
 
-int venice_eeprom_init(int quiet);
+struct venice_board_info *venice_eeprom_init(int quiet);
 const char *eeprom_get_model(void);
 const char *eeprom_get_som_model(void);
 const char *eeprom_get_baseboard_model(void);
diff --git a/board/gateworks/venice/lpddr4_timing.h b/board/gateworks/venice/lpddr4_timing.h
index 21997f6fb2a1..e4aa8b6821c7 100644
--- a/board/gateworks/venice/lpddr4_timing.h
+++ b/board/gateworks/venice/lpddr4_timing.h
@@ -6,6 +6,7 @@
 #ifndef __LPDDR4_TIMING_H__
 #define __LPDDR4_TIMING_H__
 
-extern struct dram_timing_info *spl_dram_init(const char *model, int sizemb);
+struct dram_timing_info *spl_dram_init(const char *model, struct venice_board_info *info,
+				       char *dram_desc, size_t sz_desc);
 
 #endif /* __LPDDR4_TIMING_H__ */
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gateworks/venice/lpddr4_timing_imx8mm.c
index 485649ab4f40..a6025322e78d 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
@@ -10,6 +10,8 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
+#include "eeprom.h"
+
 /* ddr phy trained csr */
 static struct dram_cfg_param lpddr4_ddrphy_trained_csr[] = {
 	{ 0x200b2, 0x0 },
@@ -3561,9 +3563,36 @@ static struct dram_cfg_param ddr_ddrphy_cfg_alt_patch[] = {
 	{ 0x120a5, 0x2 },
 };
 
-struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+/* 4GB single Die patch (MT53E1G32D2FW-046 revC) */
+static struct dram_cfg_param ddr_ddrc_cfg_4gb_single_die_patch[] = {
+	{ 0x3d400000, 0xa1080020 },
+	{ 0x3d400064, 0x5b011d },
+	{ 0x3d40011c, 0x402 },
+	{ 0x3d400138, 0x123 },
+	{ 0x3d4000f4, 0x699 },
+	{ 0x3d400200, 0x1f },
+	{ 0x3d40021c, 0xf07 },
+	{ 0x3d402064, 0xc0026 },
+	{ 0x3d40211c, 0x302 },
+	{ 0x3d402138, 0x27 },
+	{ 0x3d4020f4, 0x599 },
+	{ 0x3d403064, 0x3000a },
+	{ 0x3d40311c, 0x302 },
+	{ 0x3d403138, 0xa },
+	{ 0x3d4030f4, 0x599 }
+};
+
+static struct dram_cfg_param fsp_msg_4gb_single_die_patch[] = {
+	{ 0x00054012, 0x110 },
+	{ 0x0005402c, 0x1 },
+};
+
+struct dram_timing_info *spl_dram_init(const char *model, struct venice_board_info *info,
+				       char *dram_desc, size_t sz_desc)
 {
 	struct dram_timing_info *dram_timing;
+	int sizemb = (16 << info->sdram_size);
+	int i;
 
 	switch (sizemb) {
 	case 512:
@@ -3577,6 +3606,21 @@ struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
 		break;
 	case 4096:
 		dram_timing = &dram_timing_4gb;
+		if (info->sdram_variant == 1) {
+			if (dram_desc)
+				strlcpy(dram_desc, "single-die", sz_desc);
+			apply_cfg_patch(dram_timing->ddrc_cfg, dram_timing->ddrc_cfg_num,
+					ddr_ddrc_cfg_4gb_single_die_patch,
+					ARRAY_SIZE(ddr_ddrc_cfg_4gb_single_die_patch));
+			for (i = 0; i < 4; i++) {
+				apply_cfg_patch(dram_timing->fsp_msg[i].fsp_cfg,
+						dram_timing->fsp_msg[i].fsp_cfg_num,
+						fsp_msg_4gb_single_die_patch,
+						ARRAY_SIZE(fsp_msg_4gb_single_die_patch));
+			}
+		} else if (dram_desc) {
+			strlcpy(dram_desc, "dual-die", sz_desc);
+		}
 		break;
 	default:
 		printf("unsupported");
@@ -3596,5 +3640,8 @@ struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
 				ARRAY_SIZE(ddr_ddrphy_cfg_alt_patch));
 	}
 
+	if (ddr_init(dram_timing))
+		return NULL;
+
 	return dram_timing;
 }
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mn.c b/board/gateworks/venice/lpddr4_timing_imx8mn.c
index e7d04822c9cf..cad4fc0d31ce 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mn.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mn.c
@@ -4,6 +4,8 @@
 #include <string.h>
 #include <asm/arch/ddr.h>
 
+#include "eeprom.h"
+
 /*
  * Generated code from MX8M_DDR_tool v3.20 using RPAv15
  */
@@ -2369,26 +2371,36 @@ static struct dram_timing_info dram_timing_2gb_dual_die = {
 	.fsp_table = { 3200, 400, 100, },
 };
 
-struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+struct dram_timing_info *spl_dram_init(const char *model, struct venice_board_info *info,
+				       char *dram_desc, size_t sz_desc)
 {
 	struct dram_timing_info *dram_timing;
+	int sizemb = (16 << info->sdram_size);
 
 	switch (sizemb) {
 	case 1024:
 		dram_timing = &dram_timing_1gb_single_die;
+		if (dram_desc)
+			strlcpy(dram_desc, "single-die", sz_desc);
 		break;
 	case 2048:
 		if (!strcmp(model, "GW7902-SP466-A") ||
 		    !strcmp(model, "GW7902-SP466-B")) {
 			dram_timing = &dram_timing_2gb_dual_die;
+			if (dram_desc)
+				strlcpy(dram_desc, "dual-die", sz_desc);
 		} else {
 			dram_timing = &dram_timing_2gb_single_die;
+			if (dram_desc)
+				strlcpy(dram_desc, "single-die", sz_desc);
 		}
 		break;
 	default:
 		printf("unsupported");
 		dram_timing = &dram_timing_2gb_dual_die;
 	}
+	if (ddr_init(dram_timing))
+		return NULL;
 
 	return dram_timing;
 }
diff --git a/board/gateworks/venice/lpddr4_timing_imx8mp.c b/board/gateworks/venice/lpddr4_timing_imx8mp.c
index 36c4cb147e82..f2d5d9ce5659 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mp.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mp.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
+#include <string.h>
 #include <asm/arch/ddr.h>
 
+#include "eeprom.h"
+
 /*
  * Generated code from MX8M_DDR_tool v3.30 using MX8M_Plus RPAv7
  */
@@ -2378,21 +2381,29 @@ static struct dram_timing_info dram_timing_4gb_dual_die = {
 	.fsp_table = { 4000, 400, 100, },
 };
 
-struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
+struct dram_timing_info *spl_dram_init(const char *model, struct venice_board_info *info,
+				       char *dram_desc, size_t sz_desc)
 {
 	struct dram_timing_info *dram_timing;
+	int sizemb = (16 << info->sdram_size);
 
 	switch (sizemb) {
 	case 1024:
 		dram_timing = &dram_timing_1gb_single_die;
+		if (dram_desc)
+			strlcpy(dram_desc, "single-die", sz_desc);
 		break;
 	case 4096:
 		dram_timing = &dram_timing_4gb_dual_die;
+		if (dram_desc)
+			strlcpy(dram_desc, "dual-die", sz_desc);
 		break;
 	default:
 		printf("unsupported");
 		dram_timing = &dram_timing_4gb_dual_die;
 	}
+	if (ddr_init(dram_timing))
+		return NULL;
 
 	return dram_timing;
 }
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index e813f3e763ec..d9bc593fa0d5 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -188,9 +188,10 @@ static int power_init_board(const char *model, struct udevice *gsc)
 void board_init_f(ulong dummy)
 {
 	struct dram_timing_info *dram_timing;
+	struct venice_board_info *eeprom;
 	struct udevice *bus, *dev;
 	const char *model;
-	int dram_szmb;
+	char dram_desc[32];
 	int i, ret;
 
 	arch_cpu_init();
@@ -249,23 +250,31 @@ void board_init_f(ulong dummy)
 			break;
 		mdelay(1);
 	}
-	dram_szmb = venice_eeprom_init(0);
+	eeprom = venice_eeprom_init(0);
 	model = eeprom_get_model();
 
 	/* PMIC */
 	power_init_board(model, dev);
 
 	/* DDR initialization */
-	printf("DRAM    : LPDDR4 ");
-	if (dram_szmb > 512)
-		printf("%d GiB", dram_szmb / 1024);
-	else
-		printf("%d MiB", dram_szmb);
-	dram_timing = spl_dram_init(model, dram_szmb);
-	printf(" %dMT/s %dMHz\n",
-	       dram_timing->fsp_msg[0].drate,
-	       dram_timing->fsp_msg[0].drate / 2);
-	ddr_init(dram_timing);
+	dram_desc[0] = 0;
+	dram_timing = spl_dram_init(model, eeprom, dram_desc, sizeof(dram_desc));
+	if (dram_timing) {
+		int dram_szmb = (16 << eeprom->sdram_size);
+
+		printf("DRAM    : LPDDR4 ");
+		if (dram_szmb > 512)
+			printf("%d GiB", dram_szmb / 1024);
+		else
+			printf("%d MiB", dram_szmb);
+		printf(" %dMT/s %dMHz %s",
+		       dram_timing->fsp_msg[0].drate,
+		       dram_timing->fsp_msg[0].drate / 2,
+		       dram_desc[0] ? dram_desc : "");
+		puts("\n");
+	} else {
+		hang();
+	}
 
 	board_init_r(NULL, 0);
 }
-- 
2.25.1

