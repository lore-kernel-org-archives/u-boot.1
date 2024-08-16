Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDE2C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0861588C08;
	Fri, 16 Aug 2024 23:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C23885F6; Fri, 16 Aug 2024 23:21:18 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BD688B23
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 47GLKtJE026500; Sat, 17 Aug 2024 06:20:55 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se, sumit.garg@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: add (but disabled) SFC node for
 Radxa ROCK 5A
Date: Sat, 17 Aug 2024 06:20:48 +0900
Message-ID: <20240816212049.500-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

This commit adds SFC node for Radxa ROCK 5A.

since sdhci and sfc on RK3588s share pins(i.e. exclusive), it cannot
be enabled both nodes at the same time. so status = "okay" is omitted
here.

you may be able to enable sfc (and disable sdhci) by fdt overlay.

SPI NOR flash chip may vary, so use safe(lowest) spi-max-frequency.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Link: https://lore.kernel.org/r/20240623023329.1044-2-naoki@radxa.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 00224650dd45e166ea6eb1593f5f064583963ccf ]

(cherry picked from commit fde218de3133705f3f56dc8eb26baa878f0e0dc9)
---
 dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
index 3b9a349362d..2e2f7f0e769 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
@@ -377,6 +377,19 @@
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim0_pins>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
-- 
2.43.0

