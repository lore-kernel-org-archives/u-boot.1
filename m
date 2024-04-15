Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7DAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B84D888145;
	Mon, 15 Apr 2024 23:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bGQR/utm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF03888145; Mon, 15 Apr 2024 23:27:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C84987527
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRmwA053753;
 Mon, 15 Apr 2024 16:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713216468;
 bh=gFEBgSp6X/Dq0e8PBUCas4SUnoviwRQG5+0CqvwbBtU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bGQR/utmo2sMBJr91vTMtF2xwdNYjgh9cmXq8VZLUQExveWcgl7dO2VqCsI5+TglE
 c6lVHB4CXd7vVn2FGp32hbWl6JCirJYYQKWeYQeE2MuP/XRNNplJ5Ai6cANjYZI8f3
 ZE+cezQfjU/QLVOpH/sn6MX6L9sgwWO/td0XyN7Y=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FLRmDZ067163
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 16:27:48 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 16:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 16:27:47 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRlu7070400;
 Mon, 15 Apr 2024 16:27:47 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/5] mmc: am654_sdhci: Add itap_del_ena[] to store itapdlyena
 bit
Date: Mon, 15 Apr 2024 16:27:45 -0500
Message-ID: <20240415212747.2678974-4-jm@ti.com>
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

Set itap_del_ena if ITAPDLY is found in DT or if the tuning
algorithm was executed and found the optimal ITAPDLY. Add the
functionality to save ITAPDLYENA that can be referenced later
by storing the bit in array itap_del_ena[].

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 1dd032e1e36..38f1ad28ec4 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -92,6 +92,7 @@ struct am654_sdhci_plat {
 	bool non_removable;
 	u32 otap_del_sel[MMC_MODES_END];
 	u32 itap_del_sel[MMC_MODES_END];
+	u32 itap_del_ena[MMC_MODES_END];
 	u32 trm_icp;
 	u32 drv_strength;
 	u32 strb_sel;
@@ -223,8 +224,10 @@ static int am654_sdhci_setup_dll(struct am654_sdhci_plat *plat,
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
@@ -242,7 +245,8 @@ static void am654_sdhci_setup_delay_chain(struct am654_sdhci_plat *plat,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(plat->base, PHY_CTRL5, mask, val);
 
-	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode]);
+	am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
+				  plat->itap_del_ena[mode]);
 }
 
 static int am654_sdhci_set_ios_post(struct sdhci_host *host)
@@ -443,6 +447,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	struct udevice *dev = mmc->dev;
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
 	struct window fail_window[ITAPDLY_LENGTH];
+	int mode = mmc->selected_mode;
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
@@ -450,11 +455,10 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
-	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
+	plat->itap_del_ena[mode] = 0x1;
 
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		am654_sdhci_write_itapdly(plat, itap);
+		am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
 
 		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);
 
@@ -478,7 +482,7 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
 					  plat->dll_enable);
 
-	am654_sdhci_write_itapdly(plat, itap);
+	am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
 
 	return 0;
 }
@@ -515,6 +519,7 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
 	int mode = host->mmc->selected_mode;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
 	u32 itap_del_sel;
 	u32 mask, val;
 
@@ -524,10 +529,11 @@ static int j721e_4bit_sdhci_set_ios_post(struct sdhci_host *host)
 	val = (1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
+	itap_del_ena = plat->itap_del_ena[mode];
 	itap_del_sel = plat->itap_del_sel[mode];
 
 	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
-	val = (1 << ITAPDLYENA_SHIFT) |
+	val = (itap_del_ena << ITAPDLYENA_SHIFT) |
 	      (itap_del_sel << ITAPDLYSEL_SHIFT);
 
 	regmap_update_bits(plat->base, PHY_CTRL4, ITAPCHGWIN_MASK,
@@ -599,9 +605,13 @@ static int sdhci_am654_get_otap_delay(struct udevice *dev,
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
+				plat->itap_del_ena[i] = 0x1;
+		}
 	}
 
 	return 0;
-- 
2.43.2

