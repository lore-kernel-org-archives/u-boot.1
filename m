Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234EEC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65C488A35;
	Mon, 26 Aug 2024 12:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UejqidUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B2288A31; Mon, 26 Aug 2024 12:25:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C2887FA7
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPNK5001335;
 Mon, 26 Aug 2024 05:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667923;
 bh=OPAnpXoF6FU0I1qr4spwq/hd7uKK6lt3wD5a1Xnfud4=;
 h=From:To:CC:Subject:Date;
 b=UejqidUechUXzxSA6V1XBZ7CRBqgIhLUY6NzyiadL6XoQJYo0R7IlggEkRvZOKWtA
 +2g5osIw2wp8wWJVpIljO1R0shCBqNn+yICFV3KkSTAK9tMZ1RjbfZ8pDiLmkfCY3r
 0JW1xI6cqmMO2ma3SKlv9NVYng2i5f/l8vINlt3o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPNIl094555
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:22 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPM11041687;
 Mon, 26 Aug 2024 05:25:22 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I
 <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, "Chintan
 Vankar" <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v6 00/11] Add support for Ethernet Boot on SK-AM62
Date: Mon, 26 Aug 2024 15:55:04 +0530
Message-ID: <20240826102515.2774296-1-c-vankar@ti.com>
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

This series is based on commit 'f4f845b85926' of origin/next branch of
U-Boot.

Link to v5:
https://lore.kernel.org/r/20240813105400.4054657-1-c-vankar@ti.com/

Logs for Ethernet Boot for AM625-SK:
https://gist.github.com/chintanv133/464782796a9a60b9f5a49e674c5fc31a

Changes from v5 to v6:
- Updated function "k3_ringacc_ring_reset_raw" in [PATCH v5 04/10] to
  reset only ring size field in ring configuration register as pointed out
  by Alexander Sverdlin.
- Added a new patch [PATCH 05/11] to reset only qmode in
  "k3_ringacc_ring_reconfig_qmode_raw" function as it was resetting
  other fields in ring configuration register.
- Moved function to enable cache before probing CPSW driver as suggested
  by Andrew.
- Added Reviewed-by tags from Alexander Sverdlin and Sumit Garg.

Chintan Vankar (3):
  common: spl: spl: Init DRAM size in R5/A53 SPL
  soc: ti: k3-navss-ringacc: Fix reconfiguration of qmode API
  arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in
    phy_gmii_sel node

Kishon Vijay Abraham I (6):
  firmware: ti_sci: Add No-OP for "RX_FL_CFG"
  soc: ti: k3-navss-ringacc: Initialize base address of ring cfg
    registers
  dma: ti: k3-udma: Add support for native configuration of chan/flow
  arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS
  configs: am62: Add configs for enabling ETHBOOT in R5SPL
  configs: am62: Enable configs required for Ethboot

Siddharth Vadapalli (1):
  arm: dts: k3-am625-r5-sk: Enable DM services for main_pktdma

Vignesh Raghavendra (1):
  soc: ti: k3-navss-ringacc: Fix reset ring API

 arch/arm/dts/k3-am625-r5-sk.dts               |  5 ++++
 arch/arm/mach-k3/am62x/am625_init.c           |  9 +++++++
 common/spl/spl.c                              |  2 +-
 configs/am62x_evm_a53_ethboot_defconfig       | 17 +++++++++++++
 configs/am62x_evm_r5_ethboot_defconfig        | 25 +++++++++++++++++++
 drivers/dma/ti/k3-udma.c                      |  6 +++++
 drivers/firmware/ti_sci.c                     |  8 +++++-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c      | 11 ++++++--
 drivers/soc/ti/k3-navss-ringacc.c             | 17 ++++++++++++-
 .../src/arm64/ti/k3-am62x-sk-common.dtsi      |  4 +++
 10 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

