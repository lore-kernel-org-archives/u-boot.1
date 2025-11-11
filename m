Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E84CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBFD483EC9;
	Tue, 11 Nov 2025 12:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jw0hTG/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6525283A94; Tue, 11 Nov 2025 12:26:49 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CA583F6C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 80F46148029C; Tue, 11 Nov 2025 12:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762860406; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HjednZUGn1Ur1m1dF0vRVw+GOZY8I6/v6nT9e4C/E7s=;
 b=jw0hTG/T7lR6s6ByvFUjfKoqyCoagy6Ytt5bvGJ8k9nBGbEqz1qKFZVo9MmTvr02Yzo0mL
 g7HMTng0naeAZ95oy9VzDFCSEXS8rnWPnEViRCpk6bxMJPazqQVDD2I21fWgjVeZDlmYC+
 X/+97heHnLiBE/GSbWZvqcvwuPWzWbqn9Yj8zaUGBRUFH84ZopBs+RkKmSPnFDnHYMnfF6
 irleaVX/yXIim55aeS5GhjqCW0dpRpjSkcv+PLhgRc9O1rBlXBxUd2fSGmebRzw/AsM2ra
 ZNkYVU9fpLy8BmqpAa/gJ5MmVCj8SRjdNO/9/IsmeSxGJ1Hjdz6Q30kTee76vg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Stefan Roese <sr@denx.de>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Charan Pedumuru <charan.pedumuru@microchip.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: sam9x60: Define i2c0 node in dtsi
Date: Tue, 11 Nov 2025 12:26:35 +0100
Message-Id: <20251111112637.919074-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111112637.919074-1-ada@thorsis.com>
References: <20251111112637.919074-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Same is done upstream in linux kernel.  Allows to leave out common
attributes in dts.  Reduces diff to upstream dts.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts |  5 ----
 arch/arm/dts/sam9x60.dtsi               |  9 ++++++
 arch/arm/dts/sam9x60ek.dts              | 38 +++++++++++--------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index f12d774b97d..4c4039cb5eb 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -160,13 +160,8 @@
 	status = "okay";
 
 	i2c0: i2c@600 {
-		compatible = "microchip,sam9x60-i2c";
-		reg = <0x600 0x200>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 		status = "okay";
 
 		eeprom@53 {
diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index a0db3dd132d..a33c0d57398 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -181,6 +181,15 @@
 				#size-cells = <1>;
 				ranges = <0x0 0xf801c000 0x800>;
 				status = "disabled";
+
+				i2c0: i2c@600 {
+					compatible = "microchip,sam9x60-i2c";
+					reg = <0x600 0x200>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+					status = "disabled";
+				};
 			};
 
 			macb0: ethernet@f802c000 {
diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
index 6e9dd4035de..8d52e91e7e2 100644
--- a/arch/arm/dts/sam9x60ek.dts
+++ b/arch/arm/dts/sam9x60ek.dts
@@ -60,27 +60,6 @@
 				};
 			};
 
-			flx0: flexcom@f801c000 {
-				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
-				status = "okay";
-
-				i2c0: i2c@600 {
-					compatible = "microchip,sam9x60-i2c";
-					reg = <0x600 0x200>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_flx0>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
-					status = "okay";
-
-					eeprom@53 {
-						compatible = "atmel,24c02"; /* EEPROM is 2Kbits microchip 24aa025e48, an at24c02 with page size of 16 */
-						reg = <0x53>;
-						pagesize = <16>;
-					};
-				};
-			};
 		};
 	};
 };
@@ -155,6 +134,23 @@
 	};
 };
 
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c0: i2c@600 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx0>;
+		status = "okay";
+
+		eeprom@53 {
+			compatible = "atmel,24c02"; /* EEPROM is 2Kbits microchip 24aa025e48, an at24c02 with page size of 16 */
+			reg = <0x53>;
+			pagesize = <16>;
+		};
+	};
+};
+
 &macb0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
-- 
2.39.5

