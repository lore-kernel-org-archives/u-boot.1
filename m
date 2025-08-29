Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9672CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C72B83675;
	Fri, 29 Aug 2025 17:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GZcvv7xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29A383689; Fri, 29 Aug 2025 17:54:30 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF278365E
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-528d157a48cso1072621137.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756482866; x=1757087666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8DFVrxfYJ7g5hHGJ/7bgFMe/9z9oM0yBfcP1FRPOio0=;
 b=GZcvv7xaido/8UvM/C1FAeTi644GkB39TeO1sFzR2iRlD5ErF9PsvM7CQIjkclW3oj
 vdLsPcTgI44PHizOaO7DnX5FNOnTY5UeFXeeqFAqjxQvxZyO3ZPsOrMQivLvMZZPc+r5
 s0fG4N5KCDpQbT72OLyYAsKwMbjPQerE2dyvwb4V+iiX4S+AyTU1KwUpDUmv79R/wdJS
 Z9o66fxEyVwptcA9/ZrqpCbZFCZPaKPqVd17JEEUT5ZQaRnx6UoNt1rXvqOyLTuA+bbK
 QyKpMZ/qhy0pylEQgxMk3n6MpTuhJTDw1SLTLmTVlTutyBxq7gPmHu9xqT+qNboUl/yK
 K9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756482866; x=1757087666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DFVrxfYJ7g5hHGJ/7bgFMe/9z9oM0yBfcP1FRPOio0=;
 b=a13weOW0iOWtNdmEtI0wDZ44qUchKYRQ6ieSOBuKCI6u43HiyOgm5fPoLtqpZ5qCDD
 97aIlc0uFzdpobCHVRA2Iz0GeIGCpgD6qMkUDW7Lr4/TO4zvO2sM1VUuJ5uGUQBA2QmU
 Nb4OBk3YcowET8+jGUCXKUc82hMVl20s1TBtIQ4p4RFeH9v7WyLvE/bLmkI0wRDhWvHF
 7neEwSsElF4jEPaJdHpjGmkMDBa7Boxks04axrOAE2B4qPyVqZmitpxDoTvDwj3tgXjV
 1mMJcMCyQ4NwaqHj4bYZH4HOQEWs6OlV+65NSW4q7Y7+AMRFh4UwtBPORMuX43vCt489
 tUIw==
X-Gm-Message-State: AOJu0YyTjTYPrD513bdz3FfwMgvVxY2RPhNnI1A0E2CvQasEaTjCUBhI
 ILMCv8jSXDlZORLyj5ppq3o2QGchxMtl9TXfBIe9oJLWs2IIesCYV+DNDBGKrpoVgY/wIfVyk1K
 dy57L
X-Gm-Gg: ASbGncubYlqv1xobZ8gZ59b2D0GhovyO2rxbjKojk4B8owlzAiGpn98ZjV7zcNNjo5D
 CiWPKKlSCcjXMzGaql38+XEiPL0oB1mMeTZEH892HS5/VFSTzPbvxmk7WYhPQf4UQRkTPyTz4eC
 QT5emJ0TtOtUYvGun5JzxpBgGCLfoo6zSieTEU/cGIoIIzotsOdZyJzNSbE8jS/C9uWCHuXNGVa
 ose/a7K5/OlmMd7hYzLxPTeINBLgTWMa9OwHzXpNTR/9CUBulxxMEk7wWUzfSzlX2vZjS5OT3XY
 4FfX1ojW+SH5QKBDpMNkFCQu7R1Kfks2ga+Ih08f6zQB3eD+FKpd+RovZ4V7Czrs/gu+LxA2ufe
 s36QhnHWWPVAbL+/vrARf8E+7lfwD3RAKta1usKYkg7nlftwDTT0OL+SF3whivicuoSf+Fg==
X-Google-Smtp-Source: AGHT+IGNpDsvDqTXB5giPfGhVwpnVfJKe6BXfKPybrGkD6qoBEm5r5WIoAjiNqlkOrM8jK+23bYQkw==
X-Received: by 2002:a05:6102:d8e:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-5248bbc6aadmr4257203137.4.1756482866356; 
 Fri, 29 Aug 2025 08:54:26 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-529aee9a689sm1184505137.4.2025.08.29.08.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:54:25 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
Date: Fri, 29 Aug 2025 09:46:37 -0600
Message-ID: <20250829155415.90634-1-javier.tia@linaro.org>
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

A temporary block device is created from the downloaded image and
part_driver_lookup_type() is used for comprehensive partition detection.
If a partition driver is found, the temporary device is reused instead
of being destroyed and recreated.

Signed-off-by: Javier Tia <javier.tia@linaro.org>

---
Changelog:
- v3 changes:
  Update prepare_loaded_image() to require a non-null blk_dev parameter,
  eliminating the conditional branching logic and replacing it with
  direct assignment. In try_load_from_uri_path(), variable declarations
  were moved to follow U-Boot Coding convention, redundant cleanup calls
  were consolidated into a single location, and control flow was
  improved by replacing empty conditional blocks with logical else
  clauses for debug logging.
- v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

---
 disk/part.c                  |  2 +-
 include/part.h               | 18 +++++++++
 lib/efi_loader/efi_bootmgr.c | 78 +++++++++++++++++++++++++++---------
 3 files changed, 79 insertions(+), 19 deletions(-)

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
index 662993fb809..60e8804b1da 100644
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
@@ -346,19 +347,26 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
  * @size:	image size
  * @dp:		pointer to default file device path
  * @blk:	pointer to created blk udevice
+ * @blk_dev:	existing block device to use (must be non-NULL)
  * Return:	status code
+ *
+ * Caller must pass a valid non-NULL blk_dev; cleanup of temporary devices
+ * is caller's responsibility.
  */
 static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 					 struct efi_device_path **dp,
-					 struct udevice **blk)
+					 struct udevice **blk,
+					 struct udevice *blk_dev)
 {
 	u64 pages;
 	efi_status_t ret;
 	struct udevice *ramdisk_blk;
 
-	ramdisk_blk = mount_image(label, addr, size);
-	if (!ramdisk_blk)
-		return EFI_LOAD_ERROR;
+	if (!blk_dev)
+		return EFI_INVALID_PARAMETER;
+
+	/* Use the provided block device */
+	ramdisk_blk = blk_dev;
 
 	ret = fill_default_file_path(ramdisk_blk, dp);
 	if (ret != EFI_SUCCESS) {
@@ -387,9 +395,7 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	return EFI_SUCCESS;
 
 err:
-	if (blkmap_destroy(ramdisk_blk->parent))
-		log_err("Destroying blkmap failed\n");
-
+	/* Cleanup is now the caller's responsibility */
 	return ret;
 }
 
@@ -407,7 +413,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -452,6 +458,20 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
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
@@ -466,7 +486,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -476,6 +495,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	efi_handle_t mem_handle = NULL;
 	struct efi_device_path *loaded_dp;
 	static ulong image_size, image_addr;
+	struct udevice *temp_bdev;
+	struct part_driver *part_drv = NULL;
 
 	ctx = calloc(1, sizeof(struct uridp_context));
 	if (!ctx)
@@ -516,17 +537,34 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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
+
+	/* Create temporary block device from the downloaded image for testing */
+	temp_bdev = mount_image(lo_label, image_addr, image_size);
+	if (temp_bdev) {
+		struct blk_desc *desc = dev_get_uclass_plat(temp_bdev);
+		if (!desc) {
+			cleanup_temp_blkdev(temp_bdev);
+			temp_bdev = NULL; // prevent double cleanup later
+		} else {
+			/* Use part_driver_lookup_type for comprehensive partition detection */
+			part_drv = part_driver_lookup_type(desc);
+		}
+	} else {
+		log_debug("mount_image() failed, will attempt PE-COFF detection\n");
+	}
+
+	if (part_drv) {
+		/* Reuse the temporary device instead of destroying and recreating */
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
-					   &loaded_dp, &blk);
-		if (ret != EFI_SUCCESS)
+					   &loaded_dp, &blk, temp_bdev);
+		if (ret != EFI_SUCCESS) {
+			cleanup_temp_blkdev(temp_bdev);
+			temp_bdev = NULL;
 			goto err;
+		}
 
 		source_buffer = NULL;
 		source_size = 0;
@@ -545,11 +583,15 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
-		log_err("Error: file type is not supported\n");
+		log_err("Error: disk image is not supported\n");
 		ret = EFI_UNSUPPORTED;
 		goto err;
 	}
 
+	/* Clean up temporary device if it was created but not used for disk image */
+	if (!part_drv)
+		cleanup_temp_blkdev(temp_bdev);
+
 	ctx->image_size = image_size;
 	ctx->image_addr = image_addr;
 	ctx->loaded_dp = loaded_dp;
-- 
2.51.0

