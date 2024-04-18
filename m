Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D8AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E4F886B4;
	Thu, 18 Apr 2024 21:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sH3tUDen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373AB886B4; Thu, 18 Apr 2024 21:01:06 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F110886B9
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10QJ088938;
 Thu, 18 Apr 2024 14:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713466860;
 bh=EPp3RjK6anYveYCqzYCxz9nUt1xebZOtk8OuFzgnwaU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sH3tUDenofWqJ8x6EHQmUtHdF8cIs6Rk6RRj93Ov+Cm26gHaeR118nBw/sO472Kpm
 D6IHcdcGb4+70Pmzol0q3jaUAF1kLZbffh6VwViILESx4miUzeBQ+Q5pF4r+StarsN
 BNQ8ZCZ0jlwThftjnyq9rGp63ckCTtJMPTWmpzIU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IJ100a086062
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 14:01:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 14:01:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 14:01:00 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10w0036318;
 Thu, 18 Apr 2024 14:01:00 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 2/5] mmc: am654_sdhci: Fix OTAP/ITAP delay values
Date: Thu, 18 Apr 2024 14:00:57 -0500
Message-ID: <20240418190100.1289150-3-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418190100.1289150-1-jm@ti.com>
References: <20240418190100.1289150-1-jm@ti.com>
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
Changes since v1:
- Fix assignment to val variable in j721e_4bit_sdhci_set_ios_post()
---
 drivers/mmc/am654_sdhci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 7e41dd91f8e..becb3550899 100644
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
+	val |= (1 << ITAPDLYENA_SHIFT) |
+	       (itap_del_sel << ITAPDLYSEL_SHIFT);
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

