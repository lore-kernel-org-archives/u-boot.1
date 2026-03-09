Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14FEFCA192
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5AB83FA3;
	Mon,  9 Mar 2026 22:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PQ7iPxjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD7983F93; Mon,  9 Mar 2026 22:29:22 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5B283F6E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46701f2077cso1429156b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091758; x=1773696558;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QZ9YZm4dk81k1qLZagKtTjVfj1OWBCoaD1jVOn9POeU=;
 b=PQ7iPxjYwdeNqWSzLhipHPTmxI7watyfWNtioxBMWLEoNLTKzOT2LJkSkZ0YvGdPe0
 f3nmlSgcBPGAlX6Epj3bIMhfX2EeKoZoa63RrNg4tJ+9h0m7X7XrJJaKWTNXcV4YA+hf
 rk5C8bvCLPyMX4kGCkyX05V5khY2X37/9kjqF+nX5VwWwryZ44lvg3EBbkwsFv3GOMRT
 t+AP8IPnqCH/A7N5SxxulHiI41zWekRHSjYBFyyPyfOsJtr8YQEwpZrS0Id2uZ7lCAJ6
 IVGaZuBZCqh+PfR+0awKI61615tjdgfpsWWWN21WYmOKUXwgp+LFbUK3WkFJqPfn5+jU
 awEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091758; x=1773696558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QZ9YZm4dk81k1qLZagKtTjVfj1OWBCoaD1jVOn9POeU=;
 b=O9a26r7Wqyt2j89wRbIH7stEpbJwsKeva+M16uTf8491hKodvBZYVNShWgbSOExrCE
 llFHDE7NX8sBTixp3NLMpbwhQJXhyyQ0c43Hmud5XXBpRZAxubx0F/+MkiIdNoHq328Q
 30vHpEIakK9VbU0z3u5+MZardUDP6NJOPOdhWC675vpVF1tR04b1OVZd5V7XIskMoIcv
 0DYC7yjJyFRtgcQGEz9A3R/YM2l/maKE5/TjT4yyyKoWenqZ7WKYgY3r1LByxuXiVL9a
 xvPZxwRsCTqQK/fonS119a9sPDzENS52ER5apLhhm3G/sbJnNcDQqRTZE740HPwCmYMD
 gONA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2AvetrPEbJTJz4zhMg0vQzY2kKRKd1d3VAB29JqqJra/75vfP46+QWCejHfqSjDYCVNEzUdI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4z5Wz1EQE+R0yBypHhl90gPZLofNubntBpPud9FZE8//UpR5e
 jtIlwLHOxqjw9nNdjugddjfuhJV5vo0lFifSKuDKRS3YSUkdqrDmQpFUQvaCTcEb7FgmI+d8o48
 O2xAH
X-Gm-Gg: ATEYQzxnp1NfWCjFIb0/Sz7DKolxz5NA1r7bOIwEdHZmkay8w9bpUooFMrskGhG4Bew
 wTi2CozmjsPQt4OqzqWJKYBe+ilA+/o/83mJqgTxW9hw0fAApm7rUEoVvwwQ7767aSPMe7MyPwq
 7J4DQQ+YSVG+fADtgl+ajx7F0TJlQW/PJvviCleMy2t04FiFp/Ouz82Po64kUYksqFO3o+2hGsj
 /O7Hz43PP4X8xCXVFW4xnxv3bbO3Z5qUREWW51ep4LTc7yizVftpMq9ouRO02wCxbW2HNUfXBrx
 oPhGpIkwYa8gtA57FB3KjPaAK0ksI0JgC32iSdYI8VoWTmJk7ZYdDXxVIoyVqe41/gFCb+RJLO/
 VAbwZ8KTbz5r3TeUnXOeiWEvcqMgnyA+KDzI4H6Exfk+N+rC+SD9/R511qvsop+ikUABiA6wweY
 97946bRQpXFBsQd+F4tj9CaeSdwA==
X-Received: by 2002:a05:6870:e185:b0:417:3b22:6ba3 with SMTP id
 586e51a60fabf-417569805dcmr679908fac.14.1773091758358; 
 Mon, 09 Mar 2026 14:29:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:37 -0500
Subject: [PATCH v2 02/13] clk: mediatek: mt7981: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-2-b084ea74b99d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10479;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=puz+6PLzPVxj8iI22uyQVakEoGluoFlcW1R4y8TyVpE=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprztbYdoXI6uPFep8Odm9+h5o9a1f2drBtCUea
 YDMdXtI9o6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87WxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AU6YIAIrEtyIE5miL6So/FRWlGa5fySLNzUnAna9qSp0
 MnuqGl8Bk/w+fvi4qPnOflQl6OD0UPxZd0KGuxglgu3dwt8mDgmRvqPPvcieD42EFcbhKdMKQgh
 RnJ7uzEQqeiswEWzFStRDeszQ/4877Ag8JfogOeIP+gDR5ZuMmaLKGWNxW7cIVwes9BQNBobb6l
 6VKTHmRVCU3wR3l9v/9vugO6y/F7CL05meBdpqePkTye7naOXH94n8hApxXEmRgw0LSunfXXhTO
 F2jwvdBMEo0YdyjVHC2S0ImeFUS6M56OoDlhUHs5Qx9MhWN4RPCjiKbC1JpSaj+F4ISEcD0q0pY
 FxqA=
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
index 42c3741ce62..cdd9b9e4092 100644
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

