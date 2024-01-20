Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E27CC47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D49687E23;
	Sat, 20 Jan 2024 17:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpVIq/OA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582D987E23; Sat, 20 Jan 2024 17:56:24 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF47487DF9
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50eac018059so2391304e87.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769779; x=1706374579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=RpVIq/OALLlkUdSTkyr5e6HQA9le2lMrwB/skweVe3/GWpxQqehsR8gmvO+ji9oquK
 kXOsCmHd9BCbS7R2KiBVoFFEd461ugl860ZleGeTK1UIi1yuZiXkgvXtvfWn7RF7ZanN
 hzLAgGEhCr+XpT/953zcgLKG5zSqFZjZHL+2m+E2ohnuiZYsJZd8Or2JvShLGm7k2ZvC
 i7ylTzQEQQVNTPKKRy0F9Pe+ndich0NhlgWvdHUOcSDKK5cT/tQMa4FHRRnGL0gCAA8P
 TiR6uQBkJmBcXM5H/+fSdfdKuF01c0ItqkpeQlua0NO0fVnGoYEEcrqokqsCHpj4t8CO
 +CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769779; x=1706374579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=TwN7r46ppo4ouJap2jrasXr2pDHX/mc7xmEp5HBBkkIuGEXTzS4sPAEulHks2G05m6
 z7XOhE3GwBJfbJnepQn5n10J7oZAIqcGIX61/lTn/K1e+QoW6cMsbwN6hspE0c26oiFc
 bUHs/qxKxvXIirKva2oiORVxJ8Rc/+egskUz5Fld0nLtLMBFuECcApnC4TtuqLLykLas
 4ScoE5tm8M1PuYi4K6tPpbPrAPBIHKErtu04foLHi2pjfbFh5bs5kSs41Jp6GPeZmppY
 CjiYiy0Rresl3mDsSoY8jEgdvzlw0gVpI+uff7snrXzMjDuJ4wLFjFshGWGRyTY4omef
 lqtw==
X-Gm-Message-State: AOJu0YxmDh7WaA+n+GoUWQJoAGL4YoHNW0PrkJGb0iMhX6kt+9fzgjEd
 my2MPxqSisI8QrNkZOlpuDZLnMj9RP63FsueEx5CG7XVwPTDitzG
X-Google-Smtp-Source: AGHT+IFgES5hP7bC/2njG0wYyndkftCwEcHrXZoEd77vpIYzydZJA2pGRqhM4hw8kBctHt9MJseWfA==
X-Received: by 2002:a19:ca18:0:b0:50e:aedd:ed76 with SMTP id
 a24-20020a19ca18000000b0050eaedded76mr716712lfg.131.1705769779031; 
 Sat, 20 Jan 2024 08:56:19 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 06/13] video: tegra20: dc: add reset support
Date: Sat, 20 Jan 2024 18:55:36 +0200
Message-Id: <20240120165543.10226-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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
applied to DC before and can interfere with current configuration.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 56a23b3c97..35abb6fe46 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -10,7 +10,9 @@
 #include <panel.h>
 #include <part.h>
 #include <pwm.h>
+#include <reset.h>
 #include <video.h>
+#include <linux/delay.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
@@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct tegra_lcd_priv *priv = dev_get_priv(dev);
+	struct reset_ctl reset_ctl;
 	int ret;
 
 	/* Initialize the Tegra display controller */
@@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev)
 	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
 #endif
 
+	ret = reset_get_by_name(dev, "dc", &reset_ctl);
+	if (ret) {
+		log_err("reset_get_by_name() failed: %d\n", ret);
+		return ret;
+	}
+
+	clock_disable(priv->dc_clk[0]);
+
+	/* Reset everything set before */
+	reset_assert(&reset_ctl);
+	mdelay(4);
+	reset_deassert(&reset_ctl);
+	mdelay(4);
+
 	if (tegra_display_probe(priv, (void *)plat->base)) {
 		debug("%s: Failed to probe display driver\n", __func__);
 		return -1;
-- 
2.40.1

