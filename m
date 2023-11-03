Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E9BC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D958770B;
	Fri,  3 Nov 2023 01:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xxXn3Rxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F416087737; Fri,  3 Nov 2023 01:38:51 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A71C876E2
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8ah019799;
 Thu, 2 Nov 2023 19:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971889;
 bh=1vofJ2husb95Jf3Fb1ufIsvvJTaqh5TliEqX9dNZSpA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xxXn3Rxi1Cwb1R1mmPO27mAOfiimh2mT0BBofcf2BvCH2jt8gUGPBwTC/WFfli+hU
 wg5CBfDVNB9sdUFAhCU5I3FgV//+J0N/ooNJVGLN6XE8eTA0ORw7q4rHLqwQLb6rzz
 ZA93SJMljTaw1rD2kfeE6N24JFkS7Q5GKGjWezxs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30c828021131
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:08 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8Lx007517;
 Thu, 2 Nov 2023 19:38:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 08/15] board: ti: j721e: evm: Split code to isolate eeprom
 detected logic
Date: Thu, 2 Nov 2023 19:37:58 -0500
Message-ID: <20231103003805.2420005-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Move code out of evm.c that is based on evm specific checks for board
variants and initialization sequences there of.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/j721e/Makefile                    |   1 +
 board/ti/j721e/{evm.c => board-variants.c} | 172 +--------
 board/ti/j721e/evm.c                       | 409 +--------------------
 board/ti/j721e/evm.h                       |  24 ++
 4 files changed, 53 insertions(+), 553 deletions(-)
 copy board/ti/j721e/{evm.c => board-variants.c} (75%)
 create mode 100644 board/ti/j721e/evm.h

diff --git a/board/ti/j721e/Makefile b/board/ti/j721e/Makefile
index 97535f5d86d1..f42fcf5c463b 100644
--- a/board/ti/j721e/Makefile
+++ b/board/ti/j721e/Makefile
@@ -6,3 +6,4 @@
 #
 
 obj-y	+= evm.o
+obj-${CONFIG_TI_I2C_BOARD_DETECT} += board-variants.o
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/board-variants.c
similarity index 75%
copy from board/ti/j721e/evm.c
copy to board/ti/j721e/board-variants.c
index 0fc141776818..ada0a9238981 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/board-variants.c
@@ -1,22 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Board specific initialization for J721E EVM
+ * Board variation detection and management based on EEPROM detect logic
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
- *	Lokesh Vutla <lokeshvutla@ti.com>
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  *
  */
 
 #include <common.h>
-#include <generic-phy.h>
+#include <dm.h>
 #include <image.h>
 #include <net.h>
+#include <spl.h>
 #include <asm/arch/hardware.h>
 #include <asm/gpio.h>
-#include <spl.h>
-#include <dm.h>
 
 #include "../common/board_detect.h"
+#include "evm.h"
 
 #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
 				 board_ti_k3_is("J721EX-PM2-SOM"))
@@ -30,49 +29,6 @@
 /* Max number of MAC addresses that are parsed/processed per daughter card */
 #define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
 
-DECLARE_GLOBAL_DATA_PTR;
-
-int board_init(void)
-{
-	return 0;
-}
-
-int dram_init(void)
-{
-	if (IS_ENABLED(CONFIG_PHYS_64BIT))
-		gd->ram_size = 0x100000000;
-	else
-		gd->ram_size = 0x80000000;
-
-	return 0;
-}
-
-phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
-{
-	/* Limit RAM used by U-Boot to the DDR low region */
-	if (IS_ENABLED(CONFIG_PHYS_64BIT) && gd->ram_top > 0x100000000)
-		return 0x100000000;
-
-	return gd->ram_top;
-}
-
-int dram_init_banksize(void)
-{
-	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = 0x80000000;
-	gd->ram_size = 0x80000000;
-
-	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
-		/* Bank 1 declares the memory available in the DDR high region */
-		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
-		gd->bd->bi_dram[1].size = 0x80000000;
-		gd->ram_size = 0x100000000;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_SPL_LOAD_FIT
 int board_fit_config_name_match(const char *name)
 {
@@ -138,7 +94,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
-#ifdef CONFIG_TI_I2C_BOARD_DETECT
 int do_board_detect(void)
 {
 	int ret;
@@ -348,74 +303,7 @@ static int probe_daughtercards(void)
 
 	return 0;
 }
-#endif
-
-void configure_serdes_torrent(void)
-{
-	struct udevice *dev;
-	struct phy serdes;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_PHY,
-					  DM_DRIVER_GET(torrent_phy_provider),
-					  &dev);
-	if (ret) {
-		printf("Torrent init failed:%d\n", ret);
-		return;
-	}
-
-	serdes.dev = dev;
-	serdes.id = 0;
-
-	ret = generic_phy_init(&serdes);
-	if (ret) {
-		printf("phy_init failed!!: %d\n", ret);
-		return;
-	}
 
-	ret = generic_phy_power_on(&serdes);
-	if (ret) {
-		printf("phy_power_on failed!!: %d\n", ret);
-		return;
-	}
-}
-
-void configure_serdes_sierra(void)
-{
-	struct udevice *dev, *link_dev;
-	struct phy link;
-	int ret, count, i;
-	int link_count = 0;
-
-	ret = uclass_get_device_by_driver(UCLASS_MISC,
-					  DM_DRIVER_GET(sierra_phy_provider),
-					  &dev);
-	if (ret) {
-		printf("Sierra init failed:%d\n", ret);
-		return;
-	}
-
-	count = device_get_child_count(dev);
-	for (i = 0; i < count; i++) {
-		ret = device_get_child(dev, i, &link_dev);
-		if (ret) {
-			printf("probe of sierra child node %d failed: %d\n", i, ret);
-			return;
-		}
-		if (link_dev->driver->id == UCLASS_PHY) {
-			link.dev = link_dev;
-			link.id = link_count++;
-
-			ret = generic_phy_power_on(&link);
-			if (ret) {
-				printf("phy_power_on failed!!: %d\n", ret);
-				return;
-			}
-		}
-	}
-}
-
-#ifdef CONFIG_BOARD_LATE_INIT
 static void setup_board_eeprom_env(void)
 {
 	char *name = "j721e";
@@ -457,27 +345,6 @@ static void setup_serial(void)
 	env_set("serial#", serial_string);
 }
 
-int board_late_init(void)
-{
-	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
-		setup_board_eeprom_env();
-		setup_serial();
-
-		/* Check for and probe any plugged-in daughtercards */
-		if (board_is_j721e_som() || board_is_j7200_som())
-			probe_daughtercards();
-	}
-
-	if (IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
-		configure_serdes_torrent();
-
-	if (IS_ENABLED(CONFIG_PHY_CADENCE_SIERRA))
-		configure_serdes_sierra();
-
-	return 0;
-}
-#endif
-
 static int __maybe_unused detect_SW3_1_state(void)
 {
 	if (IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) {
@@ -513,11 +380,20 @@ err_free_gpio:
 	}
 }
 
-void spl_board_init(void)
+int variant_board_late_init(void)
 {
-	struct udevice *dev;
-	int ret;
+	setup_board_eeprom_env();
+	setup_serial();
+
+	/* Check for and probe any plugged-in daughtercards */
+	if (board_is_j721e_som() || board_is_j7200_som())
+		probe_daughtercards();
 
+	return 0;
+}
+
+void variant_spl_board_init(void)
+{
 	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
 	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
 	    IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
@@ -525,20 +401,6 @@ void spl_board_init(void)
 			probe_daughtercards();
 	}
 
-	if (IS_ENABLED(CONFIG_ESM_K3)) {
-		ret = uclass_get_device_by_driver(UCLASS_MISC,
-						  DM_DRIVER_GET(k3_esm), &dev);
-		if (ret)
-			printf("ESM init failed: %d\n", ret);
-	}
-
-	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
-		ret = uclass_get_device_by_driver(UCLASS_MISC,
-						  DM_DRIVER_GET(pmic_esm),
-						  &dev);
-		if (ret)
-			printf("ESM PMIC init failed: %d\n", ret);
-	}
 	if ((IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) &&
 	    IS_ENABLED(CONFIG_HBMC_AM654)) {
 		struct udevice *dev;
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 0fc141776818..1c1cd106ba72 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -8,27 +8,10 @@
  */
 
 #include <common.h>
-#include <generic-phy.h>
-#include <image.h>
-#include <net.h>
-#include <asm/arch/hardware.h>
-#include <asm/gpio.h>
-#include <spl.h>
 #include <dm.h>
+#include <generic-phy.h>
 
-#include "../common/board_detect.h"
-
-#define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
-				 board_ti_k3_is("J721EX-PM2-SOM"))
-
-#define board_is_j721e_sk()	(board_ti_k3_is("J721EX-EAIK") || \
-				 board_ti_k3_is("J721EX-SK"))
-
-#define board_is_j7200_som()	(board_ti_k3_is("J7200X-PM1-SOM") || \
-				 board_ti_k3_is("J7200X-PM2-SOM"))
-
-/* Max number of MAC addresses that are parsed/processed per daughter card */
-#define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
+#include "evm.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -73,283 +56,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_LOAD_FIT
-int board_fit_config_name_match(const char *name)
-{
-	bool eeprom_read = board_ti_was_eeprom_read();
-
-	if (!eeprom_read || board_is_j721e_som()) {
-		if (!strcmp(name, "k3-j721e-common-proc-board") ||
-		    !strcmp(name, "k3-j721e-r5-common-proc-board"))
-			return 0;
-	} else if (board_is_j721e_sk()) {
-		if (!strcmp(name, "k3-j721e-sk") ||
-		    !strcmp(name, "k3-j721e-r5-sk"))
-			return 0;
-	}
-
-	return -1;
-}
-#endif
-
-#if CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_LIBFDT)
-/* Returns 1, if onboard mux is set to hyperflash */
-static void __maybe_unused detect_enable_hyperflash(void *blob)
-{
-	struct gpio_desc desc = {0};
-	char *hypermux_sel_gpio = (board_is_j721e_som()) ? "8" : "6";
-
-	if (dm_gpio_lookup_name(hypermux_sel_gpio, &desc))
-		return;
-
-	if (dm_gpio_request(&desc, hypermux_sel_gpio))
-		return;
-
-	if (dm_gpio_set_dir_flags(&desc, GPIOD_IS_IN))
-		return;
-
-	if (dm_gpio_get_value(&desc)) {
-		int offset;
-
-		do_fixup_by_compat(blob, "ti,am654-hbmc", "status",
-				   "okay", sizeof("okay"), 0);
-		offset = fdt_node_offset_by_compatible(blob, -1,
-						       "ti,am654-ospi");
-		fdt_setprop(blob, offset, "status", "disabled",
-			    sizeof("disabled"));
-	}
-}
-#endif
-
-#if defined(CONFIG_SPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
-					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
-	detect_enable_hyperflash(spl_image->fdt_addr);
-}
-#endif
-
-#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	detect_enable_hyperflash(blob);
-
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_TI_I2C_BOARD_DETECT
-int do_board_detect(void)
-{
-	int ret;
-
-	if (board_ti_was_eeprom_read())
-		return 0;
-
-	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
-					 CONFIG_EEPROM_CHIP_ADDRESS);
-	if (ret) {
-		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
-		       CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
-		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
-						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
-		if (ret)
-			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
-			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
-	}
-
-	return ret;
-}
-
-int checkboard(void)
-{
-	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
-
-	if (do_board_detect())
-		/* EEPROM not populated */
-		printf("Board: %s rev %s\n", "J721EX-PM1-SOM", "E2");
-	else
-		printf("Board: %s rev %s\n", ep->name, ep->version);
-
-	return 0;
-}
-
-/*
- * Declaration of daughtercards to probe. Note that when adding more
- * cards they should be grouped by the 'i2c_addr' field to allow for a
- * more efficient probing process.
- */
-static const struct {
-	u8 i2c_addr;		/* I2C address of card EEPROM */
-	char *card_name;	/* EEPROM-programmed card name */
-	char *dtbo_name;	/* Device tree overlay to apply */
-	u8 eth_offset;		/* ethXaddr MAC address index offset */
-} ext_cards[] = {
-	{
-		0x51,
-		"J7X-BASE-CPB",
-		"",		/* No dtbo for this board */
-		0,
-	},
-	{
-		0x52,
-		"J7X-INFOTAN-EXP",
-		"",		/* No dtbo for this board */
-		0,
-	},
-	{
-		0x52,
-		"J7X-GESI-EXP",
-		"",		/* No dtbo for this board */
-		5,		/* Start populating from eth5addr */
-	},
-	{
-		0x54,
-		"J7X-VSC8514-ETH",
-		"",		/* No dtbo for this board */
-		1,		/* Start populating from eth1addr */
-	},
-};
-
-static bool daughter_card_detect_flags[ARRAY_SIZE(ext_cards)];
-
-const char *board_fit_get_additionnal_images(int index, const char *type)
-{
-	int i, j;
-
-	if (strcmp(type, FIT_FDT_PROP))
-		return NULL;
-
-	j = 0;
-	for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
-		if (daughter_card_detect_flags[i]) {
-			if (j == index) {
-				/*
-				 * Return dtbo name only if populated,
-				 * otherwise stop parsing here.
-				 */
-				if (strlen(ext_cards[i].dtbo_name))
-					return ext_cards[i].dtbo_name;
-				else
-					return NULL;
-			};
-
-			j++;
-		}
-	}
-
-	return NULL;
-}
-
-static int probe_daughtercards(void)
-{
-	char mac_addr[DAUGHTER_CARD_NO_OF_MAC_ADDR][TI_EEPROM_HDR_ETH_ALEN];
-	bool eeprom_read_success;
-	struct ti_am6_eeprom ep;
-	u8 previous_i2c_addr;
-	u8 mac_addr_cnt;
-	int i;
-	int ret;
-
-	/* Mark previous I2C address variable as not populated */
-	previous_i2c_addr = 0xff;
-
-	/* No EEPROM data was read yet */
-	eeprom_read_success = false;
-
-	/* Iterate through list of daughtercards */
-	for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
-		/* Obtain card-specific I2C address */
-		u8 i2c_addr = ext_cards[i].i2c_addr;
-
-		/* Read card EEPROM if not already read previously */
-		if (i2c_addr != previous_i2c_addr) {
-			/* Store I2C address so we can avoid reading twice */
-			previous_i2c_addr = i2c_addr;
-
-			/* Get and parse the daughter card EEPROM record */
-			ret = ti_i2c_eeprom_am6_get(CONFIG_EEPROM_BUS_ADDRESS,
-						    i2c_addr,
-						    &ep,
-						    (char **)mac_addr,
-						    DAUGHTER_CARD_NO_OF_MAC_ADDR,
-						    &mac_addr_cnt);
-			if (ret) {
-				debug("%s: No daughtercard EEPROM at 0x%02x found %d\n",
-				      __func__, i2c_addr, ret);
-				eeprom_read_success = false;
-				/* Skip to the next daughtercard to probe */
-				continue;
-			}
-
-			/* EEPROM read successful, okay to further process. */
-			eeprom_read_success = true;
-		}
-
-		/* Only continue processing if EEPROM data was read */
-		if (!eeprom_read_success)
-			continue;
-
-		/* Only process the parsed data if we found a match */
-		if (strncmp(ep.name, ext_cards[i].card_name, sizeof(ep.name)))
-			continue;
-
-		printf("Detected: %s rev %s\n", ep.name, ep.version);
-		daughter_card_detect_flags[i] = true;
-
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
-			int j;
-			/*
-			 * Populate any MAC addresses from daughtercard into the U-Boot
-			 * environment, starting with a card-specific offset so we can
-			 * have multiple ext_cards contribute to the MAC pool in a well-
-			 * defined manner.
-			 */
-			for (j = 0; j < mac_addr_cnt; j++) {
-				if (!is_valid_ethaddr((u8 *)mac_addr[j]))
-					continue;
-
-				eth_env_set_enetaddr_by_index("eth",
-							      ext_cards[i].eth_offset + j,
-							      (uchar *)mac_addr[j]);
-			}
-		}
-	}
-
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
-		char name_overlays[1024] = { 0 };
-
-		for (i = 0; i < ARRAY_SIZE(ext_cards); i++) {
-			if (!daughter_card_detect_flags[i])
-				continue;
-
-			/* Skip if no overlays are to be added */
-			if (!strlen(ext_cards[i].dtbo_name))
-				continue;
-
-			/*
-			 * Make sure we are not running out of buffer space by checking
-			 * if we can fit the new overlay, a trailing space to be used
-			 * as a separator, plus the terminating zero.
-			 */
-			if (strlen(name_overlays) + strlen(ext_cards[i].dtbo_name) + 2 >
-			    sizeof(name_overlays))
-				return -ENOMEM;
-
-			/* Append to our list of overlays */
-			strcat(name_overlays, ext_cards[i].dtbo_name);
-			strcat(name_overlays, " ");
-		}
-
-		/* Apply device tree overlay(s) to the U-Boot environment, if any */
-		if (strlen(name_overlays))
-			return env_set("name_overlays", name_overlays);
-	}
-
-	return 0;
-}
-#endif
-
 void configure_serdes_torrent(void)
 {
 	struct udevice *dev;
@@ -415,59 +121,8 @@ void configure_serdes_sierra(void)
 	}
 }
 
-#ifdef CONFIG_BOARD_LATE_INIT
-static void setup_board_eeprom_env(void)
+int board_serdes_late_init(void)
 {
-	char *name = "j721e";
-
-	if (do_board_detect())
-		goto invalid_eeprom;
-
-	if (board_is_j721e_som())
-		name = "j721e";
-	else if (board_is_j721e_sk())
-		name = "j721e-sk";
-	else if (board_is_j7200_som())
-		name = "j7200";
-	else
-		printf("Unidentified board claims %s in eeprom header\n",
-		       board_ti_get_name());
-
-invalid_eeprom:
-	set_board_info_env_am6(name);
-}
-
-static void setup_serial(void)
-{
-	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
-	unsigned long board_serial;
-	char *endp;
-	char serial_string[17] = { 0 };
-
-	if (env_get("serial#"))
-		return;
-
-	board_serial = hextoul(ep->serial, &endp);
-	if (*endp != '\0') {
-		pr_err("Error: Can't set serial# to %s\n", ep->serial);
-		return;
-	}
-
-	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
-	env_set("serial#", serial_string);
-}
-
-int board_late_init(void)
-{
-	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
-		setup_board_eeprom_env();
-		setup_serial();
-
-		/* Check for and probe any plugged-in daughtercards */
-		if (board_is_j721e_som() || board_is_j7200_som())
-			probe_daughtercards();
-	}
-
 	if (IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT))
 		configure_serdes_torrent();
 
@@ -476,41 +131,18 @@ int board_late_init(void)
 
 	return 0;
 }
-#endif
 
-static int __maybe_unused detect_SW3_1_state(void)
+int board_late_init(void)
 {
-	if (IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) {
-		struct gpio_desc desc = {0};
-		int ret;
-		char *hypermux_sel_gpio = (board_is_j721e_som()) ? "8" : "6";
-
-		ret = dm_gpio_lookup_name(hypermux_sel_gpio, &desc);
-		if (ret) {
-			printf("error getting GPIO lookup name: %d\n", ret);
-			return ret;
-		}
-
-		ret = dm_gpio_request(&desc, hypermux_sel_gpio);
-		if (ret) {
-			printf("error requesting GPIO: %d\n", ret);
-			goto err_free_gpio;
-		}
+	int ret;
 
-		ret = dm_gpio_set_dir_flags(&desc, GPIOD_IS_IN);
-		if (ret) {
-			printf("error setting direction flag of GPIO: %d\n", ret);
-			goto err_free_gpio;
-		}
+	ret = variant_board_late_init();
+	if (ret)
+		return ret;
 
-		ret = dm_gpio_get_value(&desc);
-		if (ret < 0)
-			printf("error getting value of GPIO: %d\n", ret);
+	board_serdes_late_init();
 
-err_free_gpio:
-		dm_gpio_free(desc.dev, &desc);
-		return ret;
-	}
+	return 0;
 }
 
 void spl_board_init(void)
@@ -518,13 +150,6 @@ void spl_board_init(void)
 	struct udevice *dev;
 	int ret;
 
-	if ((IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM) ||
-	     IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM)) &&
-	    IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
-		if (!board_is_j721e_sk())
-			probe_daughtercards();
-	}
-
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
 		ret = uclass_get_device_by_driver(UCLASS_MISC,
 						  DM_DRIVER_GET(k3_esm), &dev);
@@ -539,18 +164,6 @@ void spl_board_init(void)
 		if (ret)
 			printf("ESM PMIC init failed: %d\n", ret);
 	}
-	if ((IS_ENABLED(CONFIG_TARGET_J7200_A72_EVM) || IS_ENABLED(CONFIG_TARGET_J721E_A72_EVM)) &&
-	    IS_ENABLED(CONFIG_HBMC_AM654)) {
-		struct udevice *dev;
-		int ret;
 
-		ret = detect_SW3_1_state();
-		if (ret == 1) {
-			ret = uclass_get_device_by_driver(UCLASS_MTD,
-							  DM_DRIVER_GET(hbmc_am654),
-							  &dev);
-			if (ret)
-				debug("Failed to probe hyperflash\n");
-		}
-	}
+	variant_spl_board_init();
 }
diff --git a/board/ti/j721e/evm.h b/board/ti/j721e/evm.h
new file mode 100644
index 000000000000..8f8681817586
--- /dev/null
+++ b/board/ti/j721e/evm.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Board detected logic initialization abstraction
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __J72E_EVM_H
+#define __J72E_EVM_H
+
+#ifdef CONFIG_TI_I2C_BOARD_DETECT
+
+int variant_board_late_init(void);
+void variant_spl_board_init(void);
+
+#else /* CONFIG_TI_I2C_BOARD_DETECT */
+
+static inline int variant_board_late_init(void) { return 0; }
+static inline void variant_spl_board_init(void) { }
+
+#endif /* CONFIG_TI_I2C_BOARD_DETECT */
+
+#endif /* __J72E_EVM_H */
-- 
2.40.0

