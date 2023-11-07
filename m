Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CBDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F6187103;
	Tue,  7 Nov 2023 10:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KB8Lsh8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4786A87116; Tue,  7 Nov 2023 10:01:45 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F4B86BD7
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2ea7cc821so3449607b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 01:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699347701; x=1699952501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ckR+RoVLPJPAMUtMQqZzbwCdRxUf/v+VoccY6k0MBZE=;
 b=KB8Lsh8YkmDpJu72fAdUJL2+55Bbx93DTKx4eqBFmllAAS7wLFSiFtJ9jp/9P3kWu2
 ArJCy0Cpwjs9L60xU11Z/03SvB+T0cFTZhAIGKX5OXty2r3LGYMc4Myv7IL+Fmp+1sqd
 wzyZ3dLo2zShdJSSog8hkaJ+kqADuUe1WJDYPj+HsjkD0QM7Fuf0UGxFQajosNxCBReN
 r5BLn4Jgw3vDuVBKpclg0KqwI+2V46lMQRCV6jRHK3pObDe0ZKjWnt+A1CvU8QICLJzV
 bxxH5h25afwhOyN5asK6140Qwi3d9WsWXKI3+hAGhYYPhM/PnPcDjrSFbEobjtOoWVW3
 tvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699347701; x=1699952501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ckR+RoVLPJPAMUtMQqZzbwCdRxUf/v+VoccY6k0MBZE=;
 b=pTUnK9U2NwQJV/+nuO3ihBqI3BTrB+QI8vcr6qn2jIJ54Gv+87OHQbM/0+LyWYILso
 Owmah1GleLY8jmLIw27lQl4X6i+n5bpFgZFmRx6gu5fKVmWSqFONPckbjU2KH/vfnYjX
 W9oPpvlzymnwvLgVUfdvopmEcW/lbYFB9NLaFyAk7MXc6ZF16kmQm7muls5s3L377vKs
 oLRGRYO+v2ZIDGwLmie4rnaYYsIxUbPwDiMu8yUVGM5h+TpbCZEhALUwESMj7wDnP36l
 w9nIuUzlcegc4BV+VYn9iNfVRgjBjAFzLuQP6oMrbALNeIt11q59t+JDpBFBJDP58ldy
 CROA==
X-Gm-Message-State: AOJu0YxhEjznNIZDHnkxpKi8V0eWiIJ5MQW9/EhWHGItGT7YMtTmEixs
 8a4Im3eVOjkKm5dP/UWhRWzXbpPdBZxP1w==
X-Google-Smtp-Source: AGHT+IGLMP5+6Vtv6zubpySSMOgdj9F3yUNwcRpaYcxAReHIvTfB+97s0XeAtpCsYOQLOY1cHzUDwQ==
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id
 f4-20020a05680814c400b003b5663c9b91mr26412711oiw.12.1699347701620; 
 Tue, 07 Nov 2023 01:01:41 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a631a4c000000b005b3cc663c8csm982516pgm.21.2023.11.07.01.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:01:41 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, seanga2@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] clk: nuvoton: add read only feature for clk driver
Date: Tue,  7 Nov 2023 17:01:28 +0800
Message-Id: <20231107090128.199267-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a flag to set ahb/apb/fiu clock divider as read-only
It just protects the clock source and can't modify it in uboot.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - add commit message
---
 drivers/clk/nuvoton/clk_npcm.c    | 15 ++++++++++++---
 drivers/clk/nuvoton/clk_npcm.h    |  1 +
 drivers/clk/nuvoton/clk_npcm8xx.c | 12 ++++++------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
index 8d71f2a24b..18cb9cddbf 100644
--- a/drivers/clk/nuvoton/clk_npcm.c
+++ b/drivers/clk/nuvoton/clk_npcm.c
@@ -135,7 +135,7 @@ static u32 npcm_clk_get_div(struct clk *clk)
 	return div;
 }
 
-static u32 npcm_clk_set_div(struct clk *clk, u32 div)
+static int npcm_clk_set_div(struct clk *clk, u32 div)
 {
 	struct npcm_clk_priv *priv = dev_get_priv(clk->dev);
 	struct npcm_clk_div *divider;
@@ -145,6 +145,9 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
 	if (!divider)
 		return -EINVAL;
 
+	if (divider->flags & DIV_RO)
+		return 0;
+
 	if (divider->flags & PRE_DIV2)
 		div = div >> 1;
 
@@ -153,6 +156,12 @@ static u32 npcm_clk_set_div(struct clk *clk, u32 div)
 	else
 		clkdiv = ilog2(div);
 
+	if (clkdiv > (divider->mask >> (ffs(divider->mask) - 1))) {
+		printf("clkdiv(%d) for clk(%ld) is over limit\n",
+		       clkdiv, clk->id);
+		return -EINVAL;
+	}
+
 	val = readl(priv->base + divider->reg);
 	val &= ~divider->mask;
 	val |= (clkdiv << (ffs(divider->mask) - 1)) & divider->mask;
@@ -253,8 +262,8 @@ static ulong npcm_clk_set_rate(struct clk *clk, ulong rate)
 	if (ret)
 		return ret;
 
-	debug("%s: rate %lu, new rate (%lu / %u)\n", __func__, rate, parent_rate, div);
-	return (parent_rate / div);
+	debug("%s: rate %lu, new rate %lu\n", __func__, rate, npcm_clk_get_rate(clk));
+	return npcm_clk_get_rate(clk);
 }
 
 static int npcm_clk_set_parent(struct clk *clk, struct clk *parent)
diff --git a/drivers/clk/nuvoton/clk_npcm.h b/drivers/clk/nuvoton/clk_npcm.h
index 06b60dc8b8..b4726d8381 100644
--- a/drivers/clk/nuvoton/clk_npcm.h
+++ b/drivers/clk/nuvoton/clk_npcm.h
@@ -50,6 +50,7 @@
 #define PRE_DIV2	BIT(2)	/* Pre divisor = 2 */
 #define POST_DIV2	BIT(3)	/* Post divisor = 2 */
 #define FIXED_PARENT	BIT(4)	/* clock source is fixed */
+#define DIV_RO		BIT(5)	/* divider is read-only */
 
 /* Parameters of PLL configuration */
 struct npcm_clk_pll {
diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/clk_npcm8xx.c
index 27e3cfcf55..d1b32e3237 100644
--- a/drivers/clk/nuvoton/clk_npcm8xx.c
+++ b/drivers/clk/nuvoton/clk_npcm8xx.c
@@ -45,12 +45,12 @@ static struct npcm_clk_select npcm8xx_clk_selectors[] = {
 };
 
 static struct npcm_clk_div npcm8xx_clk_dividers[] = {
-	{NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2},
-	{NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2},
-	{NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2},
-	{NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1},
-	{NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1},
-	{NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1},
+	{NPCM8XX_CLK_AHB, CLKDIV1, CLK4DIV, DIV_TYPE1 | PRE_DIV2 | DIV_RO},
+	{NPCM8XX_CLK_APB2, CLKDIV2, APB2CKDIV, DIV_TYPE2 | DIV_RO},
+	{NPCM8XX_CLK_APB5, CLKDIV2, APB5CKDIV, DIV_TYPE2 | DIV_RO},
+	{NPCM8XX_CLK_SPI0, CLKDIV3, SPI0CKDIV, DIV_TYPE1 | DIV_RO},
+	{NPCM8XX_CLK_SPI1, CLKDIV3, SPI1CKDIV, DIV_TYPE1 | DIV_RO},
+	{NPCM8XX_CLK_SPI3, CLKDIV1, SPI3CKDIV, DIV_TYPE1 | DIV_RO},
 	{NPCM8XX_CLK_SPIX, CLKDIV3, SPIXCKDIV, DIV_TYPE1},
 	{NPCM8XX_CLK_UART, CLKDIV1, UARTDIV1, DIV_TYPE1},
 	{NPCM8XX_CLK_UART2, CLKDIV3, UARTDIV2, DIV_TYPE1},
-- 
2.25.1

