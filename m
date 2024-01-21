Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25661C47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E8E8783B;
	Sun, 21 Jan 2024 18:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FKon3JGt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c4H6Z3Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86698877F8; Sun, 21 Jan 2024 18:30:31 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD51F87796
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJ0jw3l06z9stT;
 Sun, 21 Jan 2024 18:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHPgmPhV1Cs1WGMAUGGr5pLByQUtzJoVOjJBFh5DTjk=;
 b=FKon3JGtyMuPe+ZBqqbAkfOWo394toTqxrs7wHCqiJvmRPuxTkVLq8DUQ0szxaovdai27T
 DwopKWJfCKEnw470RlXNgFmBFjMVzJcnlER3u0vfp3FzeJDDiLDFEdapD928MZOZ8jLx5t
 c/TxcMO7MfGItflBifSZ5PUD79pgevXfkHF0W1D1Y0B7EdqbFGooU3RjkHUc2ymVNR+pVB
 J/o+HdcnAWOyh5J32CMjwIDgi+fvjixukivlzgrHVmT1c6B+P9nEKZ/jg2RSu4IFROPRWK
 +SnpNCwdwObrXwsMxNIv30hTWs2kBqAEX1FeJk9gSkC7OM2Y7mAzI1P8viSnlw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHPgmPhV1Cs1WGMAUGGr5pLByQUtzJoVOjJBFh5DTjk=;
 b=c4H6Z3SfTeNq98KB1tkJ9OiBmxixHvVZNfxiWQFCo7hPCgexxjJH2BDwqUR+mt4FbgqmeR
 XYtxtnK9pORpHM5c68zB1nHH8SimgwGJ+czraI15k/gp+KqnYgGbaglSjGmsGNByZ/owDC
 GtYkkiTvjKhZzJMOuD0P4JWE3F7CN71GT0NzDIQZ5Jh3u7wWLPr1Z/utEDCk/4C73uDiY9
 835NyVWUu7o88XVqn9zk4k+NIhhFZspT6j5g7ECr5r2yVH+EToJbBT6JYUbd0yGsj7ushL
 +tZ9w7fm/hvVydyb+0QAQNvrrg22cc/8l3s2jeaaIX2ssvGTmz+soAtj3/Cg9Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 2/3] net: sh_eth: Use PHY MDIO address from DT if available
Date: Sun, 21 Jan 2024 18:29:34 +0100
Message-ID: <20240121173006.273629-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
References: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6dqc67y3j8rjgu3cuonadpsya5ok8ryy
X-MBO-RS-ID: 0fc51963b6c3dfcd46e
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
 drivers/net/ravb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 0bcd6cfd3f3..e1f61f514c8 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -12,6 +12,7 @@
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <eth_phy.h>
 #include <errno.h>
 #include <log.h>
 #include <miiphy.h>
@@ -309,9 +310,14 @@ static int ravb_phy_config(struct udevice *dev)
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct phy_device *phydev;
+	int phy_addr;
 	int reg;
 
-	phydev = phy_connect(eth->bus, -1, dev, pdata->phy_interface);
+	phy_addr = eth_phy_get_addr(dev);
+	if (phy_addr < 0)
+		phy_addr = -1;
+
+	phydev = phy_connect(eth->bus, phy_addr, dev, pdata->phy_interface);
 	if (!phydev)
 		return -ENODEV;
 
-- 
2.43.0

