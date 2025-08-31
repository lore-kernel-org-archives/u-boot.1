Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA16CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1CF83965;
	Sun, 31 Aug 2025 13:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YW7lFbQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B71B83929; Sun, 31 Aug 2025 13:21:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821D483966
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639292; bh=cFnPnlwQOh343SqXyUn2C+hZwibJ2gCgru4Y91Dl94M=;
 b=YW7lFbQ6dMkEFVh99IWaJ4RmK4TblFGqnMiI+jJhfG6ZcLBarqOuZzxdowIzFaWUzbM1rScPW
 T0R7MU0QjudiVOin+wGPMyxzXJnry/VEHixsKeZE/nCmsAZwRsXYHOJSmeWdntxdGhGte94wqin
 viTIzEmNU3mOC3fk2YQRmqv4VkqRRZOTS22narAkdNqa8GsnweUayFIk2C1RmdmcHR6RsEU2O2M
 llUaODwk1e6xk20H9PzfKzDDfVJOg7IN34srZpM2D3mwgNGX/IoLoeLhdCuCT2m+qWOSJHlSohT
 tt2/TvLIv2+yC/ASRW3RoNAGkOmYrDrToF+PKoeVItKQ==
X-Forward-Email-ID: 68b4303a32f03f9a5e9086e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 08/10] arm64: dts: rockchip: adjust dcin regulator on ROCK
 4D
Date: Sun, 31 Aug 2025 11:20:29 +0000
Message-ID: <20250831112046.2642363-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The ROCK 4D's actual DC input is 5V, and the schematic names it as being
5V as well.

Rename the regulator, and change the voltage it claims to be at.
Furthermore, fix vcc_1v1_nldo_s3's vin-supply as coming from
vcc_5v0_sys, and not the DCIN, as per the schematic. This makes no
functional change; both regulators are always on, and one feeds into the
other.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20250630-rock4d-reg-usb-wifi-v1-1-1057f412d98c@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 9a625a284bfdb902f27f2949063731d189adda3c ]

(cherry picked from commit ac5675c9dfaebe141256577306a0a455e481048a)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
index 62712c90c83d..ee0822cd4f35 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
@@ -57,13 +57,13 @@
 		};
 	};
 
-	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
+	vcc_5v0_dcin: regulator-vcc-5v0-dcin {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-		regulator-name = "vcc_12v0_dcin";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_dcin";
 	};
 
 	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
@@ -166,7 +166,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-name = "vcc_5v0_device";
-		vin-supply = <&vcc_12v0_dcin>;
+		vin-supply = <&vcc_5v0_sys>;
 	};
 
 	vcc_5v0_host: regulator-vcc-5v0-host {
@@ -190,7 +190,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-name = "vcc_5v0_sys";
-		vin-supply = <&vcc_12v0_dcin>;
+		vin-supply = <&vcc_5v0_dcin>;
 	};
 };
 
-- 
2.51.0

