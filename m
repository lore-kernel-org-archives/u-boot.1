Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E329C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA23684A06;
	Tue,  7 Jul 2026 17:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cd9tN+qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BAC8494B; Tue,  7 Jul 2026 17:10:31 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C588496E
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6a149bfb2a8so1929409eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783437026; x=1784041826; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W/h/wCaTAst9onv8h2SkLi2Ez1dGXqVJPL18bRqsAFo=;
 b=cd9tN+qJGEhsFa26CyCAkfOkorPDImAkQAQ99jkG2bCZZH9mBap7wGCiSNh1D/uaJv
 wmi/F09G2cme1+ZvwYeEGo43HBTNBZv/DafXIGD8ALs1UFIli2bZMGpPGr/CH+y5uDtS
 gFA6elFw+Vkeqc63V0aq/ICqRx47s+2sawzZjyNIS3bscs6k5XRcUCeXYgBpl2wRtTep
 nhHvGNsaKx8iZmgawYhYlJ8g0uLAlei5NuPUcglC4IWFMpcQW0lzpoI0PX9egEHtql7d
 aMCPVKJzYEQhd29ehAQ/hn6MR1KfZ4pnuRaj4qhMMTb8TDyN90h+H7U7MxLwoKKe8P8s
 fXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437026; x=1784041826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/h/wCaTAst9onv8h2SkLi2Ez1dGXqVJPL18bRqsAFo=;
 b=fhlLu1UsHeXg/QUC3X+CFw4q/YNN5km0HsON4IlXO4RvoV5GpnRzxwi4+1btKHeI1t
 Icm6+FJ5MXeMDPokzHTD1pNmQOyoUNOR8hKFmP1jBnP4EHWtxPlVFj4M6gdqnEdXfq85
 832tsnMXdfEz32SbvlgdSqKiAhD/v4Ccfzp1ypvFH/JAVHEtJECWwO7j+iofJYcU9LO6
 BtLrtVUyr5eCM19oCZeVpY/8fduZaQIQLM2OTgQ3HF3OMIDnQ4UEA0i2CL2LOVsmyw16
 AeO4bXnJosaL5C5pFi92ToE8V0NGRgJRb7LgMlsdJwCa7bOxAoiwnxpQIMEKsMHRK++8
 sFoA==
X-Gm-Message-State: AOJu0Yzte5gI6IZC9tzGeH+lI6vfesHsuz1PQuP0qxAYQGQaNWDjd6Ag
 +UIDd7V9ISp9zMxbAH25kgZV8HAHTEn/hurOHqBHzJOlA+LI0azcKI2KwKtUlrvWRqA=
X-Gm-Gg: AfdE7ckESW7EDzRWBTBic4P1pd17xbYp3OTVuR1WY0vmD5p8IMM8sMuZIJHRzreS4nI
 pfIHkKK9GJFJpRRFdsLhWK0EoB1n3vux4a2tghXAQ2wwqqbMCTvBT9TjRNovZuYKshIbuyInbDw
 3DB00HPC4FbfLyvdwMe+xXlAxJ5SrLl6RrQSO5R1u2IIJ9yofh8ibuZD+BZ4BtaVm1ZZWgODof5
 41vZ+e/83tO61YpdNGncuWkbg27rbranSv6m1UFbQJbnkHJ25MwTZBAOzxnJ7dccJ273HSRAEXW
 alouio/dkpU8QQduVQn8KiEzNL0nBVqJUZNPnttjDXlP6d3RwnSsjPAUJM0DPX2EWVuROnm/uGl
 Yf/Rx8HTbqoTWA1z+7YaeypvxQxGM860sU01qbDUbaAWLKNx6AiPanKBLNddE2k36TloU3KCaAj
 4uxPv0YxqsjfjEb5IX9g==
X-Received: by 2002:a05:6820:99a:b0:6a1:7cce:a3a6 with SMTP id
 006d021491bc7-6a3553d62bdmr3332528eaf.54.1783437025624; 
 Tue, 07 Jul 2026 08:10:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d011asm14846352fac.8.2026.07.07.08.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:10:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 10:07:21 -0500
Subject: [PATCH 01/24] clk: mediatek: mt7622: set parent flag for
 GATE_APMIXED()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-parent-lookup-improvements-v1-1-65d24cc0d569@baylibre.com>
References: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
In-Reply-To: <20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+rGURoIXzGmZb1CpOtNKCyPXsCrdMEwzYCgvp1EBjJo=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpNFjaj1RQSdztcVAWES45LyE3ONRFPuRGqhm4TvRaJHhHn/
 okBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqTRY2FhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8Cp2Qf/aQu446EodUr+71uxN5DL3Jfi0jAbh5U2RZKdeg9AKNMX/oG
 TmXv070RjGDK4/fUexHKhfcy8tGeqITzFp43ZS+JfKJWoLKrep8romHCQzZTCyHiu5mK6Vv2/LV
 q8god8CDg/dcvihTeta+UDZhJPmzlmBxad9pTs913LPZ4apesUBXNSXfNmt2ykcKn8wh5IIAuPw
 SThIJxSmQEHwzjCGA8QHk+qALevKCtnm95CHoMO4kDkxAwZ8omCppW3Xq1rdwX1x+Q15Cb4kFda
 epwd/dKgV/JZym+fVRDbYEaeLlEYrnQaCFU5/1dwdOCKazZNyq9u8zYUFKrIEoj0YDWvtA==
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

Set the parent flag for GATE_APMIXED() clocks.

By having parent flags on all clocks we can simplify the parent lookup
process. This is the only mediatek clock still without this flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 79315912fd4..60f4a872a66 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -85,7 +85,7 @@ static const struct mtk_gate_regs apmixed_cg_regs = {
 		.parent = _parent,			\
 		.regs = &apmixed_cg_regs,		\
 		.shift = _shift,			\
-		.flags = CLK_GATE_NO_SETCLR_INV,	\
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_APMIXED,	\
 	}
 
 static const struct mtk_gate apmixed_cgs[] = {

-- 
2.43.0

