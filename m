Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A456C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E47D84A4C;
	Mon, 29 Jun 2026 17:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vZCIBWho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06F584942; Mon, 29 Jun 2026 17:52:15 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DCF84A5B
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-137335bc3caso7123026c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748331; x=1783353131;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aQkzLainFL7hLpnSUJ4rRtiP5KPWKPBpFW0fOA3Cc8I=;
 b=vZCIBWhoFTFjyv7L2/8Q7ZWNWXybRYpB0q+lDMb55OymnE/9qTLpHGYwg6iTbIaI0b
 WovRiyMeGJ/+4G4EpWt6/jskqEKsYO0VYnHugKH/wfZdieimSp1w0b2hWkCRQktW+GcY
 C7A7apdG6RIqrnErmvCZFpij9ApAngeEMuGqWv5qgRWAl8B97Mrn23X0YldLLn58wT3l
 6oXA7TtFG/cy+fLUAvSvjKYE8pZPhPyTL6IeRAb6RqOedpgtPlT+n03J+Ggjt6RQX2tt
 ytuY1LXEoOoLj3kyEz7nXc93+Kdiu1U6bd+dTo/6MAgcUDu0fiboJP5e9XRTv/UEaQja
 BgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748331; x=1783353131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aQkzLainFL7hLpnSUJ4rRtiP5KPWKPBpFW0fOA3Cc8I=;
 b=T0TNSnE31B9oIzTRKXrJfwbJQJfNFHnYvfgmc9XGT5Dlb18OIOD9vP44pZU1JZeLEe
 Ojn3MXkvVW2D2dfQUtT4xrAOs9jbTe/rZOZQ+AqQJzfVe5Rs5nFSk3QPNbWgL/bhRSYH
 qpBtSqAOagxWk7qj25IQGYHZzYCnAj9ADcFjkaguRSuCGo4WwDXK051maXuiijgFSRjs
 BRPDMeCRPWJlGv8uwfTERox+2be/D4nBMEGdloqXq5FLCDLFu2F3Zih1gYvNFdFOYbfK
 nxPGiMNAqlAT8n2TEOdqqPI0qyXGSPnCLxzV9UjkSqrJXOWbWFeb5P+wuwFbPsntGsDa
 hPSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FpLVCVgW3d+yWCfzP0PKgngfT1Qev8vpAzNbpdhlcuF6F+H/avwSNg6wNduXjpqVVXTGE968=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy0L9yxQ/eOyMZRIM5sVd//ZZSX0hFBdEDNRu5FSAv8PxKWB9M
 /EW/CHxt0YE7pIlOV3wYd8uxbSK64CuDNJL9jcZA8oV0XOo03aSZBiqvDvWioxuRmck=
X-Gm-Gg: AfdE7cm8aAJx2FE8QHvVG9KopD48Vyuc5jImQ6cMdiNfqB5tavMzxBS1vEal+eA1mXo
 whguj6kO3jemo/BnP13cTUAsTu9obGgseuRBjjOOIKa1WEdQCz/7WdLTjUpiUtjgcoHRyY/B97l
 I9b26SWFOhemqBRbfDbf4U21rh3pTNhumg5QZ4FsjgkAi10azwluzDvtTsMQFvgs3LrdgDKPKez
 9ND16Km5up0LFBTCOuZ2TqEPRUn0SfritMLNbpnTDDI9ckC1o8omuLKbx84ZC8kNDf+d0NujU3C
 8MQ8UQYmiwfY6k963bS54O1g+PuXo0FFGBVsh39UdjTO4YzoBUVL2nKzp5UHxHbpc/81pS2gE12
 D8Tk36YMWpZrUEHsoMYnuHWiVI5IxmlCZ8Fvkg4k+WVQQeZw9/6Fv20kPycZhcsidkvSdqIvO2D
 c67Oxv6qtrq7LL+FFAMVkHjjt0TM5tzngxv2flPK1cCa4a/hurdH8ru4zVbbJKdeLN90kWSE9f6
 UBGKMrE3hMfNz19R/GHh/joexdAqnfpjQ0vyB5M7wK2TXwadhM3xA==
X-Received: by 2002:a05:7022:1a84:b0:139:c4e3:9496 with SMTP id
 a92af1059eb24-13b2a157669mr14681c88.13.1782748331107; 
 Mon, 29 Jun 2026 08:52:11 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:52:10 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:18 +0800
Subject: [PATCH v2 v2 4/8] dts: k1: add SD card support in u-boot overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-4-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add the SDH0 controller node and its pinctrl groups to the u-boot
overlay. The upstream DTS only contains the eMMC node; the SD card
controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
missing. Place the new node inside the storage-bus via path-based
merge so it inherits the dma-ranges from the parent bus.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v2:
- Use vmmc-supply as vqmmc-supply on SD node.
- Add alias of mmc0 and mmc1.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 87 ++++++++++++++++++++++++++++++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 82 ++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d6951..463952dc047 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -6,6 +6,11 @@
 #include "binman.dtsi"
 
 / {
+	aliases {
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
@@ -76,12 +81,14 @@
 				bootph-pre-ram;
 			};
 
-			buck3 {
+			buck3_1v8: buck3 {
 				regulator-name = "vdd_1v8";
 				bootph-pre-ram;
 			};
 
-			aldo1 {
+			buck4_3v3: buck4 { };
+
+			aldo1: aldo1 {
 				regulator-name = "vdd_1v8_mmc";
 				bootph-pre-ram;
 			};
@@ -89,6 +96,82 @@
 	};
 };
 
+/ {
+	soc {
+		storage-bus {
+			sdhci0: mmc@d4280000 {
+				bootph-pre-ram;
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4280000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH0>;
+				clock-names = "core", "io";
+				interrupts = <99>;
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH0>;
+				reset-names = "sdh_axi", "sdh0";
+				bus-width = <4>;
+				max-frequency = <204800000>;
+				cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_LOW>;
+				pinctrl-names = "default", "fast";
+				pinctrl-0 = <&sdhci0_0_cfg>;
+				pinctrl-1 = <&sdhci0_1_cfg>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+/* SD card pinctrl groups -- not present in upstream k1-pinctrl.dtsi */
+&pinctrl {
+	sdhci0_0_cfg: sdhci0-0-cfg {
+		grp_cmd_data {
+			pinmux = <K1_PADCONF(104, 0)>,  /* MMC1_DAT3 */
+				 <K1_PADCONF(105, 0)>,  /* MMC1_DAT2 */
+				 <K1_PADCONF(106, 0)>,  /* MMC1_DAT1 */
+				 <K1_PADCONF(107, 0)>,  /* MMC1_DAT0 */
+				 <K1_PADCONF(108, 0)>;  /* MMC1_CMD */
+			bias-pull-up = <1>;
+			drive-strength = <19>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+		};
+	};
+
+	sdhci0_1_cfg: sdhci0-1-cfg {  /* fast */
+		grp_cmd_data {
+			pinmux = <K1_PADCONF(104, 0)>,  /* MMC1_DAT3 */
+				 <K1_PADCONF(105, 0)>,  /* MMC1_DAT2 */
+				 <K1_PADCONF(106, 0)>,  /* MMC1_DAT1 */
+				 <K1_PADCONF(107, 0)>,  /* MMC1_DAT0 */
+				 <K1_PADCONF(108, 0)>;  /* MMC1_CMD */
+			bias-pull-up = <1>;
+			drive-strength = <42>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+		};
+	};
+};
+
+&emmc {
+	bootph-pre-ram;
+	resets = <&syscon_apmu RESET_SDH_AXI>, <&syscon_apmu RESET_SDH2>;
+	reset-names = "sdh_axi", "sdh2";
+	vqmmc-supply = <&buck3_1v8>;
+	vmmc-supply = <&aldo1>;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	vmmc-supply = <&buck4_3v3>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 8a9a2a09de9..24cd8621e08 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -10,6 +10,8 @@
 	aliases {
 		console = &uart0;
 		serial0 = &uart0;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -147,7 +149,7 @@
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4_3v3: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -168,7 +170,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8_mmc";
 				regulator-min-microvolt = <500000>;
@@ -249,6 +251,82 @@
 	};
 };
 
+/ {
+	soc {
+		storage-bus {
+			sdhci0: mmc@d4280000 {
+				bootph-pre-ram;
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4280000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH0>;
+				clock-names = "core", "io";
+				interrupts = <99>;
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH0>;
+				reset-names = "sdh_axi", "sdh0";
+				bus-width = <4>;
+				max-frequency = <204800000>;
+				cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_LOW>;
+				pinctrl-names = "default", "fast";
+				pinctrl-0 = <&sdhci0_0_cfg>;
+				pinctrl-1 = <&sdhci0_1_cfg>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+/* SD card pinctrl groups -- not present in upstream k1-pinctrl.dtsi */
+&pinctrl {
+	sdhci0_0_cfg: sdhci0-0-cfg {
+		grp_cmd_data {
+			pinmux = <K1_PADCONF(104, 0)>,  /* MMC1_DAT3 */
+				 <K1_PADCONF(105, 0)>,  /* MMC1_DAT2 */
+				 <K1_PADCONF(106, 0)>,  /* MMC1_DAT1 */
+				 <K1_PADCONF(107, 0)>,  /* MMC1_DAT0 */
+				 <K1_PADCONF(108, 0)>;  /* MMC1_CMD */
+			bias-pull-up = <1>;
+			drive-strength = <19>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+		};
+	};
+
+	sdhci0_1_cfg: sdhci0-1-cfg {  /* fast */
+		grp_cmd_data {
+			pinmux = <K1_PADCONF(104, 0)>,  /* MMC1_DAT3 */
+				 <K1_PADCONF(105, 0)>,  /* MMC1_DAT2 */
+				 <K1_PADCONF(106, 0)>,  /* MMC1_DAT1 */
+				 <K1_PADCONF(107, 0)>,  /* MMC1_DAT0 */
+				 <K1_PADCONF(108, 0)>;  /* MMC1_CMD */
+			bias-pull-up = <1>;
+			drive-strength = <42>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+		};
+	};
+};
+
+&emmc {
+	bootph-pre-ram;
+	resets = <&syscon_apmu RESET_SDH_AXI>, <&syscon_apmu RESET_SDH2>;
+	reset-names = "sdh_axi", "sdh2";
+	vqmmc-supply = <&buck3_1v8>;
+	vmmc-supply = <&aldo1>;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	vmmc-supply = <&buck4_3v3>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";

-- 
2.51.0

