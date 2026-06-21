Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BAECD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52599849BA;
	Sun, 21 Jun 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fuS1xTH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D98A849ED; Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FFB8499C
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BF45242081; 
 Sun, 21 Jun 2026 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029961;
 bh=+6gOZUozGJt9mdiNwP01DiGXx0p9Hhwv9VvP/xzz7Yo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fuS1xTH0bW9LTx+lhVIFgc92zRzpvFZ4jkCXFx2ToUJ0MLCcxq3G+SrinOzSVwB7V
 2ZtH/GILr3bi8mi/yueCeJxRZoZHsyQoLg6371IHvPYmVSlQtM+yZ81ZfvK8XXA1jG
 iutX1YBrngDLVucNI7F+N7dt4rZ9pNQCpeftJkOLg9iQ6YeSeaDLNgNj98v/n4FvZy
 Q6sT0NeiNfENWCeaYDfKp2lIyJk/5pFzZk1zIRXXRhmX9QKOQK3sIE+JHvjY0IxuDZ
 USc7vh4GXxHqwuas6KsT4h3ouTmtXf9NZpKXchtfFBXomRkaMspnQATmK+4+rORCpE
 AXwvHaZxBUsvVL7m4HX5tJPYnB64sZMBn1A16SyKCMLzzRx0Nsiv0jt37WyP7C8yEN
 vz53+8H5Yp4zYmIQWd5pkgf0XfGLACuuoRge7r7Fc9ByWjnWoVIQsHzg/YclsxYP0x
 djUhu+FuXHoZv/fZ5L486z1DVm5oIVBRexucaziKmINC8u6ZfiTkm4cW+KctEJ0z9S
 z2wD62o0rDohgSpH8vsn35SlWxuSYObFZ8++ml4MDzHC81jDr0Y8z8RGTbFcXOrD4p
 483bnQdvkp9O27eWXz500ZXZxE7Knt2eIUpPObQ6sUP+tusx3CtfVLaHGEA5qJmW8s
 nQh6bAylR2opOWIRgEmhSnzE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 02/11] efi_selftest: add ACPI configuration table test
Date: Sun, 21 Jun 2026 10:19:06 +0200
Message-ID: <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
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

The new unit test checks if ACPI tables are available.

If yes, it checks if the RSDP correctly points to the RSDT or XSDT.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Correct commit message %s/RSDT/RSDP/.
	Check checksums.
	Add a 'skipped' message.
---
 lib/efi_selftest/Makefile            |   1 +
 lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_acpi.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 67102648703..c6cc2430bbf 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -17,6 +17,7 @@ CFLAGS_REMOVE_efi_selftest_miniapp_return.o := $(CFLAGS_NON_EFI)
 
 obj-y += \
 efi_selftest.o \
+efi_selftest_acpi.o \
 efi_selftest_bitblt.o \
 efi_selftest_config_table.o \
 efi_selftest_controllers.o \
diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
new file mode 100644
index 00000000000..94cf5c00484
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_acpi.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_acpi
+ *
+ * Copyright 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ *
+ * Check ACPI configuration table availability and root table presence.
+ */
+
+#include <efi_selftest.h>
+#include <acpi/acpi_table.h>
+
+static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
+static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
+
+/**
+ * checksum_ok() - check if byte-sum of buffer is zero
+ *
+ * @buf:	buffer to check
+ * @len:	buffer length
+ * Return:	true if checksum is valid
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
+ * check_rsdp() - validate RSDP signature, checksum and root table pointer
+ *
+ * @rsdp:	RSDP to validate
+ * Return:	EFI_ST_SUCCESS or EFI_ST_FAILURE
+ */
+static int check_rsdp(struct acpi_rsdp *rsdp)
+{
+	struct acpi_table_header *table;
+	u32 rsdt_addr32;
+	u64 xsdt_addr64;
+	uintptr_t rsdt_addr;
+	uintptr_t xsdt_addr;
+	u32 rsdp_len;
+
+	if (memcmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature))) {
+		efi_st_error("Wrong RSDP signature\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (!checksum_ok(rsdp, 20)) {
+		efi_st_error("Invalid RSDP checksum\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0) {
+		rsdp_len = rsdp->length;
+		if (rsdp_len < sizeof(*rsdp)) {
+			efi_st_error("Invalid ACPI 2.0 RSDP length\n");
+			return EFI_ST_FAILURE;
+		}
+		if (!checksum_ok(rsdp, rsdp_len)) {
+			efi_st_error("Invalid RSDP extended checksum\n");
+			return EFI_ST_FAILURE;
+		}
+	}
+
+	memcpy(&rsdt_addr32, &rsdp->rsdt_address, sizeof(rsdt_addr32));
+	rsdt_addr = rsdt_addr32;
+
+	xsdt_addr64 = 0;
+	if (rsdp->revision >= ACPI_RSDP_REV_ACPI_2_0)
+		memcpy(&xsdt_addr64, &rsdp->xsdt_address, sizeof(xsdt_addr64));
+	xsdt_addr = xsdt_addr64;
+
+	if (!rsdt_addr && !xsdt_addr) {
+		efi_st_error("Neither RSDT nor XSDT address is set\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (xsdt_addr) {
+		table = (struct acpi_table_header *)xsdt_addr;
+		if (!memcmp(table->signature, "XSDT", 4))
+			return EFI_ST_SUCCESS;
+		efi_st_error("XSDT address does not point to XSDT\n");
+	}
+
+	if (rsdt_addr) {
+		table = (struct acpi_table_header *)rsdt_addr;
+		if (!memcmp(table->signature, "RSDT", 4))
+			return EFI_ST_SUCCESS;
+		efi_st_error("RSDT address does not point to RSDT\n");
+	}
+
+	return EFI_ST_FAILURE;
+}
+
+/**
+ * efi_st_acpi_execute() - execute ACPI selftest
+ *
+ * Return: status code
+ */
+static int efi_st_acpi_execute(void)
+{
+	struct acpi_rsdp *rsdp2, *rsdp1;
+	int ret;
+
+	rsdp2 = efi_st_get_config_table(&acpi2_guid);
+	rsdp1 = efi_st_get_config_table(&acpi1_guid);
+
+	if (!rsdp2 && !rsdp1) {
+		efi_st_printf("No ACPI configuration table, test skipped\n");
+		return EFI_ST_SUCCESS;
+	}
+
+	if (rsdp2) {
+		ret = check_rsdp(rsdp2);
+		if (ret != EFI_ST_SUCCESS)
+			return ret;
+	}
+
+	if (rsdp1) {
+		ret = check_rsdp(rsdp1);
+		if (ret != EFI_ST_SUCCESS)
+			return ret;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(acpi) = {
+	.name = "acpi",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.execute = efi_st_acpi_execute,
+};
-- 
2.53.0

