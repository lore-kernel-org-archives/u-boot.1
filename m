Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8428C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A781C88C6A;
	Fri,  2 Aug 2024 21:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLL1P2AR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE32488C45; Fri,  2 Aug 2024 21:56:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FC188C45
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so15480235e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628599; x=1723233399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2v3BS6tJjFMUs5khv0vFArCraCDWFrFo14+KHy++Cfo=;
 b=JLL1P2ARXwFjJevx4bsQki7qx1HoMd3eqH/Id0A5130+uzHNQSadh6AfBoknlpENKH
 ntoUNJacYLxt23HDprTEe/xTUEAT8rBXtpqFNKHjO5WFBG7zFi6c2Mg60UoVsrQmtwBc
 5VqJua0AsLv6FETsfgY7esk1Dr7mt7ON8KCqKn+M7C9if/kV04dPFEJamGQHmnVjyK9A
 MXv2VERHYUfTkWHNzR53ylp/3x451ViTYpb1WBtCWiNoTFvrLsA5UW8RsVq4+8KUYdjK
 Xi2hAPt4c4I/kFKd5S/2srf/7I+2dvutNcTtm88zom5XFPfJjVgA5ZsUD9noQUUQz0kk
 LycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628599; x=1723233399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v3BS6tJjFMUs5khv0vFArCraCDWFrFo14+KHy++Cfo=;
 b=OeOt43tXqVSITk2Rvkdke+/7YGT0d1QHYVX4/nFskn3eqLhLBEX+a2zFK6JauA1lW/
 U7e5uMD/vLxCcSlHAXSscbzU2lg0QjtrVZXU1e54jOrslPery1dosxkTkFENdarPq07K
 t2BlpaN9H7dHbWYBCJhD3DJwOAN0IMwYXAv87OMy5PwE7oqnVDr1hoYazKo1hJeIszQ7
 QcZ4KSWOAdH15U6ZQufIHUn0i1WAdYWjAWeD3u6kAc9VY5M4aILVntun9B6fJ3168kwZ
 //9RPKhYwGKVZHOvu/nuNi1RmzVHo+NMVQ6uZc59Hd7n2N4Zep3ts2rrsdFE2VM61u0h
 DjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvKNOgOeu6/rB5114z+80+bTP/VrBJdVWMdn1CCeKDw5xX3ughALPqyGra6CG9xdSuXaqMD3zx+sld+qfjH4QG2toxVw==
X-Gm-Message-State: AOJu0YzPcEzgyvCDgqc3GO7lBl1FjSGoLNv/Vo2GMJmrDx/tC8E7L8kZ
 XebanHLt5fZfv9xv13L3B/8VNcvZhwmM0l7G45fWlN/Ev0P8v8MA
X-Google-Smtp-Source: AGHT+IGNA0fdGPJ1Ly3AmPfGb2Pws4csgounv1Atc6lE1zUnA4GnLA9bimbygD4N+qxeH0p/8dzbiQ==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id
 5b1f17b1804b1-428e6af4c75mr24990745e9.5.1722628598869; 
 Fri, 02 Aug 2024 12:56:38 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 06/14] clk: mediatek: mt7981: swap wrong clock-names for spi
 nodes
Date: Fri,  2 Aug 2024 15:53:07 +0200
Message-ID: <20240802135326.25303-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Swap wrong clock-names for spi nodes as they were wrong and the spi-clk
was referencing the sel-clk and the sel-clk was referencing the spi-clk.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index d80eceb8d4c..be0d42bc997 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -271,7 +271,7 @@
 				  <&infracfg CK_INFRA_SPI0_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
 					 <&topckgen CK_INFRA_ISPI0>;
-		clock-names = "sel-clk", "spi-clk";
+		clock-names = "spi-clk", "sel-clk";
 		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
@@ -286,7 +286,7 @@
 				  <&infracfg CK_INFRA_SPI1_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
 					 <&topckgen CK_INFRA_ISPI1>;
-		clock-names = "sel-clk", "spi-clk";
+		clock-names = "spi-clk", "sel-clk";
 		status = "disabled";
 	};
 
@@ -299,7 +299,7 @@
 				  <&infracfg CK_INFRA_SPI2_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_M_D2>,
 					 <&topckgen CK_INFRA_ISPI0>;
-		clock-names = "sel-clk", "spi-clk";
+		clock-names = "spi-clk", "sel-clk";
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
-- 
2.45.2

