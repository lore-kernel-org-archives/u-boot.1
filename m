Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034BCC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389C788B0F;
	Thu,  8 Aug 2024 00:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ly3wvVub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0081889BE; Thu,  8 Aug 2024 00:48:18 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70A7888A4
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39b4f847a5eso1406095ab.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070894; x=1723675694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mic3n0oUDhK1izTRIDDXGjO/P0V53izUkMjLAW4HVrw=;
 b=ly3wvVub0u3RBUD+18kMGUa6Fvm51obCItJytDX2EYs0h5n8/CPtMa2qAx+iup3hi3
 n+npKJd+/txfJYSNYlRiNIa57yz6j4JGYPOedgdPy6dkbNJOj2yWKdVZd/PpCoaBX1Yy
 w4wIas3/SdXZ2/2QR2lpqzMbxtn9Voy0q0CEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070894; x=1723675694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mic3n0oUDhK1izTRIDDXGjO/P0V53izUkMjLAW4HVrw=;
 b=mGepqbuk6dfGAYNVQ0CNtT0uoo7JSE/0+ingSCaLpEtNUakRn+7r4ZeAJ8J8PfMQtc
 PULBdvyUvGaCR4HiCw+sVvc2FoRJMSpmZ8pyPMIicP1+8k6nObAcc1+ZwYZDOdYZPJaH
 RGusiB3ZguSdmbm9zZA9METmO63ZGCZYSmyTZjt3/gZ3yvIK2vDtjBH3J7SPGXwX6+mz
 t2uLEA5XG/P5yG+SVIMXpvWPcIU1BOEYKYTW/rR6I94ClW5fvHE7tcPwX+ycjw3283GQ
 +sjPfELSqed5+XoW/VMWiaFOedPfadPsuqf6a6T6Vy8aZ6iPklq0Yx5IhgTsvmlCNCcJ
 0DAA==
X-Gm-Message-State: AOJu0Yy2mlDxUNUUpd6wzoMlJDWjtYqZTGNu5GqiI9BaHPdd5vMDY2B5
 7UdBPJ2WLps0eonhSCEPCBzEtUT+Luval6LsSa3crQggNIFv/D/XDDt4JbAY427Kxxwo1MWZxus
 =
X-Google-Smtp-Source: AGHT+IG+fFWMnYv8e0cE0I7ztukJGWv1cfLnkhFqAfrbInLAjLO6W+xqbwM7pPhAUgPIoIWoFHhFXw==
X-Received: by 2002:a05:6e02:b2e:b0:397:e9bf:2dec with SMTP id
 e9e14a558f8ab-39b5ec70cbbmr1221725ab.1.1723070894403; 
 Wed, 07 Aug 2024 15:48:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/21] upl: Add a command
Date: Wed,  7 Aug 2024 16:47:30 -0600
Message-Id: <20240807224739.3858517-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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
index acb92bd3f87..4d17c966053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1714,6 +1714,8 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
+F:	cmd/upl.c
+F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
 
diff --git a/boot/Kconfig b/boot/Kconfig
index d5f1304490b..e37b08bf391 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -747,6 +747,7 @@ config BOOTMETH_SCRIPT
 
 config UPL
 	bool "upl - Universal Payload Specification"
+	imply CMD_UPL
 	imply UPL_READ
 	imply UPL_WRITE
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..8af136d2bd4 100644
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
index 1f6518b77c4..4246c06d97d 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -114,6 +114,7 @@ Shell commands
    cmd/tftpput
    cmd/trace
    cmd/true
+   cmd/upl
    cmd/ums
    cmd/unbind
    cmd/ut
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 27aa75e7036..94d054ee54e 100644
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
index aa3fddcbb75..056ae54831b 100644
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

