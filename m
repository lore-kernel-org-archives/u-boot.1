Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F9CCDDE6A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 10:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7C489328;
	Thu, 24 Oct 2024 12:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cviFrC5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39A588F23; Thu, 24 Oct 2024 12:00:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1958934B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 12:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OA0A8w053065;
 Thu, 24 Oct 2024 05:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729764010;
 bh=tcFPaDm+k6GSMcL//TFLc/4KxknSfGz1go5o/tmV4Ps=;
 h=From:Date:Subject:To:CC;
 b=cviFrC5dmxxptUPY0OZ9bQgP+o2FOz/by6wn27kqRFt08QsjZDNuiq9C1vIx0POog
 ViLmzTHQg7yXiI1PtHwxh9vsGUnDSBryux/QFkWX2vfDkqGUW0kzcfq84lo9T3V21r
 roeiKhtQcGMXMQeOlkurMVu5QvSCu14waWEuOIBk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OA0A1a056516;
 Thu, 24 Oct 2024 05:00:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 05:00:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 05:00:10 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OA083s027884;
 Thu, 24 Oct 2024 05:00:08 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 15:30:04 +0530
Subject: [PATCH] arch: arm: dts: k3-j784s4-r5: Introduce k3-j784s4-r5.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-j784s4-split-v1-1-f1376eed37c5@ti.com>
X-B4-Tracking: v=1; b=H4sIAKQaGmcC/x2M2wpAQBBAf0XzbMquKfIr8rAYjFy2HaTk320eT
 51zHlAOwgpV8kDgS1T2LYJJE+gmt42M0kcGm1kymc2xJTy9HoHdinNRkhKqX+RAZ1uKTm46Joi
 5DzzI/a/r5n0/pk+6fWoAAAA=
X-Change-ID: 20241023-b4-upstream-j784s4-split-a2b424131ce4
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Beleswar Padhi <b-padhi@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729764008; l=8585;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ikKlm9sJbqFuv8000x2B1I3NTcFk2EFknl8OYgBo7wA=;
 b=lO2LwAZ06095OU165QtJ2pK8osrufqCE5oInZO+VyO8MSkytCpmg2rRY4a+kszI8cO9F1v/WU
 zDxrBH9GZ0ICvqF4Bfh7wKOTn7KNT3uTn462JDC3F4u4yPjRDTWfVRV
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Create an SoC R5 dtsi file that could be used at board level R5 files. This
would help in keeping the SoC level changes in sync across board files.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Test logs: https://gist.github.com/manorit2001/108a42ab67e936707f47f71e1d18e90a
---
 arch/arm/dts/k3-am69-r5-sk.dts                     | 125 ++-------------------
 arch/arm/dts/k3-j784s4-r5-evm.dts                  | 125 ++-------------------
 .../{k3-j784s4-r5-evm.dts => k3-j784s4-r5.dtsi}    |   9 +-
 board/ti/j784s4/MAINTAINERS                        |   1 +
 4 files changed, 26 insertions(+), 234 deletions(-)

diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
dissimilarity index 87%
index 13809f82d99a6fc7da1fc2401b33bf0d0bb75548..9c6e324ba299c72f87f5f792fbfe98ef62ebde3d 100644
--- a/arch/arm/dts/k3-am69-r5-sk.dts
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -1,113 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "k3-am69-sk.dts"
-#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
-#include "k3-j784s4-ddr.dtsi"
-#include "k3-am69-sk-u-boot.dtsi"
-
-/ {
-	chosen {
-		tick-timer = &mcu_timer0;
-	};
-
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a72_0;
-	};
-
-	a72_0: a72@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x0 0x00a90000 0x0 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <2000000000>;
-		ti,sci = <&sms>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <3>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_mcu 21>, <&secure_proxy_mcu 23>;
-		bootph-pre-ram;
-	};
-};
-
-&mcu_timer0 {
-	status = "okay";
-	clock-frequency = <250000000>;
-	bootph-pre-ram;
-};
-
-&secure_proxy_sa3 {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&secure_proxy_mcu {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&cbass_mcu_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&secure_proxy_mcu 4>,
-			<&secure_proxy_mcu 5>,
-			<&secure_proxy_sa3 5>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&sms {
-	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
-	mbox-names = "tx", "rx", "notify";
-	ti,host-id = <4>;
-	ti,secure-host;
-	bootph-pre-ram;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&ospi0 {
-	reg = <0x0 0x47040000 0x0 0x100>,
-	      <0x0 0x50000000 0x0 0x8000000>;
-};
-
-&ospi1 {
-	reg = <0x0 0x47050000 0x0 0x100>,
-	      <0x0 0x58000000 0x0 0x8000000>;
-};
-
-&fss {
-	/* enable ranges missing from the FSS node */
-	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
-	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
-};
-
-&mcu_ringacc {
-	ti,sci = <&dm_tifs>;
-};
-
-&mcu_udmap {
-	ti,sci = <&dm_tifs>;
-};
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
+#include "k3-j784s4-r5.dtsi"
diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
dissimilarity index 87%
index 8b8b0e70047e6c7538eee6e39f4fca182796f751..0eeffa7874035697d28f37507b3c3feb03a10acd 100644
--- a/arch/arm/dts/k3-j784s4-r5-evm.dts
+++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
@@ -1,113 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "k3-j784s4-evm.dts"
-#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
-#include "k3-j784s4-ddr.dtsi"
-#include "k3-j784s4-evm-u-boot.dtsi"
-
-/ {
-	chosen {
-		tick-timer = &mcu_timer0;
-	};
-
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a72_0;
-	};
-
-	a72_0: a72@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x0 0x00a90000 0x0 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <2000000000>;
-		ti,sci = <&sms>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <3>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_mcu 21>, <&secure_proxy_mcu 23>;
-		bootph-pre-ram;
-	};
-};
-
-&mcu_timer0 {
-	status = "okay";
-	clock-frequency = <250000000>;
-	bootph-pre-ram;
-};
-
-&secure_proxy_sa3 {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&secure_proxy_mcu {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&cbass_mcu_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&secure_proxy_mcu 4>,
-			<&secure_proxy_mcu 5>,
-			<&secure_proxy_sa3 5>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&sms {
-	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
-	mbox-names = "tx", "rx", "notify";
-	ti,host-id = <4>;
-	ti,secure-host;
-	bootph-pre-ram;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&ospi0 {
-	reg = <0x0 0x47040000 0x0 0x100>,
-	      <0x0 0x50000000 0x0 0x8000000>;
-};
-
-&ospi1 {
-	reg = <0x0 0x47050000 0x0 0x100>,
-	      <0x0 0x58000000 0x0 0x8000000>;
-};
-
-&fss {
-	/* enable ranges missing from the FSS node */
-	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
-	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
-};
-
-&mcu_ringacc {
-	ti,sci = <&dm_tifs>;
-};
-
-&mcu_udmap {
-	ti,sci = <&dm_tifs>;
-};
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-j784s4-evm.dts"
+#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
+#include "k3-j784s4-ddr.dtsi"
+#include "k3-j784s4-evm-u-boot.dtsi"
+#include "k3-j784s4-r5.dtsi"
diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5.dtsi
similarity index 90%
copy from arch/arm/dts/k3-j784s4-r5-evm.dts
copy to arch/arm/dts/k3-j784s4-r5.dtsi
index 8b8b0e70047e6c7538eee6e39f4fca182796f751..0cd0ccc2dea0379971595faa1076b20aa3606492 100644
--- a/arch/arm/dts/k3-j784s4-r5-evm.dts
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -3,13 +3,6 @@
  * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-/dts-v1/;
-
-#include "k3-j784s4-evm.dts"
-#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
-#include "k3-j784s4-ddr.dtsi"
-#include "k3-j784s4-evm-u-boot.dtsi"
-
 / {
 	chosen {
 		tick-timer = &mcu_timer0;
@@ -101,7 +94,7 @@
 &fss {
 	/* enable ranges missing from the FSS node */
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
-	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+		 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
 
 &mcu_ringacc {
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index b7605ff335b9085b30a9874e95e8f303c84a0444..e92e8d03cb3eba26298390b1a79f08145cf8ff9d 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -8,6 +8,7 @@ F:	configs/j784s4_evm_r5_defconfig
 F:	configs/j784s4_evm_a72_defconfig
 F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j784s4-r5-evm.dts
+F:	arch/arm/dts/k3-j784s4-r5.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
 F:	doc/board/ti/j784s4_evm.rst

---
base-commit: 392ff1449f7d30cc48fd4d17320d05882cd68f2e
change-id: 20241023-b4-upstream-j784s4-split-a2b424131ce4

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

