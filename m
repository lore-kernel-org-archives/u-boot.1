Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B5BC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1437881CC5;
	Wed, 12 Mar 2025 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTMTYCrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8169081D3B; Wed, 12 Mar 2025 19:08:16 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CC1807D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso62484a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802894; x=1742407694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU6mPxVxJ8xWrY5344FcLYTTLhW3jmtuA15YdcaZovA=;
 b=BTMTYCrQ0Xc4Wh2OZR0Y5/PD51bsZM+U58+GMRmGtB7lvAqm9wd4dYwTi5Dp/JzsNb
 wOKQg6aPzmgStH8Tkmr6z+ZpVOM5hFMCzlxTgztRpLGJ165U9kGLfK6SDCYrWpBnyijw
 0foR9H073ji9Tf5qIQBQvFEB+i3GIlgFFbhWrN3WmW3LBlX/eh+RrwuOvLrNsrZmLSMX
 t9+NeezmUaXDdVOVTSroKtcrdBQU815l9iE5PqrWPrHd4b5RF4NaUggjjBC5+FiYr50P
 RVGLnTj6DZA2yeQyTofVZR9P96Gfb8SRXZEalg1JrLN7JgcuRWYpJEo0imolm8N83eeP
 9TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802894; x=1742407694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EU6mPxVxJ8xWrY5344FcLYTTLhW3jmtuA15YdcaZovA=;
 b=JKiQDSGY22XqddMIXRssWQdfr7OVtlZ9QRLLvZoi4Eh/sfqWqFcGNpQcTn0X2ZSrMn
 SEfsZUdD5rsmex12f0Z5l4QimpJ4/PgMo3+dw6CNOQXfbpWJSzSm8g/n+7CoGxGqYZJv
 SclGibQOml1j2YD1StrMLtuKFmab6rGk2cw8Bvi0rHkTz2MZTwJPo9dJPldQklRhA+1P
 YGDet3SSY3Yp/OkLXmxte1kT8WikIBO2Vty+1m7Y5Pc3MxFsmj0kWuDmBuiiqYBqjYds
 mKjq45n3xYXIorG9GIuHno2DWnp7/njsx8pH2an+gFMLH5V/A6yHY9cIREgk5aSzLepv
 jSDQ==
X-Gm-Message-State: AOJu0YwB6joSWovI3HCt185bIPWHvItyftYXDcRBVlccZGDC5BcURxc5
 iCCo1kn3T1H973YFmyhcEocWPJD7iM91ypljCaNSVpfqM2XGis4M
X-Gm-Gg: ASbGncuMfb9L6xj1NlzqhPUjioBbWudMPCkfdcDMuZ4G/5Aa5iAEhK/eozJH4wEgHSe
 qUMbmYjUxMzauO/SyWxjsCjJByAJ9FqejUok/w1gaz3QtWiyevHc7VMjuwd0EFLOdT9RwtOUDtI
 BdhXQI9JDymf2fQYWD4bBrC2yMCejH6tSck3J3AGeVmAn05ZvQSf40mHQcT/g9MdBml890ldA+Q
 tUlnfKhlR1Kwio9+JtSumpdiyksuPi1qpxLB2t5TmLUIrLZxxykOAGpuSQKQMR3yz3n00yLbckP
 SaZpK3L2JqGA2wWNpW7aELBWpwK+UJ+sFCw5
X-Google-Smtp-Source: AGHT+IGy4vaFl+UQMzQjNm2cteMVmrS/c2N1cYeQtPxXGJysmFBqxIM3WrAKQVIfk47iyoirKhbZ0g==
X-Received: by 2002:a05:6402:50c9:b0:5dc:80ba:dda1 with SMTP id
 4fb4d7f45d1cf-5e5e22bda31mr49383504a12.9.1741802893557; 
 Wed, 12 Mar 2025 11:08:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 07/13] video: bridge: ssd2825: convert to use of_graph
Date: Wed, 12 Mar 2025 20:07:48 +0200
Message-ID: <20250312180754.120946-8-clamor95@gmail.com>
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

Use OF graph parsing helpers to get linked panel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index b1f08d7f38c..e3be3d22bb4 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -5,6 +5,7 @@
 
 #include <clk.h>
 #include <dm.h>
+#include <dm/ofnode_graph.h>
 #include <log.h>
 #include <misc.h>
 #include <mipi_display.h>
@@ -444,6 +445,26 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 	return 0;
 }
 
+static int ssd2825_bridge_get_panel(struct udevice *dev)
+{
+	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	u32 num = ofnode_graph_get_port_count(dev_ofnode(dev));
+
+	for (i = 0; i < num; i++) {
+		ofnode remote = ofnode_graph_get_remote_node(dev_ofnode(dev), i, -1);
+
+		ret = uclass_get_device_by_ofnode(UCLASS_PANEL, remote,
+						  &priv->panel);
+		if (!ret)
+			return 0;
+	}
+
+	/* If this point is reached, no panels were found */
+	return -ENODEV;
+}
+
 static int ssd2825_bridge_probe(struct udevice *dev)
 {
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
@@ -458,10 +479,9 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 		return ret;
 	}
 
-	ret = uclass_get_device_by_phandle(UCLASS_PANEL, dev,
-					   "panel", &priv->panel);
+	ret = ssd2825_bridge_get_panel(dev);
 	if (ret) {
-		log_err("cannot get panel: ret=%d\n", ret);
+		log_debug("%s: panel not found, ret %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -512,6 +532,7 @@ U_BOOT_DRIVER(ssd2825) = {
 	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= ssd2825_bridge_ids,
 	.ops		= &ssd2825_bridge_ops,
+	.bind		= dm_scan_fdt_dev,
 	.probe		= ssd2825_bridge_probe,
 	.priv_auto	= sizeof(struct ssd2825_bridge_priv),
 };
-- 
2.43.0

