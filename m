Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F17CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F74838D5;
	Fri,  3 Oct 2025 18:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2CCDnYcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5302F838B7; Fri,  3 Oct 2025 18:34:48 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E26838CC
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B74184E40EAA;
 Fri,  3 Oct 2025 16:34:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 89D7660683;
 Fri,  3 Oct 2025 16:34:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 127CE102F17C6; 
 Fri,  3 Oct 2025 18:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759509284; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=34+E8pdI1wzFTIAusimbSBpU2C1Wau/8WUpcYmbaDcY=;
 b=2CCDnYcH0/fGrtgfJIbdF3J4fcNdkLoTADIYOyA0gsHrC4CkM51+HQlW8LTko+yBihc8at
 Io6t8+Wi5d3MU8Fh1ssE++dqtWAordSZKz3cJYflrHnNydudLwgIRYgEcA7yg7udyHf2Yy
 CVzdhV1N4ChH9uGdUpkhGp4COQp4XPSHbTmhK16ZhcuiuamKUGyLjJMVBNkySLMt/Fh5vA
 AOkw9Bb83oY5neWdfni0zd48DEkLjn4xaEwl0U0OWLWSANNof8dy9QrcEygj+Gmxt1aYAI
 Dly353yfOAvRhh+/BuwJV+J8ha0VQb+SZBP/f7qSCZhBDlDnrVGAEwDS/6tIUQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Oct 2025 18:33:53 +0200
Subject: [PATCH 13/16] boot: extension: Move overlay apply custom logic to
 command level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-feature_sysboot_extension_board-v1-13-458b8bf85325@bootlin.com>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
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

The extension_overlay_cmd environment variable approach is specific to
the U-Boot extension_board command, while other boot flows (pxe_utils,
bootstd) handle overlay loading differently.

Move the extension_overlay_cmd execution out of the core extension
framework to the command level. This decouples the framework from
command-specific behavior and prepares for future extension support
in other boot flows.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 boot/extension-uclass.c   | 68 +++--------------------------------
 cmd/extension_board.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++--
 include/extension_board.h | 12 ++-----
 3 files changed, 98 insertions(+), 74 deletions(-)

diff --git a/boot/extension-uclass.c b/boot/extension-uclass.c
index 1b21aa08944..840023fa84e 100644
--- a/boot/extension-uclass.c
+++ b/boot/extension-uclass.c
@@ -104,92 +104,34 @@ int extension_scan(void)
 	return ops->scan(extension_list);
 }
 
-static int _extension_apply(const struct extension *extension)
+int extension_apply(struct fdt_header *working_fdt, ulong size)
 {
-	ulong extrasize, overlay_addr;
 	struct fdt_header *blob;
-	char *overlay_cmd;
+	ulong overlay_addr;
 	int ret;
 
-	if (!working_fdt) {
-		printf("No FDT memory address configured. Please configure\n"
-		       "the FDT address via \"fdt addr <address>\" command.\n");
-		return -EINVAL;
-	}
-
-	overlay_cmd = env_get("extension_overlay_cmd");
-	if (!overlay_cmd) {
-		printf("Environment extension_overlay_cmd is missing\n");
-		return -EINVAL;
-	}
-
 	overlay_addr = env_get_hex("extension_overlay_addr", 0);
 	if (!overlay_addr) {
 		printf("Environment extension_overlay_addr is missing\n");
 		return -EINVAL;
 	}
 
-	env_set("extension_overlay_name", extension->overlay);
-	ret = run_command(overlay_cmd, 0);
-	if (ret)
-		return ret;
-
-	extrasize = env_get_hex("filesize", 0);
-	if (!extrasize)
-		return -EINVAL;
-
-	fdt_shrink_to_minimum(working_fdt, extrasize);
+	fdt_shrink_to_minimum(working_fdt, size);
 
 	blob = map_sysmem(overlay_addr, 0);
 	if (!fdt_valid(&blob)) {
-		printf("Invalid overlay devicetree %s\n", extension->overlay);
+		printf("Invalid overlay devicetree\n");
 		return -EINVAL;
 	}
 
 	/* Apply method prints messages on error */
 	ret = fdt_overlay_apply_verbose(working_fdt, blob);
 	if (ret)
-		printf("Failed to apply overlay %s\n", extension->overlay);
+		printf("Failed to apply overlay\n");
 
 	return ret;
 }
 
-int extension_apply(int extension_num)
-{
-	struct alist *extension_list = extension_get_list();
-	const struct extension *extension;
-
-	if (!extension_list)
-		return -ENODEV;
-
-	extension = alist_get(extension_list, extension_num,
-			      struct extension);
-	if (!extension) {
-		printf("Wrong extension number\n");
-		return -ENODEV;
-	}
-
-	return _extension_apply(extension);
-}
-
-int extension_apply_all(void)
-{
-	struct alist *extension_list = extension_get_list();
-	const struct extension *extension;
-	int ret;
-
-	if (!extension_list)
-		return -ENODEV;
-
-	alist_for_each(extension, extension_list) {
-		ret = _extension_apply(extension);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 UCLASS_DRIVER(extension) = {
 	.name	= "extension",
 	.id	= UCLASS_EXTENSION,
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index c373397e0fb..86e4795ba8a 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -7,8 +7,90 @@
 #include <alist.h>
 #include <exports.h>
 #include <command.h>
+#include <env.h>
 #include <extension_board.h>
 
+static int
+cmd_extension_load_overlay_from_env(const struct extension *extension,
+				    ulong *filesize)
+{
+	ulong size, overlay_addr;
+	char *overlay_cmd;
+	int ret;
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
+	size = env_get_hex("filesize", 0);
+	if (!size)
+		return -EINVAL;
+
+	*filesize = size;
+	return 0;
+}
+
+static int cmd_extension_apply(int extension_num)
+{
+	struct alist *extension_list = extension_get_list();
+	const struct extension *extension;
+	ulong size;
+	int ret;
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
+	ret = cmd_extension_load_overlay_from_env(extension, &size);
+	if (ret)
+		return ret;
+
+	return extension_apply(working_fdt, size);
+}
+
+static int cmd_extension_apply_all(void)
+{
+	struct alist *extension_list = extension_get_list();
+	const struct extension *extension;
+	int ret;
+
+	if (!extension_list)
+		return -ENODEV;
+
+	alist_for_each(extension, extension_list) {
+		ulong size;
+
+		ret = cmd_extension_load_overlay_from_env(extension, &size);
+		if (ret)
+			return ret;
+
+		ret = extension_apply(working_fdt, size);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
 			     int argc, char *const argv[])
 {
@@ -55,12 +137,18 @@ static int do_extension_apply(struct cmd_tbl *cmdtp, int flag,
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
+	if (!working_fdt) {
+		printf("No FDT memory address configured. Please configure\n"
+		       "the FDT address via \"fdt addr <address>\" command.\n");
+		return -EINVAL;
+	}
+
 	if (strcmp(argv[1], "all") == 0) {
-		if (extension_apply_all())
+		if (cmd_extension_apply_all())
 			return CMD_RET_FAILURE;
 	} else {
 		extension_id = simple_strtol(argv[1], NULL, 10);
-		if (extension_apply(extension_id))
+		if (cmd_extension_apply(extension_id))
 			return CMD_RET_FAILURE;
 	}
 
diff --git a/include/extension_board.h b/include/extension_board.h
index fc9c33ed354..e12c91abb4c 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -41,17 +41,11 @@ int extension_scan(void);
 
 /**
  * extension_apply - Apply extension board overlay to the devicetree
- * @extension_num: Extension number to be applied
+ * @working_fdt: Pointer to working flattened device tree
+ * @size: Size of the devicetree overlay
  * Return: Zero on success, negative on failure.
  */
-int extension_apply(int extension_num);
-
-/**
- * extension_apply_all - Apply all extension board overlays to the
- *			    devicetree
- * Return: Zero on success, negative on failure.
- */
-int extension_apply_all(void);
+int extension_apply(struct fdt_header *working_fdt, ulong size);
 
 struct extension {
 	char name[32];

-- 
2.43.0

