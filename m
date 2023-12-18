Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E95C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DACB87509;
	Mon, 18 Dec 2023 20:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OZKf8uyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E95874ED; Mon, 18 Dec 2023 20:11:57 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3047C8761C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1389674a12.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926713; x=1703531513;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4UhcsK3ZbbFilY0m42WLmk5Fv86D+fHPZZXuEWLsRw=;
 b=OZKf8uypo7I1iY42CIhvK58u+7wpGbVzZJ5hSLcb+kDiZDShflkoKPVA/4WOKgQVMa
 izi1sRzg3BX2iBrOu8BGvwpJJIh75gz2+J3UEBowY5WxWzCeSHkPRFo/u99Q1EPnDvVP
 Nu6ElaaCmUVyNuER6L57f99UfpnkYmQSRP1UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926713; x=1703531513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4UhcsK3ZbbFilY0m42WLmk5Fv86D+fHPZZXuEWLsRw=;
 b=pkTfMlxSpFoJajRSrKJ3/Yhnp9w9YsGjJUBxXirHHlg3l36qDETskkV/5fQTw8o9lV
 Z8JPbxr6FhChgZOo0p/xpqpxM/5LI6SKVv7X0zDtsfAFZcNCCGgzKsx2gzDtkOZw5tQt
 oWVEAQ42259y0bCAvVqym1aSZG3ieZZ6Gp8qXcDqU0UUKEJjJThovZO90mO7E4K4NEI4
 BmsZnbHS26qHXj1SgmI9bub/3ZXZffwIz75yoCX1o7nwZDXw7r7DD68VIM1ZRP4oznXw
 itSaGqxSrMfrncXISrMyQFV6PLHdZ/UETho8UzPa59rSKlPW3wc28jiIpBr6QlQ2yn+U
 WGGg==
X-Gm-Message-State: AOJu0YweqdCprYmGQj4XfFe7FFQQR1gHxkIrwODK0AAN3weske7knKdP
 f3KvN7k8juO2J2REA3K80+neQw==
X-Google-Smtp-Source: AGHT+IGDuWQpov3VCPSu+Na6UISWirwBwKxG6hGQI1yXbpdA1OoX3S3/qKKolYlMOm817Gl+RZFRYA==
X-Received: by 2002:a17:90a:c7c3:b0:28b:7ee0:4ef0 with SMTP id
 gf3-20020a17090ac7c300b0028b7ee04ef0mr991572pjb.39.1702926713553; 
 Mon, 18 Dec 2023 11:11:53 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:53 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 07/17] video: rockchip: vop: Add win offset support
Date: Tue, 19 Dec 2023 00:41:04 +0530
Message-Id: <20231218191114.129329-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

Unlike RK3399, RK3288 the Newer Rockchip SoC's like RK3328 have
different offsets for win registers.

Group the win register set via win_regs pointers so that win_offset
would point the win_regs to access for any changes in the offset value.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/video/rockchip/rk_vop.c | 22 +++++++++++++---------
 drivers/video/rockchip/rk_vop.h |  2 ++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 158ba7cbf6..b719a4e4ea 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -46,6 +46,7 @@ static void rkvop_enable(struct udevice *dev, ulong fbbase,
 {
 	struct rk_vop_priv *priv = dev_get_priv(dev);
 	struct rk3288_vop *regs = priv->regs;
+	struct rk3288_vop *win_regs = priv->regs + priv->win_offset;
 	u32 lb_mode;
 	u32 rgb_mode;
 	u32 hactive = edid->hactive.typ;
@@ -53,32 +54,32 @@ static void rkvop_enable(struct udevice *dev, ulong fbbase,
 	int ret;
 
 	writel(V_ACT_WIDTH(hactive - 1) | V_ACT_HEIGHT(vactive - 1),
-	       &regs->win0_act_info);
+	       &win_regs->win0_act_info);
 
 	writel(V_DSP_XST(edid->hsync_len.typ + edid->hback_porch.typ) |
 	       V_DSP_YST(edid->vsync_len.typ + edid->vback_porch.typ),
-	       &regs->win0_dsp_st);
+	       &win_regs->win0_dsp_st);
 
 	writel(V_DSP_WIDTH(hactive - 1) |
 		V_DSP_HEIGHT(vactive - 1),
-		&regs->win0_dsp_info);
+		&win_regs->win0_dsp_info);
 
-	clrsetbits_le32(&regs->win0_color_key, M_WIN0_KEY_EN | M_WIN0_KEY_COLOR,
+	clrsetbits_le32(&win_regs->win0_color_key, M_WIN0_KEY_EN | M_WIN0_KEY_COLOR,
 			V_WIN0_KEY_EN(0) | V_WIN0_KEY_COLOR(0));
 
 	switch (fb_bits_per_pixel) {
 	case 16:
 		rgb_mode = RGB565;
-		writel(V_RGB565_VIRWIDTH(hactive), &regs->win0_vir);
+		writel(V_RGB565_VIRWIDTH(hactive), &win_regs->win0_vir);
 		break;
 	case 24:
 		rgb_mode = RGB888;
-		writel(V_RGB888_VIRWIDTH(hactive), &regs->win0_vir);
+		writel(V_RGB888_VIRWIDTH(hactive), &win_regs->win0_vir);
 		break;
 	case 32:
 	default:
 		rgb_mode = ARGB8888;
-		writel(V_ARGB888_VIRWIDTH(hactive), &regs->win0_vir);
+		writel(V_ARGB888_VIRWIDTH(hactive), &win_regs->win0_vir);
 		break;
 	}
 
@@ -91,12 +92,12 @@ static void rkvop_enable(struct udevice *dev, ulong fbbase,
 	else
 		lb_mode = LB_RGB_1280X8;
 
-	clrsetbits_le32(&regs->win0_ctrl0,
+	clrsetbits_le32(&win_regs->win0_ctrl0,
 			M_WIN0_LB_MODE | M_WIN0_DATA_FMT | M_WIN0_EN,
 			V_WIN0_LB_MODE(lb_mode) | V_WIN0_DATA_FMT(rgb_mode) |
 			V_WIN0_EN(1));
 
-	writel(fbbase, &regs->win0_yrgb_mst);
+	writel(fbbase, &win_regs->win0_yrgb_mst);
 	writel(0x01, &regs->reg_cfg_done); /* enable reg config */
 
 	ret = reset_assert(dclk_rst);
@@ -415,6 +416,8 @@ int rk_vop_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct rk_vop_priv *priv = dev_get_priv(dev);
+	struct rkvop_driverdata *ops =
+		(struct rkvop_driverdata *)dev_get_driver_data(dev);
 	int ret = 0;
 	ofnode port, node;
 	struct reset_ctl ahb_rst;
@@ -448,6 +451,7 @@ int rk_vop_probe(struct udevice *dev)
 #endif
 
 	priv->regs = dev_read_addr_ptr(dev);
+	priv->win_offset = ops->win_offset;
 
 	/*
 	 * Try all the ports until we find one that works. In practice this
diff --git a/drivers/video/rockchip/rk_vop.h b/drivers/video/rockchip/rk_vop.h
index 0528fb23f5..909f5602e5 100644
--- a/drivers/video/rockchip/rk_vop.h
+++ b/drivers/video/rockchip/rk_vop.h
@@ -11,6 +11,7 @@
 struct rk_vop_priv {
 	void *grf;
 	void *regs;
+	int win_offset;
 };
 
 enum vop_features {
@@ -18,6 +19,7 @@ enum vop_features {
 };
 
 struct rkvop_driverdata {
+	int win_offset;
 	/* configuration */
 	u32 features;
 	/* block-specific setters/getters */
-- 
2.25.1

