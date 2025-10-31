Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85335CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 20:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21E183B07;
	Fri, 31 Oct 2025 20:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XAkB0jy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C6483AFD; Fri, 31 Oct 2025 20:59:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D9D83AEA
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5C55640968; 
 Fri, 31 Oct 2025 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761940775;
 bh=802s4MHcdxqYa4Z3UxFUNawYy7k+8Haoq2FApppdpf0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XAkB0jy/6Jg6lUKp0XTLQYGwnP+QTUbAGOIxJqIhkHoxiRcZhnu2sVnE6DsCtS2TF
 b18yOFXAEL6xnB5Z80Jdy8hvsUJobGK+THq1+L3uhsCKSbT2ENxyqaD7m8ovT7YrCc
 7TRT6jJBTFfHDTUEfv9GdzP4BdLjeYln2JB6gScsVALLBKYYr1GDU2RmmoG+7a+msO
 GKmStKHC9USOPr4l5YSE2PbWMb/zxWKHrpKHukrbOhFExaYs+mMr9YpRLvyQGtsyZG
 nJ4E45+Vmn4p9n4aPr9ntYP64RxWmlSrr8Ub2pSBB8kzJwuLMfIdkMZMShAceaxf0w
 7XAMg5SS5TXjK+lg6lVWPtgBlmwUs5GY5NRU1hrsH3P7p7kM1yO1MZIyXvvCWsg5is
 usl72f3zSaXdfawPzR4w0wkvDznpGf/ckgireoA+5AY/lLnEnVndgWr+iSjvoXQtTh
 aYH+MFY1+ABCsAS0/sZHYcxMPJ1Po66q6EkXi2fIsUKE2raHOmBNIWOGnl6TuIiWHj
 JcW4sCOofZ0Fh6Oqbpn89ORWEFGDuBsJE4SzmFJsb+rw5D8a9UXdbxxNJtY/1JpZWX
 VybklAYeF3/YH4o52vbbYIEmIRqlNA6zEQy4h1eGEjxdvawZp4B4K/VBEKoSpEYRW0
 //1BmhtrGuN1VdGyIgpdTjPI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] test: provide test for 'acpi list' command
Date: Fri, 31 Oct 2025 20:59:30 +0100
Message-ID: <20251031195931.622513-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
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

Check that some mandatory ACPI tables exist:

  - RSDP
  - RSDT or XSDT
  - FADT

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/Makefile |  3 +++
 test/cmd/acpi.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 test/cmd/acpi.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index e71c80a5b2e..ae545b03b79 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -13,6 +13,9 @@ endif
 obj-y += exit.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
+ifdef CONFIG_CONSOLE_RECORD
+obj-$(CONFIG_CMD_ACPI) += acpi.o
+endif
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
diff --git a/test/cmd/acpi.c b/test/cmd/acpi.c
new file mode 100644
index 00000000000..ae6157d3d56
--- /dev/null
+++ b/test/cmd/acpi.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for acpi command
+ */
+
+#include <linux/bitops.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+#define HAVE_RSDP BIT(0)
+#define HAVE_XSDT BIT(1)
+#define HAVE_FADT BIT(2)
+#define HAVE_ALL (HAVE_RSDP | HAVE_XSDT | HAVE_FADT)
+
+/**
+ * cmd_test_acpi() - test the acpi command
+ */
+static int cmd_test_acpi(struct unit_test_state *uts)
+{
+	unsigned int actual = 0;
+	int ret;
+
+	/*
+	 * Check that some mandatory ACPI tables exist:
+	 * - RSDP
+	 * - RSDT or XSDT
+	 * - FADT
+	 */
+	ut_assertok(run_commandf("acpi list"));
+	ut_assert_nextline("Name              Base   Size  Detail");
+	ut_assert_nextline("----  ----------------  -----  ----------------------------");
+	for (;;) {
+		ret = console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+		if (ret == -ENOENT) {
+			ut_asserteq(HAVE_ALL, actual);
+
+			return 0;
+		}
+		if (ret < 0)
+			ut_asserteq(0, ret);
+
+		if (!strncmp("RSDP", uts->actual_str, 4))
+			actual |= HAVE_RSDP;
+		else if (!strncmp("RSDT", uts->actual_str, 4))
+			actual |= HAVE_XSDT;
+		else if (!strncmp("XSDT", uts->actual_str, 4))
+			actual |= HAVE_XSDT;
+		else if (!strncmp("FACP", uts->actual_str, 4))
+			actual |= HAVE_FADT;
+	}
+}
+CMD_TEST(cmd_test_acpi, UTF_CONSOLE);
-- 
2.51.0

