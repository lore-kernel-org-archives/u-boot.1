Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C43CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF14839DF;
	Thu, 30 Oct 2025 17:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xNJdiZJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE36839C7; Thu, 30 Oct 2025 17:45:46 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9623B839D5
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 509431A1782;
 Thu, 30 Oct 2025 16:45:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2666B60331;
 Thu, 30 Oct 2025 16:45:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 263BA11808C40; Thu, 30 Oct 2025 17:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gKC9OOhM9mpInXSTDo7HD92DAun3ZzTVrDXwpjxaH18=;
 b=xNJdiZJmBCBw4J+9aUsNIDMEw98jk1vI2KQUqTeuxnZUONr+WpukKwtb8rMwbfeI4REfbG
 z6UJaWM+CmWn1feTKafMQwSBN/w++5PFCFiFUW1Iu5EwSd4JpbwV8R2/RT202gDqrK1yLA
 ppZJ8Kgug5DakXynOG3AHEg8y/Wb/oAZlxdqZ9f4Xz/kbGvZmrxrAlLkSkFw7KwHr1b3pB
 8r1sXNiHnF0dj3eH3LrikxyDv1BaS5NQDBw2PRhfCcArGZIRN0fF76bFNWweQBJs6jYmLe
 i2DssALOV48Ul6sH0sqQ09tlc4wajpMeIKYeHQOEKQpaXDXd1g2q8mEgZS7s8g==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:10 +0100
Subject: [PATCH v5 17/20] boot: extension: Move overlay apply custom logic
 to command level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-17-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
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
X-Mailer: b4 0.14.3
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

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 boot/extension-uclass.c   | 68 +++--------------------------------
 cmd/extension_board.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++--
 include/extension_board.h | 12 ++-----
 3 files changed, 98 insertions(+), 74 deletions(-)

diff --git a/boot/extension-uclass.c b/boot/extension-uclass.c
index 35f751237eb..4b3dd1bc0cd 100644
--- a/boot/extension-uclass.c
+++ b/boot/extension-uclass.c
@@ -59,92 +59,34 @@ int extension_scan(void)
 	return ops->scan(dev, extension_list);
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
-		return -ENOENT;
-
-	extension = alist_get(extension_list, extension_num,
-			      struct extension);
-	if (!extension) {
-		printf("Wrong extension number\n");
-		return -EINVAL;
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
-		return -ENOENT;
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
index 451e8ed832d..0b9fb99ad7d 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -44,17 +44,11 @@ int extension_scan(void);
 
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
 
 /**
  * extension - Description fields of an extension board

-- 
2.43.0

