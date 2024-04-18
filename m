Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A73C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 19:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BA5886CF;
	Thu, 18 Apr 2024 21:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oO/wyhuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADBA886B8; Thu, 18 Apr 2024 21:01:09 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB72886BF
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 21:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ11dZ006742;
 Thu, 18 Apr 2024 14:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713466861;
 bh=3LDPhh5eDDPiCvg3pIY0rpONxHfTgzKvji7BAQ7UDqY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oO/wyhuqajrbCm/I9ihYZvP69nsCigc0K+YKS14BcXD/0HPDZCaRsSlEFFFQcXxk5
 j+iEuLUeG/Mbl5XvOAAfDhdKzVaIY4Z4cV2UwbidxAsShghfAcB1AOtOecABih/uLG
 /Jz8IjQxQwnG3TajjMG//pNo/ldwb5pb4SDfXrV0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IJ10LU024815
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 14:01:00 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 14:01:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 14:01:00 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IJ10w2036318;
 Thu, 18 Apr 2024 14:01:00 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 4/5] mmc: am654_sdhci: Set ENDLL=1 for DDR52 mode
Date: Thu, 18 Apr 2024 14:00:59 -0500
Message-ID: <20240418190100.1289150-5-jm@ti.com>
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

According to the device datasheet [0], ENDLL=1 for
DDR52 mode, so call am654_sdhci_setup_dll() and write
itapdly after since we do not carry out tuning.

[0] https://www.ti.com/lit/ds/symlink/am62p.pdf
Fixes: c964447ea3d6 ("mmc: am654_sdhci: Add support for input tap delay")
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changes since v1:
- Add Reviewed-by
---
 drivers/mmc/am654_sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 62007ebd0f4..e1047812fa8 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -289,12 +289,14 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
 
 	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
 
-	if (mode > UHS_SDR25 && speed >= CLOCK_TOO_SLOW_HZ) {
+	if ((mode > UHS_SDR25 || mode == MMC_DDR_52) && speed >= CLOCK_TOO_SLOW_HZ) {
 		ret = am654_sdhci_setup_dll(plat, speed);
 		if (ret)
 			return ret;
 
 		plat->dll_enable = true;
+		am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
+					  plat->itap_del_ena[mode]);
 	} else {
 		am654_sdhci_setup_delay_chain(plat, mode);
 		plat->dll_enable = false;
-- 
2.43.2

