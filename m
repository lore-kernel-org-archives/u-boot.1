Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5214EB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4D083F2D;
	Tue,  3 Mar 2026 01:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zyD541Lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264B58063E; Tue,  3 Mar 2026 01:05:13 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259FE83F69
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so183390fac.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496305; x=1773101105;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9lxow2MNoKT9mCLg/rVAKRslVJICLLA3Kzje+C1a+JM=;
 b=zyD541LokVFirRYf0kgETv6dn44uSzAJOyvfrClnAL4DlXscZocytcFzpBWAzfK3F0
 ktk6TpMhYpaDJBhyeATG05OYtZMQqYefkRZGZAKKFH5nHN3yYTYXznM2nRirgieD8U09
 gqPzyz+Brr43xwUdHG9UmL6lyMs/xNOuBsf27GIz4lGalE1FfbvCNeaEeTXtbhY8Q8Tm
 I2QKVgfF6dFL2tuCeBLf8CbPNPaT6yUFt/MFddnuoiEAU99Dnm3SVlzf5Q4T+jZcggvG
 vw6N+HwC2Xf8wDlMS3ONXuZ7OOfEjcoLkwpG+yP+cvLlIkl61uVIHGsXt041keOWO6VN
 m6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496305; x=1773101105;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9lxow2MNoKT9mCLg/rVAKRslVJICLLA3Kzje+C1a+JM=;
 b=ZdBU/VcMR9HSUIMJThAnniwdkD9WLJ0dfMq1E9O7kRHWwPzOb2k+W0Ql4s9BGQRbx4
 9ed/ckAub5yvF25IT2QHU3cDvHR5fhNkpPO4KxsYqJPnA14ompERHa7zX18lvaXi3GkO
 Ll5S4k71jey1yE1+EIxIz8ZlZAKL5QO5baRmB2sLdX/p35T2iO3d9Wi6naEMBVxi+bHY
 ykV8vdLt/d0/v1+YICqhbY9m7+5anIVTvryv6wax1LfyVVzosEQqyIrri9YjJeCOMyt2
 a6ZkjTqhJB2T3yqbxvwCUbQpOiErg2oZ4mfpy9SVzIr0RPdXKEglDM3KZl5xX4ejRfVb
 DRiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFyLWyc7SQVSenfw0ICI5lAqSfLla6XygJ0Pmufk6LpIFiucsS9oRFsjGfFxb493m0MxFXoh0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Wo6AIRwbI6xv7IyVqf1pRAKWFZZkHtvSxxrkyrk7RHGVojAQ
 4dsir3evw0kscX/Sv7mXhLZ9jbJS5KQN3YNjnRaOiMTBGGdNB6mF2acX+zsL26xJ86VxkYzbCkM
 giIfq
X-Gm-Gg: ATEYQzxxtBcufFUkYaE9xpUo7L4oXT86yUDaqs2zPTKY+MpblEL17/IYT2cTeN6N+8X
 FhKhVVx44UXhjDlYmp7bNywRBB5gRrAsYdYr6GEgJxXzdW+tpfj9OfoUG76BDdPlIyDw3bFiJ5M
 UCladCJAF1HN4eF/tc3a2QPNlefymhZexY8v2dRIJ1MDb2Hp7IlobypaoJizDUOifKZfT/ryGBs
 fQqKDP4D7UPqy9GvnZHom+wRWde2OG3nGns3G/0c7l085WVwXFC+4Wrl1A6JFA1fNclMT9Ji3Y2
 0x3xXTs8/Ix4pm4W+CPvlz1uXecj/Qny7+HKkREUeCYgGOf0t2uZapzSr19h7XJNGUIiiZbH0w3
 qxavyDPOLBgA+g0Z+sS/Ld3T1yGpywytXW3TEKML3GBYJYB4RPH9NNJjeuP/+yrySFh1e8wejBP
 IVbmcu+Ejmw/XI8X2lP3L2Jfbnur6a
X-Received: by 2002:a05:6870:6121:b0:3ff:4bcd:cc37 with SMTP id
 586e51a60fabf-41626f9b095mr9602014fac.30.1772496305380; 
 Mon, 02 Mar 2026 16:05:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:14 -0600
Subject: [PATCH 05/14] clk: mediatek: mt7988: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-5-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=l5z7LZ7MnYTTtxkfd9H41tFlsZR4sCXCaKI4AeODhU4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVqk3ByHGqaRi+1ex/CKflWP2+F8qTPgvhoH
 1CP6ukRE9OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlahYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AC/4H/1OqxjJZL+F/Zzo4dfube1NvpC86Vxn1Y+oczW0
 ByZZ0k833BG/vrCqvIIyRYL0F0A3NkIBhPHxlmvYlwb+uhpNnbAqNuNjJ7D2IWQXeTBnNXUkk/o
 34hHQFbEEUMBZHf4d/Xui0YYuFLjE/7O/LmsZJe0SJJzvHK2G7bWuPEXO9dL9bCBsngapFIOftE
 HQ4j3k1uErhB7AHGq0dCfrQtgrf2ZDVHwGDl69bSVd269GGXJyd8tFVJoYgO489fEbxZW6aw9yS
 3f5QTiap8gnLB1sk0OQso5U/HrCWx6jGsNY0DVGP58ue3C/2RjIgklUGzfyRRAHnofvzFQrxvla
 Xsb0=
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
 drivers/clk/mediatek/clk-mt7988.c | 74 ++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 55a4ec858df..eba278d8e26 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -442,51 +442,75 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
 };
 
 /* INFRASYS MUX PARENTS */
-static const int infra_mux_uart0_parents[] = { CLK_TOP_INFRA_F26M_SEL,
-					       CLK_TOP_UART_SEL };
+static const struct mtk_parent infra_mux_uart0_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
+};
 
-static const int infra_mux_uart1_parents[] = { CLK_TOP_INFRA_F26M_SEL,
-					       CLK_TOP_UART_SEL };
+static const struct mtk_parent infra_mux_uart1_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
+};
 
-static const int infra_mux_uart2_parents[] = { CLK_TOP_INFRA_F26M_SEL,
-					       CLK_TOP_UART_SEL };
+static const struct mtk_parent infra_mux_uart2_parents[] = {
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_UART_SEL),
+};
 
-static const int infra_mux_spi0_parents[] = { CLK_TOP_I2C_SEL, CLK_TOP_SPI_SEL };
+static const struct mtk_parent infra_mux_spi0_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPI_SEL),
+};
 
-static const int infra_mux_spi1_parents[] = { CLK_TOP_I2C_SEL, CLK_TOP_SPIM_MST_SEL };
+static const struct mtk_parent infra_mux_spi1_parents[] = {
+	TOP_PARENT(CLK_TOP_I2C_SEL),
+	TOP_PARENT(CLK_TOP_SPIM_MST_SEL),
+};
 
-static const int infra_pwm_bck_parents[] = { CLK_TOP_RTC_32P7K,
-					     CLK_TOP_INFRA_F26M_SEL, CLK_TOP_SYSAXI_SEL,
-					     CLK_TOP_PWM_SEL };
+static const struct mtk_parent infra_pwm_bck_parents[] = {
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_SYSAXI_SEL),
+	TOP_PARENT(CLK_TOP_PWM_SEL),
+};
 
-static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
-	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p0_parents[] = {
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_SEL),
 };
 
-static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
-	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_P1_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_P1_SEL),
 };
 
-static const int infra_pcie_gfmux_tl_ck_o_p2_parents[] = {
-	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_P2_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p2_parents[] = {
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_P2_SEL),
 };
 
-static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
-	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
-	CLK_TOP_PEXTP_TL_P3_SEL
+static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
+	TOP_PARENT(CLK_TOP_RTC_32P7K),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_INFRA_F26M_SEL),
+	TOP_PARENT(CLK_TOP_PEXTP_TL_P3_SEL),
 };
 
 #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)                  \
 	{                                                                      \
 		.id = _id, .mux_reg = _reg + 0x8, .mux_set_reg = _reg + 0x0,   \
 		.mux_clr_reg = _reg + 0x4, .mux_shift = _shift,                \
-		.mux_mask = BIT(_width) - 1, .parent = _parents,               \
+		.mux_mask = BIT(_width) - 1,				       \
+		.parent_flags = _parents,				       \
 		.gate_shift = -1, .upd_shift = -1,			       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_TOPCKGEN,             \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
 	}
 
 /* INFRA MUX */

-- 
2.43.0

