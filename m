Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EC3C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C7888225;
	Sat, 13 Apr 2024 20:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ecAQ/5Co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A22B87CF1; Sat, 13 Apr 2024 20:15:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F9588225
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032122; bh=hxwq88x13k+0DdejzLGukmYAhBBzCiHT8yzHtCzDrR0=;
 b=ecAQ/5CoFcABzMz9vLrDoj2OAjdSdOEkLoc+oalbJbaJWDVithaREdvMVoa6SpZ4RjR81hu0y
 i9mAbW3Sy/8u5lORHOuehO201F9MtEktf2Qo4N8IPgC9fmBr9QhAfRc7E6/tMBlJw6ECyv8h6Z1
 pu9ujjUKNKprihQTOduJb4twqDtJidvy95/UkVkOza6ffyCP2r231Ru/VLzbsKhHnnH3ZU43xDS
 YirhOk1XJtVv4xBtjoHh/CvJ4dAgU2miTzeMgy52ugDLnXgWTKxFNloFKA8uWV8GiHmnM4zt0bE
 2qp/xBiBFvilGG34spjJMuI6N/NLsF5FyHoUgQZQcH6w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Andy Yan <andyshrk@163.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, John Clark
 <inindev@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>, Joshua
 Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 12/23] rockchip: rk3588: Update bootph props
Date: Sat, 13 Apr 2024 18:13:46 +0000
Message-ID: <20240413181425.1384357-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661acbb76fbb975d49a65499
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

After the commit aca95282c1b7 ("Makefile: Use the fdtgrep -u flag")
bootph props is propagating to parent nodes.

Update bootph props to ensure eMMC, SD-card and SPI flash is available
in SPL and U-Boot proper pre-reloc phase also remove unneeded bootph
props that automatically is propagated to parent nodes.

Also adjust pinctrl nodes to only be included in boot phases where they
are needed and add any missing pinctrl node needed in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Add bootph-some-ram props and follow kernel sort order

Following bootph props have been applied:

CRU, GRF and UART nodes:
- bootph-all - needed at all or most stages

SD-card regulator related nodes:
- bootph-pre-ram (SPL) - regulator pinctrl may be needed to read FIT
  from SD-card on some boards

eMMC/SD-card/SPI flash related nodes:
- bootph-pre-ram (SPL)
- bootph-some-ram (U-Boot proper pre-reloc)
---
 .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |  8 +--
 arch/arm/dts/rk3588-generic.dts               |  1 +
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     | 12 ++---
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  7 ++-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +--
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  6 ++-
 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |  8 +--
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  9 ++--
 arch/arm/dts/rk3588s-u-boot.dtsi              | 50 ++++++++++++++-----
 configs/evb-rk3588_defconfig                  |  4 +-
 10 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
index ed15b14ea0ee..f0ef0164664e 100644
--- a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,16 +13,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
 	status = "okay";
 
 	flash@0 {
-		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
 		spi-max-frequency = <24000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index e4721d97a87d..baafe7463f1b 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -40,5 +40,6 @@
 };
 
 &uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 60494bb8485f..968385622fa5 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -7,12 +7,11 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim1_pins {
-	bootph-all;
-};
-
-&sfc {
 	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
+	bootph-some-ram;
+};
+
+&sfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim1_pins>;
 	#address-cells = <1>;
@@ -20,9 +19,10 @@
 	status = "okay";
 
 	flash@0 {
-		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
 		spi-max-frequency = <24000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
index 5d5fa6ffb214..1ab31a4ec5ab 100644
--- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588-u-boot.dtsi"
 
 &fspim1_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,10 +13,8 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
-
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 9ee9dd051e32..d6020ca790f6 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -18,7 +18,8 @@
 };
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl {
@@ -35,16 +36,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
 	status = "okay";
 
 	flash@0 {
-		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
 		spi-max-frequency = <24000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index ca2a684f3541..a50bcc45f216 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -12,6 +12,10 @@
 };
 
 &uart9 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
+
+&uart9m0_xfer {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
index 6e4b97028d7c..f51d7f30d787 100644
--- a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk3588s-u-boot.dtsi"
 
 &fspim2_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -12,16 +13,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
 	status = "okay";
 
 	flash@0 {
-		bootph-pre-ram;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
 		spi-max-frequency = <24000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
index 888d1b9c12d7..12a92c0cba10 100644
--- a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
@@ -9,14 +9,13 @@
 };
 
 &fspim0_pins {
-	bootph-all;
-};
-
-&sfc {
 	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
+	bootph-some-ram;
+};
 
+&sfc {
 	flash@0 {
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 543327954b1a..f837239d2747 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -121,31 +121,40 @@
 };
 
 &cru {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &emmc_bus8 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_data_strobe {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_rstnout {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &ioc {
-	bootph-pre-ram;
+	bootph-all;
+};
+
+&pcfg_pull_down {
+	bootph-all;
 };
 
 &pcfg_pull_none {
@@ -157,6 +166,11 @@
 };
 
 &pcfg_pull_up_drv_level_2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&php_grf {
 	bootph-all;
 };
 
@@ -170,10 +184,12 @@
 
 &scmi {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &scmi_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -189,27 +205,35 @@
 };
 
 &sdmmc_bus4 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_det {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc {
+	u-boot,spl-sfc-no-dma;
 };
 
 &sys_grf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &uart2 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
 
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 68ecbc54b807..610a8d740fbb 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -33,7 +33,8 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -52,6 +53,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.43.2

