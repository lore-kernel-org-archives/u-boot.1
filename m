Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8EAC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5456188C1F;
	Fri,  2 Aug 2024 20:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lb6LVXoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C58288BF0; Fri,  2 Aug 2024 20:00:37 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696F488BF5
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722621628;
 bh=r8W6CKoUDdRivVx6ZtpDwqnmFzG5AjB9b1F+VpiFx50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lb6LVXoTKMXng/8ojw+5LnMTv6ePr7FLKCRAmEYrgORPzyxiQZ5QsK3CirpoExLwM
 8W3Z7St/RS45M3UZPmnCCMBj2QgUKbfJJ7AcdFknsIQ66n+T/Evh5LYjse09n3EZx3
 CIRjBdjZzn+sMH+TXUWsCxDKDgiiNy6WHR/8rm5SJyrU4Hrl9sDOJf0madstelX5Yo
 kyVeUkiKImERPkhF1Bd3GaIYPAWr8wAJf3mOsAFVigCRXTu/qcgGCB+0ou+fZa9ZQ7
 DkI0/M2Rmhv9c5O2rPdyE5t0yGoFzCDeqwldFKTt+S0eZMogLN8Mh2pGj0Wem98FLc
 DBCG1UsaE5iFg==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFF44378221E;
 Fri,  2 Aug 2024 18:00:28 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id D322D4800F6; Fri, 02 Aug 2024 20:00:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 5/7] rockchip: rk3588-rock-5b: Add USB-C controller to
 u-boot.dtsi
Date: Fri,  2 Aug 2024 19:59:35 +0200
Message-ID: <20240802180027.139193-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 8e318e624a85..e93795359ece 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2023 Collabora Ltd.
  */
 
+#include <dt-bindings/usb/pd.h>
 #include "rk3588-u-boot.dtsi"
 
 &fspim2_pins {
@@ -65,3 +66,30 @@
 	dr_mode = "host";
 	status = "okay";
 };
+
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
-- 
2.43.0

