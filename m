Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D12C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 23:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1209587DC3;
	Sat, 27 Jan 2024 00:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yazMnN6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CEB87DCB; Sat, 27 Jan 2024 00:27:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2376087DAE
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706311586; bh=3Oy5ammFIyfpTAXzKwBNyjYbTWcNZXyMrcJK+vg2uEE=;
 b=yazMnN6TeVQ7xbRcK4bagvNILVU+9yiXsMoOeL/Ybx+DR6Jr+Myhdf2blPbZDc3crvJgSd+gx
 cS/UYjJY2vBP9DR/KmAG2EG57AN7OqYdvb2H3TMEXazkS33DpuXDbNQwvvnqLMHZ+cHNu0enZXV
 RbZQu/RXPHSkgwQk97d248VHthi8rpb3R2O4ebYe4/KPw1fgihC8ZaZocnnxlcFjWbVf1uTi3e6
 64qfpqlmLZX/hDnHKmQtqGDDo2OMS4fNmZuYDIM+vApRvqilgotuzLewqhMjU5YsT0uC76kTZk1
 /FtG4NtxDm30GOO7cEurwVsUIhkzuvK8ktwSZrB5FgEg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>, Andy Yan
 <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Date: Fri, 26 Jan 2024 23:26:07 +0000
Message-ID: <20240126232615.6826-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232615.6826-1-jonas@kwiboo.se>
References: <20240126232615.6826-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65b43fa159c89db01a285fec
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

Writing to eMMC using DDR52 mode does not work reliably or at all on
RK356x and RK3588 boards.

Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
 arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
 arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
 12 files changed, 12 deletions(-)

diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
index 11976fd3a6e0..930d660868bb 100644
--- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
@@ -8,7 +8,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 };
diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
index 8de9d1535efb..c235b4357f7d 100644
--- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
@@ -4,7 +4,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 };
diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
index 158f652cb3b1..e0e501deccfe 100644
--- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
@@ -7,5 +7,4 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 };
diff --git a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
index f65f4067f3e9..5e46a2422d60 100644
--- a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
@@ -4,7 +4,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
 };
diff --git a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
index a44ac35bdacd..1597473017ed 100644
--- a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
@@ -8,7 +8,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
index 62f572c4cf9f..64c43374c042 100644
--- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
@@ -14,7 +14,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
index ecba91aa30f5..1fc71faa9e07 100644
--- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
@@ -8,7 +8,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
index caf524443079..74755a44eaee 100644
--- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
@@ -16,7 +16,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
index 46ebb77283f1..5b823fcca5fb 100644
--- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
@@ -20,7 +20,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	mmc-hs400-enhanced-strobe;
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index e99e60185ebe..9ee9dd051e32 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -31,7 +31,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 };
 
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index 471508a9ed74..ca2a684f3541 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -8,7 +8,6 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 };
 
diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
index 9a6a353088df..efba0c359ba5 100644
--- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
@@ -7,6 +7,5 @@
 
 &sdhci {
 	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 };
-- 
2.43.0

