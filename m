Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A54C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5151881D0B;
	Wed, 12 Mar 2025 19:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iBjZBEuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C787B81A0F; Wed, 12 Mar 2025 19:08:20 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2B281DCA
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso122370a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802898; x=1742407698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Diy+Q1fBfY5st28vJKOW5YH6JhAb0Ss7hMyBp2ckcf8=;
 b=iBjZBEuvMg5VyUd/gNcWY0947wD3Jc6UCAgfYrqw4eM3nC3wcBlfqhg2g8kKhVYhTO
 H3IxsUAxnUgfwa2lS0irSRMFYJMBMxdCr7Pv/MiXAXgKqv0RFphyszO/9NwCIAplewNa
 luS66lakIqeQ1bPBLSdb83q4n4xRImyoSpKqB/KOVc5MUtfm4AJuMoe5Raihwm1lH/JE
 JRiOdbGpeed/lUtjstS+EiHQ6tSbaUVW23Kxq5kiHYE6Ee4DTHLrI6+lOv0UNXbM4JTL
 fvXtcGWZeRF5pe/TQdqes+ATU45BmYgLqqCOon9S4bLTZfLb8GeT5KN6+WaxvqAi/rM/
 eq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802898; x=1742407698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Diy+Q1fBfY5st28vJKOW5YH6JhAb0Ss7hMyBp2ckcf8=;
 b=ILsb6QStQ7VaYC5ZOi99xS09yLaxsBPAkOt8JjzfqhtZhtSeVqozqQ9j3Mm3LgJ5L7
 cSYTkuOxrMEW26wk5OLWCfGL72k7qqrM+UPyb0yW7Ch8Zvz6qDsQrgTGsqeiL2Gkcr2n
 N6JCDZ51ovCpVxJzMwLIvwY+Z/QA99lTJgjPrjQFZraZABwirMCEGbjVYZGcwyz2FgxQ
 RPB0H3oSivhETa4/0FApgaSmlCJW2EW3QUJ4CeuWa264p+Qy1qcHug6ZNXyNcjcewaJU
 n36juJF5AQHP/ElazefwD8mBz/4goVW5Cfchl2N/h/0GcF8/BxeGPpryPbLx+qeNc3xE
 HfYQ==
X-Gm-Message-State: AOJu0YwWIXa/LbqkZZJExs4yrIhYlS1ingEEjFljGLPdbsSQdA1oce4Q
 KPPB8wYUqufcluvC56t97RqEVOckL1UbKOfN5SOocN6lpq13Dfpr
X-Gm-Gg: ASbGncvQw5QWO7CAkykAalSIqqj679ZlgeM9mn94ZWScnJip/YinlOuLKaTa1p67TU9
 o9OovGQ71dzqE2R+GNffKjId9vxZ7RVXYn44icOvri9GpZblgUK5YSUdyxl38c8aCUQk4UpfhDo
 L5EOcA/Ngq8D59pCOfcy0ulEoDqxC31+cCKZer70yNkXrB8WGPJHSbtk5fpeD/tuhbpYepagadg
 BpS45R9962wP24wO03/jS8/mUcjS738o1vH6hbBOC9QQ05yoYdxjWIDM4wsnOFEV6u3N5MjuA45
 hRBQRW+JOvJ01uagH4Hi321DGfn6V9cqh6jX
X-Google-Smtp-Source: AGHT+IH0jAEsjIbmgLhE2Aie87cGiijz91RcIlhM7388542lPFCkOSMIN6kJp4Q1vUD6KgXV+HfMiQ==
X-Received: by 2002:a05:6402:4007:b0:5e5:e78a:c4d7 with SMTP id
 4fb4d7f45d1cf-5e5e78ac8a6mr33612522a12.12.1741802897896; 
 Wed, 12 Mar 2025 11:08:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 11/13] video: bridge: ssd2825: set default minimum tx_clk
Date: Wed, 12 Mar 2025 20:07:52 +0200
Message-ID: <20250312180754.120946-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

If TX_CLK is not set or gives an error, use SSD2825_REF_MIN_CLK.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index eafd9f55913..b8653cc7297 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -311,6 +311,9 @@ static void ssd2825_setup_pll(struct udevice *dev)
 	u8 hzd, hpd;
 
 	tx_freq_khz = clk_get_rate(priv->tx_clk) / 1000;
+	if (!tx_freq_khz || tx_freq_khz < 0)
+		tx_freq_khz = SSD2825_REF_MIN_CLK;
+
 	pd_lines = mipi_dsi_pixel_format_to_bpp(device->format);
 	pclk_mult = pd_lines / device->lanes + 1;
 
@@ -539,7 +542,7 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 	}
 
 	/* get clk */
-	priv->tx_clk = devm_clk_get(dev, "tx_clk");
+	priv->tx_clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->tx_clk)) {
 		log_err("cannot get tx_clk: %ld\n", PTR_ERR(priv->tx_clk));
 		return PTR_ERR(priv->tx_clk);
-- 
2.43.0

