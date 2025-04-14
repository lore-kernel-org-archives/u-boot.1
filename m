Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D44C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF9482982;
	Tue, 15 Apr 2025 00:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HLMLt1JJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707DF826AD; Tue, 15 Apr 2025 00:44:08 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB645827A6
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvUU2183004
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 17:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744670637;
 bh=5hDea4waEPCrFOeLehdJJarVMkbQLBoQkA3xB6vKTFI=;
 h=From:To:CC:Subject:Date;
 b=HLMLt1JJXS/u8aavmv30CuqOMFCerxuklRlTRDvtF2TToDOkODH4rjJP03AvWUb9n
 uuczuOAe+9X4xB0n74byEDR/FSHLVjLSsQpSmHRfxzzd/oE3mNU8ZLqCtEWVuqYsbk
 K5r9ZNFoS20X6ir8TwN5eYG1OqYMm5crcMp5QP58=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EMhvVo002952
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 17:43:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 17:43:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 17:43:57 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EMhvux064149;
 Mon, 14 Apr 2025 17:43:57 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, open
 list <u-boot@lists.denx.de>
Subject: [PATCH v2 0/5] More MMC fixes
Date: Mon, 14 Apr 2025 17:43:52 -0500
Message-ID: <20250414224357.1555064-1-jm@ti.com>
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

This patch series fixes MMC_HS_52 mode in am654_sdhci
driver, as well as HIGH_SPEED_ENA and UHS_MODE_SELECT
for HS modes.

Also Disable eMMC HS400 mode for am62px device according
to silicon errata i2458 [0] and add TI_COMMON_CMD_OPTIONS
to K3 Sitara board a53 defconfigs. 

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf

Changes since v1:
- rebase against master and fix merge conflicts for patch 5/5
- pick up bryans reviewed-by tag

Judith Mendez (5):
  mmc: am654_sdhci: Add MMC_HS_52 to timing data
  mmc: am654_sdhci: Fix HIGH_SPEED_ENA
  mmc: am654_sdhci: Add am654_sdhci_set_control_reg
  configs: am62px_evm_r5/a53_defconfig: Disable eMMC HS400
  configs: am62*_evm_a53_defconfig: Add TI_COMMON_CMD_OPTIONS

 board/ti/common/Kconfig          |  2 ++
 configs/am62ax_evm_a53_defconfig |  3 +--
 configs/am62px_evm_a53_defconfig | 13 +++----------
 configs/am62px_evm_r5_defconfig  |  1 -
 configs/am62x_evm_a53_defconfig  |  3 +--
 configs/am64x_evm_a53_defconfig  | 11 +----------
 configs/am65x_evm_a53_defconfig  |  9 +--------
 drivers/mmc/am654_sdhci.c        | 25 +++++++++++++++++++------
 drivers/mmc/sdhci.c              |  2 +-
 include/sdhci.h                  |  1 +
 10 files changed, 30 insertions(+), 40 deletions(-)


base-commit: 8c98b57d72d5e5b94ed064fe1041e51216165334
-- 
2.49.0

