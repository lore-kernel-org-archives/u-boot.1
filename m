Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE56C47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7596487D4B;
	Fri, 26 Jan 2024 23:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T+Ubi1nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FEB87D64; Fri, 26 Jan 2024 23:15:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330B187D72
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706307341; bh=p5Ba33SMuztIpF4S3TGNSzkSUMlltRRkCGnZbTw8sd0=;
 b=T+Ubi1nxBZ+awABJiC57Eg2oNi2Kckh949AnyLTRGgL6MR1jTbkgPSvfcSgxOeExsGQqPsGiw
 cCqYc9+FiYKn0O78b4FLPFo0k2Sn77ftHbmhw5oNYn5BcaQsElm1ni/UsjkD28PE1haBTkVhbQn
 7U8ftwE9xAlOiq8v0iE3fBg1jwA+gbhE88t0W6nmxgSeu5EIMdyjWPRGWWpsEyM1RKpXRIDupB7
 esxHt/aM8PfAIIe7h9/Aoc6HfD0WZbN2PXlihF6o0jA62hJohu88H+/v0BAnNbcOOrLKJrbveTT
 wuE7fZz0qHGdDKvEJt1q1USDTW8aTViymZTMNKqiUCVA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tom
 Fitzhenry <tom@tom-fitzhenry.me.uk>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH 6/7] rockchip: rk3588: Add default u-boot,spl-boot-order prop
Date: Fri, 26 Jan 2024 22:14:54 +0000
Message-ID: <20240126221508.4093334-7-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65b42f0d0365e20062645646
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

Add a default u-boot,spl-boot-order prop to rk3588s-u-boot.dtsi and
remove the prop from board u-boot.dtsi files using the default value.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi       | 6 ------
 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi | 6 ------
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi     | 6 ------
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi         | 4 ----
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi      | 6 ------
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi        | 6 ------
 arch/arm/dts/rk3588s-u-boot.dtsi                | 4 ++++
 7 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 87831c9d432a..60494bb8485f 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -6,12 +6,6 @@
 
 #include "rk3588-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-};
-
 &fspim1_pins {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
index b0f5c667197c..5d5fa6ffb214 100644
--- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
@@ -2,12 +2,6 @@
 
 #include "rk3588-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-};
-
 &fspim1_pins {
 	bootph-all;
 };
diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
index 191ec988c459..7b937943a53c 100644
--- a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
@@ -4,9 +4,3 @@
  */
 
 #include "rk3588-u-boot.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-};
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 5fa20cecc044..e99e60185ebe 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -7,10 +7,6 @@
 #include <dt-bindings/usb/pd.h>
 
 / {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index 06c6f327c14b..e791b572b6bf 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -6,12 +6,6 @@
 
 #include "rk3588-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
index 584476f77b13..9a6a353088df 100644
--- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
@@ -5,12 +5,6 @@
 
 #include "rk3588s-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index d251a210b313..945b2d62a75e 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -10,6 +10,10 @@
 		spi5 = &sfc;
 	};
 
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+	};
+
 	dmc {
 		compatible = "rockchip,rk3588-dmc";
 		bootph-all;
-- 
2.43.0

