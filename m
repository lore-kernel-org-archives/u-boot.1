Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9699DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0CE8776E;
	Fri,  3 Nov 2023 01:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RYwrid/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3690087718; Fri,  3 Nov 2023 01:38:36 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3511B8768D
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c8Rj099915;
 Thu, 2 Nov 2023 19:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971888;
 bh=Xur+gi2DW/uFvuR0JY1wMVaLWHGU816XQEx6b3v0aPA=;
 h=From:To:CC:Subject:Date;
 b=RYwrid/tldezfyq1Ap2stzNpv31pITRXHF2zX8CscEMmb+Kqh4AWdivJ2Y6zFvvhh
 OxDhZBYL6fNVo88Lt05GMkV6x1Epl1eOJJU3M4/wufc+s5xhb0gRiOakrJZrI42flh
 gN4YJ6IBYKzUxTq64db6ODpJkz+a+baWZ/iDPEUs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30c8EN120004
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30c84l030429;
 Thu, 2 Nov 2023 19:38:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 00/15] board: ti: Add support for BeagleBone AI-64
Date: Thu, 2 Nov 2023 19:37:50 -0500
Message-ID: <20231103003805.2420005-1-nm@ti.com>
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

Cleanups for J721e/J7200 and add support for BeagleBone AI-64

Based off:
master 07fe79c93c5c Merge tag 'i2cfixes-for-v2024-01-rc2' of https://source.denx.de/u-boot/custodians/u-boot-i2c

Boot Logs:
J721e-SK: https://gist.github.com/nmenon/c144e64f1da9fd49997ef5794b056bb0
J721e-EVM: https://gist.github.com/nmenon/e79bed6807da05c723e71687fb3c0b90
J7200-HSEVM: https://gist.github.com/nmenon/5658dd6fa2f67bce915c77b25c02f897

BeagleBone AI-64:
SD/MMC boot: https://gist.github.com/nmenon/1e07858fb8ca39ca87e40d3894e4d9b7
eMMC boot: https://gist.github.com/nmenon/9b0602df1f1be2c6b512d135b0afae60
eMMC boot with SDcard detected: https://gist.github.com/nmenon/82058014f4b2f6b9ed21431bc675e12a

U-Boot CI: https://github.com/u-boot/u-boot/pull/444

BeagleBone AI-64 is introduced without EEPROM detection and cleanups
to j721e evm configuration is done to facilitate that. based on when
and timing of [1] is merged in, we can introduce an equivalent patch or
squash similar patch in for beagleboneai64.

Boot uses stdboot as default - so we also transition j721e over to
sdboot along with it.

Fixes a breakage with HBMC that was getting in my way of testing, but I
have'nt focussed on converting j7200 to stdboot - but probably a minor
patch similar to that in this series for j721e.

What works:
* emmc, sd, dhcp, basic i2c gpio etc..
* DDR looks stable as well.

TODO:
* PMIC support will need to be added for AVS to be active - something to
  do once upstream kernel gets that support
* USB boot is broken (or was just noticed) - some sort of regression with
  serdes is my best guess.
* We could potentially enable something like nvme boot as well if we can
  make PCIe work

Nishanth Menon (14):
  arm: mach-k3: j721e: Improve support for UDA FS
  configs: j7200: Remove HBMC_AM654 config
  board: ti: j721e: evm: Drop board check for ESM
  board: ti: j721e: evm: Drop unused headers
  board: ti: j721e: evm: Switch to using IS_ENABLED
  board: ti: j721e: evm: Drop board based serdes initialization
  board: ti: j721e: evm: Use IS_ENABLED with CONFIG_PHYS_64BIT
  board: ti: j721e: evm: Split code to isolate eeprom detected logic
  board: ti: j721e: j721e.env: Add explicit boot_targets
  configs: j721e_evm_a72_defconfig: Switch to bootstd
  arm: dts: k3-j721e-binman: Allow a single board configuration
  arm: dts: k3-j721e-binman: Use macros that can be overridden for dtbs
  board: ti: Add j721e_beagleboneai64_* config fragments and env file
  doc: board: ti: Add BeagleBone AI-64 documentation

Robert Nelson (1):
  arm: dts: Add k3-j721e-beagleboneai64

 arch/arm/dts/Makefile                         |    5 +-
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  206 ++
 arch/arm/dts/k3-j721e-beagleboneai64.dts      |  993 ++++++++
 arch/arm/dts/k3-j721e-binman.dtsi             |   33 +-
 .../k3-j721e-common-proc-board-u-boot.dtsi    |    2 +
 .../k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi | 2200 +++++++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |   96 +
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |    2 +
 arch/arm/mach-k3/j721e_init.c                 |    9 +-
 board/ti/j721e/MAINTAINERS                    |    7 +
 board/ti/j721e/Makefile                       |    1 +
 board/ti/j721e/beagleboneai64.env             |   19 +
 board/ti/j721e/beagleboneai64_a72.config      |   55 +
 board/ti/j721e/beagleboneai64_r5.config       |   19 +
 board/ti/j721e/{evm.c => board-variants.c}    |  276 +--
 board/ti/j721e/evm.c                          |  459 +---
 board/ti/j721e/evm.h                          |   24 +
 board/ti/j721e/j721e.env                      |    1 +
 configs/j7200_evm_a72_defconfig               |    1 -
 configs/j7200_evm_r5_defconfig                |    1 -
 configs/j721e_evm_a72_defconfig               |    5 +-
 doc/board/ti/j721e_beagleboneai64.rst         |  327 +++
 doc/board/ti/k3.rst                           |    1 +
 23 files changed, 4083 insertions(+), 659 deletions(-)
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64.dts
 create mode 100644 arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
 create mode 100644 board/ti/j721e/beagleboneai64.env
 create mode 100644 board/ti/j721e/beagleboneai64_a72.config
 create mode 100644 board/ti/j721e/beagleboneai64_r5.config
 copy board/ti/j721e/{evm.c => board-variants.c} (63%)
 create mode 100644 board/ti/j721e/evm.h
 create mode 100644 doc/board/ti/j721e_beagleboneai64.rst

[1] https://lore.kernel.org/all/20231101170519.39627-1-afd@ti.com/
-- 
2.40.0

