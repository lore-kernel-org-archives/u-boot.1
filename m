Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8671C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E04A388800;
	Sat, 13 Jul 2024 09:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fx73g62v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E82E8884F; Sat, 13 Jul 2024 09:03:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE5A88805
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so16070675e9.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854233; x=1721459033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJKTxQWNkoOwpMMxbQa7kQcbHcjka9GbTCGHaa4jSPo=;
 b=fx73g62v2OvrWVn6VRrmNX8HTNkSEEibpuDpkVcY6Z7tn0CwsMIHiJCgULWsSDy32l
 yLaGh2rAX6T/f0vMXX6CmGcnnCyv19qURFPNFm6jiM/ILI+U3vGFkNLu91HNinEPtGuI
 32nt7AzMsQsck1bdsR8O6F+cozk6ESl3MhsxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854233; x=1721459033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJKTxQWNkoOwpMMxbQa7kQcbHcjka9GbTCGHaa4jSPo=;
 b=q+VP41ZQl7sQK83W5/Bx3MpMQbYyWQNiFwdDhkeqRGoBxQFKni8r1gmISJGm4QA/Uz
 iralNCEkjsMGpxA9K/ap3Jn6CCrDQX/W3XOapLo+EEWyqeoF0XzWxN8wP02azVYp3TnS
 Yw9T7cewRTlXSAFFRz00YxUAazMAaqYsaPaW5AtKnEIpsNC4rAADI/jsea9kYzffN5wL
 8Ex38JoNz2A75jw0WXmiwN8JCm8q0nHZhiUbmgKFLD5ouclaRtrmXfjbsv0Cpywg5C/A
 KfIQIRP5SrYOiYPV4T7GtrU52Q8KUS9EEnD5uHqaqohTfCh7QRofAeXwjFNf6T4Dw8ho
 yr4g==
X-Gm-Message-State: AOJu0YzVja+/xEO1fCNLqMD2ugejDweTZSnssnINHsAhpDpU8b+7Gtvz
 +n0bpNpfz453Cywo2ltlMmQHALl02dVkdJ8tCptAPvuEOo6kebIepOYZZDyaXjtW/mcwg4XgkHo
 =
X-Google-Smtp-Source: AGHT+IHQE8rOC/sMGk3StLGhOrXp8v1AgNhi7DnH/sGPnG5Bv1eAyyvzHXr4dRxM6Rt7Qsd/HqtoBw==
X-Received: by 2002:a05:600c:3ba1:b0:426:618a:a092 with SMTP id
 5b1f17b1804b1-4279da3a68dmr39883175e9.13.1720854232991; 
 Sat, 13 Jul 2024 00:03:52 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 13/21] upl: Add a command
Date: Sat, 13 Jul 2024 08:00:47 +0100
Message-Id: <20240713070055.2172883-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

(no changes since v1)

 MAINTAINERS                       |   2 +
 boot/Kconfig                      |   1 +
 cmd/Kconfig                       |   7 ++
 cmd/Makefile                      |   1 +
 cmd/upl.c                         | 118 +++++++++++++++++++
 doc/usage/cmd/upl.rst             | 186 ++++++++++++++++++++++++++++++
 doc/usage/index.rst               |   1 +
 include/asm-generic/global_data.h |  15 +++
 test/boot/upl.c                   |  40 +++++++
 9 files changed, 371 insertions(+)
 create mode 100644 cmd/upl.c
 create mode 100644 doc/usage/cmd/upl.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 7150c3281ab..2932273c0d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1699,6 +1699,8 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
+F:	cmd/upl.c
+F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
 
diff --git a/boot/Kconfig b/boot/Kconfig
index 04088ca10c0..6c322ac99bd 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -721,6 +721,7 @@ config BOOTMETH_SCRIPT
 
 config UPL
 	bool "upl - Universal Payload Specification"
+	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0cf0d8ad8ab..3c602bd5ba3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -388,6 +388,13 @@ config CMD_SEAMA
 	help
 	  Support reading NAND Seattle Image (SEAMA) images.
 
+config CMD_UPL
+	bool "upl - Universal Payload Specification"
+	help
+	  Provides commands to deal with UPL payloads and handoff information.
+	  U-Boot supports generating and accepting handoff information. The
+	  mkimage tool will eventually support creating payloads.
+
 config CMD_VBE
 	bool "vbe - Verified Boot for Embedded"
 	depends on BOOTMETH_VBE
diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a8..91227f1249c 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -189,6 +189,7 @@ obj-$(CONFIG_CMD_UBIFS) += ubifs.o
 obj-$(CONFIG_CMD_UNIVERSE) += universe.o
 obj-$(CONFIG_CMD_UNLZ4) += unlz4.o
 obj-$(CONFIG_CMD_UNZIP) += unzip.o
+obj-$(CONFIG_CMD_UPL) += upl.o
 obj-$(CONFIG_CMD_VIRTIO) += virtio.o
 obj-$(CONFIG_CMD_WDT) += wdt.o
 obj-$(CONFIG_CMD_LZMADEC) += lzmadec.o
diff --git a/cmd/upl.c b/cmd/upl.c
new file mode 100644
index 00000000000..c9745886507
--- /dev/null
+++ b/cmd/upl.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Commands for UPL handoff generation
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <abuf.h>
+#include <alist.h>
+#include <command.h>
+#include <display_options.h>
+#include <mapmem.h>
+#include <string.h>
+#include <upl.h>
+#include <dm/ofnode.h>
+#include <test/ut.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int do_upl_info(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	const struct upl *upl = gd_upl();
+
+	printf("UPL state: %sactive\n", upl ? "" : "in");
+	if (!upl)
+		return 0;
+	if (argc > 1 && !strcmp("-v", argv[1])) {
+		int i;
+
+		printf("fit %lx\n", upl->fit);
+		printf("conf_offset %x\n", upl->conf_offset);
+		for (i = 0; i < upl->image.count; i++) {
+			const struct upl_image *img =
+				alist_get(&upl->image, i, struct upl_image);
+
+			printf("image %d: load %lx size %lx offset %x: %s\n", i,
+			       img->load, img->size, img->offset,
+			       img->description);
+		}
+	}
+
+	return 0;
+}
+
+static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct upl s_upl, *upl = &s_upl;
+	struct unit_test_state uts;
+	struct abuf buf;
+	oftree tree;
+	ulong addr;
+	int ret;
+
+	upl_get_test_data(&uts, upl);
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
+U_BOOT_LONGHELP(upl,
+	"info [-v]     - Check UPL status\n"
+	"upl read <addr>   - Read handoff information\n"
+	"upl write         - Write handoff information");
+
+U_BOOT_CMD_WITH_SUBCMDS(upl, "Universal Payload support", upl_help_text,
+	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_upl_info),
+	U_BOOT_SUBCMD_MKENT(read, 2, 1, do_upl_read),
+	U_BOOT_SUBCMD_MKENT(write, 1, 1, do_upl_write));
diff --git a/doc/usage/cmd/upl.rst b/doc/usage/cmd/upl.rst
new file mode 100644
index 00000000000..a64063d42d5
--- /dev/null
+++ b/doc/usage/cmd/upl.rst
@@ -0,0 +1,186 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+upl command
+===========
+
+Synopsis
+--------
+
+::
+
+    upl write
+    upl read <addr>
+    upl info [-v]
+
+Description
+-----------
+
+The *upl* command is used to test U-Boot's support for the Universal Payload
+Specification (UPL) firmware standard. It allows creation of a fake handoff for
+use in testing.
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
+upl info
+~~~~~~~~
+
+Show basic information about usage of UPL:
+
+    UPL state
+        active or inactive (indicates whether U-Boot booted from UPL or not)
+
+    fit
+        Address of the FIT which was loaded
+
+    conf_offset 2a4
+        FIT offset of the chosen configuration
+
+For each image the following information is shown:
+
+    Image number
+        Images are numbered from 0
+
+    load
+        Address to which the image was loaded
+
+    size
+        Size of the loaded image
+
+    offset
+        FIT offset of the image
+
+    description
+        Description of the image
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
+
+This shows getting basic information about UPL:
+
+    => upl info -v
+    UPL state: active
+    fit 1264000
+    conf_offset 2a4
+    image 0: load 200000 size 105f5c8 offset a4: U-Boot 2024.07-00770-g739ee12e8358 for sandbox board
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 2f211f748ab..43f8588e695 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -112,6 +112,7 @@ Shell commands
    cmd/tftpput
    cmd/trace
    cmd/true
+   cmd/upl
    cmd/ums
    cmd/unbind
    cmd/ut
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index aa336d63e3a..98d822530d8 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -30,6 +30,7 @@
 
 struct acpi_ctx;
 struct driver_rt;
+struct upl;
 
 typedef struct global_data gd_t;
 
@@ -491,6 +492,12 @@ struct global_data {
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
@@ -590,6 +597,14 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
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
index e9d92efd80d..c55f1d297d1 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -358,6 +358,46 @@ static int upl_test_base(struct unit_test_state *uts)
 }
 UPL_TEST(upl_test_base, 0);
 
+/* Test 'upl info' command */
+static int upl_test_info(struct unit_test_state *uts)
+{
+	gd_set_upl(NULL);
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
+UPL_TEST(upl_test_info, UT_TESTF_CONSOLE_REC);
+
+/* Test 'upl read' and 'upl_write' commands */
+static int upl_test_read_write(struct unit_test_state *uts)
+{
+	ulong addr;
+
+	if (!CONFIG_IS_ENABLED(OFNODE_MULTI_TREE))
+		return -EAGAIN;  /* skip test */
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
+UPL_TEST(upl_test_read_write, UT_TESTF_CONSOLE_REC);
+
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
-- 
2.34.1

