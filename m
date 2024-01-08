Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01294C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4206287A82;
	Mon,  8 Jan 2024 17:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3cOOP6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8360287AA4; Mon,  8 Jan 2024 17:45:26 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97AB87A82
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55745901085so2497910a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704732322; x=1705337122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0nW9u1jufA9yDPc8OkPmx5inrzzKMEzPforfM0Alec=;
 b=E3cOOP6ol8AQ7OfBkQiepFxWkCbcOzZYmDQryJm9a2nHtNLDjVKw0rOMDj7rm2JrMe
 Y9Tdz/ILnPcKEqsbEm9jpY491JIek/f32TihcVyLpsBXt+DnBkVzvctmhcWqjfCZ/ex4
 xIAoBdmAjMHYWXggb0gnOFiH4izyYLTNjD4kklVJiB/sP2jeFJxDDa8/kOQBSeGDv/cw
 7u6ele3A2kwpyiB8DCG0vigvAMIIO8zT5IOMgvmvhS226AY7v9SxWhPdyX/t/AfMlfHP
 sHAuatqa+RJfOaGnb+VOlnPe0HFJ/pqjwnL1eSLL+jZz5IA60Gn69UDCiNDcxRefgg3b
 3aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704732322; x=1705337122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0nW9u1jufA9yDPc8OkPmx5inrzzKMEzPforfM0Alec=;
 b=Z/h1pFeYONYRviJBMmCqjufZjgXFl2lP+A/JTGlAfB4xQ3FvZ/sRswJI+uR81XzU+I
 /baWckRy9Yvc5qR+aGRLpdgJfeUghXRPthIlhPh//RbymRkIK0N/wlsDwMwifDZs0VH8
 dJfNxWfcJ32nk9Ofo8QXfsZIpjNoehsO0Qihz0oqian2BlWfKhJ9SxkxOCnb6pWaagPt
 4YdQf2yVIE4XOO6e6JvCTM73sBos+McPXy3uWr50aDnKFWo38QEI/rBJeJD3C0UuSxrS
 Nay0xF2KnmhbUuOY90vNnO3iKueXTj/RoFoeRwNaG6CkPKhjCOOqC8Lh1+23b+a+lGo5
 Y5KQ==
X-Gm-Message-State: AOJu0YyipEuKg7Bq+2wCs8YgNBSXGblDtyXtlx4M8EoRg+auFWriO0dh
 Q1Rj8IpSuCEghnQZVe8VhJU=
X-Google-Smtp-Source: AGHT+IEnJ47wVL2cXP5G2Kp+IHf8aVjQnXM+BrK+wYXteXWmBV1hj9jjHuROEAkPSUeLezhc6t69KA==
X-Received: by 2002:a05:6402:3125:b0:555:2b97:3f57 with SMTP id
 dd5-20020a056402312500b005552b973f57mr1892369edb.84.1704732321902; 
 Mon, 08 Jan 2024 08:45:21 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 x8-20020aa7cd88000000b0055751515a84sm26684edv.51.2024.01.08.08.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:45:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] video: simple_panel: simplify platform data pass
Date: Mon,  8 Jan 2024 18:45:00 +0200
Message-Id: <20240108164501.4660-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108164501.4660-1-clamor95@gmail.com>
References: <20240108164501.4660-1-clamor95@gmail.com>
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

Pass MIPI DSI platform data to simple DSI panel directly
from driver data on panel probe.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/simple_panel.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index efb122b534..064c113d2d 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -19,19 +19,6 @@ struct simple_panel_priv {
 	struct gpio_desc enable;
 };
 
-/* List of supported DSI panels */
-enum {
-	PANEL_NON_DSI,
-	PANASONIC_VVX10F004B00,
-};
-
-static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
-	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
-	.format = MIPI_DSI_FMT_RGB888,
-	.lanes = 4,
-};
-
 static int simple_panel_enable_backlight(struct udevice *dev)
 {
 	struct simple_panel_priv *priv = dev_get_priv(dev);
@@ -111,7 +98,8 @@ static int simple_panel_probe(struct udevice *dev)
 {
 	struct simple_panel_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
-	const u32 dsi_data = dev_get_driver_data(dev);
+	struct mipi_dsi_panel_plat *dsi_data =
+		(struct mipi_dsi_panel_plat *)dev_get_driver_data(dev);
 	int ret;
 
 	ret = regulator_set_enable_if_allowed(priv->reg, true);
@@ -121,15 +109,8 @@ static int simple_panel_probe(struct udevice *dev)
 		return ret;
 	}
 
-	switch (dsi_data) {
-	case PANASONIC_VVX10F004B00:
-		memcpy(plat, &panasonic_vvx10f004b00,
-		       sizeof(panasonic_vvx10f004b00));
-		break;
-	case PANEL_NON_DSI:
-	default:
-		break;
-	}
+	if (dsi_data)
+		memcpy(plat, dsi_data, sizeof(struct mipi_dsi_panel_plat));
 
 	return 0;
 }
@@ -140,6 +121,13 @@ static const struct panel_ops simple_panel_ops = {
 	.get_display_timing	= simple_panel_get_display_timing,
 };
 
+static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "auo,b133xtn01" },
@@ -150,7 +138,7 @@ static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "sharp,lq123p1jx31" },
 	{ .compatible = "boe,nv101wxmn51" },
 	{ .compatible = "panasonic,vvx10f004b00",
-	  .data = PANASONIC_VVX10F004B00 },
+	  .data = (ulong)&panasonic_vvx10f004b00 },
 	{ }
 };
 
-- 
2.40.1

