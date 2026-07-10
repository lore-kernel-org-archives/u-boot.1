Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5628C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B08F84AD6;
	Fri, 10 Jul 2026 20:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="nztE5URv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF0784AC8; Fri, 10 Jul 2026 20:59:15 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056DB84A78
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 20:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-447a81776e9so415093fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783709952; x=1784314752; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W/h/wCaTAst9onv8h2SkLi2Ez1dGXqVJPL18bRqsAFo=;
 b=nztE5URv1saJ7Vvizi6BaGvphKgZtYDUyw8idLNQ9S6Z9x6KSjxI+FQLmNDKdnsKsR
 4aqjH51sK7/do8Teh0R3mSmrY25nOEA5tcC3eoV1bM38N+JyCmwUc65czlizzsjohxKG
 4XOGoxaJ9Vb8Jj9pFtSeq6Bprs/Uqh+tffqh/pgMmhoOq8VLq5MkJvYTtw8SkEquA+jY
 7iaV1bhVYABNK/megDrFZ3Bz+j52TvZxT9lJewBYfxAqT2+al+AfQSQI6mpCQEZ/OWw1
 wgxEsyMOYJElYtiXvnAXikbESj1DzlVCcul3UW6K3qkV3lb3qktZ/uVuS6v32x5NuaT8
 i3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783709952; x=1784314752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/h/wCaTAst9onv8h2SkLi2Ez1dGXqVJPL18bRqsAFo=;
 b=VVHfSIaEQikFzZbCod0OMCba6LADzRQ8J4fVngBUbjflTmsKoPX07XirA4AF+SVag9
 B9SBxjYGG2nPUhTk2trzY0NJK6rXo+dH09M30I+DcTV45AfPHoHOQ2HqXRslKZ7asovs
 GRHruvsgJ+JOkZqgWcRXheSshWj/OcxSPo8XfAw1RQcW0K6c3JHBuioY8iRIYqX1mIEE
 bgcTlyNeMrkb7JnCjqMEAaynHlv3OQXxH6cvyqqyR0+XtxqJD4vlIy0m1QaXAa8KJWxZ
 sra+afCmQ5Jo50qNa/Jt+WTMiJLjRg8HifOCZVoHcUd85C4z6j/bqQN0ehvzDTUKE39P
 3z8A==
X-Gm-Message-State: AOJu0YwPLVXxCUh09HnafgTCrCtQm+j9mbEUZNajm1m5PuAIBttg6rWC
 k+osZi5dQ/WjMS/deBDqgk9erlivh4Qr2zf6Rp9Ogk7ZHjTkxgB1KIvbrIb0c3Sr3e+8SL8kw9o
 BrEq6
X-Gm-Gg: AfdE7ck6Hyslmx99I7PvPa8+qfiaJL5N9Cxo7Z7KR09G811xVYtFX51olcp6DU1O9Wh
 KZGXOvBPKIWaNpk7XXEc58JDWGwvIIdBgDDq7cDzH6pOdb4nsjGyMBOeT3pUwNc1wyOwznYqAom
 ufBhEFLwulyFfud643Re4bAku5bvBCI3KtCw3QjrWU++o7u/++4B5KhVyNQUXEa1CvY7wMj++lT
 aMwK0/K/cgHqTqL0DytR9wIWn1vOo7uz7lcpT7SyXkfPbi3Z9pXRBgzsRYLkxVKhEvM9scwTy1i
 wOW4BlkWp7R2Bt3M2bGY68o6DZ8X89hB+hSkE7P5an1CICeU1H+fb4AN/K9NGDLKIZqKT6fe1RY
 utSWMJpGcLtcCZDz4hwRVp88VRObMSe4r0iEIAwNLfZt9SLItfneOJCyo+KsXDaoHLKrHs9qXcO
 QDhqsPeGFQtCf61Ro0NxF/Hhuv3Us=
X-Received: by 2002:a05:6870:bacb:b0:448:6c60:9781 with SMTP id
 586e51a60fabf-451f0f4cb2emr108174fac.6.1783709951664; 
 Fri, 10 Jul 2026 11:59:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916f31d4sm5789657fac.16.2026.07.10.11.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:59:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 13:56:17 -0500
Subject: [PATCH v2 01/24] clk: mediatek: mt7622: set parent flag for
 GATE_APMIXED()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mtk-clk-parent-lookup-improvements-v2-1-f3f3a4a28dca@baylibre.com>
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
In-Reply-To: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqUUBdIYk2VowgiUSSd4OC4qRliK18pQn7HtVLn
 Rgxp9VPs1iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalFAXRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AIg0H/1wBtbzaR2+a5nt7xzJQ8LLg7mYLDN3xDUzu84t
 BiguYwHUn1+K+pNZ3JM5IaTxj3JuybXWS4m7sMYktLRo48WRcyMOeAlEgeIyAFqb7haDpIvXBmQ
 tnxN8M/waZPtZyyWXVgCTRTqnbPuiJdpwS7PfjQNkUPtkORMdR79GvB5q7Vb4ascZOYoNVMHRaX
 KVm4e0xfsoHvUNujw9sX9ayTxBOH9RGnTiPsEZZFyVYYdZ8YqnG4xypn8b6euXeh4IQwwcDPAAK
 3HsLpP1AZ/36AZh5ioLbGGkbCwSM6JE0v3xLODd0RtzQFHvJagNqFPeuspMKK5BXLdXPXCCVx+t
 Cclg=
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

