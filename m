Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17362C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E4EB8779D;
	Fri, 10 Nov 2023 05:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PPPGHtv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B738778B; Fri, 10 Nov 2023 05:28:04 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7140C87795
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc5916d578so14361875ad.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590453; x=1700195253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WvCQ9ou6HZnmoqUpXLMBON6r+ZMeYqUEZ9iR6FTgSc=;
 b=PPPGHtv/DR5rQvrOO1DSgHiTnPxFUgE8zAXe8xTP3EMUTGlE7ncxth9woXQrwE+r6H
 KZLgzK+LfiL78Wlb5x0Sw3CuQiSwH6+Xl3hcTrnRCGWfpkrAvQJnf5xX2hu5lFxbRb6u
 FQmeiVgWD8tOsvZnvHF7N8o73AI2gg57ikGBYEeFtF2WuMVVZPPI7+eU0M9UBeHoFfy/
 0pO3sikji5L3GoGWBDvpf519n/boFe0GGt9lajG3m7WaoyDisTZBldnPrTRSBWC9QrLd
 YC96R+7K4zYlSJfdAUsz20Skshhyfyxmsy5YnB49CRdOyRhvhjvoqWm0qVi1xl/tcOL1
 rX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590453; x=1700195253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WvCQ9ou6HZnmoqUpXLMBON6r+ZMeYqUEZ9iR6FTgSc=;
 b=qq0sXS59C9VgDORn6QiGs6QVbiaCZEzhbMna7453uKf3NxtQY69Z10wxGKa/31yfud
 UXKmrXbuNyTQfBLoSBDnGK/u+O9ogwywlXtNaXT+yuBaKS03A1padj7B+AHqpZ3kZEB4
 E3Jhbv8N38uKzhrFZGUKgCUxHdQxhlrs4ikT0vb0Q41sHrz9DyzIbyAtkFQ+ujppdHQY
 1RkS4V8aEG+/XHWHLJDSJDSJ4kaRNnQK+rfLq6YLkjEhf80ag3VXId6qtkxaoXNGiULx
 jRkvVE44n3J7Kp198E0lPlLZGJRivQ3ZtyxZJ5trBIaiEtio7u6O9HLIFhsqK359p7sZ
 OivA==
X-Gm-Message-State: AOJu0Yyr8g8fmmDqmw/uAiM8Cb8HJvlqaIFRHivQH8i77Yvieo2U8sjB
 3OWHeDqLyIT0snhfIcTt5B14YGwR8x/viJeb1h4=
X-Google-Smtp-Source: AGHT+IG+SLvpNzC2l2dJr6o9RYexzg6IEGy/pbW9wEc6hVR/1HjQg9m8+RE4Q3R1SWlgbxsu2s2w9w==
X-Received: by 2002:a17:902:9b90:b0:1cc:4467:a563 with SMTP id
 y16-20020a1709029b9000b001cc4467a563mr6327577plp.3.1699590452918; 
 Thu, 09 Nov 2023 20:27:32 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 iz3-20020a170902ef8300b001cc8cf4ad16sm4372318plb.246.2023.11.09.20.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:32 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v12 7/9] efi_loader: support boot from URI device path
Date: Fri, 10 Nov 2023 13:25:40 +0900
Message-Id: <20231110042542.3797301-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig       |   9 +
 lib/efi_loader/efi_bootmgr.c | 378 +++++++++++++++++++++++++++++++++++
 2 files changed, 387 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6db..229a6dbdfd 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
 	  replace the transfer via the device-tree. The latter is not
 	  possible on systems using ACPI.
 
+config EFI_HTTP_BOOT
+	bool "EFI HTTP Boot support"
+	select CMD_DNS
+	select CMD_WGET
+	select BLKMAP
+	help
+	  Enabling this option adds EFI HTTP Boot support. It allows to
+	  directly boot from network.
+
 endif
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..0582e4f71b 100644
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
 
@@ -168,6 +189,356 @@ out:
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
+	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
+					 (void **)&device_path, efi_root, NULL,
+					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
+	if (ret != EFI_SUCCESS)
+		return ret;
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
+	EFI_CALL(root->close(root));
+
+	*loaded_dp = full_path;
+
+	return EFI_SUCCESS;
+
+err:
+	EFI_CALL(root->close(root));
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
@@ -211,6 +582,13 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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

