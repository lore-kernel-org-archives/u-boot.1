Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA5CC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 17:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC7880D8;
	Wed, 27 Mar 2024 18:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="gRfR2Uu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58723880E5; Wed, 27 Mar 2024 18:09:54 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAC28808D
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 18:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2024032717095193e94e474facf9bce0 for <u-boot@lists.denx.de>;
 Wed, 27 Mar 2024 18:09:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=31/nvVgoJIVaBfIonCzE6X9nRGPxROs6YkV+ej2RIC8=;
 b=gRfR2Uu+BDOeJlb/RvOci8ugNgfYJq6SxL9faWf4406i7fev8+e1PW0oixlkvEY5lLTq/X
 rXq+QaXILiYRN3xNAlhwn5Vhq1+E0e/k0XBYlNOcYhLdWdxn6MqQmB0wQKNVKuQTLaOtJRaf
 nmBEOu0p9SnVdb0vRqHW/Qt3xUNZk=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [PATCH] net: ti: am65-cpsw-nuss: Don't crash in am65_cpsw_phy_init()
Date: Wed, 27 Mar 2024 18:09:40 +0100
Message-ID: <20240327170941.436610-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

am65_cpsw_ofdata_parse_phy() tries to handle the case when PHY is not
specified in DT gracefully:

am65_cpsw_nuss_port ethernet@8000000port@1: can't parse phy-handle port 1 (-2)

am65_cpsw_mdio_init() is turn is prepared for this, checks
if priv->has_phy == 0 and bails out (leaving cpsw_common->bus == NULL).

am65_cpsw_phy_init() however is not prepared for this and calls
phy_connect(cpsw_common->bus, ...) unconditionally, which leads to:

"Synchronous Abort" handler, esr 0x8600000d, far 0x0
elr: ffffffff808ab000 lr : 000000008083bde4 (reloc)

where lr points to the instruction right after bus->read() in get_phy_id().

Fixes: 9d0dca1199d1 ("net: ethernet: ti: Introduce am654 gigabit eth switch subsystem driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 6da018c0f9d5..d1e452b6b43c 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -722,6 +722,9 @@ static int am65_cpsw_phy_init(struct udevice *dev)
 	u32 supported = PHY_GBIT_FEATURES;
 	int ret;
 
+	if (!priv->has_phy || !cpsw_common->bus)
+		return 0;
+
 	phydev = phy_connect(cpsw_common->bus,
 			     priv->phy_addr,
 			     priv->dev,
-- 
2.44.0

