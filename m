Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A9C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8246B88667;
	Wed,  7 Aug 2024 16:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YhiFkxDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F0E88667; Wed,  7 Aug 2024 16:57:01 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0F28869E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477Eur7m039937;
 Wed, 7 Aug 2024 09:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723042613;
 bh=bJRLDNvlgyUfC2+w1eco2huHXmsHeKMwd1GGm/UvwQM=;
 h=From:To:CC:Subject:Date;
 b=YhiFkxDwgOcXI2wqdVfIvXzNJm5lADnxNTqTZi032VIUv1MTfaWXAJ5Ilz8cFcrH2
 SkWt64IL2gcyyahGkTIMGf8qWh1J9wgXzdD2MPJcPfcQNmaSZf3zgssgewqCucRW0S
 S1MpWzpH/eo1uwNKtxoUH8aTznYsHS4ZolvfFoj0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477EurB4059145
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Aug 2024 09:56:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 09:56:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 09:56:53 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Euq1o024328;
 Wed, 7 Aug 2024 09:56:52 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: dts: keystone: Move to OF_UPSTREAM
Date: Wed, 7 Aug 2024 09:56:51 -0500
Message-ID: <20240807145651.52700-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable OF_UPSTREAM for Keystone boards. Remove DT files that
are now available in dts/upstream.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/Makefile                         |   7 -
 arch/arm/dts/keystone-clocks.dtsi             | 411 -----------------
 arch/arm/dts/keystone-k2e-clocks.dtsi         |  74 ---
 arch/arm/dts/keystone-k2e-evm-u-boot.dtsi     |  14 +-
 arch/arm/dts/keystone-k2e-evm.dts             | 152 -------
 arch/arm/dts/keystone-k2e-netcp.dtsi          | 203 ---------
 arch/arm/dts/keystone-k2e.dtsi                | 144 ------
 arch/arm/dts/keystone-k2g-evm-u-boot.dtsi     |  20 +-
 arch/arm/dts/keystone-k2g-evm.dts             | 148 ------
 arch/arm/dts/keystone-k2g-generic-u-boot.dtsi |  18 -
 arch/arm/dts/keystone-k2g-generic.dts         |  27 --
 arch/arm/dts/keystone-k2g-ice-u-boot.dtsi     |  15 +-
 arch/arm/dts/keystone-k2g-ice.dts             | 118 -----
 arch/arm/dts/keystone-k2g-netcp.dtsi          | 149 -------
 arch/arm/dts/keystone-k2g.dtsi                | 258 -----------
 arch/arm/dts/keystone-k2hk-clocks.dtsi        | 422 ------------------
 arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi    |  26 +-
 arch/arm/dts/keystone-k2hk-evm.dts            | 180 --------
 arch/arm/dts/keystone-k2hk-netcp.dtsi         | 207 ---------
 arch/arm/dts/keystone-k2hk.dtsi               | 111 -----
 arch/arm/dts/keystone-k2l-clocks.dtsi         | 263 -----------
 arch/arm/dts/keystone-k2l-evm-u-boot.dtsi     |  28 +-
 arch/arm/dts/keystone-k2l-evm.dts             | 129 ------
 arch/arm/dts/keystone-k2l-netcp.dtsi          | 187 --------
 arch/arm/dts/keystone-k2l.dtsi                | 105 -----
 arch/arm/dts/keystone.dtsi                    | 330 --------------
 configs/k2e_evm_defconfig                     |   3 +-
 configs/k2e_hs_evm_defconfig                  |   3 +-
 configs/k2g_evm_defconfig                     |   5 +-
 configs/k2g_hs_evm_defconfig                  |   5 +-
 configs/k2hk_evm_defconfig                    |   3 +-
 configs/k2hk_hs_evm_defconfig                 |   3 +-
 configs/k2l_evm_defconfig                     |   3 +-
 configs/k2l_hs_evm_defconfig                  |   3 +-
 34 files changed, 98 insertions(+), 3676 deletions(-)
 delete mode 100644 arch/arm/dts/keystone-clocks.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2e-clocks.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2e-evm.dts
 delete mode 100644 arch/arm/dts/keystone-k2e-netcp.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2e.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2g-evm.dts
 delete mode 100644 arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2g-generic.dts
 delete mode 100644 arch/arm/dts/keystone-k2g-ice.dts
 delete mode 100644 arch/arm/dts/keystone-k2g-netcp.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2g.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2hk-clocks.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2hk-evm.dts
 delete mode 100644 arch/arm/dts/keystone-k2hk-netcp.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2hk.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2l-clocks.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2l-evm.dts
 delete mode 100644 arch/arm/dts/keystone-k2l-netcp.dtsi
 delete mode 100644 arch/arm/dts/keystone-k2l.dtsi
 delete mode 100644 arch/arm/dts/keystone.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82d37adae3f..2c983b2224c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -953,13 +953,6 @@ endif
 dtb-$(CONFIG_RZA1) += \
 	r7s72100-gr-peach.dtb
 
-dtb-$(CONFIG_ARCH_KEYSTONE) += keystone-k2hk-evm.dtb \
-	keystone-k2l-evm.dtb \
-	keystone-k2e-evm.dtb \
-	keystone-k2g-evm.dtb \
-	keystone-k2g-generic.dtb \
-	keystone-k2g-ice.dtb
-
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
 dtb-$(CONFIG_TARGET_PM9261) += at91sam9261ek.dtb
diff --git a/arch/arm/dts/keystone-clocks.dtsi b/arch/arm/dts/keystone-clocks.dtsi
deleted file mode 100644
index 33742d81971..00000000000
--- a/arch/arm/dts/keystone-clocks.dtsi
+++ /dev/null
@@ -1,411 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for Keystone 2 clock tree
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-clocks {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	mainmuxclk: mainmuxclk@2310108 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-mux-clock";
-		clocks = <&mainpllclk>, <&refclksys>;
-		reg = <0x02310108 4>;
-		bit-shift = <23>;
-		bit-mask = <1>;
-		clock-output-names = "mainmuxclk";
-	};
-
-	chipclk1: chipclk1 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&mainmuxclk>;
-		clock-div = <1>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1";
-	};
-
-	chipclk1rstiso: chipclk1rstiso {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&mainmuxclk>;
-		clock-div = <1>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1rstiso";
-	};
-
-	gemtraceclk: gemtraceclk@2310120 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-divider-clock";
-		clocks = <&mainmuxclk>;
-		reg = <0x02310120 4>;
-		bit-shift = <0>;
-		bit-mask = <8>;
-		clock-output-names = "gemtraceclk";
-	};
-
-	chipstmxptclk: chipstmxptclk@2310164 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-divider-clock";
-		clocks = <&mainmuxclk>;
-		reg = <0x02310164 4>;
-		bit-shift = <0>;
-		bit-mask = <8>;
-		clock-output-names = "chipstmxptclk";
-	};
-
-	chipclk12: chipclk12 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <2>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk12";
-	};
-
-	chipclk13: chipclk13 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <3>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk13";
-	};
-
-	paclk13: paclk13 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&papllclk>;
-		clock-div = <3>;
-		clock-mult = <1>;
-		clock-output-names = "paclk13";
-	};
-
-	chipclk14: chipclk14 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <4>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk14";
-	};
-
-	chipclk16: chipclk16 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <6>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk16";
-	};
-
-	chipclk112: chipclk112 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <12>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk112";
-	};
-
-	chipclk124: chipclk124 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1>;
-		clock-div = <24>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk114";
-	};
-
-	chipclk1rstiso13: chipclk1rstiso13 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1rstiso>;
-		clock-div = <3>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1rstiso13";
-	};
-
-	chipclk1rstiso14: chipclk1rstiso14 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1rstiso>;
-		clock-div = <4>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1rstiso14";
-	};
-
-	chipclk1rstiso16: chipclk1rstiso16 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1rstiso>;
-		clock-div = <6>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1rstiso16";
-	};
-
-	chipclk1rstiso112: chipclk1rstiso112 {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&chipclk1rstiso>;
-		clock-div = <12>;
-		clock-mult = <1>;
-		clock-output-names = "chipclk1rstiso112";
-	};
-
-	clkmodrst0: clkmodrst0@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "modrst0";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-
-	clkusb: clkusb@2350008 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "usb";
-		reg = <0x02350008 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkaemifspi: clkaemifspi@235000c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "aemif-spi";
-		reg = <0x0235000c 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-
-	clkdebugsstrc: clkdebugsstrc@2350014 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "debugss-trc";
-		reg = <0x02350014 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <1>;
-	};
-
-	clktetbtrc: clktetbtrc@2350018 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tetb-trc";
-		reg = <0x02350018 0xb00>, <0x02350004 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <1>;
-	};
-
-	clkpa: clkpa@235001c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&paclk13>;
-		clock-output-names = "pa";
-		reg = <0x0235001c 0xb00>, <0x02350008 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <2>;
-	};
-
-	clkcpgmac: clkcpgmac@2350020 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkpa>;
-		clock-output-names = "cpgmac";
-		reg = <0x02350020 0xb00>, <0x02350008 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <2>;
-	};
-
-	clksa: clksa@2350024 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkpa>;
-		clock-output-names = "sa";
-		reg = <0x02350024 0xb00>, <0x02350008 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <2>;
-	};
-
-	clkpcie: clkpcie@2350028 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "pcie";
-		reg = <0x02350028 0xb00>, <0x0235000c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <3>;
-	};
-
-	clksr: clksr@2350034 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1rstiso112>;
-		clock-output-names = "sr";
-		reg = <0x02350034 0xb00>, <0x02350018 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <6>;
-	};
-
-	clkgem0: clkgem0@235003c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem0";
-		reg = <0x0235003c 0xb00>, <0x02350020 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <8>;
-	};
-
-	clkddr30: clkddr30@235005c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "ddr3-0";
-		reg = <0x0235005c 0xb00>, <0x02350040 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <16>;
-	};
-
-	clkwdtimer0: clkwdtimer0@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "timer0";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkwdtimer1: clkwdtimer1@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "timer1";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkwdtimer2: clkwdtimer2@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "timer2";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkwdtimer3: clkwdtimer3@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "timer3";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clktimer15: clktimer15@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "timer15";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkuart0: clkuart0@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "uart0";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkuart1: clkuart1@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "uart1";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkaemif: clkaemif@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkaemifspi>;
-		clock-output-names = "aemif";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkusim: clkusim@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "usim";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clki2c: clki2c@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "i2c";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkspi: clkspi@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkaemifspi>;
-		clock-output-names = "spi";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkgpio: clkgpio@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "gpio";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkkeymgr: clkkeymgr@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "keymgr";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2e-clocks.dtsi b/arch/arm/dts/keystone-k2e-clocks.dtsi
deleted file mode 100644
index 46f8ab3a11d..00000000000
--- a/arch/arm/dts/keystone-k2e-clocks.dtsi
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Edison SoC specific device tree
- *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-clocks {
-	mainpllclk: mainpllclk@2310110 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
-		reg-names = "control", "multiplier", "post-divider";
-	};
-
-	papllclk: papllclk@2620358 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkpass>;
-		clock-output-names = "papllclk";
-		reg = <0x02620358 4>;
-		reg-names = "control";
-	};
-
-	ddr3apllclk: ddr3apllclk@2620360 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkddr3a>;
-		clock-output-names = "ddr-3a-pll-clk";
-		reg = <0x02620360 4>;
-		reg-names = "control";
-	};
-
-	clkusb1: clkusb1@2350004 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "usb1";
-		reg = <0x02350004 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkhyperlink0: clkhyperlink0@2350030 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "hyperlink-0";
-		reg = <0x02350030 0xb00>, <0x02350014 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <5>;
-	};
-
-	clkpcie1: clkpcie1@235006c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "pcie1";
-		reg = <0x0235006c 0xb00>, <0x02350048 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <18>;
-	};
-
-	clkxge: clkxge@23500c8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "xge";
-		reg = <0x023500c8 0xb00>, <0x02350074 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <29>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
index 953c7502260..e77c53dbf7b 100644
--- a/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2e-evm-u-boot.dtsi
@@ -4,15 +4,23 @@
  */
 
 /{
-	soc {
-		bootph-all;
-	};
 	aliases {
 		usb0 = &usb;
 		usb1 = &usb1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+	};
+
+	chosen {
+		stdout-path = &uart0;
 	};
 };
 
+&soc0 {
+	bootph-all;
+};
+
 &i2c1 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/keystone-k2e-evm.dts b/arch/arm/dts/keystone-k2e-evm.dts
deleted file mode 100644
index bf884442617..00000000000
--- a/arch/arm/dts/keystone-k2e-evm.dts
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Edison EVM device tree
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "keystone.dtsi"
-#include "keystone-k2e.dtsi"
-
-/ {
-	compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone";
-	model = "Texas Instruments Keystone 2 Edison EVM";
-
-	soc {
-
-		clocks {
-			refclksys: refclksys {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk-sys";
-			};
-
-			refclkpass: refclkpass {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk-pass";
-			};
-
-			refclkddr3a: refclkddr3a {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk-ddr3a";
-			};
-		};
-	};
-};
-
-&usb_phy {
-	status = "okay";
-};
-
-&usb {
-	status = "okay";
-};
-
-&usb1_phy {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
-};
-
-&i2c0 {
-	dtt@50 {
-		compatible = "at,24c1024";
-		reg = <0x50>;
-	};
-};
-
-&aemif {
-	cs0 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		clock-ranges;
-		ranges;
-
-		ti,cs-chipselect = <0>;
-		/* all timings in nanoseconds */
-		ti,cs-min-turnaround-ns = <12>;
-		ti,cs-read-hold-ns = <6>;
-		ti,cs-read-strobe-ns = <23>;
-		ti,cs-read-setup-ns = <9>;
-		ti,cs-write-hold-ns = <8>;
-		ti,cs-write-strobe-ns = <23>;
-		ti,cs-write-setup-ns = <8>;
-
-		nand@0,0 {
-			compatible = "ti,keystone-nand","ti,davinci-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0 0 0x4000000
-			       1 0 0x0000100>;
-
-			ti,davinci-chipselect = <0>;
-			ti,davinci-mask-ale = <0x2000>;
-			ti,davinci-mask-cle = <0x4000>;
-			ti,davinci-mask-chipsel = <0>;
-			nand-ecc-mode = "hw";
-			ti,davinci-ecc-bits = <4>;
-			nand-on-flash-bbt;
-
-			partition@0 {
-				label = "u-boot";
-				reg = <0x0 0x100000>;
-				read-only;
-			};
-
-			partition@100000 {
-				label = "params";
-				reg = <0x100000 0x80000>;
-				read-only;
-			};
-
-			partition@180000 {
-				label = "ubifs";
-				reg = <0x180000 0x1FE80000>;
-			};
-		};
-	};
-};
-
-&spi0 {
-	status = "okay";
-	nor_flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "Micron,n25q128a11", "jedec,spi-nor";
-		spi-max-frequency = <54000000>;
-		m25p,fast-read;
-		reg = <0>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "misc";
-			reg = <0x80000 0xf80000>;
-		};
-	};
-};
-
-&mdio {
-	status = "okay";
-	ethphy0: ethernet-phy@0 {
-		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
-	};
-
-	ethphy1: ethernet-phy@1 {
-		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2e-netcp.dtsi b/arch/arm/dts/keystone-k2e-netcp.dtsi
deleted file mode 100644
index dd61503db39..00000000000
--- a/arch/arm/dts/keystone-k2e-netcp.dtsi
+++ /dev/null
@@ -1,203 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for Keystone 2 Edison Netcp driver
- *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-qmss: qmss@2a40000 {
-	compatible = "ti,keystone-navigator-qmss";
-	dma-coherent;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	clocks = <&chipclk13>;
-	ranges;
-	queue-range = <0 0x2000>;
-	linkram0 = <0x100000 0x4000>;
-	linkram1 = <0 0x10000>;
-
-	qmgrs {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		qmgr0 {
-			managed-queues = <0 0x2000>;
-			reg = <0x2a40000 0x20000>,
-			      <0x2a06000 0x400>,
-			      <0x2a02000 0x1000>,
-			      <0x2a03000 0x1000>,
-			      <0x23a80000 0x20000>,
-			      <0x2a80000 0x20000>;
-			reg-names = "peek", "status", "config",
-				    "region", "push", "pop";
-		};
-	};
-	queue-pools {
-		qpend {
-			qpend-0 {
-				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
-			};
-			qpend-1 {
-				qrange = <528 16>;
-				interrupts = <0 48 0xf04 0 49 0xf04 0 50 0xf04
-					      0 51 0xf04 0 52 0xf04 0 53 0xf04
-					      0 54 0xf04 0 55 0xf04 0 56 0xf04
-					      0 57 0xf04 0 58 0xf04 0 59 0xf04
-					      0 60 0xf04 0 61 0xf04 0 62 0xf04
-					      0 63 0xf04>;
-				qalloc-by-id;
-			};
-			qpend-2 {
-				qrange = <544 16>;
-				interrupts = <0 64 0xf04 0 65 0xf04 0 66 0xf04
-					      0 59 0xf04 0 68 0xf04 0 69 0xf04
-					      0 70 0xf04 0 71 0xf04 0 72 0xf04
-					      0 73 0xf04 0 74 0xf04 0 75 0xf04
-					      0 76 0xf04 0 77 0xf04 0 78 0xf04
-					      0 79 0xf04>;
-			};
-		};
-		general-purpose {
-			gp-0 {
-				qrange = <4000 64>;
-			};
-			netcp-tx {
-				qrange = <896 128>;
-				qalloc-by-id;
-			};
-		};
-	};
-	descriptor-regions {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		region-12 {
-			id = <12>;
-			region-spec = <8192 128>;	/* num_desc desc_size */
-			link-index = <0x4000>;
-		};
-	};
-}; /* qmss */
-
-knav_dmas: knav_dmas@0 {
-	compatible = "ti,keystone-navigator-dma";
-	clocks = <&papllclk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	ti,navigator-cloud-address = <0x23a80000 0x23a90000
-				 0x23a80000 0x23a90000>;
-
-	dma_gbe: dma_gbe@0 {
-		reg = <0x24186000 0x100>,
-			  <0x24187000 0x2a0>,
-			  <0x24188000 0xb60>,
-			  <0x24186100 0x80>,
-			  <0x24189000 0x1000>;
-		reg-names = "global", "txchan", "rxchan",
-				"txsched", "rxflow";
-	};
-};
-
-netcp: netcp@24000000 {
-	reg = <0x2620110 0x8>;
-	reg-names = "efuse";
-	compatible = "ti,netcp-1.0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	/* NetCP address range */
-	ranges = <0 0x24000000 0x1000000>;
-
-	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
-	dma-coherent;
-
-	ti,navigator-dmas = <&dma_gbe 0>,
-			<&dma_gbe 8>,
-			<&dma_gbe 0>;
-	ti,navigator-dma-names = "netrx0", "netrx1", "nettx";
-
-	netcp-devices {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		gbe@200000 { /* ETHSS */
-			label = "netcp-gbe";
-			compatible = "ti,netcp-gbe-9";
-			reg = <0x200000 0x900>, <0x220000 0x20000>;
-			/* enable-ale; */
-			tx-queue = <896>;
-			tx-channel = "nettx";
-
-			interfaces {
-				gbe0: interface-0 {
-					slave-port = <0>;
-					link-interface = <1>;
-					phy-handle = <&ethphy0>;
-				};
-				gbe1: interface-1 {
-					slave-port = <1>;
-					link-interface = <1>;
-					phy-handle = <&ethphy1>;
-				};
-			};
-
-			secondary-slave-ports {
-				port-2 {
-					slave-port = <2>;
-					link-interface = <2>;
-				};
-				port-3 {
-					slave-port = <3>;
-					link-interface = <2>;
-				};
-				port-4 {
-					slave-port = <4>;
-					link-interface = <2>;
-				};
-				port-5 {
-					slave-port = <5>;
-					link-interface = <2>;
-				};
-				port-6 {
-					slave-port = <6>;
-					link-interface = <2>;
-				};
-				port-7 {
-					slave-port = <7>;
-					link-interface = <2>;
-				};
-			};
-		};
-	};
-
-	netcp-interfaces {
-		interface-0 {
-			rx-channel = "netrx0";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <528>;
-			tx-completion-queue = <530>;
-			efuse-mac = <1>;
-			netcp-gbe = <&gbe0>;
-
-		};
-		interface-1 {
-			rx-channel = "netrx1";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <529>;
-			tx-completion-queue = <531>;
-			efuse-mac = <0>;
-			local-mac-address = [02 18 31 7e 3e 00];
-			netcp-gbe = <&gbe1>;
-		};
-	};
-};
diff --git a/arch/arm/dts/keystone-k2e.dtsi b/arch/arm/dts/keystone-k2e.dtsi
deleted file mode 100644
index 449cddcb814..00000000000
--- a/arch/arm/dts/keystone-k2e.dtsi
+++ /dev/null
@@ -1,144 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Edison soc device tree
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/ {
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		interrupt-parent = <&gic>;
-
-		cpu@0 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <0>;
-		};
-
-		cpu@1 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <1>;
-		};
-
-		cpu@2 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <2>;
-		};
-
-		cpu@3 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <3>;
-		};
-	};
-
-	soc {
-		/include/ "keystone-k2e-clocks.dtsi"
-
-		usb: usb@2680000 {
-			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
-			usb@2690000 {
-				interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-
-		usb1_phy: usb_phy@2620750 {
-			compatible = "ti,keystone-usbphy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2620750 24>;
-			status = "disabled";
-		};
-
-		usb1: usb@25000000 {
-			compatible = "ti,keystone-dwc3";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x25000000 0x10000>;
-			clocks = <&clkusb1>;
-			clock-names = "usb";
-			interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
-			ranges;
-			dma-coherent;
-			dma-ranges;
-			status = "disabled";
-
-			usb@25010000 {
-				compatible = "synopsys,dwc3";
-				reg = <0x25010000 0x70000>;
-				interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
-				usb-phy = <&usb1_phy>, <&usb1_phy>;
-			};
-		};
-
-		dspgpio0: keystone_dsp_gpio@02620240 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x240>;
-		};
-
-		pcie1: pcie@21020000 {
-			compatible = "ti,keystone-pcie","snps,dw-pcie";
-			clocks = <&clkpcie1>;
-			clock-names = "pcie";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			reg = <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
-			ranges = <0x81000000 0 0 0x23260000 0x4000 0x4000
-				0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
-
-			status = "disabled";
-			device_type = "pci";
-			num-lanes = <2>;
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc1 0>, /* INT A */
-					<0 0 0 2 &pcie_intc1 1>, /* INT B */
-					<0 0 0 3 &pcie_intc1 2>, /* INT C */
-					<0 0 0 4 &pcie_intc1 3>; /* INT D */
-
-			pcie_msi_intc1: msi-interrupt-controller {
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 377 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 378 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 379 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 380 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 381 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 382 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 383 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 384 IRQ_TYPE_EDGE_RISING>;
-			};
-
-			pcie_intc1: legacy-interrupt-controller {
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 374 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-
-		mdio: mdio@24200f00 {
-			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x24200f00 0x100>;
-			status = "disabled";
-			clocks = <&clkcpgmac>;
-			clock-names = "fck";
-			bus_freq = <2500000>;
-		};
-		/include/ "keystone-k2e-netcp.dtsi"
-	};
-};
diff --git a/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
index 72b67b232dd..19c78c97ae3 100644
--- a/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2g-evm-u-boot.dtsi
@@ -4,20 +4,34 @@
  */
 
 /{
-	soc {
-		bootph-all;
-	};
 	aliases {
 		usb0 = &usb0;
 		usb1 = &usb1;
 	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&soc0 {
+	bootph-all;
+
+	pmmc@2900000 {
+		bootph-all;
+		compatible = "ti,power-processor";
+		reg = <0x02900000 0x40000>;
+		ti,lpsc_module = <1>;
+	};
 };
 
 &i2c0 {
+	status = "okay";
 	bootph-all;
 };
 
 &i2c1 {
+	status = "okay";
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/keystone-k2g-evm.dts b/arch/arm/dts/keystone-k2g-evm.dts
deleted file mode 100644
index 491fdc4b046..00000000000
--- a/arch/arm/dts/keystone-k2g-evm.dts
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for K2G EVM
- *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "keystone-k2g.dtsi"
-
-/ {
-	compatible =  "ti,k2g-evm","ti,keystone";
-	model = "Texas Instruments K2G General Purpose EVM";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
-	};
-};
-
-&mdio {
-	status = "okay";
-	ethphy0: ethernet-phy@0 {
-		reg = <0>;
-	};
-};
-
-&keystone_usb0 {
-	status = "okay";
-};
-
-&usb0_phy {
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&keystone_usb1 {
-	status = "okay";
-};
-
-&usb1_phy {
-	status = "okay";
-};
-
-&usb1 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&gbe0 {
-	phy-handle = <&ethphy0>;
-};
-
-&netcp {
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-
-	spi_nor: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-		m25p,fast-read;
-		reg = <0>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "misc";
-			reg = <0x80000 0xf80000>;
-		};
-	};
-};
-
-&qspi {
-	status = "okay";
-
-	flash0: flash@0 {
-		compatible = "s25fl512s", "jedec,spi-nor";
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		spi-max-frequency = <96000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		cdns,tshsl-ns = <392>;
-		cdns,tsd2d-ns = <392>;
-		cdns,tchsh-ns = <100>;
-		cdns,tslch-ns = <100>;
-		block-size = <18>;
-
-		partition@0 {
-			label = "QSPI.u-boot-spl-os";
-			reg = <0x00000000 0x00100000>;
-		};
-		partition@1 {
-			label = "QSPI.u-boot-env";
-			reg = <0x00100000 0x00040000>;
-		};
-		partition@2 {
-			label = "QSPI.skern";
-			reg = <0x00140000 0x0040000>;
-		};
-		partition@3 {
-			label = "QSPI.pmmc-firmware";
-			reg = <0x00180000 0x0040000>;
-		};
-		partition@4 {
-			label = "QSPI.kernel";
-			reg = <0x001C0000 0x0800000>;
-		};
-		partition@5 {
-			label = "QSPI.file-system";
-			reg = <0x009C0000 0x3640000>;
-		};
-	};
-};
-
-&mmc0 {
-	status = "okay";
-};
-
-&mmc1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi b/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
deleted file mode 100644
index 3634ed7268c..00000000000
--- a/arch/arm/dts/keystone-k2g-generic-u-boot.dtsi
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/{
-	soc {
-		bootph-all;
-	};
-};
-
-&i2c0 {
-	bootph-all;
-};
-
-&i2c1 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/keystone-k2g-generic.dts b/arch/arm/dts/keystone-k2g-generic.dts
deleted file mode 100644
index dc6c31a31b4..00000000000
--- a/arch/arm/dts/keystone-k2g-generic.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree Source for Generic 66AK2G0X EVM
- *
- * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "keystone-k2g.dtsi"
-
-/ {
-	compatible = "ti,k2g-generic", "ti,k2g", "ti,keystone";
-	model = "Texas Instruments 66AK2G02 Generic";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&i2c0 {
-        status = "okay";
-};
-
-&i2c1 {
-        status = "okay";
-};
diff --git a/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi b/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
index 3634ed7268c..152744686b5 100644
--- a/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2g-ice-u-boot.dtsi
@@ -4,15 +4,28 @@
  */
 
 /{
-	soc {
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&soc0 {
+	bootph-all;
+
+	pmmc@2900000 {
 		bootph-all;
+		compatible = "ti,power-processor";
+		reg = <0x02900000 0x40000>;
+		ti,lpsc_module = <1>;
 	};
 };
 
 &i2c0 {
+	status = "okay";
 	bootph-all;
 };
 
 &i2c1 {
+	status = "okay";
 	bootph-all;
 };
diff --git a/arch/arm/dts/keystone-k2g-ice.dts b/arch/arm/dts/keystone-k2g-ice.dts
deleted file mode 100644
index b898ae668a9..00000000000
--- a/arch/arm/dts/keystone-k2g-ice.dts
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for K2G Industrial Communication Engine EVM
- *
- * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "keystone-k2g.dtsi"
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	compatible = "ti,k2g-ice", "ti,k2g", "ti,keystone";
-	model = "Texas Instruments K2G Industrial Communication EVM";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>;
-	};
-};
-
-&mmc1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&qspi {
-	status = "okay";
-
-	flash0: flash@0 {
-		compatible = "s25fl256s1", "jedec,spi-nor";
-		reg = <0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		spi-max-frequency = <96000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		cdns,read-delay = <5>;
-		cdns,tshsl-ns = <500>;
-		cdns,tsd2d-ns = <500>;
-		cdns,tchsh-ns = <119>;
-		cdns,tslch-ns = <119>;
-
-		partition@0 {
-			label = "QSPI.u-boot";
-			reg = <0x00000000 0x00100000>;
-		};
-		partition@1 {
-			label = "QSPI.u-boot-env";
-			reg = <0x00100000 0x00040000>;
-		};
-		partition@2 {
-			label = "QSPI.skern";
-			reg = <0x00140000 0x0040000>;
-		};
-		partition@3 {
-			label = "QSPI.pmmc-firmware";
-			reg = <0x00180000 0x0040000>;
-		};
-		partition@4 {
-			label = "QSPI.kernel";
-			reg = <0x001c0000 0x0800000>;
-		};
-		partition@5 {
-			label = "QSPI.u-boot-spl-os";
-			reg = <0x009c0000 0x0040000>;
-		};
-		partition@6 {
-			label = "QSPI.file-system";
-			reg = <0x00a00000 0x1600000>;
-		};
-	};
-};
-
-&qmss {
-	status = "okay";
-};
-
-&knav_dmas {
-	status = "okay";
-};
-
-&netcp {
-	pinctrl-names = "default";
-	//pinctrl-0 = <&emac_pins>;
-	status = "okay";
-};
-
-&mdio {
-	pinctrl-names = "default";
-	//pinctrl-0 = <&mdio_pins>;
-	status = "okay";
-	ethphy0: ethernet-phy@0 {
-		reg = <0>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
-		ti,min-output-impedance;
-		ti,dp83867-rxctrl-strap-quirk;
-	};
-};
-
-&gbe0 {
-	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-};
diff --git a/arch/arm/dts/keystone-k2g-netcp.dtsi b/arch/arm/dts/keystone-k2g-netcp.dtsi
deleted file mode 100644
index 2afb48823c1..00000000000
--- a/arch/arm/dts/keystone-k2g-netcp.dtsi
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for K2G Netcp driver
- *
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-qmss: qmss@4020000 {
-	compatible = "ti,keystone-navigator-qmss-l";
-	dma-coherent;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	/* power-domains = <&k2g_pds K2G_DEV_NSS0>; */
-	/* clocks = <&k2g_clks K2G_DEV_NSS0 K2G_DEV_NSS_VCLK>; */
-	clock-names = "nss_vclk";
-	ranges;
-	queue-range = <0 0x80>;
-	linkram0 = <0x4020000 0x7ff>;
-
-	qmgrs {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		qmgr0 {
-			managed-queues = <0 0x80>;
-			reg = <0x4100000 0x800>,
-			      <0x4040000 0x100>,
-			      <0x4080000 0x800>,
-			      <0x40c0000 0x800>;
-			reg-names = "peek", "config",
-				    "region", "push";
-		};
-
-	};
-	queue-pools {
-		qpend {
-			qpend-0 {
-				qrange = <77 8>;
-				interrupts =<0 308 0xf04 0 309 0xf04 0 310 0xf04
-					     0 311 0xf04 0 312 0xf04 0 313 0xf04
-					     0 314 0xf04 0 315 0xf04>;
-				qalloc-by-id;
-			};
-		};
-		general-purpose {
-			gp-0 {
-				qrange = <112 8>;
-			};
-			netcp-tx {
-				qrange = <5 8>;
-				qalloc-by-id;
-			};
-		};
-	};
-
-	descriptor-regions {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		region-12 {
-			id = <12>;
-			region-spec = <1023 128>; /* num_desc desc_size */
-			link-index = <0x400>;
-		};
-	};
-}; /* qmss */
-
-knav_dmas: knav_dmas@0 {
-	compatible = "ti,keystone-navigator-dma";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	/* power-domains = <&k2g_pds K2G_DEV_NSS0>; */
-	/* clocks = <&k2g_clks K2G_DEV_NSS0 K2G_DEV_NSS_VCLK>; */
-	clock-names = "nss_vclk";
-	ranges;
-	ti,navigator-cloud-address = <0x40c0000 0x40c0000 0x40c0000 0x40c0000>;
-
-	dma_gbe: dma_gbe@0 {
-		reg = <0x4010000 0x100>,
-		      <0x4011000 0x2a0>, /* 21 Tx channels */
-		      <0x4012000 0x400>, /* 32 Rx channels */
-		      <0x4010100 0x80>,
-		      <0x4013000 0x400>; /* 32 Rx flows */
-		reg-names = "global", "txchan", "rxchan",
-			    "txsched", "rxflow";
-	};
-
-};
-
-gbe_subsys: subsys@4200000 {
-	compatible = "syscon";
-	reg = <0x4200000 0x100>;
-};
-
-netcp: netcp@4000000 {
-	reg = <0x2620110 0x8>;
-	reg-names = "efuse";
-	compatible = "ti,netcp-1.0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	status = "disabled";
-	/* power-domains = <&k2g_pds K2G_DEV_NSS0>; */
-	/* clocks = <&k2g_clks K2G_DEV_NSS0 K2G_DEV_NSS_ESW_CLK>; */
-	clock-names = "ethss_clk";
-
-	/* NetCP address range */
-	ranges = <0 0x4000000 0x1000000>;
-
-	dma-coherent;
-
-	ti,navigator-dmas = <&dma_gbe 0>, <&dma_gbe 5>;
-	ti,navigator-dma-names = "netrx0", "nettx";
-
-	netcp-devices {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		gbe@200000 {
-			label = "netcp-gbe";
-			compatible = "ti,netcp-gbe-2";
-			syscon-subsys = <&gbe_subsys>;
-			reg = <0x200100 0xe00>, <0x220000 0x20000>;
-			/* enable-ale; */
-			tx-queue = <5>;
-			tx-channel = "nettx";
-
-			interfaces {
-				gbe0: interface-0 {
-					slave-port = <0>;
-					link-interface = <5>;
-				};
-			};
-		};
-	};
-
-	netcp-interfaces {
-		interface-0 {
-			rx-channel = "netrx0";
-			rx-pool = <512 12>;
-			tx-pool = <511 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <77>;
-			tx-completion-queue = <78>;
-			efuse-mac = <1>;
-			netcp-gbe = <&gbe0>;
-		};
-	};
-};
diff --git a/arch/arm/dts/keystone-k2g.dtsi b/arch/arm/dts/keystone-k2g.dtsi
deleted file mode 100644
index 5c3ff127218..00000000000
--- a/arch/arm/dts/keystone-k2g.dtsi
+++ /dev/null
@@ -1,258 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for K2G SOC
- *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	model = "Texas Instruments K2G SoC";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&gic>;
-
-	chosen { };
-
-	aliases {
-		serial0	= &uart0;
-		spi0 = &spi0;
-		spi1 = &spi1;
-		spi2 = &spi2;
-		spi3 = &spi3;
-		spi4 = &qspi;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		interrupt-parent = <&gic>;
-
-		cpu@0 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <0>;
-		};
-	};
-
-	gic: interrupt-controller@2561000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x0 0x02561000 0x0 0x1000>,
-		      <0x0 0x02562000 0x0 0x2000>,
-		      <0x0 0x02564000 0x0 0x1000>,
-		      <0x0 0x02566000 0x0 0x2000>;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
-				IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "ti,keystone","simple-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		uart0: serial@02530c00 {
-			compatible = "ns16550a";
-			current-speed = <115200>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			reg = <0x02530c00 0x100>;
-			clock-names = "uart";
-			interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
-		};
-
-		mdio: mdio@4200f00 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* power-domains = <&k2g_pds K2G_DEV_NSS0>; */
-			/* clocks = <&k2g_clks K2G_DEV_NSS0 K2G_DEV_NSS_ESW_CLK>; */
-			clock-names = "fck";
-			reg = <0x04200f00 0x100>;
-			status = "disabled";
-			bus_freq = <2500000>;
-		};
-
-		qspi: qspi@2940000 {
-			compatible =  "cdns,qspi-nor";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x02940000 0x1000>,
-			      <0x24000000 0x4000000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>;
-			num-cs = <4>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,trigger-address = <0x24000000>;
-			status = "disabled";
-		};
-
-		#include "keystone-k2g-netcp.dtsi"
-
-		pmmc: pmmc@2900000 {
-			compatible = "ti,power-processor";
-			reg = <0x02900000 0x40000>;
-			ti,lpsc_module = <1>;
-		};
-
-		spi0: spi@21805400 {
-			compatible = "ti,keystone-spi", "ti,dm6441-spi";
-			reg = <0x21805400 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 64 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi1: spi@21805800 {
-			compatible = "ti,keystone-spi", "ti,dm6441-spi";
-			reg = <0x21805800 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 66 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi2: spi@21805c00 {
-			compatible = "ti,keystone-spi", "ti,dm6441-spi";
-			reg = <0x21805C00 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		spi3: spi@21806000 {
-			compatible = "ti,keystone-spi", "ti,dm6441-spi";
-			reg = <0x21806000 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-		i2c0: i2c@2530000 {
-			compatible = "ti,keystone-i2c";
-			reg = <0x02530000 0x400>;
-			clock-frequency = <100000>;
-			interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@2530400 {
-			compatible = "ti,keystone-i2c";
-			reg = <0x02530400 0x400>;
-			clock-frequency = <100000>;
-			interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@2530800 {
-			compatible = "ti,keystone-i2c";
-			reg = <0x02530800 0x400>;
-			clock-frequency = <100000>;
-			interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		mmc0: mmc@23000000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x23000000 0x400>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-			bus-width = <4>;
-			ti,needs-special-reset;
-			no-1-8-v;
-			max-frequency = <96000000>;
-			status = "disabled";
-		};
-
-		mmc1: mmc@23100000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x23100000 0x400>;
-			interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
-			bus-width = <8>;
-			ti,needs-special-reset;
-			ti,non-removable;
-			max-frequency = <96000000>;
-			status = "disabled";
-			clock-names = "fck";
-		};
-
-		usb0_phy: usb-phy@0 {
-			compatible = "usb-nop-xceiv";
-			status = "disabled";
-		};
-
-		keystone_usb0: keystone-dwc3@2680000 {
-			compatible = "ti,keystone-dwc3";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2680000 0x10000>;
-			interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>;
-			ranges;
-			dma-coherent;
-			dma-ranges;
-			status = "disabled";
-			/*power-domains = <&k2g_pds 0x0016>;*/
-
-			usb0: usb@2690000 {
-				compatible = "snps,dwc3";
-				reg = <0x2690000 0x10000>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>;
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-				/*usb-phy = <&usb0_phy>;*/
-				status = "disabled";
-			};
-		};
-
-		usb1_phy: usb-phy@1 {
-			compatible = "usb-nop-xceiv";
-			status = "disabled";
-		};
-
-		keystone_usb1: keystone-dwc3@2580000 {
-			compatible = "ti,keystone-dwc3";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2580000 0x10000>;
-			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
-			ranges;
-			dma-coherent;
-			dma-ranges;
-			status = "disabled";
-			/*power-domains = <&k2g_pds 0x0017>;*/
-
-			usb1: usb@2590000 {
-				compatible = "snps,dwc3";
-				reg = <0x2590000 0x10000>;
-				interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-				/*usb-phy = <&usb1_phy>;*/
-				status = "disabled";
-			};
-		};
-	};
-};
diff --git a/arch/arm/dts/keystone-k2hk-clocks.dtsi b/arch/arm/dts/keystone-k2hk-clocks.dtsi
deleted file mode 100644
index 3ca4722087c..00000000000
--- a/arch/arm/dts/keystone-k2hk-clocks.dtsi
+++ /dev/null
@@ -1,422 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Kepler/Hawking SoC clock nodes
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-clocks {
-	armpllclk: armpllclk@2620370 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkarm>;
-		clock-output-names = "arm-pll-clk";
-		reg = <0x02620370 4>;
-		reg-names = "control";
-	};
-
-	mainpllclk: mainpllclk@2310110 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
-		reg-names = "control", "multiplier", "post-divider";
-	};
-
-	papllclk: papllclk@2620358 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkpass>;
-		clock-output-names = "papllclk";
-		reg = <0x02620358 4>;
-		reg-names = "control";
-	};
-
-	ddr3apllclk: ddr3apllclk@2620360 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkddr3a>;
-		clock-output-names = "ddr-3a-pll-clk";
-		reg = <0x02620360 4>;
-		reg-names = "control";
-	};
-
-	ddr3bpllclk: ddr3bpllclk@2620368 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkddr3b>;
-		clock-output-names = "ddr-3b-pll-clk";
-		reg = <0x02620368 4>;
-		reg-names = "control";
-	};
-
-	clktsip: clktsip@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk16>;
-		clock-output-names = "tsip";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clksrio: clksrio@235002c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1rstiso13>;
-		clock-output-names = "srio";
-		reg = <0x0235002c 0xb00>, <0x02350010 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <4>;
-	};
-
-	clkhyperlink0: clkhyperlink0@2350030 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "hyperlink-0";
-		reg = <0x02350030 0xb00>, <0x02350014 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <5>;
-	};
-
-	clkgem1: clkgem1@2350040 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem1";
-		reg = <0x02350040 0xb00>, <0x02350024 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <9>;
-	};
-
-	clkgem2: clkgem2@2350044 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem2";
-		reg = <0x02350044 0xb00>, <0x02350028 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <10>;
-	};
-
-	clkgem3: clkgem3@2350048 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem3";
-		reg = <0x02350048 0xb00>, <0x0235002c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <11>;
-	};
-
-	clkgem4: clkgem4@235004c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem4";
-		reg = <0x0235004c 0xb00>, <0x02350030 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <12>;
-	};
-
-	clkgem5: clkgem5@2350050 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem5";
-		reg = <0x02350050 0xb00>, <0x02350034 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <13>;
-	};
-
-	clkgem6: clkgem6@2350054 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem6";
-		reg = <0x02350054 0xb00>, <0x02350038 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <14>;
-	};
-
-	clkgem7: clkgem7@2350058 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem7";
-		reg = <0x02350058 0xb00>, <0x0235003c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <15>;
-	};
-
-	clkddr31: clkddr31@2350060 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "ddr3-1";
-		reg = <0x02350060 0xb00>, <0x02350040 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <16>;
-	};
-
-	clktac: clktac@2350064 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tac";
-		reg = <0x02350064 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkrac01: clkrac01@2350068 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "rac-01";
-		reg = <0x02350068 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkrac23: clkrac23@235006c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "rac-23";
-		reg = <0x0235006c 0xb00>, <0x02350048 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <18>;
-	};
-
-	clkfftc0: clkfftc0@2350070 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-0";
-		reg = <0x02350070 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <19>;
-	};
-
-	clkfftc1: clkfftc1@2350074 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-1";
-		reg = <0x02350074 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <19>;
-	};
-
-	clkfftc2: clkfftc2@2350078 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-2";
-		reg = <0x02350078 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc3: clkfftc3@235007c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-3";
-		reg = <0x0235007c 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc4: clkfftc4@2350080 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-4";
-		reg = <0x02350080 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkfftc5: clkfftc5@2350084 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-5";
-		reg = <0x02350084 0xb00>, <0x02350050 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <20>;
-	};
-
-	clkaif: clkaif@2350088 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "aif";
-		reg = <0x02350088 0xb00>, <0x02350054 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <21>;
-	};
-
-	clktcp3d0: clktcp3d0@235008c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-0";
-		reg = <0x0235008c 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <22>;
-	};
-
-	clktcp3d1: clktcp3d1@2350090 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-1";
-		reg = <0x02350090 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <22>;
-	};
-
-	clktcp3d2: clktcp3d2@2350094 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-2";
-		reg = <0x02350094 0xb00>, <0x0235005c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <23>;
-	};
-
-	clktcp3d3: clktcp3d3@2350098 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-3";
-		reg = <0x02350098 0xb00>, <0x0235005c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <23>;
-	};
-
-	clkvcp0: clkvcp0@235009c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-0";
-		reg = <0x0235009c 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp1: clkvcp1@23500a0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-1";
-		reg = <0x023500a0 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp2: clkvcp2@23500a4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-2";
-		reg = <0x023500a4 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp3: clkvcp3@23500a8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-3";
-		reg = <0x023500a8 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp4: clkvcp4@23500ac {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-4";
-		reg = <0x023500ac 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp5: clkvcp5@23500b0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-5";
-		reg = <0x023500b0 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp6: clkvcp6@23500b4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-6";
-		reg = <0x023500b4 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkvcp7: clkvcp7@23500b8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-7";
-		reg = <0x023500b8 0xb00>, <0x02350064 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <25>;
-	};
-
-	clkbcp: clkbcp@23500bc {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "bcp";
-		reg = <0x023500bc 0xb00>, <0x02350068 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <26>;
-	};
-
-	clkdxb: clkdxb@23500c0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "dxb";
-		reg = <0x023500c0 0xb00>, <0x0235006c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <27>;
-	};
-
-	clkhyperlink1: clkhyperlink1@23500c4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "hyperlink-1";
-		reg = <0x023500c4 0xb00>, <0x02350070 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <28>;
-	};
-
-	clkxge: clkxge@23500c8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "xge";
-		reg = <0x023500c8 0xb00>, <0x02350074 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <29>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
index 3e38f228a6a..3b3d327562c 100644
--- a/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2hk-evm-u-boot.dtsi
@@ -4,9 +4,19 @@
  */
 
 /{
-	soc {
-		bootph-all;
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
 	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&soc0 {
+	bootph-all;
 };
 
 &i2c1 {
@@ -18,11 +28,9 @@
 	psc-domain = <2>;
 };
 
-&usb {
-	dwc3@2690000 {
-		phys = <&usb_phy>;
-		dr_mode = "host";
-		snps,u2ss_inp3_quirk;
-		status = "okay";
-	};
+&usb0 {
+	phys = <&usb_phy>;
+	dr_mode = "host";
+	snps,u2ss_inp3_quirk;
+	status = "okay";
 };
diff --git a/arch/arm/dts/keystone-k2hk-evm.dts b/arch/arm/dts/keystone-k2hk-evm.dts
deleted file mode 100644
index 6222876f277..00000000000
--- a/arch/arm/dts/keystone-k2hk-evm.dts
+++ /dev/null
@@ -1,180 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Kepler/Hawking EVM device tree
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "keystone.dtsi"
-#include "keystone-k2hk.dtsi"
-
-/ {
-	compatible =  "ti,k2hk-evm","ti,keystone";
-	model = "Texas Instruments Keystone 2 Kepler/Hawking EVM";
-
-	soc {
-		clocks {
-			refclksys: refclksys {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <122880000>;
-				clock-output-names = "refclk-sys";
-			};
-
-			refclkpass: refclkpass {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <122880000>;
-				clock-output-names = "refclk-pass";
-			};
-
-			refclkarm: refclkarm {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <125000000>;
-				clock-output-names = "refclk-arm";
-			};
-
-			refclkddr3a: refclkddr3a {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk-ddr3a";
-			};
-
-			refclkddr3b: refclkddr3b {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk-ddr3b";
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led-debug-1-1 {
-			label = "keystone:green:debug1";
-			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>; /* 12 */
-		};
-
-		led-debug-1-2 {
-			label = "keystone:red:debug1";
-			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>; /* 13 */
-		};
-
-		led-debug-2 {
-			label = "keystone:blue:debug2";
-			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>; /* 14 */
-		};
-
-		led-debug-3 {
-			label = "keystone:blue:debug3";
-			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>; /* 15 */
-		};
-	};
-};
-
-&usb_phy {
-	status = "okay";
-};
-
-&usb {
-	status = "okay";
-};
-
-&aemif {
-	cs0 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		clock-ranges;
-		ranges;
-
-		ti,cs-chipselect = <0>;
-		/* all timings in nanoseconds */
-		ti,cs-min-turnaround-ns = <12>;
-		ti,cs-read-hold-ns = <6>;
-		ti,cs-read-strobe-ns = <23>;
-		ti,cs-read-setup-ns = <9>;
-		ti,cs-write-hold-ns = <8>;
-		ti,cs-write-strobe-ns = <23>;
-		ti,cs-write-setup-ns = <8>;
-
-		nand@0,0 {
-			compatible = "ti,keystone-nand","ti,davinci-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0 0 0x4000000
-			       1 0 0x0000100>;
-
-			ti,davinci-chipselect = <0>;
-			ti,davinci-mask-ale = <0x2000>;
-			ti,davinci-mask-cle = <0x4000>;
-			ti,davinci-mask-chipsel = <0>;
-			nand-ecc-mode = "hw";
-			ti,davinci-ecc-bits = <4>;
-			nand-on-flash-bbt;
-
-			partition@0 {
-				label = "u-boot";
-				reg = <0x0 0x100000>;
-				read-only;
-			};
-
-			partition@100000 {
-				label = "params";
-				reg = <0x100000 0x80000>;
-				read-only;
-			};
-
-			partition@180000 {
-				label = "ubifs";
-				reg = <0x180000 0x1fe80000>;
-			};
-		};
-	};
-};
-
-&i2c0 {
-	dtt@50 {
-		compatible = "at,24c1024";
-		reg = <0x50>;
-	};
-};
-
-&spi0 {
-	status = "okay";
-	nor_flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "Micron,n25q128a11", "jedec,spi-nor";
-		spi-max-frequency = <54000000>;
-		m25p,fast-read;
-		reg = <0>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "misc";
-			reg = <0x80000 0xf80000>;
-		};
-	};
-};
-
-&mdio {
-	status = "okay";
-	ethphy0: ethernet-phy@0 {
-		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
-	};
-
-	ethphy1: ethernet-phy@1 {
-		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2hk-netcp.dtsi b/arch/arm/dts/keystone-k2hk-netcp.dtsi
deleted file mode 100644
index 3f8c4c263a2..00000000000
--- a/arch/arm/dts/keystone-k2hk-netcp.dtsi
+++ /dev/null
@@ -1,207 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for Keystone 2 Hawking Netcp driver
- *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-qmss: qmss@2a40000 {
-	compatible = "ti,keystone-navigator-qmss";
-	dma-coherent;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	clocks = <&chipclk13>;
-	ranges;
-	queue-range = <0 0x4000>;
-	linkram0 = <0x100000 0x8000>;
-	linkram1 = <0x0 0x10000>;
-
-	qmgrs {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		qmgr0 {
-			managed-queues = <0 0x2000>;
-			reg = <0x2a40000 0x20000>,
-			      <0x2a06000 0x400>,
-			      <0x2a02000 0x1000>,
-			      <0x2a03000 0x1000>,
-			      <0x23a80000 0x20000>,
-			      <0x2a80000 0x20000>;
-			reg-names = "peek", "status", "config",
-				    "region", "push", "pop";
-		};
-
-		qmgr1 {
-			managed-queues = <0x2000 0x2000>;
-			reg = <0x2a60000 0x20000>,
-			      <0x2a06400 0x400>,
-			      <0x2a04000 0x1000>,
-			      <0x2a05000 0x1000>,
-			      <0x23aa0000 0x20000>,
-			      <0x2aa0000 0x20000>;
-			reg-names = "peek", "status", "config",
-				    "region", "push", "pop";
-		};
-	};
-
-	queue-pools {
-		qpend {
-			qpend-0 {
-				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
-			};
-			qpend-1 {
-				qrange = <8704 16>;
-				interrupts = <0 48 0xf04 0 49 0xf04 0 50 0xf04
-					      0 51 0xf04 0 52 0xf04 0 53 0xf04
-					      0 54 0xf04 0 55 0xf04 0 56 0xf04
-					      0 57 0xf04 0 58 0xf04 0 59 0xf04
-					      0 60 0xf04 0 61 0xf04 0 62 0xf04
-					      0 63 0xf04>;
-				qalloc-by-id;
-			};
-			qpend-2 {
-				qrange = <8720 16>;
-				interrupts = <0 64 0xf04 0 65 0xf04 0 66 0xf04
-					      0 59 0xf04 0 68 0xf04 0 69 0xf04
-					      0 70 0xf04 0 71 0xf04 0 72 0xf04
-					      0 73 0xf04 0 74 0xf04 0 75 0xf04
-					      0 76 0xf04 0 77 0xf04 0 78 0xf04
-					      0 79 0xf04>;
-			};
-		};
-		general-purpose {
-			gp-0 {
-				qrange = <4000 64>;
-			};
-			netcp-tx {
-				qrange = <640 9>;
-				qalloc-by-id;
-			};
-			netcpx-tx {
-				qrange = <8752 8>;
-				qalloc-by-id;
-			};
-		};
-	};
-
-	descriptor-regions {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		region-12 {
-			id = <12>;
-			region-spec = <8192 128>;	/* num_desc desc_size */
-			link-index = <0x4000>;
-		};
-	};
-}; /* qmss */
-
-knav_dmas: knav_dmas@0 {
-	compatible = "ti,keystone-navigator-dma";
-	clocks = <&papllclk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	ti,navigator-cloud-address = <0x23a80000 0x23a90000
-				   0x23aa0000 0x23ab0000>;
-
-	dma_gbe: dma_gbe@0 {
-		reg = <0x2004000 0x100>,
-			  <0x2004400 0x120>,
-			  <0x2004800 0x300>,
-			  <0x2004c00 0x120>,
-			  <0x2005000 0x400>;
-		reg-names = "global", "txchan", "rxchan",
-				"txsched", "rxflow";
-	};
-};
-
-netcp: netcp@2000000 {
-	reg = <0x2620110 0x8>;
-	reg-names = "efuse";
-	compatible = "ti,netcp-1.0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	/* NetCP address range */
-	ranges = <0 0x2000000 0x100000>;
-
-	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
-	dma-coherent;
-
-	ti,navigator-dmas = <&dma_gbe 22>,
-			<&dma_gbe 23>,
-			<&dma_gbe 8>;
-	ti,navigator-dma-names = "netrx0", "netrx1", "nettx";
-
-	netcp-devices {
-		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		gbe@90000 { /* ETHSS */
-			#address-cells = <1>;
-			#size-cells = <1>;
-			label = "netcp-gbe";
-			compatible = "ti,netcp-gbe";
-			reg = <0x90000 0x300>, <0x90400 0x400>, <0x90800 0x700>;
-			/* enable-ale; */
-			tx-queue = <648>;
-			tx-channel = "nettx";
-
-			interfaces {
-				gbe0: interface-0 {
-					slave-port = <0>;
-					link-interface = <1>;
-					phy-handle = <&ethphy0>;
-				};
-				gbe1: interface-1 {
-					slave-port = <1>;
-					link-interface = <1>;
-					phy-handle = <&ethphy1>;
-				};
-			};
-
-			secondary-slave-ports {
-				port-2 {
-					slave-port = <2>;
-					link-interface = <2>;
-				};
-				port-3 {
-					slave-port = <3>;
-					link-interface = <2>;
-				};
-			};
-		};
-	};
-
-	netcp-interfaces {
-		interface-0 {
-			rx-channel = "netrx0";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <8704>;
-			tx-completion-queue = <8706>;
-			efuse-mac = <1>;
-			netcp-gbe = <&gbe0>;
-
-		};
-		interface-1 {
-			rx-channel = "netrx1";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <8705>;
-			tx-completion-queue = <8707>;
-			efuse-mac = <0>;
-			local-mac-address = [02 18 31 7e 3e 6f];
-			netcp-gbe = <&gbe1>;
-		};
-	};
-};
diff --git a/arch/arm/dts/keystone-k2hk.dtsi b/arch/arm/dts/keystone-k2hk.dtsi
deleted file mode 100644
index e5ab1fbb559..00000000000
--- a/arch/arm/dts/keystone-k2hk.dtsi
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Kepler/Hawking soc specific device tree
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/ {
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		interrupt-parent = <&gic>;
-
-		cpu@0 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <0>;
-		};
-
-		cpu@1 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <1>;
-		};
-
-		cpu@2 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <2>;
-		};
-
-		cpu@3 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <3>;
-		};
-	};
-
-	soc {
-		/include/ "keystone-k2hk-clocks.dtsi"
-
-		dspgpio0: keystone_dsp_gpio@02620240 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x240>;
-		};
-
-		dspgpio1: keystone_dsp_gpio@2620244 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x244>;
-		};
-
-		dspgpio2: keystone_dsp_gpio@2620248 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x248>;
-		};
-
-		dspgpio3: keystone_dsp_gpio@262024c {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x24c>;
-		};
-
-		dspgpio4: keystone_dsp_gpio@2620250 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x250>;
-		};
-
-		dspgpio5: keystone_dsp_gpio@2620254 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x254>;
-		};
-
-		dspgpio6: keystone_dsp_gpio@2620258 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x258>;
-		};
-
-		dspgpio7: keystone_dsp_gpio@262025c {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x25c>;
-		};
-
-		mdio: mdio@02090300 {
-			compatible	= "ti,keystone_mdio", "ti,davinci_mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x02090300 0x100>;
-			status = "disabled";
-			clocks = <&clkcpgmac>;
-			clock-names = "fck";
-			bus_freq	= <2500000>;
-		};
-		/include/ "keystone-k2hk-netcp.dtsi"
-	};
-};
diff --git a/arch/arm/dts/keystone-k2l-clocks.dtsi b/arch/arm/dts/keystone-k2l-clocks.dtsi
deleted file mode 100644
index fcfc2fb6cc2..00000000000
--- a/arch/arm/dts/keystone-k2l-clocks.dtsi
+++ /dev/null
@@ -1,263 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 lamarr SoC clock nodes
- *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-clocks {
-	armpllclk: armpllclk@2620370 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclksys>;
-		clock-output-names = "arm-pll-clk";
-		reg = <0x02620370 4>;
-		reg-names = "control";
-	};
-
-	mainpllclk: mainpllclk@2310110 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclksys>;
-		reg = <0x02620350 4>, <0x02310110 4>, <0x02310108 4>;
-		reg-names = "control", "multiplier", "post-divider";
-	};
-
-	papllclk: papllclk@2620358 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclksys>;
-		clock-output-names = "papllclk";
-		reg = <0x02620358 4>;
-		reg-names = "control";
-	};
-
-	ddr3apllclk: ddr3apllclk@2620360 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclksys>;
-		clock-output-names = "ddr-3a-pll-clk";
-		reg = <0x02620360 4>;
-		reg-names = "control";
-	};
-
-	clkdfeiqnsys: clkdfeiqnsys@2350004 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "dfe";
-		reg-names = "control", "domain";
-		reg = <0x02350004 0xb00>, <0x02350000 0x400>;
-		domain-id = <0>;
-	};
-
-	clkpcie1: clkpcie1@235002c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk12>;
-		clock-output-names = "pcie";
-		reg = <0x0235002c 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <4>;
-	};
-
-	clkgem1: clkgem1@2350040 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem1";
-		reg = <0x02350040 0xb00>, <0x02350024 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <9>;
-	};
-
-	clkgem2: clkgem2@2350044 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem2";
-		reg = <0x02350044 0xb00>, <0x02350028 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <10>;
-	};
-
-	clkgem3: clkgem3@2350048 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk1>;
-		clock-output-names = "gem3";
-		reg = <0x02350048 0xb00>, <0x0235002c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <11>;
-	};
-
-	clktac: clktac@2350064 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tac";
-		reg = <0x02350064 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkrac: clkrac@2350068 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "rac";
-		reg = <0x02350068 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <17>;
-	};
-
-	clkdfepd0: clkdfepd0@235006c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "dfe-pd0";
-		reg = <0x0235006c 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <18>;
-	};
-
-	clkfftc0: clkfftc0@2350070 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-0";
-		reg = <0x02350070 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <19>;
-	};
-
-	clkosr: clkosr@2350088 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "osr";
-		reg = <0x02350088 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <21>;
-	};
-
-	clktcp3d0: clktcp3d0@235008c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-0";
-		reg = <0x0235008c 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <22>;
-	};
-
-	clktcp3d1: clktcp3d1@2350094 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "tcp3d-1";
-		reg = <0x02350094 0xb00>, <0x02350058 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <23>;
-	};
-
-	clkvcp0: clkvcp0@235009c {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-0";
-		reg = <0x0235009c 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp1: clkvcp1@23500a0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-1";
-		reg = <0x023500a0 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp2: clkvcp2@23500a4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-2";
-		reg = <0x023500a4 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkvcp3: clkvcp3@23500a8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "vcp-3";
-		reg = <0x023500a8 0xb00>, <0x02350060 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <24>;
-	};
-
-	clkbcp: clkbcp@23500bc {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "bcp";
-		reg = <0x023500bc 0xb00>, <0x02350068 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <26>;
-	};
-
-	clkdfepd1: clkdfepd1@23500c0 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "dfe-pd1";
-		reg = <0x023500c0 0xb00>, <0x02350044 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <27>;
-	};
-
-	clkfftc1: clkfftc1@23500c4 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "fftc-1";
-		reg = <0x023500c4 0xb00>, <0x023504c0 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <28>;
-	};
-
-	clkiqnail: clkiqnail@23500c8 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&chipclk13>;
-		clock-output-names = "iqn-ail";
-		reg = <0x023500c8 0xb00>, <0x0235004c 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <29>;
-	};
-
-	clkuart2: clkuart2@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "uart2";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-
-	clkuart3: clkuart3@2350000 {
-		#clock-cells = <0>;
-		compatible = "ti,keystone,psc-clock";
-		clocks = <&clkmodrst0>;
-		clock-output-names = "uart3";
-		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
-		reg-names = "control", "domain";
-		domain-id = <0>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi b/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
index f1aed14b0b5..d9dee805ebe 100644
--- a/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
+++ b/arch/arm/dts/keystone-k2l-evm-u-boot.dtsi
@@ -3,16 +3,30 @@
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+/{
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&soc0 {
+	bootph-all;
+};
+
 &usb_phy {
 	#phy-cells = <0>;
 	psc-domain = <2>;
 };
 
-&usb {
-	dwc3@2690000 {
-		phys = <&usb_phy>;
-		dr_mode = "host";
-		snps,u2ss_inp3_quirk;
-		status = "okay";
-	};
+&usb0 {
+	phys = <&usb_phy>;
+	dr_mode = "host";
+	snps,u2ss_inp3_quirk;
+	status = "okay";
 };
diff --git a/arch/arm/dts/keystone-k2l-evm.dts b/arch/arm/dts/keystone-k2l-evm.dts
deleted file mode 100644
index 9d2b4542e81..00000000000
--- a/arch/arm/dts/keystone-k2l-evm.dts
+++ /dev/null
@@ -1,129 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Lamarr EVM device tree
- *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "keystone.dtsi"
-#include "keystone-k2l.dtsi"
-
-/ {
-	compatible =  "ti,k2l-evm","ti,keystone";
-	model = "Texas Instruments Keystone 2 Lamarr EVM";
-
-	soc {
-		clocks {
-			refclksys: refclksys {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <122880000>;
-				clock-output-names = "refclk-sys";
-			};
-		};
-	};
-};
-
-&usb_phy {
-	status = "okay";
-};
-
-&usb {
-	status = "okay";
-};
-
-&i2c0 {
-	dtt@50 {
-		compatible = "at,24c1024";
-		reg = <0x50>;
-	};
-};
-
-&aemif {
-	cs0 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		clock-ranges;
-		ranges;
-
-		ti,cs-chipselect = <0>;
-		/* all timings in nanoseconds */
-		ti,cs-min-turnaround-ns = <12>;
-		ti,cs-read-hold-ns = <6>;
-		ti,cs-read-strobe-ns = <23>;
-		ti,cs-read-setup-ns = <9>;
-		ti,cs-write-hold-ns = <8>;
-		ti,cs-write-strobe-ns = <23>;
-		ti,cs-write-setup-ns = <8>;
-
-		nand@0,0 {
-			compatible = "ti,keystone-nand","ti,davinci-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0 0 0x4000000
-			       1 0 0x0000100>;
-
-			ti,davinci-chipselect = <0>;
-			ti,davinci-mask-ale = <0x2000>;
-			ti,davinci-mask-cle = <0x4000>;
-			ti,davinci-mask-chipsel = <0>;
-			nand-ecc-mode = "hw";
-			ti,davinci-ecc-bits = <4>;
-			nand-on-flash-bbt;
-
-			partition@0 {
-				label = "u-boot";
-				reg = <0x0 0x100000>;
-				read-only;
-			};
-
-			partition@100000 {
-				label = "params";
-				reg = <0x100000 0x80000>;
-				read-only;
-			};
-
-			partition@180000 {
-				label = "ubifs";
-				reg = <0x180000 0x7FE80000>;
-			};
-		};
-	};
-};
-
-&spi0 {
-	status ="okay";
-	nor_flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "Micron,n25q128a11", "jedec,spi-nor";
-		spi-max-frequency = <54000000>;
-		m25p,fast-read;
-		reg = <0>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "misc";
-			reg = <0x80000 0xf80000>;
-		};
-	};
-};
-
-&mdio {
-	status = "okay";
-	ethphy0: ethernet-phy@0 {
-		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
-	};
-
-	ethphy1: ethernet-phy@1 {
-		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
-};
diff --git a/arch/arm/dts/keystone-k2l-netcp.dtsi b/arch/arm/dts/keystone-k2l-netcp.dtsi
deleted file mode 100644
index 2caa0583fc8..00000000000
--- a/arch/arm/dts/keystone-k2l-netcp.dtsi
+++ /dev/null
@@ -1,187 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device Tree Source for Keystone 2 Lamarr Netcp driver
- *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-qmss: qmss@2a40000 {
-	compatible = "ti,keystone-navigator-qmss";
-	dma-coherent;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	clocks = <&chipclk13>;
-	ranges;
-	queue-range = <0 0x2000>;
-	linkram0 = <0x100000 0x4000>;
-	linkram1 = <0x70000000 0x10000>; /* 1MB OSR mem */
-
-	qmgrs {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		qmgr0 {
-			managed-queues = <0 0x2000>;
-			reg = <0x2a40000 0x20000>,
-			      <0x2a06000 0x400>,
-			      <0x2a02000 0x1000>,
-			      <0x2a03000 0x1000>,
-			      <0x23a80000 0x20000>,
-			      <0x2a80000 0x20000>;
-			reg-names = "peek", "status", "config",
-				    "region", "push", "pop";
-		};
-	};
-	queue-pools {
-		qpend {
-			qpend-0 {
-				qrange = <658 8>;
-				interrupts =<0 40 0xf04 0 41 0xf04 0 42 0xf04
-					     0 43 0xf04 0 44 0xf04 0 45 0xf04
-					     0 46 0xf04 0 47 0xf04>;
-			};
-			qpend-1 {
-				qrange = <528 16>;
-				interrupts = <0 48 0xf04 0 49 0xf04 0 50 0xf04
-					      0 51 0xf04 0 52 0xf04 0 53 0xf04
-					      0 54 0xf04 0 55 0xf04 0 56 0xf04
-					      0 57 0xf04 0 58 0xf04 0 59 0xf04
-					      0 60 0xf04 0 61 0xf04 0 62 0xf04
-					      0 63 0xf04>;
-				qalloc-by-id;
-			};
-			qpend-2 {
-				qrange = <544 16>;
-				interrupts = <0 64 0xf04 0 65 0xf04 0 66 0xf04
-					      0 59 0xf04 0 68 0xf04 0 69 0xf04
-					      0 70 0xf04 0 71 0xf04 0 72 0xf04
-					      0 73 0xf04 0 74 0xf04 0 75 0xf04
-					      0 76 0xf04 0 77 0xf04 0 78 0xf04
-					      0 79 0xf04>;
-			};
-		};
-		general-purpose {
-			gp-0 {
-				qrange = <4000 64>;
-			};
-			netcp-tx {
-				qrange = <896 128>;
-				qalloc-by-id;
-			};
-		};
-	};
-
-	descriptor-regions {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		region-12 {
-			id = <12>;
-			region-spec = <8192 128>;	/* num_desc desc_size */
-			link-index = <0x4000>;
-		};
-	};
-}; /* qmss */
-
-knav_dmas: knav_dmas@0 {
-	compatible = "ti,keystone-navigator-dma";
-	clocks = <&papllclk>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	ti,navigator-cloud-address = <0x23a80000 0x23a90000>;
-
-	dma_gbe: dma_gbe@0 {
-		reg = <0x26186000 0x100>,
-			  <0x26187000 0x2a0>,
-			  <0x26188000 0xb60>,
-			  <0x26186100 0x80>,
-			  <0x26189000 0x1000>;
-		reg-names = "global", "txchan", "rxchan",
-				"txsched", "rxflow";
-	};
-};
-
-netcp: netcp@26000000 {
-	reg = <0x2620110 0x8>;
-	reg-names = "efuse";
-	compatible = "ti,netcp-1.0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	/* NetCP address range */
-	ranges = <0 0x26000000 0x1000000>;
-
-	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
-	dma-coherent;
-
-	ti,navigator-dmas = <&dma_gbe 0>,
-			<&dma_gbe 8>,
-			<&dma_gbe 0>;
-	ti,navigator-dma-names = "netrx0", "netrx1", "nettx";
-
-	netcp-devices {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		gbe@200000 { /* ETHSS */
-			label = "netcp-gbe";
-			compatible = "ti,netcp-gbe-5";
-			reg = <0x200000 0x900>, <0x220000 0x20000>;
-			/* enable-ale; */
-			tx-queue = <896>;
-			tx-channel = "nettx";
-
-			interfaces {
-				gbe0: interface-0 {
-					slave-port = <0>;
-					link-interface = <1>;
-					phy-handle = <&ethphy0>;
-				};
-				gbe1: interface-1 {
-					slave-port = <1>;
-					link-interface = <1>;
-					phy-handle = <&ethphy1>;
-				};
-			};
-
-			secondary-slave-ports {
-				port-2 {
-					slave-port = <2>;
-					link-interface = <2>;
-				};
-				port-3 {
-					slave-port = <3>;
-					link-interface = <2>;
-				};
-			};
-		};
-	};
-
-	netcp-interfaces {
-		interface-0 {
-			rx-channel = "netrx0";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <528>;
-			tx-completion-queue = <530>;
-			efuse-mac = <1>;
-			netcp-gbe = <&gbe0>;
-
-		};
-		interface-1 {
-			rx-channel = "netrx1";
-			rx-pool = <1024 12>;
-			tx-pool = <1024 12>;
-			rx-queue-depth = <128 128 0 0>;
-			rx-buffer-size = <1518 4096 0 0>;
-			rx-queue = <529>;
-			tx-completion-queue = <531>;
-			efuse-mac = <0>;
-			local-mac-address = [02 18 31 7e 3e 7f];
-			netcp-gbe = <&gbe1>;
-		};
-	};
-};
diff --git a/arch/arm/dts/keystone-k2l.dtsi b/arch/arm/dts/keystone-k2l.dtsi
deleted file mode 100644
index c8893e284f2..00000000000
--- a/arch/arm/dts/keystone-k2l.dtsi
+++ /dev/null
@@ -1,105 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Keystone 2 Lamarr SoC specific device tree
- *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/ {
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		interrupt-parent = <&gic>;
-
-		cpu@0 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <0>;
-		};
-
-		cpu@1 {
-			compatible = "arm,cortex-a15";
-			device_type = "cpu";
-			reg = <1>;
-		};
-	};
-
-	soc {
-		/include/ "keystone-k2l-clocks.dtsi"
-
-		uart2: serial@2348400 {
-			compatible = "ns16550a";
-			current-speed = <115200>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			reg = <0x02348400 0x100>;
-			clocks = <&clkuart2>;
-			interrupts = <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>;
-		};
-
-		uart3:	serial@2348800 {
-			compatible = "ns16550a";
-			current-speed = <115200>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			reg = <0x02348800 0x100>;
-			clocks = <&clkuart3>;
-			interrupts = <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>;
-		};
-
-		dspgpio0: keystone_dsp_gpio@02620240 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x240>;
-		};
-
-		dspgpio1: keystone_dsp_gpio@2620244 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x244>;
-		};
-
-		dspgpio2: keystone_dsp_gpio@2620248 {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x248>;
-		};
-
-		dspgpio3: keystone_dsp_gpio@262024c {
-			compatible = "ti,keystone-dsp-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio,syscon-dev = <&devctrl 0x24c>;
-		};
-
-		mdio: mdio@26200f00 {
-			compatible = "ti,keystone_mdio", "ti,davinci_mdio";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x26200f00 0x100>;
-			status = "disabled";
-			clocks = <&clkcpgmac>;
-			clock-names = "fck";
-			bus_freq = <2500000>;
-		};
-		/include/ "keystone-k2l-netcp.dtsi"
-	};
-};
-
-&spi0 {
-       ti,davinci-spi-num-cs = <5>;
-};
-
-&spi1 {
-       ti,davinci-spi-num-cs = <3>;
-};
-
-&spi2 {
-       ti,davinci-spi-num-cs = <5>;
-       /* Pin muxed. Enabled and configured by Bootloader */
-       status = "disabled";
-};
diff --git a/arch/arm/dts/keystone.dtsi b/arch/arm/dts/keystone.dtsi
deleted file mode 100644
index 1538ccef81a..00000000000
--- a/arch/arm/dts/keystone.dtsi
+++ /dev/null
@@ -1,330 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/gpio/gpio.h>
-
-#include "skeleton.dtsi"
-
-/ {
-	model = "Texas Instruments Keystone 2 SoC";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&gic>;
-
-	aliases {
-		serial0	= &uart0;
-		spi0 = &spi0;
-		spi1 = &spi1;
-		spi2 = &spi2;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-	};
-
-	chosen {
-		stdout-path = &uart0;
-	};
-
-	memory {
-		reg = <0x80000000 0x40000000>;
-	};
-
-	gic: interrupt-controller {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x02561000 0x1000>,
-		      <0x02562000 0x2000>,
-		      <0x02564000 0x1000>,
-		      <0x02566000 0x2000>;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
-				IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts =
-			<GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a15-pmu";
-		interrupts = <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "ti,keystone","simple-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pllctrl: pll-controller@02310000 {
-			compatible = "ti,keystone-pllctrl", "syscon";
-			reg = <0x02310000 0x200>;
-		};
-
-		devctrl: device-state-control@02620000 {
-			compatible = "ti,keystone-devctrl", "syscon";
-			reg = <0x02620000 0x1000>;
-		};
-
-		rstctrl: reset-controller {
-			compatible = "ti,keystone-reset";
-			ti,syscon-pll = <&pllctrl 0xe4>;
-			ti,syscon-dev = <&devctrl 0x328>;
-			ti,wdt-list = <0>;
-		};
-
-		/include/ "keystone-clocks.dtsi"
-
-		uart0: serial@2530c00 {
-			compatible = "ns16550a";
-			current-speed = <115200>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			reg = <0x02530c00 0x100>;
-			clocks = <&clkuart0>;
-			interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
-		};
-
-		uart1:	serial@2531000 {
-			compatible = "ns16550a";
-			current-speed = <115200>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			reg = <0x02531000 0x100>;
-			clocks = <&clkuart1>;
-			interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
-		};
-
-		i2c0: i2c@2530000 {
-			compatible = "ti,davinci-i2c";
-			reg = <0x02530000 0x400>;
-			clock-frequency = <100000>;
-			clocks = <&clki2c>;
-			interrupts = <GIC_SPI 283 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c1: i2c@2530400 {
-			compatible = "ti,davinci-i2c";
-			reg = <0x02530400 0x400>;
-			clock-frequency = <100000>;
-			clocks = <&clki2c>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c2: i2c@2530800 {
-			compatible = "ti,davinci-i2c";
-			reg = <0x02530800 0x400>;
-			clock-frequency = <100000>;
-			clocks = <&clki2c>;
-			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi0: spi@21000400 {
-			compatible = "ti,dm6441-spi";
-			reg = <0x21000400 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 292 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&clkspi>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi1: spi@21000600 {
-			compatible = "ti,dm6441-spi";
-			reg = <0x21000600 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&clkspi>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi2: spi@21000800 {
-			compatible = "ti,dm6441-spi";
-			reg = <0x21000800 0x200>;
-			num-cs = <4>;
-			ti,davinci-spi-intr-line = <0>;
-			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&clkspi>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		usb_phy: usb_phy@2620738 {
-			compatible = "ti,keystone-usbphy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2620738 24>;
-			status = "disabled";
-		};
-
-		usb: usb@2680000 {
-			compatible = "ti,keystone-dwc3";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2680000 0x10000>;
-			clocks = <&clkusb>;
-			clock-names = "usb";
-			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
-			ranges;
-			dma-coherent;
-			dma-ranges;
-			status = "disabled";
-
-			usb@2690000 {
-				compatible = "synopsys,dwc3";
-				reg = <0x2690000 0x70000>;
-				interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
-				usb-phy = <&usb_phy>, <&usb_phy>;
-			};
-		};
-
-		wdt: wdt@22f0080 {
-			compatible = "ti,keystone-wdt","ti,davinci-wdt";
-			reg = <0x022f0080 0x80>;
-			clocks = <&clkwdtimer0>;
-		};
-
-		clock_event: timer@22f0000 {
-			compatible = "ti,keystone-timer";
-			reg = <0x022f0000 0x80>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&clktimer15>;
-		};
-
-		gpio0: gpio@260bf00 {
-			compatible = "ti,keystone-gpio";
-			reg = <0x0260bf00 0x100>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			/* HW Interrupts mapped to GPIO pins */
-			interrupts = <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 123 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 142 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 143 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 144 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 145 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 146 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 147 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 148 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 150 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&clkgpio>;
-			clock-names = "gpio";
-			ti,ngpio = <32>;
-			ti,davinci-gpio-unbanked = <32>;
-		};
-
-		aemif: aemif@21000A00 {
-			compatible = "ti,keystone-aemif", "ti,davinci-aemif";
-			#address-cells = <2>;
-			#size-cells = <1>;
-			clocks = <&clkaemif>;
-			clock-names = "aemif";
-			clock-ranges;
-
-			reg = <0x21000A00 0x00000100>;
-			ranges = <0 0 0x30000000 0x10000000
-				  1 0 0x21000A00 0x00000100>;
-		};
-
-		kirq0: keystone_irq@26202a0 {
-			compatible = "ti,keystone-irq";
-			interrupts = <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-			ti,syscon-dev = <&devctrl 0x2a0>;
-		};
-
-		pcie0: pcie@21800000 {
-			compatible = "ti,keystone-pcie", "snps,dw-pcie";
-			clocks = <&clkpcie>;
-			clock-names = "pcie";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			reg = <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
-			ranges = <0x81000000 0 0 0x23250000 0 0x4000
-				0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
-
-			status = "disabled";
-			device_type = "pci";
-			num-lanes = <2>;
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie_intc0 0>, /* INT A */
-					<0 0 0 2 &pcie_intc0 1>, /* INT B */
-					<0 0 0 3 &pcie_intc0 2>, /* INT C */
-					<0 0 0 4 &pcie_intc0 3>; /* INT D */
-
-			pcie_msi_intc0: msi-interrupt-controller {
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 32 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 33 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
-			};
-
-			pcie_intc0: legacy-interrupt-controller {
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
-					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-	};
-};
diff --git a/configs/k2e_evm_defconfig b/configs/k2e_evm_defconfig
index 8d6cb240446..f201a175727 100644
--- a/configs/k2e_evm_defconfig
+++ b/configs/k2e_evm_defconfig
@@ -18,7 +18,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2e-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2e-evm"
 CONFIG_SPL_TEXT_BASE=0xC100000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0xc1223f4
@@ -99,3 +99,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2e_hs_evm_defconfig b/configs/k2e_hs_evm_defconfig
index e3c0ae15071..46501d59e09 100644
--- a/configs/k2e_hs_evm_defconfig
+++ b/configs/k2e_hs_evm_defconfig
@@ -15,7 +15,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0fff10
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2e-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2e-evm"
 CONFIG_TIMESTAMP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -73,3 +73,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2g_evm_defconfig b/configs/k2g_evm_defconfig
index 5d54d75f974..57a3d362a1b 100644
--- a/configs/k2g_evm_defconfig
+++ b/configs/k2g_evm_defconfig
@@ -17,7 +17,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc09ff10
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2g-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2g-evm"
 CONFIG_SPL_TEXT_BASE=0xC0A0000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0xc0c23f4
@@ -57,7 +57,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=davinci_nand.0"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="keystone-k2g-generic keystone-k2g-evm keystone-k2g-ice"
+CONFIG_OF_LIST="ti/keystone/keystone-k2g-evm ti/keystone/keystone-k2g-ice"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -109,3 +109,4 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_SDP=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2g_hs_evm_defconfig b/configs/k2g_hs_evm_defconfig
index 9adab3af305..392ec5b2a05 100644
--- a/configs/k2g_hs_evm_defconfig
+++ b/configs/k2g_hs_evm_defconfig
@@ -14,7 +14,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc09ff10
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2g-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2g-evm"
 CONFIG_TIMESTAMP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -33,7 +33,7 @@ CONFIG_BOOTP_DNS2=y
 CONFIG_MTDIDS_DEFAULT="nand0=davinci_nand.0"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="keystone-k2g-generic keystone-k2g-evm keystone-k2g-ice"
+CONFIG_OF_LIST="ti/keystone/keystone-k2g-evm ti/keystone/keystone-k2g-ice"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -84,3 +84,4 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_SDP=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2hk_evm_defconfig b/configs/k2hk_evm_defconfig
index 4da75d1ca76..2e29b2f2aeb 100644
--- a/configs/k2hk_evm_defconfig
+++ b/configs/k2hk_evm_defconfig
@@ -18,7 +18,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2hk-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2hk-evm"
 CONFIG_SPL_TEXT_BASE=0xC200000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0xc2223f4
@@ -100,3 +100,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2hk_hs_evm_defconfig b/configs/k2hk_hs_evm_defconfig
index 1a24d7142b8..cf299f2457c 100644
--- a/configs/k2hk_hs_evm_defconfig
+++ b/configs/k2hk_hs_evm_defconfig
@@ -15,7 +15,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc1fff10
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2hk-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2hk-evm"
 CONFIG_TIMESTAMP=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -74,3 +74,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2l_evm_defconfig b/configs/k2l_evm_defconfig
index c4534f033ac..0cadece4b02 100644
--- a/configs/k2l_evm_defconfig
+++ b/configs/k2l_evm_defconfig
@@ -18,7 +18,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2l-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2l-evm"
 CONFIG_SPL_TEXT_BASE=0xC100000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0xc1223f4
@@ -100,3 +100,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_OF_UPSTREAM=y
diff --git a/configs/k2l_hs_evm_defconfig b/configs/k2l_hs_evm_defconfig
index c874349e942..5496049d3a3 100644
--- a/configs/k2l_hs_evm_defconfig
+++ b/configs/k2l_hs_evm_defconfig
@@ -15,7 +15,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0fff10
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="keystone-k2l-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/keystone/keystone-k2l-evm"
 CONFIG_TIMESTAMP=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
@@ -78,3 +78,4 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_OF_UPSTREAM=y
-- 
2.39.2

