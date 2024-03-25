Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E578C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 16:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAD387F41;
	Mon, 25 Mar 2024 17:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F45887F24; Mon, 25 Mar 2024 17:27:44 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755F387F36
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 17:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ronAi-0034H4-Tw;
 Mon, 25 Mar 2024 16:27:41 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m*-venice: enable TPM support
Date: Mon, 25 Mar 2024 09:27:39 -0700
Message-Id: <20240325162739.1350665-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Enable support for TPM2 devices. As the ATTPM20P TPM2 used on the
Gateworks Venice boards hangs off the SPI bus we enable SPI support
as well.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 configs/imx8mm_venice_defconfig | 10 ++++++++++
 configs/imx8mn_venice_defconfig | 10 ++++++++++
 configs/imx8mp_venice_defconfig | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index cb6b97d097c1..86928687df2d 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -127,14 +128,20 @@ CONFIG_SPL_DM_PMIC_MP5416=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+# CONFIG_DM_RNG is not set
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_HOST_ETHER=y
@@ -152,4 +159,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_TPM=y
+# CONFIG_SPL_SHA512 is not set
+# CONFIG_SPL_SHA384 is not set
 CONFIG_HEXDUMP=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 0a4fba5f1ca8..6bb0f015a9bf 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -128,14 +129,20 @@ CONFIG_SPL_DM_PMIC_MP5416=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+# CONFIG_DM_RNG is not set
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_HOST_ETHER=y
@@ -153,4 +160,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_TPM=y
+# CONFIG_SPL_SHA512 is not set
+# CONFIG_SPL_SHA384 is not set
 CONFIG_HEXDUMP=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 6e4addc7728f..b1055ef2f066 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -73,6 +73,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -135,14 +136,20 @@ CONFIG_SPL_DM_PMIC_MP5416=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+# CONFIG_DM_RNG is not set
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
@@ -160,4 +167,7 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_TPM=y
+# CONFIG_SPL_SHA512 is not set
+# CONFIG_SPL_SHA384 is not set
 CONFIG_HEXDUMP=y
-- 
2.25.1

