Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167CCD1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F4E88F91;
	Tue, 22 Oct 2024 08:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="fIWpbP9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A44088F82; Tue, 22 Oct 2024 08:04:34 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 376D088E31
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202410220604314c47aefd9c98991523 for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=NOUMkE4gUv1EAIU9AqUrsju6bX6Zic7CsRE/jSjxxvM=;
 b=fIWpbP9LQVFer7RO2UELEB3wxQVDvHE9gwE7Z1cAgzb8ncK0mXxym2jCf5gqR/rn1+HJpp
 BYnMgO9um4wi3MC7p+0Rcg2TrGBtd2ndK8qsFxeiB7lTHCjYxDBVbnl2Q81Tq1XaY2UA5OVU
 nP4+F8zBEyW4jx/2tUNTSiYjSajeT8COLHBsT4PlcaU/rGiBpvQJ54qJqrffHwEdGhE54k8e
 PKMxtdCVFzR04kk/dljmevhi6nGV0+5WBiq8RvAA5T3TGEpMYG6iiXxWL+dWII8NJCJUqvra
 D7oQSyT5wrbBTVnlUd9pCUfuI2xpI1Xe0vtP9cMrEGs+bOkjfq52lhjw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v2 00/13] boards: siemens: iot2050: SM variant, sysinfo support,
 fixes & cleanups
Date: Tue, 22 Oct 2024 08:04:17 +0200
Message-ID: <cover.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

Changes in v2:
 - rebased over master, adding the missing 6.12 cherry-picks from
   devicetree-rebasing

This adds support for the new IOT2050 SM variant, introduces a sysinfo
driver which also permits SMBIOS support and switches the board to
OF_UPSTREAM. There are some further fixes for the boards included as well.

Not yet included is configuration support for DMA isolation via the PVU as
this depends on not yet merged DT bindings and another overlay.

Jan


CC: Baocheng Su <baocheng.su@siemens.com>
CC: Li Hua Qian <huaqian.li@siemens.com>

Baocheng Su (5):
  board: siemens: iot2050: Fix coding style
  board: siemens: iot2050: Control pcie power for all variants
  board: siemens: iot2050: Pass DDR size from FSBL
  board: siemens: iot2050: Generalize the fdt fixup
  board: iot2050: Support new IOT2050-SM variant

Jan Kiszka (5):
  board: siemens: iot2050: Fix mistake in list of writable env vars
  board: siemens: iot2050: Stop using special spl DT sources
  arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware
  board: siemens: iot2050: Migrate to OF_UPSTREAM
  smbios: Fill UUID from sysinfo when available

Li Hua Qian (3):
  arm64: dts: ti: iot2050: Disable lock-step for all iot2050 boards
  sysinfo: Add driver for IOT2050 boards
  board: siemens: iot2050: Use sysinfo for board initialization

 arch/arm/dts/Makefile                         |   8 -
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  19 +-
 arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi  |  46 --
 arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi  |  51 --
 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  18 +
 arch/arm/dts/k3-am65-iot2050-common.dtsi      | 738 ------------------
 arch/arm/dts/k3-am65-iot2050-spl.dts          |  17 -
 .../dts/k3-am6528-iot2050-basic-common.dtsi   |  61 --
 arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts  |  24 -
 arch/arm/dts/k3-am6528-iot2050-basic.dts      |  24 -
 .../k3-am6548-iot2050-advanced-common.dtsi    |  52 --
 .../arm/dts/k3-am6548-iot2050-advanced-m2.dts | 119 ---
 .../dts/k3-am6548-iot2050-advanced-pg2.dts    |  29 -
 .../k3-am6548-iot2050-advanced-sm-u-boot.dtsi |   1 +
 arch/arm/dts/k3-am6548-iot2050-advanced.dts   |  24 -
 arch/arm/mach-k3/am65x/Kconfig                |   2 +
 board/siemens/iot2050/board.c                 | 226 ++++--
 configs/iot2050_defconfig                     |   7 +-
 doc/board/siemens/iot2050.rst                 |   7 +-
 drivers/sysinfo/Kconfig                       |   7 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/iot2050.c                     | 143 ++++
 drivers/sysinfo/iot2050.h                     |  26 +
 .../arm64/ti/k3-am65-iot2050-common-pg2.dtsi  |   5 -
 .../src/arm64/ti/k3-am65-iot2050-common.dtsi  |   5 +
 .../src/arm64/ti/k3-am6528-iot2050-basic.dts  |   5 -
 ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso |   2 +-
 ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso |   2 +-
 include/configs/iot2050.h                     |   5 +-
 include/sysinfo.h                             |   1 +
 lib/smbios.c                                  |   4 +
 31 files changed, 379 insertions(+), 1300 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-spl.dts
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic.dts
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-pg2.dts
 create mode 120000 arch/arm/dts/k3-am6548-iot2050-advanced-sm-u-boot.dtsi
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced.dts
 create mode 100644 drivers/sysinfo/iot2050.c
 create mode 100644 drivers/sysinfo/iot2050.h
 rename arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso => dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso (92%)
 rename arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso => dts/upstream/src/arm64/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso (96%)

-- 
2.43.0

