Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84CEC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 11:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA99E8785E;
	Mon, 12 Aug 2024 13:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IbG8ZGbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6855C881A2; Mon, 12 Aug 2024 13:36:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E25C87702
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBadSw128342;
 Mon, 12 Aug 2024 06:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723462599;
 bh=uP7WGGQUxhFBMwv0nbsrJko1N88iesq9fZeGk+6vXYQ=;
 h=From:To:CC:Subject:Date;
 b=IbG8ZGbXmHcIB+MezZp3Hx1db+A2Hv18ZAFi3MEkc2lGonC4iN9+Yxau3S5XfOLUW
 VPL60Tv+0YfUEZmiVoEaNlm5HTJV4E1EJiiHEpdOrf3K0jot+FHP5nNvdebHkisRgj
 gU7GsAUcW7rU0zXke3GoKIy8O2QffqGUf0o8Yjx0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBadIf084159
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 06:36:39 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:36:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:36:38 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBab9m114745;
 Mon, 12 Aug 2024 06:36:38 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 00/10] Add support for Ethernet Boot on SK-AM62
Date: Mon, 12 Aug 2024 17:06:21 +0530
Message-ID: <20240812113621.3840652-1-c-vankar@ti.com>
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

Link to v3:
https://lore.kernel.org/r/20240705045030.1141934-1-c-vankar@ti.com/

Logs for Ethernet Boot for AM625-SK:
https://gist.github.com/chintanv133/07bcb1473301581aab6d4e951d9c6572

Changes from v3 to v4:
- Updated config files by enabling architecture specific configs and
  default device tree config to fix buildman failure as pointed by Tom.
- Updated [PATCH v3 10/10] by syncing "k3-am62x-sk-common.dtsi" file
  with Linux v6.11-rc3.

Chintan Vankar (2):
  common: spl: spl: Init DRAM size in R5/A53 SPL
  dts: upstream: src: arm64: ti: k3-am62x-sk-common: Sync DT with Linux
    v6.11-rc3

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

 arch/arm/dts/k3-am625-r5-sk.dts               |  5 +++
 arch/arm/mach-k3/am62x/am625_init.c           | 10 ++++++
 common/spl/spl.c                              |  2 +-
 configs/am62x_evm_a53_ethboot_defconfig       | 17 ++++++++++
 configs/am62x_evm_r5_ethboot_defconfig        | 25 +++++++++++++++
 drivers/dma/ti/k3-udma.c                      |  6 ++++
 drivers/firmware/ti_sci.c                     |  8 ++++-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c      |  9 +++++-
 drivers/soc/ti/k3-navss-ringacc.c             | 17 +++++++++-
 .../src/arm64/ti/k3-am62x-sk-common.dtsi      | 32 ++++++++++---------
 10 files changed, 112 insertions(+), 19 deletions(-)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

