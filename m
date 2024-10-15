Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B61D216A3
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C1988875;
	Tue, 15 Oct 2024 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nc+fQ8Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB01188969; Tue, 15 Oct 2024 15:33:20 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5616D88770
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83549342f09so150784539f.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999197; x=1729603997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmSmVldIOrPikNxhJvbEq1J5cIjz080pfbl2D4cUV94=;
 b=Nc+fQ8Z0GRDP4nMhQAjsJD4AmVbjdKsmDFrkP4beGq82CFhrEBHkrfhhbGWwQmjVaq
 iUkZwNNHtrAc8gUPoV8ihtlj9cL9KvrJfbpkVL5m4KRYtCFjXaQPTCtea2/qwLuztFvU
 AD4zKQD3OAsHbgChhSTH0gtE9rKXJLNXIEOX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999197; x=1729603997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmSmVldIOrPikNxhJvbEq1J5cIjz080pfbl2D4cUV94=;
 b=dZWDTmhu9ONVSB58VwfQ/QA5o9vX2nMNoRiim+mu4vdwdaKm2M0Io+8ZEerW5ZGcg7
 3z581/flPNc8trrZKVtd1UhWIXQtJ9lLeQEQm/cUADe1Rht1obFWBXXY8BWVXQlX8rl+
 m8/pllj7eIVkTB2Zow+jVxiQEerw3r25+LEn5g81nH5xl7J0AtvmTeWy0FvZLt4zbqXJ
 ebZRq84Bnsqi/BQWFEOM8TZKlBFKtNlHQ1OQJ2dJdeQblM7argxjlVTQmSQ6XhYRZgKz
 FJVq+As54JIL6t+B2qDaPlWuzPmETdky9vB2ZKVXxMY+YhLO67TQ+uANPfatdhY4MIV1
 jXDw==
X-Gm-Message-State: AOJu0Yws4vkXO6F7DkHZB4WUsI/GM72iwq3P++X0hHVVlHITdRIgzRvV
 ssoLTnGlykCXfGG09WQoBBf4VbmCx/Smq7kafP9pnFbDuPcWj9oY3wXN6QhJ+Pqm+lqpr5FgajJ
 jzA==
X-Google-Smtp-Source: AGHT+IEbwYr4IA65R2b0hVoiiBKH6p2SsQ/aLm3HaH9UAcGk0y+RItHynRGXUfhoDOgJ3l89AqAKYw==
X-Received: by 2002:a6b:3106:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-83a94285c2amr33807939f.5.1728999196877; 
 Tue, 15 Oct 2024 06:33:16 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v3 7/7] cmd: Update the meminfo command to show the memory map
Date: Tue, 15 Oct 2024 07:33:04 -0600
Message-Id: <20241015133304.2874735-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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
index 2fd29e9fa88..fd8060c2c34 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -882,6 +882,17 @@ config CMD_MEMINFO
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
index 70563374899..3939add8eaf 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -83,6 +83,7 @@ Shell commands
    cmd/loads
    cmd/loadx
    cmd/loady
+   cmd/meminfo
    cmd/mbr
    cmd/md
    cmd/mmc
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..0f1c8d77dd9 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -18,8 +18,9 @@ obj-$(CONFIG_CMD_FDT) += fdt.o
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
2.34.1

