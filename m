Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA724C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A178B8852D;
	Mon, 24 Jun 2024 23:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fNBApdOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6F088119; Mon, 24 Jun 2024 23:04:36 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55269883C9
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4217136a74dso39664115e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263074; x=1719867874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t9CfDVGOz6KTLC+evnRlVUFAOKx9+mHwstEfz5WLmCk=;
 b=fNBApdOTeUsrLELrYpnxVTSk3YfRzpejE/bEMzhVtGMW3O7gOE9xONmmTGxU7GJDbG
 jPHFYnKejj7MpbSq+wjkS7Sr9LB3fr/fxnlLffhAbDpHANCXUN31zQl7GeSUVPxOTLRj
 ARUpkIaIk7oWb3aHLEwLzWNPxwW3ptfOv63G0O0lR7h6KzjBKHIuWjntLi/ML5IhB09c
 BDn95QPbNDLdg1CrPeh0KKraz2akmhmTy5HFsAIKh23LoxSlO0DFguyQT0XH6ARonn2k
 kkpQBYL5ebuxmyX3saTzZJ+1JbwHbA8cCksYpBsJ6fCpwStO4JlQG8zfcrDq//YHStyJ
 wnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263074; x=1719867874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9CfDVGOz6KTLC+evnRlVUFAOKx9+mHwstEfz5WLmCk=;
 b=qsjC5jPV4pRUiQChlmffb6V7YCKuqZDIQ43sMf/syEtqgzdyTN2zvFD2Cz7t6FyEtD
 YngfiFEt7YCLfyJMpN+MJ7gOj6TFBE3rU4y+T3SlT9PFm89FOqfpYjZ3h9eRGHZA9ZHU
 Bz6Nk0XmTiSrD5TZBlvgCIgoIePW+dvERIxqIa+qcGiMoEyAJGykVb+mrw6+4whvUVmc
 a2MhieKO00br6tjeSW21+9YPLkELDE1AgyEHhz0Gzi5jVfaUkGWSZMF7rqaY65gkCj63
 d7JbRgB12cNyZjSiNMBIsLZY+g/WlXaesqIHD38fk176m0bs4O/Wh2CoZhOlPXqnKl0n
 pUXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaRV5F0e+vyglMqGN6Jt8CyXUhqpd3pSLApCFG8U6/x6S/5TAlYVWoGGPvk2b0stRr4x4Nenl0TXBLaUiQMfi7rCBycQ==
X-Gm-Message-State: AOJu0YyCcXtdJpF7bi8izO+/epthfBfBXK++JO/zyyWfAgvDnDskXUGc
 rQT+7zflWlwgqNUrz5B4oQ+mtD3Adtj/1RFUWtauBTRsQ9lN+VYa
X-Google-Smtp-Source: AGHT+IErsodt/sExvpD1Q/TI57TmQZ99Uhm2HqCpQW3VUuPa/IgqKfzlbefIIbBsArvxXb/K8ZWFLA==
X-Received: by 2002:a05:600c:2d05:b0:421:82ed:28d1 with SMTP id
 5b1f17b1804b1-4248cc73e25mr38207885e9.41.1719263073694; 
 Mon, 24 Jun 2024 14:04:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:33 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 05/14] i2c: mediatek: add support for optional arb and pmic
 clock
Date: Mon, 24 Jun 2024 23:03:31 +0200
Message-ID: <20240624210418.19324-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
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
2.45.1

