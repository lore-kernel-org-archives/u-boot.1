Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D9C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 05:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBAA82AEF;
	Fri, 11 Apr 2025 07:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ITzOGg5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D337D82AF1; Fri, 11 Apr 2025 07:33:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF2582ACF
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-163.46.114.pool.telefonica.de
 [46.114.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A328E3F189; 
 Fri, 11 Apr 2025 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744349581;
 bh=BDR1Ax4oGBn73awgeE4nwoM9w0cEtUrtUGAy0l90wAw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ITzOGg5sW0fPLx5ns8ZC/qxidue/lnlu0niopTxNM4craJ1PR40OWOPuV+B+dHA33
 RkllQxAwGb9GbSnoP8+vvUn6uQvJrioZFKwE6lNtSqSu1ke/qKOYU54UXu0xq4qIX2
 KZSV5oRNCEpU/WVm1CG3rg1/IObLCeXDZR2v4cwtea67R2TyQVeDtHsPzRoc38O0+k
 +fwCfahjRnZFzIiVS/fj3tUqOMf2G1IV25aPmTzCgyvDB4oIOIMqNQh32Lb8dVwgbT
 5OjjuSua1DlLbRYvU6evc5FB1m1P0bUd0bz7WdH9NA15tq5tVvA3jG0bJyFjfdaUMe
 XjpMZM9XDOqlw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: check executing in EL2
Date: Fri, 11 Apr 2025 07:32:56 +0200
Message-ID: <20250411053256.17332-1-heinrich.schuchardt@canonical.com>
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

UEFI binaries should be executed in EL2 or EL1 even if U-Boot is started
in EL3. Provide a unit test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/Makefile          |  1 +
 lib/efi_selftest/efi_selftest_el.c | 46 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_el.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 17fbfad116f..d78bf7d6191 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -51,6 +51,7 @@ efi_selftest_variables_runtime.o \
 efi_selftest_watchdog.o
 
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
+obj-$(CONFIG_ARM64) += efi_selftest_el.o
 obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
diff --git a/lib/efi_selftest/efi_selftest_el.c b/lib/efi_selftest/efi_selftest_el.c
new file mode 100644
index 00000000000..03218efa49c
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_el.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Check current exception level on ARMv8.
+ */
+#include <efi_loader.h>
+#include <efi_selftest.h>
+
+/**
+ * current_exception_level()
+ *
+ * Return:	current exception level, 0 - 3
+ */
+static unsigned int current_exception_level(void)
+{
+	unsigned long el;
+
+	asm volatile (
+		"MRS %0, CurrentEL"
+		: "=r" (el) : : );
+
+	return (el >> 2) & 0x3;
+}
+
+/**
+ * execute() - execute test
+ *
+ * Check that the exception level is not EL3.
+ */
+static int execute(void)
+{
+	unsigned int el = current_exception_level();
+
+	efi_st_printf("Exception level EL%u\n", el);
+	if (el != 1 && el != 2) {
+		efi_st_error("EL1 or EL2 expected");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(el) = {
+	.name = "exception level",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.execute = execute,
+};
-- 
2.48.1

