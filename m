Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D8C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DE9888AB;
	Tue, 13 Aug 2024 12:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VhKEN+Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A12888AB; Tue, 13 Aug 2024 12:54:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F038800C
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 12:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DAs8Od110838;
 Tue, 13 Aug 2024 05:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723546448;
 bh=g+BOhZdStbFQ7n+epUgfHZ3gUeuwL2PVq+OswxgNpPE=;
 h=From:To:CC:Subject:Date;
 b=VhKEN+OumHV6n2H13IR8EMs7dnWAULbk7+paJrmt3nm4MjujRIgWK0Rb7M6mTvLfs
 SyOou+BTZ3vA8C17HoYZhCRN4n2quDDIHWrrBe438Oef1DkRL5D7eDQ+hlbDVwIz9u
 8uYY+ULTxt7+EHgUP7tHsmazcN9L4GiV+4IvWNzw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DAs8fk071780
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 05:54:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 05:54:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 05:54:07 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DAs7YM120708;
 Tue, 13 Aug 2024 05:54:07 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Nishanth Menon" <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v5 00/10] Add support for Ethernet Boot on SK-AM62
Date: Tue, 13 Aug 2024 16:23:50 +0530
Message-ID: <20240813105400.4054657-1-c-vankar@ti.com>
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

Link to v4:
https://lore.kernel.org/r/20240812113621.3840652-1-c-vankar@ti.com/

Logs for Ethernet Boot for AM625-SK:
https://gist.github.com/chintanv133/07bcb1473301581aab6d4e951d9c6572

Changes from v4 to v5:
- Updated [PATCH v4 10/10] with the cherry picked patch from
  devicetree-rabasing repo as pointed out by Sumit.

Chintan Vankar (2):
  common: spl: spl: Init DRAM size in R5/A53 SPL
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
 arch/arm/mach-k3/am62x/am625_init.c           | 10 ++++++++
 common/spl/spl.c                              |  2 +-
 configs/am62x_evm_a53_ethboot_defconfig       | 17 +++++++++++++
 configs/am62x_evm_r5_ethboot_defconfig        | 25 +++++++++++++++++++
 drivers/dma/ti/k3-udma.c                      |  6 +++++
 drivers/firmware/ti_sci.c                     |  8 +++++-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c      |  9 ++++++-
 drivers/soc/ti/k3-navss-ringacc.c             | 17 ++++++++++++-
 .../src/arm64/ti/k3-am62x-sk-common.dtsi      |  4 +++
 10 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

