Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3DC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 23:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE25284015;
	Tue,  5 Aug 2025 01:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h4FrQCW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B5F8407D; Tue,  5 Aug 2025 01:37:27 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E152D8402F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 01:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 574NbJln153981;
 Mon, 4 Aug 2025 18:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754350639;
 bh=oqaAZVqdrvpxyodK7SdgJGSPxEhJBWX0DGBuDZYgilk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h4FrQCW8rKCY7Qk6eXeTNZSVVR2eDgThskMeKnDwxOME3viagJfSAEughmAX0bLan
 K3SY0FlFwEIGIGUPC+yxLYhz/auJWz5R7jhX1L0nplKWiYIruH/IiRhW5JA5WJeg1T
 4SCBm9oC044F6yGbmJcxJqXShpwJWKCmDfkgX3lk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 574NbJTu3167855
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 4 Aug 2025 18:37:19 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 4
 Aug 2025 18:37:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 4 Aug 2025 18:37:18 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 574NbIRK898934;
 Mon, 4 Aug 2025 18:37:18 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/2] mmc: am654_sdhci: Disable HS400 for AM62P SR1.0 and SR1.1
Date: Mon, 4 Aug 2025 18:37:18 -0500
Message-ID: <20250804233718.1471877-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804233718.1471877-1-jm@ti.com>
References: <20250804233718.1471877-1-jm@ti.com>
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

AM62P SR1.0 and SR1.1 do not support HS400 due to errata i2458 [0] so
add functionality to detect these SoC revisions and disable HS400.

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index d3c8f94dd0c..7e4e7e1b90e 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -629,6 +629,12 @@ const struct soc_attr am654_sdhci_soc_attr[] = {
 	{/* sentinel */}
 };
 
+static struct soc_attr sdhci_am654_descope_hs400[] = {
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.1" },
+	{ /* sentinel */ }
+};
+
 static int sdhci_am654_get_otap_delay(struct udevice *dev,
 				      struct mmc_config *cfg)
 {
@@ -715,6 +721,12 @@ static int am654_sdhci_probe(struct udevice *dev)
 		host->ops = soc_drv_data->ops;
 	}
 
+	soc = soc_device_match(sdhci_am654_descope_hs400);
+	if (soc) {
+		dev_err(dev, "Disable descoped HS400 mode for this silicon revision\n");
+		plat->cfg.host_caps &= ~(MMC_MODE_HS400 | MMC_MODE_HS400_ES);
+	}
+
 	host->mmc->priv = host;
 	upriv->mmc = host->mmc;
 
-- 
2.49.0

