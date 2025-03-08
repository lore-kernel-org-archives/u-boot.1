Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8132EC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3821803CC;
	Sat,  8 Mar 2025 21:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bJJ03zI/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CDwPaocs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDB88043C; Sat,  8 Mar 2025 21:50:23 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595228004F
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z9FfN1XvZz9sRx;
 Sat,  8 Mar 2025 21:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741467020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p8aXm26YtbHmOVjZ4NZdzs/rJghYVxbJj6YenGPcKBs=;
 b=bJJ03zI/M9wP3Z6cGFoe1Y6YyyGvB2jiKlhRjkbws1+Uv8qiP43GRVDCFN3vRdiIlioJCj
 sisC3DEhyRkuMjEeNn7UwkaEn/z44jL7QP4VwHJ/aIfh8+WYT3qwr7wOJ/TBwydHPL2Non
 2e1yqHcWNTAKD1xdHE9Htlj2bPTdhWXb8o6nVkL3Qnd/d9u6mLHx+OvEf8omARJypjS6v3
 zdfVuQyutd4TVexF5cEwgop7kYU6x+OlfefqTxXZs8NiZQUEKEkKDoCl5+OBGCRF3O+F/D
 vJmb4QX3MZxjQWWT2w2kk3WP61Z1m7fLFbDcDYr1+voOUpODhmv7YsfijVdBTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741467018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p8aXm26YtbHmOVjZ4NZdzs/rJghYVxbJj6YenGPcKBs=;
 b=CDwPaocsbldzJWYF3JIvHGGgQrmWHX7jCS9VGlr3TIveAuwW2fb4S8NHoaMDxf0Q8zYN4B
 gCMNUQFKeKj6WjfdA5v0/gSl4Zw1EnTiKHSIejRhOhb+JK1tNd+EbMj22PublRQ4LHVBl2
 47Pr1Lap1hto5HD6raXRUIg56LSQ8ZOSYwa89+8mPVJl1VZD2tH+DEJmndPJqgxr/kb8e/
 MUkUalNnyroLXDN+rbW9cS2ZgLq46PpDj9bW0RgItAqt6PvrUHpJbE1Y8i/Y9xQRpUeAoF
 fRTt+byAfSDBJq+LPlIDk9JQ0XJaVRIwatkxE1CgTTpXJV/KGs7QHYx9Ni8a8Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH] net: miiphybb: Convert documentation to rst
Date: Sat,  8 Mar 2025 21:49:42 +0100
Message-ID: <20250308205002.1318885-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1794bf74d1bcb32eab8
X-MBO-RS-META: okeuf8rp5y5dsbkzxmprdaj1ux4c96sk
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

Convert the current miiphybb documentation to rst. Rename
the README.bitbangMII to bitbangmii.rst in the process.

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
 doc/README.bitbangMII | 67 ---------------------------------------
 doc/bitbangmii.rst    | 73 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 67 deletions(-)
 delete mode 100644 doc/README.bitbangMII
 create mode 100644 doc/bitbangmii.rst

diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
deleted file mode 100644
index 78b4ef880cb..00000000000
--- a/doc/README.bitbangMII
+++ /dev/null
@@ -1,67 +0,0 @@
-The miiphybb ( Bit-banged MII bus driver ) supports an arbitrary number of
-MII buses. This feature is useful when a driver uses different MII buses for
-different PHYs and all (or a part) of these buses are implemented via
-bit-banging mode.
-
-The driver requires that the following macros should be defined into the board
-configuration file:
-
-CONFIG_BITBANGMII	- Enable the miiphybb driver
-
-The driver code needs to allocate a regular MDIO device using mdio_alloc()
-and assign .read and .write accessors which wrap bb_miiphy_read() and
-bb_miiphy_write() functions respectively. The bb_miiphy_read() and
-bb_miiphy_write() functions take a pointer to a callback structure,
-struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has the following
-fields/callbacks (see miiphy.h for details):
-
-int (*mdio_active)()   - Activate the MDIO pin as output
-int (*mdio_tristate)() - Activate the MDIO pin as input/tristate pin
-int (*set_mdio)()      - Write the MDIO pin
-int (*get_mdio)()      - Read the MDIO pin
-int (*set_mdc)()       - Write the MDC pin
-int (*delay)()	       - Delay function
-
-The driver code will look like:
-
-static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
-	.mdio_active	= ravb_bb_mdio_active,
-	.mdio_tristate	= ravb_bb_mdio_tristate,
-	.set_mdio	= ravb_bb_set_mdio,
-	.get_mdio	= ravb_bb_get_mdio,
-	.set_mdc	= ravb_bb_set_mdc,
-	.delay		= ravb_bb_delay,
-};
-
-static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
-			       int devad, int reg)
-{
-	return bb_miiphy_read(miidev, &ravb_bb_miiphy_bus_ops,
-			      addr, devad, reg);
-}
-
-static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
-				int devad, int reg, u16 value)
-{
-	return bb_miiphy_write(miidev, &ravb_bb_miiphy_bus_ops,
-			       addr, devad, reg, value);
-}
-
-static int ravb_probe(struct udevice *dev)
-{
-	struct mii_dev *mdiodev;
-...
-	mdiodev = mdio_alloc();
-	if (!mdiodev)
-		return -ENOMEM;
-
-	mdiodev->read = ravb_bb_miiphy_read;
-	mdiodev->write = ravb_bb_miiphy_write;
-	mdiodev->priv = eth;
-	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
-
-	ret = mdio_register(mdiodev);
-...
-
-2009 Industrie Dial Face S.p.A.
-     Luigi 'Comio' Mantellini <luigi.mantellini@idf-hit.com>
diff --git a/doc/bitbangmii.rst b/doc/bitbangmii.rst
new file mode 100644
index 00000000000..95707e8f57f
--- /dev/null
+++ b/doc/bitbangmii.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Bit-banged MII bus support
+==========================
+
+The miiphybb ( Bit-banged MII bus driver ) supports an arbitrary number of
+MII buses. This feature is useful when a driver uses different MII buses for
+different PHYs and all (or a part) of these buses are implemented via
+bit-banging mode.
+
+The driver requires that the following macros should be defined into the board
+configuration file:
+
+    CONFIG_BITBANGMII      - Enable the miiphybb driver
+
+The driver code needs to allocate a regular MDIO device using mdio_alloc()
+and assign .read and .write accessors which wrap bb_miiphy_read() and
+bb_miiphy_write() functions respectively. The bb_miiphy_read() and
+bb_miiphy_write() functions take a pointer to a callback structure,
+struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has the following
+fields/callbacks (see miiphy.h for details):
+
+    int (*mdio_active)()   - Activate the MDIO pin as output
+    int (*mdio_tristate)() - Activate the MDIO pin as input/tristate pin
+    int (*set_mdio)()      - Write the MDIO pin
+    int (*get_mdio)()      - Read the MDIO pin
+    int (*set_mdc)()       - Write the MDC pin
+    int (*delay)()         - Delay function
+
+The driver code will look like:
+
+    static const struct bb_miiphy_bus_ops ravb_bb_miiphy_bus_ops = {
+        .mdio_active      = ravb_bb_mdio_active,
+        .mdio_tristate    = ravb_bb_mdio_tristate,
+        .set_mdio         = ravb_bb_set_mdio,
+        .get_mdio         = ravb_bb_get_mdio,
+        .set_mdc          = ravb_bb_set_mdc,
+        .delay            = ravb_bb_delay,
+    };
+
+    static int ravb_bb_miiphy_read(struct mii_dev *miidev, int addr,
+                                   int devad, int reg)
+    {
+        return bb_miiphy_read(miidev, &ravb_bb_miiphy_bus_ops,
+                              addr, devad, reg);
+    }
+
+    static int ravb_bb_miiphy_write(struct mii_dev *miidev, int addr,
+                                    int devad, int reg, u16 value)
+    {
+        return bb_miiphy_write(miidev, &ravb_bb_miiphy_bus_ops,
+                               addr, devad, reg, value);
+    }
+
+    static int ravb_probe(struct udevice *dev)
+    {
+        struct mii_dev *mdiodev;
+    ...
+        mdiodev = mdio_alloc();
+        if (!mdiodev)
+            return -ENOMEM;
+
+        mdiodev->read = ravb_bb_miiphy_read;
+        mdiodev->write = ravb_bb_miiphy_write;
+        mdiodev->priv = eth;
+        snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
+
+        ret = mdio_register(mdiodev);
+    ...
+    }
+
+2009 Industrie Dial Face S.p.A.
+     Luigi 'Comio' Mantellini <luigi.mantellini@idf-hit.com>
-- 
2.47.2

