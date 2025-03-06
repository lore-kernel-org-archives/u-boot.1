Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F3C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E198880F4C;
	Fri,  7 Mar 2025 00:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WT5Ah++T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kJ4kOJpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C918680F9E; Fri,  7 Mar 2025 00:09:03 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3AA80E94
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z83b34jHQz9tF1;
 Thu,  6 Mar 2025 23:13:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741299199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fnBvW3LuDVo7Nl+j+Lzujvg/bLueSwcytVji/G6fZ4s=;
 b=WT5Ah++TU/Pe/jj4OKU5fIcurkGaWbOUAeVuEM4nTAHYRS00Wb4Yu4SzuLJENzPBMUkzqk
 anO+NOs14b1xKIDQVOsdC+T8vY31yqkTNU96pD7fEiOwXD8z19fuEGoFzshJDPvl8vGJ8M
 aceZI7Xx1jzStB9Gxu+UKuOwdpqjl3X2HLo1Bs1W2w+M+V5aA0ih9Eed6aUKWGC74hVb71
 1K1hz/OCgNyONZUTQBWorhJOtZu1wq3LKrBmXIQDypAedBKZyoM7dY9YUjN5hvbRPQYmPB
 qHBMWNplAQ1/XFfLWJaWD7EC2XxmRzTmROLVsAbTlD6QO7gAD9eP7eN/Gn03Lg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741299197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fnBvW3LuDVo7Nl+j+Lzujvg/bLueSwcytVji/G6fZ4s=;
 b=kJ4kOJpaFmb1UpHntrMT0vw/g2O1jKmD/zmH70kVAOFUyFpql0GWZcwYWcN4OyDtJVxAMf
 vslpCx/jD4Y23Q4uuWul+zGSKZterE5s18/Zv37D6OsbRc3IW7KhrPgbs4vBktQPWL7NTF
 FKeT3h737pDNRZEEyPWVILi9vc1UxQd3N2j63SWfA0XEgXKyoy/MtvrIoroXIvcS3ftGNb
 qX8s+I7G8jBwM8w/z+6RRS14WxTOtkJ8LZVDR2KZHnMf4tsbiP9Eg0KbCZiUmkUYwxAnNH
 HhP0FX4OCes/5Zsa+eC5YB7ODZol8Fbnasnc624cf7QP7VFnRI/MRt7MWMnSgA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: miiphybb: Update documentation
Date: Thu,  6 Mar 2025 23:12:34 +0100
Message-ID: <20250306221304.136257-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 539dc1ef21e52aafad0
X-MBO-RS-META: ghwueye4n49s34gs4og8q7ff1spajkex
X-Rspamd-Queue-Id: 4Z83b34jHQz9tF1
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

Update the miiphybb documentation to match current implementation.
The static struct bb_miiphy_bus bb_miiphy_buses[] array is removed.
The example is updated to match current Renesas RAVB driver, which
is one of the miiphybb users.

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
 doc/README.bitbangMII | 68 ++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
index 05ab20376f3..cb8a6eabf9d 100644
--- a/doc/README.bitbangMII
+++ b/doc/README.bitbangMII
@@ -1,39 +1,67 @@
-This patch rewrites the miiphybb ( Bit-banged MII bus driver ) in order to
-support an arbitrary number of mii buses. This feature is useful when your
-board uses different mii buses for different phys and all (or a part) of these
-buses are implemented via bit-banging mode.
+The miiphybb ( Bit-banged MII bus driver ) supports an arbitrary number of
+MII buses. This feature is useful when a driver uses different MII buses for
+different PHYs and all (or a part) of these buses are implemented via
+bit-banging mode.
 
 The driver requires that the following macros should be defined into the board
 configuration file:
 
 CONFIG_BITBANGMII	- Enable the miiphybb driver
 
-The board code needs to fill the bb_miiphy_buses[] array with a record for
-each required bus and declare the bb_miiphy_buses_num variable with the
-number of mii buses. The record (struct bb_miiphy_bus) has the following
-fields/callbacks (see miiphy.h for details):
+The driver code needs to allocate regular MDIO device using mdio_alloc()
+and assign .read and .write accessors which wrap bb_miiphy_read() and
+bb_miiphy_write() functions respectively. The bb_miiphy_read() and
+bb_miiphy_write() functions have to be passed a point to a callback
+structure, struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has
+the following fields/callbacks (see miiphy.h for details):
 
-char name[]	       - The symbolic name that must be equal to the MII bus
-			 registered name
-int (*init)()	       - Initialization function called at startup time (just
-			 before the Ethernet initialization)
 int (*mdio_active)()   - Activate the MDIO pin as output
 int (*mdio_tristate)() - Activate the MDIO pin as input/tristate pin
 int (*set_mdio)()      - Write the MDIO pin
 int (*get_mdio)()      - Read the MDIO pin
 int (*set_mdc)()       - Write the MDC pin
 int (*delay)()	       - Delay function
-void *priv	       - Private data used by board specific code
 
-The board code will look like:
+The driver code will look like:
 
-struct bb_miiphy_bus bb_miiphy_buses[] = {
- { .name = "miibus#1", .init = b1_init, .mdio_active = b1_mdio_active, ... },
- { .name = "miibus#2", .init = b2_init, .mdio_active = b2_mdio_active, ... },
- ...
+static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
+	.mdio_active	= ravb_bb_mdio_active,
+	.mdio_tristate	= ravb_bb_mdio_tristate,
+	.set_mdio	= ravb_bb_set_mdio,
+	.get_mdio	= ravb_bb_get_mdio,
+	.set_mdc	= ravb_bb_set_mdc,
+	.delay		= ravb_bb_delay,
 };
-int bb_miiphy_buses_num = sizeof(bb_miiphy_buses) /
-			  sizeof(bb_miiphy_buses[0]);
+
+static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
+			       int devad, int reg)
+{
+	return bb_miiphy_read(miidev, &ravb_bb_miiphy_bus_ops,
+			      addr, devad, reg);
+}
+
+static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
+				int devad, int reg, u16 value)
+{
+	return bb_miiphy_write(miidev, &ravb_bb_miiphy_bus_ops,
+			       addr, devad, reg, value);
+}
+
+static int ravb_probe(struct udevice *dev)
+{
+	struct mii_dev *mdiodev;
+...
+	mdiodev = mdio_alloc();
+	if (!mdiodev)
+		return -ENOMEM;
+
+	mdiodev->read = ravb_bb_miiphy_read;
+	mdiodev->write = ravb_bb_miiphy_write;
+	mdiodev->priv = eth;
+	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
+
+	ret = mdio_register(mdiodev);
+...
 
 2009 Industrie Dial Face S.p.A.
      Luigi 'Comio' Mantellini <luigi.mantellini@idf-hit.com>
-- 
2.47.2

