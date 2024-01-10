Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F6BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B53287AB2;
	Wed, 10 Jan 2024 08:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPKuu765";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2011787938; Wed, 10 Jan 2024 08:44:11 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7471787A36
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a28e31563ebso397565366b.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872646; x=1705477446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=VPKuu765Df6U4fzJlXyc56oJmYQIKUOT4q8xIjkuPFIaDroKdw6tUtXqEKryGPXBL3
 YbOakdNsqteZzwb+NNxZcRMu2aeGUgax9ZdVD3UFN9x/pb9Nfb8yRp4uzr5F9GHInnVF
 IU6zlZc7s1Uw6luHWTGNrw+o/9YcPfL1a91JYxJ6wcZGXQIyYkbbVtWvf9bwSS1jMPe6
 wb6iJmQ5BWYO6ewbQ8FfbbyaOHeV4Se+w4GM0y3aFG+gAhwHYsNfTuzEe7NoM/Ewzzeq
 akPqDJ824ytXFWdt/g202u9FRU2aDCXVzZDzDZkjocJHUvLKKng0PkMhOvZxABAheKXV
 gDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872646; x=1705477446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zerQ22x/x8UOxAW3Wsxy4H6ymQPKhUl2gDGa7gIhMSQ=;
 b=QLwlGrZkwyp+HNXij4zi+pN7qJXVebW1V4IZyB6Fsy9IWgmHDbIHEVkuY2mjTtG/4R
 55/tT75Q8aEr/tHMixgcflywSNCa07OdqoPS8SWO6qDMtDYzgJwTrhLzivZEiI4Mzzny
 lm9E8gvLm91nn/XgXNjHK2FUDkOvG1hetfVdKMsNZc5joMKzuXWJlYrXJGNjEpB6CCA0
 sVP6POhKLHqEoN8sWedivsO/oxW3AjEvAcVxqK3+Aj0uY1seZlNWlypELRGig6yIaQsi
 90DwORJl6KOHQoRVJvGnBoxbWSiOQYn4VHZM6RkWC2nn0CZKIvrco5T9zYvdmjEtHMTj
 50qg==
X-Gm-Message-State: AOJu0YzALktGopxIU0Ifseh978f0wgRfUrrCRQu4fbZFgrKOm58A3Ovg
 RHOlN9EVFnb3uDfv1UQJELk=
X-Google-Smtp-Source: AGHT+IFZx/i5JUoQsMgf8lZSdraBCCdlLBquifVCqGaTGftHqscyzZKxXb5fJDBgi9GDUQuwke2S9g==
X-Received: by 2002:a17:906:220c:b0:a2b:c6c6:21a5 with SMTP id
 s12-20020a170906220c00b00a2bc6c621a5mr272734ejs.32.1704872645946; 
 Tue, 09 Jan 2024 23:44:05 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 06/10] video: tegra20: dc: add reset support
Date: Wed, 10 Jan 2024 09:43:38 +0200
Message-Id: <20240110074342.38331-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110074342.38331-1-clamor95@gmail.com>
References: <20240110074342.38331-1-clamor95@gmail.com>
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

