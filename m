Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1FE810D6
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7782386DE7;
	Wed, 27 Sep 2023 14:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSJjK/V6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610F286DE7; Wed, 27 Sep 2023 14:02:04 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD8A86DC5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B1ECFCE19BE;
 Wed, 27 Sep 2023 12:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7DFC433C8;
 Wed, 27 Sep 2023 12:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695816118;
 bh=Sqc+EtmlWFlFWeu+PV0RKyLPsSEajw+hiinKkSUlpbI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FSJjK/V6nhSfinfv9Nls05YI18C6KCsfuzZIEAHKsPq1HCFcfom/SmsPlAgRS4q4H
 ZBvjDFYP2WuSW8r1bgmFTvthvHB6pn0Z1eqV0O+rHbaeiEOtN6o4kOJ8igY400WVk6
 GG+xBNnwr4eG7E3Jxdu/FkFtO0DwYL+w8K7z/TlkIUAHKN83s/zNmJt3pm7Hfm/gip
 X1v9iit8aMkh/7szoOa7bu9EJAaEhkzUCnttMuNZvi6UooRIeqCP4BNAWCPqeYxUrE
 Wx0Q4ZLLCl/GiVgPDF1F0PVxZLv+zN/1LP5COLZhNnycmZn0Dl59EcQKAERFFjpd5v
 sOOObHuh5tq4Q==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: vigneshr@ti.com, bb@ti.com, afd@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 praneeth@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] Revert "ARM: dts: k3-am642-sk-u-boot: add PMIC node"
Date: Wed, 27 Sep 2023 15:01:47 +0300
Message-Id: <20230927120148.75088-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927120148.75088-1-rogerq@kernel.org>
References: <20230927120148.75088-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This reverts commit 28a4c3113445d4400639f357fae0def007a41093.

The PMIC should come from the k3-am642-sk.dts file.

There are 2 variants of the AM642-SK board and each has a different PMIC.
i.e. SK-AM64 [1] has TPS6521855 and SK-AM64B [2] has TPS6522053.

[1] - https://www.ti.com/tool/SK-AM64
[2] - https://www.ti.com/tool/SK-AM64B

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi | 61 ----------------------------
 1 file changed, 61 deletions(-)

diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 3d6be025bd..4431750dc6 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -54,67 +54,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
-
-	tps65219: pmic@30 {
-		compatible = "ti,tps65219";
-		reg = <0x30>;
-
-		regulators {
-			buck1_reg: buck1 {
-				regulator-name = "VDD_CORE";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck2_reg: buck2 {
-				regulator-name = "VCC1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck3_reg: buck3 {
-				regulator-name = "VDD_LPDDR4";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: ldo1 {
-				regulator-name = "VDDSHV_SD_IO_PMIC";
-				regulator-min-microvolt = <33000000>;
-				regulator-max-microvolt = <33000000>;
-			};
-
-			ldo2_reg: ldo2 {
-				regulator-name = "VDDAR_CORE";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: ldo3 {
-				regulator-name = "VDDA_1V8";
-				regulator-min-microvolt = <18000000>;
-				regulator-max-microvolt = <18000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: ldo4 {
-				regulator-name = "VDD_PHY_2V5";
-				regulator-min-microvolt = <25000000>;
-				regulator-max-microvolt = <25000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
 };
 
 &main_uart0 {
-- 
2.34.1

