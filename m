Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236E8C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E99487BA9;
	Wed, 17 Jan 2024 18:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNsQnVaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0836187B52; Wed, 17 Jan 2024 18:17:34 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DD287B71
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so679672266b.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511849; x=1706116649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=MNsQnVaGEhbGO1LdagQvpzTR5xOggl8MDrx3Gri3ReECqqv3cw3BbAKfqpJWazZoSX
 tsSZeM/mjs2mTsXCnx8igLaBFVi5GTfW0wL0AyGIEsUg28qDTtywc+f4CJjk9L6d+Xy+
 o4VgZiTdGWjmuZtD3lL2aJA4AKQ+TaufNfEM+JVyXc9q385TgZj0En0vLeD0m8me0OfO
 gBlnDkKd6WgvIZOoSlTgndA9qFR4MTXTcAkKTvqDiZjwi5EVjspTUyb6RtcBVabhFQ31
 Rxd4ih5aHHMjLcB2DtP9QHLqYtZvAIwwWzkZBtZ6f0NYnI+6NxwAdbSoO6d4/nDniDMi
 1aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511849; x=1706116649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=f54qEwuw4QgROLFYBwRPlRLoKMVrXulGP2lByrdsaeyAkPaREvujnvhFrFGejvAt6S
 8iVlOGdJCSnlZDzfIHGJGQx+nPD12BMpRRwl6E/xl2MSglFokRyf+1AEQMiSb5tgbFAS
 H5dwQm9UhI+8ZYFKzST+QhCX8qyxy9BC5EyH8L2z/4Ia/cwtECqFpDShIv1y6/oUIVDE
 exoQLf7PsYLkJ6mLt41r/tNACHOaxFWt9ziIUEwObPNhjLyWa0iEg6VDyJ63oEFoYhHC
 f5B00RxvLQd+LC2BMKx4GMt73DbmuQ4RmAqGqANloHxHaVWhCUHLMNdT0wZH+wL7IKbt
 5NOA==
X-Gm-Message-State: AOJu0YxobdqekrNg1Mc+VNz9l+HXeELUlocQ1NwgCU+6Ew1Il2u0d0va
 nh8zWas4767D8vEVJVwH2A+Ey4aeRHhziwCEwJLgJZ0wJ37T52lZ
X-Google-Smtp-Source: AGHT+IF3gyw1udyTUDMymtylj+SdhJB1R56Zr1Kj5vs6lyRPFcrBIvjVCFLhb1d2N8695qJi3gBqxw==
X-Received: by 2002:a17:906:b845:b0:a2e:c034:36eb with SMTP id
 ga5-20020a170906b84500b00a2ec03436ebmr1054333ejb.37.1705511849487; 
 Wed, 17 Jan 2024 09:17:29 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 11/13] video: tegra20: dsi: add reset support
Date: Wed, 17 Jan 2024 19:16:56 +0200
Message-Id: <20240117171658.22324-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

Implement reset use to discard any changes which could have been
applied to DSI before and can interfere with current configuration.

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index f4743e8458..6408026808 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -12,6 +12,7 @@
 #include <mipi_dsi.h>
 #include <backlight.h>
 #include <panel.h>
+#include <reset.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/time.h>
@@ -849,6 +850,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mipi_plat;
+	struct reset_ctl reset_ctl;
 	int ret;
 
 	priv->version = dev_get_driver_data(dev);
@@ -862,6 +864,13 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	priv->video_fifo_depth = 480;
 	priv->host_fifo_depth = 64;
 
+	ret = reset_get_by_name(dev, "dsi", &reset_ctl);
+	if (ret) {
+		log_debug("%s: reset_get_by_name() failed: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
 	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
 					   "avdd-dsi-csi-supply", &priv->avdd);
 	if (ret)
@@ -900,12 +909,17 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 
 	tegra_dsi_get_format(device->format, &priv->format);
 
+	reset_assert(&reset_ctl);
+
 	ret = regulator_set_enable_if_allowed(priv->avdd, true);
 	if (ret && ret != -ENOSYS)
 		return ret;
 
 	tegra_dsi_init_clocks(dev);
 
+	mdelay(2);
+	reset_deassert(&reset_ctl);
+
 	return 0;
 }
 
-- 
2.40.1

