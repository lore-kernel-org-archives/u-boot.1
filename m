Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D69E71D3A
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A9D86EF0;
	Fri, 29 Sep 2023 15:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fm0oM74t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234F686EF8; Fri, 29 Sep 2023 15:47:09 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D579C86EF0
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BDFA7CE2398;
 Fri, 29 Sep 2023 13:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE11C433C8;
 Fri, 29 Sep 2023 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995224;
 bh=WLpGeqb65OLkqIq4YyOTyJ64mHLi3LNQE6KQzzj1EeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fm0oM74tk+2P4oNXCnBRUE9ukgVPbnvHNs/wvzsz9kKaPmMurjz8IGKdEbN1U3atj
 vI4chGu/QTXMbm3KfkeS93uZzDbW8cWYYd4LT5q8/nkNHBEY+DsAeuwJxrQzHWku7n
 JtKTHuyalrq8PBEqzhybmgJ+l5q+9Q6u/dnfVF6Z9iLE7Msrlmvqigw73+bStV4q2F
 qYeKyPz0TmC7UAMgKW6OIS/Lg4bcraeKxDZuvnVYG+ZYnfg2TcbkcI71CLZhpR4Lpe
 Q+W9YVe+6ARrdczNUIJTCELx5JL4X1L66XtYvFXVg6IhawgeuCzFMgOCInTpJb9rvO
 LlbCuUIrUeXZA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/6] arm: dts: k3-am642-sk: Fix boot
Date: Fri, 29 Sep 2023 16:46:43 +0300
Message-Id: <20230929134646.214781-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929134646.214781-1-rogerq@kernel.org>
References: <20230929134646.214781-1-rogerq@kernel.org>
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

Since commit [1] A53 u-boot proper is broken.
This is because nodes marked as 'bootph-pre-ram' are
not available at u-boot proper before relocation.

To fix this we mark all nodes in sk-u-boot.dtsi as
'bootph-all'.

Move cbass_mcu node to -r5-sk.dts as it is only required
for R5 SPL.

[1]
9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-r5-sk.dts      |  4 ++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi | 76 +++++++++++++---------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index def4622ff1..daa483a781 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -53,6 +53,10 @@
 	bootph-pre-ram;
 };
 
+&cbass_mcu {
+	bootph-pre-ram;
+};
+
 &mcu_esm {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index c277ef8aba..5599977f6c 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -11,129 +11,125 @@
 	};
 
 	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &cbass_main{
-	bootph-pre-ram;
-};
-
-&cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_timer0 {
-	bootph-pre-ram;
+	bootph-all;
 	clock-frequency = <200000000>;
 };
 
 &main_conf {
-	bootph-pre-ram;
+	bootph-all;
 	chipid@14 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_i2c0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &dmss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &k3_pds {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_clks {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_reset {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci0 {
 	status = "disabled";
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g {
-	bootph-pre-ram;
+	bootph-all;
 
 	ethernet-ports {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &cpsw_port2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_bcdma {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_pktdma {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &rgmii1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &rgmii2_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mdio1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g_phy1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_usb0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &serdes_ln_ctrl {
@@ -141,25 +137,25 @@
 };
 
 &usbss0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &serdes_wiz0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &serdes0_usb_link {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &serdes0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &serdes_refclk {
-	bootph-pre-ram;
+	bootph-all;
 };
-- 
2.34.1

