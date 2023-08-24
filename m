Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6D78692D;
	Thu, 24 Aug 2023 21:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A02868D7; Thu, 24 Aug 2023 21:01:52 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4134186901
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qZFaU-008JUB-Ph; Thu, 24 Aug 2023 19:01:46 +0000
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
Subject: [PATCH v2 2/3] arm: dts: imx8mp: move firmware/optee node to common
 imx8mp-u-boot.dtsi
Date: Thu, 24 Aug 2023 12:01:43 -0700
Message-Id: <20230824190144.980883-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230824190144.980883-1-tharvey@gateworks.com>
References: <20230824190144.980883-1-tharvey@gateworks.com>
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

Move the firmware/optee node to the common imx8mp-u-boot.dtsi and
protect it with an ifdef CONFIG_OPTEE as it is a meaningless node
without the optee driver enabled.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Fabio Estevam <festevam@denx.de>
---
v2: added Fabio's rb tag
---
 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi           | 7 -------
 arch/arm/dts/imx8mp-evk-u-boot.dtsi                  | 6 ------
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi | 7 -------
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi           | 7 -------
 arch/arm/dts/imx8mp-u-boot.dtsi                      | 9 +++++++++
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi        | 7 -------
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi      | 7 -------
 7 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
index b56f3a2bd2e1..c69f7c9c32c0 100644
--- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
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
 
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 6784ed2e7c92..17965c58ba10 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -11,12 +11,6 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-	};
 };
 
 &reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
index d411cf79e85d..fe20938af536 100644
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
@@ -12,13 +12,6 @@
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
 
 &reg_usdhc2_vmmc {
diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
index f3fb44046d5c..8f1df232b1b7 100644
--- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
@@ -12,13 +12,6 @@
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
 
 &iomuxc {
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 36e7444a627b..b2f213e3e706 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -8,6 +8,15 @@
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
diff --git a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
index 501bc0ce200e..240fbc1b568f 100644
--- a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
@@ -6,13 +6,6 @@
 #include "imx8mp-u-boot.dtsi"
 
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
diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 0162f9b2da37..fc87d3f4035b 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -6,13 +6,6 @@
 #include "imx8mp-u-boot.dtsi"
 
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

