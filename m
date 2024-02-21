Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E75AC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 14:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C6087D91;
	Wed, 21 Feb 2024 15:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hl0oqmJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1928587D9F; Wed, 21 Feb 2024 15:24:07 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3858C87D78
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 15:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41LENwit058008;
 Wed, 21 Feb 2024 08:23:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708525438;
 bh=PG7BNs3dy945jaVQR2frhWRC+ClCkh27MPd9VXa9OVE=;
 h=From:To:CC:Subject:Date;
 b=hl0oqmJ55lHsidbTDU5fub6dKLz2D4XTV4a2Ggeu8xqGbwJ22/ftlMtGczw/GqMBd
 JLOTSVtOqpQ7h23frVxLgmwyCzU8CdX3m11WPV4wxikbDMMWZd1aRigh8T0Z0BH2oZ
 J+IES5ifKwpzG8EDDhymFD9Evyjyjuy/BfZKpafY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41LENwlY023046
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Feb 2024 08:23:58 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 08:23:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 08:23:57 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41LENsDf062126;
 Wed, 21 Feb 2024 08:23:54 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <danishanwar@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>,
 <matthias.schiffer@ew.tq-group.com>, <r-gunasekaran@ti.com>,
 <u-boot@lists.denx.de>, <j-humphreys@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2] dma: ti: k3-udma: Fix ring_idx to pair k3 nav rings
Date: Wed, 21 Feb 2024 19:53:44 +0530
Message-ID: <20240221142343.3652840-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

ring_idx was not correctly assigned in case of tflow_id is zero.
Which leads to wrong pairing of DMA for drivers like OSPI.

Fixes: 4312a1dfca26 ("dma: ti: k3-udma: Use ring_idx to pair k3 nav rings")
Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog
Changes in v2
- Removed Trailing quote in subject line
- Picked Reviewed-by Tag from Jai
link to v1
https://lore.kernel.org/all/20240221072825.3645303-1-u-kumar1@ti.com/

 drivers/dma/ti/k3-udma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index eea9ec9659..39866ffff8 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -884,10 +884,10 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 		return ret;
 
 	tchan = uc->tchan;
-	if (tchan->tflow_id >= 0)
+	if (tchan->tflow_id > 0)
 		ring_idx = tchan->tflow_id;
 	else
-		ring_idx = ud->bchan_cnt + tchan->id;
+		ring_idx = tchan->id;
 
 	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
 						&uc->tchan->t_ring,

base-commit: 1817afe30f1549d4d2145bd35de0427e9a7bfdfb
-- 
2.34.1

