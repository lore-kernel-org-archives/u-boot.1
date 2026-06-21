Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F2CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658B784A17;
	Sun, 21 Jun 2026 10:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hUaysfnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07346849F0; Sun, 21 Jun 2026 10:19:29 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CDC3849AC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0945A42075; 
 Sun, 21 Jun 2026 08:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029965;
 bh=fDL2LgwQET+DPwh+Iezs5PfAQJ7BD1KIweUTeHnzb5I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hUaysfnpOV07GkKogzu0+U3MmMOWkglwNR17UdyxHNvncnELTpu8yUp/mWfTUPfQi
 UVf4VjE4Qe67qhn/vTkSM6wEvlfmWNwKs3G3EcdReXYgORTSdGXnC2yeODSRF2DUXH
 i0ELLDULAQiGZZ9XP862PzCnHsGTi02h8P4PtJ6VTbQ9Paoxzs1hXyCIP2SZUrdWgo
 T4DOgfASvDuqlcVHnuGtIr5mQYkbYuokz/8EMVGwQKIpWhLmdgbYlMMw2gOQk+i2hc
 zbqGA16fSGNHOD093E/TSfGI0GFhQ/vKVBebJ2lsgAEmvP+gACXPBqOBR9p1VMU7Ww
 XZqIU3lJ7w1OK1ey8HQhQfZdZsnQDlgS6ZcqfPPlS4Z9qP2jqcOKovxj1yKFg07GGK
 QXs5nFH3pQSmZ8N7btUU294KX/b2ZSwyFs3+nPAY/bjqtaP2wFYDZCAERwYEjpPpdo
 ymQLmPkF5K3d9JsSyCdkN+wnGB3zPWv6aEo7LRWX7RIyL+U3rleCPch9w75RuQACmB
 /MqtfnZIlWnIT9/zbJasAMQ2aCzCons8VZN0ZIvQIRBn/Dp7ijFoSg8bQytPzauyKW
 Du3IlIknWTfaL/80Jem73Okr7CISHgyZIgOD2/42/8LfnzuGKEHWmWcoUnZIiPOUlt
 eT9Ez6+oFDtmxyMDFSkO7gy0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 11/11] efi_loader: add ACPI table dump EFI app
Date: Sun, 21 Jun 2026 10:19:15 +0200
Message-ID: <20260621081915.19154-12-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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
v2:
	Check checksums.
	Check both RSDT and XSDT if both exist.
---
 lib/efi_loader/Makefile   |   3 +-
 lib/efi_loader/acpidump.c | 563 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 565 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_loader/acpidump.c

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 94ad6721a70..b9a3433a0c5 100644
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
@@ -103,7 +104,7 @@ $(foreach f,$(apps-y) $(efi-obj-y),\
 	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
 
 # Link efi_app_common.o into each dump app
-$(obj)/dbginfodump_efi.so $(obj)/dtbdump_efi.so \
+$(obj)/acpidump_efi.so $(obj)/dbginfodump_efi.so $(obj)/dtbdump_efi.so \
 $(obj)/initrddump_efi.so $(obj)/smbiosdump_efi.so: $(obj)/efi_app_common.o
 
 always-y += $(foreach f,$(apps-y),$(f).efi)
diff --git a/lib/efi_loader/acpidump.c b/lib/efi_loader/acpidump.c
new file mode 100644
index 00000000000..3e5635fce5a
--- /dev/null
+++ b/lib/efi_loader/acpidump.c
@@ -0,0 +1,563 @@
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
+#include "efi_app_common.h"
+
+#define MAX_FILENAME_LENGTH	32
+
+u16 app_banner[] = u"ACPI Dump\r\n=========\r\n\r\n";
+
+struct acpi_dump_table {
+	char signature[5];
+	uintptr_t addr;
+	u32 len;
+};
+
+static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
+static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
+
+/**
+ * checksum_ok() - check if byte-sum of buffer is zero
+ *
+ * @buf:	buffer to check
+ * @len:	buffer length
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
+ * @src:	source address
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
+ * @src:	source address
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
+ * is_filename_char() - check if a signature byte is filename-safe
+ *
+ * @ch:	character to check
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
+ * append_uint_dec() - append decimal representation of integer to UTF-16 string
+ *
+ * @str:	destination UTF-16 string
+ * @pos:	current write position
+ * @size:	destination size in UTF-16 code units
+ * @val:	value to append
+ * Return:	updated write position
+ */
+static efi_uintn_t append_uint_dec(u16 *str, efi_uintn_t pos,
+				   efi_uintn_t size, u32 val)
+{
+	u16 tmp[11];
+	efi_uintn_t n = 0;
+	efi_uintn_t i;
+
+	if (!val)
+		tmp[n++] = u'0';
+	while (val && n < ARRAY_SIZE(tmp)) {
+		tmp[n++] = u'0' + val % 10;
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
+ * u32_to_utf16_dec() - convert unsigned integer to UTF-16 decimal string
+ *
+ * @dst:	destination UTF-16 buffer
+ * @dst_size:	destination size in UTF-16 code units
+ * @val:	value to convert
+ */
+static void u32_to_utf16_dec(u16 *dst, efi_uintn_t dst_size, u32 val)
+{
+	append_uint_dec(dst, 0, dst_size, val);
+}
+
+/**
+ * build_table_filename() - construct table filename
+ *
+ * @sig:	4-byte ACPI signature string
+ * @instance:	duplicate instance number (0 for first)
+ * @name:	output filename buffer (UTF-16)
+ * @name_size:	output filename buffer size in UTF-16 code units
+ */
+static void build_table_filename(const char *sig, u32 instance, u16 *name,
+				 efi_uintn_t name_size)
+{
+	efi_uintn_t pos = 0;
+	int i;
+
+	if (!name_size)
+		return;
+
+	for (i = 0; i < 4 && pos + 1 < name_size; ++i)
+		name[pos++] = is_filename_char(sig[i]) ? (u16)sig[i] : u'_';
+
+	if (instance)
+		pos = append_uint_dec(name, pos, name_size, instance);
+
+	if (pos + 4 < name_size) {
+		name[pos++] = u'.';
+		name[pos++] = u'd';
+		name[pos++] = u'a';
+		name[pos++] = u't';
+	}
+	name[pos] = 0;
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
+ * @tables:	table array
+ * @table_count:	current table count
+ * @addr:	table address
+ * @len:	table length
+ * @sig:	4-character ACPI signature
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
+ * @tables:	table array
+ * @table_count:	number of used entries
+ * @addr:	table address to search
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
+ * @tablesp:	output table array
+ * @table_count:	output table count
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
+	if (!rsdp) {
+		error(u"No ACPI configuration table\r\n");
+		return EFI_NOT_FOUND;
+	}
+	print(u"RSDP address: 0x");
+	printx((uintptr_t)rsdp, 2 * sizeof(void *));
+	print(u"\r\n");
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
+			if (len >= offsetof(struct acpi_fadt, x_dsdt) +
+				    sizeof(fadt->x_dsdt))
+				dsdt_addr = read_u64(&fadt->x_dsdt);
+			else
+				dsdt_addr = 0;
+			if (!dsdt_addr)
+				dsdt_addr = read_u32(&fadt->dsdt);
+			if (dsdt_addr && !has_table_addr(tables, *table_count,
+						      dsdt_addr)) {
+				struct acpi_table_header *dsdt;
+				u32 dsdt_len;
+
+				dsdt = (struct acpi_table_header *)dsdt_addr;
+				if (memcmp(dsdt->signature, "DSDT", 4)) {
+					error(u"Invalid DSDT signature\r\n");
+					ret = EFI_LOAD_ERROR;
+					goto err_out;
+				}
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
+			if (len >= offsetof(struct acpi_fadt, x_firmware_ctrl) +
+				    sizeof(fadt->x_firmware_ctrl))
+				facs_addr = read_u64(&fadt->x_firmware_ctrl);
+			else
+				facs_addr = 0;
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
+ * do_check() - parse ACPI tables and report success/failure
+ *
+ * @args:	unused command arguments
+ */
+static void do_check(u16 * __maybe_unused args)
+{
+	struct acpi_dump_table *tables;
+	u32 table_count;
+	u16 num[11] = {0};
+	efi_status_t ret;
+
+	ret = collect_tables(&tables, &table_count);
+	if (ret != EFI_SUCCESS)
+		return;
+
+	u32_to_utf16_dec(num, ARRAY_SIZE(num), table_count);
+
+	print(u"ACPI tables found: ");
+	print(num);
+	print(u"\r\n");
+
+	bs->free_pool(tables);
+	print(u"OK\r\n");
+}
+
+/**
+ * do_write() - ask filename and save ACPI table set
+ *
+ * @args:	unused command arguments
+ */
+static void do_write(u16 * __maybe_unused args)
+{
+	struct acpi_dump_table *tables;
+	u16 filename[MAX_FILENAME_LENGTH];
+	u32 table_count;
+	u32 i;
+	efi_status_t ret;
+
+	ret = collect_tables(&tables, &table_count);
+	if (ret != EFI_SUCCESS)
+		return;
+	if (!table_count) {
+		print(u"No ACPI tables found\r\n");
+		bs->free_pool(tables);
+		return;
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
+		build_table_filename(tables[i].signature, instance, filename,
+				     ARRAY_SIZE(filename));
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
+		if (ret == EFI_ACCESS_DENIED)
+			continue;
+		if (ret != EFI_SUCCESS)
+			break;
+	}
+
+	bs->free_pool(tables);
+}
+
+struct efi_app_cmd app_cmds[] = {
+	{ u"check", u"check - parse ACPI table list\r\n", do_check },
+	{ u"write", u"write - save one file per ACPI table\r\n", do_write },
+	{ }
+};
-- 
2.53.0

