Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36FCC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE1886573;
	Thu, 24 Aug 2023 05:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sYKNoodO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48B386569; Thu, 24 Aug 2023 05:11:18 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEA786435
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3B9ff053209;
 Wed, 23 Aug 2023 22:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846669;
 bh=EH0UFROLFt3Hu3hv0pE7usjRad8yWf0QKUZVI7VqwOE=;
 h=From:To:CC:Subject:Date;
 b=sYKNoodOPhC4+dC6JzgJX24LmYSXBimJ6i2ZrVWgz7jZWFNuZaoMQu3QAm583LIc+
 /0OvesPwTdsMZHSNZaYl0k+zJtXMLzdIa+lVYyPROpgK6x2tVf7JeODtGlavysStU9
 Ivs9Fifw/4pZ/xDogA45jVcsBp/VEojRYn6yVoAc=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3B9Qs030855
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:09 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3B9gS000769;
 Wed, 23 Aug 2023 22:11:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 00/17] board: ti: Add support for BeaglePlay
Date: Wed, 23 Aug 2023 22:10:44 -0500
Message-ID: <20230824031101.3460411-1-nm@ti.com>
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

Add support for BeaglePlay - rev 5

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

CI loop check: https://github.com/u-boot/u-boot/pull/425 (whenever that
gets done I guess).

Bootlogs:
SD Boot: https://gist.github.com/nmenon/c74acb3a895053e05623e886df77c8fe
eMMC, no SD boot: https://gist.github.com/nmenon/16df3b8fc0e9102f29ebb7836b950a08
eMMC with SD card: https://gist.github.com/nmenon/042dbe7c08589e7bfe1919da1fedc545

Complete code (with the tmp patch) can be found at:
https://github.com/nmenon/fix-k3-dt-u-boot/tree/beagleplay-v5

Baseline: 97841de68043 (origin/next) Merge branch '2023-08-22-assorted-code-cleanups' into next

Changes since V4:
* Switched boot from distro_boot to bootstd - AM62 as a start will rely
  on txt env file.
* Cleanups around am625_init.c (new patches)
* Review comment fixups for documentation
* I have'nt picked up Mattijs's tested by since this is a different
  approach (bootstd Vs distro_bootcmd)
* Dropped the sdhci patches AND CFG_EXTRA_ENV_SETTINGS (Instead, we
  switch entirely to bootstd and move am62x-sk to bootstd along with
  it).

V4: https://lore.kernel.org/all/20230822184135.2328409-1-nm@ti.com/
V3: https://lore.kernel.org/all/20230815164440.2713726-1-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/

Nishanth Menon (16):
  include: configs: ti_armv7_common: Add documentation for protected
    section
  include: configs: am62x_evm: Drop unused SDRAM address
  include: configs: am62x_evm: Wrap distroboot with
    CONFIG_DISTRO_DEFAULTS
  board: ti: am62x: am62x.env: Add explicit boot_targets
  configs: am62x_evm_a53_defconfig: Switch to bootstd
  include: configs: am62x_evm: Drop distro_bootcmd usage
  include: env: ti: ti_armv7_common.env: Rename to ti_common.env
  include: env: ti: ti_common: Add a generic findfdt
  board: ti: am62x: am62x.env: Use default findfdt
  arm: mach-k3: am625_init: Use IS_ENABLED()
  arm: mach-k3: am625_init: Convert rtc_erratumi2327_init to static
  configs: am62x_evm*: Enable EMMC_BOOT configuration
  arm: mach-k3: am625: Add support for UDA FS
  arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
  board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file
  doc: board: ti: Add BeaglePlay documentation

Robert Nelson (1):
  arm: dts: Add k3-am625-beagleplay

 arch/arm/dts/Makefile                         |    2 +
 .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  195 ++
 arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   86 +
 arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
 arch/arm/mach-k3/am625_init.c                 |   49 +-
 board/siemens/iot2050/iot2050.env             |    2 +-
 board/ti/am62ax/am62ax.env                    |    2 +-
 board/ti/am62x/MAINTAINERS                    |    7 +
 board/ti/am62x/am62x.env                      |    7 +-
 board/ti/am62x/beagleplay.env                 |   18 +
 board/ti/am62x/beagleplay_a53.config          |   55 +
 board/ti/am62x/beagleplay_r5.config           |   15 +
 board/ti/am64x/am64x.env                      |    2 +-
 board/ti/am65x/am65x.env                      |    2 +-
 board/ti/j721e/j721e.env                      |    2 +-
 board/ti/j721s2/j721s2.env                    |    2 +-
 board/ti/ks2_evm/k2e_evm.env                  |    2 +-
 board/ti/ks2_evm/k2g_evm.env                  |    2 +-
 board/ti/ks2_evm/k2hk_evm.env                 |    2 +-
 board/ti/ks2_evm/k2l_evm.env                  |    2 +-
 configs/am62x_evm_a53_defconfig               |    6 +-
 configs/am62x_evm_r5_defconfig                |    1 +
 doc/board/ti/am62x_beagleplay.rst             |  256 ++
 doc/board/ti/img/beagleplay_emmc.svg          |  697 ++++++
 doc/board/ti/k3.rst                           |    1 +
 include/configs/am62x_evm.h                   |    6 -
 include/configs/ti_armv7_common.h             |    2 +-
 .../ti/{ti_armv7_common.env => ti_common.env} |   12 +
 30 files changed, 4342 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
 create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
 create mode 100644 board/ti/am62x/beagleplay.env
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 doc/board/ti/am62x_beagleplay.rst
 create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
 rename include/env/ti/{ti_armv7_common.env => ti_common.env} (71%)

-- 
2.40.0

