Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DCCC47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6E787D4D;
	Fri, 26 Jan 2024 23:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="A6KD0fAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA8587D4D; Fri, 26 Jan 2024 23:15:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE2387D40
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706307324; bh=SzloocALSiwkRmDaBKRD5urGEB5FhDG/S2+GcY/8ZMA=;
 b=A6KD0fADEePgrdMjrnwzFmSmubr790divhfzKzFkoiZv0EnlXYJZ7Cwy5e977avOE0qoCGje4
 BVIpEqGTn+y/IHHNWN4Vgo2bDJohtCDu6VBN19lK1r4V5xwovrGc5wCFn30AL/gbDxOYCe1mynd
 ZpIdspWrwS5AeaPMB6Fmb4sK+SUqd+b0CrtMMgC4FgacuSBeGFQMNf+D+yDPi7aJIcTx+BBQyI+
 eFtSOS8+cTsHCp8aFAj2FqNAIs7M4kj/yzvaCAUxlqjiWy9GLHz0bZXrwQ9TJyNPDc83ekVIM7t
 by6SGnz/ukHFDp2fMCl6NdK00E9CRB3wToBiJl2Qxtxg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/7] rockchip: rk356x: Sync device tree from linux v6.8-rc1
Date: Fri, 26 Jan 2024 22:14:50 +0000
Message-ID: <20240126221508.4093334-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126221508.4093334-1-jonas@kwiboo.se>
References: <20240126221508.4093334-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b42efb0365e200626455f7
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

Sync rk356x device tree from linux v6.8-rc1.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3566-quartz64-a.dts       | 5 +++--
 arch/arm/dts/rk3566-radxa-cm3-io.dts     | 1 +
 arch/arm/dts/rk3566-soquartz-blade.dts   | 4 ++++
 arch/arm/dts/rk3566-soquartz-cm4.dts     | 4 ++++
 arch/arm/dts/rk3566-soquartz-model-a.dts | 4 ++++
 arch/arm/dts/rk3566-soquartz.dtsi        | 1 -
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3566-quartz64-a.dts b/arch/arm/dts/rk3566-quartz64-a.dts
index 854d02b46e6f..59843a7a199c 100644
--- a/arch/arm/dts/rk3566-quartz64-a.dts
+++ b/arch/arm/dts/rk3566-quartz64-a.dts
@@ -31,8 +31,9 @@
 	fan: gpio_fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <0    0
-				      4500 1>;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<4500 1>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&fan_en_h>;
 		#cooling-cells = <2>;
diff --git a/arch/arm/dts/rk3566-radxa-cm3-io.dts b/arch/arm/dts/rk3566-radxa-cm3-io.dts
index 1b1c67d5b1ef..3ae24e39450a 100644
--- a/arch/arm/dts/rk3566-radxa-cm3-io.dts
+++ b/arch/arm/dts/rk3566-radxa-cm3-io.dts
@@ -14,6 +14,7 @@
 	compatible = "radxa,cm3-io", "radxa,cm3", "rockchip,rk3566";
 
 	aliases {
+		ethernet0 = &gmac1;
 		mmc1 = &sdmmc0;
 	};
 
diff --git a/arch/arm/dts/rk3566-soquartz-blade.dts b/arch/arm/dts/rk3566-soquartz-blade.dts
index 4e49bebf548b..fdbf1c783242 100644
--- a/arch/arm/dts/rk3566-soquartz-blade.dts
+++ b/arch/arm/dts/rk3566-soquartz-blade.dts
@@ -13,6 +13,10 @@
 	model = "PINE64 RK3566 SOQuartz on Blade carrier board";
 	compatible = "pine64,soquartz-blade", "pine64,soquartz", "rockchip,rk3566";
 
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
 	/* labeled VCC3V0_SD in schematic to not conflict with PMIC regulator */
 	vcc3v0_sd: vcc3v0-sd-regulator {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/dts/rk3566-soquartz-cm4.dts b/arch/arm/dts/rk3566-soquartz-cm4.dts
index cddf6cd2fecb..6ed3fa4aee34 100644
--- a/arch/arm/dts/rk3566-soquartz-cm4.dts
+++ b/arch/arm/dts/rk3566-soquartz-cm4.dts
@@ -8,6 +8,10 @@
 	model = "Pine64 RK3566 SoQuartz with CM4-IO Carrier Board";
 	compatible = "pine64,soquartz-cm4io", "pine64,soquartz", "rockchip,rk3566";
 
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
 	/* labeled +12v in schematic */
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/dts/rk3566-soquartz-model-a.dts b/arch/arm/dts/rk3566-soquartz-model-a.dts
index 2208dbfb7f0a..f2095dfa4eaf 100644
--- a/arch/arm/dts/rk3566-soquartz-model-a.dts
+++ b/arch/arm/dts/rk3566-soquartz-model-a.dts
@@ -8,6 +8,10 @@
 	model = "PINE64 RK3566 SOQuartz on Model A carrier board";
 	compatible = "pine64,soquartz-model-a", "pine64,soquartz", "rockchip,rk3566";
 
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
 	/* labeled DCIN_12V in schematic */
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/dts/rk3566-soquartz.dtsi b/arch/arm/dts/rk3566-soquartz.dtsi
index 63bae36b8f7e..bfb7b952f4c5 100644
--- a/arch/arm/dts/rk3566-soquartz.dtsi
+++ b/arch/arm/dts/rk3566-soquartz.dtsi
@@ -12,7 +12,6 @@
 	compatible = "pine64,soquartz", "rockchip,rk3566";
 
 	aliases {
-		ethernet0 = &gmac1;
 		mmc0 = &sdmmc0;
 		mmc1 = &sdhci;
 		mmc2 = &sdmmc1;
-- 
2.43.0

