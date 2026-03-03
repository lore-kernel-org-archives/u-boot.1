Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC9CEB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC5883F82;
	Tue,  3 Mar 2026 01:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YF7lVPZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0005283F4C; Tue,  3 Mar 2026 01:05:12 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B1883F6D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40ee486a76eso183439fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496306; x=1773101106;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uW4EnTBsJE2NHmmHfbSorO1uH13C6TJIojXWx439S3E=;
 b=YF7lVPZsSJGdDLqB3hcR9bKx7iOWu1KeWJjyrVI1jpWA96yXjU+DRY6hl1dDoZCn/H
 dHjiJskNfqR5F4xV1nmJnCYYE0KeJc9cjQIVDCfnOfTZkwC9sW8L5RawM3gX3yxI3n6D
 DV3do7KHODE24Jh6fyD1itCHoG6qhmXaxzko1nYwCJ/7xMi+aVpVWvstu3ISEmgGW1/4
 ulbOg5ZQx9YFATqVfAqn2nwwt8odKxEdrBUxB0k5a7HKJaELAx6drzKvYbgR3/jIFeLN
 sTt8N5Nx79SyNiZzoBFF8WCOPzprZrFLGCJklZLl2h7Z1zYuT8v8x2K8qkxxWOeemZK2
 T27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496306; x=1773101106;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uW4EnTBsJE2NHmmHfbSorO1uH13C6TJIojXWx439S3E=;
 b=Bo9C3bEop3UDsEFEtnSfU9k74EK6xpPS5ZboNtSPwNy59nGNKLcjHN14+hyUDHppgt
 sgcPa4t74bbC0HxLTKIjbiVAvAMAANNNixVhpxBhEZWKh126gIYF0f26+oPa7WMAufd0
 IVc3g+68DdUXKsRr3DgK6qPGaiy0S9aNww98hRTf/t2vR1XwqOBgUAP/bXIchdl/yt84
 yCKI92vTO8MEw6HhWCJYuERM1UxQMpw8uh8v3QEBxmol+ZzmUKHgMna+3VkrO9pumsEP
 dNWWCZJwqvwFIs7tGG3BChymB09mA0N9c9mDZ+9vkUD/Q+c3lAitAg9Zs5KNFYv461MO
 21Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW652VmL1n6j6afw5rsPzTL3OO/SZH2f080woETtGQKFYIxvCQmnpwOata55Mkee9XMGVyaBQo=@lists.denx.de
X-Gm-Message-State: AOJu0YxpXrFv5tmkdeinfTbA6DVgiEl3XjgwU7lzCx3EyNHf7VvznJOK
 vfVPa7euyTeSoJKhBdRvEW2ayMiS/itZ5LLetds0db+FYO2/0ZCaxREbe4+JJLD5/FA=
X-Gm-Gg: ATEYQzybkU0jNk++Az+KRTxLwW9rLVm4T7Pvnxld6O2l7ySd0S6zn2eH3ylCGLbRdw0
 JxTLrbTX9Y74lDrMJvP0Bm12hHEZ745sGYijy5+q3p/xN7D6buc6B3bYOem0HxH55kJK/YSIrUD
 0LNhpfupwcrpqRhfGNHIT40Zg57zvTlq7usNnSynPAtgewLy1A8KHjDTDoFsaaqlsOXqjo0iI+X
 Uyje33zozbeTOqgR7bgwU3CO6lLeMWD4hYw/kfPYiGGWRTQEF1sZElQlOAVUDnSL5PiOr2yknpm
 P8zq8aQ0Ig8t/+dFztgypgA4oez8HL1UAompH8vyY3sD1mC8/G2xGn+pMRj1o+DFZxvSkrUwv8W
 pEmtjhFCojxRGt35DIUm2yaXoEYRIFX643YiNm2QuCqBilg69WqGM0CUBnAcut4W+TXaQUbQO4U
 nm51WpWCcWSmbz+8ntVnCr9eWmajta
X-Received: by 2002:a05:6870:21cb:b0:409:ddda:a14b with SMTP id
 586e51a60fabf-41626d84e44mr7899053fac.2.1772496306242; 
 Mon, 02 Mar 2026 16:05:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:15 -0600
Subject: [PATCH 06/14] clk: mediatek: mt8183: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-6-32f45085f4d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23014;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=mOLU415e5uRkeMoaJ1XIQ50fB57UL/B46muZBq2Tiwc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVxbszF25KNjZugPEzISaVIndQj9PID70hPb
 TarJSDp9BmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlcRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AOJMH/0/sj5Qd9p85KYgJ4Zbt1LKC33c7G0H09xbFGH6
 ovUyb2tTfZT3zQv+7mIoiYQvIZxYDq//wSCL2y05QsGos+vHj2QMCJSIV+ZusMNw61CzamKd790
 K/EGH524PLQcDq/UEqpoQ1S577nhlBRxWRlHJFpCApUGZkR3mHoBHT3Lf1wpDrqCrcbsyPAVC/X
 BmHGXNM1YSd/QuwOlfoU4+/qCgp5pT80tr69/rQU96g1HGkHDpHsCDNDtBua7Ih9EQCpAZpGEeV
 46lIQMghm9cYmK0cZ3a5QbaWxjFG7fHlGu+xyeLlFObnxvwBneF9wfMfM/2d5dVSoqHuV7W+M07
 NN+A=
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

