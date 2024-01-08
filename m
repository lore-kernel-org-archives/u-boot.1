Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9605C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4695487A93;
	Mon,  8 Jan 2024 11:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHTQtAIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487F187A21; Mon,  8 Jan 2024 11:51:00 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3AF87A21
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2814fa68eeso119993866b.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711058; x=1705315858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3xptMYgx2emgpO+nyo/mflKngBnTgN5gAiM/p7T9WE=;
 b=lHTQtAItMtkGTD85cjjixBveMXdnMOnyxYfTUhdL5W3b9FJ3wUDwBvrE2DpZOFFaUE
 3/HUCUW2Pj1y3pkU3Qw07xrfFLERfw/36HyGPtCked1pmfWd+1cikJrKJidtVszVOY1N
 uB8fgMMltzdcZonpjj165sf8qMBuT55tt1N5kpD7hatGlm5KVBOtrkrZt+MxrW2qZRDX
 67Vqhexak5jQt+Sgaxp8qXEv0+HzAqWSWyHAQcI57BR+I1zJ4uw8uoKADWjbWPATDoG6
 9xGmJXswLsowa7x5vqG65IEkxAY60jWPEZ2Tc8kKEMgSiGDU3s+g1LJUyy8Ll5YrMpBr
 ClsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711058; x=1705315858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3xptMYgx2emgpO+nyo/mflKngBnTgN5gAiM/p7T9WE=;
 b=SGJMPJHQ+maJbz0y/BB3rLHUghTC2Yys4xz3rB3CrwuJai754zWoZ1GI4qMGHqh0UZ
 bSNrlooUNf1rSot6N4xjUkzo0HjqScYv9Hzynqx1K7OWe1gxwcDgdT/4dDQKXUKnv5CQ
 gqRoTrquGRQP5Kud3pf+NkGIb89TWlMWh5iZ7w48W1DgZnu2eje25ZewWhObGlcv3bwa
 D0yFoG24C/I3CC0aD5TZT/K6Jbhddl5YcKkGmxV+mGTfoBL5IoWeMD+5aSv0/SMxhw6W
 z5eBEkJnGI6P5F2MQJCl5AmEOjQUwVfarWqXjGxtBd1X0NPiuO4c/Lfz8QAzhJxaI6ht
 mmlg==
X-Gm-Message-State: AOJu0Yxh2iVYzXbSEKWjdLvKcZmcCwNHXZ057Y+qP0RdItvpM+pIkygf
 HnblxgTbfM1VJTWAL+rQjCg=
X-Google-Smtp-Source: AGHT+IFK3OK084xrFv3KK01UM/l57R83stmgJas38klhdTA6Q35FV4W0H2oHi58LWwYAZnfIIm/haA==
X-Received: by 2002:a17:906:10d2:b0:a28:ddb2:1fb8 with SMTP id
 v18-20020a17090610d200b00a28ddb21fb8mr1475996ejv.61.1704711057557; 
 Mon, 08 Jan 2024 02:50:57 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 5/9] video: tegra20: dc: add reset support
Date: Mon,  8 Jan 2024 12:49:58 +0200
Message-Id: <20240108105002.243149-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108105002.243149-1-clamor95@gmail.com>
References: <20240108105002.243149-1-clamor95@gmail.com>
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
index f2b2dcd48a..f6e20eeee2 100644
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

