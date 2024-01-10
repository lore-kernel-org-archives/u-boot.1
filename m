Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE55C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC84687AB9;
	Wed, 10 Jan 2024 08:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bSiUnZ+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1054187A9B; Wed, 10 Jan 2024 08:44:14 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28408878D5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so4146771e87.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872648; x=1705477448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=bSiUnZ+HToIapFtXjOsSANk57KPUiGMQ1Cuc+6qNmjSvJ2eAk3kkEw4hxj66ECAhjl
 1MydBMxILyxvj39YBi6hPZdIzbfNnSQLk2DIRC60HcKbcw3NkQB3UyF09tYIsfD9XGvp
 EnqjMPRTeumA0eq0esE0nVxwPIMGGwANexYmqgd4bm0Ut+fejVjBhw6zYo+/oT4c3rJN
 kipJqCUDiXyPzZFZFNZ/veVCcxKsMzTSpmn4pyU0pWvlF2xncpc+j1uhKYEMqQ55ywLK
 xc4VA1eKhEafcL26Frz4t/gCCW1isju+svlcLav3Rsz0fAdHyOQjncru2V/7p9qk4ixv
 D9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872648; x=1705477448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=F8786EjaA3z9WebiUtrY9Bif0SQOPhsgJnUL42qVW0MQJJxjZg5vh1VPKoq2O6+lr8
 S6gBcNrGGiwSwENpw1AH2ps6VsXVyrLgYMR87ui3IXedkxHHHtl7pGlA3iHALiUlX410
 2vL+KaWvd2I2HesVp37kuyzwQ34JSmVBQi0bDr2v2wUsOaJLYi2COXlWNFkROJzSpxNf
 UJ53K+JcAgWPQ+P8ckrsfCf4gyA+6pqEbtaZjGZLjOpqcpPHHj2FoE3pUEoQ082Wlt4Z
 WtWearTXzIyXz9rqtOTatTLTrz1BBguYklwA1ka+fHooHIVSWDeCtGD/51mj1ru4KqXZ
 wsgQ==
X-Gm-Message-State: AOJu0Yz5zMu/IezOlgpoRjva0/SdMTpJ8kBJWMguafxTlhIqzlHxqH6p
 7XZlFtPwafgD2LwpTXXSTw4=
X-Google-Smtp-Source: AGHT+IE1jku1r8+dRs89XB+9lX9n/dNAEtLk6YqOf3u5rHfYpsFF5l9mtF5xbDaYnPTPgOD4DaaXCw==
X-Received: by 2002:a05:6512:acf:b0:50e:7d6e:11a with SMTP id
 n15-20020a0565120acf00b0050e7d6e011amr88546lfu.174.1704872648380; 
 Tue, 09 Jan 2024 23:44:08 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 10/10] video: tegra20: dsi: add reset support
Date: Wed, 10 Jan 2024 09:43:42 +0200
Message-Id: <20240110074342.38331-11-clamor95@gmail.com>
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

