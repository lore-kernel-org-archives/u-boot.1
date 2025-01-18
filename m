Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265AAC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D888680755;
	Sat, 18 Jan 2025 07:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="flSFx6fk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XWr5K8SJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629B0807B9; Sat, 18 Jan 2025 07:54:49 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F2680759
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnQv00Cqz9sqH;
 Sat, 18 Jan 2025 07:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lg1K3cDB3VxCUGSWBDKqYr/8itU4Y6hAHHWvRjbafC8=;
 b=flSFx6fkuBnAqrV5YFUKf8WfsQW/tV/fETS23JY1OTO2VA3199bSBX0tL3ttpYIO25Mkxt
 mTNtwKLDSxriX1Igtkhw8FAVcCd655XK1SUJuSvkbOCMP8yRMfcerbns2MLTgCfOPVZYIt
 h3VXLnQSEfcTmV3rjg0O2A6x9fyjONmR55mYjbxmczEAOlURwqga3Pg4tTT1hPKLuhWnlN
 tNbNEu50E1uea0ltjgk49HzDE4IEk6utUBIlcJTfUNQE2bpUOzVFCbQt+bNbH845X0WZdx
 t8hT8EOU+FuNKGlhtrbfxM3X1KBX0X6toKFoT+Wiz7yxt8PolVPQ5Ddci0OSWw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lg1K3cDB3VxCUGSWBDKqYr/8itU4Y6hAHHWvRjbafC8=;
 b=XWr5K8SJvD2VAajAhrfge/5avjq3/VAtannLj0Ubi48QzINtFPo5eVfvk11m95ptU1gCGQ
 3IexC7ofhX2370o+ZGmBF1SDMq8AcmA6sz60zlPeGkzLLPXDrDKDrigKAPEWlKOuDqdbfS
 4X2YKiUcs78PDHW7pEf6taQkqqzT6k17bzvS8anLp3k+RGUFKGUIp3gLjOPAQbdrSax4o3
 SOXw6m8Nsakp3WDMmD/1V4DROm7gHBJp5fKrbS9ACEG7ELRDGYFTRiZLFYveTCH47+Uukl
 B4AfGL9JRoebQQ4/jXizLCHADxoN1oihP1e0XEhTaBsCzUisdH3yalKegE0Tsw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/17] net: miiphybb: Drop name field from struct bb_miiphy_bus
Date: Sat, 18 Jan 2025 07:53:14 +0100
Message-ID: <20250118065402.172253-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5cef3e7951b4a1f49b2
X-MBO-RS-META: b4mtpcfxgn4mdmr6s465bptwjzfz9iu1
X-Rspamd-Queue-Id: 4YZnQv00Cqz9sqH
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
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
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
 board/gdsys/a38x/ihs_phys.c | 11 +++--------
 drivers/net/ravb.c          |  6 +-----
 drivers/net/sh_eth.c        |  6 +-----
 include/miiphy.h            |  1 -
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index aa738016025..2b598abb7f0 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -223,18 +223,17 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
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
 	bb_miiphy->init = mii_mdio_init;
 	bb_miiphy->mdio_active = mii_mdio_active;
 	bb_miiphy->mdio_tristate = mii_mdio_tristate;
@@ -242,13 +241,12 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	bb_miiphy->get_mdio = mii_get_mdio;
 	bb_miiphy->set_mdc = mii_set_mdc;
 	bb_miiphy->delay = mii_delay;
-	strlcpy(bb_miiphy->name, name, MDIO_NAME_LEN);
 	bb_miiphy->priv = &(gpio_mii_set[k]);
 
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-	*bus = miiphy_get_dev_by_name(name);
+	*bus = miiphy_get_dev_by_name(mdiodev->name);
 
 	return 0;
 }
@@ -331,7 +329,6 @@ int init_octo_phys(uint octo_phy_mask)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name = "ihs0",
 		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
@@ -342,7 +339,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.priv = &gpio_mii_set[0],
 	},
 	{
-		.name = "ihs1",
 		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
@@ -353,7 +349,6 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 		.priv = &gpio_mii_set[1],
 	},
 	{
-		.name = "ihs2",
 		.init = mii_mdio_init,
 		.mdio_active = mii_mdio_active,
 		.mdio_tristate = mii_mdio_tristate,
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 60454d1a579..efcf176c6ad 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -578,7 +578,7 @@ static int ravb_probe(struct udevice *dev)
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = ravb_bb_mdio_active;
 	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
@@ -586,7 +586,6 @@ static int ravb_probe(struct udevice *dev)
 	bb_miiphy->get_mdio = ravb_bb_get_mdio;
 	bb_miiphy->set_mdc = ravb_bb_set_mdc;
 	bb_miiphy->delay = ravb_bb_delay;
-	strlcpy(bb_miiphy->name, "ravb", MDIO_NAME_LEN);
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
@@ -635,7 +634,6 @@ static int ravb_remove(struct udevice *dev)
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= "ravb",
 		.init		= NULL,
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
@@ -668,8 +666,6 @@ int ravb_of_to_plat(struct udevice *dev)
 
 	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 1000);
 
-	sprintf(bb_miiphy_buses[0].name, dev->name);
-
 	return 0;
 }
 
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index a765c280ff0..ccfb31d40fd 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -740,7 +740,7 @@ static int sh_ether_probe(struct udevice *udev)
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
-	/* Copy the bus accessors, name and private data */
+	/* Copy the bus accessors and private data */
 	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = sh_eth_bb_mdio_active;
 	bb_miiphy->mdio_tristate = sh_eth_bb_mdio_tristate;
@@ -748,7 +748,6 @@ static int sh_ether_probe(struct udevice *udev)
 	bb_miiphy->get_mdio = sh_eth_bb_get_mdio;
 	bb_miiphy->set_mdc = sh_eth_bb_set_mdc;
 	bb_miiphy->delay = sh_eth_bb_delay;
-	strlcpy(bb_miiphy->name, "sh_eth", MDIO_NAME_LEN);
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
@@ -830,8 +829,6 @@ int sh_ether_of_to_plat(struct udevice *dev)
 	if (cell)
 		pdata->max_speed = fdt32_to_cpu(*cell);
 
-	sprintf(bb_miiphy_buses[0].name, dev->name);
-
 	return 0;
 }
 
@@ -860,7 +857,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
-		.name		= "sh_eth",
 		.init		= NULL,
 		.mdio_active	= sh_eth_bb_mdio_active,
 		.mdio_tristate	= sh_eth_bb_mdio_tristate,
diff --git a/include/miiphy.h b/include/miiphy.h
index 962ace13079..03ae4e0078a 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -65,7 +65,6 @@ void mdio_list_devices(void);
 #define BB_MII_DEVNAME	"bb_miiphy"
 
 struct bb_miiphy_bus {
-	char name[MDIO_NAME_LEN];
 	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
-- 
2.45.2

