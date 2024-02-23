Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED127C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD8E87BFE;
	Fri, 23 Feb 2024 21:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z9lx/pU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47308879FC; Fri, 23 Feb 2024 21:24:44 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F8687C00
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 21:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NKOJGe119347;
 Fri, 23 Feb 2024 14:24:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708719859;
 bh=ihcuRv2K5WWUEG9fdBN0hgMtWrKaXergILDQXIQ17Bs=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=Z9lx/pU3OXfez/cntDYiozwG2SW5Def9eeJR6FZIUznscRfs42wQxsBGTROW71zS5
 A3hy3HXgtUkNdHQFqvYr7AV7kai4wljS5N+UEK+N+lGGrHfdwWXojkTxvY9XbEjFRM
 uHTpeKIN108yvotQT1OzUvYKEEoH79JQiaE/zYWc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NKOJ14038613
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 14:24:19 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 14:24:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 14:24:18 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NKLsQl104070; 
 Fri, 23 Feb 2024 14:24:07 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, Bryan
 Brattlof <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Bhavya Kapoor <b-kapoor@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jayesh Choudhary <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v10 12/15] arm: dts: Introduce am69-sk u-boot dts files
Date: Sat, 24 Feb 2024 01:51:50 +0530
Message-ID: <20240223202153.3756094-13-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223202153.3756094-1-a-nandan@ti.com>
References: <20240223202153.3756094-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Introduce the base dts files needed for u-boot or to augment the linux
dtbs for use in the u-boot-spl and u-boot binaries.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/dts/Makefile               |   3 +-
 arch/arm/dts/k3-am69-r5-sk.dts      | 106 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am69-sk-u-boot.dtsi |  54 ++++++++++++++
 board/ti/j784s4/MAINTAINERS         |   6 ++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e484112dd7c..e3a47d055b0 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1413,7 +1413,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
 			       k3-j721s2-common-proc-board.dtb\
 			       k3-j721s2-r5-common-proc-board.dtb
 
-dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-r5-evm.dtb
+dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-r5-sk.dtb \
+			       k3-j784s4-r5-evm.dtb
 
 dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
 			      k3-am642-r5-evm.dtb \
diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
new file mode 100644
index 00000000000..f177f563527
--- /dev/null
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am69-sk.dts"
+#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
+#include "k3-j784s4-ddr.dtsi"
+#include "k3-am69-sk-u-boot.dtsi"
+
+/ {
+	chosen {
+		tick-timer = &mcu_timer0;
+	};
+
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a72_0;
+	};
+
+	a72_0: a72@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x0 0x00a90000 0x0 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 202 0>;
+		clocks = <&k3_clks 61 0>;
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <2000000000>;
+		ti,sci = <&sms>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <3>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_mcu 21>, <&secure_proxy_mcu 23>;
+		bootph-pre-ram;
+	};
+};
+
+&mcu_timer0 {
+	status = "okay";
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
+};
+
+&secure_proxy_sa3 {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&secure_proxy_mcu {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>,
+			<&secure_proxy_mcu 5>,
+			<&secure_proxy_sa3 5>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&sms {
+	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
+	mbox-names = "tx", "rx", "notify";
+	ti,host-id = <4>;
+	ti,secure-host;
+	bootph-pre-ram;
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&ospi0 {
+	reg = <0x0 0x47040000 0x0 0x100>,
+	      <0x0 0x50000000 0x0 0x8000000>;
+};
+
+&ospi1 {
+	reg = <0x0 0x47050000 0x0 0x100>,
+	      <0x0 0x58000000 0x0 0x8000000>;
+};
+
+&mcu_ringacc {
+	ti,sci = <&dm_tifs>;
+};
+
+&mcu_udmap {
+	ti,sci = <&dm_tifs>;
+};
diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
new file mode 100644
index 00000000000..bed330e6d4e
--- /dev/null
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-j784s4-binman.dtsi"
+
+/ {
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
+&mcu_udmap {
+	reg =   <0x0 0x285c0000 0x0 0x100>,
+		<0x0 0x284c0000 0x0 0x4000>,
+		<0x0 0x2a800000 0x0 0x40000>,
+		<0x0 0x284a0000 0x0 0x4000>,
+		<0x0 0x2aa00000 0x0 0x40000>,
+		<0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+		    "tchanrt", "rflow";
+	bootph-pre-ram;
+};
+
+&sms {
+	k3_sysreset: sysreset-controller {
+		compatible = "ti,sci-sysreset";
+		bootph-pre-ram;
+	};
+};
+
+#ifdef CONFIG_TARGET_J784S4_A72_EVM
+
+#define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
+#define AM69_SK_DTB "u-boot.dtb"
+
+&spl_j784s4_evm_dtb {
+	filename = SPL_AM69_SK_DTB;
+};
+
+&j784s4_evm_dtb {
+	filename = AM69_SK_DTB;
+};
+
+&spl_j784s4_evm_dtb_unsigned {
+	filename = SPL_AM69_SK_DTB;
+};
+
+&j784s4_evm_dtb_unsigned {
+	filename = AM69_SK_DTB;
+};
+
+#endif
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index ff00cc60868..8b03a7adb1e 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -8,3 +8,9 @@ F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j784s4-r5-evm.dts
 F:	arch/arm/dts/k3-j784s4-ddr.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+
+AM69 SK BOARD
+M:	Apurva Nandan <a-nandan@ti.com>
+S:	Maintained
+F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
+F:	arch/arm/dts/k3-am69-r5-sk.dts
-- 
2.34.1

