Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D59C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D48875DB;
	Wed,  8 Nov 2023 12:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="coSDr+n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975E5875DB; Wed,  8 Nov 2023 12:08:19 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862358770C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so48963215ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441691; x=1700046491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRHnQHDXMRhtK3CMXQvqlgnT16gM9yP4IqJzbQC6tUM=;
 b=coSDr+n4JfVpRoh2WePk/TuQDNuEIXDAXz7czdzI5lbLM6/rSIsvca24uFLHsqOY9+
 8uL1oXnKhmz2uvfNDildJ0Cwf/sDDvZ3HKiJMAbYoIeoNONTsaJpATH38x4sDmMMf4eW
 4SfTo7kdSFZDS3biZmd5pcjiM1R+VqYpxwDNOaoeYt378o2bYVMQCNWFnG/azJhyf5KQ
 DEPSSHBxLLrsRMJcsQ9gRGelatNn/5koxIzeWvi5Tzxp97DiM31VyeRODHTORZFT9DRQ
 BmOoqGFD6YSBGQH6duCZbgPUUuyXxOBmibcO1Ge0dtvWATI7L5Vv4pQcN3R4y5xSX/sn
 CuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441691; x=1700046491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRHnQHDXMRhtK3CMXQvqlgnT16gM9yP4IqJzbQC6tUM=;
 b=eOGvQH//b8MEmOcK57li+Xrn9WGJyPEZ1+DWymZYAiNcsHqA2nPbsmpKxA3NSZ+L/y
 Un3yJZ0wooqbqi4MZ6J1Qg4AGd1OHuATJ46M/pcsd7JLnRpbHG5pWZivnrhDWqGZ+FDy
 p6W77GzEXg44cl6vwF+qCpGmtGp8moK6g7vizSYhTPbIOjeChWH5+2chTU6+lvV5yzqF
 sCd6x8cBJRuQjJ1mna497qjZIaAfi/3TTn6dabH44y9eAlVzM8DoMPgFyBzgj+kZEDRC
 FfJLbNI4qwQljmsrSiA2nQ1SRKLgCQBuGUS56U3UDdjxWOrFNmEDmswb444k+czXF/NK
 2E8Q==
X-Gm-Message-State: AOJu0YynGZnAmNcfx6DOPUuRGmKogsxHgoTiACb3MQhuZQ9YxK1vkXHb
 I7PVA64PVwBQE+xSSJvm5SZPmSAnS3CXCugECm0=
X-Google-Smtp-Source: AGHT+IFfIratoC961fajuJChDvliG8jMeiXL8tcKTA+nlTAGV5UwtBklzXdrjmd+MzE/eTJXj3g7gg==
X-Received: by 2002:a17:903:22c3:b0:1cc:b20d:7ec3 with SMTP id
 y3-20020a17090322c300b001ccb20d7ec3mr2072220plg.45.1699441690923; 
 Wed, 08 Nov 2023 03:08:10 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170903234200b001c55e13bf2asm1469033plh.283.2023.11.08.03.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:08:10 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v11 7/9] efi_loader: support boot from URI device path
Date: Wed,  8 Nov 2023 20:06:34 +0900
Message-Id: <20231108110637.3691441-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 376 +++++++++++++++++++++++++++++++++++
 2 files changed, 385 insertions(+)

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
index a40762c74c..ebed3c0f13 100644
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
@@ -19,6 +23,23 @@
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
 
+/**
+ * struct uridp_context - uri device path resource
+ *
+ * @image_size:		image size
+ * @image_addr:		image address
+ * @loaded_dp:		pointer to loaded device path
+ * @ramdisk_blk_dev:	pointer to the ramdisk blk device
+ * @mem_handle:		efi_handle to the loaded PE-COFF image
+ */
+struct uridp_context {
+	ulong image_size;
+	ulong image_addr;
+	struct efi_device_path *loaded_dp;
+	struct udevice *ramdisk_blk_dev;
+	efi_handle_t mem_handle;
+};
+
 const efi_guid_t efi_guid_bootmenu_auto_generated =
 		EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
 
@@ -168,6 +189,354 @@ out:
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
+ * @loaded_dp:	pointer to default file device path
+ * Return:	status code
+ */
+static efi_status_t search_default_file(struct udevice *dev,
+					struct efi_device_path **loaded_dp)
+{
+	efi_status_t ret;
+	efi_handle_t handle;
+	u16 *default_file_name = NULL;
+	struct efi_file_handle *root, *f;
+	struct efi_device_path *dp = NULL, *fp = NULL;
+	struct efi_simple_file_system_protocol *file_system;
+	struct efi_device_path *device_path, *full_path = NULL;
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
+	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
+					 (void **)&device_path, efi_root, NULL,
+					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	full_path = expand_media_path(device_path);
+	ret = efi_dp_split_file_path(full_path, &dp, &fp);
+	if (ret != EFI_SUCCESS)
+		goto err;
+
+	default_file_name = efi_dp_str(fp);
+	efi_free_pool(dp);
+	efi_free_pool(fp);
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
+	*loaded_dp = full_path;
+
+	return EFI_SUCCESS;
+
+err:
+	efi_free_pool(full_path);
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
+ * @blk:	pointer to created blk udevice
+ * Return:	status code
+ */
+static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
+					 struct efi_device_path **dp,
+					 struct udevice **blk)
+{
+	efi_status_t ret;
+	struct udevice *ramdisk_blk;
+
+	ramdisk_blk = mount_image(label, addr, size);
+	if (!ramdisk_blk)
+		return EFI_LOAD_ERROR;
+
+	ret = check_disk_has_default_file(ramdisk_blk, dp);
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
+	*blk = ramdisk_blk;
+
+	return EFI_SUCCESS;
+
+err:
+	if (blkmap_destroy(ramdisk_blk->parent))
+		log_err("Destroying blkmap failed\n");
+
+	return ret;
+}
+
+/**
+ * efi_bootmgr_release_uridp_resource() - cleanup uri device path resource
+ *
+ * @ctx:	event context
+ * Return:	status code
+ */
+efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *ctx)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (!ctx)
+		return ret;
+
+	/* cleanup for iso or img image */
+	if (ctx->ramdisk_blk_dev) {
+		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
+					 EFI_CONVENTIONAL_MEMORY);
+		if (ret != EFI_SUCCESS)
+			log_err("Reclaiming memory failed\n");
+
+		if (blkmap_destroy(ctx->ramdisk_blk_dev->parent)) {
+			log_err("Destroying blkmap failed\n");
+			ret = EFI_DEVICE_ERROR;
+		}
+	}
+
+	/* cleanup for PE-COFF image */
+	if (ctx->mem_handle) {
+		ret = efi_uninstall_multiple_protocol_interfaces(
+			ctx->mem_handle, &efi_guid_device_path, ctx->loaded_dp,
+			NULL);
+		if (ret != EFI_SUCCESS)
+			log_err("Uninstall device_path protocol failed\n");
+	}
+
+	efi_free_pool(ctx->loaded_dp);
+	free(ctx);
+
+	return ret;
+}
+
+/**
+ * efi_bootmgr_image_return_notify() - return to efibootmgr callback
+ *
+ * @event:	the event for which this notification function is registered
+ * @context:	event context
+ */
+static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
+						   void *context)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %p", event, context);
+	ret = efi_bootmgr_release_uridp_resource(context);
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
+	struct uridp_context *ctx;
+	struct udevice *blk = NULL;
+	struct efi_event *event = NULL;
+	efi_handle_t mem_handle = NULL;
+	struct efi_device_path *loaded_dp;
+	static ulong image_size, image_addr;
+
+	ctx = calloc(1, sizeof(struct uridp_context));
+	if (!ctx)
+		return EFI_OUT_OF_RESOURCES;
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
+		ret = prepare_loaded_image(lo_label, image_addr, image_size,
+					   &loaded_dp, &blk);
+		if (ret != EFI_SUCCESS)
+			goto err;
+
+		source_buffer = NULL;
+		source_size = 0;
+	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
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
+	ctx->image_size = image_size;
+	ctx->image_addr = image_addr;
+	ctx->loaded_dp = loaded_dp;
+	ctx->ramdisk_blk_dev = blk;
+	ctx->mem_handle = mem_handle;
+
+	ret = EFI_CALL(efi_load_image(false, efi_root, loaded_dp, source_buffer,
+				      source_size, handle));
+	if (ret != EFI_SUCCESS)
+		goto err;
+
+	/* create event for cleanup when the image returns or error occurs */
+	ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
+			       efi_bootmgr_image_return_notify, ctx,
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
+	efi_bootmgr_release_uridp_resource(ctx);
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +580,13 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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

