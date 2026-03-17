Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D5BFD875A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B524184277;
	Tue, 17 Mar 2026 13:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="S3YbOZYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9C784285; Tue, 17 Mar 2026 13:31:31 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B6C8426C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CLBhOxt5Q9a6R5kLkolQQq0M/JUXYfS6RttblMVj8IE=; b=S3YbOZYGIOAMlZ0PXpFpp/ItNW
 pd5AHquUaAv2iu/1Vh4QnWMIJrCQFFzSni6Zo3hRFpPc3++8ALtz+jvemhQkbQj1vnpAVwGiUDQLz
 +S6I+plwrXLkSHkOpkz0edzK+rEiWxHQrbU1JSqcByWKOQxIZQ1pJkfD7Vz+Py+IXzJjB3o0twioS
 E8zSKj2hIRA5UqkoJTT1md1vzvS7ZKuWOG7VIyOkK+JrCN3ozu0n7VUcIL+H+XdobvmMdtJROZY6E
 udLYFwEPJ1vBaJIJAPXHd6Xt5hLuqV6hoKHvIQ1+r5wN1N60YngGBrCx9j5cevPzxLnBP/hI7qkhX
 yGxVpWOQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54360
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1w2Ta5-0000000DUuO-1cyy; Tue, 17 Mar 2026 13:31:26 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>,
 Teresa Remmet <t.remmet@phytec.de>
Cc: uboot-imx@nxp.com,
	upstream@lists.phytec.de,
	u-boot@lists.denx.de
Subject: [PATCH] board: phytec: phycore-imx91-93: Add phyCORE-i.MX91 support
Date: Tue, 17 Mar 2026 13:31:26 +0100
Message-Id: <20260317123126.2132269-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

As the PHYTEC phyCORE-i.MX91 [1] is just another variant of the existing
PHYTEC phyCORE-i.MX93 SoM but with i.MX91 SoC populated instead, add it
to the existing board-code "phycore_imx93", and rename that board to
"phycore_imx91_93" to reflect the dual SoCs support. While at it, also
rename and change common files accordingly. This way i.MX91 and i.MX93
SoC variants of the phyCORE SoM share most of the code and documentation
without duplication, while maintaining own device-tree and defconfigs
for each CPU variant.

Supported features:
 - 1GB LPDDR4 RAM
 - Debug UART
 - EEPROM
 - eMMC
 - Ethernet
 - SD-card
 - USB

Product page SoM:
[1] https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 ...imx91-93-phyboard-segin-common-u-boot.dtsi |  228 ++
 arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi |   18 +
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  221 +-
 arch/arm/mach-imx/imx9/Kconfig                |   10 +-
 arch/arm/mach-imx/imx9/soc.c                  |    3 +-
 board/phytec/common/Kconfig                   |    6 +-
 board/phytec/common/Makefile                  |    2 +-
 ...m_detection.c => imx91_93_som_detection.c} |   39 +-
 board/phytec/common/imx91_93_som_detection.h  |   51 +
 board/phytec/common/imx93_som_detection.h     |   51 -
 board/phytec/phycore_imx91_93/Kconfig         |   47 +
 board/phytec/phycore_imx91_93/MAINTAINERS     |   16 +
 .../Makefile                                  |    9 +-
 .../phycore_imx91_93/lpddr4_timing_imx91.c    | 1998 +++++++++++++++++
 .../lpddr4_timing_imx93.c}                    |    0
 .../phycore-imx91-93.c}                       |    8 +-
 .../phycore_imx91_93.env}                     |    2 +
 .../{phycore_imx93 => phycore_imx91_93}/spl.c |   46 +-
 board/phytec/phycore_imx93/Kconfig            |   41 -
 board/phytec/phycore_imx93/MAINTAINERS        |   12 -
 configs/imx91-phycore_defconfig               |  167 ++
 configs/imx93-phycore_defconfig               |    2 +-
 ...imx93-phycore.rst => imx91-93-phycore.rst} |   38 +-
 doc/board/phytec/index.rst                    |    2 +-
 .../{phycore_imx93.h => phycore_imx91_93.h}   |    6 +-
 25 files changed, 2637 insertions(+), 386 deletions(-)
 create mode 100644 arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi
 rename board/phytec/common/{imx93_som_detection.c => imx91_93_som_detection.c} (56%)
 create mode 100644 board/phytec/common/imx91_93_som_detection.h
 delete mode 100644 board/phytec/common/imx93_som_detection.h
 create mode 100644 board/phytec/phycore_imx91_93/Kconfig
 create mode 100644 board/phytec/phycore_imx91_93/MAINTAINERS
 rename board/phytec/{phycore_imx93 => phycore_imx91_93}/Makefile (58%)
 create mode 100644 board/phytec/phycore_imx91_93/lpddr4_timing_imx91.c
 rename board/phytec/{phycore_imx93/lpddr4_timing.c => phycore_imx91_93/lpddr4_timing_imx93.c} (100%)
 rename board/phytec/{phycore_imx93/phycore-imx93.c => phycore_imx91_93/phycore-imx91-93.c} (90%)
 rename board/phytec/{phycore_imx93/phycore_imx93.env => phycore_imx91_93/phycore_imx91_93.env} (94%)
 rename board/phytec/{phycore_imx93 => phycore_imx91_93}/spl.c (75%)
 delete mode 100644 board/phytec/phycore_imx93/Kconfig
 delete mode 100644 board/phytec/phycore_imx93/MAINTAINERS
 create mode 100644 configs/imx91-phycore_defconfig
 rename doc/board/phytec/{imx93-phycore.rst => imx91-93-phycore.rst} (52%)
 rename include/configs/{phycore_imx93.h => phycore_imx91_93.h} (88%)

diff --git a/arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi b/arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi
new file mode 100644
index 000000000000..64ed7af99463
--- /dev/null
+++ b/arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ *
+ */
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog3>;
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc0", "mmc1", "ethernet";
+
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+
+&{/soc@0} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-pre-ram;
+	bootph-all;
+};
+
+&aips2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&iomuxc {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&reg_usdhc2_vmmc {
+	u-boot,off-on-delay-us = <20000>;
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_pmic {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc2_cd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc2_default {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&lpi2c1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpi2c2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpi2c3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	pmic@25 {
+		bootph-pre-ram;
+		bootph-some-ram;
+
+		regulators {
+			bootph-pre-ram;
+			bootph-some-ram;
+		};
+	};
+
+	eeprom@50 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
+
+&s4muap {
+	bootph-pre-ram;
+	bootph-some-ram;
+	status = "okay";
+};
+
+&clk {
+	bootph-all;
+	bootph-pre-ram;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};
+
+&osc_32k {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&osc_24m {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	bootph-all;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi
new file mode 100644
index 000000000000..5d788854de5b
--- /dev/null
+++ b/arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ *
+ */
+
+#include "imx91-u-boot.dtsi"
+#include "imx91-93-phyboard-segin-common-u-boot.dtsi"
+
+/ {
+	/*
+	 * The phyCORE-i.MX91 u-boot uses the imx91-phyboard-segin.dts as
+	 * reference, but does only make use of its SoM (phyCORE) contained
+	 * periphery.
+	 */
+	model = "PHYTEC phyCORE-i.MX91";
+};
diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 646b617949d6..b80ce20e9425 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "imx93-u-boot.dtsi"
+#include "imx91-93-phyboard-segin-common-u-boot.dtsi"
 
 / {
 	/*
@@ -17,224 +18,4 @@
 	 * periphery.
 	 */
 	model = "PHYTEC phyCORE-i.MX93";
-
-	wdt-reboot {
-		compatible = "wdt-reboot";
-		wdt = <&wdog3>;
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-
-	aliases {
-		ethernet0 = &fec;
-		ethernet1 = &eqos;
-	};
-
-	bootstd {
-		bootph-verify;
-		compatible = "u-boot,boot-std";
-
-		filename-prefixes = "/", "/boot/";
-		bootdev-order = "mmc0", "mmc1", "ethernet";
-
-		rauc {
-			compatible = "u-boot,distro-rauc";
-		};
-
-		script {
-			compatible = "u-boot,script";
-		};
-	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-};
-
-&{/soc@0} {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&aips1 {
-	bootph-pre-ram;
-	bootph-all;
-};
-
-&aips2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&aips3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&iomuxc {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&reg_usdhc2_vmmc {
-	u-boot,off-on-delay-us = <20000>;
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_lpi2c3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_pmic {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_reg_usdhc2_vmmc {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc1_100mhz {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc1_200mhz {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc2_cd {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc2_default {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc2_100mhz {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&pinctrl_usdhc2_200mhz {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&gpio4 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpuart1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&usdhc1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&usdhc2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-	fsl,signal-voltage-switch-extra-delay-ms = <8>;
-};
-
-&lpi2c1 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpi2c2 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
-&lpi2c3 {
-	bootph-pre-ram;
-	bootph-some-ram;
-
-	pmic@25 {
-		bootph-pre-ram;
-		bootph-some-ram;
-
-		regulators {
-			bootph-pre-ram;
-			bootph-some-ram;
-		};
-	};
-
-	eeprom@50 {
-		bootph-pre-ram;
-		bootph-some-ram;
-	};
-};
-
-&s4muap {
-	bootph-pre-ram;
-	bootph-some-ram;
-	status = "okay";
-};
-
-&clk {
-	bootph-all;
-	bootph-pre-ram;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-rates;
-	/delete-property/ assigned-clock-parents;
-};
-
-&osc_32k {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&osc_24m {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&clk_ext1 {
-	bootph-all;
-	bootph-pre-ram;
-};
-
-&wdog3 {
-	bootph-all;
-	bootph-pre-ram;
 };
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c9..48ac16664d7a 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -120,6 +120,14 @@ config TARGET_KONTRON_MX93
 	  Kontron Electronics BL i.MX93 using SoM module conformant to OSM
 	  standard 1.1 size S.
 
+config TARGET_PHYCORE_IMX91
+	bool "phycore_imx91"
+	select IMX91
+	select IMX9_LPDDR4X
+	imply OF_UPSTREAM
+	select OF_BOARD_FIXUP
+	select OF_BOARD_SETUP
+
 config TARGET_PHYCORE_IMX93
 	bool "phycore_imx93"
 	select IMX93
@@ -161,7 +169,7 @@ source "board/nxp/imx93_evk/Kconfig"
 source "board/nxp/imx93_frdm/Kconfig"
 source "board/nxp/imx93_qsb/Kconfig"
 source "board/kontron/osm-s-mx93/Kconfig"
-source "board/phytec/phycore_imx93/Kconfig"
+source "board/phytec/phycore_imx91_93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 583c3a5a464b..44b3e0f53101 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -664,7 +664,8 @@ int low_drive_freq_update(void *blob)
 	return 0;
 }
 
-#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_TARGET_PHYCORE_IMX93)
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_TARGET_PHYCORE_IMX93) && \
+	!defined(CONFIG_TARGET_PHYCORE_IMX91)
 #ifndef CONFIG_XPL_BUILD
 int board_fix_fdt(void *fdt)
 {
diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index a72f66ee3f58..6afd03086f7a 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -19,13 +19,13 @@ config PHYTEC_IMX8M_SOM_DETECTION
 	  Support of I2C EEPROM based SoM detection. Supported
 	  for PHYTEC i.MX8MM/i.MX8MP boards
 
-config PHYTEC_IMX93_SOM_DETECTION
-	bool "Support SoM detection for i.MX93 PHYTEC platforms"
+config PHYTEC_IMX91_93_SOM_DETECTION
+	bool "Support SoM detection for i.MX91/93 PHYTEC platforms"
 	depends on ARCH_IMX9 && PHYTEC_SOM_DETECTION
 	default y
 	help
 	  Support of I2C EEPROM based SoM detection. Supported
-	  for PHYTEC i.MX93 based boards
+	  for PHYTEC i.MX91/93 based boards
 
 config PHYTEC_AM62_SOM_DETECTION
 	bool "Support SoM detection for AM62x PHYTEC platforms"
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 948f9dab626e..e09dea01d49c 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -10,4 +10,4 @@ endif
 obj-y += phytec_som_detection.o phytec_som_detection_blocks.o
 obj-$(CONFIG_ARCH_K3) += am6_som_detection.o k3/
 obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
-obj-$(CONFIG_ARCH_IMX9) += imx93_som_detection.o
+obj-$(CONFIG_ARCH_IMX9) += imx91_93_som_detection.o
diff --git a/board/phytec/common/imx93_som_detection.c b/board/phytec/common/imx91_93_som_detection.c
similarity index 56%
rename from board/phytec/common/imx93_som_detection.c
rename to board/phytec/common/imx91_93_som_detection.c
index eb9574d43b58..bcc5500ae9f7 100644
--- a/board/phytec/common/imx93_som_detection.c
+++ b/board/phytec/common/imx91_93_som_detection.c
@@ -10,18 +10,19 @@
 #include <i2c.h>
 #include <u-boot/crc.h>
 
-#include "imx93_som_detection.h"
+#include "imx91_93_som_detection.h"
 
 extern struct phytec_eeprom_data eeprom_data;
 
-#if IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION)
+#if IS_ENABLED(CONFIG_PHYTEC_IMX91_93_SOM_DETECTION)
 
 /* Check if the SoM is actually one of the following products:
+ * - i.MX91
  * - i.MX93
  *
  * Returns 0 in case it's a known SoM. Otherwise, returns 1.
  */
-u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_imx91_93_detect(struct phytec_eeprom_data *data)
 {
 	u8 som;
 
@@ -35,7 +36,7 @@ u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
 	som = data->payload.data.data_api2.som_no;
 	debug("%s: som id: %u\n", __func__, som);
 
-	if (som == PHYTEC_IMX93_SOM && is_imx93())
+	if (som == PHYTEC_IMX91_93_SOM && (is_imx91() || is_imx93()))
 		return 0;
 
 	pr_err("%s: SoM ID does not match. Wrong EEPROM data?\n", __func__);
@@ -43,15 +44,15 @@ u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
 }
 
 /*
- * Filter PHYTEC i.MX93 SoM options by option index
+ * Filter PHYTEC i.MX91/93 SoM options by option index
  *
  * Returns:
  *  - option value
  *  - PHYTEC_EEPROM_INVAL when the data is invalid
  *
  */
-u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
-				       enum phytec_imx93_option_index idx)
+u8 __maybe_unused phytec_imx91_93_get_opt(struct phytec_eeprom_data *data,
+					  enum phytec_imx91_93_option_index idx)
 {
 	char *opt;
 	u8 opt_id;
@@ -73,39 +74,41 @@ u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
 }
 
 /*
- * Filter PHYTEC i.MX93 SoM voltage
+ * Filter PHYTEC i.MX91/93 SoM voltage
  *
  * Returns:
- *  - PHYTEC_IMX93_VOLTAGE_1V8 or PHYTEC_IMX93_VOLTAGE_3V3
+ *  - PHYTEC_IMX91_93_VOLTAGE_1V8 or PHYTEC_IMX91_93_VOLTAGE_3V3
  *  - PHYTEC_EEPROM_INVAL when the data is invalid
  *
  */
-enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage(struct phytec_eeprom_data *data)
+enum phytec_imx91_93_voltage __maybe_unused
+phytec_imx91_93_get_voltage(struct phytec_eeprom_data *data)
 {
-	u8 option = phytec_imx93_get_opt(data, PHYTEC_IMX93_OPT_FEAT);
+	u8 option = phytec_imx91_93_get_opt(data, PHYTEC_IMX91_93_OPT_FEAT);
 
 	if (option == PHYTEC_EEPROM_INVAL)
-		return PHYTEC_IMX93_VOLTAGE_INVALID;
-	return (option & 0x01) ? PHYTEC_IMX93_VOLTAGE_1V8 : PHYTEC_IMX93_VOLTAGE_3V3;
+		return PHYTEC_IMX91_93_VOLTAGE_INVALID;
+	return (option & 0x01) ? PHYTEC_IMX91_93_VOLTAGE_1V8 :
+				 PHYTEC_IMX91_93_VOLTAGE_3V3;
 }
 
 #else
 
-inline u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_imx91_93_detect(struct phytec_eeprom_data *data)
 {
 	return 1;
 }
 
-inline u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
-					      enum phytec_imx93_option_index idx)
+inline u8 __maybe_unused phytec_imx91_93_get_opt(struct phytec_eeprom_data *data,
+						 enum phytec_imx91_93_option_index idx)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
+inline enum phytec_imx91_93_voltage __maybe_unused phytec_imx91_93_get_voltage
 	(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX93_SOM_DETECTION) */
+#endif /* IS_ENABLED(CONFIG_PHYTEC_IMX91_93_SOM_DETECTION) */
diff --git a/board/phytec/common/imx91_93_som_detection.h b/board/phytec/common/imx91_93_som_detection.h
new file mode 100644
index 000000000000..05ea4cf08682
--- /dev/null
+++ b/board/phytec/common/imx91_93_som_detection.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#ifndef _PHYTEC_IMX91_93_SOM_DETECTION_H
+#define _PHYTEC_IMX91_93_SOM_DETECTION_H
+
+#include "phytec_som_detection.h"
+
+#define PHYTEC_IMX91_93_SOM	77
+
+enum phytec_imx91_93_option_index {
+	PHYTEC_IMX91_93_OPT_DDR = 0,
+	PHYTEC_IMX91_93_OPT_EMMC = 1,
+	PHYTEC_IMX91_93_OPT_CPU = 2,
+	PHYTEC_IMX91_93_OPT_FREQ = 3,
+	PHYTEC_IMX91_93_OPT_NPU = 4,
+	PHYTEC_IMX91_93_OPT_DISP = 5,
+	PHYTEC_IMX91_93_OPT_ETH = 6,
+	PHYTEC_IMX91_93_OPT_FEAT = 7,
+	PHYTEC_IMX91_93_OPT_TEMP = 8,
+	PHYTEC_IMX91_93_OPT_BOOT = 9,
+	PHYTEC_IMX91_93_OPT_LED = 10,
+	PHYTEC_IMX91_93_OPT_EEPROM = 11,
+};
+
+enum phytec_imx91_93_voltage {
+	PHYTEC_IMX91_93_VOLTAGE_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX91_93_VOLTAGE_3V3 = 0,
+	PHYTEC_IMX91_93_VOLTAGE_1V8 = 1,
+};
+
+enum phytec_imx91_93_ddr_eeprom_code {
+	PHYTEC_IMX91_93_DDR_INVALID = PHYTEC_EEPROM_INVAL,
+	PHYTEC_IMX91_93_LPDDR4X_512MB = 0,
+	PHYTEC_IMX91_93_LPDDR4X_1GB = 1,
+	PHYTEC_IMX91_93_LPDDR4X_2GB = 2,
+	PHYTEC_IMX91_93_LPDDR4_512MB = 3,
+	PHYTEC_IMX91_93_LPDDR4_1GB = 4,
+	PHYTEC_IMX91_93_LPDDR4_2GB = 5,
+};
+
+u8 __maybe_unused phytec_imx91_93_detect(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_imx91_93_get_opt(struct phytec_eeprom_data *data,
+					  enum phytec_imx91_93_option_index idx);
+enum phytec_imx91_93_voltage __maybe_unused phytec_imx91_93_get_voltage
+	(struct phytec_eeprom_data *data);
+
+#endif /* _PHYTEC_IMX91_93_SOM_DETECTION_H */
diff --git a/board/phytec/common/imx93_som_detection.h b/board/phytec/common/imx93_som_detection.h
deleted file mode 100644
index a0803b47cbe8..000000000000
--- a/board/phytec/common/imx93_som_detection.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2024 PHYTEC Messtechnik GmbH
- * Author: Primoz Fiser <primoz.fiser@norik.com>
- */
-
-#ifndef _PHYTEC_IMX93_SOM_DETECTION_H
-#define _PHYTEC_IMX93_SOM_DETECTION_H
-
-#include "phytec_som_detection.h"
-
-#define PHYTEC_IMX93_SOM	77
-
-enum phytec_imx93_option_index {
-	PHYTEC_IMX93_OPT_DDR = 0,
-	PHYTEC_IMX93_OPT_EMMC = 1,
-	PHYTEC_IMX93_OPT_CPU = 2,
-	PHYTEC_IMX93_OPT_FREQ = 3,
-	PHYTEC_IMX93_OPT_NPU = 4,
-	PHYTEC_IMX93_OPT_DISP = 5,
-	PHYTEC_IMX93_OPT_ETH = 6,
-	PHYTEC_IMX93_OPT_FEAT = 7,
-	PHYTEC_IMX93_OPT_TEMP = 8,
-	PHYTEC_IMX93_OPT_BOOT = 9,
-	PHYTEC_IMX93_OPT_LED = 10,
-	PHYTEC_IMX93_OPT_EEPROM = 11,
-};
-
-enum phytec_imx93_voltage {
-	PHYTEC_IMX93_VOLTAGE_INVALID = PHYTEC_EEPROM_INVAL,
-	PHYTEC_IMX93_VOLTAGE_3V3 = 0,
-	PHYTEC_IMX93_VOLTAGE_1V8 = 1,
-};
-
-enum phytec_imx93_ddr_eeprom_code {
-	PHYTEC_IMX93_DDR_INVALID = PHYTEC_EEPROM_INVAL,
-	PHYTEC_IMX93_LPDDR4X_512MB = 0,
-	PHYTEC_IMX93_LPDDR4X_1GB = 1,
-	PHYTEC_IMX93_LPDDR4X_2GB = 2,
-	PHYTEC_IMX93_LPDDR4_512MB = 3,
-	PHYTEC_IMX93_LPDDR4_1GB = 4,
-	PHYTEC_IMX93_LPDDR4_2GB = 5,
-};
-
-u8 __maybe_unused phytec_imx93_detect(struct phytec_eeprom_data *data);
-u8 __maybe_unused phytec_imx93_get_opt(struct phytec_eeprom_data *data,
-				       enum phytec_imx93_option_index idx);
-enum phytec_imx93_voltage __maybe_unused phytec_imx93_get_voltage
-	(struct phytec_eeprom_data *data);
-
-#endif /* _PHYTEC_IMX93_SOM_DETECTION_H */
diff --git a/board/phytec/phycore_imx91_93/Kconfig b/board/phytec/phycore_imx91_93/Kconfig
new file mode 100644
index 000000000000..87fd915e5a84
--- /dev/null
+++ b/board/phytec/phycore_imx91_93/Kconfig
@@ -0,0 +1,47 @@
+
+if TARGET_PHYCORE_IMX91 || TARGET_PHYCORE_IMX93
+
+config SYS_BOARD
+	default "phycore_imx91_93"
+
+config SYS_VENDOR
+	default "phytec"
+
+config SYS_CONFIG_NAME
+	default "phycore_imx91_93"
+
+config PHYCORE_IMX91_93_RAM_TYPE_FIX
+	bool "Set phyCORE-i.MX91/93 RAM type and size fix instead of detecting"
+	default false
+	help
+	  RAM type and size is being automatically detected with the help
+	  of the PHYTEC EEPROM introspection data.
+	  Set RAM type to a fix value instead.
+
+choice
+	prompt "phyCORE-i.MX91/93 RAM type"
+	depends on PHYCORE_IMX91_93_RAM_TYPE_FIX
+	default PHYCORE_IMX91_93_RAM_TYPE_LPDDR4X_1GB
+
+config PHYCORE_IMX91_93_RAM_TYPE_LPDDR4_1GB
+	bool "LPDDR4 1GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4 and RAM size fixed to 1GB
+	  for phyCORE-i.MX91/93.
+
+config PHYCORE_IMX91_93_RAM_TYPE_LPDDR4X_1GB
+	bool "LPDDR4X 1GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 1GB
+	  for phyCORE-i.MX91/93.
+
+config PHYCORE_IMX91_93_RAM_TYPE_LPDDR4X_2GB
+	bool "LPDDR4X 2GB RAM"
+	help
+	  Set RAM type fixed to LPDDR4X and RAM size fixed to 2GB
+	  for phyCORE-i.MX91/93.
+
+endchoice
+
+source "board/phytec/common/Kconfig"
+endif
diff --git a/board/phytec/phycore_imx91_93/MAINTAINERS b/board/phytec/phycore_imx91_93/MAINTAINERS
new file mode 100644
index 000000000000..573d1c36a5e1
--- /dev/null
+++ b/board/phytec/phycore_imx91_93/MAINTAINERS
@@ -0,0 +1,16 @@
+phyCORE-i.MX91/93
+M:      Mathieu Othacehe <m.othacehe@gmail.com>
+R:      Christoph Stoidner <c.stoidner@phytec.de>
+L:      upstream@lists.phytec.de
+W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
+S:      Maintained
+F:      arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi
+F:      arch/arm/dts/imx91-phyboard-segin-u-boot.dtsi
+F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+F:      board/phytec/phycore_imx91_93/
+F:      board/phytec/common/imx91_93_som_detection.c
+F:      board/phytec/common/imx91_93_som_detection.h
+F:      configs/imx91-phycore_defconfig
+F:      configs/imx93-phycore_defconfig
+F:      include/configs/phycore_imx91_93.h
+F:      doc/board/phytec/imx91-93-phycore.rst
diff --git a/board/phytec/phycore_imx93/Makefile b/board/phytec/phycore_imx91_93/Makefile
similarity index 58%
rename from board/phytec/phycore_imx93/Makefile
rename to board/phytec/phycore_imx91_93/Makefile
index dd5085e160f1..976ecb306f75 100644
--- a/board/phytec/phycore_imx93/Makefile
+++ b/board/phytec/phycore_imx91_93/Makefile
@@ -7,8 +7,13 @@
 # SPDX-License-Identifier:      GPL-2.0+
 #
 
-obj-y += phycore-imx93.o
+obj-y += phycore-imx91-93.o
 
 ifdef CONFIG_XPL_BUILD
-obj-y += spl.o lpddr4_timing.o
+obj-y += spl.o
+ifdef CONFIG_IMX91
+obj-$(CONFIG_IMX9_LPDDR4X) += lpddr4_timing_imx91.o
+else
+obj-$(CONFIG_IMX9_LPDDR4X) += lpddr4_timing_imx93.o
+endif
 endif
diff --git a/board/phytec/phycore_imx91_93/lpddr4_timing_imx91.c b/board/phytec/phycore_imx91_93/lpddr4_timing_imx91.c
new file mode 100644
index 000000000000..ddc8094f0803
--- /dev/null
+++ b/board/phytec/phycore_imx91_93/lpddr4_timing_imx91.c
@@ -0,0 +1,1998 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2024 NXP
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Christoph Stoidner <c.stoidner@phytec.de>
+ *
+ * Code generated with DDR Tool v3.3.0_1.8-d1cdb7d3.
+ * DDR PHY FW2022.01
+ */
+
+#include <linux/kernel.h>
+#include <asm/arch/ddr.h>
+
+/* Initialize DDRC registers */
+static struct dram_cfg_param ddr_ddrc_cfg[] = {
+	{0x4e300110, 0x44100001},
+	{0x4e300000, 0x8000bf},
+	{0x4e300008, 0x0},
+	{0x4e300080, 0x80000412},
+	{0x4e300084, 0x0},
+	{0x4e300114, 0x1002},
+	{0x4e300260, 0x80},
+	{0x4e300f04, 0x80},
+	{0x4e300800, 0x43b30002},
+	{0x4e300804, 0x1f1f1f1f},
+	{0x4e301000, 0x0},
+	{0x4e301240, 0x0},
+	{0x4e301244, 0x0},
+	{0x4e301248, 0x0},
+	{0x4e30124c, 0x0},
+	{0x4e301250, 0x0},
+	{0x4e301254, 0x0},
+	{0x4e301258, 0x0},
+	{0x4e30125c, 0x0},
+};
+
+/* dram fsp cfg */
+static struct dram_fsp_cfg ddr_dram_fsp_cfg[] = {
+	{
+		{
+			{0x4e300100, 0x13542110},
+			{0x4e300104, 0xF8990011},
+			{0x4e300108, 0x636E88CC},
+			{0x4e30010C, 0x00614070},
+			{0x4e300124, 0x124E0000},
+			{0x4e300160, 0x00009102},
+			{0x4e30016C, 0x31D00000},
+			{0x4e300170, 0x8B0B0608},
+			{0x4e300250, 0x0000001A},
+			{0x4e300254, 0x00A000A0},
+			{0x4e300258, 0x00000008},
+			{0x4e30025C, 0x00000400},
+			{0x4e300300, 0x1633160D},
+			{0x4e300304, 0x00A0180C},
+			{0x4e300308, 0x0C280927},
+		},
+		{
+			{0x01, 0xC4},
+			{0x02, 0x24},
+			{0x03, 0x23},
+			{0x0b, 0x44},
+			{0x0c, 0x49},
+			{0x0e, 0x4A},
+			{0x16, 0x04},
+		},
+		0,
+	},
+	{
+		{
+			{0x4e300100, 0x010A1100},
+			{0x4e300104, 0xF855000A},
+			{0x4e300108, 0xBABA0068},
+			{0x4e30010C, 0x00610158},
+			{0x4e300124, 0x09270000},
+			{0x4e300160, 0x00009102},
+			{0x4e30016C, 0x30400000},
+			{0x4e300170, 0x8A0A0508},
+			{0x4e300250, 0x0000000D},
+			{0x4e300254, 0x004C004C},
+			{0x4e300258, 0x00000008},
+			{0x4e30025C, 0x00000400},
+		},
+		{
+			{0x01, 0xA4},
+			{0x02, 0x52},
+			{0x03, 0x23},
+			{0x0b, 0x44},
+			{0x0c, 0x49},
+			{0x0e, 0x4A},
+			{0x16, 0x04},
+		},
+		0,
+	},
+	{
+		{
+			{0x4e300100, 0x00051000},
+			{0x4e300104, 0xF855000A},
+			{0x4e300108, 0x6E620A48},
+			{0x4e30010C, 0x0031010D},
+			{0x4e300124, 0x04C50000},
+			{0x4e300160, 0x00009102},
+			{0x4e30016C, 0x30000000},
+			{0x4e300170, 0x89090408},
+			{0x4e300250, 0x00000007},
+			{0x4e300254, 0x00240024},
+			{0x4e300258, 0x00000008},
+			{0x4e30025C, 0x00000400},
+		},
+		{
+			{0x01, 0x94},
+			{0x02, 0x9},
+			{0x03, 0x23},
+			{0x0b, 0x44},
+			{0x0c, 0x49},
+			{0x0e, 0x4A},
+			{0x16, 0x04},
+		},
+		1,
+	},
+
+};
+
+/* PHY Initialize Configuration */
+static struct dram_cfg_param ddr_ddrphy_cfg[] = {
+	{0x100a0, 0x0},
+	{0x100a1, 0x1},
+	{0x100a2, 0x2},
+	{0x100a3, 0x3},
+	{0x100a4, 0x4},
+	{0x100a5, 0x5},
+	{0x100a6, 0x6},
+	{0x100a7, 0x7},
+	{0x110a0, 0x0},
+	{0x110a1, 0x1},
+	{0x110a2, 0x2},
+	{0x110a3, 0x3},
+	{0x110a4, 0x4},
+	{0x110a5, 0x5},
+	{0x110a6, 0x6},
+	{0x110a7, 0x7},
+	{0x1005f, 0x1ff},
+	{0x1015f, 0x1ff},
+	{0x1105f, 0x1ff},
+	{0x1115f, 0x1ff},
+	{0x11005f, 0x1ff},
+	{0x11015f, 0x1ff},
+	{0x11105f, 0x1ff},
+	{0x11115f, 0x1ff},
+	{0x21005f, 0x1ff},
+	{0x21015f, 0x1ff},
+	{0x21105f, 0x1ff},
+	{0x21115f, 0x1ff},
+	{0x55, 0x1ff},
+	{0x1055, 0x1ff},
+	{0x2055, 0x1ff},
+	{0x200c5, 0xa},
+	{0x1200c5, 0x2},
+	{0x2200c5, 0x7},
+	{0x2002e, 0x2},
+	{0x12002e, 0x1},
+	{0x22002e, 0x2},
+	{0x90204, 0x0},
+	{0x190204, 0x0},
+	{0x290204, 0x0},
+	{0x20024, 0x1e3},
+	{0x2003a, 0x2},
+	{0x2007d, 0x212},
+	{0x2007c, 0x61},
+	{0x120024, 0x1e3},
+	{0x2003a, 0x2},
+	{0x12007d, 0x212},
+	{0x12007c, 0x61},
+	{0x220024, 0x1e3},
+	{0x2003a, 0x2},
+	{0x22007d, 0x212},
+	{0x22007c, 0x61},
+	{0x20056, 0x3},
+	{0x120056, 0x3},
+	{0x220056, 0x3},
+	{0x1004d, 0x600},
+	{0x1014d, 0x600},
+	{0x1104d, 0x600},
+	{0x1114d, 0x600},
+	{0x11004d, 0x600},
+	{0x11014d, 0x600},
+	{0x11104d, 0x600},
+	{0x11114d, 0x600},
+	{0x21004d, 0x600},
+	{0x21014d, 0x600},
+	{0x21104d, 0x600},
+	{0x21114d, 0x600},
+	{0x10049, 0x61f},
+	{0x10149, 0x61f},
+	{0x11049, 0x61f},
+	{0x11149, 0x61f},
+	{0x110049, 0x61f},
+	{0x110149, 0x61f},
+	{0x111049, 0x61f},
+	{0x111149, 0x61f},
+	{0x210049, 0x61f},
+	{0x210149, 0x61f},
+	{0x211049, 0x61f},
+	{0x211149, 0x61f},
+	{0x43, 0x7f},
+	{0x1043, 0x7f},
+	{0x2043, 0x7f},
+	{0x20018, 0x1},
+	{0x20075, 0x4},
+	{0x20050, 0x11},
+	{0x2009b, 0x2},
+	{0x20008, 0x258},
+	{0x120008, 0x12c},
+	{0x220008, 0x9c},
+	{0x20088, 0x9},
+	{0x200b2, 0x104},
+	{0x10043, 0x5a1},
+	{0x10143, 0x5a1},
+	{0x11043, 0x5a1},
+	{0x11143, 0x5a1},
+	{0x1200b2, 0x104},
+	{0x110043, 0x5a1},
+	{0x110143, 0x5a1},
+	{0x111043, 0x5a1},
+	{0x111143, 0x5a1},
+	{0x2200b2, 0x104},
+	{0x210043, 0x5a1},
+	{0x210143, 0x5a1},
+	{0x211043, 0x5a1},
+	{0x211143, 0x5a1},
+	{0x200fa, 0x2},
+	{0x1200fa, 0x2},
+	{0x2200fa, 0x2},
+	{0x20019, 0x1},
+	{0x120019, 0x1},
+	{0x220019, 0x1},
+	{0x200f0, 0x600},
+	{0x200f1, 0x0},
+	{0x200f2, 0x4444},
+	{0x200f3, 0x8888},
+	{0x200f4, 0x5655},
+	{0x200f5, 0x0},
+	{0x200f6, 0x0},
+	{0x200f7, 0xf000},
+	{0x1004a, 0x500},
+	{0x1104a, 0x500},
+	{0x20025, 0x0},
+	{0x2002d, 0x0},
+	{0x12002d, 0x0},
+	{0x22002d, 0x0},
+	{0x2002c, 0x0},
+	{0x20021, 0x0},
+	{0x200c7, 0x21},
+	{0x1200c7, 0x41},
+	{0x200ca, 0x24},
+	{0x1200ca, 0x24},
+};
+
+/* PHY trained csr */
+static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
+	{0x1005f, 0x0},
+	{0x1015f, 0x0},
+	{0x1105f, 0x0},
+	{0x1115f, 0x0},
+	{0x11005f, 0x0},
+	{0x11015f, 0x0},
+	{0x11105f, 0x0},
+	{0x11115f, 0x0},
+	{0x21005f, 0x0},
+	{0x21015f, 0x0},
+	{0x21105f, 0x0},
+	{0x21115f, 0x0},
+	{0x55, 0x0},
+	{0x1055, 0x0},
+	{0x2055, 0x0},
+	{0x200c5, 0x0},
+	{0x1200c5, 0x0},
+	{0x2200c5, 0x0},
+	{0x2002e, 0x0},
+	{0x12002e, 0x0},
+	{0x22002e, 0x0},
+	{0x90204, 0x0},
+	{0x190204, 0x0},
+	{0x290204, 0x0},
+	{0x20024, 0x0},
+	{0x2003a, 0x0},
+	{0x2007d, 0x0},
+	{0x2007c, 0x0},
+	{0x120024, 0x0},
+	{0x12007d, 0x0},
+	{0x12007c, 0x0},
+	{0x220024, 0x0},
+	{0x22007d, 0x0},
+	{0x22007c, 0x0},
+	{0x20056, 0x0},
+	{0x120056, 0x0},
+	{0x220056, 0x0},
+	{0x1004d, 0x0},
+	{0x1014d, 0x0},
+	{0x1104d, 0x0},
+	{0x1114d, 0x0},
+	{0x11004d, 0x0},
+	{0x11014d, 0x0},
+	{0x11104d, 0x0},
+	{0x11114d, 0x0},
+	{0x21004d, 0x0},
+	{0x21014d, 0x0},
+	{0x21104d, 0x0},
+	{0x21114d, 0x0},
+	{0x10049, 0x0},
+	{0x10149, 0x0},
+	{0x11049, 0x0},
+	{0x11149, 0x0},
+	{0x110049, 0x0},
+	{0x110149, 0x0},
+	{0x111049, 0x0},
+	{0x111149, 0x0},
+	{0x210049, 0x0},
+	{0x210149, 0x0},
+	{0x211049, 0x0},
+	{0x211149, 0x0},
+	{0x43, 0x0},
+	{0x1043, 0x0},
+	{0x2043, 0x0},
+	{0x20018, 0x0},
+	{0x20075, 0x0},
+	{0x20050, 0x0},
+	{0x2009b, 0x0},
+	{0x20008, 0x0},
+	{0x120008, 0x0},
+	{0x220008, 0x0},
+	{0x20088, 0x0},
+	{0x200b2, 0x0},
+	{0x10043, 0x0},
+	{0x10143, 0x0},
+	{0x11043, 0x0},
+	{0x11143, 0x0},
+	{0x1200b2, 0x0},
+	{0x110043, 0x0},
+	{0x110143, 0x0},
+	{0x111043, 0x0},
+	{0x111143, 0x0},
+	{0x2200b2, 0x0},
+	{0x210043, 0x0},
+	{0x210143, 0x0},
+	{0x211043, 0x0},
+	{0x211143, 0x0},
+	{0x200fa, 0x0},
+	{0x1200fa, 0x0},
+	{0x2200fa, 0x0},
+	{0x20019, 0x0},
+	{0x120019, 0x0},
+	{0x220019, 0x0},
+	{0x200f0, 0x0},
+	{0x200f1, 0x0},
+	{0x200f2, 0x0},
+	{0x200f3, 0x0},
+	{0x200f4, 0x0},
+	{0x200f5, 0x0},
+	{0x200f6, 0x0},
+	{0x200f7, 0x0},
+	{0x1004a, 0x0},
+	{0x1104a, 0x0},
+	{0x20025, 0x0},
+	{0x2002d, 0x0},
+	{0x12002d, 0x0},
+	{0x22002d, 0x0},
+	{0x2002c, 0x0},
+	{0xd0000, 0x0},
+	{0x90000, 0x0},
+	{0x90001, 0x0},
+	{0x90002, 0x0},
+	{0x90003, 0x0},
+	{0x90004, 0x0},
+	{0x90005, 0x0},
+	{0x90029, 0x0},
+	{0x9002a, 0x0},
+	{0x9002b, 0x0},
+	{0x9002c, 0x0},
+	{0x9002d, 0x0},
+	{0x9002e, 0x0},
+	{0x9002f, 0x0},
+	{0x90030, 0x0},
+	{0x90031, 0x0},
+	{0x90032, 0x0},
+	{0x90033, 0x0},
+	{0x90034, 0x0},
+	{0x90035, 0x0},
+	{0x90036, 0x0},
+	{0x90037, 0x0},
+	{0x90038, 0x0},
+	{0x90039, 0x0},
+	{0x9003a, 0x0},
+	{0x9003b, 0x0},
+	{0x9003c, 0x0},
+	{0x9003d, 0x0},
+	{0x9003e, 0x0},
+	{0x9003f, 0x0},
+	{0x90040, 0x0},
+	{0x90041, 0x0},
+	{0x90042, 0x0},
+	{0x90043, 0x0},
+	{0x90044, 0x0},
+	{0x90045, 0x0},
+	{0x90046, 0x0},
+	{0x90047, 0x0},
+	{0x90048, 0x0},
+	{0x90049, 0x0},
+	{0x9004a, 0x0},
+	{0x9004b, 0x0},
+	{0x9004c, 0x0},
+	{0x9004d, 0x0},
+	{0x9004e, 0x0},
+	{0x9004f, 0x0},
+	{0x90050, 0x0},
+	{0x90051, 0x0},
+	{0x90052, 0x0},
+	{0x90053, 0x0},
+	{0x90054, 0x0},
+	{0x90055, 0x0},
+	{0x90056, 0x0},
+	{0x90057, 0x0},
+	{0x90058, 0x0},
+	{0x90059, 0x0},
+	{0x9005a, 0x0},
+	{0x9005b, 0x0},
+	{0x9005c, 0x0},
+	{0x9005d, 0x0},
+	{0x9005e, 0x0},
+	{0x9005f, 0x0},
+	{0x90060, 0x0},
+	{0x90061, 0x0},
+	{0x90062, 0x0},
+	{0x90063, 0x0},
+	{0x90064, 0x0},
+	{0x90065, 0x0},
+	{0x90066, 0x0},
+	{0x90067, 0x0},
+	{0x90068, 0x0},
+	{0x90069, 0x0},
+	{0x9006a, 0x0},
+	{0x9006b, 0x0},
+	{0x9006c, 0x0},
+	{0x9006d, 0x0},
+	{0x9006e, 0x0},
+	{0x9006f, 0x0},
+	{0x90070, 0x0},
+	{0x90071, 0x0},
+	{0x90072, 0x0},
+	{0x90073, 0x0},
+	{0x90074, 0x0},
+	{0x90075, 0x0},
+	{0x90076, 0x0},
+	{0x90077, 0x0},
+	{0x90078, 0x0},
+	{0x90079, 0x0},
+	{0x9007a, 0x0},
+	{0x9007b, 0x0},
+	{0x9007c, 0x0},
+	{0x9007d, 0x0},
+	{0x9007e, 0x0},
+	{0x9007f, 0x0},
+	{0x90080, 0x0},
+	{0x90081, 0x0},
+	{0x90082, 0x0},
+	{0x90083, 0x0},
+	{0x90084, 0x0},
+	{0x90085, 0x0},
+	{0x90086, 0x0},
+	{0x90087, 0x0},
+	{0x90088, 0x0},
+	{0x90089, 0x0},
+	{0x9008a, 0x0},
+	{0x9008b, 0x0},
+	{0x9008c, 0x0},
+	{0x9008d, 0x0},
+	{0x9008e, 0x0},
+	{0x9008f, 0x0},
+	{0x90090, 0x0},
+	{0x90091, 0x0},
+	{0x90092, 0x0},
+	{0x90093, 0x0},
+	{0x90094, 0x0},
+	{0x90095, 0x0},
+	{0x90096, 0x0},
+	{0x90097, 0x0},
+	{0x90098, 0x0},
+	{0x90099, 0x0},
+	{0x9009a, 0x0},
+	{0x9009b, 0x0},
+	{0x9009c, 0x0},
+	{0x9009d, 0x0},
+	{0x9009e, 0x0},
+	{0x9009f, 0x0},
+	{0x900a0, 0x0},
+	{0x900a1, 0x0},
+	{0x900a2, 0x0},
+	{0x900a3, 0x0},
+	{0x900a4, 0x0},
+	{0x900a5, 0x0},
+	{0x900a6, 0x0},
+	{0x900a7, 0x0},
+	{0x900a8, 0x0},
+	{0x900a9, 0x0},
+	{0x40000, 0x0},
+	{0x40020, 0x0},
+	{0x40040, 0x0},
+	{0x40060, 0x0},
+	{0x40001, 0x0},
+	{0x40021, 0x0},
+	{0x40041, 0x0},
+	{0x40061, 0x0},
+	{0x40002, 0x0},
+	{0x40022, 0x0},
+	{0x40042, 0x0},
+	{0x40062, 0x0},
+	{0x40003, 0x0},
+	{0x40023, 0x0},
+	{0x40043, 0x0},
+	{0x40063, 0x0},
+	{0x40004, 0x0},
+	{0x40024, 0x0},
+	{0x40044, 0x0},
+	{0x40064, 0x0},
+	{0x40005, 0x0},
+	{0x40025, 0x0},
+	{0x40045, 0x0},
+	{0x40065, 0x0},
+	{0x40006, 0x0},
+	{0x40026, 0x0},
+	{0x40046, 0x0},
+	{0x40066, 0x0},
+	{0x40007, 0x0},
+	{0x40027, 0x0},
+	{0x40047, 0x0},
+	{0x40067, 0x0},
+	{0x40008, 0x0},
+	{0x40028, 0x0},
+	{0x40048, 0x0},
+	{0x40068, 0x0},
+	{0x40009, 0x0},
+	{0x40029, 0x0},
+	{0x40049, 0x0},
+	{0x40069, 0x0},
+	{0x4000a, 0x0},
+	{0x4002a, 0x0},
+	{0x4004a, 0x0},
+	{0x4006a, 0x0},
+	{0x4000b, 0x0},
+	{0x4002b, 0x0},
+	{0x4004b, 0x0},
+	{0x4006b, 0x0},
+	{0x4000c, 0x0},
+	{0x4002c, 0x0},
+	{0x4004c, 0x0},
+	{0x4006c, 0x0},
+	{0x4000d, 0x0},
+	{0x4002d, 0x0},
+	{0x4004d, 0x0},
+	{0x4006d, 0x0},
+	{0x4000e, 0x0},
+	{0x4002e, 0x0},
+	{0x4004e, 0x0},
+	{0x4006e, 0x0},
+	{0x4000f, 0x0},
+	{0x4002f, 0x0},
+	{0x4004f, 0x0},
+	{0x4006f, 0x0},
+	{0x40010, 0x0},
+	{0x40030, 0x0},
+	{0x40050, 0x0},
+	{0x40070, 0x0},
+	{0x40011, 0x0},
+	{0x40031, 0x0},
+	{0x40051, 0x0},
+	{0x40071, 0x0},
+	{0x40012, 0x0},
+	{0x40032, 0x0},
+	{0x40052, 0x0},
+	{0x40072, 0x0},
+	{0x40013, 0x0},
+	{0x40033, 0x0},
+	{0x40053, 0x0},
+	{0x40073, 0x0},
+	{0x40014, 0x0},
+	{0x40034, 0x0},
+	{0x40054, 0x0},
+	{0x40074, 0x0},
+	{0x40015, 0x0},
+	{0x40035, 0x0},
+	{0x40055, 0x0},
+	{0x40075, 0x0},
+	{0x40016, 0x0},
+	{0x40036, 0x0},
+	{0x40056, 0x0},
+	{0x40076, 0x0},
+	{0x40017, 0x0},
+	{0x40037, 0x0},
+	{0x40057, 0x0},
+	{0x40077, 0x0},
+	{0x40018, 0x0},
+	{0x40038, 0x0},
+	{0x40058, 0x0},
+	{0x40078, 0x0},
+	{0x40019, 0x0},
+	{0x40039, 0x0},
+	{0x40059, 0x0},
+	{0x40079, 0x0},
+	{0x4001a, 0x0},
+	{0x4003a, 0x0},
+	{0x4005a, 0x0},
+	{0x4007a, 0x0},
+	{0x900aa, 0x0},
+	{0x900ab, 0x0},
+	{0x900ac, 0x0},
+	{0x900ad, 0x0},
+	{0x900ae, 0x0},
+	{0x900af, 0x0},
+	{0x900b0, 0x0},
+	{0x900b1, 0x0},
+	{0x900b2, 0x0},
+	{0x900b3, 0x0},
+	{0x900b4, 0x0},
+	{0x900b5, 0x0},
+	{0x900b6, 0x0},
+	{0x900b7, 0x0},
+	{0x900b8, 0x0},
+	{0x900b9, 0x0},
+	{0x900ba, 0x0},
+	{0x900bb, 0x0},
+	{0x900bc, 0x0},
+	{0x900bd, 0x0},
+	{0x900be, 0x0},
+	{0x900bf, 0x0},
+	{0x900c0, 0x0},
+	{0x900c1, 0x0},
+	{0x900c2, 0x0},
+	{0x900c3, 0x0},
+	{0x900c4, 0x0},
+	{0x900c5, 0x0},
+	{0x900c6, 0x0},
+	{0x900c7, 0x0},
+	{0x900c8, 0x0},
+	{0x900c9, 0x0},
+	{0x900ca, 0x0},
+	{0x900cb, 0x0},
+	{0x900cc, 0x0},
+	{0x900cd, 0x0},
+	{0x900ce, 0x0},
+	{0x900cf, 0x0},
+	{0x900d0, 0x0},
+	{0x900d1, 0x0},
+	{0x900d2, 0x0},
+	{0x900d3, 0x0},
+	{0x900d4, 0x0},
+	{0x900d5, 0x0},
+	{0x900d6, 0x0},
+	{0x900d7, 0x0},
+	{0x900d8, 0x0},
+	{0x900d9, 0x0},
+	{0x900da, 0x0},
+	{0x900db, 0x0},
+	{0x900dc, 0x0},
+	{0x900dd, 0x0},
+	{0x900de, 0x0},
+	{0x900df, 0x0},
+	{0x900e0, 0x0},
+	{0x900e1, 0x0},
+	{0x900e2, 0x0},
+	{0x900e3, 0x0},
+	{0x900e4, 0x0},
+	{0x900e5, 0x0},
+	{0x900e6, 0x0},
+	{0x900e7, 0x0},
+	{0x900e8, 0x0},
+	{0x900e9, 0x0},
+	{0x900ea, 0x0},
+	{0x900eb, 0x0},
+	{0x900ec, 0x0},
+	{0x900ed, 0x0},
+	{0x900ee, 0x0},
+	{0x900ef, 0x0},
+	{0x900f0, 0x0},
+	{0x900f1, 0x0},
+	{0x900f2, 0x0},
+	{0x900f3, 0x0},
+	{0x900f4, 0x0},
+	{0x900f5, 0x0},
+	{0x900f6, 0x0},
+	{0x900f7, 0x0},
+	{0x900f8, 0x0},
+	{0x900f9, 0x0},
+	{0x900fa, 0x0},
+	{0x900fb, 0x0},
+	{0x900fc, 0x0},
+	{0x900fd, 0x0},
+	{0x900fe, 0x0},
+	{0x900ff, 0x0},
+	{0x90100, 0x0},
+	{0x90101, 0x0},
+	{0x90102, 0x0},
+	{0x90103, 0x0},
+	{0x90104, 0x0},
+	{0x90105, 0x0},
+	{0x90106, 0x0},
+	{0x90107, 0x0},
+	{0x90108, 0x0},
+	{0x90109, 0x0},
+	{0x9010a, 0x0},
+	{0x9010b, 0x0},
+	{0x9010c, 0x0},
+	{0x9010d, 0x0},
+	{0x9010e, 0x0},
+	{0x9010f, 0x0},
+	{0x90110, 0x0},
+	{0x90111, 0x0},
+	{0x90112, 0x0},
+	{0x90113, 0x0},
+	{0x90114, 0x0},
+	{0x90115, 0x0},
+	{0x90116, 0x0},
+	{0x90117, 0x0},
+	{0x90118, 0x0},
+	{0x90119, 0x0},
+	{0x9011a, 0x0},
+	{0x9011b, 0x0},
+	{0x9011c, 0x0},
+	{0x9011d, 0x0},
+	{0x9011e, 0x0},
+	{0x9011f, 0x0},
+	{0x90120, 0x0},
+	{0x90121, 0x0},
+	{0x90122, 0x0},
+	{0x90123, 0x0},
+	{0x90124, 0x0},
+	{0x90125, 0x0},
+	{0x90126, 0x0},
+	{0x90127, 0x0},
+	{0x90128, 0x0},
+	{0x90129, 0x0},
+	{0x9012a, 0x0},
+	{0x9012b, 0x0},
+	{0x9012c, 0x0},
+	{0x9012d, 0x0},
+	{0x9012e, 0x0},
+	{0x9012f, 0x0},
+	{0x90130, 0x0},
+	{0x90131, 0x0},
+	{0x90132, 0x0},
+	{0x90133, 0x0},
+	{0x90134, 0x0},
+	{0x90135, 0x0},
+	{0x90136, 0x0},
+	{0x90137, 0x0},
+	{0x90138, 0x0},
+	{0x90139, 0x0},
+	{0x9013a, 0x0},
+	{0x9013b, 0x0},
+	{0x9013c, 0x0},
+	{0x9013d, 0x0},
+	{0x9013e, 0x0},
+	{0x9013f, 0x0},
+	{0x90140, 0x0},
+	{0x90141, 0x0},
+	{0x90142, 0x0},
+	{0x90143, 0x0},
+	{0x90144, 0x0},
+	{0x90145, 0x0},
+	{0x90146, 0x0},
+	{0x90147, 0x0},
+	{0x90148, 0x0},
+	{0x90149, 0x0},
+	{0x9014a, 0x0},
+	{0x9014b, 0x0},
+	{0x9014c, 0x0},
+	{0x9014d, 0x0},
+	{0x9014e, 0x0},
+	{0x9014f, 0x0},
+	{0x90150, 0x0},
+	{0x90151, 0x0},
+	{0x90152, 0x0},
+	{0x90153, 0x0},
+	{0x90154, 0x0},
+	{0x90155, 0x0},
+	{0x90156, 0x0},
+	{0x90157, 0x0},
+	{0x90158, 0x0},
+	{0x90159, 0x0},
+	{0x9015a, 0x0},
+	{0x9015b, 0x0},
+	{0x9015c, 0x0},
+	{0x9015d, 0x0},
+	{0x9015e, 0x0},
+	{0x9015f, 0x0},
+	{0x90160, 0x0},
+	{0x90161, 0x0},
+	{0x90162, 0x0},
+	{0x90163, 0x0},
+	{0x90164, 0x0},
+	{0x90165, 0x0},
+	{0x90166, 0x0},
+	{0x90167, 0x0},
+	{0x90168, 0x0},
+	{0x90169, 0x0},
+	{0x9016a, 0x0},
+	{0x9016b, 0x0},
+	{0x9016c, 0x0},
+	{0x9016d, 0x0},
+	{0x9016e, 0x0},
+	{0x9016f, 0x0},
+	{0x90170, 0x0},
+	{0x90171, 0x0},
+	{0x90172, 0x0},
+	{0x90173, 0x0},
+	{0x90174, 0x0},
+	{0x90175, 0x0},
+	{0x90176, 0x0},
+	{0x90177, 0x0},
+	{0x90178, 0x0},
+	{0x90179, 0x0},
+	{0x9017a, 0x0},
+	{0x9017b, 0x0},
+	{0x9017c, 0x0},
+	{0x9017d, 0x0},
+	{0x9017e, 0x0},
+	{0x9017f, 0x0},
+	{0x90180, 0x0},
+	{0x90181, 0x0},
+	{0x90182, 0x0},
+	{0x90183, 0x0},
+	{0x90184, 0x0},
+	{0x90006, 0x0},
+	{0x90007, 0x0},
+	{0x90008, 0x0},
+	{0x90009, 0x0},
+	{0x9000a, 0x0},
+	{0x9000b, 0x0},
+	{0xd00e7, 0x0},
+	{0x90017, 0x0},
+	{0x9001f, 0x0},
+	{0x90026, 0x0},
+	{0x400d0, 0x0},
+	{0x400d1, 0x0},
+	{0x400d2, 0x0},
+	{0x400d3, 0x0},
+	{0x400d4, 0x0},
+	{0x400d5, 0x0},
+	{0x400d6, 0x0},
+	{0x400d7, 0x0},
+	{0x200be, 0x0},
+	{0x2000b, 0x0},
+	{0x2000c, 0x0},
+	{0x2000d, 0x0},
+	{0x2000e, 0x0},
+	{0x12000b, 0x0},
+	{0x12000c, 0x0},
+	{0x12000d, 0x0},
+	{0x12000e, 0x0},
+	{0x22000b, 0x0},
+	{0x22000c, 0x0},
+	{0x22000d, 0x0},
+	{0x22000e, 0x0},
+	{0x9000c, 0x0},
+	{0x9000d, 0x0},
+	{0x9000e, 0x0},
+	{0x9000f, 0x0},
+	{0x90010, 0x0},
+	{0x90011, 0x0},
+	{0x90012, 0x0},
+	{0x90013, 0x0},
+	{0x20010, 0x0},
+	{0x20011, 0x0},
+	{0x120010, 0x0},
+	{0x120011, 0x0},
+	{0x40080, 0x0},
+	{0x40081, 0x0},
+	{0x40082, 0x0},
+	{0x40083, 0x0},
+	{0x40084, 0x0},
+	{0x40085, 0x0},
+	{0x140080, 0x0},
+	{0x140081, 0x0},
+	{0x140082, 0x0},
+	{0x140083, 0x0},
+	{0x140084, 0x0},
+	{0x140085, 0x0},
+	{0x240080, 0x0},
+	{0x240081, 0x0},
+	{0x240082, 0x0},
+	{0x240083, 0x0},
+	{0x240084, 0x0},
+	{0x240085, 0x0},
+	{0x400fd, 0x0},
+	{0x400f1, 0x0},
+	{0x10011, 0x0},
+	{0x10012, 0x0},
+	{0x10013, 0x0},
+	{0x10018, 0x0},
+	{0x10002, 0x0},
+	{0x100b2, 0x0},
+	{0x101b4, 0x0},
+	{0x102b4, 0x0},
+	{0x103b4, 0x0},
+	{0x104b4, 0x0},
+	{0x105b4, 0x0},
+	{0x106b4, 0x0},
+	{0x107b4, 0x0},
+	{0x108b4, 0x0},
+	{0x11011, 0x0},
+	{0x11012, 0x0},
+	{0x11013, 0x0},
+	{0x11018, 0x0},
+	{0x11002, 0x0},
+	{0x110b2, 0x0},
+	{0x111b4, 0x0},
+	{0x112b4, 0x0},
+	{0x113b4, 0x0},
+	{0x114b4, 0x0},
+	{0x115b4, 0x0},
+	{0x116b4, 0x0},
+	{0x117b4, 0x0},
+	{0x118b4, 0x0},
+	{0x20089, 0x0},
+	{0xc0080, 0x0},
+	{0x200cb, 0x0},
+	{0x10068, 0x0},
+	{0x10069, 0x0},
+	{0x10168, 0x0},
+	{0x10169, 0x0},
+	{0x10268, 0x0},
+	{0x10269, 0x0},
+	{0x10368, 0x0},
+	{0x10369, 0x0},
+	{0x10468, 0x0},
+	{0x10469, 0x0},
+	{0x10568, 0x0},
+	{0x10569, 0x0},
+	{0x10668, 0x0},
+	{0x10669, 0x0},
+	{0x10768, 0x0},
+	{0x10769, 0x0},
+	{0x10868, 0x0},
+	{0x10869, 0x0},
+	{0x100aa, 0x0},
+	{0x10062, 0x0},
+	{0x10001, 0x0},
+	{0x100a0, 0x0},
+	{0x100a1, 0x0},
+	{0x100a2, 0x0},
+	{0x100a3, 0x0},
+	{0x100a4, 0x0},
+	{0x100a5, 0x0},
+	{0x100a6, 0x0},
+	{0x100a7, 0x0},
+	{0x11068, 0x0},
+	{0x11069, 0x0},
+	{0x11168, 0x0},
+	{0x11169, 0x0},
+	{0x11268, 0x0},
+	{0x11269, 0x0},
+	{0x11368, 0x0},
+	{0x11369, 0x0},
+	{0x11468, 0x0},
+	{0x11469, 0x0},
+	{0x11568, 0x0},
+	{0x11569, 0x0},
+	{0x11668, 0x0},
+	{0x11669, 0x0},
+	{0x11768, 0x0},
+	{0x11769, 0x0},
+	{0x11868, 0x0},
+	{0x11869, 0x0},
+	{0x110aa, 0x0},
+	{0x11062, 0x0},
+	{0x11001, 0x0},
+	{0x110a0, 0x0},
+	{0x110a1, 0x0},
+	{0x110a2, 0x0},
+	{0x110a3, 0x0},
+	{0x110a4, 0x0},
+	{0x110a5, 0x0},
+	{0x110a6, 0x0},
+	{0x110a7, 0x0},
+	{0x80, 0x0},
+	{0x1080, 0x0},
+	{0x2080, 0x0},
+	{0x10020, 0x0},
+	{0x10080, 0x0},
+	{0x10081, 0x0},
+	{0x100d0, 0x0},
+	{0x100d1, 0x0},
+	{0x1008c, 0x0},
+	{0x1008d, 0x0},
+	{0x10180, 0x0},
+	{0x10181, 0x0},
+	{0x101d0, 0x0},
+	{0x101d1, 0x0},
+	{0x1018c, 0x0},
+	{0x1018d, 0x0},
+	{0x100c0, 0x0},
+	{0x100c1, 0x0},
+	{0x101c0, 0x0},
+	{0x101c1, 0x0},
+	{0x102c0, 0x0},
+	{0x102c1, 0x0},
+	{0x103c0, 0x0},
+	{0x103c1, 0x0},
+	{0x104c0, 0x0},
+	{0x104c1, 0x0},
+	{0x105c0, 0x0},
+	{0x105c1, 0x0},
+	{0x106c0, 0x0},
+	{0x106c1, 0x0},
+	{0x107c0, 0x0},
+	{0x107c1, 0x0},
+	{0x108c0, 0x0},
+	{0x108c1, 0x0},
+	{0x100ae, 0x0},
+	{0x100af, 0x0},
+	{0x11020, 0x0},
+	{0x11080, 0x0},
+	{0x11081, 0x0},
+	{0x110d0, 0x0},
+	{0x110d1, 0x0},
+	{0x1108c, 0x0},
+	{0x1108d, 0x0},
+	{0x11180, 0x0},
+	{0x11181, 0x0},
+	{0x111d0, 0x0},
+	{0x111d1, 0x0},
+	{0x1118c, 0x0},
+	{0x1118d, 0x0},
+	{0x110c0, 0x0},
+	{0x110c1, 0x0},
+	{0x111c0, 0x0},
+	{0x111c1, 0x0},
+	{0x112c0, 0x0},
+	{0x112c1, 0x0},
+	{0x113c0, 0x0},
+	{0x113c1, 0x0},
+	{0x114c0, 0x0},
+	{0x114c1, 0x0},
+	{0x115c0, 0x0},
+	{0x115c1, 0x0},
+	{0x116c0, 0x0},
+	{0x116c1, 0x0},
+	{0x117c0, 0x0},
+	{0x117c1, 0x0},
+	{0x118c0, 0x0},
+	{0x118c1, 0x0},
+	{0x110ae, 0x0},
+	{0x110af, 0x0},
+	{0x90201, 0x0},
+	{0x90202, 0x0},
+	{0x90203, 0x0},
+	{0x90205, 0x0},
+	{0x90206, 0x0},
+	{0x90207, 0x0},
+	{0x90208, 0x0},
+	{0x20020, 0x0},
+	{0x100080, 0x0},
+	{0x101080, 0x0},
+	{0x102080, 0x0},
+	{0x110020, 0x0},
+	{0x110080, 0x0},
+	{0x110081, 0x0},
+	{0x1100d0, 0x0},
+	{0x1100d1, 0x0},
+	{0x11008c, 0x0},
+	{0x11008d, 0x0},
+	{0x110180, 0x0},
+	{0x110181, 0x0},
+	{0x1101d0, 0x0},
+	{0x1101d1, 0x0},
+	{0x11018c, 0x0},
+	{0x11018d, 0x0},
+	{0x1100c0, 0x0},
+	{0x1100c1, 0x0},
+	{0x1101c0, 0x0},
+	{0x1101c1, 0x0},
+	{0x1102c0, 0x0},
+	{0x1102c1, 0x0},
+	{0x1103c0, 0x0},
+	{0x1103c1, 0x0},
+	{0x1104c0, 0x0},
+	{0x1104c1, 0x0},
+	{0x1105c0, 0x0},
+	{0x1105c1, 0x0},
+	{0x1106c0, 0x0},
+	{0x1106c1, 0x0},
+	{0x1107c0, 0x0},
+	{0x1107c1, 0x0},
+	{0x1108c0, 0x0},
+	{0x1108c1, 0x0},
+	{0x1100ae, 0x0},
+	{0x1100af, 0x0},
+	{0x111020, 0x0},
+	{0x111080, 0x0},
+	{0x111081, 0x0},
+	{0x1110d0, 0x0},
+	{0x1110d1, 0x0},
+	{0x11108c, 0x0},
+	{0x11108d, 0x0},
+	{0x111180, 0x0},
+	{0x111181, 0x0},
+	{0x1111d0, 0x0},
+	{0x1111d1, 0x0},
+	{0x11118c, 0x0},
+	{0x11118d, 0x0},
+	{0x1110c0, 0x0},
+	{0x1110c1, 0x0},
+	{0x1111c0, 0x0},
+	{0x1111c1, 0x0},
+	{0x1112c0, 0x0},
+	{0x1112c1, 0x0},
+	{0x1113c0, 0x0},
+	{0x1113c1, 0x0},
+	{0x1114c0, 0x0},
+	{0x1114c1, 0x0},
+	{0x1115c0, 0x0},
+	{0x1115c1, 0x0},
+	{0x1116c0, 0x0},
+	{0x1116c1, 0x0},
+	{0x1117c0, 0x0},
+	{0x1117c1, 0x0},
+	{0x1118c0, 0x0},
+	{0x1118c1, 0x0},
+	{0x1110ae, 0x0},
+	{0x1110af, 0x0},
+	{0x190201, 0x0},
+	{0x190202, 0x0},
+	{0x190203, 0x0},
+	{0x190205, 0x0},
+	{0x190206, 0x0},
+	{0x190207, 0x0},
+	{0x190208, 0x0},
+	{0x120020, 0x0},
+	{0x200080, 0x0},
+	{0x201080, 0x0},
+	{0x202080, 0x0},
+	{0x210020, 0x0},
+	{0x210080, 0x0},
+	{0x210081, 0x0},
+	{0x2100d0, 0x0},
+	{0x2100d1, 0x0},
+	{0x21008c, 0x0},
+	{0x21008d, 0x0},
+	{0x210180, 0x0},
+	{0x210181, 0x0},
+	{0x2101d0, 0x0},
+	{0x2101d1, 0x0},
+	{0x21018c, 0x0},
+	{0x21018d, 0x0},
+	{0x2100c0, 0x0},
+	{0x2100c1, 0x0},
+	{0x2101c0, 0x0},
+	{0x2101c1, 0x0},
+	{0x2102c0, 0x0},
+	{0x2102c1, 0x0},
+	{0x2103c0, 0x0},
+	{0x2103c1, 0x0},
+	{0x2104c0, 0x0},
+	{0x2104c1, 0x0},
+	{0x2105c0, 0x0},
+	{0x2105c1, 0x0},
+	{0x2106c0, 0x0},
+	{0x2106c1, 0x0},
+	{0x2107c0, 0x0},
+	{0x2107c1, 0x0},
+	{0x2108c0, 0x0},
+	{0x2108c1, 0x0},
+	{0x2100ae, 0x0},
+	{0x2100af, 0x0},
+	{0x211020, 0x0},
+	{0x211080, 0x0},
+	{0x211081, 0x0},
+	{0x2110d0, 0x0},
+	{0x2110d1, 0x0},
+	{0x21108c, 0x0},
+	{0x21108d, 0x0},
+	{0x211180, 0x0},
+	{0x211181, 0x0},
+	{0x2111d0, 0x0},
+	{0x2111d1, 0x0},
+	{0x21118c, 0x0},
+	{0x21118d, 0x0},
+	{0x2110c0, 0x0},
+	{0x2110c1, 0x0},
+	{0x2111c0, 0x0},
+	{0x2111c1, 0x0},
+	{0x2112c0, 0x0},
+	{0x2112c1, 0x0},
+	{0x2113c0, 0x0},
+	{0x2113c1, 0x0},
+	{0x2114c0, 0x0},
+	{0x2114c1, 0x0},
+	{0x2115c0, 0x0},
+	{0x2115c1, 0x0},
+	{0x2116c0, 0x0},
+	{0x2116c1, 0x0},
+	{0x2117c0, 0x0},
+	{0x2117c1, 0x0},
+	{0x2118c0, 0x0},
+	{0x2118c1, 0x0},
+	{0x2110ae, 0x0},
+	{0x2110af, 0x0},
+	{0x290201, 0x0},
+	{0x290202, 0x0},
+	{0x290203, 0x0},
+	{0x290205, 0x0},
+	{0x290206, 0x0},
+	{0x290207, 0x0},
+	{0x290208, 0x0},
+	{0x220020, 0x0},
+	{0x20077, 0x0},
+	{0x20072, 0x0},
+	{0x20073, 0x0},
+	{0x400c0, 0x0},
+	{0x10040, 0x0},
+	{0x10140, 0x0},
+	{0x10240, 0x0},
+	{0x10340, 0x0},
+	{0x10440, 0x0},
+	{0x10540, 0x0},
+	{0x10640, 0x0},
+	{0x10740, 0x0},
+	{0x10840, 0x0},
+	{0x11040, 0x0},
+	{0x11140, 0x0},
+	{0x11240, 0x0},
+	{0x11340, 0x0},
+	{0x11440, 0x0},
+	{0x11540, 0x0},
+	{0x11640, 0x0},
+	{0x11740, 0x0},
+	{0x11840, 0x0},
+};
+
+/* P0 message block parameter for training firmware */
+static struct dram_cfg_param ddr_fsp0_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54003, 0x960},
+	{0x54004, 0x4},
+	{0x54006, 0x14},
+	{0x54008, 0x131f},
+	{0x54009, 0xc8},
+	{0x5400b, 0x4},
+	{0x5400d, 0x100},
+	{0x5400f, 0x100},
+	{0x54012, 0x110},
+	{0x54019, 0x24c4},
+	{0x5401a, 0x23},
+	{0x5401b, 0x4944},
+	{0x5401c, 0x4a08},
+	{0x5401e, 0x4},
+	{0x5401f, 0x24c4},
+	{0x54020, 0x23},
+	{0x54021, 0x4944},
+	{0x54022, 0x4a08},
+	{0x54024, 0x4},
+	{0x54032, 0xc400},
+	{0x54033, 0x2324},
+	{0x54034, 0x4400},
+	{0x54035, 0x849},
+	{0x54036, 0x4a},
+	{0x54037, 0x400},
+	{0x54038, 0xc400},
+	{0x54039, 0x2324},
+	{0x5403a, 0x4400},
+	{0x5403b, 0x849},
+	{0x5403c, 0x4a},
+	{0x5403d, 0x400},
+	{0xd0000, 0x1}
+};
+
+/* P1 message block parameter for training firmware */
+static struct dram_cfg_param ddr_fsp1_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54002, 0x1},
+	{0x54003, 0x4b0},
+	{0x54004, 0x4},
+	{0x54006, 0x14},
+	{0x54008, 0x121f},
+	{0x54009, 0xc8},
+	{0x5400b, 0x4},
+	{0x5400d, 0x100},
+	{0x5400f, 0x100},
+	{0x54012, 0x110},
+	{0x54019, 0x52a4},
+	{0x5401a, 0x23},
+	{0x5401b, 0x4944},
+	{0x5401c, 0x4a08},
+	{0x5401e, 0x4},
+	{0x5401f, 0x52a4},
+	{0x54020, 0x23},
+	{0x54021, 0x4944},
+	{0x54022, 0x4a08},
+	{0x54024, 0x4},
+	{0x54032, 0xa400},
+	{0x54033, 0x2352},
+	{0x54034, 0x4400},
+	{0x54035, 0x849},
+	{0x54036, 0x4a},
+	{0x54037, 0x400},
+	{0x54038, 0xa400},
+	{0x54039, 0x2352},
+	{0x5403a, 0x4400},
+	{0x5403b, 0x849},
+	{0x5403c, 0x4a},
+	{0x5403d, 0x400},
+	{0xd0000, 0x1}
+};
+
+/* P2 message block parameter for training firmware */
+static struct dram_cfg_param ddr_fsp2_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54002, 0x102},
+	{0x54003, 0x270},
+	{0x54004, 0x4},
+	{0x54006, 0x14},
+	{0x54008, 0x121f},
+	{0x54009, 0xc8},
+	{0x5400b, 0x4},
+	{0x5400d, 0x100},
+	{0x5400f, 0x100},
+	{0x54012, 0x110},
+	{0x54019, 0x994},
+	{0x5401a, 0x23},
+	{0x5401b, 0x4944},
+	{0x5401c, 0x4a00},
+	{0x5401e, 0x4},
+	{0x5401f, 0x994},
+	{0x54020, 0x23},
+	{0x54021, 0x4944},
+	{0x54022, 0x4a00},
+	{0x54024, 0x4},
+	{0x54032, 0x9400},
+	{0x54033, 0x2309},
+	{0x54034, 0x4400},
+	{0x54035, 0x49},
+	{0x54036, 0x4a},
+	{0x54037, 0x400},
+	{0x54038, 0x9400},
+	{0x54039, 0x2309},
+	{0x5403a, 0x4400},
+	{0x5403b, 0x49},
+	{0x5403c, 0x4a},
+	{0x5403d, 0x400},
+	{0xd0000, 0x1}
+};
+
+/* P0 2D message block parameter for training firmware */
+static struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54003, 0x960},
+	{0x54004, 0x4},
+	{0x54006, 0x14},
+	{0x54008, 0x61},
+	{0x54009, 0xc8},
+	{0x5400b, 0x4},
+	{0x5400d, 0x100},
+	{0x5400f, 0x100},
+	{0x54010, 0x2080},
+	{0x54012, 0x110},
+	{0x54019, 0x24c4},
+	{0x5401a, 0x23},
+	{0x5401b, 0x4944},
+	{0x5401c, 0x4a08},
+	{0x5401e, 0x4},
+	{0x5401f, 0x24c4},
+	{0x54020, 0x23},
+	{0x54021, 0x4944},
+	{0x54022, 0x4a08},
+	{0x54024, 0x4},
+	{0x54032, 0xc400},
+	{0x54033, 0x2324},
+	{0x54034, 0x4400},
+	{0x54035, 0x849},
+	{0x54036, 0x4a},
+	{0x54037, 0x400},
+	{0x54038, 0xc400},
+	{0x54039, 0x2324},
+	{0x5403a, 0x4400},
+	{0x5403b, 0x849},
+	{0x5403c, 0x4a},
+	{0x5403d, 0x400},
+	{0xd0000, 0x1}
+};
+
+/* DRAM PHY init engine image */
+static struct dram_cfg_param ddr_phy_pie[] = {
+	{0xd0000, 0x0},
+	{0x90000, 0x10},
+	{0x90001, 0x400},
+	{0x90002, 0x10e},
+	{0x90003, 0x0},
+	{0x90004, 0x0},
+	{0x90005, 0x8},
+	{0x90029, 0xb},
+	{0x9002a, 0x480},
+	{0x9002b, 0x109},
+	{0x9002c, 0x8},
+	{0x9002d, 0x448},
+	{0x9002e, 0x139},
+	{0x9002f, 0x8},
+	{0x90030, 0x478},
+	{0x90031, 0x109},
+	{0x90032, 0x0},
+	{0x90033, 0xe8},
+	{0x90034, 0x109},
+	{0x90035, 0x2},
+	{0x90036, 0x10},
+	{0x90037, 0x139},
+	{0x90038, 0xb},
+	{0x90039, 0x7c0},
+	{0x9003a, 0x139},
+	{0x9003b, 0x44},
+	{0x9003c, 0x633},
+	{0x9003d, 0x159},
+	{0x9003e, 0x14f},
+	{0x9003f, 0x630},
+	{0x90040, 0x159},
+	{0x90041, 0x47},
+	{0x90042, 0x633},
+	{0x90043, 0x149},
+	{0x90044, 0x4f},
+	{0x90045, 0x633},
+	{0x90046, 0x179},
+	{0x90047, 0x8},
+	{0x90048, 0xe0},
+	{0x90049, 0x109},
+	{0x9004a, 0x0},
+	{0x9004b, 0x7c8},
+	{0x9004c, 0x109},
+	{0x9004d, 0x0},
+	{0x9004e, 0x1},
+	{0x9004f, 0x8},
+	{0x90050, 0x30},
+	{0x90051, 0x65a},
+	{0x90052, 0x9},
+	{0x90053, 0x0},
+	{0x90054, 0x45a},
+	{0x90055, 0x9},
+	{0x90056, 0x0},
+	{0x90057, 0x448},
+	{0x90058, 0x109},
+	{0x90059, 0x40},
+	{0x9005a, 0x633},
+	{0x9005b, 0x179},
+	{0x9005c, 0x1},
+	{0x9005d, 0x618},
+	{0x9005e, 0x109},
+	{0x9005f, 0x40c0},
+	{0x90060, 0x633},
+	{0x90061, 0x149},
+	{0x90062, 0x8},
+	{0x90063, 0x4},
+	{0x90064, 0x48},
+	{0x90065, 0x4040},
+	{0x90066, 0x633},
+	{0x90067, 0x149},
+	{0x90068, 0x0},
+	{0x90069, 0x4},
+	{0x9006a, 0x48},
+	{0x9006b, 0x40},
+	{0x9006c, 0x633},
+	{0x9006d, 0x149},
+	{0x9006e, 0x0},
+	{0x9006f, 0x658},
+	{0x90070, 0x109},
+	{0x90071, 0x10},
+	{0x90072, 0x4},
+	{0x90073, 0x18},
+	{0x90074, 0x0},
+	{0x90075, 0x4},
+	{0x90076, 0x78},
+	{0x90077, 0x549},
+	{0x90078, 0x633},
+	{0x90079, 0x159},
+	{0x9007a, 0xd49},
+	{0x9007b, 0x633},
+	{0x9007c, 0x159},
+	{0x9007d, 0x94a},
+	{0x9007e, 0x633},
+	{0x9007f, 0x159},
+	{0x90080, 0x441},
+	{0x90081, 0x633},
+	{0x90082, 0x149},
+	{0x90083, 0x42},
+	{0x90084, 0x633},
+	{0x90085, 0x149},
+	{0x90086, 0x1},
+	{0x90087, 0x633},
+	{0x90088, 0x149},
+	{0x90089, 0x0},
+	{0x9008a, 0xe0},
+	{0x9008b, 0x109},
+	{0x9008c, 0xa},
+	{0x9008d, 0x10},
+	{0x9008e, 0x109},
+	{0x9008f, 0x9},
+	{0x90090, 0x3c0},
+	{0x90091, 0x149},
+	{0x90092, 0x9},
+	{0x90093, 0x3c0},
+	{0x90094, 0x159},
+	{0x90095, 0x18},
+	{0x90096, 0x10},
+	{0x90097, 0x109},
+	{0x90098, 0x0},
+	{0x90099, 0x3c0},
+	{0x9009a, 0x109},
+	{0x9009b, 0x18},
+	{0x9009c, 0x4},
+	{0x9009d, 0x48},
+	{0x9009e, 0x18},
+	{0x9009f, 0x4},
+	{0x900a0, 0x58},
+	{0x900a1, 0xb},
+	{0x900a2, 0x10},
+	{0x900a3, 0x109},
+	{0x900a4, 0x1},
+	{0x900a5, 0x10},
+	{0x900a6, 0x109},
+	{0x900a7, 0x5},
+	{0x900a8, 0x7c0},
+	{0x900a9, 0x109},
+	{0x40000, 0x811},
+	{0x40020, 0x880},
+	{0x40040, 0x0},
+	{0x40060, 0x0},
+	{0x40001, 0x4008},
+	{0x40021, 0x83},
+	{0x40041, 0x4f},
+	{0x40061, 0x0},
+	{0x40002, 0x4040},
+	{0x40022, 0x83},
+	{0x40042, 0x51},
+	{0x40062, 0x0},
+	{0x40003, 0x811},
+	{0x40023, 0x880},
+	{0x40043, 0x0},
+	{0x40063, 0x0},
+	{0x40004, 0x720},
+	{0x40024, 0xf},
+	{0x40044, 0x1740},
+	{0x40064, 0x0},
+	{0x40005, 0x16},
+	{0x40025, 0x83},
+	{0x40045, 0x4b},
+	{0x40065, 0x0},
+	{0x40006, 0x716},
+	{0x40026, 0xf},
+	{0x40046, 0x2001},
+	{0x40066, 0x0},
+	{0x40007, 0x716},
+	{0x40027, 0xf},
+	{0x40047, 0x2800},
+	{0x40067, 0x0},
+	{0x40008, 0x716},
+	{0x40028, 0xf},
+	{0x40048, 0xf00},
+	{0x40068, 0x0},
+	{0x40009, 0x720},
+	{0x40029, 0xf},
+	{0x40049, 0x1400},
+	{0x40069, 0x0},
+	{0x4000a, 0xe08},
+	{0x4002a, 0xc15},
+	{0x4004a, 0x0},
+	{0x4006a, 0x0},
+	{0x4000b, 0x625},
+	{0x4002b, 0x15},
+	{0x4004b, 0x0},
+	{0x4006b, 0x0},
+	{0x4000c, 0x4028},
+	{0x4002c, 0x80},
+	{0x4004c, 0x0},
+	{0x4006c, 0x0},
+	{0x4000d, 0xe08},
+	{0x4002d, 0xc1a},
+	{0x4004d, 0x0},
+	{0x4006d, 0x0},
+	{0x4000e, 0x625},
+	{0x4002e, 0x1a},
+	{0x4004e, 0x0},
+	{0x4006e, 0x0},
+	{0x4000f, 0x4040},
+	{0x4002f, 0x80},
+	{0x4004f, 0x0},
+	{0x4006f, 0x0},
+	{0x40010, 0x2604},
+	{0x40030, 0x15},
+	{0x40050, 0x0},
+	{0x40070, 0x0},
+	{0x40011, 0x708},
+	{0x40031, 0x5},
+	{0x40051, 0x0},
+	{0x40071, 0x2002},
+	{0x40012, 0x8},
+	{0x40032, 0x80},
+	{0x40052, 0x0},
+	{0x40072, 0x0},
+	{0x40013, 0x2604},
+	{0x40033, 0x1a},
+	{0x40053, 0x0},
+	{0x40073, 0x0},
+	{0x40014, 0x708},
+	{0x40034, 0xa},
+	{0x40054, 0x0},
+	{0x40074, 0x2002},
+	{0x40015, 0x4040},
+	{0x40035, 0x80},
+	{0x40055, 0x0},
+	{0x40075, 0x0},
+	{0x40016, 0x60a},
+	{0x40036, 0x15},
+	{0x40056, 0x1200},
+	{0x40076, 0x0},
+	{0x40017, 0x61a},
+	{0x40037, 0x15},
+	{0x40057, 0x1300},
+	{0x40077, 0x0},
+	{0x40018, 0x60a},
+	{0x40038, 0x1a},
+	{0x40058, 0x1200},
+	{0x40078, 0x0},
+	{0x40019, 0x642},
+	{0x40039, 0x1a},
+	{0x40059, 0x1300},
+	{0x40079, 0x0},
+	{0x4001a, 0x4808},
+	{0x4003a, 0x880},
+	{0x4005a, 0x0},
+	{0x4007a, 0x0},
+	{0x900aa, 0x0},
+	{0x900ab, 0x790},
+	{0x900ac, 0x11a},
+	{0x900ad, 0x8},
+	{0x900ae, 0x7aa},
+	{0x900af, 0x2a},
+	{0x900b0, 0x10},
+	{0x900b1, 0x7b2},
+	{0x900b2, 0x2a},
+	{0x900b3, 0x0},
+	{0x900b4, 0x7c8},
+	{0x900b5, 0x109},
+	{0x900b6, 0x10},
+	{0x900b7, 0x10},
+	{0x900b8, 0x109},
+	{0x900b9, 0x10},
+	{0x900ba, 0x2a8},
+	{0x900bb, 0x129},
+	{0x900bc, 0x8},
+	{0x900bd, 0x370},
+	{0x900be, 0x129},
+	{0x900bf, 0xa},
+	{0x900c0, 0x3c8},
+	{0x900c1, 0x1a9},
+	{0x900c2, 0xc},
+	{0x900c3, 0x408},
+	{0x900c4, 0x199},
+	{0x900c5, 0x14},
+	{0x900c6, 0x790},
+	{0x900c7, 0x11a},
+	{0x900c8, 0x8},
+	{0x900c9, 0x4},
+	{0x900ca, 0x18},
+	{0x900cb, 0xe},
+	{0x900cc, 0x408},
+	{0x900cd, 0x199},
+	{0x900ce, 0x8},
+	{0x900cf, 0x8568},
+	{0x900d0, 0x108},
+	{0x900d1, 0x18},
+	{0x900d2, 0x790},
+	{0x900d3, 0x16a},
+	{0x900d4, 0x8},
+	{0x900d5, 0x1d8},
+	{0x900d6, 0x169},
+	{0x900d7, 0x10},
+	{0x900d8, 0x8558},
+	{0x900d9, 0x168},
+	{0x900da, 0x1ff8},
+	{0x900db, 0x85a8},
+	{0x900dc, 0x1e8},
+	{0x900dd, 0x50},
+	{0x900de, 0x798},
+	{0x900df, 0x16a},
+	{0x900e0, 0x60},
+	{0x900e1, 0x7a0},
+	{0x900e2, 0x16a},
+	{0x900e3, 0x8},
+	{0x900e4, 0x8310},
+	{0x900e5, 0x168},
+	{0x900e6, 0x8},
+	{0x900e7, 0xa310},
+	{0x900e8, 0x168},
+	{0x900e9, 0xa},
+	{0x900ea, 0x408},
+	{0x900eb, 0x169},
+	{0x900ec, 0x6e},
+	{0x900ed, 0x0},
+	{0x900ee, 0x68},
+	{0x900ef, 0x0},
+	{0x900f0, 0x408},
+	{0x900f1, 0x169},
+	{0x900f2, 0x0},
+	{0x900f3, 0x8310},
+	{0x900f4, 0x168},
+	{0x900f5, 0x0},
+	{0x900f6, 0xa310},
+	{0x900f7, 0x168},
+	{0x900f8, 0x1ff8},
+	{0x900f9, 0x85a8},
+	{0x900fa, 0x1e8},
+	{0x900fb, 0x68},
+	{0x900fc, 0x798},
+	{0x900fd, 0x16a},
+	{0x900fe, 0x78},
+	{0x900ff, 0x7a0},
+	{0x90100, 0x16a},
+	{0x90101, 0x68},
+	{0x90102, 0x790},
+	{0x90103, 0x16a},
+	{0x90104, 0x8},
+	{0x90105, 0x8b10},
+	{0x90106, 0x168},
+	{0x90107, 0x8},
+	{0x90108, 0xab10},
+	{0x90109, 0x168},
+	{0x9010a, 0xa},
+	{0x9010b, 0x408},
+	{0x9010c, 0x169},
+	{0x9010d, 0x58},
+	{0x9010e, 0x0},
+	{0x9010f, 0x68},
+	{0x90110, 0x0},
+	{0x90111, 0x408},
+	{0x90112, 0x169},
+	{0x90113, 0x0},
+	{0x90114, 0x8b10},
+	{0x90115, 0x168},
+	{0x90116, 0x1},
+	{0x90117, 0xab10},
+	{0x90118, 0x168},
+	{0x90119, 0x0},
+	{0x9011a, 0x1d8},
+	{0x9011b, 0x169},
+	{0x9011c, 0x80},
+	{0x9011d, 0x790},
+	{0x9011e, 0x16a},
+	{0x9011f, 0x18},
+	{0x90120, 0x7aa},
+	{0x90121, 0x6a},
+	{0x90122, 0xa},
+	{0x90123, 0x0},
+	{0x90124, 0x1e9},
+	{0x90125, 0x8},
+	{0x90126, 0x8080},
+	{0x90127, 0x108},
+	{0x90128, 0xf},
+	{0x90129, 0x408},
+	{0x9012a, 0x169},
+	{0x9012b, 0xc},
+	{0x9012c, 0x0},
+	{0x9012d, 0x68},
+	{0x9012e, 0x9},
+	{0x9012f, 0x0},
+	{0x90130, 0x1a9},
+	{0x90131, 0x0},
+	{0x90132, 0x408},
+	{0x90133, 0x169},
+	{0x90134, 0x0},
+	{0x90135, 0x8080},
+	{0x90136, 0x108},
+	{0x90137, 0x8},
+	{0x90138, 0x7aa},
+	{0x90139, 0x6a},
+	{0x9013a, 0x0},
+	{0x9013b, 0x8568},
+	{0x9013c, 0x108},
+	{0x9013d, 0xb7},
+	{0x9013e, 0x790},
+	{0x9013f, 0x16a},
+	{0x90140, 0x1f},
+	{0x90141, 0x0},
+	{0x90142, 0x68},
+	{0x90143, 0x8},
+	{0x90144, 0x8558},
+	{0x90145, 0x168},
+	{0x90146, 0xf},
+	{0x90147, 0x408},
+	{0x90148, 0x169},
+	{0x90149, 0xd},
+	{0x9014a, 0x0},
+	{0x9014b, 0x68},
+	{0x9014c, 0x0},
+	{0x9014d, 0x408},
+	{0x9014e, 0x169},
+	{0x9014f, 0x0},
+	{0x90150, 0x8558},
+	{0x90151, 0x168},
+	{0x90152, 0x8},
+	{0x90153, 0x3c8},
+	{0x90154, 0x1a9},
+	{0x90155, 0x3},
+	{0x90156, 0x370},
+	{0x90157, 0x129},
+	{0x90158, 0x20},
+	{0x90159, 0x2aa},
+	{0x9015a, 0x9},
+	{0x9015b, 0x8},
+	{0x9015c, 0xe8},
+	{0x9015d, 0x109},
+	{0x9015e, 0x0},
+	{0x9015f, 0x8140},
+	{0x90160, 0x10c},
+	{0x90161, 0x10},
+	{0x90162, 0x8138},
+	{0x90163, 0x104},
+	{0x90164, 0x8},
+	{0x90165, 0x448},
+	{0x90166, 0x109},
+	{0x90167, 0xf},
+	{0x90168, 0x7c0},
+	{0x90169, 0x109},
+	{0x9016a, 0x0},
+	{0x9016b, 0xe8},
+	{0x9016c, 0x109},
+	{0x9016d, 0x47},
+	{0x9016e, 0x630},
+	{0x9016f, 0x109},
+	{0x90170, 0x8},
+	{0x90171, 0x618},
+	{0x90172, 0x109},
+	{0x90173, 0x8},
+	{0x90174, 0xe0},
+	{0x90175, 0x109},
+	{0x90176, 0x0},
+	{0x90177, 0x7c8},
+	{0x90178, 0x109},
+	{0x90179, 0x8},
+	{0x9017a, 0x8140},
+	{0x9017b, 0x10c},
+	{0x9017c, 0x0},
+	{0x9017d, 0x478},
+	{0x9017e, 0x109},
+	{0x9017f, 0x0},
+	{0x90180, 0x1},
+	{0x90181, 0x8},
+	{0x90182, 0x8},
+	{0x90183, 0x4},
+	{0x90184, 0x0},
+	{0x90006, 0x8},
+	{0x90007, 0x7c8},
+	{0x90008, 0x109},
+	{0x90009, 0x0},
+	{0x9000a, 0x400},
+	{0x9000b, 0x106},
+	{0xd00e7, 0x400},
+	{0x90017, 0x0},
+	{0x9001f, 0x2b},
+	{0x90026, 0x69},
+	{0x400d0, 0x0},
+	{0x400d1, 0x101},
+	{0x400d2, 0x105},
+	{0x400d3, 0x107},
+	{0x400d4, 0x10f},
+	{0x400d5, 0x202},
+	{0x400d6, 0x20a},
+	{0x400d7, 0x20b},
+	{0x2003a, 0x2},
+	{0x200be, 0x3},
+	{0x2000b, 0x2a3},
+	{0x2000c, 0x96},
+	{0x2000d, 0x5dc},
+	{0x2000e, 0x2c},
+	{0x12000b, 0x152},
+	{0x12000c, 0x4b},
+	{0x12000d, 0x2ee},
+	{0x12000e, 0x2c},
+	{0x22000b, 0xb0},
+	{0x22000c, 0x27},
+	{0x22000d, 0x186},
+	{0x22000e, 0x10},
+	{0x9000c, 0x0},
+	{0x9000d, 0x173},
+	{0x9000e, 0x60},
+	{0x9000f, 0x6110},
+	{0x90010, 0x2152},
+	{0x90011, 0xdfbd},
+	{0x90012, 0x2060},
+	{0x90013, 0x6152},
+	{0x20010, 0x5a},
+	{0x20011, 0x3},
+	{0x120010, 0x5a},
+	{0x120011, 0x3},
+	{0x40080, 0xe0},
+	{0x40081, 0x12},
+	{0x40082, 0xe0},
+	{0x40083, 0x12},
+	{0x40084, 0xe0},
+	{0x40085, 0x12},
+	{0x140080, 0xe0},
+	{0x140081, 0x12},
+	{0x140082, 0xe0},
+	{0x140083, 0x12},
+	{0x140084, 0xe0},
+	{0x140085, 0x12},
+	{0x240080, 0xe0},
+	{0x240081, 0x12},
+	{0x240082, 0xe0},
+	{0x240083, 0x12},
+	{0x240084, 0xe0},
+	{0x240085, 0x12},
+	{0x400fd, 0xf},
+	{0x400f1, 0xe},
+	{0x10011, 0x1},
+	{0x10012, 0x1},
+	{0x10013, 0x180},
+	{0x10018, 0x1},
+	{0x10002, 0x6209},
+	{0x100b2, 0x1},
+	{0x101b4, 0x1},
+	{0x102b4, 0x1},
+	{0x103b4, 0x1},
+	{0x104b4, 0x1},
+	{0x105b4, 0x1},
+	{0x106b4, 0x1},
+	{0x107b4, 0x1},
+	{0x108b4, 0x1},
+	{0x11011, 0x1},
+	{0x11012, 0x1},
+	{0x11013, 0x180},
+	{0x11018, 0x1},
+	{0x11002, 0x6209},
+	{0x110b2, 0x1},
+	{0x111b4, 0x1},
+	{0x112b4, 0x1},
+	{0x113b4, 0x1},
+	{0x114b4, 0x1},
+	{0x115b4, 0x1},
+	{0x116b4, 0x1},
+	{0x117b4, 0x1},
+	{0x118b4, 0x1},
+	{0x20089, 0x1},
+	{0x20088, 0x19},
+	{0xc0080, 0x0},
+	{0xd0000, 0x1},
+};
+
+static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
+	{
+		/* P0 2400mts 1D */
+		.drate = 2400,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
+	},
+	{
+		/* P1 1200mts 1D */
+		.drate = 1200,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp1_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp1_cfg),
+	},
+	{
+		/* P2 625mts 1D */
+		.drate = 625,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp2_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg),
+	},
+	{
+		/* P0 2400mts 2D */
+		.drate = 2400,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = ddr_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
+	},
+};
+
+/* ddr timing config params */
+struct dram_timing_info dram_timing = {
+	.ddrc_cfg = ddr_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
+	.ddrphy_cfg = ddr_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
+	.fsp_msg = ddr_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
+	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
+	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
+	.ddrphy_pie = ddr_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
+	.fsp_table = { 2400, 1200, 625, },
+	.fsp_cfg = ddr_dram_fsp_cfg,
+	.fsp_cfg_num = ARRAY_SIZE(ddr_dram_fsp_cfg),
+};
diff --git a/board/phytec/phycore_imx93/lpddr4_timing.c b/board/phytec/phycore_imx91_93/lpddr4_timing_imx93.c
similarity index 100%
rename from board/phytec/phycore_imx93/lpddr4_timing.c
rename to board/phytec/phycore_imx91_93/lpddr4_timing_imx93.c
diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx91_93/phycore-imx91-93.c
similarity index 90%
rename from board/phytec/phycore_imx93/phycore-imx93.c
rename to board/phytec/phycore_imx91_93/phycore-imx91-93.c
index 036c9f5de7ea..2605a3bd09ea 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx91_93/phycore-imx91-93.c
@@ -11,7 +11,7 @@
 #include <env.h>
 #include <fdt_support.h>
 
-#include "../common/imx93_som_detection.h"
+#include "../common/imx91_93_som_detection.h"
 
 #define EEPROM_ADDR            0x50
 
@@ -55,13 +55,13 @@ int board_late_init(void)
 
 static void emmc_fixup(void *blob, struct phytec_eeprom_data *data)
 {
-	enum phytec_imx93_voltage voltage = phytec_imx93_get_voltage(data);
+	enum phytec_imx91_93_voltage voltage = phytec_imx91_93_get_voltage(data);
 	int offset;
 
-	if (voltage == PHYTEC_IMX93_VOLTAGE_INVALID)
+	if (voltage == PHYTEC_IMX91_93_VOLTAGE_INVALID)
 		goto err;
 
-	if (voltage == PHYTEC_IMX93_VOLTAGE_1V8) {
+	if (voltage == PHYTEC_IMX91_93_VOLTAGE_1V8) {
 		offset = fdt_node_offset_by_compat_reg(blob, "fsl,imx93-usdhc",
 						       0x42850000);
 		if (offset)
diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx91_93/phycore_imx91_93.env
similarity index 94%
rename from board/phytec/phycore_imx93/phycore_imx93.env
rename to board/phytec/phycore_imx91_93/phycore_imx91_93.env
index c8fb3a875da0..a39359869d66 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx91_93/phycore_imx91_93.env
@@ -9,6 +9,8 @@ fdtoverlay_addr_r=0x900c0000
 ip_dyn=yes
 kernel_addr_r=0x88000000
 nfsroot=/srv/nfs
+#ifdef CONFIG_IMX93
 prepare_mcore=setenv optargs "${optargs} clk-imx93.mcore_booted"
+#endif
 scriptaddr=0x83500000
 sd_dev=1    /* This is needed by built-in uuu flash scripts */
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx91_93/spl.c
similarity index 75%
rename from board/phytec/phycore_imx93/spl.c
rename to board/phytec/phycore_imx91_93/spl.c
index aa7d562911a7..92441c5af329 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx91_93/spl.c
@@ -19,7 +19,7 @@
 #include <power/pca9450.h>
 #include <spl.h>
 
-#include "../common/imx93_som_detection.h"
+#include "../common/imx91_93_som_detection.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -50,32 +50,38 @@ void spl_board_init(void)
 void spl_dram_init(void)
 {
 	int ret;
-	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
+	enum phytec_imx91_93_ddr_eeprom_code ddr_opt = PHYTEC_IMX91_93_DDR_INVALID;
 
 	ret = phytec_eeprom_data_setup(NULL, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
-	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
+	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX91_93_RAM_TYPE_FIX))
 		goto out;
 
-	ret = phytec_imx93_detect(NULL);
+	ret = phytec_imx91_93_detect(NULL);
 	if (!ret)
 		phytec_print_som_info(NULL);
 
-	if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX)) {
-		if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB))
-			ddr_opt = PHYTEC_IMX93_LPDDR4X_1GB;
-		else if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB))
-			ddr_opt = PHYTEC_IMX93_LPDDR4X_2GB;
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX91_93_RAM_TYPE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX91_93_RAM_TYPE_LPDDR4_1GB))
+			ddr_opt = PHYTEC_IMX91_93_LPDDR4_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX91_93_RAM_TYPE_LPDDR4X_1GB))
+			ddr_opt = PHYTEC_IMX91_93_LPDDR4X_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX91_93_RAM_TYPE_LPDDR4X_2GB))
+			ddr_opt = PHYTEC_IMX91_93_LPDDR4X_2GB;
 	} else {
-		ddr_opt = phytec_imx93_get_opt(NULL, PHYTEC_IMX93_OPT_DDR);
+		ddr_opt = phytec_imx91_93_get_opt(NULL, PHYTEC_IMX91_93_OPT_DDR);
 	}
 
 	switch (ddr_opt) {
-	case PHYTEC_IMX93_LPDDR4X_1GB:
-		if (is_voltage_mode(VOLT_LOW_DRIVE))
+	case PHYTEC_IMX91_93_LPDDR4_1GB:
+		/* Timings statically set for i.MX91 LPDDR4 1GB. */
+		break;
+	case PHYTEC_IMX91_93_LPDDR4X_1GB:
+		if (IS_ENABLED(CONFIG_IMX93) && is_voltage_mode(VOLT_LOW_DRIVE))
 			set_dram_timings_1gb_lpddr4x_900mhz();
 		break;
-	case PHYTEC_IMX93_LPDDR4X_2GB:
-		set_dram_timings_2gb_lpddr4x();
+	case PHYTEC_IMX91_93_LPDDR4X_2GB:
+		if (IS_ENABLED(CONFIG_IMX93))
+			set_dram_timings_2gb_lpddr4x();
 		break;
 	default:
 		goto out;
@@ -84,7 +90,7 @@ void spl_dram_init(void)
 	return;
 out:
 	puts("Could not detect correct RAM type and size. Fall back to default.\n");
-	if (is_voltage_mode(VOLT_LOW_DRIVE))
+	if (IS_ENABLED(CONFIG_IMX93) && is_voltage_mode(VOLT_LOW_DRIVE))
 		set_dram_timings_1gb_lpddr4x_900mhz();
 	ddr_init(&dram_timing);
 }
@@ -185,10 +191,12 @@ void board_init_f(ulong dummy)
 	/* DDR initialization */
 	spl_dram_init();
 
-	/* Put M33 into CPUWAIT for following kick */
-	ret = m33_prepare();
-	if (!ret)
-		printf("M33 prepare ok\n");
+	if (IS_ENABLED(CONFIG_IMX93)) {
+		/* Put M33 into CPUWAIT for following kick */
+		ret = m33_prepare();
+		if (!ret)
+			printf("M33 prepare ok\n");
+	}
 
 	board_init_r(NULL, 0);
 }
diff --git a/board/phytec/phycore_imx93/Kconfig b/board/phytec/phycore_imx93/Kconfig
deleted file mode 100644
index 09f26e89e333..000000000000
--- a/board/phytec/phycore_imx93/Kconfig
+++ /dev/null
@@ -1,41 +0,0 @@
-
-if TARGET_PHYCORE_IMX93
-
-config SYS_BOARD
-	default "phycore_imx93"
-
-config SYS_VENDOR
-	default "phytec"
-
-config SYS_CONFIG_NAME
-	default "phycore_imx93"
-
-config PHYCORE_IMX93_RAM_TYPE_FIX
-	bool "Set phyCORE-i.MX93 RAM type and size fix instead of detecting"
-	default false
-	help
-	  RAM type and size is being automatically detected with the help
-	  of the PHYTEC EEPROM introspection data.
-	  Set RAM type to a fix value instead.
-
-choice
-	prompt "phyCORE-i.MX93 RAM type"
-	depends on PHYCORE_IMX93_RAM_TYPE_FIX
-	default PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
-
-config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB
-	bool "LPDDR4X 1GB RAM"
-	help
-	  Set RAM type fixed to LPDDR4X and RAM size fixed to 1GB
-	  for phyCORE-i.MX93.
-
-config PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB
-	bool "LPDDR4X 2GB RAM"
-	help
-	  Set RAM type fixed to LPDDR4X and RAM size fixed to 2GB
-	  for phyCORE-i.MX93.
-
-endchoice
-
-source "board/phytec/common/Kconfig"
-endif
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
deleted file mode 100644
index 0b087bf1ef23..000000000000
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ /dev/null
@@ -1,12 +0,0 @@
-phyCORE-i.MX93
-M:      Mathieu Othacehe <m.othacehe@gmail.com>
-R:      Christoph Stoidner <c.stoidner@phytec.de>
-L:      upstream@lists.phytec.de
-W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
-S:      Maintained
-F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
-F:      board/phytec/phycore_imx93/
-F:      board/phytec/common/imx93_som_detection.c
-F:      board/phytec/common/imx93_som_detection.h
-F:      configs/imx93-phycore_defconfig
-F:      include/configs/phycore_imx93.h
diff --git a/configs/imx91-phycore_defconfig b/configs/imx91-phycore_defconfig
new file mode 100644
index 000000000000..b1e13bade84e
--- /dev/null
+++ b/configs/imx91-phycore_defconfig
@@ -0,0 +1,167 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="phycore_imx91_93"
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_PHYTEC_EEPROM_BUS=2
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-phyboard-segin"
+CONFIG_TARGET_PHYCORE_IMX91=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204E0000
+CONFIG_SPL_TEXT_BASE=0x204A0000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x20498000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x720000
+CONFIG_CMD_DEKBLOB=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_BOOTDEV is not set
+# CONFIG_CMD_BOOTMETH is not set
+# CONFIG_CMD_BOOTSTD is not set
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=2
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=4096
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_CLK_IMX93=y
+CONFIG_SAVED_DRAM_TIMING_BASE=0x2049C000
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_GPIO_HOG=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY_TI_GENERIC=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX93=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_ULP_WATCHDOG=y
+# CONFIG_RSA is not set
+# CONFIG_SPL_SHA256 is not set
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 3fb6e7b5f1dd..6ae6e405fbf3 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SOURCE_FILE="phycore_imx93"
+CONFIG_ENV_SOURCE_FILE="phycore_imx91_93"
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_PHYTEC_EEPROM_BUS=2
diff --git a/doc/board/phytec/imx93-phycore.rst b/doc/board/phytec/imx91-93-phycore.rst
similarity index 52%
rename from doc/board/phytec/imx93-phycore.rst
rename to doc/board/phytec/imx91-93-phycore.rst
index bd110a3ebee6..42bcda100e0f 100644
--- a/doc/board/phytec/imx93-phycore.rst
+++ b/doc/board/phytec/imx91-93-phycore.rst
@@ -1,9 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
-phyCORE-i.MX 93
-===============
+phyCORE-i.MX 91/93
+==================
 
-U-Boot for the phyCORE-i.MX 93.
+U-Boot for the phyCORE-i.MX 91/93. Both SoC variants, that is i.MX 91 and i.MX 93,
+are supported by same board code, however each variant uses different defconfig
+and ATF/ELE firmware blobs. Please follow the correct steps for the populated SoC.
 
 Quick Start
 -----------
@@ -18,7 +20,17 @@ Get and Build the ARM Trusted firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.8
+branch: lf_v2.12
+
+For phyCORE-i.MX 91 variant:
+
+.. code-block:: bash
+
+   $ unset LDFLAGS
+   $ make PLAT=imx91 bl31
+   $ cp build/imx91/release/bl31.bin $(srctree)
+
+For phyCORE-i.MX 93 variant:
 
 .. code-block:: bash
 
@@ -41,14 +53,24 @@ Get ahab-container.img
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.11.bin
-   $ chmod +x firmware-sentinel-0.11.bin
-   $ ./firmware-sentinel-0.11.bin
-   $ cp firmware-sentinel-0.11/mx93a1-ahab-container.img $(srctree)
+   $ wget  https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
+   $ ./firmware-ele-imx-1.3.0-17945fc.bin
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx91a0-ahab-container.img $(srctree)
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx93a1-ahab-container.img $(srctree)
 
 Build U-Boot
 ------------
 
+For phyCORE-i.MX 91 variant:
+
+.. code-block:: bash
+
+   $ make imx91-phycore_defconfig
+   $ make
+
+For phyCORE-i.MX 93 variant:
+
 .. code-block:: bash
 
    $ make imx93-phycore_defconfig
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index dd9edd792f40..4519079ab3dd 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -8,7 +8,7 @@ PHYTEC
 
    imx8mp-libra-fpsc
    imx8mm-phygate-tauri-l
-   imx93-phycore
+   imx91-93-phycore
    phycore-am62x
    phycore-am62ax
    phycore-am64x
diff --git a/include/configs/phycore_imx93.h b/include/configs/phycore_imx91_93.h
similarity index 88%
rename from include/configs/phycore_imx93.h
rename to include/configs/phycore_imx91_93.h
index 07364dff4030..02fa1d9b274d 100644
--- a/include/configs/phycore_imx93.h
+++ b/include/configs/phycore_imx91_93.h
@@ -6,8 +6,8 @@
  * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
  */
 
-#ifndef __PHYCORE_IMX93_H
-#define __PHYCORE_IMX93_H
+#ifndef __PHYCORE_IMX91_93_H
+#define __PHYCORE_IMX91_93_H
 
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
@@ -25,4 +25,4 @@
 /* Using ULP WDOG for reset */
 #define WDOG_BASE_ADDR          WDG3_BASE_ADDR
 
-#endif /* __PHYCORE_IMX93_H */
+#endif /* __PHYCORE_IMX91_93_H */
-- 
2.34.1

