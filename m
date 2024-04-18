Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25437C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B361886C5;
	Thu, 18 Apr 2024 21:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SxxxzZaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196AF886B8; Thu, 18 Apr 2024 21:01:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853CF886BE
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10aF076069;
 Thu, 18 Apr 2024 14:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713466861;
 bh=mH9UDBw3qfWY+Y0tKdL8xMUHgyiHCWTW/PrF0GLk4NQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SxxxzZaQwVGSiioL3LFSAZFtmDX6Y3XsWsEYc+jLIaO/OaT4ovLmhnHoB9K8q6q6n
 REfHiHxJx26TeGNmo7aX0p6HOpjUnXaDbjNe9UmSxFoAWlTiuldsjPWHDAnGiF6Pa3
 9UM4A9Lqyios9HLV9JVAb68ZTLejkEqddHMtuyFs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IJ10o4086071
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 14:01:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 14:01:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 14:01:00 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10w3036318;
 Thu, 18 Apr 2024 14:01:00 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 5/5] mmc: am654_sdhci: Fix ITAPDLY for HS400 timing
Date: Thu, 18 Apr 2024 14:01:00 -0500
Message-ID: <20240418190100.1289150-6-jm@ti.com>
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

At HS400 mode the ITAPDLY value is that from High Speed mode
which is incorrect and may cause boot failures.

The ITAPDLY for HS400 speed mode should be the same as ITAPDLY
as HS200 timing after tuning is executed. Add the functionality
to save ITAPDLY from HS200 tuning and save as HS400 ITAPDLY.

Fixes: c964447ea3d6 ("mmc: am654_sdhci: Add support for input tap delay")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Use ENABLE macro instead of 0x1
---
 drivers/mmc/am654_sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index e1047812fa8..fadab7d40bb 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -295,6 +295,11 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
 			return ret;
 
 		plat->dll_enable = true;
+		if (mode == MMC_HS_400) {
+			plat->itap_del_ena[mode] = ENABLE;
+			plat->itap_del_sel[mode] = plat->itap_del_sel[mode - 1];
+		}
+
 		am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
 					  plat->itap_del_ena[mode]);
 	} else {
@@ -486,6 +491,9 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
 					  plat->dll_enable);
 
+	/* Save ITAPDLY */
+	plat->itap_del_sel[mode] = itap;
+
 	am654_sdhci_write_itapdly(plat, itap, plat->itap_del_ena[mode]);
 
 	return 0;
-- 
2.43.2

