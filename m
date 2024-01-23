Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CC4C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BE387D57;
	Tue, 23 Jan 2024 18:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9rsOasG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665BF87DA4; Tue, 23 Jan 2024 18:17:27 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E692287D6D
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50f11e3ba3aso6522267e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030234; x=1706635034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9h3FMekcBMvnYgBeVOpudZyxmncN+o/X08InfRJupHE=;
 b=b9rsOasGNVyvHCJVFeSNn7yP9gWCPi1MJRYdjASF33dIfcwzXRjMgRIGpBYkUQdJ9k
 tk8rFpWoTJnyLNHEESimpsiq9YgaR9rym2L6AM41sujiIADKgMpC3/9HsisBzlshRpBo
 +Bfh3XS/0t76/f86+/9c6oHkdm+lVGl1YqBySPHYIpjI4PGg9ExVHKV5u01Vj/olnVGP
 89xIKdtOWiE9ZVqtGqFglYjGomZFeXYblV0aGG+e4VgxOzG4NcAzfA2yVFcNHDLd9vbN
 3iWEDa3PRQdhRWeue/bwx1tRCrNKP6QTc9eWmBgCNkL0HxWfUC6oI8qH2e0QXiemkC4f
 mPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030234; x=1706635034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9h3FMekcBMvnYgBeVOpudZyxmncN+o/X08InfRJupHE=;
 b=baIo8eHP1xunn/6TK+/voxr0FLnDKG5yx8MfYchBpZ5wyj/x/+N56WagY7APaSKAl8
 K1jj9iKzloZPYFxTYDV+lrlCwgd5Km0Ejp8wVR4v2sYWzr+9YKoDcmwMC/Bbc9oru0ui
 ig5aSGStlAW38eRCSFTUQagvTOzpvHl8mnRhj7pRkqA4zxQhEPPleutztvZ5Fc0gw1L6
 NJETIegstSQJP+6jC8uwVqHwWoCvtWDqflxqUPmIIoN21k1wGJEOIWd5c0RFigRf8Z7C
 2VmV1ThhIXQ0g0Sh3DEekTB2oj7NA8pH8exz+s+nS8pNupPJTg0ie4Rp9C+Q/tm4QozH
 h/mw==
X-Gm-Message-State: AOJu0YxswQN/vdv9J3Ffs+Hpyy121VwSAQwTYB4dyF2ya8HWf8I3blAc
 Wc2FrWe8lakNfWMhpVDGsUQxuIGNYiULBFYHoG2oJxasD29GUDhO
X-Google-Smtp-Source: AGHT+IFcJxrSD4ykRGKI+K3DTudwRU1dmFUemuWulHkrMhJ0LMbg6Nm4of9shvWeUT892Ah2ePJB9g==
X-Received: by 2002:ac2:5976:0:b0:510:c63:5621 with SMTP id
 h22-20020ac25976000000b005100c635621mr278492lfp.17.1706030234203; 
 Tue, 23 Jan 2024 09:17:14 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 15/18] video: tegra20: dsi: add reset support
Date: Tue, 23 Jan 2024 19:16:30 +0200
Message-Id: <20240123171633.246057-16-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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
index 25a629535e..fc9ca1310a 100644
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
@@ -863,6 +864,7 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mipi_plat;
+	struct reset_ctl reset_ctl;
 	int ret;
 
 	priv->version = dev_get_driver_data(dev);
@@ -876,6 +878,13 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
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
@@ -914,12 +923,17 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 
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

