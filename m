Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E446C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ACF888B16;
	Wed, 28 Aug 2024 03:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fu1yUb1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4EF88A7B; Wed, 28 Aug 2024 03:44:42 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BDF88A9D
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f921c418eso3232839f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809478; x=1725414278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+1ZNAKpGLqqqk2ZF8ePuzkcZOfn0R8AwnIXNpQEuOs=;
 b=Fu1yUb1rsqdyBZosgKWCVzhsYFPAngEFc8+4eBf8Y1ye599xaFGt8hDRzkK9+2XqSl
 E+MsenHxpapIJjkWSnlmzvMRND+8mh84POzMc0AhechgIf5Ip5mLWg7udRDzefBvXk1D
 vYc5f5FrzgsvZ9vzIKsaeMSGdKYYEnVVBIOwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809478; x=1725414278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+1ZNAKpGLqqqk2ZF8ePuzkcZOfn0R8AwnIXNpQEuOs=;
 b=bMPP44lp6OUAMTUzPhaR9RL/KogJqwu0a+okzlyGsy2fbnLmOSFXWiEhPCd4Cqi63P
 Gc8tvaOHiKBrYQ1/3plR79StNHmy+P5RiM4p1VSoIgT893UQzyNuNhZx7j2EkErcqYQ8
 7m8A5mAYzv2Nm1Kk54I6AsHPgBIxoTF7qByynbWO10FRXXE7elgYdg1ghHsCi2nXB+c6
 45x9uIZ9/VBI8/tms9GQFiRIvjkYhnCWxnGTNTEPWqAwx5ukGgJ2luEFohQmSE+gPUjW
 nXZBcRRmgsdGxYXQmZzj+aJv8enfu8098gAR6XjOOTXRn56AyBOtdkPbbZf2GdxPBVeF
 N8xg==
X-Gm-Message-State: AOJu0YxwFWH75rGpP3OfgBEgL6zEo/v3iQtVXT4ghJhZQvr5mfomQTlA
 0XhJq0RJEZhwNmf2FQnSfd2rCmKU/fGN+NhkFbCbor+910tY3ywdQXrOe+oy5yrvQr4NUlV5Okw
 =
X-Google-Smtp-Source: AGHT+IE2csFFNwioLnziJv16vxilcMfVaf/EI9XcInYF5y+/2ijFVV76CMyQcQ31EhL53+9IXMgDfA==
X-Received: by 2002:a05:6602:6197:b0:7f3:d85e:476f with SMTP id
 ca18e2360f4ac-82a03840903mr38242739f.6.1724809477911; 
 Tue, 27 Aug 2024 18:44:37 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] x86: Add a cpuid command
Date: Tue, 27 Aug 2024 19:44:28 -0600
Message-Id: <20240828014429.3320011-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014429.3320011-1-sjg@chromium.org>
References: <20240828014429.3320011-1-sjg@chromium.org>
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

It is useful to obtain the results of cpuid queries, so add a command
for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/Makefile        |  2 +-
 cmd/x86/cpuid.c         | 37 ++++++++++++++++++++++
 doc/usage/cmd/cpuid.rst | 68 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 test/cmd/Makefile       |  1 +
 test/cmd/cpuid.c        | 22 +++++++++++++
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 cmd/x86/cpuid.c
 create mode 100644 doc/usage/cmd/cpuid.rst
 create mode 100644 test/cmd/cpuid.c

diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index b1f39d3bfde..1648907ac2d 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
-obj-y += mtrr.o
+obj-y += cpuid.o mtrr.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_USE_HOB) += hob.o
 obj-$(CONFIG_HAVE_FSP) += fsp.o
diff --git a/cmd/x86/cpuid.c b/cmd/x86/cpuid.c
new file mode 100644
index 00000000000..222754b5d15
--- /dev/null
+++ b/cmd/x86/cpuid.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * The 'cpuid' command provides access to the CPU's cpuid information
+ *
+ * Copyright 2024 Google, LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <command.h>
+#include <vsprintf.h>
+#include <asm/cpu.h>
+
+static int do_cpuid(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	struct cpuid_result res;
+	ulong op;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	op = hextoul(argv[1], NULL);
+	res = cpuid(op);
+	printf("eax %08x\n", res.eax);
+	printf("ebx %08x\n", res.ebx);
+	printf("ecx %08x\n", res.ecx);
+	printf("edx %08x\n", res.edx);
+
+	return 0;
+}
+
+U_BOOT_LONGHELP(cpuid, "Show CPU Identification information");
+
+U_BOOT_CMD(
+	cpuid,	2,	1,	do_cpuid,
+	"cpuid <op>", cpuid_help_text
+);
diff --git a/doc/usage/cmd/cpuid.rst b/doc/usage/cmd/cpuid.rst
new file mode 100644
index 00000000000..cccf9262ed4
--- /dev/null
+++ b/doc/usage/cmd/cpuid.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: cpuid (command)
+
+cpuid command
+=============
+
+Synopsis
+--------
+
+::
+
+    cpuid <op>
+
+Description
+-----------
+
+The cpuid command requests CPU-identification information on x86 CPUs. The
+operation <op> selects what information is returned. Up to four 32-bit registers
+can be update (eax-edx) depending on the operation.
+
+Configuration
+-------------
+
+The cpuid command is only available on x86.
+
+Return value
+------------
+
+The return value $? is 0 (true).
+
+Example
+-------
+
+::
+
+    => cpuid 1
+    eax 00060fb1
+    ebx 00040800
+    ecx 80002001
+    edx 178bfbfd
+
+This shows checking for 64-bit 'long' mode::
+
+    => cpuid 80000000
+    eax 8000000a
+    ebx 68747541
+    ecx 444d4163
+    edx 69746e65
+    => cpuid 80000001
+    eax 00060fb1
+    ebx 00000000
+    ecx 00000007
+    edx 2193fbfd   # Bit 29 is set in edx, so long mode is available
+
+On a 32-bit-only CPU::
+
+    => cpuid 80000000
+    eax 80000004
+    ebx 756e6547
+    ecx 6c65746e
+    edx 49656e69
+    => cpuid 80000001
+    eax 00000663
+    ebx 00000000
+    ecx 00000000
+    edx 00000000   # Bit 29 is not set in edx, so long mode is not available
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index b058c2254fb..986554090af 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -52,6 +52,7 @@ Shell commands
    cmd/conitrace
    cmd/cp
    cmd/cpu
+   cmd/cpuid
    cmd/cyclic
    cmd/dm
    cmd/ebtupdate
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..dedcec33c8e 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -12,6 +12,7 @@ ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
 obj-y += exit.o mem.o
+obj-$(CONFIG_X86) += cpuid.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
diff --git a/test/cmd/cpuid.c b/test/cmd/cpuid.c
new file mode 100644
index 00000000000..e07f5fd4696
--- /dev/null
+++ b/test/cmd/cpuid.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for cpuid command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <test/cmd.h>
+#include <test/ut.h>
+
+static int cmd_test_cpuid(struct unit_test_state *uts)
+{
+	ut_assertok(run_commandf("cpuid 1"));
+	ut_assert_nextline("eax 00060fb1");
+	ut_assert_nextline("ebx 00000800");
+	ut_assert_nextline("ecx 80002001");
+	ut_assert_nextline("edx 078bfbfd");
+
+	return 0;
+}
+CMD_TEST(cmd_test_cpuid, UTF_CONSOLE);
-- 
2.34.1

