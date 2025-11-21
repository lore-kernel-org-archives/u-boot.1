Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E97CFC281
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 20:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9072839D7;
	Fri, 21 Nov 2025 21:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cZhOTYaF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Gpm0lnkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C0483AAD; Fri, 21 Nov 2025 21:58:06 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 454F0839A8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 21:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dCncC6mfBz9t8m;
 Fri, 21 Nov 2025 21:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763758684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g09ZbqkJ/3S5cqygDt2KrGAkpCi4UymB8MqT/UBUPhg=;
 b=cZhOTYaF7YV+sG0F+7YI2zbxKARvc8M0Obub1Fn+J9d4o4QOvTAs18CdoNASPNm5JgDE4v
 c0kftlbdctsINuweZWlXYqjZ+h1j8x4sqQBadB/vF/mE/RwPo+KRy/TN48+MgmYEwajloC
 ruuti5FPaXcPoWFKf1ahZDpC69Ca5LD008vtKyBNzaHRp16Ibt3EzwzkIdgMPSOkrScTDY
 vc3YA/1TObkcrrXdbT2ZdcTMOFwhpmHYvZBUXDYbnSrS/tL9qNx76oL7ae27lGpYZl4SYu
 ddwFZaxOtCcw8HenvBCyy0DY0wkVIPeggJmxCFVPQbfz16ZuMrQFjrUJ79D1/g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Gpm0lnkT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763758682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g09ZbqkJ/3S5cqygDt2KrGAkpCi4UymB8MqT/UBUPhg=;
 b=Gpm0lnkTCEq2B+xLlurgHfXDq5VMHgoMeRFezOZJ9NbxqUsZqPZL20aQUSkR7bLcMKEgMV
 8iSyS0hSwwRGXxh1ijGDgeg9Bw/hUBXXXDrrkmFaB84P566jFkixOwt5vRSYH6Gt/eintr
 u8VG2GbZILxYOFPpc6wyvFEBo7pOoewhcdeQWRwfEYb4lXPLRjiZa3dJnVW6nlOV9BHDb7
 19VwzRl7TONZm5SqcFPgDDo3yOSIqKoFVzgGDW2MfNuPIW/gKn8XCecPtW0JpyiWsdoJbv
 ji1cFSqWrveqJa5tOM9JqCCCmIS1A2ND8pMtlK4l8yv6sLR66aadqBBpZOQ6ww==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] i2c: sandbox: Inline i2c_chip_of_to_plat() into
 i2c_child_post_bind()
Date: Fri, 21 Nov 2025 21:55:45 +0100
Message-ID: <20251121205758.66888-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7a6752b206314c6dc24
X-MBO-RS-META: hgx9k3e4pn89et7yqytraadmbho3hcx9
X-Rspamd-Queue-Id: 4dCncC6mfBz9t8m
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

