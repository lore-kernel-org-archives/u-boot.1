Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467DC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1A2831D4;
	Fri, 18 Apr 2025 01:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aH/+ETzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F24E83158; Fri, 18 Apr 2025 01:43:41 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3090A83125
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HNhYUw137861
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744933415;
 bh=Pbq8D34pOEE43TdRaZ7LIkbeSqZc9vfvT9pmbcz7xDs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aH/+ETzr0Aq+uWXOJGesoJQhoiUXmtMptSobQwwqdWLGywO/RWUOY3+Onvq/nq5Uh
 d5FznvXXuWEg0QAc+p3Whr+RGJ9Vj4i6npLMXmbe0Vn9cpW/NexJj4d62BkzE6cSSe
 D9j3MphWDnNYByin9HzMXGUqEPelgg1uzIHNsi5U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HNhY0q013453
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Apr 2025 18:43:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 18:43:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 18:43:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HNhYV1036073;
 Thu, 17 Apr 2025 18:43:34 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 3/4] mmc: am654_sdhci: Add am654_sdhci_set_control_reg
Date: Thu, 17 Apr 2025 18:43:33 -0500
Message-ID: <20250417234334.3661321-4-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417234334.3661321-1-jm@ti.com>
References: <20250417234334.3661321-1-jm@ti.com>
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

This patch adds am654_sdhci_set_control_reg to am654_sdhci.

This is required to fix UHS_MODE_SELECT for TI K3 boards.

If any of HIGH_SPEED_ENA, V1P8_SIGNAL_ENA, UHS_MODE_SELECT
are set, then data will be launched on the pos-edge of the
clock.

Since K3 SoCs did not meet timing requirements for High Speed
SDR mode at rising clock edge, none of these three should be
set, therefore limit UHS_MODE_SELECT to only be set for modes
above MMC_HS_52.

This fixes MMC write issue on am64x evm at mode High Speed
SDR.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
 drivers/mmc/am654_sdhci.c | 15 +++++++++++++--
 drivers/mmc/sdhci.c       |  2 +-
 include/sdhci.h           |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 28d82afd012..0df3568f073 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -523,13 +523,24 @@ static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 	return 0;
 }
 #endif
+
+void am654_sdhci_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+
+	sdhci_set_voltage(host);
+
+	if (mmc->selected_mode > MMC_HS_52)
+		sdhci_set_uhs_timing(host);
+}
+
 const struct sdhci_ops am654_sdhci_ops = {
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = am654_sdhci_execute_tuning,
 #endif
 	.deferred_probe		= am654_sdhci_deferred_probe,
 	.set_ios_post		= &am654_sdhci_set_ios_post,
-	.set_control_reg	= sdhci_set_control_reg,
+	.set_control_reg	= am654_sdhci_set_control_reg,
 	.write_b		= am654_sdhci_write_b,
 };
 
@@ -589,7 +600,7 @@ const struct sdhci_ops j721e_4bit_sdhci_ops = {
 #endif
 	.deferred_probe		= am654_sdhci_deferred_probe,
 	.set_ios_post		= &j721e_4bit_sdhci_set_ios_post,
-	.set_control_reg	= sdhci_set_control_reg,
+	.set_control_reg	= am654_sdhci_set_control_reg,
 	.write_b		= am654_sdhci_write_b,
 };
 
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index dc7f0724a7b..648dfa4b5ef 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -549,7 +549,7 @@ void sdhci_set_uhs_timing(struct sdhci_host *host)
 	sdhci_writew(host, reg, SDHCI_HOST_CONTROL2);
 }
 
-static void sdhci_set_voltage(struct sdhci_host *host)
+void sdhci_set_voltage(struct sdhci_host *host)
 {
 	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
 		struct mmc *mmc = (struct mmc *)host->mmc;
diff --git a/include/sdhci.h b/include/sdhci.h
index 31a49ca6a2f..2372697b743 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -518,6 +518,7 @@ void sdhci_set_uhs_timing(struct sdhci_host *host);
 /* Export the operations to drivers */
 int sdhci_probe(struct udevice *dev);
 int sdhci_set_clock(struct mmc *mmc, unsigned int clock);
+void sdhci_set_voltage(struct sdhci_host *host);
 
 /**
  * sdhci_set_control_reg - Set control registers
-- 
2.49.0

