Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA3EC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E4D80EB0;
	Sun,  9 Feb 2025 13:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NBIEgzEP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DgZrYd1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811CA80EAF; Sun,  9 Feb 2025 13:05:24 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C46807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YrRH60GNnz9ssp;
 Sun,  9 Feb 2025 13:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdpihD+Ejp4bgfIZzcWeC4UK7QwM9TrwZcAh7MoZhHI=;
 b=NBIEgzEPNX74mJj5kjsoWMOSqU8UqhSCUuzE01Nt4hA8xYW7Vx2n2kbLwHE286pnLg/Qr7
 ARTscuZ1td+mMYSTAW2QxBTPydGDaQo9uCXolarBuWe/i4cnEE8ZxGUCi+sAh3oz6xE3RN
 6T3Re7OrwQkF3MVfccoG3WANmvfilXGHKdK55SW4J0jVzqU35osQyI13jxPjv86Q/oJ6ZP
 E8MmkKBMM25aFfom9LMBzPE2ARO94bQcauQhlL6+PlsK7Y6IdZ6OQbcRA1s4gDjuxc3k5X
 oYiHgUo+nFXfpM1gFOZMZ+DB0uQdEnvzrNMSay5kcLGiXfdnRvdfw6D5zjVpdA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdpihD+Ejp4bgfIZzcWeC4UK7QwM9TrwZcAh7MoZhHI=;
 b=DgZrYd1r3NgDTirOUjkZkATPSflJuS979uAhGfsaarWevnKlf4r4CZ7ptoVaonZSHYbhat
 vokDRSa/jGq/N8dMQgjzUltOAls/1ckIhNdLNIJ/6SrkI28QvLeVtFQ4Y/Qg7tCVNZyCPK
 1QqXjNJUraQtvwkLClvmFvqT9L2TRB3zH3ktdvgFJaaO0ZDRdJt33lgASUEe7YmYAPYo23
 lxiqnpSBmtdkXPqXU3REPMGZBpJYsi39fnA9cs9ZtTMQ6jLvzGRaJCHR47pYawRZyhy0SX
 QWn/GWHMppQ2SPFsw2/R8vCciitpfSJLJ4/YdOUOd3S8WlM+/4qwhpt+ulEh0g==
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
Subject: [PATCH v2 20/24] net: miiphybb: Drop name field from struct
 bb_miiphy_bus
Date: Sun,  9 Feb 2025 13:01:46 +0100
Message-ID: <20250209120403.5321-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5ca2dd01ceb2b304a43
X-MBO-RS-META: h445qik6mqepetbg8m9ctw7ijiwi14qc
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

The struct bb_miiphy_bus embeds struct struct mii_dev, which
already contains one copy of name field. Drop the duplicate
top level copy of name field.

The a38x code does static assignment of disparate names, use
snprintf(...) to fill in matching name in probe to avoid any
breakage.

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
 board/gdsys/a38x/ihs_phys.c | 11 +++--------
 drivers/net/designware.c    |  5 +----
 drivers/net/ravb.c          |  6 +-----
 drivers/net/sh_eth.c        |  6 +-----
 include/miiphy.h            |  1 -
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index a121898be52..128b1395243 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -223,31 +223,29 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
 	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
 	struct mii_dev *mdiodev;
-	char *name = bb_miiphy_buses[k].name;
 	int retval;
 
 	if (!bb_miiphy)
 		return -ENOMEM;
 
 	mdiodev = &bb_miiphy->mii;
-	strlcpy(mdiodev->name, name, MDIO_NAME_LEN);
+	snprintf(mdiodev->name, MDIO_NAME_LEN, "ihs%d", k);
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->mdio_active = mii_mdio_active;
 	bb_miiphy->mdio_tristate = mii_mdio_tristate;
 	bb_miiphy->set_mdio = mii_set_mdio;
 	bb_miiphy->get_mdio = mii_get_mdio;
 	bb_miiphy->set_mdc = mii_set_mdc;
 	bb_miiphy->delay = mii_delay;
-	strlcpy(bb_miiphy->name, name, MDIO_NAME_LEN);
 	bb_miiphy->priv = &gpio_mii_set[k];
 
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-	*bus = miiphy_get_dev_by_name(name);
+	*bus = miiphy_get_dev_by_name(mdiodev->name);
 
 	return mii_mdio_init(bb_miiphy);
 }
@@ -330,7 +328,6 @@ int init_octo_phys(uint octo_phy_mask)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name = "ihs0",
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
@@ -340,7 +337,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.priv = &gpio_mii_set[0],
 	},
 	{
-		.name = "ihs1",
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
@@ -350,7 +346,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.priv = &gpio_mii_set[1],
 	},
 	{
-		.name = "ihs2",
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
 		.set_mdio = mii_set_mdio,
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index ea3d1670997..a8405c20e22 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -289,7 +289,6 @@ static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= BB_MII_DEVNAME,
 		.mdio_active	= dw_eth_bb_mdio_active,
 		.mdio_tristate	= dw_eth_bb_mdio_tristate,
 		.set_mdio	= dw_eth_bb_set_mdio,
@@ -337,7 +336,6 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 
 	bb_miiphy_buses[0].priv = dwpriv;
 	snprintf(bus->name, sizeof(bus->name), "%s", name);
-	strlcpy(bb_miiphy_buses[0].name, bus->name, MDIO_NAME_LEN);
 	bus->read = bb_miiphy_read;
 	bus->write = bb_miiphy_write;
 #if CONFIG_IS_ENABLED(DM_GPIO)
@@ -345,14 +343,13 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 #endif
 	bus->priv = dwpriv;
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->mdio_active = dw_eth_bb_mdio_active;
 	bb_miiphy->mdio_tristate = dw_eth_bb_mdio_tristate;
 	bb_miiphy->set_mdio = dw_eth_bb_set_mdio;
 	bb_miiphy->get_mdio = dw_eth_bb_get_mdio;
 	bb_miiphy->set_mdc = dw_eth_bb_set_mdc;
 	bb_miiphy->delay = dw_eth_bb_delay;
-	strlcpy(bb_miiphy->name, bus->name, MDIO_NAME_LEN);
 
 	return mdio_register(bus);
 }
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 0018b694ec1..86787183488 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -578,14 +578,13 @@ static int ravb_probe(struct udevice *dev)
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->mdio_active = ravb_bb_mdio_active;
 	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
 	bb_miiphy->set_mdio = ravb_bb_set_mdio;
 	bb_miiphy->get_mdio = ravb_bb_get_mdio;
 	bb_miiphy->set_mdc = ravb_bb_set_mdc;
 	bb_miiphy->delay = ravb_bb_delay;
-	strlcpy(bb_miiphy->name, "ravb", MDIO_NAME_LEN);
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
@@ -634,7 +633,6 @@ static int ravb_remove(struct udevice *dev)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= "ravb",
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
 		.set_mdio	= ravb_bb_set_mdio,
@@ -666,8 +664,6 @@ int ravb_of_to_plat(struct udevice *dev)
 
 	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 1000);
 
-	sprintf(bb_miiphy_buses[0].name, dev->name);
-
 	return 0;
 }
 
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index e78d64d77c3..49065ebe717 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -740,14 +740,13 @@ static int sh_ether_probe(struct udevice *udev)
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->mdio_active = sh_eth_bb_mdio_active;
 	bb_miiphy->mdio_tristate = sh_eth_bb_mdio_tristate;
 	bb_miiphy->set_mdio = sh_eth_bb_set_mdio;
 	bb_miiphy->get_mdio = sh_eth_bb_get_mdio;
 	bb_miiphy->set_mdc = sh_eth_bb_set_mdc;
 	bb_miiphy->delay = sh_eth_bb_delay;
-	strlcpy(bb_miiphy->name, "sh_eth", MDIO_NAME_LEN);
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
@@ -829,8 +828,6 @@ int sh_ether_of_to_plat(struct udevice *dev)
 	if (cell)
 		pdata->max_speed = fdt32_to_cpu(*cell);
 
-	sprintf(bb_miiphy_buses[0].name, dev->name);
-
 	return 0;
 }
 
@@ -859,7 +856,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= "sh_eth",
 		.mdio_active	= sh_eth_bb_mdio_active,
 		.mdio_tristate	= sh_eth_bb_mdio_tristate,
 		.set_mdio	= sh_eth_bb_set_mdio,
diff --git a/include/miiphy.h b/include/miiphy.h
index 42300ee5386..efeff8ae70b 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -65,7 +65,6 @@ void mdio_list_devices(void);
 #define BB_MII_DEVNAME	"bb_miiphy"
 
 struct bb_miiphy_bus {
-	char name[MDIO_NAME_LEN];
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
 	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
-- 
2.47.2

