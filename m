Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F572C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE9B885B5;
	Fri, 28 Jun 2024 19:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EivTEI8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BDF885DD; Fri, 28 Jun 2024 19:41:41 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA56881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52bbf73f334so810201e87.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596499; x=1720201299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co6TGUsQcLH3p/A+AzWG75JJ+aVqEpP5wX4X59GzNdI=;
 b=EivTEI8sWCmL77MAiTbG25Nl3Swep/ynd7IKWx+BL5nRZAKKOj61KtyMFTXBcv/Cm1
 Al6MVBmUl/1Dp0oy4PzaMn0isF2WDeOw9z4KPVmwfXIgl8d5DtC5vZBYjy+YjfYmn79p
 RiihNn4risHCEKTBhjDZEBNqvzy15MwaZsvyCQsPPjLcq2QWE1eX/ti3AH1D3kulJTHu
 DGMTYaXJfllzbLDfjI5wBT0Js95KOJWVnDTaKocOxsLgCaSodpySTtC8fs2yG+n5cM7H
 HdIdJLdhc5hGw3zr98DCj70Jc8kwdCaE3pmdC8+LdtFLjDEU43uVai3fBcENuQwcqH5W
 sR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596499; x=1720201299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Co6TGUsQcLH3p/A+AzWG75JJ+aVqEpP5wX4X59GzNdI=;
 b=iK1UlUl8vFzVYyZY6AO4YcXb/J8SrUsTmWVqkXigoN900YQAePXSXT9XcJOZzDpDZO
 6of4Dm3OyCWsz1W6JCg+TBboOG8oy0bW3hh9O/gr8xhrwed3UAOlxbcuRgzkDHXcUc+i
 o4QT+FwX59L53OCVR6XN9SZCcgQuXoInlx9CYHsxU846/VJVBZqmLOJ9jz5LmB8fBGPW
 H9kPjS6oMTooLa7PX6P38zP6KCFPpGF7uSOYOWE233nd7WSNzRLNVp7A9G6c2ePu6prl
 ElG9v3V6P8sId3tYYmKTSqoGWB4OFvvZBJKCtskW1S3m91dl/mHuoLKbObMzQZomPzvC
 mVDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQqe2SOlCmmgxpOwOWUw7zeCp2IC7WAWsnrncYxmC4MFrjMMXVY5FgIf2OxPVYf5Moo1xcy1AGse9ApfbwqR9p4paSLQ==
X-Gm-Message-State: AOJu0YyTnGlxvHUsSjrWzL8sIcVhP6ZSeLeCZPYoY81w7d26YW1qDfwy
 QagWlKhXB9u9AVnHxULyFG/FWsKpJoHCPPzLyNRUhW9EhcceHx9e
X-Google-Smtp-Source: AGHT+IE6LGeqmEczwQXgXuPkEfQ4hxAGwkNtVtWd39KwU9a+AHrOQM8Iwka0hbxT6ANuni/MY04Uiw==
X-Received: by 2002:ac2:43ce:0:b0:52c:da39:e40d with SMTP id
 2adb3069b0e04-52cdf7f1581mr10211250e87.26.1719596498573; 
 Fri, 28 Jun 2024 10:41:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 04/12] clk: mediatek: add support for gate ID at offset
Date: Fri, 28 Jun 2024 19:40:49 +0200
Message-ID: <20240628174114.8675-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

Add support to clk_gate ops to reference the clk ID at an offset by
using the just introduced gates_offs value from the unified muxes +
gates implementation.

Gate clock that doesn't have gates_offs set won't be affected as the
offset will simply be 0 and won't be offset of any value.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c3c50f4c14b..79230fc26e0 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -529,8 +529,12 @@ static int mtk_gate_enable(void __iomem *base, const struct mtk_gate *gate)
 static int mtk_clk_gate_enable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate = &priv->gates[clk->id];
+	const struct mtk_gate *gate;
+
+	if (clk->id < priv->tree->gates_offs)
+		return -EINVAL;
 
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_enable(priv->base, gate);
 }
 
@@ -575,8 +579,12 @@ static int mtk_gate_disable(void __iomem *base, const struct mtk_gate *gate)
 static int mtk_clk_gate_disable(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate = &priv->gates[clk->id];
+	const struct mtk_gate *gate;
 
+	if (clk->id < priv->tree->gates_offs)
+		return -EINVAL;
+
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	return mtk_gate_disable(priv->base, gate);
 }
 
@@ -596,8 +604,12 @@ static int mtk_clk_infrasys_disable(struct clk *clk)
 static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
-	const struct mtk_gate *gate = &priv->gates[clk->id];
+	const struct mtk_gate *gate;
+
+	if (clk->id < priv->tree->gates_offs)
+		return -EINVAL;
 
+	gate = &priv->gates[clk->id - priv->tree->gates_offs];
 	/*
 	 * Assume xtal_rate to be declared if some gates have
 	 * XTAL as parent
-- 
2.45.1

