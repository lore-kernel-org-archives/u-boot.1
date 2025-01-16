Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3AC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1207C807C4;
	Thu, 16 Jan 2025 14:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="UltkdIgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A6C8069D; Thu, 16 Jan 2025 10:16:52 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF41D801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YYcgj19cNz9t9V;
 Thu, 16 Jan 2025 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737019009; bh=O/sXEtk6SqJ84q3Ofn+MMdRRJfLs/3yRb8Oq+TGXhYc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UltkdIgsdpD2fqG0Q3/KYrvr4SAPPPnyY2oLjky+z5bcQjZbMYDyOQSBsj7Oi7Jfv
 8eq30JiMlKzBlNsaKNutwJ/psZP8nl3I0g1WOFlJveTN/+B4Xtp22xhls1FmXxe242
 Y3rkgRn5aX3y2h3c8C5d4rMQ3anPeFIX8sNLfMt0=
X-Riseup-User-ID: ABF14187318540B57A2389230720F100A422D752202057B6BB1E8A0F6D6E7462
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcgf2hDnzJrSq;
 Thu, 16 Jan 2025 09:16:46 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Thu, 16 Jan 2025 16:15:59 +0700
Subject: [PATCH 10/10] configs: pinetab2-rk3566: Enable video and USB keyboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-vop2-pt2-v1-10-c9d646b53930@riseup.net>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
In-Reply-To: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:20 +0100
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

Now that we have VOP2 support, let's enable it and support the
built in USB keyboard.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 configs/pinetab2-rk3566_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 45e63b42d192dc172f24e071b09c8203675965d8..b250d8d12e9d5e045e28db4d455850f94514321f 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -23,7 +23,10 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
+CONFIG_PRE_CONSOLE_BUFFER=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
@@ -57,6 +60,8 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
@@ -69,6 +74,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_SPL_PINCTRL=y
@@ -94,6 +100,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
@@ -101,4 +108,12 @@ CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_VIDEO=y
+CONFIG_CONSOLE_ROTATION=y
+CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
 CONFIG_ERRNO_STR=y

-- 
2.48.1

