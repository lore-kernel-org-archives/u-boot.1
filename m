Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F07C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE6788452;
	Wed,  5 Jun 2024 21:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOt9xva5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F4988370; Wed,  5 Jun 2024 21:03:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26F888096
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354dfe54738so88559f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614228; x=1718219028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1VygQ6hcB1JVrIF1U7chwaZod2xshZcNbfPBaIln5h4=;
 b=MOt9xva5jyTGH8VeaWFad4VAeyhJBbqww0QwRJqU6VzGiPx4PtD0Tmpu2l3CnSTfEW
 q16FHhSQTgy10wmMBUt5oTnChXWe2JZQZKDw0JpqS2tg0Y/knSIqGDKBBTMzvP64kbfx
 dlYhTkJB6KiGJYpXElXsLPxgPXbGGE/KAB2BRGDyuxVVtpoJEJagEUzDufQgf9kaeEA7
 Nj2FzSGtv2pZAtX7Zma+1ZAWF1VhTNjxsFeXz6xVTahQ+278nMT/73drWEOhzt+vOZb2
 lP6LrHGN5E75+edx0DA7Y0waHZpnP3UlV1HY3OO0jV7/Lk1u79CMWRA4vFEDMFh2RPfH
 34hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614228; x=1718219028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VygQ6hcB1JVrIF1U7chwaZod2xshZcNbfPBaIln5h4=;
 b=QiGy73L2EbB978FKsyN/s3NKYzzgT/aEDP31fVMBbX6zA/52Nz2uk7t0WW4pD4b0r5
 GF/AWGupAoedU5ESIsrL8t7xEBYp23A2ecuPeFZ2dhwvUVgrhK5RzPA48nojHicLHWmj
 lxECEUeqVa1RYYVUQzNAZIrJU3yvzaMeQmnR0NpHU+CyRYJ1fRww53pCCuVf8K2tZrQC
 /0dhkO3moYeAAUY/YYooAzSkijCGIxvIjIFpFaOaNf6+vRHrqjHvvYLrsZn39yWzcCwo
 VqhgPcBlJ04u90B5/luTLB/GAf6qrpQEiZAN9kdTJR6sxjlHcQjFPvvv6ozNoabymXDQ
 h+ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxHwfgQqLVcQFPel/4EfYB+jhN8IpL/VsiqWKqgRAhSWDrhKAbnevhraIHh5tCx0kb0dvZ4KIFSiHBGWfzb0PTvndr2g==
X-Gm-Message-State: AOJu0Yz7cZ5LY8WXVSMFHAtsHeT9EbQD5kk5MnhiizawpY1oWboxPeIj
 JDBeqEOCFC2G9FwUQ93jVTZirfSXCzXF8z4hghwcXtJ7+a/yvpGO
X-Google-Smtp-Source: AGHT+IHza5c0MHYTGQ9lnPasY8bF/6ean9KXn97yG+e9+NQbVDO9qJnoRbxflspxj5BJANEWxJXEIw==
X-Received: by 2002:a05:6000:118e:b0:354:e0cb:8dcc with SMTP id
 ffacd0b85a97d-35e8ef65b39mr2712956f8f.54.1717614228168; 
 Wed, 05 Jun 2024 12:03:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:47 -0700 (PDT)
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
Subject: [PATCH 06/11] serial: mediatek: add support for bus clock and enable
 it
Date: Wed,  5 Jun 2024 21:02:13 +0200
Message-ID: <20240605190220.17616-7-ansuelsmth@gmail.com>
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

Upstream linux also provide the additional optional bus clock.

Add support for it and also enable the baud and bus clock on probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/serial/serial_mtk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index f146f2b006e..d34a31c9cf0 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -76,6 +76,7 @@ struct mtk_serial_regs {
  *				driver
  * @regs:			Register base of the serial port
  * @clk:			The baud clock device
+ * @clk_bus:			The bus clock device
  * @fixed_clk_rate:		Fallback fixed baud clock rate if baud clock
  *				device is not specified
  * @force_highspeed:		Force using high-speed mode
@@ -83,6 +84,7 @@ struct mtk_serial_regs {
 struct mtk_serial_priv {
 	struct mtk_serial_regs __iomem *regs;
 	struct clk clk;
+	struct clk clk_bus;
 	u32 fixed_clk_rate;
 	bool force_highspeed;
 };
@@ -220,6 +222,10 @@ static int mtk_serial_probe(struct udevice *dev)
 	writel(UART_MCRVAL, &priv->regs->mcr);
 	writel(UART_FCRVAL, &priv->regs->fcr);
 
+	clk_enable(&priv->clk);
+	if (priv->clk_bus.dev)
+		clk_enable(&priv->clk_bus);
+
 	return 0;
 }
 
@@ -250,6 +256,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 		}
 	}
 
+	clk_get_by_name(dev, "bus", &priv->clk_bus);
+
 	priv->force_highspeed = dev_read_bool(dev, "mediatek,force-highspeed");
 
 	return 0;
-- 
2.43.0

