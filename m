Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942C0CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DE38484F;
	Thu, 21 May 2026 20:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="B4+HgUqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63ED98484F; Thu, 21 May 2026 20:50:35 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F76884855
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-111-011.46.114.pool.telefonica.de
 [46.114.111.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5E15241798; 
 Thu, 21 May 2026 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779389431;
 bh=kThstIrJMD4oz03P0XrEIRvOzxZ+Z082uLKq+rX+xTc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=B4+HgUqfVW1Ql/s5FEWidvy3H4ot5najiZ4cS7yirEgeuHnrW8AbtNzIRnZc893at
 q+is/AKQxQobU8SrWsTRFXKYOirFi5M7BzXoYfyEYyPlJJNaJZhXC1XhGKANh/BKtb
 sBT76ph+7aw1OyTDkLe6rRYocIa/1YcObaUt4rWtQY6At8D7Jpnrn6/Hv9nD16OAkv
 gctHJYuUUV9flM9vOzl0+41ljsVyYr7AYjrCLLibUd46d3PokFWxIACSjSJfcmNXTP
 ppeOTmevKKT9IVe8G2YusGmC6sW4xFSGduTw+gxJO+W4Pd1N2X/fZ52gR7U6So5LpU
 cW0RHGWspjeWDAmvzrrLKzufMOEvj9ppmZo/NvyMHWbERuX7iC+S751EUCsQ4vJe9N
 iAdBHU7Q0dj40aVr3KXg67WV4p1LsYffvMkp/z1jdJvitkL7yGsKkXZu5dzauQd/Kt
 5WdxDV7bBPoO4kExaX0g8gAc3Ob81Oid36xx8Nb+TKqCqHe1U6+NmcIRTAelqNPpGm
 Ai1ihstdkGJ2JselSsMMi2EPAUyZMykUYxi25ZlnQTp3PBW6CrOARun8IFOzzbqdpF
 t4F9z7yS2dx0HAbz+QIOI/i+IF8gwyu9XB6oH0tnNVyioBWx92P0EnXx3OVAZxp7FB
 ZnPSwXKJSex7EY25HF4GBKeI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] efi_loader: add ACPI table dump EFI app
Date: Thu, 21 May 2026 20:50:25 +0200
Message-ID: <20260521185025.30857-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
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

Provide an EFI binary that can dump all ACPI tables to files
<table_name>.dat. These can then be further analyzed by decompiling
with iasl.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Makefile   |   1 +
 lib/efi_loader/acpidump.c | 999 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1000 insertions(+)
 create mode 100644 lib/efi_loader/acpidump.c

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d73ad43951b..118566ee7ef 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -16,6 +16,7 @@ CFLAGS_efi_boottime.o += \
 apps-$(CONFIG_RISCV) += boothart
 apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) += helloworld
 apps-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbiosdump
+apps-$(CONFIG_GENERATE_ACPI_TABLE) += acpidump
 apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
 apps-y += dtbdump
diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
new file mode 100644
index 00000000000..0bc3770c85d
--- /dev/null
+++ b/lib/efi_loader/acpidump.c
@@ -0,0 +1,999 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * acpidump.efi saves the ACPI table set as file.
+ *
+ * Specifying 'nocolor' as load option data suppresses colored output and
+ * clearing of the screen.
+ */
+
+#include <efi_api.h>
+#include <part.h>
+#include <string.h>
+#include <acpi/acpi_table.h>
+
+#define BUFFER_SIZE 64
+
+struct acpi_dump_table {
+	char signature[5];
+	uintptr_t addr;
+	u32 len;
+};
+
+static struct efi_simple_text_output_protocol *cout;
+static struct efi_simple_text_input_protocol *cin;
+static struct efi_boot_services *bs;
+static efi_handle_t handle;
+static struct efi_system_table *systable;
+static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
+static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
+static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
+static const efi_guid_t guid_simple_file_system_protocol =
+					EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
+static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
+static bool nocolor;
+
+/**
+ * checksum_ok() - check if byte-sum of buffer is zero
+ *
+ * @buf:      buffer to check
+ * @len:      buffer length
+ * Return:    true if checksum is valid
+ */
+static bool checksum_ok(const void *buf, efi_uintn_t len)
+{
+	const u8 *pos = buf;
+	u8 sum = 0;
+
+	for (; len; --len, ++pos)
+		sum += *pos;
+
+	return !sum;
+}
+
+/**
+ * read_u32() - read 32-bit value via memcpy
+ *
+ * @src: source address
+ * Return: value
+ */
+static u32 read_u32(const void *src)
+{
+	u32 val;
+
+	memcpy(&val, src, sizeof(val));
+
+	return val;
+}
+
+/**
+ * read_u64() - read 64-bit value via memcpy
+ *
+ * @src: source address
+ * Return: value
+ */
+static u64 read_u64(const void *src)
+{
+	u64 val;
+
+	memcpy(&val, src, sizeof(val));
+
+	return val;
+}
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
+ * is_filename_char() - check if a signature byte is filename-safe
+ *
+ * @ch: character to check
+ * Return: true if filename-safe
+ */
+static bool is_filename_char(char ch)
+{
+	return (ch >= 'A' && ch <= 'Z') ||
+	       (ch >= 'a' && ch <= 'z') ||
+	       (ch >= '0' && ch <= '9') || ch == '_';
+}
+
+/**
+ * ascii_to_utf16() - convert ASCII string to UTF-16
+ *
+ * @dst: destination UTF-16 buffer
+ * @dst_size: destination size in UTF-16 code units
+ * @src: source ASCII string
+ */
+static void ascii_to_utf16(u16 *dst, efi_uintn_t dst_size, const char *src)
+{
+	efi_uintn_t i;
+
+	if (!dst_size)
+		return;
+
+	for (i = 0; i < dst_size - 1 && src[i]; ++i)
+		dst[i] = (u8)src[i];
+	dst[i] = 0;
+}
+
+/**
+ * append_uint_dec() - append unsigned decimal number to C string
+ *
+ * @str: destination string
+ * @pos: current write position
+ * @size: destination size
+ * @val: value to append
+ * Return: updated write position
+ */
+static efi_uintn_t append_uint_dec(char *str, efi_uintn_t pos,
+				   efi_uintn_t size, u32 val)
+{
+	char tmp[11];
+	efi_uintn_t n = 0;
+	efi_uintn_t i;
+
+	if (!val)
+		tmp[n++] = '0';
+	while (val && n < ARRAY_SIZE(tmp)) {
+		tmp[n++] = '0' + val % 10;
+		val /= 10;
+	}
+
+	for (i = 0; i < n && pos + 1 < size; ++i)
+		str[pos++] = tmp[n - i - 1];
+
+	if (pos < size)
+		str[pos] = 0;
+
+	return pos;
+}
+
+/**
+ * u32_to_utf16_dec() - convert unsigned integer to UTF-16 decimal
+ *
+ * @dst: destination UTF-16 buffer
+ * @dst_size: destination size in UTF-16 code units
+ * @val: value to convert
+ */
+static void u32_to_utf16_dec(u16 *dst, efi_uintn_t dst_size, u32 val)
+{
+	char ascii[11] = {0};
+
+	append_uint_dec(ascii, 0, sizeof(ascii), val);
+	ascii_to_utf16(dst, dst_size, ascii);
+}
+
+/**
+ * build_table_filename() - construct table filename
+ *
+ * @sig: 4-byte ACPI signature string
+ * @instance: duplicate instance number (0 for first)
+ * @name: output filename buffer
+ * @name_size: output filename buffer size
+ */
+static void build_table_filename(const char *sig, u32 instance, char *name,
+				 efi_uintn_t name_size)
+{
+	efi_uintn_t pos = 0;
+	int i;
+
+	if (!name_size)
+		return;
+
+	for (i = 0; i < 4 && pos + 1 < name_size; ++i)
+		name[pos++] = is_filename_char(sig[i]) ? sig[i] : '_';
+
+	if (instance)
+		pos = append_uint_dec(name, pos, name_size, instance);
+
+	if (pos + 4 < name_size) {
+		name[pos++] = '.';
+		name[pos++] = 'd';
+		name[pos++] = 'a';
+		name[pos++] = 't';
+	}
+	name[pos] = 0;
+}
+
+/**
+ * printp() - print pointer
+ *
+ * @p: pointer
+ */
+static void printp(void *p)
+{
+	u16 str[2 + 2 * sizeof(void *) + 1] = u"0x";
+	u16 *ptr = &str[2];
+	u16 ch;
+	int i;
+
+	for (i = 8 * sizeof(void *) - 4; i >= 0; i -= 4) {
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
+		return false;
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
+	if (handle_buffer)
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
+	error(u"check - parse ACPI table list\r\n");
+	error(u"write - save one file per ACPI table\r\n");
+	error(u"exit  - exit the shell\r\n");
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
+		if (!memcmp(guid, &systable->tables[i].guid, sizeof(*guid)))
+			return systable->tables[i].table;
+	}
+
+	return NULL;
+}
+
+/**
+ * get_acpi_rsdp_addr() - find ACPI RSDP via EFI config table GUID
+ *
+ * Return:	pointer to RSDP or NULL
+ */
+static struct acpi_rsdp *get_acpi_rsdp_addr(void)
+{
+	struct acpi_rsdp *rsdp;
+
+	rsdp = get_config_table(&acpi2_guid);
+	if (rsdp)
+		return rsdp;
+
+	rsdp = get_config_table(&acpi1_guid);
+
+	return rsdp;
+}
+
+/**
+ * add_table() - append one ACPI table entry
+ *
+ * @tables: table array
+ * @table_count: current table count
+ * @addr: table address
+ * @len: table length
+ * @sig: 4-character ACPI signature
+ * Return:	status code
+ */
+static efi_status_t add_table(struct acpi_dump_table *tables, u32 *table_count,
+			      uintptr_t addr, u32 len, const char *sig)
+{
+	struct acpi_dump_table *table = &tables[*table_count];
+
+	memset(table, 0, sizeof(*table));
+	memcpy(table->signature, sig, 4);
+	table->addr = addr;
+	table->len = len;
+	++*table_count;
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * has_table_addr() - check if a table address is already in the list
+ *
+ * @tables: table array
+ * @table_count: number of used entries
+ * @addr: table address to search
+ * Return: true if found
+ */
+static bool has_table_addr(struct acpi_dump_table *tables, u32 table_count,
+			   uintptr_t addr)
+{
+	u32 i;
+
+	for (i = 0; i < table_count; ++i) {
+		if (tables[i].addr == addr)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * collect_tables() - parse ACPI table structure and collect ACPI tables
+ *
+ * @tablesp: output table array
+ * @table_count: output table count
+ * Return:	status code
+ */
+static efi_status_t collect_tables(struct acpi_dump_table **tablesp,
+				   u32 *table_count)
+{
+	struct acpi_rsdp *rsdp;
+	struct acpi_table_header *root;
+	struct acpi_dump_table *tables;
+	uintptr_t root_addr;
+	u32 rsdp_len, root_len, max_tables;
+	u32 i, entries, entry_size;
+	bool use_xsdt;
+	efi_status_t ret;
+
+	rsdp = get_acpi_rsdp_addr();
+	print(u"RSDP address: ");
+	printp(rsdp);
+	print(u"\r\n");
+	if (!rsdp) {
+		error(u"No ACPI configuration table\r\n");
+		return EFI_NOT_FOUND;
+	}
+
+	if (memcmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature))) {
+		error(u"Invalid RSDP signature\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (!checksum_ok(rsdp, 20)) {
+		error(u"Invalid RSDP checksum\r\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	rsdp_len = rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0 ?
+		read_u32(&rsdp->length) : 20;
+	if (rsdp_len < 20) {
+		error(u"Invalid RSDP length\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0) {
+		if (rsdp_len < sizeof(struct acpi_rsdp)) {
+			error(u"Invalid ACPI 2.0 RSDP length\r\n");
+			return EFI_LOAD_ERROR;
+		}
+		if (!checksum_ok(rsdp, rsdp_len)) {
+			error(u"Invalid ACPI 2.0 RSDP checksum\r\n");
+			return EFI_LOAD_ERROR;
+		}
+	}
+
+	if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0 &&
+	    read_u64(&rsdp->xsdt_address)) {
+		root_addr = read_u64(&rsdp->xsdt_address);
+		use_xsdt = true;
+	} else {
+		root_addr = read_u32(&rsdp->rsdt_address);
+		use_xsdt = false;
+	}
+
+	if (!root_addr) {
+		error(u"Invalid RSDT/XSDT address\r\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	root = (struct acpi_table_header *)root_addr;
+	root_len = read_u32(&root->length);
+	if (root_len < sizeof(*root)) {
+		error(u"Invalid RSDT/XSDT length\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (use_xsdt && memcmp(root->signature, "XSDT", 4)) {
+		error(u"Invalid XSDT signature\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (!use_xsdt && memcmp(root->signature, "RSDT", 4)) {
+		error(u"Invalid RSDT signature\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	if (!checksum_ok(root, root_len)) {
+		error(u"Invalid RSDT/XSDT checksum\r\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	entry_size = use_xsdt ? sizeof(u64) : sizeof(u32);
+	if ((root_len - sizeof(*root)) % entry_size) {
+		error(u"Invalid RSDT/XSDT entry list\r\n");
+		return EFI_LOAD_ERROR;
+	}
+	entries = (root_len - sizeof(*root)) / entry_size;
+	/* RSDP + root + each root entry + up to DSDT/FACS per entry */
+	max_tables = 2 + 3 * entries;
+
+	ret = bs->allocate_pool(EFI_LOADER_DATA,
+			       max_tables * sizeof(struct acpi_dump_table),
+			       (void **)&tables);
+	if (ret != EFI_SUCCESS) {
+		error(u"Out of memory\r\n");
+		return ret;
+	}
+	*table_count = 0;
+
+	ret = add_table(tables, table_count, (uintptr_t)rsdp, rsdp_len, "RSDP");
+	if (ret != EFI_SUCCESS)
+		goto err_out;
+
+	ret = add_table(tables, table_count, root_addr, root_len, root->signature);
+	if (ret != EFI_SUCCESS)
+		goto err_out;
+
+	for (i = 0; i < entries; ++i) {
+		uintptr_t addr;
+		struct acpi_table_header *table;
+		u32 len;
+
+		if (use_xsdt) {
+			u64 *entry = (u64 *)((u8 *)root + sizeof(*root));
+
+			addr = read_u64(&entry[i]);
+		} else {
+			u32 *entry = (u32 *)((u8 *)root + sizeof(*root));
+
+			addr = read_u32(&entry[i]);
+		}
+		if (!addr)
+			continue;
+		if (has_table_addr(tables, *table_count, addr))
+			continue;
+
+		table = (struct acpi_table_header *)addr;
+		len = read_u32(&table->length);
+		if (len < sizeof(*table)) {
+			error(u"Invalid ACPI table length\r\n");
+			ret = EFI_LOAD_ERROR;
+			goto err_out;
+		}
+		if (!checksum_ok(table, len)) {
+			error(u"Invalid ACPI table checksum\r\n");
+			ret = EFI_LOAD_ERROR;
+			goto err_out;
+		}
+
+		ret = add_table(tables, table_count, addr, len, table->signature);
+		if (ret != EFI_SUCCESS)
+			goto err_out;
+
+		/*
+		 * FADT (signature FACP) references DSDT and FACS outside RSDT/XSDT.
+		 * Include them so output matches acpidump -b style completeness.
+		 */
+		if (!memcmp(table->signature, "FACP", 4)) {
+			struct acpi_fadt *fadt = (struct acpi_fadt *)table;
+			uintptr_t dsdt_addr;
+			uintptr_t facs_addr;
+
+			dsdt_addr = read_u64(&fadt->x_dsdt);
+			if (!dsdt_addr)
+				dsdt_addr = read_u32(&fadt->dsdt);
+			if (dsdt_addr && !has_table_addr(tables, *table_count,
+						      dsdt_addr)) {
+				struct acpi_table_header *dsdt;
+				u32 dsdt_len;
+
+				dsdt = (struct acpi_table_header *)dsdt_addr;
+				dsdt_len = read_u32(&dsdt->length);
+				if (dsdt_len < sizeof(*dsdt)) {
+					error(u"Invalid DSDT length\r\n");
+					ret = EFI_LOAD_ERROR;
+					goto err_out;
+				}
+				if (!checksum_ok(dsdt, dsdt_len)) {
+					error(u"Invalid DSDT checksum\r\n");
+					ret = EFI_LOAD_ERROR;
+					goto err_out;
+				}
+
+				ret = add_table(tables, table_count, dsdt_addr, dsdt_len,
+						dsdt->signature);
+				if (ret != EFI_SUCCESS)
+					goto err_out;
+			}
+
+			facs_addr = read_u64(&fadt->x_firmware_ctrl);
+			if (!facs_addr)
+				facs_addr = read_u32(&fadt->firmware_ctrl);
+			if (facs_addr && !has_table_addr(tables, *table_count,
+						      facs_addr)) {
+				struct acpi_facs *facs;
+				u32 facs_len;
+
+				facs = (struct acpi_facs *)facs_addr;
+				if (memcmp(facs->signature, "FACS", 4)) {
+					error(u"Invalid FACS signature\r\n");
+					ret = EFI_LOAD_ERROR;
+					goto err_out;
+				}
+				facs_len = read_u32(&facs->length);
+				if (facs_len < sizeof(*facs)) {
+					error(u"Invalid FACS length\r\n");
+					ret = EFI_LOAD_ERROR;
+					goto err_out;
+				}
+				ret = add_table(tables, table_count, facs_addr, facs_len,
+						facs->signature);
+				if (ret != EFI_SUCCESS)
+					goto err_out;
+			}
+		}
+	}
+
+	*tablesp = tables;
+
+	return EFI_SUCCESS;
+
+err_out:
+	bs->free_pool(tables);
+	return ret;
+}
+
+/**
+ * save_file() - save file to EFI system partition
+ *
+ * @filename:	file name
+ * @buf:	buffer to write
+ * @size:	size of the buffer
+ */
+static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
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
+ * do_check() - parse ACPI tables and report success/failure
+ *
+ * Return:	status code
+ */
+static efi_status_t do_check(void)
+{
+	struct acpi_dump_table *tables;
+	u32 table_count;
+	u16 num[11] = {0};
+	efi_status_t ret;
+
+	ret = collect_tables(&tables, &table_count);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	if (!table_count) {
+		print(u"No ACPI tables found\r\n");
+		return EFI_NOT_FOUND;
+	}
+
+	u32_to_utf16_dec(num, ARRAY_SIZE(num), table_count);
+
+	print(u"ACPI tables found: ");
+	print(num);
+	print(u"\r\n");
+
+	bs->free_pool(tables);
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * do_write() - ask filename and save ACPI table set
+ *
+ * Return:	status code
+ */
+static efi_status_t do_write(void)
+{
+	struct acpi_dump_table *tables;
+	u16 filename[BUFFER_SIZE];
+	char ascii_name[BUFFER_SIZE];
+	u32 table_count;
+	u32 i;
+	efi_status_t ret;
+
+	ret = collect_tables(&tables, &table_count);
+	if (ret != EFI_SUCCESS)
+		return ret;
+	if (!table_count) {
+		print(u"No ACPI tables found\r\n");
+		bs->free_pool(tables);
+		return EFI_NOT_FOUND;
+	}
+
+	for (i = 0; i < table_count; ++i) {
+		u8 *buf;
+		u32 instance = 0;
+		u32 same_type = 0;
+		u32 j;
+
+		for (j = 0; j < table_count; ++j) {
+			if (!memcmp(tables[i].signature, tables[j].signature, 4))
+				++same_type;
+		}
+
+		if (same_type > 1) {
+			/* Number duplicates starting at 1 for the first instance. */
+			for (j = 0; j <= i; ++j) {
+				if (!memcmp(tables[i].signature, tables[j].signature, 4))
+					++instance;
+			}
+		}
+
+		build_table_filename(tables[i].signature, instance, ascii_name,
+				     ARRAY_SIZE(ascii_name));
+		ascii_to_utf16(filename, ARRAY_SIZE(filename), ascii_name);
+
+		ret = bs->allocate_pool(EFI_LOADER_DATA, tables[i].len,
+				       (void **)&buf);
+		if (ret != EFI_SUCCESS) {
+			error(u"Out of memory\r\n");
+			break;
+		}
+
+		memcpy(buf, (void *)tables[i].addr, tables[i].len);
+		ret = save_file(filename, buf, tables[i].len);
+		if (ret == EFI_SUCCESS) {
+			print(filename);
+			print(u" written\r\n");
+		}
+
+		bs->free_pool(buf);
+		if (ret != EFI_SUCCESS)
+			break;
+	}
+
+	bs->free_pool(tables);
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
+ * command_loop() - process user commands
+ */
+static void command_loop(void)
+{
+	for (;;) {
+		u16 command[BUFFER_SIZE];
+		u16 *pos;
+		efi_status_t ret;
+
+		print(u"=> ");
+		ret = efi_input(command, ARRAY_SIZE(command));
+		if (ret == EFI_ABORTED)
+			break;
+		pos = skip_whitespace(command);
+		if (starts_with(pos, u"exit")) {
+			break;
+		} else if (starts_with(pos, u"check")) {
+			ret = do_check();
+			if (ret == EFI_SUCCESS)
+				print(u"OK\r\n");
+		} else if (starts_with(pos, u"write")) {
+			do_write();
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
+	print(u"ACPI Dump\r\n=========\r\n\r\n");
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
2.53.0

