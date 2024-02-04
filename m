Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8898FC48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 20:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B328487C2B;
	Sun,  4 Feb 2024 21:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ua4hc2vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957BE87BA8; Sun,  4 Feb 2024 21:53:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31A687C3E
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 21:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbd4=JO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707080003; bh=R42VwSVQ1JTeZMBoCE5Ky2ToQxF1K4ax5bpRIJ/qlaI=;
 b=ua4hc2vgRItwLpVIgewh1u7NnH5I9/xuyiZdQ45y21cAbSgndUjlq/axU/xgMJY+xd4ga9QtX
 4fJIi8dnPZ1b0l0sUMT64B55IbALH+J2otoGHyrLQIwEsDOo8jR0j34UFYunMWMs8Vrm6VAE4RJ
 +q+vSmc2DDzHvRxO9pR4GAfEhEFmKk42UxIjhLKQSwgaUlTKLnq0tgt8xbtO1DfRNs/bVKW90iv
 p+aW7lVA49VY8dKzDHW5npGaSsSgYuzAcM1ydgadayxPnFnp5Ul7DGsZRQfhhx0ESa+j2dVjEuH
 jSRNxnMOufNVJ9Pk/33Cov1uuoX+2GwV869J0uIbojCQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, Andy Yan
 <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Weizhao Ouyang
 <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Date: Sun,  4 Feb 2024 20:53:05 +0000
Message-ID: <20240204205312.2342868-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204205312.2342868-1-jonas@kwiboo.se>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bff9426f7b756870de38f3
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

Testing has shown that writing to eMMC using DDR52 mode does not seem to
work on RK356x and RK3588 boards.

A simple test of writing a single block to e.g. sector 0x4000 fails:

  # Rescan using DDR52 mode
  => mmc rescan 4

  # Write a single block to sector 0x4000 fails with ERROR
  => mmc write 20000000 4000 1

With the MMC_SPEED_MODE_SET Kconfig option enabled.

Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in affected
board u-boot.dtsi files.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Update commit message

Link to v1: https://patchwork.ozlabs.org/patch/1891695/
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

