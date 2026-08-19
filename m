Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83784C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48591406B3;
	Wed, 19 Aug 2026 03:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ije_alea7Yf; Wed, 19 Aug 2026 03:57:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111845;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jq7h5aaVdmm0WJ6+l0ZlegIv9xrODwzRaK34Yd1NNhcYni3KpHinwxZAeKz/W4mrS
	 E967WN6mHcGGye8NEx9Tn2VMU9uYs+4WfaJUe3JdPrs/xs21kv9DQZ075zgzFgELbP
	 Q2TI/hupBkNaJA/10VKv4S3aveiaTDdPSuQWS0T7IWIjfM0PBqGTFT2vocb3SPQx/f
	 gqMTRdlOyM1LrCeqjhKBPWu1J/NoGT8+7m/382Gdx5hNyMv4qWn5vXkQTZWzmxJESd
	 koSaz0TiK2RztYMOdnZTHvTxIpTI0YvmM3Ra5ODXdgUlHA7U0QKNrjNQXLDflytc18
	 z7N4a7bAJnVZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 877404066D;
	Wed, 19 Aug 2026 03:57:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 990DD1395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96B1980E66
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWwEoZPuIkER for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=t9BvV2WQ
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA1BD80C31
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:22 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so551786a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111842; x=1787716642;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=t9BvV2WQR4PZykHaCm8zvfwbUKsNpwmln0Ph2Qy6MT2JWPyGWmrf3Q3MznB76HZN/p
 kXa7/yG5z6EoomcMbpD0Z9SbirYsFs0bivEbGGC3vz3oe4W62SxoQIUJi/fx4Ysj2TI/
 Je10tBztP0xCvlSZl1xwIwG1bwJTbxdgSi6iqdylPqa7JXLN7K6G6dp5NN/33Yz2NT42
 JTX2RY95EZeATt7i3dhFKcrUHt+ebvN3VVFSQowdzXW2uDn7K8C0NaMwdh1SlvljamkG
 UTVz/n2gX9vl+7w935MPNLS+jVUPOS64OfQqYr+QrQlEaTkeV7U0FhOxOnCzoJnPk81r
 OYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111842; x=1787716642;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=dKPJTqgxUv1PhYTT6iu7HjhYgmKc2Z7de4EdBYwmYbbJGhUw2Uc2VatsAgI6EqIIVN
 45nzYN4dWUWSRnhnDyZL8X51C6uEpqpGGEzpOxJxSevWemAAH0wRrLCZ182mDhj7yE2U
 pf3fCTKOCDlhi+Cn9apcULBzL9MJBA9zBoe/zFrdDjVjgt09auFRYqy7ls2iYs9zZwRl
 +pkbLBg0Ijq36Uvo2trV1nT3oxxVP3+84Uw3yP9N0ydwJyoTKIKlS1VtxWeyf6t8RHCk
 nT6QOMWNbyfngYz0yJc461GNhg7nHX0k8OQYgobbhNgq3pJUrIoXzIyKnc9ZufWlGMhl
 qFfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXSDzOsZV+Mb97cqh0oXs+OenqfDtDJ/qPQNdzJPAVglcS4hxIX79M8bCXoZwnV8daebS3S3Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzzpqW4t142mfXUvk9HihrVrJmiRLgGbtx96DavoDpZGfLkN4nB
 q0SnEDODG5+Tdm90cNSGPtVpiemSv7WiGEFAHwgU2CbwE3n7KTK6n1IZUNxZTRRlvFI=
X-Gm-Gg: AR+sD12zr5diC/jyhyfRd+60Dg1pTIb22pnQezz9yarG6IL3nM6f6cgpUhwDlwJ1hT2
 G8FvJgtoeFBNSSo19JAbTBiufOcFACIyxJOvP2TuXD81r/T1LJFOi85v52mvmavbqDzClRMqeSn
 vVg05Y2lDHEz7WWEsQzHJ3TmvhP23Clw0pJEmYPG4fUZJ4WypKgRqs7Kss2dYEPOy6Cqw4eFbwV
 T/IjUmpTLuqVrO7qabXJfGqq3ajlCavuedcA43VMogKCPhiXgmvI3f5ELwt+O+D2DTK1gEZhLA/
 T/Gnu1SeGPrIiRExbS8jawqEDmaHVJWzEfUZkvpeaFhZhwdmjjLlVfngUXus64tKerBq18I5lV9
 0/FEI1YTg2j+9qGZR4qa0g13LE5G1mXVIg+XbcaahLyrDWtn7yqPH4nj2ydoaGabRqClHzl/jk0
 wraZf+dJazlwA8+PuTmYUOSoR0MM56TCmGtwBbsjDREmboeto6y8NoH6Bj3T6LxMYsVB5Fr5npJ
 ysdlb4NBlJk1Iooh7fn2hSRzl3f5Pxe9uavMO4nHgpxAAVuTvJZYFfNmkwY6APqknCyjgdDCwDU
 BIv7HuGN/JzwUbKW8L97JD+TYrM/bNq83H5cNw==
X-Received: by 2002:a05:6a21:99a3:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3cd011b5342mr3216297637.10.1787111842215; 
 Tue, 18 Aug 2026 20:57:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:57 +0800
Subject: [PATCH v9 15/19] dts: k1: enable mmc devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-15-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
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

Enable eMMC and SD device nodes in SPL stage. And set the
bus frequency for mmc device nodes.

Remove the redundant device nodes that are delcared in upstream
DTS files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 ++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +++---------------------------
 2 files changed, 21 insertions(+), 127 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d69510..3077cdee55d7 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -50,7 +50,6 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
@@ -65,7 +64,6 @@
  */
 &i2c8 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI8>;
 
 	pmic@41 {
 		bootph-pre-ram;
@@ -89,6 +87,16 @@
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 8a9a2a09de99..d6299c96949d 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -76,42 +76,15 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	status = "okay";
-	pinctrl-0 = <&i2c2_0_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
 		status = "okay";
-		compatible = "atmel,24c02";
-		reg = <0x50>;
-		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
-		pagesize = <16>;
-		read-only;
-		size = <256>;
-
-		nvmem-layout {
-			compatible = "onie,tlv-layout";
-
-			mac-address {
-				#nvmem-cell-cells = <1>;
-			};
-
-			num-macs {
-			};
-
-			serial-number {
-			};
-		};
 	};
 };
 
 &i2c8 {
 	bootph-pre-ram;
-	pinctrl-0 = <&i2c8_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI8>;
 	status = "okay";
 
 	pmic@41 {
@@ -125,130 +98,43 @@
 			buck1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_core";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			buck3_1v8: buck3 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			aldo1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8_mmc";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			aldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			aldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
 			};
 
-			aldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo1 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			dldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo7 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
 		};
 	};
 };
 
 &qspi {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_cfg>;
 	status = "okay";
 
 	flash@0 {
 		bootph-pre-ram;
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <26500000>;
-		m25p,fast-read;
-		broken-flash-reset;
 		status = "okay";
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";

-- 
2.51.0

