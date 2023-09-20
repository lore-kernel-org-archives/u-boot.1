Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB2FCE79D1
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCDB86C1B;
	Wed, 20 Sep 2023 14:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FC386C32; Wed, 20 Sep 2023 14:43:26 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id A107886C1D
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="176658390"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Sep 2023 21:43:23 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94DDD433CFB5;
 Wed, 20 Sep 2023 21:43:20 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
Date: Wed, 20 Sep 2023 13:42:12 +0100
Message-Id: <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
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

The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMARC
carrier board.

The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
devicetree blob to the bootloader as an argument in the same was
previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
which can be used to identify the particular SoC we are running on and
this is used to select the appropriate device tree to load.

The configuration renesas_rzg2l_smarc_defconfig is added to support
building for this target. In the future this defconfig will be extended
to support other SoCs and evaluation boards from the RZ/G2L family.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-rmobile/Kconfig.rzg2l   | 14 +++++
 board/renesas/rzg2l/Kconfig           | 18 +++++++
 board/renesas/rzg2l/MAINTAINERS       |  6 +++
 board/renesas/rzg2l/Makefile          |  4 ++
 board/renesas/rzg2l/rzg2l.c           | 76 +++++++++++++++++++++++++++
 configs/renesas_rzg2l_smarc_defconfig | 52 ++++++++++++++++++
 include/configs/rzg2l-smarc.h         | 14 +++++
 7 files changed, 184 insertions(+)
 create mode 100644 board/renesas/rzg2l/Kconfig
 create mode 100644 board/renesas/rzg2l/MAINTAINERS
 create mode 100644 board/renesas/rzg2l/Makefile
 create mode 100644 board/renesas/rzg2l/rzg2l.c
 create mode 100644 configs/renesas_rzg2l_smarc_defconfig
 create mode 100644 include/configs/rzg2l-smarc.h

diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
index 7d268e8c366a..1fe49e323300 100644
--- a/arch/arm/mach-rmobile/Kconfig.rzg2l
+++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
@@ -9,6 +9,20 @@ config R9A07G044L
 	help
 	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
 
+choice
+	prompt "Renesas RZ/G2L Family Board selection"
+	default TARGET_RZG2L_SMARC_EVK
+
+config TARGET_RZG2L_SMARC_EVK
+	bool "Renesas RZ/G2L SMARC EVK"
+	imply R9A07G044L
+	help
+	  Enable support for the RZ/G2L SMARC evaluation board.
+
+source "board/renesas/rzg2l/Kconfig"
+
+endchoice
+
 config MULTI_DTB_FIT_UNCOMPRESS_SZ
 	default 0x80000 if TARGET_RZG2L_SMARC_EVK
 
diff --git a/board/renesas/rzg2l/Kconfig b/board/renesas/rzg2l/Kconfig
new file mode 100644
index 000000000000..1335fc7ae806
--- /dev/null
+++ b/board/renesas/rzg2l/Kconfig
@@ -0,0 +1,18 @@
+# Copyright (C) 2023 Renesas Electronics Corporation
+# SPDX-License-Identifier: GPL-2.0+
+
+if TARGET_RZG2L_SMARC_EVK
+
+config SYS_SOC
+	default "rmobile"
+
+config SYS_BOARD
+	default "rzg2l"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "rzg2l-smarc"
+
+endif
diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAINTAINERS
new file mode 100644
index 000000000000..0a51391c1fc9
--- /dev/null
+++ b/board/renesas/rzg2l/MAINTAINERS
@@ -0,0 +1,6 @@
+RENESAS RZG2L BOARD FAMILY
+M:	Paul Barker <paul.barker.ct@bp.renesas.com>
+S:	Supported
+F:	arch/arm/dts/rz-smarc-common.dtsi
+N:	rzg2l
+N:	r9a07g044
diff --git a/board/renesas/rzg2l/Makefile b/board/renesas/rzg2l/Makefile
new file mode 100644
index 000000000000..466935fc8158
--- /dev/null
+++ b/board/renesas/rzg2l/Makefile
@@ -0,0 +1,4 @@
+# Copyright (C) 2023 Renesas Electronics Corporation
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	:= rzg2l.o
diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
new file mode 100644
index 000000000000..2b1bb3546c26
--- /dev/null
+++ b/board/renesas/rzg2l/rzg2l.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L board support.
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#include <common.h>
+#include <fdtdec.h>
+#include <linux/libfdt.h>
+
+#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
+/* If the firmware passed a device tree, use it for board identification. */
+extern u64 rcar_atf_boot_args[];
+
+static bool is_rzg2l_board(const char *board_name)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+
+	return fdt_node_check_compatible(atf_fdt_blob, 0, board_name) == 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+
+	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
+		return -1;
+
+	if (is_rzg2l_board("renesas,r9a07g044l2"))
+		return strcmp(name, "r9a07g044l2-smarc");
+
+	return -1;
+}
+#endif
+
+static void apply_atf_overlay(void *fdt_blob)
+{
+	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
+
+	if (fdt_magic(atf_fdt_blob) == FDT_MAGIC)
+		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
+}
+
+int fdtdec_board_setup(const void *fdt_blob)
+{
+	apply_atf_overlay((void *)fdt_blob);
+
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+int __weak board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	fdtdec_setup_memory_banksize();
+
+	return 0;
+}
+
+void __weak reset_cpu(void)
+{
+
+}
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
new file mode 100644
index 000000000000..e17d22695787
--- /dev/null
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -0,0 +1,52 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=16666666
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1048576
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_RMOBILE=y
+CONFIG_TEXT_BASE=0x50000000
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0xFFFE0000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="r9a07g044l2-smarc"
+CONFIG_RZG2L=y
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SYS_LOAD_ADDR=0x58000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_USE_BOOTARGS=y
+# CONFIG_BOARD_EARLY_INIT_F is not set
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_PBSIZE=2068
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT_LZO=y
+CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_VERSION_VARIABLE=y
+CONFIG_REGMAP=y
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+# CONFIG_CLK_RCAR_GEN3 is not set
+CONFIG_GPIO_HOG=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
diff --git a/include/configs/rzg2l-smarc.h b/include/configs/rzg2l-smarc.h
new file mode 100644
index 000000000000..ea57d280cb8d
--- /dev/null
+++ b/include/configs/rzg2l-smarc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#ifndef __RENESAS_RZG2L_H
+#define __RENESAS_RZG2L_H
+
+#include <asm/arch/rmobile.h>
+
+/* console */
+#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 38400 }
+
+#endif /* __RENESAS_RZG2L_H */
-- 
2.34.1

