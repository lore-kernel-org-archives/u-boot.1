Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3668BCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BAF84852;
	Thu, 21 May 2026 20:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XMs6wjaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFD48484F; Thu, 21 May 2026 20:50:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58258484F
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-111-011.46.114.pool.telefonica.de
 [46.114.111.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CAC6441796; 
 Thu, 21 May 2026 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779389431;
 bh=+l94JzR93GGCD/3YRDU7loUi1kyB7LdPuix7NFqgXKA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XMs6wjaPAx2rb568H8OkQ3uAbX2ZtHZwGJgsRFPxrPhd8By01VYx+DpsMaJxfKESF
 e2i9lpBB+QAS8mhA1iyX2mM2P1U3Q9XHt76mvjvDmLGmv870hjKq8INyJQjcKNqnDU
 L+bm/FW0tZa69PNXczmthWKcsDGJvKBWyhbbJ74dc49jGZvxeJ6gJs+OX7pHgGaNcW
 enFruoEXTK7kbvxt+TvqtEfQIxbEZIM5s07RBdCzQurbNfIMEryVvM1HRZZyT8+803
 DxOA5wn/Qd3OTpsmoQZBB6mkJSkb0mKC5u0FAln1eK3NJqLhPR8b5Je+mbeGPqz2G3
 66FfAu7G8rfK7hpFHYO+AZYge09l2kHEk5ni/8zToIUUyKbz5mP9Gal1gcTCXCYTNM
 XDocixmmreEE4OCCcGWpKpdIyaC1PqJbQYLxJiyRGvgQhtzxHpdN83u9Wbvp01R/tn
 Cw+JczsuO8dw7ACCbNE2TExv86G7EDyKdPHWtDDVtF0AuOpUTEt9701RiMQyUHtpE3
 1mdO8cRd0+0JdvKiZLKbaq2N8EsiynRxQppXYVlMJcqg3hqPuM/ExUXDEJPhL4BM0G
 KM3qodZLtl1N1QU12cSemtKqjEFwPX4S8ybtxpucKXIxs5VDyY6QggQ7em83TsdYL/
 e1UP4bQv7LC+AD/jyosu/NJQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] efi_selftest: add ACPI configuration table test
Date: Thu, 21 May 2026 20:50:24 +0200
Message-ID: <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
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

The new unit tests checks if ACPI tables are available.

If yes, it checks if the RSDT correctly points to the RSDT or XSDT.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/Makefile            |  1 +
 lib/efi_selftest/efi_selftest_acpi.c | 75 ++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 00000000000..ee91c1fd120
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_acpi.c
@@ -0,0 +1,75 @@
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
+ * efi_st_acpi_execute() - execute ACPI selftest
+ *
+ * Return: status code
+ */
+static int efi_st_acpi_execute(void)
+{
+	struct acpi_rsdp *rsdp;
+	struct acpi_table_header *table;
+	u32 rsdt_addr32;
+	u64 xsdt_addr64;
+	uintptr_t rsdt_addr;
+	uintptr_t xsdt_addr;
+
+	rsdp = efi_st_get_config_table(&acpi2_guid);
+	if (!rsdp)
+		rsdp = efi_st_get_config_table(&acpi1_guid);
+	if (!rsdp)
+		return EFI_ST_SUCCESS;
+
+	if (memcmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature))) {
+		efi_st_error("Wrong RSDP signature\n");
+		return EFI_ST_FAILURE;
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
+EFI_UNIT_TEST(acpi) = {
+	.name = "acpi",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.execute = efi_st_acpi_execute,
+};
-- 
2.53.0

