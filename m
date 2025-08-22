Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C94CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 23:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9058304A;
	Sat, 23 Aug 2025 01:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFL+AQip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121128006D; Sat, 23 Aug 2025 01:29:51 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCBA82C84
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 01:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9d41d2a5cso2123214f8f.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755905388; x=1756510188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Okm1QHY+DETNclmbC1sE+425Gvc3JjLPmc2dDPZgr60=;
 b=aFL+AQipjtqgbjHixp0X8S9oD45n2fJ3lu1+w7J6dMAUVCXAle/BsIp40m27TK7DSa
 kwHMoGvNo6emqPfEfS5CMIneZfsZ7FCsB4AlV+mQ03TO5al8XZwKWZzrqjlFnpEiMWkD
 heNz9NX0rfcU3MxR/82W5BHb1BWyv4y6VlIl5GD9MbVxKaKT0GubJlAT3vBBeVu+C5Jo
 meAfVe7uUkOc8RnPkiPwKFjBjpnnhUcUUmbYlUKlHNdWWR1KFyf+Bt2nbkneHsXefDDB
 9wytMWDQb+PcCyxP8d19qBZtyoX7S1ZcNzAKNIz135vrF7EcAeImunOJq4xCFukJrT3U
 OAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755905388; x=1756510188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Okm1QHY+DETNclmbC1sE+425Gvc3JjLPmc2dDPZgr60=;
 b=Td2I31dBmhQSGJh0fzUQhHXaNFLgTppqqq6H1HUy205m/vwMFBLLBp9xFW2kVtYd8m
 pTuykmMHJ1ZEyk+m+kvXXTtI+rcEY+YQhlZH/Sp07Zl4UtRgT2d4gkYrQSIr6EaJMQk5
 IPDvgnpsr1CW1VW3TNrIyQaTTpI3WyMrjCGOb2Yt0KaJjksaqD9yCeah1aHkHpoXk6Do
 +g4hKVWqW5Mp1Y4LQ4Use8QJCkzQZXxQWWhxupanBgLvy9X0svXxEKRABt1J+BBFtGlL
 hseC3MQfTrzUhRP02yDW/ZVGQoc+qaVtXT4snym75TNo1w7nyRnYFVos9aOb2nlx2rAm
 wMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLGOzhmsfu3H8r0R/FBVJr4OaGIo+WWTZJOzbf+HD17AWBDzQtKH6dL+iC1/lXwAQH1k7zSj4=@lists.denx.de
X-Gm-Message-State: AOJu0YyHqVVN/PULDGx6USlnb39uB6/0DoKjy3OUyBI4CKTOMFuIB8m/
 CnJDHVWLL3rhCFXkpzMTS/lJ4aj+n5Xj8ILHjZYAxZBP6BrINRYz4pif
X-Gm-Gg: ASbGncvux35u0jBpBotmeUtBNZbU1ifLi59i2qdVDjfc6L8hrWp2BGZS9VB3Hz5bdm9
 axBjB18aTy8LISWMNPiwhf5l9iQ0kPQxGVbO4RU4/tzf6kNDGe6HLA0m/uSNQbMNjIxCfQ2Ahy+
 +V0vnNYeLV2dMI+XUCi0sFlhKEUSvbzouIwRpTFnEicqeegJHutxg1lPOhuV3tIolqcsSmNuZDm
 ehLhXG7Qou7CDPoPu2IfKuWSUtRbEE26lfvclxximu0S6rDHcxuXpx+hfL66++4yq/D0WNr5onn
 wKK3C1XEUreRHKafzQcX7x71JEdJiOyiaimk1NnslE088YDA22iZgk1D57fZGEsraKnPfScJkEA
 9dCJDg3oT+x37FRnXPN2ZM9SMcIGCUHVkt680tw9PKNLvyKyi09kR7IJWqOyGpAPtUaw1aCX33f
 /7pLZT/Q==
X-Google-Smtp-Source: AGHT+IH7jFCTBcS5gUZ8pnrsZRSEBaOga+EVCNWUL7GyoSUiNNYV9Mr4tLjnV2FLvEckIZIC3w9gUQ==
X-Received: by 2002:a05:6000:4287:b0:3b8:ffd1:80d2 with SMTP id
 ffacd0b85a97d-3c5dac1aae7mr4268208f8f.24.1755905388456; 
 Fri, 22 Aug 2025 16:29:48 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1483sm1216970f8f.50.2025.08.22.16.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:29:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 4/5] net: airoha: fill in support for PCS in Airoha
 Ethernet driver
Date: Sat, 23 Aug 2025 01:29:18 +0200
Message-ID: <20250822232921.30076-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822232921.30076-1-ansuelsmth@gmail.com>
References: <20250822232921.30076-1-ansuelsmth@gmail.com>
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

Add required changes to call PCS function to configure the Serdes Port.
The Ethernet driver is adapted following Upstream Kernel node structure.

Function calling order is the same of Phylink upstream kernel.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 89 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f73dafa7d09..e0e426204ce 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -129,6 +129,7 @@ config AIROHA_ETH
 	select PHYLIB
 	select DM_RESET
 	select MDIO_MT7531
+	select PCS_AIROHA_AN7581
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 6be6ec2845b..9bd5123ba05 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -18,10 +18,13 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/time.h>
 
+#include "airoha/pcs-airoha.h"
+
 #define AIROHA_MAX_NUM_GDM_PORTS	1
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
@@ -645,9 +648,71 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+static int airoha_pcs_init(struct udevice *dev, ofnode node)
+{
+	struct airoha_pcs_priv *priv;
+	struct udevice *pcs_dev;
+	phy_interface_t mode;
+	const char *managed;
+	int pcs_phandle;
+	bool neg_mode;
+	int speed;
+	int ret;
+
+	/* PCS property is mandatory */
+	if (!ofnode_read_bool(node, "pcs"))
+		return 0;
+
+	ret = ofnode_read_u32(node, "pcs", &pcs_phandle);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_phandle_id(UCLASS_MISC, pcs_phandle, &pcs_dev);
+	if (ret || !pcs_dev)
+		return ret;
+
+	priv = dev_get_priv(pcs_dev);
+
+	mode = ofnode_read_phy_mode(node);
+	managed = ofnode_read_string(node, "managed");
+	neg_mode = !strncmp(managed, "in-band-status", sizeof("in-band-status"));
+
+	airoha_pcs_pre_config(priv, mode);
+
+	ret = airoha_pcs_post_config(priv, mode);
+	if (ret)
+		return ret;
+
+	ret = airoha_pcs_config(priv, neg_mode, mode, NULL, true);
+	if (ret)
+		return ret;
+
+	/* Hardcode speed for linkup */
+	switch (mode) {
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10GBASER:
+		speed = SPEED_10000;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		speed = SPEED_2500;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		speed = SPEED_1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	airoha_pcs_link_up(priv, neg_mode, mode, speed, DUPLEX_FULL);
+
+	return 0;
+}
+
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
 {
+	ofnode node;
 	int ret, i;
 
 	/* disable xsi */
@@ -665,6 +730,10 @@ static int airoha_hw_init(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	ret = reset_deassert_bulk(&eth->xsi_rsts);
+	if (ret)
+		return ret;
+
 	mdelay(20);
 
 	ret = airoha_fe_init(eth);
@@ -677,6 +746,26 @@ static int airoha_hw_init(struct udevice *dev,
 			return ret;
 	}
 
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		u32 id;
+
+		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
+			continue;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = ofnode_read_u32(node, "reg", &id);
+		if (ret)
+			continue;
+
+		/* Skip PCS init for embedded Switch */
+		if (id == 1)
+			continue;
+
+		airoha_pcs_init(dev, node);
+	}
+
 	return 0;
 }
 
-- 
2.50.0

