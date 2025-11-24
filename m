Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F65CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 14:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D1683E0F;
	Mon, 24 Nov 2025 15:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tlzcmTbV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pLvHeTd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA4483B85; Mon, 24 Nov 2025 15:51:40 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9875783DEE
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dFTL22sHPz9tGC;
 Mon, 24 Nov 2025 15:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763995898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlIM3vcDurtQfgOzpiqcpQAVzb72jCjSx6KZM321TsU=;
 b=tlzcmTbVw9sSQp+EZrqEikyqMd4cpYD/N966EO7Dle95F4Pa41IAcm+c4OwpNwoIgiSdxd
 KPwvScHOyFIgXdeHyGMcpZysXaIM8x+V3TuMt4xEcNFNJN/LCi9rZFR5Jr1WMedCMgRemy
 rRmubYG3K1EqibhZjhoW6DgH1D2GjIq0hGK4Ea3ZKuzG6xnqMlfJ0/b14lCAjOKC3ITloJ
 r7NLv8wBTUZbw5VGdH0524ApyCwz28qdBpDVFF57xIF6P+oTl0EOrp6sooahCULiEtlnlA
 WFZFVfglYjiEavGmswem2LZcg6Ai0xJ6h8Se/XAbXYSIRSuJTZdVF+/eb+eaBg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pLvHeTd6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763995896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlIM3vcDurtQfgOzpiqcpQAVzb72jCjSx6KZM321TsU=;
 b=pLvHeTd65m7pxtwOYBtE3wad0dBmufB9g9hEg4rWN/9+6nfCkTrc7bWZvxOPPbxpnGYZy7
 gJZwlRgN/JVvm3Rba4Cfpvl5ZhVcBiWslmIz+Pb78q6GiOgmTDYDCYB4aC9bVk5WzrX4oQ
 V8mVf10qcX0r+QdKCwM79HEGSzJzAUbHsaOQoQ83wNtbWXodNV0X8/qhc+gd014S0C1JLy
 MevtMJQTNr41MSCRHhD1xbk80gBAdvL7YsaPZKz6HYJjPdJIaM/t5rtZwncjNA1PUCIF9f
 hXGOXjkMLMlyfkwga4lvcckjw86LPDxaqAm7sSzrMSBc1k0uUuH8vk+FAaLqZg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] i2c: Avoid calling dev_read_*() if CONFIG_OF_PLATDATA=y
Date: Mon, 24 Nov 2025 15:51:01 +0100
Message-ID: <20251124145128.8624-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251124145128.8624-1-marek.vasut+renesas@mailbox.org>
References: <20251124145128.8624-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xp8adtw4so86g3fjwwhz4tdcx6hggw1a
X-MBO-RS-ID: 161ac57e0e704e8dabf
X-Rspamd-Queue-Id: 4dFTL22sHPz9tGC
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

If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
and passes result of ofnode_to_offset(node) as an offset parameter into it.

The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
because libfdt can not handle negative node offsets without full tree check,
which U-Boot inhibits to keep size lower.

Since i2c_child_post_bind() already calls dev_has_ofnode(dev), reuse the
same call and assign i2c->speed_hz = I2C_SPEED_STANDARD_RATE in case the
device has no valid node associated with it, and do not call any of the
dev_read_*() functions for devices without valid nodes.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Fix up i2c_pre_probe() using dev_has_ofnode() and drop remaining
    if CONFIG_IS_ENABLED(OF_REAL) ifdeffery
V3: Drop sandbox from subject
---
 drivers/i2c/i2c-uclass.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index 97466597d77..bb32ebd9981 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -703,12 +703,14 @@ int i2c_deblock(struct udevice *bus)
 
 static int i2c_pre_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(OF_REAL)
 	struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
 	unsigned int max = 0;
 	ofnode node;
 	int ret;
 
+	if (!dev_has_ofnode(dev))
+		return 0;
+
 	i2c->max_transaction_bytes = 0;
 	dev_for_each_subnode(node, dev) {
 		ret = ofnode_read_u32(node,
@@ -720,22 +722,22 @@ static int i2c_pre_probe(struct udevice *dev)
 
 	debug("%s: I2C bus: %s max transaction bytes: %d\n", __func__,
 	      dev->name, i2c->max_transaction_bytes);
-#endif
+
 	return 0;
 }
 
 static int i2c_post_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(OF_REAL)
 	struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
 
-	i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
-					     I2C_SPEED_STANDARD_RATE);
+	if (dev_has_ofnode(dev)) {
+		i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
+						     I2C_SPEED_STANDARD_RATE);
+	} else {
+		i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
+	}
 
 	return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
-#else
-	return 0;
-#endif
 }
 
 static int i2c_child_post_bind(struct udevice *dev)
-- 
2.51.0

