Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134C5CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D531888FED;
	Wed,  9 Oct 2024 03:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oCsy1IsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DE889005; Wed,  9 Oct 2024 03:50:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D41D88FD1
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a2761f1227so21776875ab.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438636; x=1729043436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWXPOLBTD2wxpA+yBPtFoJO0wglIGPPhghyQLXWxU8Y=;
 b=oCsy1IsTb9SUTStYM1+MMFM0Lygc0x3hEj9Yj228IzYaBPGr0c6tYYdVD/21yu/yZU
 bxRhlNc8TzOL+B2vMT1DQTeQ/IDfqIuaWH4D5vhGG+5lRMfbq5jiXIyQqcKS9wya3xQE
 7sMOYS15dR38iYrdZXc7sVefm7wBLgA6AlmIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438636; x=1729043436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWXPOLBTD2wxpA+yBPtFoJO0wglIGPPhghyQLXWxU8Y=;
 b=bZ0XNMWLRl/Vzz4Pe6lfIBPHzo17bCyh5NfE/fC/7uTf1tu6exvVJUasjQCepCbO77
 1EudjkFkULFevsmPf+5SiBmJHCETl4hRdcHdeuQ39lA5X10vMQ9aICRF31y8IKw7CaGz
 VkW9j3+Yo+TYj5XmCyUW+0ag8AjtMr5ggx/Yrt0MtHlobV9fFHO/407fviBs/LnvtsyO
 v8ARWPPkD/YV8qIbTmC3GTJaCywt4rVQMkNaaX3mTZb1pnXx1b39/ecQieWrf5w4kUix
 ODBth+XWIXiqEM9xw1X5DrHpcvY1XboGpgJZGYxvZFC5GDtN1UCPVk9G05lKyqmfV1OZ
 jVNA==
X-Gm-Message-State: AOJu0YxVDKMUGCQxlElJK/ZkBG/SCcYr7pjvEbfR+XewX7rV3gv8SLq3
 vj7XwHV16lMlKbZqadMmVpG8cJzKEBN2nd/ojMQBDrgdoVryukHaK6IC61LTpte3n7QNYNJqvrG
 Jlw==
X-Google-Smtp-Source: AGHT+IH1rs2ouic2YQ9h4rM0f5x6TK+4WY5qmjKcQIgNo8SUagIUokx4tzPmQG/z83u7TPJiP2cj9w==
X-Received: by 2002:a05:6e02:20e3:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a397ce6ac7mr10223305ab.10.1728438636499; 
 Tue, 08 Oct 2024 18:50:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH 6/6] cmd: Add a command to show the memory map
Date: Tue,  8 Oct 2024 19:50:18 -0600
Message-ID: <20241009015020.25817-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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

Add a 'memmap' command which shows it. This command does not cover
arch-specific pieces but gives a good overview of where things are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig              |  10 ++++
 cmd/Makefile             |   1 +
 cmd/memmap.c             |  66 +++++++++++++++++++++
 doc/usage/cmd/memmap.rst | 123 +++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst      |   1 +
 test/cmd/Makefile        |   3 +-
 test/cmd/memmap.c        |  35 +++++++++++
 7 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 cmd/memmap.c
 create mode 100644 doc/usage/cmd/memmap.rst
 create mode 100644 test/cmd/memmap.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index dd33266cec7..d4a29217323 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -921,6 +921,16 @@ config CMD_MEM_SEARCH
 	  pressing return will show the next 10 matches. Environment variables
 	  are set for use with scripting (memmatches, memaddr, mempos).
 
+config CMD_MEMMAP
+	bool "memmap - Memory map"
+	default y if SANDBOX
+	help
+	  memmap command
+
+	  This shows the location of areas of memory used by U-Boot. This includes
+	  the malloc() region, U-Boot's code and data, bloblist and anything else
+	  that prevents a particular region being used for loading images.
+
 config CMD_MX_CYCLIC
 	bool "Enable cyclic md/mw commands"
 	depends on CMD_MEMORY
diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249c..4f05dafaaad 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -109,6 +109,7 @@ obj-y += load.o
 obj-$(CONFIG_CMD_LOG) += log.o
 obj-$(CONFIG_CMD_LSBLK) += lsblk.o
 obj-$(CONFIG_CMD_MD5SUM) += md5sum.o
+obj-$(CONFIG_CMD_MEMMAP) += memmap.o
 obj-$(CONFIG_CMD_MEMORY) += mem.o
 obj-$(CONFIG_CMD_IO) += io.o
 obj-$(CONFIG_CMD_MII) += mii.o
diff --git a/cmd/memmap.c b/cmd/memmap.c
new file mode 100644
index 00000000000..d83c04467e9
--- /dev/null
+++ b/cmd/memmap.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <bloblist.h>
+#include <bootstage.h>
+#include <command.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
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
+static int do_memmap(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	ulong upto, stk_bot;
+
+	printf("%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
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
+	print_region("malloc", mem_malloc_start,
+		     mem_malloc_end - mem_malloc_start, &upto);
+	print_region("board_info", map_to_sysmem(gd->bd),
+		     sizeof(struct bd_info), &upto);
+	print_region("global_data", map_to_sysmem(gd),
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
+	return 0;
+}
+
+U_BOOT_CMD(
+	memmap,	1, 1, do_memmap, "Show a map of U-Boot's memory usage", ""
+);
diff --git a/doc/usage/cmd/memmap.rst b/doc/usage/cmd/memmap.rst
new file mode 100644
index 00000000000..2f0888a9691
--- /dev/null
+++ b/doc/usage/cmd/memmap.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: memmap (command)
+
+memmap command
+==============
+
+Synopsis
+--------
+
+::
+
+    memmap
+
+Description
+-----------
+
+The memmap command shows the layout of memory used by U-Boot and the region
+which is free for use by images.
+
+The layout of memory is set up before relocation, within the init sequence in
+``board_init_f()``, specifically the various ``reserve_...()`` functions. This
+'reservation' of memory starts from the top of RAM and proceeds downwards,
+ending with the stack. This results in the maximum possible amount of memory
+being left free for image-loading.
+
+The memmap command writes its outputs in 5 columns:
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
+::
+
+    => memmap
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
index 70563374899..dd2b5807a4f 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -83,6 +83,7 @@ Shell commands
    cmd/loads
    cmd/loadx
    cmd/loady
+   cmd/memmap
    cmd/mbr
    cmd/md
    cmd/mmc
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..3f6ae59f3d4 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -18,8 +18,9 @@ obj-$(CONFIG_CMD_FDT) += fdt.o
 obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_LOADM) += loadm.o
-obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
+obj-$(CONFIG_CMD_MEMMAP) += memmap.o
 obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
+obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
diff --git a/test/cmd/memmap.c b/test/cmd/memmap.c
new file mode 100644
index 00000000000..f12d7174838
--- /dev/null
+++ b/test/cmd/memmap.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for 'memmap' command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <dm/test.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+/* Test 'memmap' command */
+static int cmd_test_memmap(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("memmap", 0));
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
+CMD_TEST(cmd_test_memmap, UTF_CONSOLE);
-- 
2.43.0

