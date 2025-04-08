Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C9C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 17:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171BA82CE7;
	Tue,  8 Apr 2025 19:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mswgxnSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F23782B8D; Tue,  8 Apr 2025 19:05:35 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0F282B8E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 19:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5ReH1268887
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744131928;
 bh=bL78l3nvFSVCBHxpbosVX94ZCUaI0Ikg7BPkJAPhqIg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mswgxnSPO7aQ1s5hedmGS36JsM6Lo9RljGE9Z8UlYOwju6Ns/OPFTKWWzQNVXv9E2
 oUhP8+aQygeffHB8sZARTcUZbI28ugRhQGxjj5mM41Xs/OoZoLfCr++AIWsYE4nteL
 kAzRTay8S06oRRynXJpjZpSaLI6GU3RcB/wulmb0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5R3r112761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 12:05:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 12:05:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 12:05:27 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538H5RjN105590;
 Tue, 8 Apr 2025 12:05:27 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/5] mmc: am654_sdhci: Add MMC_HS_52 to timing data
Date: Tue, 8 Apr 2025 12:05:23 -0500
Message-ID: <20250408170527.2832563-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408170527.2832563-1-jm@ti.com>
References: <20250408170527.2832563-1-jm@ti.com>
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

