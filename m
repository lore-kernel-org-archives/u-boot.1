Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF1C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4063387A58;
	Wed, 25 Oct 2023 08:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MJ2I2ilM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016B287A5E; Wed, 25 Oct 2023 08:30:36 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CF7879D8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso5159819b3a.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698215425; x=1698820225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBcgl+WOthLVrHfHg9ym25N5aCfLNvMApEqH2Y5JpA8=;
 b=MJ2I2ilMOCfsuvhpKQMtVnZxHoe6mBG+XN8WjsmO+qNC3CqS1wkVRAnDy3KS/YN+jV
 oLFd4hgOnqbu19gpgGE4+iJwpKgKLi+I2czlFdR6eQ5dJj7/vSfSt0J7kAoSy+gjby0j
 eAJzZ4klmRYkdIjmjZTf7eHdEFqZV+pc+AgN4vz7wzFN4CK2bijTbxXtLiNfDRzN58U9
 bl2hRVe1Te3dMCdgnB//h4QXJW9oBM2bHq8VRV+d27N06GkSUkUYI1bUhljgwU7/G5mc
 lXotdaRKSPjqBsIXiLQV/2bIqTY56YNe7gutkTe8ZqFKtqg9CHVtMpexEZ6brNcOR5o7
 u0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698215425; x=1698820225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBcgl+WOthLVrHfHg9ym25N5aCfLNvMApEqH2Y5JpA8=;
 b=nSHsSv2Wy9s17YXTw3GPwYSKtQxIp5Djl6iTgnOoYP5wfoA/GX7F1YuW1zXaHmcxRj
 gUcEhJJxJgYROLlnGDMFN2oBlF+FwJQgD4RoqDGuOto3+XB50Q5/PSGL70YMkBgBvrvL
 msmEIodoBr9R6FceK3LhRQ5c9XWNNhKiRB+fsWgzYJnn2+Ec972k3OkTS1uv87dxFGUu
 vdvPMn2jRDuOgrRimx0d4oCm5fjpdpU/ZVOj98ifhgOjArFRHoQBhal5wrGpXGY8p86N
 FalYTPmWRI8tKQmjd0oDDHgYugdg8ErgK1at8JGircdIIHqV+IjavQ+kPtUsFAiFFj9V
 nTSw==
X-Gm-Message-State: AOJu0YzFplFQNQ4u1pXTx1WTeYT7YyX0RPJkD4V55olHWTGwwm/zUEJ9
 VrT225PbzgEaeuXl7qrQttaxRkyqL6BbRbZNmhY=
X-Google-Smtp-Source: AGHT+IFpLFfzQnVzxzVafgvOdZ6Vn+auKXbgQQaE4KGANMQ8iVb2524bC5CqeebqRtJXTW+4mwgDLQ==
X-Received: by 2002:a05:6a20:4426:b0:16a:4f24:d30 with SMTP id
 ce38-20020a056a20442600b0016a4f240d30mr6439827pzb.53.1698215425565; 
 Tue, 24 Oct 2023 23:30:25 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 v12-20020a63f20c000000b005b32d6b4f2fsm8080288pgh.81.2023.10.24.23.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:30:24 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v8 5/7] efi_loader: support boot from URI device path
Date: Wed, 25 Oct 2023 15:28:43 +0900
Message-Id: <20231025062845.3100964-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
References: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
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
 cmd/bootefi.c                |   5 +
 include/efi_loader.h         |   1 +
 lib/efi_loader/Kconfig       |   9 ++
 lib/efi_loader/efi_bootmgr.c | 229 +++++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33..74203ec5b6 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -394,6 +394,11 @@ out:
 			log_err("Failed to remove loadfile2 for initrd\n");
 	}
 
+	if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT)) {
+		if (efi_bootmgr_release_ramdisk() != EFI_SUCCESS)
+			log_err("Failed to remove ramdisk\n");
+	}
+
 	/* Control is returned to U-Boot, disable EFI watchdog */
 	efi_set_watchdog(0);
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f..2fea1f17fb 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -937,6 +937,7 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
 				  efi_uintn_t load_options_size,
 				  void *load_options);
 efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);
+efi_status_t efi_bootmgr_release_ramdisk(void);
 
 /**
  * struct efi_image_regions - A list of memory regions
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
index a40762c74c..abe148bd80 100644
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
@@ -19,6 +23,10 @@
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
 
+static u32 image_size;
+static ulong image_addr;
+static struct udevice *ramdisk_blk_dev = NULL;
+
 const efi_guid_t efi_guid_bootmenu_auto_generated =
 		EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
 
@@ -168,6 +176,197 @@ out:
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
+static struct udevice *mount_image(u16 *lo_label, ulong addr, int size)
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
+ * try_load_default_file() - try to load the default file
+ *
+ * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
+ * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
+ *
+ * @dev			pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
+ * @image_handle:	pointer to handle for newly installed image
+ * Return:		status code
+ */
+static efi_status_t try_load_default_file(struct udevice *dev,
+					  efi_handle_t *image_handle)
+{
+	efi_status_t ret;
+	efi_handle_t handle;
+	struct efi_handler *handler;
+	struct efi_device_path *file_path;
+	struct efi_device_path *device_path;
+
+	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
+		log_warning("DM_TAG_EFI not found\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	ret = efi_search_protocol(handle,
+				  &efi_simple_file_system_protocol_guid, &handler);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
+					 (void **)&device_path, efi_root, NULL,
+					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	file_path = expand_media_path(device_path);
+	ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
+				      image_handle));
+	efi_free_pool(file_path);
+
+	return ret;
+}
+
+/**
+ * load_default_file_from_blk_dev() - load the default file
+ *
+ * @blk		pointer to the UCLASS_BLK udevice
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
+						   efi_handle_t *handle)
+{
+	efi_status_t ret;
+	struct udevice *partition;
+
+	/* image that has no partition table but a file system */
+	ret = try_load_default_file(blk, handle);
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
+		ret = try_load_default_file(partition, handle);
+		if (ret == EFI_SUCCESS)
+			return ret;
+	}
+
+	return EFI_NOT_FOUND;
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
+
+		blk = mount_image(lo_label, image_addr, image_size);
+		if (!blk)
+			return EFI_LOAD_ERROR;
+
+		ret = load_default_file_from_blk_dev(blk, handle);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		ramdisk_blk_dev = blk;
+
+		/*
+		 * TODO: expose the ramdisk to OS.
+		 * Need to pass the ramdisk information by the architecture-specific
+		 * methods such as 'pmem' device-tree node.
+		 */
+		ret = efi_add_memory_map(image_addr, image_size,
+					 EFI_RESERVED_MEMORY_TYPE);
+		if (ret != EFI_SUCCESS)
+			efi_bootmgr_release_ramdisk();
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
@@ -211,6 +410,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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
@@ -345,6 +552,28 @@ error:
 	return ret;
 }
 
+/**
+ * efi_bootmgr_release_ramdisk() - release ramdisk resource
+ *
+ * Return:		status code
+ */
+efi_status_t efi_bootmgr_release_ramdisk(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (ramdisk_blk_dev) {
+		ret = efi_add_memory_map(image_addr, image_size,
+					 EFI_CONVENTIONAL_MEMORY);
+
+		if (blkmap_destroy(ramdisk_blk_dev->parent))
+			ret = EFI_DEVICE_ERROR;
+
+		ramdisk_blk_dev = NULL;
+	}
+
+	return ret;
+}
+
 /**
  * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
  *
-- 
2.34.1

