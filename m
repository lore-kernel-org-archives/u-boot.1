Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF0CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81012845E4;
	Fri, 28 Nov 2025 15:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l/mSg6Ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B6783B81; Fri, 28 Nov 2025 11:34:40 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C5183B43
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso15650125e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764326077; x=1764930877;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=l/mSg6Ty7lz2IThzcMQ7KhgAFeKSolEjNEktli7+K/TcU+1v+fuzw8tEEjqp1f+/Q5
 yAELEdCrGbCEDoSaTBseJe9r+O+SEqcSdqhEZrJfSmQKw+IrsEJx0Sutj/n/3Kz9cmIE
 EapcWkS1StI2GMd78tNqYCOrOACl0PKNbfZO07ulqarXRjX8recu2FniwOdJWlt0Vf2t
 QBXXT6emzYFLd1QiX0bsBauQfDTyqujmUGZ1PMxBy41YZyISUQsIV4XgnIiL0hG/Hfmm
 fLo74SwpHBjqAXK8tqQKrSSMKjUNuYmWlqElmDdZknWuwQH+7jMdZX8x68Z93gUNz6S+
 4vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764326077; x=1764930877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=vcFe4QJgW6wLspwtqH1ajsxiw6++TTZvqK4JWojRhCixlL2+bxzSn8LtgNf1Z1DGZJ
 50Ba9ay6XYcdnkD250i4K9MJaDo9MkHyDoGv7obnC5VSnVRxgJ9HuK9S6k+/YIsravBe
 qZNWZqwOzFpEL45bsvwPoPOS8BqNt24W0PLUrFWBCd8wyfG4E355I1yY3AN2USDYUD5+
 4ZxNOxQVpSL7Um9tvrI+EQ1SHoSFU2K9gBq0/ySF62JcdY4/tKJyo4jdiEEKTua/qgzI
 DD7jA+Hunm7DTX/DrDqe6qmFZ0EI+f4x3UkKlG3sDL5Nq08NF0VcBOd+fWvOoDvhSF2K
 2u8Q==
X-Gm-Message-State: AOJu0Yy7iyj7UHWpDVOMYptSHMBskBdDlkF//uILuL+p7agxftd9LCTC
 9EB3wQgBSHWn+Q7l6y3Sqxmv/asfVTe9/qrFidzlrhVGIpXyp23rQoFikVg0kAtZsWs=
X-Gm-Gg: ASbGncsmJYov86Oz+REcNIKQFOeg2QYNoB9p8bLG4ulmw7MIR9u6iO/vN/UZE1j409y
 IX2Q4Ocj0tsrZWZCOIEauTpFurDV4FNSTuGxF14RjKqcwci7AKhrydzL/aVmcS0WRfj7HfC1ED3
 sfz0E+D4yiSXjgCXj5814XuHnuD/0h/VNvDYsSr4d1vWH88pbRTdgHtwmQXnGTTjvweE3hMDCyS
 5mrw8kJVbxOQHuePWKGhtwxfjgwVOOdgYmshw2CbTEdtfgVpF37nsxceVpPucisxplhtuvvmQCp
 SqbbDCudL7BZkZ4A4X/+9GwERzfOiA9BmwzdP8nKm/CLJR1ZaF4lNh0bmTajUcph5AOfJe/0sp2
 Dr2QMaq8RSxBp6JdELtGclk4ptj5xjcWiudRfMBkuUnp/AgJM54Rb0lwC9v9TbFOQ2kykFhmB/s
 hLUgRlnuA=
X-Google-Smtp-Source: AGHT+IGCK7wfGPKxXWfXh1yTLNfoRfWAIc+XC73jMyp/wj0BWcbMn8Yw360FI9D3LuEfnMOBdfOhfw==
X-Received: by 2002:a05:600c:c8a:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-477c04cfb70mr295141305e9.6.1764326077183; 
 Fri, 28 Nov 2025 02:34:37 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-479040d81e4sm93259385e9.3.2025.11.28.02.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:34:36 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 11:34:19 +0100
Subject: [PATCH 2/2] video: ti: am335x: Support OF graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-lcd-v2026-01-v1-2-ef75d4330d3d@baylibre.com>
References: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=msp@baylibre.com;
 h=from:subject:message-id; bh=BLqCJ5mUVvTnsP3XHcrulNh/wDuhDSCUp6GaeQHqvYA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNqq2VSw9dLC4QP/so7qL46ZNy1zZPzTCV97Pq5z90z
 jJBm026o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTAC7yhZGh8cibgJktJTx1U7OO
 by7eqs2/fV3Dsi+hsT8vrNSO/V78nuG/78X1jqsitpvM1Y3imOuhEMa1eFOy4bZdjRuic7h96zS
 YAQ==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

