Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF22C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7216C84BD7;
	Fri, 10 Jul 2026 20:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="TBwqd+NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373C684BFC; Fri, 10 Jul 2026 20:59:47 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069BA84BD0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so1074638fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709984; x=1784314784; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=87eI/6NhY84A5SZCrD/f8Pnrnxq5ipaEI8VWQrzm03g=;
 b=TBwqd+NRPTTU7K4YOwbbvMEvlLq015kdOHFouUFItCke5Ra23RGNkQJLElMvYsDuN2
 M3lncDcn8lpP7/fE4k7jaTcYEBVz9Jiy7CQOh/bZBtH5l+eHyrTP8vi2MZiAT3riZ9t3
 OS2VWeJm1qg7Lp4evnRcsDLfBEFv0BI4LexXrAhwH3OqAJfhorNwDlQtSKclNbBXx1ys
 6S/1i60gWyYlBh2UFyu7vEhqn/t2bCbL+Q+j56T+dXGHzFBo1XGAnM75uHF0JN9x799Z
 zP4Tqb/72o3mJ65ON9T4raB2aYuiPPKzD2WP8Lqj5JOxY++bc9fdXbdvjoBi6X2OCH2f
 W2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709984; x=1784314784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=87eI/6NhY84A5SZCrD/f8Pnrnxq5ipaEI8VWQrzm03g=;
 b=svUmrJu8w1YRr3IiGAjWfo6wbkYhVXKRA+uVugo0RPl3+b1SjlFqLz4yI8d/IIJ1fl
 y9715hgIg8fQCFdWSt9jPY+Zm1FwGbENoolC0GbnAlmBJr9uEylZAZd9RGhYB7uVXxkz
 6xXMgihiBhaWb+v6GwijTvsmXEDiKzZFT1zx7rTDFZAPt1Gu+hC4ZVLKR6VFWZfHjHYG
 kdoRqxW/rqaTv9obcqOUH+saRQ7MAn1/hzhpEtZydjlRtFAk22JjNppXrx4OyZNVqQ8E
 WU8WzQNdpV7GUAd7kaqtEBNxtb09oYStEM5JXXaoDBNtrKv25j+uiYSZGHbxsIvL/4MF
 4LvQ==
X-Gm-Message-State: AOJu0Yyrs501NH4A08tVUnwjnPgJoaL1xlO4wTuQmQO7yMMCv8XXeR0C
 ISq1+Z0rQObTI1IInTkTAAHRCSiS6gmcOQnceGxzvHdIAoDKASGRG41q0HBLBafsTQjWU0HqZFu
 cqKCQ
X-Gm-Gg: AfdE7clQIsimmAD2BWDKgyUL8L53jWFb3xkseuj+4d2pd2pFEdGmu6bw46ID967IK36
 aqpz/7LeCh7+zqKEf1rH6H9BLGwEvZXmTx/FYmzhDfYsTciELM5npgTJZVQRKPw8U4FARSP2woL
 IWjAMt9qslaGdp3m0iGBCBdk9FaWUVOztjLIXIvbK1ncxynmkwEwz1lTQZAwuqwRLLlfrA6z+D1
 c9nfr177eOcucFHixWCVc4wgXsUESntFUtSgfzuPeWXJbB9m9XUG4fgBCvchwdMVZB5aZ3WElo3
 K+S1UxCNfC5xnDkgX8lbf6xm0G0e3pyxRNZ1MV/F1xMaxZaXDFLDABcqGpC62/kfNU3p/Fvy8p8
 BbKEl9AID/AUenTdFXIC6I7B6mOCKKMDBTOPq7jkxt7OSXw6dcUJwtYBYTnU3+PCMtKKq0ZPWAC
 o/SZfynqnnQrhbOVdp
X-Received: by 2002:a05:6871:22c8:b0:43b:9a63:a7dc with SMTP id
 586e51a60fabf-451bb02c7f0mr2235161fac.18.1783709983644; 
 Fri, 10 Jul 2026 11:59:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:39 -0500
Subject: [PATCH v2 23/24] arm: dts: mt7988: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-23-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDv0loKpeVZ/SFIedXMlMHqP0I+xPfKziGdT
 XWVbN05HXuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA7xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzwoH/jNDlkXbuVslYN4fC7tqIQiA4SqBcDLz0Ifr10M
 A2Bk5tROt99B9h41CbwzEgddrrUo1oGP3moFaTamAY5CauE9jUHh5wZzxY7p2utNasDMiuCMtJH
 UDcEmQvR+QkrzrrlTGz6MrxTeLtxQjwRHNA85N5e1WKcScnw1VLgGL58Um6/sCaAYQdUlCr3I+S
 lx7RbHuBsMR8qeQE1pRzDe2ULkMgKT3QbodGJz0loIm/V7bWAfqZhTbDT50aAJzp753PkhhFwb+
 zWRb2lt28NxeSE4BcgVrNvwr1jEax8sS30T+oAA/R7k96CBneSz0yHYZ/3/UIH4m50s6BfRg/Cy
 CQfA=
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

