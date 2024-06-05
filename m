Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC208C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DBB8842F;
	Wed,  5 Jun 2024 21:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Trxk+Ici";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAA48825E; Wed,  5 Jun 2024 21:03:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0678C8836C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4212b4eea2eso1894745e9.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614226; x=1718219026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lbqhTC/Ts3tNK5F1WJyeiJc9XsdkXxjI9Vn5rbodR/U=;
 b=Trxk+IciZtvCoKlpcg78aMpJr13kujs1Q785fLPdXBF6SYu1CdG1zvV/kcG47LGlx0
 T4Gn8nOA4quEIrTbCwb8W6CFs3+//3Aj+YmnwvpCIWL2Gqyj+8CmKkPuoxKpVe8Q4u4Q
 Ncb8iRB6Am9rSUMKoHQ2a6AEkDHU9QrWT8tMufPMkBELEUiiSbsvphiryHT21fPrLI1c
 kpy6S5hy7gFimSTh57JK7WbD6ilctXvCWRqWQCojBJVuNTBnqMYpju8epsVThshDFH60
 y6xGU397AYnszqxg+jz53EyUnnGbYEPKXy3FO0F9J8pIFak7LFlRtmJMyUtsxx3sdK+J
 m/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614226; x=1718219026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbqhTC/Ts3tNK5F1WJyeiJc9XsdkXxjI9Vn5rbodR/U=;
 b=WR5vm7wK7Fpe0mJJvbOhFp7S0VFQ3wMBS1KZAChBTPGDTdZRVPTfEP91ECJXHms55A
 hec14FRnSbMr/YfJzlWR4E1dulik0+R2QXDB2W2Uq8/MzqZ1dW5CVsG59eRVFTTZ4+QJ
 MornRCIjSt/+2xJ/o5ZBZWB2PQvPKEeNY5ihQjQ+2o4U+T9H0ozHRBEWXgVtdx4y/W1V
 yeRTxfPVJbew5dSG3pyQ0d6W1OVJO+xSlJdKhJwAorHqKZSr9+5SiGAK12R+iA6UV7ux
 mioG10kPJLLYTsQtqli9I4AT1Ce3wrAZsgWgvKde0r09qXngDZTdRJDG0ztJtPGqr4Ry
 Rm9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+6Al4Mk6V8TsuJ7lhOQD5835M0NBmJYJIzPE5L8dVdudg8G4dAoZ0z/OsPI9MB9qHFjhCCTit6MfG0p6JMmqxpqxorw==
X-Gm-Message-State: AOJu0YwLiASR9mmlICxRf4u/7EEUVkj+fO46yJHTS5EwXHYjGCFONaEF
 Hhk1nUr13EAtgrat3zNua/Xt3SwPCuc9BZijs/Vb06VYswHr0PzQ
X-Google-Smtp-Source: AGHT+IHbPdxlLtwD/DEGv1wn7YBfmnATbFUKNnRdfbK1zN0TH2wZsHCWxLDwQPE85XiRhxfZgPnGWA==
X-Received: by 2002:a05:600c:4754:b0:416:9ba0:8f17 with SMTP id
 5b1f17b1804b1-421562f21b8mr30115985e9.22.1717614226435; 
 Wed, 05 Jun 2024 12:03:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:45 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 05/11] i2c: mediatek: add support for optional arb and pmic
 clock
Date: Wed,  5 Jun 2024 21:02:12 +0200
Message-ID: <20240605190220.17616-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

