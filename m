Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C34B88365;
	Mon, 22 Apr 2024 08:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uX+S2n3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F6D88360; Mon, 22 Apr 2024 08:30:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A1C788354
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767421; bh=d32gzkUhQMieEs8Dff4wRtnFyN2k+fcMFXL8Wr7rUgo=;
 b=uX+S2n3UHcD8k6W5wu3X8/87hI6IeBs6nCUNU28kyPF/UdEKw97w58mlwSEIpad+wVMrM0U1Z
 8g2Mg73VaGOM1JAQdreBCIzgYHF7boij+/3m9k2OJ2mePA7jO/BSOCbN3mlgJyqLWCWUmrhCjaj
 RtPvap+554Zdu3Xz+Are8UXF298zaBRRCLqc8gc3jYJc02ujGLRPnPt/NM3JoAQQCi5H/FRmJ93
 by4m0KU7AAYCme4AUVqZDSjJ6vRp9iVp/9NNOZnn9x6MNnN1TCZKmbao++yy8A7UzrQTkwezr+P
 418V6+u8suKODVVPeHF44su0Eq465B+C/G6Ny9dh6m3g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 11/28] rockchip: rk35xx: Sort soc u-boot.dtsi alphabetically
Date: Mon, 22 Apr 2024 06:28:48 +0000
Message-ID: <20240422062936.681359-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 662603fd34ba165ad4474342
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
v3: Include binman node in sort (Quentin)
v3: Collect r-b tag
v2: Follow kernel sort order (Quentin)

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
---
 arch/arm/dts/rk356x-u-boot.dtsi  | 112 +++++++++++++++----------------
 arch/arm/dts/rk3588s-u-boot.dtsi |  91 ++++++++++++-------------
 2 files changed, 99 insertions(+), 104 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 05367216e118..8ac10f1698f6 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -38,46 +38,21 @@
 	};
 };
 
-&xin24m {
-	bootph-all;
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x8000>;
+		};
+	};
 };
+#endif
 
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
@@ -102,10 +77,51 @@
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
@@ -126,31 +142,15 @@
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
 
-#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-&binman {
-	simple-bin-spi {
-		mkimage {
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			offset = <0x8000>;
-		};
-	};
+&uart2m0_xfer {
+	bootph-all;
+};
+
+&xin24m {
+	bootph-all;
 };
-#endif
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 233eb79d9ba2..7fcbdb969240 100644
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
@@ -125,6 +120,21 @@
 	};
 };
 
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+&binman {
+	simple-bin-spi {
+		mkimage {
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			offset = <0x8000>;
+		};
+	};
+};
+#endif
+
+&cru {
+	bootph-pre-ram;
+};
+
 &emmc_bus8 {
 	bootph-all;
 };
@@ -145,32 +155,24 @@
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
@@ -185,18 +187,18 @@
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
@@ -213,6 +215,10 @@
 	bootph-all;
 };
 
+&sys_grf {
+	bootph-pre-ram;
+};
+
 &uart2 {
 	bootph-pre-ram;
 	clock-frequency = <24000000>;
@@ -222,17 +228,6 @@
 	bootph-all;
 };
 
-&ioc {
-	bootph-pre-ram;
+&xin24m {
+	bootph-all;
 };
-
-#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-&binman {
-	simple-bin-spi {
-		mkimage {
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			offset = <0x8000>;
-		};
-	};
-};
-#endif
-- 
2.43.2

