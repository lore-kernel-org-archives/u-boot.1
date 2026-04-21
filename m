Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D67BF5A8A2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AF184324;
	Tue, 21 Apr 2026 02:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="KVyvMX2S";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWYS0ITX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FC5841C8; Tue, 21 Apr 2026 02:05:17 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB998431C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 777331D00244;
 Mon, 20 Apr 2026 20:05:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 20:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729913; x=1776816313; bh=9wPmd3Ut0M5h2j2lE45zUj8V3Z8jLGKE
 FpcnjugY3rc=; b=KVyvMX2SsjomHJDpZV+p0CNBuxcbesUlori0AXoGlykgZ7PH
 bUL2JBrbNvzkEU9vNdWaZ5tDiKip+alv3/DsIWyU0ld30uIAcbdUOeVGmQ5OFrhl
 l7LMM+1nsWzaLARoB0FdsUv7CEMdi/LOe7t7pySrnPktndhJjPqNlP0yMmeWG2ss
 pCXdxyoeQZLh1AMvZeRq8cDOHvFaFx1ZK4OFd8o1Zzpcp8j7ERve42R6MaO/QLW3
 MEtXJ6x63sOVsl5ak0V7ckWNFi5CJdp6Ztnic+5wzdCzNO+5gQFPmP+IsrRtbuGv
 I5Tt+8HF6lqAgRUM80D43ulIZncc7y0/4ouP1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729913; x=
 1776816313; bh=9wPmd3Ut0M5h2j2lE45zUj8V3Z8jLGKEFpcnjugY3rc=; b=C
 WYS0ITXlgeOqqH1LNySADQNX2qqrGpKi1Yn3DXPRf4CGm8rU13UJNOEOwsaq0Gnj
 WJAsU6jhsPnkvM9Tpq2KLDrBGnntUjFKa3/l5sqkJ7AxBuXF7oCcFbpkg/ZPYQvX
 Ho37JM5fMhxFpoINu7YWdgKG6ufMroIQX/qRiSpCySIldXLzD7wsaBhVSiPDz5Il
 US35jw9EfC7Nwy436XYP1SKoKVcPmm8QRkTv5hkfCzF84INu4UGf5jTqfeJ32pPv
 hYYyESnJJFXJCSdRCKwysroR8V7h9jqOaXykGjkTbaXUuCkMfjt6bBLA1YCQmrup
 7DqAYZk3Gb4OnqByJ8zgQ==
X-ME-Sender: <xms:Ob_maZPICwEmvN2UakQCxhezFciaBdO78boqPAO6bKO2ztPZvYsN-w>
 <xme:Ob_maQ4uSXf9X5vK8hy4t-E7gdbUWbTaF0N8zB5CrN-m9nQajc_WOFaXOfR5bpDmT
 ewqP8QzEDwzoulB0bg1geQjz1ea6gcOjRrsCDltqE49MaUEje7RytI>
X-ME-Received: <xmr:Ob_machf8aPzU56-npqViMzvtrYIw_bEJQczmqmQdoYVL6_bBklYDLD9q7MwSrw3QjgAnxPQMFDBxQo-eI4WKfwfR5elxw80yCaIey797UWkXFNWWUj5zdZK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:Ob_maVcu1XfxVsb4aqYfbqpTmrOM26COl6duojRNhXgHLv16Eo4puw>
 <xmx:Ob_maUzhoYDir3SAarFDgTQ9Ug3hAgsbqRYC8zhJDI-n8R8hCkXoBA>
 <xmx:Ob_maU0cM0e96C7rRqHKbgD9m55JEntKfYBOuUOD_AUij8zMZ_5vpA>
 <xmx:Ob_maaxz0oyzXR2dqrifS6rns36KAI1OFR7SJTMgDJ4FVNLGXFsXDQ>
 <xmx:Ob_mafgse3qMr4jNbfHg5Gj8sEFhRwYAuQMtQFIp4Zf3PiFM3b-0wbET>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:05:10 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:40 +1000
Subject: [PATCH v2 7/8] arm: dts: remove local copy Ten64 board DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-7-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=8628;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=Knxa6TR8nAnMrRH3eoYgDI8rIVNbWvUJd81tHIwmjRY=;
 b=nWVha3jevn4MZqvKKUkFiuONJnCe6OU17K6fNjyeo5/KsCDw6zDNEr+7yQDQ5Q5hCevk09OHO
 WqJMJKmZNPsBExocxepuwjVwk++TwL24E9MFVquopBvmN/kyY5f4+ul
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

This board has been migrated to the upstream / kernel
device tree version (OF_UPSTREAM), so remove the
old 'local' copies that are no longer required.

However, the -u-boot.dtsi append needs to remain,
because the SoC fsl-ls1088a-u-boot.dtsi is required
for some devices (like PCIe controllers and DPAA2 ethernet)
to properly enumerate under U-Boot.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi |   8 -
 arch/arm/dts/fsl-ls1088a-ten64.dts         | 388 -----------------------------
 2 files changed, 396 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi
index 4e6700d586e..0d64795bf44 100644
--- a/arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi
@@ -18,11 +18,3 @@
 		ethernet9 = &dpmac1;
 	};
 };
-
-&i2c0 {
-	uc: board-controller@7e {
-		compatible = "traverse,ten64-controller";
-		reg = <0x7e>;
-	};
-};
-
diff --git a/arch/arm/dts/fsl-ls1088a-ten64.dts b/arch/arm/dts/fsl-ls1088a-ten64.dts
deleted file mode 100644
index 0d11440d88d..00000000000
--- a/arch/arm/dts/fsl-ls1088a-ten64.dts
+++ /dev/null
@@ -1,388 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Device Tree file for Traverse Technologies Ten64
- * (LS1088A) board
- * Based on fsl-ls1088a-rdb.dts
- * Copyright 2017-2020 NXP
- * Copyright 2019-2023 Traverse Technologies
- *
- * Author: Mathew McBride <matt@traverse.com.au>
- */
-
-/dts-v1/;
-
-#include "fsl-ls1088a.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Traverse Ten64";
-	compatible = "traverse,ten64", "fsl,ls1088a";
-
-	aliases {
-		serial0 = &duart0;
-		serial1 = &duart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	buttons {
-		compatible = "gpio-keys";
-
-		/* Fired by system controller when
-		 * external power off (e.g ATX Power Button)
-		 * asserted
-		 */
-		button-powerdn {
-			label = "External Power Down";
-			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
-		};
-
-		/* Rear Panel 'ADMIN' button (GPIO_H) */
-		button-admin {
-			label = "ADMIN button";
-			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_WPS_BUTTON>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "ten64:green:sfp1:down";
-			gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-1 {
-			label = "ten64:green:sfp2:up";
-			gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-2 {
-			label = "ten64:admin";
-			gpios = <&sfpgpio 12 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	sfp_xg0: dpmac2-sfp {
-		compatible = "sff,sfp";
-		i2c-bus = <&sfplower_i2c>;
-		tx-fault-gpios = <&sfpgpio 0 GPIO_ACTIVE_HIGH>;
-		tx-disable-gpios = <&sfpgpio 1 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sfpgpio 2 GPIO_ACTIVE_LOW>;
-		los-gpios = <&sfpgpio 3 GPIO_ACTIVE_HIGH>;
-		maximum-power-milliwatt = <2000>;
-	};
-
-	sfp_xg1: dpmac1-sfp {
-		compatible = "sff,sfp";
-		i2c-bus = <&sfpupper_i2c>;
-		tx-fault-gpios = <&sfpgpio 4 GPIO_ACTIVE_HIGH>;
-		tx-disable-gpios = <&sfpgpio 5 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sfpgpio 6 GPIO_ACTIVE_LOW>;
-		los-gpios = <&sfpgpio 7 GPIO_ACTIVE_HIGH>;
-		maximum-power-milliwatt = <2000>;
-	};
-};
-
-/* XG1 - Upper SFP */
-&dpmac1 {
-	sfp = <&sfp_xg1>;
-	pcs-handle = <&pcs1>;
-	phy-connection-type = "10gbase-r";
-	managed = "in-band-status";
-};
-
-/* XG0 - Lower SFP */
-&dpmac2 {
-	sfp = <&sfp_xg0>;
-	pcs-handle = <&pcs2>;
-	phy-connection-type = "10gbase-r";
-	managed = "in-band-status";
-};
-
-/* DPMAC3..6 is GE4 to GE8 */
-&dpmac3 {
-	phy-handle = <&mdio1_phy5>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs3_0>;
-};
-
-&dpmac4 {
-	phy-handle = <&mdio1_phy6>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs3_1>;
-};
-
-&dpmac5 {
-	phy-handle = <&mdio1_phy7>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs3_2>;
-};
-
-&dpmac6 {
-	phy-handle = <&mdio1_phy8>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs3_3>;
-};
-
-/* DPMAC7..10 is GE0 to GE3 */
-&dpmac7 {
-	phy-handle = <&mdio1_phy1>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs7_0>;
-};
-
-&dpmac8 {
-	phy-handle = <&mdio1_phy2>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs7_1>;
-};
-
-&dpmac9 {
-	phy-handle = <&mdio1_phy3>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs7_2>;
-};
-
-&dpmac10 {
-	phy-handle = <&mdio1_phy4>;
-	phy-connection-type = "qsgmii";
-	managed = "in-band-status";
-	pcs-handle = <&pcs7_3>;
-};
-
-&duart0 {
-	status = "okay";
-};
-
-&duart1 {
-	status = "okay";
-};
-
-&emdio1 {
-	status = "okay";
-
-	mdio1_phy5: ethernet-phy@c {
-		reg = <0xc>;
-	};
-
-	mdio1_phy6: ethernet-phy@d {
-		reg = <0xd>;
-	};
-
-	mdio1_phy7: ethernet-phy@e {
-		reg = <0xe>;
-	};
-
-	mdio1_phy8: ethernet-phy@f {
-		reg = <0xf>;
-	};
-
-	mdio1_phy1: ethernet-phy@1c {
-		reg = <0x1c>;
-	};
-
-	mdio1_phy2: ethernet-phy@1d {
-		reg = <0x1d>;
-	};
-
-	mdio1_phy3: ethernet-phy@1e {
-		reg = <0x1e>;
-	};
-
-	mdio1_phy4: ethernet-phy@1f {
-		reg = <0x1f>;
-	};
-};
-
-&esdhc {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	sfpgpio: gpio@76 {
-		compatible = "ti,tca9539";
-		reg = <0x76>;
-		#gpio-cells = <2>;
-		gpio-controller;
-
-		admin_led_lower {
-			gpio-hog;
-			gpios = <13 GPIO_ACTIVE_HIGH>;
-			output-low;
-		};
-	};
-
-	at97sc: tpm@29 {
-		compatible = "atmel,at97sc3204t";
-		reg = <0x29>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	rx8035: rtc@32 {
-		compatible = "epson,rx8035";
-		reg = <0x32>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9540";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-
-		sfpupper_i2c: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		sfplower_i2c: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-	};
-};
-
-&pcs_mdio1 {
-	status = "okay";
-};
-
-&pcs_mdio2 {
-	status = "okay";
-};
-
-&pcs_mdio3 {
-	status = "okay";
-};
-
-&pcs_mdio7 {
-	status = "okay";
-};
-
-&qspi {
-	status = "okay";
-
-	en25s64: flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "bl2";
-				reg = <0 0x100000>;
-			};
-
-			partition@100000 {
-				label = "bl3";
-				reg = <0x100000 0x200000>;
-			};
-
-			partition@300000 {
-				label = "mcfirmware";
-				reg = <0x300000 0x200000>;
-			};
-
-			partition@500000 {
-				label = "ubootenv";
-				reg = <0x500000 0x80000>;
-			};
-
-			partition@580000 {
-				label = "dpl";
-				reg = <0x580000 0x40000>;
-			};
-
-			partition@5C0000 {
-				label = "dpc";
-				reg = <0x5C0000 0x40000>;
-			};
-
-			partition@600000 {
-				label = "devicetree";
-				reg = <0x600000 0x40000>;
-			};
-		};
-	};
-
-	nand: flash@1 {
-		compatible = "spi-nand";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <1>;
-		spi-max-frequency = <20000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			/* reserved for future boot direct from NAND flash
-			 * (this would use the same layout as the 8MiB NOR flash)
-			 */
-			partition@0 {
-				label = "nand-boot-reserved";
-				reg = <0 0x800000>;
-			};
-
-			/* recovery / install environment */
-			partition@800000 {
-				label = "recovery";
-				reg = <0x800000 0x2000000>;
-			};
-
-			/* ubia (first OpenWrt) - a/b names to prevent confusion with ubi0/1/etc. */
-			partition@2800000 {
-				label = "ubia";
-				reg = <0x2800000 0x6C00000>;
-			};
-
-			/* ubib (second OpenWrt) */
-			partition@9400000 {
-				label = "ubib";
-				reg = <0x9400000 0x6C00000>;
-			};
-		};
-	};
-};
-
-&usb0 {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
-};

-- 
2.52.0

