Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DF4C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C24886EB5;
	Mon, 10 Jun 2024 15:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B214F8858B; Mon, 10 Jun 2024 15:14:07 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C16E88550
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXM04ZBSzjm9;
 Mon, 10 Jun 2024 15:14:04 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLz478RzHsf; Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:38 +0200
Subject: [PATCH next v3 8/8] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-8-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <foss+uboot@0leil.net>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14-dev-a6ee3
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
connector) system-on-module from Theobroma Systems, featuring the
Rockchip RK3588.

It provides the following feature set:
 * up to 16GB LPDDR4x
 * on-module eMMC
 * SD card (on a baseboard) via edge connector
 * Gigabit Ethernet with on-module GbE PHY
 * HDMI/eDP
 * MIPI-DSI
 * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
 * HDMI input over FPC connector
 * CAN
 * USB
   - 1x USB 3.0 dual-role (direct connection)
   - 2x USB 3.0 host + 1x USB 2.0 host
 * PCIe
   - 1x PCIe 2.1 Gen3, 4 lanes
   - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
 * on-module ATtiny816 companion controller, implementing:
   - low-power RTC functionality (ISL1208 emulation)
   - fan controller (AMC6821 emulation)
 * on-module Secure Element with Global Platform 2.2.1 compliant
   JavaCard environment

The support is added for Tiger on Haikou devkit, similarly to RK3399
Puma and PX30 Ringneck.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  37 +++++++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  31 ++++++
 board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +++
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +++
 board/theobroma-systems/tiger_rk3588/Makefile      |  10 ++
 .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++++++++++
 configs/tiger-rk3588_defconfig                     | 113 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |   1 +
 doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++++++++++++++++++
 include/configs/tiger_rk3588.h                     |  15 +++
 11 files changed, 392 insertions(+)

diff --git a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
new file mode 100644
index 00000000000..275ae6fdaea
--- /dev/null
+++ b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
+	};
+};
+
+&emmc_pwrseq {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_reset {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	/* U-Boot currently cannot handle anything below HS200 for eMMC on RK3588 */
+	/delete-property/ mmc-ddr-1_8v;
+	/delete-property/ cap-mmc-highspeed;
+};
+
+&uart2m2_xfer {
+	bootph-all;
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 9f82e9f3371..9a35c7d9cc2 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -193,6 +193,36 @@ config TARGET_QUARTZPRO64_RK3588
 	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
 	  Computer) by Pine64.
 
+config TARGET_TIGER_RK3588
+	bool "Theobroma Systems SOM-RK3588-Q7 (Tiger)"
+	select BOARD_LATE_INIT
+	help
+	  The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
+	  connector) system-on-module from Theobroma Systems, featuring the
+	  Rockchip RK3588.
+
+	  It provides the following feature set:
+	   * up to 16GB LPDDR4x
+	   * on-module eMMC
+	   * SD card (on a baseboard) via edge connector
+	   * Gigabit Ethernet with on-module GbE PHY
+	   * HDMI/eDP
+	   * MIPI-DSI
+	   * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
+	   * HDMI input over FPC connector
+	   * CAN
+	   * USB
+	     - 1x USB 3.0 dual-role (direct connection)
+	     - 2x USB 3.0 host + 1x USB 2.0 host
+	   * PCIe
+	     - 1x PCIe 2.1 Gen3, 4 lanes
+	     - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
+	   * on-module ATtiny816 companion controller, implementing:
+	     - low-power RTC functionality (ISL1208 emulation)
+	     - fan controller (AMC6821 emulation)
+	   * on-module Secure Element with Global Platform 2.2.1 compliant
+	     JavaCard environment
+
 config TARGET_TURINGRK1_RK3588
 	bool "Turing Machines RK1 RK3588 board"
 	select BOARD_LATE_INIT
@@ -266,5 +296,6 @@ source "board/radxa/rock5b-rk3588/Kconfig"
 source "board/rockchip/evb_rk3588/Kconfig"
 source "board/rockchip/toybrick_rk3588/Kconfig"
 source "board/theobroma-systems/jaguar_rk3588/Kconfig"
+source "board/theobroma-systems/tiger_rk3588/Kconfig"
 
 endif
diff --git a/board/theobroma-systems/tiger_rk3588/Kconfig b/board/theobroma-systems/tiger_rk3588/Kconfig
new file mode 100644
index 00000000000..2c6ac6a9a83
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_TIGER_RK3588
+
+config SYS_BOARD
+	default "tiger_rk3588"
+
+config SYS_VENDOR
+	default "theobroma-systems"
+
+config SYS_CONFIG_NAME
+	default "tiger_rk3588"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ENV_IS_NOWHERE
+
+endif
diff --git a/board/theobroma-systems/tiger_rk3588/MAINTAINERS b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
new file mode 100644
index 00000000000..e5aab4b29f3
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
@@ -0,0 +1,13 @@
+TIGER-RK3588 (SOM-RK3588-Q7)
+M:	Klaus Goger <klaus.goger@cherry.de>
+M:	Quentin Schulz <quentin.schulz@cherry.de>
+M:	Heiko Stuebner <heiko.stuebner@cherry.de>
+S:	Maintained
+F:	board/theobroma-systems/tiger_rk3588
+F:	board/theobroma-systems/common
+F:	doc/board/theobroma-systems/
+F:	include/configs/tiger_rk3588.h
+F:	arch/arm/dts/rk3588-tiger*
+F:	configs/tiger-rk3588_defconfig
+W:	https://embedded.cherry.de/product/tiger-som-rk3588-q7/
+T:	git git://git.embedded.cherry.de/tiger-u-boot.git
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
new file mode 100644
index 00000000000..5c4c484657a
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -0,0 +1,10 @@
+#
+# Copyright (c) 2024 Theobroma Systems Design und Consulting GmbH
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+obj-y += tiger_rk3588.o
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y	+= ../common/common.o
+endif
diff --git a/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
new file mode 100644
index 00000000000..a6d44f10db3
--- /dev/null
+++ b/board/theobroma-systems/tiger_rk3588/tiger_rk3588.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <phy.h>
+#include <eth_phy.h>
+
+#include <asm/types.h>
+#include <asm/arch-rockchip/cru_rk3588.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/arch-rockchip/ioc_rk3588.h>
+#include <asm-generic/u-boot.h>
+#include <dm/device.h>
+#include <dm/uclass-id.h>
+#include <linux/bitfield.h>
+
+#include "../common/common.h"
+
+#define GPIO2C3_SEL_MASK		GENMASK(15, 12)
+#define GPIO2C3_ETH0_REFCLKO_25M	FIELD_PREP(GPIO2C3_SEL_MASK, 1)
+
+#define REFCLKO25M_ETH0_OUT_SEL_MASK	BIT(15)
+#define REFCLKO25M_ETH0_OUT_SEL_CPLL	FIELD_PREP(REFCLKO25M_ETH0_OUT_SEL_MASK, 1)
+#define REFCLKO25M_ETH0_OUT_DIV_MASK	GENMASK(14, 8)
+#define REFCLKO25M_ETH0_OUT_DIV(x)	FIELD_PREP(REFCLKO25M_ETH0_OUT_DIV_MASK, (x) - 1)
+
+#define REFCLKO25M_ETH0_OUT_EN		BIT(4)
+
+void setup_eth0refclko(void)
+{
+	/* Configure and enable ETH0_REFCLKO_25MHz */
+	static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
+	static struct rk3588_cru * const cru = (void *)CRU_BASE;
+
+	/* 1. Pinmux */
+	rk_clrsetreg(&bus_ioc->gpio2c_iomux_sel_l, GPIO2C3_SEL_MASK, GPIO2C3_ETH0_REFCLKO_25M);
+	/* 2. Parent clock selection + divider => CPLL (1.5GHz) / 60 => 25MHz */
+	rk_clrsetreg(&cru->clksel_con[15],
+		     REFCLKO25M_ETH0_OUT_SEL_MASK | REFCLKO25M_ETH0_OUT_DIV_MASK,
+		     REFCLKO25M_ETH0_OUT_SEL_CPLL | REFCLKO25M_ETH0_OUT_DIV(60));
+	/* 3. Enable clock */
+	rk_clrreg(&cru->clkgate_con[5], REFCLKO25M_ETH0_OUT_EN);
+}
+
+int rockchip_early_misc_init_r(void)
+{
+	setup_boottargets();
+
+	setup_eth0refclko();
+
+	return 0;
+}
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
new file mode 100644
index 00000000000..8fcdd063a3d
--- /dev/null
+++ b/configs/tiger-rk3588_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-tiger-haikou"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_TIGER_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xfeb50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+# CONFIG_DEBUG_UART_BOARD_INIT is not set
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-tiger-haikou.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CYCLIC=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SF is not set
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_MII is not set
+# CONFIG_CMD_BLOCK_CACHE is not set
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EROFS=y
+CONFIG_CMD_SQUASHFS=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_GPIO=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index fec8675c8be..eaf71673b7f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -131,6 +131,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 5B (rock5b-rk3588)
      - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
      - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
+     - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
index b4da2616c37..73e07f7ebfa 100644
--- a/doc/board/theobroma-systems/index.rst
+++ b/doc/board/theobroma-systems/index.rst
@@ -9,3 +9,4 @@ Theobroma Systems
    jaguar_rk3588
    puma_rk3399
    ringneck_px30
+   tiger_rk3588
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
new file mode 100644
index 00000000000..a73eec7fb9b
--- /dev/null
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+SOM-RK3588-Q7 Tiger
+===================
+
+The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
+connector) system-on-module from Theobroma Systems, featuring the
+Rockchip RK3588.
+
+It provides the following feature set:
+ * up to 16GB LPDDR4x
+ * on-module eMMC
+ * SD card (on a baseboard) via edge connector
+ * Gigabit Ethernet with on-module GbE PHY
+ * HDMI/eDP
+ * MIPI-DSI
+ * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
+ * HDMI input over FPC connector
+ * CAN
+ * USB
+   - 1x USB 3.0 dual-role (direct connection)
+   - 2x USB 3.0 host + 1x USB 2.0 host
+ * PCIe
+   - 1x PCIe 2.1 Gen3, 4 lanes
+   - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
+ * on-module ATtiny816 companion controller, implementing:
+   - low-power RTC functionality (ISL1208 emulation)
+   - fan controller (AMC6821 emulation)
+ * on-module Secure Element with Global Platform 2.2.1 compliant
+   JavaCard environment
+
+Here is the step-by-step to boot to U-Boot on SOM-RK3588-Q7 Tiger from Theobroma
+Systems.
+
+Get the TF-A and DDR init (TPL) binaries
+----------------------------------------
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkbin
+   cd rkbin
+   export RKBIN=$(pwd)
+   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.38.elf
+   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.11.bin
+   sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
+   sed -i 's/^uart iomux=.*$/uart iomux=2/' tools/ddrbin_param.txt
+   ./tools/ddrbin_tool tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
+   export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
+
+This will setup all required external dependencies for compiling U-Boot. This will
+be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
+gains support for open-source DRAM initialization in TPL.
+
+Build U-Boot
+------------
+
+.. prompt:: bash
+
+   cd ../u-boot
+   make CROSS_COMPILE=aarch64-linux-gnu- tiger-rk3588_defconfig all
+
+This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
+(eMMC or SD card).
+
+Flash the image
+---------------
+
+Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
+
+SD-Card
+~~~~~~~
+
+.. prompt:: bash
+
+   dd if=u-boot-rockchip.bin of=/dev/sdX seek=64
+
+.. note::
+
+   Replace ``/dev/sdX`` to match your SD card kernel device.
+
+eMMC
+~~~~
+
+``rkdeveloptool`` allows to flash the on-board eMMC via the USB OTG interface
+with help of the Rockchip loader binary.
+
+To enter the USB flashing mode on Haikou baseboard, remove any SD card, insert a
+micro-USB cable in the ``Q7 USB P1`` connector (P8), move ``SW5`` switch into
+``BIOS Disable`` mode, power cycle or reset the board and move ``SW5`` switch
+back to ``Normal Boot`` mode. A new USB device should have appeared on your PC
+(check with ``lsusb -d 2207:350b``).
+
+To flash U-Boot on the eMMC with ``rkdeveloptool``:
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkdeveloptool
+   cd rkdeveloptool
+   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
+   ./rkdeveloptool db "$RKDB"
+   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
diff --git a/include/configs/tiger_rk3588.h b/include/configs/tiger_rk3588.h
new file mode 100644
index 00000000000..7a32adfaf2a
--- /dev/null
+++ b/include/configs/tiger_rk3588.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#ifndef __TIGER_RK3588_H
+#define __TIGER_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __TIGER_RK3588_H */

-- 
2.45.2

