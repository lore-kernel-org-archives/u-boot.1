Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB1C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A092835D8;
	Thu, 31 Jul 2025 23:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C2tT2AYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65436838D4; Thu, 31 Jul 2025 23:35:58 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E97830C0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 23:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-53945ba7f2aso192142e0c.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997754; x=1754602554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5zX3Cax81Pa6lmun26iHJYSee5vj5x8t+G55HD1pWA=;
 b=C2tT2AYZxiZp07viYW3LR3zdB5P82C7NDVY1t8cb95aIKXdO928bwXAqoMqx5aFdD8
 r68fOe2SGrzplKZp0S+o8JNisodHIRzbXhNEFIdQyJXnUMX9shy1nqk2RTx6+9iuP5zm
 UIJZhfQcUNZXloJbIQQqSF6O7A5GJvVBuZfDbGo0AbAtF3ChGvZztcfDC8jRSJyIxNFO
 bC1b25UcN3Y1WSF64ogJitRJwdZLIFHIXUM7qRBOr1Scu+hTp2FpuOXOrrG7oHvnH9Yi
 DKGCEEF5K19IW6gVGXIGUFd1UbufBpXeTcMLdiMiJ+N6f2NjUE3kmmSh0lpgfcRmsBHW
 eaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997754; x=1754602554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5zX3Cax81Pa6lmun26iHJYSee5vj5x8t+G55HD1pWA=;
 b=DblOgH7EvYnn6W48cPOeFi4BdQaxFMDGxoDr/+jIfmyAokWvX2PEEGzQoHUJ/2iDR0
 qf3W8IPnJKLfA1T9oxltkHPMUSF0VdsRe2CUGuCshIVGiYeGs92UMx0JGWmOFShWHq22
 tUF5Kos2bG7N66jXCAgw1+EYfzFxvsoQmoxWvqXvGAo3Cxkr5Yq9J5CffdkdwgUlN4kR
 wuF8ZVyUSouRmDGgGskduAe64sgAnRSDrAChduCZ7Rna33Ry2YQFfRBBdLG52e8b/ylA
 N5oA/sWqTKR7pxFBM3kvAm2zYVY2ZkwE9T75d/OY0ZOrNUQP+9exNK5SHHAu1uFaXYSn
 ocNQ==
X-Gm-Message-State: AOJu0YyPbmJq4RaSHw1lqYLagM2Drl4oJG/YmPIdHxvGxmYTO83dLVlB
 E9QclGzxjJ6KALLkfOJu4EOl95llPBPywIqULdPwyzlzb6tdM17TInuHyaQmQAUa33REOf3SOTx
 7KU+A
X-Gm-Gg: ASbGnct65sp5LnNNiTyEgDKKT3ETCIzicNckKsP02J31Mklx4Ur1zz/iZXGWc0QNYei
 o0zHQDx6fSOhxZczEM0lUwR9PVT246Xyao/cGgPZKOZWlL1cnMmLO/ki8jQUpK69P1xHW+eYfJn
 jEs21/sE4ConfysbAHJpYrSQWVH+BDcFU4nDA8TQY8rf3TBvVxIrpud6gEKuYOApAbtJUvh4/wK
 AZwe/98mdEJ5YWp/PwpBO+tQO1E1ySGYHXCY3LVdP2U92x4hq5c/mGtcyTEMhIz8hHd4UJ+NgJl
 2K6qBSdrNsmHQzEBywh65pBweNjuCf0QrAViYIXypvxqz4ZgiHnEQJD/i+J/dn9rlO2gc8I+WPJ
 +wfzvarhj7NKEuecn7HJ1fS6iy1goKWbQssOWgFV9w05V0McAQm4=
X-Google-Smtp-Source: AGHT+IGd+RfXruKCLzHFLtb8b+oRTw82R8tD64QvRXxEAkBXPhqSele7XCDzf8BJPiN6WQc5Aya+iw==
X-Received: by 2002:a05:6122:8c2:b0:530:7ab8:49ab with SMTP id
 71dfb90a1353d-5391c9d1bc0mr5897167e0c.0.1753997753958; 
 Thu, 31 Jul 2025 14:35:53 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([190.113.103.157])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53936b15ea5sm658437e0c.5.2025.07.31.14.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 14:35:53 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] disk: Use part_driver_lookup_type() to valid downloaded image
Date: Thu, 31 Jul 2025 15:35:46 -0600
Message-ID: <20250731213547.654823-1-javier.tia@linaro.org>
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

The part_driver_lookup_type() function was made public to be used in the
EFI loader. This function is used to look up the partition type for a
block device.

This change allows the EFI loader to detect disk images by using the
partition driver lookup. This replaces the previous method of checking
the file extension, which was less optimal.

The EFI loader generates a temporary block device from the downloaded
image, employs the part_driver_lookup_type() function to verify the
partition type, and checks if it corresponds to a valid ISO 9660, DOS
MBR, or GPT EFI disk image, subsequently performing cleanup of the
temporary device. If the downloaded file does not constitute a valid
disk image, an error message will be logged, and the function will
return EFI_UNSUPPORTED.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c                  |  3 +-
 include/part.h               | 18 +++++++++
 lib/efi_loader/efi_bootmgr.c | 76 +++++++++++++++++++++++++++++++-----
 3 files changed, 87 insertions(+), 10 deletions(-)

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
index 662993fb809..f6729a40462 100644
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
@@ -452,6 +453,17 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
 	EFI_EXIT(ret);
 }
 
+/**
+ * cleanup_temp_blkdev() - Clean up temporary block device
+ *
+ * @temp_bdev: temporary block device to clean up
+ */
+static void cleanup_temp_blkdev(struct udevice *temp_bdev)
+{
+	if (blkmap_destroy(temp_bdev->parent))
+		log_err("Destroying temporary blkmap failed\n");
+}
+
 /**
  * try_load_from_uri_path() - Handle the URI device path
  *
@@ -466,7 +478,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,13 +527,55 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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
+			/* Validate partition type */
+			if (part_drv) {
+				if (part_drv->part_type != PART_TYPE_DOS &&
+				    part_drv->part_type != PART_TYPE_ISO &&
+				    part_drv->part_type != PART_TYPE_EFI) {
+					log_err("Unsupported partition type 0x%02x for EFI boot. "
+							"Only MBR DOS, ISO, and EFI partition types are supported.\n",
+							part_drv->part_type);
+
+					/* Clean up temporary device */
+					cleanup_temp_blkdev(temp_bdev);
+
+					/* Set part_drv to NULL to fall through to PE-COFF detection */
+					part_drv = NULL;
+				}
+			}
+
+			/*
+			 * If it's a disk image with supported partition type,
+			 * prepare_loaded_image will create the final block device
+			 */
+			if (part_drv) {
+				/* Clean up temporary device, prepare_loaded_image will create a new one */
+				cleanup_temp_blkdev(temp_bdev);
+			}
+		}
+	}
+
+	if (part_drv) {
 		ret = prepare_loaded_image(lo_label, image_addr, image_size,
 					   &loaded_dp, &blk);
 		if (ret != EFI_SUCCESS)
@@ -545,7 +598,12 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 		source_buffer = (void *)image_addr;
 		source_size = image_size;
 	} else {
-		log_err("Error: file type is not supported\n");
+		/* Clean up temporary device if it was created but not a valid disk image */
+		if (temp_bdev) {
+			cleanup_temp_blkdev(temp_bdev);
+		}
+
+		log_err("Error: disk image is not supported\n");
 		ret = EFI_UNSUPPORTED;
 		goto err;
 	}
-- 
2.50.1

