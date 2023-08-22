Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C2CEE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 22:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487A9864AF;
	Wed, 23 Aug 2023 00:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B126E864AF; Wed, 23 Aug 2023 00:17:40 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C553D8642F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 00:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([84.226.64.168]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MJRQT-1qb3Sc37jX-00332B; Wed, 23 Aug 2023 00:17:30 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1] board: toradex: verdin-imx8mm: enable usb sdp spl recovery
 support
Date: Wed, 23 Aug 2023 00:17:25 +0200
Message-Id: <20230822221726.8355-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nhEULV4N3it5G/JkndRidY78V04Ne+/c9KVU33YDfjJx2mlAauQ
 6tdy6Rj08u8rKsFKhJslgpqV2I7wkvvvUitXrRSX/kXzSUjj0s/A8muaUsjEifPcV9sCZZa
 Ujf9+tZ6bcskwRJpld6ifc7jin5I++ncBUDMTsmJGdiuHtQIPYC0Elt9Q8oXTYhX3TwS4Il
 J5unzAxUnfYthP2dRLz5A==
UI-OutboundReport: notjunk:1;M01:P0:phZyo70o9wk=;rZD5fNLVmAxFLZTbzzdWapErJVq
 Tr4aJnXgg3M/yI7rNgP7ek3W367jwruuyoIYJA9ibVhvg6eFb/gc843FSMGvIb4j0dkLVYL8y
 fMvOn/eGZrCpsa4FgLhjJ4wvODjcNTDI9QnN39BtRqhvgdACHgJS8vWcB0LXxtnL9Dn95IHOJ
 9/lj2F5S34/glgPUNJl0IIRLTsz4L47+BX9i9/QMLha30v3qWyzDHIh/+R/aP/Cx48cj4Gpzy
 U03aT5ifnyODk22ic6XKlspxjp2cMREi450tq2QVXnRj/HsQooSRpbC0+q+1m/J0y4PA/D3GY
 qdnS0gnXAU4yEURF7G+ujcRWbxV8KT7SbpaPJMLMBRd9tV6tEuA3lsZsxMVQPaybpgCcgcZ9n
 yykWtPZdMElxAW1p65kCUO5VskoLNxoySFoBJ6lMYIRgOiYSTy2Drl11MXwLY8ZE5T9ZYSK9D
 wIgmZzptuEi/u98ReHQzqQc1nuwEmJUOWjICNwMT1DBOxGV0XLN6GpePkZkfoyUqLXF+Uaxpi
 daG1sMlxM464KXoIGRT+7aiekm5gH0dWVuFFEsItG8fFeDEzwsDEVTFNVSabdoMD/Y7SOMid1
 jqKZqKe3VVlISEKvgxTHVXIVJU6E69jcq0xpdkPh5dzoc8KzsLfXOpAZvu6cyGRvcAk88Jph3
 oU1AmShL5aVid1Bfc/HWiVxM8itNX1R0vFuGhLXJujqyoCKWPcO+iue12WUACllfeyzAOsQdv
 Q5LLBmi6d9VznBdMS2YxfIxGxGgkWdI6pHRhJq4MOrsR7QfAKe8Ar6lG38WX+4z3FT5kGEdVd
 wV6kZBJtstxZaHwbn+tjtw8C0hGx7CB+oiaDRCZOYaUgE8jFw/3Rf3Edew4o8dKUkhOYg5yTZ
 plFVlGsYelRFv5f1YKspriPyRLnzXtwDQR5k=
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable USB SDP SPL aka serial downloader recovery mode support.

While at it also enable fastboot support which may be used to
subsequently load further stages like a Toradex Easy Installer FIT
image.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    | 17 ++++++++++++++++
 configs/verdin-imx8mm_defconfig               | 20 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 2b268f55cb9..b06ce3fa034 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -34,6 +34,10 @@
 	bootph-pre-ram;
 };
 
+&aips4 {
+	bootph-pre-ram;
+};
+
 &binman_uboot {
 	offset = <0x5fc00>;
 };
@@ -124,6 +128,19 @@
 	bootph-pre-ram;
 };
 
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+/* Verdin USB_1 */
+&usbotg1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 09e14c6f8c4..2fbde394577 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -69,6 +69,8 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
@@ -97,6 +99,12 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x40000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
@@ -120,6 +128,8 @@ CONFIG_PHY_FIXED=y
 CONFIG_DM_MDIO=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_NOP_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
@@ -139,8 +149,18 @@ CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
 CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x40400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_HEXDUMP=y
-- 
2.36.1

