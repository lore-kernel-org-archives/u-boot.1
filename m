Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E038FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E4C88D29;
	Fri, 13 Sep 2024 11:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VlDabCed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F9C88C30; Fri, 13 Sep 2024 11:57:13 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D15788BBE
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso258914266b.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221427; x=1726826227;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uD1BzqlMGtRVMj1ZQ9GmxLP+c5TtzKKgaOSr/TKj2SA=;
 b=VlDabCedvvmKfOE5C8ui6XB7sS4V+FJp2Z+3LPcaArAMKT6hZvkPT/zyF091FdZ+zP
 tc82rJnTKDlXZQZPmVJyxAcg4szSEND6G9W2UNLdjVDqekYgV+dokqHdhAH4H4j5JqY2
 k1o18Vnp5YmuZHOCn8GJoQOONcMllvUaajKng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221427; x=1726826227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uD1BzqlMGtRVMj1ZQ9GmxLP+c5TtzKKgaOSr/TKj2SA=;
 b=iNE6XJS6XfQksRzuf7Jqy9l7na3UtonMSLJLQk4jgqGP7+h27HaNCVuZ9qLfSwvAZv
 V485tU6SJpahFhr3d7l/oY3HfO+o2/RWMKS6s04PhIUY8KlR0suHEL7a3iWjPVg0BWEd
 QkQWUVJCLF4lrk55iX2DfK/iRcxQESvNjiE86KdrV53ZFREz7wHUcP2m2TsBUjeWp48B
 9QaRoJTSEtr+FX8P+yDOtXl9369tzv827gVWbCZ/LWXR7kD3sCYnVDeOQoLjseB0xwbi
 psYmlSs1zAcEBrbIZ/9pDC0LCNsWrIvDhMzREb8rLzDdrYw2SBb0ZjZLc+hxchMQ13i3
 R+sQ==
X-Gm-Message-State: AOJu0YyZEH0OQiZXF+IIWTWDeMU8djTGst8L1Yj9Sr5wYfff642ubBWd
 5wGn9SPGzuY2ix032dN/Uk5rhy37Fd+cDNLPK2ylnEor4WmK4rmzqMKrlotYvGUa9OAkyVUjVEe
 GNuk=
X-Google-Smtp-Source: AGHT+IH4Oxuy3mRFjWtH2rsuG9W247L38vB0lO+0DILZGaXo4mw0DpATrvf5zrFM+Kbn/0C1HEF12w==
X-Received: by 2002:a17:906:c151:b0:a90:1ed4:dec6 with SMTP id
 a640c23a62f3a-a902961bf01mr683128166b.43.1726221426636; 
 Fri, 13 Sep 2024 02:57:06 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Lukasz Majewski <lukma@denx.de>,
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/26] clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3
 as enabled
Date: Fri, 13 Sep 2024 11:55:48 +0200
Message-ID: <20240913095622.72377-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Both clock are enabled by the bootloader and we need to increase their
reference count to avoid disable during reparent operation.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c96a2ebaa19a..449ebf2d0733 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -154,6 +154,7 @@ static const char * const imx8mn_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_10
 static int imx8mn_clk_probe(struct udevice *dev)
 {
 	struct clk osc_24m_clk;
+	struct clk *clk;
 	void __iomem *base;
 	int ret;
 
@@ -420,6 +421,13 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_ECSPI3_ROOT,
 	       imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0));
 #endif
+	ret = clk_get_by_id(IMX8MN_SYS_PLL2, &clk);
+	if (!ret)
+		clk_enable(clk);
+
+	ret = clk_get_by_id(IMX8MN_SYS_PLL3, &clk);
+	if (!ret)
+		clk_enable(clk);
 
 	clk_dm(IMX8MN_CLK_ARM,
 	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
-- 
2.43.0

