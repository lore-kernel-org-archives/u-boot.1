Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E99C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2872883B5;
	Mon, 22 Apr 2024 08:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="g5ouhlkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D5C883B3; Mon, 22 Apr 2024 08:31:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C492883CA
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767470; bh=SRX4eAhViHTzL7jpadGS2lVEjY3NFRg2v4KFc2KqEfE=;
 b=g5ouhlkmuXZkW1woKy9HY1hDvAzToMChw2izevIsCcSrridBaedgihk5sqlExsO4kQDkg240Z
 z3sanXVcnm8u8qxPhrje5RPyIMi/01SV25yc317t42rbJ6f1fGF+M5kxkfDM8/jgp02/1muYVQL
 nQ0ryeB2X6Upt+bc3/VA/Oe4E+/JHpM8UpZnfWpB7oOpwWBj5aMSITq3Uf2lMhuvMf0sYKZfM4I
 qox4YUA30vN4H9UUWM1P2ZFCiUUVWQvIZ+56DHeUMaQfhigDLz5NdrZuJSoCzBkP0pHetaT1Khu
 HWpJJ3YEiqzrThpecM8YVXL8cqM6rdxByw+BZZEwgjkw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 25/28] rockchip: rk356x-generic: Add support for USB OTG
Date: Mon, 22 Apr 2024 06:29:02 +0000
Message-ID: <20240422062936.681359-26-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6626042d34ba165ad447446e
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

Add support for USB OTG, RockUSB and UMS to the generic RK3566/RK3568
target.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: Split patch
---
 arch/arm/dts/rk3568-generic.dts  | 19 ++++++++++++++++++-
 configs/generic-rk3568_defconfig | 10 ++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
index 87c3aff26589..085a09268e8a 100644
--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card and SPI flash enabled
+ * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card, SPI flash and USB OTG enabled
  */
 
 /dts-v1/;
@@ -58,3 +58,20 @@
 &uart2 {
 	status = "okay";
 };
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	extcon = <&usb2phy0>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy0_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 9276eae63ee3..26114f9cb2a5 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -31,6 +31,8 @@ CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
@@ -40,6 +42,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
@@ -57,6 +60,7 @@ CONFIG_SPI_FLASH_SILICONKAISER=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
@@ -64,4 +68,10 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

