Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EBEF9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9168A84355;
	Wed, 22 Apr 2026 16:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NC4cLgRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAAF842EF; Wed, 22 Apr 2026 16:31:52 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDDC984359
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso56170521cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868303; x=1777473103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpxaU06EDeZej6KnHjwoygi8KQn5j5oVXZh2NKzs5+M=;
 b=NC4cLgRAURml1tNwtKbmSgBX8NpXccB8bpg73Jx1dP+nutb58AopBMpf8mPP5fFiMX
 MblLzG0tsi7QT4GeWZtRna0tnU3r5lysyZmCw6qUi+U/BnZSkqR3kbno9fvWGEz2Qfya
 IQDJ7vgukYMb1GTFa0N194XzNIlIQeTcV322tJdYEYdeYgjB2r1yiilHjd2jI5sMxDJ7
 9dEbmATGlsqwVhXRjby6MRW8jztcqc5RTo0GPgj7RN2E+8kdmo0DERdepBawkUZK0jPi
 YJDoz/5Mtc4RAeujt5zS1UUVVpUwWZ56D0z0Jbe2Xlz7Z1umhZ1ob6fpq563C9r8t/nT
 9yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868303; x=1777473103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpxaU06EDeZej6KnHjwoygi8KQn5j5oVXZh2NKzs5+M=;
 b=GYNTwSaMcnKCDGcJ2mkhNU91I3xB3q8kcjsO+bfPYgFqB9boiklKmJQX7a/cJcX8rQ
 MEpHv/g3pB7yZT5Nt0XZipyAKdwbaIVk2ZXNpFdqMTUwv/UY47ZjQh6aucFYMUDQYd/F
 mYTIEnOJl8UxvEKiJ1S8LDnMd/CkcZvr5VegqVi/lnzCOQ+OSZu0MHet7xI/Gzxg18nx
 LUc/ffdOyVrI7B0APWsvAGLO1nXrdzE75hs43YIYUKDU8hoaLButTViVKtbUqDuZFqZz
 3U1XFrkhF1T1nT/oEGKdhzigLW73qBj32JkzeBZp/S/+ru0hN5I1LhUADrq0+6yGDGYG
 OSFA==
X-Gm-Message-State: AOJu0Ywb2TIaJQ8EIRQKTF4IXIkgEeEYm33bN6wi5N0PWS+qYPCGP9IF
 6ZgjqG8KuAxX978Vd4EoW1mmVcCsOlrvRWSrcRDJ0BwQXXV+SkbFCX2XgPXBSspLDks=
X-Gm-Gg: AeBDieu0IRMugfTBxnJlcUu1E65pDh8O3HEygVvgIXi08o4KfmcS+y6ed1/3kNg72sp
 mufesAq+1mTZfVqGItcLC6fWkDH74bkMA/gDKkGGXuGV0kafGzf5K66ZI8Kw/cCLn9+b+MoVbOK
 HRetJX1yRVfrTOmCVc3rAtF6ProqyyPokGA4CACPMMcesBHHpFsiUTxs8PBFEi0z5HUuwuTg8vq
 PHeNNIU8OCmFDE4598ml0MOGxBR9/Oe0sAVtkUAR1nDNRylYew/8LjDyImzfWvJrQHJ5shhqz0q
 lhw/vzUehMxj85OMN2H4sb707b9EbzohG7U1HIexEgsYnwJqqSYsZGQ509/5ZLEkO+XmZ80PXfK
 GYcepdE2XT4V5aiUV3hmQ4DRRVKZnPSMw34IT2il1OL2hKvYQsBMiJUX5sJ7S0HbJMCARL2eRfI
 vAgw/Dr+ldkYv9Vy/Btue9vnNVJe5U3Qjg/m6a32cxhNEHHr7FLeJsO6kJMfCEprPiJmNGz7p5K
 IF0sH+ZSg9vEsWIdBeFcmRUTH6JRF6v
X-Received: by 2002:ac8:5a93:0:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-50e3667611bmr282423081cf.12.1776868302808; 
 Wed, 22 Apr 2026 07:31:42 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:41 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 05/16] dts: k1: remove embedded subnode in pin configs
Date: Wed, 22 Apr 2026 10:31:01 -0400
Message-Id: <20260422143112.1329478-6-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Fix the embedded subnode that is defined in pin configs.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1-pinctrl.dtsi | 102 ++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1-pinctrl.dtsi
index aff19c86d5f..2e4216f94d0 100644
--- a/arch/riscv/dts/k1-pinctrl.dtsi
+++ b/arch/riscv/dts/k1-pinctrl.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (c) 2024 Yixun Lan <dlan@gentoo.org>
+ * Copyright (c) 2025-2026 RISCstar Ltd.
  */
 
 #include <dt-bindings/gpio/gpio.h>
@@ -12,68 +13,67 @@
 
 &pinctrl {
 	gmac0_cfg: gmac0-cfg {
-		gmac0-pins {
-			pinmux = <K1_PADCONF(0, 1)>,	/* gmac0_rxdv */
-				 <K1_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
-				 <K1_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
-				 <K1_PADCONF(3, 1)>,	/* gmac0_rx_clk */
-				 <K1_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
-				 <K1_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
-				 <K1_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
-				 <K1_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
-				 <K1_PADCONF(8, 1)>,	/* gmac0_tx */
-				 <K1_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
-				 <K1_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
-				 <K1_PADCONF(11, 1)>,	/* gmac0_tx_en */
-				 <K1_PADCONF(12, 1)>,	/* gmac0_mdc */
-				 <K1_PADCONF(13, 1)>,	/* gmac0_mdio */
-				 <K1_PADCONF(14, 1)>,	/* gmac0_int_n */
-				 <K1_PADCONF(45, 1)>;	/* gmac0_clk_ref */
+		pinmux = <K1_PADCONF(0, 1)>,	/* gmac0_rxdv */
+			 <K1_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
+			 <K1_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
+			 <K1_PADCONF(3, 1)>,	/* gmac0_rx_clk */
+			 <K1_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
+			 <K1_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
+			 <K1_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
+			 <K1_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
+			 <K1_PADCONF(8, 1)>,	/* gmac0_tx */
+			 <K1_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
+			 <K1_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
+			 <K1_PADCONF(11, 1)>,	/* gmac0_tx_en */
+			 <K1_PADCONF(12, 1)>,	/* gmac0_mdc */
+			 <K1_PADCONF(13, 1)>,	/* gmac0_mdio */
+			 <K1_PADCONF(14, 1)>,	/* gmac0_int_n */
+			 <K1_PADCONF(45, 1)>;	/* gmac0_clk_ref */
 
-			bias-pull-up = <0>;
-			drive-strength = <21>;
-		};
+		bias-pull-up = <0>;
+		drive-strength = <21>;
 	};
 
 	gmac1_cfg: gmac1-cfg {
-		gmac1-pins {
-			pinmux = <K1_PADCONF(29, 1)>,	/* gmac1_rxdv */
-				 <K1_PADCONF(30, 1)>,	/* gmac1_rx_d0 */
-				 <K1_PADCONF(31, 1)>,	/* gmac1_rx_d1 */
-				 <K1_PADCONF(32, 1)>,	/* gmac1_rx_clk */
-				 <K1_PADCONF(33, 1)>,	/* gmac1_rx_d2 */
-				 <K1_PADCONF(34, 1)>,	/* gmac1_rx_d3 */
-				 <K1_PADCONF(35, 1)>,	/* gmac1_tx_d0 */
-				 <K1_PADCONF(36, 1)>,	/* gmac1_tx_d1 */
-				 <K1_PADCONF(37, 1)>,	/* gmac1_tx */
-				 <K1_PADCONF(38, 1)>,	/* gmac1_tx_d2 */
-				 <K1_PADCONF(39, 1)>,	/* gmac1_tx_d3 */
-				 <K1_PADCONF(40, 1)>,	/* gmac1_tx_en */
-				 <K1_PADCONF(41, 1)>,	/* gmac1_mdc */
-				 <K1_PADCONF(42, 1)>,	/* gmac1_mdio */
-				 <K1_PADCONF(43, 1)>,	/* gmac1_int_n */
-				 <K1_PADCONF(46, 1)>;	/* gmac1_clk_ref */
+		pinmux = <K1_PADCONF(29, 1)>,	/* gmac1_rxdv */
+			 <K1_PADCONF(30, 1)>,	/* gmac1_rx_d0 */
+			 <K1_PADCONF(31, 1)>,	/* gmac1_rx_d1 */
+			 <K1_PADCONF(32, 1)>,	/* gmac1_rx_clk */
+			 <K1_PADCONF(33, 1)>,	/* gmac1_rx_d2 */
+			 <K1_PADCONF(34, 1)>,	/* gmac1_rx_d3 */
+			 <K1_PADCONF(35, 1)>,	/* gmac1_tx_d0 */
+			 <K1_PADCONF(36, 1)>,	/* gmac1_tx_d1 */
+			 <K1_PADCONF(37, 1)>,	/* gmac1_tx */
+			 <K1_PADCONF(38, 1)>,	/* gmac1_tx_d2 */
+			 <K1_PADCONF(39, 1)>,	/* gmac1_tx_d3 */
+			 <K1_PADCONF(40, 1)>,	/* gmac1_tx_en */
+			 <K1_PADCONF(41, 1)>,	/* gmac1_mdc */
+			 <K1_PADCONF(42, 1)>,	/* gmac1_mdio */
+			 <K1_PADCONF(43, 1)>,	/* gmac1_int_n */
+			 <K1_PADCONF(46, 1)>;	/* gmac1_clk_ref */
 
-			bias-pull-up = <0>;
-			drive-strength = <21>;
-		};
+		bias-pull-up = <0>;
+		drive-strength = <21>;
 	};
 
 	uart0_2_cfg: uart0-2-cfg {
-		uart0-2-pins {
-			pinmux = <K1_PADCONF(68, 2)>,
-				 <K1_PADCONF(69, 2)>;
+		pinmux = <K1_PADCONF(68, 2)>,
+			 <K1_PADCONF(69, 2)>;
 
-			bias-pull-up = <0>;
-			drive-strength = <32>;
-		};
+		bias-pull-up = <0>;
+		drive-strength = <32>;
+		bootph-pre-ram;
+	};
+
+	i2c2_0_cfg: i2c2-0-cfg {
+		pinmux = <K1_PADCONF(84, 4)>,	/* I2C2_SCL */
+			 <K1_PADCONF(85, 4)>;	/* I2C2_SDA */
+		bootph-pre-ram;
 	};
 
 	pwm14_1_cfg: pwm14-1-cfg {
-		pwm14-1-pins {
-			pinmux = <K1_PADCONF(44, 4)>;
-			bias-pull-up = <0>;
-			drive-strength = <32>;
-		};
+		pinmux = <K1_PADCONF(44, 4)>;
+		bias-pull-up = <0>;
+		drive-strength = <32>;
 	};
 };
-- 
2.25.1

