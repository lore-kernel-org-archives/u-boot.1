Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDA4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5116F886BD;
	Thu, 18 Apr 2024 21:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aVOCKJy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E5D886AB; Thu, 18 Apr 2024 21:01:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC31F886BA
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ102a129065;
 Thu, 18 Apr 2024 14:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713466860;
 bh=yWTAowAuVH5wJ2HK+fTZK43Z2aj6r071yqINXkWfmFQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aVOCKJy+6IAIuqeUdJ4VngPExQ8TLUt5tkaVGDlndEwUVHk0gz8N94nMzArFxc64t
 Lu9SvNoWKe69EUxMHnfYikA4SAtGCjQYvAAXugKvkvok3D/wGOB6le2Tg5FSnIXq7+
 UFekAjBNeWrh9klR8Fq1/JE88xs2V5o6m/nrH1W0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IJ10Ut024812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 14:01:00 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 14:01:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 14:01:00 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10w1036318;
 Thu, 18 Apr 2024 14:01:00 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store
 itapdlyena bit
Date: Thu, 18 Apr 2024 14:00:58 -0500
Message-ID: <20240418190100.1289150-4-jm@ti.com>
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

Set itap_del_ena if ITAPDLY is found in DT or if the tuning
algorithm was executed and found the optimal ITAPDLY. Add the
functionality to save ITAPDLYENA that can be referenced later
by storing the bit in array itap_del_ena[].

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Use ENABLE macro instead of 0x1
---
 drivers/mmc/am654_sdhci.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index becb3550899..62007ebd0f4 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -85,6 +85,8 @@
 #define AM654_SDHCI_MIN_FREQ	400000
 #define CLOCK_TOO_SLOW_HZ	50000000
 
+#define ENABLE	0x1
+
 struct am654_sdhci_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
@@ -92,6 +94,7 @@ struct am654_sdhci_plat {
 	bool non_removable;
 	u32 otap_del_sel[MMC_MODES_END];
 	u32 itap_del_sel[MMC_MODES_END];
+	u32 itap_del_ena[MMC_MODES_END];
 	u32 trm_icp;
 	u32 drv_strength;
 	u32 strb_sel;
@@ -223,8 +226,10 @@ static int am654_sdhci_setup_dll(struct am654_sdhci_plat *plat,
 }
 
 static void am654_sdhci_write_itapdly(struct am654_sdhci_plat *plat,
-				      u32 itapdly)
+				      u32 itapdly, u32 enable)
 {
+	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   enable << ITAPDLYENA_SHIFT);
 	/* Set ITAPCHGWIN before writing to ITAPDLY */
 	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
 			   1 << ITAPCHGWIN_SHIFT);
@@ -242,7 +247,8 @@ static void am654_sdhci_setup_delay_chain(struct am654_sdhci_plat *plat,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(plat->base, PHY_CTRL5, mask, val);
 
-	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode]);
+	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
+				  plat->itap_del_ena[mode]);
 }
 
 static int am654_sdhci_set_ios_post(struct sdhci_host *host)
@@ -443,6 +449,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	struct udevice *dev = mmc->dev;
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
 	struct window fail_window[ITAPDLY_LENGTH];
+	int mode = mmc->selected_mode;
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
@@ -450,11 +457,10 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
-	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
+	plat->itap_del_ena[mode] = ENABLE;
 
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		am654_sdhci_write_itapdly(plat, itap);
+		am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
 
 		curr_pass = !mmc_send_tuning(mmc, opcode);
 
@@ -478,7 +484,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
 					  plat->dll_enable);
 
-	am654_sdhci_write_itapdly(plat, itap);
+	am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
 
 	return 0;
 }
@@ -515,6 +521,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
 	int mode = host->mmc->selected_mode;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
 	u32 itap_del_sel;
 	u32 mask, val;
 
@@ -524,10 +531,11 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 	val = (1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
+	itap_del_ena = plat->itap_del_ena[mode];
 	itap_del_sel = plat->itap_del_sel[mode];
 
 	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
-	val |= (1 << ITAPDLYENA_SHIFT) |
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) |
 	       (itap_del_sel << ITAPDLYSEL_SHIFT);
 
 	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
@@ -599,9 +607,13 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
 			cfg->host_caps &= ~td[i].capability;
 		}
 
-		if (td[i].itap_binding)
-			dev_read_u32(dev, td[i].itap_binding,
-				     &plat->itap_del_sel[i]);
+		if (td[i].itap_binding) {
+			ret = dev_read_u32(dev, td[i].itap_binding,
+					   &plat->itap_del_sel[i]);
+
+			if (!ret)
+				plat->itap_del_ena[i] = ENABLE;
+		}
 	}
 
 	return 0;
-- 
2.43.2

