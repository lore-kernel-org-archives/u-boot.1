Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC256C87FDA
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 21:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F0584779;
	Fri,  8 Aug 2025 23:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ScxJXRin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A4B84788; Fri,  8 Aug 2025 23:37:41 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A83846E5
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 23:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-539613258e8so890228e0c.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754688993; x=1755293793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CuWFbI7+oPeE0vECQCm4kgMXnXdXxLNzBsB7C+FmBwE=;
 b=ScxJXRinvIeDj4yXOVkKyqB8bPjRbp4SKW+b4S1jelzBbJQY3lVyArkMCtTfQwrHmx
 /8NGGRPl88lQZTwoxlFSgr9ljucjA8BAXiwC02k/j1dff4LYYzBP4eBa6k8LHks2bN+C
 InaWm4RUvQkBTHTMu6Y0Oj/8DxLwRs8mKG5r6MFd/J/AmmDu5b/Jc1ImMLRZwjdwSMCo
 rZIgr/d16d3IgqhYimAPYlkPnHo0BJxn6UgHABZAyt7H6/8d7sxggfHnirSVOmYsoZ8D
 fPMsEcm93X3IDHQWhZMPJX4fet20eeRMSjdoSX8j2ZomIt+CxT+UqXz+BC2poAge+oM0
 wrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754688993; x=1755293793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CuWFbI7+oPeE0vECQCm4kgMXnXdXxLNzBsB7C+FmBwE=;
 b=aEzVloUN27qY6Knn3SXrIXTpwk/z3IWqfibslqo3GnhGnbN7B7EInEhJz5CrgQyMgX
 F/ymgPT3FdyrOv9oBCflNxk7XlEscLW015j0M5QJ/ULxksQfKQ0MT9HcWDJyyoK8TSPW
 H/3M/tK6jD+PISOLqCqq9aLgPoc1ph2CL4hAabBgbdkvDceHwY81LcNXTPWKa7422F7k
 QlotLkaABoSf8KPMOJa3fHf6l+V8ff88FIlVdOu0ROkdQ/7eeTqaycghYrXNc/PF2Ski
 Iy8s0YSGSzvGNnh6XLgNuVnbtCasy7b/9lEPR/Fl8OG52IL9wUj3XErlrAhrJg4NhvEW
 DXOA==
X-Gm-Message-State: AOJu0Yx9F5oWbdr//5NQuI+opO86XpHjPWIl3B3SPE7HHYZ/htdhoWIu
 teHPJcqHrG+0/YZpTvLfc01AYdog6k19ykUauRKLOgak9vgV7IuLjhg9guTL6u/6h0cERVMfFDx
 rNFpo
X-Gm-Gg: ASbGncufbi2UWpedARCdB+GfISDXCF0YV76u5RjmfibBy7PZcBgVgr/fy3WjmzqIuBW
 cotZ8O98IClKExw0OJ8tXPQ5zGFkvBRtP+jcP+0UVc9TtyGBNaUSiXnHc+lr5JYoOC1MxQ/j65W
 NIyjeOySf2fj21AyhXwSv/Px4rjx9qEuc/AXMesnrooZo35WWTgB4kz3POXvj15Wh9/r4Hdemtj
 oSsdKJy8mBwZpGkNGDILp5osHXmVDzU4wmZXnPfhNSFdYOvlvwKW++JrPebQ/W3B1+T+lDWHmV1
 z3q8S7lfw9WMdIqJAdMNl6/Zf3fwL0ijCqkoWO8GORGeJ8K7Rc0p5Kozy0PKMqrm1BqlgwcsJM2
 HMo7ZTQ2h/Z4gDLBkwgMRZpKxAL57DCziHkNZOyS+CsLlcaFn7I3K9zRjhL4=
X-Google-Smtp-Source: AGHT+IHfnt8U15yzm9vDExIgaHGjO4AiuXMKBsCVTzxsfoey0yriJ0A3nGyAI9Etq4OaYtTgCUA6Tw==
X-Received: by 2002:a05:6122:658b:b0:537:3faf:9b43 with SMTP id
 71dfb90a1353d-53a52ee865amr1675389e0c.12.1754688993207; 
 Fri, 08 Aug 2025 14:36:33 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-539b029fe36sm1356609e0c.24.2025.08.08.14.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 14:36:32 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Date: Fri,  8 Aug 2025 15:27:07 -0600
Message-ID: <20250808213627.649669-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.50.1
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

Refines the disk image detection mechanism in the EFI boot manager.
Instead of relying on file extensions, the updated code uses the
partition driver lookup function to determine if a downloaded file is a
valid disk image.

The change enhances the robustness of the boot manager by providing a
more accurate disk image detection. Extend prepare_loaded_image() to
accept an optional reuse_blk parameter. When a partition driver is
detected, the existing temporary device is passed to
prepare_loaded_image() instead of being destroyed and recreated.

The partition driver lookup function is also made public to enable its
use in the EFI boot manager. The function documentation is updated
accordingly.

Signed-off-by: Javier Tia <javier.tia@linaro.org>

---
Changes in v2:
- Extend prepare_loaded_image() to accept an optional reuse_blk
  parameter. When a partition driver is detected, the existing temporary
  device is passed to prepare_loaded_image() instead of being destroyed
  and recreated.
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

---
 disk/part.c                  |  3 +-
 include/part.h               | 18 +++++++++
 lib/efi_loader/efi_bootmgr.c | 78 +++++++++++++++++++++++++++++-------
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..adc24976624 100644
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
@@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
 
 	return 0;
 }
+
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
index 662993fb809..9c97fd7812d 100644
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
@@ -346,19 +347,27 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
  * @size:	image size
  * @dp:		pointer to default file device path
  * @blk:	pointer to created blk udevice
+ * @reuse_blk:	optional existing block device to reuse (can be NULL)
  * Return:	status code
  */
 static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 					 struct efi_device_path **dp,
-					 struct udevice **blk)
+					 struct udevice **blk,
+					 struct udevice *reuse_blk)
 {
 	u64 pages;
 	efi_status_t ret;
 	struct udevice *ramdisk_blk;
 
-	ramdisk_blk = mount_image(label, addr, size);
-	if (!ramdisk_blk)
-		return EFI_LOAD_ERROR;
+	if (reuse_blk) {
+		/* Reuse existing block device */
+		ramdisk_blk = reuse_blk;
+	} else {
+		/* Create new block device */
+		ramdisk_blk = mount_image(label, addr, size);
+		if (!ramdisk_blk)
+			return EFI_LOAD_ERROR;
+	}
 
 	ret = fill_default_file_path(ramdisk_blk, dp);
 	if (ret != EFI_SUCCESS) {
@@ -387,7 +396,8 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	return EFI_SUCCESS;
 
 err:
-	if (blkmap_destroy(ramdisk_blk->parent))
+	/* Only destroy if we created it (not reused) */
+	if (!reuse_blk && blkmap_destroy(ramdisk_blk->parent))
 		log_err("Destroying blkmap failed\n");
 
 	return ret;
@@ -407,7 +417,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -452,6 +462,20 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
 	EFI_EXIT(ret);
 }
 
+/**
+ * cleanup_temp_blkdev() - Clean up temporary block device
+ *
+ * @temp_bdev: temporary block device to clean up
+ */
+static void cleanup_temp_blkdev(struct udevice *temp_bdev)
+{
+	if (!temp_bdev)
+		return;
+
+	if (blkmap_destroy(temp_bdev->parent))
+		log_err("Destroying temporary blkmap failed\n");
+}
+
 /**
  * try_load_from_uri_path() - Handle the URI device path
  *
@@ -466,7 +490,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,21 +539,43 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
-	 * If the file extension is ".iso" or ".img", mount it and try to load
-	 * the default file.
-	 * If the file is PE-COFF image, load the downloaded file.
+	 * Check if the downloaded file is a disk image or PE-COFF image.
+	 * Use partition driver lookup for disk image detection.
 	 */
-	uri_len = strlen(uridp->uri);
-	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
-	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
+	struct udevice *temp_bdev;
+	struct part_driver *part_drv = NULL;
+
+	/* Create temporary block device from the downloaded image for testing */
+	temp_bdev = mount_image(lo_label, image_addr, image_size);
+	if (!temp_bdev) {
+		log_debug("mount_image() failed, will attempt PE-COFF detection\n");
+	}
+	if (temp_bdev) {
+		struct blk_desc *desc = dev_get_uclass_plat(temp_bdev);
+		if (!desc) {
+			/* Clean up temporary device when dev_get_uclass_plat() returns NULL */
+			cleanup_temp_blkdev(temp_bdev);
+		} else {
+			/*
+			 * Use part_driver_lookup_type for comprehensive partition detection
+			 */
+			part_drv = part_driver_lookup_type(desc);
+		}
+	}
+
+	if (part_drv) {
+		/* Reuse the temporary device instead of destroying and recreating */
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
-					   &loaded_dp, &blk);
+					   &loaded_dp, &blk, temp_bdev);
 		if (ret != EFI_SUCCESS)
 			goto err;
 
 		source_buffer = NULL;
 		source_size = 0;
 	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+		/* Clean up temporary device if it was created but not a valid disk image */
+		cleanup_temp_blkdev(temp_bdev);
+
 		/*
 		 * loaded_dp must exist until efi application returns,
 		 * will be freed in return_to_efibootmgr event callback.
@@ -545,7 +590,10 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
-		log_err("Error: file type is not supported\n");
+		/* Clean up temporary device if it was created but not a valid disk image */
+		cleanup_temp_blkdev(temp_bdev);
+
+		log_err("Error: disk image is not supported\n");
 		ret = EFI_UNSUPPORTED;
 		goto err;
 	}
-- 
2.50.1

