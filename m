Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB962C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D8788445;
	Tue, 18 Jun 2024 17:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VD7URzq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC1A8841E; Tue, 18 Jun 2024 17:35:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE17884BA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 688BA6199A;
 Tue, 18 Jun 2024 15:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D04AC4AF49;
 Tue, 18 Jun 2024 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724906;
 bh=AFCZh/WI0Wi3TrjxkAvDtz65+Zwz9W8qgyvuTIF0sRU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VD7URzq0BEhoVvG1eSdLHEmDBwlGspK4gRHiw5XZMvTM+9Zv1MoNLzT84bRWne+t7
 3r/CTusiYJnJ4srJsFz/dUm15UL52h9Hj14jkidVMkpIxeb1UcuuVL8egZ8R/PMHr5
 6FHsr+j14KgWaUcy3Ges9X3tOLhPDo2fGe4SZRKNLN/0qVyi5asYKMFfk04EPwGTJl
 yvGMQyzt/KrUovD8pDockStclDeeKblkrjQ/xAm1kQZQ2GMiJ1L0l3HwDgAS6EoC3x
 e7Vs+zihytYYSiosLAcH8RMWtRmqFR3AoC2avdpfcSxRh85A4oXQqorkgmysN/Wydv
 VxHsHqYUPPoow==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 16/16] arm: mvebu: turris_omnia: Support old
 DDR3 training
Date: Tue, 18 Jun 2024 17:34:39 +0200
Message-ID: <20240618153439.9518-17-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
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

Support old DDR3 training code on Turris Omnia, selectable via EEPROM
field.

Users experiencing DDR3 initialization failures or random crashes of the
operating system due to incorrect DDR3 configuration can select the old
DDR3 training implementation to fix those issues by setting the EEPROM
field "Use old DDR training":
  eeprom update "Use old DDR training" 1

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig                   |  1 +
 board/CZ.NIC/turris_omnia/Makefile            |  1 +
 board/CZ.NIC/turris_omnia/eeprom.c            | 37 ++++++++++-
 board/CZ.NIC/turris_omnia/old_ddr3_training.c | 63 +++++++++++++++++++
 board/CZ.NIC/turris_omnia/turris_omnia.c      | 18 +++++-
 5 files changed, 117 insertions(+), 3 deletions(-)
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
index 216e11958a..d1ef5cb860 100644
--- a/board/CZ.NIC/turris_omnia/Makefile
+++ b/board/CZ.NIC/turris_omnia/Makefile
@@ -4,3 +4,4 @@
 
 obj-y	:= turris_omnia.o ../turris_atsha_otp.o ../turris_common.o
 obj-$(CONFIG_CMD_EEPROM_LAYOUT)	+= eeprom.o
+obj-$(CONFIG_SPL_BUILD)		+= old_ddr3_training.o
diff --git a/board/CZ.NIC/turris_omnia/eeprom.c b/board/CZ.NIC/turris_omnia/eeprom.c
index 32572481ce..6e2640ad2a 100644
--- a/board/CZ.NIC/turris_omnia/eeprom.c
+++ b/board/CZ.NIC/turris_omnia/eeprom.c
@@ -91,13 +91,48 @@ static int eeprom_field_update_ddr_speed(struct eeprom_field *field,
 	return 0;
 }
 
+static void eeprom_field_print_bool(const struct eeprom_field *field)
+{
+	unsigned char val = field->buf[0];
+
+	printf(PRINT_FIELD_SEGMENT, field->name);
+
+	if (val == 0xff)
+		puts("(empty, defaults to 0)\n");
+	else
+		printf("%u\n", val);
+}
+
+static int eeprom_field_update_bool(struct eeprom_field *field, char *value)
+{
+	unsigned char *val = &field->buf[0];
+
+	if (value[0] == '\0') {
+		/* setting default value */
+		*val = 0xff;
+
+		return 0;
+	}
+
+	if (value[1] != '\0')
+		return -1;
+
+	if (value[0] == '1' || value[0] == '0')
+		*val = value[0] - '0';
+	else
+		return -1;
+
+	return 0;
+}
+
 static struct eeprom_field omnia_layout[] = {
 	_DEF_FIELD("Magic constant", 4, bin),
 	_DEF_FIELD("RAM size in GB", 4, ramsz),
 	_DEF_FIELD("Wi-Fi Region", 4, region),
 	_DEF_FIELD("CRC32 checksum", 4, bin),
 	_DEF_FIELD("DDR speed", 5, ddr_speed),
-	_DEF_FIELD("Extended reserved fields", 39, reserved),
+	_DEF_FIELD("Use old DDR training", 1, bool),
+	_DEF_FIELD("Extended reserved fields", 38, reserved),
 	_DEF_FIELD("Extended CRC32 checksum", 4, bin),
 };
 
diff --git a/board/CZ.NIC/turris_omnia/old_ddr3_training.c b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
new file mode 100644
index 0000000000..cdb3487ad9
--- /dev/null
+++ b/board/CZ.NIC/turris_omnia/old_ddr3_training.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
+
+#include <asm/arch/soc.h>
+#include <asm/io.h>
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
+__weak u32 sys_env_get_topology_update_info(struct topology_update_info *tui)
+{
+	return MV_OK;
+}
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 544784e860..2f29d26edf 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -432,7 +432,8 @@ struct omnia_eeprom {
 
 	/* second part (only considered if crc2 is not all-ones) */
 	char ddr_speed[5];
-	u8 reserved[39];
+	u8 old_ddr_training;
+	u8 reserved[38];
 	u32 crc2;
 };
 
@@ -496,7 +497,7 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 	return true;
 }
 
-static int omnia_get_ram_size_gb(void)
+int omnia_get_ram_size_gb(void)
 {
 	static int ram_size;
 	struct omnia_eeprom oep;
@@ -521,6 +522,19 @@ static int omnia_get_ram_size_gb(void)
 	return ram_size;
 }
 
+bool board_use_old_ddr3_training(void)
+{
+	struct omnia_eeprom oep;
+
+	if (!omnia_read_eeprom(&oep))
+		return false;
+
+	if (!is_omnia_eeprom_second_part_valid(&oep))
+		return false;
+
+	return oep.old_ddr_training == 1;
+}
+
 static const char *omnia_get_ddr_speed(void)
 {
 	struct omnia_eeprom oep;
-- 
2.44.2

