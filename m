Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB5EC48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2352A87C3D;
	Mon,  5 Feb 2024 14:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8A5877B0; Mon,  5 Feb 2024 09:02:38 +0100 (CET)
Received: from TWMBX01.aspeed.com (211-20-114-70.hinet-ip.hinet.net
 [211.20.114.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3BB875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 09:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 5 Feb
 2024 16:03:07 +0800
Received: from aspeedtech.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Feb 2024 16:02:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <trini@konsulko.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Date: Mon, 5 Feb 2024 16:02:28 +0800
Message-ID: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 05 Feb 2024 14:51:45 +0100
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

There is no need to perform the endian twice here.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/phy/ncsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index eb3fd65bb4..74c5386d2e 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -551,7 +551,7 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	checksum = ncsi_calculate_checksum((unsigned char *)hdr,
 					   sizeof(*hdr) + len);
 	pchecksum = (__be32 *)((void *)(hdr + 1) + len);
-	put_unaligned_be32(htonl(checksum), pchecksum);
+	put_unaligned_be32(checksum, pchecksum);
 
 	if (wait) {
 		net_set_timeout_handler(1000UL, ncsi_timeout_handler);
-- 
2.25.1

