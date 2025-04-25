Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A163AC369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 05:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19132809D4;
	Fri, 25 Apr 2025 07:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gjMjs2Kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B516E81F54; Fri, 25 Apr 2025 07:34:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720C58059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53P5YdV72696236
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 00:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745559279;
 bh=oHumZvfy7VlncGRrFMWqChhygzA6+lA8FJJ4PS17v8Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gjMjs2Khqa5noatovJsNnJNrosML1E7gBjConTz50E5VZ3JuvHBhx9hbTI5q81uN1
 otGjpJZDt9j17xuSlS5lIf4sD+NPZFfuGIky1k71Icygz7jNRyTLKw4GUA+eXHZOUb
 MrfWCm+W29N1/XlpFmBnplvxswKSQ+Qq1JkCVnIE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53P5YdIb020215
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 00:34:39 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 00:34:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 00:34:38 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53P5YWp9048874;
 Fri, 25 Apr 2025 00:34:37 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] board: ti: am57xx: Set fdtfile from C code instead of
 findfdt script
Date: Fri, 25 Apr 2025 11:04:31 +0530
Message-ID: <20250425053431.1622267-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425053431.1622267-1-a-dutta@ti.com>
References: <20250425053431.1622267-1-a-dutta@ti.com>
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

We now can provide a map and have the standard fdtfile variable set from
code itself. This allows for bootstd to "just work".

While at this, replace findfdt in environment with a warning as it is no
longer needed.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 board/ti/am57xx/board.c           | 19 ++++++++++++++++
 include/configs/ti_omap5_common.h | 36 -------------------------------
 2 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index fc0d87daae4..a807c2a5464 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -42,6 +42,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/cape_detect.h"
+#include "../common/fdt_ops.h"
 #include "mux_data.h"
 
 #ifdef CONFIG_SUPPORT_EMMC_BOOT
@@ -577,6 +578,23 @@ void do_board_detect(void)
 			 "Board: %s REV %s\n", bname, board_ti_get_rev());
 }
 
+static struct ti_fdt_map ti_omap_am57_evm_fdt_map[] = {
+	{"omap5_uevm", "ti/omap/omap5-uevm.dtb"},
+	{"dra7xx", "ti/omap/dra7-evm.dtb"},
+	{"dra72x-revc", "ti/omap/dra72-evm-revc.dtb"},
+	{"dra72x", "ti/omap/dra72-evm.dtb"},
+	{"dra71x", "ti/omap/dra71-evm.dtb"},
+	{"dra76x_acd", "ti/omap/dra76-evm.dtb"},
+	{"beagle_x15", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"beagle_x15_revb1", "ti/omap/am57xx-beagle-x15-revb1.dtb"},
+	{"beagle_x15_revc", "ti/omap/am57xx-beagle-x15-revc.dtb"},
+	{"am5729_beagleboneai", "ti/omap/am5729-beagleboneai.dtb"},
+	{"am572x_idk", "ti/omap/am572x-idk.dtb"},
+	{"am574x_idk", "ti/omap/am574x-idk.dtb"},
+	{"am57xx_evm", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"am57xx_evm_reva3", "ti/omap/am57xx-beagle-x15.dtb"},
+	{"am571x_idk", "ti/omap/am571x-idk.dtb"},
+};
 static void setup_board_eeprom_env(void)
 {
 	char *name = "beagle_x15";
@@ -614,6 +632,7 @@ static void setup_board_eeprom_env(void)
 
 invalid_eeprom:
 	set_board_info_env(name);
+	ti_set_fdt_env(name, ti_omap_am57_evm_fdt_map);
 }
 
 #endif	/* CONFIG_XPL_BUILD */
diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 39102f15eb9..a0aaf750788 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -204,41 +204,6 @@
 			"exit; " \
 		"fi;\0"
 
-#define DEFAULT_FDT_TI_ARGS \
-	"findfdt="\
-		"if test $board_name = omap5_uevm; then " \
-			"setenv fdtfile omap5-uevm.dtb; fi; " \
-		"if test $board_name = dra7xx; then " \
-			"setenv fdtfile dra7-evm.dtb; fi;" \
-		"if test $board_name = dra72x-revc; then " \
-			"setenv fdtfile dra72-evm-revc.dtb; fi;" \
-		"if test $board_name = dra72x; then " \
-			"setenv fdtfile dra72-evm.dtb; fi;" \
-		"if test $board_name = dra71x; then " \
-			"setenv fdtfile dra71-evm.dtb; fi;" \
-		"if test $board_name = dra76x_acd; then " \
-			"setenv fdtfile dra76-evm.dtb; fi;" \
-		"if test $board_name = beagle_x15; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = beagle_x15_revb1; then " \
-			"setenv fdtfile am57xx-beagle-x15-revb1.dtb; fi;" \
-		"if test $board_name = beagle_x15_revc; then " \
-			"setenv fdtfile am57xx-beagle-x15-revc.dtb; fi;" \
-		"if test $board_name = am5729_beagleboneai; then " \
-			"setenv fdtfile am5729-beagleboneai.dtb; fi;" \
-		"if test $board_name = am572x_idk; then " \
-			"setenv fdtfile am572x-idk.dtb; fi;" \
-		"if test $board_name = am574x_idk; then " \
-			"setenv fdtfile am574x-idk.dtb; fi;" \
-		"if test $board_name = am57xx_evm; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = am57xx_evm_reva3; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = am571x_idk; then " \
-			"setenv fdtfile am571x-idk.dtb; fi;" \
-		"if test $fdtfile = undefined; then " \
-			"echo WARNING: Could not determine device tree to use; fi; \0"
-
 #define GET_OVERLAY_MMC_TI_ARGS \
 	"get_overlay_mmc=" \
 		"fdt address ${fdtaddr};" \
@@ -278,7 +243,6 @@
 	DEFAULT_FIT_TI_ARGS \
 	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
 	DEFAULT_COMMON_BOOT_TI_ARGS \
-	DEFAULT_FDT_TI_ARGS \
 	GET_OVERLAY_MMC_TI_ARGS \
 	DFUARGS \
 	NETARGS \
-- 
2.34.1

