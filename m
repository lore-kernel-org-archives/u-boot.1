Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F6C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 01:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8A7807A8;
	Fri, 31 Jan 2025 02:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hZ70eTgE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hT5U4cfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE21807A8; Fri, 31 Jan 2025 02:21:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C1080646
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YkdPn11Vnz9tn3;
 Fri, 31 Jan 2025 02:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738286461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UAyDxHg1/T/s0Pvl/UoNbwCmuvzICmFdt9fPJM/Yxfc=;
 b=hZ70eTgES+fO86koYjPgglCnp9i4XHfhLD/mf7bLAT8AAAHSJDIBfDYNDCaXsT/4/Lrmn5
 mx/YERjwMnc58/vugLdjSE038ya4NUzH+tX2wPfNpZj5GZ2mriiAcQFzV7tCZlrIrwF2j8
 s3FJD9yc3U0TDtJl83a9318fOk3aTy3jrLfYLiMUS3OJzJmwICrg3p1r3MzxsmlQv77Tku
 JfZF7HggynLbQnr1aun9w2gie2Mm7KXj+HWTzDbQWj7d/BpoJMjNonEjjNShRlGhU7Kktd
 vc0zsSX9NMAMHhPr+Yyx3Iv7F1ZpNaOODPNVzdRrPtPVlhoJ073Ijwnoz+T4zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738286458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UAyDxHg1/T/s0Pvl/UoNbwCmuvzICmFdt9fPJM/Yxfc=;
 b=hT5U4cfXLHSx7yZ5y/YzqGRmkRyAqGXggYKyIivHeLU/Fa+YOhEu4TSngBhWkiKDx66TRY
 QkqHFRLBpptc9KCJk+umSXYFkilTWNR66Gug2D20U2ImrdOit3CEJdjuhPRHktHWSeT8qt
 pw6YHlx/omGcnw76xNErCiMBBFbXy5XqVZ1sKFDIt23FIxWauJqpED1ozj9TcpQUJZ5lN0
 Eon97Ym6SvYfFkdavE3QC7NQ+7yowWyPQynHMDMbQl8tPeEQElaXTc3vnIwPqZRVk1gCHr
 szyxBr3HaJbOQa/cSYO7R0nIlDUvHQMsyMGyOT/N/zZzbg4AW7JrpffwVejYNQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] arm64: renesas: Add R-Car S4 Starter Kit support
Date: Fri, 31 Jan 2025 02:19:57 +0100
Message-ID: <20250131012042.270613-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w91kj1z69keki3mubmzpjnfhrh1dehed
X-MBO-RS-ID: 5c3e4e450a35220aac4
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

Add support for the R-Car S4 Starter Kit with R8A779F4 SoC support.
This implementation natively uses OF_UPSTREAM to pull in most recent
DT. The defconfig is derived from S4 Spider, with reduced UART baud
rate to 921600 Bdps. The DT alias to rswitch is removed as the alias
should point to rswitch ports, not to rswitch itself, see [1].

[1] https://lore.kernel.org/linux-arm-kernel/20250118111344.361617-5-marek.vasut+renesas@mailbox.org/

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Include ethernet port connector placement and fix up TSN2, which yes is accessible
V3: Update Makefile on top of deduplication series ARM: renesas: Simplify board Makefiles
---
 arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi | 42 +++++++++++++
 arch/arm/mach-renesas/Kconfig.rcar4    |  7 +++
 board/renesas/s4sk/Kconfig             | 15 +++++
 board/renesas/s4sk/MAINTAINERS         |  7 +++
 board/renesas/s4sk/Makefile            |  7 +++
 board/renesas/s4sk/s4sk.c              | 85 ++++++++++++++++++++++++++
 configs/r8a779f0_spider_defconfig      | 27 +-------
 configs/r8a779f4_s4sk_defconfig        | 11 ++++
 configs/renesas_rcar4_s4.config        | 23 +++++++
 doc/board/renesas/renesas.rst          |  6 ++
 include/configs/s4sk.h                 | 13 ++++
 11 files changed, 219 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi
 create mode 100644 board/renesas/s4sk/Kconfig
 create mode 100644 board/renesas/s4sk/MAINTAINERS
 create mode 100644 board/renesas/s4sk/Makefile
 create mode 100644 board/renesas/s4sk/s4sk.c
 create mode 100644 configs/r8a779f4_s4sk_defconfig
 create mode 100644 configs/renesas_rcar4_s4.config
 create mode 100644 include/configs/s4sk.h

diff --git a/arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi b/arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi
new file mode 100644
index 00000000000..c2c743ba501
--- /dev/null
+++ b/arch/arm/dts/r8a779f4-s4sk-u-boot.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the S4SK board
+ *
+ * Copyright (C) 2024-2025 Renesas Electronics Corp.
+ */
+
+#include "r8a779f0-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &rpc;
+		/delete-property/ ethernet0;
+	};
+};
+
+&pfc {
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data4";
+		function = "qspi0";
+	};
+};
+
+&rpc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <40000000>;
+	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "s25fs512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		spi-max-frequency = <40000000>;
+	};
+};
diff --git a/arch/arm/mach-renesas/Kconfig.rcar4 b/arch/arm/mach-renesas/Kconfig.rcar4
index c2812fd75e4..c42bb9765ef 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar4
+++ b/arch/arm/mach-renesas/Kconfig.rcar4
@@ -54,6 +54,12 @@ config TARGET_SPIDER
 	help
 	  Support for Renesas R-Car Gen4 Spider platform
 
+config TARGET_S4SK
+	bool "S4SK board"
+	imply R8A779F0
+	help
+	  Support for Renesas R-Car Gen4 S4SK platform
+
 config TARGET_WHITEHAWK
 	bool "White Hawk board"
 	imply R8A779G0
@@ -70,6 +76,7 @@ endchoice
 
 source "board/renesas/falcon/Kconfig"
 source "board/renesas/spider/Kconfig"
+source "board/renesas/s4sk/Kconfig"
 source "board/renesas/whitehawk/Kconfig"
 source "board/renesas/grayhawk/Kconfig"
 
diff --git a/board/renesas/s4sk/Kconfig b/board/renesas/s4sk/Kconfig
new file mode 100644
index 00000000000..57013d22b8c
--- /dev/null
+++ b/board/renesas/s4sk/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_S4SK
+
+config SYS_SOC
+	default "renesas"
+
+config SYS_BOARD
+	default "s4sk"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "s4sk"
+
+endif
diff --git a/board/renesas/s4sk/MAINTAINERS b/board/renesas/s4sk/MAINTAINERS
new file mode 100644
index 00000000000..e64da079160
--- /dev/null
+++ b/board/renesas/s4sk/MAINTAINERS
@@ -0,0 +1,7 @@
+S4SK BOARD
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
+S:	Maintained
+F:	arch/arm/dts/r8a779f4*
+F:	board/renesas/s4sk/
+F:	configs/r8a779f4_s4sk_defconfig
+F:	include/configs/s4sk.h
diff --git a/board/renesas/s4sk/Makefile b/board/renesas/s4sk/Makefile
new file mode 100644
index 00000000000..f03e52386f2
--- /dev/null
+++ b/board/renesas/s4sk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Renesas Electronics Corp.
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= s4sk.o
diff --git a/board/renesas/s4sk/s4sk.c b/board/renesas/s4sk/s4sk.c
new file mode 100644
index 00000000000..d2beb71c684
--- /dev/null
+++ b/board/renesas/s4sk/s4sk.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <malloc.h>
+#include <net-common.h>
+
+#define S4SK_FPGA_I2C_BUS			"i2c5"
+#define S4SK_FPGA_I2C_DEV_ADDR			0x70
+#define S4SK_FPGA_I2C_DEV_WIDTH			2
+#define S4SK_FPGA_I2C_MAC_COUNT			4
+#define S4SK_FPGA_I2C_MAC_OFFSET		0x58
+#define S4SK_FPGA_I2C_MAC_WIDTH			8
+
+int board_late_init(void)
+{
+	/*
+	 * Extract AVB and TSN0,1,2 MAC addresses from FPGA via I2C.
+	 *
+	 * In case a matching ethaddr/ethNaddr environment variable
+	 * is not set, set it, otherwise do not override it. This
+	 * allows users to set their own MAC addresses via ethaddr
+	 * and ethNaddr environment variables.
+	 *
+	 * The ethaddr/ethNaddr mapping follows Linux kernel DT aliases
+	 * ethernetN property assignment:
+	 * - ethaddr ..... TSN0 (IC104 connector)
+	 * - eth1addr .... TSN1 (IC101 connector)
+	 * - eth2addr .... TSN2 (Expansion connector)
+	 * - eth3addr .... AVB (CN1 connector)
+	 */
+	ofnode i2c_node = ofnode_path(S4SK_FPGA_I2C_BUS);
+	struct udevice *bus, *dev;
+	unsigned char enetaddr[6];
+	unsigned char macs[32];	/* Four MAC addresses in FPGA in total. */
+	int i, idx, j, ret;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C, i2c_node, &bus);
+	if (ret < 0) {
+		printf("s4sk: cannot find i2c bus (%d)\n", ret);
+		return 0;
+	}
+
+	ret = i2c_get_chip(bus, S4SK_FPGA_I2C_DEV_ADDR,
+			   S4SK_FPGA_I2C_DEV_WIDTH, &dev);
+	if (ret < 0) {
+		printf("s4sk: cannot find i2c chip (%d)\n", ret);
+		return 0;
+	}
+
+	ret = dm_i2c_read(dev, S4SK_FPGA_I2C_MAC_OFFSET, macs, sizeof(macs));
+	if (ret < 0) {
+		printf("s4sk: failed to read MAC addresses via i2c (%d)\n", ret);
+		return 0;
+	}
+
+	for (i = 0; i < S4SK_FPGA_I2C_MAC_COUNT; i++) {
+		/*
+		 * Remap TSN0,1,2 to ethaddr,eth1addr,eth2addr and
+		 * AVB to eth3addr to match Linux /aliases ethernetN
+		 * assignment, which starts with ethernet0 for TSN.
+		 */
+		idx = (i + 3) % 4;
+		ret = eth_env_get_enetaddr_by_index("eth", idx, enetaddr);
+		if (ret)	/* ethaddr is already set */
+			continue;
+
+		/* Byte-wise reverse the MAC address */
+		for (j = 0; j < sizeof(enetaddr); j++)
+			enetaddr[j] = macs[i * S4SK_FPGA_I2C_MAC_WIDTH + (5 - j)];
+
+		if (!is_valid_ethaddr(enetaddr)) {
+			printf("s4sk: MAC address %d in FPGA not valid (%pM)\n",
+			       i, enetaddr);
+			continue;
+		}
+
+		eth_env_set_enetaddr_by_index("eth", idx, enetaddr);
+	}
+
+	return 0;
+}
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 7274038a202..6b16ff55480 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -1,32 +1,11 @@
-#include <configs/renesas_rcar4.config>
+#include <configs/renesas_rcar4_s4.config>
 
 CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
-CONFIG_ENV_SIZE=0x40000
-CONFIG_ENV_OFFSET=0xD00000
-CONFIG_ENV_SECT_SIZE=0x40000
-CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
 CONFIG_TARGET_SPIDER=y
-CONFIG_SYS_CLK_FREQ=20000000
-CONFIG_SYS_BOOT_GET_CMDLINE=y
-CONFIG_SYS_BARGSIZE=2048
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779f0-spider.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779f0-spider.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_CMD_PART=y
-CONFIG_CMD_UFS=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_LBA48=y
-CONFIG_SYS_64BIT_LBA=y
-CONFIG_CLK_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_PHYLIB_10G=y
-CONFIG_PHY_MARVELL_10G=y
-CONFIG_RENESAS_ETHER_SWITCH=y
-CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
-CONFIG_SCSI=y
 CONFIG_BAUDRATE=1843200
-CONFIG_UFS=y
-CONFIG_UFS_RENESAS=y
-CONFIG_FS_FAT_MAX_CLUSTSIZE=131072
+CONFIG_DM_PCA953X=y
diff --git a/configs/r8a779f4_s4sk_defconfig b/configs/r8a779f4_s4sk_defconfig
new file mode 100644
index 00000000000..1b353492d04
--- /dev/null
+++ b/configs/r8a779f4_s4sk_defconfig
@@ -0,0 +1,11 @@
+#include <configs/renesas_rcar4_s4.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_RCAR_GEN4=y
+CONFIG_TARGET_S4SK=y
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f4-s4sk"
+CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779f4-s4sk.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_DEFAULT_FDT_FILE="r8a779f4-s4sk.dtb"
+CONFIG_BAUDRATE=921600
+CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/renesas_rcar4_s4.config b/configs/renesas_rcar4_s4.config
new file mode 100644
index 00000000000..866e5759e63
--- /dev/null
+++ b/configs/renesas_rcar4_s4.config
@@ -0,0 +1,23 @@
+#include <configs/renesas_rcar4.config>
+
+CONFIG_CLK_GPIO=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_UFS=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_OFFSET=0xD00000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_FS_FAT_MAX_CLUSTSIZE=131072
+CONFIG_LBA48=y
+CONFIG_PHYLIB_10G=y
+CONFIG_PHY_MARVELL_10G=y
+CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
+CONFIG_RENESAS_ETHER_SWITCH=y
+CONFIG_SCSI=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_SYS_BARGSIZE=2048
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_CLK_FREQ=20000000
+CONFIG_UFS=y
+CONFIG_UFS_RENESAS=y
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 7d961e862e4..0a38ff42eae 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -168,6 +168,12 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - arm64
      - r8a779f0_spider_defconfig
 
+   * -
+     - S4SK
+     - R8A779F4 (S4)
+     - arm64
+     - r8a779f4_s4sk_defconfig
+
    * -
      - White Hawk
      - R8A779G0 (V4H)
diff --git a/include/configs/s4sk.h b/include/configs/s4sk.h
new file mode 100644
index 00000000000..a1707359a39
--- /dev/null
+++ b/include/configs/s4sk.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * This file is S4SK board configuration.
+ *
+ * Copyright (C) 2024-2025 Renesas Electronics Corp.
+ */
+
+#ifndef __S4SK_H
+#define __S4SK_H
+
+#include "rcar-gen4-common.h"
+
+#endif /* __S4SK_H */
-- 
2.45.2

