Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1EDC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 22:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289FC82C2F;
	Wed, 21 May 2025 00:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t0t0p7ZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9761482CD2; Wed, 21 May 2025 00:59:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612E382BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 00:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54KMxGVl135940;
 Tue, 20 May 2025 17:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747781956;
 bh=9V1C1jqmxUcl6jhNCmnbYl3J3xekwV2oUfrjrDubkII=;
 h=From:To:CC:Subject:Date;
 b=t0t0p7ZJqlxm/qYQBxbxpa03wId+T9S5NDEMpWbWgtlWOhK9gfy0iUSn5ukeGbd7b
 LfAzskCmhTEfd0it7s9dNor+JPVMGwcdQ94l5cCiWyDTAsf4dOrhg9t6/Nwv+GwGY2
 F3C/+5seWDWlKc6zVsyng8Tlkvxa3bB9yIwmM8hw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54KMxGD51672528
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 20 May 2025 17:59:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 May 2025 17:59:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 May 2025 17:59:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54KMxFk5123638;
 Tue, 20 May 2025 17:59:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when < MMC_HS_52
Date: Tue, 20 May 2025 17:59:15 -0500
Message-ID: <20250520225915.146026-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
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

This clears UHS_MODE_SELECT for timing modes < MMC_HS_52.

When initializing to HS400 mode, the host controller downgrades to non-uhs
modes so clear UHS_MODE_SELECT at modes < MMC_HS_52.

This fixes eMMC writes on j7200 EVM.

Fixes: 6067aa66b3bb ("mmc: am654_sdhci: Add am654_sdhci_set_control_reg")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 0df3568f073..d3c8f94dd0c 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -527,11 +527,16 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 void am654_sdhci_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
+	u32 reg;
 
+	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	reg &= ~SDHCI_CTRL_UHS_MASK;
 	sdhci_set_voltage(host);
 
 	if (mmc->selected_mode > MMC_HS_52)
 		sdhci_set_uhs_timing(host);
+	else
+		sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
 }
 
 const struct sdhci_ops am654_sdhci_ops = {
-- 
2.49.0

