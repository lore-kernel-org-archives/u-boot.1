Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F83CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 23:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C978368E;
	Thu, 25 Sep 2025 01:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dysakD/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A499F83678; Thu, 25 Sep 2025 01:31:29 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FDBA8365C
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 01:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-54adce22b2cso188594e0c.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758756685; x=1759361485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yU85NmBe3NrjypGcF+mvnEVY9psNBo6INGvhOKsXB/w=;
 b=dysakD/SIQGaJlwyi0avQBIB1jnD8PhGSjsFjPF+nF0cc1uIG+o1m3IOrK/XMTzs1Y
 hj2VYzLGLEA68Gw6ZvCRil5P/21jYvoMEvfvTJgMHlstgRR6xdRBoY4kX5WNPTzSNSTW
 rLs+JoB4NlqrLEbDqoRJ5NdgAGHHx8771519DEdlc6pSiW61RigFEgR46wPs3PIDyLcU
 +dlYHlyPN5b1XM0D6EJwbtaBFL30SCCCrBHUf8QGV5f9hUiJHus43FnQuNqYZuNCOdCh
 jiqFnedlGLrCXHJNhrCLmN4DxSQMA2KJ7UmY/WzKjxkpVuAm2up2BAUhbyIddpvS6xXZ
 eVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758756686; x=1759361486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yU85NmBe3NrjypGcF+mvnEVY9psNBo6INGvhOKsXB/w=;
 b=mvgazT9aIfG6OBzObX3V997/oF5CpMaNaPnq4T9I1eaglxyL+Owz9HWWBMfFzTgdOc
 617LM9qCbR2CMeyPq8s08SH3fKnjGj/d2CdP7JYMs9Yudm4d7C0gj02GZPLOxV6opz1f
 JZIrdrAGzEbnwkoqmk/ouIluLUNjWt3OHC9bwmqZ+p89n67Am6XJwsTpssr9Pq+zZd4z
 lvluuPB0PIfdgaJYd64tj+6urreJRyQKdQtcTqymJ78rNerL/Fs88S3iprLrU2MIM9fK
 BcCSwP54PRY6CPoAw+mqx0ojcaWiw5zs8a8PaTAm6MoyoBeaiiKS3+UcsWGUUZbBtLDo
 iigA==
X-Gm-Message-State: AOJu0YzORt2fUmZ4we+0fm1QwTiTN+RR4nk4V3dHOB5pKCazCOlxW75v
 r7rwloMGa4NALipuPcfKagyqNwUvJxLlsn3bl/w8SV9kdcFyrPNC+RHG9Nz6gCkd7dasqVXSCpr
 X/z68
X-Gm-Gg: ASbGncviCYwnIDGDCskgd95EkjMAHFJXE0AEU4MVCdj83QIyxmazQAn8ueIcmZwrdyo
 7xqeWiaG/BAj/WiL6cB2Qdn6aQu+wjhK5c9lqiYkq7eyQQgkkiZgG9c4nerEiq1xzQN7AwfGjFN
 QjkaivzvMrQunKJjsZgh5z+I3sBrgWcDYmIzrf3PHWjVpuDyuaiL/IwU6dpVQQAdKhcqrhTBBM8
 Y2pa+zu3MM1DGlGpHC8Nu9lDOZCRl4r9J1SYzWtlYoHr5b9jrYQUNDofmZzCqw+ppgvs2vvmkkU
 sWmh/SWfG2dqpNCKWb90bM/g7JPo+/4tRPs9clCqBtcjKtT5rfAbCQ10HgiiBHOqb0FTXZVIpwB
 R1hZ732ybhUVJ/h49VObIL9wfSuab/AtEtqh+UE3izDzQdboc
X-Google-Smtp-Source: AGHT+IF6wB2pNaa9G+Soc1gzRGQA6cufT7HzN/dR6Y+bODpS8KOVU0SaftzpmUYkPk2K8hVzbn9fkw==
X-Received: by 2002:a05:6122:d8c:b0:54a:a251:ad57 with SMTP id
 71dfb90a1353d-54bea37890bmr743888e0c.16.1758756685556; 
 Wed, 24 Sep 2025 16:31:25 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54bede0587asm101577e0c.30.2025.09.24.16.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 16:31:25 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 2/2] efi_loader: Improve disk image detection in efi_bootmgr
Date: Wed, 24 Sep 2025 17:31:20 -0600
Message-ID: <20250924233120.454116-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924233120.454116-1-javier.tia@linaro.org>
References: <20250924233120.454116-1-javier.tia@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

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

