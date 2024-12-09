Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE376E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700CE8973E;
	Mon,  9 Dec 2024 17:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dx3EFipx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B08896F9; Mon,  9 Dec 2024 17:29:09 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FF08975E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-841d8dec299so310740839f.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761745; x=1734366545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJIhOlM5RQ7bPTrd2iXDd9KOp8qAINy9LqBgwvgXvO0=;
 b=Dx3EFipxpGRAfgY2MozFuSAgngEJkUZJCXVMH06G4/0aQ8rwxBeUjCJGdUu9aKL+9J
 LdCGv0R4h7pb6POdfPVsZEgItZbF174KiFXngsz2epHcvGDjMdsmoq/owIsb2tbwo2Ee
 xLjH0v4iXEaQyVJ/0Zp9f8doKhpkg1KK0gzPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761745; x=1734366545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJIhOlM5RQ7bPTrd2iXDd9KOp8qAINy9LqBgwvgXvO0=;
 b=xH6q8hI2tUjLLyM/5Ui2ZIIfQ5Ti/hi3NbYLsk11HAjkuND5DA3rQmEFTukgHhpnpV
 BAMfc1fz0iVNS2jxmlDL1FTJk/GBJ9+sxWyoG68n3k5C4CPdZ0y2CABd4Lzq+o4bPJh5
 tcBB6KbpN4CP9AEHyeu+HT2iiFj9YtzJwnAE1bp56nJEnvoX7tJ6BXhQ66OuKgX8wguI
 HGpOzsxKVdqkaOXQsO78TU+1HICUbNU8p2tLbM1ZNbeNeAmEXLmlwy8rF+epjxxwF0Vs
 mjKyOOVDrnHZpWNW7ekDUcK4aEPZrUMgNSmYx9670eAB52v+V5iQlcxZZqPt0OF7ewqD
 jKKw==
X-Gm-Message-State: AOJu0YwOwfH6jkKYU4kP3Xn6XDQEqgKULtohViM2Gg40ipq/ygpwFBG/
 IiZNPdgG25VRqs++y18Mfa5RqVrc9KewtHjgtO1qpqpiPRLhl48s7NUDQLPvQp/fo/tJGCoYt9s
 =
X-Gm-Gg: ASbGncv3FjuWg2Zl3PookoxjCH9ytJhh4n/OdqQLSeVlQcMD7O3PU3baY8QGbEvKHMR
 e4Jhiskli7HeXQaZWK7+mLHEnmAVy28NY5Csz7Vh1barvsm+OupPiWBIQiGzObpOZw1VVCjqWtz
 84WERtoQhUB5/bIu2ukyGn2XvmkCqdxEuiSiiBGFAwUBxMI1k3s0Y2UZ/FDYdDdeR5YjIQfnPjX
 CYdvo+rRRy7xsRqSg4ONtSZvm2ZzUaIlfhGPPhmx8Qzd+gs9atjXy73+giuumeRkjrxMrD41M0C
 AqYWwhtfR5Y=
X-Google-Smtp-Source: AGHT+IGg/h8gZAvRMxLB0pMBIJCFE8dKWu3NfNdhu3V8oa681Owh7mpAO8Rf2Ipe+AbkRDV/MNcRZQ==
X-Received: by 2002:a5e:db01:0:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-844b5145224mr137048539f.3.1733761744816; 
 Mon, 09 Dec 2024 08:29:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:29:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] doc: test: Add docs and test for addr_find
Date: Mon,  9 Dec 2024 09:28:00 -0700
Message-Id: <20241209162801.288363-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

Add documentation and a test for this command.

Drop the use of config.h while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/addr_find.c             |  1 -
 doc/usage/cmd/addr_find.rst | 63 +++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst         |  1 +
 test/cmd/Makefile           |  1 +
 test/cmd/addr_find.c        | 27 ++++++++++++++++
 5 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 doc/usage/cmd/addr_find.rst
 create mode 100644 test/cmd/addr_find.c

diff --git a/cmd/addr_find.c b/cmd/addr_find.c
index 2c20b959031..601b8b2566b 100644
--- a/cmd/addr_find.c
+++ b/cmd/addr_find.c
@@ -5,7 +5,6 @@
  */
 
 #include <blk.h>
-#include <config.h>
 #include <command.h>
 #include <env.h>
 #include <fs.h>
diff --git a/doc/usage/cmd/addr_find.rst b/doc/usage/cmd/addr_find.rst
new file mode 100644
index 00000000000..0d16ffd236b
--- /dev/null
+++ b/doc/usage/cmd/addr_find.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: addr_find (command)
+
+addr_find command
+=================
+
+Synopsis
+--------
+
+::
+
+    addr_find <interface> [<dev[:part]> [<filename>]]
+
+Description
+-----------
+
+The addr_find command is used to find a consecutive region of memory
+sufficiently large to hold a file, ensuring that the memory is not currently in
+use for another file, etc.
+
+If successful, 'loadaddr' is set to the located address.
+
+The number of transferred bytes is saved in the environment variable filesize.
+The load address is saved in the environment variable fileaddr.
+
+interface
+    interface for accessing the block device (mmc, sata, scsi, usb, ....)
+
+dev
+    device number
+
+part
+    partition number, defaults to 0 (whole device)
+
+filename
+    path to file, defaults to environment variable 'bootfile'
+
+Example
+-------
+
+This shows obtaining an address suitable for a file on an mmc disk::
+
+    => ls mmc 1
+                extlinux/
+     97135227   initramfs-5.3.7-301.fc31.armv7hl.img
+                dtb-5.3.7-301.fc31.armv7hl/
+     12531628   vmlinuz-5.3.7-301.fc31.armv7hl
+
+    2 file(s), 2 dir(s)
+
+    => addr_find mmc 1 vmlinuz-5.3.7-301.fc31.armv7hl
+    => print loadaddr
+    loadaddr=7c00000
+    =>
+
+
+Return value
+------------
+
+The return value $? is set to 0 (true) if the command succeeds. If no suitable
+address could be found, the return value $? is set to 1 (false).
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 64fb91bc5a6..9cbc9a2c9f9 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -24,6 +24,7 @@ Shell commands
    :maxdepth: 1
 
    cmd/acpi
+   cmd/addr_find
    cmd/addrmap
    cmd/armffa
    cmd/askenv
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index dfc49af7bf3..912579e0c6b 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
 obj-y += exit.o mem.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
+obj-$(CONFIG_CMD_ADDR_FIND) += addr_find.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
diff --git a/test/cmd/addr_find.c b/test/cmd/addr_find.c
new file mode 100644
index 00000000000..ce087759d9e
--- /dev/null
+++ b/test/cmd/addr_find.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for 'part_find' command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Test 'addr_find' command */
+static int cmd_test_addr_find(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("loadaddr", NULL));
+	ut_assertok(run_command("addr_find mmc 1:1 vmlinuz-5.3.7-301.fc31.armv7hl", 0));
+	ut_assert_console_end();
+
+	ut_assertnonnull(env_get("loadaddr"));
+
+	return 0;
+}
+CMD_TEST(cmd_test_addr_find, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
-- 
2.34.1

