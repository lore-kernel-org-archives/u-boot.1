Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D66C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DDE8891A;
	Thu, 13 Jun 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIxXZGT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B734288901; Thu, 13 Jun 2024 13:10:25 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1410888E8
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6efacd25ecso52247366b.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277023; x=1718881823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1VygQ6hcB1JVrIF1U7chwaZod2xshZcNbfPBaIln5h4=;
 b=LIxXZGT3K8OJsBsCPq/wWT7OjufpTWH+qb+piwRJ06iRhw0InwIP7TYJhuFUl86EXK
 nwU/p3Q/pQlCAlip25QjvAN4yB/L1RwTTXBvRE3yq5jAc0lSS9Pf6H9DGYLRbg730NBK
 gE2vX5lxcdE420YWw/GDd8T4vX69cZfdLQ9JZEdfWX61qw7QO8cO5WP4qbaRHEsk9132
 PZaeSt9kaxSdGskOBdfh78H3FzhgMzLSijUPEKk7kY8sp7RrDb4gJAdOBVKaJlo3kGRK
 J3uln6jD4QNmZg2xPBT+s4Qo21EIVFg6wGvBtEfKhO0IfN50XXTlzInSK2SYnWi7EA62
 9Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277023; x=1718881823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VygQ6hcB1JVrIF1U7chwaZod2xshZcNbfPBaIln5h4=;
 b=vEV1fS2SfrlCJ5Vem+TpzYLDGW3wryT2LQU1gWW4uSE51ik6tKM1oR3igtgNDs/bqR
 4r1qmNDwarBD2Oxk9NxW8W+5HwaVvx+QG+9Y8mg8R9lpsUwHVAlF27ec4I2ZE8p0P4NY
 LnitS35xvIwoERhmB/LumsMcj/KJEpuWXmjYJn2Q9w405JiTuVqcvS05loOwRLXi8M9l
 jnZKTHEcLkdgegQ48oBdsVUwIJfZ6Ambc2PDD+hTBdmCT3o9WnVxxzb3Rex0WSajBVIn
 X+ggmKWi9Nx1sA2kJeIKxGS41YMTjU/vozLo7op/lSIgfsyScCAa9Yr77rsC6YUryxEl
 msKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOS989MF+JejFRPDqk3ruSTpE70npzbVZE9QjvijyEeAzMVI86xNczKHAP5S1EQcGxhH7vx6BnLujpP0NQ51xhIsLIoQ==
X-Gm-Message-State: AOJu0YxBnHnZK+ZkahCr6grDmEYQFSkCUxznNp8Dpy6n1L7T0nD5C5mp
 9xcA9keYcHPnprHQ4gnaZ9SpEZGjPpC29d44hFGK//3HtI0g6Sh/
X-Google-Smtp-Source: AGHT+IFe8NOejUhrZcLnbEfkIyWAtFe+pIeMHKSY1UUa52P6iZIyAUlWdSm69VeFZIAKT+ahZoUQrw==
X-Received: by 2002:a50:96d1:0:b0:578:6c08:88fb with SMTP id
 4fb4d7f45d1cf-57caaabd170mr4138722a12.12.1718277022726; 
 Thu, 13 Jun 2024 04:10:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:22 -0700 (PDT)
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
Subject: [PATCH v2 06/14] serial: mediatek: add support for bus clock and
 enable it
Date: Thu, 13 Jun 2024 13:09:24 +0200
Message-ID: <20240613110949.11076-7-ansuelsmth@gmail.com>
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

