Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F3C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 30 Dec 2023 12:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C4F87695;
	Sat, 30 Dec 2023 13:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fi6reRup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B35F877D0; Sat, 30 Dec 2023 12:21:12 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFB987695
 for <u-boot@lists.denx.de>; Sat, 30 Dec 2023 12:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arseney300@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e67e37661so7776753e87.0
 for <u-boot@lists.denx.de>; Sat, 30 Dec 2023 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703935268; x=1704540068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UPpawNr4ulDzPF1/EgtUkyPRSC2okYWe545ralvanA8=;
 b=Fi6reRupbKjWiWDEZn1cffeDuGa2fzmjgzmQzLOyV/vW+gcEYP9MN2P3N1PoM6XIvG
 uWFcOVkkugJjfrPuJWIPnrK2/I+S8mfPeGIxRJ2Febb5ZMZG4dOsTlDION5hW/JV/D1e
 dOPcxKSgJgHIKfpKz1SlaUvw8sbJhaXkTeyNfKxiz9YiZJQmaFZL8SpWlxxQYvGS3GDh
 FTpiGXiB662sPeKDZNBN1uM8GCWGpatS3lwrG74tIMA51Ve7/KJeT5y05PurRfVYq6wS
 0Nwn5BC7y2k9clUmduz4oz+LuUPnBhTJhAx8De7qfHrOpZEwLDp5t0kezlyd7D934/xH
 c5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703935268; x=1704540068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPpawNr4ulDzPF1/EgtUkyPRSC2okYWe545ralvanA8=;
 b=hTbJPF/cgFJ9imKXJzKp3XLfrwJPw5S60qtXWLSEvkwYS7uIZFXCfGrH/vwiSx3s6U
 RAZB3cX7k9xJvBSMtkpW94De8BqzbmGzj3DTJE1Aa+JooqJcM84N7QuJ/fxUAK2+oOSz
 q0hNHiUlg0C9ImV16gG+lFdVT8g4mR5A71ouB4EzRtCV/4YoHwVUZ+pUn70etO8J0VEI
 EV8forXE18+AIuRgmlm+Zsdg9b6GHy9gE5ydU8z51expvYMFkLLprTIwNrQV7mAnmnFl
 +oji9db3+qAhk41KqwYUnvGjMk950ShOLIjpc7myauLhnZydBPWZDpS161j4Kk+l72jr
 Ry6A==
X-Gm-Message-State: AOJu0Yz3dPxAw882QECxS5KyPJ4O1IUvIGi9PRkRnvOJTasCzmmkTfij
 DFCeyMQpW7LLWYL7QXrN+Ly1C8BGJeD9Vw==
X-Google-Smtp-Source: AGHT+IFUlLtBHvT3aGfiJsjWKG//LiRdXEqIXm7ouCq1cTpyM4N011Ypoe48ImiZSdAaqjGM55NQQg==
X-Received: by 2002:ac2:4d8a:0:b0:50e:69d6:c7b with SMTP id
 g10-20020ac24d8a000000b0050e69d60c7bmr4752887lfe.120.1703935268183; 
 Sat, 30 Dec 2023 03:21:08 -0800 (PST)
Received: from localhost.localdomain ([188.162.0.171])
 by smtp.gmail.com with ESMTPSA id
 dx13-20020a0565122c0d00b0050e86cda5a7sm1035920lfb.96.2023.12.30.03.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Dec 2023 03:21:07 -0800 (PST)
From: Arseniy Meshcheryakov <arseney300@gmail.com>
X-Google-Original-From: Arseniy Meshcheryakov <Arseney300@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com,
	Arseniy Meshcheryakov <Arseney300@gmail.com>
Subject: [PATCH] rockchip: rk3568: add support of all UART
Date: Sat, 30 Dec 2023 18:20:50 +0700
Message-Id: <20231230112050.90014-1-Arseney300@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 Dec 2023 13:46:33 +0100
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

This patch add support of all UARTs for rk3568, which can be used in console.

Signed-off-by: Arseniy Meshcheryakov <Arseney300@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 470 ++++++++++++++++++++++++-
 1 file changed, 452 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 69ef19cc85..f79b47ee5b 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -34,26 +34,468 @@
 #define CPU_GRF_BASE		0xfdc30000
 #define GRF_CORE_PVTPLL_CON0	(0x10)
 
-/* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
+	/* PMU_GRF_GPIO0C_IOMUX_L */
+	GPIO0C1_SHIFT		= 4,
+	GPIO0C1_MASK		= GENMASK(6, 4),
+	GPIO0C1_GPIO		= 0,
+	GPIO0C1_UART0_M0_TX	= 3,
+
+	GPIO0C0_SHIFT		= 0,
+	GPIO0C0_MASK		= GENMASK(2, 0),
+	GPIO0C0_GPIO		= 0,
+	GPIO0C0_UART0_M0_RX	= 3,
+
+	/* PMU_GRF_GPIO0D_IOMUX_L */
 	GPIO0D1_SHIFT		= 4,
 	GPIO0D1_MASK		= GENMASK(6, 4),
 	GPIO0D1_GPIO		= 0,
-	GPIO0D1_UART2_TXM0,
+	GPIO0D1_UART2_M0_TX,
 
 	GPIO0D0_SHIFT		= 0,
 	GPIO0D0_MASK		= GENMASK(2, 0),
 	GPIO0D0_GPIO		= 0,
-	GPIO0D0_UART2_RXM0,
-};
+	GPIO0D0_UART2_M0_RX,
+
+	/* GRF_GPIO1A_IOMUX_L */
+	GPIO1A1_SHIFT		= 4,
+	GPIO1A1_MASK		= GENMASK(6, 4),
+	GPIO1A1_GPIO		= 0,
+	GPIO1A1_UART3_M0_TX	= 2,
+
+	GPIO1A0_SHIFT		= 0,
+	GPIO1A0_MASK		= GENMASK(2, 0),
+	GPIO1A0_GPIO		= 0,
+	GPIO1A0_UART3_M0_RX	= 2,
+
+	/* GRF_GPIO1A_IOMUX_H */
+	GPIO1A6_SHIFT		= 8,
+	GPIO1A6_MASK		= GENMASK(10, 8),
+	GPIO1A6_GPIO		= 0,
+	GPIO1A6_UART4_M0_TX	= 2,
+
+
+	GPIO1A4_SHIFT		= 0,
+	GPIO1A4_MASK		= GENMASK(2, 0),
+	GPIO1A4_GPIO		= 0,
+	GPIO1A4_UART4_M0_RX	= 2,
+
+	/* GRF_GPIO1D_IOMUX_H */
+	GPIO1D6_SHIFT		= 8,
+	GPIO1D6_MASK		= GENMASK(10, 8),
+	GPIO1D6_GPIO		= 0,
+	GPIO1D6_UART2_M1_RX	= 2,
+	GPIO1D6_UART6_M1_RX,
+
+	GPIO1D5_SHIFT		= 4,
+	GPIO1D5_MASK		= GENMASK(6, 4),
+	GPIO1D5_GPIO		= 0,
+	GPIO1D5_UART2_M1_TX	= 2,
+	GPIO1D5_UART6_M1_TX,
+
+	/* GRF_GPIO2A_IOMUX_L */
+	GPIO2A3_SHIFT		= 12,
+	GPIO2A3_MASK		= GENMASK(14, 12),
+	GPIO2A3_GPIO		= 0,
+	GPIO2A3_UART6_M0_RX	= 3,
+
+	GPIO2A2_SHIFT		= 8,
+	GPIO2A2_MASK		= GENMASK(10, 8),
+	GPIO2A2_GPIO		= 0,
+	GPIO2A2_UART5_M0_TX	= 3,
+
+	GPIO2A1_SHIFT		= 4,
+	GPIO2A1_MASK		= GENMASK(6, 4),
+	GPIO2A1_GPIO		= 0,
+	GPIO2A1_UART5_M0_RX	= 3,
+
+	/* GRF_GPIO2A_IOMUX_H */
+	GPIO2A7_SHIFT		= 12,
+	GPIO2A7_MASK		= GENMASK(14, 12),
+	GPIO2A7_GPIO		= 0,
+	GPIO2A7_UART9_M0_RX	= 3,
+
+	GPIO2A6_SHIFT		= 8,
+	GPIO2A6_MASK		= GENMASK(10, 8),
+	GPIO2A6_GPIO		= 0,
+	GPIO2A6_UART7_M0_TX	= 3,
+
+	GPIO2A5_SHIFT		= 4,
+	GPIO2A5_MASK		= GENMASK(6, 4),
+	GPIO2A5_GPIO		= 0,
+	GPIO2A5_UART7_M0_RX	= 3,
+
+	GPIO2A4_SHIFT		= 0,
+	GPIO2A4_MASK		= GENMASK(2, 0),
+	GPIO2A4_GPIO		= 0,
+	GPIO2A4_UART6_M0_TX	= 3,
+
+	/* GRF_GPIO2B_IOMUX_L */
+	GPIO2B3_SHIFT		= 12,
+	GPIO2B3_MASK		= GENMASK(14, 12),
+	GPIO2B3_GPIO		= 0,
+	GPIO2B3_UART1_M0_RX	= 2,
+
+	GPIO2B0_SHIFT		= 0,
+	GPIO2B0_MASK		= GENMASK(2, 0),
+	GPIO2B0_GPIO		= 0,
+	GPIO2B0_UART9_M0_TX	= 3,
+
+	/* GRF_GPIO2B_IOMUX_H */
+	GPIO2B4_SHIFT		= 0,
+	GPIO2B4_MASK		= GENMASK(2, 0),
+	GPIO2B4_GPIO		= 0,
+	GPIO2B4_UART1_M0_TX	= 2,
+
+	/* GRF_GPIO2C_IOMUX_H */
+	GPIO2C6_SHIFT		= 8,
+	GPIO2C6_MASK		= GENMASK(10, 8),
+	GPIO2C6_GPIO		= 0,
+	GPIO2C6_UART8_M0_RX	= 2,
+
+	GPIO2C5_SHIFT		= 4,
+	GPIO2C5_MASK		= GENMASK(6, 4),
+	GPIO2C5_GPIO		= 0,
+	GPIO2C5_UART8_M0_TX	= 3,
+
+	/* GRF_GPIO2D_IOMUX_H */
+	GPIO2D7_SHIFT		= 12,
+	GPIO2D7_MASK		= GENMASK(14, 12),
+	GPIO2D7_GPIO		= 0,
+	GPIO2D7_UART8_M1_TX	= 4,
+
+	/* GRF_GPIO3A_IOMUX_L */
+	GPIO3A0_SHIFT		= 0,
+	GPIO3A0_MASK		= GENMASK(2, 0),
+	GPIO3A0_GPIO		= 0,
+	GPIO3A0_UART8_M1_RX	=4,
+
+	/* GRF_GPIO3B_IOMUX_L */
+	GPIO3B2_SHIFT		= 8,
+	GPIO3B2_MASK		= GENMASK(10, 8),
+	GPIO3B2_GPIO		= 0,
+	GPIO3B2_UART4_M1_TX	=4,
+
+	GPIO3B1_SHIFT		= 4,
+	GPIO3B1_MASK		= GENMASK(6, 4),
+	GPIO3B1_GPIO		= 0,
+	GPIO3B1_UART4_M1_RX	= 4,
+
+	/* GRF_GPIO3B_IOMUX_H */
+	GPIO3B7_SHIFT		= 12,
+	GPIO3B7_MASK		= GENMASK(14, 12),
+	GPIO3B7_GPIO		= 0,
+	GPIO3B7_UART3_M1_TX	= 4,
+
+	/* GRF_GPIO3C_IOMUX_L */
+	GPIO3C3_SHIFT		= 12,
+	GPIO3C3_MASK		= GENMASK(14, 12),
+	GPIO3C3_GPIO		= 0,
+	GPIO3C3_UART5_M1_RX	= 4,
+
+	GPIO3C2_SHIFT		= 8,
+	GPIO3C2_MASK		= GENMASK(10, 8),
+	GPIO3C2_GPIO		= 0,
+	GPIO3C2_UART5_M1_TX	= 4,
+
+	GPIO3C0_SHIFT		= 0,
+	GPIO3C0_MASK		= GENMASK(2, 0),
+	GPIO3C0_GPIO		= 0,
+	GPIO3C0_UART3_M1_RX	= 4,
+
+	/* GRF_GPIO3C_IOMUX_H */
+	GPIO3C5_SHIFT		= 4,
+	GPIO3C5_MASK		= GENMASK(6, 4),
+	GPIO3C5_GPIO		= 0,
+	GPIO3C5_UART7_M1_RX	=4 ,
+
+	GPIO3C4_SHIFT		= 0,
+	GPIO3C4_MASK		= GENMASK(2, 0),
+	GPIO3C4_GPIO		= 0,
+	GPIO3C4_UART7_M1_TX	= 4,
+
+	/* GRF_GPIO3D_IOMUX_H */
+	GPIO3D7_SHIFT		= 12,
+	GPIO3D7_MASK		= GENMASK(14, 12),
+	GPIO3D7_GPIO		= 0,
+	GPIO3D7_UART1_M1_RX	= 4,
+
+	GPIO3D6_SHIFT		= 8,
+	GPIO3D6_MASK		= GENMASK(10, 8),
+	GPIO3D6_GPIO		= 0,
+	GPIO3D6_UART1_M1_TX	= 4,
+
+	/* GRF_GPIO4A_IOMUX_L */
+	GPIO4A3_SHIFT		= 12,
+	GPIO4A3_MASK		= GENMASK(14, 12),
+	GPIO4A3_GPIO		= 0,
+	GPIO4A3_UART7_M2_RX	= 4,
+
+	GPIO4A2_SHIFT		= 8,
+	GPIO4A2_MASK		= GENMASK(10, 8),
+	GPIO4A2_GPIO		= 0,
+	GPIO4A2_UART7_M2_TX	= 4,
+
+	/* GRF_GPIO4A_IOMUX_H */
+	GPIO4A5_SHIFT		= 4,
+	GPIO4A5_MASK		= GENMASK(6, 4),
+	GPIO4A5_GPIO		= 0,
+	GPIO4A5_UART9_M2_RX	= 4,
+
+	GPIO4A4_SHIFT		= 0,
+	GPIO4A4_MASK		= GENMASK(2, 0),
+	GPIO4A4_GPIO		= 0,
+	GPIO4A4_UART9_M2_TX	= 4,
+
+	/* GRF_GPIO4C_IOMUX_H */
+	GPIO4C6_SHIFT		= 8,
+	GPIO4C6_MASK		= GENMASK(10, 8),
+	GPIO4C6_GPIO		= 0,
+	GPIO4C6_UART9_M1_RX	= 4,
+
+	GPIO4C5_SHIFT		= 4,
+	GPIO4C5_MASK		= GENMASK(6, 4),
+	GPIO4C5_GPIO		= 0,
+	GPIO4C5_UART9_M1_TX	= 4,
+
+	/* GRF_IOFUNC_SEL3 */
+	UART4_IO_SEL_SHIFT	= 14,
+	UART4_IO_SEL_MASK	= GENMASK(14, 14),
+	UART4_IO_SEL_M0		= 0,
+	UART4_IO_SEL_M1,
+
+	UART3_IO_SEL_SHIFT	= 12,
+	UART3_IO_SEL_MASK	= GENMASK(12, 12),
+	UART3_IO_SEL_M0		= 0,
+	UART3_IO_SEL_M1,
 
-/* GRF_IOFUNC_SEL3 */
-enum {
 	UART2_IO_SEL_SHIFT	= 10,
 	UART2_IO_SEL_MASK	= GENMASK(11, 10),
 	UART2_IO_SEL_M0		= 0,
+	UART2_IO_SEL_M1,
+
+	UART1_IO_SEL_SHIFT	= 8,
+	UART1_IO_SEL_MASK	= GENMASK(8, 8),
+	UART1_IO_SEL_M0		= 0,
+	UART1_IO_SEL_M1,
+
+	/* GRF_IOFUNC_SEL4 */
+	UART9_IO_SEL_SHIFT	= 8,
+	UART9_IO_SEL_MASK	= GENMASK(9, 8),
+	UART9_IO_SEL_M0		= 0,
+	UART9_IO_SEL_M1,
+	UART9_IO_SEL_M2,
+
+	UART8_IO_SEL_SHIFT	= 6,
+	UART8_IO_SEL_MASK	= GENMASK(6, 6),
+	UART8_IO_SEL_M0		= 0,
+	UART8_IO_SEL_M1,
+
+	UART7_IO_SEL_SHIFT	= 4,
+	UART7_IO_SEL_MASK	= GENMASK(5, 4),
+	UART7_IO_SEL_M0		= 0,
+	UART7_IO_SEL_M1,
+	UART7_IO_SEL_M2,
+
+	UART6_IO_SEL_SHIFT	= 2,
+	UART6_IO_SEL_MASK	= GENMASK(2, 2),
+	UART6_IO_SEL_M0		= 0,
+	UART6_IO_SEL_M1,
+
+	UART5_IO_SEL_SHIFT	= 0,
+	UART5_IO_SEL_MASK	= GENMASK(0, 0),
+	UART5_IO_SEL_M0		= 0,
+	UART5_IO_SEL_M1,
+
+	/* PMU_GRF_SOC_CON0 */
+	UART0_IO_SEL_SHIFT	= 8,
+	UART0_IO_SEL_MASK	= GENMASK(9, 8),
+	UART0_IO_SEL_M0		= 0,
+	UART0_IO_SEL_M1,
+	UART0_IO_SEL_M2,
 };
 
+
+#define GLUE2(a,b) a##b
+#define GLUE3(a,b,c) a##b##c
+#define GLUE4(a,b,c,d) a##b##c##d
+#define SELECT_UART(name, name_m) \
+      rk_clrsetreg(&GLUE4(name,_,name_m,_SEL_REGISTER), GLUE2(name,_IO_SEL_MASK), \
+         GLUE3(name,_IO_SEL_,name_m) << GLUE2(name,_IO_SEL_SHIFT));
+
+#define SWITCH_IOMUX_RX_GPIO(name, name_m) \
+    GLUE4(name,_,name_m,_RX_GPIO)
+
+#define SWITCH_IOMUX_TX_GPIO(name, name_m) \
+    GLUE4(name,_,name_m,_TX_GPIO)
+
+#define SWITCH_IOMUX_GPIO_UART_M(gpio, name, name_m) \
+  GLUE2(gpio,_##name##_##name_m)
+
+#define SWITCH_IOMUX_GPIO_UART_M_RX(gpio_uart_m) \
+  GLUE2(gpio_uart_m, _RX)
+
+#define SWITCH_IOMUX_GPIO_UART_M_TX(gpio_uart_m) \
+  GLUE2(gpio_uart_m, _TX)
+
+#define SWITCH_IOMUX_MASK(name) \
+    GLUE2(name, _MASK)
+
+#define SWITCH_IOMUX_SHIFT(name) \
+  GLUE2(name, _SHIFT)
+
+#define SWITCH_IOMUX_RX(name, name_m) \
+      rk_clrsetreg(&GLUE4(name,_,name_m,_RX_IOMUX_REGISTER), \
+         SWITCH_IOMUX_MASK(SWITCH_IOMUX_RX_GPIO(name, name_m)), \
+             SWITCH_IOMUX_GPIO_UART_M_RX(SWITCH_IOMUX_GPIO_UART_M(SWITCH_IOMUX_RX_GPIO(name, name_m), name, name_m)) \
+			  << SWITCH_IOMUX_SHIFT(SWITCH_IOMUX_RX_GPIO(name, name_m)));
+
+#define SWITCH_IOMUX_TX(name, name_m) \
+      rk_clrsetreg(&GLUE4(name,_,name_m,_RX_IOMUX_REGISTER), \
+         SWITCH_IOMUX_MASK(SWITCH_IOMUX_TX_GPIO(name, name_m)), \
+             SWITCH_IOMUX_GPIO_UART_M_TX(SWITCH_IOMUX_GPIO_UART_M(SWITCH_IOMUX_TX_GPIO(name, name_m), name, name_m)) \
+			 << SWITCH_IOMUX_SHIFT(SWITCH_IOMUX_TX_GPIO(name, name_m)));
+
+#define UART0_M0_RX_GPIO GPIO0C0
+#define UART0_M0_TX_GPIO GPIO0C1
+#define UART1_M0_RX_GPIO GPIO2B3
+#define UART1_M0_TX_GPIO GPIO2B4
+#define UART1_M1_RX_GPIO GPIO3D7
+#define UART1_M1_TX_GPIO GPIO3D6
+#define UART2_M0_RX_GPIO GPIO0D0
+#define UART2_M0_TX_GPIO GPIO0D1
+#define UART2_M1_RX_GPIO GPIO1D6
+#define UART2_M1_TX_GPIO GPIO1D5
+#define UART3_M0_RX_GPIO GPIO1A0
+#define UART3_M0_TX_GPIO GPIO1A1
+#define UART3_M1_RX_GPIO GPIO3C0
+#define UART3_M1_TX_GPIO GPIO3B7
+#define UART4_M0_RX_GPIO GPIO1A4
+#define UART4_M0_TX_GPIO GPIO1A6
+#define UART4_M1_RX_GPIO GPIO3B1
+#define UART4_M1_TX_GPIO GPIO3B2
+#define UART5_M0_RX_GPIO GPIO2A1
+#define UART5_M0_TX_GPIO GPIO2A2
+#define UART5_M1_RX_GPIO GPIO3C3
+#define UART5_M1_TX_GPIO GPIO3C2
+#define UART6_M0_RX_GPIO GPIO2A3
+#define UART6_M0_TX_GPIO GPIO2A4
+#define UART6_M1_RX_GPIO GPIO1D6
+#define UART6_M1_TX_GPIO GPIO1D5
+#define UART7_M0_RX_GPIO GPIO2A5
+#define UART7_M0_TX_GPIO GPIO2A6
+#define UART7_M1_RX_GPIO GPIO3C5
+#define UART7_M1_TX_GPIO GPIO3C4
+#define UART7_M2_RX_GPIO GPIO4A3
+#define UART7_M2_TX_GPIO GPIO4A2
+#define UART8_M0_RX_GPIO GPIO2C6
+#define UART8_M0_TX_GPIO GPIO2C5
+#define UART8_M1_RX_GPIO GPIO3A0
+#define UART8_M1_TX_GPIO GPIO2D7
+#define UART9_M0_RX_GPIO GPIO2A7
+#define UART9_M0_TX_GPIO GPIO2B0
+#define UART9_M1_RX_GPIO GPIO4C6
+#define UART9_M1_TX_GPIO GPIO4C5
+#define UART9_M2_RX_GPIO GPIO4A5
+#define UART9_M2_TX_GPIO GPIO4A4
+
+#define GRF_PTR ((struct rk3568_grf * const)(GRF_BASE))
+#define PMUGRF_PTR ((struct rk3568_pmugrf * const)(PMUGRF_BASE))
+
+#define UART0_M0_SEL_REGISTER PMUGRF_PTR->pmu_soc_con0
+#define UART1_M0_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART1_M1_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART2_M0_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART2_M1_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART3_M0_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART3_M1_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART4_M0_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART4_M1_SEL_REGISTER GRF_PTR->iofunc_sel3
+#define UART5_M0_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART5_M1_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART6_M0_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART6_M1_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART7_M0_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART7_M1_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART7_M2_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART8_M0_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART8_M1_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART9_M0_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART9_M1_SEL_REGISTER GRF_PTR->iofunc_sel4
+#define UART9_M2_SEL_REGISTER GRF_PTR->iofunc_sel4
+
+#define UART0_M0_RX_IOMUX_REGISTER PMUGRF_PTR->pmu_gpio0c_iomux_l
+#define UART0_M0_TX_IOMUX_REGISTER PMUGRF_PTR->pmu_gpio0c_iomux_l
+#define UART1_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2b_iomux_l
+#define UART1_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2b_iomux_h
+#define UART1_M1_RX_IOMUX_REGISTER GRF_PTR->gpio3d_iomux_h
+#define UART1_M1_TX_IOMUX_REGISTER GRF_PTR->gpio3d_iomux_h
+#define UART2_M0_RX_IOMUX_REGISTER PMUGRF_PTR->pmu_gpio0d_iomux_l
+#define UART2_M0_TX_IOMUX_REGISTER GRF_PTR->gpio0d_iomux_l
+#define UART2_M1_RX_IOMUX_REGISTER GRF_PTR->gpio1d_iomux_h
+#define UART2_M1_TX_IOMUX_REGISTER GRF_PTR->gpio1d_iomux_h
+#define UART3_M0_RX_IOMUX_REGISTER GRF_PTR->gpio1a_iomux_l
+#define UART3_M0_TX_IOMUX_REGISTER GRF_PTR->gpio1a_iomux_l
+#define UART3_M1_RX_IOMUX_REGISTER GRF_PTR->gpio3c_iomux_l
+#define UART3_M1_TX_IOMUX_REGISTER GRF_PTR->gpio3b_iomux_h
+#define UART4_M0_RX_IOMUX_REGISTER GRF_PTR->gpio1a_iomux_h
+#define UART4_M0_TX_IOMUX_REGISTER GRF_PTR->gpio1a_iomux_h
+#define UART4_M1_RX_IOMUX_REGISTER GRF_PTR->gpio3b_iomux_l
+#define UART4_M1_TX_IOMUX_REGISTER GRF_PTR->gpio3b_iomux_l
+#define UART5_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_l
+#define UART5_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_l
+#define UART5_M1_RX_IOMUX_REGISTER GRF_PTR->gpio3c_iomux_l
+#define UART5_M1_TX_IOMUX_REGISTER GRF_PTR->gpio3c_iomux_l
+#define UART6_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_l
+#define UART6_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_h
+#define UART6_M1_RX_IOMUX_REGISTER GRF_PTR->gpio1d_iomux_h
+#define UART6_M1_TX_IOMUX_REGISTER GRF_PTR->gpio1d_iomux_h
+#define UART7_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_h
+#define UART7_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_h
+#define UART7_M1_RX_IOMUX_REGISTER GRF_PTR->gpio3c_iomux_h
+#define UART7_M1_TX_IOMUX_REGISTER GRF_PTR->gpio3c_iomux_h
+#define UART7_M2_RX_IOMUX_REGISTER GRF_PTR->gpio4a_iomux_l
+#define UART7_M2_TX_IOMUX_REGISTER GRF_PTR->gpio4a_iomux_l
+#define UART8_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2c_iomux_h
+#define UART8_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2c_iomux_h
+#define UART8_M1_RX_IOMUX_REGISTER GRF_PTR->gpio2d_iomux_h
+#define UART8_M1_TX_IOMUX_REGISTER GRF_PTR->gpio2d_iomux_h
+#define UART9_M0_RX_IOMUX_REGISTER GRF_PTR->gpio2a_iomux_h
+#define UART9_M0_TX_IOMUX_REGISTER GRF_PTR->gpio2b_iomux_l
+#define UART9_M1_RX_IOMUX_REGISTER GRF_PTR->gpio4c_iomux_h
+#define UART9_M1_TX_IOMUX_REGISTER GRF_PTR->gpio4c_iomux_h
+#define UART9_M2_RX_IOMUX_REGISTER GRF_PTR->gpio4a_iomux_h
+#define UART9_M2_TX_IOMUX_REGISTER GRF_PTR->gpio4a_iomux_h
+
+#if defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfdd50000)
+#define UART UART0
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe650000)
+#define UART UART1
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe660000)
+#define UART UART2
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe670000)
+#define UART UART3
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe680000)
+#define UART UART4
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe690000)
+#define UART UART5
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe6a0000)
+#define UART UART6
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe6b0000)
+#define UART UART7
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe6c0000)
+#define UART UART8
+#elif defined(CONFIG_DEBUG_UART_BASE) && (CONFIG_DEBUG_UART_BASE == 0xfe6d0000)
+#define UART UART9
+#endif
+#if defined(CONFIG_ROCKCHIP_UART_MUX_SEL_M) && (CONFIG_ROCKCHIP_UART_MUX_SEL_M == 2)
+#define UART_M M2
+#elif defined(CONFIG_ROCKCHIP_UART_MUX_SEL_M) && (CONFIG_ROCKCHIP_UART_MUX_SEL_M == 1)
+#define UART_M M1
+#else
+#define UART_M M0
+#endif
+
 static struct mm_region rk3568_mem_map[] = {
 	{
 		.virt = 0x0UL,
@@ -91,18 +533,10 @@ struct mm_region *mem_map = rk3568_mem_map;
 
 void board_debug_uart_init(void)
 {
-	static struct rk3568_pmugrf * const pmugrf = (void *)PMUGRF_BASE;
-	static struct rk3568_grf * const grf = (void *)GRF_BASE;
-
-	/* UART2 M0 */
-	rk_clrsetreg(&grf->iofunc_sel3, UART2_IO_SEL_MASK,
-		     UART2_IO_SEL_M0 << UART2_IO_SEL_SHIFT);
-
-	/* Switch iomux */
-	rk_clrsetreg(&pmugrf->pmu_gpio0d_iomux_l,
-		     GPIO0D1_MASK | GPIO0D0_MASK,
-		     GPIO0D1_UART2_TXM0 << GPIO0D1_SHIFT |
-		     GPIO0D0_UART2_RXM0 << GPIO0D0_SHIFT);
+	SELECT_UART(UART, UART_M);
+
+	SWITCH_IOMUX_RX(UART, UART_M);
+	SWITCH_IOMUX_TX(UART, UART_M);
 }
 
 int arch_cpu_init(void)
-- 
2.39.2

