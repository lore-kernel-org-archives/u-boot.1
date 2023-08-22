Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92515EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86CD864B1;
	Tue, 22 Aug 2023 20:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EV+gB95j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1AAC8648F; Tue, 22 Aug 2023 20:41:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9D986487
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfe2S050148;
 Tue, 22 Aug 2023 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692729700;
 bh=UCYqb7N5fXeECmiyy47tol6cTC9ITHGMLN8lUT0YzUw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EV+gB95jWKHGVvvqx/7XsLykTullSWwpPLxEiA0xjTiQQ7bBGvnEGxwAFP1IOJxua
 4hexnTPWJzhR3Sp0/aqKn1xv6Ap6FYpvGJWeJqUZsPaJjXsfnz2ceS6SOfmnG5uVQc
 XOcFdwa95PgB+57HCy5WFHLU7CKE8t46rUTIXUmc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MIfeMc104571
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:41:40 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:41:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:41:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfe3b002164;
 Tue, 22 Aug 2023 13:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nitin Yadav <n-yadav@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 4/8] drivers: mmc: am654_sdhci: Update OTAP/ITAP delay
Date: Tue, 22 Aug 2023 13:41:31 -0500
Message-ID: <20230822184135.2328409-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822184135.2328409-1-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
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

U-Boot is fail to boot class U1 UHS SD cards (such as microcenter)
due to incorrect OTAP and ITAP delay select values. Update OTAP and
ITAP delay select values based on recommeded RIOT values to fix boot
issue.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Picked up from TI u-boot
New patch in the series

 drivers/mmc/am654_sdhci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index fd667aeafdaa..d0b51c0707d4 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -442,12 +442,18 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 {
 	struct udevice *dev = host->mmc->dev;
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
-	u32 otap_del_sel, mask, val;
+	u32 otap_del_sel, itap_del_sel, mask, val;
 
 	otap_del_sel = plat->otap_del_sel[host->mmc->selected_mode];
-	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
+	itap_del_sel = plat->itap_del_sel[host->mmc->selected_mode];
+	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK | ITAPDLYSEL_MASK |
+		ITAPDLYENA_MASK;
+	val = (1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT) |
+		(1 << ITAPDLYENA_SHIFT) | (itap_del_sel << ITAPDLYSEL_SHIFT);
+	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
 	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 
 	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   plat->clkbuf_sel);
@@ -501,7 +507,7 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
 	 * Remove the corresponding capability if an otap-del-sel
 	 * value is not found
 	 */
-	for (i = MMC_HS; i <= MMC_HS_400; i++) {
+	for (i = MMC_LEGACY; i <= MMC_HS_400; i++) {
 		ret = dev_read_u32(dev, td[i].otap_binding,
 				   &plat->otap_del_sel[i]);
 		if (ret) {
-- 
2.40.0

