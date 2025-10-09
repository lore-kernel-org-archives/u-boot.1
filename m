Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A7CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68031845A1;
	Thu,  9 Oct 2025 16:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XF5PQgPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5380845A8; Thu,  9 Oct 2025 16:51:28 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F0284308
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id ABD561A1243;
 Thu,  9 Oct 2025 14:51:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7F2116062C;
 Thu,  9 Oct 2025 14:51:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1BAC2102F21E7; 
 Thu,  9 Oct 2025 16:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021484; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vOrtFNT8zwhPZcMu0sTxAsnODCaiRpLAb1W7ykBWwnw=;
 b=XF5PQgPFa8mxm1BABeqN1rwGezFy9riCHBEhYjNy62YyXxntvASBmqwQ8JTy9hqF9TxtNw
 PhCo7FES7YNIRRYmhzEPjr3ynxlip+Rssl5AtOPKgbCHQxToNCBFAAMqn1PG9zEdBKNkK3
 7Jku2qiRUA+R+FWLoP8MQcl+fzBhRPotrReNeKkicUcfseiumqBrnf/3OZgdr8rbAnyHIA
 BES7j9o1rhiMjTmHUKouBiKAAMBfi8HT2bXEPkQ7cTVuLVqAbonXQRNqIhwmOqDEi35pGs
 6SiK+oJaP5WqtyKbsHRjwFa5FCDYgBkzk1H/BdQSb1jZfzH219QLHANTSmRl2g==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:50 +0200
Subject: [PATCH v2 14/18] boot: Remove legacy extension board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-14-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3
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

Remove the legacy extension board implementation now that all boards
have been converted to use the new UCLASS-based framework. This
eliminates 223 lines of legacy code while preserving functionality
through the modern driver model approach.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Changes in v2:
- Remove a missing DM_EXTENSION_SCAN in cmd/Kconfig
---
 MAINTAINERS                        |  1 -
 arch/Kconfig                       |  2 +-
 arch/arm/mach-imx/imx8m/Kconfig    |  4 +-
 arch/arm/mach-omap2/am33xx/Kconfig |  2 +-
 arch/arm/mach-omap2/omap5/Kconfig  |  2 +-
 arch/arm/mach-sunxi/Kconfig        |  2 +-
 board/ti/common/Makefile           |  2 +-
 boot/Kconfig                       |  3 --
 boot/Makefile                      |  3 +-
 boot/extension-uclass.c            | 18 +++----
 boot/extension.c                   | 97 --------------------------------------
 cmd/Kconfig                        |  2 +-
 cmd/extension_board.c              | 74 ++++-------------------------
 include/extension_board.h          | 55 ++++++---------------
 14 files changed, 40 insertions(+), 227 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a63ffa14ef5..a75e59453d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1188,7 +1188,6 @@ S:	Maintained
 F:	board/sunxi/chip.c
 F:	board/ti/common/cape_detect.c
 F:	boot/extension-uclass.c
-F:	boot/extension.c
 F:	cmd/extension_board.c
 F:	include/extension_board.h
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 5bb65a29f8d..7e05e0c2263 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -215,7 +215,7 @@ config SANDBOX
 	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_DM_EXTENSION_SCAN if CMDLINE
+	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 5324eff3084..e7bc154b805 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -359,14 +359,14 @@ config TARGET_IMX8MM_CL_IOT_GATE
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
-	select SUPPORT_DM_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN
 
 config TARGET_IMX8MM_CL_IOT_GATE_OPTEE
 	bool "CompuLab iot-gate-imx8 with optee support"
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
-	select SUPPORT_DM_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN
 
 config TARGET_IMX8MP_RSB3720A1_4G
 	bool "Support i.MX8MP RSB3720A1 4G"
diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
index 77f7938305b..dff4f1cf202 100644
--- a/arch/arm/mach-omap2/am33xx/Kconfig
+++ b/arch/arm/mach-omap2/am33xx/Kconfig
@@ -15,7 +15,7 @@ config TARGET_AM335X_EVM
 	select DM_GPIO
 	select DM_SERIAL
 	select TI_I2C_BOARD_DETECT
-	select SUPPORT_DM_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN
 	imply CMD_DM
 	imply SPL_DM
 	imply SPL_DM_SEQ_ALIAS
diff --git a/arch/arm/mach-omap2/omap5/Kconfig b/arch/arm/mach-omap2/omap5/Kconfig
index 819490a8cf8..5394529658b 100644
--- a/arch/arm/mach-omap2/omap5/Kconfig
+++ b/arch/arm/mach-omap2/omap5/Kconfig
@@ -38,7 +38,7 @@ config TARGET_AM57XX_EVM
 	select CMD_DDR3
 	select DRA7XX
 	select TI_I2C_BOARD_DETECT
-	select SUPPORT_DM_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN
 	imply DM_THERMAL
 	imply SCSI
 	imply SPL_THERMAL
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f5696199516..b04ec671696 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1223,7 +1223,7 @@ config BLUETOOTH_DT_DEVICE_FIXUP
 
 config CHIP_DIP_SCAN
 	bool "Enable DIPs detection for CHIP board"
-	select SUPPORT_DM_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN
 	select W1
 	select W1_GPIO
 	select W1_EEPROM
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index b42273d3a5a..f58935b4103 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -2,6 +2,6 @@
 # Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
 
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
-obj-${CONFIG_$(PHASE_)SUPPORT_DM_EXTENSION_SCAN} += cape_detect.o
+obj-${CONFIG_$(PHASE_)SUPPORT_EXTENSION_SCAN} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
 obj-${CONFIG_ARCH_K3} += k3-ddr.o
diff --git a/boot/Kconfig b/boot/Kconfig
index 159da81bec5..62aa301f18f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1909,9 +1909,6 @@ endif # OF_LIBFDT
 config SUPPORT_EXTENSION_SCAN
         bool
 
-config SUPPORT_DM_EXTENSION_SCAN
-        bool
-
 config USE_BOOTARGS
 	bool "Enable boot arguments"
 	help
diff --git a/boot/Makefile b/boot/Makefile
index aa26070fbb8..7fb56e7ef37 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -9,8 +9,7 @@ obj-$(CONFIG_BOOT_RETRY) += bootretry.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
-obj-$(CONFIG_SUPPORT_EXTENSION_SCAN) += extension.o
-obj-$(CONFIG_SUPPORT_DM_EXTENSION_SCAN) += extension-uclass.o
+obj-$(CONFIG_SUPPORT_EXTENSION_SCAN) += extension-uclass.o
 
 obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
 
diff --git a/boot/extension-uclass.c b/boot/extension-uclass.c
index 9dfbeb60d20..1b21aa08944 100644
--- a/boot/extension-uclass.c
+++ b/boot/extension-uclass.c
@@ -61,7 +61,7 @@ static struct udevice *extension_get_dev(void)
 	return NULL;
 }
 
-struct alist *dm_extension_get_list(void)
+struct alist *extension_get_list(void)
 {
 	struct udevice *dev = extension_get_dev();
 
@@ -71,7 +71,7 @@ struct alist *dm_extension_get_list(void)
 	return dev_get_priv(dev);
 }
 
-int dm_extension_probe(struct udevice *dev)
+int extension_probe(struct udevice *dev)
 {
 	struct alist *extension_list = dev_get_priv(dev);
 
@@ -79,7 +79,7 @@ int dm_extension_probe(struct udevice *dev)
 	return 0;
 }
 
-int dm_extension_remove(struct udevice *dev)
+int extension_remove(struct udevice *dev)
 {
 	struct alist *extension_list = dev_get_priv(dev);
 
@@ -87,9 +87,9 @@ int dm_extension_remove(struct udevice *dev)
 	return 0;
 }
 
-int dm_extension_scan(void)
+int extension_scan(void)
 {
-	struct alist *extension_list = dm_extension_get_list();
+	struct alist *extension_list = extension_get_list();
 	struct udevice *dev = extension_get_dev();
 	const struct extension_ops *ops;
 
@@ -154,9 +154,9 @@ static int _extension_apply(const struct extension *extension)
 	return ret;
 }
 
-int dm_extension_apply(int extension_num)
+int extension_apply(int extension_num)
 {
-	struct alist *extension_list = dm_extension_get_list();
+	struct alist *extension_list = extension_get_list();
 	const struct extension *extension;
 
 	if (!extension_list)
@@ -172,9 +172,9 @@ int dm_extension_apply(int extension_num)
 	return _extension_apply(extension);
 }
 
-int dm_extension_apply_all(void)
+int extension_apply_all(void)
 {
-	struct alist *extension_list = dm_extension_get_list();
+	struct alist *extension_list = extension_get_list();
 	const struct extension *extension;
 	int ret;
 
diff --git a/boot/extension.c b/boot/extension.c
deleted file mode 100644
index fc9e1d398f4..00000000000
--- a/boot/extension.c
+++ /dev/null
@@ -1,97 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2025 Köry Maincent <kory.maincent@bootlin.com>
- */
-
-#include <bootdev.h>
-#include <command.h>
-#include <env.h>
-#include <extension_board.h>
-#include <fdt_support.h>
-#include <malloc.h>
-#include <mapmem.h>
-
-int extension_apply(struct extension *extension)
-{
-	ulong extrasize, overlay_addr;
-	struct fdt_header *blob;
-	char *overlay_cmd;
-
-	if (!working_fdt) {
-		printf("No FDT memory address configured. Please configure\n"
-		       "the FDT address via \"fdt addr <address>\" command.\n");
-		return CMD_RET_FAILURE;
-	}
-
-	overlay_cmd = env_get("extension_overlay_cmd");
-	if (!overlay_cmd) {
-		printf("Environment extension_overlay_cmd is missing\n");
-		return CMD_RET_FAILURE;
-	}
-
-	overlay_addr = env_get_hex("extension_overlay_addr", 0);
-	if (!overlay_addr) {
-		printf("Environment extension_overlay_addr is missing\n");
-		return CMD_RET_FAILURE;
-	}
-
-	env_set("extension_overlay_name", extension->overlay);
-	if (run_command(overlay_cmd, 0) != 0)
-		return CMD_RET_FAILURE;
-
-	extrasize = env_get_hex("filesize", 0);
-	if (!extrasize)
-		return CMD_RET_FAILURE;
-
-	fdt_shrink_to_minimum(working_fdt, extrasize);
-
-	blob = map_sysmem(overlay_addr, 0);
-	if (!fdt_valid(&blob))
-		return CMD_RET_FAILURE;
-
-	/* apply method prints messages on error */
-	if (fdt_overlay_apply_verbose(working_fdt, blob))
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-int extension_scan(bool show)
-{
-	struct extension *extension, *next;
-	int extension_num;
-
-	list_for_each_entry_safe(extension, next, &extension_list, list) {
-		list_del(&extension->list);
-		free(extension);
-	}
-	extension_num = extension_board_scan(&extension_list);
-	if (show && extension_num >= 0)
-		printf("Found %d extension board(s).\n", extension_num);
-
-	/* either the number of extensions, or -ve for error */
-	return extension_num;
-}
-
-static int extension_bootdev_hunt(struct bootdev_hunter *info, bool show)
-{
-	int ret;
-
-	ret = env_set_hex("extension_overlay_addr",
-			  env_get_hex("fdtoverlay_addr_r", 0));
-	if (ret)
-		return log_msg_ret("env", ret);
-
-	ret = extension_scan(show);
-	if (ret < 0)
-		return log_msg_ret("ext", ret);
-
-	return 0;
-}
-
-/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass */
-BOOTDEV_HUNTER(extension_bootdev_hunter) = {
-	.prio		= BOOTDEVP_1_PRE_SCAN,
-	.uclass		= UCLASS_SIMPLE_BUS,
-	.hunt		= extension_bootdev_hunt,
-};
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 721bdb87c8a..986eeeba807 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -548,7 +548,7 @@ config CMD_FDT
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
-	depends on SUPPORT_EXTENSION_SCAN || SUPPORT_DM_EXTENSION_SCAN
+	depends on SUPPORT_EXTENSION_SCAN
 	help
 	  Enables the "extension" command, which allows to detect
 	  extension boards connected to the system, and apply
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index d70394f36c7..c373397e0fb 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -9,46 +9,26 @@
 #include <command.h>
 #include <extension_board.h>
 
-LIST_HEAD(extension_list);
-
 static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
-#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-	struct alist *dm_extension_list;
-#endif
+	struct alist *extension_list;
 	struct extension *extension;
 	int i = 0;
 
-#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-	dm_extension_list = dm_extension_get_list();
-
-	if (!alist_get_ptr(dm_extension_list, 0)) {
+	extension_list = extension_get_list();
+	if (!alist_get_ptr(extension_list, 0)) {
 		printf("No extension registered - Please run \"extension scan\"\n");
 		return CMD_RET_SUCCESS;
 	}
 
-	alist_for_each(extension, dm_extension_list) {
+	alist_for_each(extension, extension_list) {
 		printf("Extension %d: %s\n", i++, extension->name);
 		printf("\tManufacturer: \t\t%s\n", extension->owner);
 		printf("\tVersion: \t\t%s\n", extension->version);
 		printf("\tDevicetree overlay: \t%s\n", extension->overlay);
 		printf("\tOther information: \t%s\n", extension->other);
 	}
-#else
-	if (list_empty(&extension_list)) {
-		printf("No extension registered - Please run \"extension scan\"\n");
-		return CMD_RET_SUCCESS;
-	}
-
-	list_for_each_entry(extension, &extension_list, list) {
-		printf("Extension %d: %s\n", i++, extension->name);
-		printf("\tManufacturer: \t\t%s\n", extension->owner);
-		printf("\tVersion: \t\t%s\n", extension->version);
-		printf("\tDevicetree overlay: \t%s\n", extension->overlay);
-		printf("\tOther information: \t%s\n", extension->other);
-	}
-#endif
 	return CMD_RET_SUCCESS;
 }
 
@@ -57,69 +37,31 @@ static int do_extension_scan(struct cmd_tbl *cmdtp, int flag,
 {
 	int extension_num;
 
-#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-	extension_num = dm_extension_scan();
+	extension_num = extension_scan();
 	if (extension_num == -ENODEV)
 		extension_num = 0;
 	else if (extension_num < 0)
 		return CMD_RET_FAILURE;
 
 	printf("Found %d extension board(s).\n", extension_num);
-#else
-	extension_num = extension_scan(true);
-	if (extension_num < 0 && extension_num != -ENODEV)
-		return CMD_RET_FAILURE;
-#endif
-
 	return CMD_RET_SUCCESS;
 }
 
 static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
 			      int argc, char *const argv[])
 {
-#if !CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-	struct extension *extension = NULL;
-	struct list_head *entry;
-	int i = 0;
-#endif
-	int extension_id, ret;
+	int extension_id;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
 	if (strcmp(argv[1], "all") == 0) {
-		ret = CMD_RET_FAILURE;
-#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-		if (dm_extension_apply_all())
+		if (extension_apply_all())
 			return CMD_RET_FAILURE;
-#else
-		list_for_each_entry(extension, &extension_list, list) {
-			ret = extension_apply(extension);
-			if (ret != CMD_RET_SUCCESS)
-				break;
-		}
-#endif
 	} else {
 		extension_id = simple_strtol(argv[1], NULL, 10);
-#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
-		if (dm_extension_apply(extension_id))
+		if (extension_apply(extension_id))
 			return CMD_RET_FAILURE;
-#else
-		list_for_each(entry, &extension_list) {
-			if (i == extension_id) {
-				extension = list_entry(entry, struct extension,  list);
-				break;
-			}
-			i++;
-		}
-
-		if (!extension) {
-			printf("Wrong extension number\n");
-			return CMD_RET_FAILURE;
-		}
-
-		ret = extension_apply(extension);
-#endif
 	}
 
 	return CMD_RET_SUCCESS;
diff --git a/include/extension_board.h b/include/extension_board.h
index 78139cd7489..fc9c33ed354 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -14,47 +14,46 @@
 extern struct list_head extension_list;
 
 /**
- * dm_extension_get_list - Get the extension list
+ * extension_get_list - Get the extension list
  * Return: The extension alist pointer, or NULL if no such list exists.
  */
-struct alist *dm_extension_get_list(void);
+struct alist *extension_get_list(void);
 
 /**
- * dm_extension_probe - Probe extension device
+ * extension_probe - Probe extension device
  * @dev: Extension device that needs to be probed
  * Return: Zero on success, negative on failure.
  */
-int dm_extension_probe(struct udevice *dev);
+int extension_probe(struct udevice *dev);
 
 /**
- * dm_extension_remove - Remove extension device
+ * extension_remove - Remove extension device
  * @dev: Extension device that needs to be removed
  * Return: Zero on success, negative on failure.
  */
-int dm_extension_remove(struct udevice *dev);
+int extension_remove(struct udevice *dev);
 
 /**
- * dm_extension_scan - Scan extension boards available.
+ * extension_scan - Scan extension boards available.
  * Return: Zero on success, negative on failure.
  */
-int dm_extension_scan(void);
+int extension_scan(void);
 
 /**
- * dm_extension_apply - Apply extension board overlay to the devicetree
+ * extension_apply - Apply extension board overlay to the devicetree
  * @extension_num: Extension number to be applied
  * Return: Zero on success, negative on failure.
  */
-int dm_extension_apply(int extension_num);
+int extension_apply(int extension_num);
 
 /**
- * dm_extension_apply_all - Apply all extension board overlays to the
+ * extension_apply_all - Apply all extension board overlays to the
  *			    devicetree
  * Return: Zero on success, negative on failure.
  */
-int dm_extension_apply_all(void);
+int extension_apply_all(void);
 
 struct extension {
-	struct list_head list;
 	char name[32];
 	char owner[32];
 	char version[32];
@@ -76,38 +75,12 @@ struct extension_ops {
 	U_BOOT_DRIVER(_name) = { \
 		.name = #_name, \
 		.id = UCLASS_EXTENSION, \
-		.probe = dm_extension_probe, \
-		.remove = dm_extension_remove, \
+		.probe = extension_probe, \
+		.remove = extension_remove, \
 		.ops = &(struct extension_ops) { \
 		       .scan = _scan_func, \
 		       }, \
 		.priv_auto = sizeof(struct alist), \
 	}
 
-/**
- * extension_board_scan - Add system-specific function to scan extension board.
- * @param extension_list	List of extension board information to update.
- * Return: the number of extension.
- *
- * This function is called if CONFIG_CMD_EXTENSION is defined.
- * Needs to fill the list extension_list with elements.
- * Each element need to be allocated to an extension structure.
- *
- */
-int extension_board_scan(struct list_head *extension_list);
-
-/**
- * extension_apply - Apply extension board overlay to the devicetree
- * @extension: Extension to be applied
- * Return: Zero on success, negative on failure.
- */
-int extension_apply(struct extension *extension);
-
-/**
- * extension_scan - Scan extension boards available.
- * @show: Flag to enable verbose log
- * Return: Zero on success, negative on failure.
- */
-int extension_scan(bool show);
-
 #endif /* __EXTENSION_SUPPORT_H */

-- 
2.43.0

