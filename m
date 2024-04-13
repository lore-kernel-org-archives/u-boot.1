Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E97C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A87CB8821B;
	Sat, 13 Apr 2024 20:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iCSUrK0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE8A8820E; Sat, 13 Apr 2024 20:15:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD48C87F95
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032111; bh=duypQp9UqpUFoC2X1bsdVwzYYrbxdHv0wzS+qu8qrsw=;
 b=iCSUrK0h6rxliOFFaGEw+ifVOlzO0n/uHjnxKLMEKP6A9PRpGWGD1/DviMJHqkwcTeqL2WP3d
 JJzVzTUUEUAIIZjg15LuUIlFlcbNyicilvesmw3yGgMhYjMH6gdyhRTstxKrjOc0m1B8ATr7EPP
 bAxCE7RZiGea1yfX6NE3Sw81qEGJ81pHvKu1PcycXqIORoREcR38DMTOqcBkZ/gdYL8pqCj9Tsb
 oxI/5fxjEZp7sCXlMRBPre0fn6LUXx7LIFznGDNlpT5rJZSLDsrnuT+gzg+C4qZsqDZ12O9SEjx
 g/6fxd8v2yKyNKMtl23Yhht7pUNSOozcPWQJ2Jufip3A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 10/23] rockchip: rk35xx: Sort soc u-boot.dtsi alphabetically
Date: Sat, 13 Apr 2024 18:13:44 +0000
Message-ID: <20240413181425.1384357-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acbae6fbb975d49a6546b
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

Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
is sorted by reg addr then by alphabetical order.

This has no intended change beside sorting existing nodes and removing
a duplicated usbdpphy0_grf node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Follow kernel sort order (Quentin)

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
---
 arch/arm/dts/rk356x-u-boot.dtsi  | 98 ++++++++++++++++----------------
 arch/arm/dts/rk3588s-u-boot.dtsi | 69 +++++++++++-----------
 2 files changed, 81 insertions(+), 86 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 05367216e118..1ecf719202e9 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -38,46 +38,10 @@
 	};
 };
 
-&xin24m {
-	bootph-all;
-};
-
 &cru {
 	bootph-all;
 };
 
-&pmucru {
-	bootph-all;
-};
-
-&grf {
-	bootph-all;
-};
-
-&pmugrf {
-	bootph-all;
-};
-
-&pinctrl {
-	bootph-all;
-};
-
-&pcfg_pull_none_smt {
-	bootph-all;
-};
-
-&pcfg_pull_none {
-	bootph-all;
-};
-
-&pcfg_pull_up_drv_level_2 {
-	bootph-all;
-};
-
-&pcfg_pull_up {
-	bootph-all;
-};
-
 &emmc_bus8 {
 	bootph-all;
 };
@@ -102,10 +66,51 @@
 	bootph-all;
 };
 
+&grf {
+	bootph-all;
+};
+
 &i2c0_xfer {
 	bootph-all;
 };
 
+&pcfg_pull_none {
+	bootph-all;
+};
+
+&pcfg_pull_none_smt {
+	bootph-all;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
+&pcfg_pull_up_drv_level_2 {
+	bootph-all;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&pmucru {
+	bootph-all;
+};
+
+&pmugrf {
+	bootph-all;
+};
+
+&sdhci {
+	bootph-pre-ram;
+	max-frequency = <200000000>;
+};
+
+&sdmmc0 {
+	bootph-pre-ram;
+};
+
 &sdmmc0_bus4 {
 	bootph-all;
 };
@@ -126,24 +131,19 @@
 	bootph-all;
 };
 
-&uart2m0_xfer {
-	bootph-all;
-};
-
-&sdhci {
-	bootph-pre-ram;
-	max-frequency = <200000000>;
-};
-
-&sdmmc0 {
-	bootph-pre-ram;
-};
-
 &uart2 {
 	bootph-pre-ram;
 	clock-frequency = <24000000>;
 };
 
+&uart2m0_xfer {
+	bootph-all;
+};
+
+&xin24m {
+	bootph-all;
+};
+
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 &binman {
 	simple-bin-spi {
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 233eb79d9ba2..543327954b1a 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -41,6 +41,17 @@
 		status = "disabled";
 	};
 
+	vo0_grf: syscon@fd5a6000 {
+		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		reg = <0x0 0xfd5a6000 0x0 0x2000>;
+		clocks = <&cru PCLK_VO0GRF>;
+	};
+
+	usb_grf: syscon@fd5ac000 {
+		compatible = "rockchip,rk3588-usb-grf", "syscon";
+		reg = <0x0 0xfd5ac000 0x0 0x4000>;
+	};
+
 	usbdpphy0_grf: syscon@fd5c8000 {
 		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
 		reg = <0x0 0xfd5c8000 0x0 0x4000>;
@@ -72,22 +83,6 @@
 		};
 	};
 
-	vo0_grf: syscon@fd5a6000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
-		reg = <0x0 0xfd5a6000 0x0 0x2000>;
-		clocks = <&cru PCLK_VO0GRF>;
-	};
-
-	usb_grf: syscon@fd5ac000 {
-		compatible = "rockchip,rk3588-usb-grf", "syscon";
-		reg = <0x0 0xfd5ac000 0x0 0x4000>;
-	};
-
-	usbdpphy0_grf: syscon@fd5c8000 {
-		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
-		reg = <0x0 0xfd5c8000 0x0 0x4000>;
-	};
-
 	rng: rng@fe378000 {
 		compatible = "rockchip,trngv1";
 		reg = <0x0 0xfe378000 0x0 0x200>;
@@ -125,6 +120,10 @@
 	};
 };
 
+&cru {
+	bootph-pre-ram;
+};
+
 &emmc_bus8 {
 	bootph-all;
 };
@@ -145,32 +144,24 @@
 	bootph-all;
 };
 
-&pinctrl {
-	bootph-all;
+&ioc {
+	bootph-pre-ram;
 };
 
 &pcfg_pull_none {
 	bootph-all;
 };
 
-&pcfg_pull_up_drv_level_2 {
-	bootph-all;
-};
-
 &pcfg_pull_up {
 	bootph-all;
 };
 
-&xin24m {
+&pcfg_pull_up_drv_level_2 {
 	bootph-all;
 };
 
-&cru {
-	bootph-pre-ram;
-};
-
-&sys_grf {
-	bootph-pre-ram;
+&pinctrl {
+	bootph-all;
 };
 
 &pmu1grf {
@@ -185,18 +176,18 @@
 	bootph-pre-ram;
 };
 
-&sdmmc {
-	bootph-pre-ram;
-	bootph-some-ram;
-	u-boot,spl-fifo-mode;
-};
-
 &sdhci {
 	bootph-pre-ram;
 	bootph-some-ram;
 	u-boot,spl-fifo-mode;
 };
 
+&sdmmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+	u-boot,spl-fifo-mode;
+};
+
 &sdmmc_bus4 {
 	bootph-all;
 };
@@ -213,6 +204,10 @@
 	bootph-all;
 };
 
+&sys_grf {
+	bootph-pre-ram;
+};
+
 &uart2 {
 	bootph-pre-ram;
 	clock-frequency = <24000000>;
@@ -222,8 +217,8 @@
 	bootph-all;
 };
 
-&ioc {
-	bootph-pre-ram;
+&xin24m {
+	bootph-all;
 };
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-- 
2.43.2

