Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A9FD3C52C
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E31890CE;
	Thu, 17 Oct 2024 22:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vChtcqEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC2F890BE; Thu, 17 Oct 2024 22:01:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9082789099
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195258; bh=NyZnlvVt1wPgtI+nPHMBVNC9S2WILG58vMjSRZpr+Hg=;
 b=vChtcqELH7G4aI4pIuGytrr0Xx6cFG78RAtaSTv1NXC65Mm8Ygfy4qESDz0uSiRr2lUnCILCB
 GPPxQbSN2Ky4S6vJXsZZsILZOKlyonQbd3RDEb1sZvnG8svG9W0J/k2ZCRYjDX7qqn6ETZO2t8c
 UPWKQsuYIWjO1qaLU10NRm52eZs5Y5ZpnT+w8DhrJCzE+M/3H+N505pp2gsaFMzVskaM3gkFvKS
 KfyC+NUQk2pqg8nOe1mKpbts5No/2w0kXlXCyeEBYr/poMh1TF2p9vBvEj4ir3/qF6hxT82+FS/
 PF50bNfXrC2gY1r5J5MOusKpg2F3OoMogJV5Bq55sqRA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/8] arm64: dts: rockchip: add NanoPC-T6 LTS
Date: Thu, 17 Oct 2024 20:00:22 +0000
Message-ID: <20241017200039.1235524-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116cf86385e073f5ab13c9
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

In the LTS (2310) version the miniPCIe slot got removed and USB 2.0
setup has changed. There are two external accessible ports and two ports
on the internal header.

There is an on-board USB hub which provides:
- one external connector (bottom one)
- two internal ports on pin header
- one port for m.2 E connector

The top USB 2.0 connector comes directly from the SoC.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Link: https://lore.kernel.org/r/20240829-friendlyelec-nanopc-t6-lts-v6-4-edff247e8c02@linaro.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: db1dcbe5f752d423421f77d54d246398b196f670 ]

(cherry picked from commit f4a834fbc8cdb40fddd63d083e8d1c6189ba62dc)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm64/rockchip/rk3588-nanopc-t6-lts.dts   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
new file mode 100644
index 000000000000..2d92bbb4027d
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2023 Thomas McKahan
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "rk3588-nanopc-t6.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPC-T6 LTS";
+	compatible = "friendlyarm,nanopc-t6-lts", "rockchip,rk3588";
+
+	/* provide power for on-board USB 2.0 hub */
+	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb20_host_pwren>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb20_host";
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&pinctrl {
+	usb {
+		usb20_host_pwren: usb20-host-pwren {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.46.2

