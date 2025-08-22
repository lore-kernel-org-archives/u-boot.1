Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA3CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 23:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F0080422;
	Sat, 23 Aug 2025 01:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XnVbVevC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B3982E67; Sat, 23 Aug 2025 01:29:46 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA8C80422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 01:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b9e7437908so1748663f8f.3
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755905384; x=1756510184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BxWmXax6xENmBeqqxY4PRGm34X/rWdA0WE93dwOBdds=;
 b=XnVbVevCWx2+5ZsTVC7zitFlI8RTwXe7NqAT61PoPvxn01+7r6lI1pk02+4ydwGSWW
 P/S3gQcr4PrsncXZ3bcAmjYR8v1B1tCq6yHyGAuTZvdf1TZspAG3ZtXVgEseSahtNmVK
 kBPtBZsZY1DK3WaV9HsQnMkWgQoyJ8MByCtr2pHJ26cSxh4kPSpgmX4FRrSTMaO6P4Sy
 PEjm4wk8+zk4Z9GvtDsp9Oq5cHHiythDmS6EwHsKx8FIOv1cPVhEy/jNIb2607JBmFhq
 OjaRYkXdsudJHqs0BXIP1GansfRlkkyY5P+5+uaCfVKAOwf1NlmOu/CBI2p5uyskoe0o
 rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755905384; x=1756510184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxWmXax6xENmBeqqxY4PRGm34X/rWdA0WE93dwOBdds=;
 b=tEScOwpXA1Z72i1VLHLSPxsJluEXP1f0WX2Pt8WGYSl5p542Zf9lWLjHNhy5ebhGK9
 /jqF//5ujB+E+nhta/9q2EL1v4fAIMzyhOuQBaNnUaLJgPcPv9i59YYO9LouZY6ZsXRa
 nwW1F3IKnrX5zcWqeahmPqjbEH8aeL2lGKMUUia7dNxRtSqeCG2VvKOfmdTYCG4MZ4Qs
 weQ/qw+0EoQ3p9B36XWgT2Jn4VP+qRdJV7+NCSIHwuuP7Z+n26isq/aiOIu1sAOal3+B
 t44mUV9bAQV0HvfF/bDBp1q8t2Bum4/VLpuj8eMtYRS5/W+jM1hE2Qdjrby4y4W5+TQl
 svjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU7hUujwsPQ4ziNuVNhgLBMUdb7HL8UlMENq8BlUYZeoilLKUTZQvTFjTRA8mQxkrNuME07eY=@lists.denx.de
X-Gm-Message-State: AOJu0YyIOGddCKhdYKANMk+9VA8vdGeGm3t3T2OOqJULMSl5zOPKSact
 Syd0XQct3WblmzjBXJHUBTLUvVGfmODQtyX6ABDy6gYnNdgKIjMFppsu
X-Gm-Gg: ASbGncu3ENeHlqL22P6fmfeWCeRftWf49J4ckOEuYh035JEGQuMV98deOZZQt58lD1L
 PhX6OflG2rzFIDM3nluP6q0QeslRFYc4+HMlVUUOSn+8tLIwvL1/XiLFRSxHvJkMBOqiVC5jMNM
 P+NEYpCzT+50cJyNDYYNecRXDvEdtJkTk++gcgkqb1VXtDc1ixzkkkQN0xScHk9LcqX01jbFhfA
 6Ih3mC6B6lVoAFUznPzyh398iXQvI8Vn1rwslsLFH/KNIR9BFGWBZ699NQH9NQQJlKzWJp6Kpk+
 kZdQaG6zWjcuHYYQq391obu36xYyfqWPXwPp8ubZfZtMFt1BOP+KJQH7d2/P9CyxQMcN39gVrU6
 kDUzyQxhzIFdlYaWVdxkJ0IHIq1WozZ+WEncv9h1IcHVdh4yrk7DjO7P9dW3xud48Lz8qkW8=
X-Google-Smtp-Source: AGHT+IF1rZuq0tQxyihnA5rJV60GjdY6vNjAsAEZ+tPTzLRRebT65YKmaPgeLN0GO2MUuMMGSLGmdw==
X-Received: by 2002:a05:6000:40ce:b0:3b7:899c:e867 with SMTP id
 ffacd0b85a97d-3c5dcefd9aemr3816345f8f.59.1755905384177; 
 Fri, 22 Aug 2025 16:29:44 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1483sm1216970f8f.50.2025.08.22.16.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:29:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 2/5] net: airoha: bind MDIO controller on Ethernet load
Date: Sat, 23 Aug 2025 01:29:16 +0200
Message-ID: <20250822232921.30076-3-ansuelsmth@gmail.com>
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
index 9ac9bee46c9..f7ea12f9b37 100644
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
2.50.0

