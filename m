Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF38CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B907807C0;
	Tue, 21 Oct 2025 22:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A5CA8323A; Tue, 21 Oct 2025 22:55:25 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50861802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6CBDDB220442;
 Tue, 21 Oct 2025 22:55:21 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH] riscv: dts: starfive: prune redundant jh7110 overrides
Date: Tue, 21 Oct 2025 13:54:00 -0700
Message-ID: <20251021205408.180373-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Prune overrides of upstream jh7110.dtsi now that the required nodes are
available through the devicetree-rebasing subtree.

Signed-off-by: E Shattow <e@freeshell.de>
---
Depends on "dts: starfive: cherry-pick jh7110 updates from v6.18-rc1-dts":
https://lore.kernel.org/u-boot/20251015102253.48276-1-e@freeshell.de/
---
 .../dts/starfive-visionfive2-u-boot.dtsi      | 68 -------------------
 1 file changed, 68 deletions(-)

diff --git a/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi b/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
index 0e5dc3685b2..4c86d285e66 100644
--- a/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
@@ -3,74 +3,6 @@
  * Copyright (C) 2022 StarFive Technology Co., Ltd.
  */
 
-// BEGIN "riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader"
-// From upstream Linux conor/riscv-dt-for-next commit 8181cc2f3f21
-
-#include <dt-bindings/reset/starfive,jh7110-crg.h>
-
-&clint {
-	bootph-pre-ram;
-};
-
-&cpu0_intc {
-	bootph-pre-ram;
-};
-
-&cpu1_intc {
-	bootph-pre-ram;
-};
-
-&cpu2_intc {
-	bootph-pre-ram;
-};
-
-&cpu3_intc {
-	bootph-pre-ram;
-};
-
-&cpu4_intc {
-	bootph-pre-ram;
-};
-
-&osc {
-	bootph-pre-ram;
-};
-
-&gmac1_rgmii_rxin {
-	bootph-pre-ram;
-};
-
-&gmac1_rmii_refin {
-	bootph-pre-ram;
-};
-
-/ {
-	soc {
-		memory-controller@15700000 {
-			compatible = "starfive,jh7110-dmc";
-			reg = <0x0 0x15700000 0x0 0x10000>,
-			      <0x0 0x13000000 0x0 0x10000>;
-			bootph-pre-ram;
-			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
-			clock-names = "pll";
-			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
-				 <&syscrg JH7110_SYSRST_DDR_OSC>,
-				 <&syscrg JH7110_SYSRST_DDR_APB>;
-			reset-names = "axi", "osc", "apb";
-		};
-	};
-};
-
-&syscrg {
-	bootph-pre-ram;
-};
-
-&pllclk {
-	bootph-pre-ram;
-};
-
-// END "riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader"
-
 / {
 	soc {
 		memory-controller@15700000 {
-- 
2.50.0

