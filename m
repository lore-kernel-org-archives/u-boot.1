Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D21C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D305080B9E;
	Sun,  9 Feb 2025 13:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XfbVOMJ3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G3euQ5HN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB94780AE5; Sun,  9 Feb 2025 13:04:48 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B852280821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRGQ3D8Yz9syY;
 Sun,  9 Feb 2025 13:04:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iS3faOwbIg55ab9yJwmaqA/tTIeQDeTJEmTbr3nGsGU=;
 b=XfbVOMJ34psuijJd6FUcRQ5IQKkwkZgmtiYVDHM7R7VREG03s+TR8ZW4zddlffFqFQgojp
 TZZ/KXcjc2iFtM48f4QMXCLCCPf5NQ1SdD/qrq8Dyt1+40MRmCvM/3bqv0Lxp9a+oZQxTQ
 YOdvjjBBwFudXTeCjbmVx81FuPS6oDaG+TMTBcKO89kTs9OjViDcVKSFiBIpjS1+LeXwYv
 kLE+WP4J/2AfOvl713KiarunDKUv4OzRYXE2by/5PT/lFvSpD7T6a3WA44XVo6p21iuS/S
 1kXKM7wCoB/PMqOoqv1ycgsim97UWbBnklPP7Pi9xCDEcIPYWZqGJQtT58ED5g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iS3faOwbIg55ab9yJwmaqA/tTIeQDeTJEmTbr3nGsGU=;
 b=G3euQ5HN6BA2mPON8XBvQ6LN9fweOBylnzQE3fTbvEu2ktqdIaxQq86JeCr0wWV8qf7LdX
 utSOJg6Hh9AES10WMrUo2deT9u63ov+PTjmdVHscooHavMvkWq7HVA9XsCcBHS9jHjhlp1
 NUGZzIsVDNYFedIH3Cl1LGFyPYQyTZFBFNwXBs42aFyvTfT6L8jG42AbZt1acyWCDvXfWg
 LbPlpieUISUvrFixip6O9EZAK1sLKO+Z6uMou+ZQZMY9tWAkdserW9CJLYcN2kBSGtWXOj
 P8yGXJ85ID77771qPwjgD7swPcYUHuz2ivXjoMPdOdjVfMF/0ZNpXaeGETP1hw==
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
Subject: [PATCH v2 04/24] net: ravb: Reorder bb_miiphy functions
Date: Sun,  9 Feb 2025 13:01:30 +0100
Message-ID: <20250209120403.5321-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 188ac0c1e66e55e1118
X-MBO-RS-META: ysd4hkk96iczpccq5reym4q3pbmcyunz
X-Rspamd-Queue-Id: 4YrRGQ3D8Yz9syY
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

Move the bb_miiphy functions before MDIO registration. This is a
preparatory patch, the functions will be referenced around the MDIO
registration in the follow up patches. No functional change.

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
 drivers/net/ravb.c | 117 +++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 5df557da7da..381cf250ea2 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -490,6 +490,65 @@ static void ravb_stop(struct udevice *dev)
 	ravb_reset(dev);
 }
 
+/* Bitbang MDIO access */
+static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
+
+	return 0;
+}
+
+static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
+
+	return 0;
+}
+
+static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	if (v)
+		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
+	else
+		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
+
+	return 0;
+}
+
+static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	*v = (readl(eth->iobase + RAVB_REG_PIR) & PIR_MDI) >> 3;
+
+	return 0;
+}
+
+static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	if (v)
+		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
+	else
+		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
+
+	return 0;
+}
+
+static int ravb_bb_delay(struct bb_miiphy_bus *bus)
+{
+	udelay(10);
+
+	return 0;
+}
+
 static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
@@ -560,64 +619,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
-
-	return 0;
-}
-
-static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
-
-	return 0;
-}
-
-static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	if (v)
-		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
-	else
-		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
-
-	return 0;
-}
-
-static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	*v = (readl(eth->iobase + RAVB_REG_PIR) & PIR_MDI) >> 3;
-
-	return 0;
-}
-
-static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	if (v)
-		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
-	else
-		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
-
-	return 0;
-}
-
-static int ravb_bb_delay(struct bb_miiphy_bus *bus)
-{
-	udelay(10);
-
-	return 0;
-}
-
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "ravb",
-- 
2.47.2

