Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD046C61D96
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432CC875F4;
	Tue, 21 Nov 2023 15:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="DBo0eLcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA9C871CD; Tue, 21 Nov 2023 15:21:49 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D893875F2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20231121142146ef204caefd96f10e5e for <u-boot@lists.denx.de>;
 Tue, 21 Nov 2023 15:21:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t1xAqJ8G5Myxo7sXElPQaP8wLnreAb1Ul7H1bXyM8YU=;
 b=DBo0eLcQ9Hi9xDTM1h1by89OirIQvpYvif66TUcG299L41uaESUyJBbxd2ghvKOOM8c5qR
 wWhdoK/X0ypURM2vUujdGwM+yYfHvB1cfuVHz0WyiVUH3xDGPoE7Yzxk+KyQrHX3bO71XyyG
 QKq548jkC1Kn3JDFIs3dIfM8M5Bkw=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 1/6] siemens: eeprom: clean up definitions
Date: Tue, 21 Nov 2023 15:21:29 +0100
Message-Id: <20231121142134.2147652-2-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-1-enrico.leto@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

Move the I2C and EEPROM address definitions in common board header.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/capricorn/board.c   |  5 ++---
 board/siemens/common/board.c      |  6 +++---
 board/siemens/common/board.h      | 21 +++++++++++++++++++++
 board/siemens/common/factoryset.c | 12 ++++++------
 board/siemens/draco/board.c       | 13 +++++--------
 include/configs/draco-etamin.h    |  3 ---
 include/configs/draco-rastaban.h  |  3 ---
 include/configs/draco-thuban.h    |  3 ---
 8 files changed, 37 insertions(+), 29 deletions(-)
 create mode 100644 board/siemens/common/board.h

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index 924c88e8fab..81fa340ca42 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -28,6 +28,7 @@
 #include <asm/arch-imx8/clock.h>
 #endif
 #include <linux/delay.h>
+#include "../common/board.h"
 #include "../common/factoryset.h"
 
 #define GPIO_PAD_CTRL \
@@ -337,13 +338,11 @@ void board_late_mmc_env_init(void)
 }
 
 #ifndef CONFIG_SPL_BUILD
-int factoryset_read_eeprom(int i2c_addr);
-
 static int load_parameters_from_factoryset(void)
 {
 	int ret;
 
-	ret = factoryset_read_eeprom(EEPROM_I2C_ADDR);
+	ret = factoryset_read_eeprom(SIEMENS_EE_I2C_ADDR);
 	if (ret)
 		return ret;
 
diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index 8fa9197a6df..f3e3c340b38 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -34,7 +34,8 @@
 #include <cpsw.h>
 #include <watchdog.h>
 #include <asm/mach-types.h>
-#include "../common/factoryset.h"
+#include "board.h"
+#include "factoryset.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -70,7 +71,6 @@ void sdram_init(void)
 #endif /* #ifdef CONFIG_SPL_BUILD */
 
 #ifndef CONFIG_SPL_BUILD
-#define FACTORYSET_EEPROM_ADDR		0x50
 /*
  * Basic board specific setup.  Pinmux has been handled already.
  */
@@ -88,7 +88,7 @@ int board_init(void)
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 
 #ifdef CONFIG_FACTORYSET
-	factoryset_read_eeprom(FACTORYSET_EEPROM_ADDR);
+	factoryset_read_eeprom(SIEMENS_EE_I2C_ADDR);
 #endif
 
 	gpmc_init();
diff --git a/board/siemens/common/board.h b/board/siemens/common/board.h
new file mode 100644
index 00000000000..0d5b369028f
--- /dev/null
+++ b/board/siemens/common/board.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright Siemens AG 2023
+ *
+ * Common board definitions for siemens boards
+ */
+
+#ifndef _BOARD_COMMON_H_
+#define _BOARD_COMMON_H_
+
+/* EEPROM @ I2C */
+#define SIEMENS_EE_I2C_BUS	0
+#define SIEMENS_EE_I2C_ADDR	0x50
+
+/* EEPROM mapping */
+#define SIEMENS_EE_ADDR_NAND_GEO	0x80
+#define SIEMENS_EE_ADDR_DDR3		0x90
+#define SIEMENS_EE_ADDR_CHIP		0x120
+#define SIEMENS_EE_ADDR_FACTORYSET	0x400
+
+#endif /* _BOARD_COMMON_H_ */
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 4e36a6f3199..94c671389dc 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -22,11 +22,11 @@
 #include <net.h>
 #include <errno.h>
 #include <g_dnl.h>
+#include "board.h"
 #include "factoryset.h"
 
-#define EEPR_PG_SZ		0x80
-#define EEPROM_FATORYSET_OFFSET	0x400
-#define OFF_PG            EEPROM_FATORYSET_OFFSET/EEPR_PG_SZ
+#define EEPR_PG_SZ	0x80
+#define OFF_PG		(SIEMENS_EE_ADDR_FACTORYSET / EEPR_PG_SZ)
 
 /* Global variable that contains necessary information from FactorySet */
 struct factorysetcontainer factory_dat;
@@ -159,7 +159,7 @@ int factoryset_read_eeprom(int i2c_addr)
 #endif
 
 #if CONFIG_IS_ENABLED(DM_I2C)
-	ret = uclass_get_device_by_seq(UCLASS_I2C, EEPROM_I2C_BUS, &bus);
+	ret = uclass_get_device_by_seq(UCLASS_I2C, SIEMENS_EE_I2C_BUS, &bus);
 	if (ret)
 		goto err;
 
@@ -171,14 +171,14 @@ int factoryset_read_eeprom(int i2c_addr)
 	if (ret)
 		goto err;
 
-	ret = dm_i2c_read(dev, EEPROM_FATORYSET_OFFSET, hdr, sizeof(hdr));
+	ret = dm_i2c_read(dev, SIEMENS_EE_ADDR_FACTORYSET, hdr, sizeof(hdr));
 	if (ret)
 		goto err;
 #else
 	if (i2c_probe(i2c_addr))
 		goto err;
 
-	if (i2c_read(i2c_addr, EEPROM_FATORYSET_OFFSET, 2, hdr, sizeof(hdr)))
+	if (i2c_read(i2c_addr, SIEMENS_EE_ADDR_FACTORYSET, 2, hdr, sizeof(hdr)))
 		goto err;
 #endif
 
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 8874659013f..6e61236ce22 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -37,6 +37,7 @@
 #include <watchdog.h>
 #include <linux/delay.h>
 #include "board.h"
+#include "../common/board.h"
 #include "../common/factoryset.h"
 #include <nand.h>
 
@@ -132,16 +133,12 @@ struct am335x_nand_geometry {
 	u8 nand_bus;
 };
 
-#define EEPROM_ADDR		0x50
-#define EEPROM_ADDR_DDR3	0x90
-#define EEPROM_ADDR_CHIP	0x120
-
 static int draco_read_nand_geometry(void)
 {
 	struct am335x_nand_geometry geo;
 
 	/* Read NAND geometry */
-	if (i2c_read(EEPROM_ADDR, 0x80, 2,
+	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_NAND_GEO, 2,
 		     (uchar *)&geo, sizeof(struct am335x_nand_geometry))) {
 		printf("Could not read the NAND geomtery; something fundamentally wrong on the I2C bus.\n");
 		return -EIO;
@@ -164,20 +161,20 @@ static int draco_read_nand_geometry(void)
 static int read_eeprom(void)
 {
 	/* Check if baseboard eeprom is available */
-	if (i2c_probe(EEPROM_ADDR)) {
+	if (i2c_probe(SIEMENS_EE_I2C_ADDR)) {
 		printf("Could not probe the EEPROM; something fundamentally wrong on the I2C bus.\n");
 		return 1;
 	}
 
 #ifdef CONFIG_SPL_BUILD
 	/* Read Siemens eeprom data (DDR3) */
-	if (i2c_read(EEPROM_ADDR, EEPROM_ADDR_DDR3, 2,
+	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_DDR3, 2,
 		     (uchar *)&settings.ddr3, sizeof(struct ddr3_data))) {
 		printf("Could not read the EEPROM; something fundamentally wrong on the I2C bus.\nUse default DDR3 timings\n");
 		set_default_ddr3_timings();
 	}
 	/* Read Siemens eeprom data (CHIP) */
-	if (i2c_read(EEPROM_ADDR, EEPROM_ADDR_CHIP, 2,
+	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_CHIP, 2,
 		     (uchar *)&settings.chip, sizeof(settings.chip)))
 		printf("Could not read chip settings\n");
 
diff --git a/include/configs/draco-etamin.h b/include/configs/draco-etamin.h
index d07b4e95364..c2358beab21 100644
--- a/include/configs/draco-etamin.h
+++ b/include/configs/draco-etamin.h
@@ -69,9 +69,6 @@
 /* Physical Memory Map */
 #define CFG_MAX_RAM_BANK_SIZE       (1024 << 20)    /* 1GB */
 
-#define EEPROM_ADDR_DDR3 0x90
-#define EEPROM_ADDR_CHIP 0x120
-
 /* nedded by compliance test in read mode */
 
 #undef COMMON_ENV_DFU_ARGS
diff --git a/include/configs/draco-rastaban.h b/include/configs/draco-rastaban.h
index 2efb4d23cdd..601c2a919f5 100644
--- a/include/configs/draco-rastaban.h
+++ b/include/configs/draco-rastaban.h
@@ -34,9 +34,6 @@
  /* Physical Memory Map */
 #define CFG_MAX_RAM_BANK_SIZE	(1024 << 20)	/* 1GB */
 
-#define EEPROM_ADDR_DDR3 0x90
-#define EEPROM_ADDR_CHIP 0x120
-
 /* Default env settings */
 #define CFG_EXTRA_ENV_SETTINGS \
 	"hostname=rastaban\0" \
diff --git a/include/configs/draco-thuban.h b/include/configs/draco-thuban.h
index a5913e1e7d2..ccd8156d2f2 100644
--- a/include/configs/draco-thuban.h
+++ b/include/configs/draco-thuban.h
@@ -27,9 +27,6 @@
  /* Physical Memory Map */
 #define CFG_MAX_RAM_BANK_SIZE	(1024 << 20)	/* 1GB */
 
-#define EEPROM_ADDR_DDR3 0x90
-#define EEPROM_ADDR_CHIP 0x120
-
 /* Default env settings */
 #define CFG_EXTRA_ENV_SETTINGS \
 	"hostname=thuban\0" \
-- 
2.30.2

