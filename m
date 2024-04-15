Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD05C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C798881FE;
	Mon, 15 Apr 2024 18:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sIX25qZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403A088137; Mon, 15 Apr 2024 18:31:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDB2881EF
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AE89C60ECF;
 Mon, 15 Apr 2024 16:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C1C32783;
 Mon, 15 Apr 2024 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198661;
 bh=wHr/MHhWV/ZqM1Dovchfy+KTO3b35DSjUzw3PQFCMG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sIX25qZgv5hJpLx7hbp6VMfTjO7P9K74eofsieCKarT2sHRY6wpUSdYVpZZ6Xw+VL
 F2/uAXPP6/1+4BIGwFahGzJhkBaGLLZ8N89Qz0+aAZIBjJVja5jk0NZGpYMx4AIjnN
 j2wHlNdkrovvJiTYKDpluTMIoQl8OQSXM1y7Wo8P86CE1BEJaw7J0ySdQbOcps5miT
 HRDMucSAKy5jTm8BfBd9I8mOZejQtRkz4CCxmsaNkG5loPRm3rDLI72N7yDb8vlcV1
 nCNqQWItdKkJ6vefcVznzXsN+zCqGOSapzaoYrLJcz2KHf5IFhA65Aoha+9XZg1lD7
 S9bExvhnikNug==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 10/10] arm: mvebu: turris_omnia: Support old DDR3
 training, selectable via env var
Date: Mon, 15 Apr 2024 18:30:43 +0200
Message-ID: <20240415163043.7482-11-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
References: <20240415163043.7482-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Support old DDR3 training code on Turris Omnia, selectable by U-Boot
enviroment variable.

Users experiencing DDR3 initialization failures or random crashes of the
operating system due to incorrect DDR3 configuration can select the old
DDR3 training implementation to fix those issues by setting the
environment variable
  env set omnia_ddr3_training old
  env save

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig                   |  1 +
 board/CZ.NIC/turris_omnia/Makefile            |  1 +
 board/CZ.NIC/turris_omnia/old_ddr3_training.c | 79 +++++++++++++++++++
 board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
 4 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index e377e8a48a..4a8328760e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
 	select SPL_SYS_MALLOC_SIMPLE
 	select SYS_I2C_MVTWSI
 	select ATSHA204A
+	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
 
 config TARGET_TURRIS_MOX
 	bool "Support CZ.NIC's Turris Mox / RIPE Atlas Probe"
diff --git a/board/CZ.NIC/turris_omnia/Makefile b/board/CZ.NIC/turris_omnia/Makefile
index 341378b4e5..28142cca7e 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -3,3 +3,4 @@
 # Copyright (C) 2017 Marek Behún <kabel@kernel.org>
 
 obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
+obj-$(CONFIG_SPL_BUILD)	+= old_ddr3_training.o
diff --git a/board/CZ.NIC/turris_omnia/old_ddr3_training.c b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
new file mode 100644
index 0000000000..f7e89c58d4
--- /dev/null
+++ b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
+
+#include <common.h>
+#include <asm/io.h>
+#include <env.h>
+
+#include "../drivers/ddr/marvell/a38x/old/ddr3_init.h"
+
+static struct hws_topology_map board_topology_map_1g = {
+	0x1, /* active interfaces */
+	/* cs_mask, mirror, dqs_swap, ck_swap X PUPs */
+	{ { { {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0} },
+	    SPEED_BIN_DDR_1600K,	/* speed_bin */
+	    BUS_WIDTH_16,		/* memory_width */
+	    MEM_4G,			/* mem_size */
+	    DDR_FREQ_800,		/* frequency */
+	    0, 0,			/* cas_l cas_wl */
+	    HWS_TEMP_NORMAL,		/* temperature */
+	    HWS_TIM_2T} },              /* timing (force 2t) */
+	5,				/* Num Of Bus Per Interface*/
+	BUS_MASK_32BIT			/* Busses mask */
+};
+
+static struct hws_topology_map board_topology_map_2g = {
+	0x1, /* active interfaces */
+	/* cs_mask, mirror, dqs_swap, ck_swap X PUPs */
+	{ { { {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0},
+	      {0x1, 0, 0, 0} },
+	    SPEED_BIN_DDR_1600K,	/* speed_bin */
+	    BUS_WIDTH_16,		/* memory_width */
+	    MEM_8G,			/* mem_size */
+	    DDR_FREQ_800,		/* frequency */
+	    0, 0,			/* cas_l cas_wl */
+	    HWS_TEMP_NORMAL,		/* temperature */
+	    HWS_TIM_2T} },              /* timing (force 2t) */
+	5,				/* Num Of Bus Per Interface*/
+	BUS_MASK_32BIT			/* Busses mask */
+};
+
+/* defined in turris_omnia.c */
+extern int omnia_get_ram_size_gb(void);
+
+struct hws_topology_map *ddr3_get_topology_map(void)
+{
+	if (omnia_get_ram_size_gb() == 2)
+		return &board_topology_map_2g;
+	else
+		return &board_topology_map_1g;
+}
+
+bool board_use_old_ddr3_training(void)
+{
+	const char *env_val = NULL;
+
+	if (CONFIG_IS_ENABLED(ENV_SUPPORT) && !env_init())
+		env_val = env_get("omnia_ddr3_training");
+
+	if (env_val && !strcmp(env_val, "old")) {
+		printf("Using old DDR3 training implementation\n");
+		return true;
+	}
+
+	return false;
+}
+
+__weak u32 sys_env_get_topology_update_info(struct topology_update_info *tui)
+{
+	return MV_OK;
+}
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 3b7a71bdad..225c6f4bc5 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -465,7 +465,7 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 	return true;
 }
 
-static int omnia_get_ram_size_gb(void)
+int omnia_get_ram_size_gb(void)
 {
 	static int ram_size;
 	struct omnia_eeprom oep;
-- 
2.43.2

