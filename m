Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C621EC54E49
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 18:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D7B87EA3;
	Sun, 10 Mar 2024 19:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qA8L5s8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5E387D1A; Sun, 10 Mar 2024 19:52:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B28876F3
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 19:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=14bd=KR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710096697; bh=+9DSBC0cmWUjNVofRvpexKQfFo6k1TlGrjecXszSYa8=;
 b=qA8L5s8b1vpQgxRiAtErfvBipqVwueXOVO+3eprj597uFk4K0mMb7J/36GeU+keZ+M5MlaTOe
 UEqB8wi3E0foto+ByJ/FefRuPRLko9kWc8ZZ4YY03jQbajPa1kJ+H4ks1Ceh/eR6cJ/8N1gngws
 XZ5pCP4QU7Pz/hQlPCYkxuvekvVpnrHdBP8N93xByp0+28BzrRNVo4FMqS5D4X6sWRp3FgoEkEu
 GvPazzW8izl5O1Eq38sBPe8JaeB8IHvE49HStawGB+CWbOitMe59Cjq1TmEYns1+Jlffp6aPdwE
 LZrlxcHRp8oazJfsbp6FIEiKDXOnt6hjJ8gLrsCc3Wtg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/4] rockchip: Migrate to use DM_USB_GADGET on RK3328
Date: Sun, 10 Mar 2024 18:51:00 +0000
Message-ID: <20240310185106.665553-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310185106.665553-1-jonas@kwiboo.se>
References: <20240310185106.665553-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65ee01315e98868d918e8f08
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

USB gadget is not working fully as expected on RK3328, it uses a
board_usb_init() function to initialize the DWC2 OTG port.

The board_usb_init() function does not intgrate with the generic phy
framework and as a result the USB phy is not properly configured before
or after USB gadget use.

Having both USB_DWC2 and DWC2_OTG enabled for the same board is also
causing some issues.

Trying to use rockusb or ums command after usb stop result in a freeze
due to usb stop is putting the phy in a suspended state.

  => usb start
  => usb stop
  => ums 0 mmc 0
  --> freeze due to usb phy is suspended <--

Fix this by only using one of USB_DWC2 (host) or DWC2_OTG (peripheral)
depending on the most likely usage of the otg port and by migrating to
use DM_USB_GADGET instead of a board_usb_init() function.

The nanopi-r2 and orangepi-r1-plus variants share OTG and power using a
Type-C connector, mark these boards dr_mode as peripheral, the most
likely usage is for recovery and image download.

The rock64 and roc-cc currently use dr_mode as host, remove the DWC2_OTG
driver from these boards to ensure that the USB_DWC2 driver is used.

The rock-pi-e board does not enable the usb20_otg node so both USB_DWC2
and DWC2_OTG is removed from this board.

Enable RockUSB and UMS on all boards with a otg port in peripheral mode.

Also with the migration to DM_USB_GADGET completed the U-Boot specific
change to reorder usb nodes in the soc device tree can be reverted.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Drop use of DWC3_GENERIC and revert to use XHCI_DWC3 for USB 3.0 host
  for devices using another port with otg/peripheral dr_mode to work
  around build errors when mixing DWC3_GENERIC and DWC2_OTG.
- Collect r-b tag
---
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  4 ++
 .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  4 ++
 .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  4 ++
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     |  9 ++++
 arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3328-u-boot.dtsi               |  4 --
 arch/arm/dts/rk3328.dtsi                      | 41 ++++++++-----------
 configs/evb-rk3328_defconfig                  |  7 +++-
 configs/nanopi-r2c-plus-rk3328_defconfig      |  7 +++-
 configs/nanopi-r2c-rk3328_defconfig           |  7 +++-
 configs/nanopi-r2s-rk3328_defconfig           |  7 +++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  7 +++-
 configs/orangepi-r1-plus-rk3328_defconfig     |  7 +++-
 configs/roc-cc-rk3328_defconfig               |  7 ----
 configs/rock-pi-e-rk3328_defconfig            |  7 ----
 configs/rock64-rk3328_defconfig               |  6 ---
 17 files changed, 75 insertions(+), 61 deletions(-)

diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
index cca4f06145cf..4fa170eeaf8d 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
@@ -15,6 +15,10 @@
 	bootph-all;
 };
 
+&usb20_otg {
+	dr_mode = "peripheral";
+};
+
 &vcc_io_sdio {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index 0dbe5a01f986..0a9423cd9c7e 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -33,6 +33,10 @@
 	bootph-pre-ram;
 };
 
+&usb20_otg {
+	dr_mode = "peripheral";
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 1af75ada1a62..1096821fc5d3 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -33,6 +33,10 @@
 	bootph-pre-ram;
 };
 
+&usb20_otg {
+	dr_mode = "peripheral";
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
index 47d74964fd0c..582d6ba49b4e 100644
--- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
@@ -29,6 +29,10 @@
 	};
 };
 
+&usb20_otg {
+	hnp-srp-disable;
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
index 9ed0aef1ecc9..d314bfad6fc0 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
@@ -29,6 +29,15 @@
 	};
 };
 
+&u2phy_host {
+	phy-supply = <&vcc_host_5v>;
+};
+
+&vcc_host_5v {
+	/delete-property/ regulator-always-on;
+	/delete-property/ regulator-boot-on;
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
index 85426495c3d8..551cff6f24f6 100644
--- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
@@ -55,6 +55,10 @@
 	bootph-pre-ram;
 };
 
+&usb20_otg {
+	hnp-srp-disable;
+};
+
 &vcc_sd {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index 4d43fe2fb51a..e0c6aee58aba 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -130,10 +130,6 @@
 	bootph-all;
 };
 
-&usb20_otg {
-	hnp-srp-disable;
-};
-
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 &binman {
 	simple-bin-spi {
diff --git a/arch/arm/dts/rk3328.dtsi b/arch/arm/dts/rk3328.dtsi
index fe81b97bbe78..fb5dcf6e9327 100644
--- a/arch/arm/dts/rk3328.dtsi
+++ b/arch/arm/dts/rk3328.dtsi
@@ -965,6 +965,22 @@
 		};
 	};
 
+	usb20_otg: usb@ff580000 {
+		compatible = "rockchip,rk3328-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x0 0xff580000 0x0 0x40000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff5c0000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff5c0000 0x0 0x10000>;
@@ -1004,31 +1020,6 @@
 		status = "disabled";
 	};
 
-	/*
-	 * U-Boot Specific Change
-	 *
-	 * The OTG controller must come after the USB host pair for it
-	 * to work. This is likely due to lack of support for the USB
-	 * PHYs. This must be manually changed after each device tree
-	 * sync. There is no clean way to handle this in -u-boot.dtsi
-	 * files.
-	 */
-	usb20_otg: usb@ff580000 {
-		compatible = "rockchip,rk3328-usb", "rockchip,rk3066-usb",
-			     "snps,dwc2";
-		reg = <0x0 0xff580000 0x0 0x40000>;
-		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru HCLK_OTG>;
-		clock-names = "otg";
-		dr_mode = "otg";
-		g-np-tx-fifo-size = <16>;
-		g-rx-fifo-size = <280>;
-		g-tx-fifo-size = <256 128 128 64 32 16>;
-		phys = <&u2phy_otg>;
-		phy-names = "usb2-phy";
-		status = "disabled";
-	};
-
 	gic: interrupt-controller@ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index 4fa8a7d365a4..75a0e0f286bd 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -31,6 +31,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -83,17 +85,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index 5302fd91a0f5..beef682a582e 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -33,6 +33,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -90,17 +92,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 5a722c182631..8960c1afaba5 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -33,6 +33,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -90,17 +92,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 985d02475ece..96e67e248d32 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -33,6 +33,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -90,17 +92,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index e9f7a1306923..5fbbd5fc6558 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -38,6 +38,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -100,17 +102,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 6019f33ae3f5..c5afe5ea6e5c 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -38,6 +38,8 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -100,17 +102,18 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 191dbff928bb..6526d2606e72 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -13,7 +13,6 @@ CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
@@ -34,7 +33,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
@@ -55,8 +53,6 @@ CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
-CONFIG_FASTBOOT_BUF_ADDR=0x800800
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
@@ -97,10 +93,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index e4f2123e0b17..23029255bca2 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -13,7 +13,6 @@ CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
@@ -52,8 +51,6 @@ CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
-CONFIG_FASTBOOT_BUF_ADDR=0x800800
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
@@ -92,12 +89,8 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index f38431891bf8..b0be1d1d7633 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
@@ -59,8 +58,6 @@ CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
-CONFIG_FASTBOOT_BUF_ADDR=0x800800
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_DW=y
@@ -106,10 +103,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

