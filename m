Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D363CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D8183423;
	Sat, 20 Sep 2025 18:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AV9HLHoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EF583192; Sat, 20 Sep 2025 18:10:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C967833EB
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so1883179f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384626; x=1758989426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdhQACNKIt+lO//CliGiwSKTr/HoLwrRs1465XTOkjo=;
 b=AV9HLHoqgDKdPYDv876y0LHZBXLGA48t4fezozC6jwUw6HTf7fT364cD9MgFriAqtf
 8tfaJJFUcu6wHYz5R5KKmgxPsCu0xtq4+u7ARftynQwdMF2EkqjY5lzYPDp1M28RCEGA
 gJY2WzQT7Qc6BzWSL2m4A1yf2VAOnj4EyvlzpPwHHJYk2PGvmXhjWv2kcDJXCluNiCEz
 YE0hDdM1hCqbJaRgi9AN2G33dr0XHjj2Knv+VtvjnOG3Z2qhpVpNaWHwP1PTi9huyy+p
 EnYkh43bGK1NorOLB5AzQnqXhrL3z5wadBp3wyrZwG+S2o+GTIgaXUOjPUspuxz9h209
 3TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384626; x=1758989426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdhQACNKIt+lO//CliGiwSKTr/HoLwrRs1465XTOkjo=;
 b=m1HfO7dJ4NyFohELjCuPOL2z93XTTCEeLdivuu4PtDT9ceGURdGZIEyytyaOBz9Omw
 uqRQxT58kzje/C4gE/w9kKjAnR0IM6spQPcTaCqbMHNUmhwtLhrtsd5lMMAV+jo0xviI
 5PgXXjXHq46r2B70AoQSnXzLoZ8jNcK1f9j/H6zuFupgaaCG1Wotx9NENjmqEJU7FqrG
 7kmX5Cyf+HQ1PE6YJnSfaEeuD+GpsG5nxUFFx6n6F90iggLqjP/ZDJgYoqxw0MXcaP6F
 /qDUBjQipXMbaEgQfZuCjnvAEgLNUoyD9BIG5vT4h2vZKgtXJWeBWZDjcrMeEI80+BxE
 e8Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlCBKKSuWBQOt/xhLddKjMm7hWneqFxYdVW/GwyKWzqf/e3jo2Jt0N3KVPFPaKqUVDzztp8aY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6mZKVqy0KT6gFFjEB90x5Aos2pWyyWK1aW5Ua+g9FiYh5WB/9
 4Euftd+BCW39+xP8M1RRociyItQeKGLz4jluAmzC5Wh86b7bnaXQI2vE
X-Gm-Gg: ASbGncu/CsyyBvBhWoC1dCkK7oSveOXrQgslP16M/m/krEGJTbQaPFhZ3EK4TswkUsx
 iDCr/wV8Yvbbso63CsyE9X03eV+OvTrTodauq6II7VuV+VIZU1jZ1tocNdck8xgpmHEFQmgPQ3J
 Djd7AsoGkOL0yfLmS9p7k/bLzWTiquppR2XzXbQRGnRU/RkyGx1GfxhUJjTZm7CaYxVurL/aVLl
 AJbWbxoYFwAG25bCVKgrCaiOd0RYOw7PoJLHRpsZFx28B8WtMnGJ5rH5If+J7I3GdaOdqMVGwKl
 p5Jlm2JYCICbMWSzaDq7CIdAVPNWmDhQkuxVRELNiICJCVXPNUEl3xaG3Ky4PNktUuDEMZ9ZmOZ
 KxaN6ieKYqSbLfQPrMF8nZf9wqCMl8vGbvQQ/U/+koUuUiGPq3ByephgcVTw2ape+ebXye3s=
X-Google-Smtp-Source: AGHT+IHth8XprH3kN842znVgOHSLRaj/BYlOq2JOTZpWMBQsVSLgcgUJgTA6PEPbi13PKqjbYkMd7w==
X-Received: by 2002:a05:6000:2c12:b0:3ee:15b4:8443 with SMTP id
 ffacd0b85a97d-3ee7db4c6b2mr5141768f8f.18.1758384625715; 
 Sat, 20 Sep 2025 09:10:25 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 5/5] net: airoha: bind MDIO controller on Ethernet load
Date: Sat, 20 Sep 2025 18:09:45 +0200
Message-ID: <20250920161013.31799-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920161013.31799-1-ansuelsmth@gmail.com>
References: <20250920161013.31799-1-ansuelsmth@gmail.com>
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

