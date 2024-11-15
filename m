Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06913D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC9889710;
	Sat, 16 Nov 2024 00:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dGtaGpRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD6389710; Sat, 16 Nov 2024 00:20:21 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CFD8970A
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83abdaf8a26so77017239f.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712817; x=1732317617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2EviHwt1Y0wfv1srjFSYZBWL2gCgpBiG+PvzgjjjWk=;
 b=dGtaGpRl4A7ZaXuZwf9O1yDtWYixDsRx1vW1mfW0YoPT6z+/opfngRWiR/FRR0BlbV
 5i3WoHqR1suERvFvlrhAVWmDqyHgu8R+mXeYmEo6LnkzALXLuC2mqfjnuJ6b5Rgb7p+p
 Bpe5LVdVffQuAzZ/XjSTn3IQcAvo3evbfAnAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712817; x=1732317617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2EviHwt1Y0wfv1srjFSYZBWL2gCgpBiG+PvzgjjjWk=;
 b=ruGBRrjLwBiiBJMQGvPHf7p8rhnhJtH7v4q4M3YrmVLuxezNaXtn2vLgAJuKM6y2m9
 xCAFT9/1KOTXsz/FmqrlLKLhbkCayHYXhqqpQ5fRpHWoqqoUYx7kH6GaSb08X+d7NBz8
 UoWIBWC77/pJ/8skXtZDlJNaSn7892P52pRC2G5VqWurgZjLwl8iQXWXB0C5RG7EpUw9
 W5O7jzKFNXwePJ71p8ACvqt5WW4TUtN3a9oGZ4+Sk9n+xi7lWxynYwNx4AXa14dvXVdN
 +hP3spD5HN1CUGpfqHSHLM6k/xtmo7wNpEaadq93gzXLrKnpIhPeyj24aAIu8QFm+96q
 MCqw==
X-Gm-Message-State: AOJu0YzhQGlLXcyZP26p6PoaqcjAD/mXwqFbOZ7K2Ro+DpoR0AlaYwSP
 WlAYOL0Go3bNrZPzGM+hqycxZm22FHzqnbu4eEeu86ArbCJRKFRvLE5WefNYU/rY78d1Uwl0+do
 =
X-Google-Smtp-Source: AGHT+IE2Zz/tYBM4D1I/3nPjSdNtzJEAJaXs6Ug5oxWwEokUOlnJTj9pzylRDq3iWC7fBqlkqaC3NA==
X-Received: by 2002:a05:6602:2d87:b0:835:3a11:7946 with SMTP id
 ca18e2360f4ac-83e6c2b32eamr499817539f.4.1731712817021; 
 Fri, 15 Nov 2024 15:20:17 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shantur Rathore <i@shantur.com>, Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH v4 16/19] bootstd: Add a simple command to list images
Date: Fri, 15 Nov 2024 16:19:23 -0700
Message-Id: <20241115231926.211999-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

Add a new 'bootstd images' command, which lists the images which have
been loaded.

Update some existing tests to use it. Provide some documentation about
images in general and this command in particular.

Use a more realistic kernel command-line to make the test easier to
follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c                  |  12 ++++
 cmd/Kconfig                      |   9 +++
 cmd/Makefile                     |   1 +
 cmd/bootstd.c                    |  65 +++++++++++++++++++
 doc/develop/bootstd/overview.rst |  21 +++++-
 doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++++++
 doc/usage/index.rst              |   1 +
 include/bootflow.h               |   8 +++
 test/boot/bootflow.c             | 106 +++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py         |   3 +-
 10 files changed, 303 insertions(+), 2 deletions(-)
 create mode 100644 cmd/bootstd.c
 create mode 100644 doc/usage/cmd/bootstd.rst

diff --git a/boot/bootflow.c b/boot/bootflow.c
index a10d3012b48..58a1afa7a75 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -997,3 +997,15 @@ struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
 
 	return ptr;
 }
+
+int bootflow_get_seq(const struct bootflow *bflow)
+{
+	struct bootstd_priv *std;
+	int ret;
+
+	ret = bootstd_get_priv(&std);
+	if (ret)
+		return ret;
+
+	return alist_calc_index(&std->bootflows, bflow);
+}
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b2d0348fe30..85af8f7f234 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -321,6 +321,15 @@ config CMD_BOOTMETH
 
 	  This command is not necessary for bootstd to work.
 
+config CMD_BOOTSTD
+	bool "bootstd"
+	depends on BOOTSTD
+	default y if BOOTSTD_FULL
+	help
+	  Provide general information and control for bootstd.
+
+	  This command is not necessary for bootstd to work.
+
 config BOOTM_EFI
 	bool "Support booting UEFI FIT images"
 	depends on EFI_BINARY_EXEC && CMD_BOOTM && FIT
diff --git a/cmd/Makefile b/cmd/Makefile
index d1f369deec0..c0b0ff8b742 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_BLK) += blk_common.o
 obj-$(CONFIG_CMD_BOOTDEV) += bootdev.o
 obj-$(CONFIG_CMD_BOOTFLOW) += bootflow.o
 obj-$(CONFIG_CMD_BOOTMETH) += bootmeth.o
+obj-$(CONFIG_CMD_BOOTSTD) += bootstd.o
 obj-$(CONFIG_CMD_SOURCE) += source.o
 obj-$(CONFIG_CMD_BCB) += bcb.o
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
diff --git a/cmd/bootstd.c b/cmd/bootstd.c
new file mode 100644
index 00000000000..e1d82744eb5
--- /dev/null
+++ b/cmd/bootstd.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * 'bootstd' command
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <bootdev.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <bootstd.h>
+#include <command.h>
+#include <dm.h>
+#include <malloc.h>
+#include <dm/uclass-internal.h>
+
+static int do_bootstd_images(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	const struct bootflow *bflow;
+	struct bootstd_priv *std;
+	int ret, i;
+
+	ret = bootstd_get_priv(&std);
+	if (ret) {
+		printf("Cannot get bootstd (err=%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Seq  Bootflow             Type                  At      Size  Filename\n");
+	printf("---  -------------------  --------------  --------  --------  ----------------\n");
+
+	/*
+	 * Use the ordering if we have one, so long as we are not trying to list
+	 * all bootmethds
+	 */
+	i = 0;
+	alist_for_each(bflow, &std->bootflows) {
+		const struct bootflow_img *img;
+
+		alist_for_each(img, &bflow->images) {
+			printf("%3d  %-20.20s %-15.15s ",
+			       bootflow_get_seq(bflow), bflow->name,
+			       bootflow_img_type_name(img->type));
+			if (img->addr)
+				printf("%8lx", img->addr);
+			else
+				printf("%8s", "-");
+			printf("  %8lx  %s\n", img->size, img->fname);
+			i++;
+		}
+	}
+
+	printf("---  -------------------  --------------  --------  --------  ----------------\n");
+	printf("(%d image%s)\n", i, i != 1 ? "s" : "");
+
+	return 0;
+}
+
+U_BOOT_LONGHELP(bootstd,
+	"images      - list loaded images");
+
+U_BOOT_CMD_WITH_SUBCMDS(bootstd, "Standard-boot operation", bootstd_help_text,
+	U_BOOT_SUBCMD_MKENT(images, 1, 1, do_bootstd_images));
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index a2913cd47be..e3ce97cc4f5 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -453,7 +453,7 @@ drivers are bound automatically.
 Command interface
 -----------------
 
-Three commands are available:
+Four commands are available:
 
 `bootdev`
     Allows listing of available bootdevs, selecting a particular one and
@@ -468,6 +468,25 @@ Three commands are available:
     Allow listing of available bootmethds, setting the order in which they are
     tried and bootmeth specific configuration. See :doc:`/usage/cmd/bootmeth`
 
+`bootstd`
+    Allow access to standard boot itself, so far only for listing images across
+    all bootflows. See :doc:`/usage/cmd/bootstd`
+
+Images
+------
+
+Standard boot keeps track of images which can or have been loaded. These are
+kept in a list attached to each bootflow. They can be listed using the
+``bootstd images`` command (see :doc:`/usage/cmd/bootstd`).
+
+For now most bootmeths load their images when scanning. Over time, some may
+adjust to load them only when needed, but in this case the images will still
+be visible.
+
+Once a bootflow has been selected, images for those that are not selected can
+potentially be dropped from the memory map. For now, this is not implemented.
+
+
 .. _BootflowStates:
 
 Bootflow states
diff --git a/doc/usage/cmd/bootstd.rst b/doc/usage/cmd/bootstd.rst
new file mode 100644
index 00000000000..7d933852a91
--- /dev/null
+++ b/doc/usage/cmd/bootstd.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: bootstd (command)
+
+bootstd command
+===============
+
+Synopsis
+--------
+
+::
+
+    bootstd images
+
+Description
+-----------
+
+The `bootstd` command is used to manage standard boot. At present the only
+functionality available is to look at the images which have been loaded, or
+could be loaded should a particular bootflow be selected.
+
+See :doc:`/develop/bootstd/index` for more information.
+
+bootflow images
+~~~~~~~~~~~~~~~
+
+Lists the available images and their location in memory.
+
+Example
+-------
+
+This shows listing images attached to various bootflows, then checking the
+content of a few of them::
+
+    => bootflow scan
+    => bootflow list
+    Showing all bootflows
+    Seq  Method       State   Uclass    Part  Name                      Filename
+    ---  -----------  ------  --------  ----  ------------------------  ----------------
+      0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf
+      1  script       ready   mmc          1  mmc4.bootdev.part_1       /boot/boot.scr
+      2  cros         ready   mmc          2  mmc5.bootdev.part_2
+      3  cros         ready   mmc          4  mmc5.bootdev.part_4
+    ---  -----------  ------  --------  ----  ------------------------  ----------------
+    (4 bootflows, 4 valid)
+    =>
+    => bootstd images
+    Seq  Bootflow             Type                  At      Size  Filename
+    ---  -------------------  --------------  --------  --------  ----------------
+      0  mmc1.bootdev.part_1  extlinux_cfg     8ed5a70       253  /extlinux/extlinux.conf
+      1  mmc4.bootdev.part_1  script           8ed9550       c73  /boot/boot.scr
+      1  mmc4.bootdev.part_1  logo             8eda2a0      5d42  boot.bmp
+      2  mmc5.bootdev.part_2  x86_setup        8ee84d0      3000  setup
+      2  mmc5.bootdev.part_2  cmdline          8ee84d0      1000  cmdline
+      2  mmc5.bootdev.part_2  kernel                 -      4000  kernel
+      3  mmc5.bootdev.part_4  x86_setup        8eeb4e0      3000  setup
+      3  mmc5.bootdev.part_4  cmdline          8eeb4e0      1000  cmdline
+      3  mmc5.bootdev.part_4  kernel                 -      4000  kernel
+    ---  -------------------  --------------  --------  --------  ----------------
+    (9 images)
+    => md 8eda2a0 10
+    08eda2a0: 5d424d42 00000000 008a0000 007c0000  BMB]..........|.
+    08eda2b0: 00ac0000 002e0000 00010000 00000018  ................
+    08eda2c0: 5cb80000 0b130000 0b130000 00000000  ...\............
+    08eda2d0: 00000000 00000000 ff0000ff 00ff0000  ................
+    => md 8ee84d0 10
+    08ee84d0: 544f4f42 414d495f 2f3d4547 696c6d76  BOOT_IMAGE=/vmli
+    08ee84e0: 2d7a756e 35312e35 312d302e 672d3132  nuz-5.15.0-121-g
+    08ee84f0: 72656e65 72206369 3d746f6f 7665642f  eneric root=/dev
+    08ee8500: 6d766e2f 316e3065 72203170 7571206f  /nvme0n1p1 ro qu
+
+Return value
+------------
+
+The return value $? is always 0 (true).
+
+
+.. BootflowStates_:
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index cb7a23f1170..71970d5f2b3 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -40,6 +40,7 @@ Shell commands
    cmd/bootm
    cmd/bootmenu
    cmd/bootmeth
+   cmd/bootstd
    cmd/bootz
    cmd/button
    cmd/cat
diff --git a/include/bootflow.h b/include/bootflow.h
index e09cff285e4..480cf8a5af1 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -627,5 +627,13 @@ const char *bootflow_img_type_name(enum bootflow_img_t type);
 struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
 				      enum bootflow_img_t type, ulong addr,
 				      ulong size);
+/**
+ * bootflow_get_seq() - Get the sequence number of a bootflow
+ *
+ * Bootflows are numbered by their position in the bootstd list.
+ *
+ * Return: Sequence number of bootflow (0 = first)
+ */
+int bootflow_get_seq(const struct bootflow *bflow);
 
 #endif
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 9397328609d..14de5b591dd 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -15,6 +15,7 @@
 #include <efi.h>
 #include <efi_loader.h>
 #include <expo.h>
+#include <mapmem.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
 #endif
@@ -77,6 +78,14 @@ static int bootflow_cmd(struct unit_test_state *uts)
 	ut_assert_nextline("(1 bootflow, 1 valid)");
 	ut_assert_console_end();
 
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
+	ut_assert_nextlinen("---");
+	ut_assert_nextline("(1 image)");
+	ut_assert_console_end();
+
 	return 0;
 }
 BOOTSTD_TEST(bootflow_cmd, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
@@ -1193,6 +1202,19 @@ static int bootflow_cros(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
 
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
+	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  x86_setup");
+	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  cmdline");
+	ut_assert_nextlinen("  1  mmc5.bootdev.part_2  kernel                 -      4000  kernel");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  x86_setup");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  cmdline");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_4  kernel                 -      4000  kernel");
+	ut_assert_nextlinen("---");
+	ut_assert_nextline("(7 images)");
+
 	ut_assert_console_end();
 
 	return 0;
@@ -1284,3 +1306,87 @@ static int bootflow_efi(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
+
+/* Check 'bootflow scan' provides a list of images */
+static int bootstd_images(struct unit_test_state *uts)
+{
+	static const char *order[] = {"mmc2", "mmc1", "mmc4", "mmc5", NULL};
+	const struct legacy_img_hdr *hdr;
+	const struct bootflow_img *img;
+	const struct bootflow *bflow;
+	struct bootstd_priv *std;
+	const char **old_order;
+	struct udevice *dev;
+	ofnode root, node;
+	ulong data, len;
+	char *ptr;
+
+	/* get access to the current bootflow */
+	ut_assertok(bootstd_get_priv(&std));
+
+	ut_assertok(prep_mmc_bootdev(uts, "mmc4", true, &old_order));
+
+	/* bind mmc5 too, for cros */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc5");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	std->bootdev_order = order;
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+	std->bootdev_order = old_order;
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_skip_to_line("(4 bootflows, 4 valid)");
+
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  mmc1.bootdev.part_1  extlinux_cfg");
+	ut_assert_nextlinen("  1  mmc4.bootdev.part_1  script");
+	ut_assert_nextlinen("  1  mmc4.bootdev.part_1  logo");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  x86_setup");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  cmdline");
+	ut_assert_nextlinen("  2  mmc5.bootdev.part_2  kernel                 -");
+	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  x86_setup");
+	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  cmdline");
+	ut_assert_nextlinen("  3  mmc5.bootdev.part_4  kernel                 -");
+	ut_assert_nextlinen("---");
+	ut_assert_nextline("(9 images)");
+
+	/* check the first image */
+	bflow = alist_get(&std->bootflows, 0, struct bootflow);
+	img = alist_get(&bflow->images, 0, struct bootflow_img);
+	ut_asserteq_strn("# extlinux.conf", map_sysmem(img->addr, 0));
+
+	/* check the second image */
+	bflow = alist_get(&std->bootflows, 1, struct bootflow);
+	img = alist_get(&bflow->images, 0, struct bootflow_img);
+
+	/* this is the length of the script in bytes */
+	hdr = map_sysmem(img->addr, 0);
+	image_multi_getimg(hdr, 0, &data, &len);
+	ptr = (void *)data;
+	ut_asserteq_strn("# DO NOT EDIT THIS FILE", ptr);
+
+	/* check the ChromiumOS images */
+	bflow = alist_get(&std->bootflows, 2, struct bootflow);
+	img = alist_get(&bflow->images, 1, struct bootflow_img);
+	ptr = map_sysmem(img->addr, 0);
+	ut_asserteq_strn("BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=", ptr);
+
+	/*
+	 * the x86 setup is not a real binary, so just check that it is empty,
+	 * so that if this changes in the future someone will notice and update
+	 * this test
+	 */
+	img = alist_get(&bflow->images, 0, struct bootflow_img);
+	ptr = map_sysmem(img->addr, 0);
+	ut_asserteq(0, *(ulong *)ptr);
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6d44191976b..1ca9ecccb06 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -402,9 +402,10 @@ def setup_cros_image(cons):
         start, size, num, name = line.split(maxsplit=3)
         parts[int(num)] = Partition(int(start), int(size), name)
 
+    # Set up the kernel command-line
     dummy = os.path.join(cons.config.result_dir, 'dummy.txt')
     with open(dummy, 'wb') as outf:
-        outf.write(b'dummy\n')
+        outf.write(b'BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=/dev/nvme0n1p1 ro quiet splash vt.handoff=7')
 
     # For now we just use dummy kernels. This limits testing to just detecting
     # a signed kernel. We could add support for the x86 data structures so that
-- 
2.34.1

