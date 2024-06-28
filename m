Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F5BC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151A888590;
	Fri, 28 Jun 2024 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781BE88249; Fri, 28 Jun 2024 09:14:52 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5565887FB5
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 15:14:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 28 Jun 2024 15:14:45 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <joe.hershberger@ni.com>,
 <rfried.dev@gmail.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <kobedylan@gmail.com>, <jacky_chou@aspeedtech.com>, <u-boot@lists.denx.de>
Subject: [PATCH] net: ftgmac100: Fixed NC-SI PHY device cannot get
Date: Fri, 28 Jun 2024 15:14:45 +0800
Message-ID: <20240628071445.1059016-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 28 Jun 2024 15:00:50 +0200
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

The NC-SI interface does not need the MDIO bus and the
NC-SI PHY device cannot get from dm_eth_phy_connect.
Therefore, use phy_connect directly here.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 9b536fd5ab..256a519020 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -223,7 +223,7 @@ static int ftgmac100_phy_init(struct udevice *dev)
 	struct phy_device *phydev;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_DM_MDIO))
+	if (IS_ENABLED(CONFIG_DM_MDIO) && priv->phy_mode != PHY_INTERFACE_MODE_NCSI)
 		phydev = dm_eth_phy_connect(dev);
 	else
 		phydev = phy_connect(priv->bus, priv->phy_addr, dev, priv->phy_mode);
-- 
2.25.1

