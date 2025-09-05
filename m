Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FACA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 17:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C45B834D4;
	Fri,  5 Sep 2025 19:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sPSFm1Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5D783526; Fri,  5 Sep 2025 19:24:13 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE3E83487
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 19:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5449432a9d7so1336795e0c.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757093049; x=1757697849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UD7oPktF/9ZMQhHeLLanx96U/J8TJIUTn6+kdv4BxIw=;
 b=sPSFm1RrZF37iNJyy0OtucsFU5d8Vi+FRlKiY5twhupv7FXRIU8++hgbAW/t2ZAl2n
 S6rxsKbfltDUJIDsE0cOW+5K8SDJNJdHu9HrPksN7UqJ4bpw6bUzW+dxWCEr1RMxdp/N
 wq/HwaxyXsqPnM2LT5Vry+vNCTHD4Y16tLY4ZEkW0j6Xg9hTT2caGtQmswz697dO4qPi
 7mZoJiNE2jgGjPfq28e/aL+2YDm+ZT2mtY9QuRKG/MuTgqhLn8BcH6UeSNBIFOUkS5tR
 7uQun5D/qMtFVa0GKnk5DVgDaBbGmmfhL2Gyz8pE/+8+A2sDGeZdTB8g+4V5SCoQ2U+/
 7Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757093049; x=1757697849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UD7oPktF/9ZMQhHeLLanx96U/J8TJIUTn6+kdv4BxIw=;
 b=sNV7ySRSV4zFffDdGBIWjILp7BEwJMaBX5t5r9UJIHK7ik3Qtjo3VAEV/AaUE08+CK
 tqjn8Fply3tTqZDl/CcAaprDDiqp3+ffecK//OW9uNkwB6YBZMa/hTcOXEPwAF5qfojW
 bXOMzZabc63XPXAmu/nxvgQIkFK6CVOh00GyjZ9ELnqCvvM7nFttsh6HO16s/0a1Y1Ah
 Dsmh4+zA1+5K6YQzFNywTE1NRlvqVf56V1Nb2n4dMtrFojEXy50IfwkTu4aik1iW8CQL
 PMZrIenBkLUFnM9MBQOC6L7+X1uPTHcA7aft1MkTvHB7mncgLW1qX2MDxSjgmSbK9Ik1
 O2rQ==
X-Gm-Message-State: AOJu0YxHmrtg46YGs6BhAKB6AC8JA5c4FAX6LuvUGe9HAaGNLcvtYh9G
 k6uKKQ+R1hnqz4ijJSFHwpk2aa4qeNj3sZlcw+9A07S7QmQdGxbV6Rv+R4vvuLvFaMeFIShEC8i
 psYJ+
X-Gm-Gg: ASbGnctCVdbua2N9Sjxx5dGkWOhGpSA6RYztsjErb5roADYg1U0DB8L+RUYNc38kCIh
 mJARhLeSu2U/pUj3QruZyccr13joOYq0QyJMdW5xBdQUeDdl+UZC+QIUTUOD9/nIMRA1xxDge07
 hJYoSTml9M2u9CKh+UE0jl2L/jmTkjnN778cxl/cdy5Go1L0JptuwFJAr4Lx3oVtttihEbMLOUK
 oUKDV0ofOao1MwwapebJ9g1Cklxkef+Y03c4RWooun2EouQ1KUjigX7gaJTDU49Ki/Bzldxusbe
 QkM0+JodDMwZDXXSLh/eq03d4PwKB8P4DidrTPU3EL/PvdbaeuZg6Zv+lL6YQQYLNCfbhDkrbph
 hZb3aR6LYauUd8QiuHIl8b9/T3C7QHAn0lRqUkbmwNNfTNi3a8X0hOJG1nMo=
X-Google-Smtp-Source: AGHT+IHxjW7BAvdCgoBsfNLumkwUv0tBKHSbQipioXxahs288+VskwzqHftVmOc7lq9p7KgaHMbs6Q==
X-Received: by 2002:a05:6122:1792:b0:544:7364:ffc3 with SMTP id
 71dfb90a1353d-544a016e145mr7320230e0c.5.1757093048602; 
 Fri, 05 Sep 2025 10:24:08 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a1f09810sm8216154e0c.22.2025.09.05.10.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 10:24:08 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v5] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Date: Fri,  5 Sep 2025 11:23:30 -0600
Message-ID: <20250905172330.135550-1-javier.tia@linaro.org>
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
Changes in v5:
- Reverted error label renaming from 'err_cleanup_blkdev' back to 'err'
- Restored original error messages without cosmetic modifications
- Removed unnecessary comments that were obvious from code context

- v4 link: https://lore.kernel.org/u-boot/20250903214417.431985-1-javier.tia@linaro.org/
- v3 link: https://lore.kernel.org/u-boot/20250829155415.90634-1-javier.tia@linaro.org/
- v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c                  |  2 +-
 include/part.h               | 18 +++++++++++++
 lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 16 deletions(-)

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

