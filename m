Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC31C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C4988EE8;
	Thu, 25 Apr 2024 12:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A3788F1E; Thu, 25 Apr 2024 12:47:14 +0200 (CEST)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5534288E6E
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQCGl6VynzjvH;
 Thu, 25 Apr 2024 12:47:11 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VQCGk1YLMzp6K; Thu, 25 Apr 2024 12:47:10 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 25 Apr 2024 12:46:30 +0200
Subject: [PATCH v4 07/11] rockchip: evb_rk3588 et al.: use DRAM banks from
 ATAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-rk35xx-dram-atags-v4-7-331401a58e8e@theobroma-systems.com>
References: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
In-Reply-To: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

RK3588-based devices now support creating DRAM banks with proper holes
by reading the ATAGS from Rockchip TPL blob, so let's use that mechanism
instead.

Since ft_board_setup isn't defined anymore, there's no need for
selecting CONFIG_OF_BOARD_SETUP.

Similarly, because the evb_rk3588.c would be empty, it is simply
removed, with the (would-be-empty) Makefile as well.

The CONFIG_NR_DRAM_BANK now defaults to 10 which is a safe bet for
reading banks from ATAGS, so let's use the default value instead.

All defconfigs using the CONFIG_TARGET_EVB_RK3588 are updated at once
since they are impacted by this change.

Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/rockchip/evb_rk3588/Makefile       |  6 -----
 board/rockchip/evb_rk3588/evb-rk3588.c   | 39 --------------------------------
 configs/coolpi-4b-rk3588s_defconfig      |  2 --
 configs/coolpi-cm5-evb-rk3588_defconfig  |  2 --
 configs/evb-rk3588_defconfig             |  2 --
 configs/generic-rk3588_defconfig         |  2 --
 configs/orangepi-5-plus-rk3588_defconfig |  2 --
 configs/orangepi-5-rk3588s_defconfig     |  2 --
 8 files changed, 57 deletions(-)

diff --git a/board/rockchip/evb_rk3588/Makefile b/board/rockchip/evb_rk3588/Makefile
deleted file mode 100644
index 240d2ec597e..00000000000
--- a/board/rockchip/evb_rk3588/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-#
-# Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
-#
-
-obj-y += evb-rk3588.o
diff --git a/board/rockchip/evb_rk3588/evb-rk3588.c b/board/rockchip/evb_rk3588/evb-rk3588.c
deleted file mode 100644
index caf94d8d29c..00000000000
--- a/board/rockchip/evb_rk3588/evb-rk3588.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
- */
-
-#include <fdtdec.h>
-#include <fdt_support.h>
-
-#ifdef CONFIG_OF_BOARD_SETUP
-static int rk3588_add_reserved_memory_fdt_nodes(void *new_blob)
-{
-	struct fdt_memory gap1 = {
-		.start = 0x3fc000000,
-		.end = 0x3fc4fffff,
-	};
-	struct fdt_memory gap2 = {
-		.start = 0x3fff00000,
-		.end = 0x3ffffffff,
-	};
-	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
-	unsigned int ret;
-
-	/*
-	 * Inject the reserved-memory nodes into the DTS
-	 */
-	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
-					 NULL, flags);
-	if (ret)
-		return ret;
-
-	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
-					  NULL, flags);
-}
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	return rk3588_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index a0fe3708344..2608bb67679 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588s-coolpi-4b"
@@ -23,7 +22,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index fc17660da2a..c5bb7a42957 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-coolpi-cm5-evb"
@@ -23,7 +22,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index c8db04c076e..187cf26a5c9 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-evb1-v10"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
@@ -16,7 +15,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index b50f4f8b800..e7a372a828c 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-generic"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
@@ -16,7 +15,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index d6e23c154f1..ba8005363ad 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-orangepi-5-plus"
@@ -24,7 +23,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index e6b3da1dc59..d61f85aaa8c 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
@@ -23,7 +22,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y

-- 
2.44.0

