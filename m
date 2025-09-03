Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD84BCA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 21:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC90833C6;
	Wed,  3 Sep 2025 23:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xg5ADCwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E9A834E5; Wed,  3 Sep 2025 23:44:23 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8C78323A
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 23:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-528a601a3cbso810754137.1
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756935859; x=1757540659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucuOAgN659KflBAUjysbO6octPR+/1vWl0iZyQ594do=;
 b=Xg5ADCwCwzwigEJPsOjXhl58rOmVeuiTlxmWXzKhMGdRBft8v69nK+/MDNbt4FeWs0
 LN4a7Uz6q/9LqqGlxdF7oWyRPTifQFmkr4r4rton6s/4j5KSlzUX6oS4xRfrhADHaxVy
 +5/dkmMJjl40nLQ0B6vfGms7e2SFCqXBZPe9V2GYHLImASpZZDORUPU4Ww5TGW+M72Ja
 xsgqirdtDaZV6HDmoHrOeuWrGuB7g7fXNT2ChuyOSo4b8JSMrtKwAILNfa4u28bcf7a6
 qtgFyZDnzHPn7tccY4K/xaeUNCVtd3+HIyCijMbYuUpPMsnE3T7kD863HNHLxbykhgWd
 kbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756935859; x=1757540659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ucuOAgN659KflBAUjysbO6octPR+/1vWl0iZyQ594do=;
 b=FZZnFYvOvqK6zZdHiV5MYPuQQDRAp/UfXb/+AYTVX0SNoIOA3fVjpk7CKxCwBrxGKB
 2HTW+HWGKfIiik7Vo1+ugCjq6OSChquzs5Oh821vR0Yd8MbWa+HLaN7ldydBTR+COSY+
 /cSUAV/bgOqrbEYNqcN0F3qNSvrcGA1x1qzhUcmWdtKEE+Jia3safFbKfLDPb/3brDc6
 TAam4N5KDRw2W+ScV5tjNoxlB799thjbHrDyka58vHSEeEvAvMu8Qt2idbhdAgolUo3i
 55DwnG/ITRpdjO4ybOdp6MSBs6okJGTc/VcCHGdqRKA/Ggg5zdzxd55vWry+Gigyz7Oc
 SDMw==
X-Gm-Message-State: AOJu0YzwDA+xzGzRsb56+Qu6Kb4gh0vZcTGo1ROxF67a9KReTYLoUvTS
 yiHtDoxLFxN6wWRrRnbXkoshYFfHWCFUE9KT04y1wlzOTWy9qy9Bs0IfThOraVUKToOjYaYUwsD
 v4V7r
X-Gm-Gg: ASbGncsk9+23N9Cj9dRkWgNFAz+YKYYLsCOq6CnEz+QDkpworjr38dkfPcll9x4HwR/
 mS6P3SyOl73IzpcjBiMbUdPSRIK5G04oQ7okHgzgZUpcndi4kLGxE+3to6ooABNGv4MZqlsEWpY
 13THTA5a0RLuJMYtgo0IFkiar7mH5/d6KFQ9WbEnGAr5qiCAmvO14pTtppYsxSEamTYY+pZv7c2
 l7uVXkUGnR73ZfT7dunzhJ5zHyLgYLoSj2W8w+me34RfBIUh8RppDRvc8IDGj0kBST1LSXE4nLd
 Rzl/cuekr9cd8smogfWFWEnURdErP5FR2FUhuD5X/lCiBQtW76bbPI+7i+vG0Lyu2SOwxXG9VSy
 xuj62NFdCC9GyCTx+eCbQZzjT7Y66601pT3AIa5qRT0yuuL19p+3I0X93elw=
X-Google-Smtp-Source: AGHT+IFcc+9g7QFONdjwmEJWgTYUQPjmP4m3yiXrDG1NGvATQK+WkwvZkQ6J6SoJmd6YThypqzvUvw==
X-Received: by 2002:a05:6102:26d3:b0:528:9956:6a3d with SMTP id
 ada2fe7eead31-52aed4eb64fmr5939121137.12.1756935858992; 
 Wed, 03 Sep 2025 14:44:18 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52af19158a6sm5842464137.9.2025.09.03.14.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 14:44:18 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v4] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Date: Wed,  3 Sep 2025 15:44:16 -0600
Message-ID: <20250903214417.431985-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Include part.h in the EFI loader and export part_driver_lookup_type and
add its prototype and documentation in include/part.h. This makes the
partition-driver lookup available to other code paths that need to
detect partition tables on a block descriptor.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c                  |  2 +-
 include/part.h               | 18 ++++++++++
 lib/efi_loader/efi_bootmgr.c | 64 +++++++++++++++++++++++++-----------
 3 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..f0c6866e210 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int part_type)
  * @dev_desc: Device descriptor
  * Return: Driver found, or NULL if none
  */
-static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 {
 	struct part_driver *drv =
 		ll_entry_start(struct part_driver, part_driver);
diff --git a/include/part.h b/include/part.h
index b772fb34c8a..3fc3186f4c4 100644
--- a/include/part.h
+++ b/include/part.h
@@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * part_driver_lookup_type() - Look up the partition driver for a blk device
+ *
+ * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition driver
+ * against the blk device to see if there is a valid partition table acceptable
+ * to that driver.
+ *
+ * If @desc->part_type is already set, it just returns the driver for that
+ * type, without testing if the driver can find a valid partition on the
+ * descriptor.
+ *
+ * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
+ *
+ * @desc: Device descriptor
+ * Return: Driver found, or NULL if none
+ */
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 662993fb809..728e89bd95b 100644
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
@@ -355,15 +359,36 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
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
+		goto err_cleanup_blkdev;
+	}
+
+	/* Use part_driver_lookup_type for comprehensive partition detection */
+	part_drv = part_driver_lookup_type(desc);
+	if (!part_drv) {
+		log_err("Image is not a valid disk image\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto err_cleanup_blkdev;
+	}
 
 	ret = fill_default_file_path(ramdisk_blk, dp);
 	if (ret != EFI_SUCCESS) {
 		log_info("Cannot boot from downloaded image\n");
-		goto err;
+		goto err_cleanup_blkdev;
 	}
 
 	/*
@@ -379,17 +404,17 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 				    false, true);
 	if (ret != EFI_SUCCESS) {
 		log_err("Failed to reserve memory\n");
-		goto err;
+		goto err_cleanup_blkdev;
 	}
 
 	*blk = ramdisk_blk;
 
 	return EFI_SUCCESS;
 
-err:
+err_cleanup_blkdev:
+	/* Clean up the created block device on error */
 	if (blkmap_destroy(ramdisk_blk->parent))
-		log_err("Destroying blkmap failed\n");
-
+		log_err("Destroying blkmap failed during cleanup\n");
 	return ret;
 }
 
@@ -407,7 +432,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -452,6 +477,7 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
 	EFI_EXIT(ret);
 }
 
+
 /**
  * try_load_from_uri_path() - Handle the URI device path
  *
@@ -466,7 +492,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,21 +541,19 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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
+		/* Image is a PE-COFF executable */
 		/*
 		 * loaded_dp must exist until efi application returns,
 		 * will be freed in return_to_efibootmgr event callback.
@@ -545,7 +568,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
-		log_err("Error: file type is not supported\n");
+		/* Neither disk image nor PE-COFF */
+		log_err("Error: downloaded image is not supported\n");
 		ret = EFI_UNSUPPORTED;
 		goto err;
 	}
-- 
2.51.0

