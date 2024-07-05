Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3B5C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F7C88970;
	Fri,  5 Jul 2024 06:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N72x57Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CA18897C; Fri,  5 Jul 2024 06:51:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F1B88969
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654ogJN055675;
 Thu, 4 Jul 2024 23:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155042;
 bh=bVeLflRduyqiCfJ2QkhBBQcLpWBptX3w36IAmJgLZJg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=N72x57NhYsyrbDcoZPNsUqsZAO4sZ0ln9MDtr/COiTbFAb7rlAwvhkwpXKKnABbcr
 xdMmu4uhUh5kbiOubDx4xInAiOEyVsW1VAORrYmY9BefYjUXdbP/lJSCA0vS8aJZwE
 g0gdrV/wOwc26eWD5dBdBnLy0jb+wrG7yj1fWOn0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654ogDW024064
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:41 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654ofOw112287;
 Thu, 4 Jul 2024 23:50:41 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 05/10] dma: ti: k3-udma: Add support for native
 configuration of chan/flow
Date: Fri, 5 Jul 2024 10:20:25 +0530
Message-ID: <20240705045030.1141934-6-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705045030.1141934-1-c-vankar@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

In absence of Device Manager (DM) services such as at R5 SPL stage,
driver will have to natively setup TCHAN/RCHAN/RFLOW cfg registers.
Existing UDMA driver performed the above mentioned configuration
for UDMA. Add similar configuration for PKTDMA here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-6-c-vankar@ti.com/

Changes from v2 to v3:
- No changes.

 drivers/dma/ti/k3-udma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index da341a2477..14c3999035 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2119,6 +2119,9 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	if (ret)
 		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_tchan_raw(uc);
+
 	return ret;
 }
 
@@ -2167,6 +2170,9 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 		dev_err(ud->dev, "flow%d config failed: %d\n", uc->rflow->id,
 			ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_rchan_raw(uc);
+
 	return ret;
 }
 
-- 
2.34.1

