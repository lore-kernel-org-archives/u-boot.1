Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECFBC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56A684AC0;
	Tue,  7 Jul 2026 17:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="fIvh5Vyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE54C84ABB; Tue,  7 Jul 2026 17:10:53 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A507384A6B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44ce674ed17so2577781fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437050; x=1784041850; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9/q/4xqys1tPKc/trzQtN51NctBGdrVnwa9PDYgJ+o=;
 b=fIvh5VyiPjQ7lcmsW/EfL+h0YmRTBYoxrzYFTRl2Kd8522Y1j5hllAvFv8+hioYIjv
 61+wAiHRNahJPWheGPOyM50SZEpGOcdjijr9n8Auv9sjiR965HL6wotcsmsUnzqScb5R
 vUghqrLBaygcfoBEzAiZioKv2+fi2CGvwRBUXrll5ExAp93LMwM61eYB520a2eInR3J0
 X3/qWlCDMUzDaqF8Iq3t96f8n7aewe8bnUSp50PJoWybqmSwdFyOGw18JQj/NgklbuMg
 p5lS3hI1eOWXLOXbg+vEmgZlORNNyUERnIE3k4B+ld/0vhX2sQwakLOCFoYs7LCXlnMa
 Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437050; x=1784041850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+9/q/4xqys1tPKc/trzQtN51NctBGdrVnwa9PDYgJ+o=;
 b=L200YzFpK85JN82MmP9SOvixU/JjDa81rBWdeMWEj+sI9fW+U8jHJqxDevGgvIqMXn
 CL6x3LqJBkq4DnCP6SzXNvgLcS56mfGmU4VZA//q6+VyWhTa1bhwyxVPUjJeIt6oaEBW
 4MFVOtwc2wkpIB5ZV5exbUtdn7nSqgr3alxIY6GTlvgxy99k1omEzwhaHNz+b5gBSZo9
 e+dFTboedk+bnGMPfzF5Nj1yOh1JW9IGXc5kg4F6Dv8e1Gd4IGrkd/S6+xGpgRkau3wM
 CsQH/yAnRfi5ZnIIIOI85YtVMdmxQZpomRBP2nIqFLO2h+WXyo4api4UE8yIC5XI53T2
 C2/A==
X-Gm-Message-State: AOJu0YxsFIQ4zujufqbv89jx8z5dkBbq7pBd7G9Btfm38B9jeS08S45d
 nWIMDHdEUoPXIdwfrec3Bg9alj7pnpwx4yVF4gv/hEx3E//1EsNLZ9keGAFlvHQAP9s=
X-Gm-Gg: AfdE7cnQiPZJew7iaTO3TyRIqyHo9KvVu9CF7/ycYyjxR2mKLkdQTEigKzO1lYLxoBe
 TUJzwZoCnbE4EObEcaElWm6rsDOa10uRiqZVWKLjBhAjTRk169DJJbSDK3iK5au4bX7hE6VB512
 rxYNIufVyooh0lMeJZ3WakVCyHnaSvE9TL1VYxBQ6P/si5exICgnR/4fxXO/bKxEa61ba0+m0ln
 ZO+2fjEKL9KUwPLuehtX1tS4uZB88xUxV+p2ADmHvmRTb/EXJjkaZso0k5mQOQBqA6W2lLlYC5G
 SSeCPBti/kXXPMvUA4gxY4b21/jtfnCu4X01yeonbKnuZkIPdrC8xSWf5HLBQ7SHQ294wO0X+SZ
 G7sQR++l0uPmnS+/GeIDCaQYGevvg0EWFoWdfOxz5zeMFgvPs+BSjcqyx7Ntd2WLPOyO71lEUNt
 4tWfWKTCatnXtHvkXWvWEu5CF6ZPXl
X-Received: by 2002:a05:6870:612b:b0:448:5591:15d7 with SMTP id
 586e51a60fabf-45105d6968cmr3572792fac.35.1783437050400; 
 Tue, 07 Jul 2026 08:10:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:41 -0500
Subject: [PATCH 21/24] arm: dts: mt7981: remove clock-parent properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-21-65d24cc0d569@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=D4xk6d9IfOkXCYVFQYhiaekbmaPi6vt85LMoERhg010=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpNFsPI7lO8d9t4h+pSaLhOfSc7RvPsnd3Pev7FgRQnzKfc1
 okBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqTRbDFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8CXHgf/WVkGxD9EbPGy5YsZIeGx+nIMOQfuSv531ymYcnNETZ/syFJ
 RahhsFJYAXpGP6uY+DFO5uG3n9oSfp1Gt3dLQoqSH8Bl8BDUDK3isn1t5LJWTYnorQ7aLwOW1pc
 5gHfMx5vLqVTXg8mYvcBqkoNHJja9gADEmYjtXUgZIxCbL8Iz2BPouRa/cOZBPe+QuvGzkgFj4z
 zpRICrbWzA5XvcM4a0MeKPQZDCDBy/WixnzG3S6wThpd/7l6kvkDb87s+0oHnVeKxXiw7eSlH8e
 6atcwamXyomi6LVYmo8Pys5nUXyFOWXyWpazXQiBEOtpKoj65uuuHo/cw7INIFG2XSYc/g==
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

Remove all clock-parent properties from mt7981.dtsi. The clock driver
for this no longer uses this property. And this property would not be
acceptable upstream anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7981.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 5b4cadc22f7..675b14a0b7e 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -94,7 +94,6 @@
 	topckgen: topckgen@1001b000 {
 		compatible = "mediatek,mt7981-topckgen";
 		reg = <0x1001b000 0x1000>;
-		clock-parent = <&fixed_plls>;
 		#clock-cells = <1>;
 		bootph-all;
 	};
@@ -102,7 +101,6 @@
 	infracfg: infracfg@10001000 {
 		compatible = "mediatek,mt7981-infracfg";
 		reg = <0x10001000 0x30>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		bootph-all;
 	};
@@ -221,7 +219,6 @@
 	ethsys: syscon@15000000 {
 		compatible = "mediatek,mt7981-ethsys", "syscon";
 		reg = <0x15000000 0x1000>;
-		clock-parent = <&topckgen>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};

-- 
2.43.0

