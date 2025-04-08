Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E664C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 17:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 759F682B8D;
	Tue,  8 Apr 2025 19:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nJXumat6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7F583445; Tue,  8 Apr 2025 19:05:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A22C82B8D
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 19:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5Rl51268891
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744131928;
 bh=9+d1pLGM0SjQr6ZNR5OKueO+pZfGR3vdnPLH6UzkSQQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nJXumat6Yh/N5qNVLpWpiLCjHoFsxVHMxx7JuGF/IDSD7JofI5RHEiU3OQnzdcOHl
 6uVvMN/HEJNrhFWsS5dBsknV+DhAxBpsjWJ6eRTN1loRgTMIY7UjQeu7NMDZ/OpQfj
 DnjCk7ZlzEeSmSWGiDfCRBw4Mr492QadEoywgP0U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5RoJ010794
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 12:05:27 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 12:05:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 12:05:27 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538H5RjP105590;
 Tue, 8 Apr 2025 12:05:27 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/5] mmc: am654_sdhci: Add am654_sdhci_set_control_reg
Date: Tue, 8 Apr 2025 12:05:25 -0500
Message-ID: <20250408170527.2832563-4-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408170527.2832563-1-jm@ti.com>
References: <20250408170527.2832563-1-jm@ti.com>
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
> MMC_HS_52.

This fixes MMC write issue on am64x evm at mode High Speed
SDR.

Signed-off-by: Judith Mendez <jm@ti.com>
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
index 4833b5158c7..b5d7a8b6c83 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -547,7 +547,7 @@ void sdhci_set_uhs_timing(struct sdhci_host *host)
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

