Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A12E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC248021A;
	Wed, 18 Dec 2024 14:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nRfPE/Gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558908021D; Wed, 18 Dec 2024 14:00:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E6E80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BID0o9A011655;
 Wed, 18 Dec 2024 07:00:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734526850;
 bh=gOBRW7XYVM6ccbbD+aXtFB2p2o12FQsgQ2ndcEaOwRk=;
 h=From:To:CC:Subject:Date;
 b=nRfPE/Gu+MlGdUepFCIPUWW9HI7PNfouhM4EdzOE3D7raqlawWI2TbMIVpjc2IntA
 B9MYMKVr5Yx0WDNZUyxlgxBQFRaS1InnYaVry3mu//736REGUb0GobowHnN/3SeY/c
 F9EAne1fvGhpuPNdxqUk88fjD10CokW+38dLIr4c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BID0o7n117826
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 07:00:50 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:00:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:00:50 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BID0lT3020891;
 Wed, 18 Dec 2024 07:00:47 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2] dma: ti: k3-udma: Fix BCDMA probe by adding check for
 MMR_RFLOW
Date: Wed, 18 Dec 2024 18:30:45 +0530
Message-ID: <20241218130045.2070314-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

RFLOW config related MMR does not exist incase of BCDMA.
Add check to bypass the RFLOW MMR extraction.
Without this, the probe sequence fails checking for
the MMR_RFLOW region, which is valid only for packet based
DMA and obselete for BCDMA.

Fixes: 5abb694d6016 ("dma: ti: k3-udma: Add support for native configuration of chan/flow")
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
---
v2 <--> v1
Add Fixes tag.

 drivers/dma/ti/k3-udma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index dac4023ccfd..3013c4741d0 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1331,6 +1331,8 @@ static int udma_get_mmrs(struct udevice *dev)
 			continue;
 		if (i == MMR_RCHANRT && ud->rchan_cnt == 0)
 			continue;
+		if (i == MMR_RFLOW && ud->match_data->type == DMA_TYPE_BCDMA)
+			continue;
 
 		ud->mmrs[i] = dev_read_addr_name_ptr(dev, mmr_names[i]);
 		if (!ud->mmrs[i])
-- 
2.34.1

