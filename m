Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A348DCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465378341C;
	Sat, 20 Sep 2025 16:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAFUhjeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF5D833EB; Sat, 20 Sep 2025 16:37:12 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B028317B
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso33875715e9.2
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379029; x=1758983829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdhQACNKIt+lO//CliGiwSKTr/HoLwrRs1465XTOkjo=;
 b=hAFUhjeM0cfs41cLuYLaCVAjTZ7HoXLz5mO8+FOOqjeKjGqN7stqmAgu+5EG3+LCcy
 wbHuGxZ2r7JqhSxVmG+L+WD9kHeZFGo8BYvR4LwQWcqAH+FuUovQ+kXynT0snxruZW4M
 GVQ8bzykAi/tE0MjHCyvmyYjpbmG68DYWhT611bjr7HYnT0IfgFf+j58r142lZUkrOgp
 rAAiuz0rS+qStiqNGjCgoN74V1W/n8RRzg1E4EdDEKVmB0ZlgwLmE0q50wZ735r/4AyY
 xYUpI18wduRooKpIAmFkyKrd7E9RX5JPR7hlNbvQPb6+5yZn10DHTe6+BFd6uxg8i+wJ
 qGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379029; x=1758983829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdhQACNKIt+lO//CliGiwSKTr/HoLwrRs1465XTOkjo=;
 b=DAhv/3vWcMJq2wX+fSPRBzZk4iH/Qzgbq2kZjwmH1isMnqtQZnvFxJZN5Vz578dyU1
 HlICfHVWgXw+DdrC3WYZajTRazDK12Izm3w38IKh/BqVbOYxMgbvkNwavkV1mdzxG3wR
 mDLuQKSZx+rTNFyXvv0LCiolCK6XeM97NR7GyUys/0Zt1Ptwv7WWnqDx76Uwj+nKutFV
 V/zLcfpWtLLDYAo7CZMMpv7zcc9cJ2ZPvYLGTE1Q7j4bi3GkkoXhEeQ8g/9uNjbWeyLL
 E8UvuSKxk+i14OoWmB9y3E0xSFNGV4aJQUES1JEmggwh1d5uQN1AepxO0yzVAORNdFTS
 OCEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHTJM70zFx8MhjNrA6lUOug1kOZSUdWqxLKcic/nECsIncBtJiQ091aOLtZI9JQoIiKp+qNjY=@lists.denx.de
X-Gm-Message-State: AOJu0YxtMirHk4Tgsh2VtmKLvI2jrKGeuhczl/kUSq6httMAgWe6i/uv
 9kudeTnuIHO9C7phcv40vkyNlHsPeE/j5D4kMbJK6A5DD6u+jP0GhNaoRyrejg==
X-Gm-Gg: ASbGnctSg+K43Hxg+QbfzePPSw/9Ex4TC/6rynsqWrQU/KguXe7eWkdW1swtaRABG5r
 UmOYYGYeJHd+/b3V4lCURzUXSR61LlstKy8GcVpUIfBlGqsvG8A6UX6xsBzttZvP/k8qKM5QMEJ
 xzw6x/HWifokoF3b/wCcncSzly3jKxmlTA/NipsO6s9M45M5q/LFECpYjnLDhSpgmEqOOLbnWc6
 zV0IPRVECG83plLdTJ0Z8f15e50Mtz9qmWkxa40sxbrRUgHVHM9k6B1+SbZ2U+0Zuub7gRwBeGp
 ngs180RvNOWb0t5eVuFTy6ZNNFEjnzFh1d+GAKCFkobUH/GHarYvDaKovv2JOKDZ0ZyViODkyRs
 XO2/RWwu65QHCSLcFQU9BMQFX5hJrNKzKbQk1pBXtYrGEID2d3CuxxYwYCtrrT2UPWiNAsbc=
X-Google-Smtp-Source: AGHT+IGkhDAEei6r9oJG4VFTEVf7A+9rU4oEECmhfonbDV4cHbArn7aY2vyCFrkL/q+gz4WNaChRzw==
X-Received: by 2002:a05:6000:2f83:b0:3ee:154e:504 with SMTP id
 ffacd0b85a97d-3ee7db4c464mr5442002f8f.19.1758379029036; 
 Sat, 20 Sep 2025 07:37:09 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 5/5] net: airoha: bind MDIO controller on Ethernet load
Date: Sat, 20 Sep 2025 16:36:50 +0200
Message-ID: <20250920143656.29770-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920143656.29770-1-ansuelsmth@gmail.com>
References: <20250920143656.29770-1-ansuelsmth@gmail.com>
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

Bind MDIO controller on Ethernet Controller load. The Airoha AN7581 SoC
have an integrated Switch based on MT7531 (or more saying MT7988).

Attach it to the switch node to support scanning for MDIO devices on the
BUS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index cee4a3fc9bd..ce7c7e6297e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -126,6 +126,7 @@ config AIROHA_ETH
 	depends on ARCH_AIROHA
 	select PHYLIB
 	select DM_RESET
+	select MDIO_MT7531
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 6588eb3a806..6be6ec2845b 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -971,6 +971,31 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 	return 0;
 }
 
+static int airoha_eth_bind(struct udevice *dev)
+{
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	struct udevice *mdio_dev;
+	ofnode switch_node;
+	int ret = 0;
+
+	if (!CONFIG_IS_ENABLED(MDIO_MT7531))
+		return 0;
+
+	switch_node = ofnode_by_compatible(ofnode_null(),
+					   "airoha,en7581-switch");
+	if (!ofnode_valid(switch_node)) {
+		debug("Warning: missing switch node\n");
+		return 0;
+	}
+
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio", "mdio",
+					 switch_node, &mdio_dev);
+	if (ret)
+		debug("Warning: failed to bind mdio controller\n");
+
+	return 0;
+}
+
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
 	{ }
@@ -990,6 +1015,7 @@ U_BOOT_DRIVER(airoha_eth) = {
 	.id = UCLASS_ETH,
 	.of_match = airoha_eth_ids,
 	.probe = airoha_eth_probe,
+	.bind = airoha_eth_bind,
 	.ops = &airoha_eth_ops,
 	.priv_auto = sizeof(struct airoha_eth),
 	.plat_auto = sizeof(struct eth_pdata),
-- 
2.51.0

