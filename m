Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AEACFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5360083966;
	Fri, 21 Nov 2025 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="enQ/BE8J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NVJimABP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0243883966; Fri, 21 Nov 2025 17:18:26 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B01D8394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCgPW6TFkz9sRc;
 Fri, 21 Nov 2025 17:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763741903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ez9YGpdLpedMaSCV4qjPZHYoUWCQZ35eyPf46WjbAMc=;
 b=enQ/BE8JmCpR0BKN/2+Vh/PI7WET+FnI3Gp3l6UdXqPXnk9yzciQvDKUM23zxxpfR316Uc
 thaI/jZ+5acK1UTcVxbzsLc8kiBTHg4OvDkdF5i302ciDIAo8wG+YgwcRoBZLcX/zmTYhy
 tmcee3xzrIGZNEnjJjp9Z3YIcMmovMdIc3/UO2EC2TUGGkTdvb93EUydjryVqDTopzwJm5
 qcCnhYa5rDeVoECxvmz89jB5Fnpt8teCDi4ek5LMBRvBTBNKRtTq6z0FK8uV32XB+g9Qsw
 bSx7UGVMj4kMl0ynrY2ZKloktPykPWD1Qbwboge2P7RkzImDbdFi3LSOqiFxow==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NVJimABP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763741902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ez9YGpdLpedMaSCV4qjPZHYoUWCQZ35eyPf46WjbAMc=;
 b=NVJimABPbTTN3gnhLOE6aEn2WIaN5p2A6sLoRaBC5JTH9hbELENJ+jGGu97JeFtFIMJbzn
 wVrqx32TWjFDtowiE8BF0TJ3tDvQmm6VHBEJgnEkR2doV2ps+eYj00tHmFM5ezpQpJLgYu
 cb0HZVX46kMYGrjmX1pJqefsYF7VRVGIBEh6TaxPRkURBOgCISPDQq35sDrjCDxpkokoTK
 NjrAR6zTZTop0d7q+JazIdDriadyUPI+HT18K4kmUO9oeXmcyj3SXlQIXv9FQXfVptfxQ4
 aWQKtduArCvN1hRTXLmFum2NwIc1VD4tuyS6Wig5kZZ2tPjsuL+WgnUNumDs1g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] gpio: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Fri, 21 Nov 2025 17:17:55 +0100
Message-ID: <20251121161820.11883-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4c6y58ajt73t169zdgog95peckf1pqud
X-MBO-RS-ID: 2ab0ca9a34fbdaac444
X-Rspamd-Queue-Id: 4dCgPW6TFkz9sRc
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

Since gpio_sandbox_probe() already calls dev_has_ofnode(dev) and assigns
uc_priv->gpio_count to CONFIG_SANDBOX_GPIO_COUNT accordingly, add matching
dev_has_ofnode(dev) check into sandbox_gpio_of_to_plat() and do not call
any of the dev_read_*() functions for devices without valid nodes there
either.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Call only dev_has_ofnode(), which internally checks for OF_REAL
---
 drivers/gpio/sandbox.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
index f5be2781443..e8f50d815d7 100644
--- a/drivers/gpio/sandbox.c
+++ b/drivers/gpio/sandbox.c
@@ -327,13 +327,14 @@ static const struct dm_gpio_ops gpio_sandbox_ops = {
 
 static int sandbox_gpio_of_to_plat(struct udevice *dev)
 {
-	if (CONFIG_IS_ENABLED(OF_REAL)) {
-		struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 
-		uc_priv->gpio_count =
-			dev_read_u32_default(dev, "sandbox,gpio-count", 0);
-		uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	}
+	if (!dev_has_ofnode(dev))
+		return 0;
+
+	uc_priv->gpio_count =
+		dev_read_u32_default(dev, "sandbox,gpio-count", 0);
+	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 
 	return 0;
 }
-- 
2.51.0

