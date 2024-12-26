Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B124FE7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F97D803B7;
	Thu, 26 Dec 2024 10:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H/SkqQ/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E24803AC; Thu, 26 Dec 2024 10:21:07 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E56D2803E4
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso7241723a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204863; x=1735809663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BCzD3tGB7fehniWaJBC2erlvLL0gyAZd+x/XKWC4Po=;
 b=H/SkqQ/7hrxJ+lv52rzUQ6AWBW11TKJYHCrGXFTk6o82qQeyNd3SDXO1bLo7HH8VXG
 ebQJjtfDlXHYi1dyiRdtOY/tc7yFenAIjZ1m0V8HFfpydHILMnXE4aMcvlizoCTAJ/Em
 xoFlkfXqC22+iY1lk9QCkf4aZAM3uqhCI6k3vMSrptObzNGwWTiRSw9eDkZGSSx5uapU
 fJVZ2ZVdGnYIyDVxVQhRRIDYLuBe3uaXtD7dBhyZ1L8THXJfO1BU7mltHuyKZW3MP+eU
 l4fV8Iw+ZlTNDX/47T+6HWasUs3yiH6bx0U6ETJB2nY7vE17sqfHazLBcnxJ6ND0sQ2n
 xc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204863; x=1735809663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BCzD3tGB7fehniWaJBC2erlvLL0gyAZd+x/XKWC4Po=;
 b=XA+mq1k04bRM+1FrcedQvsbIq6OQPT8Nv4VLIkECbQWw3l9iAxuUuFR8/87MzdvSCw
 wZt2yvc0cax0Ls9pwNaQB1y0XgX1grmYXYfaCWBvoIBEqsVyVD5xiNUAlSfaX38yxiqX
 OGaaG3Bga9O3RoeWwZ805GHd7zKRQBbSq/IAmRToLrZQxbJIVmhntWK2x820BM8zgCwJ
 wvLEMolgxYFcK3CN5Qt/r2dbVccWhA74bSs8gKpcqbK6HsJ8ZGIYc6xkml0vh9ajfDDe
 Jcym6KFcgJjKWK/I8zp0yioceu6epsdFiiNbVeaEKv1iPZsulAk1+SSR2fN6SrqdD3N4
 1XQw==
X-Gm-Message-State: AOJu0YzWyr4JDwwM5iGUcG1a6wA7ku3X5XCh209ZTvDniKHHOF8+5Uvv
 6JNU1pFocbPTy3gVXKnStfTNpYpJTluSBklzT0on4Qq6x1JrPiwd
X-Gm-Gg: ASbGncs9QMBAHo4rugrIiMudEYswr4Kr/rN6x/LbvZKujppWpuk7Llulwubxkf2b1/5
 AbAaZtHp21+Ov8kexWmfMaINfaW2cF+ceBdKm23YQFeciQ4YJaHajDFbLtlQ3INM56s47rweEfQ
 XxPC05qkgg0G8Y0bhzwfQ4Es68g0pWkR30XQEwbCbE2Sc1XnEPFv1rWDQb3zcjeoIhINeqCZBa6
 Um6EO86CwAVz8bBik+BLBto4Ar1qTt4PrN/p/n3IG+uo1zWpEUODamPVAc=
X-Google-Smtp-Source: AGHT+IFZGH4JBKN4PB8Dmk4FYz1wj0xDF3hUZ0Tf/djin8o5j/FesQQW7Au+kUSjykXPWph1YKFP7w==
X-Received: by 2002:a17:90b:2543:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-2f452e372edmr30577694a91.21.1735204863088; 
 Thu, 26 Dec 2024 01:21:03 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:02 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/7] arm64: dts: rockchip: replace deprecated snps,
 reset props for NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:39 +0800
Message-ID: <20241226092043.419511-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
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

Replace deprecated snps,reset props and move them to the PHY node.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241022193537.1117919-3-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 82b2868937883b65732da498b26366d34db61510 ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
index 6bc17f755b..66a00cddda 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -149,10 +149,6 @@
 		     &gmac1m0_rx_bus2
 		     &gmac1m0_rgmii_clk_level2
 		     &gmac1m0_rgmii_bus_level3>;
-	snps,reset-gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	/* Reset time is 20ms, 100ms for rtl8211f */
-	snps,reset-delays-us = <0 20000 100000>;
 	status = "okay";
 };
 
@@ -414,6 +410,9 @@
 		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&eth_phy_reset_pin>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.47.0

