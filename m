Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D748C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B98B84A6B;
	Tue,  7 Jul 2026 17:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="DvjUSsfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102E184A6B; Tue,  7 Jul 2026 17:10:55 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAB984AA6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-44cb057311bso2480211fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437052; x=1784041852; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zue/Q8oJJ8ZGn5oLB1AhElp1nu57eVGgvQ8EQHIIMG0=;
 b=DvjUSsfJPcMKR83dGzYlmofwxpXuSiy/e6VvEbLC2LfhkuwOd7cbOOW03ZfBQEsCE7
 vS/Y5x+uIFFJzD0X3gHASn9z/mfYBL9NQxxuyW/xivi50Nn/PLE90qU2BQQ33aCinhek
 u/iWkCNxaGH/5YizkKjt8ADlvo3wa6gq4RIZTutS7LkIBOmgkvCSxm3Nu34KsXiScUME
 dck5IpScRppk3hxDCPWdf6xML++qwLPjdLIHToDUjhePkbeCjTOyzQoejx8ClBmzd4DU
 8mr3FG2qFDQZYirASZj+UgbShaDzrNBWIiU8tFB4INuFFeptXVuDpCtPDRiLR9qZq7Ua
 544A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437052; x=1784041852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zue/Q8oJJ8ZGn5oLB1AhElp1nu57eVGgvQ8EQHIIMG0=;
 b=rEAdFhbWoHr7+McBJE9X3KSqyPjkLRWyaczOzHxaHtkdOOf7cfn2QioSwmWJwnrCTs
 ZNe9E7h+cgiJhqs+2mAWo+XhWLfgZc0jym7IXarhLV3T6NleilFL+wjWt84GwXSUr8Xk
 YO0j5OyQaaHkqNwpNJF8oUtUF4Vt9L3FG6X+nFI2RwkmPFtfi6GgRvN9e1baMZzMpV0M
 HKa2dw0xJsjTf57J3369DpOHDlvW8HP/UPDCAPrvUmImwSDsZs8Y6PH+0EDXuNyoJcJF
 6P0XsewDaRG1B34Ck2ODtVhFr8Z7mRO/1ogNBV/wn8CY3Ls+TgXo36FDmhZe11UdClQp
 ldQg==
X-Gm-Message-State: AOJu0Yxc4hDerII15YGJgik/KMfpa/YcSlO2CUx5woI7fAm4qJDevgXn
 k/TW5bWS6gS2a36mbtuzOphnHQA02ZO/LGcnkyajPtsfOAF6CpnZIHs2JeiTjSvYK/Q=
X-Gm-Gg: AfdE7clkP2lvFwuyqZONc3bqYfSA5sYD6e/QtNjFZQVHOif6vMoN5RGjZlBmFTTSJQv
 pmwuWeLWbhP+Vjz2APYkNcxc0wTHJDNpcJqwhKH+hvbFKr54PoXuJv1RZMxenigCb8bWkbw6BtX
 sdXmTUOfFkey/51LiocYLJiJze66cy1R1kyJnPspdX1QKwpaDMh3bnp6YJ1gXxHPMy5JHwg57a8
 O13nI3X7q7YTzy//QHztb5MxPx+DE6EmObKjAZt3gfZ7qCtwNkXCl3iCpRDFVhth6JJDV1z75k+
 tL13iZGudy4Lc+iQpQ6blvvz/JLd59xaP+rcW6syCDaQNfH0PinFyOzDHjGMjvjLAYbeITyW5L5
 BPSxM1XAi6T6JLgQjWWhHQZCh3TndRCedanrNxsnebUC8wFX3Kr3IaIl4s/LFpntVUm01qaAsvD
 dJ7gMyAV7F/6bcKbzHyQ==
X-Received: by 2002:a05:6871:287:b0:44c:5d96:337 with SMTP id
 586e51a60fabf-45105edc984mr3530834fac.13.1783437051673; 
 Tue, 07 Jul 2026 08:10:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:42 -0500
Subject: [PATCH 22/24] arm: dts: mt7986: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-22-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=N5IFPkIZM0CXJJE1ZUGZhDQsIAi56m+dDRdLb0zesWs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTRbKEBoHyo25z7ro8v7Qn5VTCDLRBKk3lUebl
 hdNvXtuS1CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak0WyhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZUUH/AttJn/EKYu6oZQhxkOLaXJf4IAXTMdXUu3DRXI
 PCZHb5bPYa7FcG3fq1a+QwfCjcKVHrZ5FCW1K4DezJhamEaq0GAcH6eLaEWDzYxAPcUE8Aznr2p
 5EUUdCyGfxua5XOPyNTEvhCPUjHx8VObOpsEOBV3iZ3Y2qJDVKJQ8oYY2mG7cfE1QqkBJGCe1BW
 GIEAmPl20iOSSo+s8hgVacdPMn9dCD0oXFm6q4C0KZbFdczJtNi3omhRb/s3VFoYJLoM+53ZDOO
 lpziVeXOv/YzxE0Gjvk3jNj6WDDMEqf4tZRTWNY7CmlNeikCvcnaKxC/r/8K7lOCllHY/lHeVS9
 SXI8=
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

Remove all clock-parent properties from mt7986.dtsi. The clock driver
for this no longer uses this property. And this property would not be
acceptable upstream anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7986.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index b2c57098a5e..5b62d8917ac 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -111,14 +111,12 @@
 	topckgen: topckgen@1001B000 {
 		compatible = "mediatek,mt7986-topckgen";
 		reg = <0x1001B000 0x1000>;
-		clock-parent = <&fixed_plls>;
 		#clock-cells = <1>;
 	};
 
 	infracfg: infracfg@10001040 {
 		compatible = "mediatek,mt7986-infracfg";
 		reg = <0x10001000 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 	};
 
@@ -217,7 +215,6 @@
 	ethsys: syscon@15000000 {
 		compatible = "mediatek,mt7986-ethsys", "syscon";
 		reg = <0x15000000 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};

-- 
2.43.0

