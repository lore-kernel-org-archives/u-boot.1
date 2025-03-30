Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FDBC36010
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 17:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE85812BC;
	Sun, 30 Mar 2025 19:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VbG7oBA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FF281DE3; Sun, 30 Mar 2025 19:20:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E48F80FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 19:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743355251; bh=3+6z8tmM7QpDFliBQ+Y8FQaS45c3RJmuI0BMUL4fRT8=;
 b=VbG7oBA8FfDTuqSaGhqVYdvhOSkUwrmbPhrnL7Zgnssmfn/zBa4FlrNXruN/YUscroXHXtG6G
 olYdF6RDOMvByk/9Iz/ked+PybeuILZ2c3IwTmrkt5mMIVggo4OreaYK+m1MTcI2S/xOp4hwnfG
 QcCxsPgjY0JdJ4lpKxFQy8NM+nCVD4bjKBhT+y/r23i1d66NoKqHFPrfqFwbnXS2HwiaBh5L/95
 5nDIGD1RWwtvuhW9BnSwC0kVR+oWSoTgO/LvAcxUYtGyGh/tvv9oRbu3AXL5MOPaYGe2x29QBWb
 p4WQow7NUgkN+51tcAX0kUekIqlv94eJ5ZaRIgfvkxhQ==
X-Forward-Email-ID: 67e97d728935e384c2919341
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] board: rockchip: Add minimal generic RK3328 board
Date: Sun, 30 Mar 2025 17:20:34 +0000
Message-ID: <20250330172040.3370919-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330172040.3370919-1-jonas@kwiboo.se>
References: <20250330172040.3370919-1-jonas@kwiboo.se>
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

Add a minimal generic RK3328 board that only have eMMC, SDMMC, SPI flash
and USB OTG enabled. This defconfig can be used to boot from eMMC,
SD-card or SPI flash on most RK3328 boards that follow reference board
design.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Rebase on next after TPL_HAVE_INIT_STACK change
---
 arch/arm/dts/rk3328-generic-u-boot.dtsi | 39 +++++++++++
 arch/arm/dts/rk3328-generic.dts         | 76 +++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          |  2 +-
 board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
 configs/generic-rk3328_defconfig        | 90 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 6 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3328-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-generic.dts
 create mode 100644 configs/generic-rk3328_defconfig

diff --git a/arch/arm/dts/rk3328-generic-u-boot.dtsi b/arch/arm/dts/rk3328-generic-u-boot.dtsi
new file mode 100644
index 000000000000..af890e912dda
--- /dev/null
+++ b/arch/arm/dts/rk3328-generic-u-boot.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3328-u-boot.dtsi"
+
+&gpio0 {
+	/delete-property/ bootph-pre-ram;
+};
+
+&pcfg_pull_down_4ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi0 {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
+
+&spi0m2_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi0m2_cs0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi0m2_rx {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi0m2_tx {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/arch/arm/dts/rk3328-generic.dts b/arch/arm/dts/rk3328-generic.dts
new file mode 100644
index 000000000000..af0da8457167
--- /dev/null
+++ b/arch/arm/dts/rk3328-generic.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3328 with eMMC, SD-card, SPI flash and USB OTG enabled
+ */
+
+/dts-v1/;
+#include "rk3328.dtsi"
+
+/ {
+	model = "Generic RK3328";
+	compatible = "rockchip,rk3328";
+
+	aliases {
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	status = "okay";
+};
+
+&sdmmc0m1_pin {
+	rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_down_4ma>;
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_dectn &sdmmc0_bus4 &sdmmc0m1_pin>;
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+	};
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b61d424ba638..33a9f7a4dd4b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -201,7 +201,6 @@ config ROCKCHIP_RK3328
 	select SUPPORT_SPL
 	select SPL
 	select SUPPORT_TPL
-	select TPL
 	select TPL_HAVE_INIT_STACK if TPL
 	imply ARMV8_CRYPTO
 	imply ARMV8_SET_SMPEN
@@ -218,6 +217,7 @@ config ROCKCHIP_RK3328
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
+	imply TPL if !ROCKCHIP_EXTERNAL_TPL
 	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_SERIAL
 	help
diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 5f81be55b8e0..8c9b42fe2bbf 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -7,6 +7,12 @@ F:      configs/evb-rk3328_defconfig
 F:      arch/arm/dts/rk3328-evb.dts
 F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
 
+GENERIC-RK3328
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/generic-rk3328_defconfig
+F:	arch/arm/dts/rk3328-generic*
+
 NANOPI-R2C-RK3328
 M:      Tianling Shen <cnsztl@gmail.com>
 S:      Maintained
diff --git a/configs/generic-rk3328_defconfig b/configs/generic-rk3328_defconfig
new file mode 100644
index 000000000000..8d34a293fd42
--- /dev/null
+++ b/configs/generic-rk3328_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DEFAULT_DEVICE_TREE="rk3328-generic"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3328=y
+CONFIG_ROCKCHIP_EXTERNAL_TPL=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART_BASE=0xFF130000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-generic.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NO_NET=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+# CONFIG_ADC is not set
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+# CONFIG_ROCKCHIP_IODOMAIN is not set
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_ZBIT=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1407080f1f4f..6b48187ba79d 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -66,6 +66,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R2C Plus (nanopi-r2c-plus-rk3328)
      - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
      - FriendlyElec NanoPi R2S Plus (nanopi-r2s-plus-rk3328)
+     - Generic RK3328 (generic-rk3328)
      - Pine64 Rock64 (rock64-rk3328)
      - Radxa ROCK Pi E (rock-pi-e-rk3328)
      - Xunlong Orange Pi R1 Plus (orangepi-r1-plus-rk3328)
-- 
2.49.0

