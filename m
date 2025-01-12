Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C56CE7719E
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF66780619;
	Sun, 12 Jan 2025 23:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rMc2+MnY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vu5tnM1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E976080619; Sun, 12 Jan 2025 23:35:57 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB83A801F5
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YWVbb37mPz9scw;
 Sun, 12 Jan 2025 23:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGVTONTR7Boglcxbi73pTfYHV4sGDhdKw1TA5luu+Ck=;
 b=rMc2+MnYw+Jrx9fHjUbc49PpACcuFGDdt++gasuzPwwA/cYj+7Uo2dtEW1miRBMCEmXGMc
 dCv13pbqs4sTvtuCGrgBcIXUuLYESWSNNyifdKhe98XzpShfs8K+gh3/dWmm5Ztf5XQey9
 uVMZNmYPHYnnwr8H3Iz2phF+qrwQPyFefoYBU2WBw731EKpYJHz5bHc88/+6bDRNebUSG8
 mPUAiRo4QSsaCnlvHRE0o3ZFQ7t7n0cTUrzyH1HmvVvOkozWdkG6M2x8DDXY3RtuXZCliA
 0b5KfN/nA9pGswdCUVo5jsVGsrnoyNpdUrJT9m71ltZWhEjV2ah0Z8VaY81JfQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGVTONTR7Boglcxbi73pTfYHV4sGDhdKw1TA5luu+Ck=;
 b=Vu5tnM1N7P0GNr/tDjlAC7l2jET8afVaSynWSKe4EQ68+7jSHrkic9NEnGnvCvxzg59MuC
 0E+vhE45S0jiLjFhclVCWsgzbOZQFo7CB7ciEvEjzLmhF6K6tSOLV1g3kJcGqawuaXKfk3
 DYf9v817cnqCvu1v0GvnhLUOGg55MMtS3PgtMHSHZU7fBc8nqHz7oEQhwb4Ni4v2nLHjKN
 C0LS4sMVW428ad5ewetEBUHMGkb+62d62IV1yLkUgWvi/hG25V8eXnShNOrFG0fFm11fgD
 tHPk9Mbv/tSSmZFWL+Uo0K59OUS2NCO55kAkMxsEIPxY4NqUB/J79HVfRLvtRg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] ARM: renesas: Simplify board Makefiles
Date: Sun, 12 Jan 2025 23:34:21 +0100
Message-ID: <20250112223528.179828-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n33okjnf76h9gz8kz44pe93aoxdt8qbc
X-MBO-RS-ID: 08e5f00f576e57b5623
X-Rspamd-Queue-Id: 4YWVbb37mPz9scw
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

Introduce board/renesas/common/Makefile and remove the multiple
duplicate copies of obj := ../common/*.o from board Makefiles.
Let the build system include the common Makefile using the
HAVE_VENDOR_COMMON_LIB and build the common objects that are
shared by all the boards that way. No functional change intended.

Some of the remaining board files which include board specific
settings have been updated to use obj-y += to avoid rewriting
the board obj-y target and avoid dropping object files from the
build.

Board Makefiles cannot be empty, else they do not generate built-in.o,
move the CONFIG_XPL_BUILD ifdeffery from Makefiles into .c files to
make sure there is always a built-in.o generated from the remaining
minimal Makefiles. This will be further cleaned up in follow up patches.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/Makefile         | 45 +++++++++++++++++++++++++++
 board/renesas/common/gen3-common.c    |  3 --
 board/renesas/condor/Makefile         | 13 --------
 board/renesas/draak/Makefile          |  6 +---
 board/renesas/draak/draak.c           |  4 +++
 board/renesas/eagle/Makefile          | 13 --------
 board/renesas/ebisu/Makefile          | 13 --------
 board/renesas/falcon/Makefile         | 13 --------
 board/renesas/grayhawk/Makefile       |  9 ------
 board/renesas/salvator-x/Makefile     |  6 +---
 board/renesas/salvator-x/salvator-x.c |  4 +++
 board/renesas/spider/Makefile         |  9 ------
 board/renesas/ulcb/Makefile           |  6 +---
 board/renesas/ulcb/cpld.c             |  4 +++
 board/renesas/ulcb/ulcb.c             |  4 +++
 board/renesas/v3hsk/Makefile          |  5 ---
 board/renesas/v3hsk/cpld.c            |  4 +++
 board/renesas/v3msk/Makefile          |  5 ---
 board/renesas/v3msk/cpld.c            |  4 +++
 board/renesas/whitehawk/Makefile      | 13 --------
 20 files changed, 72 insertions(+), 111 deletions(-)
 create mode 100644 board/renesas/common/Makefile
 delete mode 100644 board/renesas/condor/Makefile
 delete mode 100644 board/renesas/eagle/Makefile
 delete mode 100644 board/renesas/ebisu/Makefile
 delete mode 100644 board/renesas/falcon/Makefile
 delete mode 100644 board/renesas/grayhawk/Makefile
 delete mode 100644 board/renesas/spider/Makefile
 delete mode 100644 board/renesas/whitehawk/Makefile

diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
new file mode 100644
index 00000000000..2072338ea05
--- /dev/null
+++ b/board/renesas/common/Makefile
@@ -0,0 +1,45 @@
+#
+# board/renesas/whitehawk/Makefile
+#
+# Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+# R-Car SoCs
+ifndef CONFIG_RZG2L
+
+# 32 bit SoCs
+ifdef CONFIG_RCAR_GEN2
+endif
+
+# 64 bit SoCs
+ifdef CONFIG_RCAR_64
+ifndef CONFIG_XPL_BUILD
+obj-y	+= common.o
+endif
+
+ifdef CONFIG_RCAR_GEN3
+ifdef CONFIG_XPL_BUILD
+obj-y	+= gen3-spl.o
+else
+obj-y	+= gen3-common.o
+ifdef CONFIG_R8A77970
+obj-y	+= v3-common.o
+endif
+ifdef CONFIG_R8A77980
+obj-y	+= v3-common.o
+endif
+endif
+endif
+
+ifdef CONFIG_RCAR_GEN4
+ifdef CONFIG_XPL_BUILD
+obj-y	+= gen4-spl.o
+else
+obj-y	+= gen4-common.o
+endif
+endif
+endif
+
+endif
diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
index 549bec9e137..840ea6d7820 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -17,8 +17,6 @@
 #include <asm/arch/renesas.h>
 #include <linux/libfdt.h>
 
-#ifdef CONFIG_RCAR_64
-
 DECLARE_GLOBAL_DATA_PTR;
 
 /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
@@ -182,4 +180,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
-#endif
diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
deleted file mode 100644
index 3b1756b44cd..00000000000
--- a/board/renesas/condor/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# board/renesas/condor/Makefile
-#
-# Copyright (C) 2019 Renesas Electronics Corporation
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/gen3-common.o ../common/common.o
-endif
diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
index 6ce05bcd649..945cc2134e8 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -6,8 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= draak.o ../common/gen3-common.o ../common/common.o
-endif
+obj-y	+= draak.o
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index a51bf65674f..b742b8d6220 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
@@ -65,3 +67,5 @@ int board_init(void)
 
 	return 0;
 }
+
+#endif
diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
deleted file mode 100644
index a5c18d81eef..00000000000
--- a/board/renesas/eagle/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# board/renesas/eagle/Makefile
-#
-# Copyright (C) 2015 Renesas Electronics Corporation
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
-endif
diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
deleted file mode 100644
index 72130b76234..00000000000
--- a/board/renesas/ebisu/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# board/renesas/ebisu/Makefile
-#
-# Copyright (C) 2018 Renesas Electronics Corporation
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/gen3-common.o ../common/common.o
-endif
diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
deleted file mode 100644
index 949953f6981..00000000000
--- a/board/renesas/falcon/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# board/renesas/falcon/Makefile
-#
-# Copyright (C) 2020 Renesas Electronics Corp.
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/gen4-common.o ../common/common.o
-endif
diff --git a/board/renesas/grayhawk/Makefile b/board/renesas/grayhawk/Makefile
deleted file mode 100644
index a70bd3739f1..00000000000
--- a/board/renesas/grayhawk/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# board/renesas/grayhawk/Makefile
-#
-# Copyright (C) 2023 Renesas Electronics Corp.
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-obj-y	:= ../common/gen4-common.o ../common/common.o
diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
index fe53366829c..daea3e6838f 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -6,8 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= salvator-x.o ../common/gen3-common.o ../common/common.o
-endif
+obj-y	+= salvator-x.o
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 2c8860bcee4..b6fb106ca5d 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <cpu_func.h>
 #include <image.h>
 #include <init.h>
@@ -93,3 +95,5 @@ int board_fit_config_name_match(const char *name)
 	return -1;
 }
 #endif
+
+#endif
diff --git a/board/renesas/spider/Makefile b/board/renesas/spider/Makefile
deleted file mode 100644
index e0f403d5fcc..00000000000
--- a/board/renesas/spider/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# board/renesas/spider/Makefile
-#
-# Copyright (C) 2020 Renesas Electronics Corp.
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-obj-y	:= ../common/gen4-common.o ../common/common.o
diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
index 6b2aa8c29f6..4f608613c15 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -6,8 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ulcb.o cpld.o ../common/gen3-common.o ../common/common.o
-endif
+obj-y	+= ulcb.o cpld.o
diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
index e72e45e3fb4..6a708d86cc8 100644
--- a/board/renesas/ulcb/cpld.c
+++ b/board/renesas/ulcb/cpld.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2017 Cogent Embedded, Inc.
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <command.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -189,3 +191,5 @@ U_BOOT_DRIVER(sysreset_renesas_ulcb) = {
 	.of_match	= renesas_ulcb_sysreset_ids,
 	.priv_auto	= sizeof(struct renesas_ulcb_sysreset_priv),
 };
+
+#endif
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 64f01b123cb..e1445adbb69 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2017 Renesas Electronics Corporation
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <image.h>
 #include <init.h>
 #include <malloc.h>
@@ -84,3 +86,5 @@ int board_fit_config_name_match(const char *name)
 	return -1;
 }
 #endif
+
+#endif
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index 936047cb3d5..0091bc9cd5b 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -7,9 +7,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
-endif
diff --git a/board/renesas/v3hsk/cpld.c b/board/renesas/v3hsk/cpld.c
index 1272aec7302..b82622f9c54 100644
--- a/board/renesas/v3hsk/cpld.c
+++ b/board/renesas/v3hsk/cpld.c
@@ -7,6 +7,8 @@
  *
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
@@ -177,3 +179,5 @@ U_BOOT_DRIVER(sysreset_renesas_v3hsk) = {
 	.probe		= renesas_v3hsk_sysreset_probe,
 	.of_match	= renesas_v3hsk_sysreset_ids,
 };
+
+#endif
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index 21eaddb6c28..fe8bf1ed1ae 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -7,9 +7,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
-endif
diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
index 260755ac746..93f3bf391cd 100644
--- a/board/renesas/v3msk/cpld.c
+++ b/board/renesas/v3msk/cpld.c
@@ -7,6 +7,8 @@
  *
  */
 
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm.h>
@@ -365,3 +367,5 @@ U_BOOT_DRIVER(sysreset_renesas_v3msk) = {
 	.of_match	= renesas_v3msk_sysreset_ids,
 	.priv_auto	= sizeof(struct renesas_v3msk_sysreset_priv),
 };
+
+#endif
diff --git a/board/renesas/whitehawk/Makefile b/board/renesas/whitehawk/Makefile
deleted file mode 100644
index f10eb82d221..00000000000
--- a/board/renesas/whitehawk/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# board/renesas/whitehawk/Makefile
-#
-# Copyright (C) 2021 Renesas Electronics Corp.
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifdef CONFIG_SPL_BUILD
-obj-y	:= ../common/gen4-spl.o
-else
-obj-y	:= ../common/gen4-common.o ../common/common.o
-endif
-- 
2.45.2

