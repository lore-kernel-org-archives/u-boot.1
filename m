Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC7FF6E9B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 23:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBB9842EF;
	Wed, 18 Mar 2026 00:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C7Xa97zI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084C9842A7; Wed, 18 Mar 2026 00:26:36 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F21684213
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4673790ab85so4142372b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773789991; x=1774394791;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEuPINwc3mpwZzgv8XYgvwQ8/AFCvOwcjvGog3ItFWM=;
 b=C7Xa97zIpBx82GnzyfbuQbpBd/89uGFgowMeHiht58/KEJHpU5IzUoIV5v0lPNUFP7
 tgc+/1T//mFETU2ypw+DerMVY1HcxUVeThfvtl7tS8e/xEt5laUgw2qX9Z05tB7xxcYK
 oPViYeZd0rr/PO3Vov+bMiQdLtaCZMiDVT+FnUCWeNodQdsSe52GAZEPKcfH8mwZCrEW
 6R9F8jcz+eDLknHRj8O2c48/goRBOHjRPPAr3RZFSxrSSkMX8TJhMVocuwIkXBvutXKQ
 zlLkwxsyak2dSaQiY4y3qEfJkydvSHla4QKhkma+O16/RJAIh+APggRCL+MN07jXpp23
 FUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789991; x=1774394791;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FEuPINwc3mpwZzgv8XYgvwQ8/AFCvOwcjvGog3ItFWM=;
 b=pkEcbioGQAV1NmvJGJXa5ORuUSOWwtpQ2ZyeEc2z6mLNjKUmSLnTECyRdd+FbPGEhz
 j7MlqOc4dDYjPo/pLUruZ/VnZL/WiBmq1KNxcCYYgvE9ncPo8mc5FEn0zD1QzajRO5Zv
 wacOXbl5LAolpAD/3CPB2dGPNOT4IF3JoCCMIMnVJdFYE2cKoWNJ4kqzeKl1akwEmCJs
 s6kS+em4PwjUqajEXur0quanT+3zeSegraouTYVAnlSLdMcX+YK6t2pE721a0FStd9MN
 Ny6kBKlGNKoCEPEcvazxPl4LR4ey6lLwJ6c12pYlQtNNTu9vC9P/UfuhTRgtx4redbx2
 m7Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU99zSh+FqMnNb7oG4U6YXTSx2VUgA3wsTrgAcz3YbPP7uLB1EKo+6FQQCeYY84P9zl51Y4Uk=@lists.denx.de
X-Gm-Message-State: AOJu0YzKOv0qk8b6T4mg7NRV+UnWmeqX8KvTq2V3lL+oIMn8h3MKmDV1
 8IrTifYocEo7iuN13/fg1uRv/CaynYVXqi9O05nJpVCyDvTGf66D56ia97aaypEYuuE=
X-Gm-Gg: ATEYQzzAN90mTePxTe9HkxX4TGzxAanSl5fV6gbP2Yjt6u+1YQfROur/R1Fn3aOQddg
 jM5gHmNTaeJx8irWTt8ftowBEAXnKXIaBK7NdbQy7N3iYylxL7zWvygIwdXnHWaNTLAPz8xSKfx
 CV22ME1g+qF+yhP4spZYmnEjjL0avwRG1uJ0FYU4Nn7EyUSt/vXrdsAGlwtAeJNTHF7KcWhYmI2
 KbYU5zavsquvOYJ5o/QcU3GdNA09vWpvnN77FZTEJumZLdpfN5QL5W0Y01wJ/HjcCGKl8JzlmvY
 p5xd0OD7KVIYWQh2JNjiE1B430U9pHhrSJnj3ePLK4r+7H7jnl4z8eg2M1W7EYlB1ZlqNsT2FZI
 0dTyLppKuQoB9jt30bdGN1NTDM/seT7wV+snpG/52blVjgskiQKNGpPmNr109zBuXBRwGoUQknZ
 wkMIUVLdq0Vf5V0uLC/ncZJdC29Q==
X-Received: by 2002:a05:6808:4f67:b0:467:2dc5:f4a9 with SMTP id
 5614622812f47-467ba25b96bmr911161b6e.28.1773789990676; 
 Tue, 17 Mar 2026 16:26:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2828aa7sm1148309fac.1.2026.03.17.16.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:26:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Mar 2026 18:23:17 -0500
Subject: [PATCH v3 04/16] clk: mediatek: mt7981: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-clk-mtk-unify-mux-parents-v3-4-a4760f5b0a80@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10479;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=/AP5DnUQHUuNgRMVkAQmjZtVy1nvMoONYN/LGjIFZNo=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpueLIQAFtKFAmL6SISJTKDpEWGBRJGwSbiKVzU
 UfeOUPOCliJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabniyBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEL4IAIIpfzcSeqEbJ97EOPr+U90EF/vvfGMCF017o7b
 SxMft+0RRSk2+2OJ4zccDlWDJNltlD+xGiDpOSwBLoOpJPjNgdNoc0UtaI+0slL28arriMQ43xp
 RD7+oSYKC/HOYtZi4yJHpmX9wHQ0gGQk5x0YJx7haGiYQ4DFOAitpEkJVoem/0v+R0h+x4h9zCd
 yMsd0y2So6AsuHgNXqnGHJNE8yL46W+FxFJE1CkuJ0o1/Cl1IXrmOiIlSihGOle+DbNX05hTRH9
 R9Be40kQr4KpWc59BcTqQu71igPiANt5+UM/yJGBWudjWgVhNU5NI5ldxHrjOpUkcJ2ObRMO0H2
 +iu8=
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
 drivers/clk/mediatek/clk-mt7981.c | 226 +++++++++++++++++++++++++++-----------
 1 file changed, 162 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 40e8429521a..0c770a0bd93 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -139,97 +139,194 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 };
 
 /* TOPCKGEN MUX PARENTS */
-static const int nfi1x_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_MM_D4,
-				     CLK_TOP_NET1_D8_D2,  CLK_TOP_CB_NET2_D6,
-				     CLK_TOP_CB_M_D4,     CLK_TOP_CB_MM_D8,
-				     CLK_TOP_NET1_D8_D4,  CLK_TOP_CB_M_D8 };
+static const struct mtk_parent nfi1x_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_MM_D4),
+	TOP_PARENT(CLK_TOP_NET1_D8_D2),
+	TOP_PARENT(CLK_TOP_CB_NET2_D6),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_CB_MM_D8),
+	TOP_PARENT(CLK_TOP_NET1_D8_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D8),
+};
 
-static const int spinfi_parents[] = { CLK_TOP_CKSQ_40M_D2, CLK_TOP_CB_CKSQ_40M,
-				      CLK_TOP_NET1_D5_D4,  CLK_TOP_CB_M_D4,
-				      CLK_TOP_CB_MM_D8,    CLK_TOP_NET1_D8_D4,
-				      CLK_TOP_MM_D6_D2,    CLK_TOP_CB_M_D8 };
+static const struct mtk_parent spinfi_parents[] = {
+	TOP_PARENT(CLK_TOP_CKSQ_40M_D2),
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_CB_MM_D8),
+	TOP_PARENT(CLK_TOP_NET1_D8_D4),
+	TOP_PARENT(CLK_TOP_MM_D6_D2),
+	TOP_PARENT(CLK_TOP_CB_M_D8),
+};
 
-static const int spi_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_M_D2,
-				   CLK_TOP_CB_MM_D4,    CLK_TOP_NET1_D8_D2,
-				   CLK_TOP_CB_NET2_D6,  CLK_TOP_NET1_D5_D4,
-				   CLK_TOP_CB_M_D4,     CLK_TOP_NET1_D8_D4 };
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_M_D2),
+	TOP_PARENT(CLK_TOP_CB_MM_D4),
+	TOP_PARENT(CLK_TOP_NET1_D8_D2),
+	TOP_PARENT(CLK_TOP_CB_NET2_D6),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_NET1_D8_D4),
+};
 
-static const int uart_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_M_D8,
-				    CLK_TOP_M_D8_D2 };
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_M_D8),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+};
 
-static const int pwm_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_NET1_D8_D2,
-				   CLK_TOP_NET1_D5_D4,  CLK_TOP_CB_M_D4,
-				   CLK_TOP_M_D8_D2,     CLK_TOP_CB_RTC_32K };
+static const struct mtk_parent pwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D8_D2),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+	TOP_PARENT(CLK_TOP_CB_RTC_32K),
+};
 
-static const int i2c_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_NET1_D5_D4,
-				   CLK_TOP_CB_M_D4, CLK_TOP_NET1_D8_D4 };
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_NET1_D8_D4),
+};
 
-static const int pextp_tl_ck_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					   CLK_TOP_NET1_D5_D4, CLK_TOP_CB_M_D4,
-					   CLK_TOP_CB_RTC_32K };
+static const struct mtk_parent pextp_tl_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+	TOP_PARENT(CLK_TOP_CB_M_D4),
+	TOP_PARENT(CLK_TOP_CB_RTC_32K),
+};
 
-static const int emmc_208m_parents[] = {
-	CLK_TOP_CB_CKSQ_40M,   CLK_TOP_CB_M_D2,  CLK_TOP_CB_NET2_D4,
-	CLK_TOP_CB_APLL2_196M, CLK_TOP_CB_MM_D4, CLK_TOP_NET1_D8_D2,
-	CLK_TOP_CB_MM_D6
+static const struct mtk_parent emmc_208m_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_M_D2),
+	TOP_PARENT(CLK_TOP_CB_NET2_D4),
+	TOP_PARENT(CLK_TOP_CB_APLL2_196M),
+	TOP_PARENT(CLK_TOP_CB_MM_D4),
+	TOP_PARENT(CLK_TOP_NET1_D8_D2),
+	TOP_PARENT(CLK_TOP_CB_MM_D6),
 };
 
-static const int emmc_400m_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_NET2_D2,
-					 CLK_TOP_CB_MM_D2, CLK_TOP_CB_NET2_D2 };
+static const struct mtk_parent emmc_400m_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET2_D2),
+	TOP_PARENT(CLK_TOP_CB_MM_D2),
+	TOP_PARENT(CLK_TOP_CB_NET2_D2),
+};
 
-static const int csw_f26m_parents[] = { CLK_TOP_CKSQ_40M_D2, CLK_TOP_M_D8_D2 };
+static const struct mtk_parent csw_f26m_parents[] = {
+	TOP_PARENT(CLK_TOP_CKSQ_40M_D2),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+};
 
-static const int dramc_md32_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_M_D2,
-					  CLK_TOP_CB_WEDMCU_208M };
+static const struct mtk_parent dramc_md32_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_M_D2),
+	TOP_PARENT(CLK_TOP_CB_WEDMCU_208M),
+};
 
-static const int sysaxi_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_NET1_D8_D2 };
+static const struct mtk_parent sysaxi_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D8_D2),
+};
 
-static const int sysapb_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_M_D3_D2 };
+static const struct mtk_parent sysapb_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_M_D3_D2),
+};
 
-static const int arm_db_main_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					   CLK_TOP_CB_NET2_D6 };
+static const struct mtk_parent arm_db_main_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET2_D6),
+};
 
-static const int ap2cnn_host_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					   CLK_TOP_NET1_D8_D4 };
+static const struct mtk_parent ap2cnn_host_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D8_D4),
+};
 
-static const int netsys_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_MM_D2 };
+static const struct mtk_parent netsys_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_MM_D2),
+};
 
-static const int netsys_500m_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					   CLK_TOP_CB_NET1_D5 };
+static const struct mtk_parent netsys_500m_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET1_D5),
+};
 
-static const int netsys_mcu_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_MM_720M,
-					  CLK_TOP_CB_NET1_D4, CLK_TOP_CB_NET1_D5,
-					  CLK_TOP_CB_M_416M };
+static const struct mtk_parent netsys_mcu_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_MM_720M),
+	TOP_PARENT(CLK_TOP_CB_NET1_D4),
+	TOP_PARENT(CLK_TOP_CB_NET1_D5),
+	TOP_PARENT(CLK_TOP_CB_M_416M),
+};
 
-static const int netsys_2x_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					 CLK_TOP_CB_NET2_800M,
-					 CLK_TOP_CB_MM_720M };
+static const struct mtk_parent netsys_2x_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET2_800M),
+	TOP_PARENT(CLK_TOP_CB_MM_720M),
+};
 
-static const int sgm_325m_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					CLK_TOP_CB_SGM_325M };
+static const struct mtk_parent sgm_325m_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_SGM_325M),
+};
 
-static const int sgm_reg_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_NET2_D4 };
+static const struct mtk_parent sgm_reg_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET2_D4),
+};
 
-static const int eip97b_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_NET1_D5,
-				      CLK_TOP_CB_M_416M, CLK_TOP_CB_MM_D2,
-				      CLK_TOP_NET1_D5_D2 };
+static const struct mtk_parent eip97b_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_NET1_D5),
+	TOP_PARENT(CLK_TOP_CB_M_416M),
+	TOP_PARENT(CLK_TOP_CB_MM_D2),
+	TOP_PARENT(CLK_TOP_NET1_D5_D2),
+};
 
-static const int aud_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_APLL2_196M };
+static const struct mtk_parent aud_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_APLL2_196M),
+};
 
-static const int a1sys_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_APLL2_D4 };
+static const struct mtk_parent a1sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+};
 
-static const int aud_l_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_CB_APLL2_196M,
-				     CLK_TOP_M_D8_D2 };
+static const struct mtk_parent aud_l_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_APLL2_196M),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+};
 
-static const int a_tuner_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_APLL2_D4,
-				       CLK_TOP_M_D8_D2 };
+static const struct mtk_parent a_tuner_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+};
 
-static const int u2u3_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_M_D8_D2 };
+static const struct mtk_parent u2u3_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_M_D8_D2),
+};
 
-static const int u2u3_sys_parents[] = { CLK_TOP_CB_CKSQ_40M, CLK_TOP_NET1_D5_D4 };
+static const struct mtk_parent u2u3_sys_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_NET1_D5_D4),
+};
 
-static const int usb_frmcnt_parents[] = { CLK_TOP_CB_CKSQ_40M,
-					  CLK_TOP_CB_MM_D3_D5 };
+static const struct mtk_parent usb_frmcnt_parents[] = {
+	TOP_PARENT(CLK_TOP_CB_CKSQ_40M),
+	TOP_PARENT(CLK_TOP_CB_MM_D3_D5),
+};
 
 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
 		_shift, _width, _gate, _upd_ofs, _upd)                         \
@@ -238,9 +335,10 @@ static const int usb_frmcnt_parents[] = { CLK_TOP_CB_CKSQ_40M,
 		.mux_clr_reg = _mux_clr_ofs, .upd_reg = _upd_ofs,              \
 		.upd_shift = _upd, .mux_shift = _shift,                        \
 		.mux_mask = BIT(_width) - 1, .gate_reg = _mux_ofs,             \
-		.gate_shift = _gate, .parent = _parents,                       \
+		.gate_shift = _gate,					       \
+		.parent_flags = _parents,				       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD,                                   \
+		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
 	}
 
 /* TOPCKGEN MUX_GATE */

-- 
2.43.0

