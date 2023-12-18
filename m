Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80BCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835F587578;
	Mon, 18 Dec 2023 20:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MYNzdslU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE57E875E9; Mon, 18 Dec 2023 20:11:52 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4862874ED
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28b4563a03aso1034522a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926709; x=1703531509;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnhmyPfXLnntoQwKVtLyzor2rw56W86wDDzZodRGKco=;
 b=MYNzdslU6nYLI53SwQF4wqIpBcxov7qqHNfQ/J4NfSX3w3x43vbkkgZ3tTzO3ayo94
 KqvFhQEbGkVnHQhOghkdGSiGkuqnGK5amEF+7H4vq5y6TsSrBR84+4VuSLkLmJZ7P1I4
 y99i7y1fjWyWTggTBoo4VXgPX8CU39pTREJjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926709; x=1703531509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnhmyPfXLnntoQwKVtLyzor2rw56W86wDDzZodRGKco=;
 b=FEFpg6JtE9BJ4rZGRc0LMxKrKENHJ4K1feYfzIIhxcbSdpQD/DFufQv+poLsN2bFe3
 1CoyYar6I9aewp1IbRi2KYEh43Dbb/Ci56vyZPHnUsm9QDRdNWHEwtV8j9tmNkmpmAar
 fa8qgV6lOi2mQYMkExtj5Rj0RqVt7pRmUPS5C1NgBcKzsdlydPDe35Fp7TMC/Jg+bbHB
 qJGL1wAwo3xbiwXOEFrm2JeVazCOPymh0jLpvVS/YMvPHuLsSnObvyrpE5KAIOFQPREu
 ZkySanImeLM0tpOerFigdw5Tu3U4+rcj8ImVF1FrlzlSaMhbmvE4mggE+1s2WltalfCA
 dQRg==
X-Gm-Message-State: AOJu0YyhSJ1UxW5PBkqzID0GQ9yA8j76Rz45OymoJ8bzv2F07L0aoB1A
 ZKIET2FH+e04+jwwZPkBmjJKHQ==
X-Google-Smtp-Source: AGHT+IEEzFUHVYkh8/pFhMIKz90SHfPIPzvMRvmJtzPsNzO6f9oQMwesiKC/qD6G7gXC5EzoQI7RtA==
X-Received: by 2002:a17:90a:4e4e:b0:28b:90c7:c7a3 with SMTP id
 t14-20020a17090a4e4e00b0028b90c7c7a3mr902968pjl.75.1702926709210; 
 Mon, 18 Dec 2023 11:11:49 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:48 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 06/17] video: rockchip: vop: Simplify rkvop_enable
Date: Tue, 19 Dec 2023 00:41:03 +0530
Message-Id: <20231218191114.129329-7-jagan@amarulasolutions.com>
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

Get the regs from priv pointer instead of passing it an argument.

This would simplify the code and better readability.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
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

