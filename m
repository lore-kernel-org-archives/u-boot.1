Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E27EC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AB966074E;
	Mon, 24 Aug 2026 08:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bg-NtiXhecas; Mon, 24 Aug 2026 08:52:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561534;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHMvnd0SbLaUK7yGfzwSMq97dJ0CC55bE+5bRQzlZT2pQjFRrSZ2Sni7NXXxvONy1
	 0DJ1ttwUT1weEjEFsCE61pi+brZLwA9oWVgu7lbrNhTUEnJToVRLaeNkRGlNSc15Xw
	 pXxyXwBOm8UBxSHTlmGyrbr0LH0+o6fRS0vlsA7jskh6vJQcdkeDln2XRnMnE1PDG1
	 f6J9Wc2/JLjyUgGcEPZ1uQhnbbMY595Q6F7sfRi+2+2ptZd2OB6NUvIUcQ7h5+aMwM
	 HYJ9x3zIUZnjysOoz/CqVe5pd0bne9J/BCPnjhydeBcIsSKwrKV3EnbdFjgx5BfP9d
	 J4WVu/42HLsUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3CB160631;
	Mon, 24 Aug 2026 08:52:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A66DE336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9893B80E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jT0h9zTi3-O for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=z5ruPzkA
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEEBF80DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:12 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cbeea240819so1824662a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561532; x=1788166332;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=z5ruPzkA8FVb5aGs/7TGmyQyz0QFFU2w7xew8xsU6KLeRUY5YNUbiPJu5c4FXI4/Uc
 iHgqifWC1nr8jbKF6ZDjsZQ0L3CGE9yWTJygKX/gQUCI7yLyFdMcwwKcrQL9+U1/N4BA
 fOMqyvA/ltfXOUpoNAOXkXlDY8VTNWLKZ9o+uuXYPFrlxwCYa+7rPfzdZRLkmCSBsJzz
 zdgQj+N9xdS1uC+tpGUnIeOLDiVVoPXSqLSwMvHPSKw2okuuuQJGNgY/BFtoNuYKERWB
 yC1/LD7rZg1vJiaAVSv8Cb+DoLgIfStiFipwOmH6PjvvsglCnC4Qm7Dd+DQGX3i7/vOb
 yCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561532; x=1788166332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=tMOOZjzZBloSFPade6LjCy9smF8naY5NqKOAIFqwjB2Kh+DvNNxd+sYdVcaztDFfMG
 C4Ae2JcaaAXSEDiE4CSV2IHiRUiEs7IAWUV4MZaQ+S5WRQ+VgC2q3MfC764Ls+UaRlrP
 47KrV63d3resuGLlUV1/EN0ipjKfrtX9VKx3OSFd7zx5wStHq1SYEdxLsdBA+NDzkP+d
 061ilTYJSb1c9nTXlC+ZLVO7mN5SGo22bwYyhBmQielCIbL5QxW6lYGvqhgweQ91Ue3Q
 3l/8ehg2G9I1qZWqC+OOq84+x/AqbrCRttHSk5OZkBFGCoeaH3+9NPuHqY/0ylR5xznx
 t8mg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/EACQx021YhJnIw9oaKE+hFSBk2Kr/tnITiL1N7dDf8GfZnWZw86vYp6nCv2+uXZq3CgJ5RY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nCZWgOAe6+CZcjrF2WKDbzHw5ZIGbeQa3Xa49HKq66ZoWhtQws
 /z1t1dgLMUJbDTkfSTTTApY8iyB6baLu+5mjv7BLS3NVZ/9+hlH20QrbXQBk8RXe6iw=
X-Gm-Gg: AR+sD13yt4FdbpiGN/O7fVpPqriKGu9Bm2UHpPcuFq149QzTKa7apWp4YB/ffGMHnSc
 rOu37qPpfx7lbEcPEjVNEWFDpa4GgL93P5VKDAmjPeTohT523H+cFF5r9y96he8MavLT/ULxMn7
 +4VEAup22rUrti2H3G3MarvyBgoEGQPDt32cbMkwcWtFlbLktIk2oMZTrjL64D61ewKEXhLCRgb
 lvfsK6n4/yDE5pbns/p6OJ0YRVjQjLWpcujUSa3topYcpNWebR5zQewUoSzZ1d+Pu69V33gUpvk
 2yCpxKFVrj9xNSvJ7xlR1ZyYQuqlxjxZZPtLaJGztqdQe1tIdZNV+KTDBYv264TOAF2F/6uLIiy
 4RRfAuLzZ3wrBNwx2k1vazrD95NXNRhPEHUL34ZeQPZh6OXYXZKymWplIlbIcaCo5nTU6T0I+BS
 gVkcGDjvQw4CfBE9ChMV8e1DEDC39WW2FwtsVxsAot0KxG1/npW9RT4UrKmD6goez0FOW1NKMUX
 ss5gAcZPs8i4LkuAZtk3tSMbZSZm7vEp2bmxQxAXGjUKu9S9OGk61/ICsLTBLYHqC+HGtejx5vw
 GyXT9O0lZ59zynJuSwoyX5Fl0w==
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd3009ca00mr46620050637.10.1787561531837; 
 Mon, 24 Aug 2026 01:52:11 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:11 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:48 +0800
Subject: [PATCH v10 13/17] dts: k1: enable mmc devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-13-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
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

