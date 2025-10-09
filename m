Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71E1CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 13:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95E684509;
	Thu,  9 Oct 2025 15:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mw6Zic5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D070D84461; Thu,  9 Oct 2025 15:18:20 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B1C844F0
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 15:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-930a1bb7b50so388839241.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760015897; x=1760620697; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ptb/7UXUBKd3JFPr2BJ/TYKZvFZQrmRYIVX2X+iJQ3M=;
 b=mw6Zic5KjQ+6n06JJXoFYvgZ04p628DyUdWz6tIn/A8cfUJsKYA31RGXqVyCKvfSVX
 iPSo6MmIvWWuZbyP17yGe+NS/0Ike1xkoHakcWfCK9JNKP5KQ3RO2bI3BdzCoEDN4zKX
 fVUsaT8ApvvFyoXUSUbRFHaa8lSgOkVU/kxtu7jrhp8C81v39iILnlezRz3P+nYalROi
 Kvn0MuHi5L+zNT12iWNeNf3Lg1PwExzaBQHcCP6lAx6r9vaDT4Ivw+mDTyXEapL7Lsig
 gzB0je//KvqC5FpeEupvvBcTJ5PibiDuhudK0KfCpStpoNqxVMXM1WtQNwYA1nKHaLct
 TTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015897; x=1760620697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ptb/7UXUBKd3JFPr2BJ/TYKZvFZQrmRYIVX2X+iJQ3M=;
 b=GrXxyrfkW8XpFR/x1k7q2fiEnb9mnCKkuH0V1FQEgKPc0XgRqhmdSyD3uYRyShdBk/
 lCmhVNehd0lxRHqzKBiEt3Y+XWnfhFLQE5zF++GACOwCGaQHwhY2mP+umEpbyiIJjpWL
 SzCzD5d2Oh0HaR4wiqS0HC8LWJaU1YXND7WVP+CMG4VYUI27N5qpudAhsRZZw1MM8Jn+
 k8ob2C/hO1VhTR6U0oM/CWGUdo8bDWLatuArCAMTYbd+/iF6Iswe0CDoZNybkcYn5TC5
 /oqNVswOwT2HUIqGMBZ22W1KkWTxtoNCsjnbA45qilGAYYC5icJJRvJYwdoXOnTCb7Nh
 gbMg==
X-Gm-Message-State: AOJu0Yy7S4b/IIcYtY6Fbx0w7yvFN4D8ZqsTmlmKG6PDdSp8C7gduwds
 U9mh6V3I/Y3IFbZUghnTEPC9Ali9cBQtSbZEEeug742+5P3W2ujjNkOX4BeOeaQPYQI=
X-Gm-Gg: ASbGnctp/CdRdxyB9FfFa0W76v5nPpQTodTztrFUqo2zfLirj26oDHuzVeFcry/U5rA
 pxHBeDQK46pGH/j5vJmuVaxeGMXpWcB1cfEa8FiUDJxfJDo44ODg6tyR3/cfIGEa+w+AoDZ21sQ
 XoncIZ8e82nZH/Mev6cDC49ddwipKTvLfuauBXMUx2gfxPgU+yb6IWDLOS8721iBQtlEk5B38br
 dKBqvxzHjh5Kwiiiy7jcStXW/4ICqxdn8a92WxoyRM3v2orCAGFTa2H3YVlCP5nl8CY68zRT/Pq
 WUvSq1z4Zu42T2uiU9Nrk8s6wPmFjfR4zY7AHwyt75Dw/Pvn2try8EYGGf8/gmC4gsNSx9OmZiQ
 Hi6Zk816DSSHcXXLnYGQSRwewyNlKtWM4JJpN5h/0pVw1s1QKJK/sufjHkdTAJqPVfbtgcenAiZ
 t7QXq56sVS
X-Google-Smtp-Source: AGHT+IF5tFNlSHVQ9yxpv9OoWivJpp4mcES9zgwIyhNtJPxwN455jFYN2ceRrxkLNgEwdyCpS/XYww==
X-Received: by 2002:a05:6102:c50:b0:523:712d:44a1 with SMTP id
 ada2fe7eead31-5d5e23644b3mr2901985137.19.1760015897366; 
 Thu, 09 Oct 2025 06:18:17 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5d5d3835333sm2400604137.3.2025.10.09.06.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 06:18:16 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Thu, 09 Oct 2025 07:17:47 -0600
Subject: [PATCH v8 2/2] efi_loader: Improve disk image detection in efi_bootmgr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-detect_disk_image_type-v8-2-a8b50a3b4acf@linaro.org>
References: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
In-Reply-To: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.3
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
 lib/efi_loader/efi_bootmgr.c | 49 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 662993fb809..d472dde158a 100644
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
@@ -407,7 +432,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 	if (!ctx)
 		return ret;
 
-	/* cleanup for iso or img image */
+	/* cleanup for disk image */
 	if (ctx->ramdisk_blk_dev) {
 		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
 					 EFI_CONVENTIONAL_MEMORY);
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

