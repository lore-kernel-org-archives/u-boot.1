Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224C4D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404A588FB3;
	Mon,  4 Nov 2024 18:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LDHJceL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCB188618; Mon,  4 Nov 2024 18:51:39 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0251388FAA
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a4e5e57678so17947895ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742693; x=1731347493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhptQMeRbOWCdd2iETvVZAUJWqfWaZFl1UmisVnlWUQ=;
 b=LDHJceL0MKx76zqHaf0bH8iHiNbRWPmTXlIN7irDH9DXWShiDfiMb2+eifNIXK/A8y
 fKS+/ugnE+sq3yTPG95LcZJs+HrTeFA1+DwP6oehU7zlMN8BXCMVPRJz2z3JcE/VjE9c
 Fr+hS2rExW3VFMz0PRshfkT+nj/dzMFSloSz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742693; x=1731347493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhptQMeRbOWCdd2iETvVZAUJWqfWaZFl1UmisVnlWUQ=;
 b=Ul3zCvhqjyN782t0Ih6vrii/YveZKKUkNRQi41uN79zgjLhEu6nEpnHpywqhaeqiMI
 1a+bRWermnBl/9wUmwMdKU9LwnlLOnNrBuOuOfVfpQwo6twEzijZtxJbMdMmqRbheGer
 zU3EuzWePKjiPjsmhi54v+1xW9DxpovhJZkNZawpgEfsVXg6hPY+rEzM56cUBhqavtGA
 b544+ZS4cdwPZNAgbiDcdj6HL5GpJu2RZTGuAVpTMPETkOMDkcjZuYsXNM9fwaV82ZTP
 RT7lSNX8o2f9gzcODZcbolPHmRpI7qDps7k9gBAYPp8AT3Gfy4xxleijIquedQuT7Mk/
 s8WA==
X-Gm-Message-State: AOJu0YzesV/aMdsu3peA3MyKpsUd5YR3hl6wvnbrUgI+136MUG/FsFb2
 QwhdNWPZzmAKvhWUkFDxV8Q0QQCwcShmlMXfmidxYNW8VfqN233mnonTR6BvYlh0JW7SMU8Hgo8
 =
X-Google-Smtp-Source: AGHT+IE2ScLPup+TU43juyELcmJYWucquR8VODC6MPSuT1HcnHVhwWj1wb9zpD2W+1x/BdaSiH+aiQ==
X-Received: by 2002:a92:c08c:0:b0:3a6:ac4e:4d with SMTP id
 e9e14a558f8ab-3a6afeef2c1mr108181755ab.7.1730742692875; 
 Mon, 04 Nov 2024 09:51:32 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 10/19] bootmeth: Update the read_file() method to include a
 type
Date: Mon,  4 Nov 2024 10:51:01 -0700
Message-Id: <20241104175110.1048449-11-sjg@chromium.org>
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

We want to record the type of each file which is loaded. Add an new
parameter for this, to the read_file() method. Update all users.

Make bootmeth_common_read_file() store information about the image that
is read.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c   | 11 ++++++++---
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
 11 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index c219631816f..1f48d0c1f51 100644
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
@@ -394,7 +395,8 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 }
 
 int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
-			      const char *file_path, ulong addr, ulong *sizep)
+			      const char *file_path, ulong addr,
+			      enum bootflow_img_t type, ulong *sizep)
 {
 	struct blk_desc *desc = NULL;
 	loff_t len_read;
@@ -423,6 +425,9 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
 		return ret;
 	*sizep = len_read;
 
+	if (!bootflow_img_add(bflow, bflow->fname, type, addr, size))
+		return log_msg_ret("bci", -ENOMEM);
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

