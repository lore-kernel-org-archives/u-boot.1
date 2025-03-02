Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83682C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E0681113;
	Sun,  2 Mar 2025 02:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v9s4QDwL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rj7MuEt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839A88118A; Sun,  2 Mar 2025 02:28:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4F98058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z548S50vkz9sv9;
 Sun,  2 Mar 2025 02:28:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fyvJtPn5y5PInGaZP+G4bb++rixkOhftREHoRyYftEI=;
 b=v9s4QDwL6NMV8DNZKHKbVSyUW0WGux87ck2XsJ8S8H5C+xLGIkJK023qlJ5WEcnSZ0utS1
 6bwzyzclYHm2TOc6ZlocLKZ6vbU0ASRzl9u4ukik0bHk+ClAf516JZBFKH3ouTQb6QayZp
 sRdfr1/dsoeMuV+DyVoi3njzK7hYGCJ8q8Ft2KqgTw4iy3IelxyXhKA3pNUk2yTgRDQ3P/
 TGvOvBECO7hsbtiCR+9FY+XsE5hL1kzEDF5e2zprbkIbabj3ZE7oOcBUhSfKQRnqcgx3CX
 2hIwLWuU6MWwFxWpUV2tekcY+SU+3x+i77LyNZRB6zxmi/VAnSQCPwr0woaTzA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fyvJtPn5y5PInGaZP+G4bb++rixkOhftREHoRyYftEI=;
 b=Rj7MuEt+Nignp/OAi9GPCSvcUEyZWKU8htoMZeJ5JHfuKuCbntQQ9VIzCBV0XN0ZwLfRl0
 8hw/GsjUqZfWkVJWK0GoGjbx+1xdhMO4r/QyZVf7nUXithPRVLsiJM6xN+lFsqeg/g0Rx2
 X3lj/CRComfEfcSOrYFXDbxWIpblYnitaJWZY7XFC90TlbJyXP4iLXmzKBkL0tfLtuhZPu
 8xH7i+Nnur0DNaiv0i1n9exk0pPb6P70A4OYonFAKwrzTMdBcG97IAj3aK8J+A/MsFVKLp
 W6i4uMSH25OTICE4zV93ntd0h4aqw4Q4VdTZbnim0RGN6OMtZYwgG4OpE4HO3A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] net: miiphybb: Split off struct bb_miiphy_bus_ops
Date: Sun,  2 Mar 2025 02:24:42 +0100
Message-ID: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1jhzrrzebneyddsemwd1zke1nck4gx7g
X-MBO-RS-ID: 5a5d97d7d3100f6f461
X-Rspamd-Queue-Id: 4Z548S50vkz9sv9
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

Move miiphybb operations into separate struct bb_miiphy_bus_ops
structure, add pointer to struct bb_miiphy_bus_ops into the base
struct bb_miiphy_bus and access the ops through this pointer in
miiphybb generic code. The variable reshuffling in miiphybb.c
cannot be easily avoided.

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
 board/gdsys/a38x/ihs_phys.c |  16 ++--
 drivers/net/designware.c    |  18 ++--
 drivers/net/phy/miiphybb.c  | 178 +++++++++++++++++++-----------------
 drivers/net/ravb.c          |  16 ++--
 drivers/net/sh_eth.c        |  16 ++--
 include/miiphy.h            |   8 +-
 6 files changed, 139 insertions(+), 113 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 0c68087912a..c999ab6d6fa 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -219,6 +219,15 @@ static int mii_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
+static const struct bb_miiphy_bus_ops mii_bb_miiphy_bus_ops = {
+	.mdio_active	= mii_mdio_active,
+	.mdio_tristate	= mii_mdio_tristate,
+	.set_mdio	= mii_set_mdio,
+	.get_mdio	= mii_get_mdio,
+	.set_mdc	= mii_set_mdc,
+	.delay		= mii_delay,
+};
+
 int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
 	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
@@ -234,12 +243,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	mdiodev->write = bb_miiphy_write;
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->mdio_active = mii_mdio_active;
-	bb_miiphy->mdio_tristate = mii_mdio_tristate;
-	bb_miiphy->set_mdio = mii_set_mdio;
-	bb_miiphy->get_mdio = mii_get_mdio;
-	bb_miiphy->set_mdc = mii_set_mdc;
-	bb_miiphy->delay = mii_delay;
+	bb_miiphy->ops = &mii_bb_miiphy_bus_ops;
 	bb_miiphy->priv = &gpio_mii_set[k];
 
 	retval = mdio_register(mdiodev);
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 5a6e89c0575..045bff476d1 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -290,6 +290,15 @@ static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
+static const struct bb_miiphy_bus_ops dw_eth_bb_miiphy_bus_ops = {
+	.mdio_active	= dw_eth_bb_mdio_active,
+	.mdio_tristate	= dw_eth_bb_mdio_tristate,
+	.set_mdio	= dw_eth_bb_set_mdio,
+	.get_mdio	= dw_eth_bb_get_mdio,
+	.set_mdc	= dw_eth_bb_set_mdc,
+	.delay		= dw_eth_bb_delay,
+};
+
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 {
 	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
@@ -330,16 +339,9 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	bus->reset = dw_mdio_reset;
 #endif
+	bus->ops = &dw_eth_bb_miiphy_bus_ops;
 	bus->priv = dwpriv;
 
-	/* Copy the bus accessors and private data */
-	bb_miiphy->mdio_active = dw_eth_bb_mdio_active;
-	bb_miiphy->mdio_tristate = dw_eth_bb_mdio_tristate;
-	bb_miiphy->set_mdio = dw_eth_bb_set_mdio;
-	bb_miiphy->get_mdio = dw_eth_bb_get_mdio;
-	bb_miiphy->set_mdc = dw_eth_bb_set_mdc;
-	bb_miiphy->delay = dw_eth_bb_delay;
-
 	return mdio_register(bus);
 }
 #endif
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 553af2c1032..e6106341eb3 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -46,8 +46,8 @@ void bb_miiphy_free(struct bb_miiphy_bus *bus)
  * Utility to send the preamble, address, and register (common to read
  * and write).
  */
-static void miiphy_pre(struct bb_miiphy_bus *bus, char read,
-		       unsigned char addr, unsigned char reg)
+static void miiphy_pre(struct bb_miiphy_bus *bus, const struct bb_miiphy_bus_ops *ops,
+		       char read, unsigned char addr, unsigned char reg)
 {
 	int j;
 
@@ -59,62 +59,62 @@ static void miiphy_pre(struct bb_miiphy_bus *bus, char read,
 	 * but it is safer and will be much more robust.
 	 */
 
-	bus->mdio_active(bus);
-	bus->set_mdio(bus, 1);
+	ops->mdio_active(bus);
+	ops->set_mdio(bus, 1);
 	for (j = 0; j < 32; j++) {
-		bus->set_mdc(bus, 0);
-		bus->delay(bus);
-		bus->set_mdc(bus, 1);
-		bus->delay(bus);
+		ops->set_mdc(bus, 0);
+		ops->delay(bus);
+		ops->set_mdc(bus, 1);
+		ops->delay(bus);
 	}
 
 	/* send the start bit (01) and the read opcode (10) or write (10) */
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, 0);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, read);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, !read);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, 0);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, read);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, !read);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
 
 	/* send the PHY address */
 	for (j = 0; j < 5; j++) {
-		bus->set_mdc(bus, 0);
+		ops->set_mdc(bus, 0);
 		if ((addr & 0x10) == 0) {
-			bus->set_mdio(bus, 0);
+			ops->set_mdio(bus, 0);
 		} else {
-			bus->set_mdio(bus, 1);
+			ops->set_mdio(bus, 1);
 		}
-		bus->delay(bus);
-		bus->set_mdc(bus, 1);
-		bus->delay(bus);
+		ops->delay(bus);
+		ops->set_mdc(bus, 1);
+		ops->delay(bus);
 		addr <<= 1;
 	}
 
 	/* send the register address */
 	for (j = 0; j < 5; j++) {
-		bus->set_mdc(bus, 0);
+		ops->set_mdc(bus, 0);
 		if ((reg & 0x10) == 0) {
-			bus->set_mdio(bus, 0);
+			ops->set_mdio(bus, 0);
 		} else {
-			bus->set_mdio(bus, 1);
+			ops->set_mdio(bus, 1);
 		}
-		bus->delay(bus);
-		bus->set_mdc(bus, 1);
-		bus->delay(bus);
+		ops->delay(bus);
+		ops->set_mdc(bus, 1);
+		ops->delay(bus);
 		reg <<= 1;
 	}
 }
@@ -132,56 +132,59 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	int v;
 	int j; /* counter */
 	struct bb_miiphy_bus *bus;
+	const struct bb_miiphy_bus_ops *ops;
 
 	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		return -1;
 	}
 
-	miiphy_pre (bus, 1, addr, reg);
+	ops = bus->ops;
+
+	miiphy_pre(bus, ops, 1, addr, reg);
 
 	/* tri-state our MDIO I/O pin so we can read */
-	bus->set_mdc(bus, 0);
-	bus->mdio_tristate(bus);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->mdio_tristate(bus);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
 
 	/* check the turnaround bit: the PHY should be driving it to zero */
-	bus->get_mdio(bus, &v);
+	ops->get_mdio(bus, &v);
 	if (v != 0) {
 		/* puts ("PHY didn't drive TA low\n"); */
 		for (j = 0; j < 32; j++) {
-			bus->set_mdc(bus, 0);
-			bus->delay(bus);
-			bus->set_mdc(bus, 1);
-			bus->delay(bus);
+			ops->set_mdc(bus, 0);
+			ops->delay(bus);
+			ops->set_mdc(bus, 1);
+			ops->delay(bus);
 		}
 		/* There is no PHY, return */
 		return -1;
 	}
 
-	bus->set_mdc(bus, 0);
-	bus->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->delay(bus);
 
 	/* read 16 bits of register data, MSB first */
 	rdreg = 0;
 	for (j = 0; j < 16; j++) {
-		bus->set_mdc(bus, 1);
-		bus->delay(bus);
+		ops->set_mdc(bus, 1);
+		ops->delay(bus);
 		rdreg <<= 1;
-		bus->get_mdio(bus, &v);
+		ops->get_mdio(bus, &v);
 		rdreg |= (v & 0x1);
-		bus->set_mdc(bus, 0);
-		bus->delay(bus);
+		ops->set_mdc(bus, 0);
+		ops->delay(bus);
 	}
 
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 0);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
 
 	debug("%s[%s](0x%x) @ 0x%x = 0x%04x\n", __func__, miidev->name, reg, addr, rdreg);
 
@@ -199,6 +202,7 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		    u16 value)
 {
 	struct bb_miiphy_bus *bus;
+	const struct bb_miiphy_bus_ops *ops;
 	int j;			/* counter */
 
 	bus = bb_miiphy_getbus(miidev);
@@ -207,42 +211,44 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		return -1;
 	}
 
-	miiphy_pre (bus, 0, addr, reg);
+	ops = bus->ops;
+
+	miiphy_pre(bus, ops, 0, addr, reg);
 
 	/* send the turnaround (10) */
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
-	bus->set_mdc(bus, 0);
-	bus->set_mdio(bus, 0);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
+	ops->set_mdc(bus, 0);
+	ops->set_mdio(bus, 0);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
 
 	/* write 16 bits of register data, MSB first */
 	for (j = 0; j < 16; j++) {
-		bus->set_mdc(bus, 0);
+		ops->set_mdc(bus, 0);
 		if ((value & 0x00008000) == 0) {
-			bus->set_mdio(bus, 0);
+			ops->set_mdio(bus, 0);
 		} else {
-			bus->set_mdio(bus, 1);
+			ops->set_mdio(bus, 1);
 		}
-		bus->delay(bus);
-		bus->set_mdc(bus, 1);
-		bus->delay(bus);
+		ops->delay(bus);
+		ops->set_mdc(bus, 1);
+		ops->delay(bus);
 		value <<= 1;
 	}
 
 	/*
 	 * Tri-state the MDIO line.
 	 */
-	bus->mdio_tristate(bus);
-	bus->set_mdc(bus, 0);
-	bus->delay(bus);
-	bus->set_mdc(bus, 1);
-	bus->delay(bus);
+	ops->mdio_tristate(bus);
+	ops->set_mdc(bus, 0);
+	ops->delay(bus);
+	ops->set_mdc(bus, 1);
+	ops->delay(bus);
 
 	return 0;
 }
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index cb727ae9bc1..bd4900270a2 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -549,6 +549,15 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
+static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
+	.mdio_active	= ravb_bb_mdio_active,
+	.mdio_tristate	= ravb_bb_mdio_tristate,
+	.set_mdio	= ravb_bb_set_mdio,
+	.get_mdio	= ravb_bb_get_mdio,
+	.set_mdc	= ravb_bb_set_mdc,
+	.delay		= ravb_bb_delay,
+};
+
 static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
@@ -578,12 +587,7 @@ static int ravb_probe(struct udevice *dev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->mdio_active = ravb_bb_mdio_active;
-	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
-	bb_miiphy->set_mdio = ravb_bb_set_mdio;
-	bb_miiphy->get_mdio = ravb_bb_get_mdio;
-	bb_miiphy->set_mdc = ravb_bb_set_mdc;
-	bb_miiphy->delay = ravb_bb_delay;
+	bb_miiphy->ops = &ravb_bb_miiphy_bus_ops;
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 83e48609224..0693c240fbd 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -711,6 +711,15 @@ static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
+static const struct bb_miiphy_bus_ops sh_ether_bb_miiphy_bus_ops = {
+	.mdio_active	= sh_eth_bb_mdio_active,
+	.mdio_tristate	= sh_eth_bb_mdio_tristate,
+	.set_mdio	= sh_eth_bb_set_mdio,
+	.get_mdio	= sh_eth_bb_get_mdio,
+	.set_mdc	= sh_eth_bb_set_mdc,
+	.delay		= sh_eth_bb_delay,
+};
+
 static int sh_ether_probe(struct udevice *udev)
 {
 	struct eth_pdata *pdata = dev_get_plat(udev);
@@ -740,12 +749,7 @@ static int sh_ether_probe(struct udevice *udev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->mdio_active = sh_eth_bb_mdio_active;
-	bb_miiphy->mdio_tristate = sh_eth_bb_mdio_tristate;
-	bb_miiphy->set_mdio = sh_eth_bb_set_mdio;
-	bb_miiphy->get_mdio = sh_eth_bb_get_mdio;
-	bb_miiphy->set_mdc = sh_eth_bb_set_mdc;
-	bb_miiphy->delay = sh_eth_bb_delay;
+	bb_miiphy->ops = &sh_ether_bb_miiphy_bus_ops;
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
diff --git a/include/miiphy.h b/include/miiphy.h
index b879fd16ae3..28d7296e6ae 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -64,14 +64,20 @@ void mdio_list_devices(void);
 
 #define BB_MII_DEVNAME	"bb_miiphy"
 
-struct bb_miiphy_bus {
+struct bb_miiphy_bus;
+
+struct bb_miiphy_bus_ops {
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
 	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
 	int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
 	int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
 	int (*delay)(struct bb_miiphy_bus *bus);
+};
+
+struct bb_miiphy_bus {
 	void *priv;
+	const struct bb_miiphy_bus_ops *ops;
 	struct mii_dev mii;
 };
 
-- 
2.47.2

