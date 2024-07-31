Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A409C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A8F88958;
	Wed, 31 Jul 2024 08:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="N3ljpg92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D9588914; Wed, 31 Jul 2024 08:51:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2D088971
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722408663; bh=qlizyInpTVvqCXX7j7YQgwAvp0HTCMxwMJ2mks38oCo=;
 b=N3ljpg92QPSaBalHG+PrdzDJIEwRVhfk0LFuH6kXAsIeFo8ytTIq31Oge55iI934ehJV1jyk+
 j1Bjx/xg9cQlA9eVsy9qyKeuXavjvWcTFMMDocpAiFiv0jATed9mYw2io60T31ehwiH5le3XLBh
 k2RwA52CTiWCKQen5iPac+yGf5CXRaycrfO4QDHj+akt77UQgbxfBOhC87PZg9MvQCOEnQhUxcx
 YqbX/k5co7SuCClMzwX0vPMyt0ENSarEtWLOKMA2BOpa4O4bdshTcBwK/jq/6b++DwvlAAc1/8e
 O71NvWTjERwD3YVs2LreC6c5E/GqgF7BVMI+r5qZcjEw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>, Trevor Woerner <twoerner@gmail.com>, Heiko Stuebner
 <heiko@sntech.de>
Subject: [PATCH 3/5] arm64: dts: rockchip: add gpio-line-names to radxa-zero-3
Date: Wed, 31 Jul 2024 06:50:38 +0000
Message-ID: <20240731065048.1199792-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731065048.1199792-1-jonas@kwiboo.se>
References: <20240731065048.1199792-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a9ded773d983cd0923795a
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

From: Trevor Woerner <twoerner@gmail.com>

Add names to the pins of the general-purpose expansion header as given
in the Radxa documentation[1] following the conventions in the kernel[2]
to make it easier for users to correlate pins with functions when using
utilities such as 'gpioinfo'.

[1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface
[2] https://www.kernel.org/doc/Documentation/devicetree/bindings/gpio/gpio.txt

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
Link: https://lore.kernel.org/r/20240620013301.33653-1-twoerner@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: f7c742cbe664ebdedc075945e75443683d1175f7 ]

(cherry picked from commit 8b26cf42ba0c74a9c86cebe591a9195f75151d97)
---
 .../arm64/rockchip/rk3566-radxa-zero-3.dtsi   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
index 081be841b286..9cc7aa3298d0 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3566-radxa-zero-3.dtsi
@@ -105,6 +105,78 @@
 	cpu-supply = <&vdd_cpu>;
 };
 
+&gpio0 {
+	gpio-line-names =
+		/* GPIO0_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_D0 - D7 */
+		"pin-10 [GPIO0_D0]", "pin-08 [GPIO0_D1]", "",
+		"", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* GPIO1_A0 - A7 */
+		"pin-03 [GPIO1_A0]", "pin-05 [GPIO1_A1]", "",
+		"",                  "pin-37 [GPIO1_A4]", "",
+		"",                  "",
+		/* GPIO1_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* GPIO2_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* GPIO3_A0 - A7 */
+		"",                  "pin-11 [GPIO3_A1]", "pin-13 [GPIO3_A2]",
+		"pin-12 [GPIO3_A3]", "pin-35 [GPIO3_A4]", "pin-40 [GPIO3_A5]",
+		"pin-38 [GPIO3_A6]", "pin-36 [GPIO3_A7]",
+		/* GPIO3_B0 - B7 */
+		"pin-15 [GPIO3_B0]", "pin-16 [GPIO3_B1]", "pin-18 [GPIO3_B2]",
+		"pin-29 [GPIO3_B3]", "pin-31 [GPIO3_B4]", "",
+		"", "",
+		/* GPIO3_C0 - C7 */
+		"",                  "pin-22 [GPIO3_C1]", "pin-32 [GPIO3_C2]",
+		"pin-33 [GPIO3_C3]", "pin-07 [GPIO3_C4]", "",
+		"", "",
+		/* GPIO3_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		/* GPIO4_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO4_B0 - B7 */
+		"",                  "",                  "pin-27 [GPIO4_B2]",
+		"pin-28 [GPIO4_B3]", "", "", "", "",
+		/* GPIO4_C0 - C7 */
+		"",                  "",                  "pin-23 [GPIO4_C2]",
+		"pin-19 [GPIO4_C3]", "",                  "pin-21 [GPIO4_C5]",
+		"pin-24 [GPIO4_C6]", "",
+		/* GPIO4_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_npu>;
 	status = "okay";
-- 
2.45.2

