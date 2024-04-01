Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE25CD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 18:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5697788338;
	Mon,  1 Apr 2024 20:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlY47gVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED5688330; Mon,  1 Apr 2024 20:15:00 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4EE58832A
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 20:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-22a1e72f683so3284761fac.0
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711995285; x=1712600085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BoguD4n//9RMgf5ZneR8fLR8l4s/W8zyXE5VH9bkxw=;
 b=VlY47gVt1+QecJaxb+4JnZwCF61R+SN4FBvAIRiF2ImNxExBcVHLnMU2GemN2gpD3s
 IszWHH7sotuqiswekrCEyrJYvLcqgBgpRwCCzyvA7EqFQ4HwwmXVbqMdq8YDP5AyymxC
 WEHA03j8EHfQSjaw7urLfpQJs364WsAOudnQBy1Thn78LVaQkGhslygV3dIlh7tOAMLL
 kWxfDcFBrImicImEI7YzMe7eZPx//C1cFezys+qb8H1LN4sR3BYka/vNoaUJ/Da18A8X
 yydwt3jyDKKfNBVmT307kQlAgXN0Gp63c4RNA6wWrTeEib0VlZLJbythBbdr6ieR5VNe
 I/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711995285; x=1712600085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BoguD4n//9RMgf5ZneR8fLR8l4s/W8zyXE5VH9bkxw=;
 b=uB5XR++n0uisltqdXFseJSFZAEUsSRiwFuIA/eudIMPNL0RBjotd40yf9E9mmL3N7C
 wEDRaAtEs4ia1GZKdoAdkAdJ/c5Ku1+CFEoUsJA6lFC/u/z2SUHP4F7fpf2IxFL3COk0
 IQoRf/5vAqkbGLJlqPxvBaABCVmGsjHnwauQGvQaksKU9Daxy4+N1KBOvNnHX+7j3zx5
 /gRykS76yWkdQsDMm4s+lijy33kc23cZiO9S6FLmVAorD14+2Br5qjzSVZ6QCwy3plSm
 hQ9MOftNLKaynuaVSdzCGwgKr78AlvSa/RsbW1TROMIY10CMb7O/F+WpghPCC8SMtfDg
 Zvfg==
X-Gm-Message-State: AOJu0Yx3Guyee5mrw9q4rogKaslujFncg7TjW8XbirZayVZb1Tdehjol
 zd47TDSVAtJ/kV5UcyANaV3Y4yJuy7JPMkPLkC8yE4iSqUYkIOYmno65OJKV
X-Google-Smtp-Source: AGHT+IHMyJcFpTmzz74c29k91rVNr9yiP6QoCrNDR0cL8bO0oLtn+cLAlzpqYmchuhF7iKvoFbOUqg==
X-Received: by 2002:a05:6871:741a:b0:229:cec1:cbb8 with SMTP id
 nw26-20020a056871741a00b00229cec1cbb8mr12388092oac.3.1711995284762; 
 Mon, 01 Apr 2024 11:14:44 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 hx17-20020a056871531100b0022a0a60a9bcsm3008824oac.57.2024.04.01.11.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:14:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [V2 PATCH 2/2] rockchip: Switch RK3568 and RK3588 to new RAM bank
 logic
Date: Mon,  1 Apr 2024 13:14:35 -0500
Message-Id: <20240401181435.553351-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401181435.553351-1-macroalpha82@gmail.com>
References: <20240401181435.553351-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Switch all RK3568 and RK3588 boards to use the ATAGS based RAM bank
logic. This allows us to access all RAM when >= 4GB of RAM is available
while also automatically creating the memory holes when >= 16GB of RAM
is available.

Remove the board specific logic that previously created the memory
holes, and update the CONFIG_NR_DRAM_BANKS to 10 which is the maximum
supported number of banks using the ATAGS method. Only the number of
banks found by the RAM init code will get added.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/friendlyelec/nanopc-t6-rk3588/Makefile  |  6 ---
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       | 39 -------------------
 board/pine64/quartzpro64-rk3588/Makefile      |  3 --
 .../quartzpro64-rk3588/quartzpro64-rk3588.c   | 39 -------------------
 board/radxa/rock5a-rk3588s/Makefile           |  6 ---
 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c   | 39 -------------------
 board/radxa/rock5b-rk3588/Makefile            |  6 ---
 board/radxa/rock5b-rk3588/rock5b-rk3588.c     | 39 -------------------
 board/rockchip/evb_rk3588/Makefile            |  6 ---
 board/rockchip/evb_rk3588/evb-rk3588.c        | 39 -------------------
 board/turing/turing-rk1-rk3588/Makefile       |  6 ---
 .../turing-rk1-rk3588/turing-rk1-rk3588.c     | 39 -------------------
 configs/anbernic-rgxx3-rk3566_defconfig       |  2 +-
 configs/bpi-r2-pro-rk3568_defconfig           |  2 +-
 configs/evb-rk3568_defconfig                  |  2 +-
 configs/evb-rk3588_defconfig                  |  3 +-
 configs/generic-rk3568_defconfig              |  2 +-
 configs/lubancat-2-rk3568_defconfig           |  2 +-
 configs/nanopc-t6-rk3588_defconfig            |  3 +-
 configs/nanopi-r5c-rk3568_defconfig           |  2 +-
 configs/nanopi-r5s-rk3568_defconfig           |  2 +-
 configs/neu6a-io-rk3588_defconfig             |  2 +-
 configs/neu6b-io-rk3588_defconfig             |  2 +-
 configs/odroid-m1-rk3568_defconfig            |  2 +-
 configs/orangepi-5-plus-rk3588_defconfig      |  3 +-
 configs/orangepi-5-rk3588s_defconfig          |  3 +-
 configs/quartz64-a-rk3566_defconfig           |  2 +-
 configs/quartz64-b-rk3566_defconfig           |  2 +-
 configs/quartzpro64-rk3588_defconfig          |  3 +-
 configs/radxa-cm3-io-rk3566_defconfig         |  2 +-
 configs/radxa-e25-rk3568_defconfig            |  2 +-
 configs/rock-3a-rk3568_defconfig              |  2 +-
 configs/rock5a-rk3588s_defconfig              |  3 +-
 configs/rock5b-rk3588_defconfig               |  3 +-
 configs/soquartz-blade-rk3566_defconfig       |  2 +-
 configs/soquartz-cm4-rk3566_defconfig         |  2 +-
 configs/soquartz-model-a-rk3566_defconfig     |  2 +-
 configs/turing-rk1-rk3588_defconfig           |  3 +-
 38 files changed, 26 insertions(+), 301 deletions(-)
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 delete mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 delete mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 delete mode 100644 board/radxa/rock5a-rk3588s/Makefile
 delete mode 100644 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
 delete mode 100644 board/radxa/rock5b-rk3588/Makefile
 delete mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 delete mode 100644 board/rockchip/evb_rk3588/Makefile
 delete mode 100644 board/rockchip/evb_rk3588/evb-rk3588.c
 delete mode 100644 board/turing/turing-rk1-rk3588/Makefile
 delete mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c

diff --git a/board/friendlyelec/nanopc-t6-rk3588/Makefile b/board/friendlyelec/nanopc-t6-rk3588/Makefile
deleted file mode 100644
index c1c49b1970..0000000000
--- a/board/friendlyelec/nanopc-t6-rk3588/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-#
-# Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
-#
-
-obj-y += nanopc-t6-rk3588.o
diff --git a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
deleted file mode 100644
index 99bbef964e..0000000000
--- a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
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
-int nanopc_t6_add_reserved_memory_fdt_nodes(void *new_blob)
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
-	return nanopc_t6_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/board/pine64/quartzpro64-rk3588/Makefile b/board/pine64/quartzpro64-rk3588/Makefile
deleted file mode 100644
index 47819d9be9..0000000000
--- a/board/pine64/quartzpro64-rk3588/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-
-obj-y += quartzpro64-rk3588.o
diff --git a/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
deleted file mode 100644
index bda804a89e..0000000000
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
diff --git a/board/radxa/rock5a-rk3588s/Makefile b/board/radxa/rock5a-rk3588s/Makefile
deleted file mode 100644
index 48dd512455..0000000000
--- a/board/radxa/rock5a-rk3588s/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-#
-# Copyright (c) 2023 Collabora Ltd.
-#
-
-obj-y += rock5a-rk3588s.o
diff --git a/board/radxa/rock5a-rk3588s/rock5a-rk3588s.c b/board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
deleted file mode 100644
index 2d7a8c07dc..0000000000
--- a/board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2023 Collabora Ltd.
- */
-
-#include <fdtdec.h>
-#include <fdt_support.h>
-
-#ifdef CONFIG_OF_BOARD_SETUP
-int rock5a_add_reserved_memory_fdt_nodes(void *new_blob)
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
-	return rock5a_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
deleted file mode 100644
index 95d813596d..0000000000
--- a/board/radxa/rock5b-rk3588/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier:     GPL-2.0+
-#
-# Copyright (c) 2022 Collabora Ltd.
-#
-
-obj-y += rock5b-rk3588.o
diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
deleted file mode 100644
index 5c3b52b948..0000000000
--- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2023 Collabora Ltd.
- */
-
-#include <fdtdec.h>
-#include <fdt_support.h>
-
-#ifdef CONFIG_OF_BOARD_SETUP
-int rock5b_add_reserved_memory_fdt_nodes(void *new_blob)
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
-	return rock5b_add_reserved_memory_fdt_nodes(blob);
-}
-#endif
diff --git a/board/rockchip/evb_rk3588/Makefile b/board/rockchip/evb_rk3588/Makefile
deleted file mode 100644
index 240d2ec597..0000000000
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
index caf94d8d29..0000000000
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
diff --git a/board/turing/turing-rk1-rk3588/Makefile b/board/turing/turing-rk1-rk3588/Makefile
deleted file mode 100644
index a979d8023a..0000000000
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
index e2338a2a35..0000000000
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
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index ed6643d9d4..c85b4d0128 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-anbernic-rgxx3"
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index e6e0e6fc6f..7b7a8e2af3 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2-pro"
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index cb9b87ff12..a1bd81ea9f 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-evb"
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 8a6aa91cb2..51e794c78c 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-evb1-v10"
@@ -24,7 +24,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 8fb79c9b44..4f3feb3177 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 80ae6ec3a2..5589fd769c 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-lubancat-2"
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 7609932209..cb8f61344a 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
@@ -31,7 +31,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index f5a472d03d..d7cb138547 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5c"
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 99692d341f..60b3b332a3 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-nanopi-r5s"
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index d5301c630b..5b60747ecd 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6a-io"
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index b13c9b5db1..09150ee293 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6b-io"
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index 3130e341e7..bc1b49d286 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index a58f96d577..f743c4077b 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
@@ -32,7 +32,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index a9404c912e..fe453e0191 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
@@ -31,7 +31,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index ade08867f6..d71e69cda3 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -6,7 +6,7 @@ CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 8d01db5440..2b32e141de 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 9cc4eb02e0..6d4f1fa97f 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
@@ -27,7 +27,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 4b606dcb8e..fceb88716b 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-radxa-cm3-io"
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index fedb137877..6d97c5b8f6 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3568-radxa-e25"
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 18372a570e..1ad5bab836 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index efa7bcbdcd..05c96b39ce 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
@@ -24,7 +24,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index a0678ff129..fc3118c807 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
@@ -32,7 +32,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 9693cc2f9e..8163b9be86 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-blade"
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 9c6b12d230..1ab633a179 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-cm4"
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index fd72d78a47..c08a062ea3 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-soquartz-model-a"
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 0f903cf6e8..67b0feea5d 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
+CONFIG_NR_DRAM_BANKS=10
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
 CONFIG_SF_DEFAULT_SPEED=24000000
@@ -32,7 +32,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-- 
2.34.1

