Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CD9C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD4A86900;
	Thu, 24 Aug 2023 21:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE08086925; Thu, 24 Aug 2023 21:01:52 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEF8868D7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qZFaT-008JUB-VC; Thu, 24 Aug 2023 19:01:46 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/3] arm: dts: imx8mm: move firmware/optee node to common
 imx8mm-u-boot.dtsi
Date: Thu, 24 Aug 2023 12:01:42 -0700
Message-Id: <20230824190144.980883-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Move the firmware/optee node to the common imx8mm-u-boot.dtsi and
protect it with an ifdef CONFIG_OPTEE as it is a meaningless node
without the optee driver enabled.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Fabio Estevam <festevam@denx.de>
---
v2: added Fabio's rb tag
---
 arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi | 7 -------
 arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi       | 7 -------
 arch/arm/dts/imx8mm-evk-u-boot.dtsi               | 7 -------
 arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi | 7 -------
 arch/arm/dts/imx8mm-phg-u-boot.dtsi               | 7 -------
 arch/arm/dts/imx8mm-u-boot.dtsi                   | 9 +++++++++
 arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi   | 7 -------
 7 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
index 484e31824b85..d12ce6069cc7 100644
--- a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
@@ -6,13 +6,6 @@
 #include "imx8mm-u-boot.dtsi"
 
 / {
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi b/arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi
index 1878c4e13fbe..219504f61105 100644
--- a/arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-cl-iot-gate-u-boot.dtsi
@@ -6,13 +6,6 @@
 #include "imx8mm-u-boot.dtsi"
 
 / {
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mm-evk-u-boot.dtsi b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
index 13688ec0d0f2..155670da18d1 100644
--- a/arch/arm/dts/imx8mm-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
@@ -11,13 +11,6 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
 };
 
 &aips4 {
diff --git a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
index 65dfd33725ee..1ad9d49a1118 100644
--- a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
@@ -16,13 +16,6 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
 };
 
 &crypto {
diff --git a/arch/arm/dts/imx8mm-phg-u-boot.dtsi b/arch/arm/dts/imx8mm-phg-u-boot.dtsi
index 3ced97cfaafa..c9e0b4420500 100644
--- a/arch/arm/dts/imx8mm-phg-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-phg-u-boot.dtsi
@@ -11,13 +11,6 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
 };
 
 &aips4 {
diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 035282bf0b00..a843bb851eaf 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -7,6 +7,15 @@
 	binman: binman {
 		multiple-images;
 	};
+
+#ifdef CONFIG_OPTEE
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+#endif
 };
 
 &soc {
diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 2b268f55cb95..24e565a06c2f 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -6,13 +6,6 @@
 #include "imx8mm-u-boot.dtsi"
 
 / {
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
-
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
-- 
2.25.1

