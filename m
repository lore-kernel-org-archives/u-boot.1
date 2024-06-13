Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D8AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447498891F;
	Thu, 13 Jun 2024 14:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzVJbk33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26A9888E8; Thu, 13 Jun 2024 13:10:27 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDF1888FF
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso1067677a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277025; x=1718881825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dkLSO2oqFmlNq+CTGLdRXojERXtEUdcRUTUSIaM8Y+w=;
 b=dzVJbk33qQZNjtyt5Za5hdfBNGHcivaLnYiYAiV4XZEHCQW9swaTFgNR55IsKGyI1M
 wMrJabCHt/7GlxTWdBvOSJxyNd7/Q4OAj6Ah76pdeM7Dvp3je/GuRcJukUnduV9NYXvj
 PUYFxOwbvjH0UoFr63yWSFQqOM8soX+KEI8RXoKc4dGFqXbPHX+mlcbo1Tf5dqEsUNmO
 2Pc1DPZ1qDA7evoKzYKcOjRsAFuECwGH58DPtg5zxVbBlSIqiHAc4zpaf5qTr24Dn0Dq
 zaBA61TJLzbpUN174vwREP6QI2ItjX2XsKCWiteYwnEZ94xiCA7w4wZymShgw5PXA41I
 jVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277025; x=1718881825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkLSO2oqFmlNq+CTGLdRXojERXtEUdcRUTUSIaM8Y+w=;
 b=ZH0r3fVNmGSnOjZBcXUGIebV/pHCytQaZQVCmXA/QjNdhh7gNKFtHgjr2GdVUjUFya
 bhW/Ku8fKhv+gM3EecZQGdxMF93xj9Ir4mgPT2F+da07cHgTckesLJdsnoFIepAsFlz4
 xUktcojVFdx89Q7SPS4glx4eQDJesOZjpY5Y93NbizEhq6SxDDndoMrBSYWA1trFGHzT
 46czWi8muYlbNeO2jTrzl+J3FLPbG0OVrKbAWYoEmtMdR3SjBNGrQuX5/MG7NVCKGh81
 0Be9jcjbZMbr43fueA+Y5jEB/Eh7lUDnLQg49pbNDWR08AdKJc4C6gilpHw/9Ze2h8ao
 HK9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx2sKqDF8wHPcj7QB47NaZB3W+ke+URuvmPUu4KGaMU4MHPegZzNLpidsY0rQIfINRFdbQAZs9z1zR39cl5mFhtVY7BQ==
X-Gm-Message-State: AOJu0YwzOcXAS2/ic5YN6ALtkM1+bKMD5JSfpgCO+hx0fQoaaZDAJPPq
 GfBrVg2L/YE5sWAsxdo/hzbeXtRn1xDQF5IzpXlhohiQM60WX4To
X-Google-Smtp-Source: AGHT+IFrfFz/55fLJoy1oIjuN8ZsBEv3s3iY64ZQ4SEdZCJd78G+wsuvsXj5Fhcc/33251Reloy1iQ==
X-Received: by 2002:a17:907:724a:b0:a6f:1036:98cf with SMTP id
 a640c23a62f3a-a6f4801305amr407446566b.54.1718277024659; 
 Thu, 13 Jun 2024 04:10:24 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:24 -0700 (PDT)
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
Subject: [PATCH v2 07/14] serial: mediatek: add special handling for highspeed
 and linux compat
Date: Thu, 13 Jun 2024 13:09:25 +0200
Message-ID: <20240613110949.11076-8-ansuelsmth@gmail.com>
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

Upstream linux serial driver use a different logic to setup serial regs.

They have 2 interval:
- < 115200 we use lowspeed regs and 16 * baud
- >= 115200 we use highspeed

We currently use force_highspeed property to force usage of highspeed
regs even with low baud rate.

Add special handling if the upstream compatible is used where we just
apply the same interval with anything >= 115200 in highspeed simulating
force_highspeed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/serial/serial_mtk.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index d34a31c9cf0..14be095653a 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -89,8 +89,8 @@ struct mtk_serial_priv {
 	bool force_highspeed;
 };
 
-static void _mtk_serial_setbrg(struct mtk_serial_priv *priv, int baud,
-			       uint clk_rate)
+static void _mtk_serial_setbrg(struct udevice *dev, struct mtk_serial_priv *priv,
+			       int baud, uint clk_rate)
 {
 	u32 quot, realbaud, samplecount = 1;
 
@@ -113,7 +113,12 @@ static void _mtk_serial_setbrg(struct mtk_serial_priv *priv, int baud,
 		goto set_baud;
 	}
 
-	if (priv->force_highspeed)
+	/*
+	 * Upstream linux use highspeed for anything >= 115200 and lowspeed
+	 * for < 115200. Simulate this if we are using the upstream compatible.
+	 */
+	if (priv->force_highspeed ||
+	    (device_is_compatible(dev, "mediatek,mt6577-uart") && baud >= 115200))
 		goto use_hs3;
 
 	if (baud <= 115200) {
@@ -186,7 +191,7 @@ static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
 		clk_rate = priv->fixed_clk_rate;
 
-	_mtk_serial_setbrg(priv, baudrate, clk_rate);
+	_mtk_serial_setbrg(dev, priv, baudrate, clk_rate);
 
 	return 0;
 }
@@ -302,13 +307,13 @@ DECLARE_GLOBAL_DATA_PTR;
 		writel(0, &mtk_hsuart##port.regs->ier); \
 		writel(UART_MCRVAL, &mtk_hsuart##port.regs->mcr); \
 		writel(UART_FCRVAL, &mtk_hsuart##port.regs->fcr); \
-		_mtk_serial_setbrg(&mtk_hsuart##port, gd->baudrate, \
+		_mtk_serial_setbrg(NULL, &mtk_hsuart##port, gd->baudrate, \
 				   mtk_hsuart##port.fixed_clk_rate); \
 		return 0 ; \
 	} \
 	static void mtk_serial##port##_setbrg(void) \
 	{ \
-		_mtk_serial_setbrg(&mtk_hsuart##port, gd->baudrate, \
+		_mtk_serial_setbrg(NULL, &mtk_hsuart##port, gd->baudrate, \
 				   mtk_hsuart##port.fixed_clk_rate); \
 	} \
 	static int mtk_serial##port##_getc(void) \
@@ -456,7 +461,7 @@ static inline void _debug_uart_init(void)
 	writel(UART_MCRVAL, &priv.regs->mcr);
 	writel(UART_FCRVAL, &priv.regs->fcr);
 
-	_mtk_serial_setbrg(&priv, CONFIG_BAUDRATE, priv.fixed_clk_rate);
+	_mtk_serial_setbrg(NULL, &priv, CONFIG_BAUDRATE, priv.fixed_clk_rate);
 }
 
 static inline void _debug_uart_putc(int ch)
-- 
2.43.0

