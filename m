Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2081EB1056
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381ED8407E;
	Tue, 10 Mar 2026 15:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="tLxYtJVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4287884065; Tue, 10 Mar 2026 15:13:27 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C7C84057
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id B68A85FFB1;
 Tue, 10 Mar 2026 15:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773152004;
 bh=Qqi+mefRUM1GpSOIOYfOBRH9S0fLmhAqk1xQ4rjq99A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tLxYtJVYMRxQm5FrR5rrZfjXgJKtZ8wevQVT+eoGsGrqxLa9MMsM6KjbEK5x173C/
 NuQVmMTrBAn11X/TH8tcf+KXzbLaHSFZ4Rn80L4sGaDsG1kExexylk1uENRpyRqOd2
 x9cAK+Q9UYRtFDANHqp3uLtXj2GQZmV6MvXpKAScjfJZInH9Q2PcpVk3yQEdT/BHeC
 fVo3aMCn3QDg/HFzIp2HNsGCvDxU/qWngLQKWRMh9djadW4HCHvFBQIJyOkHb7l8eX
 qU7ijRwIXe5/qqgvrqxQ+Hvrk9w2i8dO6DsCFa/ckD73nPYEd4ecm1pHQ0ll1g/WVB
 P0IT+uz23HAVA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 vjardin@free.fr
Subject: [PATCH v1 2/5] board: freebox: add Nodebox 10G board support
Date: Tue, 10 Mar 2026 15:12:49 +0100
Message-ID: <b5c6df1729a7bbb7619242b926ef5695d6f6fc48.1773151972.git.vjardin@free.fr>
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

Add board support for the Freebox Nodebox 10G based on the Marvell
Armada 8040 SoC. This board features:

- Quad-core ARMv8 AP806 with dual CP110 companions
- eMMC storage via Xenon SDHCI controller
- 1G SGMII and 10G SFI Ethernet on CP0 and CP1
- I2C buses for peripheral access
- NS16550 UART console at 115200 baud

The implementation includes:
- Device tree for the Nodebox 10G hardware
- Dedicated board directory (board/freebox/nbx10g/)
- Board-specific Kconfig and defconfig
- Management PHY reset via GPIO in board_late_init()

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 arch/arm/dts/Makefile               |   1 +
 arch/arm/dts/armada-8040-nbx.dts    | 259 ++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig         |   9 +
 board/freebox/nbx10g/Kconfig        |  12 ++
 board/freebox/nbx10g/MAINTAINERS    |  13 ++
 board/freebox/nbx10g/Makefile       |   3 +
 board/freebox/nbx10g/board.c        |  63 +++++++
 configs/mvebu_nbx_88f8040_defconfig |  73 ++++++++
 include/configs/nbx10g.h            |  29 ++++
 9 files changed, 462 insertions(+)
 create mode 100644 arch/arm/dts/armada-8040-nbx.dts
 create mode 100644 board/freebox/nbx10g/Kconfig
 create mode 100644 board/freebox/nbx10g/MAINTAINERS
 create mode 100644 board/freebox/nbx10g/Makefile
 create mode 100644 board/freebox/nbx10g/board.c
 create mode 100644 configs/mvebu_nbx_88f8040_defconfig
 create mode 100644 include/configs/nbx10g.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82ad3035308..1638d19e44d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -180,6 +180,7 @@ dtb-$(CONFIG_ARCH_MVEBU) +=			\
 	armada-8040-clearfog-gt-8k.dtb		\
 	armada-8040-db.dtb			\
 	armada-8040-mcbin.dtb			\
+	armada-8040-nbx.dtb			\
 	armada-8040-puzzle-m801.dtb		\
 	cn9130-db-A.dtb				\
 	cn9130-db-B.dtb				\
diff --git a/arch/arm/dts/armada-8040-nbx.dts b/arch/arm/dts/armada-8040-nbx.dts
new file mode 100644
index 00000000000..bfa8927c5e5
--- /dev/null
+++ b/arch/arm/dts/armada-8040-nbx.dts
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for NBX board (Freebox Nodebox10G)
+ * Based on Marvell Armada 8040 SoC
+ *
+ * Copyright (C) 2024 Freebox SA
+ */
+
+#include "armada-8040.dtsi"
+
+/ {
+	model = "NBX Armada 8040";
+	compatible = "nbx,armada8040", "marvell,armada8040";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		gpio0 = &ap_gpio0;
+		gpio1 = &cp0_gpio0;
+		gpio2 = &cp0_gpio1;
+	};
+
+	memory@00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;  /* 2GB */
+	};
+};
+
+/* AP806 UART - active */
+&uart0 {
+	status = "okay";
+};
+
+/* AP806 pinctrl */
+&ap_pinctl {
+	/*
+	 * MPP Bus:
+	 * eMMC  [0-10]
+	 * UART0 [11,19]
+	 */
+		  /* 0 1 2 3 4 5 6 7 8 9 */
+	pin-func = < 1 1 1 1 1 1 1 1 1 1
+		     1 3 0 0 0 0 0 0 0 3 >;
+};
+
+/* AP806 on-board eMMC */
+&ap_sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ap_emmc_pins>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+/* CP0 pinctrl */
+&cp0_pinctl {
+	/*
+	 * MPP Bus:
+	 * [0-31]  = 0xff: Keep default CP0_shared_pins
+	 * [32,34] GE_MDIO/MDC
+	 * [35-36] I2C1
+	 * [37-38] I2C0
+	 * [57-58] MSS I2C
+	 */
+		/*   0    1    2    3    4    5    6    7    8    9 */
+	pin-func = < 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 7    0    7    2    2    2    2    0
+		     0    0    0    0    0    0    0    0    0    0
+		     0    0    0    0    0    0    0    2    2    0
+		     0    0    0 >;
+
+	cp0_smi_pins: cp0-smi-pins {
+		marvell,pins = <32 34>;
+		marvell,function = <7>;
+	};
+};
+
+/* CP0 I2C0 */
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+/* CP0 I2C1 */
+&cp0_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+/* CP0 MSS I2C0 - Management SubSystem I2C (pins 57-58, func 2) */
+&cp0_mss_i2c0 {
+	status = "okay";
+};
+
+/* CP0 MDIO for PHY */
+&cp0_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_smi_pins>;
+
+	nbx_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+/* CP0 ComPhy - SerDes configuration */
+&cp0_comphy {
+	/*
+	 * CP0 Serdes Configuration:
+	 * Lane 0-3: Unconnected
+	 * Lane 4:   SFI (10G Ethernet)
+	 * Lane 5:   SGMII2 (1G Ethernet)
+	 */
+	phy0 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy1 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy2 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy3 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy4 {
+		phy-type = <COMPHY_TYPE_SFI0>;
+		phy-speed = <COMPHY_SPEED_10_3125G>;
+	};
+	phy5 {
+		phy-type = <COMPHY_TYPE_SGMII2>;
+		phy-speed = <COMPHY_SPEED_1_25G>;
+	};
+};
+
+/* CP0 Ethernet - only eth2 (MAC3) is active via SGMII */
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth2 {
+	status = "okay";
+	phy = <&nbx_phy0>;
+	phy-mode = "sgmii";
+};
+
+/* CP0 UTMI PHY for USB */
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi0 {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "okay";
+};
+
+/* CP0 USB3 Host controllers */
+&cp0_usb3_0 {
+	status = "okay";
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+};
+
+/* CP1 pinctrl */
+&cp1_pinctl {
+	/*
+	 * MPP Bus:
+	 * [0-26]  = Unconfigured
+	 * [27-28] GE_MDIO/MDC
+	 * [29-30] MSS I2C
+	 * [31]    = Unconfigured
+	 * [32-62] = 0xff: Keep default CP1_shared_pins
+	 */
+		/*   0    1    2    3    4    5    6    7    8    9 */
+	pin-func = < 0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0
+		     0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x0
+		     0x0  0x0  0x0  0x0  0x0  0x0  0x0  0x8  0x8  0x8
+		     0x8  0x0  0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
+		     0xff 0xff 0xff>;
+
+	cp1_mss_i2c_pins: cp1-mss-i2c-pins {
+		marvell,pins = <29 30>;
+		marvell,function = <8>;
+	};
+};
+
+/* CP1 MSS I2C0 - Management SubSystem I2C (pins 29-30, func 8) */
+&cp1_mss_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_mss_i2c_pins>;
+};
+
+/* CP1 ComPhy - SerDes configuration */
+&cp1_comphy {
+	/*
+	 * CP1 Serdes Configuration:
+	 * Lane 0:   PCIe x1
+	 * Lane 1:   USB3 Host
+	 * Lane 2-3: Unconnected
+	 * Lane 4:   SFI (10G Ethernet)
+	 * Lane 5:   Unconnected
+	 */
+	phy0 {
+		phy-type = <COMPHY_TYPE_PEX0>;
+	};
+	phy1 {
+		phy-type = <COMPHY_TYPE_USB3_HOST0>;
+	};
+	phy2 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy3 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+	phy4 {
+		phy-type = <COMPHY_TYPE_SFI0>;
+		phy-speed = <COMPHY_SPEED_10_3125G>;
+	};
+	phy5 {
+		phy-type = <COMPHY_TYPE_UNCONNECTED>;
+	};
+};
+
+/* CP1 PCIe x1 on lane 0 */
+&cp1_pcie0 {
+	status = "okay";
+};
+
+/* CP1 USB3 Host on lane 1 */
+&cp1_usb3_0 {
+	status = "okay";
+};
+
+/* CP1 UTMI PHY for USB */
+&cp1_utmi {
+	status = "okay";
+};
+
+&cp1_utmi0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index b76510ab452..66e5f1788d6 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -166,6 +166,14 @@ config TARGET_MVEBU_ARMADA_8K
 	select BOARD_LATE_INIT
 	imply SCSI
 
+config TARGET_NBX10G
+	bool "Support Freebox Nodebox 10G"
+	select ARMADA_8K
+	select BOARD_LATE_INIT
+	help
+	  Enable support for the Freebox Nodebox 10G board based on the
+	  Marvell Armada 8040 SoC with dual CP110 companion chips.
+
 config TARGET_MVEBU_ALLEYCAT5
 	bool "Support AlleyCat 5 platforms"
 	select ALLEYCAT_5
@@ -508,5 +516,6 @@ config ARMADA_32BIT_SYSCON_SYSRESET
 
 source "board/solidrun/clearfog/Kconfig"
 source "board/kobol/helios4/Kconfig"
+source "board/freebox/nbx10g/Kconfig"
 
 endif
diff --git a/board/freebox/nbx10g/Kconfig b/board/freebox/nbx10g/Kconfig
new file mode 100644
index 00000000000..18a169761b7
--- /dev/null
+++ b/board/freebox/nbx10g/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_NBX10G
+
+config SYS_BOARD
+	default "nbx10g"
+
+config SYS_VENDOR
+	default "freebox"
+
+config SYS_CONFIG_NAME
+	default "nbx10g"
+
+endif
diff --git a/board/freebox/nbx10g/MAINTAINERS b/board/freebox/nbx10g/MAINTAINERS
new file mode 100644
index 00000000000..4753a9a13bb
--- /dev/null
+++ b/board/freebox/nbx10g/MAINTAINERS
@@ -0,0 +1,13 @@
+NBX10G BOARD
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	board/freebox/nbx10g/
+F:	configs/mvebu_nbx_88f8040_defconfig
+F:	arch/arm/dts/armada-8040-nbx.dts
+F:	arch/arm/dts/armada-8040-nbx-u-boot.dtsi
+F:	include/configs/nbx10g.h
+F:	cmd/mvebu/mvebu_emmcboot.c
+F:	cmd/mvebu/nbx_fbxserial.c
+F:	include/mvebu_imagetag.h
+F:	include/mvebu_nrboot.h
+F:	include/nbx_fbxserial.h
diff --git a/board/freebox/nbx10g/Makefile b/board/freebox/nbx10g/Makefile
new file mode 100644
index 00000000000..bf83bdf63ee
--- /dev/null
+++ b/board/freebox/nbx10g/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	:= board.o
diff --git a/board/freebox/nbx10g/board.c b/board/freebox/nbx10g/board.c
new file mode 100644
index 00000000000..7080e386c38
--- /dev/null
+++ b/board/freebox/nbx10g/board.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017-2018 Freebox SA
+ * Copyright (C) 2026 Free Mobile, Vincent Jardin <vjardin@free.fr>
+ *
+ * Freebox Nodebox 10G board support
+ */
+
+#include <config.h>
+#include <dm.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/soc.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Management PHY reset GPIO */
+#define NBX_PHY_RESET_GPIO	83
+
+/* Nodebox 10G ASCII art logo */
+static const char * const nbx_logo =
+	"  _   _           _      _                 __  ___   _____\n"
+	" | \\ | |         | |    | |               /_ |/ _ \\ / ____|\n"
+	" |  \\| | ___   __| | ___| |__   _____  __  | | | | | |  __\n"
+	" | . ` |/ _ \\ / _` |/ _ \\ '_ \\ / _ \\ \\/ /  | | | | | | |_ |\n"
+	" | |\\  | (_) | (_| |  __/ |_) | (_) >  <   | | |_| | |__| |\n"
+	" |_| \\_|\\___/ \\__,_|\\___|_.__/ \\___/_/\\_\\  |_|\\___/ \\_____|\n";
+
+int checkboard(void)
+{
+	printf("%s\n", nbx_logo);
+	return 0;
+}
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+	return 0;
+}
+
+int board_late_init(void)
+{
+	int ret;
+
+	/* Reset the management PHY */
+	ret = gpio_request(NBX_PHY_RESET_GPIO, "phy-reset");
+	if (ret) {
+		printf("Failed to request PHY reset GPIO: %d\n", ret);
+		return 0;
+	}
+
+	gpio_direction_output(NBX_PHY_RESET_GPIO, 0);
+	mdelay(100);
+	gpio_set_value(NBX_PHY_RESET_GPIO, 1);
+	mdelay(100);
+	gpio_free(NBX_PHY_RESET_GPIO);
+
+	return 0;
+}
diff --git a/configs/mvebu_nbx_88f8040_defconfig b/configs/mvebu_nbx_88f8040_defconfig
new file mode 100644
index 00000000000..975c53e9a92
--- /dev/null
+++ b/configs/mvebu_nbx_88f8040_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_NBX10G=y
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x180000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="armada-8040-nbx"
+CONFIG_FIT=y
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_PCI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="echo (CRC warning is normal: no env saved yet)"
+CONFIG_SYS_PBSIZE=1048
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_DISPLAY_CPUINFO=y
+CONFIG_SYS_PROMPT="nodebox10G>> "
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+# CONFIG_CMD_SF is not set
+CONFIG_CMD_USB=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_EFI_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_I2C_MUX=y
+CONFIG_MISC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_XENON=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_GIGE=y
+CONFIG_MVPP2=y
+CONFIG_PCIE_DW_MVEBU=y
+CONFIG_PHY=y
+CONFIG_MVEBU_COMPHY_SUPPORT=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_ARMADA_8K=y
+CONFIG_SYS_NS16550=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_STORAGE=y
diff --git a/include/configs/nbx10g.h b/include/configs/nbx10g.h
new file mode 100644
index 00000000000..bd083b7e7d8
--- /dev/null
+++ b/include/configs/nbx10g.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2017-2018 Freebox SA
+ * Copyright (C) 2026 Free Mobile, Vincent Jardin <vjardin@free.fr>
+ *
+ * Configuration for Freebox Nodebox 10G
+ */
+
+#ifndef _CONFIG_NBX10G_H
+#define _CONFIG_NBX10G_H
+
+#include "mvebu_armada-8k.h"
+
+/* Override environment settings for NBX */
+#undef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS \
+	"hostname=nodebox10G\0" \
+	"ethrotate=no\0" \
+	"image_addr=0x7000000\0" \
+	"image_name=Image.nodebox10G\0" \
+	"fdt_addr=0x6f00000\0" \
+	"fdt_name=nodebox10G.dtb\0" \
+	"console=ttyS0,115200\0" \
+	"tftpboot=setenv bootargs console=${console} bank=tftp; " \
+		"dhcp ${image_addr} ${image_name}; " \
+		"tftp ${fdt_addr} ${fdt_name}; " \
+		"booti ${image_addr} - ${fdt_addr}\0"
+
+#endif /* _CONFIG_NBX10G_H */
-- 
2.43.0

