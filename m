Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B52AC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF7D840D34;
	Fri, 14 Aug 2026 18:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0sDf9wKn8KM; Fri, 14 Aug 2026 18:39:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B3D740CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732752;
	bh=06gq2qekOC6D5ZuT9hadXGysdN+cNN8ZFQOLnJiwiro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBpf2PUBJctUabfqEvYvJDDK3tgBX8WANpypdBnshoFQjxci8K98il/TaF21HT9LG
	 b09/nd4jDNPAHST438Fw4ByiYSLV+UnhO6FLjlclRhLAV/930jhs/HpRXdCNiTpfjX
	 dVkQv6HMNOdmdFHliG3DmUzq3V8LmiY1MsyQQnQXAe7+YozKxS3E9wCZ5KAJSJ9MiF
	 /daL+Sldy+jwGgn59vZVwl1eSwJu1bUUm5NlXoUfHpsD4q37ng2ogANy7AUqYfVv0g
	 CaTId+7eknJu2vljKCcqHnM0kvzNwWrZwacLHQ0ELSgrDp70SdoTRbevuZbPWUx/a5
	 M8F0yTmwqO2Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B3D740CF2;
	Fri, 14 Aug 2026 18:39:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EFDE139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4078940B19
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E762SyNCSopG for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1B7340AE9
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1B7340AE9
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=A2lcH8Cj
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1B7340AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:07 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c08df8513so8130421cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732746; x=1787337546;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=06gq2qekOC6D5ZuT9hadXGysdN+cNN8ZFQOLnJiwiro=;
 b=A2lcH8CjXk5Oy+7C3wF1BOsQAFIZKKfoStNS1Dm2Taw7bJlftk6XtgfoPtQ0uaeN6S
 Cb09/SyN2qkRA12c+Mg/2bsBWWRAag+RFanPI5lrYZA/UrAGBpObE7K8h9Ock1zcCTCX
 eOA/viIZ63IOWgqShV8a7n5GTFwy0juMtGw8225qDoxqn/qplhk1jGPQ63GvRWrcUVRc
 kC31OMdvJSEuREDAWsaDW/ErDQfjZD4P1b5O3cTiOdj4wvAbOUETD68A840GZ/nOLZzd
 VPUYv8xbGKP9bpBjlA4vCIu+OSf0vC9RrVbS8AAScpqqXiP4iVhb4Em/NQpbukspze5p
 iB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732746; x=1787337546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=06gq2qekOC6D5ZuT9hadXGysdN+cNN8ZFQOLnJiwiro=;
 b=R7/f/2KNqWowmS3f4y6W77RST8Ma/bLvCMg/dWmZqdmATLS542SC93N9o1kkkR2f/z
 e8bvA3p8pMIoAbp/NBGH5H311YjrVbSTZxbjGT4vjGhFBhiEAeacxzzkd+h9HgD1Ym4j
 udcGpsE2LpNWU/tLWYL0pcpBjJjjmufU0+RbSlGg3vi+KjrKlMz3KtY4G8oKXGXaz/CW
 gxxykIxf71aHOEtDAfeIN3nGOSoAzJ1AOUxZZ4YlDjetVASa0XVaVJFSkxcNNqkedVOO
 Kj1RUggmoDjMjY3Zk2qoQzPBt6VgUvZwUXcyLrf7R1ozqsZOnJvJ/WvhDf8IQd4HZ99e
 dCYg==
X-Gm-Message-State: AOJu0YyOQ9N3rJ6mqm48uy3CHIu/6idxZ0/90RJc9qNAYf6LOWBWzNO7
 CV74I0d0DRQRIdEad3BmKjXbRmFS08DO0Rbba+wIziPl/XlNPQFaN0Jq9l5XAqsatCTqS0qmGws
 yhqBigGQ=
X-Gm-Gg: AR+sD10unZVfdaUB72s9lpiEo1qyNXNR/VEUrQrCJ1Ti+Dd8qF7qh4Lr92qakm9aHP7
 XGWtdLtdLUtyILwpnAmoWxXEBYR98hF5uxKpZKJA82U7gam3t684BMSrkfj9/BOkbTSRicoBv8l
 +4+Uj/sczYWGUW+IesJ6TFTVs3Z1ZCsMXvzuaLb74YD70kzcCUVgkL/Qu3/f2dJ4TMJhWkUz16p
 Yi0Vpuj74hNySzL62SjN2O8gf+lIh5Q1pn1Aoudgyb9tosVby/+9rQW9M/f0u5DvAKshqPkJUYb
 6riRN9d8QNtZD4NFa+LDw6tS497FTXO8Ze9GDh8GZ0j8Ka54CybuNBZyDzOm0bkAHUSHaCtTnWa
 WuCZqMpohz7y3udf2E3+1zVCgWaTr/xcdYLJ9UVg2AbUIzayaXmCF7wjDBHLRY0w454dm5/oD/2
 CZ85IP5zSvDNP5lzyznLwqza68+Pyj15KUx8a7HUCzwzFNUocUCjSCF3tKnceFp0PQSMpLBeILd
 7sq5rJCHRBNne2fgdcRdhdjhf3QZU4DOempenyGi73maamqjM+wo9D+
X-Received: by 2002:ac8:5a95:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-52d85303553mr91028431cf.8.1786732745972; 
 Fri, 14 Aug 2026 11:39:05 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:05 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:57 -0400
Subject: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=12992;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=UIQzNQwm/7PbkwzYHuhpioOkNQ6GUHTHBN+4+uH4yNg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKQjHrXAOLY/ccPxbk2YmSZS11gstOsdt6aho5jt0KGqkjHclkBvaxVJrNA7RLPD+KCnoiQ6DXR
 4EK/+ltyVpQA=
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

Sync with dts/upstream/src/arm/renesas/r9a06g032.dtsi

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
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

