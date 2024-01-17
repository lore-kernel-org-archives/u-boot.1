Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E66BC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF1487A0E;
	Wed, 17 Jan 2024 08:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UJBq4nB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD270879D8; Wed, 17 Jan 2024 08:52:41 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835B1878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d5f10052easo5638425ad.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477958; x=1706082758;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jf4mBVUQVVByOnno/raO1kLGykc+RhPZZ5tg8H0UdCE=;
 b=UJBq4nB6unogHPup4/6nXtv7A4c0nhNQGMQkTCUkLGd0hpLEU1dPBlWzEPQZpbeD6K
 ++iyf0Z9OEXvguObQdIU2iIhsykxA9J+fw6kpVOj41MIk7GsYGqgiwksqcQiod0wSYGi
 DnM1DZnflwmEbm4/WMKcp0ejt8EZiWo/98/WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477958; x=1706082758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jf4mBVUQVVByOnno/raO1kLGykc+RhPZZ5tg8H0UdCE=;
 b=wlDBxrXmHvN1N4ILQskQUrl1hbuJpIh2f3M7BUCYipzMo/0SJGUX9nFHX4FmiMkycg
 f2NbPwbFmOzesfzCyssIJ20nnWPwd75M1Vvmr4CsMOtI2JBeaDhAMl8Z7cK7cZVA7Hel
 8nBVIamM9/lShn3owqK15nHELAY9OsWtJJxBedLiVlz4marUDKJZXio4v5EXHh/Ip45K
 Ru6wchxaKfr7J4wehmRrADFicom4YoXBz3XLo+9MFz96xpjrgHgPTlBh1k6ccVQ+vIY1
 oXKjSuHf3mHwJA2b63gZiG+WZwVFP1djGeRsGMQGu+byyA2VeMdmUbBbqE+f3yJ+FfHE
 OLXQ==
X-Gm-Message-State: AOJu0YzQ1+1c7/M9BgzkW88JhF09zGCwt5EeGQ2V7uXRZsZ/KuWl53ru
 /TRe3ms0CQ9kEzOg/EPcy6oeHo1AbuBz+Vv/7CWxlAY7+rm6dw==
X-Google-Smtp-Source: AGHT+IHs974nFremSlnPzaXb40ncpA72HGbCq82eiLd9xrr3xKaPWBDAeCJTQAOZzttKeXxFY3eKMw==
X-Received: by 2002:a17:902:b907:b0:1d0:c0d3:5c1 with SMTP id
 bf7-20020a170902b90700b001d0c0d305c1mr4814338plb.102.1705477957957; 
 Tue, 16 Jan 2024 23:52:37 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:37 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 06/17] video: rockchip: vop: Simplify rkvop_enable
Date: Wed, 17 Jan 2024 13:21:43 +0530
Message-Id: <20240117075154.58747-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

Get the regs from priv pointer instead of passing it an argument.

This would simplify the code and better readability.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3, v2:
- none

 drivers/video/rockchip/rk_vop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index c514e2a0e4..158ba7cbf6 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -39,11 +39,13 @@ enum vop_pol {
 	DCLK_INVERT    = 3
 };
 
-static void rkvop_enable(struct udevice *dev, struct rk3288_vop *regs, ulong fbbase,
+static void rkvop_enable(struct udevice *dev, ulong fbbase,
 			 int fb_bits_per_pixel,
 			 const struct display_timing *edid,
 			 struct reset_ctl *dclk_rst)
 {
+	struct rk_vop_priv *priv = dev_get_priv(dev);
+	struct rk3288_vop *regs = priv->regs;
 	u32 lb_mode;
 	u32 rgb_mode;
 	u32 hactive = edid->hactive.typ;
@@ -243,9 +245,7 @@ static void rkvop_mode_set(struct udevice *dev,
 static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 {
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
-	struct rk_vop_priv *priv = dev_get_priv(dev);
 	int vop_id, remote_vop_id;
-	struct rk3288_vop *regs = priv->regs;
 	struct display_timing timing;
 	struct udevice *disp;
 	int ret;
@@ -380,7 +380,7 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 		return ret;
 	}
 
-	rkvop_enable(dev, regs, fbbase, 1 << l2bpp, &timing, &dclk_rst);
+	rkvop_enable(dev, fbbase, 1 << l2bpp, &timing, &dclk_rst);
 
 	ret = display_enable(disp, 1 << l2bpp, &timing);
 	if (ret)
-- 
2.25.1

