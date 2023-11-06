Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3139FC4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 029C28700D;
	Mon,  6 Nov 2023 12:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dp+z8Gti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C3987036; Mon,  6 Nov 2023 12:41:07 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF1C387056
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2e72fe47fso2823193b6e.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270853; x=1699875653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onIZJ3mvBTOQ+ZhpQNWBJbHURkxZJ0aUS8gAA43ajI8=;
 b=dp+z8Gti8k1SlJUNRGUVz+tt5V+hD+ywOrP7R7MAyN+R4vD9WFusDUXO1UXPofBCy7
 moX2b1p3O6rdQ5a1voARglVGD02NKI5dzXWmHlcyXnEXGiat+nMxZB09dlF34VV/QZcB
 gbkALqc9SMMgzmk3IMF6TPx0A1tAj65d73OUNmPeSKSbWe8YnhCG53jRbvHnP/3Rxc8C
 0u4IVFqt/mEYwasyd/R9KQtVENFCZCin6rhgPFCNfxbiyw2KGN4qmR91eOvS2lUD9r4U
 zqRFey/9upzfBkff2YdrR0aT8bd6nV8bJPcYLBs4jrnH54L1/HVDUDy1RxteDLMCd2Sb
 Vmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270853; x=1699875653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onIZJ3mvBTOQ+ZhpQNWBJbHURkxZJ0aUS8gAA43ajI8=;
 b=kWBIFLMosVHRiwGLk2wYu4EvaJ4V0IWZdO4lW/Xr5jYUGNxzjBaw+oP4uVgHoGhbdE
 XipHCDeEcM1/zubZy/mUisYxWUWyGlQsNn29VU2jYNOmMssHA097LDpLqrdbifiIsZwH
 g/CImIebD8FuDXLMkAS5Dpq+SxhigHHov99sIvMj7DurCxjFjzhgv5RI03mKufCxvgwI
 dTr7/Z0QOc7UuBV9UIp4waWLSu+ynnd2o63bZjmxxcUruXQVpdkjuN7GfDl18Bp+X9kW
 IpfhjUly3oaMoswYH6qFm3+dn6/YQj3g6UVYc2RxS29NTPpQK8hbC/YME/R97bFI8aPE
 HHiQ==
X-Gm-Message-State: AOJu0YyemxjHOOzaLiBRg3E3Gaw2gkmho3UT7K4UZSz5piRm+y45wVFG
 JjSJMzXzMDB2GGTSn9dBao+Zj2nJqVmOYjQc7+o=
X-Google-Smtp-Source: AGHT+IEfn6LwGVVICN31vQsgKhvaZIUrN5H1+nU81b1uLEkgIZEYwKmd2HvbJ4xjnqu565wFA72A4Q==
X-Received: by 2002:a05:6808:308c:b0:3af:709c:1b2b with SMTP id
 bl12-20020a056808308c00b003af709c1b2bmr35471986oib.32.1699270852783; 
 Mon, 06 Nov 2023 03:40:52 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 fk12-20020a056a003a8c00b0066a31111cc5sm5435004pfb.152.2023.11.06.03.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:52 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v10 7/9] efi_loader: support boot from URI device path
Date: Mon,  6 Nov 2023 20:39:18 +0900
Message-Id: <20231106113920.3631591-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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
reserved to avoid the unintended access to the image and
expose the ramdisk to the OS.
For PE-COFF file case, this memory reservation is done
in LoadImage Boot Service.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/Kconfig       |   9 +
 lib/efi_loader/efi_bootmgr.c | 337 +++++++++++++++++++++++++++++++++++
 2 files changed, 346 insertions(+)

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
index a40762c74c..e24c18215a 100644
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
@@ -19,6 +23,11 @@
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
 
+static ulong image_size;
+static ulong image_addr;
+struct efi_device_path *loaded_dp;
+static struct udevice *ramdisk_blk_dev;
+
 const efi_guid_t efi_guid_bootmenu_auto_generated =
 		EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
 
@@ -168,6 +177,327 @@ out:
 	return ret;
 }
 
+/**
+ * mount_image() - mount the image with blkmap
+ *
+ * @lo_label:	u16 label string of load option
+ * @addr:	image address
+ * @size:	image size
+ * Return:	pointer to the UCLASS_BLK udevice, NULL if failed
+ */
+static struct udevice *mount_image(u16 *lo_label, ulong addr, ulong size)
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
+	err = blkmap_create_ramdisk(label, addr, size, &bm_dev);
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
+ * search_default_file() - search default file
+ *
+ * @dev:	pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
+ * @dp:		pointer to default file device path
+ * Return:	status code
+ */
+static efi_status_t search_default_file(struct udevice *dev,
+					struct efi_device_path **dp)
+{
+	efi_status_t ret;
+	efi_handle_t handle;
+	u16 *default_file_name = NULL;
+	struct efi_file_handle *root, *f;
+	struct efi_device_path *full_path;
+	struct efi_device_path *device_path;
+	struct efi_device_path *file_path = NULL;
+	struct efi_simple_file_system_protocol *file_system;
+
+	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
+		log_warning("DM_TAG_EFI not found\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	ret = EFI_CALL(bs->open_protocol(handle, &efi_simple_file_system_protocol_guid,
+					 (void **)&file_system, efi_root, NULL,
+					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	ret = EFI_CALL(file_system->open_volume(file_system, &root));
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	file_path = efi_dp_from_file(NULL, "/EFI/BOOT/" BOOTEFI_NAME);
+	default_file_name = efi_dp_str(file_path);
+	if (!default_file_name) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto err;
+	}
+
+	ret = EFI_CALL(root->open(root, &f, default_file_name,
+				  EFI_FILE_MODE_READ, 0));
+	efi_free_pool(default_file_name);
+	if (ret != EFI_SUCCESS)
+		goto err;
+
+	EFI_CALL(f->close(f));
+
+	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
+					 (void **)&device_path, efi_root, NULL,
+					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
+	if (ret != EFI_SUCCESS)
+		goto err;
+
+	full_path = efi_dp_append(device_path, file_path);
+	if (!full_path) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto err;
+	}
+
+	*dp = full_path;
+err:
+	efi_free_pool(file_path);
+
+	return ret;
+}
+
+/**
+ * check_disk_has_default_file() - load the default file
+ *
+ * @blk:	pointer to the UCLASS_BLK udevice
+ * @dp:		pointer to default file device path
+ * Return:	status code
+ */
+static efi_status_t check_disk_has_default_file(struct udevice *blk,
+						struct efi_device_path **dp)
+{
+	efi_status_t ret;
+	struct udevice *partition;
+
+	/* image that has no partition table but a file system */
+	ret = search_default_file(blk, dp);
+	if (ret == EFI_SUCCESS)
+		return ret;
+
+	/* try the partitions */
+	device_foreach_child(partition, blk) {
+		enum uclass_id id;
+
+		id = device_get_uclass_id(partition);
+		if (id != UCLASS_PARTITION)
+			continue;
+
+		ret = search_default_file(partition, dp);
+		if (ret == EFI_SUCCESS)
+			return ret;
+	}
+
+	return EFI_NOT_FOUND;
+}
+
+/**
+ * prepare_loaded_image() - prepare ramdisk for downloaded image
+ *
+ * @label:	label of load option
+ * @addr:	image address
+ * @size:	image size
+ * @dp:		pointer to default file device path
+ * Return:	status code
+ */
+static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
+					 struct efi_device_path **dp)
+{
+	efi_status_t ret;
+	struct udevice *blk;
+
+	blk = mount_image(label, addr, size);
+	if (!blk)
+		return EFI_LOAD_ERROR;
+
+	ret = check_disk_has_default_file(blk, dp);
+	if (ret != EFI_SUCCESS) {
+		log_info("Cannot boot from downloaded image\n");
+		goto err;
+	}
+
+	/*
+	 * TODO: expose the ramdisk to OS.
+	 * Need to pass the ramdisk information by the architecture-specific
+	 * methods such as 'pmem' device-tree node.
+	 */
+	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
+	if (ret != EFI_SUCCESS) {
+		log_err("Memory reservation failed\n");
+		goto err;
+	}
+
+	ramdisk_blk_dev = blk;
+
+	return EFI_SUCCESS;
+
+err:
+	if (blkmap_destroy(blk->parent))
+		log_err("Destroying blkmap failed\n");
+
+	return ret;
+}
+
+/**
+ * efi_bootmgr_release_uridp_resource() - cleanup uri device path resource
+ *
+ * Return:	status code
+ */
+efi_status_t efi_bootmgr_release_uridp_resource(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (ramdisk_blk_dev) {
+		ret = efi_add_memory_map(image_addr, image_size,
+					 EFI_CONVENTIONAL_MEMORY);
+		if (ret != EFI_SUCCESS)
+			log_err("Reclaiming memory failed\n");
+
+		if (blkmap_destroy(ramdisk_blk_dev->parent)) {
+			log_err("Destroying blkmap failed\n");
+			ret = EFI_DEVICE_ERROR;
+		}
+
+		ramdisk_blk_dev = NULL;
+	}
+
+	efi_free_pool(loaded_dp);
+	loaded_dp = NULL;
+
+	return ret;
+}
+
+/**
+ * efi_bootmgr_image_return_notify() - return to efibootmgr callback
+ *
+ * @event:	the event for which this notification function is registered
+ * @context:	event context - not used in this function
+ */
+static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
+						   void *context)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %p", event, context);
+	ret = efi_bootmgr_release_uridp_resource();
+	EFI_EXIT(ret);
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
+	efi_status_t ret;
+	void *source_buffer;
+	efi_uintn_t source_size;
+	struct efi_event *event = NULL;
+
+	loaded_dp = NULL;
+	ramdisk_blk_dev = NULL;
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
+		ret = prepare_loaded_image(lo_label, image_addr, image_size, &loaded_dp);
+		if (ret != EFI_SUCCESS)
+			goto err;
+
+		source_buffer = NULL;
+		source_size = 0;
+	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+		efi_handle_t mem_handle = NULL;
+
+		/*
+		 * loaded_dp must exist until efi application returns,
+		 * will be freed in return_to_efibootmgr event callback.
+		 */
+		loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image_addr, image_size);
+		ret = efi_install_multiple_protocol_interfaces(
+			&mem_handle, &efi_guid_device_path, loaded_dp, NULL);
+		if (ret != EFI_SUCCESS)
+			goto err;
+
+		source_buffer = (void *)image_addr;
+		source_size = image_size;
+	} else {
+		log_err("Error: file type is not supported\n");
+		return EFI_UNSUPPORTED;
+	}
+
+	ret = EFI_CALL(efi_load_image(false, efi_root, loaded_dp, source_buffer,
+				      source_size, handle));
+	if (ret != EFI_SUCCESS)
+		goto err;
+
+	/* create event for cleanup when the image returns or error occurs */
+	ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
+			       efi_bootmgr_image_return_notify, NULL,
+			       &efi_guid_event_group_return_to_efibootmgr,
+			       &event);
+	if (ret != EFI_SUCCESS) {
+		log_err("Creating event failed\n");
+		goto err;
+	}
+
+	return ret;
+
+err:
+	efi_bootmgr_release_uridp_resource();
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +541,13 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
+				ret = try_load_from_uri_path(
+					(struct efi_device_path_uri *)lo.file_path,
+					lo.label, handle);
+			else
+				ret = EFI_LOAD_ERROR;
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
-- 
2.34.1

