Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4149CCD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CC0882D8;
	Sun, 31 Mar 2024 22:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F+md9wRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2003387FC0; Sun, 31 Mar 2024 22:30:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B94882E1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917045; bh=DWYy2aG/eQZBAqo5JouWx9w8b9NicVWiPMOJnHefgmk=;
 b=F+md9wRjIs3ui6o4LAeTtl4q3nEYdea4hN/XtN9pPGah87KXwqKeiAOlQQ7LD0cblz71xKGBO
 5HJXPj+GoLXguDNI6ss9kPiiBs6FMGkq0T8KiA9wuk/pU0LSpkxO528MP8dblee2AqiCVpOBFhK
 xpeAC5mvUMy+t+WzB5/NtYp93q2POYNK9J7fqpb3U8cXIsFCdWxAIaRppZpIdmvNcsIe6xDRyjz
 LpUhd9wjTf8pwuvABCqlxHX1M4TRlSNrvtnkvGC4gmQgKwYTIxYVmUMEmJCaErXWEFXgrNhI9Ed
 ItDim0d7MjyC7BXV8vFiqc+R+khNUCJFz8aEeZvgCcaw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 16/31] rockchip: rk3399-gru: Sync device tree from linux v6.8
Date: Sun, 31 Mar 2024 20:28:22 +0000
Message-ID: <20240331202921.262323-17-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6609c7f38fc6b45ed44f7386
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

Sync rk3399-gru related device tree from linux v6.8.

The spi_flash symbol is no longer part of upstream DT, it is re-defined
to allow exising use in related u-boot.dtsi-files.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-gru-bob.dts         |   8 +-
 arch/arm/dts/rk3399-gru-chromebook.dtsi | 200 +++++++++++++++++++++++-
 arch/arm/dts/rk3399-gru-kevin.dts       |   3 +-
 arch/arm/dts/rk3399-gru-u-boot.dtsi     |  10 +-
 arch/arm/dts/rk3399-gru.dtsi            |  52 +++++-
 5 files changed, 254 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/rk3399-gru-bob.dts b/arch/arm/dts/rk3399-gru-bob.dts
index e6c1c94c8d69..1cba1d857c96 100644
--- a/arch/arm/dts/rk3399-gru-bob.dts
+++ b/arch/arm/dts/rk3399-gru-bob.dts
@@ -16,6 +16,7 @@
 		     "google,bob-rev7", "google,bob-rev6",
 		     "google,bob-rev5", "google,bob-rev4",
 		     "google,bob", "google,gru", "rockchip,rk3399";
+	chassis-type = "convertible";
 
 	edp_panel: edp-panel {
 		compatible = "boe,nv101wxmn51";
@@ -69,7 +70,7 @@
 &spi0 {
 	status = "okay";
 
-	cr50@0 {
+	tpm@0 {
 		compatible = "google,cr50";
 		reg = <0>;
 		interrupt-parent = <&gpio0>;
@@ -87,3 +88,8 @@
 		};
 	};
 };
+
+&wlan_host_wake_l {
+	/* Kevin has an external pull up, but Bob does not. */
+	rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
+};
diff --git a/arch/arm/dts/rk3399-gru-chromebook.dtsi b/arch/arm/dts/rk3399-gru-chromebook.dtsi
index 1384dabbdf40..cacbad35cfc8 100644
--- a/arch/arm/dts/rk3399-gru-chromebook.dtsi
+++ b/arch/arm/dts/rk3399-gru-chromebook.dtsi
@@ -198,7 +198,6 @@
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
-		pwm-delay-us = <10000>;
 	};
 
 	gpio_keys: gpio-keys {
@@ -206,7 +205,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_l>;
 
-		wake_on_bt: wake-on-bt {
+		wake_on_bt: key-wake-on-bt {
 			label = "Wake-on-Bluetooth";
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
@@ -234,9 +233,24 @@
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+	rockchip,pd-idle-dis-freq-hz = <800000000>;
+	rockchip,sr-idle-dis-freq-hz = <800000000>;
+	rockchip,sr-mc-gate-idle-dis-freq-hz = <800000000>;
+};
+
 &edp {
 	status = "okay";
 
+	/*
+	 * eDP PHY/clk don't sync reliably at anything other than 24 MHz. Only
+	 * set this here, because rk3399-gru.dtsi ensures we can generate this
+	 * off GPLL=600MHz, whereas some other RK3399 boards may not.
+	 */
+	assigned-clocks = <&cru PCLK_EDP>;
+	assigned-clock-rates = <24000000>;
+
 	ports {
 		edp_out: port@1 {
 			reg = <1>;
@@ -251,6 +265,182 @@
 	};
 };
 
+&gpio0 {
+	gpio-line-names = /* GPIO0 A 0-7 */
+			  "AP_RTC_CLK_IN",
+			  "EC_AP_INT_L",
+			  "PP1800_AUDIO_EN",
+			  "BT_HOST_WAKE_L",
+			  "WLAN_MODULE_PD_L",
+			  "H1_INT_OD_L",
+			  "CENTERLOGIC_DVS_PWM",
+			  "",
+
+			  /* GPIO0 B 0-4 */
+			  "WIFI_HOST_WAKE_L",
+			  "PMUIO2_33_18_L",
+			  "PP1500_EN",
+			  "AP_EC_WARM_RESET_REQ",
+			  "PP3000_EN";
+};
+
+&gpio1 {
+	gpio-line-names = /* GPIO1 A 0-7 */
+			  "",
+			  "",
+			  "SPK_PA_EN",
+			  "",
+			  "TRACKPAD_INT_L",
+			  "AP_EC_S3_S0_L",
+			  "AP_EC_OVERTEMP",
+			  "AP_SPI_FLASH_MISO",
+
+			  /* GPIO1 B 0-7 */
+			  "AP_SPI_FLASH_MOSI_R",
+			  "AP_SPI_FLASH_CLK_R",
+			  "AP_SPI_FLASH_CS_L_R",
+			  "WLAN_MODULE_RESET_L",
+			  "WIFI_DISABLE_L",
+			  "MIC_INT",
+			  "",
+			  "AP_I2C_DVS_SDA",
+
+			  /* GPIO1 C 0-7 */
+			  "AP_I2C_DVS_SCL",
+			  "AP_BL_EN",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics call it
+			   * AP_FW_WP or CPU1_FW_WP, depending on the variant.
+			   */
+			  "AP_FLASH_WP",
+			  "LITCPU_DVS_PWM",
+			  "AP_I2C_AUDIO_SDA",
+			  "AP_I2C_AUDIO_SCL",
+			  "",
+			  "HEADSET_INT_L";
+};
+
+&gpio2 {
+	gpio-line-names = /* GPIO2 A 0-7 */
+			  "",
+			  "",
+			  "SD_IO_PWR_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO2 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO2 C 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SPI_EC_MISO",
+			  "AP_SPI_EC_MOSI",
+			  "AP_SPI_EC_CLK",
+			  "AP_SPI_EC_CS_L",
+
+			  /* GPIO2 D 0-4 */
+			  "BT_DEV_WAKE_L",
+			  "",
+			  "WIFI_PCIE_CLKREQ_L",
+			  "WIFI_PERST_L",
+			  "SD_PWR_3000_1800_L";
+};
+
+&gpio3 {
+	gpio-line-names = /* GPIO3 A 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SPI_TPM_MISO",
+			  "AP_SPI_TPM_MOSI_R",
+			  "AP_SPI_TPM_CLK_R",
+			  "AP_SPI_TPM_CS_L_R",
+
+			  /* GPIO3 B 0-7 */
+			  "EC_IN_RW",
+			  "",
+			  "AP_I2C_TP_SDA",
+			  "AP_I2C_TP_SCL",
+			  "AP_I2C_TP_PU_EN",
+			  "TOUCH_INT_L",
+			  "",
+			  "",
+
+			  /* GPIO3 C 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO3 D 0-7 */
+			  "I2S0_SCLK",
+			  "I2S0_LRCK_RX",
+			  "I2S0_LRCK_TX",
+			  "I2S0_SDI_0",
+			  "I2S0_SDI_1",
+			  "",
+			  "I2S0_SDO_1",
+			  "I2S0_SDO_0";
+};
+
+&gpio4 {
+	gpio-line-names = /* GPIO4 A 0-7 */
+			  "I2S_MCLK",
+			  "AP_I2C_MIC_SDA",
+			  "AP_I2C_MIC_SCL",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 C 0-7 */
+			  "AP_I2C_TS_SDA",
+			  "AP_I2C_TS_SCL",
+			  "GPU_DVS_PWM",
+			  "UART_DBG_TX_AP_RX",
+			  "UART_AP_TX_DBG_RX",
+			  "",
+			  "BIGCPU_DVS_PWM",
+			  "EDP_HPD_3V0",
+
+			  /* GPIO4 D 0-5 */
+			  "SD_CARD_DET_L",
+			  "USB_DP_HPD",
+			  "TOUCH_RESET_L",
+			  "PP3300_DISP_EN",
+			  "",
+			  "SD_SLOT_PWR_EN";
+};
+
 ap_i2c_mic: &i2c1 {
 	status = "okay";
 
@@ -286,7 +476,7 @@ ap_i2c_tp: &i2c5 {
 };
 
 &cros_ec {
-	cros_ec_pwm: ec-pwm {
+	cros_ec_pwm: pwm {
 		compatible = "google,cros-ec-pwm";
 		#pwm-cells = <1>;
 	};
@@ -319,8 +509,7 @@ ap_i2c_tp: &i2c5 {
 &pci_rootport {
 	mvl_wifi: wifi@0,0 {
 		compatible = "pci1b4b,2b42";
-		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
-		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		reg = <0x0000 0x0 0x0 0x0 0x0>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
@@ -395,6 +584,7 @@ ap_i2c_tp: &i2c5 {
 	};
 
 	wlan_host_wake_l: wlan-host-wake-l {
+		/* Kevin has an external pull up, but Bob does not */
 		rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
diff --git a/arch/arm/dts/rk3399-gru-kevin.dts b/arch/arm/dts/rk3399-gru-kevin.dts
index 2bbef9fcbe27..2cc9b3386c16 100644
--- a/arch/arm/dts/rk3399-gru-kevin.dts
+++ b/arch/arm/dts/rk3399-gru-kevin.dts
@@ -24,6 +24,7 @@
 		     "google,kevin-rev9", "google,kevin-rev8",
 		     "google,kevin-rev7", "google,kevin-rev6",
 		     "google,kevin", "google,gru", "rockchip,rk3399";
+	chassis-type = "convertible";
 
 	/* Power tree */
 
@@ -91,7 +92,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&bt_host_wake_l>, <&cpu1_pen_eject>;
 
-	pen-insert {
+	switch-pen-insert {
 		label = "Pen Insert";
 		/* Insert = low, eject = high */
 		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 0cc40eb6d6f6..6bdc892bd913 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -78,12 +78,14 @@
 	/delete-property/ bootph-pre-ram;
 };
 
+&spi1 {
+	spi_flash: flash@0 {
+		bootph-all;
+	};
+};
+
 &spi5 {
 	spi-activate-delay = <100>;
 	spi-max-frequency = <3000000>;
 	spi-deactivate-delay = <200>;
 };
-
-&spi_flash {
-	bootph-all;
-};
diff --git a/arch/arm/dts/rk3399-gru.dtsi b/arch/arm/dts/rk3399-gru.dtsi
index b80f19066b57..d90fe4d40d48 100644
--- a/arch/arm/dts/rk3399-gru.dtsi
+++ b/arch/arm/dts/rk3399-gru.dtsi
@@ -250,7 +250,7 @@
 		pinctrl-0 = <&sd_io_pwr_en &sd_pwr_1800_sel>;
 
 		enable-active-high;
-		enable-gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x1>,
 			 <3000000 0x0>;
@@ -286,7 +286,7 @@
 
 	sound: sound {
 		compatible = "rockchip,rk3399-gru-sound";
-		rockchip,cpu = <&i2s0 &i2s2>;
+		rockchip,cpu = <&i2s0 &spdif>;
 	};
 };
 
@@ -373,6 +373,34 @@
 		<200000000>;
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+
+	rockchip,pd-idle-ns = <160>;
+	rockchip,sr-idle-ns = <10240>;
+	rockchip,sr-mc-gate-idle-ns = <40960>;
+	rockchip,srpd-lite-idle-ns = <61440>;
+	rockchip,standby-idle-ns = <81920>;
+
+	rockchip,ddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr3_odt_dis_freq = <666000000>;
+	rockchip,lpddr4_odt_dis_freq = <666000000>;
+
+	rockchip,sr-mc-gate-idle-dis-freq-hz = <1000000000>;
+	rockchip,srpd-lite-idle-dis-freq-hz = <0>;
+	rockchip,standby-idle-dis-freq-hz = <928000000>;
+};
+
+&dmc_opp_table {
+	opp03 {
+		opp-suspend;
+	};
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -437,10 +465,6 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
-&i2s2 {
-	status = "okay";
-};
-
 &io_domains {
 	status = "okay";
 
@@ -461,10 +485,11 @@ ap_i2c_audio: &i2c8 {
 	vpcie0v9-supply = <&pp900_pcie>;
 
 	pci_rootport: pcie@0,0 {
-		reg = <0x83000000 0x0 0x00000000 0x0 0x00000000>;
+		reg = <0x0000 0 0 0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
+		device_type = "pci";
 	};
 };
 
@@ -537,13 +562,24 @@ ap_i2c_audio: &i2c8 {
 	vqmmc-supply = <&ppvar_sd_card_io>;
 };
 
+&spdif {
+	status = "okay";
+
+	/*
+	 * SPDIF is routed internally to DP; we either don't use these pins, or
+	 * mux them to something else.
+	 */
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+};
+
 &spi1 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
 	pinctrl-1 = <&spi1_sleep>;
 
-	spi_flash: spiflash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 
-- 
2.43.2

