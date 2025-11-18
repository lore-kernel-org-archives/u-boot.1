Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C1DCEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B9483E7F;
	Tue, 18 Nov 2025 14:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="anh9XBC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F74B83C96; Tue, 18 Nov 2025 11:42:34 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ABF83CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b73875aa527so386422066b.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462552; x=1764067352;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=anh9XBC07DIL+0pPV4ShpprzkCuiNmksHij3FvxPHrshsAou9Gw/DZGqV2U6x/P50p
 ZPGsBjJoxMfCMDgZmaVPlRz4rMxBt9o3I2aQUghCVg8eLZzsRdoKdP+Q2BWyEY2Ai0jg
 alxf2IigoaA2uu3IStLXBp5G0ODB+lnq3zX/qs5kJqERh2D14PlZZD2QXEL1RcnGs/VP
 MIxFgEDJmVwo6o9HFknxadERQ3yvq4IBj2NSM/32ObPWISzPqVeIjPXNw4HHTOWTE/OS
 YlmxFyXD3zH+yk0APXOzk+JEHcVWXxMjdn26iborKR6LCLC8tOreEXfh9GsDduNg46bB
 bRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462552; x=1764067352;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVL7W+VJNYZCVENkgVRkKLKuEBNKdeJGqIsQ4VzhMA8=;
 b=Lw4lQqxDrzKmWRdw0ugv5qIoN1FMQNJOnmxhDa2GaoXmAjjZT980XIhs8X4jXPL+jw
 PLGA6l0XvJsZzu8f2MkX440KxLxmAikKbfLeIrSemq3gNyesZyDBUGxz/1A+l0Oa7XvL
 +Q4NxKkZ31TWzKNy6m5snow6OzhI/s6KRdBEW32wbv6u4RwafEoVehk9yxA0TxwyNkZj
 MaPEG9/xXXE5itUFJdzABPihlk3dYU/GOGJOCjgX3EOsGNBNwVe3kLAy2+QnQQR9ZoC3
 mI+76qwa57F00/EZj4T2iaGzSUC1aHA3SUa9I+wF31gMbWZK/qnrwfKfuL4cy0+s3oyE
 c+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg2fbPoneFmqQUcX8u54yCWqcetk0GlQ4OS6lnwoEBquRRvS1sbWcnFQgePCs6fEnIWkX1ZIw=@lists.denx.de
X-Gm-Message-State: AOJu0YwDqF97Q4ze0m2pCdDGpphfusrYqeFhxg67A1J77VNQR/6JC367
 PG7d74uxGnxlNaIigPHhcyf1TeN+u/nqZSwR6q3QNVKu5EBbn85jd09gwgQx5l0fTQA=
X-Gm-Gg: ASbGncvb6Ctu9gZ0EiR3S+QNvBzqlz4DMukqI7NjA+5HMnhXzIkTzC5Jy/hRs/a0jg4
 QNZzVrH0/ZnnbkwvoWiVyGKMveZpPDcnADrapVHL4bG2XHb38y2/9o6theWxEfzvQAXdi9tuM4p
 yFD3iMH13s4hZJnBywLbALdApr1RsiILfrFspXG/dt3MXw3q0151L+1OTGZpYoBMddglIrEzXLX
 08cO2p4ZtqGalWZwwyJ9/xhLScO12Kz6IB0T3S0sgtT099kJl67LlN0RKzW4YhQIn8RddWDL71S
 L2hnzhaRg0BcJCt9PnKPKKg3WcEGc81wxVbkh1PBOLLrhD7YbGWoPbFriYReO72XwOLNW5lPEtw
 BflM3R5skTRjNB8ZIdhvZF9ozWC0G+JjwH1L1BtByEC8Jt9oUFSaaNeT1LJEiBLh6JXdkXu5QQi
 EMc9UTy1Q=
X-Google-Smtp-Source: AGHT+IGuxCqst1UEGCQyR2d8cSz6rzxluPFuBTBLjrrX/zjutfk+N/agVfGjntJzLKt6qKGEou+Kbw==
X-Received: by 2002:a17:906:c18:b0:b73:6d57:3e06 with SMTP id
 a640c23a62f3a-b736d573f0fmr1226241366b.7.1763462551907; 
 Tue, 18 Nov 2025 02:42:31 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fda8da2sm1288598266b.55.2025.11.18.02.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:31 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:34 +0100
Subject: [PATCH 14/15] video: ti: am335x: Support OF graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-14-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=msp@baylibre.com;
 h=from:subject:message-id; bh=BLqCJ5mUVvTnsP3XHcrulNh/wDuhDSCUp6GaeQHqvYA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ33JZvaOeQvUfZr5R/iikZfViYy/H1bPJVy575Rh6t
 sufF7DsKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIk8usLwh6OkeOtezqlHjMS9
 Xotx9Hn9z88uc5fOW1izsCxjevC0aoZ/tgG6arYmRoGCvcIMupo+H2ft/P1ezdbPUGvik1MTJh1
 mBwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

