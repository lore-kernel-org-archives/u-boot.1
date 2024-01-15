Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E25C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 15:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DA987186;
	Mon, 15 Jan 2024 16:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEC98706B; Mon, 15 Jan 2024 11:34:57 +0100 (CET)
Received: from TWMBX03.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 by phobos.denx.de (Postfix) with ESMTP id C8124871BB
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX03.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Jan
 2024 18:34:47 +0800
Received: from aspeedtech.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jan 2024 18:34:47 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <michal.simek@amd.com>,
 <u-boot@lists.denx.de>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH] net: phy: the NC-SI phy device do not require mdio bus
Date: Mon, 15 Jan 2024 18:34:47 +0800
Message-ID: <20240115103447.389339-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 15 Jan 2024 16:27:20 +0100
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

As with fixed-link phy device, the NC-SI phy devive does not
require an mdio bus. So, a condition is added to check the
NC-SI phy id to avoid accessing the bus pointer that is NULL.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/phy/phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 63b3e46f10..9991d86037 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -566,7 +566,8 @@ struct phy_device *phy_device_create(struct mii_dev *bus, int addr,
 		return NULL;
 	}
 
-	if (addr >= 0 && addr < PHY_MAX_ADDR && phy_id != PHY_FIXED_ID)
+	if (addr >= 0 && addr < PHY_MAX_ADDR && phy_id != PHY_FIXED_ID &&
+	    phy_id != PHY_NCSI_ID)
 		bus->phymap[addr] = dev;
 
 	return dev;
-- 
2.34.1

