Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA86CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC1383A94;
	Tue, 11 Nov 2025 12:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="ic/aXRml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC7183F72; Tue, 11 Nov 2025 12:26:48 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471F983EC9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A40681480134; Tue, 11 Nov 2025 12:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762860405; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=6NOd4GfwQZJusQF19FDSW+ZDEIEi4csMKpe2rSmtZNw=;
 b=ic/aXRmlDgXr95SBw6vflCdc9Euie/lC69A2LLUuH8DNatLLLcgEqMG6Eo42ToMw6EQN51
 cF/82d7vZWwkD5ctla3b10cgNasLqQxYvbrTGQ7pTrkQbPb9/3EFIVAwapKBLQav46P71V
 qw31kUm1K4V5BylYb16N+HTW3ZIjlgDkD5TrK5ChD+li63r8XTvrWk8e8PCoh3e4VnRHBh
 g0Ifdd6fTWaMadZcjowpXjXXdlpgTdS85KINNpHp3mp/rTR0/RFzM7uz0kkLvEsOF67tOh
 1uldhGdhiXrgiLQbqlQ1xmeLSNA6rA+oLBxC4GimEvBdqlRcohi+ksau5vSlyg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Zixun LI <admin@hifiphile.com>, Stefan Roese <sr@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sam9x60: Fix flexcom/i2c node addresses
Date: Tue, 11 Nov 2025 12:26:34 +0100
Message-Id: <20251111112637.919074-2-ada@thorsis.com>
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

Tested on SAM9X60-Curiosity:

    U-Boot> i2c dev 0
    Setting bus to 0
    U-Boot> i2c md 0x53 0x00.1 0x100
    0000: fe ff ff ff ff ff ff ff ff ff ff 02 1e b3 12 eb    ................
    0010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0030: 02 06 06 14 ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0060: 20 4d 43 48 49 50 20 52 44 43 15 31 44 44 34 00     MCHIP RDC.1DD4.
    0070: 00 00 53 41 4d 39 58 36 30 43 55 52 20 34 00 00    ..SAM9X60CUR 4..
    0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    0090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
    00f0: ff ff ff ff ff ff ff ff ff ff 04 91 62 f2 9c 5a    ............b..Z
    U-Boot> printenv ethaddr
    ethaddr=04:91:62:f2:9c:5a

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 7 +++++--
 arch/arm/dts/sam9x60.dtsi               | 2 +-
 arch/arm/dts/sam9x60ek.dts              | 9 ++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index f165fdadb9e..f12d774b97d 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -15,9 +15,12 @@
 	model = "Microchip SAM9X60 Curiosity";
 	compatible = "microchip,sam9x60-curiosity", "microchip,sam9x60", "atmel,at91sam9";
 
+	aliases {
+		i2c0 = &i2c0;
+	};
+
 	chosen {
 		stdout-path = &dbgu;
-		i2c0 = &flx0;
 	};
 
 	memory {
@@ -156,7 +159,7 @@
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
 	status = "okay";
 
-	i2c@600 {
+	i2c0: i2c@600 {
 		compatible = "microchip,sam9x60-i2c";
 		reg = <0x600 0x200>;
 		pinctrl-names = "default";
diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 79449042c24..a0db3dd132d 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -173,7 +173,7 @@
 				clock-names = "pclk", "gclk";
 			};
 
-			flx0: flexcom@f801c600 {
+			flx0: flexcom@f801c000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xf801c000 0x200>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
index 6521585ee9c..6e9dd4035de 100644
--- a/arch/arm/dts/sam9x60ek.dts
+++ b/arch/arm/dts/sam9x60ek.dts
@@ -14,9 +14,12 @@
 	model = "Microchip SAM9X60-Ek";
 	compatible = "microchip,sam9x60ek", "microchip,sam9x60", "atmel,at91sam9";
 
+	aliases {
+		i2c0 = &i2c0;
+	};
+
 	chosen {
 		stdout-path = &dbgu;
-		i2c0 = &flx0;
 	};
 
 	clocks {
@@ -57,11 +60,11 @@
 				};
 			};
 
-			flx0: flexcom@f801c600 {
+			flx0: flexcom@f801c000 {
 				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
 				status = "okay";
 
-				i2c@600 {
+				i2c0: i2c@600 {
 					compatible = "microchip,sam9x60-i2c";
 					reg = <0x600 0x200>;
 					pinctrl-names = "default";
-- 
2.39.5

