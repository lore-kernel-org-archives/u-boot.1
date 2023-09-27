Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B01E810B2
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D166686D93;
	Wed, 27 Sep 2023 11:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cOZz/atC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D857E86D93; Wed, 27 Sep 2023 11:37:48 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842AE86DB9
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c63164a2b6so23524105ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695807464; x=1696412264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1AsBZDMagcwhVH5MHk4s7ySm+OXoAUqVLonpxVJiAk=;
 b=cOZz/atC0G9fNbp/y/CPl8L8+qKcBonL65od8TAcHI1HD0VuUMYG6KCtojDHNriQ2F
 knWW/UBTOFqREjzF74d8iTWRrD+w1XT0XOJedoyEvZ3XGa6vZm7/XueCRpyV7OHGDgAg
 91awSWlsrzVO/OGI8lUIrKMU4oHDVOmMFWUVINtkATdkSoH7m0DG1+F38EstRPOEGpqm
 BBK5i35YGgslHySX17DEfJPXYm1ELLyC5lG4z9GUYQhRmen9jwf4jvO1CBj6aEiDmZ3t
 guhK0OafjzaUhJTp9w6aCZkR/5zYInZWxKB5keh90CPUX4N2gbOs9Jf0XUQC4pHGCZ02
 AYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807464; x=1696412264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1AsBZDMagcwhVH5MHk4s7ySm+OXoAUqVLonpxVJiAk=;
 b=MPyw6I7pwXJA3N5SEHG2mRxG+ga/mj3tRnkGok8ae2WUK7tJagqlaLVxgWWo0sWvOm
 vmxyh0sE3cdgJ/pi6j+NP8s5g6/CyBwzCJRWMjguJ/lNakauhFQPXqVBsQ9PhxFMd2le
 o1K7wg2o9N8UsJ7+BQypGrVmPUz1llnGHFPZG/N/8Hlsc0tJwwQEUvgkzJcap+SQprrW
 HTJzTJUh4hl4EBj9HxY1nQ6Kw/m+lAmj61saRoHbqJKw/6Hc/LPAQmB/gWBbRJBRO6Oz
 9z7DZB2swALDdbcK80Zdhte2zG9S/Yfvc4ItOvCtDxMUw1VBc3H+7Yhg+3IDu5iiByWg
 Ydkw==
X-Gm-Message-State: AOJu0YzzxK02PKdupxIIVZdnQRKQdtpzl4kLr2yIP2fBQclMw3tt5j16
 X12FkddKUVPFtxEXmRRjz0IK8m9rchAmTjJfsgI=
X-Google-Smtp-Source: AGHT+IEtV4hHQK7uiW1f8Z6e/etA05VHn6v5V2CCFrup0TBRYWVXjLUbZvfsfdysugAS4u3xs4ZLYA==
X-Received: by 2002:a17:902:e84d:b0:1c7:21cc:2750 with SMTP id
 t13-20020a170902e84d00b001c721cc2750mr3692985plg.28.1695807464478; 
 Wed, 27 Sep 2023 02:37:44 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 n12-20020a170902d2cc00b001c474d6a408sm12579998plc.201.2023.09.27.02.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:37:43 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 4/7] efi_loader: support boot from URI device path
Date: Wed, 27 Sep 2023 18:36:28 +0900
Message-Id: <20230927093631.1595494-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
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
If the file is PE-COFF file, load and start the downloaded file.

The buffer used to download the ISO image file must be
reserved to avoid the unintended access to the image.
For PE-COFF file case, this memory reservation is done
in LoadImage Boot Service.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h          |   2 +
 lib/efi_loader/efi_bootmgr.c  | 198 +++++++++++++++++++++++++++++++++-
 lib/efi_loader/efi_dt_fixup.c |   2 +-
 3 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4a29ddaef4..c4207edc91 100644
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
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..a5030d50c0 100644
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
@@ -168,6 +172,187 @@ out:
 	return ret;
 }
 
+/**
+ * mount_image() - mount the image with blkmap
+ *
+ * @lo_label	u16 label string of load option
+ * @image_addr:	image address
+ * @image_size	image size
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
+
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
+ * @lo_label	label of load option
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
+					   u16 *lo_label,
+					   efi_handle_t *handle)
+{
+	char *s;
+	int uri_len;
+	int image_size;
+	efi_status_t ret;
+	ulong image_addr;
+
+	s = env_get("loadaddr");
+	if (!s) {
+		log_err("Error: loadaddr is not set\n");
+		return EFI_INVALID_PARAMETER;
+	}
+	image_addr = hextoul(s, NULL);
+	image_size = wget_with_dns(image_addr, uridp->uri);
+	if (image_size < 0)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * If the file extension is ".iso" or ".img", mount it and try to load
+	 * the default file.
+	 * If the file is PE-COFF image, load the downloaded file.
+	 */
+	uri_len = strlen(uridp->uri); /* todo: directly use uridp->uri */
+	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
+	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
+		struct udevice *blk;
+
+		blk = mount_image(lo_label, image_addr, image_size);
+		if (!blk)
+			return EFI_INVALID_PARAMETER;
+
+		ret = load_default_file_from_blk_dev(blk, handle);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		/* whole ramdisk must be reserved */
+		efi_reserve_memory(image_addr, image_size, true);
+	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+		efi_handle_t mem_handle = NULL;
+		struct efi_device_path *file_path = NULL;
+
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image_addr, image_size);
+		ret = efi_install_multiple_protocol_interfaces(
+			&mem_handle, &efi_guid_device_path, file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			return EFI_INVALID_PARAMETER;
+
+		ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
+					      (void *)image_addr, image_size,
+					      handle));
+	} else {
+		log_err("Error: file type is not supported\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -185,7 +370,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 {
 	struct efi_load_option lo;
 	u16 varname[9];
-	void *load_option;
+	void *load_option = NULL;
 	efi_uintn_t size;
 	efi_status_t ret;
 
@@ -211,6 +396,17 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			if (IS_ENABLED(CONFIG_BLKMAP) &&
+			    IS_ENABLED(CONFIG_CMD_WGET) &&
+			    IS_ENABLED(CONFIG_CMD_DNS)) {
+				ret = try_load_from_uri_path(
+					(struct efi_device_path_uri *)
+						lo.file_path,
+					lo.label, handle);
+			} else {
+				ret = EFI_LOAD_ERROR;
+			}
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
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

