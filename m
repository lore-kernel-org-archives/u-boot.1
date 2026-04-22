Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE93F9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916B3841F2;
	Wed, 22 Apr 2026 16:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NF5D8VId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEE9842E6; Wed, 22 Apr 2026 16:31:47 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2224F84324
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbd23bc684so3172555a34.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868299; x=1777473099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiMCHDNSaVY1pWYwMwgilc+Iec389Bar8qB956M5X4I=;
 b=NF5D8VIdou1UKmcjnYfDWNxibfEFUbxOTOjkxbuUtPyRiMfvii2S7ZCeYssFAxNgLo
 sLf5SANVUTVNED5cS70BHfvuXUAzVbWQUQspWaPVpfHZDt2c6sPAiJHfhkPBMU04/SUT
 ycO1sqoPDvsJVb/6pjjI4U/7ab1mZNCbBKUtzuNHArzO5ovyE3RLNRio8odgynCcbbnm
 53IC767cHfkg1fX5D1aeiin28NuqsjCKIUtlpuJZgattEIakWNGci9X+7WCSoHMtUNn4
 sQqg+Trrpk5qzXGZtO1QqrYDWgCp5wosl9VznP9rmGOUTg+8fNB167NK4yCu839P+wuH
 jGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868299; x=1777473099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YiMCHDNSaVY1pWYwMwgilc+Iec389Bar8qB956M5X4I=;
 b=bLMGEAWYK1RHH6nuv7Or1eCSKEkz0qxlj3wYpyRYXSWTtswnbz7kihtA+XtG5ff2e4
 6S4eXdLg7H6TX8CXWjHaFJ4d7uSv03h+Rin6y3pWBawi9RIy00uFXwnsrSO5SpnEavPg
 v7JGjMWbXYiNI+z4zfqs/p7TDl17TFUXMfdhV18Dg3LyDr+tSflIpy0PTPfmVpxex6Dq
 2DFlQB2BvhkY1i0HIVY9S7ALgFLnov/dcMHDNaGV3mn4B8PrqoMvWCpMLLzAYcYqKIVi
 VMbVHoWIbjGpS3ICvEpILe1+Td9xy/8PnFNlxHGl+dx/vU4DFq8O68yKjST1rEbrdvzu
 HyCA==
X-Gm-Message-State: AOJu0Yz6hav6NlDG4ryWxyXEABH93WjJRNBjDGB0gh3FTH8o7zKj4+y+
 Kt91RWiGt6YJEmP6GJVo3y/xBujeMPQ2FJILRnWTMPE7JcVBvFArlXjZusOWO9PNTys=
X-Gm-Gg: AeBDietjYbsRSRGCfIwCE1KGnCOGqM3sYOBtAqjgYlouvGcFYNbAPfcRldydc3mOfaZ
 /G2z7CTO5Wns5JmLA+pBv5e+WJS6ss73yObF2UlF+UDsZP+fDaXTuPzppv7fYFVZqdOA5ekbnoc
 XtiebDW7f1OApbrLQBde/+hYFhO3w9gQE8gY+ZRvmnksPDNjdgU4SrV27HdJhoD+WTGVPo9X0jw
 Ot3GFMS9d2b11kVhTcSboEkbp+b+95QiLoIRQb6vwIQCgz1MFKWrpcBaScYmjgVtqdT309VMDc/
 ohidNaST4SeVGCJSNklArMID6gABG7i3pRxeRG1Km9A/BVUkxSlDRhhzBb/qnD5iuhemvwTHchz
 ZpjZ762KIq8A5iOQkaXhdFFqL6kCp5yqaY9dNLaNvwNn/xhrDfN15sRvExM9xyMeGrbsCnNP9iv
 0YC1YpaGbHsk/qzVGGD43gEPUBQYMsv3Kgyyrp30wQC2fIfVPT71lYRWN6QQ8bpTzG3Q1xlJhEw
 hN2Cch+gEW91F2rV3rvLA==
X-Received: by 2002:a05:6820:c018:b0:686:d107:2859 with SMTP id
 006d021491bc7-69462e649e8mr7738601eaf.23.1776868299528; 
 Wed, 22 Apr 2026 07:31:39 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:37 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream folder
Date: Wed, 22 Apr 2026 10:31:00 -0400
Message-Id: <20260422143112.1329478-5-raymondmaoca@gmail.com>
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

Import k1-pinctrl.dtsi from upstream folder.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1-pinctrl.dtsi | 66 ++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1-pinctrl.dtsi
index 14e7096fbcf..aff19c86d5f 100644
--- a/arch/riscv/dts/k1-pinctrl.dtsi
+++ b/arch/riscv/dts/k1-pinctrl.dtsi
@@ -1,12 +1,64 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright (C) 2022 Spacemit Inc.
- * Copyright (C) 2025 Yixun Lan <dlan@gentoo.org>
+ * Copyright (c) 2024 Yixun Lan <dlan@gentoo.org>
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 #define K1_PADCONF(pin, func) (((pin) << 16) | (func))
 
+/* Map GPIO pin to each bank's <index, offset> */
+#define K1_GPIO(x)	(x / 32) (x % 32)
+
 &pinctrl {
+	gmac0_cfg: gmac0-cfg {
+		gmac0-pins {
+			pinmux = <K1_PADCONF(0, 1)>,	/* gmac0_rxdv */
+				 <K1_PADCONF(1, 1)>,	/* gmac0_rx_d0 */
+				 <K1_PADCONF(2, 1)>,	/* gmac0_rx_d1 */
+				 <K1_PADCONF(3, 1)>,	/* gmac0_rx_clk */
+				 <K1_PADCONF(4, 1)>,	/* gmac0_rx_d2 */
+				 <K1_PADCONF(5, 1)>,	/* gmac0_rx_d3 */
+				 <K1_PADCONF(6, 1)>,	/* gmac0_tx_d0 */
+				 <K1_PADCONF(7, 1)>,	/* gmac0_tx_d1 */
+				 <K1_PADCONF(8, 1)>,	/* gmac0_tx */
+				 <K1_PADCONF(9, 1)>,	/* gmac0_tx_d2 */
+				 <K1_PADCONF(10, 1)>,	/* gmac0_tx_d3 */
+				 <K1_PADCONF(11, 1)>,	/* gmac0_tx_en */
+				 <K1_PADCONF(12, 1)>,	/* gmac0_mdc */
+				 <K1_PADCONF(13, 1)>,	/* gmac0_mdio */
+				 <K1_PADCONF(14, 1)>,	/* gmac0_int_n */
+				 <K1_PADCONF(45, 1)>;	/* gmac0_clk_ref */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
+	gmac1_cfg: gmac1-cfg {
+		gmac1-pins {
+			pinmux = <K1_PADCONF(29, 1)>,	/* gmac1_rxdv */
+				 <K1_PADCONF(30, 1)>,	/* gmac1_rx_d0 */
+				 <K1_PADCONF(31, 1)>,	/* gmac1_rx_d1 */
+				 <K1_PADCONF(32, 1)>,	/* gmac1_rx_clk */
+				 <K1_PADCONF(33, 1)>,	/* gmac1_rx_d2 */
+				 <K1_PADCONF(34, 1)>,	/* gmac1_rx_d3 */
+				 <K1_PADCONF(35, 1)>,	/* gmac1_tx_d0 */
+				 <K1_PADCONF(36, 1)>,	/* gmac1_tx_d1 */
+				 <K1_PADCONF(37, 1)>,	/* gmac1_tx */
+				 <K1_PADCONF(38, 1)>,	/* gmac1_tx_d2 */
+				 <K1_PADCONF(39, 1)>,	/* gmac1_tx_d3 */
+				 <K1_PADCONF(40, 1)>,	/* gmac1_tx_en */
+				 <K1_PADCONF(41, 1)>,	/* gmac1_mdc */
+				 <K1_PADCONF(42, 1)>,	/* gmac1_mdio */
+				 <K1_PADCONF(43, 1)>,	/* gmac1_int_n */
+				 <K1_PADCONF(46, 1)>;	/* gmac1_clk_ref */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
 			pinmux = <K1_PADCONF(68, 2)>,
@@ -16,4 +68,12 @@
 			drive-strength = <32>;
 		};
 	};
+
+	pwm14_1_cfg: pwm14-1-cfg {
+		pwm14-1-pins {
+			pinmux = <K1_PADCONF(44, 4)>;
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
 };
-- 
2.25.1

