Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B1DCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB4086BD3;
	Mon, 16 Oct 2023 01:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tAzs1zXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBD1864AA; Mon, 16 Oct 2023 01:50:58 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DB086BCD
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso1278307b3a.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413844; x=1698018644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sem+HHX0VXCT9ALLt5h9piqxM6bOFDSHojQAIvVFoWY=;
 b=tAzs1zXCasBo+eUf+gm1KTqNmb1PoN7ragArEOS9aiFxJgJb3tyTNfXwwKAXhKIGec
 5IrBCwRx108SjnwO8+FafRYxMZ63Z91PLCYHK0hp9xxDqkL903QU5d3tM8TgfhdHGDVJ
 3Z8enn96Et760u6o5E1KZXxk8VeMeIGriEQSDy63MVbxhCi8LkGCRiaNFcD6WlxpIJFO
 YpCXzlF8n7UsEdTsDDtX6sakMB5MKEoAW99soak/tU6EEtEHfiOaENnRrMvWWBC1XWii
 /Zmdia6zHtrl55REBTJDC5i3mzkwJc9qGVqBaCEut0ge0WFxI75OJYDvKHjeh55lW7ID
 7F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413844; x=1698018644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sem+HHX0VXCT9ALLt5h9piqxM6bOFDSHojQAIvVFoWY=;
 b=ADaISMNXLr9CxLeWKTonVf4P6g0JdKf9hgHc7TwB8fiaHfMfrpAz+YANpgL7oteNCC
 oEp9K0LbCY8JwS8vRxh/KDFsg1x2rqN6kSOco9n42hryBEucy8gPYS5ZaT9oruZJe4FA
 apCMrOivqVA9Ue2KuqYVlmeqbsHk8R0hAMLC4xSqawHe/eOAu34jqH+I+7Y6YPQykAtu
 CWlz5cU5YLJrpK+0HK5G270ACiKF3t0T3LgwOwojPTvaDtUuTQIDUZDkOY+199NCvRU9
 Mi7vnz1yu0rrGwacProS7AWNmpeUQAicRMC3q0cpJDB4ImZrrZWYyuxdFEo69DgOh+8k
 Y7Ug==
X-Gm-Message-State: AOJu0YzYze5OUZfZoel/Eo5ykt5l+IPmpGZM4Ap0Nq9LukXdhyCOFE0A
 hXQqYwWHtiSBr8dRS6Y+eHP5juEbS7xolMZ7p4A=
X-Google-Smtp-Source: AGHT+IGKG2jxUZbKFtpgbE8LhpYRgjg45IvgrCZUyGGwvldEDHBKVh/pZXYBxRFxWMYnVRjEgfua/Q==
X-Received: by 2002:a05:6a20:6a03:b0:15a:6733:24e2 with SMTP id
 p3-20020a056a206a0300b0015a673324e2mr9015843pzk.25.1697413844259; 
 Sun, 15 Oct 2023 16:50:44 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 p6-20020a631e46000000b0059b782e8541sm1640014pgm.28.2023.10.15.16.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:50:43 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 5/9] efi_loader: support boot from URI device path
Date: Mon, 16 Oct 2023 08:49:03 +0900
Message-Id: <20231015234907.2362717-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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

This supports to boot from the URI device path.
When user selects the URI device path, bootmgr downloads
the file using wget into the address specified by loadaddr
env variable.
If the file is .iso or .img file, mount the image with blkmap
then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
Since boot option indicating the default file is automatically
created when new disk is detected, system can boot by selecting
the automatically created blkmap boot option.
If the file is PE-COFF file, load and start the downloaded file.

The buffer used to download the ISO image file must be
reserved to avoid the unintended access to the image.
For PE-COFF file case, this memory reservation is done

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h          |   2 +
 lib/efi_loader/Kconfig        |   9 ++
 lib/efi_loader/efi_bootmgr.c  | 251 ++++++++++++++++++++++++++++++++--
 lib/efi_loader/efi_dt_fixup.c |   2 +-
 4 files changed, 248 insertions(+), 16 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f..106006127b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -554,6 +554,8 @@ void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
 efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
 					void **address);
+/* add reserved memory to memory map */
+void efi_reserve_memory(u64 addr, u64 size, bool nomap);
 /* Carve out DT reserved memory ranges */
 void efi_carve_out_dt_rsv(void *fdt);
 /* Purge unused kaslr-seed */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6db..5d99206dc3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
 	  replace the transfer via the device-tree. The latter is not
 	  possible on systems using ACPI.
 
+config EFI_HTTP_BOOT
+	bool "EFI HTTP Boot support"
+	depends on CMD_DNS
+	depends on CMD_WGET
+	depends on BLKMAP
+	help
+	  Enabling this option adds EFI HTTP Boot support. It allows to
+	  directly boot from network.
+
 endif
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a197127cdd..b71a303f58 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -7,10 +7,14 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blk.h>
+#include <blkmap.h>
 #include <common.h>
 #include <charset.h>
+#include <dm.h>
 #include <log.h>
 #include <malloc.h>
+#include <net.h>
 #include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -168,6 +172,192 @@ out:
 	return ret;
 }
 
+/**
+ * mount_image() - mount the image with blkmap
+ *
+ * @lo_label:	u16 label string of load option
+ * @image_addr:	image address
+ * @image_size:	image size
+ * Return:	pointer to the UCLASS_BLK udevice, NULL if failed
+ */
+static struct udevice *mount_image(u16 *lo_label, ulong image_addr, int image_size)
+{
+	int err;
+	struct blkmap *bm;
+	struct udevice *bm_dev;
+	char *label = NULL, *p;
+
+	label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
+	if (!label)
+		return NULL;
+
+	p = label;
+	utf16_utf8_strcpy(&p, lo_label);
+	err = blkmap_create_ramdisk(label, image_addr, image_size, &bm_dev);
+	if (err) {
+		efi_free_pool(label);
+		return NULL;
+	}
+	bm = dev_get_plat(bm_dev);
+
+	efi_free_pool(label);
+
+	return bm->blk;
+}
+
+/**
+ * load_default_file_boot_option() - load default file boot option
+ *
+ * @devnum:	target blkmap device
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t load_default_file_boot_option(int devnum, efi_handle_t *handle)
+{
+	u32 i;
+	u16 *bm_label, *p;
+	char device_name[12];
+	u16 *bootorder = NULL;
+	efi_uintn_t num, size;
+	void *load_option = NULL;
+	struct efi_load_option lo;
+	u16 varname[] = u"Boot####";
+	efi_status_t ret = EFI_NOT_FOUND;
+
+	snprintf(device_name, 12, "blkmap %d", devnum);
+	bm_label = calloc(1, (strlen(device_name) + 1) * sizeof(u16));
+	if (!bm_label)
+		return EFI_OUT_OF_RESOURCES;
+
+	p = bm_label;
+	utf8_utf16_strcpy(&p, device_name);
+
+	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid, &size);
+	if (!bootorder)
+		goto out;
+
+	num = size / sizeof(u16);
+	for (i = 0; i < num; i++) {
+		efi_create_indexed_name(varname, sizeof(varname), "Boot",
+					bootorder[i]);
+		load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
+		if (!load_option)
+			continue;
+
+		ret = efi_deserialize_load_option(&lo, load_option, &size);
+		if (ret != EFI_SUCCESS) {
+			free(load_option);
+			continue;
+		}
+
+		/* check whether the label indicates the target blkmap device */
+		if (u16_strncmp(bm_label, lo.label, u16_strlen(bm_label))) {
+			free(load_option);
+			continue;
+		}
+
+		/* check whether the boot option is automatically generated */
+		if (guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated)) {
+			free(load_option);
+			continue;
+		}
+
+		ret = EFI_CALL(efi_load_image(true, efi_root, lo.file_path,
+					      NULL, 0, handle));
+		free(load_option);
+		goto out;
+	}
+
+	if (i == num)
+		ret = EFI_NOT_FOUND;
+out:
+	free(bm_label);
+	free(bootorder);
+
+	return ret;
+}
+
+/**
+ * try_load_from_uri_path() - Handle the URI device path
+ *
+ * @uridp:	uri device path
+ * @lo_label:	label of load option
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
+					   u16 *lo_label,
+					   efi_handle_t *handle)
+{
+	char *s;
+	int err;
+	int uri_len;
+	u32 image_size;
+	efi_status_t ret;
+	ulong image_addr;
+
+	s = env_get("loadaddr");
+	if (!s) {
+		log_err("Error: loadaddr is not set\n");
+		return EFI_INVALID_PARAMETER;
+	}
+	image_addr = hextoul(s, NULL);
+	err = wget_with_dns(image_addr, uridp->uri);
+	if (err < 0)
+		return EFI_INVALID_PARAMETER;
+	image_size = env_get_hex("filesize", 0);
+	if (!image_size)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * If the file extension is ".iso" or ".img", mount it and try to load
+	 * the default file.
+	 * If the file is PE-COFF image, load the downloaded file.
+	 */
+	uri_len = strlen(uridp->uri);
+	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
+	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
+		struct udevice *blk;
+		struct blk_desc *desc;
+
+		blk = mount_image(lo_label, image_addr, image_size);
+		if (!blk)
+			return EFI_LOAD_ERROR;
+
+		/*
+		 * When the new disk is detected, boot option is automatically
+		 * created if it has a default file.
+		 * Let's load the automatically created boot option.
+		 */
+		desc = dev_get_uclass_plat(blk);
+		ret = load_default_file_boot_option(desc->devnum, handle);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		/* whole ramdisk must be reserved */
+		efi_reserve_memory(image_addr, image_size, true);
+	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+		efi_handle_t mem_handle = NULL;
+		struct efi_device_path *file_path;
+
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image_addr, image_size);
+		ret = efi_install_multiple_protocol_interfaces(
+			&mem_handle, &efi_guid_device_path, file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
+					      (void *)image_addr, image_size,
+					      handle));
+	} else {
+		log_err("Error: file type is not supported\n");
+		return EFI_UNSUPPORTED;
+	}
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +401,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
+				ret = try_load_from_uri_path(
+					(struct efi_device_path_uri *)
+						lo.file_path,
+					lo.label, handle);
+			else
+				ret = EFI_LOAD_ERROR;
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
@@ -367,32 +565,51 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		char *optional_data;
 		struct efi_load_option lo;
 		char buf[BOOTMENU_DEVICE_NAME_MAX];
-		struct efi_device_path *device_path, *full_path;
+		struct efi_device_path *device_path, *full_path, *dp, *fp;
 		struct efi_device_path *short_dp;
-		efi_handle_t image_handle;
+		struct efi_file_handle *root, *f;
+		struct efi_simple_file_system_protocol *file_system;
+		u16 *default_file_path = NULL;
 
-		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
-		if (ret != EFI_SUCCESS)
-			continue;
-		ret = efi_protocol_open(handler, (void **)&device_path,
-					efi_root, NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
 
-		/* check whether the partition or disk have the default file */
+		device_path = handler->protocol_interface;
 		full_path = efi_dp_from_file(device_path,
 					     "/EFI/BOOT/" BOOTEFI_NAME);
-		ret = EFI_CALL(efi_load_image(true, efi_root, full_path, NULL,
-					      0, &image_handle));
+
+		/* check whether the partition or disk have the default file */
+		ret = efi_dp_split_file_path(full_path, &dp, &fp);
+		if (ret != EFI_SUCCESS || !fp)
+			goto next_entry;
+
+		default_file_path = efi_dp_str(fp);
+		if (!default_file_path)
+			goto next_entry;
+
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_simple_file_system_protocol_guid,
+					  &handler);
 		if (ret != EFI_SUCCESS)
-			goto next;
-		ret = EFI_CALL(efi_unload_image(image_handle));
+			goto next_entry;
+
+		file_system = handler->protocol_interface;
+		ret = EFI_CALL(file_system->open_volume(file_system, &root));
 		if (ret != EFI_SUCCESS)
-			goto next;
+			goto next_entry;
+
+		ret = EFI_CALL(root->open(root, &f, default_file_path,
+					  EFI_FILE_MODE_READ, 0));
+		if (ret != EFI_SUCCESS)
+			goto next_entry;
+
+		EFI_CALL(f->close(f));
 
 		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
 		if (ret != EFI_SUCCESS)
-			goto next;
+			goto next_entry;
 
 		p = dev_name;
 		utf8_utf16_strncpy(&p, buf, strlen(buf));
@@ -416,6 +633,8 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
 		if (!opt[num].size) {
 			efi_free_pool(full_path);
+			efi_free_pool(dp);
+			efi_free_pool(fp);
 			return EFI_OUT_OF_RESOURCES;
 		}
 		/* set the guid */
@@ -423,8 +642,10 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
 		num++;
 
-next:
+next_entry:
 		efi_free_pool(full_path);
+		efi_free_pool(dp);
+		efi_free_pool(fp);
 	}
 
 	*count = num;
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 838023c78f..edc515b9ff 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -22,7 +22,7 @@ const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
  * @nomap:	indicates that the memory range shall not be accessed by the
  *		UEFI payload
  */
-static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
+void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 {
 	int type;
 	efi_uintn_t ret;
-- 
2.34.1

