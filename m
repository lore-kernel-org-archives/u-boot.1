Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C41CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 17:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5CBE8006D;
	Thu, 23 Oct 2025 19:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wwnh8YSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB77E82E34; Thu, 23 Oct 2025 19:08:05 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40F68003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 19:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so551402f8f.3
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761239283; x=1761844083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cf2hW+hBunxO90XA6giJyVRy7WEm8JHwfCcRBNE/4n4=;
 b=Wwnh8YSPeUoWro4E5vC5a3h4MMmhzU4wFdsowAy6BPuKQxibw7X8WKNRDj8ohCDVrF
 XTMYJZu73VWeJzJRqiKnRNBaSU2ApHRbKyXNivDjyHm9h/MOzyhoKNd2Qnq2ESL+yB2B
 9iYsMB5aOezXZtAtzGqINTRHeXbqpPiuQCt9WYsSwBXLq+33Bv14CQVytWZ7Ye05mWIn
 /UAG4JMth7SvmxcWQVkbm9eivS9k/bDUb49/WMpMTgWTdZDqpHLatpqnur7pdkeFioDP
 LTm03Qstcn6ZpnHj1R+//KEFfPUWWpwypEbk8ebCiAXt1cGxLExyUqgU55/xCHFn/zKZ
 E/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761239283; x=1761844083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf2hW+hBunxO90XA6giJyVRy7WEm8JHwfCcRBNE/4n4=;
 b=npTDYhgVT89awcqeHO8zFfzTwDvoKb0IzPGLf6FHeIpDNR0jghMB2W5Dmt1y/yjZa1
 H7QxHNqnTxT2qaqgvMeGmOWRjNttVn7GHatlEBGsIiDRuBtn74nyhAh8hnSKnNarE7gG
 gZQDDo6L9DloAPum8uX2LXwsbRR2XKAa7sQPz/IB8EKenHetHJxFa2zmhw24uGZVqJqK
 CiuefRZhaLlh597F+iOxizq7YOl3o/7WhyvyFzVm+q9hQuwTVVmBOoHW8egdugnJUwiU
 YU365HK9rWq+dn90z0vpuSEhiMwhwExO6n4hAmyk1XCet6OrtVdewE2RtWow/ktVRGW6
 KycA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCU3QYBKeacc7D/PxWzVgvaH7X5lh2o44iKyGnh4vRC4137YegHRXuq+NtzaVF+iXoyUP4zI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/25Vre3aSknn4YjUXR5wplkxadj8RDGioLmE84oXE7EanoEHB
 FbpIQ2KlGAOIUKFbRUo28qztw1/FpF3dUloxCGMQeuh31PAQVVVvOhBd
X-Gm-Gg: ASbGncvgzPqg20JLDty8uAjcYuhgQ3J108NyMrbsQTgCHR2dX5+d+nZqYKX1k8WIWZQ
 Cf5n13pGf0zA25+6CcNuXYBsKNuCjPmfRNA7lpHnUokue9KXl2mSatJ6DYP28ZNyNXudO/orLU0
 qX/W5Dy5wRIXd65U/TqjK1rNwuvu+zIUMBlDOALEp5zeZwaR4oBhT3eNXwbnmclYPRWF/UMRC3c
 EO1uh+8AqnizY0XzsJicm0/ezNyPjGh6LvqhCOEIjKgZRst64x7JuWljDSYiiV+D5kIivrcIFOV
 zzrYUXeGrxzk6TA9Lc2bC0nJl3iz/+JjD64su+j/YigrqHhXbtkvEQRFlZcYvXBgkS4LlkUa8Ma
 RUqggvLEVCICAvRAzKVH0b+lyRNGLqoXnaamh65nlvFp+o3tE5ekDnv6qpl5Nuu6VaBXCbT6LgR
 XKYo+EhoNglEM0o/eKJ9YPEesj7T9fRmMXE4OKt9HB
X-Google-Smtp-Source: AGHT+IFAnkJ8HkWeYKjvwNNjTA7GP5xQ+xJdxoPhHyG/meviNKNvO1R0DO2hmnTXCMvtZ0eYucTNSA==
X-Received: by 2002:a5d:5d0a:0:b0:3e7:6104:35a8 with SMTP id
 ffacd0b85a97d-42704d98e81mr17268657f8f.35.1761239283058; 
 Thu, 23 Oct 2025 10:08:03 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429897f52aasm4824465f8f.12.2025.10.23.10.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 10:08:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3] net: airoha: bind MDIO controller on Ethernet load
Date: Thu, 23 Oct 2025 19:07:45 +0200
Message-ID: <20251023170753.21628-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Attach it to the mdio node in the switch node to support scanning for
MDIO devices on the BUS with DM API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 6588eb3a806..d62c56e2563 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -10,6 +10,7 @@
 
 #include <dm.h>
 #include <dm/devres.h>
+#include <dm/lists.h>
 #include <mapmem.h>
 #include <net.h>
 #include <regmap.h>
@@ -971,6 +972,36 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 	return 0;
 }
 
+static int airoha_eth_bind(struct udevice *dev)
+{
+	ofnode switch_node, mdio_node;
+	struct udevice *mdio_dev;
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
+	mdio_node = ofnode_find_subnode(switch_node, "mdio");
+	if (!ofnode_valid(mdio_node)) {
+		debug("Warning: missing mdio node\n");
+		return 0;
+	}
+
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio", "mdio",
+					 mdio_node, &mdio_dev);
+	if (ret)
+		debug("Warning: failed to bind mdio controller\n");
+
+	return 0;
+}
+
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
 	{ }
@@ -990,6 +1021,7 @@ U_BOOT_DRIVER(airoha_eth) = {
 	.id = UCLASS_ETH,
 	.of_match = airoha_eth_ids,
 	.probe = airoha_eth_probe,
+	.bind = airoha_eth_bind,
 	.ops = &airoha_eth_ops,
 	.priv_auto = sizeof(struct airoha_eth),
 	.plat_auto = sizeof(struct eth_pdata),
-- 
2.51.0

