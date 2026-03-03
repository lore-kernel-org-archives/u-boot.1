Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DDBEB3644
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE40783F54;
	Tue,  3 Mar 2026 01:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NciWhdNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46AC83F4D; Tue,  3 Mar 2026 01:05:10 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F62983F4D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40f387a688dso171461fac.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496304; x=1773101104;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HQ/Tz+f93SSxEmufWa47PLHE843lmq4+2g4bS8oYhwA=;
 b=NciWhdNcTxjbWFrvrs0pnUOen1E3WkIjQU3XWyDw0gWpiipK6/3NTlvb7DpAlh+wNh
 9P7Y8ZYBEknko5zkifnmo43B1+pfqXgryRO23ekZ9xpAUjvpaJ68GHDysIMuAulwEYUC
 TRZC96bfulIohqUoZqKZWnM9xlXjVyhkCKVhpgXjeAjF2bASqaXrdDrQpmiVt+9CYji3
 Jy6b9fJ+i9LDlWjY9+jj4Ij9pHcFMHURlHCpsvZZWHkrv5GOSHVUTscyF4BtM9DEoMQs
 YnJ6HoF8x82QLTPzK857oy4PcJnkQ5tK1HTi6kSDGnAgHLG262L/KS/YE1fONzxUGUvf
 L5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496304; x=1773101104;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HQ/Tz+f93SSxEmufWa47PLHE843lmq4+2g4bS8oYhwA=;
 b=IgbueizFSN4fdTahpTEWXa+fX4DbRXzXzDQGLLgN7YdbqddzfEIugGL9g/Nhhcpgs9
 MimG43Tp91RXn2szfxMc8FTb7PAxuzlX+AQYbUXcj+HFUK3Flo18K3BKgphKsiup+TNe
 xmLQ8Kvr9jlQQ6x3ZJ3bEeMSpnzRYq7vzQzChDiF2mQ7z8pRK4rxB4vSVCGNPLPhHESK
 +9dHTkrwA4dudC7HdMRXdde46ivs6k4JJAmGgK70QEfosfoMyPJ2QbwP8PtUa/6j924r
 45FY62vAfQP6RguXY7wSSsWe4GDVQu5A3tf/yC/8+Q5mkqnYQ2YvCVRUWVnrdop8KZrW
 /3WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG0ToVf8XZKkIFf/5d9ZytNx579PI/TZnjyiNDSAvtUe/BhFgnDmT1CRCXGs3xMqGiQ/IToSc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx4YxhyASV+HSmxNu96wvGYWtvQr/VTwmoytJ644ZGasS3B+BL
 kIl0wX+SeKEv5ZuoLWLleFoGPUxQu3nGz5e5XNtf3yns+GI8puFA1+X34M8lQKGK3Eg=
X-Gm-Gg: ATEYQzwts2POkX+j+BZGzDTV+f0t8enS09To9+xNbwYX9zM4eCYwFjpT+IyBmbPRDGU
 BLXI+3pNuriJZU0SQMZSCYGSUYy3lBH37GgHPmU7n/E/BByXo6iHn82fDR7iq2aQAMYrtc+qR/p
 T/lU6n0hkU1l4UfCn5ZSPWIbYkS8jZi6CEKJdFgDFcCQauraXcolmC8YG7/5dqqxctbtRI3QPKZ
 CA+zS8EI1JcfTuLve0lc5xjQY8qZfweAPhI1zvflTu+FstVhb8sNK6pJqkfeRTyLJhZ5xQ9bowD
 8Lgb6tPs4QsB35PHfTE9mdWR6HIRmIeoHyk65ZU5+4jR3kzbb5sc6RnSpvhsw4M0IhvOlhXU3fB
 OpwFFed/Bjdr1EIkmksErR6PuskR/SCOR4yoT2NQ5IqG+j5GiLFAdGfWsBmipRWF0FcMjykDWVI
 8JL5mwLOyOgSUJcZJ2m787ADQrraYA
X-Received: by 2002:a05:6870:dc49:b0:349:de3c:bfc5 with SMTP id
 586e51a60fabf-41626e4fd29mr7249797fac.7.1772496303737; 
 Mon, 02 Mar 2026 16:05:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:12 -0600
Subject: [PATCH 03/14] clk: mediatek: mt7981: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-3-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10479;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=3+ry4wrWDWsE90BpBfxhGqIjLo7B1Wu2wLe9vpAWO6U=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVeBmg/l1B4EqFHvo8tns9xla/bG+Y3GDQo0
 M/4t/u8OiuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlXhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlRAH/31vyFM8BjiAcAaUM9K2UYwFjNMXKoI/42q56FJ
 v6k8ozmB0OjstVKAY6QuYba/qPvS/h+mkZMKHv+ZdqaZby4YCVk+/LhGZNG4KcVj+rSbp0yxQf4
 NTbWoc9EaftWhQnSNSVprAmNjNzw+RoRSFhdsl+IMaOBbhzCAzzAo2rjh1SnwXseycReBjplvIl
 kfQrb98HGuOmlC66ud0UX22FvwjNLLFBuhR2u4r6/5qIOykQ6QstT2M4oHGrVzZWb2ju3VMV1CQ
 3IS2/gZtPwIq8wCXtJ6iADlKiYeL0qQ8Hja+bzYutj27rjm7CBQYq4JlG3Ywlmuuu5YSLqf0HZA
 a0zM=
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
index 3fb6a3e33df..c21a15f8a81 100644
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

