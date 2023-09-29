Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6296E71D38
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0EAE86EE5;
	Fri, 29 Sep 2023 15:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KkkRe6gV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1840B86EEE; Fri, 29 Sep 2023 15:47:03 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33DD86EEB
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 47EFDCE2437;
 Fri, 29 Sep 2023 13:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE7C433C8;
 Fri, 29 Sep 2023 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995217;
 bh=LA/2huYaA28ScN8knlFExrCUa+ErInfUW08PAsDONQg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KkkRe6gVgcTxjptfWdF1iSm1YQdkyShlVY9MRpXo8ixlUBTxyHDiAnEJtcTFQlxsn
 QjiDURDrjCkZDADCi09/YT0FMdMFbLhRZubvSFQc0kl6V07QoSZscTYjRFk1nn2cE4
 Cqp8I4A2bIWqjWP4c9DkcTaQqanx4JwLq7DJRVS4CTl9zwVEhrIfQ+FivPbvtRlbE6
 hatkrCZhOTUmsEK2AC05z7eZMQ+o/AYTGm5vFbeblGKZPFRc/i0+Z30geEfR20dlbY
 u/Q+iMhnslYhnO6tk+AYjbWNk8TAZDIJoHaaF1/dzDAfJA2ZW1BU0KO+v+VEYiPP3n
 /4fMan3W78nlg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/6] arm: dts: k3-am64-evm: Fix boot
Date: Fri, 29 Sep 2023 16:46:41 +0300
Message-Id: <20230929134646.214781-2-rogerq@kernel.org>
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

Move vtt_supply and cbass_mcu node to -r5-evm.dts as
it is only required for R5 SPL.

[1]
9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 56 ++++++++++++---------------
 arch/arm/dts/k3-am642-r5-evm.dts      |  8 ++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index c85f57d40f..d06955dfbc 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -11,109 +11,101 @@
 	};
 
 	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
-&vtt_supply {
-	bootph-pre-ram;
-};
-
 &cbass_main {
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
 
 &usb0 {
 	dr_mode="peripheral";
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usbss0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_mmc1_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_usb0_pins_default {
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
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw_port2 {
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 73461f8f6c..696735d8e2 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -40,6 +40,10 @@
 	};
 };
 
+&vtt_supply {
+	bootph-pre-ram;
+};
+
 &cbass_main {
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
@@ -53,6 +57,10 @@
 	bootph-pre-ram;
 };
 
+&cbass_mcu {
+	bootph-pre-ram;
+};
+
 &mcu_esm {
 	bootph-pre-ram;
 };
-- 
2.34.1

