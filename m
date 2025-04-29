Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96D2C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 08:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3060D80F03;
	Tue, 29 Apr 2025 10:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HKe70adM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF3381FDE; Tue, 29 Apr 2025 10:41:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193D58007D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 89C713F47E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745916107;
 bh=dc84M3bpXqMOw6PlS5p1d8LGndGl97ciotP8k4kgEQo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HKe70adMeIf1Fcsmzj9YwPgivFjJnPZDImTf4AN9Yk29xC57sW089xdGEZMaXtWmm
 kU12wM/BJjCNJLZMVks67xds3albnhgTcMlR8lvuu6qjxLmw3DIYcp8ux3kBiWsZMG
 0aXeSRKU9Fp2hFzkuh1b5WpJVD76WghiXzLUo6Of8iIJSchvZP214dPnek5sLlelju
 bVOAaJwrKb7FYCQ7XyN5SJ0OGn4RPmcMOaaEPHGfKei0UROVMGFkuyHBvuEfAjJ4aQ
 fc7Xr+OAItXqGz27Kz8b+FUyRQxzEmNpp1XNM+z1WGgyj1HfrFjtSyXD/7zpWAehZS
 9TAO7qY/5Ri9w==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so28377385e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 01:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745916105; x=1746520905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dc84M3bpXqMOw6PlS5p1d8LGndGl97ciotP8k4kgEQo=;
 b=UIaTVHbJDuJ2LaazPXyqQfUu7uC9MJXX7Gp7jwS/zZrSxEns133CoFrkU1zUevsJRx
 kX7OHElH4RiIRHhH5miHSA8bFq5wQG77n3sLky3FJUYe/F+aqH1BxdzSNR2QGteNSSvM
 qPqMNOGpHN9H9g11EqLNFnb93HdegkQrjXPxk+N/2rEFMeeMlk1ckFKwYALyoRJ399m9
 O35UXkdbKXSc/95wd6auoD8oDP39dR1hYLpWHZZygKGkf2jCvz71Oxp21YIk9Oh30Qnw
 si8Gm4eFkcmO+o2qhThRmjQRpZ4SSRc+34mwrBs00vhb3AwIThppSohPNqxesCya3e50
 pYsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd96J6s3XJApGyNVgUeSsewYJSRwIwF1+JAA7hYQH5vOrsZzhpdY4L54MEu59BJFvPrhtUbBc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9S2GzlQSAKoCDnhD923k4I5vDjMPoA8lDPnDRkxhEZgvNJXDY
 BtPx5jx1jDBZLjGZj/S6ul10Wwj2+r5xE1WeisQsmwDrutn2UZBv9KLoSRfbdfUk1UNw92MtmvR
 T8TmdKrNDZVzbp3Opcx8MS12urcxW1V38Qcw7koI/YjBTYXCBxZNK41xwzZ0P93JwigSckH+4Op
 Y=
X-Gm-Gg: ASbGncvteygy2Md1sx+GnsVyrZNzFceHUI7Dlo1rGG4CiB+t8yPhpN8UwGou9XdfgLt
 7WpJ474zu8aHKuMDnJcAhlEcKEzsPGIs3U4fSuso61miH3Bl8YVOGZvi+zM9YA9pY6lG2HsfdO7
 cyJt4I5D2E8i8KaKFcSLxyT79KmA7RaZrN334GEYQi4MpCi/CUBOFNO0dgRFZG2CUl6qHg+KNyq
 pC5P1HBqHoQ86Ubqjh0KYN38FfgnuMhmE87Dgar3xwCKpv6iJfTLtpGsyJJaDLZQPmUjwcWoDhF
 UVkf7p7QcM9BmUqygG6mQ8zqfWsn9ElWwO/0ih1YOanDow==
X-Received: by 2002:a05:600c:1908:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-440ab872370mr113420475e9.30.1745916105188; 
 Tue, 29 Apr 2025 01:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZTFjpjYLxAnWS85/RaLTZFEf0xM8UNann2NaqJ6WWMNbzISMkk+I9jtEksORYIukOl1uMEg==
X-Received: by 2002:a05:600c:1908:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-440ab872370mr113420155e9.30.1745916104738; 
 Tue, 29 Apr 2025 01:41:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:7fae:8f35:67e9:6205:4893])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5310a8fsm151494355e9.22.2025.04.29.01.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 01:41:44 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: add dbginfodump.efi
Date: Tue, 29 Apr 2025 10:41:38 +0200
Message-ID: <20250429084138.239990-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Provide a test application to dump the EFI_DEBUG_IMAGE_INFO_TABLE
as implemented in EDK II.

EFI_DEBUG_IMAGE_INFO is not packed in contrast to many other EFI
structures.

As of today EDK II when removing an entry in the EfiDebugImageInfoTable
just sets NormalImage = NULL but does not compact the array. So
TableSize reflects the number of non-NULL entries and not the array
size as reported independently in
https://github.com/tianocore/edk2/pull/11013 and
https://github.com/tianocore/edk2/pull/11019.

The current implementation tolerates this deviation from the UEFI
specification.

This is what the output may look like:

    Debug Info Table Dump
    =====================

    => dump
    Modified
    Number of entries: 0x0000004a
    Info type 0x00000001
      Address: [0x000000008315a000, 0x00000000831bafff]
      File: FvFile(D6A2CB7F-6A18-4E2F-B43B-9920A733700A)
      Handle: 0x000000017fe3cb18
    ...
    Info type 0x00000001
      Address: [0x000000017e8db000, 0x000000017ea00f3f]
      File: FvFile(7C04A583-9E3E-4F1C-AD65-E05268D0B4D1)
      Handle: 0x000000017f358e98
    Info type 0x00000001
      Address: [0x000000017eae5000, 0x000000017eae81ff]
      File: \dbginfodump.efi
      Handle: 0x000000017eaf0298
    =>

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Tolerate EDK II setting NormalImage = NULL for deleted entries.
	Update commit message.
	Add more code comments.
---
 lib/efi_loader/Makefile      |   1 +
 lib/efi_loader/dbginfodump.c | 356 +++++++++++++++++++++++++++++++++++
 2 files changed, 357 insertions(+)
 create mode 100644 lib/efi_loader/dbginfodump.c

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index cf050e5385d..0ff068b4307 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -21,6 +21,7 @@ ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 apps-y += dtbdump
 endif
 apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
+apps-y += dbginfodump
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
 obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
new file mode 100644
index 00000000000..adbbd5060cc
--- /dev/null
+++ b/lib/efi_loader/dbginfodump.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025, Heinrich Schuchardt <xypron.glpk@gmx.de>
+ *
+ * dbginfodump.efi prints out the content of the EFI_DEBUG_IMAGE_INFO_TABLE.
+ */
+
+#include <efi_api.h>
+
+/**
+ * BUFFER_SIZE - size of the command line input buffer
+ */
+#define BUFFER_SIZE 64
+
+static struct efi_simple_text_output_protocol *cerr;
+static struct efi_simple_text_output_protocol *cout;
+static struct efi_simple_text_input_protocol *cin;
+static efi_handle_t handle;
+static struct efi_system_table *systable;
+static struct efi_boot_services *bs;
+
+static efi_guid_t guid_device_path_to_text_protocol =
+	EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
+
+static struct efi_device_path_to_text_protocol *device_path_to_text;
+
+/* EFI_DEBUG_IMAGE_INFO_TABLE_GUID */
+static const efi_guid_t dbg_info_guid =
+	EFI_GUID(0x49152E77, 0x1ADA, 0x4764, 0xB7, 0xA2,
+		 0x7A, 0xFE, 0xFE, 0xD9, 0x5E, 0x8B);
+
+/* EFI_DEBUG_IMAGE_INFO_NORMAL */
+struct dbg_info {
+	u32 type;
+	struct efi_loaded_image *info;
+	efi_handle_t handle;
+};
+
+/* FI_DEBUG_IMAGE_INFO_TABLE_HEADER */
+struct dbg_info_header {
+	u32 status;
+	u32 size;
+	struct dbg_info **info;
+};
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
+ * error() - print error string
+ *
+ * @string:	error text
+ */
+static void error(u16 *string)
+{
+	cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
+	print(string);
+	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
+}
+
+/**
+ * printu() - print unsigned
+ *
+ * @val:	value to print
+ */
+static void printu(u32 val)
+{
+	u16 str[19] = u"0x";
+	u16 *ptr = &str[2];
+	u16 ch;
+
+	for (ssize_t i = 8 * sizeof(u32) - 4; i >= 0; i -= 4) {
+		ch = (val >> i & 0xf) + '0';
+		if (ch > '9')
+			ch += 'a' - '9' - 1;
+		*ptr++ = ch;
+	}
+	*ptr = 0;
+	print(str);
+}
+
+/**
+ * printp() - print pointer
+ *
+ * @p:	pointer
+ */
+static void printp(void *p)
+{
+	u16 str[19] = u"0x";
+	u16 *ptr = &str[2];
+	u16 ch;
+
+	for (ssize_t i = 8 * sizeof(void *) - 4; i >= 0; i -= 4) {
+		ch = ((uintptr_t)p >> i & 0xf) + '0';
+		if (ch > '9')
+			ch += 'a' - '9' - 1;
+		*ptr++ = ch;
+	}
+	*ptr = 0;
+	print(str);
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
+	for (; *keyword; ++string, ++keyword) {
+		if (*string != *keyword)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * do_help() - print help
+ */
+static void do_help(void)
+{
+	error(u"dump       - print debug info table\r\n");
+	error(u"exit       - exit the shell\r\n");
+}
+
+/**
+ * get_dbg_info_table() - get debug info table
+ *
+ * Return:	debug info table or NULL
+ */
+static void *get_dbg_info(void)
+{
+	void *dbg = NULL;
+	efi_uintn_t i;
+
+	for (i = 0; i < systable->nr_tables; ++i) {
+		if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
+			    sizeof(efi_guid_t))) {
+			dbg = systable->tables[i].table;
+			break;
+		}
+	}
+	return dbg;
+}
+
+/**
+ * print_info() - print loaded image protocol
+ */
+static void print_info(struct efi_loaded_image *info)
+{
+	print(u"  Address: [");
+	printp(info->image_base);
+	print(u", ");
+	printp(info->image_base + info->image_size - 1);
+	print(u"]\r\n");
+	if (device_path_to_text && info->file_path) {
+		u16 *string;
+
+		string = device_path_to_text->convert_device_path_to_text(
+					info->file_path, true, false);
+		if (!string) {
+			error(u"ConvertDevicePathToText failed");
+		} else {
+			print(u"  File: ");
+			print(string);
+		}
+		print(u"\r\n");
+	}
+}
+
+/**
+ * do_dump() - print debug info table
+ */
+static efi_status_t do_dump(void)
+{
+	struct dbg_info_header *dbg;
+	u32 count;
+
+	dbg = get_dbg_info();
+	if (!dbg) {
+		error(u"Debug info table not found\r\n");
+		return EFI_NOT_FOUND;
+	}
+	if (dbg->status & 0x01) {
+		error(u"Update in progress\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (dbg->status & 0x02)
+		print(u"Modified\r\n");
+	print(u"Number of entries: ");
+	printu(dbg->size);
+	print(u"\r\n");
+
+	count = dbg->size;
+	for (u32 i = 0; count; ++i) {
+		struct dbg_info *info = dbg->info[i];
+
+		/*
+		 * The EDK II implementation decreases the size field and
+		 * writes a NULL value when deleting an entry which is not
+		 * backed by the UEFI specification.
+		 */
+		if (!info) {
+			print(u"Deleted entry\r\n");
+			continue;
+		}
+		--count;
+		print(u"Info type ");
+		printu(info->type);
+		print(u"\r\n");
+		if (info->type != 1)
+			continue;
+		print_info(info->info);
+		print(u"  Handle: ");
+		printp(info->handle);
+		print(u"\r\n");
+	}
+
+	return EFI_SUCCESS;
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
+	efi_status_t ret;
+
+	handle = image_handle;
+	systable = systab;
+	cerr = systable->std_err;
+	cout = systable->con_out;
+	cin = systable->con_in;
+	bs = systable->boottime;
+
+	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
+	cout->clear_screen(cout);
+	cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
+	print(u"Debug Info Table Dump\r\n=====================\r\n\r\n");
+	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
+
+	ret = bs->locate_protocol(&guid_device_path_to_text_protocol,
+				  NULL, (void **)&device_path_to_text);
+	if (ret != EFI_SUCCESS)	{
+		error(u"No device path to text protocol\r\n");
+		device_path_to_text = NULL;
+	}
+
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
+		if (starts_with(pos, u"exit"))
+			break;
+		else if (starts_with(pos, u"dump"))
+			do_dump();
+		else
+			do_help();
+	}
+
+	cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
+	cout->clear_screen(cout);
+	return EFI_SUCCESS;
+}
-- 
2.48.1

