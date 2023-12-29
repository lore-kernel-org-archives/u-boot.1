Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C259C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 03:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E20587960;
	Fri, 29 Dec 2023 04:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53778879E2; Fri, 29 Dec 2023 02:46:12 +0100 (CET)
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 by phobos.denx.de (Postfix) with ESMTP id 31E6F87919
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 02:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 Dec
 2023 09:45:58 +0800
Received: from aspeedtech.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Dec 2023 09:45:58 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <michal.simek@amd.com>,
 <u-boot@lists.denx.de>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH] net: phy: ncsi: fixed not nullify the pointers after free
Date: Fri, 29 Dec 2023 09:45:55 +0800
Message-ID: <20231229014555.3781595-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jacky_chou@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10; helo=aspeedtech.com;
X-Mailman-Approved-At: Fri, 29 Dec 2023 04:43:12 +0100
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

The issue occurs the UAF (use-after-free) to cause double free
when do the realloc function for the pointers during the
reinitialization NC-SI process, and it will cause the memory
management occurs error.
So, nullify these pointers after free.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/phy/ncsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index eb3fd65bb4..9689385884 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -619,9 +619,12 @@ static void ncsi_handle_aen(struct ip_udp_hdr *ip, unsigned int len)
 
 	/* Link or configuration lost - just redo the discovery process */
 	ncsi_priv->state = NCSI_PROBE_PACKAGE_SP;
-	for (i = 0; i < ncsi_priv->n_packages; i++)
+	for (i = 0; i < ncsi_priv->n_packages; i++) {
 		free(ncsi_priv->packages[i].channels);
+		ncsi_priv->packages[i].channels = NULL;
+	}
 	free(ncsi_priv->packages);
+	ncsi_priv->packages = NULL;
 	ncsi_priv->n_packages = 0;
 
 	ncsi_priv->current_package = NCSI_PACKAGE_MAX;
-- 
2.34.1

