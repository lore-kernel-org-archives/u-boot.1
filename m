Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8BC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCE284979;
	Sun, 28 Jun 2026 10:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pNJy03A7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEE58490A; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9FF84866
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 291F4420B3; 
 Sun, 28 Jun 2026 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635293;
 bh=frKMc1b+9M2wpUe3xDSkqZ6GfIaZz80cQRlFqsymQ2M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pNJy03A7JMZzfd7rPaxvrL3ShN05r2NYJYYXm9537ST44nIbPtCZfkHMWrWXExUW1
 pBoesCLhFzz85ib/Ve5OIAzP9oJYEA9OOhViOTQMXb3tiIlaau5ZnSGOoHd+e4gaaL
 g6oi38jjcKTPVlcYX4xP0w7fn1lashy9Az1Di2zE4rRRQvK0H/ihjwLWWqEkhQYK+Y
 j8+6O0cV3tpdDImTQY7OoP7SDyq2dAdsX+NIt7HNWwFiOaO35072SVHbcWcsIfGGct
 1cKAgmzHojDxgHa7NI8AN2/ySLVbOcSvrO7eeMZ9SmnQgYTfN8gw1RtKgpb8Ya1bQB
 zYcegr0780FPmTmwfMuGJHN9KqPIHccQFMhFaPkG8OrrvK6vHIdEJshP+qwYxiFZb8
 4iAzhUJUT00QSZBuz9aW7IyPDpUvwwCApUKBpqbuwTC7IQ2W+ZpyZ3TNxMXY8qgcFl
 hvkBO6PNcApJmiMAn4bA4D1Xqj+oJPc3VYOaeEpz30WISBaL4CvOw9B73n4ke7ggeH
 koxJ2gpB05xhfOnRfYnDK8HJJ6PCGykhMz7mOZUvXxV+gHgILSD2z3uTlrEN2zEIGA
 pS3iQQkAisvFN5pVJAPekQXEjE52NOyky0PbBojiY0JpeNBPrfcElmRuYYQHIn5PEB
 sdC3gZxj6nHU3kqTb1fUbNqE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 02/11] efi_selftest: add ACPI configuration table test
Date: Sun, 28 Jun 2026 10:28:00 +0200
Message-ID: <20260628082810.175862-3-heinrich.schuchardt@canonical.com>
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

The new unit test checks if ACPI tables are available.

If yes, it checks if the RSDP correctly points to the RSDT or XSDT.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2:
	new patch
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

