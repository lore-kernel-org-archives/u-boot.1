Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A02CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED278830C;
	Sun, 31 Mar 2024 22:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iOJQB9lI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EC788316; Sun, 31 Mar 2024 22:31:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0CB8830E
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917095; bh=ONYLzkB3GF9AuosgfLaKKlCtrskYDIwofrQlIm0YUM0=;
 b=iOJQB9lIN3WNrIAbFkRMgHPeBCTs418v3OYc9/CcoadgSL2eDMPi11JmfZQyuaDLHQyLdYrDj
 5nic311No6TFxYudKgTL8FVfZuHHQmjZ6ptOKtUduEXucfZtPEYpkD+38idQ+x81g/OQp6w4vjT
 1Wdq6A/J30OmwA8WlyZ8VXLFkm2IorBsGkUZJ/SNweYI2bTghBt0ZjTNNNapMbDHGfu9IQjljDx
 pniN7QPQmJpCMIrjanO419uikQexl8PURPRdUUyyLpB2BkrFHApAjwsGPBTHxOXZ2B5TuCOm4z0
 p1l9399rWB4sZv9/TGIYs8Nxqi82wN5876y5AYi9CARA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nick Xie <nick@khadas.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 27/31] rockchip: rk3399-khadas: Sync device tree from linux
 v6.8
Date: Sun, 31 Mar 2024 20:28:33 +0000
Message-ID: <20240331202921.262323-28-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c8268fc6b45ed44f7462
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

Sync rk3399-khadas related device tree from linux v6.8.

Add SPI flash related options to support booting from SPI flash.

Add DM_RESET=y to support reset signals.

Add PCI=y, CMD_PCI=y and NVME_PCI=y to support PCIe and NVMe boot.

Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA boot.

Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.

Add CMD_ROCKUSB=y, CMD_USB_MASS_STORAGE=y and USB_GADGET=y to support
RockUSB and UMS gadget.

Remove CONFIG_NET_RANDOM_ETHADDR=y, ethaddr and eth1addr is set based on
cpuid read from eFUSE.

Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.

Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.

Add DM_ETH_PHY=y to support ethernet PHY.

Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.

Remove SPL_TINY_MEMSET=y to use full memset in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-khadas-edge-captain.dts  |  4 +++
 arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi  |  5 +++
 arch/arm/dts/rk3399-khadas-edge-v.dts        |  4 +++
 arch/arm/dts/rk3399-khadas-edge.dtsi         | 10 +++---
 configs/khadas-edge-captain-rk3399_defconfig | 33 ++++++++++++++++++--
 configs/khadas-edge-rk3399_defconfig         | 27 +++++++++++++---
 configs/khadas-edge-v-rk3399_defconfig       | 33 ++++++++++++++++++--
 7 files changed, 100 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/rk3399-khadas-edge-captain.dts b/arch/arm/dts/rk3399-khadas-edge-captain.dts
index 8302e51def52..99ac4ed0f13f 100644
--- a/arch/arm/dts/rk3399-khadas-edge-captain.dts
+++ b/arch/arm/dts/rk3399-khadas-edge-captain.dts
@@ -10,6 +10,10 @@
 / {
 	model = "Khadas Edge-Captain";
 	compatible = "khadas,edge-captain", "rockchip,rk3399";
+
+	aliases {
+		ethernet0 = &gmac;
+	};
 };
 
 &gmac {
diff --git a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
index 4a3b23e48313..dd7a84d2b4a8 100644
--- a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
@@ -6,6 +6,11 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
+&spiflash {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
diff --git a/arch/arm/dts/rk3399-khadas-edge-v.dts b/arch/arm/dts/rk3399-khadas-edge-v.dts
index f5dcb99dc349..e12e7b4d64ca 100644
--- a/arch/arm/dts/rk3399-khadas-edge-v.dts
+++ b/arch/arm/dts/rk3399-khadas-edge-v.dts
@@ -10,6 +10,10 @@
 / {
 	model = "Khadas Edge-V";
 	compatible = "khadas,edge-v", "rockchip,rk3399";
+
+	aliases {
+		ethernet0 = &gmac;
+	};
 };
 
 &gmac {
diff --git a/arch/arm/dts/rk3399-khadas-edge.dtsi b/arch/arm/dts/rk3399-khadas-edge.dtsi
index d5c7648c841d..9d9297bc5f04 100644
--- a/arch/arm/dts/rk3399-khadas-edge.dtsi
+++ b/arch/arm/dts/rk3399-khadas-edge.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
@@ -80,12 +81,12 @@
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
+		pwm-supply = <&vsys_3v3>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
-		vin-supply = <&vsys_3v3>;
 	};
 
 	vsys: vsys {
@@ -122,7 +123,7 @@
 		keyup-threshold-microvolt = <1800000>;
 		poll-interval = <100>;
 
-		recovery {
+		button-recovery {
 			label = "Recovery";
 			linux,code = <KEY_VENDOR>;
 			press-threshold-microvolt = <18000>;
@@ -135,7 +136,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
@@ -682,7 +683,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		brcm,drive-strength = <5>;
 		pinctrl-names = "default";
@@ -705,7 +706,6 @@
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
 	non-removable;
 	status = "okay";
 };
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 230b9d796442..cf6516656e9a 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -3,51 +3,76 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-captain"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge-captain.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_SYS_PROMPT="kedge# "
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -63,5 +88,7 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_SPL_TINY_MEMSET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 9f13cbf58398..f752731dec01 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -3,20 +3,27 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_SYS_PROMPT="kedge# "
@@ -24,21 +31,28 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
@@ -47,6 +61,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -62,5 +77,7 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_SPL_TINY_MEMSET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index abc4f2054cfd..f321d10a7694 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -3,51 +3,76 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-khadas-edge-v"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge-v.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_SYS_PROMPT="kedge# "
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
@@ -63,5 +88,7 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_SPL_TINY_MEMSET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

