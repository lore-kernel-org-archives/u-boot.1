Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ECCC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BF984A04;
	Sun, 28 Jun 2026 10:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iTcmGUtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BD984987; Sun, 28 Jun 2026 10:28:19 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04892849AC
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 54A42420A6; 
 Sun, 28 Jun 2026 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635296;
 bh=kBi1vW9Z7iNh70pUaceoWfCAcFWqr8z5wZd6HkZiMnM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=iTcmGUtmp76mwOfKlLCrg7az4HPMzd7sN9R2ZSUY4rTMm+9Nne1gwDsUuAr21aRBM
 8m6wEQOcUDmHWNEexp1M7Y3cASQruhxIvmO4QzwyP1urw4ytTIGsbvbeE//tr6MU6v
 IJ8Uxj/o8gEYEYvUGZeQblS3WQAPCEZgrodZKhtBr2XSMXQyNME/8dDwZh9TQiL2eP
 3/kx26cv0NyUNFL/O/WSfJyynmy4t1qj2Alk/iUXx64ISb4H/9P5r0TnmHGcaMPIgR
 errX0HgGoO6Gk3toV+T2AiwPLnbUFJQ8zv4D0GJX+GXPRoeslhdUi53lwiYdt4LwQw
 7VXsz1MxpnhjA+Mn/eaHsRcJtDWOhj+yEF/xxFVCOaRp6+/OeWB2OE9Au4zLnxQu9m
 5NkgUQGZgxem/j5Wo/NrEiLQLzwyvEml5KqBCkWmO+HfZNhZTN0Mnzb81N1l9jcFv7
 P2nFl5mAGcSgCGv6kBRs1d07YufDxMf6+GIyetFZ+oKsPn2pJCR0qOPaVigM2Q/2dx
 Gc83xAcmfYJzGC7Y+eKp1MwgR1O2SfeUjDuGuDqmF3AGD5HvKUKXmf2Bps2LZJ9xz3
 rvhFO6TIHM6aBebS7OaNdLCsTcWcFLCkMRhdBs61Lng8PqeyTj2x2VqoUmX8r+R41O
 QhLq3T6wdSC+jmMCyzu7Oypg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 08/11] efi_loader: move file-system helpers to
 efi_app_common
Date: Sun, 28 Jun 2026 10:28:06 +0200
Message-ID: <20260628082810.175862-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
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

Move the shared file-system utilities to efi_app_common:

* open_file_system() - open the simple file system protocol, first
  trying the partition the image was loaded from, then the UEFI system
  partition.
* get_config_table()  - look up an EFI configuration table by GUID.
* save_file()         - write a buffer to a named file, prompting for
  confirmation if the file already exists.

get_config_table() supersedes the private get_dtb() in dtbdump and
get_dbg_info() in dbginfodump; both call-sites are updated to use it.

dtbdump's do_save() and initrddump's do_save() are simplified to use
the common save_file(), eliminating duplicate file-open/write/close
sequences.

smbiosdump's private get_config_table(), open_file_system() and
save_file() are removed; the common versions take their place.

GUID declarations that are no longer referenced after these removals
are dropped from each app's file-scope variables.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	use sizeof(efi_guid_t) when calling memcmp() for GUID
	correct type of ret in save_file()
	document the partition search logic of open_file_system and save_file
v2:
	new patch
---
 lib/efi_loader/dbginfodump.c    |  22 +-----
 lib/efi_loader/dtbdump.c        | 120 +-----------------------------
 lib/efi_loader/efi_app_common.c | 106 +++++++++++++++++++++++++++
 lib/efi_loader/efi_app_common.h |  32 ++++++++
 lib/efi_loader/initrddump.c     |  69 +-----------------
 lib/efi_loader/smbiosdump.c     | 125 --------------------------------
 6 files changed, 147 insertions(+), 327 deletions(-)

diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index 39ffbb59d82..06cb1a3850a 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -91,26 +91,6 @@ static void do_help(void)
 	error(u"exit       - exit the shell\r\n");
 }
 
-/**
- * get_dbg_info_table() - get debug info table
- *
- * Return:	debug info table or NULL
- */
-static void *get_dbg_info(void)
-{
-	void *dbg = NULL;
-	efi_uintn_t i;
-
-	for (i = 0; i < systable->nr_tables; ++i) {
-		if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
-			    sizeof(efi_guid_t))) {
-			dbg = systable->tables[i].table;
-			break;
-		}
-	}
-	return dbg;
-}
-
 /**
  * print_info() - print loaded image protocol
  */
@@ -144,7 +124,7 @@ static efi_status_t do_dump(void)
 	struct dbg_info_header *dbg;
 	u32 count;
 
-	dbg = get_dbg_info();
+	dbg = get_config_table(&dbg_info_guid);
 	if (!dbg) {
 		error(u"Debug info table not found\r\n");
 		return EFI_NOT_FOUND;
diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 559c64be7f7..0d56a41ecf6 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -7,7 +7,6 @@
  */
 
 #include <efi_dt_fixup.h>
-#include <part.h>
 #include <linux/libfdt.h>
 #include "efi_app_common.h"
 
@@ -18,14 +17,10 @@
 
 static struct efi_boot_services *bs;
 static const efi_guid_t fdt_guid = EFI_FDT_GUID;
-static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
-static const efi_guid_t guid_simple_file_system_protocol =
-					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static efi_handle_t handle;
 static struct efi_system_table *systable;
 static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
 static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
-static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
 
 /**
  * print_char() - print character
@@ -66,27 +61,6 @@ static u32 f2h(fdt32_t val)
 	return *(u32 *)buf;
 }
 
-/**
- * get_dtb() - get device tree
- *
- * @systable:	system table
- * Return:	device tree or NULL
- */
-static void *get_dtb(struct efi_system_table *systable)
-{
-	void *dtb = NULL;
-	efi_uintn_t i;
-
-	for (i = 0; i < systable->nr_tables; ++i) {
-		if (!memcmp(&systable->tables[i].guid, &fdt_guid,
-			    sizeof(efi_guid_t))) {
-			dtb = systable->tables[i].table;
-			break;
-		}
-	}
-	return dtb;
-}
-
 /**
  * do_help() - print help
  */
@@ -98,52 +72,6 @@ static void do_help(void)
 	error(u"exit       - exit the shell\r\n");
 }
 
-/**
- * open_file_system() - open simple file system protocol
- *
- * file_system:	interface of the simple file system protocol
- * Return:	status code
- */
-static efi_status_t
-open_file_system(struct efi_simple_file_system_protocol **file_system)
-{
-	struct efi_loaded_image *loaded_image;
-	efi_status_t ret;
-	efi_handle_t *handle_buffer = NULL;
-	efi_uintn_t count;
-
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		return ret;
-	}
-
-	/* Open the simple file system protocol on the same partition */
-	ret = bs->open_protocol(loaded_image->device_handle,
-				&guid_simple_file_system_protocol,
-				(void **)file_system, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret == EFI_SUCCESS)
-		return ret;
-
-	/* Open the simple file system protocol on the UEFI system partition */
-	ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
-				       NULL, &count, &handle_buffer);
-	if (ret == EFI_SUCCESS && handle_buffer)
-		ret = bs->open_protocol(handle_buffer[0],
-					&guid_simple_file_system_protocol,
-					(void **)file_system, NULL, NULL,
-					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS)
-		error(u"Failed to open simple file system protocol\r\n");
-	if (handle_buffer)
-		bs->free_pool(handle_buffer);
-
-	return ret;
-}
-
 /**
  * do_load() - load and install device-tree
  *
@@ -289,13 +217,11 @@ out:
  */
 static efi_status_t do_save(u16 *filename)
 {
-	struct efi_simple_file_system_protocol *file_system;
-	efi_uintn_t dtb_size;
-	struct efi_file_handle *root, *file;
 	struct fdt_header *dtb;
+	efi_uintn_t dtb_size;
 	efi_uintn_t ret;
 
-	dtb = get_dtb(systable);
+	dtb = get_config_table(&fdt_guid);
 	if (!dtb) {
 		error(u"DTB not found\r\n");
 		return EFI_NOT_FOUND;
@@ -308,45 +234,7 @@ static efi_status_t do_save(u16 *filename)
 
 	filename = skip_whitespace(filename);
 
-	ret = open_file_system(&file_system);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	/* Open volume */
-	ret = file_system->open_volume(file_system, &root);
-	if (ret != EFI_SUCCESS) {
-		error(u"Failed to open volume\r\n");
-		return ret;
-	}
-	/* Check if file already exists */
-	ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
-	if (ret == EFI_SUCCESS) {
-		file->close(file);
-		print(u"Overwrite existing file (y/n)? ");
-		ret = efi_input_yn();
-		print(u"\r\n");
-		if (ret != EFI_SUCCESS) {
-			root->close(root);
-			error(u"Aborted by user\r\n");
-			return ret;
-		}
-	}
-
-	/* Create file */
-	ret = root->open(root, &file, filename,
-			 EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
-			 EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
-	if (ret == EFI_SUCCESS) {
-		/* Write file */
-		ret = file->write(file, &dtb_size, dtb);
-		if (ret != EFI_SUCCESS)
-			error(u"Failed to write file\r\n");
-		file->close(file);
-	} else {
-		error(u"Failed to open file\r\n");
-	}
-	root->close(root);
-
+	ret = save_file(filename, dtb, dtb_size);
 	if (ret == EFI_SUCCESS) {
 		print(filename);
 		print(u" written\r\n");
@@ -479,7 +367,7 @@ static efi_status_t do_dump(void)
 	const char *strings;
 	u32 level = 0;
 
-	fdt = get_dtb(systable);
+	fdt = get_config_table(&fdt_guid);
 	if (!fdt) {
 		error(u"DTB not found\r\n");
 		return EFI_NOT_FOUND;
diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
index 6bd52e08d28..2bb71f4fc1a 100644
--- a/lib/efi_loader/efi_app_common.c
+++ b/lib/efi_loader/efi_app_common.c
@@ -6,6 +6,7 @@
  */
 
 #include <efi_api.h>
+#include <part.h>
 #include "efi_app_common.h"
 
 static efi_handle_t app_handle;
@@ -15,6 +16,9 @@ struct efi_boot_services *bs;
 static bool nocolor;
 static struct efi_system_table *systable;
 static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
+static const efi_guid_t guid_simple_file_system_protocol =
+	EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
+static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
 
 static u16 *get_load_options(void)
 {
@@ -199,3 +203,105 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
 		}
 	}
 }
+
+void *get_config_table(const efi_guid_t *guid)
+{
+	size_t i;
+
+	for (i = 0; i < systable->nr_tables; ++i) {
+		if (!memcmp(guid, &systable->tables[i].guid,
+			    sizeof(efi_guid_t)))
+			return systable->tables[i].table;
+	}
+
+	return NULL;
+}
+
+efi_status_t
+open_file_system(struct efi_simple_file_system_protocol **file_system)
+{
+	struct efi_loaded_image *loaded_image;
+	efi_status_t ret;
+	efi_handle_t *handle_buffer = NULL;
+	efi_uintn_t count;
+
+	ret = bs->open_protocol(app_handle, &loaded_image_guid,
+				(void **)&loaded_image, NULL, NULL,
+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS) {
+		error(u"Loaded image protocol not found\r\n");
+		return ret;
+	}
+
+	/* Open the simple file system protocol on the same partition */
+	ret = bs->open_protocol(loaded_image->device_handle,
+				&guid_simple_file_system_protocol,
+				(void **)file_system, NULL, NULL,
+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret == EFI_SUCCESS)
+		return ret;
+
+	/* Open the simple file system protocol on the UEFI system partition */
+	ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
+				       NULL, &count, &handle_buffer);
+	if (ret == EFI_SUCCESS && handle_buffer)
+		ret = bs->open_protocol(handle_buffer[0],
+					&guid_simple_file_system_protocol,
+					(void **)file_system, NULL, NULL,
+					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS)
+		error(u"Failed to open simple file system protocol\r\n");
+	if (handle_buffer)
+		bs->free_pool(handle_buffer);
+
+	return ret;
+}
+
+efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
+{
+	efi_status_t ret;
+	struct efi_simple_file_system_protocol *file_system;
+	struct efi_file_handle *root, *file;
+
+	ret = open_file_system(&file_system);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	/* Open volume */
+	ret = file_system->open_volume(file_system, &root);
+	if (ret != EFI_SUCCESS) {
+		error(u"Failed to open volume\r\n");
+		return ret;
+	}
+	/* Check if file already exists */
+	ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
+	if (ret == EFI_SUCCESS) {
+		file->close(file);
+		print(u"Overwrite existing file (y/n)? ");
+		ret = efi_input_yn();
+		print(u"\r\n");
+		if (ret != EFI_SUCCESS) {
+			root->close(root);
+			error(u"Aborted by user\r\n");
+			return ret;
+		}
+	}
+
+	/* Create file */
+	ret = root->open(root, &file, filename,
+			 EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
+				 EFI_FILE_MODE_CREATE,
+			 EFI_FILE_ARCHIVE);
+	if (ret == EFI_SUCCESS) {
+		/* Write file */
+		ret = file->write(file, &size, buf);
+		if (ret != EFI_SUCCESS)
+			error(u"Failed to write file\r\n");
+		file->close(file);
+	} else {
+		error(u"Failed to open file\r\n");
+	}
+	root->close(root);
+
+	return ret;
+}
diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
index ff37f3413eb..7cdc5ca0ca0 100644
--- a/lib/efi_loader/efi_app_common.h
+++ b/lib/efi_loader/efi_app_common.h
@@ -101,4 +101,36 @@ efi_status_t efi_input_yn(void);
  */
 efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
 
+/**
+ * get_config_table() - get configuration table
+ *
+ * @guid:       GUID of the configuration table
+ * Return:      pointer to configuration table or NULL
+ */
+void *get_config_table(const efi_guid_t *guid);
+
+/**
+ * open_file_system() - open simple file system protocol
+ *
+ * First try to open the file system pointed to by the Loaded Image
+ * Protocol of the application. If this fails, use the ESP.
+ *
+ * @file_system: interface of the simple file system protocol
+ * Return:       status code
+ */
+efi_status_t
+open_file_system(struct efi_simple_file_system_protocol **file_system);
+
+/**
+ * save_file() - save buffer to a file
+ *
+ * See open_file_system() for the partition used.
+ *
+ * @filename:   file name
+ * @buf:        buffer to write
+ * @size:       size of the buffer
+ * Return:      status code
+ */
+efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size);
+
 #endif /* _EFI_APP_COMMON_H */
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 0a025c1a841..c3e6f2b683f 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -19,9 +19,6 @@
 
 static struct efi_system_table *systable;
 static struct efi_boot_services *bs;
-static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
-static const efi_guid_t guid_simple_file_system_protocol =
-					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
 static const efi_guid_t load_file2_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
 static efi_handle_t handle;
 
@@ -143,9 +140,6 @@ static efi_status_t do_load(void)
  */
 static efi_status_t do_save(u16 *filename)
 {
-	struct efi_loaded_image *loaded_image;
-	struct efi_simple_file_system_protocol *file_system;
-	struct efi_file_handle *root, *file;
 	void *initrd;
 	efi_uintn_t initrd_size;
 	efi_uintn_t ret;
@@ -156,68 +150,13 @@ static efi_status_t do_save(u16 *filename)
 
 	filename = skip_whitespace(filename);
 
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		goto out;
-	}
-
-	/* Open the simple file system protocol */
-	ret = bs->open_protocol(loaded_image->device_handle,
-				&guid_simple_file_system_protocol,
-				(void **)&file_system, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Failed to open simple file system protocol\r\n");
-		goto out;
-	}
-
-	/* Open volume */
-	ret = file_system->open_volume(file_system, &root);
-	if (ret != EFI_SUCCESS) {
-		error(u"Failed to open volume\r\n");
-		goto out;
-	}
-	/* Check if file already exists */
-	ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
-	if (ret == EFI_SUCCESS) {
-		file->close(file);
-		efi_drain_input();
-		print(u"Overwrite existing file (y/n)? ");
-		ret = efi_input_yn();
-		print(u"\r\n");
-		if (ret != EFI_SUCCESS) {
-			root->close(root);
-			error(u"Aborted by user\r\n");
-			goto out;
-		}
-	}
-
-	/* Create file */
-	ret = root->open(root, &file, filename,
-			 EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
-			 EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
+	ret = save_file(filename, initrd, initrd_size);
 	if (ret == EFI_SUCCESS) {
-		/* Write file */
-		ret = file->write(file, &initrd_size, initrd);
-		if (ret != EFI_SUCCESS) {
-			error(u"Failed to write file\r\n");
-		} else {
-			print(filename);
-			print(u" written\r\n");
-		}
-		file->close(file);
-	} else {
-		error(u"Failed to open file\r\n");
+		print(filename);
+		print(u" written\r\n");
 	}
-	root->close(root);
 
-out:
-	if (initrd)
-		bs->free_pages((uintptr_t)initrd,
-			       efi_size_in_pages(initrd_size));
+	bs->free_pages((uintptr_t)initrd, efi_size_in_pages(initrd_size));
 	return ret;
 }
 
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 351e103fb97..8aa6f594a07 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -8,7 +8,6 @@
  * clearing of the screen.
  */
 
-#include <part.h>
 #include <smbios.h>
 #include <string.h>
 #include "efi_app_common.h"
@@ -20,56 +19,6 @@ static efi_handle_t handle;
 static struct efi_system_table *systable;
 static const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
 static const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
-static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
-static const efi_guid_t guid_simple_file_system_protocol =
-					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
-static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
-
-/**
- * open_file_system() - open simple file system protocol
- *
- * file_system:	interface of the simple file system protocol
- * Return:	status code
- */
-static efi_status_t
-open_file_system(struct efi_simple_file_system_protocol **file_system)
-{
-	struct efi_loaded_image *loaded_image;
-	efi_status_t ret;
-	efi_handle_t *handle_buffer = NULL;
-	efi_uintn_t count;
-
-	ret = bs->open_protocol(handle, &loaded_image_guid,
-				(void **)&loaded_image, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS) {
-		error(u"Loaded image protocol not found\r\n");
-		return ret;
-	}
-
-	/* Open the simple file system protocol on the same partition */
-	ret = bs->open_protocol(loaded_image->device_handle,
-				&guid_simple_file_system_protocol,
-				(void **)file_system, NULL, NULL,
-				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret == EFI_SUCCESS)
-		return ret;
-
-	/* Open the simple file system protocol on the UEFI system partition */
-	ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
-				       NULL, &count, &handle_buffer);
-	if (ret == EFI_SUCCESS && handle_buffer)
-		ret = bs->open_protocol(handle_buffer[0],
-					&guid_simple_file_system_protocol,
-					(void **)file_system, NULL, NULL,
-					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
-	if (ret != EFI_SUCCESS)
-		error(u"Failed to open simple file system protocol\r\n");
-	if (handle_buffer)
-		bs->free_pool(handle_buffer);
-
-	return ret;
-}
 
 /**
  * do_help() - print help
@@ -81,24 +30,6 @@ static void do_help(void)
 	error(u"exit        - exit the shell\r\n");
 }
 
-/**
- * get_config_table() - get configuration table
- *
- * @guid:	GUID of the configuration table
- * Return:	pointer to configuration table or NULL
- */
-static void *get_config_table(const efi_guid_t *guid)
-{
-	size_t i;
-
-	for (i = 0; i < systable->nr_tables; ++i) {
-		if (!memcmp(guid, &systable->tables[i].guid, 16))
-			return systable->tables[i].table;
-	}
-
-	return NULL;
-}
-
 /**
  * checksum() - calculate checksum
  *
@@ -211,62 +142,6 @@ static efi_status_t do_check(void)
 	return EFI_SUCCESS;
 }
 
-/**
- * save_file() - save file to EFI system partition
- *
- * @filename:	file name
- * @buf:	buffer to write
- * @size:	size of the buffer
- */
-static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
-{
-	efi_uintn_t ret;
-	struct efi_simple_file_system_protocol *file_system;
-	struct efi_file_handle *root, *file;
-
-	ret = open_file_system(&file_system);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	/* Open volume */
-	ret = file_system->open_volume(file_system, &root);
-	if (ret != EFI_SUCCESS) {
-		error(u"Failed to open volume\r\n");
-		return ret;
-	}
-	/* Check if file already exists */
-	ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
-	if (ret == EFI_SUCCESS) {
-		file->close(file);
-		print(u"Overwrite existing file (y/n)? ");
-		ret = efi_input_yn();
-		print(u"\r\n");
-		if (ret != EFI_SUCCESS) {
-			root->close(root);
-			error(u"Aborted by user\r\n");
-			bs->free_pool(buf);
-			return ret;
-		}
-	}
-
-	/* Create file */
-	ret = root->open(root, &file, filename,
-			 EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
-			 EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
-	if (ret == EFI_SUCCESS) {
-		/* Write file */
-		ret = file->write(file, &size, buf);
-		if (ret != EFI_SUCCESS)
-			error(u"Failed to write file\r\n");
-		file->close(file);
-	} else {
-		error(u"Failed to open file\r\n");
-	}
-	root->close(root);
-
-	return ret;
-}
-
 /**
  * do_save() - save SMBIOS table
  *
-- 
2.53.0

