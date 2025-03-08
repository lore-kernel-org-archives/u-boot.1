Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D30BC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC738043C;
	Sat,  8 Mar 2025 21:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qBjf5/M/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wYi/TS1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390C9808A2; Sat,  8 Mar 2025 21:36:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8F9803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z9FLf5vM1z9sRt;
 Sat,  8 Mar 2025 21:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741466202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZQNmW/fQ5fThQjQRuXcHMLcXYrTjD9p9xfZ7pJbw5u0=;
 b=qBjf5/M/y0qfzIQAR0WqpC/IDwAS9KHDDmEXS1+mh4EAf3Q4954wX31zujf34tvtTdsJT2
 7wGWDCP/sK91GAsnwg5+sh+HHVjc7eFvkPHCMRdkZwV/Fm/uiBs/tnhln0IS/fREcG8kXe
 yK3RSpIcGVxQOObMBmW6jhe8YXD4BaNZZsYbt+CUUqvXqZ5FN9nrTxfgkUTeaqotaaEPxh
 WFAJgKMLCbSjmJ9btm8/juRDRcZyaOw1JwOFMrM9W/KYLBwfSJOaFAsXBicWdzNBSjF8vk
 UrWBEbN236Qb1/2sf0Zu/JWkrpS8fA0cwCnKkzkje7CpJH691haBDXh+d683Sg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741466200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZQNmW/fQ5fThQjQRuXcHMLcXYrTjD9p9xfZ7pJbw5u0=;
 b=wYi/TS1u2aU5529jhGl1lYOgu0EPCeAHMdnUlBKhNcYXE0Gep4/Z1n8xMZ2pEgidn/BE2C
 waE+2YtgaQeTnvWVjE8YeXH8H9KXqxXsWd52OeaJ7Q6tbyiAhGLvVY23IgjSvh8wZvgBw1
 y7xHYj2OicYSxPEyxVMOk2EDjivk5q83l8eMepjtlMjB7bOKQBnBuKjTlfA/WTWoIwIIzW
 T6sBQZgk43qdqAn+3JERSUB3WR966i6Zqib9MjH6ide3mtHCAQkyWGcFcqQNDz3gKpU1xP
 YqMGM44LwINBn4Trj9kFyn4krXNhfGfBcz8rkylflr3LwfOlr4zBxaibxL4rrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: miiphybb: Update documentation
Date: Sat,  8 Mar 2025 21:36:02 +0100
Message-ID: <20250308203625.1317615-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zsf1cam4b7u75gkn7wkbam11k6guegyk
X-MBO-RS-ID: 6d2f1677f8ec03ceb64
X-Rspamd-Queue-Id: 4Z9FLf5vM1z9sRt
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

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
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
V2: - Fix language bugs
    - Add RB from Paul
---
 doc/README.bitbangMII | 66 ++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
index 05ab20376f3..78b4ef880cb 100644
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
+The driver code needs to allocate a regular MDIO device using mdio_alloc()
+and assign .read and .write accessors which wrap bb_miiphy_read() and
+bb_miiphy_write() functions respectively. The bb_miiphy_read() and
+bb_miiphy_write() functions take a pointer to a callback structure,
+struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has the following
 fields/callbacks (see miiphy.h for details):
 
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

