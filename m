Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A1C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE5488315;
	Mon, 22 Apr 2024 01:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741549;
	bh=uNqk10MmK7R4p1uTtXWRWRnoL/sxwjIXAdODY3h7CyQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sMHuJ24+0vGHeGdA/H5Zyo8LkcJH1GPa0YrBhYnli/E0hl2Iw9Er19Dn6KuhhCa2A
	 sbdS25OwOy1I6oH92CV2zwiKTjpzrI8DTs/vZPQTL5n+/nKQGcugREJ5xaubhNioxn
	 Cw5SHumR2FchLdjHOB3Ys24Ms2YuA642LDB1792nKMVoP37j7tq/KPN7MIDxHJDSt8
	 /WoD/MJnDjmh+FkEAObkV7vKx24rYyD9WvM+55GyuNdSMoiDypvNtRS/Hkk3LSfmW+
	 R9P0WWVeu2vYwKMXpIJWeuvAo2Vaz6fT9CNvZBze6OavYahr6MWw4LH5Ohd1X8HaD3
	 od6maXS/MKyeg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 31A8B87F3F;
 Mon, 22 Apr 2024 01:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741547;
 bh=uNqk10MmK7R4p1uTtXWRWRnoL/sxwjIXAdODY3h7CyQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Cjb+xQOWGIkmDFLOyEn4K3VweOlN0w4Ln34K2VQaLxPuQokcPziBcFXpEhxZdejT/
 ewIcxrmxJNxAyC/JLbJy+W8yGeWZW2yL9h7P5zfB5bslia5+raUMnURyi7zynFEDyL
 lCB6o8QYjXYGrrf3WT13QNca6AIFWnyBeJvlT0oQRuDpk1QykkgxoB7g3edUOduaza
 U650qg2MGfsNRldL/PhD+vMkLNT7tKIf9ZsE4VnWuvyNOIYaTfXC5mArLi/Xo7o7oL
 flOpzq/XHNTwveJ0P4IlfzhEE2Kpp7YHSO/cTR7GVJxMXLA7OaMQ35Y5yWT/82CNEk
 1U7AKPDzKKfYA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 01/19] ARM: dts: stm32: Add alternate pinmux for MP13 ADC pins
Date: Mon, 22 Apr 2024 01:16:47 +0200
Message-ID: <20240421231849.194648-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Add another mux option for ADC pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 27e0c382678..03ded415390 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -6,6 +6,12 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	adc1_pins_a: adc1-pins-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 3, ANALOG)>; /* ADC1 in12 */
+		};
+	};
+
 	adc1_usb_cc_pins_a: adc1-usb-cc-pins-0 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 12, ANALOG)>, /* ADC1 in6 */
-- 
2.43.0

