Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265CFC4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82CC80517;
	Sun, 19 Jul 2026 03:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B9880398; Sun, 19 Jul 2026 03:53:04 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3098380517
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGiC-000000001n4-0sFh; Sun, 19 Jul 2026 01:53:00 +0000
Date: Sun, 19 Jul 2026 02:52:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: [PATCH] arm: dts: rk3568-nanopi-r5s: drop eMMC HS400 modes from the
 U-Boot FDT
Message-ID: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

U-Boot passes its control FDT to Linux, so the &sdhci override adding
mmc-hs400-1_8v and mmc-hs400-enhanced-strobe reached the kernel, which
unlike U-Boot actually drives those modes and then failed on the eMMC.
Keep HS200, which works, and leave HS400 out. Affects the R5C too, which
includes this dtsi.

Fixes: 0ef326b5e92e ("rockchip: rk3568: Add support for FriendlyARM NanoPi R5S")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
index 64c43374c04..7e0b2ba02e4 100644
--- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
@@ -15,8 +15,6 @@
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 };
 

base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0
