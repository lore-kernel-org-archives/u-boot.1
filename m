Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0812C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08624807D7;
	Wed, 12 Mar 2025 19:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Df2Jogdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BCB81BC5; Wed, 12 Mar 2025 19:08:20 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82CB88169D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so74300a12.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802897; x=1742407697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dkTyo6jonBwdHi4t0S6J2ayzO4HO5oEwHNFRWX/juE=;
 b=Df2JogdtChUxxF82Uh2raOka5mq5kWnLZXg0c2m8ENwTTbgxkuRSxFd8tW/Yx3jYv+
 9TXmtQTSvOeyTI+WURi/88B3YoOjtZO8Kemufq/IGU9fnw5cjJ0lJs16HqyhAHBuI/Tn
 pXVpuFtL48ZpM6GiwFhcRAhzh+SDkRBJ4iNMAGWFAbvrJ7Ia+4Cv8ph0PDMrrtYpu5lu
 vDHSJbbE1R1T5ewzy4KSZj9248b5wAyKoSnFhowMuGE4QWa3BwxwqVQ/vQ9y5aoq0k9V
 LoAMo5dZcNaUlRZYl2oSZ1P5s8Bg2zN8TIVlFgGUIPylHyIv4A9Qn5PAtc9kXhOEtJ7c
 Tdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802897; x=1742407697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dkTyo6jonBwdHi4t0S6J2ayzO4HO5oEwHNFRWX/juE=;
 b=fHYQchb3xuaianG0YZ900keKM1tXZ78B7F/Lord8eX7YJ/fK92q22j+wDk53Dq7cZN
 NRO89JFDC37SXrewOxVSZR9aYSDgLix2oWHA+XL0yB8f4HFLW/O3IbEaaaYm5nyVt7av
 HMF/w08RVqTrZRufkPQczMSHuYwX3Xu5bYN+bXkl8PSCNugWqRsJi6usJcLhMUJQiZX7
 28f7tXE2u/DZt1Efz3mQa92TULPLpp6mD18jqpT1ZvI+YmMPGZDkkZTjILpDzW8T7j+r
 TGSEhd7t3xN7YSdIl7LqdouU6lQI3eT7FnlCIxhm+AvVYXa55iPaykoVp+eKOv+GtwIB
 uIpw==
X-Gm-Message-State: AOJu0YxHdoPW8T20mLoqdeDCoiUsldtR+F2NJOlhXeDvrtR3jE4ubBaO
 gA77Uggivr2KWMzgVqXng2RQejUG8Ji6cbkbHkYrZnC5grww9Md1
X-Gm-Gg: ASbGncutOs4iKjRuGBo+kBzamri7ggRaffhhLXBj00ADq2P7+g5mmF+VyLVvx0zf6iE
 nJIvOoIsbCDTuwLgnDBHsQjl6N10OXsXrEec5azZ0ToC2K5WNwgExdSzjR5XUYr23kBS4hwjdu2
 o5QPuJelNASIitmdGmhIqYDSYkhQ/P7OwR845Iz5O2iulWJERfuvyrZ6cv85zCE+Yxj9lA7pzs7
 0eUuXFqby/b38Ja+P/JqgUC9FFjx0DPtrahQuJ7++5Z0BH2PVJz2e7ozCv4mrvh7CI6KTkOE7nt
 pWn+8OdQcH+GwO0Sh1+jj1qSyJOBGc3OW1A5
X-Google-Smtp-Source: AGHT+IG68rPVZAF4DOP34UWVWHPalIO+/NsvWn4GwRmHuCqswQpVVqhJ+YSW/3XK8zaktOGuOSy6NQ==
X-Received: by 2002:a05:6402:1ed0:b0:5e4:cbee:234c with SMTP id
 4fb4d7f45d1cf-5e5e22da6cdmr23983857a12.10.1741802896790; 
 Wed, 12 Mar 2025 11:08:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 10/13] video: bridge: ssd2825: make pixel format
 calculation more obvious
Date: Wed, 12 Mar 2025 20:07:51 +0200
Message-ID: <20250312180754.120946-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Use switch condition to get pixel format.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index e7c9dc6b62b..eafd9f55913 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -351,8 +351,26 @@ static int ssd2825_bridge_attach(struct udevice *dev)
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct display_timing *dt = &priv->timing;
+	u8 pixel_format;
 	int ret;
 
+	/* Set pixel format */
+	switch (device->format) {
+	case MIPI_DSI_FMT_RGB565:
+		pixel_format = 0x00;
+		break;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		pixel_format = 0x01;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		pixel_format = 0x02;
+		break;
+	case MIPI_DSI_FMT_RGB888:
+	default:
+		pixel_format = 0x03;
+		break;
+	}
+
 	/* Perform SW reset */
 	ssd2825_write_register(dev, SSD2825_OPERATION_CTRL_REG, 0x0100);
 
@@ -371,7 +389,7 @@ static int ssd2825_bridge_attach(struct udevice *dev)
 	ssd2825_write_register(dev, SSD2825_RGB_INTERFACE_CTRL_REG_6,
 			       SSD2825_HSYNC_HIGH | SSD2825_VSYNC_HIGH |
 			       SSD2825_PCKL_HIGH | SSD2825_NON_BURST |
-			       (3 - device->format));
+			       pixel_format);
 	ssd2825_write_register(dev, SSD2825_LANE_CONFIGURATION_REG,
 			       device->lanes - 1);
 	ssd2825_write_register(dev, SSD2825_TEST_REG, 0x0004);
-- 
2.43.0

