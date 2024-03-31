Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CDFCD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54913882B8;
	Sun, 31 Mar 2024 22:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r/fd0NbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFFB882C1; Sun, 31 Mar 2024 22:30:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F4D882AD
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917010; bh=qJJp98R+d/0WH+aVMkMSbfdovStLo3iN5bdCPIhklNE=;
 b=r/fd0NbJFCz3aBjIEkFP0P/xeRYF/pyPkjhKrDatJj1KK88a/CHJxjqftXVB+AUn9UPUCklFs
 HMuCRlMzdqa18u5m8meHoH7xZGu6PnNjOmNJjlHWX4q1Dx4UoZ8R4qAtqMhDdrpp+lSbFPtu34b
 0u8MCHsQsFGDJ1fRxsi+6yU3tC93ZxthIUicE7f+zazALjdV3vEQfddHocLegIVMkdGlNu1RKLx
 XkEmE+OPwQVPrL0VZ5PS9OnVpPM/5cB33azXBlHicx0X+O/XwhXpkIi7I4xGGQagVDs0uT3Xwxt
 xdQuDkeDn6PO/7jmgg3gcPz84VZvrzx0P3uGsU/i5cLg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>, Jagan
 Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 09/31] rockchip: rk3399: Add a default spl-boot-order prop
Date: Sun, 31 Mar 2024 20:28:15 +0000
Message-ID: <20240331202921.262323-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7d08fc6b45ed44f72f5
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

A lot of RK3399 boards use a u-boot,spl-boot-order of "same-as-spl",
&sdhci and &sdmmc.

Move this to rk3399-u-boot.dtsi and make this default for boards
currently missing a u-boot,spl-boot-order prop.

The &spi_flash reference has been dropped from spl-boot-order now that
boot source id is cached and "same-as-spl" can be resolved into the SPI
flash node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi      | 1 -
 arch/arm/dts/rk3399-evb-u-boot.dtsi            | 1 -
 arch/arm/dts/rk3399-ficus-u-boot.dtsi          | 6 ------
 arch/arm/dts/rk3399-firefly-u-boot.dtsi        | 6 ------
 arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi    | 6 ------
 arch/arm/dts/rk3399-leez-p710-u-boot.dtsi      | 6 ------
 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi        | 6 ------
 arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi   | 6 ------
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi  | 6 ------
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi         | 4 ----
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi      | 6 ------
 arch/arm/dts/rk3399-rock960-u-boot.dtsi        | 5 -----
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi      | 5 +----
 arch/arm/dts/rk3399-u-boot.dtsi                | 4 ++++
 arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi | 6 ------
 15 files changed, 5 insertions(+), 69 deletions(-)

diff --git a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
index a3f27566e438..6c07de98fa01 100644
--- a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
@@ -9,7 +9,6 @@
 / {
 	chosen {
 		stdout-path = "serial2:1500000n8";
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
index dfce63e4d428..796ac9642399 100644
--- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
@@ -9,7 +9,6 @@
 / {
 	chosen {
 		stdout-path = "serial2:1500000n8";
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-ficus-u-boot.dtsi b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
index 38e0897db91d..67b63a835238 100644
--- a/arch/arm/dts/rk3399-ficus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
@@ -5,9 +5,3 @@
 
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-ddr3-1600.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
diff --git a/arch/arm/dts/rk3399-firefly-u-boot.dtsi b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
index c58ad95d120a..1f5fda1d0f1d 100644
--- a/arch/arm/dts/rk3399-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-ddr3-1600.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
diff --git a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
index a7039d74a016..4a3b23e48313 100644
--- a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
diff --git a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
index c638ce259731..03b596850635 100644
--- a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
index a9d10592d573..a126bbaf086f 100644
--- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
@@ -5,12 +5,6 @@
 
 #include "rk3399-u-boot.dtsi"
 
-/{
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &sdmmc {
 	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
 };
diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
index 88a77cad8d43..83b0c44e9ec5 100644
--- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &spiflash, &sdmmc;
-	};
-};
-
 &edp {
 	rockchip,panel = <&edp_panel>;
 };
diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index cabf0a9dae89..e29757590611 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &rng {
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index c8f4418a7389..e390cf3abab5 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -7,10 +7,6 @@
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
 / {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdhci, &sdmmc;
-	};
-
 	vcc_hub_en: vcc_hub_en-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
index 60122f3bcd6c..b3bfc77f7569 100644
--- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
@@ -6,12 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
diff --git a/arch/arm/dts/rk3399-rock960-u-boot.dtsi b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
index c190089e2643..55716ba4df73 100644
--- a/arch/arm/dts/rk3399-rock960-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
@@ -7,10 +7,6 @@
 #include "rk3399-sdram-lpddr3-2GB-1600.dtsi"
 
 / {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
@@ -22,5 +18,4 @@
 		regulator-init-microvolt = <950000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-
 };
diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 089732524a76..b15e5392c3cf 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -5,11 +5,8 @@
 
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
+
 / {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
-	};
-
         smbios {
                 compatible = "u-boot,sysinfo-smbios";
                 smbios {
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 87b173e59579..fe045ca81749 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -14,6 +14,10 @@
 		spi1 = &spi1;
 	};
 
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
+	};
+
 	cic: syscon@ff620000 {
 		bootph-all;
 		compatible = "rockchip,rk3399-cic", "syscon";
diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
index 7c66e1145a50..946a0230dbb4 100644
--- a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
+++ b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
@@ -5,9 +5,3 @@
 
 #include "rk3399pro-u-boot.dtsi"
 #include "rk3399-sdram-lpddr3-4GB-1600.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
-	};
-};
-- 
2.43.2

