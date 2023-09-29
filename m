Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55374E71D37
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6349186EF2;
	Fri, 29 Sep 2023 15:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dp58cYz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CEC86EF2; Fri, 29 Sep 2023 15:47:13 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3BEE86EF2
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 75CF6B81F4D;
 Fri, 29 Sep 2023 13:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AB3C433CB;
 Fri, 29 Sep 2023 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995230;
 bh=M/cVzD9aqMSSrvfYNhTxqYUz5smOIKB5t6q94aSKemA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dp58cYz7O79XXBO383GrVfEmXg6SqU/c7oC9TY8Ub/Bk1JwmOpGorZ1UMoc8KE7K/
 FiMyg0dMPigxiOevijQqYXjiNADrz1I+dkRcOCcFJPsg/o4NlKkpdLaYuBlFtpNU6T
 2kXNzQlDh0zq9hRepmrxcpa4gGqzylD8V1QjwVmw5NHZD5ibJuBF8izqnKm4F0u6EN
 S8r+tXwKhixgVci8rlOwbvy42v1rEWz6pIN6xn3JoMz7lIGb7sA+rKgSLxGzkzktRx
 A+n4sxWReZ5Uwg1oDvliHMbNk06QfFUl2/QB5bKvp/vYKuoanmYKl8/dYDjSV3bWEQ
 OlDxJcBfwh5ZQ==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 5/6] arm: dts: k3-am625-sk: Fix boot
Date: Fri, 29 Sep 2023 16:46:45 +0300
Message-Id: <20230929134646.214781-6-rogerq@kernel.org>
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

[1]
9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 54 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index c1685bc9ca..c658506256 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -17,113 +17,113 @@
 	};
 
 	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_timer0 {
 	clock-frequency = <25000000>;
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
 
 &wkup_conf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &chipid {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_uart0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_pmx0 {
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
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ospi0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ospi0 {
-	bootph-pre-ram;
+	bootph-all;
 
 	flash@0 {
-		bootph-pre-ram;
+		bootph-all;
 
 		partitions {
-			bootph-pre-ram;
+			bootph-all;
 
 			partition@3fc0000 {
-				bootph-pre-ram;
+				bootph-all;
 			};
 		};
 	};
 };
 
 &cpsw3g {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw_port1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw_port2 {
-- 
2.34.1

