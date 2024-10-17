Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDEED3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DD289295;
	Fri, 18 Oct 2024 01:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WIYvpMWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF6A89279; Fri, 18 Oct 2024 01:25:14 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EF489260
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83a98e107feso50769939f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207511; x=1729812311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WpDAScItvLu1LJn4tnI927VGpvEG8ztx2WV3QKV3GY=;
 b=WIYvpMWAushuu/Fcu9W13jxVQcm3oYMlG2HcfaRxYClpfwE/iVm4jGn3xKUS7JY4HL
 bCIH3F9Qi9Pd6GAm8jUa7AHYKhqjZvRu0Kat69/TE6mzrrSFZDy6VjCVqhsp1l0lP1Qv
 ItHNWj06e+Wmh2xLDSlWP427C0JD+tc+Shp7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207511; x=1729812311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WpDAScItvLu1LJn4tnI927VGpvEG8ztx2WV3QKV3GY=;
 b=eU2jQIuGmfuEeJic7AAlwufSMZyWjtMbnURgYMFTON8KAkTYyyfIRgMmAfGMp8lTy1
 H8c5ZFO5ABQppsl59EYF/lreMEvCabKVeDZ6op5RlyFHfjzEcaZw3KGqVssLikzfxzWX
 rCl+bx4onJVP3trzAUVeVqTZtxqnZ4r084BuPuuzazXxCB0Y5UyW4llADVomjMOudfEr
 N8lyGKELUNxsCtOm8FnHygW2EIqBC4nCGYeESXCYPq9l/mLj9ZepelfFbndIdLgUK6dT
 dnkX4LyMAdBtFl8QDvfXbexBbYfqAZS85iMN2WkZeA4dX1pEWW93up/mv5BsCEhESH81
 9cQQ==
X-Gm-Message-State: AOJu0YydCoZHDAQD7w5dD51Y6ZBaae9JgR7Zv6zsscnAZeP4ejeuAr6d
 y+7B6WOWczXyGiU1FPYRMa/iNCobXUBevLyiwvMgWh/xvJ0caF2m2QYkCiVfS9Yd2dnWxChNtrA
 =
X-Google-Smtp-Source: AGHT+IHcnZqJEVLoDr2W19jRiqslba2HkH6Fog3oZpbh8s6cTfZYcjwO9auamyn2YwY7r4vRQsstDw==
X-Received: by 2002:a05:6e02:1d16:b0:3a3:a1a1:a3ec with SMTP id
 e9e14a558f8ab-3a3f40b745cmr3815585ab.22.1729207511123; 
 Thu, 17 Oct 2024 16:25:11 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:10 -0700 (PDT)
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
Subject: [PATCH 29/34] boot: Update extlinux pxe_getfile_func() to include type
Date: Thu, 17 Oct 2024 17:24:08 -0600
Message-Id: <20241017232413.724808-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

 boot/bootmeth_extlinux.c |  5 +++--
 boot/bootmeth_pxe.c      |  5 +++--
 boot/pxe_utils.c         | 26 ++++++++++++++++----------
 cmd/pxe.c                |  2 +-
 cmd/sysboot.c            |  6 ++++--
 include/pxe_utils.h      | 14 +++++++++++++-
 6 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 085ed9e456f..ece52d2e662 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -68,7 +68,8 @@ static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 }
 
 static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
-			    char *file_addr, ulong *sizep)
+			    char *file_addr, enum image_type_t type,
+			    ulong *sizep)
 {
 	struct extlinux_info *info = ctx->userdata;
 	ulong addr;
@@ -79,7 +80,7 @@ static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 IH_TYPE_INVALID, sizep);
+				 type, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 74b0ad7d2e9..0643d280f21 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -23,7 +23,8 @@
 #include <pxe_utils.h>
 
 static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
-					char *file_addr, ulong *sizep)
+				char *file_addr, enum image_type_t type,
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
index 4fd26524286..5188182f05f 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -97,7 +97,8 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
  * Returns 1 for success, or < 0 on error
  */
 static int get_relfile(struct pxe_context *ctx, const char *file_path,
-		       unsigned long file_addr, ulong *filesizep)
+		       unsigned long file_addr, enum image_type_t type,
+		       ulong *filesizep)
 {
 	size_t path_len;
 	char relfile[MAX_TFTP_PATH_LEN + 1];
@@ -124,7 +125,7 @@ static int get_relfile(struct pxe_context *ctx, const char *file_path,
 
 	sprintf(addr_buf, "%lx", file_addr);
 
-	ret = ctx->getfile(ctx, relfile, addr_buf, &size);
+	ret = ctx->getfile(ctx, relfile, addr_buf, type, &size);
 	if (ret < 0)
 		return log_msg_ret("get", ret);
 	if (filesizep)
@@ -140,7 +141,8 @@ int get_pxe_file(struct pxe_context *ctx, const char *file_path,
 	int err;
 	char *buf;
 
-	err = get_relfile(ctx, file_path, file_addr, &size);
+	err = get_relfile(ctx, file_path, file_addr, IH_TYPE_EXTLINUX_CFG,
+			  &size);
 	if (err < 0)
 		return err;
 
@@ -189,13 +191,15 @@ int get_pxelinux_path(struct pxe_context *ctx, const char *file,
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
+			       const char *envaddr_name, enum image_type_t type,
+			       ulong *filesizep)
 {
 	unsigned long file_addr;
 	char *envaddr;
@@ -207,7 +211,7 @@ static int get_relfile_envaddr(struct pxe_context *ctx, const char *file_path,
 	if (strict_strtoul(envaddr, 16, &file_addr) < 0)
 		return -EINVAL;
 
-	return get_relfile(ctx, file_path, file_addr, filesizep);
+	return get_relfile(ctx, file_path, file_addr, type, filesizep);
 }
 
 /**
@@ -395,7 +399,7 @@ static void label_boot_fdtoverlay(struct pxe_context *ctx,
 
 		/* Load overlay file */
 		err = get_relfile_envaddr(ctx, overlayfile, "fdtoverlay_addr_r",
-					  NULL);
+					  IH_TYPE_FLATDT, NULL);
 		if (err < 0) {
 			printf("Failed loading overlay %s\n", overlayfile);
 			goto skip_overlay;
@@ -480,7 +484,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	}
 
 	if (get_relfile_envaddr(ctx, label->kernel, "kernel_addr_r",
-				NULL) < 0) {
+				IH_TYPE_KERNEL, NULL) < 0) {
 		printf("Skipping %s for failure retrieving kernel\n",
 		       label->name);
 		return 1;
@@ -506,7 +510,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	} else if (label->initrd) {
 		ulong size;
 		if (get_relfile_envaddr(ctx, label->initrd, "ramdisk_addr_r",
-					&size) < 0) {
+					IH_TYPE_RAMDISK, &size) < 0) {
 			printf("Skipping %s for failure retrieving initrd\n",
 			       label->name);
 			goto cleanup;
@@ -651,7 +655,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 
 		if (fdtfile) {
 			int err = get_relfile_envaddr(ctx, fdtfile,
-						      "fdt_addr_r", NULL);
+						      "fdt_addr_r",
+						      IH_TYPE_FLATDT, NULL);
 
 			free(fdtfilefree);
 			if (err < 0) {
@@ -1538,7 +1543,8 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 	if (IS_ENABLED(CONFIG_CMD_BMP)) {
 		/* display BMP if available */
 		if (cfg->bmp) {
-			if (get_relfile(ctx, cfg->bmp, image_load_addr, NULL)) {
+			if (get_relfile(ctx, cfg->bmp, image_load_addr,
+					IH_TYPE_LOGO, NULL)) {
 #if defined(CONFIG_VIDEO)
 				struct udevice *dev;
 
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 982e2b1e7ea..b64a4fce1a7 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -27,7 +27,7 @@ const char *pxe_default_paths[] = {
 };
 
 static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
-		       char *file_addr, ulong *sizep)
+		       char *file_addr, enum image_type_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	int ret;
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 8a060780cab..71936cdb1cd 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -23,7 +23,8 @@ struct sysboot_info {
 };
 
 static int sysboot_read_file(struct pxe_context *ctx, const char *file_path,
-			     char *file_addr, ulong *sizep)
+			     char *file_addr, enum image_type_t type,
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
index 68ac40b64ad..ec5d8af5709 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -3,6 +3,7 @@
 #ifndef __PXE_UTILS_H
 #define __PXE_UTILS_H
 
+#include <image.h>
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
+				char *file_addr, enum image_type_t type,
+				ulong *filesizep);
 
 /**
  * struct pxe_context - context information for PXE parsing
-- 
2.34.1

