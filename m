Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD85FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B18886900;
	Thu, 24 Aug 2023 21:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A7686901; Thu, 24 Aug 2023 21:04:04 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD9D866D4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qZFcc-008JVP-OS; Thu, 24 Aug 2023 19:03:58 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm: dts: imx8m: move CAAM nodes into common u-boot.dtsi
Date: Thu, 24 Aug 2023 12:03:56 -0700
Message-Id: <20230824190356.981178-1-tharvey@gateworks.com>
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

Move the crypto and sec_jr* nodes from board-specific
u-boot.dtsi files into the common files. Additionally protect the
nodes with ifdef CONFIG_FSL_CAAM as they don't serve any purpose if
that is not enabled.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - fix invalid ifdef
 - add rb tags from Fabio and Peng
---
 arch/arm/dts/imx8mm-evk-u-boot.dtsi           | 16 ---------------
 .../dts/imx8mm-kontron-bl-common-u-boot.dtsi  | 16 ---------------
 arch/arm/dts/imx8mm-u-boot.dtsi               | 20 +++++++++++++++++++
 arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi      | 16 ---------------
 arch/arm/dts/imx8mn-u-boot.dtsi               | 20 +++++++++++++++++++
 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi    | 16 ---------------
 arch/arm/dts/imx8mp-evk-u-boot.dtsi           | 16 ---------------
 .../imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi   | 16 ---------------
 arch/arm/dts/imx8mp-u-boot.dtsi               | 20 +++++++++++++++++++
 .../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    | 16 ---------------
 10 files changed, 60 insertions(+), 112 deletions(-)

diff --git a/arch/arm/dts/imx8mm-evk-u-boot.dtsi b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
index 155670da18d1..9a5b0795133b 100644
--- a/arch/arm/dts/imx8mm-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-evk-u-boot.dtsi
@@ -65,22 +65,6 @@
 	bootph-pre-ram;
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &usbmisc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
index 1ad9d49a1118..ae542fdcffad 100644
--- a/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-kontron-bl-common-u-boot.dtsi
@@ -18,22 +18,6 @@
 	};
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &i2c1 {
 	bootph-pre-ram;
 	bootph-all;
diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index a843bb851eaf..0bd7ad980b66 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -18,6 +18,12 @@
 #endif
 };
 
+#ifdef CONFIG_FSL_CAAM
+&crypto {
+	bootph-pre-ram;
+};
+#endif
+
 &soc {
 	bootph-all;
 	bootph-pre-ram;
@@ -216,6 +222,20 @@
 	bootph-pre-ram;
 };
 
+#ifdef CONFIG_FSL_CAAM
+&sec_jr0 {
+	bootph-pre-ram;
+};
+
+&sec_jr1 {
+	bootph-pre-ram;
+};
+
+&sec_jr2 {
+	bootph-pre-ram;
+};
+#endif
+
 &spba1 {
 	bootph-all;
 	bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi b/arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi
index 315714f39848..c31f3dec3de4 100644
--- a/arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-ddr4-evk-u-boot.dtsi
@@ -57,22 +57,6 @@
 	bootph-pre-ram;
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 86c9a6cd67f0..3a9e4c16281e 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -54,6 +54,12 @@
 	/delete-property/ assigned-clock-rates;
 };
 
+#ifdef CONFIG_FSL_CAAM
+&crypto {
+	bootph-pre-ram;
+};
+#endif
+
 &iomuxc {
 	bootph-pre-ram;
 };
@@ -63,6 +69,20 @@
 	bootph-all;
 };
 
+#ifdef CONFIG_FSL_CAAM
+&sec_jr0 {
+	bootph-pre-ram;
+};
+
+&sec_jr1 {
+	bootph-pre-ram;
+};
+
+&sec_jr2 {
+	bootph-pre-ram;
+};
+#endif
+
 &spba1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
index c69f7c9c32c0..393fd8ec2e5b 100644
--- a/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi
@@ -21,10 +21,6 @@
 	bootph-pre-ram;
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
 &eqos {
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
@@ -131,18 +127,6 @@
 	u-boot,off-on-delay-us = <20000>;
 };
 
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &tpm {
 	compatible = "tcg,tpm_tis-spi";
 };
diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 17965c58ba10..6d9b229989ac 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -65,22 +65,6 @@
 	bootph-pre-ram;
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &i2c1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
index fe20938af536..cf2a87a9b903 100644
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi
@@ -62,22 +62,6 @@
 	bootph-pre-ram;
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &i2c1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index b2f213e3e706..afaf64ee9cd8 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -19,6 +19,12 @@
 #endif
 };
 
+#ifdef CONFIG_FSL_CAAM
+&crypto {
+	bootph-pre-ram;
+};
+#endif
+
 &soc {
 	bootph-all;
 	bootph-pre-ram;
@@ -62,6 +68,20 @@
 	bootph-pre-ram;
 };
 
+#ifdef CONFIG_FSL_CAAM
+&sec_jr0 {
+	bootph-pre-ram;
+};
+
+&sec_jr1 {
+	bootph-pre-ram;
+};
+
+&sec_jr2 {
+	bootph-pre-ram;
+};
+#endif
+
 &binman {
 	 u-boot-spl-ddr {
 		filename = "u-boot-spl-ddr.bin";
diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index fc87d3f4035b..2a1aa1935a76 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -28,10 +28,6 @@
 
 };
 
-&crypto {
-	bootph-pre-ram;
-};
-
 &gpio1 {
 	bootph-pre-ram;
 };
@@ -140,18 +136,6 @@
 	bootph-pre-ram;
 };
 
-&sec_jr0 {
-	bootph-pre-ram;
-};
-
-&sec_jr1 {
-	bootph-pre-ram;
-};
-
-&sec_jr2 {
-	bootph-pre-ram;
-};
-
 &uart3 {
 	bootph-pre-ram;
 };
-- 
2.25.1

