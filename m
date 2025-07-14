Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A4C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 22:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27EB83092;
	Tue, 15 Jul 2025 00:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jg2n86nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551D98304A; Tue, 15 Jul 2025 00:34:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A55BC8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 00:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752532473; bh=+B9aHLNrc7N6lWknVsGp2VbhdYABwCdu+DcSjYYtMsQ=;
 b=jg2n86nqwjfegoCXN0bZn+vPoD1zmwudL7dw0sSfY517LpCuUaBo7VKfoLJ+U6RlfST/ppMhl
 PX1ps5ebZ2j9TrlOgMRqikKkwohdvSX4gO1Noz/Iql8chbJWwI+iRyWPk0dSw2CMMMOh2yEiiJT
 nA2JXIPCz7oUTOJHxneJ7smB8wFErRcolTSJwzBfrawf6QkOl3763/B8TYjq2KhAGHT56OiqT+t
 L5UCRWuZ0AYtexDzV9j1VRuxbis/DWU2YCtC5l8dCYmPMVRQh5JyQ2HYWSwx9OlojcS0fZcB0//
 VJRB79EtJ9mCx3/V16KaErwjun/TUZZZ4a/F+QsKJadA==
X-Forward-Email-ID: 687585f49931367d30116e6a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/4] arm64: dts: rockchip: add Rock 5B+
Date: Mon, 14 Jul 2025 22:34:00 +0000
Message-ID: <20250714223410.1836893-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714223410.1836893-1-jonas@kwiboo.se>
References: <20250714223410.1836893-1-jonas@kwiboo.se>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add ROCK 5B+, which is an improved version of the ROCK 5B with the
following changes:

 * Memory LPDDR4X -> LPDDR5
 * HDMI input connector size
 * eMMC socket -> onboard
 * M.2 E-Key is replaced by onboard RTL8852BE WLAN/BT
 * M.2 M-Key 1x4 lanes is replaced by 2x2 lanes
 * Added M.2 B-Key for USB connected WWAN modules (untested)
 * Add second camera port (not yet supported in upstream Linux)
 * Add dedicated USB-C port for device power (no impact in DT;
   the existing port has not been changed and the new port is
   handled by CH224D standalone chip)

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250508-rock5bp-for-upstream-v2-4-677033cc1ac2@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 376cb9696298df2028afb620a9dc6c4b10a18605 ]

(cherry picked from commit 73262063f45da4fc1cab7cac91f568edc9d0eb7d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../arm64/rockchip/rk3588-rock-5b-plus.dts    | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b-plus.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b-plus.dts b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b-plus.dts
new file mode 100644
index 000000000000..74c7b6502e4d
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b-plus.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588-rock-5b.dtsi"
+
+/ {
+	model = "Radxa ROCK 5B+";
+	compatible = "radxa,rock-5b-plus", "rockchip,rk3588";
+
+	rfkill-wwan {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-wwan";
+		radio-type = "wwan";
+		shutdown-gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc3v3_4g: regulator-vcc3v3-4g {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		/* pinctrl for the GPIO is requested by vcc3v3_pcie2x1l0 */
+		regulator-name = "vcc3v3_4g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_wwan_pwr: regulator-vcc3v3-wwan {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wwan_power_en>;
+		regulator-name = "vcc3v3_wwan_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_4g>;
+	};
+};
+
+&gpio0 {
+	wwan-disable2-n-hog {
+		gpios = <RK_PB2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "M.2 B-key W_DISABLE2#";
+		gpio-hog;
+	};
+};
+
+&gpio2 {
+	wwan-reset-n-hog {
+		gpios = <RK_PB3 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "M.2 B-key RESET#";
+		gpio-hog;
+	};
+
+	wwan-wake-n-hog {
+		gpios = <RK_PB2 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "M.2 B-key WoWWAN#";
+		gpio-hog;
+	};
+};
+
+&pcie30phy {
+	data-lanes = <1 1 2 2>;
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3x2_rst>;
+	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pcie3x4 {
+	num-lanes = <2>;
+};
+
+&pinctrl {
+	wwan {
+		wwan_power_en: wwan-pwr-en {
+			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3x2_rst: pcie3x2-rst {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};
-- 
2.49.0

