Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F6DC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 22:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA8B8319C;
	Thu, 31 Jul 2025 00:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BjUZkA09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B6B6831B4; Thu, 31 Jul 2025 00:49:51 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983A28318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 00:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4efbfe9c7a5so956793137.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753915785; x=1754520585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eUgq7hLO2vQch/gEIC9bTMfMcd4nz4HavE1O3PDDE8E=;
 b=BjUZkA092xr7ovmmwvbsRpf5GVErM3cQssLZyzcUtgQiE/yhuDWEF81mdyamjL6vQN
 K7+FU2H6WnMuuqRaltu2JxlTkXETuxBn5D+PapNvLQRMsJwZSkN+QORE/uqaCN7gTM7Y
 WD7EYX+joreupWPav93UxLn6U9bs38cQqvuqUd7/WigF7T1NWUfRBXKlLH6rFu+eZoA0
 HCVGDrpkSgebGraeJHVCdKvkFkXN5Gb4bHF0gxaRI14C5MW+eh1G2hPdiiItJQKe9CST
 ORYApvNNOrdg8WZFu6r+sqceBDw93xzWFLgOuAa+05TIxsNSsJv76ZhB9103mKMFodHu
 LBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753915785; x=1754520585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUgq7hLO2vQch/gEIC9bTMfMcd4nz4HavE1O3PDDE8E=;
 b=s2YpZ87mWrl+aBLup4RLHFEo/nAsXthq8uK/AerqC/EFz1R/2IJFdywQZB+L4j3X7x
 PBVgmgfenXf47Yx4a14k3tmgGvnuiQh8yac2bkYHG0pJEfC5PqELvNVISSMuvNgmzIpa
 hvwwMFPSzr6yzQkBM1GjzpUUnDBWqiG3zjJm9W/tkYm4TLmVqSrrRpsHh7wRSYv9YowK
 0ETKfLk2o7sSGep3IQm+yJ4NqJky4MyTsW11twF1TOcZNg4Pwf4P/gl2vaLux/1I8I3Q
 U06bT7yGQ5L0S0i8xGJv/1zu4vBpf8RlcXXNQ+zIOxw0kIO0UwRR7flpVO/35n/UqaBp
 ftEQ==
X-Gm-Message-State: AOJu0Yyz9P9WhWoH3lFfw5y758G3v5mcSGv6tU3dFeAsWnw8PqaPcYt8
 uiGoW9GAjyGySFx2VgUz7rdaccviKqVic4Clw1RJqEU3QdB1g1ksFG8XTjPSEdwdox382t+05AQ
 58Cfy
X-Gm-Gg: ASbGncsvqc+QegX4qYJc8lsnQCXcKT1cskZzrwadeghLXsLeI/UjHJqiYaDujDc7WEd
 UT4hKgli31CMWpH4OjEM951oXy344V9/b23uBvYAmIA2Rau7hJFaWnc8v8EgTh7eKthYDE1jHxw
 dszYCSVoP4l3HmnT2W5wX6HzQ+t4g9JBODwf4ZwXvvsM+hvTYHQWedxgpdiN2uqaTe65yYCcEhc
 WInm164xXvZbYcpzXcfdee5JZFN4Bts0zn0S5VMceP1UtVMzkhuE2Qwm1cPRckphXkPpzWJgiAR
 Lq1zViDRQGipFMQLfzbDT+kizhFGn3BwFU9KY6VFWSt0KfFmJSsM9unaXSWtO7Dgi3lUnv5Ty1h
 VggwI3r5b7sOk5HEHGTXQBZf3qU+AZWikNFF+59fj6adzN3rQhRc=
X-Google-Smtp-Source: AGHT+IHZkz12LkrYhjloSMARuAMwUDxBxT/HZlffnpS+N1+AZZEfQjEHyzke5XoMu8I1Mud6woLwNg==
X-Received: by 2002:a05:6102:f95:b0:4df:9281:5ec3 with SMTP id
 ada2fe7eead31-4fbe9cdfb15mr3282293137.2.1753915785132; 
 Wed, 30 Jul 2025 15:49:45 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([190.113.103.157])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4fc0d42bba7sm37748137.11.2025.07.30.15.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:49:44 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] disk: efi_loader: Add function to detect disk image type
Date: Wed, 30 Jul 2025 16:49:41 -0600
Message-ID: <20250730224942.755510-1-javier.tia@linaro.org>
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

This commit introduces a new function, detect_disk_image_type(), which
checks if a buffer contains a disk image. This function is used to
detect disk images based on their headers, rather than relying on file
extensions.

The function checks for ISO 9660, DOS MBR, and GPT protective MBR
signatures. It returns 1 if a disk image is detected, and 0 otherwise.

This function is then used in the efi_bootmgr.c file to determine if a
downloaded file is a PE-COFF image or a disk image. This change
improves the reliability of disk image detection, as it no longer
relies on file extensions, which can be easily changed or omitted.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c                  | 46 ++++++++++++++++++++++++++++++++++++
 include/part.h               |  9 +++++++
 lib/efi_loader/efi_bootmgr.c | 29 ++++++++++-------------
 3 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..9d9483b216c 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -855,3 +855,49 @@ int part_get_bootable(struct blk_desc *desc)
 
 	return 0;
 }
+
+/**
+* detect_disk_image_type() - Detect if buffer contains a disk image
+*
+* @buffer:  Buffer containing potential disk image data
+* @size:    Size of the buffer
+* Return:   1 if disk image detected, 0 otherwise
+*/
+int detect_disk_image_type(void *buffer, size_t size)
+{
+	unsigned char *buf = (unsigned char *)buffer;
+
+	/* Need at least 512 bytes for basic checks */
+	if (!buffer || size < 512)
+		return 0;
+
+#if IS_ENABLED(CONFIG_ISO_PARTITION)
+	/* Check for ISO 9660 signature "CD001" at offset 0x8001 */
+	if (size > 0x8005) {
+		if (buf[0x8001] == 'C' && buf[0x8002] == 'D' &&
+		    buf[0x8003] == '0' && buf[0x8004] == '0' &&
+		    buf[0x8005] == '1') {
+			return 1;
+		}
+	}
+#endif
+
+#if IS_ENABLED(CONFIG_DOS_PARTITION)
+	/* Check for DOS MBR signature 0x55AA at offset 0x1FE */
+	if (buf[0x1FE] == 0x55 && buf[0x1FF] == 0xAA) {
+		return 1;
+	}
+#endif
+
+#if IS_ENABLED(CONFIG_EFI_PARTITION)
+	/* Check for GPT protective MBR */
+	if (buf[0x1FE] == 0x55 && buf[0x1FF] == 0xAA) {
+		/* Check if partition type is 0xEE (GPT protective) */
+		if (buf[0x1C2] == 0xEE) {
+			return 1;
+		}
+	}
+#endif
+
+	return 0;
+}
diff --git a/include/part.h b/include/part.h
index b772fb34c8a..39c04e0c8f7 100644
--- a/include/part.h
+++ b/include/part.h
@@ -727,6 +727,15 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * detect_disk_image_type() - Detect if buffer contains a disk image
+ *
+ * @buffer: Buffer containing potential disk image data
+ * @size:   Size of the buffer
+ * Return:  1 if disk image detected, 0 otherwise
+ */
+int detect_disk_image_type(void *buffer, size_t size);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 662993fb809..da63ad41b40 100644
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
+	/* cleanup for image file */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
@@ -466,7 +467,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 {
 	char *s;
 	int err;
-	int uri_len;
 	efi_status_t ret;
 	void *source_buffer;
 	efi_uintn_t source_size;
@@ -516,21 +516,10 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	image_size = ALIGN(image_size, SZ_2M);
 
 	/*
-	 * If the file extension is ".iso" or ".img", mount it and try to load
-	 * the default file.
-	 * If the file is PE-COFF image, load the downloaded file.
+	 * Check if the downloaded file is a PE-COFF image or a disk image.
+	 * Use header-based detection instead of file extensions.
 	 */
-	uri_len = strlen(uridp->uri);
-	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
-	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
-		ret = prepare_loaded_image(lo_label, image_addr, image_size,
-					   &loaded_dp, &blk);
-		if (ret != EFI_SUCCESS)
-			goto err;
-
-		source_buffer = NULL;
-		source_size = 0;
-	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+	if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
 		/*
 		 * loaded_dp must exist until efi application returns,
 		 * will be freed in return_to_efibootmgr event callback.
@@ -544,6 +533,14 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
 		source_buffer = (void *)image_addr;
 		source_size = image_size;
+	} else if (detect_disk_image_type((void *)image_addr, image_size)) {
+		ret = prepare_loaded_image(lo_label, image_addr, image_size,
+					   &loaded_dp, &blk);
+		if (ret != EFI_SUCCESS)
+			goto err;
+
+		source_buffer = NULL;
+		source_size = 0;
 	} else {
 		log_err("Error: file type is not supported\n");
 		ret = EFI_UNSUPPORTED;
-- 
2.50.1

