Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD6AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0ED87983;
	Wed,  3 Jan 2024 09:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bzQ0NB3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B474C87983; Wed,  3 Jan 2024 09:07:45 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AFF879A4
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6278642FD2; 
 Wed,  3 Jan 2024 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704269255;
 bh=BUpxyOcDYrrGQlu91hku2Up1nbZjEphWafxltEeAAKw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bzQ0NB3u+cAAxUtsk/xetwcw3CWe7PRrR4UTjK+1NTX4woFbvg9fpq/ixSaoLzbIh
 fOLrbE8WfqWF3p2DdJI5iM/ijX49NypbhS1wOqVZC2X5cTId2Inx3OcBkSIGmakHDp
 0ZTdcM1QdyPR7qpRYXdI8zJUBSb3Er2bH+ufffSJtmroOOgCJc79QROeYE/62PBDup
 0191WalgHQCdXHoTKdTbIJQ7I5UfIbCTxg1m5yFoR6z73NBZEri2zyNkMJQIbudSk2
 v7XRt1mCWtQF8RmZecFpqAVXgQASstodDypFSUfD8Bo5nXbp5JpvYh+MKcGs020TvN
 1xYr/kUgsXp5A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/2] efi_loader: provide tool to dump SMBIOS table
Date: Wed,  3 Jan 2024 09:07:21 +0100
Message-ID: <20240103080721.22292-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103080721.22292-1-heinrich.schuchardt@canonical.com>
References: <20240103080721.22292-1-heinrich.schuchardt@canonical.com>
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

An EFI binary smbiosdump.efi is provided that can be used to check the
SMBIOS table for consistency and to dump it as a file.

The tool provides the following commands:

check
    Check the SMBIOS table for consistency.

exit
    Leave the tool.

help
    Show available commands.

save
    Save the SMBIOS table to a file on the EFI system partition. The file
    can be further analyzed with the dmidecode command line tool::

        dmidecode --from-dump <filename>

Specifying 'nocolor' as load option data suppresses colored output and
clearing of the screen.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	rename the tool
	restructure the code
	handle NULL value in starts_with()
v2:
	fix an incorrect variable usage when checking the result of memcmp
---
 lib/efi_loader/Makefile     |   7 +
 lib/efi_loader/smbiosdump.c | 622 ++++++++++++++++++++++++++++++++++++
 2 files changed, 629 insertions(+)
 create mode 100644 lib/efi_loader/smbiosdump.c

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 24d33d5409..25060bbd95 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -16,6 +16,8 @@ CFLAGS_boothart.o := $(CFLAGS_EFI) -Os -ffreestanding
 CFLAGS_REMOVE_boothart.o := $(CFLAGS_NON_EFI)
 CFLAGS_helloworld.o := $(CFLAGS_EFI) -Os -ffreestanding
 CFLAGS_REMOVE_helloworld.o := $(CFLAGS_NON_EFI)
+CFLAGS_smbiosdump.o := $(CFLAGS_EFI) -Os -ffreestanding
+CFLAGS_REMOVE_smbiosdump.o := $(CFLAGS_NON_EFI)
 CFLAGS_dtbdump.o := $(CFLAGS_EFI) -Os -ffreestanding
 CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
 CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
@@ -31,6 +33,11 @@ always += helloworld.efi
 targets += helloworld.o
 endif
 
+ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
+always += smbiosdump.efi
+targets += smbiosdump.o
+endif
+
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 always += dtbdump.efi
 targets += dtbdump.o
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
new file mode 100644
index 0000000000..8a42794789
--- /dev/null
+++ b/lib/efi_loader/smbiosdump.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * smbiosdump.efi saves the SMBIOS table as file.
+ *
+ * Specifying 'nocolor' as load option data suppresses colored output and
+ * clearing of the screen.
+ */
+
+#include <efi_api.h>
+#include <part.h>
+#include <smbios.h>
+#include <string.h>
+
+#define BUFFER_SIZE 64
+
+static struct efi_simple_text_output_protocol *cerr;
+static struct efi_simple_text_output_protocol *cout;
+static struct efi_simple_text_input_protocol *cin;
+static struct efi_boot_services *bs;
+static efi_handle_t handle;
+static struct efi_system_table *systable;
+static const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
+static const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
+static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
+static const efi_guid_t guid_simple_file_system_protocol =
+					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
+static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
+static bool nocolor;
+
+/**
+ * color() - set foreground color
+ *
+ * @color:	foreground color
+ */
+static void color(u8 color)
+{
+	if (!nocolor)
+		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
+}
+
+/**
+ * print() - print string
+ *
+ * @string:	text
+ */
+static void print(u16 *string)
+{
+	cout->output_string(cout, string);
+}
+
+/**
+ * cls() - clear screen
+ */
+static void cls(void)
+{
+	if (nocolor)
+		print(u"\r\n");
+	else
+		cout->clear_screen(cout);
+}
+
+/**
+ * error() - print error string
+ *
+ * @string:	error text
+ */
+static void error(u16 *string)
+{
+	color(EFI_LIGHTRED);
+	print(string);
+	color(EFI_LIGHTBLUE);
+}
+
+/**
+ * efi_input_yn() - get answer to yes/no question
+ *
+ * Return:
+ * y or Y
+ *     EFI_SUCCESS
+ * n or N
+ *     EFI_ACCESS_DENIED
+ * ESC
+ *     EFI_ABORTED
+ */
+static efi_status_t efi_input_yn(void)
+{
+	struct efi_input_key key = {0};
+	efi_uintn_t index;
+	efi_status_t ret;
+
+	/* Drain the console input */
+	ret = cin->reset(cin, true);
+	for (;;) {
+		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
+		if (ret != EFI_SUCCESS)
+			continue;
+		ret = cin->read_key_stroke(cin, &key);
+		if (ret != EFI_SUCCESS)
+			continue;
+		switch (key.scan_code) {
+		case 0x17: /* Escape */
+			return EFI_ABORTED;
+		default:
+			break;
+		}
+		/* Convert to lower case */
+		switch (key.unicode_char | 0x20) {
+		case 'y':
+			return EFI_SUCCESS;
+		case 'n':
+			return EFI_ACCESS_DENIED;
+		default:
+			break;
+		}
+	}
+}
+
+/**
+ * efi_input() - read string from console
+ *
+ * @buffer:		input buffer
+ * @buffer_size:	buffer size
+ * Return:		status code
+ */
+static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
+{
+	struct efi_input_key key = {0};
+	efi_uintn_t index;
+	efi_uintn_t pos = 0;
+	u16 outbuf[2] = u" ";
+	efi_status_t ret;
+
+	/* Drain the console input */
+	ret = cin->reset(cin, true);
+	*buffer = 0;
+	for (;;) {
+		ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
+		if (ret != EFI_SUCCESS)
+			continue;
+		ret = cin->read_key_stroke(cin, &key);
+		if (ret != EFI_SUCCESS)
+			continue;
+		switch (key.scan_code) {
+		case 0x17: /* Escape */
+			print(u"\r\nAborted\r\n");
+			return EFI_ABORTED;
+		default:
+			break;
+		}
+		switch (key.unicode_char) {
+		case 0x08: /* Backspace */
+			if (pos) {
+				buffer[pos--] = 0;
+				print(u"\b \b");
+			}
+			break;
+		case 0x0a: /* Linefeed */
+		case 0x0d: /* Carriage return */
+			print(u"\r\n");
+			return EFI_SUCCESS;
+		default:
+			break;
+		}
+		/* Ignore surrogate codes */
+		if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
+			continue;
+		if (key.unicode_char >= 0x20 &&
+		    pos < buffer_size - 1) {
+			*outbuf = key.unicode_char;
+			buffer[pos++] = key.unicode_char;
+			buffer[pos] = 0;
+			print(outbuf);
+		}
+	}
+}
+
+/**
+ * skip_whitespace() - skip over leading whitespace
+ *
+ * @pos:	UTF-16 string
+ * Return:	pointer to first non-whitespace
+ */
+static u16 *skip_whitespace(u16 *pos)
+{
+	for (; *pos && *pos <= 0x20; ++pos)
+		;
+	return pos;
+}
+
+/**
+ * starts_with() - check if @string starts with @keyword
+ *
+ * @string:	string to search for keyword
+ * @keyword:	keyword to be searched
+ * Return:	true fi @string starts with the keyword
+ */
+static bool starts_with(u16 *string, u16 *keyword)
+{
+	if (!string || !keyword)
+		return NULL;
+
+	for (; *keyword; ++string, ++keyword) {
+		if (*string != *keyword)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * open_file_system() - open simple file system protocol
+ *
+ * file_system:	interface of the simple file system protocol
+ * Return:	status code
+ */
+static efi_status_t
+open_file_system(struct efi_simple_file_system_protocol **file_system)
+{
+	struct efi_loaded_image *loaded_image;
+	efi_status_t ret;
+	efi_handle_t *handle_buffer = NULL;
+	efi_uintn_t count;
+
+	ret = bs->open_protocol(handle, &loaded_image_guid,
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
+	if (handle)
+		bs->free_pool(handle_buffer);
+
+	return ret;
+}
+
+/**
+ * do_help() - print help
+ */
+static void do_help(void)
+{
+	error(u"check       - check SMBIOS table\r\n");
+	error(u"save <file> - save SMBIOS table to file\r\n");
+	error(u"exit        - exit the shell\r\n");
+}
+
+/**
+ * get_config_table() - get configuration table
+ *
+ * @guid:	GUID of the configuration table
+ * Return:	pointer to configuration table or NULL
+ */
+static void *get_config_table(const efi_guid_t *guid)
+{
+	size_t i;
+
+	for (i = 0; i < systable->nr_tables; ++i) {
+		if (!memcmp(guid, &systable->tables[i].guid, 16))
+			return systable->tables[i].table;
+	}
+
+	return NULL;
+}
+
+/**
+ * checksum() - calculate checksum
+ *
+ * @buf:	buffer to checksum
+ * @len:	length of buffer
+ * Return:	checksum
+ */
+u8 checksum(void *buf, int len)
+{
+	u8 ret = 0;
+
+	for (u8 *ptr = buf; len; --len, ++ptr)
+		ret -= *ptr;
+
+	return ret;
+}
+
+/**
+ * do_check() - check SMBIOS table
+ *
+ * Return:	status code
+ */
+efi_status_t do_check(void)
+{
+	struct smbios3_entry *smbios3_anchor;
+	void *table, *table_end;
+	u32 len;
+
+	smbios3_anchor = get_config_table(&smbios3_guid);
+	if (smbios3_anchor) {
+		int r;
+
+		r = memcmp(smbios3_anchor->anchor, "_SM3_", 5);
+		if (r) {
+			error(u"Invalid anchor string\n");
+			return EFI_LOAD_ERROR;
+		}
+		print(u"Found SMBIOS 3 entry point\n");
+		if (smbios3_anchor->length != 0x18) {
+			error(u"Invalid anchor length\n");
+			return EFI_LOAD_ERROR;
+		}
+		if (checksum(smbios3_anchor, smbios3_anchor->length)) {
+			error(u"Invalid anchor checksum\n");
+			return EFI_LOAD_ERROR;
+		}
+		table = (void *)(uintptr_t)smbios3_anchor->struct_table_address;
+		len = smbios3_anchor->max_struct_size;
+	} else {
+		struct smbios_entry *smbios_anchor;
+		int r;
+
+		smbios_anchor = get_config_table(&smbios_guid);
+		if (!smbios_anchor) {
+			error(u"No SMBIOS table\n");
+			return EFI_NOT_FOUND;
+		}
+		r = memcmp(smbios_anchor->anchor, "_SM_", 4);
+		if (r) {
+			error(u"Invalid anchor string\n");
+			return EFI_LOAD_ERROR;
+		}
+		print(u"Found SMBIOS 2.1 entry point\n");
+		if (smbios_anchor->length != 0x1f) {
+			error(u"Invalid anchor length\n");
+			return EFI_LOAD_ERROR;
+		}
+		if (checksum(smbios_anchor, smbios_anchor->length)) {
+			error(u"Invalid anchor checksum\n");
+			return EFI_LOAD_ERROR;
+		}
+		r = memcmp(smbios_anchor->intermediate_anchor, "_DMI_", 5);
+		if (r) {
+			error(u"Invalid intermediate anchor string\n");
+			return EFI_LOAD_ERROR;
+		}
+		if (checksum(&smbios_anchor->intermediate_anchor, 0xf)) {
+			error(u"Invalid intermediate anchor checksum\n");
+			return EFI_LOAD_ERROR;
+		}
+		table = (void *)(uintptr_t)smbios_anchor->struct_table_address;
+		len = smbios_anchor->struct_table_length;
+	}
+
+	table_end = (void *)((u8 *)table + len);
+	for (struct smbios_header *pos = table; ;) {
+		u8 *str = (u8 *)pos + pos->length;
+
+		if (!*str)
+			++str;
+		while (*str) {
+			for (; *str; ++str) {
+				if ((void *)str >= table_end) {
+					error(u"Structure table length exceeded\n");
+					return EFI_LOAD_ERROR;
+				}
+			}
+			++str;
+		}
+		++str;
+		if ((void *)str > table_end) {
+			error(u"Structure table length exceeded\n");
+			return EFI_LOAD_ERROR;
+		}
+		if (pos->type == 0x7f) /* End of table */
+			break;
+		pos = (struct smbios_header *)str;
+	}
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * save_file() - save file to EFI system partition
+ *
+ * @filename:	file name
+ * @buf:	buffer to write
+ * @size:	size of the buffer
+ */
+efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
+{
+	efi_uintn_t ret;
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
+			bs->free_pool(buf);
+			return ret;
+		}
+	}
+
+	/* Create file */
+	ret = root->open(root, &file, filename,
+			 EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
+			 EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
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
+
+/**
+ * do_save() - save SMBIOS table
+ *
+ * @filename:	file name
+ * Return:	status code
+ */
+static efi_status_t do_save(u16 *filename)
+{
+	struct smbios3_entry *smbios3_anchor;
+	u8 *buf;
+	efi_uintn_t size;
+	efi_uintn_t ret;
+
+	ret = do_check();
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	smbios3_anchor = get_config_table(&smbios3_guid);
+	if (smbios3_anchor) {
+		size = 0x20 + smbios3_anchor->max_struct_size;
+		ret = bs->allocate_pool(EFI_LOADER_DATA, size, (void **)&buf);
+		if (ret != EFI_SUCCESS) {
+			error(u"Out of memory\n");
+			return ret;
+		}
+
+		memset(buf, 0, size);
+		memcpy(buf, smbios3_anchor, smbios3_anchor->length);
+		memcpy(buf + 0x20,
+		       (void *)(uintptr_t)smbios3_anchor->struct_table_address,
+		       smbios3_anchor->max_struct_size);
+
+		smbios3_anchor = (struct smbios3_entry *)buf;
+		smbios3_anchor->struct_table_address = 0x20;
+		smbios3_anchor->checksum +=
+			checksum(smbios3_anchor, smbios3_anchor->length);
+	} else {
+		struct smbios_entry *smbios_anchor;
+
+		smbios_anchor = get_config_table(&smbios_guid);
+		if (!smbios_anchor) {
+			/* Should not be reached after successful do_check() */
+			error(u"No SMBIOS table\n");
+			return EFI_NOT_FOUND;
+		}
+
+		size = 0x20 + smbios_anchor->struct_table_length;
+
+		ret = bs->allocate_pool(EFI_LOADER_DATA, size, (void **)&buf);
+		if (ret != EFI_SUCCESS) {
+			error(u"Out of memory\n");
+			return ret;
+		}
+
+		memset(buf, 0, size);
+		memcpy(buf, smbios_anchor, smbios_anchor->length);
+		memcpy(buf + 0x20,
+		       (void *)(uintptr_t)smbios_anchor->struct_table_address,
+		       smbios_anchor->struct_table_length);
+
+		smbios_anchor = (struct smbios_entry *)buf;
+		smbios_anchor->struct_table_address = 0x20;
+		smbios_anchor->intermediate_checksum +=
+			checksum(&smbios_anchor->intermediate_anchor, 0xf);
+		smbios_anchor->checksum +=
+			checksum(smbios_anchor, smbios_anchor->length);
+	}
+
+	filename = skip_whitespace(filename);
+
+	ret = save_file(filename, buf, size);
+
+	if (ret == EFI_SUCCESS) {
+		print(filename);
+		print(u" written\r\n");
+	}
+
+	bs->free_pool(buf);
+
+	return ret;
+}
+
+/**
+ * get_load_options() - get load options
+ *
+ * Return:	load options or NULL
+ */
+static u16 *get_load_options(void)
+{
+	efi_status_t ret;
+	struct efi_loaded_image *loaded_image;
+
+	ret = bs->open_protocol(handle, &loaded_image_guid,
+				(void **)&loaded_image, NULL, NULL,
+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS) {
+		error(u"Loaded image protocol not found\r\n");
+		return NULL;
+	}
+
+	if (!loaded_image->load_options_size || !loaded_image->load_options)
+		return NULL;
+
+	return loaded_image->load_options;
+}
+
+/**
+ * command_loop - process user commands
+ */
+static void command_loop(void)
+{
+	for (;;) {
+		u16 command[BUFFER_SIZE];
+		u16 *pos;
+		efi_uintn_t ret;
+
+		print(u"=> ");
+		ret = efi_input(command, sizeof(command));
+		if (ret == EFI_ABORTED)
+			break;
+		pos = skip_whitespace(command);
+		if (starts_with(pos, u"exit")) {
+			break;
+		} else if (starts_with(pos, u"check")) {
+			ret = do_check();
+			if (ret == EFI_SUCCESS)
+				print(u"OK\n");
+		} else if (starts_with(pos, u"save ")) {
+			do_save(pos + 5);
+		} else {
+			do_help();
+		}
+	}
+}
+
+/**
+ * efi_main() - entry point of the EFI application.
+ *
+ * @handle:	handle of the loaded image
+ * @systab:	system table
+ * Return:	status code
+ */
+efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
+			     struct efi_system_table *systab)
+{
+	u16 *load_options;
+
+	handle = image_handle;
+	systable = systab;
+	cerr = systable->std_err;
+	cout = systable->con_out;
+	cin = systable->con_in;
+	bs = systable->boottime;
+	load_options = get_load_options();
+
+	if (starts_with(load_options, u"nocolor"))
+		nocolor = true;
+
+	color(EFI_WHITE);
+	cls();
+	print(u"DMI Dump\r\n========\r\n\r\n");
+	color(EFI_LIGHTBLUE);
+
+	command_loop();
+
+	color(EFI_LIGHTGRAY);
+	cls();
+
+	return EFI_SUCCESS;
+}
-- 
2.43.0

