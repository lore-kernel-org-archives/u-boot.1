Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCD6CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 21:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF9683287;
	Wed, 10 Sep 2025 23:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PU/AhdCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10659832DA; Wed, 10 Sep 2025 23:45:23 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B211983253
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 23:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALjFNZ658968;
 Wed, 10 Sep 2025 16:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757540715;
 bh=Ne+XPQgP6cr2ai8F35C+VossDH9JfxX/YIc4POCedLQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PU/AhdCw1y90HGdsxZM9yABnlBhEH+AQCr2j2hd4Op7VmNWW+iP6HWw25h5G2Wh11
 jWhzkLIE6wYY2qGOB0xe/X+x+Vg0F4omKfCzBPvlgrMrTGSWyrwwBtWV/prmPXKMCR
 R6N+/1XgPUf2KtAwQIp67XaKAOWJ696D4rHTC8oA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALjFqZ025348
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 16:45:15 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:45:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:45:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALjFW81119180;
 Wed, 10 Sep 2025 16:45:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 3/4] configs: am62px/j722s: Remove non-spl HS400 support at r5
 stage
Date: Wed, 10 Sep 2025 16:45:13 -0500
Message-ID: <20250910214514.1848847-4-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910214514.1848847-1-jm@ti.com>
References: <20250910214514.1848847-1-jm@ti.com>
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

MMC_HS400_SUPPORT config does not enable eMMC HS400 support in R5 SPL
stage, therefore cleanup from r5 defconfig file.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/am62px_evm_r5_defconfig | 1 -
 configs/j722s_evm_r5_defconfig  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index cf4282eac02..80c15981d84 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -88,7 +88,6 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
 CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 8e2741c8d42..8e981ff48c2 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -92,7 +92,6 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
-CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.51.0

