Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF805CFC509
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 20:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B8683AB0;
	Fri, 21 Nov 2025 21:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aYlc4HgZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="duo67NBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087E9839A8; Fri, 21 Nov 2025 21:58:07 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125E983A9F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 21:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCncD5zkPz9twg;
 Fri, 21 Nov 2025 21:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763758684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+nkBRM3pYmUEYUCh5VK8rsT4IuBgUh6vlKnNiuW9pw=;
 b=aYlc4HgZaC4EjijXevBg3BC55R5RRLETZqLpOaSee3rRIEaWg6TFGn36cFwDpmRSrfhDMI
 UoEEHAKdYikZjEM31HuivQEdkUi31dEtOJvZ3twlfNDYDpW155Y79RarOuGWiArVosR5KG
 m0SEkPZVdHnUaJlAErBjYjPHVxa2iEkwPaWng/56asqnhP1Tb5YClHMi4DcApIPXijpyHE
 sAL/CQBvI6X0e4HanUiizbKKTW4/Picfe9k9fWwlWRh3uOVAtF70Sf+/E4XjVKwrrpBBXH
 ZByHgBRvOJBmmYiDjBTpJ26JUxaTeKmcx29QFsYeZytHTs4RAeu3ZVov9xQZDw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=duo67NBO;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763758683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+nkBRM3pYmUEYUCh5VK8rsT4IuBgUh6vlKnNiuW9pw=;
 b=duo67NBOtruUAsu1iopOGLYEmHXzZ4ig8Kdkp67HZO1j6KvwwDR2JlaqqigvMTTvVA0iUi
 9RWcO9xUCFtATK4WDL2S+paN/1I3e0c6HCcqJsbsXSFR5C7KpuF9ApG1r2EEky9PL2XxvB
 swH+AfKhpovKSnNPUugEf/8+tfLN557dKKEtAaQ+RmxQ6zGlV5pASfMeaeGTa6498IcYZ/
 zmp1iAjtmnxvLyU7NYw6HX4m2hCaWBhzD93+HIw+EFjAhrXH3p8+MOYyX4qNu0B4JJp66a
 WMhkGKVzKvcI9gr2vqXNFrV/N410cPvi+KhsWZWb2ghhP9XeZTeHDXdCyqm+kA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Fri, 21 Nov 2025 21:55:46 +0100
Message-ID: <20251121205758.66888-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251121205758.66888-1-marek.vasut+renesas@mailbox.org>
References: <20251121205758.66888-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 38144b3a6303b916c74
X-MBO-RS-META: m3x1xpb777hqrun57e3q5o8o9cao4rex
X-Rspamd-Queue-Id: 4dCncD5zkPz9twg
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

