Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD0C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84DFF80C65;
	Wed, 29 Jan 2025 18:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ICx9LNIu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PXeCqnWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F35680646; Wed, 29 Jan 2025 18:05:43 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF9D80A09
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YjpSh68Mtz9syY;
 Wed, 29 Jan 2025 18:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYoyS/O7ucli0iUZLd+CTBpaYLGGHfoGqT3G9PAAQ/U=;
 b=ICx9LNIuuYp3fZuPDVIWU1kXOnx+d8ENvKE3LEOHz3L51ShWfpzHQGRdibhuj8Jrh0uqEU
 Cl9iQmfphh/pw3dU+gHEK+QN+XyKHLMEdVuuhtXDhJbWQweizvjVYq9J4DV2D0s9+aUKq1
 2tlVhJEB9B3HcHvUwvIhY7Xy194vz4opaO+Ixoo1CjWl1J2/k5HkzNE9pfC7ftxpl6oTRF
 SFB2hrdgq5Yxg5mGcO3PvHAUaQwpk41CEo7JJ6Gp041WDNqKwD/FwkLoBAjKNJT95H0jQa
 EvWD/g3GoCAqk0HwoewmCxw0iA/4JJmyxQyHxlPZn5JBoeQX8Flg7YFTHiVOVw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYoyS/O7ucli0iUZLd+CTBpaYLGGHfoGqT3G9PAAQ/U=;
 b=PXeCqnWwn8VW94S6Tb9FoxX3dqEI9CxqbxIaZuU/Qaok4Oe/uD6wxyf+KLwMhxHdFBkgD1
 K0fVCEs7AGP7lc4tOv/NE7rFlt/LmKSfgxFxTCrY0I5UL3SHmBOng5MJx983Uh4vMw62VR
 2MOYadQUD4UG8pttlQAoaAfD5g/iTxzRhAvvdmtWGPxGb821qfgfjeI6GedFQ3uNZxp73X
 N0QEN9215/XtZ+SJAtzSv3b6yCvboe+Ej+J6Qw/85KkxJIp9rfRLf/EsTQIsVennJYLj88
 85zfcyAf4QmbdxjK2ub/Az++OBIgw8llBySmeZ0E8JJ2NNLW+kZ/DKle7WLy6Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/9] ARM: renesas: Simplify board Makefiles
Date: Wed, 29 Jan 2025 18:04:28 +0100
Message-ID: <20250129170514.82118-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9619c16a2ed8122c4d4
X-MBO-RS-META: pq4cf6jtxnd6x55a5makghabwikqgrag
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

The board/renesas/common/Makefile is now also used when building
RZG2L targets which also set CONFIG_RCAR_64 symbol and 32bit R-Car
Gen2 targets, however, this common code is specific to 64bit R-Car
only. Inhibit the build of this common code for RZG2L using extra
ifndef CONFIG_RZG2L and do not include any code for R-Car Gen2 so
far.

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
V2: - Add paragraph about RZG2L/R-Car Gen2 at the end of commit message
    - Add ifdef RCAR_32 around ifdef RCAR_GEN2
    - Drop paragraph about non-empty Makefiles which was bogus
    - Drop the ifdeferry from board files again
V3: - Drop another #ifdef CONFIG_RCAR_64
---
 board/renesas/common/Makefile      | 47 ++++++++++++++++++++++++++++++
 board/renesas/common/common.c      |  4 ---
 board/renesas/common/gen3-common.c |  3 --
 board/renesas/condor/Makefile      | 13 ---------
 board/renesas/draak/Makefile       |  6 ++--
 board/renesas/eagle/Makefile       | 13 ---------
 board/renesas/ebisu/Makefile       | 13 ---------
 board/renesas/falcon/Makefile      | 11 -------
 board/renesas/grayhawk/Makefile    |  9 ------
 board/renesas/salvator-x/Makefile  |  6 ++--
 board/renesas/spider/Makefile      |  9 ------
 board/renesas/ulcb/Makefile        |  6 ++--
 board/renesas/v3hsk/Makefile       |  5 +---
 board/renesas/v3msk/Makefile       |  5 +---
 board/renesas/whitehawk/Makefile   | 13 ---------
 15 files changed, 55 insertions(+), 108 deletions(-)
 delete mode 100644 board/renesas/condor/Makefile
 delete mode 100644 board/renesas/eagle/Makefile
 delete mode 100644 board/renesas/ebisu/Makefile
 delete mode 100644 board/renesas/falcon/Makefile
 delete mode 100644 board/renesas/grayhawk/Makefile
 delete mode 100644 board/renesas/spider/Makefile
 delete mode 100644 board/renesas/whitehawk/Makefile

diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index e69de29bb2d..c531738b22e 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -0,0 +1,47 @@
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
+ifdef CONFIG_RCAR_32
+ifdef CONFIG_RCAR_GEN2
+endif
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
diff --git a/board/renesas/common/common.c b/board/renesas/common/common.c
index 7fba8d10ff5..74ec0a46e6f 100644
--- a/board/renesas/common/common.c
+++ b/board/renesas/common/common.c
@@ -18,8 +18,6 @@
 #include <asm/system.h>
 #include <linux/libfdt.h>
 
-#ifdef CONFIG_RCAR_64
-
 DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
@@ -67,5 +65,3 @@ int __weak board_init(void)
 {
 	return 0;
 }
-
-#endif
diff --git a/board/renesas/common/gen3-common.c b/board/renesas/common/gen3-common.c
index 05b01c846c6..94da00985d3 100644
--- a/board/renesas/common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -18,8 +18,6 @@
 #include <asm/arch/renesas.h>
 #include <linux/libfdt.h>
 
-#ifdef CONFIG_RCAR_64
-
 DECLARE_GLOBAL_DATA_PTR;
 
 /* If the firmware passed a device tree use it for e.g. U-Boot DRAM setup. */
@@ -178,4 +176,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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
index 6ce05bcd649..0a6a325d761 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -6,8 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= draak.o ../common/gen3-common.o ../common/common.o
+ifndef CONFIG_XPL_BUILD
+obj-y	+= draak.o
 endif
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
index 430a842081a..00000000000
--- a/board/renesas/falcon/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-#
-# board/renesas/falcon/Makefile
-#
-# Copyright (C) 2020 Renesas Electronics Corp.
-#
-# SPDX-License-Identifier: GPL-2.0+
-#
-
-ifndef CONFIG_XPL_BUILD
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
index fe53366829c..538bbdddf76 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -6,8 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= salvator-x.o ../common/gen3-common.o ../common/common.o
+ifndef CONFIG_XPL_BUILD
+obj-y	+= salvator-x.o
 endif
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
index 6b2aa8c29f6..4f2dd1ca211 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -6,8 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ulcb.o cpld.o ../common/gen3-common.o ../common/common.o
+ifndef CONFIG_XPL_BUILD
+obj-y	+= ulcb.o cpld.o
 endif
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index 936047cb3d5..e6db77468e6 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -7,9 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index 21eaddb6c28..211b8a32489 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -7,9 +7,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
-obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
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

