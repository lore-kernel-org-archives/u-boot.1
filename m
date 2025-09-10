Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8038CCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 21:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC63832F9;
	Wed, 10 Sep 2025 23:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rQMfUseA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5098383253; Wed, 10 Sep 2025 23:45:23 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B224A83257
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 23:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALjFCe658976;
 Wed, 10 Sep 2025 16:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757540716;
 bh=bKRwU7FjmGEazTKHkQbMXtx1UlXZb3xU60NxF0A0DFo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rQMfUseAuKMW4BSidbt9OYPaFnBHgZOUGYox48QF01cBCP/NMKmjEjrYJDNMBA3CK
 G4hrepoRFWKNUvR2WBmPQCDa7kVOFCNIimNI+59cihwOLQqi0qb8M3CHQZS8ndvRk6
 reH33W30buK9C/CFXhDIK/9nG8gCxz5mI9JpQQLg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALjF8Y671509
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 16:45:15 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:45:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:45:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALjFW91119180;
 Wed, 10 Sep 2025 16:45:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, "Moteen Shah" <m-shah@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/4] configs: j722s_evm_a53_defconfig: Disable eMMC HS400
Date: Wed, 10 Sep 2025 16:45:14 -0500
Message-ID: <20250910214514.1848847-5-jm@ti.com>
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

This patch addresses silicon errata i2478 [0] "MMCSD0: HS400 Mode not
supported". Where, eMMC HS400 mode is not supported due to bus timing
limitations. As per workaround, use HS200 mode instead.

[0] https://www.ti.com/lit/pdf/sprz575
Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/j722s_evm_a53_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 83ac99c922a..a7ab78a367a 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -101,8 +101,8 @@ CONFIG_FS_LOADER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.51.0

