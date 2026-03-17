Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A21FF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AF184310;
	Wed, 18 Mar 2026 00:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8LK5Tuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A512084222; Wed, 18 Mar 2026 00:26:36 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3628419E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40427db1300so3780140fac.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789992; x=1774394792;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y17deMalg4xIWrz6YPMbe0wH2pfGuj0Y9Xm+W+v/PPg=;
 b=D8LK5TuwcKcclhnG8vGTBrdaxRZtB/APv/bXxjM5xIsJXGqyHZps1ORMVObHOlOJZT
 wvaxGuPA4jeQ3VD9C+oMetLeMFUnwgiRcNHrr1BgMcSyt3qk3Ez16tIgTGGTki352Hv9
 B6CAtxXMaVXl5inZI03Ya5F8CUA+jgc/MVCArMrLEth6qxmPlQLDZt/I1gRzC9K9IUCY
 1ViwRgnI+6XFYFdNV3AW/G6QCeMKl9yUI8p4/pEcbOKTqtqDiBSDYPmjF8zjZMrTGlFo
 alK5/oBt3/MRkQ4/vW6mjDPlkHR2AAWjgC7Tg0m0hGx5F0Ko1+pduTPo6+ixcSoJz4Re
 el3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789992; x=1774394792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y17deMalg4xIWrz6YPMbe0wH2pfGuj0Y9Xm+W+v/PPg=;
 b=AotTzmGkPQDdXwED3FJX7d01ahtV1S+l5XSx93WxD/zaGd9AjXBiU5fLO6IYI3zb4/
 fPO2JgtxANvKoRHdLRuzdXAr2C04joOBzUwED2LQLhgp36vXRD6UQXyIMV2K//e7Wl5I
 S8V8pvcf56ePul+Zl5iz/d30RbZb0wfihGLU8+w9zbGm70WOt952ed9G1KCGzigxBib2
 Hflodwbfgi7l58Xmwhwt0KyoI5rdDXOb7ZLZ7DnkXYrICyuQiobAKj6IRTDmb1Ngs82n
 qNg4Mj0zpgUB3+Sk7gUH+6b3vkP3dPDb36+bZWzsZgynQKseV8WAxBlgnK+TF84tAH1s
 YREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhMZrK/QIYYSiWvvievB8C1EQbq4uDKeHnv6xNBgtWiTFWBubsdk3zKEi4b3fGX/c5PrUaNRk=@lists.denx.de
X-Gm-Message-State: AOJu0YxBXRqbZCYPLvaVDr4tU3F0ZYYgX+Br6sekH3yZyFN2BgFRP953
 QdlKxhwIgfpl/7wyJ1gUDocmAf3DOLz/6RIFJwaJtaBzNZRjngw8w85nNjoc2z3BcYI=
X-Gm-Gg: ATEYQzy+708PYIClNalzXDxFL2rBWnw341qVZkhjxblGcghXeV2DxyKOG615mprjHIO
 i0OlHXmUbpSUX/m2rwaLjbt6ERGzrbkjnorkSB+benFJe+sPqb1N3mJtF+BrCE3l7u+cToI8mSL
 cPM1lKrd0FxuSGQgrbv5+1/lesFB6Ei2CW1de8JNSNChLU09bLVLsehJr9TVfuOn8/Eq0nSMsow
 MJDIGagkAOjHO6Ldcd2LTPl99isnIZwTG2UE1J5P/tCCIGWrgg4clJeKToaYk5RKY4CJg8XHsxT
 eUvR4u62rMkbd6s4e/C33D76RpT/IL02QoAB/wt9ou4TBYfZAokSN4mttnvgdPjeYWPc1FEArh1
 zHuv8imY1dnbqb7WB/14Ef7D3W/Qd2SFGWyqVOzPm6r8UCW9sqZAbe0QZZdg4PmM3mbVCFYmURe
 XqIdJikhyt7Up5G/bcB9qaismySSGkqDbZjHbb
X-Received: by 2002:a05:6870:71c2:b0:417:952a:a89f with SMTP id
 586e51a60fabf-41bd41d097amr870664fac.39.1773789992272; 
 Tue, 17 Mar 2026 16:26:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:19 -0500
Subject: [PATCH v3 06/16] clk: mediatek: mt7988: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-6-a4760f5b0a80@baylibre.com>
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
 bh=/GlgBmOL0UAiR/Vqj+SJEQeJFlzYRp7muyWNQzMq3B0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueLWGK1RO3zkQYriAhKd7e4WWBkXeEWZxLEfV
 cXsoY8em56JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabni1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7mQIAKCQmakJNMi8HIRPXR6ZzwX+R4IlP882VTKETdS
 CD3Shq/0wESPR+WZ8PjWcU5DhMPWIkUbvAS7uqXIytEC7gvlYNg1sj9roT170r90ucEic8sbLg7
 ZCsOa6CcYs0zmcJ/tbiMDepMMZOyBpLMsOczcsCbt3pTSnr4UH6OGUXc3bizxdZRPZVi+GFoS9C
 GKAvfaSkuhWS3kxLrp+KQ3gMPJkGndEb2tHmBDtaEvmEwguLbO4RsBd9xCU48ZUxl2rWBn+SuTp
 9bV5e96jwWTVZfGa3xxdzfRKyAupmqAgUluR2yVH+cD54EzviCAL6/Ag9YwwJ5qjcnvzCbJufaw
 g+Fw=
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
index 83f7c559e31..21d194ed807 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -444,51 +444,75 @@ static const struct mtk_composite topckgen_mtk_muxes[] = {
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

