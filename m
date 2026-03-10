Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9A7EB1057
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB8D84027;
	Tue, 10 Mar 2026 15:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="thfHeZ8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FF98409B; Tue, 10 Mar 2026 15:13:48 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE2383FE9
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 08ADE5FFB7;
 Tue, 10 Mar 2026 15:13:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773152025;
 bh=f3gm3zMekTFFJLzEnnJPhBYWoZh1xPX7JnFQCs74JqY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=thfHeZ8yPfhbhLDagO/X5bkz0k3hhHYJKrmIym3psYoFaWpcM3SFR31MyAM3r0NnF
 gQQ4m5m4c3lbi1tEF7cyy8dt3aqA3ZKTkcNy3GtGvVrVYDiK3kBV0Q4ry1bVn+r1cJ
 NJSEyNz9avI9Q4NnNyw28DjGloyTmK8SnNyg8C+YlOdYYhU0BRjkS/uUi3P723RgEE
 LK9dW5ifNoZWC2XFac6EFbkbMAJueEcih9v3ra4M0gtlBTapJ5xFa9hdV+FDsqQMmv
 V4oCq+XfMIPZ6qSIBUlY/jAIgKLQBhKB6Stcer6L2+BVxQZ2vsgXwMFdV4jR++2G4Z
 wktULgwN5a7pA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 vjardin@free.fr
Subject: [PATCH v1 5/5] cmd: mvebu: add device serial and MAC address
 initialization
Date: Tue, 10 Mar 2026 15:12:52 +0100
Message-ID: <6bde7b2f2ad9eba4148be8d9422068ccd8ba294e.1773151972.git.vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773151972.git.vjardin@free.fr>
References: <cover.1773151972.git.vjardin@free.fr>
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

Read device identification data from a dedicated eMMC region. This
provides:

- Unique device serial number for identification and tracking
- Factory-programmed MAC address for network interfaces
- Bundle information for device variant identification

The serial structure includes CRC32 validation to detect corruption.
On read failure or invalid data, sensible defaults are used to ensure
the system remains bootable.

The fbxserial command provides two subcommands:
- fbxserial show: Display serial info (default)
- fbxserial init: Initialize ethaddr from serial info

Each network interface gets a unique MAC address by incrementing the
base address stored in the serial structure.

The board file hooks EVT_SETTINGS_R to automatically set MAC addresses
before network drivers probe, ensuring addresses are available without
manual intervention.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 board/freebox/nbx10g/board.c        |  16 ++
 cmd/mvebu/Kconfig                   |  27 +++
 cmd/mvebu/Makefile                  |   1 +
 cmd/mvebu/nbx_fbxserial.c           | 289 ++++++++++++++++++++++++++++
 configs/mvebu_nbx_88f8040_defconfig |   2 +
 include/nbx_fbxserial.h             | 134 +++++++++++++
 6 files changed, 469 insertions(+)
 create mode 100644 cmd/mvebu/nbx_fbxserial.c
 create mode 100644 include/nbx_fbxserial.h

diff --git a/board/freebox/nbx10g/board.c b/board/freebox/nbx10g/board.c
index 7080e386c38..2cdf5f68be5 100644
--- a/board/freebox/nbx10g/board.c
+++ b/board/freebox/nbx10g/board.c
@@ -8,6 +8,7 @@
 
 #include <config.h>
 #include <dm.h>
+#include <event.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
@@ -15,6 +16,7 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <linux/delay.h>
+#include <nbx_fbxserial.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -61,3 +63,17 @@ int board_late_init(void)
 
 	return 0;
 }
+
+/*
+ * Set MAC addresses from eMMC serial info before network driver probes.
+ * EVT_SETTINGS_R is triggered after MMC is available but before
+ * initr_net().
+ */
+static int nbx_fbx_settings_r(void)
+{
+	nbx_fbx_init_ethaddr(0, CONFIG_NBX_MMC_PART_SERIAL_OFFSET);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_SETTINGS_R, nbx_fbx_settings_r);
diff --git a/cmd/mvebu/Kconfig b/cmd/mvebu/Kconfig
index ea03f581280..764e2e7de94 100644
--- a/cmd/mvebu/Kconfig
+++ b/cmd/mvebu/Kconfig
@@ -132,4 +132,31 @@ config MVEBU_MMC_PART_BANK1_SIZE
 
 endif
 
+config CMD_NBX_FBXSERIAL
+	bool "NBX fbxserial command"
+	depends on ARMADA_8K && MMC_SDHCI_XENON
+	help
+	  Enable the NBX fbxserial command to read and display device
+	  serial information from eMMC. This includes:
+	  - Device serial number (type, version, manufacturer, date, number)
+	  - MAC address (used to set ethaddr environment variables)
+	  - Bundle information (if present)
+
+	  The serial info is stored at a fixed offset in the eMMC user area.
+
+	  Subcommands:
+	  - fbxserial show: display serial info (default)
+	  - fbxserial init: initialize ethaddr from serial info
+
+if CMD_NBX_FBXSERIAL
+
+config NBX_MMC_PART_SERIAL_OFFSET
+	hex "Serial info offset in eMMC"
+	default 0x800000
+	help
+	  Byte offset in eMMC where the serial info structure is stored.
+	  Default: 0x800000 (8MB)
+
+endif
+
 endmenu
diff --git a/cmd/mvebu/Makefile b/cmd/mvebu/Makefile
index c096f507e26..b1dbd283c63 100644
--- a/cmd/mvebu/Makefile
+++ b/cmd/mvebu/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_CMD_MVEBU_BUBT) += bubt.o
 obj-$(CONFIG_CMD_MVEBU_COMPHY_RX_TRAINING) += comphy_rx_training.o
 obj-$(CONFIG_CMD_NBX_EMMCBOOT) += mvebu_emmcboot.o
+obj-$(CONFIG_CMD_NBX_FBXSERIAL) += nbx_fbxserial.o
diff --git a/cmd/mvebu/nbx_fbxserial.c b/cmd/mvebu/nbx_fbxserial.c
new file mode 100644
index 00000000000..baad5c56c10
--- /dev/null
+++ b/cmd/mvebu/nbx_fbxserial.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NBX Freebox Serial Info Support
+ *
+ * Copyright (C) 2026 Free Mobile, Freebox
+ *
+ * Reads device serial number and MAC address from eMMC.
+ * The serial info is stored at a fixed offset in the eMMC user area.
+ *
+ * Serial format: TTTT-VV-M-(YY)WW-NN-NNNNN / FLAGS
+ * Where:
+ *   TTTT  = Device type (e.g., 9018)
+ *   VV    = Board version
+ *   M     = Manufacturer code (ASCII)
+ *   YY    = Year (BCD)
+ *   WW    = Week (1-53)
+ *   NNNNN = Serial number
+ *   FLAGS = Feature flags
+ */
+
+#include <command.h>
+#include <env.h>
+#include <mmc.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <string.h>
+#include <vsprintf.h>
+#include <u-boot/crc.h>
+#include <asm/byteorder.h>
+#include <linux/ctype.h>
+#include <nbx_fbxserial.h>
+
+/* Default serial info (Freebox OUI, type 9018) */
+static const struct nbx_fbx_serial nbx_fbxserial_default = {
+	.crc32		= 0,
+	.magic		= NBX_FBXSERIAL_MAGIC,
+	.struct_version	= NBX_FBXSERIAL_VERSION,
+	.len		= sizeof(struct nbx_fbx_serial),
+	.type		= 9018,
+	.version	= 0,
+	.manufacturer	= '_',
+	.year		= 0,
+	.week		= 0,
+	.number		= 0,
+	.flags		= 0,
+	.mac_addr_base	= { 0x00, 0x07, 0xCB, 0x00, 0x00, 0xFD },
+	.mac_count	= 1,
+	.random_data	= { 0 },
+	.last_modified	= 0,
+	.extinfo_count	= 0,
+};
+
+void nbx_fbxserial_set_default(struct nbx_fbx_serial *serial)
+{
+	memcpy(serial, &nbx_fbxserial_default, sizeof(*serial));
+}
+
+/*
+ * Validate serial info structure
+ */
+static int nbx_fbx_check_serial(struct nbx_fbx_serial *fs)
+{
+	unsigned int sum, len;
+
+	/* Check magic first */
+	if (be32_to_cpu(fs->magic) != NBX_FBXSERIAL_MAGIC) {
+		printf("Invalid magic for serial info (%08x != %08x)!\n",
+		       be32_to_cpu(fs->magic), NBX_FBXSERIAL_MAGIC);
+		return -1;
+	}
+
+	/* Check struct version */
+	if (be32_to_cpu(fs->struct_version) > NBX_FBXSERIAL_VERSION) {
+		printf("Version too big for fbxserial info (0x%08x)!\n",
+		       be32_to_cpu(fs->struct_version));
+		return -1;
+	}
+
+	/* Check for silly len */
+	len = be32_to_cpu(fs->len);
+	if (len > NBX_FBXSERIAL_MAX_SIZE) {
+		printf("Silly len for serial info (%d)\n", len);
+		return -1;
+	}
+
+	/* Validate CRC (crc32_no_comp: no one's complement) */
+	sum = crc32_no_comp(0, (void *)fs + 4, len - 4);
+	if (be32_to_cpu(fs->crc32) != sum) {
+		printf("Invalid checksum for serial info (%08x != %08x)\n",
+		       sum, be32_to_cpu(fs->crc32));
+		return -1;
+	}
+
+	return 0;
+}
+
+int nbx_fbx_read_serial(int dev_num, unsigned long offset,
+			struct nbx_fbx_serial *fs)
+{
+	struct mmc *mmc;
+	struct blk_desc *bd;
+	uint blk_start, blk_cnt;
+	uint n;
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, ALIGN(sizeof(*fs), 512));
+	mmc = find_mmc_device(dev_num);
+	if (!mmc) {
+		printf("No MMC device %d found\n", dev_num);
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	if (mmc_init(mmc)) {
+		puts("MMC init failed\n");
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	/* Switch to partition 0 (user data area) */
+	if (blk_select_hwpart_devnum(UCLASS_MMC, dev_num, 0)) {
+		puts("MMC partition switch failed\n");
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	bd = mmc_get_blk_desc(mmc);
+	if (!bd) {
+		puts("Failed to get MMC block descriptor\n");
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
+	blk_cnt = ALIGN(sizeof(*fs), bd->blksz) / bd->blksz;
+
+	n = blk_dread(bd, blk_start, blk_cnt, buf);
+	if (n != blk_cnt) {
+		printf("Failed to read serial info from MMC\n");
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	memcpy(fs, buf, sizeof(*fs));
+
+	if (nbx_fbx_check_serial(fs) != 0) {
+		nbx_fbxserial_set_default(fs);
+		return -1;
+	}
+
+	return 0;
+}
+
+void nbx_fbx_dump_serial(struct nbx_fbx_serial *fs)
+{
+	int i;
+
+	printf("Serial: %04u-%02u-%c-(%02u)%02u-%02u-%05u / %08x\n",
+	       be16_to_cpu(fs->type),
+	       fs->version,
+	       isprint(fs->manufacturer) ? fs->manufacturer : '?',
+	       be16_to_cpu(fs->year) / 100,
+	       be16_to_cpu(fs->year) % 100,
+	       fs->week,
+	       be32_to_cpu(fs->number),
+	       be32_to_cpu(fs->flags));
+
+	printf("Mac:    %02X:%02X:%02X:%02X:%02X:%02X\n",
+	       fs->mac_addr_base[0],
+	       fs->mac_addr_base[1],
+	       fs->mac_addr_base[2],
+	       fs->mac_addr_base[3],
+	       fs->mac_addr_base[4],
+	       fs->mac_addr_base[5]);
+
+	/* Show bundle info */
+	for (i = 0; i < be32_to_cpu(fs->extinfo_count); i++) {
+		struct nbx_serial_extinfo *p;
+
+		if (i >= NBX_EXTINFO_MAX_COUNT)
+			break;
+
+		p = &fs->extinfos[i];
+		if (be32_to_cpu(p->type) == NBX_EXTINFO_TYPE_EXTDEV &&
+		    be32_to_cpu(p->u.extdev.type) == NBX_EXTDEV_TYPE_BUNDLE) {
+			/* Ensure null termination */
+			p->u.extdev.serial[sizeof(p->u.extdev.serial) - 1] = 0;
+			printf("Bundle: %s\n", p->u.extdev.serial);
+		}
+	}
+
+	printf("\n");
+}
+
+int nbx_fbx_init_ethaddr(int dev_num, unsigned long offset)
+{
+	struct nbx_fbx_serial fs;
+	char mac[32];
+	int ret;
+
+	ret = nbx_fbx_read_serial(dev_num, offset, &fs);
+
+	nbx_fbx_dump_serial(&fs);
+
+	/* Even on error, fs has default values set */
+	snprintf(mac, sizeof(mac), "%02x:%02x:%02x:%02x:%02x:%02x",
+		 fs.mac_addr_base[0], fs.mac_addr_base[1],
+		 fs.mac_addr_base[2], fs.mac_addr_base[3],
+		 fs.mac_addr_base[4], fs.mac_addr_base[5]);
+
+	env_set("ethaddr", mac);
+	env_set("eth1addr", mac);
+	env_set("eth2addr", mac);
+
+	return ret;
+}
+
+/*
+ * fbxserial show - display serial info from eMMC
+ */
+static int do_fbxserial_show(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	struct nbx_fbx_serial fs;
+	int dev = 0;
+	unsigned long offset = CONFIG_NBX_MMC_PART_SERIAL_OFFSET;
+
+	if (argc >= 1)
+		dev = dectoul(argv[0], NULL);
+
+	if (argc >= 2)
+		offset = hextoul(argv[1], NULL);
+
+	if (nbx_fbx_read_serial(dev, offset, &fs) != 0)
+		printf("Warning: Using default serial info\n");
+
+	nbx_fbx_dump_serial(&fs);
+
+	return CMD_RET_SUCCESS;
+}
+
+/*
+ * fbxserial init - initialize ethaddr from serial info
+ */
+static int do_fbxserial_init(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	int dev = 0;
+	unsigned long offset = CONFIG_NBX_MMC_PART_SERIAL_OFFSET;
+
+	if (argc >= 1)
+		dev = dectoul(argv[0], NULL);
+
+	if (argc >= 2)
+		offset = hextoul(argv[1], NULL);
+
+	return nbx_fbx_init_ethaddr(dev, offset);
+}
+
+static struct cmd_tbl cmd_fbxserial_sub[] = {
+	U_BOOT_CMD_MKENT(show, 3, 0, do_fbxserial_show, "", ""),
+	U_BOOT_CMD_MKENT(init, 3, 0, do_fbxserial_init, "", ""),
+};
+
+static int do_fbxserial(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	/* Default to 'show' if no subcommand */
+	if (argc < 2)
+		return do_fbxserial_show(cmdtp, flag, 0, NULL);
+
+	cp = find_cmd_tbl(argv[1], cmd_fbxserial_sub,
+			  ARRAY_SIZE(cmd_fbxserial_sub));
+
+	if (!cp)
+		return CMD_RET_USAGE;
+
+	return cp->cmd(cmdtp, flag, argc - 2, argv + 2);
+}
+
+U_BOOT_CMD(
+	fbxserial, 5, 0, do_fbxserial,
+	"NBX serial info and MAC address initialization",
+	"show [dev] [offset] - display serial info from eMMC\n"
+	"fbxserial init [dev] [offset] - initialize ethaddr from serial info\n"
+	"    dev    - MMC device number (default 0)\n"
+	"    offset - offset in eMMC in hex (default from Kconfig)"
+);
diff --git a/configs/mvebu_nbx_88f8040_defconfig b/configs/mvebu_nbx_88f8040_defconfig
index 2fd58e4ad64..c295094536e 100644
--- a/configs/mvebu_nbx_88f8040_defconfig
+++ b/configs/mvebu_nbx_88f8040_defconfig
@@ -21,6 +21,7 @@ CONFIG_PREBOOT="echo (CRC warning is normal: no env saved yet)"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_CPUINFO=y
+CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_PROMPT="nodebox10G>> "
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
@@ -41,6 +42,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_NBX_EMMCBOOT=y
+CONFIG_CMD_NBX_FBXSERIAL=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
diff --git a/include/nbx_fbxserial.h b/include/nbx_fbxserial.h
new file mode 100644
index 00000000000..7628e658f5e
--- /dev/null
+++ b/include/nbx_fbxserial.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * NBX Freebox Serial Info Support
+ *
+ * Copyright (C) 2026 Free Mobile, Freebox
+ *
+ * Reads device serial number and MAC address from eMMC.
+ * Used to identify the board and set network MAC addresses.
+ */
+
+#ifndef NBX_FBXSERIAL_H
+#define NBX_FBXSERIAL_H
+
+#include <linux/types.h>
+
+/*
+ * Extended info structure - variable data depending on type
+ */
+#define NBX_EXTINFO_SIZE		128
+#define NBX_EXTINFO_MAX_COUNT		16
+
+/* Extended info types */
+#define NBX_EXTINFO_TYPE_EXTDEV		1
+
+/* Extended device types */
+#define NBX_EXTDEV_TYPE_BUNDLE		1
+#define NBX_EXTDEV_TYPE_MAX		2
+
+struct nbx_serial_extinfo {
+	u32 type;
+
+	union {
+		/* extdev */
+		struct {
+			u32 type;
+			u32 model;
+			char serial[64];
+		} extdev;
+
+		/* raw access */
+		unsigned char data[NBX_EXTINFO_SIZE];
+	} u;
+} __packed;
+
+/*
+ * Master serial structure
+ */
+#define NBX_FBXSERIAL_VERSION		1
+#define NBX_FBXSERIAL_MAGIC		0x2d9521ab
+
+#define NBX_MAC_ADDR_SIZE		6
+#define NBX_RANDOM_DATA_SIZE		32
+
+/* Maximum size for CRC validation */
+#define NBX_FBXSERIAL_MAX_SIZE		8192
+
+struct nbx_fbx_serial {
+	u32 crc32;
+	u32 magic;
+	u32 struct_version;
+	u32 len;
+
+	/* Board serial */
+	u16 type;
+	u8 version;
+	u8 manufacturer;
+	u16 year;
+	u8 week;
+	u32 number;
+	u32 flags;
+
+	/* MAC address base */
+	u8 mac_addr_base[NBX_MAC_ADDR_SIZE];
+
+	/* MAC address count */
+	u8 mac_count;
+
+	/* Random data used to derive keys */
+	u8 random_data[NBX_RANDOM_DATA_SIZE];
+
+	/* Last update of data (seconds since epoch) */
+	u32 last_modified;
+
+	/* Count of following extinfo tags */
+	u32 extinfo_count;
+
+	/* Beginning of extended info */
+	struct nbx_serial_extinfo extinfos[NBX_EXTINFO_MAX_COUNT];
+} __packed;
+
+/**
+ * nbx_fbxserial_set_default() - Initialize serial structure with defaults
+ * @serial: Pointer to serial structure to initialize
+ *
+ * Sets the serial structure to default values (Freebox OUI, type 9018).
+ * Used as fallback when serial info cannot be read from eMMC.
+ */
+void nbx_fbxserial_set_default(struct nbx_fbx_serial *serial);
+
+/**
+ * nbx_fbx_read_serial() - Read serial info from eMMC
+ * @dev_num: MMC device number
+ * @offset: Byte offset in eMMC where serial info is stored
+ * @fs: Pointer to serial structure to fill
+ *
+ * Reads and validates the serial info from eMMC. On failure,
+ * the structure is filled with default values.
+ *
+ * Return: 0 on success, negative on error (defaults still set)
+ */
+int nbx_fbx_read_serial(int dev_num, unsigned long offset,
+			struct nbx_fbx_serial *fs);
+
+/**
+ * nbx_fbx_dump_serial() - Print serial info to console
+ * @fs: Pointer to serial structure to display
+ *
+ * Prints the serial number, MAC address, and bundle info (if present).
+ */
+void nbx_fbx_dump_serial(struct nbx_fbx_serial *fs);
+
+/**
+ * nbx_fbx_init_ethaddr() - Initialize Ethernet addresses from serial info
+ * @dev_num: MMC device number
+ * @offset: Byte offset in eMMC where serial info is stored
+ *
+ * Reads serial info and sets ethaddr, eth1addr, eth2addr environment
+ * variables from the base MAC address in the serial structure.
+ *
+ * Return: 0 on success, negative on error
+ */
+int nbx_fbx_init_ethaddr(int dev_num, unsigned long offset);
+
+#endif /* NBX_FBXSERIAL_H */
-- 
2.43.0

