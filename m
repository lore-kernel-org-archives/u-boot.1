Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8DFC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 22:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E1988B49;
	Fri,  9 Aug 2024 00:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE8F88B89; Fri,  9 Aug 2024 00:23:52 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50648871E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 00:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 478MNWsU000374; Fri, 9 Aug 2024 07:23:33 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: banglang.huang@foxmail.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, gajjar04akash@gmail.com,
 chris.obbard@collabora.com, dsimic@manjaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH v2 2/2] arm: dts: rockchip: turn LEDs on at boot for Radxa
 boards
Date: Fri,  9 Aug 2024 07:23:25 +0900
Message-ID: <20240808222325.2082-2-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808222325.2082-1-naoki@radxa.com>
References: <20240808222325.2082-1-naoki@radxa.com>
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

Basically, Radxa's boards are intended to turn LEDs on at U-Boot.
add `default-state = "on"` to u-boot.dtsi.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
Changes in v2:
- remove irrelevant contents from rk3399-rock-4c-plus-u-boot.dtsi
- depend https://patchwork.ozlabs.org/project/uboot/patch/20240808221902.2006-1-naoki@radxa.com/
---
 .../arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  6 +++++
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  | 12 ++++++++++
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi     |  8 +++++++
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi  |  8 +++++++
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 23 +++++++++++++++++++
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |  8 +++++++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +++++++
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi      |  8 +++++++
 8 files changed, 81 insertions(+)

diff --git a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
index 39bb66c4fcb..a30adb0be98 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
@@ -6,6 +6,12 @@
 #include "rk3328-u-boot.dtsi"
 
 / {
+	leds {
+		led-0 {
+			default-state = "on";
+		};
+	};
+
 	smbios {
 		compatible = "u-boot,sysinfo-smbios";
 
diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
index 50dae5cb5ef..7a6af430a6f 100644
--- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
@@ -6,6 +6,18 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
+/ {
+	leds {
+		led-0 {
+			default-state = "on";
+		};
+
+		led-1 {
+			default-state = "on";
+		};
+	};
+};
+
 &pcfg_pull_none_18ma {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
index b3bfc77f756..4861574636e 100644
--- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
@@ -6,6 +6,14 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
+/ {
+	leds {
+		led-0 {
+			default-state = "on";
+		};
+	};
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
index e0e501deccf..412f9e06aff 100644
--- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
@@ -5,6 +5,14 @@
 
 #include "rk356x-u-boot.dtsi"
 
+/ {
+	leds {
+		led-1 {
+			default-state = "on";
+		};
+	};
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 };
diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
index 74755a44eae..efeab626d8a 100644
--- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
@@ -2,6 +2,29 @@
 
 #include "rk356x-u-boot.dtsi"
 
+/ {
+	gpio-leds {
+		led-0 {
+			default-state = "on";
+		};
+
+		led-red {
+			default-state = "on";
+			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-green {
+			default-state = "on";
+			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-blue {
+			default-state = "on";
+			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
 &pcie3x1 {
 	pinctrl-0 = <&pcie30x1_reset_h>;
 };
diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 9d18f5d0b36..c493352abc1 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -6,6 +6,14 @@
 
 #include "rk356x-u-boot.dtsi"
 
+/ {
+	leds {
+		led-0 {
+			default-state = "on";
+		};
+	};
+};
+
 &pcie3x2 {
 	pinctrl-0 = <&pcie3x2_reset_h>;
 };
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 8e318e624a8..8ebba36f90a 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -5,6 +5,14 @@
 
 #include "rk3588-u-boot.dtsi"
 
+/ {
+	leds {
+		led_rgb_b {
+			default-state = "on";
+		};
+	};
+};
+
 &fspim2_pins {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
index efba0c359ba..a75ae296386 100644
--- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
@@ -5,6 +5,14 @@
 
 #include "rk3588s-u-boot.dtsi"
 
+/ {
+	leds {
+		io-led {
+			default-state = "on";
+		};
+	};
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.43.0

