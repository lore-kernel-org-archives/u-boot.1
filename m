Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B07BD5B87D
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 01:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB12A80077;
	Tue, 16 Dec 2025 02:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="ojo8kn7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C742800AB; Tue, 16 Dec 2025 01:54:05 +0100 (CET)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32498003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 01:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:2af:22b0:6c0b:d94b:97c7:89ef])
 (Authenticated sender: vjardin@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 792A713F86A;
 Tue, 16 Dec 2025 01:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1765846441;
 bh=IPMEZUJS1Kzu2FBpbVrTd6wK0tpnZpXyek2/WzIpOrQ=;
 h=From:To:Cc:Subject:Date:From;
 b=ojo8kn7/Gc231HtVlnKK02x/0JLZPSatEAKmKsn8IxwJzBwaMeXVMC9o073z3VT4t
 l7ZWPlFnLhonUAU4Vg82zOigp0WzXQwHjADIdIqTzll6wDjx5tKPhSsLFuNz18peyz
 S8Uc/nFsVhiuss0oWN+9r3TCbuNdbrxzGitljJyyXc+SrRiQARhYo4ZijDqRUEI5WI
 RzvUUsyGqHsawKF5+aSkcxfokwcHt1sH5II8PoEE+UstCN1sHRMilrzYS+cmNNfFPN
 yhcjyIxWxBx2tcTqH247Xjhc1i5yO0nVODUHQLlGw/AGjpwUBNDj87u33aGN1T77E2
 7pLX1MPCtoCMQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 seanga2@gmail.com, sjg@chromium.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH] net: mvpp2: fix NULL pointer dereference in mvpp2_phy_connect
Date: Tue, 16 Dec 2025 01:53:52 +0100
Message-ID: <20251216005352.92277-1-vjardin@free.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 02:14:21 +0100
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

Fix two NULL pointer dereferences in mvpp2_phy_connect():

1. port->phy_dev->dev is used in dev_warn() but
   port->phy_dev is not assigned yet (assigned later at line below).

2. port->phy_dev->dev is used in dev_err() inside
   the "if (!phy_dev)" block, which means phy_dev is NULL.

Both cases would cause a crash if the PHY detection fails or returns
a generic PHY. Use the already available 'dev' parameter instead.

Fixes: 9db60ee470c2 ("net: mvpp2: Convert netdev_xxx to dev_xxx")
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/mvpp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index ae545fe229c..3f6f1978f2f 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -4530,7 +4530,7 @@ static void mvpp2_phy_connect(struct udevice *dev, struct mvpp2_port *port)
 		 */
 		if (phy_dev &&
 		    phy_dev->drv->uid == 0xffffffff) {/* Generic phy */
-			dev_warn(port->phy_dev->dev,
+			dev_warn(dev,
 				 "Marking phy as invalid, link will not be checked\n");
 			/* set phy_addr to invalid value */
 			port->phyaddr = PHY_MAX_ADDR;
@@ -4542,7 +4542,7 @@ static void mvpp2_phy_connect(struct udevice *dev, struct mvpp2_port *port)
 
 		port->phy_dev = phy_dev;
 		if (!phy_dev) {
-			dev_err(port->phy_dev->dev, "cannot connect to phy\n");
+			dev_err(dev, "cannot connect to phy\n");
 			return;
 		}
 		phy_dev->supported &= PHY_GBIT_FEATURES;
-- 
2.43.0

