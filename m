Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86886C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36EE3883B1;
	Mon, 22 Apr 2024 08:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="timYdaNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF582883CC; Mon, 22 Apr 2024 08:31:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD9F883B4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767475; bh=wQ8iKS9zC+p5fNyP8FsuxtaQ568oF9LrsglwRbbeO00=;
 b=timYdaNISaw9Ij+sbWqIs7QiyIlhtp2BfT2TVoxERl/gbl7iJVussAF2LUncWdrZwTy4MSCPr
 nxRDJmvg9ASHwqGefMnSN8Bc5IRR2HvM4Hn5y9wR3/AI7JvhI+Es81MYrSmGEYR3H3oRZ9VoAdd
 K8afJ/KapBI1R9/szc2+zM3J/2gV15l4cb6/y+P8OKZSRiyy61ewZKHjJRKka/n6AQXRetevJ55
 WKHGt108JkqyVqx+JJZZ6NyDXH8cAi3piWg/lpGnbczKi+6BIHExii0ccpYmhsaEpP9778RLnB6
 Niz+m4wB2aqgxO4pY1d48ui91u4sveBfvWwq1YP9v0HA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 27/28] rockchip: rk3588-generic: Add support for USB OTG
Date: Mon, 22 Apr 2024 06:29:04 +0000
Message-ID: <20240422062936.681359-28-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 6626043334ba165ad4474492
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

Add support for USB OTG, RockUSB and UMS to the generic RK3588S/RK3588
target.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: Split patch
---
 arch/arm/dts/rk3588-generic-u-boot.dtsi | 22 ++++++++++++++++++++++
 arch/arm/dts/rk3588-generic.dts         |  2 +-
 configs/generic-rk3588_defconfig        | 11 +++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
index 853ed58cfe58..225dfa0b682a 100644
--- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
@@ -1,3 +1,25 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk3588s-u-boot.dtsi"
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&usbdp_phy0_u3 {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index baafe7463f1b..95d757676f12 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3588S/RK3588 with eMMC and SD-card enabled
+ * Minimal generic DT for RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
  */
 
 /dts-v1/;
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index b50f4f8b8008..e96df619b59d 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -27,6 +27,8 @@ CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
@@ -36,6 +38,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
@@ -44,10 +47,18 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
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

