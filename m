Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B4FC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C738129F;
	Sun,  2 Mar 2025 02:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nhDk+yKv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kfCKkgDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE3C811DF; Sun,  2 Mar 2025 02:28:39 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF718128D
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z548d3yr9z9sW5;
 Sun,  2 Mar 2025 02:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyN4js/i5N6dgnKPJ4oyep/uWF6/INze1nBrVrOmRLw=;
 b=nhDk+yKvpdG+CZClRQaFXBgJPhiDEE080vFjHt+qZXnKc2DBGUz2qhQl1l82KAuBnChP6L
 F9ZbwMMejKiQ4OL74St9ZofUmlWUyw/5t2as7ZBwJjgM8ZQelcbfCDfqh/mlTzkXxpmEPK
 dR7ebs4Qww1y+tYwQ2K30qzeBGk3ROAP8BkkTVyA3BxlAKP3eSPJT7b4hO1s3mqVb2j1f7
 8OSMVCwnhldqGYC+6A4BWd6B726z4yvCuOC85wlDtXjwD96BCQfOwWGN4GdhWwp/P8nnYO
 2sktE2VhjNVb5BW1riqPpnXxJ86M4JkulfZ3Hp/rWdo7PNAZiRmGt+A97gbbew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyN4js/i5N6dgnKPJ4oyep/uWF6/INze1nBrVrOmRLw=;
 b=kfCKkgDwq88hl29iI8kHOODqpvowmW3gsWmijCyErw9A8BkVoWgEYktfmdimSlhZSHtqpf
 3OMlqbvQLqk4CI/LWKHHqqM5qOPnUhwZijhgUiytSIPe7vMq5vQ0tSA0K5B03w3j9sdUDT
 9lcmwVutSpwyJzjpcxL+Jb7p8IETa+jkx/jT3GpvB0kNK0fLIo0jpF+BHhYC5H4PY4HA4g
 8RwsYfd56VoQeyKpzXKAUaIFmY+ze98ZoyhD46DBat9vn76I4j/os4o8IaS0Mo2vG89at4
 TesUQOkVa02Ci/dK6fzYxT90f5Mg0NyH+F6JFOUFmQH6EqVkwLwMY9HETCj/qw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] net: designware: Switch back to mdio_alloc()
Date: Sun,  2 Mar 2025 02:24:47 +0100
Message-ID: <20250302012752.393608-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nrjfw8wp76dn47n8brndte4zyp5jser6
X-MBO-RS-ID: 475f5f31469ca518103
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

Use mdio_alloc() again to allocate MDIO bus. This is possible
because all the miiphybb parameters and ops passing is handled in
at bb_miiphy_read()/bb_miiphy_write() level.

This also fixes previously missed bb_miiphy_free() in .remove
callback of this driver. which does not pose a problem anymore.

Fixes: cbb69c2fafcc ("net: designware: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jim Liu <jim.t90615@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michael Chang <zhang971090220@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/designware.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 4827811dce3..0f93c25e3fe 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -316,17 +316,14 @@ static int dw_bb_miiphy_write(struct mii_dev *miidev, int addr,
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 {
 	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
-	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
-	struct mii_dev *bus;
+	struct mii_dev *bus = mdio_alloc();
 	int ret;
 
-	if (!bb_miiphy) {
+	if (!bus) {
 		printf("Failed to allocate MDIO bus\n");
 		return -ENOMEM;
 	}
 
-	bus = &bb_miiphy->mii;
-
 	debug("\n%s: use bitbang mii..\n", dev->name);
 	ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
 				   &dwpriv->mdc_gpio,
@@ -855,7 +852,6 @@ int designware_eth_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct dw_eth_dev *priv = dev_get_priv(dev);
-	bool __maybe_unused bbmiiphy = false;
 	phys_addr_t iobase = pdata->iobase;
 	void *ioaddr;
 	int ret, err;
@@ -947,8 +943,7 @@ int designware_eth_probe(struct udevice *dev)
 	priv->max_speed = pdata->max_speed;
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
-	bbmiiphy = dev_read_bool(dev, "snps,bitbang-mii");
-	if (bbmiiphy) {
+	if (dev_read_bool(dev, "snps,bitbang-mii")) {
 		ret = dw_bb_mdio_init(dev->name, dev);
 		if (ret) {
 			err = ret;
@@ -978,12 +973,7 @@ int designware_eth_probe(struct udevice *dev)
 	/* continue here for cleanup if no PHY found */
 	err = ret;
 	mdio_unregister(priv->bus);
-#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
-	if (bbmiiphy)
-		bb_miiphy_free(container_of(priv->bus, struct bb_miiphy_bus, mii));
-	else
-#endif
-		mdio_free(priv->bus);
+	mdio_free(priv->bus);
 mdio_err:
 
 #ifdef CONFIG_CLK
-- 
2.47.2

