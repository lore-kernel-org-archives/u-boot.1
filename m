Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D54C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77A588F28;
	Thu, 25 Apr 2024 14:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C1knQnHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D64C88F04; Thu, 25 Apr 2024 14:09:04 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2317488F0D
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8mdP040525;
 Thu, 25 Apr 2024 07:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714046928;
 bh=ifk/Cj5uSyNo6qO5qeepYsX5RXYIq7bAvY+VkYm1WSI=;
 h=From:To:CC:Subject:Date;
 b=C1knQnHMum5w5kJ7ZlE0W3r12eJRg0xXyUU0i+3QLAVdYiSjpl0mudKyvnY8tQZKv
 6HDMWefNi+Evazg4XU17+ve+nhhFt0V5FmMBMFx/vzrGptDRb88dffKXfgHdTLYV0+
 1z6qB2AxzUSUxFS9/t/B195l/2puDrmd79tuKrxI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PC8mKQ011660
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:08:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:08:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:08:48 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8lWZ061828;
 Thu, 25 Apr 2024 07:08:48 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Vignesh Raghavendra <vigneshr@ti.com>, "MD Danish
 Anwar" <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Wadim Egorov <w.egorov@phytec.de>, "Joao
 Paulo Goncalves" <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Chintan Vankar <c-vankar@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Andrew
 Davis" <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 00/10] Add support for Ethernet Boot on SK-AM62
Date: Thu, 25 Apr 2024 17:38:12 +0530
Message-ID: <20240425120822.2048012-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series enables Ethernet Boot on SK-AM62 device.

Link to v1:
https://lore.kernel.org/all/20240112064759.1801600-1-s-vadapalli@ti.com/

Changes from v1 to v2:
- Updated dram_init_banksize() function to be called from common section
  instead of board specific function call as suggested by Tom.
- Dropped [PATCH 06/10] from this version since it was a clean up patch
  and not required for AM62x Ethernet Boot functionality.
- Removed independent defconfig files for R5 and A53 configs and created
  a config fragment for them as suggested by Nishanth.
- Added new patch [PATCH v2 10/10] in this series to enable CPSW MAC's
  PHY node "phy_gmii_sel" which is required for Ethernet Boot.

  This changes are done as per discussion here:
  https://lore.kernel.org/r/20240112064759.1801600-1-s-vadapalli@ti.com/

Logs:
https://gist.github.com/chintanv133/07bcb1473301581aab6d4e951d9c6572

Chintan Vankar (2):
  common: spl: spl: Init DRAM size in R5/A53 SPL
  arch: arm: dts: k3-am62-sk-u-boot: Add missing "bootph-all" property
    to phy_gmii_sel node

Kishon Vijay Abraham I (6):
  firmware: ti_sci: Add No-OP for "RX_FL_CFG"
  soc: ti: k3-navss-ringacc: Initialize base address of ring cfg
    registers
  dma: ti: k3-udma: Add support for native configuration of chan/flow
  arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
  configs: am62: Add configs for enabling ETHBOOT in R5SPL
  configs: am62: Enable configs required for Ethboot

Siddharth Vadapalli (1):
  arm: dts: k3-am625-r5-sk: Enable DM services for main_pktdma

Vignesh Raghavendra (1):
  soc: ti: k3-navss-ringacc: Fix reset ring API

 arch/arm/dts/k3-am625-r5-sk.dts          |  5 +++++
 arch/arm/dts/k3-am625-sk-u-boot.dtsi     |  4 ++++
 arch/arm/mach-k3/am625_init.c            | 10 ++++++++++
 common/spl/spl.c                         |  2 +-
 configs/am62x_evm_a53_ethboot_defconfig  | 11 +++++++++++
 configs/am62x_evm_r5_ethboot_defconfig   | 19 +++++++++++++++++++
 drivers/dma/ti/k3-udma.c                 |  6 ++++++
 drivers/firmware/ti_sci.c                |  8 +++++++-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c |  9 ++++++++-
 drivers/soc/ti/k3-navss-ringacc.c        |  7 ++++++-
 10 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

