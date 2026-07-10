Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB782C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 19:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470284BCB;
	Fri, 10 Jul 2026 20:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="jjp4BuIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6312F84BD0; Fri, 10 Jul 2026 20:59:48 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72B984B9B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4518ad44e83so676550fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709982; x=1784314782; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zue/Q8oJJ8ZGn5oLB1AhElp1nu57eVGgvQ8EQHIIMG0=;
 b=jjp4BuIKDwgRE/aQGXDNC+kCcOtzv39SmcaNPAfHSuEnrceazt7Ez5FraxM0xOB77+
 SwxTiTLER7Pon2f+4WpCeLF/QVqiLUw39G8wNekUYfh68xlAKLCfGk5BHdABK/zuG8uh
 tjFLc4dML/uhhKoyJUzJmWvzUDw/kjTK+5tn1VwGBv89qn0IY/1UGBO1UksnOfUSTiWq
 3xfClpLwlboIav1QR3k6md8TOjp3LERIc7hGMRiQTWKk3sDiAIBVTpztWct3bMNup2jZ
 VnzXnAIQWo0yCFeq+EUHBXwiUp6FNwRqcLCVFnenNApY3SWp8iIUVE/H/hGie3m1f/+u
 JTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709982; x=1784314782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zue/Q8oJJ8ZGn5oLB1AhElp1nu57eVGgvQ8EQHIIMG0=;
 b=qrtU5SXSBI4qar1Glo3bPo2Unnv9tcDMdSSrn1dzdXY+JYmzBaf9EcOUfkiZtfUUai
 01Q7zQvmHYT9tOA3rW+vicjSqOSBa+Y2hvri0o+HHZsgw1K9bPY+NwWNnIu8ST9vB67M
 PfdKcZvuOQnMEC7dF6fE0bV16n0Lozl32Gly6C6/P6sdBGVG43eyVWxf0cgT8QaxTKYx
 Bx1Ss9xZNSdHTvT8uOvJKXYSXRyFhVbsL4WTB/uaJCgBEK8ZvRNniQJLGAemHTejkOlb
 WBKAEZ4Sl7R5IM1DHJYHfHA9HZ/s4kP1W6PI1yvTc2LI8HuCfAEK6FTyoBqY1K/+OPWO
 Z6+A==
X-Gm-Message-State: AOJu0YxDraHJ1kdPVINL9R6S0tbhvyybZB+R/p8FsEzZt1KspL17uBml
 dK8QqVLnTvfHsUrhalt06qCd2zFqfro/aLSREYn22wbDEM1fyF5JPRO6Y0x9sSPy8Yg2Yg6Mm0i
 UWoJF
X-Gm-Gg: AfdE7cmsBSE5nKYnzbp8yWCg6mctYNC0eq7WeBA83nKVv5jOOXPG9l1jJ3RJvXVYxJ6
 sVeKI8ekW2z7/agkp6RfzyGWcuDEtT3jwkRqC8iH5ZIFaSkCW1mzp8ra/bUVjdgh5zMg+tk1BUD
 ajvo0nXO2zaxKZF+5vinCmmZo25SCkmNmXR7tkUVoudh5Ap7tWlR14ODoZPyglbSxZyJEcl6HNq
 QSYs9VmBASwRTIdOxODgL2PEilw9jXmdFTqHKhomfAgwUMDyTAMcmR7mIqAEh+9OHTzwPsAXJrz
 zNRfjf5T/mCTRWv8QlEDv5w49saG2gCV0HKtbuDQCUurzk/9913F057Cf+t16Jxj5UkWJgKQjuQ
 jErrVtmuBslY77iouLIYBxVbGIMXEir39NtNKJV5akoGN5Tc03KMSjVFerWNyNlHZ7pvbq28uR5
 lJlmg9bxcyeClscrj2
X-Received: by 2002:a05:6870:971e:b0:42c:24f6:f190 with SMTP id
 586e51a60fabf-451f10f585dmr104370fac.17.1783709982460; 
 Fri, 10 Jul 2026 11:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:38 -0500
Subject: [PATCH v2 22/24] arm: dts: mt7986: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-22-f3f3a4a28dca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=N5IFPkIZM0CXJJE1ZUGZhDQsIAi56m+dDRdLb0zesWs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUDosDKzyWP0nvPUw6uLzo8xHoMhUHzNWQnox
 AhUrQDcTpyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFA6BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4FYIAIAM/5zSP5BAU63fRBOfMku66ix05bnTRXE/B+l
 49wiOjmkxyE+A2FFL8FUys+eKlNn3ZR/V0hybouNwdl5lfgJV75iYeErlBatMgZcDrsXyOEAKtP
 lrKN1UAooJsnBZ+7N2qc7Ly0M/QkT8OcYOhEpci1Nyhs7nZA4xxBuFdyljxECzLJyWeN6PAqkDc
 DdIdaoqiU4PzRqRu22UZ9v0mzFU8yT2fAsW4oJpfC54SaN7VaysV8ljreV/xIx7lKC4lvzZjQev
 ZdlnOQUS69tJTvPmk6T7AiI5aLa4OkzEKMA3wmKfszpw25rZdCbdF4/2t46A/U2Q1Vi0urTOKzq
 9Ceg=
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

