Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF89C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8274287438;
	Sun, 12 Nov 2023 21:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LEDLYO0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2470186FBF; Sun, 12 Nov 2023 21:55:32 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FD68710C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b006f7c473so85282839f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699822522; x=1700427322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1taXUEOBRkfOempfsZ4vW7td1uC33rFXFA2GW137ut0=;
 b=LEDLYO0A94iCvm23I8DnYiBQCINazQqRQf/okZILnjxLoH3jUoV197yF7kVbsz48Rs
 zznkDo66ReZVHaSDyTrMskIRT0dRciuaEnw0esD0H+vZL9GOZFUB+xdoqy91EqtDd3/3
 AYfvkX9DSILPU0vbCedzioqh6up5Fxptl3kSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699822522; x=1700427322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1taXUEOBRkfOempfsZ4vW7td1uC33rFXFA2GW137ut0=;
 b=N6vSc99NDeui7H+kfVU4AyAp2bITWjJDi9r6uLWTMu2VIG/LXcA6APcV+EBEMpP1dv
 IXmyzZSZcd77PTcKGjIgh8Zgf1LQz3jWMRJ0+b2nmfmrVUAYh5Ywc+ZMBfBMYqJYN2By
 UC3AQXjltD62UROqtvqWWOWFUtMiY56L1vaGRVEf0xJrIH3n6OSso6O5tVRlPDjRq8ot
 PJCLUl9so08UqYhJoMTSweO/tHHAMF3qAzvDLHMRS5NPIxz0IHcfKkxna5wc69CoNg2p
 5cOBZlrosf9OHA+QqEwN97orXkfSUINNEN2kQlB+dpqYYli6ZxZ6K2k1ODdEMAtlKJCT
 ANyA==
X-Gm-Message-State: AOJu0Yyi1gwDOQuASpKiolXH0ehq0B7vSsafFj2veHncJ9apNw2uhsKz
 Ak+T9iURhbjMuY2jiv2mtFtn7JhdJuhtBZ3KzMUfKQ==
X-Google-Smtp-Source: AGHT+IG7wDxMT392yAKBeQV+2WuJFZ7PWuTe1ux60OvM+7a5gfakiZicwR6SH5TMmEXKUE5AA3z63Q==
X-Received: by 2002:a05:6602:2e12:b0:79f:e9ac:f60a with SMTP id
 o18-20020a0566022e1200b0079fe9acf60amr7702410iow.20.1699822522600; 
 Sun, 12 Nov 2023 12:55:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a056602210c00b007b01c6a57d5sm1079641iox.15.2023.11.12.12.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:55:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
Date: Sun, 12 Nov 2023 13:55:11 -0700
Message-ID: <20231112205516.183410-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112205516.183410-1-sjg@chromium.org>
References: <20231112205516.183410-1-sjg@chromium.org>
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

This requires moving quite a lot of code into the board directory, butt
this is the normal place for code called by board_early_init_r()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop duplicate acpi_xsdt patch
- Put the board_early_init_r code into board/

 board/efi/efi-x86_app/Makefile  |   5 +
 board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++
 configs/efi-x86_app64_defconfig |   1 +
 lib/efi/efi_app.c               | 187 -----------------------------
 4 files changed, 211 insertions(+), 187 deletions(-)
 create mode 100644 board/efi/efi-x86_app/Makefile
 create mode 100644 board/efi/efi-x86_app/efi_app.c

diff --git a/board/efi/efi-x86_app/Makefile b/board/efi/efi-x86_app/Makefile
new file mode 100644
index 000000000000..682f8754b44d
--- /dev/null
+++ b/board/efi/efi-x86_app/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2023 Google LLC
+
+obj-y	+= efi_app.o
diff --git a/board/efi/efi-x86_app/efi_app.c b/board/efi/efi-x86_app/efi_app.c
new file mode 100644
index 000000000000..c5e4192fe06c
--- /dev/null
+++ b/board/efi/efi-x86_app/efi_app.c
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
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index d6b6c3d82995..e6a62b30dd09 100644
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
-- 
2.42.0.869.gea05f2083d-goog

