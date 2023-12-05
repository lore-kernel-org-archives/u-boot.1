Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D806AC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 01:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245DA87635;
	Tue,  5 Dec 2023 02:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E7C87640; Tue,  5 Dec 2023 02:24:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C7C84875F5
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 02:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F29071474;
 Mon,  4 Dec 2023 17:24:46 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201583F5A1;
 Mon,  4 Dec 2023 17:23:59 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-sunxi@lists.linux.dev, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] sunxi: dts: arm64: update emac for Orange Pi Zero 3
Date: Tue,  5 Dec 2023 01:22:28 +0000
Message-Id: <20231205012228.4256-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

From: Chukun Pan <amadeus@jmu.edu.cn>

The current emac setting is not suitable for Orange Pi Zero 3,
move it back to Orange Pi Zero 2 DT. Also update phy mode and
delay values for emac on Orange Pi Zero 3.
With these changes, Ethernet now looks stable.

Fixes: 95c3b0635ea4 ("sunxi: dts: arm64: update devicetree files from Linux-v6.6-rc6")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Hi,

this is a port of the corresponding Linux patch, that fixes Ethernet
on that board. The patch is in Linux' sunxi/fixes-for-6.7 queue,
awaiting a merge anytime soon.
For me this indeed fixes Ethernet operation in U-Boot on that board.

Cheers,
Andre

 arch/arm/dts/sun50i-h616-orangepi-zero.dtsi | 3 ---
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts | 3 +++
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/sun50i-h616-orangepi-zero.dtsi b/arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
index 15290e6892f..fc7315b9440 100644
--- a/arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm/dts/sun50i-h616-orangepi-zero.dtsi
@@ -68,10 +68,7 @@
 &emac0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ext_rgmii_pins>;
-	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
-	allwinner,rx-delay-ps = <3100>;
-	allwinner,tx-delay-ps = <700>;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/sun50i-h616-orangepi-zero2.dts b/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
index d83852e72f0..b5d713926a3 100644
--- a/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
@@ -13,6 +13,9 @@
 };
 
 &emac0 {
+	allwinner,rx-delay-ps = <3100>;
+	allwinner,tx-delay-ps = <700>;
+	phy-mode = "rgmii";
 	phy-supply = <&reg_dcdce>;
 };
 
diff --git a/arch/arm/dts/sun50i-h618-orangepi-zero3.dts b/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
index 00fe28caac9..b3b1b869212 100644
--- a/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
@@ -13,6 +13,8 @@
 };
 
 &emac0 {
+	allwinner,tx-delay-ps = <700>;
+	phy-mode = "rgmii-rxid";
 	phy-supply = <&reg_dldo1>;
 };
 
-- 
2.35.8

