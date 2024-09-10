Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA30ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B840388AB1;
	Tue, 10 Sep 2024 14:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82916889CD; Tue, 10 Sep 2024 09:49:41 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8175188EFB
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 15:49:34 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Sep 2024 15:49:34 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <BMC-SW@aspeedtech.com>, <joel@jms.id.au>, <trini@konsulko.com>,
 <jacky_chou@aspeedtech.com>, <u-boot@lists.denx.de>
Subject: [PATCH] driver: net: Add Aspeed AST2700 MDIO support
Date: Tue, 10 Sep 2024 15:49:34 +0800
Message-ID: <20240910074934.1216-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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

The AST2700 is the 7th generation SoC from Aspeed.
And use the driver to support clause 22 access.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/aspeed_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/aspeed_mdio.c b/drivers/net/aspeed_mdio.c
index f2e4392aa9..2e1f3cdf11 100644
--- a/drivers/net/aspeed_mdio.c
+++ b/drivers/net/aspeed_mdio.c
@@ -113,6 +113,7 @@ static int aspeed_mdio_probe(struct udevice *dev)
 
 static const struct udevice_id aspeed_mdio_ids[] = {
 	{ .compatible = "aspeed,ast2600-mdio" },
+	{ .compatible = "aspeed,ast2700-mdio" },
 	{ }
 };
 
-- 
2.25.1

