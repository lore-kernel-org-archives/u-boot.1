Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2043EC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EDA87664;
	Mon, 11 Dec 2023 10:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bGWdYHGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3658875FE; Mon, 11 Dec 2023 10:01:11 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B273876B4
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d0521554ddso24985475ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285268; x=1702890068;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byW24buT+ohnpKi9zMTBIPka6CRBq5vVwp3rnVXRb7Q=;
 b=bGWdYHGAoJIhF26xSr8nPF23zltOyX1TiFlqx/mqrfGcSpTihNLtRl98GLYZX+UuF4
 1gGNNx7GIYWPz0ElwcewagN8M2Vi1kr06NZ/emfD45ss+MxRI+jLKrIsnHEbvSpvn0Vy
 hTXBteAkxHSNz+I/Vt9TPbHuzkGlNtruWRtSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285268; x=1702890068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byW24buT+ohnpKi9zMTBIPka6CRBq5vVwp3rnVXRb7Q=;
 b=CmDev7iVKfAztTygoxm8GIdD9O7Q3wsDDjUikHBnGh+kOBU8Y8h+TroWv3pCj+SOuj
 nawhqHpiKOXBtXaPCbyQQV9x4ri9QEOhKmuZfKXih2aXq+xLBp8H/HA9XLMZKlIPk90q
 ilBR7ccSqxLCd3pQz0N+/OAz2rCasBiCF1LmPvWIQ6SUB8dQw285qteEgeii2r5k+IUy
 MsxYK2w+eAJzyB2zUmgg0XZSthCc9vGfcfomWuPP9tN5C+hI+nwVI/yP/XnjQUmYRnb4
 VAg3jOgnX5vagOrrrb1oK2D3+D/1WHc26mqM4gfzzmMt/loEs//1adEcPPgbSggxWSGn
 dNRA==
X-Gm-Message-State: AOJu0YxAyqa8CJp7aeBFJ49xC99CHGaCTzQ3QZxRllJOxhg/19QsaPzW
 RZ+Fzp6OQmorCTSuz3UF7CAkTrzgh8Smm5yUJrlG8g==
X-Google-Smtp-Source: AGHT+IH/gPSjEezCYskzYgZtB1bk7oB5oMt/aMcSY9HIFFAN2sCamvA0K+D0AW+Okyoc8E++l3frVw==
X-Received: by 2002:a17:903:268d:b0:1d0:752e:c420 with SMTP id
 jf13-20020a170903268d00b001d0752ec420mr1545694plb.34.1702285267810; 
 Mon, 11 Dec 2023 01:01:07 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:07 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 06/17] video: rockchip: vop: Simplify rkvop_enable
Date: Mon, 11 Dec 2023 14:29:28 +0530
Message-Id: <20231211085939.5478-7-jagan@amarulasolutions.com>
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

Get the regs from priv pointer instead of passing it an argument.

This would simplify the code and better readability.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
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

