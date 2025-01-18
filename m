Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC1DC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE0D807D3;
	Sat, 18 Jan 2025 07:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G8wLd0fB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A7pYgSQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2239B807D3; Sat, 18 Jan 2025 07:54:45 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1113180759
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZnQp5LJdz9sbl;
 Sat, 18 Jan 2025 07:54:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLAlZwwYorYjNXEo6p7ZLEf/s7/hEOhzxvO53subSEw=;
 b=G8wLd0fBq6yxlVCiYQ6aDEBM+DeqZTgSV3AeY2fvkthXY23fvQrZT7GWXIF4VnSeZ/pUgD
 aqk8xuXshlVSgcvHgm6SGgUtqr80tPtlFOpOzkHSqo+IkNaTuY8vV/rbnZGJQubEmPTEZu
 b037bRuUrx4sbgRj4FCdH5ddiZLgL2d2KxKcEl70fUf4AWGZVuH+atTXDHX5vhMwEKVxKt
 xysp3yDr5nK/UuPj04z2fNozVR7IATmzAl5NoYU6Z5UbU0dPfENxlEiX2/jl6byKjaAGKE
 V1KguFX27072vSzgPg1eeDt7iy8IkLFnih4TbtMiBSpQbcXdXzXdKm2d1MnT6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLAlZwwYorYjNXEo6p7ZLEf/s7/hEOhzxvO53subSEw=;
 b=A7pYgSQk0T7N4f8XPRj5tWNZTkmOgIljeBNnIdlRv8EX/FPyHJTU6gcG1zlKeXn04yE6DV
 Ax3vMk3+2Hj8+gMN2gE7FEjjyxfmq5grJNUwX5CcTU02KAuNIYK8RF1w64NO2zMfdlHVSt
 ZrTqg9RFck1FXOaJDPjYn7cETWD862Rf7WAjyaYv2T98+heSpz170i71Bj5JiLpwif2MX4
 mGSq+WwuIb3yprUtpCegLIxso2LTumlJChNJreiX0MYIcbKyHimnkvH2SfhMOVuW25h2AJ
 w8JZz2BbC7mBe0V9L9HZgsXeG6c5ydSbkAYsN4m8Jj7PIjP1xC76/2px7Jyy/Q==
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
Subject: [PATCH 08/17] net: sh_eth: Allocate bb_miiphy using bb_miiphy_alloc()
 and fill in callbacks
Date: Sat, 18 Jan 2025 07:53:12 +0100
Message-ID: <20250118065402.172253-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3z4kkbhirogma8pok7f1cdwb38mkrwcg
X-MBO-RS-ID: 6e690d31b48f6e72855
X-Rspamd-Queue-Id: 4YZnQp5LJdz9sbl
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
 drivers/net/sh_eth.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 45dc79c4309..a765c280ff0 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -716,6 +716,7 @@ static int sh_ether_probe(struct udevice *udev)
 	struct eth_pdata *pdata = dev_get_plat(udev);
 	struct sh_ether_priv *priv = dev_get_priv(udev);
 	struct sh_eth_dev *eth = &priv->shdev;
+	struct bb_miiphy_bus *bb_miiphy;
 	struct mii_dev *mdiodev;
 	int ret;
 
@@ -726,17 +727,30 @@ static int sh_ether_probe(struct udevice *udev)
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
+	bb_miiphy->init = NULL;
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
@@ -771,7 +785,7 @@ err_phy_config:
 	clk_disable(&priv->clk);
 #endif
 err_mdio_register:
-	mdio_free(mdiodev);
+	bb_miiphy_free(bb_miiphy);
 	return ret;
 }
 
-- 
2.45.2

