Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2B4C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FFF826AD;
	Tue, 15 Apr 2025 00:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KQgXzguO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239FD8297E; Tue, 15 Apr 2025 00:44:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07F382836
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvE62881577
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 17:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744670637;
 bh=eZPaM71m4irbVc2zOxqZv4Hf2y40sN63/c0d8pmSBq8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KQgXzguOFSgkh7wmCVUjlvDwSGRQT7ombk2c3gGxOEfBIxVJ1ObdSY6ODiwd9KtvK
 se7hiqfRV6YRBaD1pAKwBlDamxu4Y+dgr5XiVOJ0t6f1qpHW8wFZvAFVHOsSMDSkOt
 DA8R7VQjvPytXOOBRVhTEH/JPsfidezxlLBvfcGE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvs5118171
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 17:43:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 17:43:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 17:43:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EMhvv1064149;
 Mon, 14 Apr 2025 17:43:57 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, open
 list <u-boot@lists.denx.de>
Subject: [PATCH v2 2/5] mmc: am654_sdhci: Fix HIGH_SPEED_ENA
Date: Mon, 14 Apr 2025 17:43:54 -0500
Message-ID: <20250414224357.1555064-3-jm@ti.com>
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

High Speed enable bit switches data launch from the falling
clock edge (half cycle timing) to the rising clock edge (full
cycle timing). For all SD UHS modes, data launch must happen
at the rising clock edge, so set HIGH_SPEED_ENA for SDR12 and
SDR25 modes. For all HS modes, data launch must happen at the
falling clock edge, so do not set HIGH_SPEED_ENA for MMC_HS_52.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
 drivers/mmc/am654_sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index e4fa8a88565..28d82afd012 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -412,8 +412,7 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
 		 */
 		case SD_HS:
 		case MMC_HS:
-		case UHS_SDR12:
-		case UHS_SDR25:
+		case MMC_HS_52:
 			val &= ~SDHCI_CTRL_HISPD;
 		default:
 			break;
-- 
2.49.0

