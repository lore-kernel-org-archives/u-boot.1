Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB23C369A4
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6566883189;
	Mon,  7 Apr 2025 22:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HtrxCmkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B2183161; Mon,  7 Apr 2025 22:02:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8A9830B3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso26453555e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056169; x=1744660969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6GT2iCEOxGo3chKEWDmYa67Dxy7h4pm0P1Oned8gAaQ=;
 b=HtrxCmkf9EmUvrpbs00eY2XLWYR+4IG1Cz6wkew20xMMxUe4ZrCTCqUmWZS9YixW+K
 1Tx7rmIya/JxUn1cMeCNfqa4YqTje2Ye6VSNfBTRDdZpItb7hkwrLPffXVzsjfRtgOw7
 oblk046+HXAOtZeH4lCD4Ag2s6xueIrgFvr7/yCTiegnFUi9I3FoiUus7rBNtZksTvfy
 1PC7T37Z8o4aRnZ4CqVUQZgNNgIUbBqoX6f/1DAk6i2Y6n0MOdNte8fnO+6ehIyYimZa
 O7d3bZiCDw3wZQQIHeAhQ7dmJzBQhXb8NTGux/+wIgets+sTLPRg9kPSwriuP5csYAwc
 9v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056169; x=1744660969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GT2iCEOxGo3chKEWDmYa67Dxy7h4pm0P1Oned8gAaQ=;
 b=jlbZCy+HO87mu8cr8x0w7BDoNy1OnGPlzM4XylNie6avalfjv35FOkIvSftqGi3bLh
 E4pXfuvQhNWwQ8C6ULfIfoyx7Or9oqca3ZG5eTpJdPTBz7xdtxxZszYF+6VhTKjINyxr
 45ZvnkFVqKFF5RPgrMixFYx9n/yry78vOMlaVwpXHki8AZSlDrZh0RWFvHS4citFQgdL
 xHJpw6bK4pVsfL8XagJbVBeeaWSLSc6NknsGbjdPkl/pezPRKTJSHhoT3pOnLXiYRqKJ
 vpeGVyj2/iTVt4S3WJlun9npXEOYPfaLLRLzx8EeR2cH2+LeQkgsfZbmFCwofVZVy6h3
 Qzvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXStO5S0+98qKH7jYXhTBnD/lapPhP6tCwGj/CpSu0nT9DbRGbjAlBg7h1zcwwsHSd7sFFbyCo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2xUeo8p9sP0Itz19pWEOWgSF0RIPcysU8mFcg8MVVtpWNKfJp
 dqSjV3Kh2LzYCeSLpqEXX6m0kDlfuIpNzm3ZkhoJdtHV19jypGyH
X-Gm-Gg: ASbGncsS0viWFcXQe+tghWyVzsCzigjmi8m73xo8FP0Khn+m2M8Um8nQGNfW+uS/wyW
 PpJTAltwrvfJtA0PlbwiZ+fUtNVpspqfoY0Om45OQuf/XVkfPfTSuwfyzq6sgdWRugM/4thJqgX
 E0zsiLV0Kt/+dEkM9YaZpzzyx6Erez+qjxkwXhE5owbBAdG2ipMBdne9z+LWVKMU/f6nIzgL1vI
 IUFZFSvnQmbWbq4j+WCNZMu4pS0NnmI8519m3ur97vc5D4IHpwAqMYlbW4145ieVNWHvA4rvt4Z
 S7Jl+mptTb9vcuENceU3jg1JV3H/P05NSnfpEfEQ2711PD4+B2dvgqNsEw3wohRywqrbwSXWinl
 nSasmaCV7x82mAg==
X-Google-Smtp-Source: AGHT+IFkMc3BTivv6cyyeYswBjnB2G2y6XeG4+NQyAAdLAtR6ZtdSk8XvkZioe/k+j2y4rsLfbRBGg==
X-Received: by 2002:a05:600c:1989:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-43ee0660a3cmr107561235e9.10.1744056168720; 
 Mon, 07 Apr 2025 13:02:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 13/14] arm: dts: an7581: Add SNAND node
Date: Mon,  7 Apr 2025 22:01:57 +0200
Message-ID: <20250407200208.25594-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Add SNAND node to Airoha AN7581 EVB DTS to enable support for attached
SNAND flash.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 46526ff0f0f..a9297ca6503 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -59,6 +59,26 @@
 			reg = <0 0x1fb58000 0 0x8000>;
 		};
 
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
 		mmc0: mmc@1fa0e000 {
 			compatible = "mediatek,mt7622-mmc";
 			reg = <0x0 0x1fa0e000 0x0 0x1000>,
-- 
2.48.1

