Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9653C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D1A8083C;
	Sun,  9 Feb 2025 13:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v0Rqre8W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LkmZMAEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29C0809D4; Sun,  9 Feb 2025 13:04:52 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0753880AE5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRGS4MxNz9t1w;
 Sun,  9 Feb 2025 13:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz/yYZZbw2m+9VD2pAy/vCp8IzYVUdy8CHQugtzJGOE=;
 b=v0Rqre8WFrS5pHrfD0JR+4nqSUYkvVuOqL8Ez3qjaxg20E+RHv0aGILcVhIvskna+DS5Oe
 +gHqbNWsH63ms0rP2PVFVuPgh9FvLYCC1sJ0JY5anaMGXFIJc1mMhFYpRNJyusxKBdai7u
 jr7Mx3LtrlVDrK95IHFsORk5tov3F++ShjEQk8rxjWaW5PygtuaLu/zJYxwXWHRwy6ei1q
 Lxg7T0zagBKiqiL2xRAETyb4HPLM6KR9Fy+hALOgqcatBy7rIxRxG5FOgIBgQz01cCeP14
 UGo94otwffWutRXROLm1X6ltyWJFr0sDVk+yQEPM6pw5fRb8jHWqxXNP5CxO3A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz/yYZZbw2m+9VD2pAy/vCp8IzYVUdy8CHQugtzJGOE=;
 b=LkmZMAEyPXRF9OwXnwkFvGxAsT4Cq+AoZvMH7HSlyxc33y9fKXnwuUZ3wCv62qH7VFzSJu
 bo0eDamNJ44VO5lP/1YWTToQWdRKJB0vAJ67WpwLmMfHen28fMtXDQyPKq+vaqnF0T7+lt
 EUEesfhjndyhHddFpN1VbgYy69FSfpLl/+WqffESvjKzHKmevNNI8PQem2l87aUqsUssHD
 sa63K+wLgQu6SEPc+vg3j23H93TVo/bQF2ockI5wrszUojGb9vuzhx5XI5ogNLELmIZeU2
 IYzprkkIPp6kX7KKDqAK7UpNzneGIFWt3RDYHI5XC5Yw9qlghOw79ksX9fbtIQ==
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
Subject: [PATCH v2 05/24] net: sh_eth: Reorder bb_miiphy functions
Date: Sun,  9 Feb 2025 13:01:31 +0100
Message-ID: <20250209120403.5321-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f598f54c222759d4e57
X-MBO-RS-META: q1bn9npejyxbikaxb8tofcky7zok8jsb
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
 drivers/net/sh_eth.c | 136 +++++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index b607b9a3a43..6bd12ee3f19 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -643,6 +643,74 @@ static void sh_ether_stop(struct udevice *dev)
 	sh_eth_stop(&priv->shdev);
 }
 
+/******* for bb_miiphy *******/
+static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	if (v)
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) | PIR_MDO, PIR);
+	else
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) & ~PIR_MDO, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
+
+	return 0;
+}
+
+static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	if (v)
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) | PIR_MDC, PIR);
+	else
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) & ~PIR_MDC, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
+{
+	udelay(10);
+
+	return 0;
+}
+
 static int sh_ether_probe(struct udevice *udev)
 {
 	struct eth_pdata *pdata = dev_get_plat(udev);
@@ -776,74 +844,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
 };
 
-/******* for bb_miiphy *******/
-static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	if (v)
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) | PIR_MDO, PIR);
-	else
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) & ~PIR_MDO, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
-
-	return 0;
-}
-
-static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	if (v)
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) | PIR_MDC, PIR);
-	else
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) & ~PIR_MDC, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
-{
-	udelay(10);
-
-	return 0;
-}
-
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "sh_eth",
-- 
2.47.2

