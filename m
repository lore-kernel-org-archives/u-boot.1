Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D879C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0078815B;
	Mon, 15 Apr 2024 23:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mtMSLJU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9E48812F; Mon, 15 Apr 2024 23:27:55 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83C2878E2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRmth001227;
 Mon, 15 Apr 2024 16:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713216468;
 bh=0OgbSDst028wUmuSCl3sD8bzJIpmMtVHlDOOtVd5ZEc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mtMSLJU92OEAUwSBd/AKVkzD2NC3wQgtJUSN5hvI1LtI44Ni2MqGHzMTjY70WXoVJ
 uObX0HziSPLJLfSBU4HQBgWbtWnb4E3VGTJ/+ZfHGR/dwZNK1rtl2IE0GRMjRgrgEx
 HDdFTJX6hFIFJN18l2zKql9c4qe+Awk3bW0gI6R0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FLRmDY067163
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 16:27:48 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 16:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 16:27:48 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRlu6070400;
 Mon, 15 Apr 2024 16:27:47 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/5] mmc: am654_sdhci: Fix OTAP/ITAP delay values
Date: Mon, 15 Apr 2024 16:27:44 -0500
Message-ID: <20240415212747.2678974-3-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415212747.2678974-1-jm@ti.com>
References: <20240415212747.2678974-1-jm@ti.com>
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

From: Nitin Yadav <n-yadav@ti.com>

U-Boot is failing to boot class U1 UHS SD cards due to incorrect
OTAP and ITAP delay select values. Update OTAP and ITAP delay select
values from DT.

Fixes: c7d106b4eb3 ("mmc: am654_sdhci: Update output tap delay writes")
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index e5ad00e2531..1dd032e1e36 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -513,12 +513,27 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 {
 	struct udevice *dev = host->mmc->dev;
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
-	u32 otap_del_sel, mask, val;
+	int mode = host->mmc->selected_mode;
+	u32 otap_del_sel;
+	u32 itap_del_sel;
+	u32 mask, val;
+
+	otap_del_sel = plat->otap_del_sel[mode];
 
-	otap_del_sel = plat->otap_del_sel[host->mmc->selected_mode];
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
+	val = (1 << OTAPDLYENA_SHIFT) |
+	      (otap_del_sel << OTAPDLYSEL_SHIFT);
+
+	itap_del_sel = plat->itap_del_sel[mode];
+
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val = (1 << ITAPDLYENA_SHIFT) |
+	      (itap_del_sel << ITAPDLYSEL_SHIFT);
+
+	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
 	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 
 	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   plat->clkbuf_sel);
@@ -572,7 +587,7 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
 	 * Remove the corresponding capability if an otap-del-sel
 	 * value is not found
 	 */
-	for (i = MMC_HS; i <= MMC_HS_400; i++) {
+	for (i = MMC_LEGACY; i <= MMC_HS_400; i++) {
 		ret = dev_read_u32(dev, td[i].otap_binding,
 				   &plat->otap_del_sel[i]);
 		if (ret) {
-- 
2.43.2

