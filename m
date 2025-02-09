Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD40C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17318809A4;
	Sun,  9 Feb 2025 13:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hp+LIVfv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dA9YJ7AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0933B80C91; Sun,  9 Feb 2025 13:05:15 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D3780A29
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRGw5ZBdz9srw;
 Sun,  9 Feb 2025 13:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJE9te9puEV7qGlDMjAepcdWVrM1CYYmhO1cNpnwytI=;
 b=hp+LIVfvEyZ747QHW75S4X6/AlZ4p/5HQGPkgB+QurjpHoVKRQiDqDMyjVRmOP2j54l8yn
 GmZpbdb+21r8zA2u093hl7sMmarwjvWexAyRRWNbDVV8gx+Wxll4jsrOsfv+lUKTCFhNYU
 Jrtp59U/YSXYmjYA5vwXBBz6RpM18zb6CE+9PHF2VRRR+4tm5asmFP6h7QFTUbH4/CDOVB
 TYFMSsP3rNzKwSOLp9FuuxCi/Ayn6oG9iUjjxwQcfpqKNDSpUviUsaGepk1IM8soIVgppu
 N9gtloPbzTsoMmzHHa2yqJrzs8sSAb2fGsxLP3FMq1Jc3vwbWoX018c6J0VOBQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJE9te9puEV7qGlDMjAepcdWVrM1CYYmhO1cNpnwytI=;
 b=dA9YJ7ABUHCotPsZaz/WHev8atV2UA1x+BOzEUy5EMj50KGqrOdLWZhMDUkOCNggruMZcj
 y2G/jTXmX6kSThBfTzFnrafoJv19ECjKkSme6tOw1z67ZfVxNLFbaBCOXgeJ88YtucUvuo
 kqYHeqS/5KmJ+C/wYp7BAylF02u28+TC7icv1rHQJBQzNo4R8q21YMxDJj9QYjr/sdFcui
 j+XOJPwU1X8YQxEBLxYg8eQltoPbRIfD3eiQPIgvaP2Ycqbd6RMUgkdo4Qyh68mttvxFP2
 7Wl1TPQXCTmDUCZnBniYckWjlVSnXiArlM0hNUWSAZwgiaPkz7hnnXK9QCBl2A==
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
Subject: [PATCH v2 16/24] net: ravb: Allocate bb_miiphy using
 bb_miiphy_alloc() and fill in callbacks
Date: Sun,  9 Feb 2025 13:01:42 +0100
Message-ID: <20250209120403.5321-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1dcad470a916dc5cda3
X-MBO-RS-META: r44rmooe4boam15bxr353towkn97f59h
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

