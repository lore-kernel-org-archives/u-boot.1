Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B97C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C1986F6B;
	Mon, 30 Oct 2023 12:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GqK5Hm9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F3487A4B; Mon, 30 Oct 2023 12:01:47 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8938E86EEE
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1frC089477;
 Mon, 30 Oct 2023 06:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698663701;
 bh=SP+Kj5LgsctpkYMI9d1F7vU+07i3hzzH2EWo/miAaxY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GqK5Hm9KAl9F98EjMsdoox1G6RpCqz+gguwkdVizwt/kPC0sH4mA2Irzp86fzhxtH
 cMjhaTsbmW0LvvsDMDU0iz8BTU6foTeewAr8OU8agaX56yQ23j7BpmtArmNk/zrbtt
 E1MiXWHuDOCmjjLRyJ+bZ5FXGKa+zJ4GwA4qD7wQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39UB1f1E032070
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 30 Oct 2023 06:01:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Oct 2023 06:01:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Oct 2023 06:01:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39UB1e7p088303;
 Mon, 30 Oct 2023 06:01:41 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 1/4] arm: dts: Refactor common dtsi file for R5 and A53 SPL
Date: Mon, 30 Oct 2023 16:31:35 +0530
Message-ID: <20231030110138.1347603-2-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030110138.1347603-1-n-yadav@ti.com>
References: <20231030110138.1347603-1-n-yadav@ti.com>
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

Add k3-am62x-r5-sk-common to include nodes common for R5
SPL from k3-am625-r5-sk for AM62x SoC based boards. Add
k3-am62x-sk-common-u-boot to move common nodes of A53 SPL
stage from k3-am625-sk-u-boot.

Replace 'bootph-pre-ram' from 'bootph-all' as it's not available
at u-boot proper before relocation.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm/dts/k3-am625-r5-sk.dts             |  94 +----------------
 arch/arm/dts/k3-am625-sk-u-boot.dtsi        | 110 +-------------------
 arch/arm/dts/k3-am62x-r5-sk-common.dtsi     |  96 +++++++++++++++++
 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi | 109 +++++++++++++++++++
 4 files changed, 211 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62x-r5-sk-common.dtsi
 create mode 100644 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi

diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index bf219226b9..faa7f693a2 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -1,102 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * AM625 SK dts file for R5 SPL
- * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-am625-sk.dts"
 #include "k3-am62x-sk-ddr4-1600MTs.dtsi"
 #include "k3-am62-ddr.dtsi"
 
+#include "k3-am62x-r5-sk-common.dtsi"
 #include "k3-am625-sk-u-boot.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial3 = &main_uart1;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&mcu_esm {
-	bootph-pre-ram;
-};
-
-&secure_proxy_sa3 {
-	bootph-pre-ram;
-	/* We require this for boot handshake */
-	status = "okay";
-};
-
-&main_esm {
-	bootph-pre-ram;
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&wkup_uart0_pins_default {
-	bootph-pre-ram;
-};
-
-&main_uart1_pins_default {
-	bootph-pre-ram;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	bootph-pre-ram;
-};
-
-/* Main UART1 is used for TIFS firmware logs */
-&main_uart1 {
-	bootph-pre-ram;
-};
-
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
-};
diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index c1685bc9ca..1a5238fb11 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -1,102 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common AM625 SK dts file for SPLs
- * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * AM625 SK dts file for SPLs
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-am625-sk-binman.dtsi"
-
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &main_timer0;
-	};
-
-	aliases {
-		mmc1 = &sdhci1;
-	};
-
-	memory@80000000 {
-		bootph-pre-ram;
-	};
-};
-
-&cbass_main {
-	bootph-pre-ram;
-};
-
-&main_timer0 {
-	clock-frequency = <25000000>;
-	bootph-pre-ram;
-};
-
-&dmss {
-	bootph-pre-ram;
-};
-
-&secure_proxy_main {
-	bootph-pre-ram;
-};
-
-&dmsc {
-	bootph-pre-ram;
-};
-
-&k3_pds {
-	bootph-pre-ram;
-};
-
-&k3_clks {
-	bootph-pre-ram;
-};
-
-&k3_reset {
-	bootph-pre-ram;
-};
-
-&wkup_conf {
-	bootph-pre-ram;
-};
-
-&chipid {
-	bootph-pre-ram;
-};
-
-&main_pmx0 {
-	bootph-pre-ram;
-};
+#include "k3-am62x-sk-common-u-boot.dtsi"
 
-&main_uart0 {
-	bootph-pre-ram;
-};
-
-&main_uart0_pins_default {
-	bootph-pre-ram;
-};
-
-&cbass_mcu {
-	bootph-pre-ram;
-};
-
-&cbass_wakeup {
-	bootph-pre-ram;
-};
-
-&mcu_pmx0 {
-	bootph-pre-ram;
-};
-
-&sdhci1 {
-	bootph-pre-ram;
-};
-
-&main_mmc1_pins_default {
-	bootph-pre-ram;
-};
-
-&fss {
-	bootph-pre-ram;
-};
+#include "k3-am625-sk-binman.dtsi"
 
 &ospi0_pins_default {
 	bootph-pre-ram;
@@ -117,15 +27,3 @@
 		};
 	};
 };
-
-&cpsw3g {
-	bootph-pre-ram;
-};
-
-&cpsw_port1 {
-	bootph-pre-ram;
-};
-
-&cpsw_port2 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/k3-am62x-r5-sk-common.dtsi b/arch/arm/dts/k3-am62x-r5-sk-common.dtsi
new file mode 100644
index 0000000000..04f897fc43
--- /dev/null
+++ b/arch/arm/dts/k3-am62x-r5-sk-common.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common SK dts file for R5 SPL
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial3 = &main_uart1;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>;
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&mcu_esm {
+	bootph-pre-ram;
+};
+
+&secure_proxy_sa3 {
+	bootph-pre-ram;
+	/* We require this for boot handshake */
+	status = "okay";
+};
+
+&main_esm {
+	bootph-pre-ram;
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_uart1_pins_default {
+	bootph-pre-ram;
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	bootph-pre-ram;
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	bootph-pre-ram;
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};
diff --git a/arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi b/arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi
new file mode 100644
index 0000000000..628ce6636f
--- /dev/null
+++ b/arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common AM625 SK dts file for SPLs
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	chosen {
+		stdout-path = "serial2:115200n8";
+		tick-timer = &main_timer0;
+	};
+
+	aliases {
+		mmc1 = &sdhci1;
+	};
+
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
+&cbass_main {
+	bootph-all;
+};
+
+&main_timer0 {
+	clock-frequency = <25000000>;
+	bootph-all;
+};
+
+&dmss {
+	bootph-all;
+};
+
+&secure_proxy_main {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+};
+
+&k3_pds {
+	bootph-all;
+};
+
+&k3_clks {
+	bootph-all;
+};
+
+&k3_reset {
+	bootph-all;
+};
+
+&wkup_conf {
+	bootph-all;
+};
+
+&chipid {
+	bootph-all;
+};
+
+&main_pmx0 {
+	bootph-all;
+};
+
+&main_uart0 {
+	bootph-all;
+};
+
+&main_uart0_pins_default {
+	bootph-all;
+};
+
+&cbass_mcu {
+	bootph-all;
+};
+
+&cbass_wakeup {
+	bootph-all;
+};
+
+&mcu_pmx0 {
+	bootph-all;
+};
+
+&sdhci1 {
+	bootph-all;
+};
+
+&main_mmc1_pins_default {
+	bootph-all;
+};
+
+&fss {
+	bootph-all;
+};
+
+&cpsw3g {
+	bootph-all;
+};
+
+&cpsw_port1 {
+	bootph-all;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
-- 
2.25.1

