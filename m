Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D4AD1F9DA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071B083FBC;
	Thu,  4 Dec 2025 13:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wMby+uO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E4F83F24; Thu,  4 Dec 2025 09:32:00 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A190783F32
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 09:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so92776466b.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 00:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764837108; x=1765441908;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=wMby+uO2XPmnth+J60WvwmPlwGLk/i6r2oYu3oleNC/lvM3/T/3cYwIFcklboOBZ7f
 i2QpqOy33Ne8Nd2RJ83rOrVStxXiUCdlMOIQYnljgzwiKbroWrREWnrvm81500ppwQVN
 7g671br1u4KxYShMtiml3mFeUpFwLKIN5VMHHRb8eeGIOnTWGRSGA579CjwTNYKVJ9Jn
 BmDi1hn08iiO54FdsODHNkKg6jc4RsGOb8GRbs4XRqWk8/JeOevdO7o5ymQR7C8nq9Li
 W3sBnRwyzuPvnyyhpurQqeizKBxbIpw8cVz3c79lUWhx/8nuzzEhzP/xq56fHakX6Jpt
 zhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837108; x=1765441908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=LYEskLub5IzKEf8OGQfJBR1oYh6Au5sHUhJr0i7DcHca26vYP7HGzz/otvPNArHurB
 r8TSdNfppsM/zsfuqJ7LWgeCru9/j6vE+IOmBWXQqKo7raKs/JkWozlxhvc7SefWDj89
 /XKppULPn2fspCkC510FG+l/aZi55709RGPZrreccECZIfVkxHsTK+//rSj63xN4Jlkr
 u6zoeQuQxBA0x/pVYJHUj0MU8L9eJMTyJvr6YPU+jywCwY/GvHEhywPA0s4CAmTiowz+
 g+2JbOIskgnJabywHq/b/8tPFg89QoiLwO+omMex7B6JLErBc2hSSNtsnZpoq2eFNUwW
 Zt7Q==
X-Gm-Message-State: AOJu0YzM+wY1ttGOUhAw3lXQnShNnv5BI0Rs4gIEv2jo/59OKPmKOyYQ
 YEIkujDbB5Gpn0cL9ng3GM196TUPck6hl544J2QvbiYzL02iUXPq3TTBTelZVenBT7I=
X-Gm-Gg: ASbGncugsW98L2ZgjcGsU4Eut973aA7SKEE3J4QkXyo5OInBXSMH7Rb3oGKGkkmPoT3
 DkUxapw2heSFGoa3IWijZdhz9rKJ1qsn6KZ3jI8T6We8/p5Zt2bfKrLbzENh8FsbNYh2GZ2PPCC
 bu3v09WSslJ5fquhWSf3AwVVyv/zNuaR3djYI4uXlgDKQTT3kY7bw7MtVKPs6NTp3hezWbivwY2
 Is1lHwPMz41ykQDR1BBvalkwVRYHgNLNF2DnKTMq+/LZZG9hZcgvAoCiAfpp16qCY/V3kXgaPw3
 pVTS6/VrGZg2uplCR0eWC/GtnlEhBbZi+yOdTyaAaN6X1za8erzEcWE9/OquALlpfYPRmJRF7sx
 HfKJgO061KxdXQ7ynV86L8P/qOHiDmW9qCGu9NVXkBHI2rtVGAUGN4/1tT4ewl27PkA/sT6eJ8/
 NVa9vHWTE=
X-Google-Smtp-Source: AGHT+IFgSsNwZzr7pvRA9tUW6bK3Z9bN2LVHn3nHug1sWAD50G1do3UOcNVCNiIni/50Wg5ZJFAEHQ==
X-Received: by 2002:a17:907:8e95:b0:b77:1964:1881 with SMTP id
 a640c23a62f3a-b79ec707a5amr223097666b.58.1764837108027; 
 Thu, 04 Dec 2025 00:31:48 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49772c6sm68969766b.44.2025.12.04.00.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 00:31:47 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 09:31:17 +0100
Subject: [PATCH v3 4/4] video: ti: am335x: Support OF graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-lcd-v2026-01-v3-4-ca74853bd5f0@baylibre.com>
References: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxDtxdqH21NerWKIyxmvC34PpXv/byHluEvthRc+XxkT
 60ka5NPRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEwkcQPDf2+Xy9vSp7Y4XhCT
 7WvaZbLq62PhkGPa5TYFP1QLqwTVYhn+8Ou90vujM03v2Pe4mVHqZyecN0h25dA6bu75RHp7kct
 lBgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

