Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBACD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066B588C7F;
	Tue,  3 Sep 2024 20:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Fk1mmDYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A8888C21; Tue,  3 Sep 2024 20:21:41 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BCD88B49
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725387696;
 bh=vhtzCLtJh0vs21ZCzo0Fi9OtuzKlKwoqG87vCckZH60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fk1mmDYkzhR2v5jWh+s2P4rUA+U4VX5iQdoUDD0rajtEF0Oc5rxbPmScOwjfeJ9cg
 WaogJmIZtV8zSWqYOLf3BRNHFdHxb6zmmMQbqYlsyyPug9nuv3YOQ7mwJCFv3hbhv3
 CkGzdSwQ7UTtS6tSA9i/OHStsUGomXyb+K2wuEoziU5QywhALLsWTstkbDv5Tc/ZgB
 YsRGb/czpMa/bNe3tqCBQKts+bKuIsqMx0jaELLt8gBDCp+DYsVMqGzxiewoEv5QJG
 VeQv8s9UmIXqy0scMaLmM3Us4xOjBXRFq2C0sywqPaKFRFyJ55PJYscEhrNDJBRC9/
 SYHk6rhIWDBBw==
Received: from jupiter.universe (dyndsl-091-248-190-124.ewe-ip-backbone.de
 [91.248.190.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CA86617E1213;
 Tue,  3 Sep 2024 20:21:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 80EC84800F8; Tue, 03 Sep 2024 20:21:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 4/6] rockchip: rk3588-rock-5b: Add USB-C controller to
 u-boot.dtsi
Date: Tue,  3 Sep 2024 20:16:56 +0200
Message-ID: <20240903182136.153196-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903182136.153196-1-sebastian.reichel@collabora.com>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
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

