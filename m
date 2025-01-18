Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2836C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0270807F3;
	Sat, 18 Jan 2025 07:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uLI13/yM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LjjWYtf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB033807CD; Sat, 18 Jan 2025 07:55:01 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B3E807EE
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZnR71SQ2z9slj;
 Sat, 18 Jan 2025 07:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swPQD9q8WtdCcOQY7OInQJrhKbv5JEYzqifw+LRpu00=;
 b=uLI13/yMtJtQUvAaBIMZhoYZ7C38shyF4TuUsPEGdu+d3/uuU7Qwtplht9wh9ybCodhc3L
 XkN9IkmnYY1IpPlzQX+iFODdTqM/wZkgt03bSZf0uouVsu1BcE3KHp78t1RdUR2mZS5zKc
 YK+4CHTtzFqRMJhsvVgKodA5luwwFGKEDPwvUiaCqb/uUkvGiLzcpJ92DB/wZN9CF5hC3b
 m64EGtMM+E3ZqKw1MaYze57fwmY5RXhC6czfgJaSTBS/IovyNaQ8IWgLV4ZWpjerx8au+H
 c09zxmIwfHMw0oAHZyKuwEtiIh8t45yJq7xSRzTc/o88IM2V75Up0K2XkMomHQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swPQD9q8WtdCcOQY7OInQJrhKbv5JEYzqifw+LRpu00=;
 b=LjjWYtf2ewWOk8dkK4R3tehzweeYgBFD8nAuTdd8AiACFqxS4t0wepR+ep2ibBYDEMxbkF
 RPcACLG837xMI5nzTKXO1gzZ1/mtVh31vuHEs1W/EPwrTiewRsGzxcYi+Xf+7li6eOWapJ
 RCe7maCZlQci4Pjo3qW/pP5Wt2kjRD4tkpW6jwNRfetSs7nJj5YGBgpsFJ2XI8i11NlmLP
 KcArVmw8p3Te376UNS9C5VxdKt2R6Htk4+qjlMNLwyfh4NbCbu3t+zfBVvvZF82KMDwiGX
 WG6RBhaikSF1yA4t9PTbtvzrH9LRXFUWZTFYqs5ZWp+kkeSSUn97QRuxsPme5Q==
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
Subject: [PATCH 16/17] net: miiphybb: Drop bb_miiphy_buses and
 bb_miiphy_buses_num
Date: Sat, 18 Jan 2025 07:53:20 +0100
Message-ID: <20250118065402.172253-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kuagy87jsxgb1yxg7m3nm3nrqowyrmbp
X-MBO-RS-ID: cedd4ad6696996fbee6
X-Rspamd-Queue-Id: 4YZnR71SQ2z9slj
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
 board/gdsys/a38x/ihs_phys.c | 37 +------------------------------------
 drivers/net/ravb.c          | 14 --------------
 drivers/net/sh_eth.c        | 15 ---------------
 include/miiphy.h            |  3 ---
 4 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 2663724b930..2477a2ea48e 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -290,7 +290,7 @@ int init_octo_phys(uint octo_phy_mask)
 	uint bus_idx;
 
 	/* there are up to four octo-phys on each mdio bus */
-	for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; ++bus_idx) {
+	for (bus_idx = 0; bus_idx < ARRAY_SIZE(gpio_mii_set); ++bus_idx) {
 		uint m;
 		uint octo_index = bus_idx * 4;
 		struct mii_dev *bus = NULL;
@@ -326,38 +326,3 @@ int init_octo_phys(uint octo_phy_mask)
 
 	return 0;
 }
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.init = mii_mdio_init,
-		.mdio_active = mii_mdio_active,
-		.mdio_tristate = mii_mdio_tristate,
-		.set_mdio = mii_set_mdio,
-		.get_mdio = mii_get_mdio,
-		.set_mdc = mii_set_mdc,
-		.delay = mii_delay,
-		.priv = &gpio_mii_set[0],
-	},
-	{
-		.init = mii_mdio_init,
-		.mdio_active = mii_mdio_active,
-		.mdio_tristate = mii_mdio_tristate,
-		.set_mdio = mii_set_mdio,
-		.get_mdio = mii_get_mdio,
-		.set_mdc = mii_set_mdc,
-		.delay = mii_delay,
-		.priv = &gpio_mii_set[1],
-	},
-	{
-		.init = mii_mdio_init,
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
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index ac5bb89c905..084fe8f9777 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -575,7 +575,6 @@ static int ravb_probe(struct udevice *dev)
 
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
-	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
 	/* Copy the bus accessors and private data */
@@ -632,19 +631,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.init		= NULL,
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
index 824a4a7e004..699121a6880 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -737,7 +737,6 @@ static int sh_ether_probe(struct udevice *udev)
 
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
-	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
 	/* Copy the bus accessors and private data */
@@ -854,17 +853,3 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 	.plat_auto	= sizeof(struct eth_pdata),
 	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
 };
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.init		= NULL,
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
index 9d9fe58b41c..6e8e4ee57bc 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -76,9 +76,6 @@ struct bb_miiphy_bus {
 	struct mii_dev mii;
 };
 
-extern struct bb_miiphy_bus bb_miiphy_buses[];
-extern int bb_miiphy_buses_num;
-
 struct bb_miiphy_bus *bb_miiphy_alloc(void);
 void bb_miiphy_free(struct bb_miiphy_bus *bus);
 
-- 
2.45.2

