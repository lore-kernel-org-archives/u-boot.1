Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77EFC369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 14:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B251482E40;
	Sat, 12 Apr 2025 16:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="C84K2IoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6CD82E40; Sat, 12 Apr 2025 16:31:55 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBD482E68
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 16:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZZbbW1VvWz9wPG;
 Sat, 12 Apr 2025 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744468311; bh=De74bNhIUvmrpVL7MIBBhHZ8/m/Z6fP0TKSZ+Jebex4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=C84K2IoAIZFFgXKCaeEbFbYCkKXW1PX2WNDQkdxRoC2zT+J6JKgF4gqW9slsrlKvq
 EwMG5EfcxQVuqwC3NRwOz/L+Vu9Oed9BnaxNKzrO4ssx7cvFt2oxPAPaEE8ox3mYp6
 3WeDVCVJ1lvSfy64FZNO7AZz3WunhtapJkeFbC/4=
X-Riseup-User-ID: FF647AB2B8C7021F161A8A901E5C210A02BF892E23599E9078BBED05F9E50E12
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZZbbR5Qs4zJtcZ;
 Sat, 12 Apr 2025 14:31:47 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 12 Apr 2025 21:27:13 +0700
Subject: [PATCH v3 11/12] configs: pinetab2-rk3566: Enable video and USB
 keyboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-vop2-pt2-v3-11-7c796db335e9@riseup.net>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
In-Reply-To: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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
 configs/pinetab2-rk3566_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 45e63b42d192dc172f24e071b09c8203675965d8..792ec0ec119437fd7a920558a149363c886c87de 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -57,6 +57,7 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_CCF=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
@@ -69,6 +70,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_SPL_PINCTRL=y
@@ -94,6 +96,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
@@ -101,4 +104,12 @@ CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_REMOVE=y
 CONFIG_ERRNO_STR=y

-- 
2.49.0

