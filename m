Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420D9C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB8787252;
	Mon, 18 Dec 2023 20:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ivDHhWU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DFE8715C; Mon, 18 Dec 2023 20:12:01 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC1D87252
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c673b01eeeso1341220a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926717; x=1703531517;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZU03AWD78AcVQvGB6vWKP75Nwr9sgVJy1Evf3TSi4rA=;
 b=ivDHhWU9+KLrPUt/Hxq3HCefhwTFI8sA+xEbhgffhsG8U/Wv9uYQWHNbu0UA+qEIVf
 lfP/KWU8NnPBSsXA6hmhk0pa0xCqJLXiddcoUAk1N0b9lVCGyvNzIjb8aL0eJy1+ae7b
 cz6hwWzxLQs9+Kd0a9im445VYyIVLqNBPjR6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926717; x=1703531517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZU03AWD78AcVQvGB6vWKP75Nwr9sgVJy1Evf3TSi4rA=;
 b=PbeoywqxoTkFtAHreb1kPdAkyepkXaMm/zhEk6ZX7J3bUXLxqWwJBRiUvN/xkvSf/7
 npxbLl0bdg+XfM4mXWA86t9oWP+IdnHMI6ALb1U1j9HVioZ/INHWwI/W3Rk2LSnQF4rg
 Hn9fkfFAewyAY/W6jfoe1GUiVPMpUK63CR1czR0nTlY9YctBTjWjRdIpbhxX/jKZr1GV
 dIqjm/PkwOKDjcgflR0/zcaJZDtpPenHucIOgugx/D0bF4suxWPoXLAWRl34620PEy88
 lkRDNabFRFK/VbIBTx4aNGESbUbYu9wKVO4IzG0O11MPevbUtiQx53s3WZtUeNm9ZUOf
 muRw==
X-Gm-Message-State: AOJu0Yxhy/wkXvPxOKWCZevje3e8J0JE86pVbjKYyDQ9zwW8fBZX7zf8
 jd+A7oK33VNrW/ETrpHnB87nLg==
X-Google-Smtp-Source: AGHT+IGTx8/FcPh1JZMo24q5Xu6vWT6nQ+JmC3/iZu76e2IJDp9CnhmYTDH9p/NyRJu3FCnfpJ24Ig==
X-Received: by 2002:a17:90b:1918:b0:28b:865a:8dad with SMTP id
 mp24-20020a17090b191800b0028b865a8dadmr856885pjb.85.1702926717259; 
 Mon, 18 Dec 2023 11:11:57 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:56 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 08/17] video: rockchip: vop: Add dsp offset support
Date: Tue, 19 Dec 2023 00:41:05 +0530
Message-Id: <20231218191114.129329-9-jagan@amarulasolutions.com>
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
different offsets for dsp registers.

Group the dsp register set via dsp_regs pointers so that dsp_offset
would point the dsp_regs to access for any changes in the offset value.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- none

 drivers/video/rockchip/rk_vop.c | 14 ++++++++------
 drivers/video/rockchip/rk_vop.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index b719a4e4ea..acc02e5d7c 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -165,6 +165,7 @@ static void rkvop_mode_set(struct udevice *dev,
 {
 	struct rk_vop_priv *priv = dev_get_priv(dev);
 	struct rk3288_vop *regs = priv->regs;
+	struct rk3288_vop *dsp_regs = priv->regs + priv->dsp_offset;
 	struct rkvop_driverdata *data =
 		(struct rkvop_driverdata *)dev_get_driver_data(dev);
 
@@ -198,27 +199,27 @@ static void rkvop_mode_set(struct udevice *dev,
 
 	writel(V_HSYNC(hsync_len) |
 	       V_HORPRD(hsync_len + hback_porch + hactive + hfront_porch),
-			&regs->dsp_htotal_hs_end);
+			&dsp_regs->dsp_htotal_hs_end);
 
 	writel(V_HEAP(hsync_len + hback_porch + hactive) |
 	       V_HASP(hsync_len + hback_porch),
-	       &regs->dsp_hact_st_end);
+	       &dsp_regs->dsp_hact_st_end);
 
 	writel(V_VSYNC(vsync_len) |
 	       V_VERPRD(vsync_len + vback_porch + vactive + vfront_porch),
-	       &regs->dsp_vtotal_vs_end);
+	       &dsp_regs->dsp_vtotal_vs_end);
 
 	writel(V_VAEP(vsync_len + vback_porch + vactive)|
 	       V_VASP(vsync_len + vback_porch),
-	       &regs->dsp_vact_st_end);
+	       &dsp_regs->dsp_vact_st_end);
 
 	writel(V_HEAP(hsync_len + hback_porch + hactive) |
 	       V_HASP(hsync_len + hback_porch),
-	       &regs->post_dsp_hact_info);
+	       &dsp_regs->post_dsp_hact_info);
 
 	writel(V_VAEP(vsync_len + vback_porch + vactive)|
 	       V_VASP(vsync_len + vback_porch),
-	       &regs->post_dsp_vact_info);
+	       &dsp_regs->post_dsp_vact_info);
 
 	writel(0x01, &regs->reg_cfg_done); /* enable reg config */
 }
@@ -452,6 +453,7 @@ int rk_vop_probe(struct udevice *dev)
 
 	priv->regs = dev_read_addr_ptr(dev);
 	priv->win_offset = ops->win_offset;
+	priv->dsp_offset = ops->dsp_offset;
 
 	/*
 	 * Try all the ports until we find one that works. In practice this
diff --git a/drivers/video/rockchip/rk_vop.h b/drivers/video/rockchip/rk_vop.h
index 909f5602e5..eba68d87c4 100644
--- a/drivers/video/rockchip/rk_vop.h
+++ b/drivers/video/rockchip/rk_vop.h
@@ -12,6 +12,7 @@ struct rk_vop_priv {
 	void *grf;
 	void *regs;
 	int win_offset;
+	int dsp_offset;
 };
 
 enum vop_features {
@@ -20,6 +21,7 @@ enum vop_features {
 
 struct rkvop_driverdata {
 	int win_offset;
+	int dsp_offset;
 	/* configuration */
 	u32 features;
 	/* block-specific setters/getters */
-- 
2.25.1

