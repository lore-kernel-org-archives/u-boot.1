Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B84D72361
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 09:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9311083B6C;
	Fri, 23 Jan 2026 10:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CLRnmxcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD6883B6C; Fri, 23 Jan 2026 10:41:14 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1A383B27
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso9594375e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769161272; x=1769766072;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9kXYwov9WAG7I9PqU/TkEUSs26iaP6f6BGQLmiZCz1E=;
 b=CLRnmxcyKMs1UuyV3AFu+BVSdF2UhBnpzet7A4x3FSIgcjjvQZZOzCpZtUQENFDhPL
 Kj7ot1spi+hRqv6J9J93bhx9S2QHoJMO9t03vAgdW0XcnQ6raLISKTUcc8SaylU0JqlG
 6F1SX2kESMOqVxBTzeSTXfDE0XFfZL2kN/GInO/1B+n3VJLwP/HSaY24We0UkLgoNe/4
 gUKxpT2XKpAjrWT5tlIAlADtzI/w4kmrrGf5qRzCBjpguwyWkcfICj4Pmg5yyoEwK0hP
 KIJk3/WJqHS+vKgv1GI953KyHIDz9Hx7qxmRVOH7cKJM3cj7p1lmAFVpXObfsIVc6r1l
 pq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769161272; x=1769766072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9kXYwov9WAG7I9PqU/TkEUSs26iaP6f6BGQLmiZCz1E=;
 b=w/afmDaUWnK5sfvdK/yGlG4r5U/Y6aT5u88Jx7jxWfNpyBnwHhyWDM5L+LrxpWKTAq
 teH1DlHTZltFOG2A9EQ9iYS+khNeaIm50lfcx/3DTXgJRUPgV0xffN/xMaEzEyX5Lco9
 xDSyLC04R1wdq7sOK/XFNsDT4K3182py82i7DCasTVDhjxgTp1LYmCjx+XicsUUwWg6m
 c+UFBUhFtaxQC6XzusiWbQRZk4SMG0EeB5+ezJlLONUQCb0zqTpYCO3yhrOzU/BqaB9C
 GlotGgN6m8AfGejbR97ToB0BOWGuVUXUiqOMy8LSSeEss8tUfph3gvPOW4wXM3Fk4SUd
 e5kQ==
X-Gm-Message-State: AOJu0YzpU4QqzSJMZaA1HENFk5YHvfUdAqinGneAEdJ06IrVw2Xn9Zzr
 8X4rP72NtIF7Sf58NflWjzGZBdDzBmLwcXEFT0WwgEMv74drb0g9cmlwrJ3V7ixH1wc=
X-Gm-Gg: AZuq6aLbfbQWMMIjWoDGBQLEQweO+U9nrXFK1Lw+PXmz6cRyF00YDAAV6LcPgRVeomO
 sfCL4q47rFQ6He/xWh5wUsrHfTHXLpjSeRRWlzUn6+E+7txRm3ovl0sBrgF+kVL+Uc57IImW5vg
 gG8eqcClNQHp8rE5BisKWCtqXhnRNqJuQXQUWiaRYaBrGYzxYJFK4PB2nGwV8HKHp/mZ06N/U0I
 ednwFgpAFgEmIfNNa1SXwtNjvW9HRT9HScHPL8pNeJjFPx1n1D6ffUkKffJ1Su9DWvS2z0TGxzU
 oFc0PaCn8gHv6v0genHYLPzEJeMKkrTswnEwI9sI5q1VTPuF5cDL82BXzHq7qSAOOYrGb1w5JK1
 PpmK9JFHNdcvFJykIX2UXdhunfPz5e/OOfyU6tyVfrucmQJXCrMGt60H/R+1pD26HlC8sjOxHzf
 JGNJ1m6TMn5aXe8mgZ41XcIDfjzj+T645hWsMDVX/nxGRlEtXDHYhpc8DdB5s5dwIe5IalJ5D0Z
 4IymbGfsQ==
X-Received: by 2002:a05:600c:4fd6:b0:480:4a5a:bd53 with SMTP id
 5b1f17b1804b1-4804c9affe2mr39316685e9.21.1769161271777; 
 Fri, 23 Jan 2026 01:41:11 -0800 (PST)
Received: from [192.168.1.60]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm5147411f8f.20.2026.01.23.01.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 01:41:11 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 23 Jan 2026 10:41:10 +0100
Subject: [PATCH 2/5] clk: mediatek: mt8188: fix circular clock dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-mt8188-fix-clock-v1-2-e355352bf405@baylibre.com>
References: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
In-Reply-To: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
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

