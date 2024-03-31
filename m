Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F2ECD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014A7882D3;
	Sun, 31 Mar 2024 22:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uvqqUyT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6B1882EE; Sun, 31 Mar 2024 22:31:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4956882E1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917053; bh=wyO9IyQIz+U8ddjTD8qR+lHkOwqIVujoQ9yXXZGMPhI=;
 b=uvqqUyT3EaHWvlG54ySIxe+SZ0D73leWD+bNeKt7Dqxgvu27QCRfwKiSv8ifHpGWr5lxXib42
 b2fRQCo1FJLdmAtMxwDidRJ+INwC1f4u9MKNdmK+Kkbai6sRS9KQiQDrOfQ/uhaaEWp8LXMnC5e
 4Vj4x4Ztf9m6A9JtQFRRooOXBK3L4Bl2JDyrg3cwUiQ9dHOX1iPzOEMQaiJi58LnH5AF4hUseZZ
 MhwRLB5xdGDxw3couQx/g11vqY3vdZOlQDcrNzpcoQaiWmgNnr2Hh8ZYDHcCksTbV00B6f4iPwN
 2t3vKlwBwROQuu3u0C+0gXMlUrahawvI3fO09Z/+/g4Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 18/31] rockchip: rk3399-rock-pi-n10: Sync device tree from
 linux v6.8
Date: Sun, 31 Mar 2024 20:28:24 +0000
Message-ID: <20240331202921.262323-19-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6609c7fc8fc6b45ed44f73aa
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

Sync rk3399-rock-pi-n10 related device tree from linux v6.8.

Remove SPL_GPIO=y, board does not use gpio in SPL.

Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.

Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.

Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.

Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.

Remove REGULATOR_PWM=y, board does not use pwm-regulator compatible.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-vmarc-som.dtsi            | 48 +++++++++++++++++++
 arch/arm/dts/rk3399pro-vmarc-som.dtsi         | 20 ++++++--
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 21 ++++++++
 configs/rock-pi-n10-rk3399pro_defconfig       |  8 ++--
 4 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/rk3288-vmarc-som.dtsi b/arch/arm/dts/rk3288-vmarc-som.dtsi
index 717cb3dc816e..793951655b73 100644
--- a/arch/arm/dts/rk3288-vmarc-som.dtsi
+++ b/arch/arm/dts/rk3288-vmarc-som.dtsi
@@ -231,11 +231,43 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+	};
+};
+
 &i2c5 {
 	status = "okay";
 };
 
+&io_domains {
+	bb-supply = <&vcc_io>;
+	flash0-supply = <&vccio_flash>;
+	gpio1830-supply = <&vcc_18>;
+	gpio30-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_wl>;
+	status = "okay";
+};
+
 &pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <5 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
 		drive-strength = <8>;
 	};
@@ -251,6 +283,12 @@
 		};
 	};
 
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_bus4: sdmmc-bus4 {
 			rockchip,pins =
@@ -282,6 +320,16 @@
 	};
 };
 
+&sdio_pwrseq {
+	/*
+	 * On the module itself this is one of these (depending
+	 * on the actual card populated):
+	 * - SDIO_RESET_L_WL_REG_ON
+	 * - PDN (power down when low)
+	 */
+	reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;	/* WIFI_REG_ON */
+};
+
 &usbphy {
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3399pro-vmarc-som.dtsi b/arch/arm/dts/rk3399pro-vmarc-som.dtsi
index e1cb426f2aa5..8823c924dc1d 100644
--- a/arch/arm/dts/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm/dts/rk3399pro-vmarc-som.dtsi
@@ -13,8 +13,9 @@
 	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
 
 	aliases {
-		mmc0 = &sdmmc;
-		mmc1 = &sdhci;
+		ethernet0 = &gmac;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
 	};
 
 	vcc3v3_pcie: vcc-pcie-regulator {
@@ -297,11 +298,10 @@
 	clock-frequency = <400000>;
 	status = "okay";
 
-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "hym8563";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
@@ -347,7 +347,7 @@
 
 	pcie {
 		pcie_pwr: pcie-pwr {
-			rockchip,pins =	<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
@@ -381,6 +381,16 @@
 	pmu1830-supply = <&vcc_1v8>;
 };
 
+&sdio_pwrseq {
+	/*
+	 * On the module itself this is one of these (depending
+	 * on the actual card populated):
+	 * - SDIO_RESET_L_WL_REG_ON
+	 * - PDN (power down when low)
+	 */
+	reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+};
+
 &sdhci {
 	bus-width = <8>;
 	mmc-hs400-1_8v;
diff --git a/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
index 26b53eac4706..da1d548b7330 100644
--- a/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
+++ b/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
@@ -15,6 +15,14 @@
 		#clock-cells = <0>;
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -78,6 +86,19 @@
 	status = "okay";
 };
 
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 234d0c9ab0f5..6d93b9e58003 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399pro-rock-pi-n10"
@@ -18,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399pro-rock-pi-n10.dtb"
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -36,17 +35,20 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
-- 
2.43.2

