Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44AAD32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54FD689443;
	Tue, 12 Nov 2024 19:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iurfmxYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24C888DFE; Tue, 12 Nov 2024 15:57:53 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AC689450
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A38B840009;
 Tue, 12 Nov 2024 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1731423471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgYs1LvTFegttTgszwxxHIqjVZCJfpwHXs+S+p6E/vo=;
 b=iurfmxYf4IuTGJ5JHs/K76rLItEOGl+pcySNR4qjwWLtjEPR6aTNUa4/q4QZjAdkI94EsJ
 OpCk5hhBRDxrnoFKPIcGg16g90d0N3RW6QYTDPmBOUf7EwqOdhnc7Q8EBnngukesNuTXDa
 JnkuVyHdzcLQ83b+/0B7JR8Lmi2JmQBrHrxPtn3HQ4VyVy4ErSsQkHMmt8Iqf0ainVUpaS
 v5rt1TzJkh+Inw6P7P2Wu/FZfF5KD2x1eYtgMl4rc9rtxj1FHyFJ64m23MV38YZ4iMI5lm
 VmfozGLDhtG6YStm7uhideMAy1jn5JlwaqJZvgEIzbWi/Hp1lTEkI6TbOSnRQQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 12 Nov 2024 15:57:38 +0100
Subject: [PATCH 3/3] board: add support for LicheeRV Nano
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-licheerv-nano-v1-3-bf75d1eb560e@bootlin.com>
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
In-Reply-To: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

The LicheeRV Nano is a small SBC using the Sophgo SG2002 RISCV SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/Kconfig                     |  4 +++
 board/sophgo/licheerv_nano/Kconfig     | 28 ++++++++++++++++++++
 board/sophgo/licheerv_nano/MAINTAINERS |  4 +++
 board/sophgo/licheerv_nano/Makefile    |  5 ++++
 board/sophgo/licheerv_nano/board.c     |  9 +++++++
 configs/sipeed_licheerv_nano_defconfig | 47 ++++++++++++++++++++++++++++++++++
 include/configs/licheerv_nano.h        | 24 +++++++++++++++++
 7 files changed, 121 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c52728862019c426f031262c40901ee51..91d531a4e9eb8e915bf47a4be2ad3392f64fa352 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,6 +11,9 @@ choice
 config TARGET_ANDES_AE350
 	bool "Support Andes ae350"
 
+config TARGET_LICHEERV_NANO
+	bool "Support LicheeRV Nano Board"
+
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
 
@@ -88,6 +91,7 @@ source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
+source "board/sophgo/licheerv_nano/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/board/sophgo/licheerv_nano/Kconfig b/board/sophgo/licheerv_nano/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..660d3c5d0958632cde45eeca58c2921881948452
--- /dev/null
+++ b/board/sophgo/licheerv_nano/Kconfig
@@ -0,0 +1,28 @@
+if TARGET_LICHEERV_NANO
+
+config SYS_BOARD
+	default "licheerv_nano"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "licheerv_nano"
+
+config TEXT_BASE
+	default 0x80200000
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/licheerv_nano/MAINTAINERS b/board/sophgo/licheerv_nano/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..88cab489c985925f736a9537ff797870bea38b9d
--- /dev/null
+++ b/board/sophgo/licheerv_nano/MAINTAINERS
@@ -0,0 +1,4 @@
+LicheeRV Nano
+M:	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+S:	Maintained
+F:	board/sophgo/licheerv_nano/
diff --git a/board/sophgo/licheerv_nano/Makefile b/board/sophgo/licheerv_nano/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..59fcd5bfba91ceacb10f56692e9a1c82cc66d6cf
--- /dev/null
+++ b/board/sophgo/licheerv_nano/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y += board.o
diff --git a/board/sophgo/licheerv_nano/board.c b/board/sophgo/licheerv_nano/board.c
new file mode 100644
index 0000000000000000000000000000000000000000..eaa47be17396915e74c141e09fef752c07719f73
--- /dev/null
+++ b/board/sophgo/licheerv_nano/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..14fefa968c677f3d56c42f8ad6bd38c02b17b017
--- /dev/null
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -0,0 +1,47 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sg2002-licheerv-nano-b"
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING="licheerv_nano"
+CONFIG_TARGET_LICHEERV_NANO=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+CONFIG_SD_BOOT=y
+CONFIG_BOOTCOMMAND="run distro_bootcmd"
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="licheerv_nano# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CV1800B_SPIF=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/include/configs/licheerv_nano.h b/include/configs/licheerv_nano.h
new file mode 100644
index 0000000000000000000000000000000000000000..2ea7943f66f46aa59f59d4aa7c2e8f7e4d84d301
--- /dev/null
+++ b/include/configs/licheerv_nano.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <config_distro_bootcmd.h>
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0)
+
+#define CFG_SYS_SDRAM_BASE         0x80000000
+
+#define CFG_EXTRA_ENV_SETTINGS  "consoledev=ttyS0\0" \
+								"baudrate=115200\0" \
+								"fdt_addr_r=0x82000000\0" \
+								"kernel_addr_r=0x81000000\0" \
+								"scriptaddr=0x80c00000\0" \
+								BOOTENV
+
+#endif /* __CONFIG_H */

-- 
2.47.0

