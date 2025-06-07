Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A63C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 11:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB3782AF6;
	Sat,  7 Jun 2025 13:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="geKbP93h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503F8807B1; Sat,  7 Jun 2025 13:49:38 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1919582AA7
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 13:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 192D74B66C; 
 Sat,  7 Jun 2025 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749296972;
 bh=nkLNuBumC2WhPCVvJ78mYp6ynB1gXHQWnkmaCuyI/jw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=geKbP93hG2TgSIi9aNebw7qjrZViRITl07xwTp6Dc9IQoUdhuCxrrSIuiX6wJgB5t
 JowdoP3L/BCIhGXefLJLqTz4L3U/bSgbbK2M1M32Keh1JHIbWIoJUWLyGbG4n5CK9t
 ujXs6z/5LYHl5LThz30sgDN/NI51E6Pgm+wHdZBPzX4sbL1TkiZT1bcw+lbkQoIxaS
 L8uzuK48XKw13k+wApzPoG2LR6DebjGrd4aDo9NhqAS8PJbJEAgZ3UBTSEQQI/dHrO
 NbttQ8HB63fp73qf4lt2NuMBMXNPIpuseletPBtoeZ/dJi+sNjqs3fm6zCHsnC+VFj
 ZalNbmlkQ88pw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] test: unit test for efi_alloc_aligned_pages()
Date: Sat,  7 Jun 2025 13:49:05 +0200
Message-ID: <20250607114906.209959-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
References: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
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

Provide unit tests for efi_alloc_aligned_pages() and
efi_allocate_pages().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/lib/Makefile     |  2 +-
 test/lib/efi_memory.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 test/lib/efi_memory.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index ff4ff63270d..35b40b584c4 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) += compression.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += abuf.o
 obj-y += alist.o
-obj-$(CONFIG_EFI_LOADER) += efi_device_path.o
+obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
diff --git a/test/lib/efi_memory.c b/test/lib/efi_memory.c
new file mode 100644
index 00000000000..d2e1ab6b4a3
--- /dev/null
+++ b/test/lib/efi_memory.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test memory functions
+ *
+ * Copyright (c) 2025 Heinrich Schuchardt <xypron.glpk@gmx.de>
+ */
+
+#include <efi_loader.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int lib_test_efi_alloc_aligned_pages(struct unit_test_state *uts)
+{
+	efi_status_t ret;
+
+	void *addr;
+	unsigned long align = 0x400000;
+
+	addr = efi_alloc_aligned_pages(4096, EFI_PERSISTENT_MEMORY_TYPE,
+				       EFI_PAGE_SIZE);
+	ut_asserteq_ptr(NULL, addr);
+
+	addr = efi_alloc_aligned_pages(4096, 0x6FFFFFFF, EFI_PAGE_SIZE);
+	ut_asserteq_ptr(NULL, addr);
+
+	align = 0x200;
+	addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
+	ut_assertnonnull(addr);
+	ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
+
+	ret = efi_free_pages((uintptr_t) addr, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	align = 0x400000;
+	addr = efi_alloc_aligned_pages(4096, EFI_ACPI_RECLAIM_MEMORY, align);
+	ut_assertnonnull(addr);
+	ut_asserteq_64(0, (uintptr_t)addr & (align - 1));
+
+	ret = efi_free_pages((uintptr_t) addr, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_alloc_aligned_pages, 0);
+
+static int lib_test_efi_allocate_pages(struct unit_test_state *uts)
+{
+	efi_status_t ret;
+	u64 memory;
+
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_ACPI_RECLAIM_MEMORY,
+				 1, &memory);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+	ut_asserteq_64(0, memory & EFI_PAGE_MASK);
+
+	ret = efi_free_pages(memory, 1);
+	ut_asserteq_64(ret, EFI_SUCCESS);
+
+	return 0;
+}
+LIB_TEST(lib_test_efi_allocate_pages, 0);
-- 
2.48.1

