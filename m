Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3CDC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 15:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1358F830F3;
	Thu, 22 May 2025 17:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lBglHEP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CE5830F4; Thu, 22 May 2025 17:05:56 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F050830E9
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 17:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54MF5pYD1844483;
 Thu, 22 May 2025 10:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747926351;
 bh=8y7awMwciyA90lEb46O1c/gPbDoA0vxunZPut8N8u3k=;
 h=From:To:CC:Subject:Date;
 b=lBglHEP4fl/UcVXdrcoa7wCo2YQyglho+oP0vgHhzoScSDN2eiUbbmhDn9ywFUuWC
 X8Flsg7rhN6RVe1TV11bpt1yFjNsrobTfDZPgv6UMWE5zdCSuXyrEUIJHs0u4d0mCh
 OnnK0VBltNqCJ0YjHo6lXVJFEQWQoAZHIX+cNQh8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54MF5oA43585693
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 10:05:51 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 10:05:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 10:05:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54MF5owU086418;
 Thu, 22 May 2025 10:05:50 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2] mmc: am654_sdhci: Clear UHS_MODE_SELECT when <= MMC_HS_52
Date: Thu, 22 May 2025 10:05:50 -0500
Message-ID: <20250522150550.574018-1-jm@ti.com>
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

This clears UHS_MODE_SELECT for timing modes <= MMC_HS_52.

When initializing to HS400 mode, the host controller downgrades to non-uhs
modes so clear UHS_MODE_SELECT at modes <= MMC_HS_52.

This fixes eMMC writes on j7200 EVM.

Fixes: 6067aa66b3bb ("mmc: am654_sdhci: Add am654_sdhci_set_control_reg")
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes since v1:
- Add Pengs review tag
- Fix commit description '<' -> '<='
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

