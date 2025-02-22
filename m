Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F123C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B421780F3F;
	Sat, 22 Feb 2025 21:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ph9jWVgh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hfNCfr/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF2480F3F; Sat, 22 Feb 2025 21:36:35 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B935580FFC
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z0f0w5Lvjz9tW3;
 Sat, 22 Feb 2025 21:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pe41sCdSl7+RgJmKwqNizj8cO92EvM6fTkAE9aTvJHo=;
 b=ph9jWVghLQAImmJ447pRsZvHR0Rv6mcey+R2YrvAWOoonyZ6pD8ey5tcM2qmUK2ZPLsl6l
 MOiFhdfH37w7+29xtBu5b6IaQbUT76JoYzqdPV2Ir1n4oLRi0zekJ+vLv/s2248xlIcAWr
 9UZYC+9BTO9a6Bx9xOXkVOK+z70lZoadzjkGs+abymJxXtG605iSKZMawapnDN64l6iGuE
 GfxOWLySpixYwV9IK3ooCa4cJzpvG58jK0S6Sonc/NQpWLUW/+BbR03tQxfSSc2yEsT27B
 azBjtJwSsvDJWh9zt0roaKpM65v3RsFwLdOd0auyi6EvxYdH07p5kKzaeHcm7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pe41sCdSl7+RgJmKwqNizj8cO92EvM6fTkAE9aTvJHo=;
 b=hfNCfr/J7cI6ueT+Gxy3jdrLhxmmjUMpvYlTSL6YCFKP/zHaOwsBpZScvkY/c6rLlMsY1y
 3jmKxZq0fU2lGcrVdiHW9qOA+ZAgoOvXZ9/nJdTUTXTKiJKXgesiRztSKTuBRFT6d8HlAh
 E8lbM55Tw4QRdLBfd0G3er/Lu32zkEr1bnsuB7j39IvS0gNpGHHNehGEQWceSl4Dg15HFk
 jvnO5sLiWOkdJl8HZ2OyNs9fIbv/Nw0R+26LEGt1Hc0vueXYlOEJdVTwM5zf0aSs4AyyG2
 /39EXTcnRYwqa/rWzVyaaB2VbYcUX61HeeX0tw24LlN12Shsu8cVh6k8ox6wNA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/23] net: designware: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sat, 22 Feb 2025 21:33:27 +0100
Message-ID: <20250222203511.195437-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cxx7qgi8mpps8ka6f4prjkpnie1mixc6
X-MBO-RS-ID: 87f8ce932fe59baf52c
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
V2: New patch
V3: No change
---
 drivers/net/designware.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index c88b8df28ed..74cf8271e67 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -307,14 +307,17 @@ int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
 static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 {
 	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
-	struct mii_dev *bus = mdio_alloc();
+	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
+	struct mii_dev *bus;
 	int ret;
 
-	if (!bus) {
+	if (!bb_miiphy) {
 		printf("Failed to allocate MDIO bus\n");
 		return -ENOMEM;
 	}
 
+	bus = &bb_miiphy->mii;
+
 	debug("\n%s: use bitbang mii..\n", dev->name);
 	ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
 				   &dwpriv->mdc_gpio,
@@ -345,6 +348,15 @@ static int dw_bb_mdio_init(const char *name, struct udevice *dev)
 #endif
 	bus->priv = dwpriv;
 
+	/* Copy the bus accessors, name and private data */
+	bb_miiphy->mdio_active = dw_eth_bb_mdio_active;
+	bb_miiphy->mdio_tristate = dw_eth_bb_mdio_tristate;
+	bb_miiphy->set_mdio = dw_eth_bb_set_mdio;
+	bb_miiphy->get_mdio = dw_eth_bb_get_mdio;
+	bb_miiphy->set_mdc = dw_eth_bb_set_mdc;
+	bb_miiphy->delay = dw_eth_bb_delay;
+	strlcpy(bb_miiphy->name, bus->name, MDIO_NAME_LEN);
+
 	return mdio_register(bus);
 }
 #endif
@@ -968,7 +980,12 @@ int designware_eth_probe(struct udevice *dev)
 	/* continue here for cleanup if no PHY found */
 	err = ret;
 	mdio_unregister(priv->bus);
-	mdio_free(priv->bus);
+#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
+	if (bbmiiphy)
+		bb_miiphy_free(container_of(priv->bus, struct bb_miiphy_bus, mii));
+	else
+#endif
+		mdio_free(priv->bus);
 mdio_err:
 
 #ifdef CONFIG_CLK
-- 
2.47.2

