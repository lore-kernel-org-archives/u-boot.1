Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28603C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF715829B2;
	Tue, 15 Apr 2025 00:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OqstMOxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781F1827A6; Tue, 15 Apr 2025 00:44:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD7F82102
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvrJ2281878
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 17:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744670637;
 bh=5JEpfNTFgNbzNEhf5XtA/6Ak3fi4hoRQaRUGmMbd75U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OqstMOxRT4YOv/GNY/vuW+6jSjq3WZlZyvyFprzgF1/H02t2EC+LzMmqTxj0bLLoB
 fbYI/3iMbYL/GP3i42gO84aSNVLcVJl8l/tmIKqJhi5VaVCKxCCAj1EN34rYYDVXeu
 WS7Q73vKvUF3qxPN3AJdGmR+d0yeZhJznklsQ5Jg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvEo007561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 17:43:57 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 17:43:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 17:43:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EMhvv0064149;
 Mon, 14 Apr 2025 17:43:57 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, open
 list <u-boot@lists.denx.de>
Subject: [PATCH v2 1/5] mmc: am654_sdhci: Add MMC_HS_52 to timing data
Date: Mon, 14 Apr 2025 17:43:53 -0500
Message-ID: <20250414224357.1555064-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414224357.1555064-1-jm@ti.com>
References: <20250414224357.1555064-1-jm@ti.com>
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

This patch adds MMC_HS_52 to the timing data structure.

Previously, this bus mode tap settings were not populated and
were instead populated for MMC_HS which is a different bus mode
up to 26MHz. Since we intended these settings according to the
device data sheet[0] for MMC_HS_52 up to 52MHz, populate MMC_HS
tap settings for MMC_HS_52.

While we are here, fix typo in ti,itap-del-sel-mms-hs.

[0] https://www.ti.com/lit/ds/symlink/am625.pdf Table 7-79
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
 drivers/mmc/am654_sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index b4c60a48d2e..e4fa8a88565 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -125,12 +125,15 @@ static const struct timing_data td[] = {
 	[MMC_LEGACY]	= {"ti,otap-del-sel-legacy",
 			   "ti,itap-del-sel-legacy",
 			   0},
-	[MMC_HS]	= {"ti,otap-del-sel-mmc-hs",
-			   "ti,itap-del-sel-mms-hs",
+	[MMC_HS]	= {"ti,otap-del-sel-mmc-hs26",
+			   "ti,itap-del-sel-mmc-hs26",
 			   MMC_CAP(MMC_HS)},
 	[SD_HS]		= {"ti,otap-del-sel-sd-hs",
 			   "ti,itap-del-sel-sd-hs",
 			   MMC_CAP(SD_HS)},
+	[MMC_HS_52]	= {"ti,otap-del-sel-mmc-hs",
+			   "ti,itap-del-sel-mmc-hs",
+			   MMC_CAP(MMC_HS_52)},
 	[UHS_SDR12]	= {"ti,otap-del-sel-sdr12",
 			   "ti,itap-del-sel-sdr12",
 			   MMC_CAP(UHS_SDR12)},
-- 
2.49.0

