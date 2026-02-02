Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52951E73158
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15E183E8E;
	Mon,  2 Feb 2026 13:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UBmYB+Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D123283EAF; Mon,  2 Feb 2026 13:42:02 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2A783DFF
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3519580f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770036120; x=1770640920;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5xBUZqEnR7AKFlgECEwDcAWY9r27SBu0cB8DrXGGLg=;
 b=UBmYB+BsQFu5Wm8ad8oEjsEmaZ/PVNLJDvYO94wcbhl1iWZoj6l41/xqSGzudvLysm
 WoBqU6nncztStweTTBB1YZ7i7dTnopZxq+ITq2D7hyhRSqZdKsH0/QZZrwBJ/qm3pEoe
 in/tZaz88eeRV+LPWd9O7iG8GOQ/ZzIVPN0xsphNZ1zZX64ABzWiuXMzubhkV7yQ3Ucq
 lOj+JGdHUNXq1Jdp1CwL0y36nS7OBPruwKfD23oK7t75uKdTiqG52DOYgq5gZUTlELOk
 8KM84v9QMiwi2SRYjGOBuG+uoouJZl7krTw4BZShuLLOdTgCRjPqRD1ALJ2qsnzh2U32
 4hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036120; x=1770640920;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t5xBUZqEnR7AKFlgECEwDcAWY9r27SBu0cB8DrXGGLg=;
 b=xTehOMibJLl/yp5+WbMw0kWc0LFulYHhid4oF3k8LVYfiiO6eCsqQa6L+g/305T9ci
 aIqgVPamNivEH+69T6jXCmukjlisl2UE4M39Xr5PxpSBtAbvgSsVqpiiYOsfQqDxuRkl
 MSpwhF5YYOYkVGKM2XIGUezrABVwy9Coe93uKiIhKve+6JUKhd+fEhd0hg9jQCEhrTib
 WGeJIvDpl3gYiKE56S9KEKbK0TD6DLEfPs4Rq09FICU6V2969Xfl2qeeqHXUZLSFMT/M
 2KgdJLihpE8R3jpPWUC8IrOfarEI8XzJ2YrpPFUuZFOt2o82u2T33GRF8Lb/gwbDfG2H
 h3qQ==
X-Gm-Message-State: AOJu0Yw91kzZz8Mi5HBQFcMh2T1+Uliignc7trIM8+L1gIxQsVBEjazm
 2b9KGPgNVpR+MFLPE8flck/ROgBdEnyvF7pBKI0wHYlio27hkbV5vBwfGC0M+La7ONA=
X-Gm-Gg: AZuq6aJDqCt7RItnpT9Fhqk0C2YWU7GNC1eXqRdnS72knZksLNrXiZZPUCQ0DAIHyV1
 rq0Jj4T32QKbZ3C5n+qkMnubAHhTXmlBIVRiil83pe7VqrE3KHdXfUtThlW3VHRd05JfYKeUkGV
 IunCStXGdFb/0DbZ4jeEhbdQcyXoCXMmNbROyFM0pQc7MJxd2aXFShWmMZ6TJphBYvMAYiTFDAm
 mrwhGZP5peKQDBEPI5qxvLJ+byCm5JKkUeEgRUSrysa/M0TmXjLoSVL1l9oIsNzrYqq4K8oE+Uh
 z8jm5+/Ar09ecbfM032nNSakqo7A6emVFHv7gCknLFlLzsyo4hjouxjjKryiVS9m7GLrt4smpFB
 iwNQ3G3fyG1ksyKR8FsgvH5UNhL+oXvvYoko+jhcqdwaHw2KGAlP5Y5JX2xjzAEBwU2xzxTDwZe
 eaEZUzwrBuI9/Fd1XCuBIrQipdf6RUrxCj0Br1IwBq8buolr9Ciswhys87tNKR6ZmBawfp6dkrL
 mJzvjyu9w==
X-Received: by 2002:a05:6000:240e:b0:432:c37c:d83b with SMTP id
 ffacd0b85a97d-435f3a8af45mr18830666f8f.20.1770036120171; 
 Mon, 02 Feb 2026 04:42:00 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm43593588f8f.18.2026.02.02.04.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:41:59 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:41:52 +0100
Subject: [PATCH v2 4/5] clk: mediatek: mt8188: fix some clock parents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-mt8188-fix-clock-v2-4-b39bddfcac66@baylibre.com>
References: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
In-Reply-To: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Fix a number of clock parent definitions for MT8188 clocks.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index c0f68c41d6e..537aa706d4b 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -26,8 +26,6 @@
 #define CLK_TOP_CLK32K		209
 #define CLK_TOP_IMGPLL		210
 #define CLK_TOP_MSDCPLL		211
-#define CLK_TOP_ULPOSC1_CK1	212
-#define CLK_TOP_ULPOSC_CK1	213
 
 /* apmixedsys */
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
@@ -165,21 +163,21 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_MMPLL_D6_D2, CLK_TOP_MMPLL_D6, 1, 2),
 	FACTOR0(CLK_TOP_MMPLL_D7, CLK_APMIXED_MMPLL, 1, 7),
 	FACTOR0(CLK_TOP_MMPLL_D9, CLK_APMIXED_MMPLL, 1, 9),
-	FACTOR1(CLK_TOP_TVDPLL1_D2, CLK_TOP_TVDPLL1, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL1_D4, CLK_TOP_TVDPLL1, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL1_D8, CLK_TOP_TVDPLL1, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL1_D16,  CLK_TOP_TVDPLL1, 1, 16),
-	FACTOR1(CLK_TOP_TVDPLL2_D2, CLK_TOP_TVDPLL2, 1, 2),
-	FACTOR1(CLK_TOP_TVDPLL2_D4, CLK_TOP_TVDPLL2, 1, 4),
-	FACTOR1(CLK_TOP_TVDPLL2_D8, CLK_TOP_TVDPLL2, 1, 8),
-	FACTOR1(CLK_TOP_TVDPLL2_D16, CLK_TOP_TVDPLL2, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL1_D2, CLK_APMIXED_TVDPLL1, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL1_D4, CLK_APMIXED_TVDPLL1, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL1_D8, CLK_APMIXED_TVDPLL1, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL1_D16,  CLK_APMIXED_TVDPLL1, 1, 16),
+	FACTOR0(CLK_TOP_TVDPLL2_D2, CLK_APMIXED_TVDPLL2, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL2_D16, CLK_APMIXED_TVDPLL2, 1, 16),
 	FACTOR0(CLK_TOP_MSDCPLL, CLK_APMIXED_MSDCPLL, 1, 1),
 	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
 	FACTOR0(CLK_TOP_MSDCPLL_D16, CLK_APMIXED_MSDCPLL, 1, 16),
-	FACTOR1(CLK_TOP_ETHPLL_D2, CLK_TOP_ETHPLL, 1, 2),
-	FACTOR1(CLK_TOP_ETHPLL_D4, CLK_TOP_ETHPLL, 1, 4),
-	FACTOR1(CLK_TOP_ETHPLL_D8, CLK_TOP_ETHPLL, 1, 8),
-	FACTOR1(CLK_TOP_ETHPLL_D10, CLK_TOP_ETHPLL, 1, 10),
+	FACTOR0(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2),
+	FACTOR0(CLK_TOP_ETHPLL_D4, CLK_APMIXED_ETHPLL, 1, 4),
+	FACTOR0(CLK_TOP_ETHPLL_D8, CLK_APMIXED_ETHPLL, 1, 8),
+	FACTOR0(CLK_TOP_ETHPLL_D10, CLK_APMIXED_ETHPLL, 1, 10),
 	FACTOR0(CLK_TOP_ADSPPLL_D2, CLK_APMIXED_ADSPPLL, 1, 2),
 	FACTOR0(CLK_TOP_ADSPPLL_D4, CLK_APMIXED_ADSPPLL, 1, 4),
 	FACTOR0(CLK_TOP_ADSPPLL_D8, CLK_APMIXED_ADSPPLL, 1, 8),
@@ -859,7 +857,7 @@ static const int adsp_parents[] = {
 	CLK_TOP_UNIVPLL_D4_D4,
 	CLK_TOP_UNIVPLL_D4,
 	CLK_TOP_ULPOSC1_D2,
-	CLK_TOP_ULPOSC1_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ADSPPLL,
 	CLK_TOP_ADSPPLL_D2,
 	CLK_TOP_ADSPPLL_D4,
@@ -876,7 +874,7 @@ static const int audio_local_bus_parents[] = {
 	CLK_TOP_MAINPLL_D7,
 	CLK_TOP_MAINPLL_D4,
 	CLK_TOP_UNIVPLL_D6,
-	CLK_TOP_ULPOSC1_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ULPOSC1_D4,
 	CLK_TOP_ULPOSC1_D2
 };
@@ -1015,7 +1013,7 @@ static const int spinor_parents[] = {
 };
 
 static const int ulposc_parents[] = {
-	CLK_TOP_ULPOSC_CK1,
+	CLK_TOP_ULPOSC1,
 	CLK_TOP_ETHPLL_D2,
 	CLK_TOP_MAINPLL_D4_D2,
 	CLK_TOP_ETHPLL_D10
@@ -1356,8 +1354,6 @@ static const int mt8188_id_offs_map[] = {
 	8, /* CLK_TOP_CLK32K */
 	-1, /* CLK_TOP_IMGPLL */
 	72, /* CLK_TOP_MSDCPLL */
-	-1, /* CLK_TOP_ULPOSC1_CK1 */
-	-1, /* CLK_TOP_ULPOSC_CK1 */
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {

-- 
2.52.0

