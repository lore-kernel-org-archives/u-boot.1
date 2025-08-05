Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAB7C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039CD83890;
	Tue,  5 Aug 2025 18:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m7IylDpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248D08388B; Tue,  5 Aug 2025 18:22:07 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8618388B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-53924027b19so1126991e0c.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754410922; x=1755015722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U1Izf0TAKscYtwkR2Ly1lbZ/IyGe7lG2b9jIiKYNM90=;
 b=m7IylDpIAmfUwIZZLD8Xbiv0aObW653363NZ+SBbrFOMQ+ynxcYO/YlEAD5xz8m8Lf
 Ll8PT/MbP5yVsu7E2h8y+pM31JlOn/2GZNNvONblAl7pvpDh6hY+lbhdYonJQVa6zTL5
 XX/XxjqRxNs+Zb78oNWpNvSFlRDHZZOPDW9DrkVqbrm9wAR4yPoCtaxYuWd19YtbrCud
 hG11R1YyThPFA4MyRcI3uXTz8G0jJoA62JjRgqbtJCuSFnBu8NEVD2xnmMSp0gSkI9N0
 Hs2cuqWZGwu5xPalTLVMHd7PLefH8ZX4wsUvU2KdheWv5jrfgeDumKKxe5tlUdJD4iLW
 ZnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754410922; x=1755015722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U1Izf0TAKscYtwkR2Ly1lbZ/IyGe7lG2b9jIiKYNM90=;
 b=ExVEwKvKc5ScQwn+duhSZ20Eev6+r3yHBh69CRZTCpawjxt5OFMr6S0ScPVYd/HQBu
 zoGAWL8v6lHmLTY/YOzdxWua6mSUXlJFQ59gRvzjtfqbZn1VKPBkLWBvPHSKKm1zQ/UY
 +1vUU2dsrt+J29QPY1NtmxRPiy/5fOY5j7ItsPMwQFLa9w04NMpvL7BFA1i8Y8StlgvD
 LFVPQ+SfLdpJT6FV902AT+4SKVnSKDZzqW221ZOm22KXOl+v73wEQFIft/MCByfWGNWV
 S01LRUXIqfmO3YY3J3vEZNCzoeFcmD6Nz7tUyduATtrXwnQ3o9emwjdFCj4VotIoDrDn
 nZ9A==
X-Gm-Message-State: AOJu0YzS6zA5yIQ8ePluYaxN9Ogrg1E9WkIIw9Qo+y3UKoFue98EXvlt
 i3O+KqLPmqD/4u7KW0tuup6ct7YXSNc+Ma/azIVjx3hmUcTa50tcK1slorigPJOAoN/1rFwgTJs
 o2bqC
X-Gm-Gg: ASbGncvIIq7nyHtzUD5wKkvNuw12vROeuoo+8GaHBHFR1IDVvHdzHlY7NmJhjbbjAGc
 1/jNcqRcW/MTyqT3gyBSJZmGTT6H1D2zaEmCfVsdtA+AnGnhWHvd4xvKPH6v8iUgUqUOmCG0skH
 38EO5/FfXW2AHuWgcaaY8iY6smUlviBnlKpIbXQcfPhyXIKX2ORP6ZOA1P/ZlxEo9+pUisMKNft
 ffBLy52ElTMJM0+S4slEKO3amkwxI+LMO08TmY9DzVd1FdDPUL1UvMY/Xq6iD1SW8Fgk9nVvNUC
 nMdThs+uFRItSUPKZXdThmEiEN5R3xSQ4OqIcfd9WLUDxP1qP13KbPd4Wh++A+FV1+jqo5XbdJ1
 yCCg/FAwwN2wVf9c31ZtMMjvZ8M5j7B+xyVaBLwfA0TUzWCUfyhE=
X-Google-Smtp-Source: AGHT+IFQ2Wp/BKDt8JEFyeKwbDnndYVH3i72o30649zq/uzG2OQIe0EzhoHx3j8rq2b5HZRxeRowVg==
X-Received: by 2002:a05:6122:130d:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-5395f3515d5mr5611458e0c.10.1754410922070; 
 Tue, 05 Aug 2025 09:22:02 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([190.113.103.157])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53936b1696asm3668119e0c.2.2025.08.05.09.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 09:22:01 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] disk: efi_loader: Improve disk image detection in efi_bootmgr
Date: Tue,  5 Aug 2025 10:21:57 -0600
Message-ID: <20250805162158.117876-1-javier.tia@linaro.org>
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
more accurate disk image detection. It also improves error handling by
adding a cleanup function for temporary block devices.

The partition driver lookup function is also made public to enable its
use in the EFI boot manager. The function documentation is updated
accordingly.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c                  |  3 +-
 include/part.h               | 18 +++++++++++
 lib/efi_loader/efi_bootmgr.c | 59 ++++++++++++++++++++++++++++++------
 3 files changed, 70 insertions(+), 10 deletions(-)

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
index 662993fb809..7acb4f4e92b 100644
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
@@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -452,6 +453,20 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
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
@@ -466,7 +481,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,13 +530,37 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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
+			/* Use part_driver_lookup_type for comprehensive partition detection */
+			part_drv = part_driver_lookup_type(desc);
+
+			/*
+			 * If it's a disk image with valid partition type,
+			 * prepare_loaded_image will create the final block device
+			 */
+			if (part_drv)
+				/* Clean up temporary device, prepare_loaded_image will create a new one */
+				cleanup_temp_blkdev(temp_bdev);
+		}
+	}
+
+	if (part_drv) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
 					   &loaded_dp, &blk);
 		if (ret != EFI_SUCCESS)
@@ -545,7 +583,10 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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

