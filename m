Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E28D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAB08900E;
	Mon,  4 Nov 2024 18:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qff/gxhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B891788FE2; Mon,  4 Nov 2024 18:51:40 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1478289025
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83ab00438acso135581839f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742696; x=1731347496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZH6FPz84MKIRwsM7KYkgPti6UFn5FOGrNJcsQaNEoM=;
 b=Qff/gxhFW1+tWFuob3YK8SbJSnLZUG/GsckkSDVKykKlbjCCesXLTC0dN4pTqYJ6yy
 OssfAIcGqyODmJTPY1yLWdqYWfl8yGKRKQp9J0EgenSXF9DwKfgcbiTx2xqAhyCJ/oyP
 O22k5zk5EMFMo9cwdtC+5ZuZlcw448okCJahg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742696; x=1731347496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZH6FPz84MKIRwsM7KYkgPti6UFn5FOGrNJcsQaNEoM=;
 b=KAFCwf671xjZlD240ZAOSP4pgYTfiWYtzRpZJPAaYihGRZ3r8P7HJXnWpnku6DNBZh
 7faOVcePHVDaAncnQYulOmpCjYCLK85wu1Ktzm6+H11miuhMop0vcuXZyHywSLj3HIYH
 oJ0NEiiH7QDUxhKJzYaHymFhhhhXsH9IVTY88m47M4SG30VkU8eA4j6NTMtxPMxc9q53
 qykOp1AF0Bwv9mfZsXDPPCHYglTEWL5BojRhVQ5TyMroaK8FHEZtEgWrw8PSU0wtD2R5
 faAWNXm/kDbO3jhE615wSsGwSNjL7I+9icLeSM4yFm1uHjUPDFhewY84oqVy45AsRBwJ
 E3Qw==
X-Gm-Message-State: AOJu0YyI+esrmDSJXShWAvnrW4EBhQCnj4v4iGXvAyn3sogGS9a3xNzs
 7o1TScvGMIv0TUoKKPiTgMl4lt632qRbtaib3NwEAmP99z1ChRzNXbdYtB1IAp23i8euMdruMzI
 =
X-Google-Smtp-Source: AGHT+IEmWXCwF1+yUa6nheKb4nmbrGmQYDGEPYnY5N9Bm0NzAQ9JQ1V5VSgSYcKK0jhwo+D/Cn9M9g==
X-Received: by 2002:a6b:7e44:0:b0:805:2048:a492 with SMTP id
 ca18e2360f4ac-83b7133cf86mr1024444039f.6.1730742696180; 
 Mon, 04 Nov 2024 09:51:36 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 12/19] boot: Update extlinux pxe_getfile_func() to include
 type
Date: Mon,  4 Nov 2024 10:51:03 -0700
Message-Id: <20241104175110.1048449-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

Add a file-type parameter to this function and update all users. Add a
proper comment to the function which we are here.

This will allow tracking of the file types loaded by the extlinux
bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth_extlinux.c |  5 +++--
 boot/bootmeth_pxe.c      |  5 +++--
 boot/pxe_utils.c         | 26 ++++++++++++++++++--------
 cmd/pxe.c                |  2 +-
 cmd/sysboot.c            |  6 ++++--
 include/pxe_utils.h      | 14 +++++++++++++-
 6 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ae5ae4dbb34..63cb9a4a8af 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -68,7 +68,8 @@ static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 }
 
 static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
-			    char *file_addr, ulong *sizep)
+			    char *file_addr, enum bootflow_img_t type,
+			    ulong *sizep)
 {
 	struct extlinux_info *info = ctx->userdata;
 	ulong addr;
@@ -79,7 +80,7 @@ static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 (enum bootflow_img_t)IH_TYPE_INVALID, sizep);
+				 type, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index e64429f6857..b2873075ba5 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -23,7 +23,8 @@
 #include <pxe_utils.h>
 
 static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
-					char *file_addr, ulong *sizep)
+				char *file_addr, enum bootflow_img_t type,
+				ulong *sizep)
 {
 	struct extlinux_info *info = ctx->userdata;
 	ulong addr;
@@ -34,7 +35,7 @@ static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 IH_TYPE_INVALID, sizep);
+				 type, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 4fd26524286..03d0ab8c578 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -6,6 +6,7 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <bootflow.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
@@ -97,7 +98,8 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
  * Returns 1 for success, or < 0 on error
  */
 static int get_relfile(struct pxe_context *ctx, const char *file_path,
-		       unsigned long file_addr, ulong *filesizep)
+		       unsigned long file_addr, enum bootflow_img_t type,
+		       ulong *filesizep)
 {
 	size_t path_len;
 	char relfile[MAX_TFTP_PATH_LEN + 1];
@@ -124,7 +126,7 @@ static int get_relfile(struct pxe_context *ctx, const char *file_path,
 
 	sprintf(addr_buf, "%lx", file_addr);
 
-	ret = ctx->getfile(ctx, relfile, addr_buf, &size);
+	ret = ctx->getfile(ctx, relfile, addr_buf, type, &size);
 	if (ret < 0)
 		return log_msg_ret("get", ret);
 	if (filesizep)
@@ -140,7 +142,8 @@ int get_pxe_file(struct pxe_context *ctx, const char *file_path,
 	int err;
 	char *buf;
 
-	err = get_relfile(ctx, file_path, file_addr, &size);
+	err = get_relfile(ctx, file_path, file_addr, BFI_EXTLINUX_CFG,
+			  &size);
 	if (err < 0)
 		return err;
 
@@ -189,13 +192,15 @@ int get_pxelinux_path(struct pxe_context *ctx, const char *file,
  * @file_path: File path to read (relative to the PXE file)
  * @envaddr_name: Name of environment variable which contains the address to
  *	load to
+ * @type: File type
  * @filesizep: Returns the file size in bytes
  * Returns 1 on success, -ENOENT if @envaddr_name does not exist as an
  *	environment variable, -EINVAL if its format is not valid hex, or other
  *	value < 0 on other error
  */
 static int get_relfile_envaddr(struct pxe_context *ctx, const char *file_path,
-			       const char *envaddr_name, ulong *filesizep)
+			       const char *envaddr_name,
+			       enum bootflow_img_t type, ulong *filesizep)
 {
 	unsigned long file_addr;
 	char *envaddr;
@@ -207,7 +212,7 @@ static int get_relfile_envaddr(struct pxe_context *ctx, const char *file_path,
 	if (strict_strtoul(envaddr, 16, &file_addr) < 0)
 		return -EINVAL;
 
-	return get_relfile(ctx, file_path, file_addr, filesizep);
+	return get_relfile(ctx, file_path, file_addr, type, filesizep);
 }
 
 /**
@@ -395,6 +400,7 @@ static void label_boot_fdtoverlay(struct pxe_context *ctx,
 
 		/* Load overlay file */
 		err = get_relfile_envaddr(ctx, overlayfile, "fdtoverlay_addr_r",
+					  (enum bootflow_img_t)IH_TYPE_FLATDT,
 					  NULL);
 		if (err < 0) {
 			printf("Failed loading overlay %s\n", overlayfile);
@@ -480,7 +486,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	}
 
 	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
-				NULL) < 0) {
+				(enum bootflow_img_t)IH_TYPE_KERNEL, NULL)
+				< 0) {
 		printf("Skipping %s for failure retrieving kernel\n",
 		       label->name);
 		return 1;
@@ -506,6 +513,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	} else if (label->initrd) {
 		ulong size;
 		if (get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
+					(enum bootflow_img_t)IH_TYPE_RAMDISK,
 					&size) < 0) {
 			printf("Skipping %s for failure retrieving initrd\n",
 			       label->name);
@@ -651,7 +659,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 
 		if (fdtfile) {
 			int err = get_relfile_envaddr(ctx, fdtfile,
-						      "fdt_addr_r", NULL);
+				"fdt_addr_r",
+				 (enum bootflow_img_t)IH_TYPE_FLATDT, NULL);
 
 			free(fdtfilefree);
 			if (err < 0) {
@@ -1538,7 +1547,8 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 	if (IS_ENABLED(CONFIG_CMD_BMP)) {
 		/* display BMP if available */
 		if (cfg->bmp) {
-			if (get_relfile(ctx, cfg->bmp, image_load_addr, NULL)) {
+			if (get_relfile(ctx, cfg->bmp, image_load_addr,
+					BFI_LOGO, NULL)) {
 #if defined(CONFIG_VIDEO)
 				struct udevice *dev;
 
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 982e2b1e7ea..37b8dea6ad6 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -27,7 +27,7 @@ const char *pxe_default_paths[] = {
 };
 
 static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
-		       char *file_addr, ulong *sizep)
+		       char *file_addr, enum bootflow_img_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	int ret;
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 8a060780cab..93d4a400830 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -23,7 +23,8 @@ struct sysboot_info {
 };
 
 static int sysboot_read_file(struct pxe_context *ctx, const char *file_path,
-			     char *file_addr, ulong *sizep)
+			     char *file_addr, enum bootflow_img_t type,
+			     ulong *sizep)
 {
 	struct sysboot_info *info = ctx->userdata;
 	loff_t len_read;
@@ -110,7 +111,8 @@ static int do_sysboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	if (get_pxe_file(&ctx, filename, pxefile_addr_r) < 0) {
+	if (get_pxe_file(&ctx, filename, pxefile_addr_r)
+	    < 0) {
 		printf("Error reading config file\n");
 		pxe_destroy_ctx(&ctx);
 		return 1;
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 68ac40b64ad..0378f2889f7 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -3,6 +3,7 @@
 #ifndef __PXE_UTILS_H
 #define __PXE_UTILS_H
 
+#include <bootflow.h>
 #include <linux/list.h>
 
 /*
@@ -82,8 +83,19 @@ struct pxe_menu {
 };
 
 struct pxe_context;
+
+/**
+ * Read a file
+ *
+ * @ctx: PXE context
+ * @file_path: Full path to filename to read
+ * @file_addr: String containing the to which to read the file
+ * @type: File type
+ * @fileszeip: Returns file size
+ */
 typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
-				char *file_addr, ulong *filesizep);
+				char *file_addr, enum bootflow_img_t type,
+				ulong *filesizep);
 
 /**
  * struct pxe_context - context information for PXE parsing
-- 
2.34.1

