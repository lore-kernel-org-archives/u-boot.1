Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F73CA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 02:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347E786725;
	Fri,  1 Sep 2023 04:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6061886741; Fri,  1 Sep 2023 04:58:26 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD260866AA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 04:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 3812vtS2006383; Fri, 1 Sep 2023 11:58:09 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 2/2] arm: dts: rockchip: rock-5b: add support for PCIe3 and
 NVMe
Date: Fri,  1 Sep 2023 11:57:19 +0900
Message-Id: <20230901025719.34023-2-naoki@radxa.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230901025719.34023-1-naoki@radxa.com>
References: <20230901025719.34023-1-naoki@radxa.com>
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

this patch adds support for PCIe3 (M.2 M key) and enables NVMe.

=> pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1d87     0x3588     Bridge device           0x04
01.00.00   0x10ec     0x8125     Network controller      0x00
02.00.00   0x1d87     0x3588     Bridge device           0x04
03.00.00   0x1179     0x011a     Mass storage controller 0x08
=> nvme scan
=> nvme info
Device 0: Vendor: 0x1179 Rev: AGHA4101 Prod: 79CA20WPKRYN
            Type: Hard Disk
            Capacity: 488386.3 MB = 476.9 GB (1000215216 x 512)

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>

this patch depends:
- "rockchip: rk3568: Fix use of PCIe bifurcation" [1]
[1] https://patchwork.ozlabs.org/project/uboot/list/?series=366997
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 33 +++++++++++++++++++++++++
 configs/rock5b-rk3588_defconfig         |  1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 1b2fcbb0bb..c790894170 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -27,6 +27,19 @@
 		regulator-max-microvolt = <12000000>;
 	};
 
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie3_vcc3v3_en>;
+	};
+
 	vcc5v0_usbdcin: vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usbdcin";
@@ -87,6 +100,18 @@
 	status = "okay";
 };
 
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_rst>;
+	status = "okay";
+};
+
 &pinctrl {
 	pcie {
 		pcie_reset_h: pcie-reset-h {
@@ -97,6 +122,14 @@
 			rockchip,pins = <3 RK_PC7 4 &pcfg_pull_none>,
 					<3 RK_PD0 4 &pcfg_pull_none>;
 		};
+
+		pcie3_rst: pcie3-rst {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb {
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 3fa65cbf9b..50551c70f2 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -81,6 +81,7 @@ CONFIG_SPI_FLASH_XTX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_RTL8169=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
-- 
2.39.2

