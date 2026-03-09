Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF8FCA191
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8210883F98;
	Mon,  9 Mar 2026 22:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xep9uGlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D97C83FA7; Mon,  9 Mar 2026 22:29:24 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E4183F53
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-464bc03efd8so7117405b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091760; x=1773696560;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ElEdnx78STtScfLE2RZPwJbeGam1/mb7FWmepYDlXeA=;
 b=Xep9uGlrONHRI1l6fGMNhWzWC2GqtRD5xRW81WHg4M27IGoBHICSSf5NBK/CgmdUFQ
 lcd+6NL43kLPKAAL49bAy74G8KhdW/nhyXEwIbolPQNvRLGhPWinexlN+vTSmgpEypkJ
 bkfZ5fEMRw+JDJPZycBiHt7iB+qFiLALt+kEHVsPCUDAogpNz0T4jquDH+V6ux2N1MN4
 Wqm+v8lq9SPGOGqU89BRAUy/WxefMuEcnxADF549ycRbNswmi3J9gyXRf4JIdrJ8/WdX
 UCuooajs64a1pBkPJHtm9yMlpByY7pFLd48syXsasA+JyvHaN+oSf9OF8VCXh5+yYj8T
 Svow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091760; x=1773696560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ElEdnx78STtScfLE2RZPwJbeGam1/mb7FWmepYDlXeA=;
 b=HWq9Ww34i2P+eH1wdXN3D+4pJXLJ6vDaThuBUk5kvl1XA6U+oQuTAp/M7rMN1alkDx
 ZwmTe5xjrc5NysLN8aAPFWe5BgkwZfWtm5BlnVUQT5XMAcvgV7XJ42PYyJMSmedmaJCu
 Ww/0heyp0YRVqKNMw7sc779eorBTxu6MEpCdsIp6DHcqgiLB4IzG/RCp1rK6i/MPP3jn
 pbzCvU7I093CAyvu78SszsbhxPSt1T1KXg3CeO3Dabn0Alq3QdZCROR/6f1YwecA+nJP
 qQ6nj0Lcn9ICOVXOt8+g0fZ2LCAx6lyAjI0WeblqxQlTgKtduvY/I7CZBVCjLAnk5QAy
 HrTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc6pdL7xM8UQoFLMVr/H8utw+O2LfryXR9mEJlbCUegI7K5+giTMlMIYlKQQY9ZHHxFTIqRyg=@lists.denx.de
X-Gm-Message-State: AOJu0YzYZZHJHcuabomX4wNXsW/SqdY5xto0y2Q4N8OwgQuuBG8ZuFpY
 963EI46hLCzxek6vuQzD8gTkZs2SzZIhMTV9EFPu/Jl6/TN9l9MdgLOBAKwpSbbTKMQjDNjzigt
 evesg
X-Gm-Gg: ATEYQzyojaUTeCf6mftWwQSZwDBybYDk7QKRd1hdM7JeZ6IZSGxTF5RS1LhiuMsbTO6
 HfOnweyDzHsq+j07j0vrK9HgKvvYSCCvr8WsLori1l96Lql8wVykgyixbQkTmrA7IuybOd63xxJ
 kZ5tYAvB6sygGPc9YY95qzy0wi8P7XJxrPBwkjoGJr19orPYsRWuuiv9stB68/JFggpFY3XtPer
 a63Oz1riJQ48v/e+If2A0gIdZtGsFk3TAUi/71a9dUJSttw8LMlh0aVxoXQ3xRzeVGkJDCYtPrI
 Y+bi4AY9H2pWCNyc1HRLZixSqm6BCtmKxAvlM7UiC4OhyrqdcqRfT6WBq4abswo5/hiOnsHHmZk
 nqKf7ffJG9cDqoYlRtcIYucBHxUtO/MCci077HTIcAWzx/a8f6ZcUczQHO8QOLm2bQNrvEm59PK
 4gVCX4VHuPhELqm5Dus9X3xWN4wg==
X-Received: by 2002:a05:6808:3025:b0:45e:dbd6:9cff with SMTP id
 5614622812f47-466dca296b1mr7165399b6e.16.1773091760575; 
 Mon, 09 Mar 2026 14:29:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:39 -0500
Subject: [PATCH v2 04/13] clk: mediatek: mt7988: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-4-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=eleBwOpPwveiBBqUkq5kVh93LDxezoC+zEx4ueVv81s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprztoYsli6Oq0RXYlqeIlRxYiHBa/InJLvlFUE
 bea42dhsgqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87aBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ag4QIAJR40sPMpHzY9s+nV0z7lDqwpl/ieMOBMzjpbms
 Q0WTJEj3fgK1utBnOWXnB4CX7K2GZoO9+xqnwf1vN1BiM/V6mtgknpddossx2com9SZVI3xvFS9
 sHHRq+xAPROwkQRZlbpHfqZsFoG7eKZyIvV7EYl0KVsbBaxwnhM4XctbOjWcE0dfhTOYPDb7vxg
 2eNmKxOwpDA6deVcYILmPSJBTPH5Hhqllm/0u5HBeJXmGlXD+x7lCfLUrAk2vTFaudRsLOpNoQl
 OJ2GIJYjjmujld7q3MrLuy/HkgnYUx1ez901hoHlu9nb3ynz6sMq1cLaTQPbaaq6tAd7akwoGru
 WYN8=
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
index 943f85e701e..38a5c20035d 100644
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

