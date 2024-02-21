Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C68C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C1F87D08;
	Wed, 21 Feb 2024 08:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wdtCGkPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3CE87F67; Wed, 21 Feb 2024 08:28:50 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D7B87CAB
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41L7ScZn035186;
 Wed, 21 Feb 2024 01:28:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708500518;
 bh=Oc5p0rae9czus8WLrw9+UF58qnW5RIAuT5MjtfUu8G0=;
 h=From:To:CC:Subject:Date;
 b=wdtCGkPIqQrJu5794aUpfsd6XlXIrXE3VZPNqpxDkzgRMu/3ysm+9hyUX3TWM8oBA
 5yMofMoW6OwQTxR2f2QC374F98YDVFWWrYPSvzT1mgOGyhpO2z7DC5AfXASmwJiNpt
 wP91j3m9eLzdNdcoRc97olTNjU/UhrOxad0qqmNU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41L7ScaB047586
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Feb 2024 01:28:38 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 01:28:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 01:28:38 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41L7SX96019849;
 Wed, 21 Feb 2024 01:28:34 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <danishanwar@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>,
 <matthias.schiffer@ew.tq-group.com>, <r-gunasekaran@ti.com>,
 <u-boot@lists.denx.de>, <j-humphreys@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] dma: ti: k3-udma: Fix ring_idx to pair k3 nav rings"
Date: Wed, 21 Feb 2024 12:58:25 +0530
Message-ID: <20240221072825.3645303-1-u-kumar1@ti.com>
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
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
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
-- 
2.34.1

