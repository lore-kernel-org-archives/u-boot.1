Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28075C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B3687F08;
	Sat, 20 Jan 2024 17:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyC/UGfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846F187E67; Sat, 20 Jan 2024 17:56:29 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF76087ED7
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2a17f3217aso167640566b.2
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769782; x=1706374582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=LyC/UGfVh5Cux+I3i+lbrbAlwzEhdnBczpw0X54ycYmmym29rsifk1qXHTeAdE+yDw
 ygZbkNAhwZ+soArGnjNagumuvVo7YpR30SWr8M9bgL5VC72cG05fceizgaw8jpFVyNMe
 zJHcbsEcd1Kx4zt969ht0BCJzYnVNVWW5a+lz9Zo4tWwe2PYbTfmD0ke3hxeHzQYCg8X
 ovudGqQi9/Jr0UGjWKiBVn2OklAFnt6dwFCuT8stmRBS1cROPwC5pSWLoBkDu4DavZHu
 /UNFAXd0h9xxfgK7zJaNmsPwA0UooMFHg46MfRWEn6X4DGxTh1NYW1BHi4Lnu0Djt8CU
 aUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769782; x=1706374582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywT7RtroBGQBoOgjaad2C3kGUJ/r/zdruIhtLtkR65U=;
 b=syCILNgNtaF6hTe4TOptdGDJySIPDBn1pHIhCXtskinSd7fiLo5WaVPBTiygEqh95n
 SLBqq+LB8HORTX9CXsoINeB0wW3TpJUezAIouZagkbwe0RRogy2W9hLVnS4waW7nnfgm
 cfCobY9o87MBQDk2JBKk1Rt2e7n0+7xhG9Ip1zp+xFgUoA98vj1JVJhLx76REltKas1r
 TiJ1splCKyeVXOaQNGLfkGdbCWO20/Ylf3KeuF0XZZrxthnD/8V+S9LKvMyTOy5OsMR3
 WQAuAIenfdQqU/OmxJJByKhLjCsLNtjcfTHUBSVop2YNy7e2k4YjIkaTpoz3CMJvrboU
 +Hfw==
X-Gm-Message-State: AOJu0YwlZuIwCp4/FBY1nQ47f5xjUjp1Gt1jCN3lueUvvhbWv7JUV40J
 t4yxF7zmf5zCPm9SwziIEDVV+oJbqBBzNfCaYxn3p3Fj7Vfu5Au4
X-Google-Smtp-Source: AGHT+IGVoSc9lf0hN0lI9OyN4sbAZE4p7GRzYMrjkECX1plAhOu+ZK3HYECc+B4Af8tJmGkJexEp5Q==
X-Received: by 2002:a17:906:f8db:b0:a2d:45c2:5f8d with SMTP id
 lh27-20020a170906f8db00b00a2d45c25f8dmr765701ejb.121.1705769782446; 
 Sat, 20 Jan 2024 08:56:22 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 11/13] video: tegra20: dsi: add reset support
Date: Sat, 20 Jan 2024 18:55:41 +0200
Message-Id: <20240120165543.10226-12-clamor95@gmail.com>
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

