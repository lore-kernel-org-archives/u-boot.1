Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8BC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F051885FF;
	Fri,  5 Jul 2024 06:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uRMvVrai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2071187D14; Fri,  5 Jul 2024 06:51:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C98287D14
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654oZkj088817;
 Thu, 4 Jul 2024 23:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155035;
 bh=xH4pMhvIHjo+Fh4nX/7YHUL7PDZ5UzrMSlrwwDK/1bY=;
 h=From:To:CC:Subject:Date;
 b=uRMvVraiBHMLGvGJ5Ooa/QQApVBRRGVy41ZPngKQVyEzUAktdUsPG+p7A7zrJGiyM
 SpXGr2k0pSOGclBIfJcAo/BHoHHgUQn09xk/4f5n5+uoVxb2dOOQyNenaGLi0dkzvW
 wYEdgZn/AS88mDRLSEwNtDBHiPgCpurYo6iks4dk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654oZpI024024
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:35 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:34 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654oXlU112173;
 Thu, 4 Jul 2024 23:50:34 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 00/10] Add support for Ethernet Boot on SK-AM62
Date: Fri, 5 Jul 2024 10:20:20 +0530
Message-ID: <20240705045030.1141934-1-c-vankar@ti.com>
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

This series is based on commit "b4cbd1a257d4" of origin/next branch
of u-boot.

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-1-c-vankar@ti.com/

TestLogs:
https://gist.github.com/chintanv133/76de0a51fd532b34fea686f4c7bd75c6

Changes frpom v2 to v3:
- Since register property is defined as "ring" for PKTDMA and "cfg"
  for UDMA, change the condition to configure the base address of ring
  configuration register accordingly.
- Since "phy_gmii_sel" with "bootph-all" property is merged at upstream
  Linux for am62x-sk-common with commit "ba50141137fa", [PATCH 10/10]
  can be drop with next DT-Sync.

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
 arch/arm/mach-k3/am62x/am625_init.c      | 10 ++++++++++
 common/spl/spl.c                         |  2 +-
 configs/am62x_evm_a53_ethboot_defconfig  | 12 ++++++++++++
 configs/am62x_evm_r5_ethboot_defconfig   | 20 ++++++++++++++++++++
 drivers/dma/ti/k3-udma.c                 |  6 ++++++
 drivers/firmware/ti_sci.c                |  8 +++++++-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c |  9 ++++++++-
 drivers/soc/ti/k3-navss-ringacc.c        | 17 ++++++++++++++++-
 10 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

