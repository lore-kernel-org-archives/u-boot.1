Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5BDC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 12:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8E580657;
	Sat, 18 Jan 2025 13:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YhBPW3s3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LZyKwgmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99BFE8070C; Sat, 18 Jan 2025 13:22:35 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B978063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 13:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZwj35QQyz9smm;
 Sat, 18 Jan 2025 13:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737202951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qWoyomYHKVoGH8f0NrCbDj7i0DnktoozhbNsxN6qVhA=;
 b=YhBPW3s3iPeqzobItF88SgiAWqZW6RTPFYRQWYUkardHxYQ1xS8dmLbhYWmoXlZlNXcS77
 Ucje4StthnydYWRiABrfKGc/YoFu4UY0avdCBw8CRi+lBvkFMHq0mmQNnxdtdTUlmXeVU1
 BU9PR4qDgS5C2MDxFGnko6CoEeZNRR9nXg67XKOyANw7wAYTBvY0UpGYzaafzLtP3mW0U1
 stoZYQTzr7HimtgcyCAeG8jDqy7i9yA6BoEj6smWUsopUXWKZC5qUDZoHBXWjo8HTAuSwP
 Q5OBk++ttKbkrhciY17EQtjewU0lc+Lwcc01Bp2cGi1S/fJsFCImYsIo8mo0xA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737202949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qWoyomYHKVoGH8f0NrCbDj7i0DnktoozhbNsxN6qVhA=;
 b=LZyKwgmr68Z7uiFnoS7WYhn0KbQZUfFSV+Z/L+yIGxPmm8xclvtijC9fJ925qHpKfhUYHk
 GiAgOhw6ZSkV0MdCVPma+v+LFxo7i/JUKbVmNQCBm45lQM9gRxJHu0deHwFZVUsCnhWmEn
 XOJwTJqIIAiBQmZ1KOy3en/H0jZM2xvob1/ic3IQ4dAcU1iu2ZuOvj7y5xvwz2XphInhWn
 HyG1OzJ7yOd24UhLTdNAscaSSYv/ob5/HGXyZQL9DoSArKX8RUo9xwFfTmgHC9M0SeuuxL
 Dwc61IudslWh9DGjDfnmK345bqmhCSWsgUGATebjmuZNp/w87Wpn3CNca2+c4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Add R-Car S4 Starter Kit support
Date: Sat, 18 Jan 2025 13:21:23 +0100
Message-ID: <20250118122214.388300-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d8abc95f19c399b08b7
X-MBO-RS-META: jtxpcpqdoqgrp8moc1a1edx9ysm9u1to
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
index 00000000000..7a1985e5e8d
--- /dev/null
+++ b/board/renesas/s4sk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Renesas Electronics Corp.
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= s4sk.o ../rcar-common/gen4-common.o ../rcar-common/common.o
diff --git a/board/renesas/s4sk/s4sk.c b/board/renesas/s4sk/s4sk.c
new file mode 100644
index 00000000000..92eb4ee0297
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
+	 * - ethaddr ..... TSN0
+	 * - eth1addr .... TSN1
+	 * - eth2addr .... TSN2 (not accessible)
+	 * - eth3addr .... AVB
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

