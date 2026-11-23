Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eiBgWv1w;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DFEqn74G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A29480E21;
	Mon, 23 Nov 2026 10:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-tFX2ZQHSuk; Mon, 23 Nov 2026 10:22:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D5DE80E2E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429379;
	b=loxOJ2akMOp/phBLkb5BvfsGKf2A5iKJq3rYAELDfJ+uidiMnnAUSJD2t9ldcTvjlgg6
	 u7azvCqUfRE8JXvLTZbzbPgo1/amU8yikvQvbk7KmZtEVgTJGUai6kKPi8RD1Nslp8FsS
	 tmc1d1eZ/aDW2ELcoXtFovPivrCkxPjqNhkiWFQ6zsx6Gx3LIp0PjwhXR0nHO15P3UbrD
	 jL1CPpGonATGdc9xJRL/FT9MYd3qGo6uyu/yKb8rGrrX/OmVJNw1b2y1eZPnezHbM7huJ
	 H86jO3Sket+2v/qXc1wAB/EXo/Votb3CVlVMy4bYyq9/K8qKzMr+afDQx9nb0EARMrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tPE5ABBopFsXIy+OguG+XnmCJknKQjsZr94RbEV2Gp4=;
	b=NorH36SwcTGfNfuMCnQPJruJAWhqxTQ6VLx5YcC2dIiUIJkCdiLQ9/+eUcFBelPp6s6T
	 CpfQeOyBycxObeF1R6MShYwvAE/KcBkgejsfOWrQBnSb8V4+OisHbDOwJwby6uIH7tbn1
	 aR6MKzpABljcKb9rejX7F35paeY+eGfeBI3QQPlbNCyUBBd7GmxxpYl2hd5pRzuRcUZ7s
	 QAseEVVTrwIHKaTrzLhiryAabS2/+zRZpczRqYkxXIAh3ETYXtHZBWXbuLy4ti7TBiWPw
	 YATj0/JP2vNve6fWmzJ5IwySnyRyDXGuQrOSC8Td4IfUKCs0HMZU9dZlV3FkrBYG/2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DFEqn74G;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429379;
	bh=tPE5ABBopFsXIy+OguG+XnmCJknKQjsZr94RbEV2Gp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiBgWv1wmrWLKWXqZOYcf7yooFS97UzbNYnu/4xVUJEKdD8kR1yhR1kFsBVbe+ekr
	 r5UUrgUYxi2ek2UP3SgnVX2iS4u3govouKlw4YgkL3MOHT5qQkivvFFShEeohK4/SL
	 E9WkeAvi+lrPmGW4U45g7TD4lGaxvD+NFUmMEi6mxmbKNCZNiP0IzZJTMY81LoZ37r
	 TzKwtY+FTzhSDDMYsexHkNlNJFL7sjE+WmIFkyVg52ognFXPKKS+p3cU8oFLxIMYJO
	 LS+aDRs+io0W5ABttQk34clQDWtWmEKeFodt0TKK5vmy3mBInDQJsgLlWabj+oGoGI
	 EXm09uEkc/PrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D5DE80E2E;
	Mon, 23 Nov 2026 10:22:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AF3022B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14E3680DC8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqVXOp8GArns for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B56B280E0B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DFEqn74G
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B56B280E0B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:50 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so38125805e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429369; x=1796034169;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tPE5ABBopFsXIy+OguG+XnmCJknKQjsZr94RbEV2Gp4=;
 b=DFEqn74G1PrF8n2lpVdds+0VAIp6fIItQFsFYMTDYzvZj2tdOAQqDXBmJadUwNgE3Q
 7vCZlQvg7vcARz0BPYfLKNfZ7Rk8iibKHqS/Zxx/n3BtyRH2nANOGW9Ytc5110WpAt31
 9mBDr29zEAvUpCadABB4+qUd6Auqcj8kYCeXF73LJmbnGthyNb6cNWHFYdkt/flf6/Av
 Fqd+Elbloz4nGOelInW9rzDNcbzoWT3u/vtbXPXkgG0KCCdjp3nE+P4qoK0XLh7ZMajp
 oyPfBGl+mUrO1yxB1LniU4gGAUhUxd4xymr6iILLCduCj79eOnrsZLGAKnFLlbFW4mQY
 e+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429369; x=1796034169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tPE5ABBopFsXIy+OguG+XnmCJknKQjsZr94RbEV2Gp4=;
 b=zNqio7Lel4DI7znbYg+/PKA+tajeh7myz2GJs0rlID+U/UAMtgDtfPykZJcGeaiDLL
 sDeOn7446FhW0Z49BFeATKnz4lCb34xeCIDNRXwK9u36XJbHL7ESLHakZH3P+2bZ1cf/
 /3xv+wqG5KebTdvAflIoe406+sECiPtWebM6Unmn36QevIxkF1qpmQVgGx+kakrWr8s+
 OjaOQVnLuVfLRN2iNl+RB8jTni0eY4wSQx3/QAitm0CZejXkFVBAl/gxAhwfl5a+Wb8R
 khv/qLMXp9cG8CzeBsqCovbbfuYSG5eXf25SNXrPV5ZYWAoAOCs0IgpfF3ztlKSUxfWL
 9MnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMajdjrFi8uE09OB3v3VWfq0mEDGmEmNyUeO2nJSwt2T4y2u9NdjyWO0B/ztp5yNirFKkD7mE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+5KcognUk7V59BBeaRcwvsT14muZ3LHlGIX52SJCX+nLrXdJC6
 KKoywTH45AtfGOchlzoAVeGvoEF9cSCX/ENVyjW/90b9dSsI5zl1iGWbeUbhAWLxJ3g=
X-Gm-Gg: AZFdTZd8m5C2UOPU6bu4UwO9r3mnvA2QlSSKHVohW5yPyhP4aAh3chzCE2O2hlviCNA
 Yd+qcu4j8qtRFBapNW+yvEzBH9BcHQPi6Iok9VRYuHd/KSM5ebzK5goSpwCZNSVz/Nn788B0TKj
 HdO91vLxIBKdbqdx6ET/Ce7d3LjVsWOn626HNnqqc4T5OGhuIAEkbTiAQc1XEEEsBqxINllhKHe
 uDGBu/jcfSPWoZZMOZMicV1+WFLcTeAY7YKM9DMeh2m6Vm5L6+P972YDjyYYlX+PlwqnVvwArG7
 3fS8KB0Y9hjvpsMYMiux3Tzt6H2Bf+gjANzeQdgU5dT215TtjkwWl+2CrQ4ObucNGnyw+DK3/U+
 QfK4Oc42HY/WDa816avQnf91uPPE7rUbBBDwGA21wrt7zMBcQw7F6A/t1b9cFrWjuwi+mzdZm72
 5Kf8UtgszDqMuBi1gYaeyzSny8Q1sXynesd6sDE8crvxakI0i+YvBkei+RHSydjZKukvHxyQNr5
 8Va0GSJ7CrTgZI0ePKT11vYirbuNGVG18i5urorcI6Z8JisDcbmeeHN1b6k1Op4Nt3yJZ4Ml4yh
 hhnQtjncjq/ihg+f7582haQqUTH6czkwdOrceza2VYYW8VH3ewQbxVyrcJR0VCe5vOoRQkXS6g0
 d1kFY8Gc351onezYGXhVHB3hpCc93V/o6/ykPepDpCGgVvg==
X-Received: by 2002:a05:600c:4e02:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4bb88812b1cmr228213155e9.24.1795429368566; 
 Mon, 23 Nov 2026 02:22:48 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:48 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 11:22:22 +0100
Subject: [PATCH v2 7/8] arm: dts: mt8189: describe the I2C controllers and
 wrapper clocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-7-7d3f843db7ef@baylibre.com>
References: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
In-Reply-To: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe all nine I2C controllers and their four clock providers.
Leave the buses disabled so each board can enable the ones it uses.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 150 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index ce4c32c46b..9cc764b973 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -450,6 +450,156 @@
 			#reset-cells = <1>;
 		};
 
+		imp_iic_wrap_ws: clock-controller@11b21e00 {
+			compatible = "mediatek,mt8189-iic-wrap-ws";
+			reg = <0 0x11b21e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_e: clock-controller@11c22e00 {
+			compatible = "mediatek,mt8189-iic-wrap-e";
+			reg = <0 0x11c22e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_s: clock-controller@11d74e00 {
+			compatible = "mediatek,mt8189-iic-wrap-s";
+			reg = <0 0x11d74e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_en: clock-controller@11f32e00 {
+			compatible = "mediatek,mt8189-iic-wrap-en";
+			reg = <0 0x11f32e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		i2c0: i2c@11c20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c20000 0 0x1000>,
+			      <0 0x11300200 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_e CLK_IMPE_I2C0>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11c21000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c21000 0 0x1000>,
+			      <0 0x11300300 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_e CLK_IMPE_I2C1>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11b20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11b20000 0 0x1000>,
+			      <0 0x11300400 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_ws CLK_IMPWS_I2C2>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@11d70000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d70000 0 0x1000>,
+			      <0 0x11300500 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s CLK_IMPS_I2C3>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11d71000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d71000 0 0x1000>,
+			      <0 0x11300600 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s CLK_IMPS_I2C4>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@11d72000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d72000 0 0x1000>,
+			      <0 0x11300700 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s CLK_IMPS_I2C5>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@11d73000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d73000 0 0x1000>,
+			      <0 0x11300800 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s CLK_IMPS_I2C6>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@11f30000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f30000 0 0x1000>,
+			      <0 0x11300900 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_en CLK_IMPEN_I2C7>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@11f31000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f31000 0 0x1000>,
+			      <0 0x11300a00 0 0x80>;
+			clock-div = <1>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_en CLK_IMPEN_I2C8>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		eth: ethernet@1101a000 {
 			compatible = "mediatek,mt8189-gmac", "snps,dwmac-5.10a";
 			reg = <0 0x1101a000 0 0x4000>;

-- 
2.56.1

