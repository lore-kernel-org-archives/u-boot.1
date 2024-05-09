Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB51C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0678848C;
	Thu,  9 May 2024 11:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qIDeEQQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BA888470; Thu,  9 May 2024 11:53:44 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C586988494
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4499rcQM031300;
 Thu, 9 May 2024 04:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715248418;
 bh=vK8v5w0dbWkOciD2NxOvLJRWjUI5xLLT3RkXHurRtO8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=qIDeEQQPWqku+ttxpZ/2gyYs7hkVESg+J3Yskqfnv42FanRByK46J6Zknrej7NFJh
 RXoSWo9lNkrfhRNJBa/nc7I6bZ+VF63rFy3ilLha3mNGLaK/yaYi8nO0Hh2h366y/3
 4l+lslUPEdNvCw+VZMcfUFLR7PcKCWqKfO1hW79s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4499rcA5004509
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 04:53:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 04:53:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 04:53:38 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4499rKt5075143;
 Thu, 9 May 2024 04:53:35 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 9 May 2024 15:23:18 +0530
Subject: [PATCH v2 4/6] arch: arm: dts: k3-j721s2-r5: Introduce
 k3-j721s2-r5.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-b4-upstream-j721s2-of-upstream-v2-4-149563cd4901@ti.com>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715248401; l=7284;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Y9wTS+9cAE0jZ028hWIVW6Al3HYDGJL+yG3YFOBS9us=;
 b=ww4nW0ovflhYOvC9NwzywTDBXTcBZfJv63lZIfQSrGrVfSleZlBB/c6Y7UdL1fmq1oHoamZBA
 4ZCs98HgTY6DmOKyy+jvQZOhqCNkjyDAdUdRGjxFT27yT1WOhBBlPY3
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Create an SoC R5 dtsi file that could be used at board level R5 files. This
would help in keeping the SoC level changes in sync across board files.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-r5-base-board.dts       | 78 +-----------------------
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 78 +-----------------------
 arch/arm/dts/k3-j721s2-r5.dtsi                  | 81 +++++++++++++++++++++++++
 board/ti/j721s2/MAINTAINERS                     |  1 +
 4 files changed, 84 insertions(+), 154 deletions(-)

diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
index 038b08dc3e01..3b2d7af2e528 100644
--- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
@@ -9,80 +9,4 @@
 #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
 #include "k3-j721s2-ddr.dtsi"
 #include "k3-am68-sk-base-board-u-boot.dtsi"
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
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>;
-		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
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
-		mboxes= <&secure_proxy_mcu 21>,
-			<&secure_proxy_mcu 23>;
-		bootph-pre-ram;
-	};
-};
-
-&mcu_timer0 {
-	clock-frequency = <250000000>;
-	bootph-pre-ram;
-};
-
-&secure_proxy_mcu {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&secure_proxy_sa3 {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&cbass_mcu_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
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
-};
-
-&mcu_ringacc {
-	ti,sci = <&dm_tifs>;
-};
-
-&mcu_udmap {
-	ti,sci = <&dm_tifs>;
-};
+#include "k3-j721s2-r5.dtsi"
diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index 03bd680f4421..e92b1917df4e 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -9,80 +9,4 @@
 #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
 #include "k3-j721s2-ddr.dtsi"
 #include "k3-j721s2-common-proc-board-u-boot.dtsi"
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
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>;
-		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
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
-		mboxes= <&secure_proxy_mcu 21>,
-			<&secure_proxy_mcu 23>;
-		bootph-pre-ram;
-	};
-};
-
-&mcu_timer0 {
-	clock-frequency = <250000000>;
-	bootph-pre-ram;
-};
-
-&secure_proxy_sa3 {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&secure_proxy_mcu {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&cbass_mcu_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-system-controller";
-		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
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
-};
-
-&mcu_ringacc {
-	ti,sci = <&dm_tifs>;
-};
-
-&mcu_udmap {
-	ti,sci = <&dm_tifs>;
-};
+#include "k3-j721s2-r5.dtsi"
diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
new file mode 100644
index 000000000000..eb0df42583a3
--- /dev/null
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
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
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 202 0>;
+		clocks = <&k3_clks 61 1>;
+		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
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
+		mboxes= <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
+		bootph-pre-ram;
+	};
+};
+
+&mcu_timer0 {
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
+};
+
+&secure_proxy_sa3 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
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
+};
+
+&mcu_ringacc {
+	ti,sci = <&dm_tifs>;
+};
+
+&mcu_udmap {
+	ti,sci = <&dm_tifs>;
+};
diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 08c8d110ac0a..561c3dfff9bd 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -14,6 +14,7 @@ F:	arch/arm/dts/k3-j721s2-thermal.dtsi
 F:	arch/arm/dts/k3-j721s2-som-p0.dtsi
 F:	arch/arm/dts/k3-j721s2-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+F:	arch/arm/dts/k3-j721s2-r5.dtsi
 F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi

-- 
2.43.2

