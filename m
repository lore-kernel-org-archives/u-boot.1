Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C16C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689E888B40;
	Wed, 28 Aug 2024 03:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjF1o/uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8758F88875; Wed, 28 Aug 2024 03:44:42 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C56B88AB1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so395961139f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809479; x=1725414279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIY0u0AxH4yiUXGkDE1YJbyH3Tuygweo60MMmw97r2U=;
 b=SjF1o/uymcOxGU3BPZHigQPNVuwRutZ+sHm4swITpfhnSgLQEwI7M61XMPNsSVhmvI
 7yWBb+a5FRG2+1ykbZ/2XjaLp5V4n2SktKeyo7ASkFcuwzg7SXMXVc/xzfxZ4MTbkkvR
 F7IeG1Yw7WApU0nQkrRRlLqRQfCLLxURZrbHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809479; x=1725414279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIY0u0AxH4yiUXGkDE1YJbyH3Tuygweo60MMmw97r2U=;
 b=otpVzsFYrhlWqvAmRqTJ6JGJqlUxWzyUX9HASTaTMyf4t+IrEyzjTBc+6HHwRdxxtZ
 3lq0v7RHskRMbESfKsWB8IKEbEgOUizCYjPFeYq+ivoZh5Z6+Irq03uu40rwf18DA2cg
 gYMz6ikow0hQJfDvxBPYJnhjvM137Xjm00jQzSYylRUiioi+EcWUNrjowrpcvWnJ1+MA
 GewuXuWsuzVFuTEnHXF2HpDfpquYHcxjUauwGTyJ17SasAmwhBN8N6VRTWS7KwSV+iPA
 UtpqygMAE7qDxje3/eJZyyBgTD9dbJJwSWCFgnLg8cCVc3Oae6PdBEkJf6c1bd6WHzp5
 UUlA==
X-Gm-Message-State: AOJu0YzVUNAsSQdd0YHLEPig8UwxW42QwGwNg1XeDkjqj4ZBZnSQ60zI
 cT3ApgE+jo3pb5t2oXyuJMvysQZcbddisKf7Hz6CCRIDlbi5qXNM1y5Fe+8PaWKMjL9Z00bVgzA
 =
X-Google-Smtp-Source: AGHT+IE3PJP1iewa87KluvfJRLMILVTUGRLELEdYHgBxgsoIeA78uow5KgL3URMRLAKNPTdsJoBWeA==
X-Received: by 2002:a05:6602:340b:b0:81f:8c39:2a5c with SMTP id
 ca18e2360f4ac-82a04181c6bmr65875739f.12.1724809478852; 
 Tue, 27 Aug 2024 18:44:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] x86: Add msr command
Date: Tue, 27 Aug 2024 19:44:29 -0600
Message-Id: <20240828014429.3320011-7-sjg@chromium.org>
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

It is useful to obtain the results of MSR queries as well as to update
MSR registers, so add a command these tasks.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/Makefile      |  2 +-
 cmd/x86/msr.c         | 52 ++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/msr.rst | 61 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |  1 +
 test/cmd/Makefile     |  2 +-
 test/cmd/msr.c        | 38 +++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 cmd/x86/msr.c
 create mode 100644 doc/usage/cmd/msr.rst
 create mode 100644 test/cmd/msr.c

diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 1648907ac2d..925215235d3 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
-obj-y += cpuid.o mtrr.o
+obj-y += cpuid.o msr.o mtrr.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
 obj-$(CONFIG_USE_HOB) += hob.o
 obj-$(CONFIG_HAVE_FSP) += fsp.o
diff --git a/cmd/x86/msr.c b/cmd/x86/msr.c
new file mode 100644
index 00000000000..3cb70d1f89a
--- /dev/null
+++ b/cmd/x86/msr.c
@@ -0,0 +1,52 @@
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
+#include <asm/msr.h>
+
+static int do_read(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	struct msr_t msr;
+	ulong op;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	op = hextoul(argv[1], NULL);
+	msr = msr_read(op);
+	printf("%08x %08x\n", msr.hi, msr.lo);
+
+	return 0;
+}
+
+static int do_write(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	struct msr_t msr;
+	ulong op;
+
+	if (argc < 4)
+		return CMD_RET_USAGE;
+
+	op = hextoul(argv[1], NULL);
+	msr.hi = hextoul(argv[2], NULL);
+	msr.lo = hextoul(argv[3], NULL);
+	msr_write(op, msr);
+
+	return 0;
+}
+
+U_BOOT_LONGHELP(msr,
+	"read <op>         - read a machine-status register (MSR) as <hi 32-bits> <lo 32-bits>\n"
+	"write <op< <hi> <lo>  - write an MSR");
+
+U_BOOT_CMD_WITH_SUBCMDS(msr, "Machine Status Registers", msr_help_text,
+	U_BOOT_CMD_MKENT(read, CONFIG_SYS_MAXARGS, 1, do_read, "", ""),
+	U_BOOT_CMD_MKENT(write, CONFIG_SYS_MAXARGS, 1, do_write, "", ""));
diff --git a/doc/usage/cmd/msr.rst b/doc/usage/cmd/msr.rst
new file mode 100644
index 00000000000..04ee52cc1c7
--- /dev/null
+++ b/doc/usage/cmd/msr.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: msr (command)
+
+msr command
+===========
+
+Synopsis
+--------
+
+::
+
+    msr read <op>
+    msr write <op> <hi> <lo>
+
+Description
+-----------
+
+The msr command reads and writes machine-status registers (MSRs) on x86 CPUs.
+The information is a 64-bit value split into two parts, <hi> for the top 32
+bits and <lo> for the bottom 32 bits.
+
+The operation <op> selects what information is read or written.
+
+msr read
+~~~~~~~~
+
+This reads an MSR and displays the value obtained.
+
+msr write
+~~~~~~~~~
+
+This writes a value to an MSR.
+
+Configuration
+-------------
+
+The msr command is only available on x86.
+
+Return value
+------------
+
+The return value $? is 0 (true).
+
+Example
+-------
+
+This shows reading msr 0x194 which is MSR_FLEX_RATIO on Intel CPUs::
+
+    => msr read 194
+    00000000 00011200   # Bits 16 (flex ratio enable) and 20 (lock) are set
+
+This shows adjusting the energy-performance bias on an Intel CPU::
+
+    => msr read 1b0
+    00000000 00000006     # 6 means 'normal'
+
+    => msr write 1b0 0 f  # change to power-save
+    => msr read 1b0
+    00000000 0000000f
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 986554090af..2e60afb297e 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -87,6 +87,7 @@ Shell commands
    cmd/mbr
    cmd/md
    cmd/mmc
+   cmd/msr
    cmd/mtest
    cmd/mtrr
    cmd/panic
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index dedcec33c8e..fb6795a87a5 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -12,7 +12,7 @@ ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
 obj-y += exit.o mem.o
-obj-$(CONFIG_X86) += cpuid.o
+obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
diff --git a/test/cmd/msr.c b/test/cmd/msr.c
new file mode 100644
index 00000000000..e9a152ee5bf
--- /dev/null
+++ b/test/cmd/msr.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for msr command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <test/cmd.h>
+#include <test/ut.h>
+
+static int cmd_test_msr(struct unit_test_state *uts)
+{
+	ut_assertok(run_commandf("msr read 200"));
+	ut_assert_nextline("00000000 ffe00006");
+	ut_assert_console_end();
+
+	/* change the first variable msr and see it reflected in the mtrr cmd */
+	ut_assertok(run_commandf("mtrr"));
+	ut_assert_nextline("CPU 65537:");
+	ut_assert_nextlinen("Reg");
+	ut_assert_nextlinen("0   Y     Back         00000000ffe00000");
+	ut_assertok(console_record_reset_enable());
+
+	/* change the type from 6 to 5 */
+	ut_assertok(run_commandf("msr write 200 0 ffe00005"));
+	ut_assert_console_end();
+
+	/* Now it shows 'Protect' */
+	ut_assertok(run_commandf("mtrr"));
+	ut_assert_nextline("CPU 65537:");
+	ut_assert_nextlinen("Reg");
+	ut_assert_nextlinen("0   Y     Protect      00000000ffe00000");
+	ut_assertok(console_record_reset_enable());
+
+	return 0;
+}
+CMD_TEST(cmd_test_msr, UTF_CONSOLE);
-- 
2.34.1

