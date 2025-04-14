Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F86BC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A34D82905;
	Tue, 15 Apr 2025 00:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="biI2G1S7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57FE982836; Tue, 15 Apr 2025 00:44:08 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED4C826AD
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhwRK2821282
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 17:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744670638;
 bh=F0BTvZDcYB6qRvtcE6KD+cvgqkXF8v+MdIsh+IK/z00=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=biI2G1S7LQ27R5O0xgZF4H+HJvutKhAqPGiHEyR11hyIv5NtSo+pG2n8a+3XNtEEt
 osahvLw3lql57x0a7vQM1zo+JDdgJypGYaFL5BT4MBEnz5nOrLPbyMtejhm9Si9+VE
 9ITIrsMKCytmpXXd67GQFFnJbetUuimQbA/afJV4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhv10007567
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 17:43:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 17:43:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 17:43:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EMhvv3064149;
 Mon, 14 Apr 2025 17:43:57 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, open
 list <u-boot@lists.denx.de>
Subject: [PATCH v2 4/5] configs: am62px_evm_r5/a53_defconfig: Disable eMMC
 HS400
Date: Mon, 14 Apr 2025 17:43:56 -0500
Message-ID: <20250414224357.1555064-5-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414224357.1555064-1-jm@ti.com>
References: <20250414224357.1555064-1-jm@ti.com>
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

This patch addresses silicon errata i2458 [0] "MMCHS: eMMC HS400
tDCD timing marginal to JEDEC spec". Where, in some corner cases,
MMC0 interface may marginally exceed the tdCD JEDEC spec requirement
of 300 ps. As per workaround, switch to HS200 mode instead of HS400.

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
 configs/am62px_evm_a53_defconfig | 4 ++--
 configs/am62px_evm_r5_defconfig  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index dae87c3b788..d9e68956676 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -109,8 +109,8 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 39b6a83ab42..cba1f057be3 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -87,7 +87,6 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
-CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.49.0

