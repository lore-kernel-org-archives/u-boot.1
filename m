Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75241EEC2AB
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9969083C5E;
	Tue, 24 Feb 2026 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y270YvqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD8383981; Tue, 24 Feb 2026 00:23:04 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C929D83E21
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso2984527a34.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888975; x=1772493775;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZlcTgVVncjdAOJO5d4N/CtnzUmwO6bo6HTEtyVxRUyI=;
 b=Y270YvqIujV0CWtmzsFnBqLF5RTnXEVueVKEyztH+vOuqTxe3RBhXcLVB3HU8KA2PO
 Bzao0rtlrW8NChMimAaVR6yAXj1vpPsS5PIoWZJhBFbzlQ+n/QTs+D3Nqb3jkHwr8MHM
 NDUKvf8tAK6Au8kdAbW2kwpFH5LRg+JJ4nfA0Q+HkgeBcucSK+uwqD09OBvA0G+WIUng
 /Z1nS+sMhn5WVN+Kwunk+hgtCM8kU6WVPhMYNe8vF0ipGCn481U433rQyoHyRRaDAtgO
 URasqgjIGBUatlk8djI7uT1jPfxg6aetJIQyV/W2/hxo2ep/ivE601Nj9jdKvOsQXkNt
 1fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888975; x=1772493775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZlcTgVVncjdAOJO5d4N/CtnzUmwO6bo6HTEtyVxRUyI=;
 b=IQsltQ0VQzvMyXiaXQE2NCr5f1Z5kIpPY9XNibqa+fmi8SratKFumEu54uFhRG6WaA
 RCcFJ/Er1a6/R4T7U8pLFFz4OyIMYOQrYX9KDJkJ3EzdRxq3/k1PhljaNQSM8UEcX/lA
 FiQ+0/t9qzrnVoQu7KpgYd/Fu5X4qgXM6Csx7WfJHAO+Vj5AWDOosgMF82r5E6M/E/XI
 ALfOXik5+V3ZVvKH1RLZ/VPz9v9ll3BHPwHga4oWWf6/H9fttLqvZrSo2TcSvWt92Saf
 GzrvMwfIpgzFR3/2pFOx0Q9kjOnRVCMySGXIrzbp30PM2ZQljt47IuEh0NuuBQ9dSo1p
 9KVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFQz4ZO/lhnVchXkohSj0Pr095P2PGiPjk6CSZu+ga0Neo0ISP4zvhyOkSKT7CsL6m4ZcU0bw=@lists.denx.de
X-Gm-Message-State: AOJu0YzkzkNQQKe+45gJgpAZNaPDdo0mt7WDiCEjAqS5V1z6KR2V62yv
 3XCYrJUQs6kJypQsdRbFBjh265dH471v5qJLNMRVzAJNPcgFBg+GgNs789ts4CjMU34=
X-Gm-Gg: AZuq6aKdDskAXpQ8tpYC6HSRJKuMyTlOItnTh9HdiWrmWmoN+cdLskRPXKYSgBKE+FE
 Z/WfroerOWdNNQR8DAFlHVWd0LM7xBGHnHbyvWXYZ1qYpfvdd1HRIb+Z3hzb+fiwEKKeHfioS+E
 jc7U+nijWb4rI2euMVHbOS5zAwNmDrHKPj9IUhXLwCb3Y98pz9HIpe4EXVnW4pe+AyFUOjrrV0a
 cqhsxCwA7VWow7hchB5DMRLLwAz/dJiMCt/A0GGpYTPp0zp48G+foQi/wLzXBLDXJM+fvbcgjGX
 TJkKMDvtroU+iZv3ihI9hRUKzC7W9xANDkj1lGqnlOmdwyPiYAzyNj+raktlUwAHHszY4LFy5Zj
 5djBaXvjBjZuw2Z7czIvi/i9jRfe+OyBwFLxUTbN73IBBaO1Ufr5BlbpL/zxmePx2ql8HE7D+IF
 QMxHatu/QDTjBE47joXc5QAZkaXzQu
X-Received: by 2002:a05:6830:6586:b0:7cf:da97:57d5 with SMTP id
 46e09a7af769-7d52bf52c4bmr5618101a34.34.1771888975491; 
 Mon, 23 Feb 2026 15:22:55 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 17:21:57 -0600
Subject: [PATCH 5/7] clk: mediatek: mt7623: change to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-5-a7dc97bc2660@baylibre.com>
References: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
In-Reply-To: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23673;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=zAC3Qr95qKAMaOrAv9quIxy50D9dXRXW9QqB153iKa0=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOE1HR7f+p0AJJOAPb97Y++nWLMJ7FxFxPo3P
 pyJXtn97SOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhNRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQo0H/2YMgGhJm/o3puvPeU/Zp5B1yD8MhQabroWo8Oe
 /COagiF3t3iNcAqWQRTsUMcwyHhARyVYaNHhZXQM/hTGIRlovFPIVSoIyEdKXCHPRFW+t7stDf3
 HFXIU0wzAWg9rR5KutmFBr4K643WVP15AOIDKvYwVs1A4P92Wrj995+DBULnHctAhfNlhVhRBVo
 ZkAXnH6hwoIM5XM22MTaglyzfgDkfrHU/RTe13gaHY8v6emTp/w4BGnUG8Q44fq6pDMLAmIxM6k
 nVOWlYdIbWiNGSjJfOBztwFfDLdHFg8zODQaAUxfA0RrdQOyjUZ7RcGF6jXfZH3PAgM+TUuJgWD
 yFvc=
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

Change mux parents to use struct mtk_parent instead of int. Since these
clocks have mixed parents, we should be using struct mtk_parent which
specifically handles this case.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 777 +++++++++++++++++++-------------------
 1 file changed, 390 insertions(+), 387 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index d62b9651fa6..dfe6f5e113e 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -375,399 +375,402 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_8BDAC, CLK_TOP_UNIVPLL_D2, 1, 1),
 };
 
-static const int axi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_MMPLL_D2,
-	CLK_TOP_DMPLL_D2
-};
-
-static const int mem_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_DMPLL
-};
-
-static const int ddrphycfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8
-};
-
-static const int mm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_DMPLL
-};
-
-static const int pwm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL1_D4
-};
-
-static const int vdec_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VDECPLL,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_MMPLL_D2
-};
-
-static const int mfg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MMPLL,
-	CLK_TOP_DMPLL_X2,
-	CLK_TOP_MSDCPLL,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_TOP_UNIVPLL_D3,
-	CLK_TOP_UNIVPLL1_D2
-};
-
-static const int camtg_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_MMPLL_D2
-};
-
-static const int uart_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D8
-};
-
-static const int spi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL1_D8
-};
-
-static const int usb20_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL1_D8,
-	CLK_TOP_UNIVPLL3_D4
-};
-
-static const int msdc30_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MSDCPLL_D2,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL1_D4,
-	CLK_TOP_UNIVPLL2_D4,
-};
-
-static const int aud_intbus_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int pmicspi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_DMPLL_D2,
-	CLK_TOP_DMPLL_D4
-};
-
-static const int scp_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_DMPLL_D2,
-	CLK_TOP_DMPLL_D4
-};
-
-static const int dpi0_tve_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MIPIPLL,
-	CLK_TOP_MIPIPLL_D2,
-	CLK_TOP_MIPIPLL_D4,
-	CLK_XTAL,
-	CLK_TOP_TVDPLL,
-	CLK_TOP_TVDPLL_D2,
-	CLK_TOP_TVDPLL_D4
-};
-
-static const int dpi1_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_TVDPLL,
-	CLK_TOP_TVDPLL_D2,
-	CLK_TOP_TVDPLL_D4
-};
-
-static const int hdmi_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_HDMIPLL,
-	CLK_TOP_HDMIPLL_D2,
-	CLK_TOP_HDMIPLL_D3
-};
-
-static const int apll_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUDPLL,
-	CLK_TOP_AUDPLL_D4,
-	CLK_TOP_AUDPLL_D8,
-	CLK_TOP_AUDPLL_D16,
-	CLK_TOP_AUDPLL_D24,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int rtc_parents[] = {
-	CLK_TOP_32K_INTERNAL,
-	CLK_TOP_32K_EXTERNAL,
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D8
-};
-
-static const int nfi2x_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL_D7,
-	CLK_TOP_UNIVPLL3_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL4_D4,
-	CLK_XTAL
-};
-
-static const int emmc_hclk_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL2_D2
-};
-
-static const int flash_parents[] = {
-	CLK_TOP_CLK26M_D8,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL2_D8,
-	CLK_TOP_SYSPLL3_D4,
-	CLK_TOP_UNIVPLL3_D4,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_UNIVPLL2_D4
-};
-
-static const int di_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_TVD2PLL,
-	CLK_TOP_TVD2PLL_D2,
-	CLK_XTAL
-};
-
-static const int nr_osd_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_VENCPLL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_DMPLL
-};
-
-static const int hdmirx_bist_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL_D3,
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D16,
-	CLK_TOP_SYSPLL4_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_VENCPLL,
-	CLK_XTAL
-};
-
-static const int intdir_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_MMPLL,
-	CLK_TOP_SYSPLL_D2,
-	CLK_TOP_UNIVPLL_D2
-};
-
-static const int asm_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL2_D4,
-	CLK_TOP_UNIVPLL2_D2,
-	CLK_TOP_SYSPLL_D5
-};
-
-static const int ms_card_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL3_D8,
-	CLK_TOP_SYSPLL4_D4
-};
-
-static const int ethif_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_DMPLL,
-	CLK_TOP_DMPLL_D2
-};
-
-static const int hdmirx_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D52
-};
-
-static const int cmsys_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_SYSPLL1_D2,
-	CLK_TOP_UNIVPLL1_D2,
-	CLK_TOP_UNIVPLL_D5,
-	CLK_TOP_SYSPLL_D5,
-	CLK_TOP_SYSPLL2_D2,
-	CLK_TOP_SYSPLL1_D4,
-	CLK_TOP_SYSPLL3_D2,
-	CLK_TOP_SYSPLL2_D4,
-	CLK_TOP_SYSPLL1_D8,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int clk_8bdac_parents[] = {
-	CLK_TOP_32K_INTERNAL,
-	CLK_TOP_8BDAC,
-	CLK_XTAL,
-	CLK_XTAL
-};
-
-static const int aud2dvd_parents[] = {
-	CLK_TOP_AUD_48K_TIMING,
-	CLK_TOP_AUD_44K_TIMING
-};
-
-static const int padmclk_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_UNIVPLL_D26,
-	CLK_TOP_UNIVPLL_D52,
-	CLK_TOP_UNIVPLL_D108,
-	CLK_TOP_UNIVPLL2_D8,
-	CLK_TOP_UNIVPLL2_D16,
-	CLK_TOP_UNIVPLL2_D32
-};
+#define XTAL_PARENT(id)		PARENT(id, CLK_PARENT_XTAL)
+#define TOP_PARENT(id)		PARENT(id, CLK_PARENT_TOPCKGEN)
 
-static const int aud_mux_parents[] = {
-	CLK_XTAL,
-	CLK_TOP_AUD1PLL_98M,
-	CLK_TOP_AUD2PLL_90M,
-	CLK_TOP_HADDS2PLL_98M,
-	CLK_TOP_AUD_EXTCK1_DIV,
-	CLK_TOP_AUD_EXTCK2_DIV
+static const struct mtk_parent axi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+};
+
+static const struct mtk_parent mem_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent ddrphycfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+};
+
+static const struct mtk_parent mm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+};
+
+static const struct mtk_parent vdec_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VDECPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent mfg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_DMPLL_X2),
+	TOP_PARENT(CLK_TOP_MSDCPLL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+};
+
+static const struct mtk_parent camtg_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D2),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+};
+
+static const struct mtk_parent spi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+};
+
+static const struct mtk_parent usb20_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+};
+
+static const struct mtk_parent msdc30_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent pmicspi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
+
+static const struct mtk_parent scp_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+	TOP_PARENT(CLK_TOP_DMPLL_D4),
+};
+
+static const struct mtk_parent dpi0_tve_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MIPIPLL),
+	TOP_PARENT(CLK_TOP_MIPIPLL_D2),
+	TOP_PARENT(CLK_TOP_MIPIPLL_D4),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVDPLL),
+	TOP_PARENT(CLK_TOP_TVDPLL_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL_D4),
+};
+
+static const struct mtk_parent dpi1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVDPLL),
+	TOP_PARENT(CLK_TOP_TVDPLL_D2),
+	TOP_PARENT(CLK_TOP_TVDPLL_D4),
+};
+
+static const struct mtk_parent hdmi_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_HDMIPLL),
+	TOP_PARENT(CLK_TOP_HDMIPLL_D2),
+	TOP_PARENT(CLK_TOP_HDMIPLL_D3),
+};
+
+static const struct mtk_parent apll_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUDPLL),
+	TOP_PARENT(CLK_TOP_AUDPLL_D4),
+	TOP_PARENT(CLK_TOP_AUDPLL_D8),
+	TOP_PARENT(CLK_TOP_AUDPLL_D16),
+	TOP_PARENT(CLK_TOP_AUDPLL_D24),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent rtc_parents[] = {
+	TOP_PARENT(CLK_TOP_32K_INTERNAL),
+	TOP_PARENT(CLK_TOP_32K_EXTERNAL),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
+};
+
+static const struct mtk_parent nfi2x_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent emmc_hclk_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+};
+
+static const struct mtk_parent flash_parents[] = {
+	TOP_PARENT(CLK_TOP_CLK26M_D8),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+};
+
+static const struct mtk_parent di_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_TVD2PLL),
+	TOP_PARENT(CLK_TOP_TVD2PLL_D2),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent nr_osd_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+};
+
+static const struct mtk_parent hdmirx_bist_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D3),
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D16),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_VENCPLL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent intdir_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_MMPLL),
+	TOP_PARENT(CLK_TOP_SYSPLL_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D2),
+};
+
+static const struct mtk_parent asm_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+};
+
+static const struct mtk_parent ms_card_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL3_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL4_D4),
+};
+
+static const struct mtk_parent ethif_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_DMPLL),
+	TOP_PARENT(CLK_TOP_DMPLL_D2),
+};
+
+static const struct mtk_parent hdmirx_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
+};
+
+static const struct mtk_parent cmsys_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL_D5),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL3_D2),
+	TOP_PARENT(CLK_TOP_SYSPLL2_D4),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent clk_8bdac_parents[] = {
+	TOP_PARENT(CLK_TOP_32K_INTERNAL),
+	TOP_PARENT(CLK_TOP_8BDAC),
+	XTAL_PARENT(CLK_XTAL),
+	XTAL_PARENT(CLK_XTAL),
+};
+
+static const struct mtk_parent aud2dvd_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD_48K_TIMING),
+	TOP_PARENT(CLK_TOP_AUD_44K_TIMING),
+};
+
+static const struct mtk_parent padmclk_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D26),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D52),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D108),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL2_D32),
+};
+
+static const struct mtk_parent aud_mux_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	TOP_PARENT(CLK_TOP_AUD1PLL_98M),
+	TOP_PARENT(CLK_TOP_AUD2PLL_90M),
+	TOP_PARENT(CLK_TOP_HADDS2PLL_98M),
+	TOP_PARENT(CLK_TOP_AUD_EXTCK1_DIV),
+	TOP_PARENT(CLK_TOP_AUD_EXTCK2_DIV),
 };
 
-static const int aud_src_parents[] = {
-	CLK_TOP_AUD_MUX1_SEL,
-	CLK_TOP_AUD_MUX2_SEL
+static const struct mtk_parent aud_src_parents[] = {
+	TOP_PARENT(CLK_TOP_AUD_MUX1_SEL),
+	TOP_PARENT(CLK_TOP_AUD_MUX2_SEL),
 };
 
 static const struct mtk_composite top_muxes[] = {
-	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
-		       CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
-	MUX_GATE_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
-		       CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
-	MUX_GATE(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
-	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
-	MUX_GATE(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
-	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
-	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
-	MUX_GATE(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
-
-	MUX_GATE(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
-	MUX_GATE(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
-	MUX_GATE(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
-
-	MUX_GATE(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
-
-	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
-	MUX_GATE(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
-	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
-
-	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
-	MUX_GATE_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
-		       CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
-	MUX_GATE(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
-	MUX_GATE(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
-
-	MUX_GATE(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
-	MUX_GATE(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
-	MUX_GATE(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
-
-	MUX(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
-
-	MUX(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
-	MUX(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
-	MUX(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
-
-	MUX_GATE(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
-	MUX_GATE(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
-	MUX_GATE(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
-	MUX_GATE(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
-	MUX_GATE(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
-	MUX_GATE(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
+	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
+			     CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
+			     CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE_MIXED(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
+	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
+
+	MUX_GATE_MIXED(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
+	MUX_GATE_MIXED(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
+	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
+
+	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
+	MUX_GATE_MIXED(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
+	MUX_GATE_MIXED_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
+			     CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE_MIXED(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
+	MUX_GATE_MIXED(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
+	MUX_GATE_MIXED(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
+
+	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
+	MUX_GATE_MIXED(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
+	MUX_GATE_MIXED(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
+	MUX_GATE_MIXED(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
+
+	MUX_MIXED(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
+
+	MUX_MIXED(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
+	MUX_MIXED(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
+	MUX_MIXED(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
+
+	MUX_GATE_MIXED(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
+	MUX_GATE_MIXED(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
 };
 
 /* infracfg */

-- 
2.43.0

