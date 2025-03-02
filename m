Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51146C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B1E81219;
	Sun,  2 Mar 2025 02:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x/Ovqf79";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fRtsrS1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF53E811CE; Sun,  2 Mar 2025 02:28:39 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC5A8129B
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z548f6zJZz9sJG;
 Sun,  2 Mar 2025 02:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOVWCurityuxfT/3PGtR/tVme/x6yHoCIL0RUgtxctc=;
 b=x/Ovqf79XxAFv+8TrZ3FUqbMRl1f5CNA1BpwvgelZ/RzWqx0efOAt8gGYbESev61YtNNKz
 T7DlGvc9MW1lLv7LhZHyMnBXtWeeBcUO93DHZjnKft5WdYctgLw6FhE5XE0CEJr7uF8/LJ
 1bs/tAEt9e3+7GrQLsclRcyUrEEq4dpghlftoFQaSWGB6r6o0O3r4xTUCo38WV/kelUH6v
 TE+0F7EyB0MpZXrsCMpUwwaqNBqkJCOHBGAIzPH154BHwhdebMwFWwEIXaU6luCLsAq9JA
 FKH4Q5mAMATeQJqWNecD3DEE4yCdsjzKfPIilEVJyM+8FRZKh6oM4eHq18yK0w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOVWCurityuxfT/3PGtR/tVme/x6yHoCIL0RUgtxctc=;
 b=fRtsrS1NX9C4c/v3IIuYKgtaJrQe+HQWcPcd+kjF87YeCHuPuJ/xYRp/KZwcviqJIY2sLm
 x8wq2uaXMZrYDT7JIu+0DNCSb77HX8kc7O7v3uQXtNrWjVFuz6wCJ76t5yUv/IvdQuSbPV
 IP7Qq95t0zXx5FVr3aU8TKR9+pc2KodiPR0KaZtRnD/3LEcHEStXD4WH/iihqWXgtKjHfU
 h8cyyQlzezCfiFLOErj0I0WlzpYxTB41bgCU+0jViVf0S5J4+mrPDaTAR5TJYtMM+CQXiS
 nPchOt1sTia4PeIU9Nn77mHB+cule8O2sLLg10VePAIhNRlQ0vmyQmPwc3yekg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] net: ravb: Switch back to mdio_alloc()
Date: Sun,  2 Mar 2025 02:24:48 +0100
Message-ID: <20250302012752.393608-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dwkmb3i3u7gnwrztwhgbty93hr5knkt5
X-MBO-RS-ID: 870218f975c470b7b32
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

Fixes: 079eaca6e7b4 ("net: ravb: Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks")
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
 drivers/net/ravb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index dcd8ba9283f..6129929568a 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -576,7 +576,6 @@ static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
-	struct bb_miiphy_bus *bb_miiphy;
 	struct mii_dev *mdiodev;
 	void __iomem *iobase;
 	int ret;
@@ -588,14 +587,12 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_alloc;
 
-	bb_miiphy = bb_miiphy_alloc();
-	if (!bb_miiphy) {
+	mdiodev = mdio_alloc();
+	if (!mdiodev) {
 		ret = -ENOMEM;
 		goto err_mdio_alloc;
 	}
 
-	mdiodev = &bb_miiphy->mii;
-
 	mdiodev->read = ravb_bb_miiphy_read;
 	mdiodev->write = ravb_bb_miiphy_write;
 	mdiodev->priv = eth;
@@ -605,7 +602,7 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	eth->bus = &bb_miiphy->mii;
+	eth->bus = mdiodev;
 
 	/* Bring up PHY */
 	ret = clk_enable_bulk(&eth->clks);
@@ -625,7 +622,7 @@ static int ravb_probe(struct udevice *dev)
 err_mdio_reset:
 	clk_release_bulk(&eth->clks);
 err_mdio_register:
-	bb_miiphy_free(bb_miiphy);
+	mdio_free(mdiodev);
 err_mdio_alloc:
 	unmap_physmem(eth->iobase, MAP_NOCACHE);
 	return ret;
-- 
2.47.2

