Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC874C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2728283753;
	Tue, 22 Jul 2025 00:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qHvdTk4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A62830EA; Tue, 22 Jul 2025 00:08:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051AA8383F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135695; bh=DWNofZWsELtd9nIMUA5suLfA/VQaS1I9Sg8FuboOHcw=;
 b=qHvdTk4MiG4NGTJd6lBNJzvzc4WLjlPFN4RZOAbRbmKPYTvhKewauS8mUQsLjdUMMvmBignTW
 w7nckorpW25ZKWoSs+D3GFStHsnkbOwJJqPlQfGNjvfWeSOYt1hT0Ci4c7z3B0DP3HNOWVdqW+J
 PTdyP/EjLAO/YvUE9/rJsgbvEuCmd3Su0WkXxmfSOOsOMUmyxUf8dONeg2o6ZKKh2cr870KiYMn
 fjnPcHTdEMlpGVLccJ1/DA0zeSHHh9Bn/YjUaDOjYUt8W65DL3ufQ6DLP6bAd1Rlbc9ekkAnE1w
 jKTdMq0kzwV3SxyppGW9OnjA7wh+F1gDrYJLbsgddKzw==
X-Forward-Email-ID: 687eba4e285c522641289589
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 10/10] rockchip: rk3588-generic: Move usb nodes to board dts
Date: Mon, 21 Jul 2025 22:07:19 +0000
Message-ID: <20250721220734.1617117-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
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

After the commit 7a53abb18325 ("rockchip: rk3588: Remove USB3 DRD nodes
in u-boot.dtsi") was merged for v2024.10 there is no reason to keep the
usb nodes for the Generic RK3588 board in the board u-boot.dtsi.

Move usb related nodes from board u-boot.dtsi to main board device tree.

While at it, also drop use of the usb3-phy as we only want to enable the
usb2-phy to be compatible with as many boards as possible.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-generic-u-boot.dtsi | 18 ------------------
 arch/arm/dts/rk3588-generic.dts         | 16 ++++++++++++++++
 configs/generic-rk3588_defconfig        |  1 -
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
index f67301d87a6e..853ed58cfe58 100644
--- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
@@ -1,21 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include "rk3588s-u-boot.dtsi"
-
-&u2phy0 {
-	status = "okay";
-};
-
-&u2phy0_otg {
-	status = "okay";
-};
-
-&usbdp_phy0 {
-	status = "okay";
-};
-
-&usb_host0_xhci {
-	dr_mode = "peripheral";
-	maximum-speed = "high-speed";
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index 95d757676f12..6740f9866f17 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -39,7 +39,23 @@
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	phys = <&u2phy0_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index ed2f936b324b..dfa8efabe6be 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -53,7 +53,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.50.1

