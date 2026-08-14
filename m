Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3980CC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 082E78108B;
	Fri, 14 Aug 2026 18:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TTH-8GqxAnM5; Fri, 14 Aug 2026 18:39:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 814D081190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732757;
	bh=bK5ceEmKgw94933RWRzjmnDdJziCe7ZTnJJwNkT6A34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQXas+tf5gRTiC2FCl3WJqyZneD10C2/gzGKBYdm73lWULKmbmm2FOxnlcJv0y/0m
	 LOTlUsq3Tu07bcD8l0cP9CJ1rxKxwhNgzmBEoiztIzxIuUZ6JZZTlPIdsq6dv5O4W/
	 9n+VwZaYcjin5nI7psrOoq0raXX3IJCrPLpBgo6iGDNNSEpJkD38wRSly9QLPxUYoQ
	 9sKkuEMKcPD4aUXQkkos5jXYoVSoj37aRxFKd7KQuITjaEs2fmK04PGwIEILOGE58C
	 gRTuYbFavnaONyAzJV3X04RxALS66w/avdNUwHFF0Buy2AVbCp6C2q8kfm+WYqBIzU
	 36xKG8apW47BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 814D081190;
	Fri, 14 Aug 2026 18:39:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAC3F3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFD3F40CF2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WVkGqi1oXyd for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0AA5B40C9A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AA5B40C9A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oTIuHEvq
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AA5B40C9A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-52d58d7aad6so7607671cf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732749; x=1787337549;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bK5ceEmKgw94933RWRzjmnDdJziCe7ZTnJJwNkT6A34=;
 b=oTIuHEvqtrQiYiW0ozdNcP2zt96r3IBAkb97R7KmqEnr910A5dW/dW62+2chhoQBak
 cBjQkqVjeYl8NuLCsx9DRO0paXWuGmJl/55fgK6FWL2a+hA3aONLuCDwcFdZZ2Kl5wZb
 vRZPrTSEpRCJWyTgTeOlTf0JuNV84yAZrJbayOnJlISV7wcwIw8zQLOrZgrVlj3GYm81
 zCFXR4ECSf6FABYDBXOLZnOmrDLQpxqrkmPFqOcLYGOkaLzTd1O4iQkYe7hbRyR3xBIk
 8cnSbKB5jtaplE1bIc5Li1X0VyvRjU17s0rbKrLoPIuVzP700ISkJ0kF6QvnLEMCb6ib
 YJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732749; x=1787337549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bK5ceEmKgw94933RWRzjmnDdJziCe7ZTnJJwNkT6A34=;
 b=EizL9cnKaoc+BtpEBEOuluflDMtR6nIqb3R86XONfE6XmSNkzPKN0wUARfccjvSgiD
 80k+09Ktsmnz8ygCH4eqxzQQwA03hyV5IMTQ0vgGNOaAh+v9S3uW3Cs8djq3svdfmZOj
 EM0Tw8nTdBRbn3VbOfMtpq7i4E8lngq6ule5S/8/yfTlc3uTbGNMbG38+b1X1aEzCP/0
 I+fy+brKYCKt2ZvbpRe4sKYLu6gx8GBpn4bLH4Q8VAsSP4TA/mb792Tw0ERwM21JexxX
 IgoGc3LA8luslLZpxw259HVQybwdAuEdvxKNeatnn4Ko8LGdLqM3TCYdM9zuSn61hpH3
 U84Q==
X-Gm-Message-State: AOJu0YxT7PaD1i7iQ5ZsA6pHz+kyyNE+1ypA+T59T1p9HMOPfn2P47Tc
 L7YTDZK8equVLD2iZIeSYClmjK7exyqwIfeoIp/2ez0yJUhFfQnJjMw1lWfg17N4TfWci9HGLMa
 HpXx6UTk=
X-Gm-Gg: AR+sD10+v7cx19tJpIECcDC5IWnSGKmuCpbcvPi5gl6Er83UhRhNcho9VWKFepeOWrN
 OjzIOfOIUzqzvSDCf1SdiVWoromlmK56S+JDcki1L6xLoKv7TSbHWilezbCNxH6b57NiSvcUul1
 luSx46L7FQgUX4Wl/IbGcwaOwewVhiLMYW1tPe5oJshsKKX6KepUcfjuun0Rt8owyvXw7W0cRDM
 eEcVBK/iT8rY8ofEe7qxzbJYd/Wc8x+NuEEFOke5PWBIh0uLaBbvwa3xPN1470AuzmY5XnWBCCm
 wCIx8ibGubT3ofCx3uPYcZp+BPaZjymeiioJRxraQk1WVXh4h6BF45sGg/hHVWKByo81M3GeqBi
 NqWk2qGz5tybk2bvh0QQgVpOVK4mY6o6u2FcT+UAMO+WnTFsFVmmtJioPaOLYrWYRwElu7WX28D
 ufdXbAhi+DCm7X6yPZoFnxShCSuqmD+t3aHB+g1CKRAgpze5/wg8bPYqT7dT4Igf4SM2mN/A89e
 uDBQ2hFUeLb7PKjQ7WvEAGg6//Htv1RhBB6ZEUtvCf5Fm7GTTd5YqWs9QX9j7UL4No=
X-Received: by 2002:ac8:7d12:0:b0:51a:8696:cb38 with SMTP id
 d75a77b69052e-52d852f2f3cmr76255631cf.7.1786732748626; 
 Fri, 14 Aug 2026 11:39:08 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:08 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:59 -0400
Subject: [PATCH v2 7/8] ARM: dts: r9a06g032-rzn1-snarc: enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-7-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=12047;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=hQuLslKykRHaxX8hyowICC77QMUlaSJhXHeDi0pIElA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPPUtSCRPf8l/XBFAxUwdh4ocryENlzavls/Fpdu/GSJAsBeebxk+tVKFDLCtDGMOBoA/2DiEJb
 OgP7axZIXpQQ=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

Add pinmux and enable newly added drivers:
- MMC (SDIO)
- QSPI flash
- NAND flash
- USB controller
- GPIO
- Ethernet (designware)
- A5PSW ethernet switch
- MIIC media converter

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- make it easier to compare with original r9a06g032-rzn1d400-db.dts
- reorder device nodes alphabetically (and matching the original)
- pinmux: change indentation, remove underscores from node names
---
 arch/arm/dts/r9a06g032-rzn1-snarc.dts | 376 +++++++++++++++++++++++++++++++++-
 1 file changed, 371 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/r9a06g032-rzn1-snarc.dts b/arch/arm/dts/r9a06g032-rzn1-snarc.dts
index 7de8ee15ef3..08ea5c56f14 100644
--- a/arch/arm/dts/r9a06g032-rzn1-snarc.dts
+++ b/arch/arm/dts/r9a06g032-rzn1-snarc.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzn1-pinctrl.h>
 #include "r9a06g032.dtsi"
 
@@ -73,16 +74,375 @@
 	};
 };
 
+&eth_miic {
+	status = "okay";
+};
+
+&gmac2 {
+	status = "okay";
+	phy-connection-type = "rgmii-id";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&gpio0 {
+	pinctrl-0 = <&pins_gpio0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&pins_gpio1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&gpio2 {
+	pinctrl-0 = <&pins_gpio2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mii_conv1 {
+	status = "okay";
+};
+
+&mii_conv2 {
+	status = "okay";
+};
+
+&mii_conv3 {
+	status = "okay";
+};
+
+&mii_conv4 {
+	status = "okay";
+};
+
+&mii_conv5 {
+	status = "okay";
+};
+
+&nand_controller {
+	pinctrl-0 = <&pins_nand>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	oob-reserved = <8>;
+	nand@0 {
+		label = "nand";
+		reg = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			/* 512MB */
+			label = "nand:ubi0";
+			reg = <0x0000000 0>;
+		};
+	};
+};
+
 &pinctrl {
 	status = "okay";
 
-	pins_uart0: pins_uart0 {
-		pinmux = <
-			RZN1_PINMUX(103, RZN1_FUNC_UART0_I)     /* UART0_TXD */
-			RZN1_PINMUX(104, RZN1_FUNC_UART0_I)     /* UART0_RXD */
-			>;
+	pins_eth3: pins-eth3 {
+		pinmux = <RZN1_PINMUX(36, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXCLK */
+			 <RZN1_PINMUX(37, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXD[0] */
+			 <RZN1_PINMUX(38, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXD[1] */
+			 <RZN1_PINMUX(39, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXD[2] */
+			 <RZN1_PINMUX(40, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXD[3] */
+			 <RZN1_PINMUX(41, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_TXEN */
+			 <RZN1_PINMUX(42, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_RXCLK */
+			 <RZN1_PINMUX(43, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_RXD[0] */
+			 <RZN1_PINMUX(44, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_RXD[1] */
+			 <RZN1_PINMUX(45, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_RXD[2] */
+			 <RZN1_PINMUX(46, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH3_RXD[3] */
+			 <RZN1_PINMUX(47, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;	/* ETH3_RXDV */
+		drive-strength = <6>;
 		bias-disable;
 	};
+
+	pins_eth4: pins-eth4 {
+		pinmux = <RZN1_PINMUX(48, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXCLK */
+			 <RZN1_PINMUX(49, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXD[0] */
+			 <RZN1_PINMUX(50, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXD[1] */
+			 <RZN1_PINMUX(51, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXD[2] */
+			 <RZN1_PINMUX(52, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXD[3] */
+			 <RZN1_PINMUX(53, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_TXEN */
+			 <RZN1_PINMUX(54, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_RXCLK */
+			 <RZN1_PINMUX(55, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_RXD[0] */
+			 <RZN1_PINMUX(56, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_RXD[1] */
+			 <RZN1_PINMUX(57, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_RXD[2] */
+			 <RZN1_PINMUX(58, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,	/* ETH4_RXD[3] */
+			 <RZN1_PINMUX(59, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;	/* ETH4_RXDV */
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	pins_gpio0: pins-gpio0 {
+		pinmux = <RZN1_PINMUX(13, RZN1_FUNC_GPIO)>,	/* GPIO0B[7] */
+			 <RZN1_PINMUX(14, RZN1_FUNC_GPIO)>,	/* GPIO0B[8] */
+			 <RZN1_PINMUX(15, RZN1_FUNC_GPIO)>,	/* GPIO0A[6] */
+			 <RZN1_PINMUX(16, RZN1_FUNC_GPIO)>,	/* GPIO0A[7] */
+			 <RZN1_PINMUX(17, RZN1_FUNC_GPIO)>,	/* GPIO0B[9] */
+			 <RZN1_PINMUX(18, RZN1_FUNC_GPIO)>,	/* GPIO0B[10] */
+			 <RZN1_PINMUX(22, RZN1_FUNC_GPIO)>,	/* GPIO0A[9] */
+			 <RZN1_PINMUX(23, RZN1_FUNC_GPIO)>;	/* GPIO0B[13] */
+		drive-strength = <6>;
+		bias-disable;
+
+		pins-gpio0-pullup {
+			pinmux = <RZN1_PINMUX(25, RZN1_FUNC_GPIO)>,	/* GPIO0B[14] - A70CI_EN_N */
+				 <RZN1_PINMUX(26, RZN1_FUNC_GPIO)>,	/* GPIO0B[15] - A71CH_EN_N */
+				 <RZN1_PINMUX(27, RZN1_FUNC_GPIO)>,	/* GPIO0A[11] - TRUST_M_EN_N */
+				 <RZN1_PINMUX(28, RZN1_FUNC_GPIO)>,	/* GPIO0A[12] - TRUST_X_EN_N */
+				 <RZN1_PINMUX(32, RZN1_FUNC_GPIO)>;	/* GPIO0B[19] - STMA100_EN_N*/
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+
+	};
+
+	pins_gpio1: pins-gpio1 {
+		pinmux = <RZN1_PINMUX(108, RZN1_FUNC_GPIO)>,	/* GPIO1A[18] - for SPI1_SS_N[0] */
+			 <RZN1_PINMUX(109, RZN1_FUNC_GPIO)>,	/* GPIO1A[19] - for SPI0_SS_N[1] */
+			 <RZN1_PINMUX(110, RZN1_FUNC_GPIO)>,	/* GPIO1A[20] - for SPI0_SS_N[2] */
+			 <RZN1_PINMUX(114, RZN1_FUNC_GPIO)>;	/* GPIO1A[24] - for SPI0_SS_N[0] */
+	};
+
+	pins_gpio2: pins-gpio2 {
+		pinmux = <RZN1_PINMUX(147, RZN1_FUNC_GPIO)>,	/* Eth4 IRQ (GPIO2A[25],	*/
+			 <RZN1_PINMUX(148, RZN1_FUNC_GPIO)>,	/* Touch IRQ (GPIO2A[26])	*/
+			 <RZN1_PINMUX(149, RZN1_FUNC_GPIO)>;	/* Eth5 IRQ (GPIO2A[27])	*/
+	};
+
+	pins_mdio1: pins-mdio1 {
+		pinmux = <RZN1_PINMUX(152, RZN1_FUNC_ETH_MDIO)>,	/* MDIO1_MDC */
+			 <RZN1_PINMUX(153, RZN1_FUNC_ETH_MDIO)>,	/* MDIO1_MDIO */
+			 <RZN1_PINMUX(171, RZN1_FUNC_MDIO1_SWITCH)>;	/* MDIO1_MUX_SWITCH */
+	};
+
+	pins_nand: pins-nand {
+		pinmux = <RZN1_PINMUX(80, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_ALE */
+			 <RZN1_PINMUX(81, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_CLE */
+			 <RZN1_PINMUX(82, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_WE_N */
+			 <RZN1_PINMUX(83, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_RE_N */
+			 <RZN1_PINMUX(84, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[0] */
+			 <RZN1_PINMUX(85, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[1] */
+			 <RZN1_PINMUX(86, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[2] */
+			 <RZN1_PINMUX(87, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[3] */
+			 <RZN1_PINMUX(88, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[4] */
+			 <RZN1_PINMUX(89, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[5] */
+			 <RZN1_PINMUX(90, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[6] */
+			 <RZN1_PINMUX(91, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_IO[7] */
+			 <RZN1_PINMUX(92, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_CE_N[0] */
+			 <RZN1_PINMUX(93, RZN1_FUNC_CLK_ETH_NAND)>,	/* NAND_WP_N[0] */
+			 <RZN1_PINMUX(94, RZN1_FUNC_CLK_ETH_NAND)>;	/* NAND_RYBY_N[0] */
+	};
+
+	pins_qspi0: pins-qspi0 {
+		pinmux = <RZN1_PINMUX(74, RZN1_FUNC_QSPI)>,	/* QSPI0_CS_N[0] */
+			 <RZN1_PINMUX(75, RZN1_FUNC_QSPI)>,	/* QSPI0_IO[3] */
+			 <RZN1_PINMUX(76, RZN1_FUNC_QSPI)>,	/* QSPI0_IO[2] */
+			 <RZN1_PINMUX(77, RZN1_FUNC_QSPI)>,	/* QSPI0_IO[1] */
+			 <RZN1_PINMUX(78, RZN1_FUNC_QSPI)>,	/* QSPI0_IO[0] */
+			 <RZN1_PINMUX(79, RZN1_FUNC_QSPI)>;	/* QSPI0_CLK */
+		bias-disable;
+	};
+
+	pins_sdio1: pins-sdio1 {
+		pinmux = <RZN1_PINMUX(95, RZN1_FUNC_SDIO)>,	/* SDIO0_CMD */
+			 <RZN1_PINMUX(97, RZN1_FUNC_SDIO)>,	/* SDIO0_IO[0] */
+			 <RZN1_PINMUX(98, RZN1_FUNC_SDIO)>,	/* SDIO0_IO[1] */
+			 <RZN1_PINMUX(99, RZN1_FUNC_SDIO)>,	/* SDIO0_IO[2] */
+			 <RZN1_PINMUX(100, RZN1_FUNC_SDIO)>;	/* SDIO0_IO[3] */
+
+		pins_sdio1_clk: pins-sdio1-clk {
+			pinmux = <RZN1_PINMUX(96, RZN1_FUNC_SDIO)>;	/* SDIO0_CLK */
+			drive-strength = <12>;
+		};
+
+		pins_sdio1_cd_wp: pins-sdio1-cd-wp {
+			pinmux = <RZN1_PINMUX(101, RZN1_FUNC_SDIO_E)>,	/* SDIO0_CD_N */
+				 <RZN1_PINMUX(102, RZN1_FUNC_SDIO_E)>;	/* SDIO0_WP */
+			bias-pull-down;
+		};
+	};
+
+	pins_uart0: pins-uart0 {
+		pinmux = <RZN1_PINMUX(103, RZN1_FUNC_UART0_I)>,	/* UART0_TXD */
+			 <RZN1_PINMUX(104, RZN1_FUNC_UART0_I)>;	/* UART0_RXD */
+		bias-disable;
+	};
+
+	pins_usb: pins-usb {
+		pins-usb-pdown {
+			pinmux = <RZN1_PINMUX(119, RZN1_FUNC_USB)>,	/* USB_PPON[1] */
+				 <RZN1_PINMUX(121, RZN1_FUNC_USB)>;	/* USB_PPON[2] */
+			drive-strength = <4>;
+			bias-pull-down;
+		};
+
+		pins-usb-pup {
+			pinmux = <RZN1_PINMUX(120, RZN1_FUNC_USB)>,	/* USB_OC[1] */
+				 <RZN1_PINMUX(122, RZN1_FUNC_USB)>;	/* USB_OC[2] */
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+	};
+};
+
+&qspi0 {
+	pinctrl-0 = <&pins_qspi0>;
+	pinctrl-names = "default";
+	status = "okay";
+	//bootph-all;  /* causes malloc failure at boot */
+
+	flash@0 {
+		reg = <0>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <62500000>;
+		spi-cpha;
+		spi-cpol;
+		spi-rx-bus-width = <4>;
+		//bootph-all;  /* causes malloc failure at boot */
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				/* 256KB */
+				label = "qspi0:spl";
+				reg = <0x00000000 0x00040000>;
+			};
+			partition@40000 {
+				/* 256KB */
+				label = "qspi0:unused_mtd3";
+				reg = <0x00040000 0x00040000>;
+			};
+			partition@80000 {
+				/* 256KB */
+				label = "qspi0:configcms";
+				reg = <0x00080000 0x00040000>;
+			};
+			partition@c0000 {
+				/* 256KB */
+				label = "qspi0:unused_mtd5";
+				reg = <0x000C0000 0x00040000>;
+			};
+			partition@100000 {
+				/* 256KB */
+				label = "qspi0:env";
+				reg = <0x00100000 0x00040000>;
+			};
+			partition@140000 {
+				/* 1MB */
+				label = "qspi0:unused_mtd7";
+				reg = <0x00140000 0x00100000>;
+			};
+			partition@240000 {
+				/* 1MB */
+				label = "qspi0:uboot0fit";
+				reg = <0x00240000 0x00100000>;
+			};
+			partition@340000 {
+				/* 1MB */
+				label = "qspi0:uboot1fit";
+				reg = <0x00340000 0x00100000>;
+			};
+			partition@440000 {
+				/* 1MB */
+				label = "qspi0:tosfit0";
+				reg = <0x00440000 0x00100000>;
+			};
+			partition@540000 {
+				/* 1MB */
+				label = "qspi0:tosfit1";
+				reg = <0x00540000 0x00100000>;
+			};
+			partition@640000 {
+				/* 1MB */
+				label = "qspi0:cm3fit0";
+				reg = <0x00640000 0x00100000>;
+			};
+			partition@740000 {
+				/* 1MB */
+				label = "qspi0:cm3fit1";
+				reg = <0x00740000 0x00100000>;
+			};
+			partition@840000 {
+				/* Remaining */
+				label = "qspi0:data";
+				reg = <0x00840000 0>;
+			};
+		};
+	};
+};
+
+&sdio1 {
+	pinctrl-0 = <&pins_sdio1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&switch {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_eth3>, <&pins_eth4>, <&pins_mdio1>;
+
+	phy-reset-gpios = <&gpio2a 26 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <15>;
+
+	dsa,member = <0 0>;
+
+	syscon = <&plat_regs>;
+
+	mdio {
+		clock-frequency = <2500000>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch0phy4: ethernet-phy@4 {
+			reg = <4>;
+		};
+
+		switch0phy5: ethernet-phy@5 {
+			reg = <5>;
+		};
+	};
+};
+
+&switch_port0 {
+	label = "end0";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy5>;
+	status = "okay";
+};
+
+&switch_port1 {
+	label = "end1";
+	phy-mode = "rgmii-id";
+	phy-handle = <&switch0phy4>;
+	status = "okay";
+};
+
+&switch_port4 {
+	/* Upstream to GMAC2 */
+	status = "okay";
 };
 
 &uart0 {
@@ -90,3 +450,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&udc {
+	pinctrl-0 = <&pins_usb>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.55.0

