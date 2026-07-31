Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDBC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC1CA80E86;
	Fri, 31 Jul 2026 16:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zP5HmU1lL6n; Fri, 31 Jul 2026 16:36:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DD5A80F74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515769;
	bh=IqfrcJBcS9XBzYyxY4YC3q9ReknjdxBKXXrZuHPIXI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VGBDPXIfLoPAS5LMwvvoXL2Q8Oh+PIDMq+RI4PDTyPxpwBA6s41jgUuV9RJhGu8cu
	 nvc5qsJ/4ZAu/OSzTySq4WHP0cBGJJdD1RtlUNZFnEzJ6RuBbD7D7Xm2yqCPbY8pjE
	 hyHyaNQyRH41vNoXu1j/7/wV+89gSlTVKuuqodl0m8YmoH1OtOJAZNpZynFG4z+hvX
	 KgvmT5mOrChS8gViPeD33vANF7Wn2Hgj1s7RD5HoCIv8QP1F386z4K7x3UmLF1Ugyc
	 bmUJNONZMW3nqybIByoK772RE6kg71weUevgtA1xL6q2mrbZetec3av4Hu+MmasOet
	 EGKkyQ9dbMWLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DD5A80F74;
	Fri, 31 Jul 2026 16:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A22B769
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88E964061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogEGirIfAxiB for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5307240685
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5307240685
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5307240685
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:25 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5bfa99f8ef8so1440135e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515664; x=1786120464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IqfrcJBcS9XBzYyxY4YC3q9ReknjdxBKXXrZuHPIXI8=;
 b=BOysRyiMvWGJAe7nwJV+pbYvHbjbKDrI5LiDrr2dZG4u/8WJ2EojNHoxiK3i0/+QBJ
 EiTrd0gqeGUzUetxcEXZTUiONOKUbYI5Voct9L0HW8kvS07K0Pmh3ljvvc4x0FdEW2pb
 qiC5bqzPiHKQfVlrw2pG6DOFnCKiNv1JhmDXRWcT0Uc4PdazlKsEJlNRiHhWWqPBM0bD
 dGmiJ39DLE8lTTZ/EUIrhtKGV8b4btVbXHjVO94THC0PZ9h2r/t5PELRZp6Rq+gn5hgW
 iwBtxfYLe4bCuD42Y/xdub5iMbcNCEY/moR4gbP68YV+uBTT1SlOBixPIXcLuxAIlKoO
 1cGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNqZ8IN1cn7xO0y+cvvYQVHfWrZE1J+4RQ0NwjPqo1KJi5zH9iRLxMddKFxRKFZWrbRM4vuUA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxnker/tO/31CEaX9tO+u8/4s3RhXqjPDyNLp96GS16OXkz99bc
 8AEbrcd/t6k2mI3Rufa33DgcL94YCutqJpJVKmAPuKOJLM4ql6piFN9w8Fv/iU783js=
X-Gm-Gg: AR+sD12DRcOWYTOzw863yknm5WD+2k37Nd+Ykh1p10D5jkOiih3Zo8jj4ZAN05MWvpA
 nWhpUjyguBOjya4zfaP0LJLmbLZuDR8yEboJ0rXYfrfSJBSSVAVgBCTMjorFsoue24Xh2MOMqrS
 Z5vJVePnASiLKgsiRzMZD0hUlvsvk4AuCiJiLyAZPgHy/Wp8UjjBD5gmynb/WunwUs2H3QtvSrk
 TUNZ9czPzbpQJjz89YbYP+Z9gRdZjUlsT6lwsd7DXCiF1SKWG6gLa2KFikzFQpMR+/OfR78DCMZ
 64Q5NJwGyR/Bm5lTZyzXOcGEOFpOsH0pBVCyFTYTUogGXuPnbebJDrcKI5BUldol46xCUvpEOJp
 CSNr5A5fmkZr9RlfGxdnxj0Xeow3YUR7145jrNdPKC1WwovWQzu2oR2vEttG6bKLHuWgdH+SoPM
 lhxkNwfUv0EiA3XcJwzyY5UgGL21CFt2r/jbaMa8ByxhAjjtULO8VrUL8EnQclmLkCGA6Z7CqY9
 EKU/DROtgc4LMTzl5gUM6XRCnyJznWElnhb1rMzad+cFUo7mNZO87vu7hCy
X-Received: by 2002:a05:6122:2ac3:b0:5bf:8166:edc3 with SMTP id
 71dfb90a1353d-5c37e78ef55mr673071e0c.4.1785515663748; 
 Fri, 31 Jul 2026 09:34:23 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:23 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:43 -0400
Subject: [PATCH 14/17] ARM: dts: r9a06g032: sync with upstream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-14-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=13147;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=18JilyRiX2Bw+vFPPggVyxEkQv3oDJgJ1ww0oFA1Ftw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBu0l5y2not/KZSi0uFw3HZPHGZvdMxseepqKBNgwxS13LDOk1zxfqSfNFY2BwK1etGwuuLnX47
 OhO8fNALMDQk=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515664; x=1786120464;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqfrcJBcS9XBzYyxY4YC3q9ReknjdxBKXXrZuHPIXI8=;
 b=Onu+jHms/Q4BI9v/uPVber1sl1Keq/JZTyk3Ks16WYgMA+MtQcmvdV6hfLfAmgSV6d
 9008a6NnKXan6rI2hpWEAVN9APNYu4E73p9f1ZyViaHhJaCfYloQ3ssHMU59UYK1VNdg
 eyoHAh897RPtXFnAigKOB6cd08hb2uBPfHVKww/77S9Y5Wes2CMMXtq/IR5R2HFYTUFU
 44o1H8cHuETNLS07kSkyZg2Ic2P/c62bmCcs9zCUaGbIDSOiHVx5TcrvdwaiY+dabFxX
 MwmMQTzCbnSvznB//vz/ZmlZWUxqlABdfBFwte3FoVSx1RlL7aHDSREbuzag5gpfLe/F
 jyiA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Onu+jHms
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

Sync with dts/upstream/src/arm/renesas/r9a06g032.dtsi

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
We are very close to being able to use upstream r9a06g032.dtsi, there is
only one remaining non-upstream change (QSPI controller, see next commit).
---
 arch/arm/dts/r9a06g032.dtsi | 270 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 254 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/r9a06g032.dtsi b/arch/arm/dts/r9a06g032.dtsi
index 0fa565a1c3a..f4f760aff28 100644
--- a/arch/arm/dts/r9a06g032.dtsi
+++ b/arch/arm/dts/r9a06g032.dtsi
@@ -13,6 +13,7 @@
 	compatible = "renesas,r9a06g032";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	interrupt-parent = <&gic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -63,7 +64,6 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		interrupt-parent = <&gic>;
 		ranges;
 
 		rtc0: rtc@40006000 {
@@ -73,8 +73,8 @@
 				     <GIC_SPI 67 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "alarm", "timer", "pps";
-			clocks = <&sysctrl R9A06G032_HCLK_RTC>;
-			clock-names = "hclk";
+			clocks = <&sysctrl R9A06G032_HCLK_RTC>, <&ext_rtc_clk>;
+			clock-names = "hclk", "xtal";
 			power-domains = <&sysctrl>;
 			status = "disabled";
 		};
@@ -211,8 +211,8 @@
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART3>, <&sysctrl R9A06G032_HCLK_UART3>;
 			clock-names = "baudclk", "apb_pclk";
-			dmas = <&dmamux 0 0 0 0 0 1>, <&dmamux 1 0 0 0 1 1>;
-			dma-names = "rx", "tx";
+			dmas = <&dmamux 1 0 0 0 1 1>, <&dmamux 0 0 0 0 0 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -224,8 +224,8 @@
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART4>, <&sysctrl R9A06G032_HCLK_UART4>;
 			clock-names = "baudclk", "apb_pclk";
-			dmas = <&dmamux 2 0 0 0 2 1>, <&dmamux 3 0 0 0 3 1>;
-			dma-names = "rx", "tx";
+			dmas = <&dmamux 3 0 0 0 3 1>, <&dmamux 2 0 0 0 2 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -237,8 +237,8 @@
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART5>, <&sysctrl R9A06G032_HCLK_UART5>;
 			clock-names = "baudclk", "apb_pclk";
-			dmas = <&dmamux 4 0 0 0 4 1>, <&dmamux 5 0 0 0 5 1>;
-			dma-names = "rx", "tx";
+			dmas = <&dmamux 5 0 0 0 5 1>, <&dmamux 4 0 0 0 4 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -250,8 +250,8 @@
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART6>, <&sysctrl R9A06G032_HCLK_UART6>;
 			clock-names = "baudclk", "apb_pclk";
-			dmas = <&dmamux 6 0 0 0 6 1>, <&dmamux 7 0 0 0 7 1>;
-			dma-names = "rx", "tx";
+			dmas = <&dmamux 7 0 0 0 7 1>, <&dmamux 6 0 0 0 6 1>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -263,8 +263,40 @@
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART7>, <&sysctrl R9A06G032_HCLK_UART7>;
 			clock-names = "baudclk", "apb_pclk";
-			dmas = <&dmamux 4 0 0 0 20 1>, <&dmamux 5 0 0 0 21 1>;
-			dma-names = "rx", "tx";
+			dmas = <&dmamux 5 0 0 0 21 1>, <&dmamux 4 0 0 0 20 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		i2c1: i2c@40063000 {
+			compatible = "renesas,r9a06g032-i2c", "renesas,rzn1-i2c", "snps,designware-i2c";
+			reg = <0x40063000 0x100>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_HCLK_I2C0>, <&sysctrl R9A06G032_CLK_I2C0>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@40064000 {
+			compatible = "renesas,r9a06g032-i2c", "renesas,rzn1-i2c", "snps,designware-i2c";
+			reg = <0x40064000 0x100>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_HCLK_I2C1>, <&sysctrl R9A06G032_CLK_I2C1>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		adc: adc@40065000 {
+			compatible = "renesas,r9a06g032-adc", "renesas,rzn1-adc";
+			reg = <0x40065000 0x200>;
+			clocks = <&sysctrl R9A06G032_HCLK_ADC>, <&sysctrl R9A06G032_CLK_ADC>;
+			clock-names = "pclk", "adc";
+			power-domains = <&sysctrl>;
+			#io-channel-cells = <1>;
 			status = "disabled";
 		};
 
@@ -276,6 +308,30 @@
 			status = "okay";
 		};
 
+		sdio1: mmc@40100000 {
+			compatible = "renesas,r9a06g032-sdhci", "renesas,rzn1-sdhci", "arasan,sdhci-8.9a";
+			reg = <0x40100000 0x1000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int", "wakeup";
+			clocks = <&sysctrl R9A06G032_CLK_SDIO0>, <&sysctrl R9A06G032_HCLK_SDIO0>;
+			clock-names = "clk_xin", "clk_ahb";
+			no-1-8-v;
+			status = "disabled";
+		};
+
+		sdio2: mmc@40101000 {
+			compatible = "renesas,r9a06g032-sdhci", "renesas,rzn1-sdhci", "arasan,sdhci-8.9a";
+			reg = <0x40101000 0x1000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int", "wakeup";
+			clocks = <&sysctrl R9A06G032_CLK_SDIO1>, <&sysctrl R9A06G032_HCLK_SDIO1>;
+			clock-names = "clk_xin", "clk_ahb";
+			no-1-8-v;
+			status = "disabled";
+		};
+
 		nand_controller: nand-controller@40102000 {
 			compatible = "renesas,r9a06g032-nandc", "renesas,rzn1-nandc";
 			reg = <0x40102000 0x2000>;
@@ -316,10 +372,27 @@
 			data-width = <8>;
 		};
 
+		gmac1: ethernet@44000000 {
+			compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
+			reg = <0x44000000 0x2000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi";
+			clocks = <&sysctrl R9A06G032_HCLK_GMAC0>;
+			clock-names = "stmmaceth";
+			power-domains = <&sysctrl>;
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <2048>;
+			rx-fifo-depth = <4096>;
+			pcs-handle = <&mii_conv1>;
+			status = "disabled";
+		};
+
 		gmac2: ethernet@44002000 {
 			compatible = "renesas,r9a06g032-gmac", "renesas,rzn1-gmac", "snps,dwmac";
 			reg = <0x44002000 0x2000>;
-			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -380,6 +453,12 @@
 				 <&sysctrl R9A06G032_CLK_SWITCH>;
 			clock-names = "hclk", "clk";
 			power-domains = <&sysctrl>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dlr", "switch", "prp", "hub", "ptrn";
 			status = "disabled";
 
 			ethernet-ports {
@@ -436,8 +515,167 @@
 				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		/*
+		 * The GPIO mapping to the corresponding pins is not obvious.
+		 * See the hardware documentation for details.
+		 */
+		gpio0: gpio@5000b000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x5000b000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&sysctrl R9A06G032_HCLK_GPIO0>;
+			clock-names = "bus";
+
+			/* GPIO0a[0]      connected to pin  GPIO0      */
+			/* GPIO0a[1..2]   connected to pins GPIO3..4   */
+			/* GPIO0a[3..4]   connected to pins GPIO9..10  */
+			/* GPIO0a[5]      connected to pin  GPIO12     */
+			/* GPIO0a[6..7]   connected to pins GPIO15..16 */
+			/* GPIO0a[8..9]   connected to pins GPIO21..22 */
+			/* GPIO0a[10]     connected to pin  GPIO24     */
+			/* GPIO0a[11..12] connected to pins GPIO27..28 */
+			/* GPIO0a[13..14] connected to pins GPIO33..34 */
+			/* GPIO0a[15]     connected to pin  GPIO36     */
+			/* GPIO0a[16..17] connected to pins GPIO39..40 */
+			/* GPIO0a[18..19] connected to pins GPIO45..46 */
+			/* GPIO0a[20]     connected to pin  GPIO48     */
+			/* GPIO0a[21..22] connected to pins GPIO51..52 */
+			/* GPIO0a[23..24] connected to pins GPIO57..58 */
+			/* GPIO0a[25..31] connected to pins GPIO62..68 */
+			gpio0a: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = < 0  1  2  3  4  5  6  7
+					       8  9 10 11 12 13 14 15
+					      16 17 18 19 20 21 22 23
+					      24 25 26 27 28 29 30 31>;
+				#interrupt-cells = <2>;
+			};
+
+			/* GPIO0b[0..1]   connected to pins GPIO1..2   */
+			/* GPIO0b[2..5]   connected to pins GPIO5..8   */
+			/* GPIO0b[6]      connected to pin  GPIO11     */
+			/* GPIO0b[7..8]   connected to pins GPIO13..14 */
+			/* GPIO0b[9..12]  connected to pins GPIO17..20 */
+			/* GPIO0b[13]     connected to pin  GPIO23     */
+			/* GPIO0b[14..15] connected to pins GPIO25..26 */
+			/* GPIO0b[16..19] connected to pins GPIO29..32 */
+			/* GPIO0b[20]     connected to pin  GPIO35     */
+			/* GPIO0b[21..22] connected to pins GPIO37..38 */
+			/* GPIO0b[23..26] connected to pins GPIO41..44 */
+			/* GPIO0b[27]     connected to pin  GPIO47     */
+			/* GPIO0b[28..29] connected to pins GPIO49..50 */
+			/* GPIO0b[30..31] connected to pins GPIO53..54 */
+			gpio0b: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+			};
+		};
+
+		gpio1: gpio@5000c000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x5000c000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&sysctrl R9A06G032_HCLK_GPIO1>;
+			clock-names = "bus";
+
+			/* GPIO1a[0..4]  connected to pins GPIO69..73 */
+			/* GPIO1a[5..31] connected to pins GPIO95..121 */
+			gpio1a: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = <32 33 34 35 36 37 38 39
+					      40 41 42 43 44 45 46 47
+					      48 49 50 51 52 53 54 55
+					      56 57 58 59 60 61 62 63>;
+				#interrupt-cells = <2>;
+			};
+
+			/* GPIO1b[0..1]   connected to pins GPIO55..56 */
+			/* GPIO1b[2..4]   connected to pins GPIO59..61 */
+			/* GPIO1b[5..25]  connected to pins GPIO74..94 */
+			/* GPIO1b[26..31] connected to pins GPIO150..155 */
+			gpio1b: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+			};
+		};
+
+		gpio2: gpio@5000d000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x5000d000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&sysctrl R9A06G032_HCLK_GPIO2>;
+			clock-names = "bus";
+
+			/* GPIO2a[0..27]  connected to pins GPIO122..149 */
+			/* GPIO2a[28..31] connected to pins GPIO156..159 */
+			gpio2a: gpio-port@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = <64 65 66 67 68 69 70 71
+					      72 73 74 75 76 77 78 79
+					      80 81 82 83 84 85 86 87
+					      88 89 90 91 92 93 94 95>;
+				#interrupt-cells = <2>;
+			};
+
+			/* GPIO2b[0..9] connected to pins GPIO160..169 */
+			gpio2b: gpio-port@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <10>;
+			};
+		};
+
+		gpioirqmux: interrupt-controller@51000480 {
+			compatible = "renesas,r9a06g032-gpioirqmux", "renesas,rzn1-gpioirqmux";
+			reg = <0x51000480 0x20>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			interrupt-map-mask = <0x7f>;
+
+			/*
+			 * Example mapping entry. Board DTs need to overwrite
+			 * 'interrupt-map' with their specific mapping. Check
+			 * the irqmux binding documentation for details.
+			 */
+			interrupt-map = <0 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
+
 		can0: can@52104000 {
-			compatible = "renesas,r9a06g032-sja1000","renesas,rzn1-sja1000";
+			compatible = "renesas,r9a06g032-sja1000", "renesas,rzn1-sja1000";
 			reg = <0x52104000 0x800>;
 			reg-io-width = <4>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
@@ -459,7 +697,6 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupt-parent = <&gic>;
 		arm,cpu-registers-not-fw-configured;
 		always-on;
 		interrupts =
@@ -467,6 +704,7 @@
 			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys";
 	};
 
 	usbphy: usb-phy {

-- 
2.55.0

