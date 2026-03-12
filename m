Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC8FED2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386F7841E3;
	Thu, 12 Mar 2026 10:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mlJfQAV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533D283F53; Thu, 12 Mar 2026 10:57:43 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F868419E
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9xIGymEvWXB4Anchps0PmwLYzn3JX3g37vpfuLXNaM0=; b=mlJfQAV+RgZaI4a6xGm6fivRv1
 6ZuzCQymtmxO1xye3ex8sTOv0zW8BGjtFdodNqLwqTobI0Oe/yjaWhokwCqr6YmjSMKGEYHBPWgeB
 7IrZUv0PsovKoQGxsyrMD0rwPZSfqQAZR/hjPxoju4pqyGhSetYW+oUS3VT9hIhs5uL12VTnUECJJ
 n+mPK5oWGQauiGehVeZRRpnzXLpoLw51DlFqTIxChY/RoRnS+z5EcY1f5fiJbBY/YIi7yB1cc/B59
 64iPP5PD05FfITH5vULtD5z81mcDnlKAsOAcSFO4MZZgw1DyDMFJGELgGILO2QB3MDt7T8yNzwlS9
 Z75MaWlA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-0007zY-1d; Thu, 12 Mar 2026 10:57:38 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-000Fyo-0U; Thu, 12 Mar 2026 10:57:38 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Gerber <Paul.Gerber@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 09/13] board: tqma6: use common TQ baseboard
Date: Thu, 12 Mar 2026 10:57:05 +0100
Message-ID: <20260312095711.3219756-10-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

From: Paul Gerber <Paul.Gerber@ew.tq-group.com>

update functions to match common baseboard header
include TQ common Kconfig and
select TQ_BB option for MBa6 and WRU4

While at it, remove empty implementations that are now covered by
board/tq/common.

Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig      |  4 ++++
 board/tq/tqma6/tqma6.c      | 17 +++++++++--------
 board/tq/tqma6/tqma6_bb.h   | 28 ----------------------------
 board/tq/tqma6/tqma6_mba6.c | 26 +++-----------------------
 board/tq/tqma6/tqma6_wru4.c | 29 +++++++----------------------
 5 files changed, 23 insertions(+), 81 deletions(-)
 delete mode 100644 board/tq/tqma6/tqma6_bb.h

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 9cb0c909aa9..1ef9f6732aa 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -72,6 +72,7 @@ choice
 
 config MBA6
 	bool "TQMa6 on MBa6 Starterkit"
+	select TQ_COMMON_BB
 	select USB
 	select CMD_USB
 	select USB_STORAGE
@@ -92,6 +93,7 @@ config MBA6
 
 config WRU4
 	bool "OHB WRU-IV"
+	select TQ_COMMON_BB
 	help
 	  Select the
 	  OHB Systems AG WRU-IV baseboard.
@@ -107,4 +109,6 @@ config IMX_CONFIG
 	default "board/tq/tqma6/tqma6dl.cfg" if TQMA6DL
 	default "board/tq/tqma6/tqma6s.cfg" if TQMA6S
 
+source "board/tq/common/Kconfig"
+
 endif
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 75d36240a1e..a3a0a11c42b 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -26,7 +26,7 @@
 #include <power/pfuze100_pmic.h>
 #include <power/pmic.h>
 
-#include "tqma6_bb.h"
+#include "../common/tq_bb.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,7 +41,7 @@ static const uint16_t tqma6_emmc_dsr = 0x0100;
 
 int board_early_init_f(void)
 {
-	return tqma6_bb_board_early_init_f();
+	return tq_bb_board_early_init_f();
 }
 
 int board_init(void)
@@ -49,7 +49,7 @@ int board_init(void)
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
-	tqma6_bb_board_init();
+	tq_bb_board_init();
 
 	return 0;
 }
@@ -96,11 +96,12 @@ int board_late_init(void)
 {
 	env_set("board_name", tqma6_get_boardname());
 
-	tqma6_bb_board_late_init();
+	tq_bb_board_late_init();
 
 	printf("Board: %s on a %s\n", tqma6_get_boardname(),
-	       tqma6_bb_get_boardname());
-	return 0;
+	       tq_bb_get_boardname());
+
+	return tq_bb_checkboard();
 }
 
 /*
@@ -113,14 +114,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	char modelstr[MODELSTRLEN];
 
 	snprintf(modelstr, MODELSTRLEN, "TQ %s on %s", tqma6_get_boardname(),
-		 tqma6_bb_get_boardname());
+		 tq_bb_get_boardname());
 	do_fixup_by_path_string(blob, "/", "model", modelstr);
 	fdt_fixup_memory(blob, (u64)PHYS_SDRAM, (u64)gd->ram_size);
 	/* bring in eMMC dsr settings */
 	do_fixup_by_path_u32(blob,
 			     "/soc/aips-bus@02100000/usdhc@02198000",
 			     "dsr", tqma6_emmc_dsr, 2);
-	tqma6_bb_ft_board_setup(blob, bd);
+	tq_bb_ft_board_setup(blob, bd);
 
 	return 0;
 }
diff --git a/board/tq/tqma6/tqma6_bb.h b/board/tq/tqma6/tqma6_bb.h
deleted file mode 100644
index e17e6ad3f57..00000000000
--- a/board/tq/tqma6/tqma6_bb.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- */
-
-#ifndef __TQMA6_BB__
-#define __TQMA6_BB__
-
-int tqma6_bb_board_mmc_getwp(struct mmc *mmc);
-int tqma6_bb_board_mmc_getcd(struct mmc *mmc);
-int tqma6_bb_board_mmc_init(struct bd_info *bis);
-
-int tqma6_bb_board_early_init_f(void);
-int tqma6_bb_board_init(void);
-int tqma6_bb_board_late_init(void);
-int tqma6_bb_checkboard(void);
-
-const char *tqma6_bb_get_boardname(void);
-/*
- * Device Tree Support
- */
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT)
-void tqma6_bb_ft_board_setup(void *blob, struct bd_info *bd);
-#endif /* defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT) */
-
-#endif
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 46989102fec..d604d6d4f0a 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -31,7 +31,7 @@
 #include <mmc.h>
 #include <netdev.h>
 
-#include "tqma6_bb.h"
+#include "../common/tq_bb.h"
 
 #if defined(CONFIG_TQMA6Q)
 
@@ -126,34 +126,14 @@ int board_phy_config(struct phy_device *phydev)
 	return 0;
 }
 
-int tqma6_bb_board_early_init_f(void)
-{
-	return 0;
-}
-
-int tqma6_bb_board_init(void)
+int tq_bb_board_init(void)
 {
 	mba6_setup_iomuxc_enet();
 
 	return 0;
 }
 
-int tqma6_bb_board_late_init(void)
-{
-	return 0;
-}
-
-const char *tqma6_bb_get_boardname(void)
+const char *tq_bb_get_boardname(void)
 {
 	return "MBa6x";
 }
-
-/*
- * Device Tree Support
- */
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT)
-void tqma6_bb_ft_board_setup(void *blob, struct bd_info *bd)
-{
- /* TBD */
-}
-#endif /* defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT) */
diff --git a/board/tq/tqma6/tqma6_wru4.c b/board/tq/tqma6/tqma6_wru4.c
index 7acefc7b064..a7dc8fca109 100644
--- a/board/tq/tqma6/tqma6_wru4.c
+++ b/board/tq/tqma6/tqma6_wru4.c
@@ -33,7 +33,7 @@
 #include <mmc.h>
 #include <netdev.h>
 
-#include "tqma6_bb.h"
+#include "../common/tq_bb.h"
 
 /* UART */
 #define UART4_PAD_CTRL (			\
@@ -95,7 +95,7 @@ static struct fsl_esdhc_cfg usdhc2_cfg = {
 	.max_bus_width = 4,
 };
 
-int tqma6_bb_board_mmc_getcd(struct mmc *mmc)
+int tq_bb_board_mmc_getcd(struct mmc *mmc)
 {
 	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
 	int ret = 0;
@@ -106,7 +106,7 @@ int tqma6_bb_board_mmc_getcd(struct mmc *mmc)
 	return ret;
 }
 
-int tqma6_bb_board_mmc_getwp(struct mmc *mmc)
+int tq_bb_board_mmc_getwp(struct mmc *mmc)
 {
 	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
 	int ret = 0;
@@ -117,7 +117,7 @@ int tqma6_bb_board_mmc_getwp(struct mmc *mmc)
 	return ret;
 }
 
-int tqma6_bb_board_mmc_init(struct bd_info *bis)
+int tq_bb_board_mmc_init(struct bd_info *bis)
 {
 	int ret;
 
@@ -256,14 +256,14 @@ static void gpio_init(void)
 		gpio_direction_output(GPIO_UART3_PWRON, 0);
 }
 
-int tqma6_bb_board_early_init_f(void)
+int tq_bb_board_early_init_f(void)
 {
 	setup_iomuxc_uart4();
 
 	return 0;
 }
 
-int tqma6_bb_board_init(void)
+int tq_bb_board_init(void)
 {
 	setup_iomuxc_enet();
 
@@ -279,12 +279,7 @@ int tqma6_bb_board_init(void)
 	return 0;
 }
 
-int tqma6_bb_board_late_init(void)
-{
-	return 0;
-}
-
-const char *tqma6_bb_get_boardname(void)
+const char *tq_bb_get_boardname(void)
 {
 	return "WRU-IV";
 }
@@ -331,13 +326,3 @@ int board_ehci_power(int port, int on)
 
 	return 0;
 }
-
-/*
- * Device Tree Support
- */
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT)
-void tqma6_bb_ft_board_setup(void *blob, struct bd_info *bd)
-{
-	/* TBD */
-}
-#endif /* defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT) */
-- 
2.43.0

