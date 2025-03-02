Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2F3C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DB4812BB;
	Sun,  2 Mar 2025 02:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ItWCzI8E";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gkha+H+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109EA811DF; Sun,  2 Mar 2025 02:28:35 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E460B811CE
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z548Z3vWDz9sSm;
 Sun,  2 Mar 2025 02:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+RXjrmgstRPJBwXDvYpy5yg/8dmfnTlLCuankdAfbs=;
 b=ItWCzI8EuDr6t/Y9AXjZIKG2hYex10BGdUTv6WeLPYziEg1HKFWeu+2gjF6EN1BAozGcsx
 VqUgG5O1s/CsE4WmZUyk/NRVyNCI43ICzeDW2tFOC6fzHs6KGOWOg58Ipgyac+CNsj6nuw
 q9q0ypcUDzKQTalQwNKBUqSUjY8DHd+figILg8A3UwvkG/xsuMQvb6vnh6t+i6IYkG+afM
 7i2CBKrvi9lFtQqSw78+N0xxb18penOQyKT31rORPYTqv6fL74TyeCW+EQD+wpfGfAf/V1
 GyDfBiT8VV1nh7szoGXQA9zqL8LMN6PXlIPfVnWTqH7h+wEaURqhlguzGr2Ajw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+RXjrmgstRPJBwXDvYpy5yg/8dmfnTlLCuankdAfbs=;
 b=gkha+H+lN2YBy1kuyXzly2A/HICAvMdgA2OB1KgnCcyJUinb2ml8OqDZ1/unhksDzQrLz5
 vpV7CcY7BtfoFGV5tDB/Z475WJ0RWzzilA2Qvf/s4zal5fOKIOmO0uGArVGewVBYvQgccv
 Qz1TBBFwgbsVEmLZAtt29qBaxDVmNHAV1A8Em2UByvCaCs3isfrcp22hVHApuYDe5yCTu/
 iAw+iCxaQAF/quH2nYw6eb0hXkMP+KQWX+sa8r7Os6jqy4Ej6ydLoM7UWZ6cDiYEIlyoWI
 PRaCKylokqOsnEY/b7qV2rMm9SvBYTgaU7P25k3SYxyoGfz3ET1SffiqkJaTGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] net: miiphybb: Pass struct mii_dev directly to
 bb_miiphy_read/write()
Date: Sun,  2 Mar 2025 02:24:45 +0100
Message-ID: <20250302012752.393608-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 90a904de88a2deb4bbb
X-MBO-RS-META: ghbxn99eqr9mxaq51q9cy4gttmqb4jph
X-Rspamd-Queue-Id: 4Z548Z3vWDz9sSm
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

Access to MDIO bus private data can be provided by both
struct mii_dev .priv member and struct bb_miiphy_bus .priv
member, use the former directly and remove .priv from the
later. Drop unused bb_miiphy_getbus(). This removes any
dependency on struct bb_miiphy_bus from the miiphybb code,
except for helper functions which will be removed later.

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
 board/gdsys/a38x/ihs_phys.c |  29 +++---
 drivers/net/designware.c    |  24 ++---
 drivers/net/phy/miiphybb.c  | 188 ++++++++++++++++--------------------
 drivers/net/ravb.c          |  23 ++---
 drivers/net/sh_eth.c        |  23 ++---
 include/miiphy.h            |  12 +--
 6 files changed, 142 insertions(+), 157 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 6176a47cda0..86a4049238b 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -123,9 +123,9 @@ struct gpio_mii {
 	{ 2, {}, {}, 46, 24, 1 },
 };
 
-static int mii_mdio_init(struct bb_miiphy_bus *bus)
+static int mii_mdio_init(const int k)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = &gpio_mii_set[k];
 	char name[32] = {};
 	struct udevice *gpio_dev1 = NULL;
 	struct udevice *gpio_dev2 = NULL;
@@ -164,27 +164,27 @@ static int mii_mdio_init(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-static int mii_mdio_active(struct bb_miiphy_bus *bus)
+static int mii_mdio_active(struct mii_dev *miidev)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = miidev->priv;
 
 	dm_gpio_set_value(&gpio_mii->mdc_gpio, gpio_mii->mdio_value);
 
 	return 0;
 }
 
-static int mii_mdio_tristate(struct bb_miiphy_bus *bus)
+static int mii_mdio_tristate(struct mii_dev *miidev)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = miidev->priv;
 
 	dm_gpio_set_dir_flags(&gpio_mii->mdio_gpio, GPIOD_IS_IN);
 
 	return 0;
 }
 
-static int mii_set_mdio(struct bb_miiphy_bus *bus, int v)
+static int mii_set_mdio(struct mii_dev *miidev, int v)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = miidev->priv;
 
 	dm_gpio_set_dir_flags(&gpio_mii->mdio_gpio, GPIOD_IS_OUT);
 	dm_gpio_set_value(&gpio_mii->mdio_gpio, v);
@@ -193,9 +193,9 @@ static int mii_set_mdio(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int mii_get_mdio(struct bb_miiphy_bus *bus, int *v)
+static int mii_get_mdio(struct mii_dev *miidev, int *v)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = miidev->priv;
 
 	dm_gpio_set_dir_flags(&gpio_mii->mdio_gpio, GPIOD_IS_IN);
 	*v = (dm_gpio_get_value(&gpio_mii->mdio_gpio));
@@ -203,16 +203,16 @@ static int mii_get_mdio(struct bb_miiphy_bus *bus, int *v)
 	return 0;
 }
 
-static int mii_set_mdc(struct bb_miiphy_bus *bus, int v)
+static int mii_set_mdc(struct mii_dev *miidev, int v)
 {
-	struct gpio_mii *gpio_mii = bus->priv;
+	struct gpio_mii *gpio_mii = miidev->priv;
 
 	dm_gpio_set_value(&gpio_mii->mdc_gpio, v);
 
 	return 0;
 }
 
-static int mii_delay(struct bb_miiphy_bus *bus)
+static int mii_delay(struct mii_dev *miidev)
 {
 	udelay(1);
 
@@ -255,6 +255,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	snprintf(mdiodev->name, MDIO_NAME_LEN, "ihs%d", k);
 	mdiodev->read = mii_bb_miiphy_read;
 	mdiodev->write = mii_bb_miiphy_write;
+	mdiodev->priv = &gpio_mii_set[k];
 
 	/* Copy the bus accessors and private data */
 	bb_miiphy->priv = &gpio_mii_set[k];
@@ -264,7 +265,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 		return retval;
 	*bus = &bb_miiphy->mii;
 
-	return mii_mdio_init(bb_miiphy);
+	return mii_mdio_init(k);
 }
 
 struct porttype *get_porttype(uint octo_phy_mask, uint k)
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 2069e34be15..4827811dce3 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -227,9 +227,9 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 #endif
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
-static int dw_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+static int dw_eth_bb_mdio_active(struct mii_dev *miidev)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 	struct gpio_desc *desc = &priv->mdio_gpio;
 
 	desc->flags = 0;
@@ -238,9 +238,9 @@ static int dw_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-static int dw_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+static int dw_eth_bb_mdio_tristate(struct mii_dev *miidev)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 	struct gpio_desc *desc = &priv->mdio_gpio;
 
 	desc->flags = 0;
@@ -249,9 +249,9 @@ static int dw_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-static int dw_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+static int dw_eth_bb_set_mdio(struct mii_dev *miidev, int v)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 
 	if (v)
 		dm_gpio_set_value(&priv->mdio_gpio, 1);
@@ -261,18 +261,18 @@ static int dw_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int dw_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+static int dw_eth_bb_get_mdio(struct mii_dev *miidev, int *v)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 
 	*v = dm_gpio_get_value(&priv->mdio_gpio);
 
 	return 0;
 }
 
-static int dw_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+static int dw_eth_bb_set_mdc(struct mii_dev *miidev, int v)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 
 	if (v)
 		dm_gpio_set_value(&priv->mdc_gpio, 1);
@@ -282,9 +282,9 @@ static int dw_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
+static int dw_eth_bb_delay(struct mii_dev *miidev)
 {
-	struct dw_eth_dev *priv = bus->priv;
+	struct dw_eth_dev *priv = miidev->priv;
 
 	udelay(priv->bb_delay);
 	return 0;
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 9481ba76f51..60c791b707b 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -18,11 +18,6 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-static inline struct bb_miiphy_bus *bb_miiphy_getbus(struct mii_dev *miidev)
-{
-	return container_of(miidev, struct bb_miiphy_bus, mii);
-}
-
 struct bb_miiphy_bus *bb_miiphy_alloc(void)
 {
 	struct bb_miiphy_bus *bus;
@@ -46,7 +41,7 @@ void bb_miiphy_free(struct bb_miiphy_bus *bus)
  * Utility to send the preamble, address, and register (common to read
  * and write).
  */
-static void miiphy_pre(struct bb_miiphy_bus *bus, const struct bb_miiphy_bus_ops *ops,
+static void miiphy_pre(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
 		       char read, unsigned char addr, unsigned char reg)
 {
 	int j;
@@ -59,62 +54,62 @@ static void miiphy_pre(struct bb_miiphy_bus *bus, const struct bb_miiphy_bus_ops
 	 * but it is safer and will be much more robust.
 	 */
 
-	ops->mdio_active(bus);
-	ops->set_mdio(bus, 1);
+	ops->mdio_active(miidev);
+	ops->set_mdio(miidev, 1);
 	for (j = 0; j < 32; j++) {
-		ops->set_mdc(bus, 0);
-		ops->delay(bus);
-		ops->set_mdc(bus, 1);
-		ops->delay(bus);
+		ops->set_mdc(miidev, 0);
+		ops->delay(miidev);
+		ops->set_mdc(miidev, 1);
+		ops->delay(miidev);
 	}
 
 	/* send the start bit (01) and the read opcode (10) or write (10) */
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, 0);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, read);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, !read);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, 0);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, read);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, !read);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
 
 	/* send the PHY address */
 	for (j = 0; j < 5; j++) {
-		ops->set_mdc(bus, 0);
+		ops->set_mdc(miidev, 0);
 		if ((addr & 0x10) == 0) {
-			ops->set_mdio(bus, 0);
+			ops->set_mdio(miidev, 0);
 		} else {
-			ops->set_mdio(bus, 1);
+			ops->set_mdio(miidev, 1);
 		}
-		ops->delay(bus);
-		ops->set_mdc(bus, 1);
-		ops->delay(bus);
+		ops->delay(miidev);
+		ops->set_mdc(miidev, 1);
+		ops->delay(miidev);
 		addr <<= 1;
 	}
 
 	/* send the register address */
 	for (j = 0; j < 5; j++) {
-		ops->set_mdc(bus, 0);
+		ops->set_mdc(miidev, 0);
 		if ((reg & 0x10) == 0) {
-			ops->set_mdio(bus, 0);
+			ops->set_mdio(miidev, 0);
 		} else {
-			ops->set_mdio(bus, 1);
+			ops->set_mdio(miidev, 1);
 		}
-		ops->delay(bus);
-		ops->set_mdc(bus, 1);
-		ops->delay(bus);
+		ops->delay(miidev);
+		ops->set_mdc(miidev, 1);
+		ops->delay(miidev);
 		reg <<= 1;
 	}
 }
@@ -132,57 +127,51 @@ int bb_miiphy_read(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
 	unsigned short rdreg; /* register working value */
 	int v;
 	int j; /* counter */
-	struct bb_miiphy_bus *bus;
 
-	bus = bb_miiphy_getbus(miidev);
-	if (bus == NULL) {
-		return -1;
-	}
-
-	miiphy_pre(bus, ops, 1, addr, reg);
+	miiphy_pre(miidev, ops, 1, addr, reg);
 
 	/* tri-state our MDIO I/O pin so we can read */
-	ops->set_mdc(bus, 0);
-	ops->mdio_tristate(bus);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
+	ops->set_mdc(miidev, 0);
+	ops->mdio_tristate(miidev);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
 
 	/* check the turnaround bit: the PHY should be driving it to zero */
-	ops->get_mdio(bus, &v);
+	ops->get_mdio(miidev, &v);
 	if (v != 0) {
 		/* puts ("PHY didn't drive TA low\n"); */
 		for (j = 0; j < 32; j++) {
-			ops->set_mdc(bus, 0);
-			ops->delay(bus);
-			ops->set_mdc(bus, 1);
-			ops->delay(bus);
+			ops->set_mdc(miidev, 0);
+			ops->delay(miidev);
+			ops->set_mdc(miidev, 1);
+			ops->delay(miidev);
 		}
 		/* There is no PHY, return */
 		return -1;
 	}
 
-	ops->set_mdc(bus, 0);
-	ops->delay(bus);
+	ops->set_mdc(miidev, 0);
+	ops->delay(miidev);
 
 	/* read 16 bits of register data, MSB first */
 	rdreg = 0;
 	for (j = 0; j < 16; j++) {
-		ops->set_mdc(bus, 1);
-		ops->delay(bus);
+		ops->set_mdc(miidev, 1);
+		ops->delay(miidev);
 		rdreg <<= 1;
-		ops->get_mdio(bus, &v);
+		ops->get_mdio(miidev, &v);
 		rdreg |= (v & 0x1);
-		ops->set_mdc(bus, 0);
-		ops->delay(bus);
+		ops->set_mdc(miidev, 0);
+		ops->delay(miidev);
 	}
 
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 0);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
 
 	debug("%s[%s](0x%x) @ 0x%x = 0x%04x\n", __func__, miidev->name, reg, addr, rdreg);
 
@@ -199,51 +188,44 @@ int bb_miiphy_read(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
 int bb_miiphy_write(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
 		    int addr, int devad, int reg, u16 value)
 {
-	struct bb_miiphy_bus *bus;
 	int j;			/* counter */
 
-	bus = bb_miiphy_getbus(miidev);
-	if (bus == NULL) {
-		/* Bus not found! */
-		return -1;
-	}
-
-	miiphy_pre(bus, ops, 0, addr, reg);
+	miiphy_pre(miidev, ops, 0, addr, reg);
 
 	/* send the turnaround (10) */
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
-	ops->set_mdc(bus, 0);
-	ops->set_mdio(bus, 0);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->set_mdio(miidev, 0);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
 
 	/* write 16 bits of register data, MSB first */
 	for (j = 0; j < 16; j++) {
-		ops->set_mdc(bus, 0);
+		ops->set_mdc(miidev, 0);
 		if ((value & 0x00008000) == 0) {
-			ops->set_mdio(bus, 0);
+			ops->set_mdio(miidev, 0);
 		} else {
-			ops->set_mdio(bus, 1);
+			ops->set_mdio(miidev, 1);
 		}
-		ops->delay(bus);
-		ops->set_mdc(bus, 1);
-		ops->delay(bus);
+		ops->delay(miidev);
+		ops->set_mdc(miidev, 1);
+		ops->delay(miidev);
 		value <<= 1;
 	}
 
 	/*
 	 * Tri-state the MDIO line.
 	 */
-	ops->mdio_tristate(bus);
-	ops->set_mdc(bus, 0);
-	ops->delay(bus);
-	ops->set_mdc(bus, 1);
-	ops->delay(bus);
+	ops->mdio_tristate(miidev);
+	ops->set_mdc(miidev, 0);
+	ops->delay(miidev);
+	ops->set_mdc(miidev, 1);
+	ops->delay(miidev);
 
 	return 0;
 }
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 65ba107fc00..52547b27aff 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -491,27 +491,27 @@ static void ravb_stop(struct udevice *dev)
 }
 
 /* Bitbang MDIO access */
-static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
+static int ravb_bb_mdio_active(struct mii_dev *miidev)
 {
-	struct ravb_priv *eth = bus->priv;
+	struct ravb_priv *eth = miidev->priv;
 
 	setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
 
 	return 0;
 }
 
-static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+static int ravb_bb_mdio_tristate(struct mii_dev *miidev)
 {
-	struct ravb_priv *eth = bus->priv;
+	struct ravb_priv *eth = miidev->priv;
 
 	clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
 
 	return 0;
 }
 
-static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+static int ravb_bb_set_mdio(struct mii_dev *miidev, int v)
 {
-	struct ravb_priv *eth = bus->priv;
+	struct ravb_priv *eth = miidev->priv;
 
 	if (v)
 		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
@@ -521,18 +521,18 @@ static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+static int ravb_bb_get_mdio(struct mii_dev *miidev, int *v)
 {
-	struct ravb_priv *eth = bus->priv;
+	struct ravb_priv *eth = miidev->priv;
 
 	*v = (readl(eth->iobase + RAVB_REG_PIR) & PIR_MDI) >> 3;
 
 	return 0;
 }
 
-static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+static int ravb_bb_set_mdc(struct mii_dev *miidev, int v)
 {
-	struct ravb_priv *eth = bus->priv;
+	struct ravb_priv *eth = miidev->priv;
 
 	if (v)
 		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
@@ -542,7 +542,7 @@ static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int ravb_bb_delay(struct bb_miiphy_bus *bus)
+static int ravb_bb_delay(struct mii_dev *miidev)
 {
 	udelay(10);
 
@@ -598,6 +598,7 @@ static int ravb_probe(struct udevice *dev)
 
 	mdiodev->read = ravb_bb_miiphy_read;
 	mdiodev->write = ravb_bb_miiphy_write;
+	mdiodev->priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 738dc43cdc7..c898a2204d8 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -644,9 +644,9 @@ static void sh_ether_stop(struct udevice *dev)
 }
 
 /******* for bb_miiphy *******/
-static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+static int sh_eth_bb_mdio_active(struct mii_dev *miidev)
 {
-	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_dev *eth = miidev->priv;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
@@ -654,9 +654,9 @@ static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+static int sh_eth_bb_mdio_tristate(struct mii_dev *miidev)
 {
-	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_dev *eth = miidev->priv;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
@@ -664,9 +664,9 @@ static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+static int sh_eth_bb_set_mdio(struct mii_dev *miidev, int v)
 {
-	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_dev *eth = miidev->priv;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	if (v)
@@ -679,9 +679,9 @@ static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+static int sh_eth_bb_get_mdio(struct mii_dev *miidev, int *v)
 {
-	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_dev *eth = miidev->priv;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
@@ -689,9 +689,9 @@ static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
 	return 0;
 }
 
-static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+static int sh_eth_bb_set_mdc(struct mii_dev *miidev, int v)
 {
-	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_dev *eth = miidev->priv;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 
 	if (v)
@@ -704,7 +704,7 @@ static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
+static int sh_eth_bb_delay(struct mii_dev *miidev)
 {
 	udelay(10);
 
@@ -760,6 +760,7 @@ static int sh_ether_probe(struct udevice *udev)
 
 	mdiodev->read = sh_eth_bb_miiphy_read;
 	mdiodev->write = sh_eth_bb_miiphy_write;
+	mdiodev->priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
diff --git a/include/miiphy.h b/include/miiphy.h
index f0163b3f29e..c9128a641dd 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -67,12 +67,12 @@ void mdio_list_devices(void);
 struct bb_miiphy_bus;
 
 struct bb_miiphy_bus_ops {
-	int (*mdio_active)(struct bb_miiphy_bus *bus);
-	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
-	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
-	int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
-	int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
-	int (*delay)(struct bb_miiphy_bus *bus);
+	int (*mdio_active)(struct mii_dev *miidev);
+	int (*mdio_tristate)(struct mii_dev *miidev);
+	int (*set_mdio)(struct mii_dev *miidev, int v);
+	int (*get_mdio)(struct mii_dev *miidev, int *v);
+	int (*set_mdc)(struct mii_dev *miidev, int v);
+	int (*delay)(struct mii_dev *miidev);
 };
 
 struct bb_miiphy_bus {
-- 
2.47.2

