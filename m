Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B744C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D5A84A7A;
	Wed,  8 Jul 2026 22:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FmL9OJ+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895CB84AA8; Wed,  8 Jul 2026 22:37:43 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA40084A73
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543061; x=1783802261;
 bh=nqguFnbbOss5NUBJx0byJuv6pzLcyLmzjGgRU964VRQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FmL9OJ+ycvhIU7UQC0xK+5OD52Cdghfr60XTMJN6VctMi+No4lEiaGVjEhrpREC7v
 nVjKPPevaBzXjmDmaYHFGNAn8pekhsNA+q5yZnyUN3+UsU7w2OK9Y/81F//lb/kRTm
 xpKPD0AE8+nQPYOKXnfyAsspSxlXa5wOMP1D9guEnVMNalrXOCIJyRa/D8n5uBWt+I
 AQm2U6SwJucvxzXDIUfaQZsBbZIMqN1EDM4k9RBKuGmXpFkjd7Rt6RMSQv+SHiI4pR
 pBUYwQ2aEUnfrmLL4B8stNaIFp4L4o1uvRWzSBm0vytuFmA7/PWZ4TYk4qwKd2pEIi
 ro3ffXPrCxjng==
X-Pm-Submission-Id: 4gwVJy0xvFz1DFGQ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 10/10] test: add test of 'config' command
Date: Wed,  8 Jul 2026 22:37:11 +0200
Message-ID: <20260708203711.849489-11-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
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

Add some test cases for the 'config' command, including the ability to
filter the output.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 test/cmd/Makefile |  1 +
 test/cmd/config.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 test/cmd/config.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8d6932f1176..8d36463879d 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -17,6 +17,7 @@ ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_ACPI) += acpi.o
 endif
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
+obj-$(CONFIG_CMD_CONFIG) += config.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CMD_HASH) += hash.o
diff --git a/test/cmd/config.c b/test/cmd/config.c
new file mode 100644
index 00000000000..5a48060801f
--- /dev/null
+++ b/test/cmd/config.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for config command
+ */
+
+#include <console.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+static int cmd_test_config(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("config", 0));
+	ut_assert_skip_to_line("# Automatically generated file; DO NOT EDIT.");
+	ut_assert_skip_to_linen("# Compiler:");
+	ut_assert_skip_to_line("CONFIG_CMD_CONFIG=y");
+
+	console_record_reset_enable();
+
+	ut_assertok(run_command("config cmd_config=y", 0));
+	ut_assert_nextline("CONFIG_CMD_CONFIG=y");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("config 'this string never appears in .config'", 0));
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(cmd_test_config, UTF_CONSOLE);
-- 
2.55.0

