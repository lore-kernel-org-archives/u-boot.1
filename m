Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC3C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0349340825;
	Mon, 17 Aug 2026 15:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VAd5Nec67XcB; Mon, 17 Aug 2026 15:37:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F07F84074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981025;
	bh=xisThQCkFYN2x79+Z12TI+GHrR7Rq4Igkbnp1uoiy3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=joUmCDHPLRUZW4Fd9A42aMv455u7nY8IdplzIZTghP98PaQX+rOEeUqJ14Sevi3MK
	 1yNJnLARdBevR6daLZA6yg5DdHs0OWjmMiivAHCb4B2dVWwBx0vKCZc51JcVJqFJzh
	 VtBuYrwfEt3cIz8f84l8Zqo7ayOEUrcC/Kz/tujCkuEDFCw422msP/DmPDKtm+aA8I
	 d4coigSd3W6jN0pD0DBm17GJrMhNgpC7pOi+xaIe+QsFQ3riM1WPGjZNe/+ux3/7li
	 LXeImbQZfiENeegvX4H9Xume6zkSNJTGDoPKdGEkEpzUk458Y8hi9H5Mm9w3E8xSsn
	 +xM3S0jkI1Pcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F07F84074F;
	Mon, 17 Aug 2026 15:37:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 734DB2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 597CD6078D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJeWOuuI1pUa for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:37:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 553E5605F5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 553E5605F5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=cuh+C6fU
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 553E5605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B02F3B00539;
 Mon, 17 Aug 2026 17:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981020;
 bh=vjW9H6PI2JuiDVhgNEWQzllTJ98U1uR/VdFhr9gz+t0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cuh+C6fUfGupZP7ks2/LU8GE4fiGFKubfiYLJgKVVZiMjn9AUbzdVvWNSJm0uturn
 r7JuARcG7TQ/kGwg3rvQfLQhBK3jXDr686PwvTyqmzYp3zV2s1GekXjbW6aVhcFFmi
 9vKyKFAcvlbcxBWLVaHE5ScHAvfGBlKctk4Rbo9s57++cG18Dty9JuRiVvM8w2VaFF
 fJw0T2rdhlwLtnTM56IoMYG+kiKdvjLTbdT7s1aaenZfEcxr8yl5ExjSZjfkBh+Zbv
 rOaAWiSsmT32Pb0ZNKc4OSkS7A/RGcIph4qAVbW1NGI/zpgVacOJtNPkj9FAXbSgj7
 244oQEJFS7UaQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 17/23] arm: dts: nbxv3: add the +3V3_FAN regulator
Date: Mon, 17 Aug 2026 17:31:35 +0200
Message-ID: <20260817153144.1951036-18-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Declare the +3V3_FAN fixed regulator (fan-en-pwr) on the carrier
chassis management expander of the IIC6 mux tree.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 3b87ee32d94..2047709f5b7 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "fsl-lx2160a.dtsi"
 
 / {
@@ -248,7 +249,6 @@
 				reg = <0x76>;
 				#gpio-cells = <2>;
 				gpio-controller;
-				/* P0_4 = fan-en-pwr -- FAN power rail enable, U186.P0_4 */
 			};
 		};
 
@@ -315,10 +315,10 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					fan-controller@2c { compatible = "microchip,emc2305"; reg = <0x2c>; };
-					eeprom@50         { compatible = "atmel,24c32";       reg = <0x50>; };
-					tmp411@4c         { compatible = "ti,tmp411";          reg = <0x4c>; };
-					tmp411@4d         { compatible = "ti,tmp411";          reg = <0x4d>; };
+					fan-controller@2c { compatible = "microchip,emc2305"; reg = <0x2c>; vcc-supply = <&fan_3v3>; };
+					eeprom@50         { compatible = "atmel,24c32";       reg = <0x50>; vcc-supply = <&fan_3v3>; };
+					tmp411@4c         { compatible = "ti,tmp411";          reg = <0x4c>; vcc-supply = <&fan_3v3>; };
+					tmp411@4d         { compatible = "ti,tmp411";          reg = <0x4d>; vcc-supply = <&fan_3v3>; };
 				};
 
 				i2c@1 { reg = <1>; #address-cells = <1>; #size-cells = <0>; };
@@ -340,3 +340,15 @@
 		};
 	};
 };
+
+/ {
+	fan_3v3: regulator-fan-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "+3V3_FAN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&carrier_u186 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
-- 
2.43.0

