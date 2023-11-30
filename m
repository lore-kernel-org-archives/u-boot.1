Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1D8C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 12:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E426D876AB;
	Thu, 30 Nov 2023 13:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="LLeeOw9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C251387631; Thu, 30 Nov 2023 13:24:39 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D289875AA
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 13:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20231130122425da11be5cd305641147 for <u-boot@lists.denx.de>;
 Thu, 30 Nov 2023 13:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MBCMvOkLzU3mBQ3FlJThDTWB16R5qSlVz0fnjwhPtdg=;
 b=LLeeOw9NFif1A4oG/UbHNiOOy0q7atCX6CLC0WpCJxN6tld1VSRIXfgX0jc+khOmdIcsjx
 BVBmqBYpuNsyqNSxdt9qJLIDdCioGkKyU1g3WxQ9deEXzAUf3l+Wjlh88hOTcj0wiuRTkI9d
 AR1XJTL+5OehyaU/T1Z/PMmtXpBJA=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v2 2/6] siemens: eeprom: simplify setup & read
Date: Thu, 30 Nov 2023 13:23:20 +0100
Message-Id: <20231130122324.658502-3-enrico.leto@siemens.com>
In-Reply-To: <20231130122324.658502-1-enrico.leto@siemens.com>
References: <20231130122324.658502-1-enrico.leto@siemens.com>
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

Since we have boards using the driver model or not for i2c, use abstraction
function to probe the i2c, check the EEPROM and read from EEPROM.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 board/siemens/common/board.c      | 50 ++++++++++++++++++++++++--
 board/siemens/common/board.h      |  3 ++
 board/siemens/common/factoryset.c | 58 +++++--------------------------
 board/siemens/draco/board.c       | 23 ++++--------
 board/siemens/pxm2/board.c        |  2 +-
 board/siemens/rut/board.c         |  2 +-
 6 files changed, 67 insertions(+), 71 deletions(-)

diff --git a/board/siemens/common/board.c b/board/siemens/common/board.c
index f3e3c340b38..ddbb92811cf 100644
--- a/board/siemens/common/board.c
+++ b/board/siemens/common/board.c
@@ -39,6 +39,50 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+
+#if CONFIG_IS_ENABLED(DM_I2C)
+static struct udevice *i2c_dev;
+#endif
+
+/* Probe I2C and set-up EEPROM */
+int siemens_ee_setup(void)
+{
+#if CONFIG_IS_ENABLED(DM_I2C)
+	struct udevice *bus;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, SIEMENS_EE_I2C_BUS, &bus);
+	if (ret)
+		goto err;
+
+	ret = dm_i2c_probe(bus, SIEMENS_EE_I2C_ADDR, 0, &i2c_dev);
+	if (ret)
+		goto err;
+	if (i2c_set_chip_offset_len(i2c_dev, 2))
+		goto err;
+#else
+	i2c_set_bus_num(SIEMENS_EE_I2C_BUS);
+	if (i2c_probe(SIEMENS_EE_I2C_ADDR))
+		goto err;
+#endif
+	return 0;
+
+err:
+	printf("Could not probe the EEPROM; something fundamentally wrong on the I2C bus.\n");
+	return 1;
+}
+
+/* Read data from EEPROM */
+int siemens_ee_read_data(uint address, uchar *buffer, int len)
+{
+#if CONFIG_IS_ENABLED(DM_I2C)
+	return dm_i2c_read(i2c_dev, address, buffer, len);
+#else
+	return i2c_read(SIEMENS_EE_I2C_ADDR, address, 2, buffer, len);
+#endif
+}
+
+
 #ifdef CONFIG_SPL_BUILD
 void set_uart_mux_conf(void)
 {
@@ -49,12 +93,13 @@ void set_mux_conf_regs(void)
 {
 	/* Initalize the board header */
 	enable_i2c0_pin_mux();
-	i2c_set_bus_num(0);
 
 	/* enable early the console */
 	gd->baudrate = CONFIG_BAUDRATE;
 	serial_init();
 	gd->have_console = 1;
+
+	siemens_ee_setup();
 	if (read_eeprom() < 0)
 		puts("Could not get board ID.\n");
 
@@ -79,8 +124,7 @@ int board_init(void)
 #if defined(CONFIG_HW_WATCHDOG)
 	hw_watchdog_init();
 #endif /* defined(CONFIG_HW_WATCHDOG) */
-	i2c_set_bus_num(0);
-	if (read_eeprom() < 0)
+	if (siemens_ee_setup() < 0)
 		puts("Could not get board ID.\n");
 #ifdef CONFIG_MACH_TYPE
 	gd->bd->bi_arch_number = CONFIG_MACH_TYPE;
diff --git a/board/siemens/common/board.h b/board/siemens/common/board.h
index 0d5b369028f..2b49348919a 100644
--- a/board/siemens/common/board.h
+++ b/board/siemens/common/board.h
@@ -18,4 +18,7 @@
 #define SIEMENS_EE_ADDR_CHIP		0x120
 #define SIEMENS_EE_ADDR_FACTORYSET	0x400
 
+int siemens_ee_setup(void);
+int siemens_ee_read_data(uint address, uchar *buffer, int len);
+
 #endif /* _BOARD_COMMON_H_ */
diff --git a/board/siemens/common/factoryset.c b/board/siemens/common/factoryset.c
index 94c671389dc..8f5cf066664 100644
--- a/board/siemens/common/factoryset.c
+++ b/board/siemens/common/factoryset.c
@@ -148,39 +148,14 @@ int factoryset_read_eeprom(int i2c_addr)
 	int i, pages = 0, size = 0;
 	unsigned char eeprom_buf[0x3c00], hdr[4], buf[MAX_STRING_LENGTH];
 	unsigned char *cp, *cp1;
-#if CONFIG_IS_ENABLED(DM_I2C)
-	struct udevice *bus, *dev;
-	int ret;
-#endif
 
 #if defined(CONFIG_DFU_OVER_USB)
 	factory_dat.usb_vendor_id = CONFIG_USB_GADGET_VENDOR_NUM;
 	factory_dat.usb_product_id = CONFIG_USB_GADGET_PRODUCT_NUM;
 #endif
 
-#if CONFIG_IS_ENABLED(DM_I2C)
-	ret = uclass_get_device_by_seq(UCLASS_I2C, SIEMENS_EE_I2C_BUS, &bus);
-	if (ret)
-		goto err;
-
-	ret = dm_i2c_probe(bus, i2c_addr, 0, &dev);
-	if (ret)
-		goto err;
-
-	ret = i2c_set_chip_offset_len(dev, 2);
-	if (ret)
-		goto err;
-
-	ret = dm_i2c_read(dev, SIEMENS_EE_ADDR_FACTORYSET, hdr, sizeof(hdr));
-	if (ret)
-		goto err;
-#else
-	if (i2c_probe(i2c_addr))
-		goto err;
-
-	if (i2c_read(i2c_addr, SIEMENS_EE_ADDR_FACTORYSET, 2, hdr, sizeof(hdr)))
+	if (siemens_ee_read_data(SIEMENS_EE_ADDR_FACTORYSET, hdr, sizeof(hdr)))
 		goto err;
-#endif
 
 	if ((hdr[0] != 0x99) || (hdr[1] != 0x80)) {
 		printf("FactorySet is not right in eeprom.\n");
@@ -201,33 +176,16 @@ int factoryset_read_eeprom(int i2c_addr)
 	 * data after every time we got a record from eeprom
 	 */
 	debug("Read eeprom page :\n");
-	for (i = 0; i < pages; i++) {
-#if CONFIG_IS_ENABLED(DM_I2C)
-		ret = dm_i2c_read(dev, (OFF_PG + i) * EEPR_PG_SZ,
-				  eeprom_buf + (i * EEPR_PG_SZ), EEPR_PG_SZ);
-		if (ret)
+	for (i = 0; i < pages; i++)
+		if (siemens_ee_read_data((OFF_PG + i) * EEPR_PG_SZ,
+				     eeprom_buf + (i * EEPR_PG_SZ), EEPR_PG_SZ))
 			goto err;
-#else
-		if (i2c_read(i2c_addr, (OFF_PG + i) * EEPR_PG_SZ, 2,
-			     eeprom_buf + (i * EEPR_PG_SZ), EEPR_PG_SZ))
-			goto err;
-#endif
-	}
 
-	if (size % EEPR_PG_SZ) {
-#if CONFIG_IS_ENABLED(DM_I2C)
-		ret = dm_i2c_read(dev, (OFF_PG + pages) * EEPR_PG_SZ,
-				  eeprom_buf + (pages * EEPR_PG_SZ),
-				  size % EEPR_PG_SZ);
-		if (ret)
-			goto err;
-#else
-		if (i2c_read(i2c_addr, (OFF_PG + pages) * EEPR_PG_SZ, 2,
-			     eeprom_buf + (pages * EEPR_PG_SZ),
-			     (size % EEPR_PG_SZ)))
+	if (size % EEPR_PG_SZ)
+		if (siemens_ee_read_data((OFF_PG + pages) * EEPR_PG_SZ,
+				     eeprom_buf + (pages * EEPR_PG_SZ),
+				     size % EEPR_PG_SZ))
 			goto err;
-#endif
-	}
 
 	/* we do below just for eeprom align */
 	for (i = 0; i < size; i++)
diff --git a/board/siemens/draco/board.c b/board/siemens/draco/board.c
index 6e61236ce22..43db76490f7 100644
--- a/board/siemens/draco/board.c
+++ b/board/siemens/draco/board.c
@@ -138,8 +138,8 @@ static int draco_read_nand_geometry(void)
 	struct am335x_nand_geometry geo;
 
 	/* Read NAND geometry */
-	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_NAND_GEO, 2,
-		     (uchar *)&geo, sizeof(struct am335x_nand_geometry))) {
+	if (siemens_ee_read_data(SIEMENS_EE_ADDR_NAND_GEO, (uchar *)&geo,
+			     sizeof(struct am335x_nand_geometry))) {
 		printf("Could not read the NAND geomtery; something fundamentally wrong on the I2C bus.\n");
 		return -EIO;
 	}
@@ -155,27 +155,21 @@ static int draco_read_nand_geometry(void)
 	return 0;
 }
 
+#ifdef CONFIG_SPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
 static int read_eeprom(void)
 {
-	/* Check if baseboard eeprom is available */
-	if (i2c_probe(SIEMENS_EE_I2C_ADDR)) {
-		printf("Could not probe the EEPROM; something fundamentally wrong on the I2C bus.\n");
-		return 1;
-	}
-
-#ifdef CONFIG_SPL_BUILD
 	/* Read Siemens eeprom data (DDR3) */
-	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_DDR3, 2,
-		     (uchar *)&settings.ddr3, sizeof(struct ddr3_data))) {
+	if (siemens_ee_read_data(SIEMENS_EE_ADDR_DDR3, (uchar *)&settings.ddr3,
+			     sizeof(struct ddr3_data))) {
 		printf("Could not read the EEPROM; something fundamentally wrong on the I2C bus.\nUse default DDR3 timings\n");
 		set_default_ddr3_timings();
 	}
 	/* Read Siemens eeprom data (CHIP) */
-	if (i2c_read(SIEMENS_EE_I2C_ADDR, SIEMENS_EE_ADDR_CHIP, 2,
-		     (uchar *)&settings.chip, sizeof(settings.chip)))
+	if (siemens_ee_read_data(SIEMENS_EE_ADDR_CHIP, (uchar *)&settings.chip,
+			     sizeof(settings.chip)))
 		printf("Could not read chip settings\n");
 
 	if (ddr3_default.magic == settings.ddr3.magic &&
@@ -199,11 +193,8 @@ static int read_eeprom(void)
 	print_ddr3_timings();
 
 	return draco_read_nand_geometry();
-#endif
-	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
 static void board_init_ddr(void)
 {
 struct emif_regs draco_ddr3_emif_reg_data = {
diff --git a/board/siemens/pxm2/board.c b/board/siemens/pxm2/board.c
index 47f19bcb8fd..6a345b5639f 100644
--- a/board/siemens/pxm2/board.c
+++ b/board/siemens/pxm2/board.c
@@ -160,7 +160,6 @@ void spl_siemens_board_init(void)
 		printf("voltage update failed\n");
 	}
 }
-#endif /* if def CONFIG_SPL_BUILD */
 
 int read_eeprom(void)
 {
@@ -168,6 +167,7 @@ int read_eeprom(void)
 
 	return 0;
 }
+#endif /* if def CONFIG_SPL_BUILD */
 
 #if (defined(CONFIG_DRIVER_TI_CPSW) && !defined(CONFIG_SPL_BUILD)) || \
 	(defined(CONFIG_SPL_ETH) && defined(CONFIG_SPL_BUILD))
diff --git a/board/siemens/rut/board.c b/board/siemens/rut/board.c
index a8b196a65c9..bd1c5894f6a 100644
--- a/board/siemens/rut/board.c
+++ b/board/siemens/rut/board.c
@@ -38,6 +38,7 @@
 #include "board.h"
 #include "../common/factoryset.h"
 
+#ifdef CONFIG_SPL_BUILD
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -46,7 +47,6 @@ static int read_eeprom(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
 static void board_init_ddr(void)
 {
 struct emif_regs rut_ddr3_emif_reg_data = {
-- 
2.30.2

