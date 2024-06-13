Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999FC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1F188915;
	Thu, 13 Jun 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dnrQtP5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F01D888FA; Thu, 13 Jun 2024 13:10:24 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BC2888D1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f04afcce1so119341466b.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277021; x=1718881821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lbqhTC/Ts3tNK5F1WJyeiJc9XsdkXxjI9Vn5rbodR/U=;
 b=dnrQtP5xtx5IpNq7fNkuO09UimtMRc6vxBtDDnesB+Obbgb5Z323sm0ZmuaTGzG59U
 7aNLOEgZf527vd2XJVugkZ30ZDpTSEjOlX47KBzYmPZ0QBtkTCkqXUzRaIHFVPTICeNo
 ZMY3BJw+ChgwEVsnXKTTm9BpNkD952biA8RelwOxkkw85+dUlNPQZWqL4pQ3jD/5F7Ko
 ln46NwTMr/kmYt3R0Rvxn4jrPk1ePFQ4FQpm8oJs5VTLCLt5HlcbqCEwNMHC9CNhAUeE
 bTHp173TfOfdt5JJevvIhv8w6Bim0MlTS+HAYkkMYCsW7pfklJuGCOqezIOEBSPB5I34
 MQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277021; x=1718881821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbqhTC/Ts3tNK5F1WJyeiJc9XsdkXxjI9Vn5rbodR/U=;
 b=jGuwmo2BOEI88P2B+0SLfkDWw8BQpbbReYBZ0DV4YYpM+6an/jxB6SoVEiwK6yx3Zb
 a3DhplbHAHi6gqlEDcaAwmXUG7rmnieeQjF9aVXqEYeEuEhunYvXXWcJFFulMmC5AnD/
 BOllPf/NAGV3jTcfzQwn6Gjkq84wcl8/1KqAWayNKGy6NaRIlTs3J3TocRkvhl0YI7ad
 y3KWROaYIduXu/iSk8YXl6IRytKOJPi0ElD6yGKrDJnBRIKjCHNfo0z0+Ax9GyYTyGrJ
 c59QDlZ1hpm8hOipunJq2dhqE7yXQANVhOblIJrlu+gsHOpA+LRhlJGxOARaSyV6Ap4j
 DGYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWERE40AIKqq1t/dZWsFaKRF06R0hlrJBz6qrcbG5oVBN+Ec9YjwffManxEkw6b9qte1x1BUuSO4Tqh6FGd7W68MFUn9A==
X-Gm-Message-State: AOJu0YzZIFJNgIP80rC49ip4jQfkytJEXwSW6uioaFmr1SOhyiw8LR3J
 mUo7E0CuH2lG/CasVuhvHxlLJT5PWEdMTfC4ZG4YFp61MV5qZk26
X-Google-Smtp-Source: AGHT+IHJHB+jIddf77Imz5NORsp9TLPRYGU9lI8BbC+r4wH5eJLqOXGdWGHVBuy0sMUuRENzUo7HKw==
X-Received: by 2002:a17:907:94c1:b0:a6f:4804:d41a with SMTP id
 a640c23a62f3a-a6f4804d4c0mr453242966b.55.1718277020627; 
 Thu, 13 Jun 2024 04:10:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 05/14] i2c: mediatek: add support for optional arb and pmic
 clock
Date: Thu, 13 Jun 2024 13:09:23 +0200
Message-ID: <20240613110949.11076-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

Add support for optional arb and pmic clock for i2c provided in upstream
linux DTSI.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/mtk_i2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 5592fe91817..3450177741a 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -221,6 +221,8 @@ struct mtk_i2c_priv {
 	void __iomem *pdmabase;		/* dma base address*/
 	struct clk clk_main;		/* main clock for i2c bus */
 	struct clk clk_dma;		/* DMA clock for i2c via DMA */
+	struct clk clk_arb;		/* DMA clock for i2c ARB */
+	struct clk clk_pmic;		/* DMA clock for i2c PMIC */
 	const struct mtk_i2c_soc_data *soc_data; /* Compatible data for different IC */
 	int op;				/* operation mode */
 	bool zero_len;			/* Only transfer slave address, no data */
@@ -255,6 +257,18 @@ static int mtk_i2c_clk_enable(struct mtk_i2c_priv *priv)
 	if (ret)
 		return log_msg_ret("enable clk_dma", ret);
 
+	if (priv->clk_arb.dev) {
+		ret = clk_enable(&priv->clk_arb);
+		if (ret)
+			return log_msg_ret("enable clk_arb", ret);
+	}
+
+	if (priv->clk_pmic.dev) {
+		ret = clk_enable(&priv->clk_pmic);
+		if (ret)
+			return log_msg_ret("enable clk_pmic", ret);
+	}
+
 	return 0;
 }
 
@@ -262,6 +276,18 @@ static int mtk_i2c_clk_disable(struct mtk_i2c_priv *priv)
 {
 	int ret;
 
+	if (priv->clk_pmic.dev) {
+		ret = clk_disable(&priv->clk_pmic);
+		if (ret)
+			return log_msg_ret("disable clk_pmic", ret);
+	}
+
+	if (priv->clk_arb.dev) {
+		ret = clk_disable(&priv->clk_arb);
+		if (ret)
+			return log_msg_ret("disable clk_arb", ret);
+	}
+
 	ret = clk_disable(&priv->clk_dma);
 	if (ret)
 		return log_msg_ret("disable clk_dma", ret);
@@ -748,6 +774,10 @@ static int mtk_i2c_of_to_plat(struct udevice *dev)
 
 	ret = clk_get_by_index(dev, 1, &priv->clk_dma);
 
+	/* optional i2c clock */
+	clk_get_by_name(dev, "arb", &priv->clk_arb);
+	clk_get_by_name(dev, "pmic", &priv->clk_pmic);
+
 	return ret;
 }
 
-- 
2.43.0

