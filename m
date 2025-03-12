Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029A5C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D652081B42;
	Wed, 12 Mar 2025 19:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBOGePJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A06A81A02; Wed, 12 Mar 2025 19:08:12 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230428169D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e4d50ed90aso91882a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802889; x=1742407689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XH9d0beqqiP4up8K2VpDy1pi7ykwWXVuwnT/s6ueWjw=;
 b=kBOGePJ3wGY4HM+Sycr2gI6jOnE9vXYySl/nCyJv7PzCHbVc/uibtZ/Ru/euO4JeOa
 YOAUzB4SZPIk+1T4eDf1WUxyvK/k0mHZBY0hYEjRK+Rf+sK3ulq+l3sbu7dpW9BcJyUK
 +h69PUQuO226F/Nqa2MwxWa5JyUeH0EayoGPxupsP8Bw0e4DZ5kFH/SM6lu6EIyHZ9jH
 iqIl9oW/2fqSViLXYNFvD9UcwgBJbvsFedcZSccWYJ6VKMk9wrdBua/S9x8mAz1HY8Zh
 jIQKtXawJK2lNeY4gEDmQum7g44YnMnM61QezPmPoXWBXNW89poBcmme2ZzpakdaoXjw
 oN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802889; x=1742407689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XH9d0beqqiP4up8K2VpDy1pi7ykwWXVuwnT/s6ueWjw=;
 b=PZOw2kmcGTEeI54CxaGde9EIPKrBCqiAoMvPJRahzoa0+XXYcCt3tJyn0zxhY03ZW2
 SgpBXSSq/illKHCvU8GcIpUN8ZYJR1OGtTaTgXt0UXxJ7Xo6ZULbsfvfy8/jdVZaM+NE
 6vlZpD5u4fMdidJ+rxYAJr43ZhqBOofCb0JyJzGeKosfh1Rw48jmx4IzwJbRwHc1Rgq6
 AuFWhdAtwWR62xXCMuI+rhf7c9q8tn99EPQ/NRICh7hLd9CPIgmgFTXmSPX1tVLpv7UB
 9lkI0SySwlVROLKF2ManUDhKMToqLGxENpV4yeUnBqGTnMhz+jVZJFQ+yuG6cxSnvI+8
 r00w==
X-Gm-Message-State: AOJu0YyEJ9ns69P3/kUDQf3QM/DluiTCyMeHjWgQvCfhzg0NehlfVFmu
 qPeg/83YFZD0ovFh9X3LJYd5L31vRJ617yb0eSPAYC95RhwxqGcn
X-Gm-Gg: ASbGncssKEwNIB15b84SOaAkmQvyzrX0T8ZR7CSvt7NYziMSPrnTd1+Dqlh4gfV1GP9
 0gr/NanmklAqT+SuK+NURfkQOkVc0JJt36O069SpQg9x6vpn6PG9b3rbWmAuysuWyu6H7pdylUk
 ImYgDFZNxBJPITXh01udfaiZzUbNSiXDWNgz5W0KVOVKdx5jgkd4WzVYIbK096xD0zXgqa43niL
 TaSGzYfg6Aa5kmmFhHDDlkwtm0O5Inrnh1uHL8L1xrn6rj65sixvvu6UbhSLXcinr5yDdV5O1sD
 kcMwhn/9k+7fbeawfT8hd2CRgDvbzpW1T0XD
X-Google-Smtp-Source: AGHT+IFKLTn2ywzv7nXEX6jt3DAzMuAiH9P67xLfGawbEJyrPcEtIMSR2p/6AKY5s63imOHOrd/p7Q==
X-Received: by 2002:a05:6402:4409:b0:5e7:110a:c55 with SMTP id
 4fb4d7f45d1cf-5e7110a0c6dmr17758846a12.18.1741802889409; 
 Wed, 12 Mar 2025 11:08:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/13] video: bridge: tc358768: convert to use of_graph
Date: Wed, 12 Mar 2025 20:07:44 +0200
Message-ID: <20250312180754.120946-4-clamor95@gmail.com>
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
 drivers/video/bridge/tc358768.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/video/bridge/tc358768.c b/drivers/video/bridge/tc358768.c
index b5d45e0e3c9..15bee19a152 100644
--- a/drivers/video/bridge/tc358768.c
+++ b/drivers/video/bridge/tc358768.c
@@ -6,6 +6,7 @@
 
 #include <clk.h>
 #include <dm.h>
+#include <dm/ofnode_graph.h>
 #include <i2c.h>
 #include <log.h>
 #include <mipi_display.h>
@@ -877,6 +878,26 @@ static int tc358768_panel_timings(struct udevice *dev,
 	return 0;
 }
 
+static int tc358768_get_panel(struct udevice *dev)
+{
+	struct tc358768_priv *priv = dev_get_priv(dev);
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
 static int tc358768_setup(struct udevice *dev)
 {
 	struct tc358768_priv *priv = dev_get_priv(dev);
@@ -893,11 +914,10 @@ static int tc358768_setup(struct udevice *dev)
 		return ret;
 	}
 
-	ret = uclass_get_device_by_phandle(UCLASS_PANEL, dev,
-					   "panel", &priv->panel);
+	ret = tc358768_get_panel(dev);
 	if (ret) {
-		log_debug("%s: Cannot get panel: ret=%d\n", __func__, ret);
-		return log_ret(ret);
+		log_debug("%s: panel not found, ret %d\n", __func__, ret);
+		return ret;
 	}
 
 	panel_get_display_timing(priv->panel, &priv->timing);
@@ -976,6 +996,7 @@ U_BOOT_DRIVER(tc358768) = {
 	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= tc358768_ids,
 	.ops		= &tc358768_ops,
+	.bind		= dm_scan_fdt_dev,
 	.probe		= tc358768_probe,
 	.priv_auto	= sizeof(struct tc358768_priv),
 };
-- 
2.43.0

