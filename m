Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D2C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 22:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF16088B14;
	Fri, 16 Aug 2024 00:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F0888B40; Fri, 16 Aug 2024 00:37:40 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E39D88AF8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 00:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 47FMbJ0d023468; Fri, 16 Aug 2024 07:37:19 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jonas@kwiboo.se, FUKAUMI Naoki <naoki@radxa.com>,
 Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2] arm: dts: rockchip: fix dts for Radxa ROCK 4C+
Date: Fri, 16 Aug 2024 07:37:13 +0900
Message-ID: <20240815223713.2479-1-naoki@radxa.com>
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

ROCK Pi 4 series and ROCK 4C+ cannot share .dtsi file because 4C+ is
different board.

add rk3399-rock-pi-4-u-boot.dtsi contents and remove dependency of it.

no functional change is intended.

Fixes: 71a95e2efd30 ("arm: dts: rockchip: add Radxa ROCK 4C+")
Suggested-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
Changes in v2:
- reword commit message
---
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
index 5ec15a845c1..50dae5cb5ef 100644
--- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
@@ -1,8 +1,10 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// SPDX-License-Identifier: GPL-2.0+
 /*
+ * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
  * Copyright (c) 2023 Radxa Limited
  */
-#include "rk3399-rock-pi-4-u-boot.dtsi"
+#include "rk3399-u-boot.dtsi"
+#include "rk3399-sdram-lpddr4-100.dtsi"
 
 &pcfg_pull_none_18ma {
 	bootph-pre-ram;
@@ -14,6 +16,12 @@
 	bootph-some-ram;
 };
 
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+};
+
 &spi1 {
 	status = "okay";
 
@@ -25,3 +33,7 @@
 		spi-max-frequency = <10000000>;
 	};
 };
+
+&vdd_log {
+	regulator-init-microvolt = <950000>;
+};
-- 
2.43.0

