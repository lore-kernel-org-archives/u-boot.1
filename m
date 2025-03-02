Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0143C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A932811E0;
	Sun,  2 Mar 2025 02:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IogJvb8J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xkJIywG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5A0811DF; Sun,  2 Mar 2025 02:28:31 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14335806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z548X5lkfz9sQb;
 Sun,  2 Mar 2025 02:28:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+7F94fGyDUnkKFQ5nto0jyQptdB9DW7XvqvCjZmnTE=;
 b=IogJvb8Jtz3a1Vtw1KvW3xbyvTymSmb6HURzKpMl32w4dScbHr0qzUZGiaQLBflWYB+8wU
 tVm9oJhJ8wj7/vXK28XZNooe9qsUaqlN//7l8MNksddc237B7/RiW7CIOrbmKtIkcE07xg
 bEQSkWTGRJLc4OO78dK7rnbwXQpnt3dIoAIv6SMu7Jqv4IOQkeTdcB1rYleCh7lvZfzN8C
 MXHROCQU/tt3YTedVMJXzXbo0+Vt1++4W2qn4aha/tbyR4iowwaZRcDD+FaTkbFFx/o9FW
 26QGDaE/5EBNY9/QBXC/Wzf6XDervR4juFbQWKzNU2sJwXmdK6l+SQBTtb6Rxw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+7F94fGyDUnkKFQ5nto0jyQptdB9DW7XvqvCjZmnTE=;
 b=xkJIywG/vElGV2h/ilq5FlevgeqxGr3mwstlJa8L3/IJyukB97cXCo9WljmlCV5QDG0sEz
 AYeZNTX45hgOU04S+eTI4ANtJhQJ8y8hIWexapMli829BpzOfhG1fXcG+XXzV1SKrW4BlO
 41stbC8bRHGJJvyFKkuGvD4I/HG2HT67pgU7w9JOWQOckqyAcixHEykm5rv7ZDfhrxnGbS
 tqCnVAjda7H+WudN55em8aqkwn8mMBOC8BRNeiU87L2BVlPrzCfhBScDqvK5eVTO+T0ttC
 2jDGV7VBgCMiB/MTmDwG+IGNYWteI9/0CSwmCUr1NqxOhTVmsCvXf0895VE7EQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] net: miiphybb: Pass struct bb_miiphy_bus_ops directly
 to bb_miiphy_read/write()
Date: Sun,  2 Mar 2025 02:24:44 +0100
Message-ID: <20250302012752.393608-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yut9wu6ay1ab1ac5nxcckwt6dp8ff94c
X-MBO-RS-ID: 4388b8b89efe9c74ce2
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

The access to struct bb_miiphy_bus_ops via ops pointer in
struct bb_miiphy_bus is not necessary with wrappers added
in previous patch. Pass the ops pointer directly to both
bb_miiphy_read() and bb_miiphy_write() functions.

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
 board/gdsys/a38x/ihs_phys.c |  7 ++++---
 drivers/net/designware.c    |  7 ++++---
 drivers/net/phy/miiphybb.c  | 13 ++++---------
 drivers/net/ravb.c          |  7 ++++---
 drivers/net/sh_eth.c        |  7 ++++---
 include/miiphy.h            |  8 ++++----
 6 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 304b5b5f0bc..6176a47cda0 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -231,13 +231,15 @@ static const struct bb_miiphy_bus_ops mii_bb_miiphy_bus_ops = {
 static int mii_bb_miiphy_read(struct mii_dev *miidev, int addr,
 			      int devad, int reg)
 {
-	return bb_miiphy_read(miidev, addr, devad, reg);
+	return bb_miiphy_read(miidev, &mii_bb_miiphy_bus_ops,
+			      addr, devad, reg);
 }
 
 static int mii_bb_miiphy_write(struct mii_dev *miidev, int addr,
 			       int devad, int reg, u16 value)
 {
-	return bb_miiphy_write(miidev, addr, devad, reg, value);
+	return bb_miiphy_write(miidev, &mii_bb_miiphy_bus_ops,
+			       addr, devad, reg, value);
 }
 
 int register_miiphy_bus(uint k, struct mii_dev **bus)
@@ -255,7 +257,6 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	mdiodev->write = mii_bb_miiphy_write;
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->ops = &mii_bb_miiphy_bus_ops;
 	bb_miiphy->priv = &gpio_mii_set[k];
 
 	retval = mdio_register(mdiodev);
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 3c3450aa778..2069e34be15 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -302,13 +302,15 @@ static const struct bb_miiphy_bus_ops dw_eth_bb_miiphy_bus_ops = {
 static int dw_bb_miiphy_read(struct mii_dev *miidev, int addr,
 			     int devad, int reg)
 {
-	return bb_miiphy_read(miidev, addr, devad, reg);
+	return bb_miiphy_read(miidev, &dw_eth_bb_miiphy_bus_ops,
+			      addr, devad, reg);
 }
 
 static int dw_bb_miiphy_write(struct mii_dev *miidev, int addr,
 			      int devad, int reg, u16 value)
 {
-	return bb_miiphy_write(miidev, addr, devad, reg, value);
+	return bb_miiphy_write(miidev, &dw_eth_bb_miiphy_bus_ops,
+			       addr, devad, reg, value);
 }
 
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
@@ -351,7 +353,6 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	bus->reset = dw_mdio_reset;
 #endif
-	bus->ops = &dw_eth_bb_miiphy_bus_ops;
 	bus->priv = dwpriv;
 
 	return mdio_register(bus);
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index e6106341eb3..9481ba76f51 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -126,21 +126,19 @@ static void miiphy_pre(struct bb_miiphy_bus *bus, const struct bb_miiphy_bus_ops
  * Returns:
  *   0 on success
  */
-int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
+int bb_miiphy_read(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
+		   int addr, int devad, int reg)
 {
 	unsigned short rdreg; /* register working value */
 	int v;
 	int j; /* counter */
 	struct bb_miiphy_bus *bus;
-	const struct bb_miiphy_bus_ops *ops;
 
 	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		return -1;
 	}
 
-	ops = bus->ops;
-
 	miiphy_pre(bus, ops, 1, addr, reg);
 
 	/* tri-state our MDIO I/O pin so we can read */
@@ -198,11 +196,10 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
  * Returns:
  *   0 on success
  */
-int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
-		    u16 value)
+int bb_miiphy_write(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
+		    int addr, int devad, int reg, u16 value)
 {
 	struct bb_miiphy_bus *bus;
-	const struct bb_miiphy_bus_ops *ops;
 	int j;			/* counter */
 
 	bus = bb_miiphy_getbus(miidev);
@@ -211,8 +208,6 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		return -1;
 	}
 
-	ops = bus->ops;
-
 	miiphy_pre(bus, ops, 0, addr, reg);
 
 	/* send the turnaround (10) */
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 9a17ac97cce..65ba107fc00 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -561,13 +561,15 @@ static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
 static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
 			       int devad, int reg)
 {
-	return bb_miiphy_read(miidev, addr, devad, reg);
+	return bb_miiphy_read(miidev, &ravb_bb_miiphy_bus_ops,
+			      addr, devad, reg);
 }
 
 static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
 				int devad, int reg, u16 value)
 {
-	return bb_miiphy_write(miidev, addr, devad, reg, value);
+	return bb_miiphy_write(miidev, &ravb_bb_miiphy_bus_ops,
+			       addr, devad, reg, value);
 }
 
 static int ravb_probe(struct udevice *dev)
@@ -599,7 +601,6 @@ static int ravb_probe(struct udevice *dev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->ops = &ravb_bb_miiphy_bus_ops;
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index cef531c8c6f..738dc43cdc7 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -723,13 +723,15 @@ static const struct bb_miiphy_bus_ops sh_ether_bb_miiphy_bus_ops = {
 static int sh_eth_bb_miiphy_read(struct mii_dev *miidev, int addr,
 				 int devad, int reg)
 {
-	return bb_miiphy_read(miidev, addr, devad, reg);
+	return bb_miiphy_read(miidev, &sh_ether_bb_miiphy_bus_ops,
+			      addr, devad, reg);
 }
 
 static int sh_eth_bb_miiphy_write(struct mii_dev *miidev, int addr,
 				  int devad, int reg, u16 value)
 {
-	return bb_miiphy_write(miidev, addr, devad, reg, value);
+	return bb_miiphy_write(miidev, &sh_ether_bb_miiphy_bus_ops,
+			       addr, devad, reg, value);
 }
 
 static int sh_ether_probe(struct udevice *udev)
@@ -761,7 +763,6 @@ static int sh_ether_probe(struct udevice *udev)
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->ops = &sh_ether_bb_miiphy_bus_ops;
 	bb_miiphy->priv = eth;
 
 	ret = mdio_register(mdiodev);
diff --git a/include/miiphy.h b/include/miiphy.h
index 28d7296e6ae..f0163b3f29e 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -77,16 +77,16 @@ struct bb_miiphy_bus_ops {
 
 struct bb_miiphy_bus {
 	void *priv;
-	const struct bb_miiphy_bus_ops *ops;
 	struct mii_dev mii;
 };
 
 struct bb_miiphy_bus *bb_miiphy_alloc(void);
 void bb_miiphy_free(struct bb_miiphy_bus *bus);
 
-int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg);
-int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
-		    u16 value);
+int bb_miiphy_read(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
+		   int addr, int devad, int reg);
+int bb_miiphy_write(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
+		    int addr, int devad, int reg, u16 value);
 #endif
 
 /* phy seed setup */
-- 
2.47.2

