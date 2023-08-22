Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA12EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E59B864C2;
	Tue, 22 Aug 2023 20:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GJqDl24j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13C4864C2; Tue, 22 Aug 2023 20:41:49 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480CB86480
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfeEk080356;
 Tue, 22 Aug 2023 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692729700;
 bh=sXyGe/yfiJayFL36lOzYDXLlrYMQIQHM1lq5EdTN5Q0=;
 h=From:To:CC:Subject:Date;
 b=GJqDl24jGoHCRmlOGL817Yb9X1jkkJdIVObhSBy3S4VEbFLcioaQuYoR35a2rti+p
 3G7+oCnZ2j9PP7Z7miWx+eT0XFOGdRKIqB6dyhKBLuZas7WGyHMvlJqCCGi25szYT3
 Er25UkDAd57kKQaSgU7LGIbP3Vga0w0PNXV9pSaI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MIfeKc025246
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:41:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:41:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:41:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfevn098370;
 Tue, 22 Aug 2023 13:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 0/8] board: ti: Add support for BeaglePlay
Date: Tue, 22 Aug 2023 13:41:27 -0500
Message-ID: <20230822184135.2328409-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Hi,

Add support for BeaglePlay - rev 4

Full series: https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v4.2

Caveats:
* networking: pending https://lore.kernel.org/all/20230822121350.51324-1-rogerq@kernel.org/
* 32kclk and usb: pending:
  https://lore.kernel.org/u-boot/20230725185253.2123433-4-nm@ti.com/
  OR https://github.com/nmenon/fix-k3-dt-u-boot/commit/853b29d63c1ca642be316f1afb0fb778610dec46
  being properly resolved (NOTE: without this patch, wlan is broken in
  Linux as the 32kclk from SoC is incorrectly supplied to wlan as 25MHz)
* There seems to be a bug in Linux kernel with sdhci that seems to
  depend on u-boot initialization of sdhci for functionality.

Changes since V3:
* GPIO, LEDs, PMIC enabled at u-boot level.
* eMMC boot fixed in a manner not to break existing SK and other EVM
  solutions. UDA FS solution similar to commit 5019170970ad
  ("arch: arm: mach-k3: j721e: add support for UDA FS") introduced.
* env file for beagleplay introduced to keep things consistent with the
  behavior expected on BeaglePlay
* Documentation updates to fixup alt, references, added OpenOCD debug
  info etc.
* New patch to ensure env files have priority over header included env
  variables.

Bootlog:
emmc with no SD: https://gist.github.com/nmenon/5755228ff424c55245f4534548827ab9
emmc with SD: https://gist.github.com/nmenon/8571dba9e942e77e48e52fe59cf71aac
SD boot: https://gist.github.com/nmenon/1cc850c37469fe7c86b26842fe0910f8

Baseline: 7e6e40c57233 (origin/next) Merge tag 'v2023.10-rc3' into next

V3: https://lore.kernel.org/all/20230815164440.2713726-1-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/

Nishanth Menon (6):
  env_default: Allow CONFIG_EXTRA_ENV_TEXT to override
    CFG_EXTRA_ENV_SETTINGS
  configs: am62x_evm*: Enable EMMC_BOOT configuration
  arm: mach-k3: am625: Add support for UDA FS
  arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
  board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file
  doc: board: ti: Add BeaglePlay documentation

Nitin Yadav (1):
  drivers: mmc: am654_sdhci: Update OTAP/ITAP delay

Robert Nelson (1):
  arm: dts: Add k3-am625-beagleplay

 arch/arm/dts/Makefile                         |    2 +
 .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  196 ++
 arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   87 +
 arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
 arch/arm/mach-k3/am625_init.c                 |    6 +
 board/ti/am62x/MAINTAINERS                    |    7 +
 board/ti/am62x/beagleplay.env                 |   23 +
 board/ti/am62x/beagleplay_a53.config          |   55 +
 board/ti/am62x/beagleplay_r5.config           |   15 +
 configs/am62x_evm_a53_defconfig               |    1 +
 configs/am62x_evm_r5_defconfig                |    1 +
 doc/board/ti/am62x_beagleplay.rst             |  256 ++
 doc/board/ti/img/beagleplay_emmc.svg          |  697 ++++++
 doc/board/ti/k3.rst                           |    1 +
 drivers/mmc/am654_sdhci.c                     |   14 +-
 include/env_default.h                         |    6 +-
 18 files changed, 4315 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
 create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
 create mode 100644 board/ti/am62x/beagleplay.env
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 doc/board/ti/am62x_beagleplay.rst
 create mode 100644 doc/board/ti/img/beagleplay_emmc.svg

-- 
2.40.0

