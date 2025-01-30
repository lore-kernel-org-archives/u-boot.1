Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4B2C0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 03:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900F6817C4;
	Thu, 30 Jan 2025 04:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="jugJx+/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F11A281113; Thu, 30 Jan 2025 04:52:34 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4945E80C65
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 04:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=118a1aa8f=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1738209152; x=1769745152;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SatM5LJ+0tybyBSSWKAORf6Brew+Dck9PQVcn6E6PY8=;
 b=jugJx+/f7TI/5a930QsBRM44KrHE3bz0CeoPEK7jhUIOP3LhU6PeQtJ7
 QGOsU/JITGu0em8ATPrHyqo+1eLUwDJ1m6fpWXErhWmQFUvQJ6BIFyMxm
 LXuJJa6+EKVfyiylujEKu2RzUMICXdhjUGdwZRU1zmSEQWexRA0MzfLQS
 aVcOn2fVp3qvqJpSvpOCj0Iu4n2XJLp+WL/xf4b+SDfWseSMl7htavWXg
 8BemSD0KJbnLZuZfeHby61n4LMEhwNmbL/3YWHA1aD3SydIDQ6hIkBKJN
 HPbNQTyudbg0Dx6SyAkNifnZgg2qu+ZCsy3AJ9JC6b36GUav7jWtSKWoS w==;
X-CSE-ConnectionGUID: 6UfhbO/CQrK5c8RpTJRJjg==
X-CSE-MsgGUID: Al0dA5BDTpCSFkL8qAVhPg==
X-IronPort-AV: E=Sophos;i="6.13,244,1732604400"; d="scan'208";a="204597333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 Jan 2025 20:52:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Jan 2025 20:52:14 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 29 Jan 2025 20:52:11 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>, Balamanikandan Gunasundar
 <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v2 2/7] ARM: dts: at91: sam9x60: Define pinctrl node with its
 label
Date: Thu, 30 Jan 2025 09:21:52 +0530
Message-ID: <20250130035157.226995-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130035157.226995-1-manikandan.m@microchip.com>
References: <20250130035157.226995-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Define the pinctrl nodes with its label to align with the Linux DT.
Without this change the pinmux nodes are grouped under an additional
'pinctrl' child node which is not identified by the pinctrl driver
when the GPIO banks are made as child nodes of pinctrl node.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/sam9x60ek.dts | 142 +++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 69 deletions(-)

diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
index 74016f5e288..3bf45c14e42 100644
--- a/arch/arm/dts/sam9x60ek.dts
+++ b/arch/arm/dts/sam9x60ek.dts
@@ -78,75 +78,6 @@
 					};
 				};
 			};
-
-			pinctrl {
-				nand {
-					pinctrl_nand_oe_we: nand-oe-we-0 {
-						atmel,pins =
-							<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
-					};
-
-					pinctrl_nand_rb: nand-rb-0 {
-						atmel,pins =
-							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
-					};
-
-					pinctrl_nand_cs: nand-cs-0 {
-						atmel,pins =
-							<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
-					};
-				};
-
-				ebi {
-					pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
-						atmel,pins =
-							<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
-					};
-
-					pinctrl_ebi_addr_nand: ebi-addr-0 {
-						atmel,pins =
-							<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
-							 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
-					};
-				};
-
-				pinctrl_qspi: qspi {
-					atmel,pins =
-						<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
-						 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
-						 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
-						 AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
-						 AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
-						 AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
-				};
-
-				pinctrl_flx0: flx0_default {
-					atmel,pins =
-						<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
-						 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
-				};
-
-				pinctrl_onewire_tm_default: onewire_tm_default {
-					atmel,pins =
-						<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
-				};
-
-				usb1 {
-					pinctrl_usb_default: usb_default {
-						atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
-								AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
-					};
-				};
-
-			};
 		};
 	};
 };
@@ -221,6 +152,79 @@
 	status = "okay";
 };
 
+&pinctrl {
+	/* shared pinctrl settings */
+	qspi {
+		pinctrl_qspi: qspi {
+			atmel,pins =
+				<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	nand {
+		pinctrl_nand_oe_we: nand-oe-we-0 {
+			atmel,pins =
+				<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_nand_rb: nand-rb-0 {
+			atmel,pins =
+				<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_nand_cs: nand-cs-0 {
+			atmel,pins =
+				<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	ebi {
+		pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
+			atmel,pins =
+				<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_ebi_addr_nand: ebi-addr-0 {
+			atmel,pins =
+				<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+	};
+
+	flexcom {
+		pinctrl_flx0: flx0_default {
+			atmel,pins =
+				<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
+	pinctrl_onewire_tm_default: onewire_tm_default {
+		atmel,pins =
+			<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+	};
+
+	usb1 {
+		pinctrl_usb_default: usb_default {
+			atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+};
+
 &usb1 {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
-- 
2.25.1

