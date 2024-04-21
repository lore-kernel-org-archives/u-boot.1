Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA022C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5F28831D;
	Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741549;
	bh=EdXpzb2g+7pAlTtVFl72NwJEEhKJKFvazgZ4a/uBg7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lGXSCq/GwbxYdfmN1PogRcYWUxzO2VRRSvLwsmKIye3BJ9hyLJkXHOzXD+JnOp7iy
	 TK4lAlbU6JR4h9rOmI38B+qnh0DvPyXgQslkwbJDqZiQMKkjXGpzw1Xwcw2MjCC6NP
	 qPHKnplmSqQqqqrhPQWKnwQ91lNddTY28GXAM0kf3WB4jYSrXXTUKFP0ONGrrVNwOM
	 zzSdwJji63o5SXewokplnHxPlmEjTVWz3+Y7BfrWUXnFrySW96VZ9GGW9fvnf5IQ9M
	 Zed3gScLoUPU5N8/eUHbF4QOUbG8zRFWAc23gcrcPgIxHV/Apztgr6rrTmPLJ9GzS8
	 dWGZqjLEBP48Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8CC2387FE0;
 Mon, 22 Apr 2024 01:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741547;
 bh=EdXpzb2g+7pAlTtVFl72NwJEEhKJKFvazgZ4a/uBg7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dpCcm1jEB5k1arlwLFeqv8neCVknTL31x8stbcePxZ5ncgoSzTRBCUpjI5nt0RZPB
 OBqZBE6fbKCB7yiGGdm+AQLA0rb4P/ZtSwE7RG4LjAw9M4juvjSM0j3IyAn08LwVVf
 tAF/1n3oMkKNlrSN1tD2WyJOtfG0D+JqEtAvE1ztupnkEDi52LjogPom5xbqEQn2Kg
 Xt5rveTS8D+IKIVrWU/7H0xIwlDrJyMOvCQiQEQJh93RgkuSjgEzG9qKR2OYVjrElU
 jc3fPXhBfZdJycS+MPisnFP9YraLv51oV77hn7YSP0l9wJRunooXLPSF9y9rtvU1wp
 yuwi4A67GPXtw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 02/19] ARM: dts: stm32: Add alternate pinmux for MP13 ADC CC
 pins
Date: Mon, 22 Apr 2024 01:16:48 +0200
Message-ID: <20240421231849.194648-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240421231849.194648-1-marex@denx.de>
References: <20240421231849.194648-1-marex@denx.de>
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

Add another mux option for ADC CC pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 03ded415390..396fb6eee84 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -19,6 +19,13 @@
 		};
 	};
 
+	adc1_usb_cc_pins_b: adc1-usb-cc-pins-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 5, ANALOG)>, /* ADC1_INP2 */
+				 <STM32_PINMUX('F', 13, ANALOG)>; /* ADC1_INP11 */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.43.0

