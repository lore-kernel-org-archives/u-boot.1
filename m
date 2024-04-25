Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF52C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E0D88F2B;
	Thu, 25 Apr 2024 12:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE4F88EE7; Thu, 25 Apr 2024 12:47:17 +0200 (CEST)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967A588F21
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQCGq1BKzzlp9;
 Thu, 25 Apr 2024 12:47:15 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VQCGn4M7Mzql5; Thu, 25 Apr 2024 12:47:13 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 25 Apr 2024 12:46:32 +0200
Subject: [PATCH v4 09/11] rockchip: turing-rk1-rk3588: use DRAM banks from
 ATAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-rk35xx-dram-atags-v4-9-331401a58e8e@theobroma-systems.com>
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

Similarly, because the turing-rk1-rk3588.c would be empty, it is simply
removed, with the (would-be-empty) Makefile as well.

The CONFIG_NR_DRAM_BANK now defaults to 10 which is a safe bet for
reading banks from ATAGS, so let's use the default value instead.

Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/turing/turing-rk1-rk3588/Makefile            |  6 ----
 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c | 39 ----------------------
 configs/turing-rk1-rk3588_defconfig                |  2 --
 3 files changed, 47 deletions(-)

diff --git a/board/turing/turing-rk1-rk3588/Makefile b/board/turing/turing-rk1-rk3588/Makefile
deleted file mode 100644
index a979d8023aa..00000000000
--- a/board/turing/turing-rk1-rk3588/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-#
-# Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
-#
-
-obj-y += turing-rk1-rk3588.o
diff --git a/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c b/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
deleted file mode 100644
index e2338a2a35a..00000000000
--- a/board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
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
-int turing_rk1_add_reserved_memory_fdt_nodes(void *new_blob)
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
-	return turing_rk1_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index e18ced72178..49d62410ca0 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
@@ -24,7 +23,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y

-- 
2.44.0

