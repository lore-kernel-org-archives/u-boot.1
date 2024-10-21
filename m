Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EF1D0E6C8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F9B89306;
	Mon, 21 Oct 2024 10:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="li5Fex0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9316E89308; Mon, 21 Oct 2024 10:19:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B1A8897F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso617517066b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498785; x=1730103585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQMQ4GwD1o/bLje7mGqxvMSkzlilSU3tpo+RHMnnDpo=;
 b=li5Fex0okMiR0pX0V+pJtnXgmD34LRJKIG3LqsIfTDdS4eA6anAX4oTkLjzWQK++tw
 1bofJmiPWln1/3sg5FEYkRzhNrCExLqdWCWmFX14gbWWDJe+tgr0gdFBXRwWYXHoMzqt
 U2ddd4W96BrY9cYQGAn5E7krbEukIpkd/5i8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498785; x=1730103585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQMQ4GwD1o/bLje7mGqxvMSkzlilSU3tpo+RHMnnDpo=;
 b=tZzaIs/na5tFimRDIOa6ONI2GiUlRMpA96naci4X/DotjsLxbbY04/Bld+Y8F0Dbrm
 7F540LrmVk0zTSqMgr5blXYa5dA6Y31qR2Eu5BC1kyIEG/mkVw7H1yzjC3PSGPT1SPNw
 4c5EkHYIsKTEOtqL2rrcEAkWQ4c3PiynF9awIrmG8r6/V+Fm20osJg7ZrTfERBNEGg0p
 Ht9F56zxW2iZq9OPB1NFrJ2lvSrjlaFxoKN6THEkxgQV3naWA9h0Ds9k5IH9zKhGf2l4
 p7oS1Ul0FX0zz/bCibZCo1nmVJvRtxdNDibZfjK3dqoaKfqbVBnXoMeawqarqr8HY4Qi
 Ksmg==
X-Gm-Message-State: AOJu0Yz5e+UM4lnebhmVlPHXotnZs8FgxwUnOjKoYNNUAOIcUag3YCqP
 z5Je9UhBjgi/3hBQHTfuQoMF2v+nq1LtY97nVpH3jqeG2hxwlQ52VqJ/kEYZUX2t7O5jUisOThx
 DdHA5
X-Google-Smtp-Source: AGHT+IEUi7tXfX3q+RHbFJTnrgGyTmO0I5vGAClUadVoMTxssGl7Y4eqY6c5oA63E+sYEhT1ELjldg==
X-Received: by 2002:a17:906:f594:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a9a69a79c72mr1227187866b.15.1729498784569; 
 Mon, 21 Oct 2024 01:19:44 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v4 6/8] cmd: Update the meminfo command to show the memory map
Date: Mon, 21 Oct 2024 10:19:30 +0200
Message-ID: <20241021081934.289473-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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

U-Boot has a fairly rigid memory map which is normally not visible
unless debugging is enabled in board_f.c

Update the 'meminfo' command to show it. This command does not cover
arch-specific pieces but gives a good overview of where things are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Drop am65x patch as it is not needed

Changes in v3:
- Add a new Kconfig for the extra functionality

Changes in v2:
- Modify the existing 'meminfo' command instead

 cmd/Kconfig               |  11 ++++
 cmd/meminfo.c             |  51 ++++++++++++++-
 doc/usage/cmd/meminfo.rst | 128 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 test/cmd/Makefile         |   3 +-
 test/cmd/meminfo.c        |  38 +++++++++++
 6 files changed, 230 insertions(+), 2 deletions(-)
 create mode 100644 doc/usage/cmd/meminfo.rst
 create mode 100644 test/cmd/meminfo.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 05bd3e8a5e2..2c5188daff2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -889,6 +889,17 @@ config CMD_MEMINFO
 	help
 	  Display memory information.
 
+config CMD_MEMINFO_MAP
+	bool "- with memory map"
+	depends on CMD_MEMINFO
+	default y if SANDBOX
+	help
+	  Shows a memory map, in addition to just the DRAM size. This allows
+	  seeing where U-Boot's memory area is, at the top of DRAM, as well as
+	  detail about each piece of it.
+
+	  See doc/usage/cmd/meminfo.rst for more information.
+
 config CMD_MEMORY
 	bool "md, mm, nm, mw, cp, cmp, base, loop"
 	default y
diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index bb9bcec2e3f..0e6d2f9cc2c 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -4,18 +4,67 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <bloblist.h>
+#include <bootstage.h>
 #include <command.h>
 #include <display_options.h>
+#include <malloc.h>
+#include <mapmem.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
+{
+	ulong end = base + size;
+
+	printf("%-12s %8lx %8lx %8lx", name, base, size, end);
+	if (*uptop)
+		printf(" %8lx", *uptop - end);
+	putc('\n');
+	*uptop = base;
+}
+
 static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
-		       char *const argv[])
+		      char *const argv[])
 {
+	ulong upto, stk_bot;
+
 	puts("DRAM:  ");
 	print_size(gd->ram_size, "\n");
 
+	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
+		return 0;
+
+	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
+	       "Gap");
+	printf("------------------------------------------------\n");
+	upto = 0;
+	if (IS_ENABLED(CONFIG_VIDEO))
+		print_region("video", gd_video_bottom(),
+			     gd_video_size(), &upto);
+	if (IS_ENABLED(CONFIG_TRACE))
+		print_region("trace", map_to_sysmem(gd_trace_buff()),
+			     gd_trace_size(), &upto);
+	print_region("code", gd->relocaddr, gd->mon_len, &upto);
+	print_region("malloc", map_to_sysmem((void *)mem_malloc_start),
+		     mem_malloc_end - mem_malloc_start, &upto);
+	print_region("board_info", map_to_sysmem(gd->bd),
+		     sizeof(struct bd_info), &upto);
+	print_region("global_data", map_to_sysmem((void *)gd),
+		     sizeof(struct global_data), &upto);
+	print_region("devicetree", map_to_sysmem(gd->fdt_blob),
+		     fdt_totalsize(gd->fdt_blob), &upto);
+	if (IS_ENABLED(CONFIG_BOOTSTAGE))
+		print_region("bootstage", map_to_sysmem(gd_bootstage()),
+			     bootstage_get_size(false), &upto);
+	if (IS_ENABLED(CONFIG_BLOBLIST))
+		print_region("bloblist", map_to_sysmem(gd_bloblist()),
+			     bloblist_get_total_size(), &upto);
+	stk_bot = gd->start_addr_sp - CONFIG_STACK_SIZE;
+	print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
+	print_region("free", gd->ram_base, stk_bot, &upto);
+
 	return 0;
 }
 
diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
new file mode 100644
index 00000000000..6c94493cccc
--- /dev/null
+++ b/doc/usage/cmd/meminfo.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: meminfo (command)
+
+meminfo command
+===============
+
+Synopsis
+--------
+
+::
+
+    meminfo
+
+Description
+-----------
+
+The meminfo command shows the amount of memory. If ``CONFIG_CMD_MEMINFO_MAP`` is
+enabled, then it also shows the layout of memory used by U-Boot and the region
+which is free for use by images.
+
+The layout of memory is set up before relocation, within the init sequence in
+``board_init_f()``, specifically the various ``reserve_...()`` functions. This
+'reservation' of memory starts from the top of RAM and proceeds downwards,
+ending with the stack. This results in the maximum possible amount of memory
+being left free for image-loading.
+
+The meminfo command writes the DRAM size, then the rest of its outputs in 5
+columns:
+
+Region
+   Name of the region
+
+Base
+    Base address of the region, i.e. where it starts in memory
+
+Size
+    Size of the region, which may be a little smaller than the actual size
+    reserved, e.g. due to alignment
+
+End
+    End of the region. The last byte of the region is one lower than the address
+    shown here
+
+Gap
+    Gap between the end of this region and the base of the one above
+
+Regions shown are:
+
+video
+    Memory reserved for video framebuffers. This reservation happens in the
+    bind() methods of all video drivers which are present before relocation,
+    so the size depends on that maximum amount of memory which all such drivers
+    want to reserve. This may be significantly greater than the amount actually
+    needed, if the display is ultimately set to a smaller resolution or colour
+    depth than the maximum supported.
+
+code
+    U-Boot's code and Block-Starting Symbol (BSS) region. Before relocation,
+    U-Boot copies its code to a high region and sets up a BSS immediately after
+    that. The size of this region is generally therefore ``__bss_end`` -
+    ``__image_copy_start``
+
+malloc
+    Contains the malloc() heap. The size of this is set by
+    ``CONFIG_SYS_MALLOC_LEN``.
+
+board_info
+    Contains the ``bd_info`` structure, with some information about the current
+    board.
+
+global_data
+    Contains the global-data structure, pointed to by ``gd``. This includes
+    various pointers, values and flags which control U-Boot.
+
+devicetree
+    Contains the flatted devicetree blob (FDT) being used by U-Boot to configure
+    itself and its devices.
+
+bootstage
+    Contains the bootstage records, which keep track of boot time as U-Boot
+    executes. The size of this is determined by
+    ``CONFIG_BOOTSTAGE_RECORD_COUNT``, with each record taking approximately
+    32 bytes.
+
+bloblist
+    Contains the bloblist, which is a list of tables and other data created by
+    U-Boot while executed. The size of this is determined by
+    ``CONFIG_BLOBLIST_SIZE``.
+
+stack
+    Contains U-Boot's stack, growing downwards from the top. The nominal size of
+    this region is set by ``CONFIG_STACK_SIZE`` but there is no actual limit
+    enforced, so the stack can grow behind that. Images should be loaded lower
+    in memory to avoid any conflict.
+
+free
+    Free memory, which is available for loading images. The base address of
+    this is ``gd->ram_base`` which is generally set by ``CFG_SYS_SDRAM_BASE``.
+
+Example
+-------
+
+This example shows output with both ``CONFIG_CMD_MEMINFO`` and
+``CONFIG_CMD_MEMINFO_MAP`` enabled::
+
+    => meminfo
+    DRAM:  256 MiB
+
+    Region           Base     Size      End      Gap
+    ------------------------------------------------
+    video         f000000  1000000 10000000
+    code          ec3a000   3c5d28  efffd28      2d8
+    malloc        8c38000  6002000  ec3a000        0
+    board_info    8c37f90       68  8c37ff8        8
+    global_data   8c37d80      208  8c37f88        8
+    devicetree    8c33000     4d7d  8c37d7d        3
+    bootstage     8c32c20      3c8  8c32fe8       18
+    bloblist      8c32000      400  8c32400      820
+    stack         7c31ff0  1000000  8c31ff0       10
+    free                0  7c31ff0  7c31ff0        0
+
+
+Return value
+------------
+
+The return value $? is always 0 (true).
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index b84d8ee909f..db71711c393 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -84,6 +84,7 @@ Shell commands
    cmd/loads
    cmd/loadx
    cmd/loady
+   cmd/meminfo
    cmd/mbr
    cmd/md
    cmd/mmc
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 40808350962..4b487c1d2cb 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -19,8 +19,9 @@ obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
-obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
+obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
new file mode 100644
index 00000000000..84981305bf0
--- /dev/null
+++ b/test/cmd/meminfo.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for 'meminfo' command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Test 'meminfo' command */
+static int cmd_test_meminfo(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("meminfo", 0));
+	ut_assert_nextline("DRAM:  256 MiB");
+	ut_assert_nextline_empty();
+
+	ut_assert_nextline("Region           Base     Size      End      Gap");
+	ut_assert_nextlinen("-");
+
+	/* For now we don't worry about checking the values */
+	ut_assert_nextlinen("video");
+	ut_assert_nextlinen("code");
+	ut_assert_nextlinen("malloc");
+	ut_assert_nextlinen("board_info");
+	ut_assert_nextlinen("global_data");
+	ut_assert_nextlinen("devicetree");
+	ut_assert_nextlinen("bootstage");
+	ut_assert_nextlinen("bloblist");
+	ut_assert_nextlinen("stack");
+	ut_assert_nextlinen("free");
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
-- 
2.43.0

