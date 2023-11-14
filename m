Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1430C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361F6871A0;
	Tue, 14 Nov 2023 10:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLjgb1lI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63428871A2; Tue, 14 Nov 2023 10:00:19 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448898714C
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc5916d578so47963845ad.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699952415; x=1700557215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HpA2qx8FNV2mKzY6eZQ5YTvDcpEdFI8GBvRMj+GUgXU=;
 b=cLjgb1lIibzKNbiS57PoTEy0nR3raDuwXlMQmLdN9KmJa8+aOeh0na5wtv1GW5gxVJ
 5R5QNhau2He2ZJ5IQND3+wxuUwbS5e2rq4E6dLkX0fiI0+1/cHlRPHQR6jg9KYxqtZ5A
 ZJNuwj+t7TpAM+SnJRK6eI1/ccjnJf+2UcyL2dzmHlv1uTnKfIIOx+xhpdgS6GwTjhaa
 2c9IOethRZBiNkMOtoDRj5znUbwTGIlhdRQcdAGTH7TAOFeND7oXcHbhanSah4hXWLLF
 iaF2M+DSWL/3OWa3ifrKSYCLu7Y8wn9PCt058ZR7trk1McHfJaD/kq1ory+Ou+G7of5V
 +1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699952415; x=1700557215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HpA2qx8FNV2mKzY6eZQ5YTvDcpEdFI8GBvRMj+GUgXU=;
 b=Qv+geNqtNtxLj88XYUbQDDqmGRYGvCa/yrr/B0mEp6toxqEu1sFGOijsG/Rf42Ibr5
 h8m0OJx9kEwA20VGYFm9VUA5WfHsXxU3s/kbweWOlrGTtcoYU6NuGvCw3wj43nxVMBg8
 2FVt9Ab/xVSxz7qBijYINuOysZdDpxgW8f3E8j0YFfVb37WxdJPHu8LEOz+Aq0hqPrOc
 OXizsVzDNljTsY3hl3JxeWt+rSUl9r5T6eJbcT86bUnVnDKxWuveDPy8YvVQ4QjTBM3H
 RZ433Up+NXXSichdDDJDPblpX7KgUgELjDSoCP66l0UkED/XueSva6ny49soP4qT1b0p
 GiCA==
X-Gm-Message-State: AOJu0YzDEvPcQ7ZcTA/0fyV8hRnq/fLXfifieoh1MV0gB1D9H849mOGH
 fTCzWFf1E8WnFwPzHQQbzXY=
X-Google-Smtp-Source: AGHT+IEZKmQicwBoU2/nbmtBm37dEitrCFTE2kRa/1wa6Fa7MFhk8IHVxqzfsRv378zc4fWUvGw87A==
X-Received: by 2002:a17:902:e750:b0:1c9:ff46:163d with SMTP id
 p16-20020a170902e75000b001c9ff46163dmr2227195plf.38.1699952414578; 
 Tue, 14 Nov 2023 01:00:14 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a170902740900b001cc67103a15sm5224371pll.16.2023.11.14.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:00:14 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 seanga2@gmail.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] clk: nuvoton: add read only feature for clk driver
Date: Tue, 14 Nov 2023 17:00:04 +0800
Message-Id: <20231114090004.3746024-1-JJLIU0@nuvoton.com>
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

Add a flag to set ahb/apb/fiu/spi clock divider as read-only
The spi clock setting is related to booting flash, it is setup by early
bootloader.
It just protects the clock source and can't modify it in uboot.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v3:
   - add commit message
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

