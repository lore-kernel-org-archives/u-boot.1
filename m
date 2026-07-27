Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8582C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9354064A;
	Mon, 27 Jul 2026 07:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ZUXH2zXgLJT; Mon, 27 Jul 2026 06:59:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C5A34061F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135598;
	bh=yU0zv+KMs4NSgZFTuzSlJxWSz9CBANOS6N7lH6ksNKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyAEd4MvjD7hkfL3kuAIMXZ4GbbcoMx/Lm01eD7pySWdM1icGGViIp9KKjTU3kRNw
	 dXnAGJ14ai7xfsxvqpjTunO5yJYVNJgPQZFojeCg22/awcyXwr5ws6L1mC2ror5xCP
	 sIEUxQoKw3OmBRr3FUL8QJ5CaSqcBWzb9uwQfg1jbOWGrq3sGlPcXTHItQU6+jurhi
	 OP3giEoSUk/TGGqC7RA7U6BTLn/oDYcckXuDp4xKyBqt++smk/s24C6J3boiD1gCou
	 YSHz56hdsHMW4FB2KHNEykoDrwR6Bw8u4ZJsWSMdn3FOrhkGTRa/yXtKzbNNZ6btD2
	 LM1xinuTLZP7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C5A34061F;
	Mon, 27 Jul 2026 06:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 437A4490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 299F94009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2iw3muuN0Vb for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:59:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A49C4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A49C4008E
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A49C4008E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:59:56 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so2421759b3a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135595; x=1785740395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yU0zv+KMs4NSgZFTuzSlJxWSz9CBANOS6N7lH6ksNKI=;
 b=GHJ78P6/NVGDUvWPabv6jydgenZNkbwi5sx5omsupzeia3I6c+x+S33nbMNAJ5ceRu
 FuHhXWchB//VB2t+7XMQp0sNYxLuocQxjlEFveeV0+xdIr7BciLx4ejwugSD3HhHDUcd
 b5hNf1HtLYUk6IK697Vq+HAxuBXNMSl7AyRrQGXtqv2KjiRw0SsdFpG+dPgmyX1mgB1t
 lCFZQcRS+lqGd/WqtmATrseKCabmkv8YAQ9OVc7jWI0QrVBFKeDe3yO7p0FrR4joz2uB
 KSumiRUfuVPNFvY8zEdYwbCSkkadsIpqyjy8BB3SI23ZPO78t5JQc3zWxWrMCSXGetwm
 6reQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQiI47s++Kw2IjIsWUcLrs1OcrZgFqYyCt/3RZYMW65KTuARoUWb7S0+Z7iidSvvWhzXm8V/Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwiZc9fm5tIId1r+Mc7kl35CG6B/k3clQVIgXDUbb0pGshUm4Z3
 k3rqE4KV6wSguIyX8CCr27j1LqR1bhFm/pHnBVgoCtpEKG4+2+w4T2i0b/8etxAIpE0=
X-Gm-Gg: AR+sD11hoEQYSs3O2X7CArm2E9nQffIT4LWYLPDi4LuZfc48taI9q5zXyxbnJ4HMMk4
 lLKYkuyM/KCGMu1yERbKeH3GZGxDchxPaOJ8v/oaVQ8k57ow6xsBGWAQsARHFVPmDUMCEazgcsH
 9Au6ZspSz9asxfikNJDBP1ON6pu8W62665QNI9VcSUqSg+A3Yl3gmQkMmNyIjuNK2KyENh2kogv
 zN13vj76zgVHdSr5WMqSanEgcUGeS2iluHAscdVrXlk09iw6TjdEHCR87Jr7OCTuTuzcfAolv6o
 t3oq2uUIvmZiDS2S3pIwVlqWBy7k0WWYmlAJrC92vSenAseoh/mDxv6g6kHk/4FZQ3iIb66Bf6W
 0iyo9nNQY4Mu/vyKshcoIkrpI5nUsYFIsS1Zlv5Mizhm2GH3bDJ78p3Pnd9AvaFOjjgQxaDM/NW
 qF0cw2QwQmQqpdCQeu7ZAd1zSHdW2n7FZzAN+rhvz68w7IGv95SiZcHjaesaBQm3TNW5IOrsl5r
 etKg37aj8CtUZVFRc5Nniyqye32pLhTF4OBXzC2ox0=
X-Received: by 2002:a05:6a21:6f13:b0:3c3:33df:4d9a with SMTP id
 adf61e73a8af0-3c67dae959dmr7728291637.1.1785135595494; 
 Sun, 26 Jul 2026 23:59:55 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:59:54 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:08 +0800
Subject: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-6-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135595; x=1785740395;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yU0zv+KMs4NSgZFTuzSlJxWSz9CBANOS6N7lH6ksNKI=;
 b=EnNUEgic+jSog2rloo1hNi2KJJaIqZ9O8mAtJrMyWAGaD5/IkJK+RNL9ZHrhi3M6FB
 1DyB6EtNm2rJJaGlzPGGJBM1op5Ts68dPw9AZPrGXjbXysWGYCQI+5kS9BjeXCaXF/xE
 v6+SQEoc/R+RKCA+ZcRHqobiEqcgoszdIS8Lk2Qq7QiyX6OOlZ/NK5AuOImUH5MZRnU3
 MTY0FwPUSr+ewUKnsGnbOsXUbpy2viCa6cVBaJ5gr6SnLV8wu1ja4rijPEqFpMMqZai1
 g25na63Zbu3YwPxFiH1npyNnrWDVqSNfZ1WHbkaiBCCJNJPfwPw0VGWdjGwyWJIsdb6e
 LGNg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=EnNUEgic
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the SDH0 controller node and its pinctrl groups to the u-boot
overlay. The upstream DTS only contains the eMMC node; the SD card
controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
missing. Place the new node inside the storage-bus via path-based
merge so it inherits the dma-ranges from the parent bus.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v5:
- Append power source field on eMMC/SD pinctrl.
v3:
- Fix SD pinctrl as uhs.
v2:
- Use vmmc-supply as vqmmc-supply on SD node.
- Add alias of mmc0 and mmc1.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 ++++++++++++++++++++++++++++++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 ++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d6951..4823cbc1f33 100644
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
@@ -89,6 +96,86 @@
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
+			power-source = <3300>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
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
+			power-source = <1800>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
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
index 8a9a2a09de9..f730f79e3e7 100644
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
@@ -249,6 +251,86 @@
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
+			power-source = <3300>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
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
+			power-source = <1800>;
+		};
+		grp_clk {
+			pinmux = <K1_PADCONF(109, 0)>;  /* MMC1_CLK */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
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

