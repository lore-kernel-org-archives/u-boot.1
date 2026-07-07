Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A5DC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CE784A67;
	Tue,  7 Jul 2026 17:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="yUrChxh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E2F84A52; Tue,  7 Jul 2026 17:22:41 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7343F84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-385b78b44a0so2649158a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437758; x=1784042558;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sqMVEiSYs2N2thesoPMmzWiKfFiJMLhmD+aOrCmRcPE=;
 b=yUrChxh5bS7aob/+nJZEl77dvKKWAJlFxqE5OxTulXzCoY8y6sHIoyCW7Adys9Hifl
 oXM1d9JvsiayC9vGICMbLeVRczH8IxHlCXJ5HuGrcsOsN7eYRHUronNnnAsab/sHMqNy
 pI6wgrThPtsr8xmPXZstADG4NZbkTQoCimaWnyL46taOjKM3eGrovio/i7Rl58LOemjI
 d7ncARDLqEHp3U0bEyEgDX9nIZO+Aex3uAV1Wq1BzVnmsPD8kxwT3F9boBN7ocyJsu8E
 IRCkJpWZevmi4fL3Eux1LyU10rClEF1ofaohEzgsAjZ58vt3cMYjaDHLsEMh71Ov6++T
 9edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437758; x=1784042558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sqMVEiSYs2N2thesoPMmzWiKfFiJMLhmD+aOrCmRcPE=;
 b=N4+Brv1zf8GD79MaTe94c+H7WdV4ipw/V3pWNPlkMCx6YxCQ31zniVfxylIKo2T2bY
 UH3NqsqfovpJrXMzgbJJ1aWTB6kTWSgqLAwm6k/b6a/VSuOrZRYT3rDXPUG1+Nfa60s9
 gnYM31Y81a3PJtv9tXUGew/xu2PzxvEOuaimYol6WSLXXmirPvZVxi3sMp3gfWEKDYib
 X9y4GVi0tmnDMJfdIY8f0AqUMrFNf1lSZYp91bNRQVN9Bh31RMnCnZJ4bE5ocxBc+0EA
 iWuZxfX68bLCDR4PWJMTWZxtSNEf4eHEjneNiBtM38VLeym/pcliEnhkXbvaAcl6hzN/
 H//Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNlxcxvWly0E/DcFejyiqyyd1x2hL+wRaxytOjsHpbrBAai1qev5pwVuAqXlCGPTUqel4VUXc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5sHqVdyjHdYo+0x9iGGTlGzcqhw0jctM2Hrq8bd12ipS5sT6j
 t7OwfJBvTIbYfR8a71Gjr+k75ck/PqvX6OWtFhopPXBo8FUvu7sYG8+uUTHUdJTvL8s=
X-Gm-Gg: AfdE7ckpMXzduJo/y7G3m+BvxbYJCgvsp4lFB4XTcIC1ZQxhQa4WCTf4yilKWcbzJ75
 ISYtbSI4F7uzY83Z4oe2wAG+3lviEB4OM4cqMC9UEaKUDt16d/nGQNWkHW/Le1jUvSDIQLbx/Nz
 g10XTInDQBaAm0LVWs+B8QYl0WuraloE2/3D8zovJfU0jPkX6ClikUSKNxtimc8HGE5IujE/om4
 FFvGy5QZVlEfYMsXS3P3lXZv1iqdfU6PWl7fFGuSU8X2naCeiG9ZqQDH+j5LWkB1+uY0MEaNpaM
 nwUB8g+oFYqi3q9weQqlSQfzILw5f7c3J+Wqa2JsLNFiD8JQp6j4VqPusj4Gz2Zijb24NZFsTrw
 c6u9EuzxdcwkJfj7+9M6bkHjWxtc4JcrXEraVqpCknQcyWjGfpfKuki5DsP0ElVRIT9MtnKHDCH
 gqLpCe2YlVP0kyIO2/V4T3lBASMf0GxoveZUKxLzaFSh1dLIZDYKqFmJupS0HDNep/3Zv9JBEVd
 a1dToOjqPVAN7pMeMzGNuKHh0jucT1k8UADSzNzRl02XnVwarz11E+tYweAhsg2
X-Received: by 2002:a17:90b:2b8c:b0:387:e0cb:7f2 with SMTP id
 98e67ed59e1d1-387e0cb0904mr3099512a91.38.1783437757722; 
 Tue, 07 Jul 2026 08:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:37 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:46 +0800
Subject: [PATCH v4 05/10] dts: k1: add SD card support in u-boot overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-5-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
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
v3:
- Fix SD pinctrl as uhs.
v2:
- Use vmmc-supply as vqmmc-supply on SD node.
- Add alias of mmc0 and mmc1.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 87 ++++++++++++++++++++++++++++++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 82 ++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d6951..582bd61d27c 100644
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
+				pinctrl-names = "default", "uhs";
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
+	sdhci0_1_cfg: sdhci0-1-cfg {			/* uhs */
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
index 8a9a2a09de9..ac67db13d7b 100644
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
+				pinctrl-names = "default", "uhs";
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
+	sdhci0_1_cfg: sdhci0-1-cfg {			/* uhs */
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

