Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA3AFCA18D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC6B83FD3;
	Mon,  9 Mar 2026 22:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lFWsjCFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CEDA83F75; Mon,  9 Mar 2026 22:29:26 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6EB83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso5048710fac.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091762; x=1773696562;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uW4EnTBsJE2NHmmHfbSorO1uH13C6TJIojXWx439S3E=;
 b=lFWsjCFMUhtGv3gzCjIFrQjMu/IVgMFQtHNZo243GKBdqtrtK3xDRGKJVxALgjL8rc
 YipRHeXo0OpfWXDRIk7pR5ep1xabyhZozKAqlpuXaRv+ZYAZgxqmOuR4fJV34oxpLZwE
 8K9h2OU+BOSRW3Wpjilchb54IlsKOMfcyeynCsNyo+zT+UcasxEaphIEs+6B/MI3ueSm
 6JcRK8g9UMYJ+GvT7lsNnlNIjdip+kwcRiT78Ml8eTRHOluSemEgNH8+NOSZkJYzrzqf
 6K74JjluL5pMbr0nNiLWls6lgLpj1hhXs89apdh729y6QWmA4xfVliw8dw4fqk2H5r+k
 UVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091762; x=1773696562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uW4EnTBsJE2NHmmHfbSorO1uH13C6TJIojXWx439S3E=;
 b=khgfLXC2vowj4L1rZ2xb3K9fG2VZez9aNNcQcaSmdWANeC99OnC3DylWWRuuoiEfTu
 qpqruwefwiLUbIFsOGq21f41ifOvbBxyML1HmmCOs/qWjlXtMjLOCzinmUSLBJd7RT6R
 X/q68qMW/hDKt7xEABFjdT8orQ0xRwOTS7NI3w02a2fjArQrSDz7375sy4oRufhuJ4WH
 mZeZ5dtgjhIPVyRnh3Qzf2oZyQuFSdsIvwVf7OCNma2YZXZ3V1ZTXXj9jdgTGN/CbThp
 /7LyZX9ugxdVcNQSq0PRmEWnv03DaFndxSw0ReOCzkPS949PuOT8C3FVwxpUawH3ZHGI
 zA8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLobEN/8iOxmVpHqAk3dH5+NIsjDEPjm0BCAyZKGwGVu0cnhaqsb5KOrFmFw1ntPzHAhXmprA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb6u5mjrkW25orngydZe8CjisNLlcIG4/emPEnveENJfLtnctJ
 a5lGHovbyVI4pnc4oEdXSexXUn+Rp/RbJ9amUaIbt6pGKV9esWpOGZqQTI5IsuZLtoafXGjiuOk
 +EuWn
X-Gm-Gg: ATEYQzzydmVIkSrDkwOHIz15uH20XCvmQMtCV34RVA+5XEJ7xyJDsBPUHe+edAgWL9V
 oH1ipUqJORCZfnlHm/awdJAlOgUtRXBw8D8MNfqYVAxHtR611nGzW3lfg6FC9ABEibm3JTP7aZM
 vFMFJUP8Sejp8I7dLCdoxWD3oori++nHp3phDaaMtqh6Pu8blFVxnQhdnirIHBuTus8f9/CNV0C
 pk8Un3JsddrdQe9gY5vUsA94tY1GEVwkj1SbAlO+cxWGCoHd3AjBXa2hroGbVwZt1i8FNIOCuRl
 giUMszdQVj1oIt33T6+XR/uJIFgfHUoV/okQrssugyEA7cxflqkAlzgB+bQW+w9WMbsXZvGim2X
 tINAkhgffcn74DDktA2EaNE0fjjRUiPN9dX2+lVTDBp7Xt843jJMlsBTQ3KpYGEjNSOGC3vFmST
 W24wNkRjWezrbbYOS9XWPNCOFptQ==
X-Received: by 2002:a05:6871:c691:b0:417:577c:4550 with SMTP id
 586e51a60fabf-417577c49f4mr488889fac.55.1773091761966; 
 Mon, 09 Mar 2026 14:29:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:40 -0500
Subject: [PATCH v2 05/13] clk: mediatek: mt8183: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-5-b084ea74b99d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23014;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=mOLU415e5uRkeMoaJ1XIQ50fB57UL/B46muZBq2Tiwc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprztuDQzeLaQuju3eo36NcdjWAPGHaRmRefQXX
 N8J93xA6/6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87bhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Al+UH/22Mn7Id9JCJsWx823csklq4Z6LUYrt2Bt3ZjF5
 6Lhxb4lWiHjFBpxmdi6B+/hLFNA33zXazT/wAsBzDmnfcECH8/N8HJhqGOaskAPEsgIYUxCn9oy
 cqbzdzGRSGmVBZP/0Sget/LeljFIdNAz51W5gkKxam9AgxY3LSv7WYkZuGn8EV3MfSvBHj78/NE
 xlOGzBdp01bwF2SZQ5sFj+R6y+K/87DtJ0L3U9Wo5JBOEXFKWW9wwCn3WXNvOitkWL+2veJqpNb
 zmU8TapH8Uzu/+Y1AQeHS3gk4pqEHfDIX3U2ETCcejyGZBT7b1Fxp+cfEZh1yfvDWCjJzUhQ0Yj
 RZo4=
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
 drivers/clk/mediatek/clk-mt8183.c | 668 +++++++++++++++++++-------------------
 1 file changed, 334 insertions(+), 334 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 752cb1c61ab..d98614d8da6 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -197,403 +197,403 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	       16, CLK_PARENT_TOPCKGEN),
 };
 
-static const int axi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D4,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_OSC_D4
-};
-
-static const int mm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int img_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int cam_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3_D2,
-	CLK_TOP_UNIVPLL_D3_D2
-};
-
-static const int dsp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int dsp1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int dsp2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int ipu_if_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MMPLL_D6,
-	CLK_TOP_MMPLL_D7,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2
-};
-
-static const int mfg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MFGPLL_CK,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_SYSPLL_D3
-};
-
-static const int f52m_mfg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_UNIVPLL_D3_D4,
-	CLK_TOP_UNIVPLL_D3_D8
-};
-
-static const int camtg_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVP_192M_D8,
-	CLK_TOP_UNIVPLL_D3_D8,
-	CLK_TOP_UNIVP_192M_D4,
-	CLK_TOP_UNIVPLL_D3_D16,
-	CLK_TOP_F26M_CK_D2,
-	CLK_TOP_UNIVP_192M_D16,
-	CLK_TOP_UNIVP_192M_D32
-};
-
-static const int camtg2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVP_192M_D8,
-	CLK_TOP_UNIVPLL_D3_D8,
-	CLK_TOP_UNIVP_192M_D4,
-	CLK_TOP_UNIVPLL_D3_D16,
-	CLK_TOP_F26M_CK_D2,
-	CLK_TOP_UNIVP_192M_D16,
-	CLK_TOP_UNIVP_192M_D32
-};
-
-static const int camtg3_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVP_192M_D8,
-	CLK_TOP_UNIVPLL_D3_D8,
-	CLK_TOP_UNIVP_192M_D4,
-	CLK_TOP_UNIVPLL_D3_D16,
-	CLK_TOP_F26M_CK_D2,
-	CLK_TOP_UNIVP_192M_D16,
-	CLK_TOP_UNIVP_192M_D32
-};
-
-static const int camtg4_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVP_192M_D8,
-	CLK_TOP_UNIVPLL_D3_D8,
-	CLK_TOP_UNIVP_192M_D4,
-	CLK_TOP_UNIVPLL_D3_D16,
-	CLK_TOP_F26M_CK_D2,
-	CLK_TOP_UNIVP_192M_D16,
-	CLK_TOP_UNIVP_192M_D32
-};
-
-static const int uart_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3_D8
-};
-
-static const int spi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D5_D2,
-	CLK_TOP_SYSPLL_D3_D4,
-	CLK_TOP_MSDCPLL_D4
-};
-
-static const int msdc50_hclk_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3_D2
+static const struct mtk_parent axi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+};
+
+static const struct mtk_parent mm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent img_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent cam_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+};
+
+static const struct mtk_parent dsp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent dsp1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent dsp2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent ipu_if_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+};
+
+static const struct mtk_parent mfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MFGPLL_CK),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+};
+
+static const struct mtk_parent f52m_mfg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+};
+
+static const struct mtk_parent camtg_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D16),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D32),
+};
+
+static const struct mtk_parent camtg2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D16),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D32),
+};
+
+static const struct mtk_parent camtg3_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D16),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D32),
+};
+
+static const struct mtk_parent camtg4_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D16),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVP_192M_D32),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D4),
+};
+
+static const struct mtk_parent msdc50_hclk_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
 };
-
-static const int msdc50_0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_MSDCPLL_CK,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_UNIVPLL_D2_D4,
-	CLK_TOP_SYSPLL_D3_D2,
-	CLK_TOP_UNIVPLL_D2_D2
+
+static const struct mtk_parent msdc50_0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_CK),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
 };
 
-static const int msdc30_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_MSDCPLL_D2
+static const struct mtk_parent msdc30_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 };
 
-static const int msdc30_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_SYSPLL_D3_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_MSDCPLL_D2
+static const struct mtk_parent msdc30_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
 };
 
-static const int audio_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D5_D4,
-	CLK_TOP_SYSPLL_D7_D4,
-	CLK_TOP_SYSPLL_D2_D16
+static const struct mtk_parent audio_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D16),
 };
 
-static const int aud_intbus_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D4,
-	CLK_TOP_SYSPLL_D7_D2
+static const struct mtk_parent aud_intbus_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7_D2),
 };
 
-static const int pmicspi_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D8,
-	CLK_TOP_OSC_D8
+static const struct mtk_parent pmicspi_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D8),
+	TOP_PARENT(CLK_TOP_OSC_D8),
 };
 
-static const int fpwrap_ulposc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_OSC_D16,
-	CLK_TOP_OSC_D4,
-	CLK_TOP_OSC_D8
+static const struct mtk_parent fpwrap_ulposc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D16),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+	TOP_PARENT(CLK_TOP_OSC_D8),
 };
 
-static const int atb_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D5
+static const struct mtk_parent atb_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
 };
 
-static const int sspm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2_D4,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3
+static const struct mtk_parent sspm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
 };
 
-static const int dpi0_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_TVDPLL_D2,
-	CLK_TOP_TVDPLL_D4,
-	CLK_TOP_TVDPLL_D8,
-	CLK_TOP_TVDPLL_D16,
-	CLK_TOP_UNIVPLL_D5_D2,
-	CLK_TOP_UNIVPLL_D3_D4,
-	CLK_TOP_SYSPLL_D3_D4,
-	CLK_TOP_UNIVPLL_D3_D8
+static const struct mtk_parent dpi0_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D8),
 };
 
-static const int scam_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D5_D2
+static const struct mtk_parent scam_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5_D2),
 };
 
-static const int disppwm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D3_D4,
-	CLK_TOP_OSC_D2,
-	CLK_TOP_OSC_D4,
-	CLK_TOP_OSC_D16
+static const struct mtk_parent disppwm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+	TOP_PARENT(CLK_TOP_OSC_D16),
 };
 
-static const int usb_top_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D3_D4,
-	CLK_TOP_UNIVPLL_D5_D2
+static const struct mtk_parent usb_top_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
-static const int ssusb_top_xhci_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D5_D4,
-	CLK_TOP_UNIVPLL_D3_D4,
-	CLK_TOP_UNIVPLL_D5_D2
+static const struct mtk_parent ssusb_top_xhci_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
-static const int spm_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D8
+static const struct mtk_parent spm_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D8),
 };
 
-static const int i2c_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D8,
-	CLK_TOP_UNIVPLL_D5_D2
+static const struct mtk_parent i2c_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
 };
 
-static const int scp_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2_D8,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3
+static const struct mtk_parent scp_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 };
 
-static const int seninf_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_UNIVPLL_D2_D2,
-	CLK_TOP_UNIVPLL_D3_D2,
-	CLK_TOP_UNIVPLL_D2_D4
+static const struct mtk_parent seninf_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2_D4),
 };
 
-static const int dxcc_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D2_D4,
-	CLK_TOP_SYSPLL_D2_D8
+static const struct mtk_parent dxcc_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D8),
 };
 
-static const int aud_engen1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1_D2,
-	CLK_TOP_APLL1_D4,
-	CLK_TOP_APLL1_D8
+static const struct mtk_parent aud_engen1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
 };
 
-static const int aud_engen2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2_D2,
-	CLK_TOP_APLL2_D4,
-	CLK_TOP_APLL2_D8
+static const struct mtk_parent aud_engen2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
 };
 
-static const int faes_ufsfde_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2,
-	CLK_TOP_SYSPLL_D2_D2,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_SYSPLL_D2_D4,
-	CLK_TOP_UNIVPLL_D3
+static const struct mtk_parent faes_ufsfde_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
 };
 
-static const int fufs_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_SYSPLL_D2_D4,
-	CLK_TOP_SYSPLL_D2_D8,
-	CLK_TOP_SYSPLL_D2_D16
+static const struct mtk_parent fufs_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2_D16),
 };
 
-static const int aud_1_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL1_CK
+static const struct mtk_parent aud_1_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_CK),
 };
 
-static const int aud_2_parents[] = {
-	CLK_TOP_CLK26M,
-	CLK_TOP_APLL2_CK
+static const struct mtk_parent aud_2_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_CK),
 };
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX(CLK_TOP_MUX_AXI, axi_parents, 0x40, 0, 2),
-	MUX(CLK_TOP_MUX_MM, mm_parents, 0x40, 8, 3),
-	MUX(CLK_TOP_MUX_IMG, img_parents, 0x40, 16, 3),
-	MUX(CLK_TOP_MUX_CAM, cam_parents, 0x40, 24, 4),
+	MUX_MIXED(CLK_TOP_MUX_AXI, axi_parents, 0x40, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_MM, mm_parents, 0x40, 8, 3),
+	MUX_MIXED(CLK_TOP_MUX_IMG, img_parents, 0x40, 16, 3),
+	MUX_MIXED(CLK_TOP_MUX_CAM, cam_parents, 0x40, 24, 4),
 	/* CLK_CFG_1 */
-	MUX(CLK_TOP_MUX_DSP, dsp_parents, 0x50, 0, 4),
-	MUX(CLK_TOP_MUX_DSP1, dsp1_parents, 0x50, 8, 4),
-	MUX(CLK_TOP_MUX_DSP2, dsp2_parents, 0x50, 16, 4),
-	MUX(CLK_TOP_MUX_IPU_IF, ipu_if_parents, 0x50, 24, 4),
+	MUX_MIXED(CLK_TOP_MUX_DSP, dsp_parents, 0x50, 0, 4),
+	MUX_MIXED(CLK_TOP_MUX_DSP1, dsp1_parents, 0x50, 8, 4),
+	MUX_MIXED(CLK_TOP_MUX_DSP2, dsp2_parents, 0x50, 16, 4),
+	MUX_MIXED(CLK_TOP_MUX_IPU_IF, ipu_if_parents, 0x50, 24, 4),
 	/* CLK_CFG_2 */
-	MUX(CLK_TOP_MUX_MFG, mfg_parents, 0x60, 0, 2),
-	MUX(CLK_TOP_MUX_F52M_MFG, f52m_mfg_parents, 0x60, 8, 2),
-	MUX(CLK_TOP_MUX_CAMTG, camtg_parents, 0x60, 16, 3),
-	MUX(CLK_TOP_MUX_CAMTG2, camtg2_parents, 0x60, 24, 3),
+	MUX_MIXED(CLK_TOP_MUX_MFG, mfg_parents, 0x60, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_F52M_MFG, f52m_mfg_parents, 0x60, 8, 2),
+	MUX_MIXED(CLK_TOP_MUX_CAMTG, camtg_parents, 0x60, 16, 3),
+	MUX_MIXED(CLK_TOP_MUX_CAMTG2, camtg2_parents, 0x60, 24, 3),
 	/* CLK_CFG_3 */
-	MUX(CLK_TOP_MUX_CAMTG3, camtg3_parents, 0x70, 0, 3),
-	MUX(CLK_TOP_MUX_CAMTG4, camtg4_parents, 0x70, 8, 3),
-	MUX(CLK_TOP_MUX_UART, uart_parents, 0x70, 16, 1),
-	MUX(CLK_TOP_MUX_SPI, spi_parents, 0x70, 24, 2),
+	MUX_MIXED(CLK_TOP_MUX_CAMTG3, camtg3_parents, 0x70, 0, 3),
+	MUX_MIXED(CLK_TOP_MUX_CAMTG4, camtg4_parents, 0x70, 8, 3),
+	MUX_MIXED(CLK_TOP_MUX_UART, uart_parents, 0x70, 16, 1),
+	MUX_MIXED(CLK_TOP_MUX_SPI, spi_parents, 0x70, 24, 2),
 	/* CLK_CFG_4 */
-	MUX(CLK_TOP_MUX_MSDC50_0_HCLK, msdc50_hclk_parents, 0x80, 0, 2),
-	MUX(CLK_TOP_MUX_MSDC50_0, msdc50_0_parents, 0x80, 8, 3),
-	MUX(CLK_TOP_MUX_MSDC30_1, msdc30_1_parents, 0x80, 16, 3),
-	MUX(CLK_TOP_MUX_MSDC30_2, msdc30_2_parents, 0x80, 24, 3),
+	MUX_MIXED(CLK_TOP_MUX_MSDC50_0_HCLK, msdc50_hclk_parents, 0x80, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_MSDC50_0, msdc50_0_parents, 0x80, 8, 3),
+	MUX_MIXED(CLK_TOP_MUX_MSDC30_1, msdc30_1_parents, 0x80, 16, 3),
+	MUX_MIXED(CLK_TOP_MUX_MSDC30_2, msdc30_2_parents, 0x80, 24, 3),
 	/* CLK_CFG_5 */
-	MUX(CLK_TOP_MUX_AUDIO, audio_parents, 0x90, 0, 2),
-	MUX(CLK_TOP_MUX_AUD_INTBUS, aud_intbus_parents, 0x90, 8, 2),
-	MUX(CLK_TOP_MUX_PMICSPI, pmicspi_parents, 0x90, 16, 2),
-	MUX(CLK_TOP_MUX_FPWRAP_ULPOSC, fpwrap_ulposc_parents, 0x90, 24, 2),
+	MUX_MIXED(CLK_TOP_MUX_AUDIO, audio_parents, 0x90, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_AUD_INTBUS, aud_intbus_parents, 0x90, 8, 2),
+	MUX_MIXED(CLK_TOP_MUX_PMICSPI, pmicspi_parents, 0x90, 16, 2),
+	MUX_MIXED(CLK_TOP_MUX_FPWRAP_ULPOSC, fpwrap_ulposc_parents, 0x90, 24, 2),
 	/* CLK_CFG_6 */
-	MUX(CLK_TOP_MUX_ATB, atb_parents, 0xa0, 0, 2),
-	MUX(CLK_TOP_MUX_SSPM, sspm_parents, 0xa0, 8, 3),
-	MUX(CLK_TOP_MUX_DPI0, dpi0_parents, 0xa0, 16, 4),
-	MUX(CLK_TOP_MUX_SCAM, scam_parents, 0xa0, 24, 1),
+	MUX_MIXED(CLK_TOP_MUX_ATB, atb_parents, 0xa0, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_SSPM, sspm_parents, 0xa0, 8, 3),
+	MUX_MIXED(CLK_TOP_MUX_DPI0, dpi0_parents, 0xa0, 16, 4),
+	MUX_MIXED(CLK_TOP_MUX_SCAM, scam_parents, 0xa0, 24, 1),
 	/* CLK_CFG_7 */
-	MUX(CLK_TOP_MUX_DISP_PWM, disppwm_parents, 0xb0, 0, 3),
-	MUX(CLK_TOP_MUX_USB_TOP, usb_top_parents, 0xb0, 8, 2),
-	MUX(CLK_TOP_MUX_SSUSB_TOP_XHCI, ssusb_top_xhci_parents, 0xb0, 16, 2),
-	MUX(CLK_TOP_MUX_SPM, spm_parents, 0xb0, 24, 1),
+	MUX_MIXED(CLK_TOP_MUX_DISP_PWM, disppwm_parents, 0xb0, 0, 3),
+	MUX_MIXED(CLK_TOP_MUX_USB_TOP, usb_top_parents, 0xb0, 8, 2),
+	MUX_MIXED(CLK_TOP_MUX_SSUSB_TOP_XHCI, ssusb_top_xhci_parents, 0xb0, 16, 2),
+	MUX_MIXED(CLK_TOP_MUX_SPM, spm_parents, 0xb0, 24, 1),
 	/* CLK_CFG_8 */
-	MUX(CLK_TOP_MUX_I2C, i2c_parents, 0xc0, 0, 2),
-	MUX(CLK_TOP_MUX_SCP, scp_parents, 0xc0, 8, 3),
-	MUX(CLK_TOP_MUX_SENINF, seninf_parents, 0xc0, 16, 2),
-	MUX(CLK_TOP_MUX_DXCC, dxcc_parents, 0xc0, 24, 2),
+	MUX_MIXED(CLK_TOP_MUX_I2C, i2c_parents, 0xc0, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_SCP, scp_parents, 0xc0, 8, 3),
+	MUX_MIXED(CLK_TOP_MUX_SENINF, seninf_parents, 0xc0, 16, 2),
+	MUX_MIXED(CLK_TOP_MUX_DXCC, dxcc_parents, 0xc0, 24, 2),
 	/* CLK_CFG_9 */
-	MUX(CLK_TOP_MUX_AUD_ENG1, aud_engen1_parents, 0xd0, 0, 2),
-	MUX(CLK_TOP_MUX_AUD_ENG2, aud_engen2_parents, 0xd0, 8, 2),
-	MUX(CLK_TOP_MUX_FAES_UFSFDE, faes_ufsfde_parents, 0xd0, 16, 3),
-	MUX(CLK_TOP_MUX_FUFS, fufs_parents, 0xd0, 24, 2),
+	MUX_MIXED(CLK_TOP_MUX_AUD_ENG1, aud_engen1_parents, 0xd0, 0, 2),
+	MUX_MIXED(CLK_TOP_MUX_AUD_ENG2, aud_engen2_parents, 0xd0, 8, 2),
+	MUX_MIXED(CLK_TOP_MUX_FAES_UFSFDE, faes_ufsfde_parents, 0xd0, 16, 3),
+	MUX_MIXED(CLK_TOP_MUX_FUFS, fufs_parents, 0xd0, 24, 2),
 	/* CLK_CFG_10 */
-	MUX(CLK_TOP_MUX_AUD_1, aud_1_parents, 0xe0, 0, 1),
-	MUX(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
+	MUX_MIXED(CLK_TOP_MUX_AUD_1, aud_1_parents, 0xe0, 0, 1),
+	MUX_MIXED(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
 };
 
 static const struct mtk_clk_tree mt8183_clk_tree = {

-- 
2.43.0

