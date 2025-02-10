Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCAFC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963CA80BA8;
	Mon, 10 Feb 2025 21:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FfminCI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E8E80A55; Mon, 10 Feb 2025 21:29:49 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D3B806FE
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjCo193208
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Feb 2025 14:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739219385;
 bh=3SVvXuVeaoIly3mQGd7dNgnvkeYU+d9uXGav9PymNDQ=;
 h=From:To:CC:Subject:Date;
 b=FfminCI2kohyuehDUgYVUvb2yC9IgSkcuQksCU9q5pkB5YZBROEnHw0zp1jm4mEtz
 X0eTsueBxuUvxoGPPCADe/HW7VI1WNlnyFt4tlm8AblyiUEE3awT971x+pCK06ukOz
 bRK6pQm0Ii3glv1J5dFghW0fviGNnbL+OvFoOBU8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTjZC062576;
 Mon, 10 Feb 2025 14:29:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 14:29:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 14:29:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTiDA022402;
 Mon, 10 Feb 2025 14:29:44 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Judith
 Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 00/10] Introduce K3 remoteproc driver for M4 subsystem
Date: Mon, 10 Feb 2025 14:29:34 -0600
Message-ID: <20250210202944.1071931-1-jm@ti.com>
X-Mailer: git-send-email 2.48.0
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

Some K3 devices like am62x and am64x have a M4 processor in the MCU
voltage domain. This patch series introduces remoteproc M4 driver which
will be used to load firmware into and start the M4 remote core.

This series also adds support for R5F cores on am64x SoCs in patch 2 and
sets up environment to load FW in remote cores in patch 3,4,5.

This patch series also enables remoteproc drivers by default as per what
remoteproc sybsystem is supported per SoC, thus all remoteproc options
are now deleted in configs/* since they are no longer required.

This patch series was tested on am64x EVM, am62x SK, am62ax SK,
am62px SK boards.

Any additional tested by's are welcome since I was not able to
test any additional boards.

Tested by running the following commands in u-boot prompt:

=> setenv dorprocboot 1
=> run boot_rprocs

Links:
v4: https://lore.kernel.org/u-boot/20250206015406.2702944-1-jm@ti.com/
v3: https://lore.kernel.org/u-boot/20250130223256.1944522-1-jm@ti.com/
v2: https://lore.kernel.org/u-boot/20250129225233.467139-1-jm@ti.com/
v1: https://lore.kernel.org/u-boot/20250123010759.810799-1-jm@ti.com/

Changes since v4:
- Remove patch 6 from v4
- Add patches 6-10 from v5

Hari Nagalla (5):
  remoteproc: k3-m4: Introduce K3 remote proc driver for M4 subsystem
  remoteproc: k3-r5: Add support for R5F cores on AM64x SoCs
  board: ti: am64x: Add remoteproc specific env support
  board: ti: am62x: Add remoteproc specific env support
  board: ti: am62px: Add remoteproc specific env support

Judith Mendez (5):
  remoteproc: Enable ARM64 remoteproc driver by default for K3 ARCH
  spl: Enable SPL remoteproc by default for K3 ARCH
  cmd: Enable CMD remoteproc by default for K3 ARCH
  arm: mach-k3: Enable remoteproc drivers by default for K3 ARCH
  configs: am6*/j7*: Remove remoteproc configs

 arch/arm/mach-k3/Kconfig                   |  24 ++
 board/ti/am62px/am62px.env                 |   6 +
 board/ti/am62x/am62x.env                   |   6 +
 board/ti/am64x/am64x.env                   |   6 +
 cmd/Kconfig                                |   1 +
 common/spl/Kconfig                         |   1 +
 configs/am62ax_evm_a53_defconfig           |   4 -
 configs/am62ax_evm_r5_defconfig            |   3 -
 configs/am62px_evm_a53_defconfig           |   4 -
 configs/am62px_evm_r5_defconfig            |   3 -
 configs/am62x_beagleplay_a53_defconfig     |   1 -
 configs/am62x_beagleplay_r5_defconfig      |   3 -
 configs/am62x_evm_a53_defconfig            |   1 -
 configs/am62x_evm_r5_defconfig             |   3 -
 configs/am64x_evm_a53_defconfig            |   3 -
 configs/am64x_evm_r5_defconfig             |   3 -
 configs/am65x_evm_a53_defconfig            |   3 -
 configs/am65x_evm_r5_defconfig             |   3 -
 configs/am65x_evm_r5_usbdfu_defconfig      |   3 -
 configs/am65x_evm_r5_usbmsc_defconfig      |   3 -
 configs/j7200_evm_a72_defconfig            |   2 -
 configs/j7200_evm_r5_defconfig             |   3 -
 configs/j721e_beagleboneai64_a72_defconfig |   3 -
 configs/j721e_beagleboneai64_r5_defconfig  |   3 -
 configs/j721e_evm_a72_defconfig            |   3 -
 configs/j721e_evm_r5_defconfig             |   3 -
 configs/j721s2_evm_a72_defconfig           |   3 -
 configs/j721s2_evm_r5_defconfig            |   3 -
 configs/j722s_evm_a53_defconfig            |   4 -
 configs/j722s_evm_r5_defconfig             |   3 -
 configs/j784s4_evm_a72_defconfig           |   3 -
 configs/j784s4_evm_r5_defconfig            |   2 -
 drivers/remoteproc/Kconfig                 |  11 +
 drivers/remoteproc/Makefile                |   1 +
 drivers/remoteproc/ti_k3_m4_rproc.c        | 371 +++++++++++++++++++++
 drivers/remoteproc/ti_k3_r5f_rproc.c       |   2 +
 36 files changed, 429 insertions(+), 75 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c


base-commit: d6da3dbaef57fc1d319b6b552efa009e2489d7d9
-- 
2.48.0

