Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79555C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D189B88600;
	Fri, 28 Jun 2024 19:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/4y3hhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEAC88591; Fri, 28 Jun 2024 19:41:46 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC41885A0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so11999251fa.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596502; x=1720201302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Et/k5LVOxHtfBQGpaCz7WImDb01evOUMkYgz0sKEL0=;
 b=h/4y3hhLNeXqNP0jgdXABYYY2Qd7X7QQstE7bjwXUa+CJ0p1ghmrLWZ63MBSztNaYu
 tFgJZfC/H+kJqviBG1qkbgqmldcDyd6kvM9wWOx2kh0g1QlIWhoMzUHBlol1muWt9JSP
 13znjTrOwE/WxwKf+YASQM6uaDPhuZqzSuH8Zju+riOJCSmYa5BoG7HAHDip8NvEuHDl
 Xo42yefa8j6Ew2KYCLZBAhzHodxwxCqWQpsuSQ8hCaQXqzxQCSVWqqnYcVN9vELEcJfJ
 ywz01wnyXDzFjSW3Bkjd9WkVhVjINjmhgt8Xu/kQ6l4gnRVzILiIOXjwaLBZZTD2WGyp
 XMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596502; x=1720201302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Et/k5LVOxHtfBQGpaCz7WImDb01evOUMkYgz0sKEL0=;
 b=VFRLLMFc2boA213+d5WkWi8w7DIQxXgo1DSHdp6ErFqmP4p1i1F1XmkflMNqn4rAVI
 BQahcJSZQrtEhN1Pv0/3NHEI1lHLzHcfibKcA+R4hF4EuSN6J9+fajMHBviugfTFx/Gd
 VIhTBLWs34vVNQSlbm0bGX+Ix5Pj/I2TY3zvfbJeymgMZ0rBBdH7IQJ5WhH1cezhRsJy
 oClzT0RCxpWrqzG4Ce+zMll5lu1+4K5wSUjgqq8gBjLryUo4sMLRyyFwuVa2SEsjftQ1
 fQr2DCYzZRSLwtXOLlcwzrbfikVCtG9sVM1MWQcbc/LYgttuTWZc1AcfxASt46v5GXS+
 tngw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBEYQIRLIxCJyPNUh6lmlDhAoLs4WqXzKMbyiXfz0rBpSJbGFBan15vl5U250EX0FiWXqXsmXN/pOt4zo9fVEiteyEPQ==
X-Gm-Message-State: AOJu0YzL63Rf8GEawTkw78ms3ieUaK04saNZWBSsw6/x/omji4Wt7r9h
 cCBLss+O4dVuG73Wckie1ndzaMdagAnjVH4N/uBi6EcgKszn0j0c
X-Google-Smtp-Source: AGHT+IE2UQCMCEojJDI/1RM8yIcpGUXGOOhAd5wVIN1DS9CXD2lwbnVIlHe6Ba3DiqPXlA7Mkn8qWg==
X-Received: by 2002:a2e:bc1a:0:b0:2ec:5f85:61c0 with SMTP id
 38308e7fff4ca-2ec5f856227mr157184061fa.48.1719596501468; 
 Fri, 28 Jun 2024 10:41:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 07/12] clk: mediatek: add support for gate clock to reference
 topckgen clock
Date: Fri, 28 Jun 2024 19:40:52 +0200
Message-ID: <20240628174114.8675-8-ansuelsmth@gmail.com>
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

Add support for gate clock get_rate to reference topckgen clock for
infracfg-ao implementation.

In infracfg-ao implementation topckgen is on second level of parent with
infracfg in the middle.
To correctly detect this, check the driver of the dev parent and use the
second level parent if it's not mtk_clk_topckgen.

Due to all the dependency, parent tree must be filled before a gate is
used, hence is safe to assume it will be there.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 790b92eaf86..4a057059407 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -651,20 +651,33 @@ static int mtk_clk_infrasys_disable(struct clk *clk)
 static ulong mtk_clk_gate_get_rate(struct clk *clk)
 {
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	struct udevice *parent = priv->parent;
 	const struct mtk_gate *gate;
 
 	if (clk->id < priv->tree->gates_offs)
 		return -EINVAL;
 
 	gate = &priv->gates[clk->id - priv->tree->gates_offs];
+	/*
+	 * With requesting a TOPCKGEN parent, make sure the dev parent
+	 * is actually topckgen. This might not be the case for an
+	 * infracfg-ao implementation where:
+	 * parent = infracfg
+	 * parent->parent = topckgen
+	 */
+	if (gate->flags & CLK_PARENT_TOPCKGEN &&
+	    parent->driver != DM_DRIVER_GET(mtk_clk_topckgen)) {
+		priv = dev_get_priv(parent);
+		parent = priv->parent;
 	/*
 	 * Assume xtal_rate to be declared if some gates have
 	 * XTAL as parent
 	 */
-	if (gate->flags & CLK_PARENT_XTAL)
+	} else if (gate->flags & CLK_PARENT_XTAL) {
 		return priv->tree->xtal_rate;
+	}
 
-	return mtk_clk_find_parent_rate(clk, gate->parent, priv->parent);
+	return mtk_clk_find_parent_rate(clk, gate->parent, parent);
 }
 
 const struct clk_ops mtk_clk_apmixedsys_ops = {
-- 
2.45.1

