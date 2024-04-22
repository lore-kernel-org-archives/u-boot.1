Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A5AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94286883AF;
	Mon, 22 Apr 2024 08:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yLSduMkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75552883B9; Mon, 22 Apr 2024 08:31:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96308839E
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767462; bh=PnEHMN0Krzg9htcCecsw9P2DBfLPvl6BAuvz5C3YQyg=;
 b=yLSduMkKw3MwsBckuG6MpCgp1bh8joE8wFObPxBgfvABS02L4XKj38HCPJyLJEYbQ4QTDHHwC
 2nnr61T3JWji/Pl5Ovy2NUmK3bHharE1SJcBlhr0ECnql0yX0pY4ZM0yTydHPpUD7HEpPJeITwi
 olp9GuOu7XW0YFC1kDSutfxEyJhU/rX+XiH5NSkmBk7CH6zIOyV23D4ta283vDO9G7jccSKZxfd
 lh5iUbKP3Rm8wb0+SIDOmhKkeM4Ourk7BgYFDMBMhJuk0unOXoV5FfmdLWqrzI9DFVhXlEyAQhH
 KzgYrRXAkJTPd+AumL0ydUYy8krXDdfUL1mEg0cMQmiA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 23/28] rockchip: rk356x-generic: Fix eMMC and SD-card
 pinctrl
Date: Mon, 22 Apr 2024 06:29:00 +0000
Message-ID: <20240422062936.681359-24-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626042634ba165ad447444a
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

Add missing emmc_datastrobe and sdmmc0_det pinctrl to fix possible issue
reading from eMMC or SD-card. Also use correct node for mmc1 alias.

Fixes: 683f61a13f16 ("rockchip: board: Add minimal generic RK3566/RK3568 board")
Fixes: 363cbd578169 ("rockchip: rk3568-generic: Enable eMMC HS200 mode")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: Split patch
---
 arch/arm/dts/rk3568-generic.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
index 88eb1bfd2aab..3b9bf8052046 100644
--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -12,7 +12,7 @@
 
 	aliases {
 		mmc0 = &sdhci;
-		mmc1 = &sdmmc;
+		mmc1 = &sdmmc0;
 	};
 
 	chosen {
@@ -28,7 +28,7 @@
 	no-sdio;
 	non-removable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 	status = "okay";
 };
 
@@ -39,7 +39,7 @@
 	no-mmc;
 	no-sdio;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
 	status = "okay";
 };
 
-- 
2.43.2

