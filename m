Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9DCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6735784531;
	Thu,  9 Oct 2025 16:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TentiyL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150F48441D; Thu,  9 Oct 2025 16:51:03 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A9183F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9A64EC035A8;
 Thu,  9 Oct 2025 14:50:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3310C6062C;
 Thu,  9 Oct 2025 14:50:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0B0A4102F21E7; 
 Thu,  9 Oct 2025 16:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760021458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=72JaW3MwjAZQBNPVsdhK51zdNEOUXeJhnIh35N6Riwg=;
 b=TentiyL7zjnFDaxwGvjbR5M2Fw0nRwBTHyxACGozzEWYBA8y01q3B4MNMiKaFyGfMbYoYc
 jejGnCUV/RFRhKkqDvSSM9W5IbSVDx6AEo9n9RHzmtVf9KFa1km8dIzNmsN9PS6kmzaJdO
 Yiyam1TKJBH0BayMWsMNhiCrP2w23WKpkRmZHPx3Fodh4++lNHzmxD+shqLw50rNvuF3LY
 NXGnHxX0zJF6QdiEB0SyLIqJ8GZWI3rB80iwrpBrfYnU7PII3ilUy6DrZ7WPqbd/eTf1cx
 IzDCt9HxC1dZ1pM8erXyX887dBhTh1rplaBhwV8eqWtCP+Byc92Qf6m/rkksLA==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 09 Oct 2025 16:50:38 +0200
Subject: [PATCH v2 02/18] boot: Move extension board support from cmd/ to boot/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-feature_sysboot_extension_board-v2-2-e09b39e54de5@bootlin.com>
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

Relocate extension board support from cmd/ to boot/ directory in
preparation for converting the extension framework to use UCLASS.
Also improve code style by applying reverse Christmas tree ordering.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 MAINTAINERS               |  1 +
 boot/Kconfig              |  3 ++
 boot/Makefile             |  1 +
 boot/extension.c          | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig               |  3 --
 cmd/extension_board.c     | 99 ++---------------------------------------------
 include/extension_board.h | 16 ++++++++
 7 files changed, 122 insertions(+), 98 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e411e266c94..c67d5ae9d6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1187,6 +1187,7 @@ M:	Kory Maincent <kory.maincent@bootlin.com>
 S:	Maintained
 F:	board/sunxi/chip.c
 F:	board/ti/common/cape_detect.c
+F:	boot/extension.c
 F:	cmd/extension_board.c
 F:	include/extension_board.h
 
diff --git a/boot/Kconfig b/boot/Kconfig
index dd047365754..62aa301f18f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1906,6 +1906,9 @@ endmenu
 
 endif # OF_LIBFDT
 
+config SUPPORT_EXTENSION_SCAN
+        bool
+
 config USE_BOOTARGS
 	bool "Enable boot arguments"
 	help
diff --git a/boot/Makefile b/boot/Makefile
index 3da6f7a0914..f60d13130b1 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BOOT_RETRY) += bootretry.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
+obj-$(CONFIG_SUPPORT_EXTENSION_SCAN) += extension.o
 
 obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
 
diff --git a/boot/extension.c b/boot/extension.c
new file mode 100644
index 00000000000..fc9e1d398f4
--- /dev/null
+++ b/boot/extension.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2025 Köry Maincent <kory.maincent@bootlin.com>
+ */
+
+#include <bootdev.h>
+#include <command.h>
+#include <env.h>
+#include <extension_board.h>
+#include <fdt_support.h>
+#include <malloc.h>
+#include <mapmem.h>
+
+int extension_apply(struct extension *extension)
+{
+	ulong extrasize, overlay_addr;
+	struct fdt_header *blob;
+	char *overlay_cmd;
+
+	if (!working_fdt) {
+		printf("No FDT memory address configured. Please configure\n"
+		       "the FDT address via \"fdt addr <address>\" command.\n");
+		return CMD_RET_FAILURE;
+	}
+
+	overlay_cmd = env_get("extension_overlay_cmd");
+	if (!overlay_cmd) {
+		printf("Environment extension_overlay_cmd is missing\n");
+		return CMD_RET_FAILURE;
+	}
+
+	overlay_addr = env_get_hex("extension_overlay_addr", 0);
+	if (!overlay_addr) {
+		printf("Environment extension_overlay_addr is missing\n");
+		return CMD_RET_FAILURE;
+	}
+
+	env_set("extension_overlay_name", extension->overlay);
+	if (run_command(overlay_cmd, 0) != 0)
+		return CMD_RET_FAILURE;
+
+	extrasize = env_get_hex("filesize", 0);
+	if (!extrasize)
+		return CMD_RET_FAILURE;
+
+	fdt_shrink_to_minimum(working_fdt, extrasize);
+
+	blob = map_sysmem(overlay_addr, 0);
+	if (!fdt_valid(&blob))
+		return CMD_RET_FAILURE;
+
+	/* apply method prints messages on error */
+	if (fdt_overlay_apply_verbose(working_fdt, blob))
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+int extension_scan(bool show)
+{
+	struct extension *extension, *next;
+	int extension_num;
+
+	list_for_each_entry_safe(extension, next, &extension_list, list) {
+		list_del(&extension->list);
+		free(extension);
+	}
+	extension_num = extension_board_scan(&extension_list);
+	if (show && extension_num >= 0)
+		printf("Found %d extension board(s).\n", extension_num);
+
+	/* either the number of extensions, or -ve for error */
+	return extension_num;
+}
+
+static int extension_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	int ret;
+
+	ret = env_set_hex("extension_overlay_addr",
+			  env_get_hex("fdtoverlay_addr_r", 0));
+	if (ret)
+		return log_msg_ret("env", ret);
+
+	ret = extension_scan(show);
+	if (ret < 0)
+		return log_msg_ret("ext", ret);
+
+	return 0;
+}
+
+/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass */
+BOOTDEV_HUNTER(extension_bootdev_hunter) = {
+	.prio		= BOOTDEVP_1_PRE_SCAN,
+	.uclass		= UCLASS_SIMPLE_BUS,
+	.hunt		= extension_bootdev_hunt,
+};
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c..986eeeba807 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -545,9 +545,6 @@ config CMD_FDT
 	help
 	  Do FDT related setup before booting into the Operating System.
 
-config SUPPORT_EXTENSION_SCAN
-	bool
-
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 317b260bf36..78d937ee6b6 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -4,68 +4,17 @@
  * Köry Maincent, Bootlin, <kory.maincent@bootlin.com>
  */
 
-#include <bootdev.h>
+#include <exports.h>
 #include <command.h>
-#include <dm.h>
-#include <env.h>
-#include <malloc.h>
 #include <extension_board.h>
-#include <mapmem.h>
-#include <linux/libfdt.h>
-#include <fdt_support.h>
 
-static LIST_HEAD(extension_list);
-
-static int extension_apply(struct extension *extension)
-{
-	char *overlay_cmd;
-	ulong extrasize, overlay_addr;
-	struct fdt_header *blob;
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
+LIST_HEAD(extension_list);
 
 static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
-	int i = 0;
 	struct extension *extension;
+	int i = 0;
 
 	if (list_empty(&extension_list)) {
 		printf("No extension registered - Please run \"extension scan\"\n");
@@ -82,23 +31,6 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 	return CMD_RET_SUCCESS;
 }
 
-static int extension_scan(bool show)
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
 static int do_extension_scan(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
@@ -115,8 +47,8 @@ static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
 			      int argc, char *const argv[])
 {
 	struct extension *extension = NULL;
-	struct list_head *entry;
 	int i = 0, extension_id, ret;
+	struct list_head *entry;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -177,26 +109,3 @@ U_BOOT_CMD(extension, 3, 1, do_extensionops,
 	"extension list - lists available extension(s) board(s)\n"
 	"extension apply <extension number|all> - applies DT overlays corresponding to extension boards\n"
 );
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
diff --git a/include/extension_board.h b/include/extension_board.h
index 22e4104bc54..3f70416f005 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -9,6 +9,8 @@
 
 #include <linux/list.h>
 
+extern struct list_head extension_list;
+
 struct extension {
 	struct list_head list;
 	char name[32];
@@ -30,4 +32,18 @@ struct extension {
  */
 int extension_board_scan(struct list_head *extension_list);
 
+/**
+ * extension_apply - Apply extension board overlay to the devicetree
+ * @extension: Extension to be applied
+ * Return: Zero on success, negative on failure.
+ */
+int extension_apply(struct extension *extension);
+
+/**
+ * extension_scan - Scan extension boards available.
+ * @show: Flag to enable verbose log
+ * Return: Zero on success, negative on failure.
+ */
+int extension_scan(bool show);
+
 #endif /* __EXTENSION_SUPPORT_H */

-- 
2.43.0

