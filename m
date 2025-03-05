Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E9EC282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 08:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E88B807B1;
	Wed,  5 Mar 2025 09:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w+cf89ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB12807D9; Wed,  5 Mar 2025 09:41:42 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48CC800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 09:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5258fY113248325
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Mar 2025 02:41:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741164094;
 bh=yjmMOxQ5mwsHMtkS0AzfGh5Ypx4EMwM+RU7su+mIRwc=;
 h=From:To:CC:Subject:Date;
 b=w+cf89lyCY9j69eqG6u5nYgkLVE6LrGc1ZCJos9opUr0Znb7mRk6+HBKatr0VKSMv
 K50HahQNOUSM2sB9HN+onnVeuuSmufso7PSBQdcJLp60wsahsu0Epqj7lnUr6Xnj3S
 is7Wp4QJtTN4YociVKltC+h3wN/451zIsjJ6FQIs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5258fYZC055675;
 Wed, 5 Mar 2025 02:41:34 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 02:41:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 02:41:34 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com
 [10.24.69.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5258fWxl062600;
 Wed, 5 Mar 2025 02:41:33 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 <u-boot@lists.denx.de>
Subject: [PATCH] memory: ti-gpmc: Alloc per driver private struct
Date: Wed, 5 Mar 2025 14:11:30 +0530
Message-ID: <20250305084130.2677310-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.48.1
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

Driver uses dev_get_priv() but never allocates it in its
declaration leading to various crashes. Fix this by explicitly
allocating the storage.

Fixes: 9b0b5648d6e4 ("memory: Add TI GPMC driver")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/memory/ti-gpmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index e979c431e333..29e02f12ae03 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -1242,4 +1242,5 @@ U_BOOT_DRIVER(ti_gpmc) = {
 	.of_match = gpmc_dt_ids,
 	.probe  = gpmc_probe,
 	.flags  = DM_FLAG_ALLOC_PRIV_DMA,
+	.priv_auto = sizeof(struct ti_gpmc),
 };
-- 
2.48.1

