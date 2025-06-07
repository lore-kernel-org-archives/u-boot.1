Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5825AC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 05:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FAA826AA;
	Sat,  7 Jun 2025 07:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="AuzdPUpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E666F82BF6; Sat,  7 Jun 2025 07:43:56 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1A082BA7
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4bDnDT1gJdz9ty7;
 Sat,  7 Jun 2025 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1749275033; bh=fMF8pJ31RSO7pYk1dNs6Pw83DseZvo4Zl0fr98T9zgY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AuzdPUpiIYiOanKSTX0Sub9L4P2nwDPg090FZWeXFFhcQ7CQ3TgQen/WOpm0oQRKi
 GAfWnDgkdK9u6vvpiXn3QEB1xOo9Zrump2rdVwrk4lcTVcCJV6xRukBvIRPwQv/eBp
 xWJJlKbeatIqProTu5PuXly8van3xzdWLl4DdzkQ=
X-Riseup-User-ID: CB56AA60B16E1AA6CDF09AB3F3EE19407ECD0DC57CE0B0E2DB6AF3EC1EF8EE12
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4bDnDQ06c9zJn3g;
 Sat,  7 Jun 2025 05:43:49 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 07 Jun 2025 12:43:10 +0700
Subject: [PATCH v5 11/12] configs: pinetab2-rk3566: Enable video and USB
 keyboard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-vop2-pt2-v5-11-1d52f7a2cf3c@riseup.net>
References: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
In-Reply-To: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
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
 configs/pinetab2-rk3566_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 6e5fde591d05bc9bb7a3bc177a28d806d03b640e..3b8441e35523952f3ca6cd585e8ff5de682952d0 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -68,6 +68,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_SPL_PINCTRL=y
@@ -93,6 +94,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
@@ -100,4 +102,12 @@ CONFIG_USB_ETHER_RTL8152=y
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

