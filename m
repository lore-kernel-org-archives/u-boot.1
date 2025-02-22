Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763AC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9A780F96;
	Sat, 22 Feb 2025 21:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XP6uQPyF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fab639Gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABC481120; Sat, 22 Feb 2025 21:36:48 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF66A800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z0f1B4CZwz9svd;
 Sat, 22 Feb 2025 21:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7Geu72K3nnHx8AL1YJ+FyJYB99qcBSQACAlLyntRbs=;
 b=XP6uQPyFWXI8B018ibhGALblCKtUlMoAGiiiR87rUpwhoBASrGBXOb839EY9tCapamHB4G
 KaTzu71iRx9uR5mM8Yz+9zcyCZ9x2L7Bgndh2ogp5dpeVQB66c1Vldy0dMENP1Rzb+XcQP
 ZqLYqf3vuWy0emadCjqcRHhxvmbDvrYwEORMJADtAoAayV3nLEIKeiD59YA/PGR8E+MDXk
 2R4E7IWMAuoBIIH1ndl6Lze243qzvi40s30pjHg9t/34EPxWT94XJ5/SpdHxXFnhaPR67h
 g/2qBxkK8u2jW1Kk9mNXsgo6tbaXPD9bGccX2sG03AgRxM8OoJzVZQhyXgq+ig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7Geu72K3nnHx8AL1YJ+FyJYB99qcBSQACAlLyntRbs=;
 b=Fab639GiQE/np1mTLY2KpfxusTE3rJF8D0lRnWx/GHjJzK6opuQBaJrwr/jU/UDerVCkaX
 RZWDxZy1dNpe4QV8zq7q5yiut3uVzaZvhjHKp487qjgDNqs1CghW+Zc+WUAEUfSU1SP01K
 QHNRQQfiwhZTUvlKhoWJcu0CbMgf6kd7a3oFqaRrNcti7SOCXi82mjowqGLFr0d1h4Tphe
 qbOimtBApCrfTDK5u2hItANApYfmmAJWP94AUpjusqAZQWoDPt4xJwZ6vby3VuOVkTKfRK
 ktGO3f4RgneAT5qovQz1dQoAkpQbElDdPx0O2aCEntIjlhWgDov1Uhvt5OZxzA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/23] net: miiphybb: Drop bb_miiphy_buses and
 bb_miiphy_buses_num
Date: Sat, 22 Feb 2025 21:33:33 +0100
Message-ID: <20250222203511.195437-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ce733f4076c685ea989
X-MBO-RS-META: gpgjn3gu944of89dgpd6qp99ci6f8gkc
X-Rspamd-Queue-Id: 4Z0f1B4CZwz9svd
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

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
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
V3: Add RB from Paul
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
index 5124982e683..5a6e89c0575 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -290,19 +290,6 @@ static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
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
@@ -337,7 +324,6 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
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

