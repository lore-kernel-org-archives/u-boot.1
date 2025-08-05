Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E408AC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DAA83890;
	Tue,  5 Aug 2025 18:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FUcfV04p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF94383EFC; Tue,  5 Aug 2025 18:14:24 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DFC8388B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575GEJmk4078255;
 Tue, 5 Aug 2025 11:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754410459;
 bh=hnNZzlM68YI/UhECOJmcOgFaeO5ExNmemThk1QMf/yU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FUcfV04pRqIzTD1zzQzADf6gmb+MAayXji2b3yCJBLpADgfQ1c2tzhgs9HRTft1EW
 HphOpvZP7QvgCt0+nNH7sVo0N8GjlRQTYCYysnbjmalVs/zfukVjYV6FLqekY+WvNO
 nu29W7nc7NCWRPWNhXFkf9g5qobX5qWWR65VeO0c=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575GEJF93567697
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 5 Aug 2025 11:14:19 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 11:14:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 11:14:19 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575GEJqu2408213;
 Tue, 5 Aug 2025 11:14:19 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 2/2] mmc: am654_sdhci: Disable HS400 for AM62P SR1.0 and
 SR1.1
Date: Tue, 5 Aug 2025 11:14:19 -0500
Message-ID: <20250805161419.1781935-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805161419.1781935-1-jm@ti.com>
References: <20250805161419.1781935-1-jm@ti.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

