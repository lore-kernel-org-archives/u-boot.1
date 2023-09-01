Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E4FCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8454886886;
	Fri,  1 Sep 2023 12:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oeBH9xnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F101186886; Fri,  1 Sep 2023 12:26:47 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA90B86907
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d7so13584075ad.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693564002; x=1694168802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCgaQAxtd2A8HOgkWFhH3ch4Tsgwryr9I3qfko9RayQ=;
 b=oeBH9xnxMFX0+uYxYYiWNK/CP29kenPquvwcuvGKRITJwwYHQzHW04+8o+UgG26JPv
 maC6ewPeyl+e7tfGnzNED4BCBYuOI25tsog+gO5BBR6LsyWoTnb2Wh+G212WASx6Dr/L
 SDs1EcuR+6c6smzguneVlh+RmYWsGIXk3dhOHbJ52ZKKGhKP0ovTUQRN8wTzy3VH0Kty
 QdK/z5x2lqs61BCNk7U6uFCGicJBR/IOGaJx1+nMJAm0askTuc3uwlvrjBq+jt7LfmcR
 UlyJMGeHsUCCRiOeRQLE8o5wGiDfwxjuoVXw3A9EBgmZ3Sw2Q/ZkEviMVoomNUFLtkOE
 DF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693564002; x=1694168802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCgaQAxtd2A8HOgkWFhH3ch4Tsgwryr9I3qfko9RayQ=;
 b=XsqlXb22ctkYP3qAP4+MoXaYM/+qoJx2QgixxWWBEJ1zgaqlZ1KB89vmFKFnkxmLWn
 Pdo0NsdoVxaudFlBFLfKOBR9zVVgZnpo5rijLCjdAKhfjzkRtDS5E8tjt6Wt3SHZ4SSH
 sEXvCiXCWbSWnWLSJ4Iov6xiwIgy86rs6eqo73KzEHe4B79fS2EzKwoNjdMkhgV91Tlo
 x4MJFXNsdRKDEyQ75flPMf5JiZk0RPGgxO/lIM/WsNKcGeGTtk5+f0WahxVPrDPYAJkp
 GoP2CuJm7gxVX0tEvqKdMNrL5vFm3zziWcsSf13s+cH7PA5A8rgnC5LjRl2ztRqsztFO
 sB+Q==
X-Gm-Message-State: AOJu0YxRzSzrjfwS9+BLF9AXHYXnn6uumYUyyKjvagvion3I4QCaK0wI
 7inlQNfFBQr1XSd3UrGPMOhCvjGy7SRtfgd3Q5U=
X-Google-Smtp-Source: AGHT+IGphRgUp1Z97nP14OjJp6wLTIrX2JDqc7i8Pn1Cj2/rhewLpKgm9fxfGaCgAfjR0dCBgWtcnA==
X-Received: by 2002:a17:902:e88f:b0:1b8:3786:3344 with SMTP id
 w15-20020a170902e88f00b001b837863344mr2532395plg.49.1693564002002; 
 Fri, 01 Sep 2023 03:26:42 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902a70500b001bbb22652a4sm2660189plq.226.2023.09.01.03.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:41 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 4/6] efi_loader: support boot from URI device path
Date: Fri,  1 Sep 2023 19:25:40 +0900
Message-Id: <20230901102542.609239-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901102542.609239-1-masahisa.kojima@linaro.org>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
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
If the file is .efi file, load and start the downloaded file.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 197 +++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..0e8d2ca9d1 100644
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
@@ -168,6 +172,193 @@ out:
 	return ret;
 }
 
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
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
+	efi_handle_t bm_handle;
+	struct efi_handler *handler;
+	struct efi_device_path *file_path;
+	struct efi_device_path *device_path;
+
+	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
+		log_warning("DM_TAG_EFI not found\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	ret = efi_search_protocol(bm_handle,
+				  &efi_simple_file_system_protocol_guid, &handler);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	ret = efi_search_protocol(bm_handle, &efi_guid_device_path, &handler);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	ret = efi_protocol_open(handler, (void **)&device_path, efi_root, NULL,
+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
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
+	 * If the file is ".efi" and PE-COFF image, load the downloaded file.
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
+	} else if (!strncmp(&uridp->uri[uri_len - 4], ".efi", 4)) {
+		efi_handle_t mem_handle = NULL;
+		struct efi_device_path *file_path = NULL;
+
+		ret = efi_check_pe((void *)image_addr, image_size, NULL);
+		if (ret != EFI_SUCCESS) {
+			log_err("Error: downloaded image is not a PE-COFF image\n");
+			return EFI_INVALID_PARAMETER;
+		}
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
+#endif
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +402,12 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			ret = try_load_from_uri_path(
+				(struct efi_device_path_uri *)lo.file_path,
+				lo.label, handle);
+#endif
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
-- 
2.34.1

