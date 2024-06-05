Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7422C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D7A8837B;
	Wed,  5 Jun 2024 21:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDGJU3j0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6800988377; Wed,  5 Jun 2024 21:03:52 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A26688300
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42155143bb6so2185655e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614230; x=1718219030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dkLSO2oqFmlNq+CTGLdRXojERXtEUdcRUTUSIaM8Y+w=;
 b=hDGJU3j0PPhOaSjKRmKWrDT8BKEm0TkYEc8a78yLzU660igbRguXzGorhdHXQyhPc9
 AEzxlheBtlnoFNBAxquye4Bc6SO/DqNJPhWPUeY+1vQbePJpwTgVB0NEWNHn6gMVUd7U
 w+ZyND+ShREI30iCrND+C3qyc4u5ynsaxCNbzXxisJzN2fl+U+W7lK/ELvVFcVMxDGHq
 WUkg2wUyNDfDv9SccjCjJYF5+IA1zb3xY/Vc6ueMYg3fcjXE6A+mmqRjfDHKWmarPnpU
 Y+eoApGtX+/Q9xj0McHQuL4oX5GLq0ELGtQpGvL31yShFoUs03b30hmuyTaN8xll7N9L
 s9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614230; x=1718219030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkLSO2oqFmlNq+CTGLdRXojERXtEUdcRUTUSIaM8Y+w=;
 b=ksSGI2ioLDJhc0b6MCZtfqEusbkDgAekflRXtytQul564bkcC4HCrnRu1uUavAX2go
 tAUJn1bmowSSDiCdQ2ML49XfjDDvu4TbQER4M5fY9app7OqnBfjZ7g2j9pwvAjbHBxcY
 v/GTFddyVuiY0ZAlT1yS4Tl77IOp4d/TwtBQwpR+I8D7S0TheUruUoX2GHjcNywpHgRN
 Sp5xUWuJWLQywtC7ZsvbZCF5xyT6BDPwwrIih4D36Xa5OcZnAUFOW4b2TA6JOWC6vd7j
 FYMnKQpTGR0g+12T12uiIZd8gxTnU4i0AmO/QzZda9djFhopjD9jAoBz/h0MrA4T6t97
 LbTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeWbbeDyBb5eRK4Cb0HwipTvjXHNcg36X7y5zt25aljHVxGePVVDVdLuypKZmxHdjCOa1bVozAzs3auIyHYjpy7W7pVQ==
X-Gm-Message-State: AOJu0Yxl6TsaxVfO9vPfg1hDscMauNscfgHVleETChkYMOYz/FaxmFWR
 BLWhwh/WhtdzwJ2M9yfr0n8n+6SJpQUvJOF1gzXnMtv753OR2ZEN
X-Google-Smtp-Source: AGHT+IH8zaxo9wFwsrm0LmxADoSHugTCa0t+W5kfxi/x/L1FdFxTgwiPyLkDNbsQWCq92RDquZxo9w==
X-Received: by 2002:a7b:cbd9:0:b0:421:2049:5d66 with SMTP id
 5b1f17b1804b1-421562eeaa0mr27783395e9.21.1717614229841; 
 Wed, 05 Jun 2024 12:03:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:49 -0700 (PDT)
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
Subject: [PATCH 07/11] serial: mediatek: add special handling for highspeed
 and linux compat
Date: Wed,  5 Jun 2024 21:02:14 +0200
Message-ID: <20240605190220.17616-8-ansuelsmth@gmail.com>
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

