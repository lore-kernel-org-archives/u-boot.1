Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B77FF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E13A84301;
	Wed, 18 Mar 2026 00:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tjiNr46+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C81842A4; Wed, 18 Mar 2026 00:26:36 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FC184222
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-41708e43f61so2182846fac.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789991; x=1774394791;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RKVcanApSiya+9lo5t3FiHYI9zegXOdyGLSdpG66w1k=;
 b=tjiNr46+FIM95eWe6U4swIYic3u/DJo0hq6CK11iS1Gs5NsLY5PjynMulbKr1sH515
 liXCHewn/Y4Pugi7O9vWIbZx920BbNAVyP9LFiydODzWlLh+cP9yWYCXObkQOdY3gfHP
 8HCDWMz8F6w6+uUS6gyWxw745HB6/Srlxk2djFE1YIc9aMilbjK+Cjj6g8sLhr42kyMH
 Z7fnxchsx+IzhX/r8/FRZOlxIh19D4qHZoVPtSt2yegw+8Z7GjUmSgP+nRIbXzRdhIEM
 KLEoPp8ewm0cj+KvjUxmBkqf+zIKq0P8vSKDyCtr/Rdkeu2dcokIvyUPpBqAsWCbkMAF
 rZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789991; x=1774394791;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RKVcanApSiya+9lo5t3FiHYI9zegXOdyGLSdpG66w1k=;
 b=f946NveHi6Tun91gjzm09mKY8SOmfKjXfaMiyGYRzlVghFknUEZpJUNkJ9IeNp8tBl
 GxVw1QjtAn9s2SoB/6vwsfBXSr7y7NBbIMAsnsr3hEIHcVPQAMZLeQCHHb0wcmt90iwP
 jFmlXlxWu3CXwUkFCs62WUkhl9kHheaMUHGM0OsBJdTbRgv3AoXIYAH+5Ur/L7PedZCl
 xie5adyZTqqZxdCY7pA8h5T1VtJ3I4zdGJHGW6QnsrbBTjms8Rmit0E2EkHGb8Anxdpz
 Juy+cHu3vKciU7Egfics8dKuFOUcw2f8OSiQ4awJYfpYChdYTZs6tPdGWBF7Ym6zeK2F
 0/Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUjdH8obn3W0faiR+VKOpiL1qEvAYWyUc0jwaQYFTIDTaZl3GyVFD82Vz40B9qlw6ONKeG6rM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8IKtVpdNN1vg8nNsj0MQJarIDH5JH6v0t4s9hYKhe9HbF6suQ
 MntyGdNp4qGUGXVl0BTuVB2h3/vSEqY0Rimo+uVVySbthRbL1dTA4VrjALrvwkJyfW0=
X-Gm-Gg: ATEYQzzfNGHpW/7eRq1M5Q9yGT7Sm/EvmTmYHsGJWYg4WbFUIjVaaAz6NE9YsQ/YfD0
 7RfoNr4fuUKSwlnNQcYnblYSOjL10DNWNecPjlvO3co/q2k8VKhoZnL5n3ah4qBg82rc2ogDD2Z
 hP8g13w/Cyp4pdpl5PKWjFTqIMvzIhhLqXMHNY2WQsGF3WWb72bxIj2j6JgNJDm75IMzYmo93dE
 gjvIxig7jXDkQ7Ni/qoxKXBEzDut5dBus/PnP0j51cB/JayoBaXmYZftZKW+UhgggQh2bkL07dD
 FpsXs6QaTdpMT4Cg06n1+gcJKg5z5sCeVJJKG+6LGCayPky/eE/Xy4cipifzguOEZ8D93cGBVcZ
 FnbH92vLYPfBJWmfgLlrQXNMlfBml8tEM3EjLG7zWOntAavi6qMLM8M9XmpJetehRX84OijDQkl
 jEc/C0urdXA7Dd0O4py/cW56tI/Q==
X-Received: by 2002:a05:6870:a79b:b0:417:3cc0:8dc9 with SMTP id
 586e51a60fabf-41bd3fcf713mr758075fac.24.1773789991470; 
 Tue, 17 Mar 2026 16:26:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:18 -0500
Subject: [PATCH v3 05/16] clk: mediatek: mt7987: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-5-a4760f5b0a80@baylibre.com>
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OkaM4K95UTp0Y7R8ywCcA+NbWBSGWlfYNg6RoUaIej0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueLQ09Td/zWTMwFNw/WZJWw2x6+zsdTIRE5/w
 /2ZXu6HIOSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabni0BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjSEH+wQ/dx4V2GELAsJgMrcHTwNz/bdy0GCreKeynhO
 /VPG60VmauK/m9CLkn4EPUdOlbAfjI3/dlPBOFwLpQREl61coUoT4sgAwv/Kn7/13LEsIEUtvtG
 Z7/WIuv1PKsJERIPQ4uVUZmxr7MJC7vB7QCZwMDT0WAr6K4AWtI8vvlymUp9qRrEx3RX8M1/Jis
 qNNv4qygKMAqiWCzGo6TjMsKY624WcnisCXhXztDGalLpgb5xWvP6F+kVqIQJNa5emtWRNFQnn+
 dyC4R1us3n3FO18YVJVRsNjxTPH7rl0KS0dDsQUSBqBrc27G7Akl8JcfdqUoLD2WzSNOq97Kany
 nWV0=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7987.c | 71 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 641881fcb28..2f3e314b648 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -480,63 +480,63 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 /* INFRASYS MUX PARENTS */
 
 /* CLK_INFRA_MUX_UART0_SEL (infra_mux_uart0_sel) in infracfg */
-static const int infra_mux_uart0_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart0_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_UART1_SEL (infra_mux_uart1_sel) in infracfg */
-static const int infra_mux_uart1_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart1_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_UART2_SEL (infra_mux_uart2_sel) in infracfg */
-static const int infra_mux_uart2_parents[] = {
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_UART_SEL
+static const struct mtk_parent infra_mux_uart2_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI0_SEL (infra_mux_spi0_sel) in infracfg */
-static const int infra_mux_spi0_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPI_SEL
+static const struct mtk_parent infra_mux_spi0_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI1_SEL (infra_mux_spi1_sel) in infracfg */
-static const int infra_mux_spi1_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPIM_MST_SEL
+static const struct mtk_parent infra_mux_spi1_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPIM_MST_SEL),
 };
 
 /* CLK_INFRA_MUX_SPI2_BCK_SEL (infra_mux_spi2_bck_sel) in infracfg */
-static const int infra_mux_spi2_bck_parents[] = {
-	CLK_TOP_I2C_SEL,
-	CLK_TOP_SPI_SEL
+static const struct mtk_parent infra_mux_spi2_bck_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL),
 };
 
 /* CLK_INFRA_PWM_BCK_SEL (infra_pwm_bck_sel) in infracfg */
-static const int infra_pwm_bck_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_SYSAXI_SEL,
-	CLK_TOP_PWM_SEL
+static const struct mtk_parent infra_pwm_bck_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_SYSAXI_SEL),
+	TOP_PARENT(CLK_TOP_PWM_SEL),
 };
 
 /* CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL (infra_pcie_gfmux_tl_ck_o_p0_sel) in infracfg */
-static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_SEL),
 };
 
 /* CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL (infra_pcie_gfmux_tl_ck_o_p1_sel) in infracfg */
-static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
-	CLK_TOP_CB_RTC_32P7K,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_P1_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_P1_SEL),
 };
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
@@ -545,8 +545,9 @@ static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
 		.mux_clr_reg = (_reg) + 0x4, .mux_set_reg = (_reg) + 0x0,      \
 		.mux_shift = (_shift), .mux_mask = BIT(_width) - 1,            \
 		.gate_shift = -1, .upd_shift = -1,                             \
-		.parent = (_parents), .num_parents = ARRAY_SIZE(_parents),     \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_TOPCKGEN,             \
+		.parent_flags = (_parents),				       \
+		.num_parents = ARRAY_SIZE(_parents),			       \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
 	}
 
 /* INFRA MUX */

-- 
2.43.0

