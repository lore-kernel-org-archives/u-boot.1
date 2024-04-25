Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F8FC19F4F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E498F88EF0;
	Thu, 25 Apr 2024 12:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE16188F05; Thu, 25 Apr 2024 12:47:08 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAD188EE7
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQCGf4d3jzThH;
 Thu, 25 Apr 2024 12:47:06 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VQCGc6KpTzpNx; Thu, 25 Apr 2024 12:47:04 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 25 Apr 2024 12:46:27 +0200
Subject: [PATCH v4 04/11] rockchip: quartzpro64-rk3588: use DRAM banks from
 ATAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-rk35xx-dram-atags-v4-4-331401a58e8e@theobroma-systems.com>
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

Similarly, because the quartzpro64-rk3588.c would be empty, it is simply
removed, with the (would-be-empty) Makefile as well.

The CONFIG_NR_DRAM_BANK now defaults to 10 which is a safe bet for
reading banks from ATAGS, so let's use the default value instead.

Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/pine64/quartzpro64-rk3588/Makefile           |  3 --
 .../pine64/quartzpro64-rk3588/quartzpro64-rk3588.c | 39 ----------------------
 configs/quartzpro64-rk3588_defconfig               |  2 --
 3 files changed, 44 deletions(-)

diff --git a/board/pine64/quartzpro64-rk3588/Makefile b/board/pine64/quartzpro64-rk3588/Makefile
deleted file mode 100644
index 47819d9be93..00000000000
--- a/board/pine64/quartzpro64-rk3588/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-
-obj-y += quartzpro64-rk3588.o
diff --git a/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
deleted file mode 100644
index bda804a89e2..00000000000
--- a/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2023 Google, Inc
- */
-
-#include <fdtdec.h>
-#include <fdt_support.h>
-
-#ifdef CONFIG_OF_BOARD_SETUP
-int quartzpro64_add_reserved_memory_fdt_nodes(void *new_blob)
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
-	return quartzpro64_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index b2a66d3f2db..e398c7c2c0e 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_SERIAL=y
@@ -19,7 +18,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y

-- 
2.44.0

