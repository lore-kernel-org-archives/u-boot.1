Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7AE7315E
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C80483E96;
	Mon,  2 Feb 2026 13:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QL4i4ZI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DCE83E69; Mon,  2 Feb 2026 13:42:01 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5735B83E69
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso3379363f8f.2
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770036119; x=1770640919;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9kXYwov9WAG7I9PqU/TkEUSs26iaP6f6BGQLmiZCz1E=;
 b=QL4i4ZI0nKhSrsRkyQ9UY/1dcDzrkIVfTKQMu1gkMUiYXWYOdfD7JtFnIlISkraCZO
 jGCnrSQJTOhNnElSzh7JOX5Y84vFoRcuWseBVBeelbrbCGN97opK3Z3q2Rv/FRUNABxJ
 /hSpzz21A1ghRJMo7PT4bl9dwBqK220JSOaGQLGTl6iYlAyeE+cSJQUTDpGSluNDyICQ
 T6IiGCJVWjfsVkNQJN+erOWf3mnm4NXfv4X4Q47wqUTX9WESSY5Mv1hyRYbQYxJn8MIz
 FtSLUKYTt9azCkhJyp0fWH0hZIJA15RHWxkuxqS/n+vZu/jSgK+zkeGf+6+QJ2r+/V+6
 XcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036119; x=1770640919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9kXYwov9WAG7I9PqU/TkEUSs26iaP6f6BGQLmiZCz1E=;
 b=hl333QZ4Q6yISe1ZxXl3UsntsmKkVfD6NI/iKbMBhhHHbfigyq2UhvGPghCzLAfVZi
 rUwW/Qglx17rHtm7EMQqNS1r0/jeRFS2wQTV6IYCCC82DvrDzCtjx+B47PLWfYuaYz/m
 TMzt4gZN14T15Y97CN3Gh3YP4SudL4WgUvcyGfO42do+XL+nVkVAWIhu4qeF0WrZeIIO
 ca+1MPF0FKkUSlcqFzzOQtx67zOPtIl3KTzzu15yvlb0lS9AKH9oXOxBIkE/5VsWdruI
 byfS4hFfhMZwE9jxklio9cZc9JhCbxHI6q30MzzqkT4aDQcR/6Jb1lpuFSp7MfyZ7oFf
 0V8w==
X-Gm-Message-State: AOJu0YxrNvL+tapfmEHQjkDPqJ5Pp8Wief3gmpNQcjmtqYjHRCc5MDDp
 zXFuj8v3eUJLs8OarRCEqrCiD3/3oYOrmdx4RqoySpmnICI8CUrTvI23GMPk9a1XWKo=
X-Gm-Gg: AZuq6aJpOtTQOezvw7Ns0CpCSkAHlRj/N7cRXzJglEJcfhKRa7vcXMttXV1L/vtAycl
 Yk2hJoL9PTIzotkaeq2lOy0jYTjnXhJdmYVO8FFr3fExaCaAjrY3IC6BlWHbzAtLr73xKvYaIZ+
 YxCgg0hQY0UfVNRqB4IJ3aEEG9PVuvQBTmFRH2cXhrYsC1C2Oxp3U68vmfdsTN6zbZcJ4McosjA
 3KTvaufZgE18nXh13DCSdkI2bvulnRzkZEZPiP+/rjGGWaSK3QF31FkOGdqbkoK4QogBLQCxrT/
 77VNECfoC3V/NJPmU9xjuCAZa22T0n/ecnK6fMWm4GtkVZVlsyzD52VACVXZl9OoZHxTEjty5i+
 Q1LT2dtFxizLYbqtz77jF6IDaAvfElPLde7acE+SektlsY5dz/kLjZH/kF+JQOPn07Y8lv3jAUV
 h7tBIHdWrsDAPnNb9XkiBkcdT/WrPYYzKxU9FEfIubE3eiER0F7tNPpw9MD8h9gzaSKRvtH5CsS
 tMZ2O5OQA==
X-Received: by 2002:a05:6000:26c9:b0:435:9756:d4c4 with SMTP id
 ffacd0b85a97d-435f3a7bcd0mr15989893f8f.17.1770036118769; 
 Mon, 02 Feb 2026 04:41:58 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm43593588f8f.18.2026.02.02.04.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:41:58 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:41:50 +0100
Subject: [PATCH v2 2/5] clk: mediatek: mt8188: fix circular clock
 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-mt8188-fix-clock-v2-2-b39bddfcac66@baylibre.com>
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

FACTOR1(CLK_TOP_APLL1_D4, CLK_TOP_APLL1, 1, 3)
--> CLK_TOP_APLL1_D4 declares CLK_TOP_APLL1 as it's parents

MUX_GATE(CLK_TOP_APLL1, apll1_parents, 0x0F8, 0, 4, 7)
--> CLK_TOP_APLL1 declares apll1_parents as it's parents

static const int apll1_parents[] = {
	CLK_TOP_CLK26M,
	CLK_TOP_APLL1_D4
};
--> CLK_TOP_APLL1_D4 is a parent of CLK_TOP_APLL1

Fix this, by correctly setting CLK_TOP_APLL1_DX parent to CLK_APMIXED_APLLX

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 4317dd253bb..f306cce1f5b 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -148,13 +148,13 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR1(CLK_TOP_UNIVPLL_192M_D10, CLK_TOP_UNIVPLL_192M, 1, 10),
 	FACTOR1(CLK_TOP_UNIVPLL_192M_D16, CLK_TOP_UNIVPLL_192M, 1, 16),
 	FACTOR1(CLK_TOP_UNIVPLL_192M_D32, CLK_TOP_UNIVPLL_192M, 1, 32),
-	FACTOR1(CLK_TOP_APLL1_D3, CLK_TOP_APLL1, 1, 3),
-	FACTOR1(CLK_TOP_APLL1_D4, CLK_TOP_APLL1, 1, 4),
-	FACTOR1(CLK_TOP_APLL2_D3, CLK_TOP_APLL2, 1, 3),
-	FACTOR1(CLK_TOP_APLL2_D4, CLK_TOP_APLL2, 1, 4),
-	FACTOR1(CLK_TOP_APLL3_D4, CLK_TOP_APLL3, 1, 4),
-	FACTOR1(CLK_TOP_APLL4_D4, CLK_TOP_APLL4, 1, 4),
-	FACTOR1(CLK_TOP_APLL5_D4, CLK_TOP_APLL5, 1, 4),
+	FACTOR0(CLK_TOP_APLL1_D3, CLK_APMIXED_APLL1, 1, 3),
+	FACTOR0(CLK_TOP_APLL1_D4, CLK_APMIXED_APLL1, 1, 4),
+	FACTOR0(CLK_TOP_APLL2_D3, CLK_APMIXED_APLL2, 1, 3),
+	FACTOR0(CLK_TOP_APLL2_D4, CLK_APMIXED_APLL2, 1, 4),
+	FACTOR0(CLK_TOP_APLL3_D4, CLK_APMIXED_APLL3, 1, 4),
+	FACTOR0(CLK_TOP_APLL4_D4, CLK_APMIXED_APLL4, 1, 4),
+	FACTOR0(CLK_TOP_APLL5_D4, CLK_APMIXED_APLL5, 1, 4),
 	FACTOR0(CLK_TOP_MMPLL_D4, CLK_APMIXED_MMPLL, 1, 4),
 	FACTOR1(CLK_TOP_MMPLL_D4_D2, CLK_TOP_MMPLL_D4, 1, 2),
 	FACTOR0(CLK_TOP_MMPLL_D5, CLK_APMIXED_MMPLL, 1, 5),

-- 
2.52.0

