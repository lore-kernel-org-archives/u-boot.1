Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951E3C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74F18312E;
	Fri, 18 Apr 2025 01:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j5c2K1mU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9029582EBE; Fri, 18 Apr 2025 01:43:39 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3099A83156
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HNhYUS151755
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744933414;
 bh=j0vWBn3aNioN70vDdOsSLO32kq2BFo+YFPxi/94dS8M=;
 h=From:To:CC:Subject:Date;
 b=j5c2K1mUbaqS7Huf0PaAs8asbyyxf5ApkmOGiZXkvFnRzOfkuXFF+nMM5IePu9/sK
 11WMbL9rHZov8+W2EBy+Ez8gWVjoEA0A5tvT7/YDRlPQskKB1IhTeSbJ5d//rjyiA4
 t1yqlEo8OhuJYaL8ldvmmbieeeUt/gwwFcl+1EYQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HNhYnV013450
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Apr 2025 18:43:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 18:43:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 18:43:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HNhYUw036073;
 Thu, 17 Apr 2025 18:43:34 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 0/4] More MMC fixes
Date: Thu, 17 Apr 2025 18:43:30 -0500
Message-ID: <20250417234334.3661321-1-jm@ti.com>
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

This patch series fixes MMC_HS_52 mode in am654_sdhci driver,
as well as HIGH_SPEED_ENA and UHS_MODE_SELECT for HS modes.

Also add TI_COMMON_CMD_OPTIONS to K3 Sitara board a53 defconfigs. 

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf

Changes since v2:
- drop patch for removing hs400 support
- rebase against master

Link to v2:
https://lore.kernel.org/u-boot/20250414224357.1555064-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/u-boot/20250408170527.2832563-1-jm@ti.com/

Judith Mendez (4):
  mmc: am654_sdhci: Add MMC_HS_52 to timing data
  mmc: am654_sdhci: Fix HIGH_SPEED_ENA
  mmc: am654_sdhci: Add am654_sdhci_set_control_reg
  configs: am62*_evm_a53_defconfig: Add TI_COMMON_CMD_OPTIONS

 board/ti/common/Kconfig          |  2 ++
 configs/am62ax_evm_a53_defconfig |  3 +--
 configs/am62px_evm_a53_defconfig |  9 +--------
 configs/am62x_evm_a53_defconfig  |  3 +--
 configs/am64x_evm_a53_defconfig  | 11 +----------
 configs/am65x_evm_a53_defconfig  |  9 +--------
 drivers/mmc/am654_sdhci.c        | 25 +++++++++++++++++++------
 drivers/mmc/sdhci.c              |  2 +-
 include/sdhci.h                  |  1 +
 9 files changed, 28 insertions(+), 37 deletions(-)


base-commit: 278be62c052f3a5749c3c7a57bcd307b82dcdc2d
-- 
2.49.0

