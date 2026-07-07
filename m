Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23247C44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87C884AA6;
	Tue,  7 Jul 2026 17:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cjkN4tj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C9D84AA0; Tue,  7 Jul 2026 17:10:56 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C1F8496E
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a15ca0d761so2819027eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437053; x=1784041853; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=87eI/6NhY84A5SZCrD/f8Pnrnxq5ipaEI8VWQrzm03g=;
 b=cjkN4tj+fyfb3XLgcv0CFzZG6+oUxFXEzYiD6UMdQqGENq2VMwTwvEXHtcTCvz0QYz
 SNrJkDyXPA6NFAxMlHOevU2IYT+CXaZPcu4CJ01B8Prp4YFBKdaZPAc6quCZ+kKCJo5A
 QzGoZ+H3J9rN9pETrSH4xSxTUZcMrsI0hsWHFiEV7pkP9l80/SiSNqm+tUCyI7TuM9OG
 uGPRRC0lt2vt2f704T5PQkaCAjaJO8vDLhM6Yx9p7v00mLKkkBwMNlM51x+TrX/td6cY
 9o3Q6cNmXnBxHkWhwUIVP5MWHM2Jks+e8Bz1TFKv2pg7qAiddxc+B4oxaXcTeGAZeW3O
 /4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437053; x=1784041853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=87eI/6NhY84A5SZCrD/f8Pnrnxq5ipaEI8VWQrzm03g=;
 b=Dd4kNFsEFkCxoqm5dA3FsvITNHy6cuBSC8K41WRx4U6p3hKMPEwKdXSX+volSuqBzz
 9+6rbFArZxJixMLRfnPzBYbaMRNBAvDM9+SI+t5R4pZL3vXLkR+K0eUmnDZ1hBwZknfx
 0uDPYrWjLfCbTlENYHVSY0n2pkQDd4/LLk82t7GZdvDVqm3/FcWTtJu1YoDOcpYKWxdV
 IHqZx0QasSTrV9d1ZtB3ErDewxYDyCx1nkSUMkTS000GMDkIro9TuXm8wuehLd+/EjyA
 Gs3APPwNdnX4JrdrokPVbQaaNwLazC6trY96BiGjacSDzmFejhMZa8f/oKKn2SDX7TR9
 dQgA==
X-Gm-Message-State: AOJu0YwhpYDmZbx2EPQakrNU9bfl+sVutjvtfyz4dsTN5CcuMqgXwez2
 cIKj7X3eWe2IfmsAV6qYHENY1msy06Eu5M6tDW+avIBZs1RJKWNLD9pdD3zXPEZgsdlts2CnlfA
 B9rif
X-Gm-Gg: AfdE7cnfndSnJMr2G9oO8K79ddxEyB2II6KOsG8UQy5IrOLXlTEjzEYl2ebAj2wHjfI
 5Xk1Vd/yZiW/Q+Ed9epHiPKBCacoK0f1F9WwiXuHXeUre7POkporFtByEWpcZncj44h89NvxICW
 aHSxTQNYb/sRKyikyv9zy0MrHl2NEKeQHNNY35TgYzU2nUrit9zvcAiHWi5mrLxSB0hwOvniheY
 GiF21E20POkVgsG9of6LCxmWJpSOisa7kiutRIErzxJoqi+u3ZKsbkc+xTfNgghDTE2cdA9i/93
 TzASOoVKFb0S9vBiA2mJkBAKzM8pxncA3dqTm6zInOpvHoT5apy//pGUj+YjuG7fMPeM9iLB6IR
 wxwK7S/YL4XNeGfLJfO6OpagjfU9Ui/7GLW7IkRxqyeBrwBfx+OncQdjKjNjRikqzqSszw1HwiG
 iRptQ7biqGgrAV465QWQ==
X-Received: by 2002:a05:6820:4c8b:b0:69e:41d8:f7e9 with SMTP id
 006d021491bc7-6a35553201amr4005716eaf.44.1783437052772; 
 Tue, 07 Jul 2026 08:10:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:43 -0500
Subject: [PATCH 23/24] arm: dts: mt7988: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-23-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1vp5Yff8qDg6GMrxm0AQdJq9zxjHKw9BY22VLWgfJ4M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRbRjqa7TbVhyjNAgLTl+L1k6GBekFKP6cxSp
 HP5LiVnaIyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0W0RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjCAH/1g2apmzKhzpxibi6OeplkCsxm0DZW/K2QnCDoj
 9g2uNyOpmnWX2arh0TipmbmKHx+X9Jse9HkVLuVohU9YDKqYf91nrIyDQXMOXpP860WUOmOhJvY
 XxtLEUC/C4/XEKsW/5/2pjHaU/ATuBERJfhwlHfRDBnQCRqCzRMe6XTK/Wl+plBFPhecYm1fjwL
 dZ2fdCrmc9xgZZwq3GP0ClNk3mgT7fBA6wQ/jHar2LZw/DyXMuNkOJb38ORWAAObxf8GpnuZXJg
 L3uQLQhHrxBsZAWlt4TFzoJ55KzfTvCsNLwmZ7d72pyyr4YiQ+ZZist3SYjr2gUZxrqXxClcESZ
 FWPA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove all clock-parent properties from mt7988.dtsi. The clock driver
for this no longer uses this property. And this property would not be
acceptable upstream anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7988.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 2d57c6f5709..0f7a85230d4 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -106,7 +106,6 @@
 	topckgen: topckgen@1001b000 {
 		compatible = "mediatek,mt7988-topckgen", "syscon";
 		reg = <0 0x1001b000 0 0x1000>;
-		clock-parent = <&apmixedsys>;
 		#clock-cells = <1>;
 	};
 
@@ -129,28 +128,24 @@
 	sgmiisys0: syscon@10060000 {
 		compatible = "mediatek,mt7988-sgmiisys_0", "syscon";
 		reg = <0 0x10060000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	sgmiisys1: syscon@10070000 {
 		compatible = "mediatek,mt7988-sgmiisys_1", "syscon";
 		reg = <0 0x10070000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	usxgmiisys0: syscon@10080000 {
 		compatible = "mediatek,mt7988-usxgmiisys_0", "syscon";
 		reg = <0 0x10080000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	usxgmiisys1: syscon@10081000 {
 		compatible = "mediatek,mt7988-usxgmiisys_1", "syscon";
 		reg = <0 0x10081000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
@@ -378,21 +373,18 @@
 	xfi_pextp0: syscon@11f20000 {
 		compatible = "mediatek,mt7988-xfi_pextp_0", "syscon";
 		reg = <0 0x11f20000 0 0x10000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	xfi_pextp1: syscon@11f30000 {
 		compatible = "mediatek,mt7988-xfi_pextp_1", "syscon";
 		reg = <0 0x11f30000 0 0x10000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	xfi_pll: syscon@11f40000 {
 		compatible = "mediatek,mt7988-xfi_pll", "syscon";
 		reg = <0 0x11f40000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
@@ -400,14 +392,12 @@
 		compatible = "mediatek,mt7988-topmisc", "syscon",
 			     "mediatek,mt7988-power-controller";
 		reg = <0 0x11d10000 0 0x10000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
 	infracfg: infracfg@10001000 {
 		compatible = "mediatek,mt7988-infracfg", "syscon";
 		reg = <0 0x10001000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
@@ -572,7 +562,6 @@
 	ethdma: syscon@15000000 {
 		compatible = "mediatek,mt7988-ethdma", "syscon";
 		reg = <0 0x15000000 0 0x20000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
@@ -580,7 +569,6 @@
 	ethwarp: syscon@15031000 {
 		compatible = "mediatek,mt7988-ethwarp", "syscon";
 		reg = <0 0x15031000 0 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};

-- 
2.43.0

