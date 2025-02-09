Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A4C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CD7808E6;
	Sun,  9 Feb 2025 13:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uAotTJqF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YNQK7hvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D7080EBB; Sun,  9 Feb 2025 13:05:17 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4960280805
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YrRGz00jjz9skQ;
 Sun,  9 Feb 2025 13:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5Ey9GwaA1o56nUBBthiE4n8KO4ku1Ms6OvaHf8hsvQ=;
 b=uAotTJqFbzIzz9UQIqxVIKNr8wzGbTexH16V+4+EU57cYWbtI35NtEOtg7IS+jfBNdqpmp
 D9NemyyRrthUGgdiGCMsddqNwcAbylO2PayZP1Fi8uVHmWmnpj9zRc/9WPcBtbabT45FEa
 60PcnGIhWtqNrkfDGaceXXBleQ9kFsH+KoMUvEY3f3OqLZPCDM3bQbGidHOV7sDUF9WzsY
 0KRYSC0yNemD764Mn/L9HVMC3tPnqOp9vZYjRnVPspUdFeHYY45sv1U/lQRPAvq2DIObEa
 31tVAjdOxuxs7oMRW2Zjpy+vUd1yyezMzr7vVMqgzmm4FxPlEOqbqi2nXnslZA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5Ey9GwaA1o56nUBBthiE4n8KO4ku1Ms6OvaHf8hsvQ=;
 b=YNQK7hvbecTN10aYUi6vuNsk8kv0z4kuAyHXXfc6KWBTuW1cpH6+CNVmQ7JP44KaM3mTpy
 QAfiPKQwLYDoQjeMHOJR3qXj+ADU35aDz1XZIc9BrOJ1vzn5xpMb/iaMER3TQj/jMNE0Zl
 JnvI8go9QitlhJ2FxuWy8gUPPwGV0qmX6Mmvmt37xParY7zhpUbJx70JeTsV07B3NqRrub
 CkIqR7bRcNC/mpp4Trn5aMjiWgAL+TCFNyONmK5S//uv7iW5JwnJTEAxFQ/1CcsiMWe0+r
 JR7XjnN5tUDV7btkeZCV7tZ0WpZc7sOlBwoeC/itlqhkKZh2tG/4aUmRi5MyPA==
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
Subject: [PATCH v2 17/24] net: sh_eth: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sun,  9 Feb 2025 13:01:43 +0100
Message-ID: <20250209120403.5321-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zdodufyuhom1a9b7qijn3xzoekxyh53o
X-MBO-RS-ID: 68a3832671c79bd7d03
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
V2: No change
---
 drivers/net/sh_eth.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 6bd12ee3f19..e78d64d77c3 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -716,6 +716,7 @@ static int sh_ether_probe(struct udevice *udev)
 	struct eth_pdata *pdata = dev_get_plat(udev);
 	struct sh_ether_priv *priv = dev_get_priv(udev);
 	struct sh_eth_dev *eth = &priv->shdev;
+	struct bb_miiphy_bus *bb_miiphy;
 	struct mii_dev *mdiodev;
 	int ret;
 
@@ -726,17 +727,29 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		return ret;
 #endif
-	mdiodev = mdio_alloc();
-	if (!mdiodev) {
+	bb_miiphy = bb_miiphy_alloc();
+	if (!bb_miiphy) {
 		ret = -ENOMEM;
 		return ret;
 	}
 
+	mdiodev = &bb_miiphy->mii;
+
 	mdiodev->read = bb_miiphy_read;
 	mdiodev->write = bb_miiphy_write;
 	bb_miiphy_buses[0].priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
+	/* Copy the bus accessors, name and private data */
+	bb_miiphy->mdio_active = sh_eth_bb_mdio_active;
+	bb_miiphy->mdio_tristate = sh_eth_bb_mdio_tristate;
+	bb_miiphy->set_mdio = sh_eth_bb_set_mdio;
+	bb_miiphy->get_mdio = sh_eth_bb_get_mdio;
+	bb_miiphy->set_mdc = sh_eth_bb_set_mdc;
+	bb_miiphy->delay = sh_eth_bb_delay;
+	strlcpy(bb_miiphy->name, "sh_eth", MDIO_NAME_LEN);
+	bb_miiphy->priv = eth;
+
 	ret = mdio_register(mdiodev);
 	if (ret < 0)
 		goto err_mdio_register;
@@ -771,7 +784,7 @@ err_phy_config:
 	clk_disable(&priv->clk);
 #endif
 err_mdio_register:
-	mdio_free(mdiodev);
+	bb_miiphy_free(bb_miiphy);
 	return ret;
 }
 
-- 
2.47.2

