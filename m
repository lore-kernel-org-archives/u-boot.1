Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C908C46CA0
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 11:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57016875EE;
	Thu, 30 Nov 2023 12:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jtoiZs/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43419875EE; Thu, 30 Nov 2023 12:57:38 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22B7875CC
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUBvRHl021406;
 Thu, 30 Nov 2023 05:57:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701345447;
 bh=BncjEpvdSfcpJwun0LhxCiDKYgxnVFAP5YejzgSbWHM=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=jtoiZs/vJ74voSWFDePfZAjEFTKLYAgHarXIL5SYfIVYBbGHaGHZFY8GkzWK3VKam
 gWtKA15xAdY8L3sPHhjr7CEPrZtfhitq1+R230bD6C2qmVyAfllKA/gKqiY/THwJfm
 a9kTHQWu23WDgEf6+6MVCF3uo3PP5lIDJ4ahAUBQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUBvR6O024686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 05:57:27 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 05:57:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 05:57:27 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AUBtq7Q017236;
 Thu, 30 Nov 2023 05:57:20 -0600
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
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v5 13/17] arm: dts: Introduce am69-sk u-boot dts files
Date: Thu, 30 Nov 2023 17:25:48 +0530
Message-ID: <20231130115552.3580995-14-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130115552.3580995-1-a-nandan@ti.com>
References: <20231130115552.3580995-1-a-nandan@ti.com>
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Introduce the base dts files needed for u-boot or to augment the linux
dtbs for use in the u-boot-spl and u-boot binaries.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/dts/Makefile               |   1 +
 arch/arm/dts/k3-am69-r5-sk.dts      | 105 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am69-sk-u-boot.dtsi |  25 +++++++
 arch/arm/dts/k3-j784s4-binman.dtsi  |  89 +++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b73f8a9230..d966869779 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1409,6 +1409,7 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
 			       k3-j721s2-common-proc-board.dtb\
 			       k3-j721s2-r5-common-proc-board.dtb
 dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-sk.dtb\
+			       k3-am69-r5-sk.dtb\
 			       k3-j784s4-evm.dtb\
 			       k3-j784s4-r5-evm.dtb
 dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
new file mode 100644
index 0000000000..d2e73bd1bf
--- /dev/null
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -0,0 +1,105 @@
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
index 0000000000..d1623b6bbe
--- /dev/null
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
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
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 7349c2ba38..cb699424b9 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -162,8 +162,10 @@
 #ifdef CONFIG_TARGET_J784S4_A72_EVM
 
 #define SPL_J784S4_EVM_DTB "spl/dts/k3-j784s4-evm.dtb"
+#define SPL_AM69_SK_DTB "spl/dts/k3-am69-sk.dtb"
 
 #define J784S4_EVM_DTB "u-boot.dtb"
+#define AM69_SK_DTB "arch/arm/dts/k3-am69-sk.dtb"
 
 &binman {
 	ti-dm {
@@ -205,6 +207,22 @@
 						filename = SPL_J784S4_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&spl_am69_sk_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					spl_am69_sk_dtb: blob-ext {
+						filename = SPL_AM69_SK_DTB;
+					};
+				};
 			};
 
 			configurations {
@@ -216,6 +234,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -250,6 +275,26 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&am69_sk_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					am69_sk_dtb: blob-ext {
+						filename = AM69_SK_DTB;
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -261,6 +306,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -288,6 +340,16 @@
 						filename = SPL_J784S4_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = SPL_AM69_SK_DTB;
+					};
+				};
 			};
 
 			configurations {
@@ -299,6 +361,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -328,6 +397,19 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM69_SK_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -339,6 +421,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
-- 
2.34.1

