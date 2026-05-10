Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38598CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 20:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D497846D1;
	Sun, 10 May 2026 22:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="YExeHM4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18280846D7; Sun, 10 May 2026 22:37:47 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CE8846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 22:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 60F04B0051E;
 Sun, 10 May 2026 22:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778445464;
 bh=B05hn5Txwk+lxzDpc5tOQ/ErB4g1nZFJj8WlqhnaIDI=;
 h=From:To:Cc:Subject:Date:From;
 b=YExeHM4w77kOvcQc2q682mn3qOUHUC9PM66KPo5gcKD086Lvg4GFiCyDg7YKGtIr4
 li5ylKnbR/mQJ+4BG+0AlWwpZT5gDTyYwMKUGxFSnyjONzZD772ncPHFQomDEWbWl5
 HbE4BhTa9kbRjXVgmhrhdAgPZVpXkaMe4bnO53cdpH4njOuATFaOgD1VD6u9f47Tn3
 GOKvgoFuWqo1ZfLBN1Df3YIsYFd3RvvBoPZVUQPuKcVe4/UCrTL1NbNsDNhJ0qb8N9
 EXHyEEb9mq/pQemkUL4qkRBUcMLbGvMFvo9NAmul3nDMXjl4jKPLZRV01txcxxpE+O
 VrhRQInJJCBYA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v1] arm: dts: layerscape: fix many DTS warnings
Date: Sun, 10 May 2026 22:37:33 +0200
Message-ID: <20260510203738.515452-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

SPI controller bridge nodes (flexspi@/dspi@/quadspi@) and
the SPI flash child nodes were not using
proper names, so dtc warns about them. The old label
is kept as an inline comment for grep-ability.

Also drop a block of three &dspi{0,1,2} in fsl-lx2162a-qds.dts
that are provided by fsl-lx2160a-qds.dtsi, so the warning fix
is not duplicated.

No functional change.

Example, it fixes the following dtc warnings:

  fsl-lx2160a.dtsi: Warning (spi_bus_bridge): /flexspi@20c0000: node name for SPI buses should be 'spi'
  fsl-lx2160a.dtsi: Warning (spi_bus_bridge): /dspi@2100000: node name for SPI buses should be 'spi'
  fsl-lx2160a-qds-*.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-lx2162a-qds-*.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-ls2080a.dtsi: Warning (spi_bus_bridge): /dspi@2100000: node name for SPI buses should be 'spi'
  fsl-ls2080a.dtsi: Warning (spi_bus_bridge): /quadspi@1550000: node name for SPI buses should be 'spi'
  fsl-ls2080a-qds.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-ls2080a-qds-42-x.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-ls2081a-rdb.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-ls2088a-rdb-qspi.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
  fsl-ls1088a-qds.dtsi: Warning (spi_bus_reg): /soc/spi@2100000/ n25q128a: SPI bus unit address format error, expected "0"
  fsl-ls1088a-qds.dtsi: Warning (spi_bus_reg): /soc/spi@2100000/ sst25wf040b: SPI bus unit address format error, expected "1"
  ...

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 arch/arm/dts/fsl-ls1012a-qds.dtsi     |  6 +-
 arch/arm/dts/fsl-ls1012a.dtsi         |  4 +-
 arch/arm/dts/fsl-ls1028a-qds.dtsi     | 14 ++--
 arch/arm/dts/fsl-ls1043a-qds.dtsi     |  6 +-
 arch/arm/dts/fsl-ls1043a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls1043a.dtsi         |  6 +-
 arch/arm/dts/fsl-ls1046a-qds.dtsi     |  6 +-
 arch/arm/dts/fsl-ls1046a.dtsi         |  6 +-
 arch/arm/dts/fsl-ls1088a-qds.dtsi     |  6 +-
 arch/arm/dts/fsl-ls2080a-qds.dtsi     |  6 +-
 arch/arm/dts/fsl-ls2080a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls2080a.dtsi         |  4 +-
 arch/arm/dts/fsl-ls2081a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls2088a-rdb-qspi.dts |  2 +-
 arch/arm/dts/fsl-lx2160a-qds.dtsi     | 18 ++---
 arch/arm/dts/fsl-lx2160a.dtsi         |  8 +--
 arch/arm/dts/fsl-lx2162a-qds.dts      | 99 ---------------------------
 17 files changed, 49 insertions(+), 148 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1012a-qds.dtsi b/arch/arm/dts/fsl-ls1012a-qds.dtsi
index 910d2a5c778..474649e9392 100644
--- a/arch/arm/dts/fsl-ls1012a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1012a-qds.dtsi
@@ -17,7 +17,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -25,7 +25,7 @@
 		spi-max-frequency = <1000000>; /* input clock */
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -33,7 +33,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1012a.dtsi b/arch/arm/dts/fsl-ls1012a.dtsi
index 796d72fc9ed..cf4246012ad 100644
--- a/arch/arm/dts/fsl-ls1012a.dtsi
+++ b/arch/arm/dts/fsl-ls1012a.dtsi
@@ -48,7 +48,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 { /* dspi@2100000 */
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -178,7 +178,7 @@
 			clocks = <&clockgen 4 0>;
 		};
 
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 { /* quadspi@1550000 */
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1028a-qds.dtsi b/arch/arm/dts/fsl-ls1028a-qds.dtsi
index 3b063d0257d..8002391b1fd 100644
--- a/arch/arm/dts/fsl-ls1028a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-qds.dtsi
@@ -26,7 +26,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: sst25wf040b {
+	dflash0: flash@0 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -36,7 +36,7 @@
 		reg = <0>;
 	};
 
-	dflash1: en25s64 {
+	dflash1: flash@1 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -45,7 +45,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: n25q128a {
+	dflash2: flash@2 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -60,7 +60,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash3: sst25wf040b {
+	dflash3: flash@0 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -70,7 +70,7 @@
 		reg = <0>;
 	};
 
-	dflash4: en25s64 {
+	dflash4: flash@1 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -79,7 +79,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash5: n25q128a {
+	dflash5: flash@2 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -94,7 +94,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash8: en25s64 {
+	dflash8: flash@0 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
diff --git a/arch/arm/dts/fsl-ls1043a-qds.dtsi b/arch/arm/dts/fsl-ls1043a-qds.dtsi
index 5e02cd91d75..80560caebff 100644
--- a/arch/arm/dts/fsl-ls1043a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1043a-qds.dtsi
@@ -21,7 +21,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -31,7 +31,7 @@
 		reg = <0>;
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -41,7 +41,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1043a-rdb.dts b/arch/arm/dts/fsl-ls1043a-rdb.dts
index f5b3bb68b3d..10a5962cb78 100644
--- a/arch/arm/dts/fsl-ls1043a-rdb.dts
+++ b/arch/arm/dts/fsl-ls1043a-rdb.dts
@@ -28,7 +28,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dspiflash: n25q12a {
+	dspiflash: flash@0 { /* n25q12a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1043a.dtsi b/arch/arm/dts/fsl-ls1043a.dtsi
index 21643a1d951..feedc305800 100644
--- a/arch/arm/dts/fsl-ls1043a.dtsi
+++ b/arch/arm/dts/fsl-ls1043a.dtsi
@@ -54,7 +54,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 { /* dspi@2100000 */
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -67,7 +67,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi@2110000 {
+		dspi1: spi@2110000 { /* dspi@2110000 */
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -306,7 +306,7 @@
 			clock-names = "ipg";
 			status = "disabled";
 		};
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 { /* quadspi@1550000 */
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1046a-qds.dtsi b/arch/arm/dts/fsl-ls1046a-qds.dtsi
index d66824975c5..9750533a259 100644
--- a/arch/arm/dts/fsl-ls1046a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1046a-qds.dtsi
@@ -21,7 +21,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -31,7 +31,7 @@
 		reg = <0>;
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -41,7 +41,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1046a.dtsi b/arch/arm/dts/fsl-ls1046a.dtsi
index 44ee4c5808d..505760dd3ee 100644
--- a/arch/arm/dts/fsl-ls1046a.dtsi
+++ b/arch/arm/dts/fsl-ls1046a.dtsi
@@ -54,7 +54,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 { /* dspi@2100000 */
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -67,7 +67,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi@2110000 {
+		dspi1: spi@2110000 { /* dspi@2110000 */
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -311,7 +311,7 @@
 			status = "disabled";
 		};
 
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 { /* quadspi@1550000 */
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1088a-qds.dtsi b/arch/arm/dts/fsl-ls1088a-qds.dtsi
index 4d21d4fbd5e..a11b99ed14a 100644
--- a/arch/arm/dts/fsl-ls1088a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-qds.dtsi
@@ -144,7 +144,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -152,7 +152,7 @@
 		spi-max-frequency = <1000000>; /* input clock */
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -160,7 +160,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a-qds.dtsi b/arch/arm/dts/fsl-ls2080a-qds.dtsi
index cb7851f2cc0..0524e74a6ca 100644
--- a/arch/arm/dts/fsl-ls2080a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls2080a-qds.dtsi
@@ -31,7 +31,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -40,7 +40,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -49,7 +49,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a-rdb.dts b/arch/arm/dts/fsl-ls2080a-rdb.dts
index 0a87caeba96..b7f648eedb5 100644
--- a/arch/arm/dts/fsl-ls2080a-rdb.dts
+++ b/arch/arm/dts/fsl-ls2080a-rdb.dts
@@ -22,7 +22,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: flash@0 { /* n25q512a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a.dtsi b/arch/arm/dts/fsl-ls2080a.dtsi
index d754eb4d5cc..cbf018cfd81 100644
--- a/arch/arm/dts/fsl-ls2080a.dtsi
+++ b/arch/arm/dts/fsl-ls2080a.dtsi
@@ -118,7 +118,7 @@
 		interrupts = <0 35 0x4>; /* Level high type */
 	};
 
-	dspi: dspi@2100000 {
+	dspi: spi@2100000 { /* dspi@2100000 */
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -127,7 +127,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	qspi: quadspi@1550000 {
+	qspi: spi@1550000 { /* quadspi@1550000 */
 		compatible = "fsl,ls2080a-qspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls2081a-rdb.dts b/arch/arm/dts/fsl-ls2081a-rdb.dts
index b0b7ef08a02..5a8aee8e731 100644
--- a/arch/arm/dts/fsl-ls2081a-rdb.dts
+++ b/arch/arm/dts/fsl-ls2081a-rdb.dts
@@ -25,7 +25,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: flash@0 { /* n25q512a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts b/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
index a609290000f..a63b4e72897 100644
--- a/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
+++ b/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
@@ -113,7 +113,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: flash@0 { /* n25q512a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-lx2160a-qds.dtsi b/arch/arm/dts/fsl-lx2160a-qds.dtsi
index e96605b1b4f..b897b460083 100644
--- a/arch/arm/dts/fsl-lx2160a-qds.dtsi
+++ b/arch/arm/dts/fsl-lx2160a-qds.dtsi
@@ -31,7 +31,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -40,7 +40,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -49,7 +49,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -64,7 +64,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash3: n25q128a {
+	dflash3: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -73,7 +73,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash4: sst25wf040b {
+	dflash4: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -82,7 +82,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash5: en25s64 {
+	dflash5: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -97,7 +97,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash6: n25q128a {
+	dflash6: flash@0 { /* n25q128a */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -106,7 +106,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash7: sst25wf040b {
+	dflash7: flash@1 { /* sst25wf040b */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -115,7 +115,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash8: en25s64 {
+	dflash8: flash@2 { /* en25s64 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
diff --git a/arch/arm/dts/fsl-lx2160a.dtsi b/arch/arm/dts/fsl-lx2160a.dtsi
index 680c69c7b73..1e281215364 100644
--- a/arch/arm/dts/fsl-lx2160a.dtsi
+++ b/arch/arm/dts/fsl-lx2160a.dtsi
@@ -134,7 +134,7 @@
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
 	};
 
-	fspi: flexspi@20c0000 {
+	fspi: spi@20c0000 { /* flexspi@20c0000 */
 		compatible = "nxp,lx2160a-fspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -221,7 +221,7 @@
 		status = "disabled";
 	};
 
-	dspi0: dspi@2100000 {
+	dspi0: spi@2100000 { /* dspi@2100000 */
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -230,7 +230,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	dspi1: dspi@2110000 {
+	dspi1: spi@2110000 { /* dspi@2110000 */
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -239,7 +239,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	dspi2: dspi@2120000 {
+	dspi2: spi@2120000 { /* dspi@2120000 */
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-lx2162a-qds.dts b/arch/arm/dts/fsl-lx2162a-qds.dts
index 0ca30df8620..35d80639958 100644
--- a/arch/arm/dts/fsl-lx2162a-qds.dts
+++ b/arch/arm/dts/fsl-lx2162a-qds.dts
@@ -37,105 +37,6 @@
 	status = "disabled";
 };
 
-&dspi0 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash0: n25q128a {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash1: sst25wf040b {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash2: en25s64 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
-&dspi1 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash3: n25q128a {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash4: sst25wf040b {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash5: en25s64 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
-&dspi2 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash6: n25q128a {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash7: sst25wf040b {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash8: en25s64 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-flash";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
 &esdhc1 {
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/dts-layerscape-warnings
