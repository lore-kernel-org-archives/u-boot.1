Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1864AC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BEB987F95;
	Sat, 13 Apr 2024 20:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EIZlYD9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652DA88204; Sat, 13 Apr 2024 20:15:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68388800C
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032116; bh=FgKoGIE0WG4ADMj9HCwMW3G6A3jmYPE4KjaLskFkFGY=;
 b=EIZlYD9W/S//bSXGju/j2c0/WxmaZMgOWLxCc01ic+TrC1Sx0DleqOC1YjGdj299EAXmVl5Tt
 sqwZBPVWcudrYssVLyB75GAjzwqanE89PDaxcOFQ0zBwGonnw65/lY+S4atz8+k/xtuJKzBc8zp
 4mQ/0OGeEOW/W81Hb9qDUvvmK+wlVlPqQwnWm3vBUSz8NHv8OMZMwOT/C6lCNAsGzWULYVHK+Um
 a6Zdf4tkpCWSHe/eEkHf1m7clwNH3znEQHkfunmslXxA3o1OtS1Y2DDnp74uV9qQhQcrmqF603G
 XsqERKIUJSno4LXSWnk32Jklb1HteJSrTnvwew/NDUXA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 11/23] rockchip: rk356x: Update bootph props
Date: Sat, 13 Apr 2024 18:13:45 +0000
Message-ID: <20240413181425.1384357-12-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 661acbb36fbb975d49a65480
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
 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi   | 25 +++++++----
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi |  8 ++--
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi |  4 +-
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi  |  7 ++-
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi    |  5 +--
 arch/arm/dts/rk356x-u-boot.dtsi            | 51 ++++++++++++++--------
 configs/evb-rk3568_defconfig               |  3 +-
 7 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
index 4aa6ab1c848c..eb18008f2fe3 100644
--- a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
@@ -3,20 +3,31 @@
 #include "rk356x-u-boot.dtsi"
 
 &fspi_dual_io_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio0 {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &i2c0 {
 	bootph-pre-ram;
 };
 
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&i2s1m0_mclk {
+	bootph-pre-ram;
+};
+
+&pmic_int_l {
+	bootph-pre-ram;
+};
+
 &rk817 {
-	bootph-pre-ram;
-
 	regulators {
 		bootph-pre-ram;
 	};
@@ -27,15 +38,13 @@
 };
 
 &sdmmc_pwren_l {
-	bootph-all;
+	bootph-pre-ram;
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
 
diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
index 930d660868bb..0e25b7e108fc 100644
--- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
@@ -3,7 +3,7 @@
 #include "rk356x-u-boot.dtsi"
 
 &gpio0 {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &sdhci {
@@ -13,11 +13,9 @@
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
 
@@ -34,5 +32,5 @@
 };
 
 &vcc_sd_h {
-	bootph-all;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
index c235b4357f7d..f2c9d8e167d5 100644
--- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
@@ -9,11 +9,9 @@
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
 
diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
index 1fc71faa9e07..d8a6dd87510f 100644
--- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
@@ -3,7 +3,8 @@
 #include "rk356x-u-boot.dtsi"
 
 &fspi_dual_io_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdhci {
@@ -15,10 +16,8 @@
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
diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 5b823fcca5fb..9d18f5d0b364 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -26,16 +26,15 @@
 };
 
 &sfc {
-	bootph-pre-ram;
-	u-boot,spl-sfc-no-dma;
 	#address-cells = <1>;
 	#size-cells = <0>;
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
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 1ecf719202e9..ffac4a9def51 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -43,43 +43,46 @@
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
 
 &emmc_datastrobe {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_rstnout {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &fspi_pins {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &grf {
 	bootph-all;
 };
 
-&i2c0_xfer {
-	bootph-all;
-};
-
 &pcfg_pull_none {
 	bootph-all;
 };
 
 &pcfg_pull_none_smt {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up {
@@ -87,7 +90,8 @@
 };
 
 &pcfg_pull_up_drv_level_2 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl {
@@ -104,35 +108,46 @@
 
 &sdhci {
 	bootph-pre-ram;
+	bootph-some-ram;
 	max-frequency = <200000000>;
 };
 
 &sdmmc0 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_bus4 {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_clk {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_det {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_pwren {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sfc {
+	u-boot,spl-sfc-no-dma;
 };
 
 &uart2 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <24000000>;
 };
 
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index 6e8061f5f487..37b4c5955994 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
@@ -49,6 +49,7 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
-- 
2.43.2

