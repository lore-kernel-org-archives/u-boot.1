Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2AC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332FA81FAB;
	Sat,  3 May 2025 23:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62DB80EE5; Sat,  3 May 2025 23:26:19 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF6A820E8
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DF26CB4C1ED3;
 Sat,  3 May 2025 23:26:15 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH] riscv: dts: jh7110: remove redundant parent nodes
Date: Sat,  3 May 2025 14:25:54 -0700
Message-ID: <20250503212602.988874-1-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
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

- use upstream alias name for cpu and timer nodes
- remove bootph-pre-ram hint from parent nodes
- drop S7 cpu core "okay" status

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-u-boot.dtsi | 72 ++++++++++++-------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index a9e318c4a31..b4b656b444b 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -6,46 +6,6 @@
 #include <dt-bindings/reset/starfive,jh7110-crg.h>
 
 / {
-	cpus: cpus {
-		bootph-pre-ram;
-
-		S7_0: cpu@0 {
-			bootph-pre-ram;
-			status = "okay";
-			cpu0_intc: interrupt-controller {
-				bootph-pre-ram;
-			};
-		};
-
-		U74_1: cpu@1 {
-			bootph-pre-ram;
-			cpu1_intc: interrupt-controller {
-				bootph-pre-ram;
-			};
-		};
-
-		U74_2: cpu@2 {
-			bootph-pre-ram;
-			cpu2_intc: interrupt-controller {
-				bootph-pre-ram;
-			};
-		};
-
-		U74_3: cpu@3 {
-			bootph-pre-ram;
-			cpu3_intc: interrupt-controller {
-				bootph-pre-ram;
-			};
-		};
-
-		U74_4: cpu@4 {
-			bootph-pre-ram;
-			cpu4_intc: interrupt-controller {
-				bootph-pre-ram;
-			};
-		};
-	};
-
 	timer {
 		compatible = "riscv,timer";
 		interrupts-extended = <&cpu0_intc 5>,
@@ -58,10 +18,6 @@
 	soc {
 		bootph-pre-ram;
 
-		clint: timer@2000000 {
-			bootph-pre-ram;
-		};
-
 		dmc: dmc@15700000 {
 			bootph-pre-ram;
 			compatible = "starfive,jh7110-dmc";
@@ -78,6 +34,34 @@
 	};
 };
 
+&clint {
+	bootph-pre-ram;
+};
+
+&cpu0_intc {
+	bootph-pre-ram;
+};
+
+&cpu1_intc {
+	bootph-pre-ram;
+};
+
+&cpu2_intc {
+	bootph-pre-ram;
+};
+
+&cpu3_intc {
+	bootph-pre-ram;
+};
+
+&cpu4_intc {
+	bootph-pre-ram;
+};
+
+&cpus {
+	bootph-pre-ram;
+};
+
 &osc {
 	bootph-pre-ram;
 };

base-commit: 0c8a89d252c3db3401ffa572ee2e4dfcb94e2c3b
-- 
2.49.0

