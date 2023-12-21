Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201E5C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E303687862;
	Thu, 21 Dec 2023 10:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="neu1rAi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFED8785F; Thu, 21 Dec 2023 10:54:54 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C104D8785A
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c6ce4dffb5so229911a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703152490; x=1703757290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEsNUREktd4Ceezuc4AmaJ0enT6WLmKAXceoYvSvne8=;
 b=neu1rAi0mAJoTiHeCNUZin/a5OZeOozoc9DE9lRZg9TMdlwGrU8MoqHuFrhC0Nvq9k
 7WUSX5Fhf+RWgTWvtTMif8y+04Xl+hjUppKhTMQQ0RfOY1qsbF5G1blL9i7jwh95n2nb
 KGin3kuSwGR+aDN1NML7wMjkFYkxtNhrb3vbD3NHwV60AsfOcF2Euah8wTSFqwN4kw24
 5fRRQyvFpQhssNdhaHwXRSbKxRkGx0FMC7ERtr/0aNfqzArqoUEYxGbknuqD3JRiI4WS
 fJdrLDCSh03KN7YRkzCU8qT2/ljHMl8yJBmVIVNZPUYMSSfxz7QlgS6ptAdAKRbxei1n
 Q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703152490; x=1703757290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEsNUREktd4Ceezuc4AmaJ0enT6WLmKAXceoYvSvne8=;
 b=AN+DYSFxhkXO+mroyanwG4lCWVlGlmsNoFoNl3dRhTDaR2KJjJOHIBAbNOiXcn+rRT
 X0p16wOWq8XPc/v4tviQ/Jn9uM5AqidHV/U3OHL6GgrhIJT8Ly9ZK7k5QAhoJqINSJs1
 VehX5kPYvgKQVQopeNaqjk+Oxn7Di2BTgIFTu1qoBISNvhgrfDMxmjPkcCESMJM3naLW
 Hk4n2FdxDjKjycczRTgErBANBHe7VX48nQV08N9HLAiiY8flxPLhpuFP1EMdDuc+Feag
 Mwu1PXSwjHXa3TMwdFbIwT/sse9z0+Cup9dGSlMk07DvKg4SoJfIh89fV4ffgiTVTDcF
 W0wQ==
X-Gm-Message-State: AOJu0Yz0WZAS866dKFgqKVkM2M+oWjbqw8JEKFfGyCuYt2jDkUB6zIIk
 9uqRu6thgxRHXIdwaXneEvN8EV/oM2s5ACWzUes=
X-Google-Smtp-Source: AGHT+IGhTZpiVf+pQ8ixSCr7Yl3loTPq/g4YmPU796dgmLE6pRyqWZa5D6jKvLlBNMHHkpQd7NjLyQ==
X-Received: by 2002:a05:6a20:daa6:b0:195:fce:eeb3 with SMTP id
 iy38-20020a056a20daa600b001950fceeeb3mr232201pzb.106.1703152489744; 
 Thu, 21 Dec 2023 01:54:49 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 sr5-20020a17090b4e8500b0028afd8b1e0bsm772334pjb.57.2023.12.21.01.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 01:54:49 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 1/2] fwu: fix fwu_get_image_index interface
Date: Thu, 21 Dec 2023 18:52:57 +0900
Message-Id: <20231221095258.592275-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221095258.592275-1-masahisa.kojima@linaro.org>
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
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

The capsule update uses the DFU framework for updating
storage. fwu_get_image_index() currently returns the
image_index calculated by (dfu_alt_num + 1), but this is
different from the image_index in UEFI terminology.

Since capsule update implementation calls dfu_write_by_alt
function, it is better that FWU returns the dfu_alt_num.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/fwu.h                 | 13 +++++--------
 lib/efi_loader/efi_firmware.c | 11 +++++++++--
 lib/fwu_updates/fwu.c         | 32 ++++++++++++--------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index ac5c5de870..eb5638f4f3 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -122,21 +122,18 @@ int fwu_get_active_index(uint *active_idxp);
 int fwu_set_active_index(uint active_idx);
 
 /**
- * fwu_get_image_index() - Get the Image Index to be used for capsule update
- * @image_index: The Image Index for the image
- *
- * The FWU multi bank update feature computes the value of image_index at
- * runtime, based on the bank to which the image needs to be written to.
- * Derive the image_index value for the image.
+ * fwu_get_dfu_alt_num() - Get the dfu_alt_num to be used for capsule update
+ * @image_index:	The Image Index for the image
+ * @alt_num:		pointer to store dfu_alt_num
  *
  * Currently, the capsule update driver uses the DFU framework for
  * the updates. This function gets the DFU alt number which is to
- * be used as the Image Index
+ * be used for capsule update.
  *
  * Return: 0 if OK, -ve on error
  *
  */
-int fwu_get_image_index(u8 *image_index);
+int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num);
 
 /**
  * fwu_revert_boot_index() - Revert the active index in the FWU metadata
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9abb29f1df..9b8630625f 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -611,6 +611,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	u16 **abort_reason)
 {
 	int ret;
+	u8 dfu_alt_num;
 	efi_status_t status;
 	struct fmp_state state = { 0 };
 
@@ -625,19 +626,25 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	if (status != EFI_SUCCESS)
 		return EFI_EXIT(status);
 
+	/*
+	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
+	 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
+	 * is not used.
+	 */
+	dfu_alt_num = image_index - 1;
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		/*
 		 * Based on the value of update bank, derive the
 		 * image index value.
 		 */
-		ret = fwu_get_image_index(&image_index);
+		ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
 		if (ret) {
 			log_debug("Unable to get FWU image_index\n");
 			return EFI_EXIT(EFI_DEVICE_ERROR);
 		}
 	}
 
-	if (dfu_write_by_alt(image_index - 1, (void *)image, image_size,
+	if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
 			     NULL, NULL))
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index b580574015..86518108c2 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -125,16 +125,14 @@ static int in_trial_state(struct fwu_mdata *mdata)
 	return 0;
 }
 
-static int fwu_get_image_type_id(u8 *image_index, efi_guid_t *image_type_id)
+static int fwu_get_image_type_id(u8 image_index, efi_guid_t *image_type_id)
 {
-	u8 index;
 	int i;
 	struct efi_fw_image *image;
 
-	index = *image_index;
 	image = update_info.images;
 	for (i = 0; i < update_info.num_images; i++) {
-		if (index == image[i].image_index) {
+		if (image_index == image[i].image_index) {
 			guidcpy(image_type_id, &image[i].image_type_id);
 			return 0;
 		}
@@ -332,24 +330,20 @@ int fwu_set_active_index(uint active_idx)
 }
 
 /**
- * fwu_get_image_index() - Get the Image Index to be used for capsule update
- * @image_index: The Image Index for the image
- *
- * The FWU multi bank update feature computes the value of image_index at
- * runtime, based on the bank to which the image needs to be written to.
- * Derive the image_index value for the image.
+ * fwu_get_dfu_alt_num() - Get the dfu_alt_num to be used for capsule update
+ * @image_index:	The Image Index for the image
+ * @alt_num:		pointer to store dfu_alt_num
  *
  * Currently, the capsule update driver uses the DFU framework for
  * the updates. This function gets the DFU alt number which is to
- * be used as the Image Index
+ * be used for capsule update.
  *
  * Return: 0 if OK, -ve on error
  *
  */
-int fwu_get_image_index(u8 *image_index)
+int fwu_get_dfu_alt_num(u8 image_index, u8 *alt_num)
 {
 	int ret, i;
-	u8 alt_num;
 	uint update_bank;
 	efi_guid_t *image_guid, image_type_id;
 	struct fwu_mdata *mdata = &g_mdata;
@@ -365,7 +359,7 @@ int fwu_get_image_index(u8 *image_index)
 	ret = fwu_get_image_type_id(image_index, &image_type_id);
 	if (ret) {
 		log_debug("Unable to get image_type_id for image_index %u\n",
-			  *image_index);
+			  image_index);
 		goto out;
 	}
 
@@ -380,15 +374,13 @@ int fwu_get_image_index(u8 *image_index)
 			img_entry = &mdata->img_entry[i];
 			img_bank_info = &img_entry->img_bank_info[update_bank];
 			image_guid = &img_bank_info->image_uuid;
-			ret = fwu_plat_get_alt_num(g_dev, image_guid, &alt_num);
-			if (ret) {
+			ret = fwu_plat_get_alt_num(g_dev, image_guid, alt_num);
+			if (ret)
 				log_debug("alt_num not found for partition with GUID %pUs\n",
 					  image_guid);
-			} else {
+			else
 				log_debug("alt_num %d for partition %pUs\n",
-					  alt_num, image_guid);
-				*image_index = alt_num + 1;
-			}
+					  *alt_num, image_guid);
 
 			goto out;
 		}
-- 
2.34.1

