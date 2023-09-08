Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9E9EE8009
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF24786B24;
	Fri,  8 Sep 2023 16:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wktbGsjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AC586410; Fri,  8 Sep 2023 13:07:43 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E4486A27
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B7Ur8092834;
 Fri, 8 Sep 2023 06:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171250;
 bh=fR3YyNtMGcnFKtn+0AgyGb92n/HkC+CduG50vyI7uA8=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=wktbGsjMx36mwg+QLPc5lp8RAMJ7GCK6Cc48e0l5is//eOWwJZTXBkGaGdu3REUvX
 w2d+Wmf2nCBpobFnOXEUXdY+YAYOxTctvSx0a81lkUFnxvkdbP5smiYVsCfy+QfXAG
 1V3O/WspqktC4RvPpqBhCgau3ja7NcWMnLyj5/kg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B7UAh095043
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:07:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:07:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:07:29 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEQ018063;
 Fri, 8 Sep 2023 06:07:23 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 13/16] arm: dts: Introduce am69-sk u-boot dts files
Date: Fri, 8 Sep 2023 16:35:48 +0530
Message-ID: <20230908110551.861575-14-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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
 arch/arm/dts/k3-am69-r5-sk.dts      | 105 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am69-sk-u-boot.dtsi |  25 +++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1bcdbea9e5..bb7ae79745 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1330,7 +1330,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
 			       k3-am68-sk-r5-base-board.dtb\
 			       k3-j721s2-common-proc-board.dtb\
 			       k3-j721s2-r5-common-proc-board.dtb
-dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-sk.dtb\
+dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-r5-sk.dtb\
+			       k3-am69-sk.dtb\
 			       k3-j784s4-evm.dtb\
 			       k3-j784s4-r5-evm.dtb
 dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
new file mode 100644
index 0000000000..8c789c4f28
--- /dev/null
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 0000000000..c8944499e8
--- /dev/null
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-j784s4-binman.dtsi"
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
-- 
2.34.1

