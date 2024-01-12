Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D2EC47077
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 00:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8DE87933;
	Fri, 12 Jan 2024 01:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yZKrKpRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6AA87227; Fri, 12 Jan 2024 01:21:38 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C709787956
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9a795cffbso4436068b3a.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705018892; x=1705623692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65wKEJNwvk9ZVpyhvumXc2zlAAX/IgYCkwnqilCNGvw=;
 b=yZKrKpRPJDyXf0APhZ+QLU8dmu1MHS/jvibNz6ktAK/5JVZvMBVGq24tViln2csUMV
 73BqZ7l0C8bPGU2x+2zt7aVwJXGHGRrFl5z4yvB1+SrJyTKrlsugNDVHoVlccHBRsSyK
 GFlpSNoC6FAGXrHM3I+nzBi06o40UyVscuy6AdyFfyjj0/m7QEvdQjIp6tZvJqDrAhbP
 vWLVo1e0wtwbT5usGgiXJdZlmF4Ddh5R6HdJSA2YlSWwF6zLoOF98R3lenKsAehruYPE
 MO5h5EVJl+iwBKweHeGRSW1f80lAVpkmIo23+3c8jTIXSyULhIEU1ByU+ogxSexyJijf
 iwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705018892; x=1705623692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65wKEJNwvk9ZVpyhvumXc2zlAAX/IgYCkwnqilCNGvw=;
 b=KzCKk50LASm33babla8AEfRxbzuduyOEtgOTEmDkiknkGxPFtZoQo8yu+msZg3dvdv
 gwOk7ftZcKxxNQgpW4zm1qfRMn857Jy0XBwQxVdjCWnSgPxq8C3W3tOD5l9RO4wKRN4f
 5rfZKTHR/LhVkry3Jy54PTdKmvVeyfwwC91ZbubQ8tjYipkAtxLRP7XKkcjH+gTkTuk2
 5BZ9W66kyeKJr/IKBJr5o8SCsxpZtNeZhoI2E5utXMkYQzJghD0f0PXfozahJLpoplmg
 2wzpGYsFzvonLdZRoN559kQK7CryQIevgFDhRhMIDp5N4NskejsAQ1kulBvbH6LweaI/
 LZvg==
X-Gm-Message-State: AOJu0YwwqOHl5mhVn57GZbkeSRwx0MGwe/+7F1m9Coz+HXykOlOPM7qH
 PqFjgtF7kEiBqcOTt9B0aKCgAFKe7L9d8YBprvWdGE/Uz20=
X-Google-Smtp-Source: AGHT+IH0ICeF25JXD45zqqajURXdKhF+xjnoPltkgxyOvXJJU2JHMHb1rVBOg4y5YZI2Z7kvA3XKag==
X-Received: by 2002:a05:6a00:464f:b0:6d9:acb2:29ac with SMTP id
 kp15-20020a056a00464f00b006d9acb229acmr176115pfb.23.1705018891720; 
 Thu, 11 Jan 2024 16:21:31 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 t22-20020a056a00139600b006d94291679asm1821733pfg.78.2024.01.11.16.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 16:21:31 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 2/3] efi_loader: auto-generate boot option for each blkio
 device
Date: Fri, 12 Jan 2024 09:19:22 +0900
Message-Id: <20240112001923.976414-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112001923.976414-1-masahisa.kojima@linaro.org>
References: <20240112001923.976414-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 101 ++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index eda2619142..c2b8da89e6 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -559,6 +559,50 @@ err:
 	return ret;
 }
 
+/**
+ * try_load_from_media() - load file from media
+ *
+ * @file_path:		file path
+ * @handle_img:		on return handle for the newly installed image
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
+					efi_handle_t *handle_img)
+{
+	efi_handle_t handle_blkdev;
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_device_path *rem, *dp = NULL;
+	struct efi_device_path *final_dp = file_path;
+
+	handle_blkdev = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
+	if (handle_blkdev) {
+		if (rem->type == DEVICE_PATH_TYPE_END) {
+			/* no file name present, try default file */
+			ret = fill_default_file_path(handle_blkdev->dev, &dp);
+			if (ret != EFI_SUCCESS)
+				return ret;
+
+			final_dp = dp;
+		}
+	}
+
+	ret = EFI_CALL(efi_load_image(true, efi_root, final_dp, NULL, 0, handle_img));
+
+	efi_free_pool(dp);
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -593,7 +637,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
-		struct efi_device_path *file_path;
 		u32 attributes;
 
 		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
@@ -610,10 +653,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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
@@ -744,22 +784,23 @@ error:
 }
 
 /**
- * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
+ * efi_bootmgr_enumerate_boot_options() - enumerate the possible bootable media
  *
  * @opt:		pointer to the media boot option structure
- * @volume_handles:	pointer to the efi handles
- * @count:		number of efi handle
+ * @handles:		pointer to block device handles
+ * @count:		On entry number of handles to block devices.
+ *			On exit number of boot options.
  * Return:		status code
  */
-static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
-						      efi_handle_t *volume_handles,
-						      efi_status_t count)
+static efi_status_t
+efi_bootmgr_enumerate_boot_options(struct eficonfig_media_boot_option *opt,
+				   efi_handle_t *handles, efi_uintn_t *count)
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
@@ -767,8 +808,15 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
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
@@ -776,7 +824,7 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		if (ret != EFI_SUCCESS)
 			continue;
 
-		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
+		ret = efi_disk_get_device_name(handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
 		if (ret != EFI_SUCCESS)
 			continue;
 
@@ -800,17 +848,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
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
 
@@ -1039,8 +1090,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
 /**
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
- * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * This function enumerates all BlockIo devices and add the boot option for it.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -1056,13 +1106,13 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
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
 
@@ -1072,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_options(opt, handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1121,7 +1170,7 @@ out:
 			free(opt[i].lo);
 	}
 	free(opt);
-	efi_free_pool(volume_handles);
+	efi_free_pool(handles);
 
 	if (ret == EFI_NOT_FOUND)
 		return EFI_SUCCESS;
-- 
2.34.1

