Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72713CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 14:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D197383DEC;
	Mon, 24 Nov 2025 15:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Xla4ZFlE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lSdm3yzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E0F83DFF; Mon, 24 Nov 2025 15:51:39 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C504283B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dFTL04ND1z9sv4;
 Mon, 24 Nov 2025 15:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763995896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cbW4BYNc/RXso0mL2czwHA0a1YGUlaiPbuPPNBKQZso=;
 b=Xla4ZFlEiykcKKcOTKL5CU5ZC8NjrkCWbCAyb9gsZ7dUYlyv52Bo7DS8PSPSrhVI8ivdzZ
 PD6R9ozcjiAeLaNUxRPtBMaUy9szWyPaJ5c/bzwmDOr44m8P6SOvCFiF700WAvZYkoIJaL
 fC3bjJw609XsKpvuK1WomSDySgJeNOdH2YCO+L/3UPRwz2Ls9Q8tH3cZ+I38sTGr+oTzOU
 IB2wNB2y0aKP14ff9HNt/VAMxwx9DmdXsgI61fyPTFA2hnkd8DfN5+i+XJg7Q3NXIWPUWn
 YCbsMHezWVM9fADR3pxxp5l+MMipU28VtPT4/qkzHfzaxptHcI/WSjR0MnKf+Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lSdm3yzr;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763995894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cbW4BYNc/RXso0mL2czwHA0a1YGUlaiPbuPPNBKQZso=;
 b=lSdm3yzri7f/M2XOlLVULLpm36J5oJucAPuAGBT+Hnka2MrN2lVgHvFaFbK5WLWdrmJa+u
 y2BsELfhvYUXIrhEtCvmVZtxrYs+Iiw1lt9WXJ9G6yMnV6d/WC7h423c2wbsAE20zvXSZw
 R4VnVkV8Qz97D1sCcQ8NCuK76takcZrGAC6ru9C70ZkdQlon7UodnDUh9ITZqjE9iiJ4+x
 FNVIJLq9rwctI2pZVJYeeTUkaf/ATv8rNnrPH14UGYEVizoF9tp3aEsqxLAAOxnLTc5dq9
 YB7zh7hROb12iVKeLEv7rMpwXwVrE5hueH3Tvnxr4QsLQxCx+hFIw+oGG6RHPw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] i2c: Inline i2c_chip_of_to_plat() into
 i2c_child_post_bind()
Date: Mon, 24 Nov 2025 15:51:00 +0100
Message-ID: <20251124145128.8624-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3a4a9029c66f7609a0e
X-MBO-RS-META: cnj9x874fbt417gybnzim148o7xw3tm5
X-Rspamd-Queue-Id: 4dFTL04ND1z9sv4
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

The i2c_chip_of_to_plat() is called only from i2c_child_post_bind(),
inline i2c_chip_of_to_plat() into i2c_child_post_bind(). Drop the
if CONFIG_IS_ENABLED(OF_REAL) and depend on if (!dev_has_ofnode(dev))
which does check CONFIG_IS_ENABLED(OF_REAL) internally too.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: New patch
V3: Drop sandbox from subject
---
 drivers/i2c/i2c-uclass.c | 39 ++++++++++++++-------------------------
 include/i2c.h            | 13 -------------
 2 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index 380a9f8f3ad..97466597d77 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -701,26 +701,6 @@ int i2c_deblock(struct udevice *bus)
 	return ops->deblock(bus);
 }
 
-#if CONFIG_IS_ENABLED(OF_REAL)
-int i2c_chip_of_to_plat(struct udevice *dev, struct dm_i2c_chip *chip)
-{
-	int addr;
-
-	chip->offset_len = dev_read_u32_default(dev, "u-boot,i2c-offset-len",
-						1);
-	chip->flags = 0;
-	addr = dev_read_u32_default(dev, "reg", -1);
-	if (addr == -1) {
-		debug("%s: I2C Node '%s' has no 'reg' property %s\n", __func__,
-		      dev_read_name(dev), dev->name);
-		return log_ret(-EINVAL);
-	}
-	chip->chip_addr = addr;
-
-	return 0;
-}
-#endif
-
 static int i2c_pre_probe(struct udevice *dev)
 {
 #if CONFIG_IS_ENABLED(OF_REAL)
@@ -760,15 +740,24 @@ static int i2c_post_probe(struct udevice *dev)
 
 static int i2c_child_post_bind(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(OF_REAL)
-	struct dm_i2c_chip *plat = dev_get_parent_plat(dev);
+	struct dm_i2c_chip *chip = dev_get_parent_plat(dev);
+	int addr;
 
 	if (!dev_has_ofnode(dev))
 		return 0;
-	return i2c_chip_of_to_plat(dev, plat);
-#else
+
+	chip->offset_len = dev_read_u32_default(dev, "u-boot,i2c-offset-len",
+						1);
+	chip->flags = 0;
+	addr = dev_read_u32_default(dev, "reg", -1);
+	if (addr == -1) {
+		debug("%s: I2C Node '%s' has no 'reg' property %s\n", __func__,
+		      dev_read_name(dev), dev->name);
+		return log_ret(-EINVAL);
+	}
+	chip->chip_addr = addr;
+
 	return 0;
-#endif
 }
 
 static int i2c_post_bind(struct udevice *dev)
diff --git a/include/i2c.h b/include/i2c.h
index 91917f54be9..b2572076236 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -549,19 +549,6 @@ int i2c_get_chip_for_busnum(int busnum, int chip_addr, uint offset_len,
 int i2c_get_chip_by_phandle(const struct udevice *parent, const char *prop_name,
 			    struct udevice **devp);
 
-/**
- * i2c_chip_of_to_plat() - Decode standard I2C platform data
- *
- * This decodes the chip address from a device tree node and puts it into
- * its dm_i2c_chip structure. This should be called in your driver's
- * of_to_plat() method.
- *
- * @blob:	Device tree blob
- * @node:	Node offset to read from
- * @spi:	Place to put the decoded information
- */
-int i2c_chip_of_to_plat(struct udevice *dev, struct dm_i2c_chip *chip);
-
 /**
  * i2c_dump_msgs() - Dump a list of I2C messages
  *
-- 
2.51.0

