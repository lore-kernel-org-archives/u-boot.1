Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC91C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A2784A30;
	Fri, 10 Jul 2026 12:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fGpa0gbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A611684119; Fri, 10 Jul 2026 12:05:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5C38341A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783677935; bh=OWswgRkxK/G0Dcr61lTo7PG7kb8TwvpSZfT3Ffi29kI=;
 b=fGpa0gbMrYVoiAE4ByPCy8fRnphaDia/pdIw35E5RiEHOAK4EsfK9n696Gt6TciyUGgsxWQVG
 h7caWceYxnSJRJx7okctXkiJ7o7dP/hRYpAwU534DOzabGzRej2okAXrhDS5DL3Yj+XFgZneRVX
 xDeGta7C5hTqu9ZcMI1wRZA7thKxKq7SrWkqaeYQSpKpvtD9VQcfu6hLqY6t1D0ywFYPnXObLqb
 jnYL70XJQPt543JwamYgEhcce9oBFLqkFrhDQxAK2GRXHQ2rZ/AjMqAxNDoHWBBIouHhxdSq1/w
 eizqiSLD1E83X0jTM0qua4xjZnggXxXLLutBsRrSvviw==
X-Forward-Email-ID: 6a50c3ef28378fa077a39572
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/7] arm64: dts: rockchip: Enable USB ports on Radxa ROCK 2A/2F
Date: Fri, 10 Jul 2026 10:05:16 +0000
Message-ID: <20260710100521.3677247-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710100521.3677247-1-jonas@kwiboo.se>
References: <20260710100521.3677247-1-jonas@kwiboo.se>
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

The ROCK 2A has three USB 2.0 Type-A HOST ports behind an onboard
USB hub, and one USB 3.0 Type-A port.

And the ROCK 2F has two USB 2.0 Type-A HOST ports behind an onboard
USB hub, and one USB 2.0 Type-C OTG port.

Add support for using the USB ports on Radxa ROCK 2A/2F.

The onboard USB hub handles OHCI so only the EHCI controller is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260529190355.4148175-4-heiko@sntech.de

[ upstream commit: 4e55d52f5f3b333a9ff5103099df97291aaeb083 ]

(cherry picked from commit dd0101f77912adbf6ed95168a215f4eeceebf241)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3528-rock-2.dtsi       | 17 +++++++++++++++++
 .../src/arm64/rockchip/rk3528-rock-2a.dts       | 11 +++++++++++
 .../src/arm64/rockchip/rk3528-rock-2f.dts       | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi b/dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi
index aedc7ee9ee46..501a91f4c23e 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi
@@ -166,6 +166,10 @@
 	};
 };
 
+&combphy {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -291,3 +295,16 @@
 	pinctrl-0 = <&uart0m0_xfer>;
 	status = "okay";
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	phy-supply = <&vcc5v0_usb20>;
+	status = "okay";
+};
diff --git a/dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts b/dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts
index 0b696d49b71f..5e17ec2758d5 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts
@@ -79,3 +79,14 @@
 		};
 	};
 };
+
+&usb_host0_xhci {
+	dr_mode = "host";
+	extcon = <&usb2phy>;
+	status = "okay";
+};
+
+&usb2phy_otg {
+	phy-supply = <&vcc5v0_usb30_otg>;
+	status = "okay";
+};
diff --git a/dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts b/dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts
index 3e2b9b685cb2..f2b021ff5046 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts
@@ -8,3 +8,15 @@
 	model = "Radxa ROCK 2F";
 	compatible = "radxa,rock-2f", "rockchip,rk3528";
 };
+
+&usb_host0_xhci {
+	extcon = <&usb2phy>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};
-- 
2.54.0

