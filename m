Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD9C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9945280F0A;
	Sun,  9 Feb 2025 13:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NpmO3+gH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="svdy+rQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 123F680ECB; Sun,  9 Feb 2025 13:05:34 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE72807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrRHH4kT6z9t27;
 Sun,  9 Feb 2025 13:05:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69gOEnElhEedPlEpXVhhYzu9P11jvwLUYX6UCkKGlEo=;
 b=NpmO3+gH8yzY2OH4BTPSdGlCMOz+2Fdmm9WPcZED/djgXBWnHFs7sWLD6VVFVYzdlDJNyD
 czcgpbC9J8hrn1XUwX56brb+sBNecIMTzYKYjzOSJaXiAptl2b6PMGLwrQjielC6sZ7wr0
 W5Ut9WUJQn8svGTveDGsS+nj71Zf4v9hE0Z+6HrJMp5giDJnLHZw08dFB5noVnX/V3tvzX
 WNmkcIf3X7sDqwgIExCpzKu7h2w2YPnayr0TmaHKRqhpqn+tKjTuXSENKpHmVJYbfBj4bh
 nIkc1pL3JG/ipaPTgRhQA23ZvW3lWzWbVlM+ACNu7w9aZbB+A7iyNmSOyMAuAA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69gOEnElhEedPlEpXVhhYzu9P11jvwLUYX6UCkKGlEo=;
 b=svdy+rQEoa3dX3e1vahaKHJgJcRoxsYTJ2/vxt/YBnVViTn+FGZGIlpAFWo8V66/q9a5Ef
 /N6E5N3NZ7dB+tG8aBiMEnlOexkJfQeZwgv+NpogAs5aYf2dA8+MJLqPq7QpF/x5MR0X06
 sn+HerKvbmtoWeQSDX6Sd1WleAtVR3NwnUob489tGdsJ2ZfRuZxxSyBt6eKiOyF79ADopO
 hlTWZa9VyPcrzTXthJesoxhAruLj3qmTGt1lIWj5o5BYnE8o7or1SmxY+QVxrZxKiO8eiW
 w9MV8q0lLk4r9+7K20NA4cAW2CdGPokev+jPByArWvTLnuU0J+xKkm97IiS32g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/24] net: miiphybb: Drop bb_miiphy_buses and
 bb_miiphy_buses_num
Date: Sun,  9 Feb 2025 13:01:50 +0100
Message-ID: <20250209120403.5321-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db1dfc36192ee108f7d
X-MBO-RS-META: zcsp6wsbwc67j4pun9ymrjxzcydmrw7u
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

Neither bb_miiphy_buses nor bb_miiphy_buses_num are used anymore.
Drop both of them.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Fold in recently added DWC bbmiiphy too
---
 board/gdsys/a38x/ihs_phys.c | 34 +---------------------------------
 drivers/net/designware.c    | 14 --------------
 drivers/net/ravb.c          | 13 -------------
 drivers/net/sh_eth.c        | 14 --------------
 include/miiphy.h            |  3 ---
 5 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 71c9398c77a..0c68087912a 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -289,7 +289,7 @@ int init_octo_phys(uint octo_phy_mask)
 	uint bus_idx;
 
 	/* there are up to four octo-phys on each mdio bus */
-	for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; ++bus_idx) {
+	for (bus_idx = 0; bus_idx < ARRAY_SIZE(gpio_mii_set); ++bus_idx) {
 		uint m;
 		uint octo_index = bus_idx * 4;
 		struct mii_dev *bus = NULL;
@@ -325,35 +325,3 @@ int init_octo_phys(uint octo_phy_mask)
 
 	return 0;
 }
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.mdio_active = mii_mdio_active,
-		.mdio_tristate = mii_mdio_tristate,
-		.set_mdio = mii_set_mdio,
-		.get_mdio = mii_get_mdio,
-		.set_mdc = mii_set_mdc,
-		.delay = mii_delay,
-		.priv = &gpio_mii_set[0],
-	},
-	{
-		.mdio_active = mii_mdio_active,
-		.mdio_tristate = mii_mdio_tristate,
-		.set_mdio = mii_set_mdio,
-		.get_mdio = mii_get_mdio,
-		.set_mdc = mii_set_mdc,
-		.delay = mii_delay,
-		.priv = &gpio_mii_set[1],
-	},
-	{
-		.mdio_active = mii_mdio_active,
-		.mdio_tristate = mii_mdio_tristate,
-		.set_mdio = mii_set_mdio,
-		.get_mdio = mii_get_mdio,
-		.set_mdc = mii_set_mdc,
-		.delay = mii_delay,
-		.priv = &gpio_mii_set[2],
-	},
-};
-
-int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a8405c20e22..f102ae9ede3 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -287,19 +287,6 @@ static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.mdio_active	= dw_eth_bb_mdio_active,
-		.mdio_tristate	= dw_eth_bb_mdio_tristate,
-		.set_mdio	= dw_eth_bb_set_mdio,
-		.get_mdio	= dw_eth_bb_get_mdio,
-		.set_mdc	= dw_eth_bb_set_mdc,
-		.delay		= dw_eth_bb_delay,
-	}
-};
-
-int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
-
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 {
 	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
@@ -334,7 +321,6 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 	dwpriv->bus = bus;
 	dwpriv->dev = dev;
 
-	bb_miiphy_buses[0].priv = dwpriv;
 	snprintf(bus->name, sizeof(bus->name), "%s", name);
 	bus->read = bb_miiphy_read;
 	bus->write = bb_miiphy_write;
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index b790de98b48..cb727ae9bc1 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -575,7 +575,6 @@ static int ravb_probe(struct udevice *dev)
 
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
-	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
@@ -631,18 +630,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.mdio_active	= ravb_bb_mdio_active,
-		.mdio_tristate	= ravb_bb_mdio_tristate,
-		.set_mdio	= ravb_bb_set_mdio,
-		.get_mdio	= ravb_bb_get_mdio,
-		.set_mdc	= ravb_bb_set_mdc,
-		.delay		= ravb_bb_delay,
-	},
-};
-int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
-
 static const struct eth_ops ravb_ops = {
 	.start			= ravb_start,
 	.send			= ravb_send,
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index b1e35aaf291..83e48609224 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -737,7 +737,6 @@ static int sh_ether_probe(struct udevice *udev)
 
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
-	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
@@ -853,16 +852,3 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 	.plat_auto	= sizeof(struct eth_pdata),
 	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
 };
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.mdio_active	= sh_eth_bb_mdio_active,
-		.mdio_tristate	= sh_eth_bb_mdio_tristate,
-		.set_mdio	= sh_eth_bb_set_mdio,
-		.get_mdio	= sh_eth_bb_get_mdio,
-		.set_mdc	= sh_eth_bb_set_mdc,
-		.delay		= sh_eth_bb_delay,
-	}
-};
-
-int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
diff --git a/include/miiphy.h b/include/miiphy.h
index efeff8ae70b..b879fd16ae3 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -75,9 +75,6 @@ struct bb_miiphy_bus {
 	struct mii_dev mii;
 };
 
-extern struct bb_miiphy_bus bb_miiphy_buses[];
-extern int bb_miiphy_buses_num;
-
 struct bb_miiphy_bus *bb_miiphy_alloc(void);
 void bb_miiphy_free(struct bb_miiphy_bus *bus);
 
-- 
2.47.2

