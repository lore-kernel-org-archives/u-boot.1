Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C7C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 19:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAFE584C7A;
	Mon, 13 Jul 2026 21:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MsX/d/Lf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C3984C7B; Mon, 13 Jul 2026 21:30:52 +0200 (CEST)
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA4484B49
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 21:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783971049; x=1784230249;
 bh=2WNzupjhkc3dKpHJp7OJzSF/9B/aqkK8s6K7e45gLrY=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MsX/d/LfKD/t/0pJScMY2nvNdBEftmBAvaMrbpGkHiBeHYuVOQ7y7PkzQJD1/ebCF
 qW8gHwG7XHjIGm2AR4d5PCH+C4ba1seMHCZIRO20FYHSQj6wsFAmZKGg/nJP7V9xJk
 0EhVResQXySygK+MqSaqs02PWIt9SfhFmlwLsUTJEHiDy6hlLePVfe+9CqNTHk1oz7
 /1aASsjhUk4rYH3O8ORPp4mDn4Bt5ASB0NPiVCtzRMoLZ1D9k2ziy8gd+joyzXqN5W
 Gm5qZ5CgYT3XV0Iw3lfSV6kCH7Em1HCNuoByUPe7ByM6KyE5W7w1QWyYJAzYMqAM72
 S3VShKWrxzJOA==
X-Pm-Submission-Id: 4gzXbW2vCjz2Sd3Y
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] net: drop pointless .bind methods
Date: Mon, 13 Jul 2026 21:30:43 +0200
Message-ID: <20260713193043.2851418-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
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

Considering that device_set_name() does

  int device_set_name(struct udevice *dev, const char *name)
  {
	name = strdup(name);
	if (!name)
		return -ENOMEM;
	dev->name = name;
	device_set_name_alloced(dev);

	return 0;
  }

it should be pretty clear that these .bind methods are at best
pointless (there's a fixup for device_set_name() en route that will
make this not a memory leak).

I presume one of them got added by mistake and the remaining are
cargo-culted, but regardless, just remove them to prevent yet more
copies of this anti-pattern to appear.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 drivers/net/dm9000x.c    | 6 ------
 drivers/net/ftmac100.c   | 6 ------
 drivers/net/ks8851_mll.c | 6 ------
 drivers/net/smc911x.c    | 6 ------
 4 files changed, 24 deletions(-)

diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
index 9e17f0b9c28..53225979b66 100644
--- a/drivers/net/dm9000x.c
+++ b/drivers/net/dm9000x.c
@@ -638,11 +638,6 @@ static int dm9000_read_rom_hwaddr(struct udevice *dev)
 	return !is_valid_ethaddr(pdata->enetaddr);
 }
 
-static int dm9000_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int dm9000_of_to_plat(struct udevice *dev)
 {
 	struct dm9000_priv *db = dev_get_priv(dev);
@@ -673,7 +668,6 @@ U_BOOT_DRIVER(dm9000) = {
 	.name		= "eth_dm9000",
 	.id		= UCLASS_ETH,
 	.of_match	= dm9000_ids,
-	.bind		= dm9000_bind,
 	.of_to_plat = dm9000_of_to_plat,
 	.ops		= &dm9000_ops,
 	.priv_auto	= sizeof(struct dm9000_priv),
diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index fa0b3dbb6d1..d9826178e82 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -429,11 +429,6 @@ static int ftmac100_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ftmac100_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static const struct eth_ops ftmac100_ops = {
 	.start	= ftmac100_start,
 	.send	= ftmac100_send,
@@ -451,7 +446,6 @@ U_BOOT_DRIVER(ftmac100) = {
 	.name	= "ftmac100",
 	.id	= UCLASS_ETH,
 	.of_match = ftmac100_ids,
-	.bind	= ftmac100_bind,
 	.of_to_plat = ftmac100_of_to_plat,
 	.probe	= ftmac100_probe,
 	.remove = ftmac100_remove,
diff --git a/drivers/net/ks8851_mll.c b/drivers/net/ks8851_mll.c
index 2c956154d09..c2f87d4222b 100644
--- a/drivers/net/ks8851_mll.c
+++ b/drivers/net/ks8851_mll.c
@@ -571,11 +571,6 @@ static int ks8851_read_rom_hwaddr(struct udevice *dev)
 	return !is_valid_ethaddr(pdata->enetaddr);
 }
 
-static int ks8851_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int ks8851_probe(struct udevice *dev)
 {
 	struct ks_net *ks = dev_get_priv(dev);
@@ -615,7 +610,6 @@ U_BOOT_DRIVER(ks8851) = {
 	.name		= "eth_ks8851",
 	.id		= UCLASS_ETH,
 	.of_match	= ks8851_ids,
-	.bind		= ks8851_bind,
 	.of_to_plat = ks8851_of_to_plat,
 	.probe		= ks8851_probe,
 	.ops		= &ks8851_ops,
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index f39ba40944f..2835eb45856 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -431,11 +431,6 @@ static int smc911x_read_rom_hwaddr(struct udevice *dev)
 	return 0;
 }
 
-static int smc911x_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int smc911x_probe(struct udevice *dev)
 {
 	struct smc911x_priv *priv = dev_get_priv(dev);
@@ -487,7 +482,6 @@ U_BOOT_DRIVER(smc911x) = {
 	.name		= "eth_smc911x",
 	.id		= UCLASS_ETH,
 	.of_match	= smc911x_ids,
-	.bind		= smc911x_bind,
 	.of_to_plat = smc911x_of_to_plat,
 	.probe		= smc911x_probe,
 	.ops		= &smc911x_ops,
-- 
2.55.0

