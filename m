Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FE2C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C248657B;
	Thu, 31 Aug 2023 01:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bDzcLf5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509958655C; Thu, 31 Aug 2023 01:30:09 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7856786555
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so12123139f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438204; x=1694043004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNlM5/l/Gp2aFNBaW5iKO3wY7nya4uhJY17ZxCCutcE=;
 b=bDzcLf5sOEi2w1TbHnxJhOSSVS6BhTHKRnLcUg1T5bW1yPapS3GUPLtjKzKgOg9i4m
 WTfbv2RoV0RKJhZs96gq+wrztJyTu+FK3YInJYmwVyWj+BnJ1nCFIPJtW3tPlIeCsAbh
 5RKX5K8pfkkYnVMd4Nn+i1BN5eXP8Iw0yboy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438204; x=1694043004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNlM5/l/Gp2aFNBaW5iKO3wY7nya4uhJY17ZxCCutcE=;
 b=K8rECYA9HA7/vQ6UQOsD9BS9vwsn35Nfr/4P6+WcjSt/0G9VMfecQO6QoYP3nMtmRv
 xJZI8r4+dQHuPZNDcOjw+9Npdh439hXWBm0UqVOyRl8sC4XuHqAjVslzljQcHtdPUrSJ
 4z9yG8iePnuU8qtfP5ElG4W5VBTzkGDeK5a9ee3Lj/K8dNtL6Rv9GItHjgY/hnQGnRK5
 Tj/JrY6p+DACV1SYORpjN8j8IAAWA27qvFrPBs2JzT7Cc0c7fZU/AAq5UTvnghvGapew
 ajGgAUKAWRozHVkCCOmRQ4H7pM7Yk9sM5AhhXH6r7FLx1c9qczs+Dx0kOWRntPIP6vhD
 PfQg==
X-Gm-Message-State: AOJu0YwTtGE2ynDk0NjTT3XJyLMx0XJljIL9l9/8/aaoF8/7fJy/k4G1
 /V9fjHrPjKc0gzySPs1T56CZAPmhD3TfUMHkk3U=
X-Google-Smtp-Source: AGHT+IFNHBXSM+9Fq4zgeYPRbNdGTBBZ2niSzpme2E8tNh4Z9dXXLM9yNCKY6qwdg9b8eSIoZN/oyw==
X-Received: by 2002:a5e:870c:0:b0:795:196c:a074 with SMTP id
 y12-20020a5e870c000000b00795196ca074mr4147861ioj.3.1693438203972; 
 Wed, 30 Aug 2023 16:30:03 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>, Bin Meng <bmeng.cn@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Stefan Roese <sr@denx.de>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [RFC PATCH 4/9] upl: Add a command
Date: Wed, 30 Aug 2023 17:29:18 -0600
Message-ID: <20230830232928.2590178-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

Add a 'upl' command to work with Universal Payload features. For now it
only supports reading and writing a handoff structure.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig                      |   1 +
 cmd/Kconfig                       |   7 ++
 cmd/Makefile                      |   1 +
 cmd/upl.c                         |  99 ++++++++++++++++++++
 doc/usage/cmd/upl.rst             | 149 ++++++++++++++++++++++++++++++
 doc/usage/index.rst               |   1 +
 include/asm-generic/global_data.h |  15 +++
 test/boot/upl.c                   |  37 ++++++++
 8 files changed, 310 insertions(+)
 create mode 100644 cmd/upl.c
 create mode 100644 doc/usage/cmd/upl.rst

diff --git a/boot/Kconfig b/boot/Kconfig
index d44684aaa04..b8b1032ca63 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -678,6 +678,7 @@ config BOOTMETH_SCRIPT
 
 config UPL
 	bool "upl - Universal Payload Specification"
+	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3f14923b5ef..105d2647b88 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -351,6 +351,13 @@ config CMD_SEAMA
 	help
 	  Support reading NAND Seattle Image (SEAMA) images.
 
+config CMD_UPL
+	bool "upl - Universal Payload Specification"
+	help
+	  Provides commands to deal with  UPL payloads and handoff information.
+	  U-Boot supports generating and accepting handoff information. The
+	  mkimage tool will eventually support creating payloads.
+
 config CMD_VBE
 	bool "vbe - Verified Boot for Embedded"
 	depends on BOOTMETH_VBE
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c39..877eb0be9ef 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_CMD_UBIFS) += ubifs.o
 obj-$(CONFIG_CMD_UNIVERSE) += universe.o
 obj-$(CONFIG_CMD_UNLZ4) += unlz4.o
 obj-$(CONFIG_CMD_UNZIP) += unzip.o
+obj-$(CONFIG_CMD_UPL) += upl.o
 obj-$(CONFIG_CMD_VIRTIO) += virtio.o
 obj-$(CONFIG_CMD_WDT) += wdt.o
 obj-$(CONFIG_CMD_LZMADEC) += lzmadec.o
diff --git a/cmd/upl.c b/cmd/upl.c
new file mode 100644
index 00000000000..d84c2bef354
--- /dev/null
+++ b/cmd/upl.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Commands for UPL handoff generation
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <command.h>
+#include <abuf.h>
+#include <display_options.h>
+#include <mapmem.h>
+#include <string.h>
+#include <upl.h>
+#include <dm/ofnode.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int do_upl_info(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	printf("UPL state: %sactive\n", gd_upl() ? "" : "in");
+
+	return 0;
+}
+
+static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct upl s_upl, *upl = &s_upl;
+	struct abuf buf;
+	oftree tree;
+	ulong addr;
+	int ret;
+
+	upl_get_test_data(upl);
+
+	log_debug("Writing UPL\n");
+	ret = upl_create_handoff_tree(upl, &tree);
+	if (ret) {
+		log_err("Failed to write (err=%dE)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("Flattening\n");
+	ret = oftree_to_fdt(tree, &buf);
+	if (ret) {
+		log_err("Failed to write (err=%dE)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	addr = map_to_sysmem(abuf_data(&buf));
+	printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
+	if (env_set_hex("upladdr", addr) ||
+	    env_set_hex("uplsize", abuf_size(&buf))) {
+		printf("Cannot set env var\n");
+		return CMD_RET_FAILURE;
+	}
+
+	log_debug("done\n");
+
+	return 0;
+}
+
+static int do_upl_read(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	struct upl s_upl, *upl = &s_upl;
+	oftree tree;
+	ulong addr;
+	int ret;
+
+	if (argc < 1)
+		return CMD_RET_USAGE;
+	addr = hextoul(argv[1], NULL);
+
+	printf("Reading UPL at %lx\n", addr);
+	tree = oftree_from_fdt(map_sysmem(addr, 0));
+	ret = upl_read_handoff(upl, tree);
+	if (ret) {
+		log_err("Failed to read (err=%dE)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_SYS_LONGHELP
+static char upl_help_text[] =
+	"info          - Check UPL status\n"
+	"upl read <addr>   - Read handoff information\n"
+	"upl write         - Write handoff information";
+#endif
+
+U_BOOT_CMD_WITH_SUBCMDS(upl, "Universal Payload support", upl_help_text,
+	U_BOOT_SUBCMD_MKENT(info, 1, 1, do_upl_info),
+	U_BOOT_SUBCMD_MKENT(read, 2, 1, do_upl_read),
+	U_BOOT_SUBCMD_MKENT(write, 1, 1, do_upl_write));
diff --git a/doc/usage/cmd/upl.rst b/doc/usage/cmd/upl.rst
new file mode 100644
index 00000000000..8b41220dff6
--- /dev/null
+++ b/doc/usage/cmd/upl.rst
@@ -0,0 +1,149 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+upl command
+===========
+
+Synopis
+-------
+
+::
+
+    upl write
+    upl read <addr>
+
+Description
+-----------
+
+The *upl* command is used to test U-Boot's support for the Universal Payload
+Specification (UPL), an upcoming firmware standard. It allows creation of a fake
+handoff for use in testing.
+
+One the specification is finalised and published, we will move forward with full
+support for this feature in U-Boot.
+
+
+upl write
+~~~~~~~~~
+
+Write a fake UPL handoff structure. The `upladdr` environment variable is set to
+the address of this structure and `uplsize` is set to the size.
+
+
+upl read
+~~~~~~~~
+
+Read a UPL handoff structure into internal state. This allows testing that the
+handoff can be obtained.
+
+
+Example
+-------
+
+This shows checking whether a UPL handoff was read at start-up::
+
+    => upl info
+    UPL state: active
+
+This shows how to use the command to write and display the handoff::
+
+    => upl write
+    UPL handoff written to bc8a5e0 size 662
+    => print upladdr
+    upladdr=bc8a5e0
+    => print uplsize
+    uplsize=662
+
+    > fdt addr ${upladdr}
+    Working FDT set to bc8a5e0
+    => fdt print
+    / {
+        #address-cells = <0x00000001>;
+        #size-cells = <0x00000001>;
+        options {
+            upl-params {
+                smbios = <0x00000123>;
+                acpi = <0x00000456>;
+                bootmode = "default", "s3";
+                addr-width = <0x0000002e>;
+                acpi-nvs-size = <0x00000100>;
+            };
+            upl-image {
+                fit = <0x00000789>;
+                conf-offset = <0x00000234>;
+                image-1 {
+                    load = <0x00000001>;
+                    size = <0x00000002>;
+                    offset = <0x00000003>;
+                    description = "U-Boot";
+                };
+                image-2 {
+                    load = <0x00000004>;
+                    size = <0x00000005>;
+                    offset = <0x00000006>;
+                    description = "ATF";
+                };
+            };
+        };
+        memory@0x10 {
+            reg = <0x00000010 0x00000020 0x00000030 0x00000040 0x00000050 0x00000060>;
+        };
+        memory@0x70 {
+            reg = <0x00000070 0x00000080>;
+            hotpluggable;
+        };
+        memory-map {
+            acpi@0x11 {
+                reg = <0x00000011 0x00000012 0x00000013 0x00000014 0x00000015 0x00000016 0x00000017 0x00000018 0x00000019 0x0000001a>;
+                usage = "acpi-reclaim";
+            };
+            u-boot@0x21 {
+                reg = <0x00000021 0x00000022>;
+                usage = "boot-data";
+            };
+            efi@0x23 {
+                reg = <0x00000023 0x00000024>;
+                usage = "runtime-code";
+            };
+            empty@0x25 {
+                reg = <0x00000025 0x00000026 0x00000027 0x00000028>;
+            };
+            acpi-things@0x2a {
+                reg = <0x0000002a 0x00000000>;
+                usage = "acpi-nvs", "runtime-code";
+            };
+        };
+        reserved-memory {
+            mmio@0x2b {
+                reg = <0x0000002b 0x0000002c>;
+            };
+            memory@0x2d {
+                reg = <0x0000002d 0x0000002e 0x0000002f 0x00000030>;
+                no-map;
+            };
+        };
+        serial@0xf1de0000 {
+            compatible = "ns16550a";
+            clock-frequency = <0x001c2000>;
+            current-speed = <0x0001c200>;
+            reg = <0xf1de0000 0x00000100>;
+            reg-io-shift = <0x00000002>;
+            reg-offset = <0x00000040>;
+            virtual-reg = <0x20000000>;
+            access-type = "mmio";
+        };
+        framebuffer@0xd0000000 {
+            compatible = "simple-framebuffer";
+            reg = <0xd0000000 0x10000000>;
+            width = <0x00000500>;
+            height = <0x00000500>;
+            stride = <0x00001400>;
+            format = "a8r8g8b8";
+        };
+    };
+    =>
+
+This showing reading the handoff into internal state::
+
+    => upl read bc8a5e0
+    Reading UPL at bc8a5e0
+    =>
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3326ec82fff..ed896dfb3a0 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -103,6 +103,7 @@ Shell commands
    cmd/tftpput
    cmd/trace
    cmd/true
+   cmd/upl
    cmd/ums
    cmd/unbind
    cmd/ut
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index b0485f3dd2a..86fabac12ef 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -30,6 +30,7 @@
 
 struct acpi_ctx;
 struct driver_rt;
+struct upl;
 
 typedef struct global_data gd_t;
 
@@ -495,6 +496,12 @@ struct global_data {
 	 * @dmtag_list: List of DM tags
 	 */
 	struct list_head dmtag_list;
+#if CONFIG_IS_ENABLED(UPL)
+	/**
+	 * @upl: Universal Payload-handoff information
+	 */
+	struct upl *upl;
+#endif
 };
 #ifndef DO_DEPS_ONLY
 static_assert(sizeof(struct global_data) == GD_SIZE);
@@ -580,6 +587,14 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_malloc_ptr()		0L
 #endif
 
+#if CONFIG_IS_ENABLED(UPL)
+#define gd_upl()		gd->upl
+#define gd_set_upl(_val)	gd->upl = (_val)
+#else
+#define gd_upl()		NULL
+#define gd_set_upl(val)
+#endif
+
 /**
  * enum gd_flags - global data flags
  *
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 8319a93e057..e72027f4974 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -418,3 +418,40 @@ static int upl_test_read_failure(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(upl_test_read_failure, 0);
+
+/* Test 'upl info' command */
+static int dm_test_upl_info(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("upl info", 0));
+	ut_assert_nextline("UPL state: inactive");
+	ut_assert_console_end();
+
+	gd_set_upl((struct upl *)uts);	/* set it to any non-zero value */
+	ut_assertok(run_command("upl info", 0));
+	ut_assert_nextline("UPL state: active");
+	ut_assert_console_end();
+	gd_set_upl(NULL);
+
+	return 0;
+}
+BOOTSTD_TEST(dm_test_upl_info, UT_TESTF_CONSOLE_REC);
+
+/* Test 'upl read' and 'upl_write' commands */
+static int dm_test_upl_read_write(struct unit_test_state *uts)
+{
+	ulong addr;
+
+	ut_assertok(run_command("upl write", 0));
+
+	addr = env_get_hex("upladdr", 0);
+	ut_assert_nextline("UPL handoff written to %lx size %lx", addr,
+			   env_get_hex("uplsize", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("upl read ${upladdr}", 0));
+	ut_assert_nextline("Reading UPL at %lx", addr);
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(dm_test_upl_read_write, UT_TESTF_CONSOLE_REC);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

