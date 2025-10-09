Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84858CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED2884181;
	Thu,  9 Oct 2025 16:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D3tfFTgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37DD84541; Thu,  9 Oct 2025 16:51:04 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3FE84461
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 53DB44E40FB4;
 Thu,  9 Oct 2025 14:51:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 283ED6062C;
 Thu,  9 Oct 2025 14:51:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BCED6102F21E6; 
 Thu,  9 Oct 2025 16:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021460; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Cw7LlPEuy+Xb21hYJPYtqVtbgUbrlvbKBSSxHURkB8Y=;
 b=D3tfFTgBdLa39iyd3uSi5RXI44RxiiEFNEsm5LIrFMJFXsbboqXLBNOrY1vk3AazI5pThK
 sDtZE01jPPROG95pgcgurgr2ww1sT4nri8vfPjX8QNjLxSFAHpLJw6ve6YI5t5aR6kCgvy
 pnVMQ9GYghrG+uXIZK07sQjdGHSkdTbJhTOdatV+env4r90K1HvxF3Ves6z5eI40eJLEmJ
 pDx/ir55pWPySJnqu58tKKR8u7o6f19P375v5DkXoHJrsAzAImXDH1gn0MniGZWnK9nQ/V
 GqpKLlzo5ptguqOAcYIGP1ZBL37CI9Z5qfqj93AtTpnVfRHMT+7M87xYVk62zg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:39 +0200
Subject: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
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

Introduce UCLASS-based extension board support to enable more
standardized and automatic loading of extension board device tree
overlays in preparation for integration with bootstd and pxe_utils.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 MAINTAINERS                 |   1 +
 boot/Kconfig                |   3 +
 boot/Makefile               |   1 +
 boot/extension-uclass.c     | 196 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig                 |   2 +-
 cmd/extension_board.c       |  50 ++++++++++-
 doc/usage/cmd/extension.rst |  24 +++---
 include/dm/uclass-id.h      |   1 +
 include/extension_board.h   |  64 +++++++++++++++
 9 files changed, 326 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c67d5ae9d6b..a63ffa14ef5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1187,6 +1187,7 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
 S:	Maintained
 F:	board/sunxi/chip.c
 F:	board/ti/common/cape_detect.c
+F:	boot/extension-uclass.c
 F:	boot/extension.c
 F:	cmd/extension_board.c
 F:	include/extension_board.h
diff --git a/boot/Kconfig b/boot/Kconfig
index 62aa301f18f..159da81bec5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1909,6 +1909,9 @@ endif # OF_LIBFDT
 config SUPPORT_EXTENSION_SCAN
         bool
 
+config SUPPORT_DM_EXTENSION_SCAN
+        bool
+
 config USE_BOOTARGS
 	bool "Enable boot arguments"
 	help
diff --git a/boot/Makefile b/boot/Makefile
index f60d13130b1..aa26070fbb8 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
 obj-$(CONFIG_SUPPORT_EXTENSION_SCAN) += extension.o
+obj-$(CONFIG_SUPPORT_DM_EXTENSION_SCAN) += extension-uclass.o
 
 obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
 
diff --git a/boot/extension-uclass.c b/boot/extension-uclass.c
new file mode 100644
index 00000000000..9dfbeb60d20
--- /dev/null
+++ b/boot/extension-uclass.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2025 Köry Maincent <kory.maincent@bootlin.com>
+ */
+
+#include <alist.h>
+#include <command.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <extension_board.h>
+#include <fdt_support.h>
+#include <malloc.h>
+#include <mapmem.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* For now, bind the extension device manually if none are found */
+static struct udevice *extension_get_dev(void)
+{
+	struct driver *drv = ll_entry_start(struct driver, driver);
+	const int n_ents = ll_entry_count(struct driver, driver);
+	struct udevice *dev;
+	int i, ret;
+
+	/* These are not needed before relocation */
+	if (!(gd->flags & GD_FLG_RELOC))
+		return NULL;
+
+	uclass_first_device(UCLASS_EXTENSION, &dev);
+	if (dev)
+		return dev;
+
+	/* Create the extension device if not already bound */
+	for (i = 0; i < n_ents; i++, drv++) {
+		if (drv->id == UCLASS_EXTENSION) {
+			char name[32];
+
+			snprintf(name, sizeof(name), "%s_dev", drv->name);
+			ret = device_bind_driver(gd->dm_root, drv->name,
+						 name, &dev);
+			if (ret) {
+				printf("Bind extension driver %s error=%d\n",
+				       drv->name, ret);
+				return NULL;
+			}
+
+			ret = device_probe(dev);
+			if (ret) {
+				printf("Probe extension driver %s error=%d\n",
+				       drv->name, ret);
+				return NULL;
+			}
+
+			/* We manage only one extension driver for now */
+			return dev;
+		}
+	}
+
+	return NULL;
+}
+
+struct alist *dm_extension_get_list(void)
+{
+	struct udevice *dev = extension_get_dev();
+
+	if (!dev)
+		return NULL;
+
+	return dev_get_priv(dev);
+}
+
+int dm_extension_probe(struct udevice *dev)
+{
+	struct alist *extension_list = dev_get_priv(dev);
+
+	alist_init_struct(extension_list, struct extension);
+	return 0;
+}
+
+int dm_extension_remove(struct udevice *dev)
+{
+	struct alist *extension_list = dev_get_priv(dev);
+
+	alist_uninit(extension_list);
+	return 0;
+}
+
+int dm_extension_scan(void)
+{
+	struct alist *extension_list = dm_extension_get_list();
+	struct udevice *dev = extension_get_dev();
+	const struct extension_ops *ops;
+
+	if (!dev || !extension_list)
+		return -ENODEV;
+
+	ops = device_get_ops(dev);
+	if (!ops->scan)
+		return -ENODEV;
+
+	alist_empty(extension_list);
+	return ops->scan(extension_list);
+}
+
+static int _extension_apply(const struct extension *extension)
+{
+	ulong extrasize, overlay_addr;
+	struct fdt_header *blob;
+	char *overlay_cmd;
+	int ret;
+
+	if (!working_fdt) {
+		printf("No FDT memory address configured. Please configure\n"
+		       "the FDT address via \"fdt addr <address>\" command.\n");
+		return -EINVAL;
+	}
+
+	overlay_cmd = env_get("extension_overlay_cmd");
+	if (!overlay_cmd) {
+		printf("Environment extension_overlay_cmd is missing\n");
+		return -EINVAL;
+	}
+
+	overlay_addr = env_get_hex("extension_overlay_addr", 0);
+	if (!overlay_addr) {
+		printf("Environment extension_overlay_addr is missing\n");
+		return -EINVAL;
+	}
+
+	env_set("extension_overlay_name", extension->overlay);
+	ret = run_command(overlay_cmd, 0);
+	if (ret)
+		return ret;
+
+	extrasize = env_get_hex("filesize", 0);
+	if (!extrasize)
+		return -EINVAL;
+
+	fdt_shrink_to_minimum(working_fdt, extrasize);
+
+	blob = map_sysmem(overlay_addr, 0);
+	if (!fdt_valid(&blob)) {
+		printf("Invalid overlay devicetree %s\n", extension->overlay);
+		return -EINVAL;
+	}
+
+	/* Apply method prints messages on error */
+	ret = fdt_overlay_apply_verbose(working_fdt, blob);
+	if (ret)
+		printf("Failed to apply overlay %s\n", extension->overlay);
+
+	return ret;
+}
+
+int dm_extension_apply(int extension_num)
+{
+	struct alist *extension_list = dm_extension_get_list();
+	const struct extension *extension;
+
+	if (!extension_list)
+		return -ENODEV;
+
+	extension = alist_get(extension_list, extension_num,
+			      struct extension);
+	if (!extension) {
+		printf("Wrong extension number\n");
+		return -ENODEV;
+	}
+
+	return _extension_apply(extension);
+}
+
+int dm_extension_apply_all(void)
+{
+	struct alist *extension_list = dm_extension_get_list();
+	const struct extension *extension;
+	int ret;
+
+	if (!extension_list)
+		return -ENODEV;
+
+	alist_for_each(extension, extension_list) {
+		ret = _extension_apply(extension);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+UCLASS_DRIVER(extension) = {
+	.name	= "extension",
+	.id	= UCLASS_EXTENSION,
+};
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 986eeeba807..721bdb87c8a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -548,7 +548,7 @@ config CMD_FDT
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
-	depends on SUPPORT_EXTENSION_SCAN
+	depends on SUPPORT_EXTENSION_SCAN || SUPPORT_DM_EXTENSION_SCAN
 	help
 	  Enables the "extension" command, which allows to detect
 	  extension boards connected to the system, and apply
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 78d937ee6b6..d70394f36c7 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -4,6 +4,7 @@
  * Köry Maincent, Bootlin, <kory.maincent@bootlin.com>
  */
 
+#include <alist.h>
 #include <exports.h>
 #include <command.h>
 #include <extension_board.h>
@@ -13,9 +14,28 @@ LIST_HEAD(extension_list);
 static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
+	struct alist *dm_extension_list;
+#endif
 	struct extension *extension;
 	int i = 0;
 
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
+	dm_extension_list = dm_extension_get_list();
+
+	if (!alist_get_ptr(dm_extension_list, 0)) {
+		printf("No extension registered - Please run \"extension scan\"\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	alist_for_each(extension, dm_extension_list) {
+		printf("Extension %d: %s\n", i++, extension->name);
+		printf("\tManufacturer: \t\t%s\n", extension->owner);
+		printf("\tVersion: \t\t%s\n", extension->version);
+		printf("\tDevicetree overlay: \t%s\n", extension->overlay);
+		printf("\tOther information: \t%s\n", extension->other);
+	}
+#else
 	if (list_empty(&extension_list)) {
 		printf("No extension registered - Please run \"extension scan\"\n");
 		return CMD_RET_SUCCESS;
@@ -28,6 +48,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 		printf("\tDevicetree overlay: \t%s\n", extension->overlay);
 		printf("\tOther information: \t%s\n", extension->other);
 	}
+#endif
 	return CMD_RET_SUCCESS;
 }
 
@@ -36,9 +57,19 @@ static int do_extension_scan(struct cmd_tbl *cmdtp, int flag,
 {
 	int extension_num;
 
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
+	extension_num = dm_extension_scan();
+	if (extension_num == -ENODEV)
+		extension_num = 0;
+	else if (extension_num < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Found %d extension board(s).\n", extension_num);
+#else
 	extension_num = extension_scan(true);
-	if (extension_num < 0)
+	if (extension_num < 0 && extension_num != -ENODEV)
 		return CMD_RET_FAILURE;
+#endif
 
 	return CMD_RET_SUCCESS;
 }
@@ -46,22 +77,34 @@ static int do_extension_scan(struct cmd_tbl *cmdtp, int flag,
 static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
 			      int argc, char *const argv[])
 {
+#if !CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
 	struct extension *extension = NULL;
-	int i = 0, extension_id, ret;
 	struct list_head *entry;
+	int i = 0;
+#endif
+	int extension_id, ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
 	if (strcmp(argv[1], "all") == 0) {
 		ret = CMD_RET_FAILURE;
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
+		if (dm_extension_apply_all())
+			return CMD_RET_FAILURE;
+#else
 		list_for_each_entry(extension, &extension_list, list) {
 			ret = extension_apply(extension);
 			if (ret != CMD_RET_SUCCESS)
 				break;
 		}
+#endif
 	} else {
 		extension_id = simple_strtol(argv[1], NULL, 10);
+#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
+		if (dm_extension_apply(extension_id))
+			return CMD_RET_FAILURE;
+#else
 		list_for_each(entry, &extension_list) {
 			if (i == extension_id) {
 				extension = list_entry(entry, struct extension,  list);
@@ -76,9 +119,10 @@ static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
 		}
 
 		ret = extension_apply(extension);
+#endif
 	}
 
-	return ret;
+	return CMD_RET_SUCCESS;
 }
 
 static struct cmd_tbl cmd_extension[] = {
diff --git a/doc/usage/cmd/extension.rst b/doc/usage/cmd/extension.rst
index 4c261e74951..d82c3fbef0a 100644
--- a/doc/usage/cmd/extension.rst
+++ b/doc/usage/cmd/extension.rst
@@ -25,9 +25,8 @@ Device Tree overlays depending on the detected extension boards.
 
 The "extension" command comes with three sub-commands:
 
- - "extension scan" makes the generic code call the board-specific
-   extension_board_scan() function to retrieve the list of detected
-   extension boards.
+ - "extension scan" makes the generic code call a board-specific extension
+   function to retrieve the list of detected extension boards.
 
  - "extension list" allows to list the detected extension boards.
 
@@ -98,17 +97,18 @@ Simple extension_board_scan function example
 
 .. code-block:: c
 
-    int extension_board_scan(struct list_head *extension_list)
+    static int foo_extension_board_scan(struct alist *extension_list)
     {
-        struct extension *extension;
+        struct extension extension = {0};
 
-        extension = calloc(1, sizeof(struct extension));
-        snprintf(extension->overlay, sizeof(extension->overlay), "overlay.dtbo");
-        snprintf(extension->name, sizeof(extension->name), "extension board");
-        snprintf(extension->owner, sizeof(extension->owner), "sandbox");
-        snprintf(extension->version, sizeof(extension->version), "1.1");
-        snprintf(extension->other, sizeof(extension->other), "Extension board information");
-        list_add_tail(&extension->list, extension_list);
+        snprintf(extension.overlay, sizeof(extension.overlay), "overlay.dtbo");
+        snprintf(extension.name, sizeof(extension.name), "extension board");
+        snprintf(extension.owner, sizeof(extension.owner), "sandbox");
+        snprintf(extension.version, sizeof(extension.version), "1.1");
+        snprintf(extension.other, sizeof(extension.other), "Extension board information");
+        alist_add(extension_list, extension);
 
         return 1;
     }
+
+    U_BOOT_EXTENSION(foo_extension_name, foo_extension_board_scan);
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 6be59093160..eb6416b5917 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -63,6 +63,7 @@ enum uclass_id {
 	UCLASS_ETH,		/* Ethernet device */
 	UCLASS_ETH_PHY,		/* Ethernet PHY device */
 	UCLASS_EXTCON,		/* External Connector Class */
+	UCLASS_EXTENSION,	/* Extension board */
 	UCLASS_FFA,		/* Arm Firmware Framework for Armv8-A */
 	UCLASS_FFA_EMUL,		/* sandbox FF-A device emulator */
 	UCLASS_FIRMWARE,	/* Firmware */
diff --git a/include/extension_board.h b/include/extension_board.h
index 3f70416f005..78139cd7489 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -8,9 +8,51 @@
 #define __EXTENSION_SUPPORT_H
 
 #include <linux/list.h>
+#include <alist.h>
+#include <dm/device.h>
 
 extern struct list_head extension_list;
 
+/**
+ * dm_extension_get_list - Get the extension list
+ * Return: The extension alist pointer, or NULL if no such list exists.
+ */
+struct alist *dm_extension_get_list(void);
+
+/**
+ * dm_extension_probe - Probe extension device
+ * @dev: Extension device that needs to be probed
+ * Return: Zero on success, negative on failure.
+ */
+int dm_extension_probe(struct udevice *dev);
+
+/**
+ * dm_extension_remove - Remove extension device
+ * @dev: Extension device that needs to be removed
+ * Return: Zero on success, negative on failure.
+ */
+int dm_extension_remove(struct udevice *dev);
+
+/**
+ * dm_extension_scan - Scan extension boards available.
+ * Return: Zero on success, negative on failure.
+ */
+int dm_extension_scan(void);
+
+/**
+ * dm_extension_apply - Apply extension board overlay to the devicetree
+ * @extension_num: Extension number to be applied
+ * Return: Zero on success, negative on failure.
+ */
+int dm_extension_apply(int extension_num);
+
+/**
+ * dm_extension_apply_all - Apply all extension board overlays to the
+ *			    devicetree
+ * Return: Zero on success, negative on failure.
+ */
+int dm_extension_apply_all(void);
+
 struct extension {
 	struct list_head list;
 	char name[32];
@@ -20,6 +62,28 @@ struct extension {
 	char other[32];
 };
 
+struct extension_ops {
+	/**
+	 * scan - Add system-specific function to scan extension boards.
+	 * @dev: extension device to use
+	 * Return: The number of extension or a negative value in case of
+	 *	   error.
+	 */
+	int (*scan)(struct alist *extension_list);
+};
+
+#define U_BOOT_EXTENSION(_name, _scan_func) \
+	U_BOOT_DRIVER(_name) = { \
+		.name = #_name, \
+		.id = UCLASS_EXTENSION, \
+		.probe = dm_extension_probe, \
+		.remove = dm_extension_remove, \
+		.ops = &(struct extension_ops) { \
+		       .scan = _scan_func, \
+		       }, \
+		.priv_auto = sizeof(struct alist), \
+	}
+
 /**
  * extension_board_scan - Add system-specific function to scan extension board.
  * @param extension_list	List of extension board information to update.

-- 
2.43.0

