Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84D4C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9A2807C0;
	Sat, 18 Jan 2025 07:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XzNShsbo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C/VDGG/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076558063E; Sat, 18 Jan 2025 07:54:43 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AF980763
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnQm57D0z9syP;
 Sat, 18 Jan 2025 07:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lD3SE6F6FB2zImml35qNmWgEyN+lTM2KXPBnf8InE1g=;
 b=XzNShsbozYy4qBEx04APY+qe6NwaWnvGLgACwdUUWwAU9fCFfOy408/WcKdcy+w48VDUG+
 EeNNp6sG5m7bPlmNG7vGKJVHta9xRLFjiE0zx20DVLlZ2doGizaYf2uzPbiBFoS1y6lcwd
 hb3DZ78sSW5dTFeXkbAuV9aVYgAamD2+o7wrjNmQBGcfOW0jOwK6Mm4v/orRVCGmRGj3E9
 mkUXp+++T6GQ8/3f8b55OBBMuWHMY+SVH9iumSf3gEc4JVoikE2V7X2XLrzfCmJy4q7Ixo
 eCLL4ratgAdD/YAM9nCisEkn231T/YF7mYZzFzgcYa41TAQ0F4uiJH0RU0KO1A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lD3SE6F6FB2zImml35qNmWgEyN+lTM2KXPBnf8InE1g=;
 b=C/VDGG/z9s0TRlVLWnVXdnwiQHF4kOOQqkvM4uXzRbRYgI6Wx9cEvXx3vKbAtPPoZyIjh+
 FI2RHQ347Cfy2eNmzonjMjqJzVo9drwTPnNLypDWML0je2AhrOMJqcRaHOZ6mYWSA7OD92
 QPSNJSPP9WVn7qRGLS7xsD8gl9q5hM8PMHshxE9m8b7j4gA4cuov0JMZ50By3bmndFcWEK
 5WcijQecqRYwvwFYLpwK/U67zxW6MADcfpwDBppcXwKxWetUeYxrzs4NWNg3TYv/fiZ3KR
 YPe2X0PUEI5vemdLrlH5W8XbMdgm4mC6jgBAAQT0H0iiSwluUTiLYpvo4cGzOg==
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
Subject: [PATCH 07/17] net: ravb: Allocate bb_miiphy using bb_miiphy_alloc()
 and fill in callbacks
Date: Sat, 18 Jan 2025 07:53:11 +0100
Message-ID: <20250118065402.172253-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zrbp4bog9371yg9ao5oshfaois8jhmr1
X-MBO-RS-ID: c7e01099c43aadc960c
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
 drivers/net/ravb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 6e4baff658f..60454d1a579 100644
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
@@ -564,17 +565,30 @@ static int ravb_probe(struct udevice *dev)
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
+	bb_miiphy->init = NULL;
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
@@ -599,7 +613,7 @@ static int ravb_probe(struct udevice *dev)
 err_mdio_reset:
 	clk_release_bulk(&eth->clks);
 err_mdio_register:
-	mdio_free(mdiodev);
+	bb_miiphy_free(bb_miiphy);
 err_mdio_alloc:
 	unmap_physmem(eth->iobase, MAP_NOCACHE);
 	return ret;
-- 
2.45.2

