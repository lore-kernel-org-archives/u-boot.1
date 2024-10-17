Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F21D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CE8891E3;
	Fri, 18 Oct 2024 01:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwj6bvxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CBA89257; Fri, 18 Oct 2024 01:25:12 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15FA389258
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a3b8964134so5708605ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207509; x=1729812309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0vPiJ80MM+SQlHfaXz/BW5mIpgp5x2rh/hX4RegKoc=;
 b=kwj6bvxq417AY7knYcOJlbIYflU7qGP+lV7MlqW+LOdfRjAUaZo+LFvLXi7ac4cRxi
 XHTX0eq6L2eLGEIDOtZZGnjxJhy05l3GUBW7TmQBf2pW6TrxRt99dgYmZclbt4aXvwv3
 o0tZMGrFZA1rGYt1mO9G9IssisC9D82Hnh7dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207509; x=1729812309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0vPiJ80MM+SQlHfaXz/BW5mIpgp5x2rh/hX4RegKoc=;
 b=Ujnjjws89v7kvank1n/MRxewA9bVREPMUmaR3UT9pcqGVK/lfH+g7A2pWn5ga2S4SP
 3bDuxqGUbMrWOeVvZIGK7jxukfcSYsWTuEpTQBbw+f7HzS3GlPPOllRNsSvxl+GKgr7M
 YapcZFmp+BByro24qUELTzbUzgk2OYYc21VwYnuDSAetX76OIskG1P41IbikkvL6PkHH
 XpJ6kJBViO3zT1lHYwr7NJMum0eDJxJWIA2EG341iSI0PzctTCJLJeWoNZVu05u9qw/d
 8AtO8lvuVgXOyF5KtKuCqCfwPjYW6qANhTR//oTVHFGZm7fRiIjUKNaPfp4zb1goNm9b
 CD7w==
X-Gm-Message-State: AOJu0YxfH4izk5Sw5kmNwsRb06Vu+s6XUHZVGv2dHhvsC+uqc0XKk8RO
 gvwlUWHXOSUPx/pJKDb4LjzdoTZs3tFnaO4CjOtih5cqsTs80ucnxCUELM35bZu8til7AHh8+5g
 =
X-Google-Smtp-Source: AGHT+IEk28beLeO9SfcQBvTB1xb7oEwr7LC7HWeXaRL8/djpnVrV1MiMgWwPHhbWDJPacO+VCS2q+g==
X-Received: by 2002:a05:6e02:2169:b0:3a3:b527:e809 with SMTP id
 e9e14a558f8ab-3a3f406326amr3838065ab.14.1729207508559; 
 Thu, 17 Oct 2024 16:25:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 27/34] bootmeth: Update the read_file() method to include a
 type
Date: Thu, 17 Oct 2024 17:24:06 -0600
Message-Id: <20241017232413.724808-28-sjg@chromium.org>
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

We want to record the type of each file which is loaded. Add an new
parameter for this, to the read_file() method. Update all users.

Make bootmeth_common_read_file() store information about the image that
is read.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth-uclass.c   | 22 +++++++++++++++++++---
 boot/bootmeth_android.c  |  3 ++-
 boot/bootmeth_cros.c     |  3 ++-
 boot/bootmeth_efi.c      |  5 +++--
 boot/bootmeth_efi_mgr.c  |  3 ++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_pxe.c      |  6 +++---
 boot/bootmeth_qfw.c      |  3 ++-
 boot/bootmeth_sandbox.c  |  3 ++-
 boot/vbe_simple.c        |  5 +++--
 include/bootmeth.h       | 12 +++++++++---
 11 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 34fff004b43..726393e20b8 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -84,14 +84,15 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow)
 }
 
 int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
-		       const char *file_path, ulong addr, ulong *sizep)
+		       const char *file_path, ulong addr,
+		       enum image_type_t type, ulong *sizep)
 {
 	const struct bootmeth_ops *ops = bootmeth_get_ops(dev);
 
 	if (!ops->read_file)
 		return -ENOSYS;
 
-	return ops->read_file(dev, bflow, file_path, addr, sizep);
+	return ops->read_file(dev, bflow, file_path, addr, type, sizep);
 }
 
 int bootmeth_get_bootflow(struct udevice *dev, struct bootflow *bflow)
@@ -399,11 +400,14 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 }
 
 int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
-			      const char *file_path, ulong addr, ulong *sizep)
+			      const char *file_path, ulong addr,
+			      enum image_type_t type, ulong *sizep)
 {
 	struct blk_desc *desc = NULL;
+	struct bootflow_img *img;
 	loff_t len_read;
 	loff_t size;
+	char *fname;
 	int ret;
 
 	if (bflow->blk)
@@ -428,6 +432,18 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
 		return ret;
 	*sizep = len_read;
 
+	fname = strdup(bflow->fname);
+	if (!fname)
+		return log_msg_ret("crf", -ENOMEM);
+
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("cri", -ENOMEM);
+	img->fname = fname;
+	img->type = type;
+	img->addr = addr;
+	img->size = len_read;
+
 	return 0;
 }
 
diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b..0c7d3449ac7 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -298,7 +298,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int android_read_file(struct udevice *dev, struct bootflow *bflow,
-			     const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum image_type_t type, ulong *sizep)
 {
 	/*
 	 * Reading individual files is not supported since we only
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 676f550ca25..3e60fd5da07 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -400,7 +400,8 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int cros_read_file(struct udevice *dev, struct bootflow *bflow,
-			 const char *file_path, ulong addr, ulong *sizep)
+			 const char *file_path, ulong addr,
+			  enum image_type_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f3ddbe71405..e1e378481b9 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -117,7 +117,7 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 		 desc = dev_get_uclass_plat(bflow->blk);
 
 	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
-					addr, &size);
+					addr, IH_TYPE_EFI, &size);
 
 	set_efi_bootdev(desc, bflow);
 
@@ -189,7 +189,8 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 			/* Limit FDT files to 4MB */
 			size = SZ_4M;
 			ret = bootmeth_common_read_file(dev, bflow, fname,
-							fdt_addr, &size);
+							fdt_addr,
+							IH_TYPE_FLATDT, &size);
 		}
 	}
 
diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 23ae1e610ac..b2b235d4915 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -74,7 +74,8 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
-				const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum image_type_t type, ulong *sizep)
 {
 	/* Files are loaded by the 'bootefi bootmgr' command */
 
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 755a80350d9..085ed9e456f 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -79,7 +79,7 @@ static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 sizep);
+				 IH_TYPE_INVALID, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 05c6bece2c1..74b0ad7d2e9 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -23,7 +23,7 @@
 #include <pxe_utils.h>
 
 static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
-				char *file_addr, ulong *sizep)
+					char *file_addr, ulong *sizep)
 {
 	struct extlinux_info *info = ctx->userdata;
 	ulong addr;
@@ -34,7 +34,7 @@ static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 sizep);
+				 IH_TYPE_INVALID, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
@@ -113,7 +113,7 @@ static int extlinux_pxe_read_bootflow(struct udevice *dev,
 
 static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 				  const char *file_path, ulong addr,
-				  ulong *sizep)
+				  enum image_type_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	struct pxe_context *ctx = dev_get_priv(dev);
diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
index 2f8e00cf350..fb3cde4ab4b 100644
--- a/boot/bootmeth_qfw.c
+++ b/boot/bootmeth_qfw.c
@@ -52,7 +52,8 @@ static int qfw_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int qfw_read_file(struct udevice *dev, struct bootflow *bflow,
-			 const char *file_path, ulong addr, ulong *sizep)
+			 const char *file_path, ulong addr,
+			 enum image_type_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
index 26c713bb5f3..c40e8ae3304 100644
--- a/boot/bootmeth_sandbox.c
+++ b/boot/bootmeth_sandbox.c
@@ -27,7 +27,8 @@ static int sandbox_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int sandbox_read_file(struct udevice *dev, struct bootflow *bflow,
-			     const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum image_type_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index 189e86d2a22..c51b7d5805b 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -160,13 +160,14 @@ static int vbe_simple_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int vbe_simple_read_file(struct udevice *dev, struct bootflow *bflow,
-				const char *file_path, ulong addr, ulong *sizep)
+				const char *file_path, ulong addr,
+				enum image_type_t type, ulong *sizep)
 {
 	int ret;
 
 	if (vbe_phase() == VBE_PHASE_OS) {
 		ret = bootmeth_common_read_file(dev, bflow, file_path, addr,
-						sizep);
+						type, sizep);
 		if (ret)
 			return log_msg_ret("os", ret);
 	}
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 322169c6b2e..78b2ce4123b 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -118,13 +118,15 @@ struct bootmeth_ops {
 	 * @bflow:	Bootflow providing info on where to read from
 	 * @file_path:	Path to file (may be absolute or relative)
 	 * @addr:	Address to load file
+	 * @type:	File type (IH_TYPE_...)
 	 * @sizep:	On entry provides the maximum permitted size; on exit
 	 *		returns the size of the file
 	 * Return: 0 if OK, -ENOSPC if the file is too large for @sizep, other
 	 *	-ve value if something else goes wrong
 	 */
 	int (*read_file)(struct udevice *dev, struct bootflow *bflow,
-			 const char *file_path, ulong addr, ulong *sizep);
+			 const char *file_path, ulong addr,
+			 enum image_type_t type, ulong *sizep);
 #if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 	/**
 	 * readall() - read all files for a bootflow
@@ -246,13 +248,15 @@ int bootmeth_set_bootflow(struct udevice *dev, struct bootflow *bflow,
  * @bflow:	Bootflow providing info on where to read from
  * @file_path:	Path to file (may be absolute or relative)
  * @addr:	Address to load file
+ * @type:	File type (IH_TYPE_...)
  * @sizep:	On entry provides the maximum permitted size; on exit
  *		returns the size of the file
  * Return: 0 if OK, -ENOSPC if the file is too large for @sizep, other
  *	-ve value if something else goes wrong
  */
 int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
-		       const char *file_path, ulong addr, ulong *sizep);
+		       const char *file_path, ulong addr,
+		       enum image_type_t type, ulong *sizep);
 
 /**
  * bootmeth_read_all() - read all bootflow files
@@ -398,11 +402,13 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
  * @bflow: Bootflow information
  * @file_path: Path to file
  * @addr: Address to load file to
+ * @type: File type (IH_TYPE_...)
  * @sizep: On entry, the maximum file size to accept, on exit the actual file
  *	size read
  */
 int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
-			      const char *file_path, ulong addr, ulong *sizep);
+			      const char *file_path, ulong addr,
+			      enum image_type_t type, ulong *sizep);
 
 /**
  * bootmeth_get_bootflow() - Get a bootflow from a global bootmeth
-- 
2.34.1

