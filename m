Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B97EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0D888CAF;
	Wed, 11 Sep 2024 23:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rTs1kInU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBF988C36; Wed, 11 Sep 2024 23:50:06 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284C788B0A
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 73BE5120007;
 Thu, 12 Sep 2024 00:49:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 73BE5120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091396;
 bh=wvHCoHWCdUrkB41gu0jDEwPvtkthQIkOejWkn1Tjkgk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rTs1kInUBg8fcDsPw8QiYPuNELuBZqWw3yaIPxlAc3d9pPd7tm06Pj7P89vONKlEX
 OyU/5b6eZ8AcoBflC3ZrvRXd334hYX/K6nN275PnUVsxRONtiMgJ8z/SUOtGuEBLYY
 lj+H09xEjVLIywP66N/W7XhB4SjJJ+LziiKHFBApbbLouCMeFxGcnNB4XjhfI6ItwK
 xRkIfHpr1J1gQPi54TIapBlY2rFsvKyV2TgNzEKQJ4yKiPdjzRjL5u91Eh/u5l0aEr
 eimYTU0CoURXgSkpvNz5M5iwV8FGQIgcuDK8nygCXtGTyMXdY/0GrHd190C1U+jY0N
 juYt83YZ13Kfw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:56 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
Date: Thu, 12 Sep 2024 00:49:10 +0300
Message-ID: <20240911214945.15873-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; source.denx.de:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/11 19:53:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/11 21:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped
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

To enhance code organization, it is beneficial to consolidate all A/B
BCB management routines into a single super-command.
The 'bcb' command is an excellent candidate for this purpose.

This patch integrates the separate 'ab_select' command into the 'bcb'
group as the 'ab_select' subcommand, maintaining the same parameter list
for consistency.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 MAINTAINERS                               |  1 -
 cmd/Kconfig                               | 15 +----
 cmd/Makefile                              |  1 -
 cmd/ab_select.c                           | 66 --------------------
 cmd/bcb.c                                 | 73 +++++++++++++++++++----
 configs/am57xx_hs_evm_usb_defconfig       |  1 -
 configs/khadas-vim3_android_ab_defconfig  |  1 -
 configs/khadas-vim3l_android_ab_defconfig |  1 -
 configs/sandbox64_defconfig               |  4 +-
 configs/sandbox_defconfig                 |  4 +-
 doc/android/ab.rst                        | 12 ++--
 include/configs/khadas-vim3_android.h     |  2 +-
 include/configs/khadas-vim3l_android.h    |  2 +-
 include/configs/meson64_android.h         |  4 +-
 include/configs/ti_omap5_common.h         |  4 +-
 test/py/tests/test_android/test_ab.py     |  8 +--
 16 files changed, 84 insertions(+), 115 deletions(-)
 delete mode 100644 cmd/ab_select.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df82..876330d2d750 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,7 +65,6 @@ R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
-F:	cmd/ab_select.c
 F:	doc/android/ab.rst
 F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda426..eb0fb07b426a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1053,6 +1053,7 @@ config CMD_ADC
 config CMD_BCB
 	bool "bcb"
 	depends on PARTITIONS
+	depends on ANDROID_AB
 	help
 	  Read/modify/write the fields of Bootloader Control Block, usually
 	  stored on the flash "misc" partition with its structure defined in:
@@ -1766,20 +1767,6 @@ config CMD_XXD
 
 endmenu
 
-menu "Android support commands"
-
-config CMD_AB_SELECT
-	bool "ab_select"
-	depends on ANDROID_AB
-	help
-	  On Android devices with more than one boot slot (multiple copies of
-	  the kernel and system images) this provides a command to select which
-	  slot should be used to boot from and register the boot attempt. This
-	  is used by the new A/B update model where one slot is updated in the
-	  background while running from the other slot.
-
-endmenu
-
 if NET
 
 menuconfig CMD_NET
diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a8a..281c13220e95 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_CMD_2048) += 2048.o
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_AES) += aes.o
-obj-$(CONFIG_CMD_AB_SELECT) += ab_select.o
 obj-$(CONFIG_CMD_ADC) += adc.o
 obj-$(CONFIG_CMD_ARMFLASH) += armflash.o
 obj-$(CONFIG_BLK) += blk_common.o
diff --git a/cmd/ab_select.c b/cmd/ab_select.c
deleted file mode 100644
index 7c178c728ca4..000000000000
--- a/cmd/ab_select.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: BSD-2-Clause
-/*
- * Copyright (C) 2017 The Android Open Source Project
- */
-
-#include <android_ab.h>
-#include <command.h>
-#include <env.h>
-#include <part.h>
-
-static int do_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
-			char *const argv[])
-{
-	int ret;
-	struct blk_desc *dev_desc;
-	struct disk_partition part_info;
-	char slot[2];
-	bool dec_tries = true;
-
-	if (argc < 4)
-		return CMD_RET_USAGE;
-
-	for (int i = 4; i < argc; i++) {
-		if (strcmp(argv[i], "--no-dec") == 0) {
-			dec_tries = false;
-		} else {
-			return CMD_RET_USAGE;
-		}
-	}
-
-	/* Lookup the "misc" partition from argv[2] and argv[3] */
-	if (part_get_info_by_dev_and_name_or_num(argv[2], argv[3],
-						 &dev_desc, &part_info,
-						 false) < 0) {
-		return CMD_RET_FAILURE;
-	}
-
-	ret = ab_select_slot(dev_desc, &part_info, dec_tries);
-	if (ret < 0) {
-		printf("Android boot failed, error %d.\n", ret);
-		return CMD_RET_FAILURE;
-	}
-
-	/* Android standard slot names are 'a', 'b', ... */
-	slot[0] = BOOT_SLOT_NAME(ret);
-	slot[1] = '\0';
-	env_set(argv[1], slot);
-	printf("ANDROID: Booting slot: %s\n", slot);
-	return CMD_RET_SUCCESS;
-}
-
-U_BOOT_CMD(ab_select, 5, 0, do_ab_select,
-	   "Select the slot used to boot from and register the boot attempt.",
-	   "<slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
-	   "    - Load the slot metadata from the partition 'part' on\n"
-	   "      device type 'interface' instance 'dev' and store the active\n"
-	   "      slot in the 'slot_var_name' variable. This also updates the\n"
-	   "      Android slot metadata with a boot attempt, which can cause\n"
-	   "      successive calls to this function to return a different result\n"
-	   "      if the returned slot runs out of boot attempts.\n"
-	   "    - If 'part_name' is passed, preceded with a # instead of :, the\n"
-	   "      partition name whose label is 'part_name' will be looked up in\n"
-	   "      the partition table. This is commonly the \"misc\" partition.\n"
-           "    - If '--no-dec' is set, the number of tries remaining will not\n"
-           "      decremented for the selected boot slot\n"
-);
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 97a96c009641..a56535a743c0 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -8,6 +8,7 @@
 #include <android_bootloader_message.h>
 #include <bcb.h>
 #include <command.h>
+#include <android_ab.h>
 #include <display_options.h>
 #include <log.h>
 #include <part.h>
@@ -23,6 +24,7 @@ enum bcb_cmd {
 	BCB_CMD_FIELD_TEST,
 	BCB_CMD_FIELD_DUMP,
 	BCB_CMD_STORE,
+	BCB_CMD_AB_SELECT,
 };
 
 static const char * const fields[] = {
@@ -52,6 +54,8 @@ static int bcb_cmd_get(char *cmd)
 		return BCB_CMD_STORE;
 	if (!strcmp(cmd, "dump"))
 		return BCB_CMD_FIELD_DUMP;
+	if (!strcmp(cmd, "ab_select"))
+		return BCB_CMD_AB_SELECT;
 	else
 		return -1;
 }
@@ -85,6 +89,10 @@ static int bcb_is_misused(int argc, char *const argv[])
 		if (argc != 2)
 			goto err;
 		break;
+	case BCB_CMD_AB_SELECT:
+		if (argc != 4 && argc != 5)
+			goto err;
+		return 0;
 	default:
 		printf("Error: 'bcb %s' not supported\n", argv[0]);
 		return -1;
@@ -414,6 +422,44 @@ void bcb_reset(void)
 	__bcb_reset();
 }
 
+static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char * const argv[])
+{
+	int ret;
+	struct blk_desc *dev_desc;
+	struct disk_partition part_info;
+	char slot[2];
+	bool dec_tries = true;
+
+	for (int i = 4; i < argc; i++) {
+		if (strcmp(argv[i], "--no-dec") == 0)
+			dec_tries = false;
+		else
+			return CMD_RET_USAGE;
+	}
+
+	/* Lookup the "misc" partition from argv[2] and argv[3] */
+	if (part_get_info_by_dev_and_name_or_num(argv[2], argv[3],
+						 &dev_desc, &part_info,
+						 false) < 0) {
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ab_select_slot(dev_desc, &part_info, dec_tries);
+	if (ret < 0) {
+		printf("Android boot failed, error %d.\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	/* Android standard slot names are 'a', 'b', ... */
+	slot[0] = BOOT_SLOT_NAME(ret);
+	slot[1] = '\0';
+	env_set(argv[1], slot);
+	printf("ANDROID: Booting slot: %s\n", slot);
+
+	return CMD_RET_SUCCESS;
+}
+
 static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(load, CONFIG_SYS_MAXARGS, 1, do_bcb_load, "", ""),
 	U_BOOT_CMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bcb_set, "", ""),
@@ -421,6 +467,8 @@ static struct cmd_tbl cmd_bcb_sub[] = {
 	U_BOOT_CMD_MKENT(test, CONFIG_SYS_MAXARGS, 1, do_bcb_test, "", ""),
 	U_BOOT_CMD_MKENT(dump, CONFIG_SYS_MAXARGS, 1, do_bcb_dump, "", ""),
 	U_BOOT_CMD_MKENT(store, CONFIG_SYS_MAXARGS, 1, do_bcb_store, "", ""),
+	U_BOOT_CMD_MKENT(ab_select, CONFIG_SYS_MAXARGS, 1,
+			 do_bcb_ab_select, "", ""),
 };
 
 static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -460,15 +508,18 @@ U_BOOT_CMD(
 	"bcb dump  <field>              - dump  BCB <field>\n"
 	"bcb store                      - store BCB back to <interface>\n"
 	"\n"
-	"Legend:\n"
-	"<interface> - storage device interface (virtio, mmc, etc)\n"
-	"<dev>       - storage device index containing the BCB partition\n"
-	"<part>      - partition index or name containing the BCB\n"
-	"<field>     - one of {command,status,recovery,stage,reserved}\n"
-	"<op>        - the binary operator used in 'bcb test':\n"
-	"              '=' returns true if <val> matches the string stored in <field>\n"
-	"              '~' returns true if <val> matches a subset of <field>'s string\n"
-	"<val>       - string/text provided as input to bcb {set,test}\n"
-	"              NOTE: any ':' character in <val> will be replaced by line feed\n"
-	"              during 'bcb set' and used as separator by upper layers\n"
+	"bcb ab_select -\n"
+	"    Select the slot used to boot from and register the boot attempt.\n"
+	"    <slot_var_name> <interface> <dev[:part|#part_name]> [--no-dec]\n"
+	"    - Load the slot metadata from the partition 'part' on\n"
+	"      device type 'interface' instance 'dev' and store the active\n"
+	"      slot in the 'slot_var_name' variable. This also updates the\n"
+	"      Android slot metadata with a boot attempt, which can cause\n"
+	"      successive calls to this function to return a different result\n"
+	"      if the returned slot runs out of boot attempts.\n"
+	"    - If 'part_name' is passed, preceded with a # instead of :, the\n"
+	"      partition name whose label is 'part_name' will be looked up in\n"
+	"      the partition table. This is commonly the \"misc\" partition.\n"
+	"    - If '--no-dec' is set, the number of tries remaining will not\n"
+	"      decremented for the selected boot slot\n"
 );
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 807e1d66a6d7..6d822b021768 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -50,7 +50,6 @@ CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_BCB=y
-CONFIG_CMD_AB_SELECT=y
 CONFIG_BOOTP_DNS2=y
 # CONFIG_CMD_PMIC is not set
 CONFIG_CMD_AVB=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 37b8d6a9256b..5281c426cb73 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 95e70275cc4f..ff3001b78fa2 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index dd0582d2a0c0..635753f00b73 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -25,6 +25,7 @@ CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_ANDROID_AB=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_BOOTZ=y
@@ -44,6 +45,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_BCB=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -167,8 +169,8 @@ CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
+CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_SANDBOX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index dc5fcdbd1c9e..cb69554a7306 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_BCB=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
@@ -93,7 +94,6 @@ CONFIG_CMD_AXI=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_SETEXPR_FMT=y
 CONFIG_CMD_XXD=y
-CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_DHCP6=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_PCAP=y
@@ -219,8 +219,8 @@ CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
+CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_SANDBOX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/doc/android/ab.rst b/doc/android/ab.rst
index 2adf88781d60..7fd4aeb6a724 100644
--- a/doc/android/ab.rst
+++ b/doc/android/ab.rst
@@ -18,7 +18,7 @@ The A/B updates support can be activated by specifying next options in
 your board configuration file::
 
     CONFIG_ANDROID_AB=y
-    CONFIG_CMD_AB_SELECT=y
+    CONFIG_CMD_BCB=y
 
 The disk space on target device must be partitioned in a way so that each
 partition which needs to be updated has two or more instances. The name of
@@ -26,8 +26,8 @@ each instance must be formed by adding suffixes: ``_a``, ``_b``, ``_c``, etc.
 For example: ``boot_a``, ``boot_b``, ``system_a``, ``system_b``, ``vendor_a``,
 ``vendor_b``.
 
-As a result you can use ``ab_select`` command to ensure A/B boot process in your
-boot script. This command analyzes and processes A/B metadata stored on a
+As a result you can use ``bcb ab_select`` command to ensure A/B boot process in
+your boot script. This command analyzes and processes A/B metadata stored on a
 special partition (e.g. ``misc``) and determines which slot should be used for
 booting up.
 
@@ -42,15 +42,15 @@ Command usage
 
 .. code-block:: none
 
-    ab_select <slot_var_name> <interface> <dev[:part_number|#part_name]>
+    bcb ab_select <slot_var_name> <interface> <dev[:part_number|#part_name]>
 
 for example::
 
-    => ab_select slot_name mmc 1:4
+    => bcb ab_select slot_name mmc 1:4
 
 or::
 
-    => ab_select slot_name mmc 1#misc
+    => bcb ab_select slot_name mmc 1#misc
 
 Result::
 
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index da6adf6c413a..4a8348914035 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -12,7 +12,7 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index b1768e2d8211..bf1c831c0bc3 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -12,7 +12,7 @@
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
 #define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index c0e977abb01f..93f9e191a165 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -47,13 +47,13 @@
 #define AVB_VERIFY_CMD ""
 #endif
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB)
 #define ANDROIDBOOT_GET_CURRENT_SLOT_CMD "get_current_slot=" \
 	"if part number mmc ${mmcdev} " CONTROL_PARTITION " control_part_number; " \
 	"then " \
 		"echo " CONTROL_PARTITION \
 			" partition number:${control_part_number};" \
-		"ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
+		"bcb ab_select current_slot mmc ${mmcdev}:${control_part_number};" \
 	"else " \
 		"echo " CONTROL_PARTITION " partition not found;" \
 	"fi;\0"
diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 26494ae98010..5a2ea8c4ddcc 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -93,13 +93,13 @@
 
 #define CONTROL_PARTITION "misc"
 
-#if defined(CONFIG_CMD_AB_SELECT)
+#if defined(CONFIG_CMD_BCB)
 #define AB_SELECT_SLOT \
 	"if part number mmc 1 " CONTROL_PARTITION " control_part_number; " \
 	"then " \
 		"echo " CONTROL_PARTITION \
 			" partition number:${control_part_number};" \
-		"ab_select slot_name mmc ${mmcdev}:${control_part_number};" \
+		"bcb ab_select slot_name mmc ${mmcdev}:${control_part_number};" \
 	"else " \
 		"echo " CONTROL_PARTITION " partition not found;" \
 		"exit;" \
diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index c79cb07fda35..0d7b7995a9fa 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -56,20 +56,20 @@ def ab_disk_image(u_boot_console):
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('android_ab')
-@pytest.mark.buildconfigspec('cmd_ab_select')
+@pytest.mark.buildconfigspec('cmd_bcb')
 @pytest.mark.requiredtool('sgdisk')
 def test_ab(ab_disk_image, u_boot_console):
-    """Test the 'ab_select' command."""
+    """Test the 'bcb ab_select' command."""
 
     u_boot_console.run_command('host bind 0 ' + ab_disk_image.path)
 
-    output = u_boot_console.run_command('ab_select slot_name host 0#misc')
+    output = u_boot_console.run_command('bcb ab_select slot_name host 0#misc')
     assert 're-initializing A/B metadata' in output
     assert 'Attempting slot a, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=a' in output
 
-    output = u_boot_console.run_command('ab_select slot_name host 0:1')
+    output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
     assert 'Attempting slot b, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=b' in output
-- 
2.43.0

