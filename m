Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EA5D3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9661B8933E;
	Sat, 19 Oct 2024 17:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aSHWx1Ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B07892E0; Sat, 19 Oct 2024 17:23:09 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FB6892FA
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a3a309154aso11242255ab.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351377; x=1729956177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w27Oj1V0xrpcecaRxqzqvHlf+C2x0bgFA/ceRPqED+M=;
 b=aSHWx1WwLeutPH5EK5vHPRDDBa4psfz5PpAyyzEoV3r6PvgcLTWP8cpOob9e38vxxx
 VMOBzMVkNidEiTsZAOxy7ebIlvlHo/yaDiZ9sUG3LCQACqhzm9U0R4nsh9Uf2WC14Fz/
 CiDxQbLlUZ6VibgguO0i+xIU5QnNlrBTZb62U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351377; x=1729956177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w27Oj1V0xrpcecaRxqzqvHlf+C2x0bgFA/ceRPqED+M=;
 b=ncUlIFoEgQCXquqSZxyclVX4HMV3/uJ5gIuBGeQ3Hn8UW7KRsrUUSTIcR9j9Yche9J
 Xv5iM+6Ia3rsCcfh8aCeRZqKgLh8USNpoJclmb/AhxZsr2griclUyOB8VQX6jrWyaRlH
 rF1Iu0l9jwBuUpNEJtXiLdzzKDNcii/GqYTToiZf0R3vuBIEOTamXOLXb2tZYjOLVBvU
 +6fZCAlyJVTWgua5U2GFTh0gID47fav3T70tU72nyE80nfF7/08E6yIwOfUeBOFLiBdF
 gtX4m/Mpw1WqVCMUXgVN5e/QbFFTNx4j6jDmGQh7xVuBPJRxjAtieBz3Fkj4Brgtgble
 8d4A==
X-Gm-Message-State: AOJu0YyF7JZsLsAswlOARAAUOLPeRCUJS8CaQeK6GDea/6ozEnndSLDR
 9b7id62FfL+mL5Q/IObBlLWts6D24suFeWDxlcrqHjMrU4qdDHnPdejTgse40Pvq4wBP1dRtJYQ
 =
X-Google-Smtp-Source: AGHT+IGYYOAkYhXpDjKuatmme28ut6KgKR5m5Bqa1K9EgQjIbho1PL72WtwSSj1cIR518MLNZGlBvQ==
X-Received: by 2002:a05:6e02:1487:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a3f4073be5mr65790805ab.15.1729351376925; 
 Sat, 19 Oct 2024 08:22:56 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:56 -0700 (PDT)
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
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 24/31] bootmeth: Update the read_file() method to include a
 type
Date: Sat, 19 Oct 2024 09:22:04 -0600
Message-Id: <20241019152211.1014896-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Changes in v2:
- Update to use a new image-type enum in bootflow.h

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
 include/bootmeth.h       | 13 +++++++++----
 11 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 9178fca09cc..e9075701c3c 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -84,14 +84,15 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow)
 }
 
 int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
-		       const char *file_path, ulong addr, ulong *sizep)
+		       const char *file_path, ulong addr,
+		       enum bootflow_img_t type, ulong *sizep)
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
+			      enum bootflow_img_t type, ulong *sizep)
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
index 19b1f2c377b..bd6c05ab8f9 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -298,7 +298,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int android_read_file(struct udevice *dev, struct bootflow *bflow,
-			     const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum bootflow_img_t type, ulong *sizep)
 {
 	/*
 	 * Reading individual files is not supported since we only
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 676f550ca25..1825293d93d 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -400,7 +400,8 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int cros_read_file(struct udevice *dev, struct bootflow *bflow,
-			 const char *file_path, ulong addr, ulong *sizep)
+			 const char *file_path, ulong addr,
+			  enum bootflow_img_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f3ddbe71405..e8109e19bcb 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -117,7 +117,7 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 		 desc = dev_get_uclass_plat(bflow->blk);
 
 	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
-					addr, &size);
+					addr, BFI_EFI, &size);
 
 	set_efi_bootdev(desc, bflow);
 
@@ -189,7 +189,8 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 			/* Limit FDT files to 4MB */
 			size = SZ_4M;
 			ret = bootmeth_common_read_file(dev, bflow, fname,
-							fdt_addr, &size);
+				fdt_addr, (enum bootflow_img_t)IH_TYPE_FLATDT,
+				&size);
 		}
 	}
 
diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 23ae1e610ac..42b8863815e 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -74,7 +74,8 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
-				const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum bootflow_img_t type, ulong *sizep)
 {
 	/* Files are loaded by the 'bootefi bootmgr' command */
 
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 6c158c2a6c6..ae5ae4dbb34 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -79,7 +79,7 @@ static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
 	/* Allow up to 1GB */
 	*sizep = 1 << 30;
 	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 sizep);
+				 (enum bootflow_img_t)IH_TYPE_INVALID, sizep);
 	if (ret)
 		return log_msg_ret("read", ret);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 05c6bece2c1..e64429f6857 100644
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
+				  enum bootflow_img_t type, ulong *sizep)
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	struct pxe_context *ctx = dev_get_priv(dev);
diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
index 2f8e00cf350..028c2481583 100644
--- a/boot/bootmeth_qfw.c
+++ b/boot/bootmeth_qfw.c
@@ -52,7 +52,8 @@ static int qfw_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int qfw_read_file(struct udevice *dev, struct bootflow *bflow,
-			 const char *file_path, ulong addr, ulong *sizep)
+			 const char *file_path, ulong addr,
+			 enum bootflow_img_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
index 26c713bb5f3..92ba2e3f050 100644
--- a/boot/bootmeth_sandbox.c
+++ b/boot/bootmeth_sandbox.c
@@ -27,7 +27,8 @@ static int sandbox_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int sandbox_read_file(struct udevice *dev, struct bootflow *bflow,
-			     const char *file_path, ulong addr, ulong *sizep)
+			     const char *file_path, ulong addr,
+			     enum bootflow_img_t type, ulong *sizep)
 {
 	return -ENOSYS;
 }
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index 189e86d2a22..ed7b9598e38 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -160,13 +160,14 @@ static int vbe_simple_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 }
 
 static int vbe_simple_read_file(struct udevice *dev, struct bootflow *bflow,
-				const char *file_path, ulong addr, ulong *sizep)
+				const char *file_path, ulong addr,
+				enum bootflow_img_t type, ulong *sizep)
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
index e812974ec4d..788d4046ce9 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -8,7 +8,6 @@
 #define __bootmeth_h
 
 #include <bootflow.h>
-#include <image.h>
 #include <linux/bitops.h>
 
 struct blk_desc;
@@ -117,13 +116,15 @@ struct bootmeth_ops {
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
+			 enum bootflow_img_t type, ulong *sizep);
 #if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 	/**
 	 * readall() - read all files for a bootflow
@@ -245,13 +246,15 @@ int bootmeth_set_bootflow(struct udevice *dev, struct bootflow *bflow,
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
+		       enum bootflow_img_t type, ulong *sizep);
 
 /**
  * bootmeth_read_all() - read all bootflow files
@@ -397,11 +400,13 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
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
+			      enum bootflow_img_t type, ulong *sizep);
 
 /**
  * bootmeth_get_bootflow() - Get a bootflow from a global bootmeth
-- 
2.34.1

