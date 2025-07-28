Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA32C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E2882CBB;
	Mon, 28 Jul 2025 17:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UKAJfPq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1678282E26; Mon, 28 Jul 2025 16:51:18 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D18D82CA4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56SEooOQ2782006;
 Mon, 28 Jul 2025 09:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753714250;
 bh=cmHrwB46vlW+EPGRSOZCY8+j/Khb4VwTFcNrTDPw3nU=;
 h=From:To:CC:Subject:Date;
 b=UKAJfPq2Jeo25/5d5wNV+kgc91Z3jiJOttkyO9i6CpIDLm3AjQj1PnV/IEt195a+m
 Kk2L2p6vMHChspr2R8PnGDWNK3KzXWT8l4p27WA6ub4ydFDyu4f8saDGzXHavaXMFR
 F49oQ4QNBH3StDqRb7L3m3uWzxz89Cs/pJ2Kl8DU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56SEoopb2092787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 28 Jul 2025 09:50:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 28
 Jul 2025 09:50:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 28 Jul 2025 09:50:48 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 56SEoZtx1924403; Mon, 28 Jul 2025 09:50:36 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <yegorslists@googlemail.com>, <afd@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <a-nandan@ti.com>, <ggiordano@phytec.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <paulk@sys-base.io>,
 <marek.vasut+renesas@mailbox.org>, <romain.gantois@bootlin.com>,
 <kory.maincent@bootlin.com>, <mkorpershoek@kernel.org>,
 <festevam@gmail.com>, <a-dutta@ti.com>, <ddrokosov@salutedevices.com>,
 <anshuld@ti.com>, <jm@ti.com>, <sjg@chromium.org>, <p-mantena@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>,
 <seanga2@gmail.com>, <kamlesh@ti.com>, <a-shenai@ti.com>,
 <c-vankar@ti.com>, <kishon@ti.com>, <dannenberg@ti.com>,
 <e@freeshell.de>, <h-salunke@ti.com>, <semen.protsenko@linaro.org>,
 <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quentin.schulz@cherry.de>,
 <sumit.garg@kernel.org>, <d.schultz@phytec.de>,
 <emanuele.ghidoli@toradex.com>, <hiago.franco@toradex.com>,
 <joao.goncalves@toradex.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 00/45] TI SoC based Boards: Increase Aneg Timeout to 20, 000 ms
Date: Mon, 28 Jul 2025 20:19:49 +0530
Message-ID: <20250728145034.225997-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 28 Jul 2025 17:14:15 +0200
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

Hello,

This series is based on commit
088d24eb96f Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung
of the master branch of Mainline U-Boot.

The Auto Negotiation procedure between two Ethernet PHYs consists of
determining the best commonly supported parameters among Speed,
Duplex Mode and Flow Control.

The time taken for this procedure is not only dependent on the local
PHY used, but also on the link-partner PHY.

While the board and its PHY may be capable of completing the
Auto-Negotiation process in under 10,000 ms (highest timeout specified
in the configs of one of the boards prior to this series updating it),
the Link-Partner connected to it may not be capable of guaranteeing
this. As a result, we might observe intermittent timeouts. An example
of such a Link-Partner is a Network Switch with around 25 Ports with
each port connected to a different Board, and all Boards possibly
starting the Auto-Negotiation process in tandem. This is unlikely, but
when it does occur, it might result in a timeout. Therefore, this
series is increasing the timeout to 20,000 ms to be on the safe side.
Since the parameter being modified is a timeout, there should be no
adverse affect except in cases where a timeout is expected earlier -
possibly to initiate the fallback mechanism quickly.

Regards,
Siddharth.

Siddharth Vadapalli (45):
  configs: am335x_baltos_defconfig: Increase aneg timeout to 20000 ms
  configs: am335x_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am335x_evm_spiboot_defconfig: Increase aneg timeout to 20000
    ms
  configs: am335x_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am335x_hs_evm_uart_defconfig: Increase aneg timeout to 20000
    ms
  configs: am43xx_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am43xx_evm_qspiboot_defconfig: Increase aneg timeout to 20000
    ms
  configs: am43xx_evm_rtconly_defconfig: Increase aneg timeout to 20000
    ms
  configs: am43xx_evm_usbhost_boot_defconfig: Increase aneg timeout to
    20000 ms
  configs: am43xx_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am43xx_hs_evm_qspi_defconfig: Increase aneg timeout to 20000
    ms
  configs: am57xx_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am57xx_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: am57xx_hs_evm_usb_defconfig: Increase aneg timeout to 20000
    ms
  configs: am62ax_evm_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: am62px_evm_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: am62x_beagleplay_a53_defconfig: Increase aneg timeout to
    20000 ms
  configs: am62x_evm_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: am62x_evm_r5_ethboot_defconfig: Increase aneg timeout to
    20000 ms
  configs: am64x_evm_{r5,a53}_defconfig: Increase aneg timeout to 20000
    ms
  configs: am65x_evm_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: am67a_beagley_ai_a53_defconfig: Increase aneg timeout to
    20000 ms
  configs: dra7xx_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: dra7xx_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: j7200_evm_a72_defconfig: Increase aneg timeout to 20000 ms
  configs: j721e_beagleboneai64_a72_defconfig: Increase aneg timeout to
    20000 ms
  configs: j721e_evm_a72_defconfig: Increase aneg timeout to 20000 ms
  configs: j721s2_evm_a72_defconfig: Increase aneg timeout to 20000 ms
  configs: j722s_evm_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: j784s4_evm_a72_defconfig: Increase aneg timeout to 20000 ms
  configs: k2e_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2e_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2g_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2g_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2hk_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2hk_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2l_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: k2l_hs_evm_defconfig: Increase aneg timeout to 20000 ms
  configs: phycore_am62ax_a53_defconfig: Increase aneg timeout to 20000
    ms
  configs: phycore_am62ax_r5_ethboot_defconfig: Increase aneg timeout to
    20000 ms
  configs: phycore_am62x_a53_defconfig: Increase aneg timeout to 20000
    ms
  configs: phycore_am62x_r5_ethboot_defconfig: Increase aneg timeout to
    20000 ms
  configs: phycore_am64x_{r5,a53}_defconfig: Increase aneg timeout to
    20000 ms
  configs: verdin-am62_a53_defconfig: Increase aneg timeout to 20000 ms
  configs: verdin-am62p_a53_defconfig: Increase aneg timeout to 20000 ms

 configs/am335x_baltos_defconfig             | 1 +
 configs/am335x_evm_defconfig                | 1 +
 configs/am335x_evm_spiboot_defconfig        | 1 +
 configs/am335x_hs_evm_defconfig             | 1 +
 configs/am335x_hs_evm_uart_defconfig        | 1 +
 configs/am43xx_evm_defconfig                | 2 +-
 configs/am43xx_evm_qspiboot_defconfig       | 2 +-
 configs/am43xx_evm_rtconly_defconfig        | 2 +-
 configs/am43xx_evm_usbhost_boot_defconfig   | 2 +-
 configs/am43xx_hs_evm_defconfig             | 2 +-
 configs/am43xx_hs_evm_qspi_defconfig        | 2 +-
 configs/am57xx_evm_defconfig                | 2 +-
 configs/am57xx_hs_evm_defconfig             | 2 +-
 configs/am57xx_hs_evm_usb_defconfig         | 2 +-
 configs/am62ax_evm_a53_defconfig            | 1 +
 configs/am62px_evm_a53_defconfig            | 1 +
 configs/am62x_beagleplay_a53_defconfig      | 1 +
 configs/am62x_evm_a53_defconfig             | 1 +
 configs/am62x_evm_r5_ethboot_defconfig      | 1 +
 configs/am64x_evm_a53_defconfig             | 1 +
 configs/am64x_evm_r5_defconfig              | 1 +
 configs/am65x_evm_a53_defconfig             | 1 +
 configs/am67a_beagley_ai_a53_defconfig      | 1 +
 configs/dra7xx_evm_defconfig                | 1 +
 configs/dra7xx_hs_evm_defconfig             | 1 +
 configs/j7200_evm_a72_defconfig             | 1 +
 configs/j721e_beagleboneai64_a72_defconfig  | 1 +
 configs/j721e_evm_a72_defconfig             | 1 +
 configs/j721s2_evm_a72_defconfig            | 1 +
 configs/j722s_evm_a53_defconfig             | 1 +
 configs/j784s4_evm_a72_defconfig            | 1 +
 configs/k2e_evm_defconfig                   | 1 +
 configs/k2e_hs_evm_defconfig                | 1 +
 configs/k2g_evm_defconfig                   | 2 +-
 configs/k2g_hs_evm_defconfig                | 2 +-
 configs/k2hk_evm_defconfig                  | 1 +
 configs/k2hk_hs_evm_defconfig               | 1 +
 configs/k2l_evm_defconfig                   | 1 +
 configs/k2l_hs_evm_defconfig                | 1 +
 configs/phycore_am62ax_a53_defconfig        | 1 +
 configs/phycore_am62ax_r5_ethboot_defconfig | 1 +
 configs/phycore_am62x_a53_defconfig         | 1 +
 configs/phycore_am62x_r5_ethboot_defconfig  | 1 +
 configs/phycore_am64x_a53_defconfig         | 1 +
 configs/phycore_am64x_r5_defconfig          | 1 +
 configs/verdin-am62_a53_defconfig           | 1 +
 configs/verdin-am62p_a53_defconfig          | 1 +
 47 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.34.1

