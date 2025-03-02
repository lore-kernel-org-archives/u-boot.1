Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126EDC021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04016811A7;
	Sun,  2 Mar 2025 02:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Mt2acnKU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tDEig+Vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD308058A; Sun,  2 Mar 2025 02:28:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D4D81101
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z548V56vrz9swH;
 Sun,  2 Mar 2025 02:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BMhrZEIC0puf6gJPmSgC7K2wKeg/6EB+th/IGnc2wo=;
 b=Mt2acnKUn5ciC6Krs7IvMpmYGFN7R/qKUPRmvLkI/9durIkMV38yofG+x6PNAexO4hGXV7
 KrTdogc0Ffad6Q9vutVthWfaCETHTjSeZiiui/7kv18PoQr0+ybuh8xJ5XAJEI+vCk/taP
 0tNpF7Li7Y3GrFv6E57IZWqPlOAJh9N+jgYDe5VONsRTtu2FFJJ8vBVJyaddlsDJMxixdM
 7v+YxGvyNMAWzpH77KkdErRD6xqlNDIbK9XK36KaGzd+kL8flh3w6w3VXdq7oTCFzwq62f
 2PlUTvqV8V/RxBJHDdeeqVxDDjLBb7CwVXLv34zycH4txaqGIqUvjBUK4YMAzQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BMhrZEIC0puf6gJPmSgC7K2wKeg/6EB+th/IGnc2wo=;
 b=tDEig+ViyqOAs9WfeipiwvW2yQowu+6swH907p7DTrQ9jkwjyftP28ud1wyQvEBS3xeXu8
 n5R+9wWQfBNTy4KiIL7s5HdoO4X7vPkuIrFwiJqO894riwkNuKc8h8cqq0VzH7t/75UdsS
 2DWTRLFeuH4wS6aeE8MTSE0VosskhKvN2QbVBrQDVOvqjFOMFJ4+M34UU7st0DFthhPe5c
 pJdPnMpX7ojw5LKlpbqVBl9Hl6FdONq7nB2g7o3XPJ15T8DeEskkFyWQVUle4yzN1z2UZH
 Mh2Gn/6bfX0veunIbOVvFP50LjxK2h0SQm5gO0pXFssenOlQYTvZykz2qMmGNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] net: miiphybb: Wrap driver side bb_miiphy_read/write()
 accessors
Date: Sun,  2 Mar 2025 02:24:43 +0100
Message-ID: <20250302012752.393608-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zb7c8jaczpw9u51po6ceggx1z71mczf5
X-MBO-RS-ID: 842801da40f5d52c50d
X-Rspamd-Queue-Id: 4Z548V56vrz9swH
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

Do not call bb_miiphy_read()/bb_miiphy_write() accessors directly
in drivers, instead call them through wrapper functions. Those are
meant to be used as function parameter adaptation layer between
struct mii_dev callback function parameters and what the miiphybb
does expect and will soon expect. This is a preparatory patch, no
functional change.

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
 board/gdsys/a38x/ihs_phys.c | 16 ++++++++++++++--
 drivers/net/designware.c    | 16 ++++++++++++++--
 drivers/net/ravb.c          | 16 ++++++++++++++--
 drivers/net/sh_eth.c        | 16 ++++++++++++++--
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index c999ab6d6fa..304b5b5f0bc 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -228,6 +228,18 @@ static const struct bb_miiphy_bus_ops mii_bb_miiphy_bus_ops = {
 	.delay		= mii_delay,
 };
 
+static int mii_bb_miiphy_read(struct mii_dev *miidev, int addr,
+			      int devad, int reg)
+{
+	return bb_miiphy_read(miidev, addr, devad, reg);
+}
+
+static int mii_bb_miiphy_write(struct mii_dev *miidev, int addr,
+			       int devad, int reg, u16 value)
+{
+	return bb_miiphy_write(miidev, addr, devad, reg, value);
+}
+
 int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
 	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
@@ -239,8 +251,8 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 
 	mdiodev = &bb_miiphy->mii;
 	snprintf(mdiodev->name, MDIO_NAME_LEN, "ihs%d", k);
-	mdiodev->read = bb_miiphy_read;
-	mdiodev->write = bb_miiphy_write;
+	mdiodev->read = mii_bb_miiphy_read;
+	mdiodev->write = mii_bb_miiphy_write;
 
 	/* Copy the bus accessors and private data */
 	bb_miiphy->ops = &mii_bb_miiphy_bus_ops;
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 045bff476d1..3c3450aa778 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -299,6 +299,18 @@ static const struct bb_miiphy_bus_ops dw_eth_bb_miiphy_bus_ops = {
 	.delay		= dw_eth_bb_delay,
 };
 
+static int dw_bb_miiphy_read(struct mii_dev *miidev, int addr,
+			     int devad, int reg)
+{
+	return bb_miiphy_read(miidev, addr, devad, reg);
+}
+
+static int dw_bb_miiphy_write(struct mii_dev *miidev, int addr,
+			      int devad, int reg, u16 value)
+{
+	return bb_miiphy_write(miidev, addr, devad, reg, value);
+}
+
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 {
 	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
@@ -334,8 +346,8 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 	dwpriv->dev = dev;
 
 	snprintf(bus->name, sizeof(bus->name), "%s", name);
-	bus->read = bb_miiphy_read;
-	bus->write = bb_miiphy_write;
+	bus->read = dw_bb_miiphy_read;
+	bus->write = dw_bb_miiphy_write;
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	bus->reset = dw_mdio_reset;
 #endif
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index bd4900270a2..9a17ac97cce 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -558,6 +558,18 @@ static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
 	.delay		= ravb_bb_delay,
 };
 
+static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
+			       int devad, int reg)
+{
+	return bb_miiphy_read(miidev, addr, devad, reg);
+}
+
+static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
+				int devad, int reg, u16 value)
+{
+	return bb_miiphy_write(miidev, addr, devad, reg, value);
+}
+
 static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
@@ -582,8 +594,8 @@ static int ravb_probe(struct udevice *dev)
 
 	mdiodev = &bb_miiphy->mii;
 
-	mdiodev->read = bb_miiphy_read;
-	mdiodev->write = bb_miiphy_write;
+	mdiodev->read = ravb_bb_miiphy_read;
+	mdiodev->write = ravb_bb_miiphy_write;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 0693c240fbd..cef531c8c6f 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -720,6 +720,18 @@ static const struct bb_miiphy_bus_ops sh_ether_bb_miiphy_bus_ops = {
 	.delay		= sh_eth_bb_delay,
 };
 
+static int sh_eth_bb_miiphy_read(struct mii_dev *miidev, int addr,
+				 int devad, int reg)
+{
+	return bb_miiphy_read(miidev, addr, devad, reg);
+}
+
+static int sh_eth_bb_miiphy_write(struct mii_dev *miidev, int addr,
+				  int devad, int reg, u16 value)
+{
+	return bb_miiphy_write(miidev, addr, devad, reg, value);
+}
+
 static int sh_ether_probe(struct udevice *udev)
 {
 	struct eth_pdata *pdata = dev_get_plat(udev);
@@ -744,8 +756,8 @@ static int sh_ether_probe(struct udevice *udev)
 
 	mdiodev = &bb_miiphy->mii;
 
-	mdiodev->read = bb_miiphy_read;
-	mdiodev->write = bb_miiphy_write;
+	mdiodev->read = sh_eth_bb_miiphy_read;
+	mdiodev->write = sh_eth_bb_miiphy_write;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
-- 
2.47.2

