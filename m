Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D8EE6454
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4416868D7;
	Fri, 15 Sep 2023 12:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iiJMad3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233E7868D7; Fri, 15 Sep 2023 12:17:56 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14E8868BC
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb5bd8f02so1879093b3a.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773072; x=1695377872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV+tFrMvW8Ei1g+Ssw5SNJ8BmFh88MCoelRWsO/P5H0=;
 b=iiJMad3lUmUm7+SMOkR1uIGeGTj4mT9PxboDVO8WdwDl5sr3B/zATMuT0mxJ70BkPv
 D55Ly99pwjM6yJzUzy0f30JQw1LyU76xHF3R04I0VY4RAIBDdUvOiAfNFYrQY5Rw7T7p
 iT+NTXYNwHAWZcj//UFrXp7YsoPjf1eXzxxPCjfVyY2cxqj6pEcd11u1u+VivLGYVgXw
 g4EvTABViDblP4lLqOTexxlL/CLmVSQBK0zt9yBNmg/9YCKZslx9gdTXYv+FvzByukZG
 RFt8zFMX4+EUrBTPczirBkDHgTadoy4fO6+lqFDBSJ5teKsSh/cKxXjK9+E5sNHrWWrE
 NHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773072; x=1695377872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV+tFrMvW8Ei1g+Ssw5SNJ8BmFh88MCoelRWsO/P5H0=;
 b=W/09UbRBSSAiPR6BEKMm/HXlbpIc4rUoDmQ90V49Xn4D+yZ50m6HmFkw+aAZx+rdzW
 ue9xIwxccyoZrqSTqgR0croxPvPdhu4mYzmhTnrMFdnWzRU8m7z44McHiDuaAOT/hb/V
 smeoX9wGV4enggjkv3t1wS1FyRuX/sRJo1EYv9PPD8Kz+ONGRARlJM79dFMajAjCHWfU
 nNrvQzlZqCboPhxndS9iuyaZxwYwLE+NspV83CvGGk+iSLNJ6h2tbn4j/F/xhF6Yc9Rx
 4kHPDLCioFTTYtdMNQIWUYGB9k34DGd5PKSpGJmSEO+75PCJvAdmr662gW8UDSDYk/x5
 jj3w==
X-Gm-Message-State: AOJu0Yy3PTF+T80spUnuiDjXm8AWL0YXwIMCbNR0TeVn1caGcqR+0/vN
 DtsgJkfu+6+QlS3F/JU5LybF9gpSaPyZ+qbbFPA=
X-Google-Smtp-Source: AGHT+IF2b3/QIRi4+B7LA8bNwhOROhDdBdHz73/OixwdcKqmN0dyLNe2GQbKhsEHnyB3Mk3prsbUXQ==
X-Received: by 2002:a05:6a00:24d2:b0:68f:d35d:2168 with SMTP id
 d18-20020a056a0024d200b0068fd35d2168mr1300008pfv.0.1694773071925; 
 Fri, 15 Sep 2023 03:17:51 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 e23-20020a62aa17000000b0068fba4800cfsm2684917pff.56.2023.09.15.03.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:17:51 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 4/7] efi_loader: support boot from URI device path
Date: Fri, 15 Sep 2023 19:16:37 +0900
Message-Id: <20230915101640.1166332-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 189 +++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..1a287ad89d 100644
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
@@ -168,6 +172,182 @@ out:
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
+	ret = EFI_CALL(bs->open_protocol(bm_handle, &efi_guid_device_path,
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
@@ -211,6 +391,15 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
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
+			}
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
-- 
2.34.1

