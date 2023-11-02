Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9BEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 06:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7759B870C9;
	Thu,  2 Nov 2023 07:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J5hitCay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C62A87710; Thu,  2 Nov 2023 07:46:46 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8388037B
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 07:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2e72fe47fso380982b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698907600; x=1699512400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp5pTOWuuUXNeQpz4jRFxwHC3MVnThhD9NnxijwxilQ=;
 b=J5hitCayIC5Zc2UeRLzGh4Z3xRU3ZQqMwM/4k9UgkEC3e07ZqFE94HJzdYCifscvOS
 CmHEvG7Sn4rQbyJiOJE78i/iqha1ZuC2sEAjokfB7/zxhUIZugaz2NOWhSh4ax3MaDE5
 V0ibmH+lINYqsplwn/XuNrAWHnFNqrahlPq9BhAH0hrap7S8gQJaE8Uj1hf7Hqnsld55
 +Jwlj7O8MgFxea2HZvRyfNbtldulSKUhLhFYfTtuytor5TJffS9VKW+w493OB2j0UCnF
 f3aHw2PBuw3TABLT4v9RITyA74jpTw6p+sgsmw7StM+/XMFJAUpPt/PcZXYYDITvqVsQ
 +DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698907600; x=1699512400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tp5pTOWuuUXNeQpz4jRFxwHC3MVnThhD9NnxijwxilQ=;
 b=PDdnHkBqfvv+HpcpW34QTAGGvcdH/qmt5aX2h0FY714Gtmlr2QwyBSW4/fBK0avfF7
 fFwAzRMCOVXU+qjZvqz+xnOaYmc1FYb6f2jEJeZdCooJQxmUgt3GvMJZ/8PRPORAJGa/
 IchjKcxXIRYvetyWfsH9/0oO7E2ptARqqcVAzlk3ce+/+su5PV/AcQwWKW6iXmTC0gRe
 vKCcA+q14KGgIrxGNmsQl6lXFLhAF0cR505DTiqps7KS1zZxSdQgpPCPq4pR40vXRiRb
 fWaS2YgzDodyU2YReZUdvScuSbd3SQgq52WFTc1OUoJaTH58HGUlpwxzUesvBvxjyfd8
 nVXA==
X-Gm-Message-State: AOJu0YyQtKoQ8w9gZRiYEsFVAzJfnjcOJ/IcjHY/SLiE45XpCxc8+8+N
 IqM1+c1AvL2CIyb0cpgzzMuBsS1B0aaPU6F7t08=
X-Google-Smtp-Source: AGHT+IG934X/Ph/rWGM6/pCq5fqeOR8vbWsUeX7UCOBpxTxAKop8/3BHu+LmEyYjNW6a8UO5qvYgTQ==
X-Received: by 2002:a54:4393:0:b0:3ad:f86a:878e with SMTP id
 u19-20020a544393000000b003adf86a878emr17212369oiv.13.1698907600299; 
 Wed, 01 Nov 2023 23:46:40 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 b13-20020a056a000ccd00b006c2fd6a7fe3sm2007251pfv.22.2023.11.01.23.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 23:46:39 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v9 7/9] efi_loader: support boot from URI device path
Date: Thu,  2 Nov 2023 15:44:57 +0900
Message-Id: <20231102064459.3466953-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/Kconfig       |   9 ++
 lib/efi_loader/efi_bootmgr.c | 268 +++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

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
index a40762c74c..7b23b2dbf7 100644
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
 
@@ -168,6 +176,258 @@ out:
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
+	ret = efi_bootmgr_release_ramdisk();
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
+	struct udevice *blk;
+	struct efi_event *event = NULL;
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
+		blk = mount_image(lo_label, image_addr, image_size);
+		if (!blk)
+			return EFI_LOAD_ERROR;
+
+		ret = load_default_file_from_blk_dev(blk, handle);
+		if (ret != EFI_SUCCESS) {
+			log_info("Cannot boot from downloaded image\n");
+			goto iso_error;
+		}
+
+		ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
+				       efi_bootmgr_image_return_notify, NULL,
+				       &efi_guid_event_group_return_to_efibootmgr, &event);
+		if (ret != EFI_SUCCESS) {
+			log_err("Creating event failed\n");
+			goto iso_error;
+		}
+
+		/*
+		 * TODO: expose the ramdisk to OS.
+		 * Need to pass the ramdisk information by the architecture-specific
+		 * methods such as 'pmem' device-tree node.
+		 */
+		ret = efi_add_memory_map(image_addr, image_size,
+					 EFI_RESERVED_MEMORY_TYPE);
+		if (ret != EFI_SUCCESS) {
+			log_err("Memory reservation failed\n");
+			goto iso_error;
+		}
+
+		ramdisk_blk_dev = blk;
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
+
+iso_error:
+	if (blkmap_destroy(blk->parent))
+		log_err("Destroying blkmap failed\n");
+	if (event)
+		EFI_CALL(bs->close_event(event));
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +471,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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
-- 
2.34.1

