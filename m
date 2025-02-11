Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B9BC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24A980821;
	Tue, 11 Feb 2025 07:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E837800CF; Tue, 11 Feb 2025 07:14:03 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4CD80BA8
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B6DR7c024871; Tue, 11 Feb 2025 15:13:30 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 banglang.huang@foxmail.com, jonas@kwiboo.se, trini@konsulko.com,
 gajjar04akash@gmail.com, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org,
 christopher.obbard@linaro.org, wens@csie.org,
 sebastian.reichel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 5/6] rockchip: Add DFU to boot from USB for Radxa ROCK Pi E
 v1/v3
Date: Tue, 11 Feb 2025 06:13:21 +0000
Message-ID: <20250211061322.94186-6-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211061322.94186-1-naoki@radxa.com>
References: <20250211061322.94186-1-naoki@radxa.com>
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

Boot the Radxa ROCK Pi E v1/v3 from the USB OTG port using
rkflashtool[1] or rkusbboot[2] and dfu-util.

1a. Download the TPL and SPL using rkflashtool

$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-u-boot-tpl | rkflashtool l
$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L

1b. Download the TPL and SPL using rkusbboot

$ rkusbboot \
	mkimage-in-simple-bin.mkimage-u-boot-tpl \
	mkimage-in-simple-bin.mkimage-u-boot-spl

2. Download the U-Boot

$ dfu-util -a 0 -D u-boot.itb

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  8 ++++++++
 configs/rock-pi-e-rk3328_defconfig             | 12 ++++++++++++
 configs/rock-pi-e-v3-rk3328_defconfig          | 12 ++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
index a30adb0be98..fe15d4ba540 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
@@ -38,6 +38,14 @@
 	phy-supply = <&vcc_host_5v>;
 };
 
+&u2phy_otg {
+	status = "okay";
+};
+
+&usb20_otg {
+	status = "okay";
+};
+
 &vcc_host_5v {
 	/delete-property/ regulator-always-on;
 	/delete-property/ regulator-boot-on;
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 52dad765a8a..9fdb08f29f9 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -24,10 +24,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
@@ -51,6 +53,10 @@ CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
@@ -86,6 +92,7 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
@@ -93,6 +100,11 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 518ea4ebe51..c3dfc2718f0 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -24,10 +24,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
@@ -52,6 +54,10 @@ CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
@@ -87,6 +93,7 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
@@ -94,6 +101,11 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.0

