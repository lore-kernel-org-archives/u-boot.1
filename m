Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560FCCA0EE0
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 05:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62AB383A2D;
	Fri, 15 Aug 2025 07:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677B883A32; Fri, 15 Aug 2025 07:09:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41DCB83A28
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 07:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 34AE2B4E0039;
 Fri, 15 Aug 2025 07:09:17 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
Date: Thu, 14 Aug 2025 22:03:01 -0700
Message-ID: <20250815050315.62956-1-e@freeshell.de>
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

Prune jh7110-common-u-boot.dtsi (clocks, qspi flash, eeprom, and
bootph-pre-ram hints now upstream since devicetree-rebasing v6.16) and
replace by remaining dependency jh7110-u-boot.dtsi (not yet upstream).

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 99 -------------------
 .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |  2 +-
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  2 +-
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |  2 +-
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |  2 +-
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  2 +-
 6 files changed, 5 insertions(+), 104 deletions(-)
 delete mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
deleted file mode 100644
index 049b0a7ce28..00000000000
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ /dev/null
@@ -1,99 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2023 StarFive Technology Co., Ltd.
- */
-
-#include "jh7110-u-boot.dtsi"
-/ {
-	aliases {
-		spi0 = &qspi;
-	};
-
-	chosen {
-		bootph-pre-ram;
-	};
-
-	firmware {
-		spi0 = &qspi;
-		bootph-pre-ram;
-	};
-
-	memory@40000000 {
-		bootph-pre-ram;
-	};
-};
-
-&uart0 {
-	bootph-pre-ram;
-	reg-offset = <0>;
-	current-speed = <115200>;
-};
-
-&mmc0 {
-	bootph-pre-ram;
-};
-
-&mmc1 {
-	bootph-pre-ram;
-};
-
-&qspi {
-	bootph-pre-ram;
-
-	flash@0 {
-		bootph-pre-ram;
-		cdns,read-delay = <2>;
-		spi-max-frequency = <100000000>;
-	};
-};
-
-&syscrg {
-	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
-			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
-			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
-			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
-	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
-				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
-	assigned-clock-rates = <0>, <0>, <0>, <0>;
-};
-
-&sysgpio {
-	bootph-pre-ram;
-};
-
-&mmc0_pins {
-	bootph-pre-ram;
-	rst-pins {
-		bootph-pre-ram;
-	};
-};
-
-&mmc1_pins {
-	bootph-pre-ram;
-	clk-pins {
-		bootph-pre-ram;
-	};
-
-	mmc-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5_pins {
-	bootph-pre-ram;
-	i2c-pins {
-		bootph-pre-ram;
-	};
-};
-
-&i2c5 {
-	bootph-pre-ram;
-	eeprom@50 {
-		bootph-pre-ram;
-		compatible = "atmel,24c04";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
index ab882d07f6f..b9202f2acce 100644
--- a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
@@ -3,5 +3,5 @@
  * Copyright (C) 2024 StarFive Technology Co., Ltd.
  */
 
-#include "jh7110-common-u-boot.dtsi"
+#include "jh7110-u-boot.dtsi"
 #include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
index ab882d07f6f..b9202f2acce 100644
--- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -3,5 +3,5 @@
  * Copyright (C) 2024 StarFive Technology Co., Ltd.
  */
 
-#include "jh7110-common-u-boot.dtsi"
+#include "jh7110-u-boot.dtsi"
 #include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
index ab882d07f6f..b9202f2acce 100644
--- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
@@ -3,5 +3,5 @@
  * Copyright (C) 2024 StarFive Technology Co., Ltd.
  */
 
-#include "jh7110-common-u-boot.dtsi"
+#include "jh7110-u-boot.dtsi"
 #include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
index ab882d07f6f..b9202f2acce 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
@@ -3,5 +3,5 @@
  * Copyright (C) 2024 StarFive Technology Co., Ltd.
  */
 
-#include "jh7110-common-u-boot.dtsi"
+#include "jh7110-u-boot.dtsi"
 #include "starfive-visionfive2-binman.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
index 874074174ff..848ed8225ac 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
@@ -3,5 +3,5 @@
  * Copyright (C) 2023 StarFive Technology Co., Ltd.
  */
 
-#include "jh7110-common-u-boot.dtsi"
+#include "jh7110-u-boot.dtsi"
 #include "starfive-visionfive2-binman.dtsi"

base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
-- 
2.50.0

