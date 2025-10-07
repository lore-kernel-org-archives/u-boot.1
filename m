Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B1CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4AC8388C;
	Tue,  7 Oct 2025 10:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="b9EYvIU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E6D838AE; Tue,  7 Oct 2025 10:18:16 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B1E8386F
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2C268C9A49; Tue,  7 Oct 2025 10:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825093; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=QN/hdNze8vR71s1Din3drQurPRoX3y7uj9w/oGz2/TI=;
 b=b9EYvIU6cmFcrUcMgG8pGH+Dl+MbERlEiFyt+iR/xMPCePNM3nlCc0eq9Yxl2e+yi+Mi7g
 RJr5vSlMkeK6L8ZDg52VByhYNrXkJ3FRbCK/dH6rlotl+dQwNkDwesXREF6t04TodaQXMN
 ISSxYEW5veVSoIJlQw3Y5tJAWVaMIMdoiYNEDzP2U+mXJ8T31oPvCXV5gwztCKlpaOl6qO
 mQx/asFQ97qcqsMB0WpYPwmNjMKw937T/ieIY1Zan+3viikAvq4FUCUB59ZHd6zL78vZhw
 GHgt4R6D07Yp0KgewKrkKkDZ4OE5MIOddFEWeChsHtZz8IZyi4in5/VW08DR+A==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/13] imx: kontron-sl-mx8mm: Enable SDP support for loading
 via USB
Date: Tue,  7 Oct 2025 10:15:59 +0200
Message-ID: <20251007081640.61772-3-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable everything that is required to load via USB. The SPL needs
SDP support so it can load the U-Boot proper image via USB after
it has been loaded via serial loader mode of the i.MX.

This way we can use the uuu tool for loading SPL and U-Boot
proper like this:

  uuu -brun flash.bin

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi | 16 ++++++++++++++++
 configs/kontron-sl-mx8mm_defconfig               | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
index ae542fdcffa..acb26cd5af6 100644
--- a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
@@ -18,6 +18,10 @@
 	};
 };
 
+&aips4 {
+	bootph-pre-ram;
+};
+
 &i2c1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -108,6 +112,18 @@
 	bootph-all;
 };
 
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
+&usbotg1 {
+	bootph-pre-ram;
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 92583317a07..7b6ab1e217f 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -69,6 +69,8 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -117,6 +119,8 @@ CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_NOP_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
@@ -141,13 +145,19 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+# CONFIG_USB_STORAGE is not set
 CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
 # CONFIG_HEXDUMP is not set
-- 
2.51.0

