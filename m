Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A9DD1D87B
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE176889AA;
	Tue, 15 Oct 2024 17:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ck4Y2Ngo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28AB88B0A; Tue, 15 Oct 2024 17:27:23 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF42A88969
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1729006039;
 bh=GWKuD+NEylQZ8DGdcp5bvDJYA2K9IGPkfso/xVKnOkc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ck4Y2NgoBsiAHfS2R/FAgQBleLHaNlXmMMAY5FpFIhVOti3m7WcF6d0cn6b+sCLMe
 v9irIdp3gtodrEvNKold0A46OLBML8Ui3KgW/pVHBLDMfYF1BzNN03eHlJJV4Nyqyz
 K7PQQ/S+p1oo/J3JLdY22N/3dzXArRiOIoXj9RWFhBlJ1HQhb3hKAO7DNr2IfKmY8S
 jHFoTrYQ39dGYcKyZUyc3DoCU5EuimVZGrFK0Yb6J0bJWekYY1AV+8Hi3Srz+Ut5V8
 NnhTarc+5y34FFS9+T+dvD1Uy2FVUA80QJFilgAdNw/W25n84oRr6X1PDfPJI3WkDR
 zUH8LW+Jx/N+w==
Received: from jupiter.universe (dyndsl-091-248-191-104.ewe-ip-backbone.de
 [91.248.191.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F52517E3624;
 Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 205FF4800F8; Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 4/6] rockchip: rk3588-rock-5b: Add USB-C controller to
 u-boot.dtsi
Date: Tue, 15 Oct 2024 17:26:46 +0200
Message-ID: <20241015152719.88678-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015152719.88678-1-sebastian.reichel@collabora.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
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

Add USB-C controller (fusb302), which will be used by U-Boot to
initialize USB-PD. This is needed, because USB-PD communication
must happen within 5 seconds after the USB-C connector got plugged.
On my Rock 5B it often takes 5 seconds to jump to the Linux binary,
so it must happen before Linux is initialized.

This adds the DT node to the U-Boot specific file, since the Linux
kernel DT currently does not describe it to avoid a system reset.
The plan is to add it to the Linux DT with status = 'fail' and then
let U-Boot mark it as status = 'okay' if it properly dealt with
early USB-PD initialization. Until the Kernel DT has the node, let's
add it in U-Boot to get things going.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Soeren Moch <smoch@web.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 4dd17ff408cb..b0ad1158854c 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2023 Collabora Ltd.
  */
 
+#include <dt-bindings/usb/pd.h>
 #include "rk3588-u-boot.dtsi"
 
 &fspim2_pins {
@@ -10,6 +11,33 @@
 	bootph-some-ram;
 };
 
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+	status = "okay";
+
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "sink";
+			try-power-role = "sink";
+			op-sink-microwatt = <1000000>;
+			sink-pdos =
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
+				<PDO_VAR(5000, 20000, 5000)>;
+		};
+	};
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-- 
2.45.2

