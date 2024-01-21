Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BBCC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F428786B;
	Sun, 21 Jan 2024 18:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rxxiDSoI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JfUM6Vd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F96877D3; Sun, 21 Jan 2024 18:30:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F768773D
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TJ0jx4vj3z9sV0;
 Sun, 21 Jan 2024 18:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbi37R4OuGWUAKEVgr4shQnbdKJoJhHGMf5OWIjjq6g=;
 b=rxxiDSoIK9q+afm2XNy4MkO58eiyEX4q4eFOYUOiBJQfNAmtcSXtF8+xK9qdaqZreHkw6Q
 ITXovdeeQFN3JF8SVMj95YXhh3kh6R7Z1+//9Kh2rpVpQp3xBareBNkhlB7WnWH3X7oYuV
 JN78CqgbBClhGJHLrbxPjGrs6IyGaXmkG5Mke3a3fozjSkSI+dJ0zMGLBMy3x5BUIcNJLq
 rpstJUL5I/Y3b6ZbaUXtSXszLcLimw90K2g8Auf0+QtkM9xvMconaEB4JVEPZeBhmI/AHb
 FkWV7MYIJgW/gzX0a4Pwh9YUlMjP6n+NAySKdBUCWGaMP2jXlebqCqMwiagPhA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbi37R4OuGWUAKEVgr4shQnbdKJoJhHGMf5OWIjjq6g=;
 b=JfUM6Vd+EkMmA+OTZWTvBwu9I3oFV024CJmH2TkFMfV/nYlvn/91aTYoope2BbnKH9QbyZ
 BZ8PhHkvt/ONxQbYrTJ9OEe+A/VoMWCmFCQoswU3W8oWFaGd1SkB3pFJYKIrdqu1IoFdpN
 Vcyv8I3wUlR4O8s6akplVlHhnvfz24w8UWRrDBqqAKv9ee24iPijsZCSyJIpbqLrDBVolf
 mBLPZojLvLDFwUy3m0cyM+snQ+9WRtzoO7wf5hpA3Q14tjop2f70Y0VH/VcK2aXW65AGhE
 x+9lIx1WhO3q0nfXN9mWv2a3Hfhouj4eEjeWZIAfio9HgZxWXBwOdDu8sEDUrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 3/3] net: ravb: Use PHY MDIO address from DT if available
Date: Sun, 21 Jan 2024 18:29:35 +0100
Message-ID: <20240121173006.273629-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
References: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7695f73a8a25a0d312b
X-MBO-RS-META: z4do71qzf1wce1pmss6dq86kzey8ckf1
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

In case the PHY is fully described in DT, use PHY MDIO address
from DT directly instead of always using auto-detection. This
also fixes the behavior of 'mdio list' in such DT setup, which
now prints the PHY connected to the MAC correctly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
---
 drivers/net/sh_eth.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 7b1f59dc498..5e2e3054ecf 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <eth_phy.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
@@ -597,11 +598,16 @@ static int sh_eth_phy_config(struct udevice *dev)
 	struct sh_ether_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct sh_eth_dev *eth = &priv->shdev;
-	int ret = 0;
 	struct sh_eth_info *port_info = &eth->port_info[eth->port];
 	struct phy_device *phydev;
+	int phy_addr;
+	int ret = 0;
+
+	phy_addr = eth_phy_get_addr(dev);
+	if (phy_addr < 0)
+		phy_addr = -1;
 
-	phydev = phy_connect(priv->bus, -1, dev, pdata->phy_interface);
+	phydev = phy_connect(priv->bus, phy_addr, dev, pdata->phy_interface);
 	if (!phydev)
 		return -ENODEV;
 
-- 
2.43.0

