Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F248C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4221286AF7;
	Fri, 25 Aug 2023 20:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lZk9Lim/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FDC86AD8; Fri, 25 Aug 2023 20:03:24 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9415386ADE
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36rc111931;
 Fri, 25 Aug 2023 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986586;
 bh=49vvlgde9BKPQFBLjTryP2O6D3dz41oZ4hDoCKDxV64=;
 h=From:To:CC:Subject:Date;
 b=lZk9Lim/JVDkp162PsUTmtqM5d7voZgJwwfg/An5uHrShJRSfwOTL3SX5QdbJ2JhA
 ADOlB+UVcI0w1cbwv+SV4rcRuactnzP7y3xCsboczxpkua3RdwgjEzw/ssdDbYMMvp
 TB0Hy2JShithsjN9WTpN8rYqdTXH0vTawJGdaI+g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI3624085957
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI35ol114799;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 00/20] board: ti: Add support for BeaglePlay
Date: Fri, 25 Aug 2023 13:02:45 -0500
Message-ID: <20230825180305.69515-1-nm@ti.com>
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

Alright, 6th time is a charm ;) Hopefully this takes care of all
the un-addressed concerns we have had. Thanks all for pitching in,
reviewing and improving and I will stop finding things to
cleanup (promise).

Baseline: 7c6b18fb5494 (origin/next) Merge branch '2023-08-24-enable-more-features-in-qemu-arm' into next
Full series available: https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v6
Boot Logs: https://gist.github.com/nmenon/8be4106e2d0b572aa5e77d93476095b4

Caveats:
* Networking: pending https://lore.kernel.org/all/20230822121350.51324-1-rogerq@kernel.org/
* 32kclk and usb: pending:
  https://lore.kernel.org/u-boot/20230725185253.2123433-4-nm@ti.com/
  OR https://github.com/nmenon/fix-k3-dt-u-boot/commit/853b29d63c1ca642be316f1afb0fb778610dec46
  being properly resolved (NOTE: without this patch, wlan is broken in
  Linux as the 32kclk from SoC is incorrectly supplied to wlan as 25MHz)
* There seems to be a bug in Linux kernel with sdhci that seems to
  depend on u-boot initialization of sdhci for functionality (TI
  internal actions already triggered).
* buildman discussion about config fragments:
  https://lore.kernel.org/all/CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com/
* Documentation that we can copy paste:
  https://lore.kernel.org/all/20230824154036.3650607-1-nm@ti.com/
  and followon in kernel.org:
  https://lore.kernel.org/all/149528e1-062b-ebed-aa25-d37be5fe5894@iogearbox.net/
  if it all percolates back down to u-boot tree, should be trivial
  cleanup.
* Build fails with binman implementation for TI SoCs - Neha will take
  care of
  https://lore.kernel.org/all/227d74cf-9e95-4f5f-af96-49d054cde7aa@ti.com/
* This series picks up Jan's patch for working around Device Manager not
  compliant with EFI specification reqs and applies it to am62x_sk (TI
  internal action already triggered)
  https://lore.kernel.org/all/20230825011623.c74qqidp6wgvc5kl@plaza/
* I noticed that when drivers like the am654_sdhci.c uses
  deffered_probe, the default probe function does'nt fail
  https://source.denx.de/u-boot/u-boot/-/blob/master/boot/bootflow.c#L279
  So ends up attempting for each of the boot_targets even if mmc dev
  dev_id would fail. Not really sure how to solve it, so will leave it
  here. (the https://gist.github.com/nmenon/8be4106e2d0b572aa5e77d93476095b4#file-beagleplay-emmc-sd-not-inserted
  should show a bunch of 'MMC: no card present' each of which costs around
  1 second.

Changes since V5:
* New patches to clean up mmc.env to sync with BOOTSTD operations yet
  enable easier non-U-Boot developer experience for uEnv.txt and
  optimize access to non-plugged in sd-card.
* Picked up Jan's patch[1] as part of this series.
* Introduced default_findfdt.env as review comment
* Saw Simon's feedback on uSD boot, and documented that as well, will be
  good for new devs to have that info in one flow.
* Quick overall diff: https://gist.github.com/nmenon/6d934f4e1092aa293a771d26b0f2bff7

V5: https://lore.kernel.org/all/20230824031101.3460411-1-nm@ti.com/
V4: https://lore.kernel.org/all/20230822184135.2328409-1-nm@ti.com/
V3: https://lore.kernel.org/all/20230815164440.2713726-1-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/

Jan Kiszka (1):
  configs: am62x_evm_a53_defconfig: Disable semi-functional PSCI reset
    support

Nishanth Menon (18):
  include: env: ti: mmc: envboot/mmcboot: Check result of mmc dev before
    proceeding
  include: env: ti: mmc: envboot: Only attempt boot.scr if BOOTSTD is
    not enabled
  include: configs: ti_armv7_common: Add documentation for protected
    section
  include: configs: am62x_evm: Drop unused SDRAM address
  include: configs: am62x_evm: Wrap distroboot with
    CONFIG_DISTRO_DEFAULTS
  board: ti: am62x: am62x.env: Add explicit boot_targets
  configs: am62x_evm_a53_defconfig: Switch to bootstd
  include: configs: am62x_evm: Drop distro_bootcmd usage
  include: env: ti: ti_armv7_common.env: Rename to ti_common.env
  include: env: ti: Add a generic default_findfdt.env
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
 board/ti/am62x/am62x.env                      |    8 +-
 board/ti/am62x/beagleplay.env                 |   19 +
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
 configs/am62x_evm_a53_defconfig               |    7 +-
 configs/am62x_evm_r5_defconfig                |    1 +
 doc/board/ti/am62x_beagleplay.rst             |  322 +++
 doc/board/ti/img/beagleplay_emmc.svg          |  697 ++++++
 doc/board/ti/k3.rst                           |    1 +
 include/configs/am62x_evm.h                   |    6 -
 include/configs/ti_armv7_common.h             |    2 +-
 include/env/ti/default_findfdt.env            |   12 +
 include/env/ti/mmc.env                        |   12 +-
 .../ti/{ti_armv7_common.env => ti_common.env} |    0
 32 files changed, 4419 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
 create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
 create mode 100644 board/ti/am62x/beagleplay.env
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 doc/board/ti/am62x_beagleplay.rst
 create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
 create mode 100644 include/env/ti/default_findfdt.env
 rename include/env/ti/{ti_armv7_common.env => ti_common.env} (100%)

[1] https://lore.kernel.org/all/c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de/
-- 
2.40.0

