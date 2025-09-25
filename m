Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F4FCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426F18319C;
	Fri, 26 Sep 2025 00:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ldVRBJn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFC282A9E; Fri, 26 Sep 2025 00:48:46 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5CF82A9E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-54aa4b86b09so862687e0c.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758840522; x=1759445322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pIrGVkSgdMks//zHqBzHSSvT52OMRXIFWuwV+mY+C+w=;
 b=ldVRBJn+z46Noa9JjiGE5rCktUT1CGVqjRGjdkQsbQYWJzoGjpuizeJo1ev4OISsBq
 4Wy2zffLdV9gzB90U8MELltiDntvXnpbbDEsqrQs171di0f26O0Xli+0mo7DxE0R88de
 jJgbSB6BDkJ1Inwy/qYGGW/9wdmtPKGX09OAHueH1kTiNB8tFjbbEPJw2OW+eOTGFonq
 XD6r5Cv83wnNXWEGtULhxDpdFMyhmCXEfRm1+YcWBByfXkI0RZi4rE3Rhsq058v8HqBX
 ecd0l87zdGDR9RIGanQZS+xD+MvXBvI52OAA8of57cDihbfdF87iDu1nZxsKyGO2bta0
 6aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758840522; x=1759445322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIrGVkSgdMks//zHqBzHSSvT52OMRXIFWuwV+mY+C+w=;
 b=HDFPp2Wr4iflkzzHtX2wevcMx/VhUTYROdTpRBMt0VbAQwbcIxxctH3snA/6kCIfrf
 tdKqgXyi07VmmptGTVwVRxAvaO+MjsMqV+DCnK2l8SfBGLwbD03l64R/y7gNNC/sw/Rn
 W1OSRWgDLwqL4uVi6S91D3HJvuvd2R95kPYufzfTbv0/MMyCv9QDc5R1qxmhSMHtO9g6
 6Z1hWlVA5YZX60hg7gT0P5TmwAyH1TL/1pC29dJ1xzUYUdgy1LYv0E0Pl1Q/2JshkXU1
 J2mSsGQ/QOsR0GlS9FP2FxsCCZWOXKweJB1YsV3NVnkIRD77nX3BWqnEmDgjbMkcT1Nx
 X6wg==
X-Gm-Message-State: AOJu0Yxqee/jJqcaJU5jFCv2eMVMJwMY+B+o9wt0++2tis1BSJA9+FAa
 qXk4IgrVlGLNyjReymr0hEJ1ZStH4PTjLcKWQKP/7xqB/PRk/0rAZKkaUoDHduD4pWSCMRmhgzT
 Y9lgX
X-Gm-Gg: ASbGncsr63R/2uWErnruyyyl7XcKctaQfCr/7H+DX1qbYranQHBU6reGACRm6jlJvFZ
 Aeaowk5boT3bWT4YL2TYdxJyyo9y6oi+cW0DGfU326QfVt9PXXupcixBi9RnHiDykwz7HaFybIw
 L6FBz+xxVr3NzgSN6vTj/w0R2mC6TOQi6LNm1+yGMgZL8+Aod0s/SHzehrp5BdsJmlxAGVG0foA
 uluy5s57C/itql2ZR/Fck25dPuqRpvZw+bsaXMPn9XTVsxUvm7mfk1JZlV07flRW1NWS5jfaty/
 68IrgeKJsoXD4ja15P95ycZbUMbj0CqudLk+eacso2BVelbUm3/e2dkLsZ9mRgT5DgW70SaDdhh
 8F+TuwmNbxWtoB7EcZWvGYHhFP2TDfPDAamkdgAUXs1ISNnG1
X-Google-Smtp-Source: AGHT+IHAqihMHIdpGZUoL6S8lXp6oEdCA995xC/EECbJARosnYMbCJheye1nZOWhJR7YvNkje57f/g==
X-Received: by 2002:a05:6102:5129:b0:530:f657:c5d with SMTP id
 ada2fe7eead31-5accd4f6acemr2545910137.20.1758840522138; 
 Thu, 25 Sep 2025 15:48:42 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54beddf9c76sm673866e0c.28.2025.09.25.15.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 15:48:41 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v7 2/2] efi_loader: Improve disk image detection in efi_bootmgr
Date: Thu, 25 Sep 2025 16:48:37 -0600
Message-ID: <20250925224838.567562-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925224838.567562-1-javier.tia@linaro.org>
References: <20250925224838.567562-1-javier.tia@linaro.org>
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

Enhances the process for identifying disk images within the EFI boot
manager. Utilize part_driver_lookup_type() to verify the validity of a
downloaded file as a disk image, rather than depending on file
extensions.

part_driver_lookup_type() is now used in the prepare_loaded_image()
function in the EFI boot manager to detect partitions on a block device
created from a downloaded image. This allows the boot manager to boot
from any disk image that can be recognized by a partition driver, not
just ISO and IMG images.

Update prepare_loaded_image() to create the ramdisk block device
internally, obtain the blk_desc and use part_driver_lookup_type() to
detect a valid partition table.

In try_load_from_uri_path(), try prepare_loaded_image() first to detect
disk images, and fall back to PE-COFF detection only if that fails.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 include/part.h               |  6 ++---
 lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/part.h b/include/part.h
index 52fd3d534e0..715900a7ac7 100644
--- a/include/part.h
+++ b/include/part.h
@@ -471,9 +471,6 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #define part_get_info_ptr(x)	x
 #endif
 
-static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
-{ return NULL; }
-
 /**
  * struct part_driver - partition driver
  */
@@ -752,6 +749,9 @@ struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
 static inline int part_driver_get_count(void)
 { return 0; }
 
+static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+{ return NULL; }
+
 static inline struct part_driver *part_driver_get_first(void)
 { return NULL; }
 
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 662993fb809..9ae11d4ebf0 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -17,6 +17,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <part.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <asm/unaligned.h>
@@ -347,6 +348,9 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
  * @dp:		pointer to default file device path
  * @blk:	pointer to created blk udevice
  * Return:	status code
+ *
+ * This function handles device creation internally and performs cleanup
+ * on error paths.
  */
 static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 					 struct efi_device_path **dp,
@@ -355,10 +359,31 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	u64 pages;
 	efi_status_t ret;
 	struct udevice *ramdisk_blk;
+	struct blk_desc *desc;
+	struct part_driver *part_drv;
 
+	/* Create the ramdisk block device internally */
 	ramdisk_blk = mount_image(label, addr, size);
-	if (!ramdisk_blk)
-		return EFI_LOAD_ERROR;
+	if (!ramdisk_blk) {
+		log_err("Failed to create ramdisk block device\n");
+		return EFI_DEVICE_ERROR;
+	}
+
+	/* Get the block descriptor and detect partitions */
+	desc = dev_get_uclass_plat(ramdisk_blk);
+	if (!desc) {
+		log_err("Failed to get block descriptor\n");
+		ret = EFI_DEVICE_ERROR;
+		goto err;
+	}
+
+	/* Use part_driver_lookup_type for comprehensive partition detection */
+	part_drv = part_driver_lookup_type(desc);
+	if (!part_drv) {
+		log_err("Image is not a valid disk image\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto err;
+	}
 
 	ret = fill_default_file_path(ramdisk_blk, dp);
 	if (ret != EFI_SUCCESS) {
@@ -389,7 +414,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 err:
 	if (blkmap_destroy(ramdisk_blk->parent))
 		log_err("Destroying blkmap failed\n");
-
 	return ret;
 }
 
@@ -407,7 +431,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -452,6 +476,7 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
 	EFI_EXIT(ret);
 }
 
+
 /**
  * try_load_from_uri_path() - Handle the URI device path
  *
@@ -466,7 +491,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,18 +540,15 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
-	 * If the file extension is ".iso" or ".img", mount it and try to load
-	 * the default file.
-	 * If the file is PE-COFF image, load the downloaded file.
+	 * Check if the downloaded file is a disk image or PE-COFF image.
+	 * Try disk image detection first using prepare_loaded_image().
 	 */
-	uri_len = strlen(uridp->uri);
-	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
-	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
-		ret = prepare_loaded_image(lo_label, image_addr, image_size,
-					   &loaded_dp, &blk);
-		if (ret != EFI_SUCCESS)
-			goto err;
 
+	/* First, try to treat the image as a disk image */
+	ret = prepare_loaded_image(lo_label, image_addr, image_size,
+				   &loaded_dp, &blk);
+	if (ret == EFI_SUCCESS) {
+		/* Image is a disk image, set up for disk boot */
 		source_buffer = NULL;
 		source_size = 0;
 	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
-- 
2.51.0

