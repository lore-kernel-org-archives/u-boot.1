Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C3C79F89
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FBD83DEA;
	Mon,  5 Jan 2026 14:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HkgvJGng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB96183CEA; Mon,  5 Jan 2026 10:37:07 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2BD83AB7
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so144783775e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767605825; x=1768210625;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=HkgvJGngiZn/UcI/D+dFm9qFc6jXFxluWUvbkydEy7yFOwZA8kQvtRIG8QXL118jzt
 TXNwqhvQgZzwFh8MNuWhwVyGsypHQMGjqRJ2g0uTcP7h9l2bAvjV7ZkqAxDAu5iFykgj
 wJIMYLGS69h9M+SRTiiDZ4PObIE8UmlZP8SXuZSRtLpyDD1rTKawdfP9LuZyUj9yuy9w
 5FwhChQuopMaYKcy3HLC3No7veSnT1w9BS8YBSr00RJndvSkGxOQIF2g6vopBnxyy+Bb
 /HD0E8OFOtUgb6oKbEFiYRQuuFdEJTdvOz+6UrGnevBECbiRnAiM90gprfQKz0lYBxtD
 72Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767605825; x=1768210625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=NH+Xxy6WVi16JKoxwwNWPuIFZe8mJI/zpnyoMeRelIIntq5VvdSM3eo1+l2Z8Uppm1
 iJvttfKAUhmWmVTjtWNSEjbKK/izzREgVYoCs4R3Bk7m2I+T4sA5peswg07TFRECPZ8Q
 /tEZH7GL+ZngR7DCPprlG6V2RdZj2edZM3CrolnjiThfXz9LQ3MGnLSnoOywmFAoxsnc
 +tr50xVvONUf1ePnQQ4YGcGS3RoIy1KmObIhme6aiQBSUHbPIJzACqPxpAAPY9MsvOLs
 fSXQ1a4TeUIs21le/7JaH7o6NEAIeQTMakAZ8nzuDZ27ASo4Ow/Bl7jGZgSEDMS88wwv
 wfQw==
X-Gm-Message-State: AOJu0YwoR8HUbL0KTBGordS/04C7ekHeHWYgJsKb891dvi+JoG+kMmov
 PaDucRX5cdCFt406P/5hOSdo8kGeoxkemFS+oGcippmVBNAlNGCKpo9C7wCRwbQTfi4=
X-Gm-Gg: AY/fxX5Ja4BaXhefDcgJ0/mIA4nUUJbub9hF9YoJm9zUfe+ZAljuRWZaswwKCoXOcC3
 zzmLbtRT3YDqLzZ8ih2t4DPjkKcXh30EpWpjxvEJWQxpNXzYG2pONLXQ5IIu/xRrHXUtaeT9E4x
 1c7R0wM+NuJqNQngjswsDaRtnunUwNf3/lf4PJt6wdJ4rBFdcbZziEPuLx59KeaqD+++KBIilQU
 MfrLzLWji6hOh3ScEgbg7u7r8Nz7nHoQVvoZHodpIERJQoNQw6fyAr5UNBYqDjyqB1cek/oWhF0
 3wGNJt12wpLkSd7+5dLvdLrGamik0NGJgaYG6Ty0vr9xzhPFrZ9D07cKeSf/pjDtJJmYac3cArI
 xtWjXC7qs/60LAa+pOJjy6Uz+75hYCZY0uI1bBJtHrlL9y723lgnI50S3r/wk/IUlyuwekpbNMc
 CzqlyVMFAs
X-Google-Smtp-Source: AGHT+IGiEnDy5racmRSgBmtDHZmWFvOq8RBXNl9ktU9vEjlKwHD6N8zUXX829xsR8Dyilr/dA6q1HA==
X-Received: by 2002:a05:600c:4e42:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-47d1956eb65mr487451615e9.2.1767605824606; 
 Mon, 05 Jan 2026 01:37:04 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d14912asm141389205e9.8.2026.01.05.01.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 01:37:04 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 10:36:29 +0100
Subject: [PATCH v4 4/4] video: ti: am335x: Support OF graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am33-evm-lcd-v2026-01-v4-4-7617591b8159@baylibre.com>
References: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
In-Reply-To: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszoNtNLX4TsdaeoChhIP1eOnHM7r/2ZUNHb2iclHJfDO
 nwWd+3oKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIn8ZGX4ZxX38FiY2TmuDy0n
 wn2ZDiw/udjknWhPgcnhxsB379lPdDAy7Fv12dKKJX+9xVSz4FXnfdb3BLs++8Lw8eHac+cmb17
 IwggA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

