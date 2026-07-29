Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6AAC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1684260817;
	Wed, 29 Jul 2026 14:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kN7DU-lyzEk; Wed, 29 Jul 2026 14:49:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 559296066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336562;
	bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQ4kYEIuPaSsF6ZtU2SUdZoFGhEmvOA9CAGoPleun0MdjxsKke6eSa2grGXy7ZghJ
	 ZHruERqTmJzDv1TXk38INGj966w/lbUD3xvGnx8fqlKhgb70idmRZ8cw/7n7igYJrR
	 7y4HnVBqr4dMiI5Pdil3iSvlGc5bP9mSWd71QmAPBLbAhUxa79BxpxkZozaJhCfR6a
	 PvKx/kM+2NEZFagL1Lj8eU0UAn7PYeyjD32JgU9LGYGfDc1DeLpNV8g47mcfScms8p
	 uzSbQwXcst2k6ByJbN2RuTMpdHtjY9hMeoE49lWojhI3A3R0P36MnzTS425MgdAXs9
	 UCWh5Z9ORZ3AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 559296066F;
	Wed, 29 Jul 2026 14:49:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A61A350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C75180880
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3-F9Jk0eZrY for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9A1D780874
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A1D780874
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A1D780874
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:20 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so908416b3a.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336560; x=1785941360;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
 b=oGRL8r/FowXDuCMCUPNZiyZPqJFUEuuuVBrgh0Pwl0KWwtIYATcdx0MefnwrveT9MC
 YMTBS0nWloFn2WYH3FIESOWlTCxqNH6uXuMGl6MxDhy863XPe5QXEjYlnUWbKNyv1/77
 jIlGI/FrIGXT2TNhziuyCyNoxci4bawL59oo70AQsEO9dBPrPOZ6p3dCuZtkia5bRz+j
 v6z6E58qcflADIDQeBulTwsZyR4u0zySnndocwZdxeN7hQ441e+xysAZyw51zo434Wi7
 LkDpv38aEmt15KX7WuTRd6PzBNckjCIgC5H2mynKZ8QBhCNwQR5AYjDBoGyJJ71K7cYe
 rICQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoO4825+yyMNJR4d1RR4SUcCrAtYFqJ7l1QO+Yi1uQQ/7LR23Y3NObZ08wsu9i5qidJA2yl+Cs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxU/FShJDfYDytUj26j4Sm5yapkkrTZcB1YCZokcD6OFwd8wwtl
 xPoOR2ZQ6cJ9nSbeqLBqI6swPbE15xJoHfGg5GU98XALKULTRRwbocpephdWTCbBYe8=
X-Gm-Gg: AR+sD13BA1B/bElxhRySc1sUIPvM45BPZY86EW3K1da2rLBVvsU6/wcozxMemct8g7L
 Iu6MPnJhFqQOzrzEx98zAXg+snA0brRXK+Wd0gh1rJllxbxrEpF33yfF4tZLzV4ztf3rnhSi1AA
 kD0rD40MV7SzLvDgU0kGCRjziYSiki/lUuhOpLVH04aZOsiCTkK6IpeDCo5qzRNexXZRqM25TO1
 erRLGlpKLIU3yp6NRB46OiKt2xSd1Q6vCApARe2zoimOPntU34f+PxkVYmiy04ofy/+glwuaOgy
 GPv5+fp1uOALf3azf8J12eNnaIC5t/WZjHxSB4FkfgAVoUWkw2R0QOkh1Nb2ii4mK3mJI582h3I
 mkSM59NmcJXiA5VgQV5TB4XdmkyYnZlGiK5X84iwohE6X9Rg8S9pKEwJS+TvObyRBuX4VU5HMle
 B3WdCArDnENL9h+650dz6X4brx873Mu45ElmmGp9ZiPF47LNosLxi2dAT5pmVgUJ4hUEW0JO1wR
 48f3uK1wUZUBUpK2Re6+ntYZFs4TOVun32+R92Ak4eIIh4RppzZ6eLAch7exId3bm+uCUbw5eWS
 uHjh2qTMcx9E5KdKG6AYwOAj2Q==
X-Received: by 2002:a05:6a21:7484:b0:3c3:7fff:ba72 with SMTP id
 adf61e73a8af0-3c8ba66d372mr7876995637.70.1785336559797; 
 Wed, 29 Jul 2026 07:49:19 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:19 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:24 +0800
Subject: [PATCH v7 06/11] dts: k1: add SD card support in u-boot overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-6-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336560; x=1785941360;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOlaQjhU8yD90hdP02OlsvN0ZoZ5TFPgqR7tWE20cFs=;
 b=IGJbwIGg2H5hB2YoC+Aml63147FdkJlt2Euc+uUfzAkbx2qBKINCwH/MI2NV2ogDi4
 7LfkQS3Q9GwxLVfAtbq/wzSaIB9nx4O/T5sefuX9kxSK89Tl9q8M0+wZEtRE2ny1v4op
 VeHPQ8+u7SNnyhjgCLqDi7yzNewzD92EYCchO+BJ4jwS3PiB4GJ32YT+DWI0sBQtY2Oy
 cMTkhuMWiE2HNT+pVnLWIpxYS4ReDLBsYCq2bonuQ/S4e1w44QC7aRcy0NfWJXgWN0/4
 3D5nkWYdceZphjrfQ9oBL5XKpm2h/5Gey2DFzHM704aGird8v5BXluGYnUk2lx4xYPZs
 Rm6w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IGJbwIGg
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

