Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C2C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 804AE87B71;
	Thu, 18 Jan 2024 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uCt5t9k/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEE487A0E; Thu, 18 Jan 2024 08:20:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500DB87B71
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9c3f=I4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1705562399; bh=QVAh7Cowk9u6zJjKNn+AqVuiCmOA4X1ChRv6pvAUpeM=;
 b=uCt5t9k/3dq6Vo+fIupni/0+2anld80iBwYZkABxJNMJpAKrf1dUujFKbVJfd0P3Fooayavtv
 /FB+Iq2eAAzzQCRDDmaNM6qijE/D9kfSm++F29F/2WDsqdKXr/2WJWc8yFA+/CipnyuaB1pwX3b
 Zcq7uWxjTWXnn3/AY6+BKzA7bW4vin7Yv5lboeUWN+akMAMW0bzuarw8D5p/z8N9oGzsGfgNUBH
 XIffnvte3JbC+E2GuKK+09qwDQxybhlkJdczhUxU05yu1R2dM0IHGqzCN8f/1zjM9ueXDAJ4x8B
 PzaCGpHN2PomMdpTLt1KRISiGDGsCQVWrNA2T/C9JNeg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Simon
 Glass <sjg@chromium.org>, Banglang Huang <banglang.huang@foxmail.com>
Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] net: designware: Reset eth phy before phy connect
Date: Thu, 18 Jan 2024 07:19:45 +0000
Message-ID: <20240118071949.927089-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118071949.927089-1-jonas@kwiboo.se>
References: <20240118071949.927089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65a8d11ed66eecd94fbb691a
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

Some ethernet PHY require being reset before a phy-id can be read back
on the MDIO bus. This can result in the following message being show
on e.g. a Radxa ROCK Pi E v1.21 with a RTL8211F ethernet PHY.

  Could not get PHY for ethernet@ff540000: addr -1

Add support to designware ethernet driver to reset eth phy by calling
the eth phy uclass function eth_phy_set_mdio_bus(). The call use NULL
as bus parameter to not set a shared mdio bus reference that would be
freed when probe fails. Also add a eth_phy_get_addr() call to try and
get the phy addr from DT when DM_MDIO is disabled.

This help fix ethernet on Radxa ROCK Pi E v1.21:

  => mdio list
  ethernet@ff540000:
  1 - RealTek RTL8211F <--> ethernet@ff540000

Reported-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a174344b3ef5..9aa5d8a1409e 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -13,6 +13,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
+#include <eth_phy.h>
 #include <log.h>
 #include <miiphy.h>
 #include <malloc.h>
@@ -576,6 +577,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
 	struct phy_device *phydev;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
+		eth_phy_set_mdio_bus(dev, NULL);
+
 #if IS_ENABLED(CONFIG_DM_MDIO)
 	phydev = dm_eth_phy_connect(dev);
 	if (!phydev)
@@ -583,6 +587,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
 #else
 	int phy_addr = -1;
 
+	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
+		phy_addr = eth_phy_get_addr(dev);
+
 #ifdef CONFIG_PHY_ADDR
 	phy_addr = CONFIG_PHY_ADDR;
 #endif
-- 
2.43.0

