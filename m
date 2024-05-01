Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B20C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 19:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9B6882E9;
	Wed,  1 May 2024 21:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="S0szFbuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB06882E5; Wed,  1 May 2024 21:21:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D22E882DF
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 21:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714591293;
 bh=7zYJDvcVgbRyAVWJO8yOD89GGBfslPE5aekzHQ+ySRY=;
 b=S0szFbuUYUj0YrxB2vswggbBG919uDmr8obDjlGwFCY8ohEvVeQucfo7htuCuaa8TXqemw+iw
 q8fWNIGlF4/wDSEcr+m49l/totxubhS5Rd09vvSr+Ag88NYR886+QX7XBZddTXCp+ISuIrM+Q/F
 3vXnzVJUTl/cC4zVdgnyS/UPJXb7Iyu3+QNn29ML85m0qKiAW+NlDdxfQv9PW689nGQyXR+nzjL
 knQH5QQM0ngQfafK3DdVHNuVRyJSVvK8eRIWeXkOS9+TEXFUSK2Kwo98/15oSbv0DR14O4ORm/T
 b5DS/RhuGI+I9UfxbuUwXCztZhij81KDJDIpZQrVWoXg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 David Bauer <mail@david-bauer.net>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Tianling Shen
 <cnsztl@gmail.com>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3328: Add missing bootph-some-ram props
Date: Wed,  1 May 2024 19:21:24 +0000
Message-ID: <20240501192127.962261-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6632963c4c2a88c85b8058e0
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

Add bootph-some-ram props to pinctrl nodes related to eMMC, SD-card and
SPI flash to match e.g. RK3308 and RK3399.

Also adjust bootph props for sdio_vcc_pin, pinctrl and uart2m1_xfer.

Fixes: 1e21f5693045 ("rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This has been runtime tested on a Rock64 and NanoPi R2S Plus.

The uart2m1_xfer change help speed up boot by around 100 ms.
---
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  2 +-
 .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  7 ++++---
 .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  7 ++++---
 arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  7 ++++---
 arch/arm/dts/rk3328-u-boot.dtsi               | 20 +++++++++++++++----
 5 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
index 4fa170eeaf8d..d8c79600b659 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
@@ -12,7 +12,7 @@
 };
 
 &sdio_vcc_pin {
-	bootph-all;
+	bootph-pre-ram;
 };
 
 &usb20_otg {
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index 0a9423cd9c7e..b50c1332b836 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -8,9 +8,6 @@
 #include "rk3328-sdram-lpddr3-666.dtsi"
 
 &spi0 {
-	bootph-pre-ram;
-	bootph-some-ram;
-
 	flash@0 {
 		bootph-pre-ram;
 		bootph-some-ram;
@@ -19,18 +16,22 @@
 
 &spi0m2_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_cs0 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_rx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_tx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &usb20_otg {
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 1096821fc5d3..8ae003bbefd1 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -8,9 +8,6 @@
 #include "rk3328-sdram-ddr4-666.dtsi"
 
 &spi0 {
-	bootph-pre-ram;
-	bootph-some-ram;
-
 	flash@0 {
 		bootph-pre-ram;
 		bootph-some-ram;
@@ -19,18 +16,22 @@
 
 &spi0m2_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_cs0 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_rx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_tx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &usb20_otg {
diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
index 551cff6f24f6..22f128090f84 100644
--- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
@@ -30,9 +30,6 @@
 };
 
 &spi0 {
-	bootph-pre-ram;
-	bootph-some-ram;
-
 	flash@0 {
 		bootph-pre-ram;
 		bootph-some-ram;
@@ -41,18 +38,22 @@
 
 &spi0m2_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_cs0 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_rx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &spi0m2_tx {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &usb20_otg {
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index d3608bd0e2b2..0135bc08d491 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -17,7 +17,6 @@
 	};
 
 	dmc: dmc {
-		bootph-all;
 		compatible = "rockchip,rk3328-dmc";
 		reg = <0x0 0xff400000 0x0 0x1000
 		       0x0 0xff780000 0x0 0x3000
@@ -25,6 +24,7 @@
 		       0x0 0xff440000 0x0 0x1000
 		       0x0 0xff720000 0x0 0x1000
 		       0x0 0xff798000 0x0 0x1000>;
+		bootph-all;
 	};
 };
 
@@ -42,14 +42,17 @@
 
 &emmc_bus8 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &emmc_cmd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio0 {
@@ -66,10 +69,12 @@
 
 &pcfg_pull_none_8ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_none_12ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up {
@@ -78,19 +83,21 @@
 
 &pcfg_pull_up_4ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up_8ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pcfg_pull_up_12ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl {
-	bootph-pre-ram;
-	bootph-some-ram;
+	bootph-all;
 };
 
 &sdmmc {
@@ -103,18 +110,22 @@
 
 &sdmmc0_bus4 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_cmd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0_dectn {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc0m1_pin {
@@ -127,7 +138,8 @@
 };
 
 &uart2m1_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vop {
-- 
2.43.2

