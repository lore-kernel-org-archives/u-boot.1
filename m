Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBF8C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B318799E;
	Fri, 12 Jan 2024 07:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vfdz93qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A308799C; Fri, 12 Jan 2024 07:48:23 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CF1871C3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C6mJPK057303;
 Fri, 12 Jan 2024 00:48:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705042099;
 bh=kqN+9jd02zjICUdnwxDvJTRXE/w0ae/glA2Zlt8jqSo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vfdz93qu0Df6B0cpzfbwCBUcxqgFlvO8ez+qlgR2a1dXVLHdLivw/mz+XH2ztVPl9
 GIo2Yidf3mDRsZpN9LRUf/cHNPgmOk3uz8K8lY+asYdc/Uic7hF4w8fY9amukv8vV3
 Wv+e1KLi4s8Ol25Ic+LUYDyIqu59a99tUeYacxAM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C6mJNT071838
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 00:48:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 00:48:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 00:48:18 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C6lxsC063681; 
 Fri, 12 Jan 2024 00:48:16 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 05/10] dma: ti: k3-udma: Add support for native configuration
 of chan/flow
Date: Fri, 12 Jan 2024 12:17:54 +0530
Message-ID: <20240112064759.1801600-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112064759.1801600-1-s-vadapalli@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
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
---
 drivers/dma/ti/k3-udma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 8a62d63dfe..3bd1e7668b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2110,6 +2110,9 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	if (ret)
 		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_tchan_raw(uc);
+
 	return ret;
 }
 
@@ -2158,6 +2161,9 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 		dev_err(ud->dev, "flow%d config failed: %d\n", uc->rflow->id,
 			ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_rchan_raw(uc);
+
 	return ret;
 }
 
-- 
2.34.1

