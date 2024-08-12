Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2FC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 11:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBFC884C3;
	Mon, 12 Aug 2024 13:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bF/fxThg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BA28876E; Mon, 12 Aug 2024 13:48:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A00587B77
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBmj5G000992;
 Mon, 12 Aug 2024 06:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723463325;
 bh=Ki++o0ehC57f8Zr11tnl7wfRTynE8JAXBcgP1GBuM1Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bF/fxThgX+XoT6ymZLNDEk9MsO8jPmVy4HaQ1zoswfJIIx1NmElQmHfbZMyYWIK4J
 3x5OVtKmdMTaZjWPO+ouNQsWv1/5S+6pzcs6b+N/Fa4Nc+qBS+tfAxmhhF377jBIHg
 3CiaoANUcKHa3QErxijTi0rmP4JXPnv3fZTRYHoo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBmjEZ091174
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 06:48:45 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:48:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:48:45 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBmiAu129694;
 Mon, 12 Aug 2024 06:48:44 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 05/10] dma: ti: k3-udma: Add support for native
 configuration of chan/flow
Date: Mon, 12 Aug 2024 17:18:42 +0530
Message-ID: <20240812114842.3843676-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812113621.3840652-1-c-vankar@ti.com>
References: <20240812113621.3840652-1-c-vankar@ti.com>
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

Link to v3:
https://lore.kernel.org/r/20240705045030.1141934-6-c-vankar@ti.com/

Changes from v3 to v4:
- No changes.

 drivers/dma/ti/k3-udma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b7e674f218..e23d09e6b8 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2118,6 +2118,9 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	if (ret)
 		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_tchan_raw(uc);
+
 	return ret;
 }
 
@@ -2166,6 +2169,9 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 		dev_err(ud->dev, "flow%d config failed: %d\n", uc->rflow->id,
 			ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_rchan_raw(uc);
+
 	return ret;
 }
 
-- 
2.34.1

