Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3546CCAC592
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 00:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9BB832BC;
	Wed, 17 Sep 2025 02:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F03832BC; Wed, 17 Sep 2025 02:04:22 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5AC800C1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 02:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6D76BB220843;
 Wed, 17 Sep 2025 02:04:18 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/4] riscv: dts: starfive: sync visionfive2 overrides with
 upstream Linux for-next
Date: Tue, 16 Sep 2025 17:02:23 -0700
Message-ID: <20250917000254.1134031-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250917000254.1134031-1-e@freeshell.de>
References: <20250917000254.1134031-1-e@freeshell.de>
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

Sync automatic dtsi inclusion overrides for JH7110 CPU with upstream
"riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot
loader" from upstream Linux conor/riscv-dt-for-next commit 8181cc2f3f21

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-u-boot.dtsi | 81 ++++++++++++-------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
index f8d13277d24..cc27dd648f8 100644
--- a/arch/riscv/dts/jh7110-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-u-boot.dtsi
@@ -3,36 +3,10 @@
  * Copyright (C) 2022 StarFive Technology Co., Ltd.
  */
 
-#include <dt-bindings/reset/starfive,jh7110-crg.h>
-
-/ {
-	timer {
-		compatible = "riscv,timer";
-		interrupts-extended = <&cpu0_intc 5>,
-				      <&cpu1_intc 5>,
-				      <&cpu2_intc 5>,
-				      <&cpu3_intc 5>,
-				      <&cpu4_intc 5>;
-	};
+// BEGIN "riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader"
+// From upstream Linux conor/riscv-dt-for-next commit 8181cc2f3f21
 
-	soc {
-		bootph-pre-ram;
-
-		dmc: dmc@15700000 {
-			bootph-pre-ram;
-			compatible = "starfive,jh7110-dmc";
-			reg = <0x0 0x15700000 0x0 0x10000>,
-				<0x0 0x13000000 0x0 0x10000>;
-			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
-				<&syscrg JH7110_SYSRST_DDR_OSC>,
-				<&syscrg JH7110_SYSRST_DDR_APB>;
-			reset-names = "axi", "osc", "apb";
-			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
-			clock-names = "pll1_out";
-			clock-frequency = <2133>;
-		};
-	};
-};
+#include <dt-bindings/reset/starfive,jh7110-crg.h>
 
 &clint {
 	bootph-pre-ram;
@@ -58,22 +32,10 @@
 	bootph-pre-ram;
 };
 
-&cpus {
-	bootph-pre-ram;
-};
-
 &osc {
 	bootph-pre-ram;
 };
 
-&gmac0_rgmii_rxin {
-	bootph-pre-ram;
-};
-
-&gmac0_rmii_refin {
-	bootph-pre-ram;
-};
-
 &gmac1_rgmii_rxin {
 	bootph-pre-ram;
 };
@@ -82,23 +44,42 @@
 	bootph-pre-ram;
 };
 
-&aoncrg {
-	bootph-pre-ram;
+/ {
+	soc {
+		memory-controller@15700000 {
+			compatible = "starfive,jh7110-dmc";
+			reg = <0x0 0x15700000 0x0 0x10000>,
+			      <0x0 0x13000000 0x0 0x10000>;
+			bootph-pre-ram;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
+			clock-names = "pll";
+			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
+				 <&syscrg JH7110_SYSRST_DDR_OSC>,
+				 <&syscrg JH7110_SYSRST_DDR_APB>;
+			reset-names = "axi", "osc", "apb";
+		};
+	};
 };
 
-&pllclk {
+&syscrg {
 	bootph-pre-ram;
 };
 
-&syscrg {
-	assigned-clock-rates = <0>; /* cpufreq not implemented, use defaults */
+&pllclk {
 	bootph-pre-ram;
 };
 
-&stgcrg {
-	bootph-pre-ram;
+// END "riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader"
+
+/ {
+	soc {
+		memory-controller@15700000 {
+			clock-frequency = <2133>; /* FIXME: delete property and implement CCF */
+		};
+	};
 };
 
-&sys_syscon {
-	bootph-pre-ram;
+&syscrg {
+	assigned-clock-rates = <0>; /* FIXME: delete property and implement cpufreq */
 };
+
-- 
2.50.0

