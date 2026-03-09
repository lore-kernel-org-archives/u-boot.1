Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAFAFCA192
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11F983BC8;
	Mon,  9 Mar 2026 22:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TUkwc6V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A7A83F20; Mon,  9 Mar 2026 22:37:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D44C83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1773092239;
 bh=eX1S3JzJ+Cg/bw8qDPecazT0YR4VzM59FmD4E0opmAk=;
 b=TUkwc6V1RT6inrlQ4nYiLRd8a505Bb6MKJt9NjiQrU/WBx01/9QuOfkjBCWc0PUdovFzZlA40
 HcWzJ+JXN1l1jMxYEDcCECHy6+YFHJpXWvSY7IPaJdCmaeR3+TZouHMjT6xbs7R8W+MhrthWSgw
 qh06DPd1RTdSvOjAfeNzm80VWf+Eeb7jsi+0O2b2aCufqhoLznd85GCthWOHpCuQjfhIPXqYMsw
 m25IFKgNzimKTnOU5JW6els93m0uRFN5Dg2OS9eHH2bHpKVXLDuQTVl/ZuVANjrSQXImdqQ0ObY
 DYTDMm/97tfvAxfPD+2WMxzBfRX3Z/601cNY7Ucvhv4w==
X-Forward-Email-ID: 69af3d8876762a90c7fa47b2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v2] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
Date: Mon,  9 Mar 2026 21:37:06 +0000
Message-ID: <20260309213708.535186-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
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

The commit 12049db76437 ("rockchip: rk3588-rock-5b: Add USB-C controller
to u-boot.dtsi") added the USB-C controller node to the ROCK 5B board
u-boot.dtsi, this and related usb nodes are now part of upstream DT.

Remove the upstream USB-C controller related DT nodes from u-boot.dtsi,
including the temporary used dr_mode and maximum-speed props of the
usb_host0_xhci node. Only usbc0 status = "okay" is kept ensuring USB-C
power delivery continues to work as intended.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v2:
- Update commit message to mention the intended removal of the temporary
  used dr_mode and maximum-speed props
- Collect r-b tags
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 43 +------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index e07b549c767f..ddc177344ebd 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -19,33 +19,6 @@
 	bootph-some-ram;
 };
 
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c4m1_xfer>;
-	status = "okay";
-
-	usbc0: usb-typec@22 {
-		compatible = "fcs,fusb302";
-		reg = <0x22>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		usb_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			data-role = "dual";
-			power-role = "sink";
-			try-power-role = "sink";
-			op-sink-microwatt = <1000000>;
-			sink-pdos =
-				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
-				<PDO_VAR(5000, 20000, 5000)>;
-		};
-	};
-};
-
 &saradc {
 	bootph-pre-ram;
 	vdd-microvolts = <1800000>;
@@ -63,20 +36,6 @@
 	};
 };
 
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
+&usbc0 {
 	status = "okay";
 };
-- 
2.53.0

