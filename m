Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98461C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534A1820A0;
	Wed,  2 Apr 2025 00:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJumakoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD584820E3; Wed,  2 Apr 2025 00:52:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2FA81F4D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso52546015e9.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547972; x=1744152772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6GT2iCEOxGo3chKEWDmYa67Dxy7h4pm0P1Oned8gAaQ=;
 b=SJumakoODh+iV5/7wnahxqSdmqSvCK3MR08dAYv4nU5Gt/L3GgaNcOC4DQk5DQ4KA/
 j6Guu2/z1t95s0X4JT4rl/zcZInIXqxaZkTjkzFNlCAlnKqqnIZvKnoipYtdOvurfOgQ
 XanEpmx1vMz8CTGeOPbNybqYpFVTd9NTjJvNBR/nNuRYFMeR0s2WcpoZHHEAdmLRAi07
 1hpE2f8i+8QBthr3JRC83/iEvtqxMeYse3G5uFP4363fq1nsPHCN5e6EhEhzt3y7c6Bs
 fYX0Iq4tDACfWdqf1qBGlRG1E6TxtCdIVi0L/khlLohEpAXRQkNI0WsroP0vZB8htI6z
 L80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547972; x=1744152772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GT2iCEOxGo3chKEWDmYa67Dxy7h4pm0P1Oned8gAaQ=;
 b=XIgjJOEmz+tDaPe4FX6zUGFch/GYPN+iOCQcpiA6L0HHGL/9Fdu1yde9ifdpJkGqyR
 pytGWYg2ke9QAIfzRVWbVh3z2529Or8LQAdKdVPWLRIQvbjuiXGfAXAsE8ru0PBP3dWU
 Xi+513b8psAcUyitwNLLcvJYIJ1k4rYidICO2T/EHrbsD2+j4sZU1r6vgQ4QMG/Oyaum
 QYgRa3Y8IZwsexX0q6QiH7JqAQd0f94I9owmU/Z+JlR2uaN8X0BlocVZ7/K0JJi2mURG
 o5Mzc4bM0PnWWUEPz8Oi/nfO/Lf6ifT7uBuFqjZh1TRBBvPad6XZbFM4lXUSbLOjlb3t
 NBWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Z5fhwVAG6hjBz5PZUJ26xlF0sVWvUi1S9mvLoYEyyk/lE60kP98q4vGpFVrYkhwwU7jxW/E=@lists.denx.de
X-Gm-Message-State: AOJu0YzoNSVsusbK1uhRYGrSBLC7zHDJGH1AujP6i04gALMW+e1VLbmC
 /WK/Mo4DoRSPpwUrrRKG/0lod/kgJrTsRBuEWKRJ+ZZHFDEDOsZI
X-Gm-Gg: ASbGncvpAaWPmSviBLrraIfg9BttoqaI2ov1o1TrN/g1FlKDPcG1ZQJSSfPlzYDkMQT
 HlJ3viY+qmzz2oNzhmqOJMib5bfv4nmy4TpnciQVt6t/fKPKGb+ZyKs1V193IyFNyGvK87Tf3Dg
 Wms5IBqqG60i9OToFq1qy7WmaQrptJlMUyF/wC4q+SgXIcqE4gnuMne1ve4VGp3MyxFmnnVkxz6
 NVoiEGJagfNgbe6DeKaURNZBW4840YWUAKVc9wjnnhNQ1s6tYboUIva6gF75rdcZ+u65iQ25y77
 MdeqDZolhlyVQ61ikFpIoxuDxQLxfdSwv6ikJ0/95EzUYe4Ivqx1v5b1Hqwbw+aNKaSnI6GCmbj
 mAvU+T/UPfu4eJA==
X-Google-Smtp-Source: AGHT+IEoqEjQxwiohoTYXPTsI44DHZqoR3+eOxXv5JXY8S+M8SsKZPwkIQzfCMIELA7bhYlOeINyKA==
X-Received: by 2002:a05:600c:4f8a:b0:43d:412e:8a81 with SMTP id
 5b1f17b1804b1-43eb5cd2d2dmr1818555e9.28.1743547972119; 
 Tue, 01 Apr 2025 15:52:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:51 -0700 (PDT)
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
Subject: [PATCH 13/14] arm: dts: an7581: Add SNAND node
Date: Wed,  2 Apr 2025 00:51:45 +0200
Message-ID: <20250401225156.25790-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

