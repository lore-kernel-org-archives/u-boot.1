Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C327C3DA64
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 02:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEFB8852D;
	Mon,  5 Aug 2024 04:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0E0887F3; Mon,  5 Aug 2024 04:28:19 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A554088297
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 04:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 4752S5Ra017723; Mon, 5 Aug 2024 11:28:05 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] arm64: dts: rockchip: change spi-max-frequency for Radxa ROCK
 3C
Date: Mon,  5 Aug 2024 11:26:01 +0900
Message-ID: <20240805022601.913-1-naoki@radxa.com>
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

SPI NOR flash chip may vary, so use safe(lowest) spi-max-frequency.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Link: https://lore.kernel.org/r/20240623023329.1044-3-naoki@radxa.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 06f6dd4d607766a527e37529f2f3f90dd1464293 ]

(cherry picked from commit dd40945a1d0e28ae6eaf9da04f8e2dcebf8233ea)
---
 dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts b/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
index b242409d378..f2cc086e500 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-rock-3c.dts
@@ -633,7 +633,7 @@
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
-		spi-max-frequency = <120000000>;
+		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
 	};
-- 
2.43.0

