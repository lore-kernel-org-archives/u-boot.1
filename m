Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475FEC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246F480FD6;
	Sat, 22 Feb 2025 21:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cPIABUdV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VP80qwMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD0980FFC; Sat, 22 Feb 2025 21:36:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EEA800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0r1mt8z9spY;
 Sat, 22 Feb 2025 21:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1HCiZiepX3zRyUTKUaJOj1sc4ISEcEVjriUIlwnhR0=;
 b=cPIABUdVZ5PlZ0iQTGX4/BS6z7KXNHUQdMl1sQR0z15eJ8Yk63tq0guuAFaTkbSr3iopIA
 leCsLFHaee9+YbQDeWahtGjR5df3PjBGBg3qPpLJVDyS+b/Mi1a5LQmRTNcu/MgkbN8hja
 nQJTIEUS40M6dNNnvMdMd5tGY1B99PzKbsFYLsH7b8oYouuqAoYrlPkxZTBRRVL1ozQJA3
 Ir6dOjKZErvb3Pf4E9OStoNNho+JqSsGipKCNeZacIOnxl65hreSR95ox+OZZ3MFcLAtmF
 xQgIdzu7XShdcUrz9zyaMZh7tn/aIskUzTfYY0GOyfyOEe4k+ZYKaIF137R4vQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1HCiZiepX3zRyUTKUaJOj1sc4ISEcEVjriUIlwnhR0=;
 b=VP80qwMSE1oqU7cvmBuR2SqVUIyzTMnzGZwv9bBwJP1D9eeHXcvuene4YbrewCdScfgz/5
 XDY6rPYkGauew2QcnUD1eMVhdBaO9Iui0evl4pHzuA6ghKUk3M+mdybJvbBVbwNLbLSGa0
 8N7MY4vgDRyViiPduIdiiQ6I9FQd40wcvEGUjmff9zpaR9veObQWRPCii0W4c5IyO4Tfns
 JkT+I/F6awI+/xJNwY7fWx4pzdow8Xt7V8Q+F2dXup6Ct1/N5QBw9PjiM+INaglE465zr3
 N1vy5U71fhtzb2SCDmPAG15yXqDWgRnn64YqPfYcbc7S59t4kL0MQRx4pK0ItQ==
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
Subject: [PATCH v3 15/23] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sat, 22 Feb 2025 21:33:25 +0100
Message-ID: <20250222203511.195437-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: upuf6h9ukae8b98daj671pjhq19tz31c
X-MBO-RS-ID: b00a380903ca1ef26bd
X-Rspamd-Queue-Id: 4Z0f0r1mt8z9spY
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

Allocate bb_miiphy using bb_miiphy_alloc() and fill in callbacks
currently listed in bb_miiphy_buses[] array. This is a temporary
duplication of assignment to avoid breakage, which will be removed
in follow up patches. At this point, the bb_miiphy callbacks can
reach these accessors by doing container_of() on struct mii_dev.

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
V2: No change
V3: Add RB from Paul
---
 drivers/net/ravb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 381cf250ea2..0018b694ec1 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -553,6 +553,7 @@ static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
+	struct bb_miiphy_bus *bb_miiphy;
 	struct mii_dev *mdiodev;
 	void __iomem *iobase;
 	int ret;
@@ -564,17 +565,29 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_alloc;
 
-	mdiodev = mdio_alloc();
-	if (!mdiodev) {
+	bb_miiphy = bb_miiphy_alloc();
+	if (!bb_miiphy) {
 		ret = -ENOMEM;
 		goto err_mdio_alloc;
 	}
 
+	mdiodev = &bb_miiphy->mii;
+
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
+	/* Copy the bus accessors, name and private data */
+	bb_miiphy->mdio_active = ravb_bb_mdio_active;
+	bb_miiphy->mdio_tristate = ravb_bb_mdio_tristate;
+	bb_miiphy->set_mdio = ravb_bb_set_mdio;
+	bb_miiphy->get_mdio = ravb_bb_get_mdio;
+	bb_miiphy->set_mdc = ravb_bb_set_mdc;
+	bb_miiphy->delay = ravb_bb_delay;
+	strlcpy(bb_miiphy->name, "ravb", MDIO_NAME_LEN);
+	bb_miiphy->priv = eth;
+
 	ret = mdio_register(mdiodev);
 	if (ret < 0)
 		goto err_mdio_register;
@@ -599,7 +612,7 @@ static int ravb_probe(struct udevice *dev)
 err_mdio_reset:
 	clk_release_bulk(&eth->clks);
 err_mdio_register:
-	mdio_free(mdiodev);
+	bb_miiphy_free(bb_miiphy);
 err_mdio_alloc:
 	unmap_physmem(eth->iobase, MAP_NOCACHE);
 	return ret;
-- 
2.47.2

