Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2F0C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DA7830F6;
	Mon, 28 Jul 2025 18:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6C982E34; Mon, 28 Jul 2025 18:48:19 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BCB82E52
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ugR1L-0098YX-73;
 Mon, 28 Jul 2025 16:48:15 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 2/2] imx8mp-venice: enable USB device mode
Date: Mon, 28 Jul 2025 09:48:12 -0700
Message-Id: <20250728164812.1522111-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728164812.1522111-1-tharvey@gateworks.com>
References: <20250728164812.1522111-1-tharvey@gateworks.com>
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

Now that we can determine device role via a usb-connector ID pin,
remove the host-only mode dt override and enable additional USB
device mode support.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi | 5 -----
 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi | 5 -----
 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi | 5 -----
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi    | 5 -----
 configs/imx8mp_venice_defconfig                  | 7 +++++++
 5 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
index a291b7abab62..c1d21e51c4e6 100644
--- a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
@@ -54,8 +54,3 @@
 		line-name = "pci_wdis#";
 	};
 };
-
-/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
-&usb_dwc3_0 {
-	dr_mode = "host";
-};
diff --git a/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
index bdf5370fcdf6..9f6d05fdae0c 100644
--- a/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
@@ -89,8 +89,3 @@
 		line-name = "pci_wdis#";
 	};
 };
-
-/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
-&usb_dwc3_0 {
-	dr_mode = "host";
-};
diff --git a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
index 7e6f66bd9dd9..3b23802e9a7d 100644
--- a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
@@ -95,8 +95,3 @@
 		line-name = "pci_wdis#";
 	};
 };
-
-/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
-&usb_dwc3_0 {
-	dr_mode = "host";
-};
diff --git a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
index 95f5f15e742a..a82ce5a19788 100644
--- a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
@@ -250,8 +250,3 @@
 &wdog1 {
 	bootph-pre-ram;
 };
-
-/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
-&usb_dwc3_0 {
-	dr_mode = "host";
-};
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 526a954aa857..02fb5e6c0555 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_SETEXPR_FMT=y
 CONFIG_CMD_XXD=y
@@ -162,6 +163,7 @@ CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
@@ -177,6 +179,11 @@ CONFIG_USB_ETHER_LAN78XX=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Gateworks"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_TPM=y
 # CONFIG_SPL_SHA512 is not set
-- 
2.25.1

