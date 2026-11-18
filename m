Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0770606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lTD5eqP+;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ThQObOxl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7806260AA4;
	Wed, 18 Nov 2026 20:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtBLPfZPXqay; Wed, 18 Nov 2026 20:30:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A73BB60735
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033821;
	b=SfEEbEAShkGWhKJUzLLVlzYV7k9v0VvHp3cTemzPTisHjpimwFjmoZBmGXLIWg1voVDl
	 JypC/wSBqRB1XWpCT7XRs1gXovrnFK8MDiUg0ANLppKhKbVDamDIIv+lKYpBV7YjkKe91
	 pvrdMo2Mp1lgXn+c6d3WcQkXQcYeWcxhoP6sTX+I+pPSrDLCtOj6gLQsZiAP2m0rlOYEL
	 TYhQKYeVLtSkwdKunUtQGH4MIAg1/b3D+1oSU0oI5ioZakvTfKlAJ/EHb0L6+hHwFqKRa
	 scpSdJeZYXFS+eFrzkQe/m/gKHcroPhLwpKIz9dZcPQPNkg2ufEuO+PsBtv+SE7/bjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e6irqsCrh5VIGd11ChgNrqduzb1qvqX05qTS0TI7Evs=;
	b=WxIf78DB3Xima8VNCDugp0mLih98bwgW4C8JnfKGPLF3/pJv0t+GBTP6uztTCvn8d8VY
	 Bil5yg4qUwLxKBniY+3DH2DnMNUaQX7rjb4MuR0NnqOKAW9KQZuL55qNqhPl1cxtwJlbb
	 lx6aRK4jBLVdAgwKawBh87iTnx3cbRUgfcbWkCFNZEES4v2KvD9xOfRklYU51X3yh46EH
	 Y1VY43p7lqc/JdCtSwLs0rF70Cw0Uhrv/laJtRz3I9tsRH97A5NBsBMTqY/N47y5E/X8k
	 4IChPDPztKwxDzTfD1YniSDvwqK6nXT7jh5WTuZZkKFmnk2ae2bTWtX2QeoUg24OeZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033821;
	bh=e6irqsCrh5VIGd11ChgNrqduzb1qvqX05qTS0TI7Evs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lTD5eqP+FZgVp28LHEpHAAy70vQ3T5rrXCSnvtvTc6OZ3ckJcOFwNFu/Yclgjz1EA
	 yI58Wszypb854JYZbBGu5wRLITD//+tayyU6EMei/8p55rX2wPun4D6KMCHr6ZixmF
	 S+lWzQen5MdBI/ZSFF6iZDH1Ari9oKplx2YEmM9KhdmZxZqhWiq9dH/bPp9Dxdtdit
	 JjaU9HnnmYWZoNWHX65qijwhZ76zpeIwG2BAVmFp22UJUzYUbTUvNnSl5sRNoG+Tkx
	 EWmZnlsXm5q9a6t9SwUCj4++gjrleh6LqULSTqSQ2HdvYZ/Lodgo3pLAtscJbwH9qX
	 v+AAruySq6VEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A73BB60735;
	Wed, 18 Nov 2026 20:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0088D2F1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6F2540086
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ap1481MjKzt7 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5F2D40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ThQObOxl
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5F2D40024
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:16 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso13628635e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033815; x=1795638615;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e6irqsCrh5VIGd11ChgNrqduzb1qvqX05qTS0TI7Evs=;
 b=ThQObOxlGMvHEcbjraIfBYi2zMYCwzaLKDB4QsIDYDgxQCR7zDCF5F+bksBrh5pgO4
 RrV5ipN3C+vQq5PDfaYSjc/pnocg6KTMOB6EVZKBcxg34Qata60cCxaRpw7Bln6neupo
 9WvuMJNfnnR4MWt8vL8GnbqZNcPIhHChZknO1dUI1btW8rGKZgBlCfVWbkPtX3Uw8BvX
 B5mgp2SKd19RZpHlsnVSVSP9ZO17r8hBdYbzV8MSwdWZrbjGgtnek8/mt6r2DAFkkZG0
 ySxIuAl6oT7DbIJXyoyCUs8JmoH2dwSwpCh2X0MwJ9as9Z/g3sB41S1xVzqHY+EoNKOo
 6Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033815; x=1795638615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6irqsCrh5VIGd11ChgNrqduzb1qvqX05qTS0TI7Evs=;
 b=1xFdiU1+aAGF9jJTE+CZ37TbErOGYz+RU3vyY34+JB8hRu196NdyvcAKyYrv7Cif0L
 WIxiuS+FI9+W6Ai0s7bQtgkv/TSittjeSQtkhn63PZmxrJRBByfXMOClocFMXrqb7oYe
 6s73QCLVWka8AcoiFD/cwCUd4Em7a8TVifh/QrTZn/FKRt6JRHHRP8DsLkngaxGUHL9E
 u8ICx4qw0UJMlWr18NW+EU1UUPor5V9Hgv+GNjCPngJA9GVnnfiigAdaswSYcJb3kW8M
 3Ra80ZPLlUW69tyLHM7S57Zxl3G9ZMScMxMVE9kG97OXsKQmWBcVBhROLRtImwFVo8bi
 eVNw==
X-Forwarded-Encrypted: i=1;
 AL+hErGycgQvrO3BeZTGHlq5FAcgWdrW5iJGPFO3SVyMoojf5yrk9YwE+Df2Z2vOOCv6RHqTshSQ/mI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/li9LBS+3qE0JDqLtL8MFOjZMfk89ftZxBM9kd8jxE9siKS+Bj
 98khh7GWjSv08ekeiZ/poCtM+NXXcbzw5rMU4eHVyVOeJx2Gd2y5hwKIsLMSXRo5QjE=
X-Gm-Gg: AYBFou0LLOchX+u5q2sBbToUw7R9z8W337j9yq+itgLjs+zT7tnCTgFccEfLy855qkz
 BrZLLpiNpRGURKI3awr+onev5jUCXkjzb5FUEeBHVqPDBXjPpXRvx0gvWjzx/F2eXxfjTuEW8jp
 lAW1l5a/HOeiTkGzQZ3LF82Wqx1NLxJjI2iWiFunXNC8EQzu6baSYpXBumwlOiZl6NaBklE+Eou
 azOs71FvCgG8+psDheb2+YIkqGOERw5K5zZPmafG96YS4oREpy3qCgbQRaqFziSH6tG1H/l6oSL
 KTAXC3mPKJndQQopWVayuttYaqtCHu4vRWPUJg/T7h3S/6T0qCl61EYhGBfKASSmjof9b/IgiSq
 WzIhKGs5vodBZ8oD1XEmHQvqwB2EFzcwItDb7NUpLVvJegGGB3ipHB0t28HTqIFqMPlIhMKZtry
 zXW6bOtmudzZ2jEn3BylHp6vTLJS1KotnsuvJIQf+nCMYwWV6o6G09vZGdkfS7b85lcA9ui2btz
 DSWU1Bi/7IO3IkuimBGO6u2VyRalxo51Ybu7dzP7qAhL1v1Wcrp3NW7+YTSI6okw6u4DGEz61bW
 Lphwq4v45ARWPAKVu0T/J75sgrZ+PTHZhC2WU19KIz0nISqm0f8tY9xmAKV+J2dYSgNbJV3jqgj
 xkue0QK3SWvB1Oti6t6GuhRUXrCWKtsHtwF99HSM=
X-Received: by 2002:a05:600c:468b:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb7d6cc2f4mr74075505e9.4.1795033814607; 
 Wed, 18 Nov 2026 12:30:14 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:14 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 18 Nov 2026 21:29:52 +0100
Subject: [PATCH 6/7] arm: dts: mt8189: describe the I2C controllers and
 wrapper clocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-6-916dd6cc8d1a@baylibre.com>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe all nine I2C controllers and their four clock providers.
Leave the buses disabled so each board can enable the ones it uses.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 141 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index ce4c32c46b..33b717f6fe 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -450,6 +450,147 @@
 			#reset-cells = <1>;
 		};
 
+		imp_iic_wrap_ws: clock-controller@11b21000 {
+			compatible = "mediatek,mt8189-iic-wrap";
+			reg = <0 0x11b21000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_e: clock-controller@11c22000 {
+			compatible = "mediatek,mt8189-iic-wrap";
+			reg = <0 0x11c22000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_s: clock-controller@11d74000 {
+			compatible = "mediatek,mt8189-iic-wrap";
+			reg = <0 0x11d74000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imp_iic_wrap_en: clock-controller@11f32000 {
+			compatible = "mediatek,mt8189-iic-wrap";
+			reg = <0 0x11f32000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		i2c0: i2c@11c20000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11c20000 0 0x1000>,
+			      <0 0x11300200 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11c21000 0 0x1000>,
+			      <0 0x11300300 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11b20000 0 0x1000>,
+			      <0 0x11300400 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11d70000 0 0x1000>,
+			      <0 0x11300500 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11d71000 0 0x1000>,
+			      <0 0x11300600 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11d72000 0 0x1000>,
+			      <0 0x11300700 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11d73000 0 0x1000>,
+			      <0 0x11300800 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11f30000 0 0x1000>,
+			      <0 0x11300900 0 0x80>;
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
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11f31000 0 0x1000>,
+			      <0 0x11300a00 0 0x80>;
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

