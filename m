Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F9AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB678876CC;
	Mon, 11 Dec 2023 10:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EZ0g3tDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20423876C9; Mon, 11 Dec 2023 10:01:20 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD03876CC
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so24564925ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285276; x=1702890076;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MsqmQwoaPpU60gRRz+8oXZ89d3jUsaMwyPXkyOGV5I=;
 b=EZ0g3tDVVU2phFBxz4rgI76rXOvSyqRW57CbORxEkibH9jMS5rHAJ9L1lJUwAtfR0W
 XZzEyDWYHv1dRt/2YuHhCByxM91B7zijysYLgbJTJ0/hLXDmrBVDxtNpKxUAvPrvBYU5
 4OIVE4HNW0eET9TBr0L0xOpiSrnEIjZ3pfmgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285276; x=1702890076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MsqmQwoaPpU60gRRz+8oXZ89d3jUsaMwyPXkyOGV5I=;
 b=DYsdZ7nD6fDkPtLVZGU56dE2b+YdzpWNNibKp43GrK9peF+iogrlUYrd8eRaaN3kZP
 rbXxV3fJnkwDazVSGlgW6IzwvnfSK/VUC6U8PT1adI7VI6sHJ7ooosUZTM2gKGFeWEoe
 OsQhU/Dl73N8J3k3NmLbGXQg4GRjiDCwOlDulE2FMZabDnWrfTktGaRoDAEwCXQI1ftK
 LTVoucXw/OeSwlIKech//ZX7AsNn2qNnpZAdw+JeRw6fAfLKq2oLumQ0+IbZ++z4HFN+
 NSg4TuCotT6R3WCDf3lbH3ke9l8JR3jna1UXl6umBMWbuPcvY1zGeIpmlpRpPBgmTlPW
 FGnA==
X-Gm-Message-State: AOJu0Yw/1kUEB66MW3ytfYiuq58E+IkmUE5GcUfRAXqtg7tSll3qbFBZ
 1Wznrf9Z9fqTQzNaA6f9f+bWCA==
X-Google-Smtp-Source: AGHT+IHrd9f0dmUEpKTsOPY7UfSXO1bSTpvU6lgGUCC95O08vj5i+kr68rQMaJidga+TT2VBUb3Zbg==
X-Received: by 2002:a17:902:778d:b0:1cf:cc23:eff with SMTP id
 o13-20020a170902778d00b001cfcc230effmr1668274pll.52.1702285276115; 
 Mon, 11 Dec 2023 01:01:16 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 08/17] video: rockchip: vop: Add dsp offset support
Date: Mon, 11 Dec 2023 14:29:30 +0530
Message-Id: <20231211085939.5478-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

