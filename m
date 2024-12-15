Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C99E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 23:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9724880104;
	Mon, 16 Dec 2024 00:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734305446;
	bh=fbxqsGpQ52zL7e/JI6Kh5yJz3imCihdPuGVdQch2H8Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Dr/ofhTtgfzB+yIGLDxg19xqsmobhfqMqoRdIQdQn+tMKgr+l6S+D/WHIEzLx07uw
	 BFoIh3GPiY9gOHyES+OCYha2eRQWcVB2hJ7UZ60OTp/Y9kMNvA7DiGCVoRskUFiB2a
	 rqn0ikbQa7SwzjQmeaL67ZdfUwRrXwx8PARZcfIRu0BFMzXYe1bxKrh5KZQHaQqs4l
	 E17CZGoEX+Vqn1HV/NseqrkSVI5B1MNeguBhns7nRSsKIEfK+n4jDxZGWiDCtf6Xhq
	 n5SS+23iZRlGMk/hk0wFCXHkIT82sopSTPEasCayo5N+svbXdoifcqZ2X5VXni7t28
	 6AnZt5crosONA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EE080192; Mon, 16 Dec 2024 00:30:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20FB8005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 00:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Lyckr3Wa"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9F9A71048B8CC; Mon, 16 Dec 2024 00:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734305441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fbxqsGpQ52zL7e/JI6Kh5yJz3imCihdPuGVdQch2H8Y=;
 b=Lyckr3WahWKaCI9kb3HBEu+x0+LogclqMqE1kR2FDJaY8e3bNaiLqT+2S0gj751lF6XVXO
 kjTeW8XKB+J1qg8TbqlNBLGEt4FYLNekw/ZihOHfuHXMmYndlkG9BZwNfXCBglrw+Yk2+v
 xNRaEl+FYynM6eoo6UfCs+If+C4nFocuWIJwisEK0gyXnETV0+6km4cGWcCsMI7Ot0s8JB
 tYqbYRixp5BYwE1CqtoCp3meEc2Vq164mGBdwxymZVOwWtaYt18tfSq40Knx24ApQK63HU
 HxvyIHG+I8XwjEG1+RSDmc3feRLW1apgdQfO/XScfIp1nk7hlz7eiOXGD4Ywvg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/4] ARM: dts: stm32: Reinstate missing root oscillators on DH
 STM32MP15xx DHCOR
Date: Mon, 16 Dec 2024 00:29:12 +0100
Message-ID: <20241215233011.569287-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The root oscillators reference used to be in rcc node since
3d15245502c4 ("ARM: dts: stm32mp1: explicit clock reference needed by RCC clock driver")
however this is not part of upstream stm32mp151.dtsi . The
RCC driver does need this reference, reinstate it locally.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: For 2025.01
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
index 08439342cb2..ab162f39473 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
@@ -112,6 +112,10 @@
 };
 
 &rcc {
+	clock-names = "hse", "hsi", "csi", "lse", "lsi";
+	clocks = <&clk_hse>, <&clk_hsi>, <&clk_csi>,
+		 <&clk_lse>, <&clk_lsi>;
+
 	st,clksrc = <
 		CLK_MPU_PLL1P
 		CLK_AXI_PLL2P
-- 
2.45.2

