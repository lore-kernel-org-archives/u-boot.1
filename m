Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832DD12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC1B84010;
	Wed,  3 Dec 2025 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VReygIz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EAF8828A2; Wed,  3 Dec 2025 11:19:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D8083F6A
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79b9113651so395231766b.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764757193; x=1765361993;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=VReygIz5rEUSEOW5vdJ4+/Lw9CcxSwsfkH9vXcYR0CQTPcQWf0VusJWStHAJl3t82H
 NWz5nEi8vh36x0LcPP/9DKE2+gPgN2yh0Z09rImXr5fcZJEH3Rx05UcnCUCKF0BLap1k
 CKic/0Qzk9sKoxv4c6PyfTRxjgyNhpHyZ22BBBhuYaeLD7o0LLibkL6Fn9MvIIUrO05s
 lz8ckDhpNx9LTgs2YzczLYrRXdxl7XZn4E/uQKjEd+v7t8a+ifj7dLgSoBCIhzi8FUXu
 c1HaVRToywNCnIdVO2VaB4LNzMXdgz8lan0IgjNNks0NpsGk2/14H19RYYT0K6F+qjKv
 05Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764757193; x=1765361993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=pEHBNM1iwzgji3qpdMmqJk8+FhQ9bhCZcwQyav/WOMubANsx/OB3dXjjcILP4lpZST
 JqUOaxB11KtEXnMVeAy0Dm9bPyq7kuMJKHbFLdMPf3FUj6tkPXowA0ce3DCOKfGvhMPA
 VUbHuziyVL/41EAqdg6UeQJUay5BBPS12YFrTGHroUVo0n7zykSmPxgFMFuaUMh4WYeP
 GMbU+LF+o4D8E35FkcyoqZ2HIOQrQ9kvFkq3t5wGClcQdlxpABJQxLlCh8qQ4sZRGZDW
 6eswsqkF12tO+lBBrBBsTO6A/DJgcYvI1RYIqgw4kZe2cNnH2jXseVdTae3chGjy3u3S
 oDSQ==
X-Gm-Message-State: AOJu0YwJucnGBAk6iXoszrYueuq7l/IK35eOof2afWucVqlLKzGDZLmQ
 D6svp5ETR7YTmcbUsg2KxaUFJjqrK5Dws3lPYV/+R5S8Fd0V+R3lhsVUTAyDGuNkzxM=
X-Gm-Gg: ASbGncuj7PXtA5Mq5XVic12lzwlQwQRbBjKWr/crYuo2xto1m/KDNAjiRVWWzWFzXhG
 S0F14gFZ3aSvBvHjNeJL2+aguNmW/RyeQ01/WMAXcYEbrqdJ/rvSxEuLG8MU2aG4yM/3ZEbKozE
 9AM8/68XvoCUAJ7uO1cFtZ6JX/Wl1LgNyrDQsoYHIspB/DvGyqnoYQBcq6+mqJG5GgM9UIIlwta
 FTBnH/TJ+YPTUEzum4flvwMBwypb38gB2msgrRRcNLmk84btK+/kcPgkycsOguPufeiTA6MqX7G
 h+J4Iys6HoGJhxD2MRC9htShR3QanT7AXorxHDDVHZSPr1Qb7bHBApEyMjQsaxFW9pSSsiaZ4rU
 d6Slgcq5zXrUA1cFBwbqoWwFdtJA8tyGWNhMTCkLOKpXe+nfyswIKwSI1lJJYgyO8jwihNNoIs9
 vzkX5ZmM4rUwNcS+KfGg==
X-Google-Smtp-Source: AGHT+IEKtsrVUrhegWeKQktts0IZAunqoG6JfzkUC/D+CpWhntsnuN+ijqKK/Y70Bvk3QaqHOqFPoQ==
X-Received: by 2002:a17:906:f585:b0:b73:9b49:2dc7 with SMTP id
 a640c23a62f3a-b79dcbe5420mr171098766b.52.1764757192882; 
 Wed, 03 Dec 2025 02:19:52 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79d1c6219fsm177805666b.2.2025.12.03.02.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 02:19:52 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 03 Dec 2025 11:19:13 +0100
Subject: [PATCH v2 4/4] video: ti: am335x: Support OF graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-topic-am33-evm-lcd-v2026-01-v2-4-262cf4f34eb5@baylibre.com>
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=msp@baylibre.com;
 h=from:subject:message-id; bh=BLqCJ5mUVvTnsP3XHcrulNh/wDuhDSCUp6GaeQHqvYA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwDvn07Z7LFLOTdJabZw5w/XUCU+4kwE/POgNPbH2uqZ
 YUs1hPqKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInEKTL8Ykpmizy3+634HsZ1
 +9k7o7sK/2a9iq/INl6Y/3j9zdO1ZowMPy5e7NxsGKPGULYnfr3BkWaWycdPvrQomPV1n3TDnO5
 17AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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

Add support for OF graph parsing. When using OF graph the default
tilcdc_panel_info is used which is the same as defined in Linux.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/video/ti/tilcdc.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index 340c79299bacabc5a95dbeafbed3cb729afe7576..b498e81864b87464c00c1b23cb1d35394b06d9e8 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -6,6 +6,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/ofnode_graph.h>
 #include <log.h>
 #include <panel.h>
 #include <video.h>
@@ -113,6 +114,18 @@ struct tilcdc_priv {
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static const struct tilcdc_panel_info tilcdc_panel_info_default = {
+		.ac_bias                = 255,
+		.ac_bias_intrpt         = 0,
+		.dma_burst_sz           = 16,
+		.bpp                    = 16,
+		.fdd                    = 0x80,
+		.tft_alt_mode           = 0,
+		.sync_edge              = 0,
+		.sync_ctrl              = 1,
+		.raster_order           = 0,
+};
+
 static ulong tilcdc_set_pixel_clk_rate(struct udevice *dev, ulong rate)
 {
 	struct tilcdc_priv *priv = dev_get_priv(dev);
@@ -173,6 +186,8 @@ static int tilcdc_probe(struct udevice *dev)
 	struct udevice *panel, *clk_dev;
 	struct tilcdc_panel_info info;
 	struct display_timing timing;
+	bool is_legacy_panel = false;
+	ofnode remote;
 	ulong rate;
 	u32 reg;
 	int err;
@@ -181,10 +196,21 @@ static int tilcdc_probe(struct udevice *dev)
 	if (!(gd->flags & GD_FLG_RELOC))
 		return 0;
 
-	err = uclass_get_device(UCLASS_PANEL, 0, &panel);
-	if (err) {
-		dev_err(dev, "failed to get panel\n");
-		return err;
+	/* Try using remote node first, then fall back to using UCLASS_PANEL */
+	remote = ofnode_graph_get_remote_node(dev_ofnode(dev), -1, -1);
+	if (ofnode_valid(remote)) {
+		err = uclass_get_device_by_ofnode(UCLASS_PANEL, remote, &panel);
+		if (err) {
+			dev_err(dev, "failed to get panel via OF graph\n");
+			return err;
+		}
+	} else {
+		err = uclass_get_device(UCLASS_PANEL, 0, &panel);
+		if (err) {
+			dev_err(dev, "failed to get panel\n");
+			return err;
+		}
+		is_legacy_panel = true;
 	}
 
 	err = panel_get_display_timing(panel, &timing);
@@ -205,10 +231,14 @@ static int tilcdc_probe(struct udevice *dev)
 	if (timing.vactive.typ > LCDC_MAX_HEIGHT)
 		timing.vactive.typ = LCDC_MAX_HEIGHT;
 
-	err = tilcdc_panel_get_display_info(panel, &info);
-	if (err) {
-		dev_err(dev, "failed to get panel info\n");
-		return err;
+	if (is_legacy_panel) {
+		err = tilcdc_panel_get_display_info(panel, &info);
+		if (err) {
+			dev_err(dev, "failed to get panel info\n");
+			return err;
+		}
+	} else {
+		info = tilcdc_panel_info_default;
 	}
 
 	switch (info.bpp) {

-- 
2.51.0

