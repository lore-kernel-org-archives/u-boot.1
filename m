Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB2C55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F9A680E8D;
	Sat,  1 Aug 2026 16:41:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jj3Hg7mFa8lV; Sat,  1 Aug 2026 16:41:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DFDE80E25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602497;
	bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NZVFhDTG5lZoL2uQKDeZYRitvrtHDeH05hdDjOo6MZ2wy4/d3zvvDWjZTMFVbt0F+
	 7CA8SpfMyN/YlO8liueymbIV7iDxlv3TwRD/Qfttzy8nBb63bfFC4Xe1fPT1JNWuEe
	 bbPK0IaMfMk/Fl2xWE4su1j9S7DGAToWG3+7XD/8wJL0ghZM4bPlrAohbHMPA+RFeb
	 2PIBaZA7HoHmY0Zq9YTm61OKsoer4OeyWZzgmYiR+1+QsuLi/AKPAdzL50cPq3eOiW
	 WRVkRucV/bA70ZLt1jtHAnwZzk7P2uRLvMy2V0W9VKNI0mcuFl5Sx+sQySAkzB46GH
	 GWYtqOPj9n5XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFDE80E25;
	Sat,  1 Aug 2026 16:41:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F231389
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D2EE40015
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EtCEX1j6br7i for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 49C3C40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 49C3C40025
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49C3C40025
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:35 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so954318a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602494; x=1786207294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
 b=nekIN6LCY1avpq1nQM6yI/pQ1iLBLnTYnm1aqgWB8jMEwsle7+SlQ+w1WLa3MPbF9N
 NiUupBuvYaqMOO7w8GyCTed6+bTfCi9Jjs1SRaGFXMKLYS+3/jN36xz+rZRSNv0iTdIT
 g1BniICLuk8Qm459n+485xeA6a5zUlnSntUXWotf+YzKYhcSIoGMx64aq8qjRJx/vSh4
 OEkRwAq6dWyhVP1ig6xNcI+sbsAH8UOB5RRKA8bZtGn1a6KxQYoCO4e1r7imXs56yXa0
 YomQxcF7WDcPEzzOVFBnkV4NtB4TQbWOllr7pW9P/oaDz0exYX/Yy4NKKu3mYe3AJrP8
 Ulsw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq38F3otGsfTYfuwzOFTbnqcjTo+dn3Wxm+z6rXOp8X+9bgNYb8BpTfpBauzKf6dbC34JmSbAA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy03Q8MN1YUepgf5O7csc5e6AqSjViHY7AuRkxiipR/EJUJPDnW
 +MPjrmD2JbTUrVKTMyS/ZcYdNpjkn5r71fLlyBz8hdN91eF3TRqMUnRKy9JA6/4l86Q=
X-Gm-Gg: AR+sD12q04mqpKjfejw2Mo4Ka1p/4n0FsiLH1jQ8wLqOXJj/5qdam6qN7pyolJl036u
 ihrWDDzRuL7eVpF2djyfmCtmDfQcLLq01fsIE0w34/ke5GHqPFK3B2nlyCFKMPKNLO0T8lQOmPh
 VtlwzMcQgG9r4LS9FcE5iv32Cl9tF0MYlAZbnVgjHfQjXGvAkyqkYVAlTHHGj2fgoVjXL0i7zLx
 xdx/PcDFWHsJT5c1rXUoYHWDZfsGaz5/S+nbkoKy1nqEUnS9027cN7IlOB0ghzjOSk5kQuIKVh0
 jOKm81oveUBsyTXtnboSrSDS714MRCDfp2mMrnUB2ExgMY08S1QkbviOrsea5WKs0b8f1WZ+ESR
 fxul/hWyQWfAF+J5tHE5urjmqdyPyY7gNN7yrcYBK5Pz+GvM/65BaFFGbt/WQQ8GSdovJDeehvt
 TIqHdBMlBDUh/gxZOTPLGPru8JYEDus8vAN6EIj02SI2tLk9XEfbhikF/8LZ3rbV9lAdizpEPOo
 9eTXVUDU2cUDZvJCe5OXobdn/vXE7C6wp0Udsphl9dT+QK6ItBJTIkYVqckLHAGCSdrUW6T75O8
 6ACWF2smLCpurC8T6z18UiU85w==
X-Received: by 2002:a17:90a:d004:b0:37e:10d1:c05b with SMTP id
 98e67ed59e1d1-38fbc4da0a8mr3776591a91.22.1785602494528; 
 Sat, 01 Aug 2026 09:41:34 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:33 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:47 +0800
Subject: [PATCH v8 06/11] dts: k1: add SD card support in u-boot overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-6-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602494; x=1786207294;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
 b=OT7RK9GRI7p4KMHCZUq532CDeMso188sAGSu+/rXY7fR2oHfv0ANYPmbux7KXeWOQb
 126yPR9SjZLXvmZx2SwfbntlTRwMMX6TysHyR5vDLTMySb+9QYt5zHKZ1bgzlBv54Ia7
 l5114ybdPvPOXaQHGAiT+Mkybxldw9Cj+L1NutTHZ7LADS45xio4510fXCYRcl4uDlKc
 S33BGr2/1FXkLmTeEJQjuAsUWuuqEmDID4rDXmRqfXPCUFhDmdTIshJIIi2fzEe5dQC0
 9ZOeaK7XOI4djR4s7z3CBFCbOaW5rYBUF2DhRPrTb8DMugM7cbT6KwyV3keQ1UjDpDhe
 N8sA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=OT7RK9GR
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
index 7f9443d69510..4823cbc1f339 100644
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
index 8a9a2a09de99..f730f79e3e7a 100644
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

