Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB9FC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5E887A2E;
	Wed, 17 Jan 2024 08:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q5/K64RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C2587A07; Wed, 17 Jan 2024 08:52:51 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E670387A2A
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9c2db82b0so5775764b3a.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477967; x=1706082767;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRbvRm7HrAlo5DQRK2af4YQ1jiRXjruYTOpu9YPauYo=;
 b=Q5/K64RMr6ttevzCVJTSx3Ky0eatvMaMPhxAIasQYKLVE0b12lxKh7HWHVPhzPS/kV
 m4I/p1DIzASkNPMAi6oPs5jrxFrqs4vF2W6SDvBon0kKZgZx+5oJUOh29g77zVtPQEpw
 7tYRjHBzjcl3gV+o6MWwaEk0nvGGP8uKX+NCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477967; x=1706082767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRbvRm7HrAlo5DQRK2af4YQ1jiRXjruYTOpu9YPauYo=;
 b=uO8g0HkKHsEjE4zsN5qWDO0+ZiiZcHq+4OuPEnPJZQfry2LDyCEZOqoKzZ+sLcSzDi
 VusRSPIzpFGmZDvz7Exc5vf4D75/JQ3qW7kVkCCyXReLGMw5rJvrBbWjpAQHD/d651p7
 K/tZp1MESf7llsQVgylWkCJS41HvVINm37gT1M04Txw6IXNnQIJIBOKJhnFO1dvLu4uD
 f94alNampEHUBslOeTHZGtVtL+dF25KqajLeRkYbOHWs0afRBsJigOM/szy3Tn0kdAcE
 v003fID3slmnZoAfF7qPSbyxo5CVq3HK4aYHIVgZKmauJXwL8BR+yg8WLvjKcmAZdlW0
 Pv8g==
X-Gm-Message-State: AOJu0YzFcq/ta7uCxWYJyYgava6lxXopKxXydILxHSI0lg5wIlsBmxnZ
 Ai4HTC86hrBiY7aEQEoODgfc0Wb7Sk7siw==
X-Google-Smtp-Source: AGHT+IE63ut1rs8Z+kt555lQYt31A4WWBRghGQAp91rzG2qhtx9upK8nNOtpQ82jnKT80hX1wEczkQ==
X-Received: by 2002:a05:6a20:d48a:b0:19a:c0ac:f037 with SMTP id
 im10-20020a056a20d48a00b0019ac0acf037mr3579585pzb.57.1705477967400; 
 Tue, 16 Jan 2024 23:52:47 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:47 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 08/17] video: rockchip: vop: Add dsp offset support
Date: Wed, 17 Jan 2024 13:21:45 +0530
Message-Id: <20240117075154.58747-9-jagan@amarulasolutions.com>
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

Unlike RK3399, RK3288 the Newer Rockchip SoC's like RK3328 have
different offsets for dsp registers.

Group the dsp register set via dsp_regs pointers so that dsp_offset
would point the dsp_regs to access for any changes in the offset value.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3, v2:
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

