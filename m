Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E45D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2161F896FC;
	Sat, 16 Nov 2024 00:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jgKc/Wvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2A0896F7; Sat, 16 Nov 2024 00:20:08 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC628970C
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83abe7fc77eso80638639f.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712802; x=1732317602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+D3/czFqwiwJVLjocmgFLGkmnbDo5Lys2oVWrdfsls=;
 b=jgKc/WvjodeTYyExidqKFHwl6SfVXUmYCWGal2y+BquCu+XTgnj2P8lXoQw0JVbDZk
 it8zQGSZFsIcSQVB7PvKVHK1/GzTFxzu4CR7Q7d3uJ5aPpIEo7cyAoH5sDR3eMRkuLKU
 o3/efv0FaVh3xw0fUQ6XmJg59TJojbqPb1xvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712802; x=1732317602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+D3/czFqwiwJVLjocmgFLGkmnbDo5Lys2oVWrdfsls=;
 b=LtIlrafyMw/Cab+sBlEiHJLgQ6Zn0W4lucNVZNgzXM5aT1k8FWeSV0vOvOAEVKf0C6
 tSGHrO0+XaC4507fYCPSNCwTMpSiPDeGbyULnVepsaf1bHDexxLGIFW2diLDeed0TB/e
 B2rgTJgeweYiiA2BlLPvA03y0gUAcLAK9t0jraG6TlbROd64wgeD6/ijkhg5Iq2ghlrk
 f0ykqFHMoVXLMY7Uq0rc6peewbLJZZ1b580qlpzLLeqEukQfPJK60/S9z0N2fUZf7ZOu
 yHl1CSYgldY/7MW5hL06YOWguQBxtrbMdPP5x8YFXYCPlJEU6WLV4Z59hTVKahn9fiX7
 da/w==
X-Gm-Message-State: AOJu0Yw/n39M8Y1/VMFEQRpzwsKjeA4glW1SSBxYNLGXvly3BcRQzNfN
 YWLGAc0RZfPArnz/kvWQho19WqY9AC4GaA4WD6eY3qvObh9G6ONLOdcH2mppK0Valw9idoO3P4A
 =
X-Google-Smtp-Source: AGHT+IEYYrxpPMPyb36zK6w3ZDgXdXlhoaj6SlwRXDbDqMVmP1fbdEAoApwUKBZuXtVbM7W0/W3AUQ==
X-Received: by 2002:a05:6602:29c7:b0:835:46cb:6747 with SMTP id
 ca18e2360f4ac-83e6c2955efmr583403239f.4.1731712802358; 
 Fri, 15 Nov 2024 15:20:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 10/19] bootmeth: Update the read_file() method to include a
 type
Date: Fri, 15 Nov 2024 16:19:17 -0700
Message-Id: <20241115231926.211999-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

(no changes since v3)

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
index 47a22d5bd0a..f711b9d0598 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -97,7 +97,7 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 
 	size = SZ_1G;
 	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
-					addr, &size);
+					addr, BFI_EFI, &size);
 	if (ret)
 		return log_msg_ret("rdf", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
@@ -172,7 +172,8 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
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

