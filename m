Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925D0C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B20C4075D;
	Tue,  4 Aug 2026 22:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id voptUTO3qQkN; Tue,  4 Aug 2026 22:33:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95F2740748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882786;
	bh=WJVrQQkgIl0VoAoqz8WMkrQopowH4xY2Vj+zn0q6Zkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vn15P9uRTfbLmLOVaLxx9/CC5KvSNORJpav89z4IiaIaG3vmOoovJnHxLNnd4rJiZ
	 P5abv7/oOYP030znqPDSTXFs/7TJleAbA8QDSOVi4Dbv5L6EdtFNvAHKq1sBp0M0LD
	 f1Rv9dPdUu7FOaJ8XAvqtAX7Fi4xO6Fq7TqEANpDQJscu64aDQEIgjoxyp6uJxs0ds
	 7VkKiuxgcp8LL4XMG33BXXZDn7YS3bDZtNUX4s7ylnubQfr5Mm8UIDyVJxjnCUtxPv
	 zO2NzD2Ih3qq+KOv8T6ciITCzzggmqc6Zm827sLLMZzwPt1Oaa6fYXDrR+XHgn/AD1
	 htSROQ4pKwQ4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95F2740748;
	Tue,  4 Aug 2026 22:33:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78F5E218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ACE540731
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9uy2GJJ4gas for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B3F2640506
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3F2640506
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3F2640506
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:02 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6acb63301acso340245eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882781; x=1786487581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WJVrQQkgIl0VoAoqz8WMkrQopowH4xY2Vj+zn0q6Zkg=;
 b=nVGHMZXGClc2CkGfvSI35RNr9NpRd3wfvvvj5MeplbHzuUqVOMNH097MOn8hP8nrLG
 pRa1yZed7HHJpQ/dZNRM0ljZ9/DeENZduPvk6TfBPAWLfwEzjLQlxG+F87u6AbSqRQih
 xXE9TVAKe/3zVm+HozmDOYclXJNZa9qnEteF5V4AqxHx12BrVzoRPOHuD/QKPkuHz75c
 pDcK/u4tTxi0W4Ab20PdGV9JiTo/bWeSU1dPL5vJ6SlmtnLgQ/4lVwkrCRGYb9A6/cxq
 ej20pGdfFc64kKrptUDTwq+QPhFz2fXNVsdUuYbrlE5BoYfsCkDQ7U9goQvbM7EkBeY1
 1oEQ==
X-Gm-Message-State: AOJu0Yz8L6eaJ+D6sAyPcxQEaEtvYsXd1YfxXT1xczgQiTF7/Jjg6BCV
 p+VR3LXyVkyvyJMHRzjz7LQpnWVytyZTr655QgdXw8xYEYR7M549hyU2bcBEhUQE2Xc=
X-Gm-Gg: AR+sD12/1Xk3yRHX64Tkn1N6xAbK39izfD9L6ZEQCe2DpytN7JLomdQOC59aFjwVgqM
 L/XlTelTs9qoQZP2RBgXXKSk6d/VYDmWPpMEo8Xmm2KO2GepfQPgPqsnw6Xa9E95QiCM88gt+Cr
 5HoPKjhYYzNBjZ8KxvANh81ZZp/BHeMQrBhW4ETHVRFtBSXtahJxo4h1QWPVF7G5B29GlVQT3HL
 /Q0eNllflprlL+fW5v/lL4GJY75KDk7v116RQ6qFkRr6Jls4hKiodO9r3gZw/NFCM9O8HhEIc/6
 E+taqtLvZotU6nTTZ1NndkD2X3u6YQCoBAIpQshFchUcE33JBwUoCBwAYCGI6q1UYkGM+gjur+9
 FD8UJosGHWnUqsUbOfGTYqpis7udTGxRbhp3x6rLmuGONq/gCPSJD3swW9edXMJK0kIbHTIYWba
 ZByMm6p3F2ibiYIfYnN5wk67mrd13FoCSaQ66lyZyRLnMwHh4t/8+B8VBwz1+Yrmldck6sgezm5
 o2e
X-Received: by 2002:a4a:e90c:0:b0:6a1:60cd:9860 with SMTP id
 006d021491bc7-6ae968659famr1022917eaf.10.1785882781419; 
 Tue, 04 Aug 2026 15:33:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:33:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 04 Aug 2026 17:32:02 -0500
Subject: [PATCH 2/7] power: pmic: mtk-pwrap: fix clock names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-mtk-pmic-mt6366-v1-2-f3b36b8a1a47@baylibre.com>
References: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
In-Reply-To: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/TFBXnbBFJOBvzffVHQhL4XzuUNLnmrEQeN7L0LruZE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmhxYLMVWi3dJ5p33xcDxkrR4Pj6UZePKRcgg
 V0Djevy3+6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJocRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxmwIAIGi1rUxGyVoSkr6uSaH7x8e63gMr/rnROKJlFk
 wzODpsDeuOTIC2BG119ImA8SJrAVpQQl0R/8yCWsVys60pa+jc8YSq3KUSFqxB4+CIr9848TnoL
 eSOKCL0BrhczjzkyOdPDQg5D4x0L1UOm3iBgOjWRl4kpe3QZFk+yuC+y4DE/fGTnhsH/axtU6N3
 HySqztFfRRu9Ae0qulgZAy8OOlWM3QKJYf1r5ROc7aTfFTTybWIeBCkr6X1LLy6N+nOlNqdSkte
 MGw55NTLpc+TOLt8xomRU9iJfoJVJ5lTV5JnEB0A0FTxXZ9+a0ElxNJD75XkWkABbNcr7NiWlJf
 79u4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882781; x=1786487581;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJVrQQkgIl0VoAoqz8WMkrQopowH4xY2Vj+zn0q6Zkg=;
 b=fz9svB+ZrJDC7TWPmNhNvA2m1GMSKetQrbVEJycvKHnkzZMtGkP5pPEXEOaqLzroKN
 KW5Y5XNKCpvNQOzEsCFfbtbi6dIHlG1tdj/v6euv8JvM8+exus7H7LsLp5m0Dqik2vfw
 2mzwjta1TVdUjVdCUoWvQ5oIwuV0m9Zma8OQx1tsyCcOfWzy8FGRzm8Yxi2jEesHtkYE
 PtlfYomrIaVa/qSeYM9wXQJ6XqH24sqjkcOJs91VpJ7g5hUobTqGPOuHAymqAlF/pmtG
 d9I+dATXkszd8X7yCoFx4IPC/ojtJjRs8S45HBwp40HvS4KFGYMkPF0afH2Z0q9ee2HY
 WPQg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fz9svB+Z
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Change clock names to match the upstream devicetree bindings. There
are no known devicetrees using these wrong names.

Fixes: 219c05f3f68e ("power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 47347785519..f648a784019 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -720,8 +720,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	if (IS_ERR(wrp->clk_wrap))
 		return PTR_ERR(wrp->clk_wrap);
 
-	wrp->clk_wrap_sys = devm_clk_get_optional(dev, "wrap_sys");
-	wrp->clk_wrap_tmr = devm_clk_get_optional(dev, "wrap_tmr");
+	wrp->clk_wrap_sys = devm_clk_get_optional(dev, "sys");
+	wrp->clk_wrap_tmr = devm_clk_get_optional(dev, "tmr");
 
 	ret = clk_enable(wrp->clk_spi);
 	if (ret)

-- 
2.43.0

