Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B65C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A90F875A0;
	Tue, 19 Dec 2023 15:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IjxdUv2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C975187282; Tue, 19 Dec 2023 15:27:42 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCC9871C3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35fc4dc4ffaso734995ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702996057; x=1703600857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8QXau9aK7AfE3tNttP0ee9/VIPbm+SiRI0vQ4TwE8A=;
 b=IjxdUv2VskMLWnmMkkxe3p1sMDhN0qWGFGmIt94fK0sITDerC5zusxZZmiuPQLSrpb
 UiisrVtuAGHP/v9R1gTwoEg542wJ2HbR/NY2v0Mel6/OGIbbO4yM1iL776at/arw3caQ
 rZPv/wa6gY0qYKxIbuWyl0GSXpMMoX46jWJ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702996057; x=1703600857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8QXau9aK7AfE3tNttP0ee9/VIPbm+SiRI0vQ4TwE8A=;
 b=Y2cg3bTslBIdKj/AaDfkm8QwHmq1+b8Gz8yVI/VL+h+AE9UKbkR5rB27gcP8XVp+/u
 dS/qGfo0PIB3ZqVzogW0TGYA+/CcBvyvVUl07Lf0ZYq+obx36U8piuR5C43gGVoPWns9
 ZzZmqh14zCh5kUABKZWDFeeGG8BEE/77FJqSsGKxSnm+zgggH1YiaQghQmc6lfFjKCQm
 hhThu0aohT/DTBUpWVV2LdXLY7Agaw2pT+RKdLGu0lIx67v5kO7L6dKWWRLUgen77ZL8
 yQZCdIT3FGTF4p5wJWkdRDw3EZ3BOKVp3ZDP5dy7w5eTUXgSLFZUZnla31JK1GTCqzxB
 3I/g==
X-Gm-Message-State: AOJu0YwJ/nLPg2sRJqpCaWSZ0hRphcR2EgjssMoQzZ5ZoC/KG3vfmXHH
 LFN+3Rgjpviio14CZbkUwhEc3/2FcliRW7RrhrYZ8uVl6dq/
X-Google-Smtp-Source: AGHT+IFmipw7JZ6ECvPlJk5XPZQuXWqFmOy2FE6OQjLUpoPP5C8XlViAh+XQMInfpW6R5gltIWc3RA==
X-Received: by 2002:a05:6e02:164c:b0:35f:bcc8:d57f with SMTP id
 v12-20020a056e02164c00b0035fbcc8d57fmr892920ilu.33.1702996056952; 
 Tue, 19 Dec 2023 06:27:36 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a92db52000000b0035fb79100cesm803195ilq.59.2023.12.19.06.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:27:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 1/1] efi: Avoid using dm_scan_other()
Date: Tue, 19 Dec 2023 07:27:19 -0700
Message-ID: <20231219142731.2389788-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219142731.2389788-1-sjg@chromium.org>
References: <20231219142731.2389788-1-sjg@chromium.org>
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

This function is defined by bootstd so using it precludes using that
feature. Use the board_early_init_r() feature instead.

Nove the affected code into a new file, so that it is clear that
this relates to board init.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Create a new file inside lib/efi instead of board/

Changes in v2:
- Drop duplicate acpi_xsdt patch
- Put the board_early_init_r code into board/

 configs/efi-x86_app64_defconfig |   1 +
 lib/efi/Makefile                |   2 +-
 lib/efi/efi_app.c               | 187 -----------------------------
 lib/efi/efi_app_init.c          | 205 ++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 188 deletions(-)
 create mode 100644 lib/efi/efi_app_init.c

diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 14b5cd0fa0ee..ed0506fe25cb 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
diff --git a/lib/efi/Makefile b/lib/efi/Makefile
index a790d2d554cd..232fa684360e 100644
--- a/lib/efi/Makefile
+++ b/lib/efi/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2015 Google, Inc
 
-obj-$(CONFIG_EFI_APP) += efi_app.o efi.o
+obj-$(CONFIG_EFI_APP) += efi_app.o efi.o efi_app_init.o
 obj-$(CONFIG_EFI_STUB) += efi_info.o
 
 CFLAGS_REMOVE_efi_stub.o := -mregparm=3 \
diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index c5eb816655ea..e79fa5dad176 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -68,49 +68,6 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
 	return 0;
 }
 
-/**
- * efi_bind_block() - bind a new block device to an EFI device
- *
- * Binds a new top-level EFI_MEDIA device as well as a child block device so
- * that the block device can be accessed in U-Boot.
- *
- * The device can then be accessed using 'part list efi 0', 'fat ls efi 0:1',
- * for example, just like any other interface type.
- *
- * @handle: handle of the controller on which this driver is installed
- * @blkio: block io protocol proxied by this driver
- * @device_path: EFI device path structure for this
- * @len: Length of @device_path in bytes
- * @devp: Returns the bound device
- * Return: 0 if OK, -ve on error
- */
-int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
-		   struct efi_device_path *device_path, int len,
-		   struct udevice **devp)
-{
-	struct efi_media_plat plat;
-	struct udevice *dev;
-	char name[18];
-	int ret;
-
-	plat.handle = handle;
-	plat.blkio = blkio;
-	plat.device_path = malloc(device_path->length);
-	if (!plat.device_path)
-		return log_msg_ret("path", -ENOMEM);
-	memcpy(plat.device_path, device_path, device_path->length);
-	ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
-			  &plat, ofnode_null(), &dev);
-	if (ret)
-		return log_msg_ret("bind", ret);
-
-	snprintf(name, sizeof(name), "efi_media_%x", dev_seq(dev));
-	device_set_name(dev, name);
-	*devp = dev;
-
-	return 0;
-}
-
 static efi_status_t setup_memory(struct efi_priv *priv)
 {
 	struct efi_boot_services *boot = priv->boot;
@@ -179,150 +136,6 @@ static void free_memory(struct efi_priv *priv)
 	global_data_ptr = NULL;
 }
 
-/**
- * devpath_is_partition() - Figure out if a device path is a partition
- *
- * Checks if a device path refers to a partition on some media device. This
- * works by checking for a valid partition number in a hard-driver media device
- * as the final component of the device path.
- *
- * @path:	device path
- * Return:	true if a partition, false if not
- *		(e.g. it might be media which contains partitions)
- */
-static bool devpath_is_partition(const struct efi_device_path *path)
-{
-	const struct efi_device_path *p;
-	bool was_part = false;
-
-	for (p = path; p->type != DEVICE_PATH_TYPE_END;
-	     p = (void *)p + p->length) {
-		was_part = false;
-		if (p->type == DEVICE_PATH_TYPE_MEDIA_DEVICE &&
-		    p->sub_type == DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
-			struct efi_device_path_hard_drive_path *hd =
-				(void *)path;
-
-			if (hd->partition_number)
-				was_part = true;
-		}
-	}
-
-	return was_part;
-}
-
-/**
- * setup_block() - Find all block devices and setup EFI devices for them
- *
- * Partitions are ignored, since U-Boot has partition handling. Errors with
- * particular devices produce a warning but execution continues to try to
- * find others.
- *
- * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENOTSUPP
- *	if a required protocol is not supported
- */
-static int setup_block(void)
-{
-	efi_guid_t efi_blkio_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
-	efi_guid_t efi_devpath_guid = EFI_DEVICE_PATH_PROTOCOL_GUID;
-	efi_guid_t efi_pathutil_guid = EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GUID;
-	efi_guid_t efi_pathtext_guid = EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
-	struct efi_boot_services *boot = efi_get_boot();
-	struct efi_device_path_utilities_protocol *util;
-	struct efi_device_path_to_text_protocol *text;
-	struct efi_device_path *path;
-	struct efi_block_io *blkio;
-	efi_uintn_t num_handles;
-	efi_handle_t *handle;
-	int ret, i;
-
-	if (!boot)
-		return log_msg_ret("sys", -ENOSYS);
-
-	/* Find all devices which support the block I/O protocol */
-	ret = boot->locate_handle_buffer(BY_PROTOCOL, &efi_blkio_guid, NULL,
-				  &num_handles, &handle);
-	if (ret)
-		return log_msg_ret("loc", -ENOTSUPP);
-	log_debug("Found %d handles:\n", (int)num_handles);
-
-	/* We need to look up the path size and convert it to text */
-	ret = boot->locate_protocol(&efi_pathutil_guid, NULL, (void **)&util);
-	if (ret)
-		return log_msg_ret("util", -ENOTSUPP);
-	ret = boot->locate_protocol(&efi_pathtext_guid, NULL, (void **)&text);
-	if (ret)
-		return log_msg_ret("text", -ENOTSUPP);
-
-	for (i = 0; i < num_handles; i++) {
-		struct udevice *dev;
-		const u16 *name;
-		bool is_part;
-		int len;
-
-		ret = boot->handle_protocol(handle[i], &efi_devpath_guid,
-					    (void **)&path);
-		if (ret) {
-			log_warning("- devpath %d failed (ret=%d)\n", i, ret);
-			continue;
-		}
-
-		ret = boot->handle_protocol(handle[i], &efi_blkio_guid,
-					    (void **)&blkio);
-		if (ret) {
-			log_warning("- blkio %d failed (ret=%d)\n", i, ret);
-			continue;
-		}
-
-		name = text->convert_device_path_to_text(path, true, false);
-		is_part = devpath_is_partition(path);
-
-		if (!is_part) {
-			len = util->get_device_path_size(path);
-			ret = efi_bind_block(handle[i], blkio, path, len, &dev);
-			if (ret) {
-				log_warning("- blkio bind %d failed (ret=%d)\n",
-					    i, ret);
-				continue;
-			}
-		} else {
-			dev = NULL;
-		}
-
-		/*
-		 * Show the device name if we created one. Otherwise indicate
-		 * that it is a partition.
-		 */
-		printf("%2d: %-12s %ls\n", i, dev ? dev->name : "<partition>",
-		       name);
-	}
-	boot->free_pool(handle);
-
-	return 0;
-}
-
-/**
- * dm_scan_other() - Scan for UEFI devices that should be available to U-Boot
- *
- * This sets up block devices within U-Boot for those found in UEFI. With this,
- * U-Boot can access those devices
- *
- * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
- * Returns: 0 on success, -ve on error
- */
-int dm_scan_other(bool pre_reloc_only)
-{
-	if (gd->flags & GD_FLG_RELOC) {
-		int ret;
-
-		ret = setup_block();
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static void scan_tables(struct efi_system_table *sys_table)
 {
 	efi_guid_t acpi = EFI_ACPI_TABLE_GUID;
diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
new file mode 100644
index 000000000000..c5e4192fe06c
--- /dev/null
+++ b/lib/efi/efi_app_init.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * EFI-app board implementation
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm/global_data.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <linux/types.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * efi_bind_block() - bind a new block device to an EFI device
+ *
+ * Binds a new top-level EFI_MEDIA device as well as a child block device so
+ * that the block device can be accessed in U-Boot.
+ *
+ * The device can then be accessed using 'part list efi 0', 'fat ls efi 0:1',
+ * for example, just like any other interface type.
+ *
+ * @handle: handle of the controller on which this driver is installed
+ * @blkio: block io protocol proxied by this driver
+ * @device_path: EFI device path structure for this
+ * @len: Length of @device_path in bytes
+ * @devp: Returns the bound device
+ * Return: 0 if OK, -ve on error
+ */
+int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
+		   struct efi_device_path *device_path, int len,
+		   struct udevice **devp)
+{
+	struct efi_media_plat plat;
+	struct udevice *dev;
+	char name[18];
+	int ret;
+
+	plat.handle = handle;
+	plat.blkio = blkio;
+	plat.device_path = malloc(device_path->length);
+	if (!plat.device_path)
+		return log_msg_ret("path", -ENOMEM);
+	memcpy(plat.device_path, device_path, device_path->length);
+	ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
+			  &plat, ofnode_null(), &dev);
+	if (ret)
+		return log_msg_ret("bind", ret);
+
+	snprintf(name, sizeof(name), "efi_media_%x", dev_seq(dev));
+	device_set_name(dev, name);
+	*devp = dev;
+
+	return 0;
+}
+
+/**
+ * devpath_is_partition() - Figure out if a device path is a partition
+ *
+ * Checks if a device path refers to a partition on some media device. This
+ * works by checking for a valid partition number in a hard-driver media device
+ * as the final component of the device path.
+ *
+ * @path:	device path
+ * Return:	true if a partition, false if not
+ *		(e.g. it might be media which contains partitions)
+ */
+static bool devpath_is_partition(const struct efi_device_path *path)
+{
+	const struct efi_device_path *p;
+	bool was_part = false;
+
+	for (p = path; p->type != DEVICE_PATH_TYPE_END;
+	     p = (void *)p + p->length) {
+		was_part = false;
+		if (p->type == DEVICE_PATH_TYPE_MEDIA_DEVICE &&
+		    p->sub_type == DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
+			struct efi_device_path_hard_drive_path *hd =
+				(void *)path;
+
+			if (hd->partition_number)
+				was_part = true;
+		}
+	}
+
+	return was_part;
+}
+
+/**
+ * setup_block() - Find all block devices and setup EFI devices for them
+ *
+ * Partitions are ignored, since U-Boot has partition handling. Errors with
+ * particular devices produce a warning but execution continues to try to
+ * find others.
+ *
+ * Return: 0 if found, -ENOSYS if there is no boot-services table, -ENOTSUPP
+ *	if a required protocol is not supported
+ */
+static int setup_block(void)
+{
+	efi_guid_t efi_blkio_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
+	efi_guid_t efi_devpath_guid = EFI_DEVICE_PATH_PROTOCOL_GUID;
+	efi_guid_t efi_pathutil_guid = EFI_DEVICE_PATH_UTILITIES_PROTOCOL_GUID;
+	efi_guid_t efi_pathtext_guid = EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
+	struct efi_boot_services *boot = efi_get_boot();
+	struct efi_device_path_utilities_protocol *util;
+	struct efi_device_path_to_text_protocol *text;
+	struct efi_device_path *path;
+	struct efi_block_io *blkio;
+	efi_uintn_t num_handles;
+	efi_handle_t *handle;
+	int ret, i;
+
+	if (!boot)
+		return log_msg_ret("sys", -ENOSYS);
+
+	/* Find all devices which support the block I/O protocol */
+	ret = boot->locate_handle_buffer(BY_PROTOCOL, &efi_blkio_guid, NULL,
+				  &num_handles, &handle);
+	if (ret)
+		return log_msg_ret("loc", -ENOTSUPP);
+	log_debug("Found %d handles:\n", (int)num_handles);
+
+	/* We need to look up the path size and convert it to text */
+	ret = boot->locate_protocol(&efi_pathutil_guid, NULL, (void **)&util);
+	if (ret)
+		return log_msg_ret("util", -ENOTSUPP);
+	ret = boot->locate_protocol(&efi_pathtext_guid, NULL, (void **)&text);
+	if (ret)
+		return log_msg_ret("text", -ENOTSUPP);
+
+	for (i = 0; i < num_handles; i++) {
+		struct udevice *dev;
+		const u16 *name;
+		bool is_part;
+		int len;
+
+		ret = boot->handle_protocol(handle[i], &efi_devpath_guid,
+					    (void **)&path);
+		if (ret) {
+			log_warning("- devpath %d failed (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		ret = boot->handle_protocol(handle[i], &efi_blkio_guid,
+					    (void **)&blkio);
+		if (ret) {
+			log_warning("- blkio %d failed (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		name = text->convert_device_path_to_text(path, true, false);
+		is_part = devpath_is_partition(path);
+
+		if (!is_part) {
+			len = util->get_device_path_size(path);
+			ret = efi_bind_block(handle[i], blkio, path, len, &dev);
+			if (ret) {
+				log_warning("- blkio bind %d failed (ret=%d)\n",
+					    i, ret);
+				continue;
+			}
+		} else {
+			dev = NULL;
+		}
+
+		/*
+		 * Show the device name if we created one. Otherwise indicate
+		 * that it is a partition.
+		 */
+		printf("%2d: %-12s %ls\n", i, dev ? dev->name : "<partition>",
+		       name);
+	}
+	boot->free_pool(handle);
+
+	return 0;
+}
+
+/**
+ * board_early_init_r() - Scan for UEFI devices that should be available
+ *
+ * This sets up block devices within U-Boot for those found in UEFI. With this,
+ * U-Boot can access those devices
+ *
+ * Returns: 0 on success, -ve on error
+ */
+int board_early_init_r(void)
+{
+	if (gd->flags & GD_FLG_RELOC) {
+		int ret;
+
+		ret = setup_block();
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
-- 
2.43.0.472.g3155946c3a-goog

