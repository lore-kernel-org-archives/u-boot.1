Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EEAC48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B629187C45;
	Mon,  5 Feb 2024 14:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2903B8775F; Mon,  5 Feb 2024 09:13:29 +0100 (CET)
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 by phobos.denx.de (Postfix) with ESMTP id C2D94875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 09:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.25) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Feb
 2024 16:13:25 +0800
Received: from aspeedtech.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Feb 2024 16:13:25 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <trini@konsulko.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH] net: phy: ncsi: reslove the unaligned access issue
Date: Mon, 5 Feb 2024 16:13:23 +0800
Message-ID: <20240205081323.256131-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jacky_chou@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10; helo=aspeedtech.com;
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

From the ethernet header is not on aligned, because the length
of the ethernet header is 14 bytes.
Therefore, unaligned access must be done here.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/phy/ncsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index eb3fd65bb4..04617b7840 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -286,11 +286,11 @@ static void ncsi_rsp_gc(struct ncsi_rsp_pkt *pkt)
 	}
 
 	c = &ncsi_priv->packages[np].channels[nc];
-	c->cap_generic = ntohl(gc->cap) & NCSI_CAP_GENERIC_MASK;
-	c->cap_bc = ntohl(gc->bc_cap) & NCSI_CAP_BC_MASK;
-	c->cap_mc = ntohl(gc->mc_cap) & NCSI_CAP_MC_MASK;
-	c->cap_aen = ntohl(gc->aen_cap) & NCSI_CAP_AEN_MASK;
-	c->cap_vlan = ntohl(gc->vlan_mode) & NCSI_CAP_VLAN_MASK;
+	c->cap_generic = get_unaligned_be32(&gc->cap) & NCSI_CAP_GENERIC_MASK;
+	c->cap_bc = get_unaligned_be32(&gc->bc_cap) & NCSI_CAP_BC_MASK;
+	c->cap_mc = get_unaligned_be32(&gc->mc_cap) & NCSI_CAP_MC_MASK;
+	c->cap_aen = get_unaligned_be32(&gc->aen_cap) & NCSI_CAP_AEN_MASK;
+	c->cap_vlan = gc->vlan_mode & NCSI_CAP_VLAN_MASK;
 
 	/* End of probe for this channel */
 }
-- 
2.25.1

