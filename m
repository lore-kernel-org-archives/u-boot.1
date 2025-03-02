Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB828C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B07C811D8;
	Sun,  2 Mar 2025 02:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qqTcmT7R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y5iOwXjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E01E8058A; Sun,  2 Mar 2025 02:28:43 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09B5812BE
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z548h2d18z9sSf;
 Sun,  2 Mar 2025 02:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7W0AHP8AZH3BQuOg7VoSSLCGAt5cEG8orrbcrfWX60=;
 b=qqTcmT7R5w2St42qWtGoFSpyrjkoNx6ToFoHuCSMvR19nkKxX/WCbgrfzxtdsI3x/rD3GV
 fOkElMgRQ1P+1vjxLfNuhOYxRB8H+yRsp49PjNDcFXpWbIo8awnQPb/CcaYHW2Mu9TCyJo
 iexEo143Xc+IfEZJ2PsbuRpg3la1N2RYM7GhlJRyaa4kJTbwq3pqBOkXLllg+eoRoZEbqR
 LB7WQ5whHc4I5NiJmkJ6QtDmA7+ZoKkE7c9HU+zWDVYsj9vcmP2GhQdrO+ofM12ZZVSS1I
 afccHI/onvRze300MLayvvAssBTm0cQ6LKI18/cYb6E2jrj2yiU3Muee3pdOWg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7W0AHP8AZH3BQuOg7VoSSLCGAt5cEG8orrbcrfWX60=;
 b=Y5iOwXjJvLjKCJ4xClU5VrtkN79vV+Mne+baDZ7QqYHjC0f+XSlmGHH8oJZpOkU8z3qikU
 HPiLlEnXadKXJN6xQ1ph0w8TQ02trMjBKrgS9IIaGvQ6NGGfTE6h+T8jNxGNTxwg4MyrXv
 27Dmy30S4RYx0mcItHzbNRP5cUj8r9ew/5PnhbzUk0d3eX915tgobOgf/rQXf1Hxe91+bh
 2kQQKebEM1PGDug3I99tbkqof2BwdzFwt7VHTffJ+1mR6XKxNMRz4hIbfLGYs+HGyYtl1z
 DpQYfGp0XPQXmFFg/rXR7464N4umkd+iDEGi5DpOH/28WkQHRiaM3+s+fFJRpw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] net: sh_eth: Switch back to mdio_alloc()
Date: Sun,  2 Mar 2025 02:24:49 +0100
Message-ID: <20250302012752.393608-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a80a5c050d705f3c75c
X-MBO-RS-META: afc9fb1kxkrzueg6bzig8zds1qjdrpe7
X-Rspamd-Queue-Id: 4Z548h2d18z9sSf
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

Fixes: 08eefb5e792d ("net: sh_eth: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks")
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
 drivers/net/sh_eth.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index c2e2f3fc6c6..f695a3a41d2 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -739,7 +739,6 @@ static int sh_ether_probe(struct udevice *udev)
 	struct eth_pdata *pdata = dev_get_plat(udev);
 	struct sh_ether_priv *priv = dev_get_priv(udev);
 	struct sh_eth_dev *eth = &priv->shdev;
-	struct bb_miiphy_bus *bb_miiphy;
 	struct mii_dev *mdiodev;
 	int ret;
 
@@ -750,14 +749,12 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		return ret;
 #endif
-	bb_miiphy = bb_miiphy_alloc();
-	if (!bb_miiphy) {
+	mdiodev = mdio_alloc();
+	if (!mdiodev) {
 		ret = -ENOMEM;
 		return ret;
 	}
 
-	mdiodev = &bb_miiphy->mii;
-
 	mdiodev->read = sh_eth_bb_miiphy_read;
 	mdiodev->write = sh_eth_bb_miiphy_write;
 	mdiodev->priv = eth;
@@ -767,7 +764,7 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	priv->bus = &bb_miiphy->mii;
+	priv->bus = mdiodev;
 
 	eth->port = CFG_SH_ETHER_USE_PORT;
 	eth->port_info[eth->port].phy_addr = CFG_SH_ETHER_PHY_ADDR;
@@ -797,7 +794,7 @@ err_phy_config:
 	clk_disable(&priv->clk);
 #endif
 err_mdio_register:
-	bb_miiphy_free(bb_miiphy);
+	mdio_free(mdiodev);
 	return ret;
 }
 
-- 
2.47.2

