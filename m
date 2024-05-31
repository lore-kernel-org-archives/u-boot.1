Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF091C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9B9887EA;
	Fri, 31 May 2024 17:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GS1ma8v6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D52887EA; Fri, 31 May 2024 17:10:56 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28FB887B7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717168253;
 bh=46u/7UmXR2OVP+aAr/o4yvI0ko+kr0rVUqVs+C+BgeE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GS1ma8v6fzo9plNPS4pmeHXOi/+0CdJgCjDgl2BQYWcqVHmwP3PuGaXu06AA3hBtx
 CMn1qKVliIuhsngSWMnVaFjK+ztnANXRXZQqhz8qNvIp5nHUzam+lql6IbuuE7oMeQ
 iiD8YMtITNDiFKLtQKPACIhAOKio5/ZJPXBwaS4YzP/rNZ6vvv1tsiLKmeFcxW+NKS
 8tL6dW+Co3MY8pG2cvG0+uIWC7EvIJqh9ESpye4aEiQMDuogfs3Ij6EXc1W2+0FDnu
 6PHGnzDJhn9SvRCbl+wPuRPgd8GS38JVCKaDxS2+5C9uy7ZBfh6Ao8Kei4COfXhEb6
 1fA4+egGeGBog==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62C9837821DE;
 Fri, 31 May 2024 15:10:53 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E466A4800CE; Fri, 31 May 2024 17:10:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 3/5] board: rock5b-rk3588: add USB-C controller support
Date: Fri, 31 May 2024 17:08:15 +0200
Message-ID: <20240531151026.84846-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531151026.84846-1-sebastian.reichel@collabora.com>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
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

Enable support for the fusb302 USB Type-C controller.

This will do early USB PD (power deliver) negotiation, which must happen
within 5 seconds after the USB-C connector has plugged in according to
the specification. It takes almost 5 seconds to go through the bootchain
on Rock 5B and jump to the operating system. When the Linux initializes
the fusb302 usually 20-30 seconds have gone since the device has been
plugged, which is far too late. The USB PD power source reacts with a
hard reset, which disables VBUS for some time. This is not a problem for
a battery driven device, but Rock 5B will loose its power-supply and
reset. By initializing PD in U-Boot, this can be avoided.

The DT node can be sourced from the Linux kernel DT in the future,
but to get things going it makes sense to add it in the U-Boot
specific file for now. Because of the reset issue it is important
to get support in U-Boot first.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi   | 28 +++++++++++++++++++++++
 board/radxa/rock5b-rk3588/Makefile        |  6 +++++
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 22 ++++++++++++++++++
 configs/rock5b-rk3588_defconfig           |  4 ++++
 4 files changed, 60 insertions(+)
 create mode 100644 board/radxa/rock5b-rk3588/Makefile
 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c

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
diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
new file mode 100644
index 000000000000..95d813596da4
--- /dev/null
+++ b/board/radxa/rock5b-rk3588/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# Copyright (c) 2022 Collabora Ltd.
+#
+
+obj-y += rock5b-rk3588.o
diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
new file mode 100644
index 000000000000..75856ccb1288
--- /dev/null
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023-2024 Collabora Ltd.
+ */
+
+#include <usb/tcpm.h>
+
+#ifdef CONFIG_MISC_INIT_R
+int misc_init_r(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = tcpm_get("usb-typec@22", &dev);
+	if (ret) {
+		printf("Failed to probe Type-C controller\n");
+		return 0;
+	}
+
+	return 0;
+}
+#endif
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index fc118cea7bae..e368b0439d1d 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -102,3 +102,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_MISC_INIT_R=y
+CONFIG_CMD_TCPM=y
-- 
2.43.0

