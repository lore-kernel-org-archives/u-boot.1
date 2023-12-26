Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0571C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3378786E;
	Tue, 26 Dec 2023 07:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GVMeLlrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE9E8786A; Tue, 26 Dec 2023 07:30:30 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F4D87852
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35fd04ede25so19345195ab.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703572224; x=1704177024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPJwZhn+T7BYMDoLmE72/jYPNeVUTTMnXmX4tvGC9B8=;
 b=GVMeLlrY6fG8l2SMbBEGaf2hlccTHo/5m1U25ZTb4GbvaOVim2CFHrtG1vLRF/YMa/
 kpxXo2i2RicZr+lsscxG0l4iN4N3abIlV8t8mYWbYqL/sGW+81KxZZH7/BdGUqVDWUsD
 PfEAFrNErbG+OCvIuTxvHjMByIPoiYVB3OSiBlaGWl6VMKQiv6VUiT0TrY015jf5F0Cz
 wQPjfNTCWqNZ/uoN+mTwe9QMauSIKvFPww5oU48StyO1C3RwFVfh/fBSsRPby9l1Xquy
 hHo/d+06Te8BbuaWwILMkLDJ2hijp6vNqo0q2gwf1o4ioOjMxwQCP3TJGEzZzb4Az1yw
 T4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703572224; x=1704177024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPJwZhn+T7BYMDoLmE72/jYPNeVUTTMnXmX4tvGC9B8=;
 b=nrlWKqlqjqmSGGYCV1SaFvgXvr517cNnxbtJ3SNsBZV4x5vrhGExCzz+0eglfF8Sw8
 5qRpl3DYATEbPSBvNKVLqc6Zyv1hQFaGuEl3esGu6GFvaNWVbcEPDj8+kkoIqwYpsXGN
 Hy0CijEM2iZ7hzoe6NaWChE0E6Ad2hrzrBvflIi/W7dDt7jZ5685wxDV8qTvl9czYtXn
 GevWuscaWK/+cHnirS1ZaAt8PEOAIG/DOtTVZgZiIMTRJlgLQ0YU8diSXJ25FID9tfF5
 EVtU1dwmSjkp79vjkg7a8h9dQTspBg67k6o7cIp/+cHUVv5hF9C3FmfHuJrFQrSBgpK6
 jCgg==
X-Gm-Message-State: AOJu0Yw2U10vZ9bZ1t8zOZcGO7rTu7U4Az/raYBag7qsgEi94bjYRwPA
 ejtvxe8HJoUklWnbceJxIS/KTFWZSDlUADsfg82DEtd0V8M=
X-Google-Smtp-Source: AGHT+IGmN3PsyM+7D8lBTB0vWzbWCi+Z/HCo/FRtuQQka/fQP66/a1DhshX8xc+CmV0n3P6YTyWD4g==
X-Received: by 2002:a05:6e02:194e:b0:35f:754d:fed9 with SMTP id
 x14-20020a056e02194e00b0035f754dfed9mr10398552ilu.37.1703572224279; 
 Mon, 25 Dec 2023 22:30:24 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 p23-20020a635b17000000b005c66b54476bsm8469212pgb.63.2023.12.25.22.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 22:30:22 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 1/2] efi_loader: auto-generate boot option for each blkio
 device
Date: Tue, 26 Dec 2023 15:28:19 +0900
Message-Id: <20231226062820.722358-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226062820.722358-1-masahisa.kojima@linaro.org>
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
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

Current efibootmgr auto-generates the boot option for all
disks and partitions installing EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
while EDK II reference implementation auto-generates the boot option
for all devices installing  EFI_BLOCK_IO_PROTOCOL with
eliminating logical partitions.

This commit modifies the efibootmgr to get aligned to EDK II.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 94 +++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 23 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 56d97f2382..747f75ee82 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -560,6 +560,50 @@ err:
 	return ret;
 }
 
+/**
+ * try_load_from_media() - load file from media
+ *
+ * @file_path:	file path
+ * @handle:	pointer to handle for newly installed image
+ *
+ * If @file_path contains a file name, load the file.
+ * If @file_path does not have a file name, search the architecture-specific
+ * default file and load it.
+ * TODO: If the FilePathList[0] device does not support
+ * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL but supports EFI_BLOCK_IO_PROTOCOL,
+ * call EFI_BOOT_SERVICES.ConnectController()
+ * TODO: FilePathList[0] device supports EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
+ * not based on EFI_BLOCK_IO_PROTOCOL
+ *
+ * Return:	status code
+ */
+static efi_status_t try_load_from_media(struct efi_device_path *file_path,
+					efi_handle_t *handle)
+{
+	efi_handle_t h;
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_device_path *rem, *dp = NULL;
+	struct efi_device_path *final_dp = file_path;
+
+	h = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
+	if (h) {
+		if (rem->type == DEVICE_PATH_TYPE_END) {
+			/* no file name present, try default file */
+			ret = check_disk_has_default_file(h->dev, &dp);
+			if (ret != EFI_SUCCESS)
+				return ret;
+
+			final_dp = dp;
+		}
+	}
+
+	ret = EFI_CALL(efi_load_image(true, efi_root, final_dp, NULL, 0, handle));
+
+	efi_free_pool(dp);
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -594,7 +638,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
-		struct efi_device_path *file_path;
 		u32 attributes;
 
 		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
@@ -611,10 +654,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 			else
 				ret = EFI_LOAD_ERROR;
 		} else {
-			file_path = expand_media_path(lo.file_path);
-			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
-						      NULL, 0, handle));
-			efi_free_pool(file_path);
+			ret = try_load_from_media(lo.file_path, handle);
 		}
 		if (ret != EFI_SUCCESS) {
 			log_warning("Loading %ls '%ls' failed\n",
@@ -748,19 +788,19 @@ error:
  * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
  *
  * @opt:		pointer to the media boot option structure
- * @volume_handles:	pointer to the efi handles
+ * @handles:		pointer to the efi handles
  * @count:		number of efi handle
  * Return:		status code
  */
 static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
-						      efi_handle_t *volume_handles,
-						      efi_status_t count)
+						      efi_handle_t *handles,
+						      efi_uintn_t *count)
 {
-	u32 i;
+	u32 i, num = 0;
 	struct efi_handler *handler;
 	efi_status_t ret = EFI_SUCCESS;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < *count; i++) {
 		u16 *p;
 		u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
 		char *optional_data;
@@ -768,8 +808,15 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		char buf[BOOTMENU_DEVICE_NAME_MAX];
 		struct efi_device_path *device_path;
 		struct efi_device_path *short_dp;
+		struct efi_block_io *blkio;
+
+		ret = efi_search_protocol(handles[i], &efi_block_io_guid, &handler);
+		blkio = handler->protocol_interface;
 
-		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
+		if (blkio->media->logical_partition)
+			continue;
+
+		ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
 		ret = efi_protocol_open(handler, (void **)&device_path,
@@ -777,7 +824,7 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		if (ret != EFI_SUCCESS)
 			continue;
 
-		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
+		ret = efi_disk_get_device_name(handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
 		if (ret != EFI_SUCCESS)
 			continue;
 
@@ -801,17 +848,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		 * to store guid, instead of realloc the load_option.
 		 */
 		lo.optional_data = "1234567";
-		opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
-		if (!opt[i].size) {
+		opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
+		if (!opt[num].size) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
 		/* set the guid */
-		optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
+		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
+		num++;
 	}
 
 out:
+	*count = num;
+
 	return ret;
 }
 
@@ -1040,8 +1090,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
 /**
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
- * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * This function enumerates all BlockIo devices and add the boot option for it.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -1057,13 +1106,13 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 	u32 i;
 	efi_status_t ret;
 	efi_uintn_t count;
-	efi_handle_t *volume_handles = NULL;
+	efi_handle_t *handles = NULL;
 	struct eficonfig_media_boot_option *opt = NULL;
 
 	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
-					   &efi_simple_file_system_protocol_guid,
+					   &efi_block_io_guid,
 					   NULL, &count,
-					   (efi_handle_t **)&volume_handles);
+					   (efi_handle_t **)&handles);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1073,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_option(opt, handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1122,7 +1170,7 @@ out:
 			free(opt[i].lo);
 	}
 	free(opt);
-	efi_free_pool(volume_handles);
+	efi_free_pool(handles);
 
 	if (ret == EFI_NOT_FOUND)
 		return EFI_SUCCESS;
-- 
2.34.1

