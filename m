Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E157DC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61246870FC;
	Sat,  4 Nov 2023 09:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IkTUmO74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2AF870F6; Sat,  4 Nov 2023 09:11:42 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B948A87113
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B5vN069743;
 Sat, 4 Nov 2023 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699085465;
 bh=zVaBaVvfapo9506gqAYqa5wuj9SL2xGxxKAImMZY0hU=;
 h=From:To:CC:Subject:Date;
 b=IkTUmO74aGP+FUYa510qI2gQCiMSLKQJLX2BlpdVh4xu/BE73cumLFEDKUm/3J4xv
 FFNDKVCB4kRlKJo1FSkEaq7ar8m80BZB9387eBHG/cC+LisQcwlckpAj3/yCu3LlEI
 sjNdUwkFvQjLHKmkjk1HhUPLureZqS8hnKYwqJ9w=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A48B4sA017562
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:11:04 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:11:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:11:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B4q1106351;
 Sat, 4 Nov 2023 03:11:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 0/4] board: ti: Add support for BeagleBone AI-64
Date: Sat, 4 Nov 2023 03:10:59 -0500
Message-ID: <20231104081103.10607-1-nm@ti.com>
X-Mailer: git-send-email 2.37.2
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

Refactored series purely focussed on introducing BeagleBone AI-64

Cleanups are isolated off into their own series.

What works:
* emmc, sd, dhcp, basic i2c gpio etc..
* DDR looks stable as well.

TODO:
* PMIC support will need to be added for AVS to be active - something to
  do once upstream kernel gets that support
* USB boot is broken (or was just noticed in v1) - some sort of regression with
  serdes is my best guess.
* We could potentially enable something like nvme boot as well if we can
  make PCIe work

BootLogs:

AI64 (SD): https://gist.github.com/nmenon/0de3149737c517083443ab7077e6a9e4
AI64 (emmc boot with SD): https://gist.github.com/nmenon/71f978c0ad02e0977564c4fd6ecf751f
AI64 (emmc boot without SD): https://gist.github.com/nmenon/469c2ff3b7af0a568764896fd9aafd18

The complete series including dependencies can be found at:
https://github.com/nmenon/u-boot/commits/beagleboneai64-v2

CI loop (for complete series): https://github.com/u-boot/u-boot/pull/445

Dependencies (in order):
(keys and yaml)
1. https://lore.kernel.org/all/20231101183329.65091-1-afd@ti.com/
2. https://lore.kernel.org/u-boot/20231104024511.3597476-1-nm@ti.com/
(docs prompt cleanup - gets in the way of moving things)
3. https://lore.kernel.org/u-boot/20231103000915.2413501-1-nm@ti.com/
(j7200/J721e cleanups):
4. https://lore.kernel.org/u-boot/20231104072150.3339-1-nm@ti.com/
(Beagle - move products to beagle vendor folder):
5. https://lore.kernel.org/u-boot/20231104080137.9628-1-nm@ti.com/

Changes since V1:
* Major refactoring to put BeagleBone AI-64 under beagle vendor folder.
* Split into additional series

V1: https://lore.kernel.org/u-boot/20231103003805.2420005-1-nm@ti.com/

Nishanth Menon (3):
  board: beagle: Add BeagleBone AI-64 support
  configs: Add j721e_beagleboneai64_* configs
  doc: board: beagle: Add BeagleBone AI-64 documentation

Robert Nelson (1):
  arm: dts: Add k3-j721e-beagleboneai64

 arch/arm/dts/Makefile                         |    5 +-
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  358 ++
 arch/arm/dts/k3-j721e-beagleboneai64.dts      |  993 ++++++
 .../k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi | 2200 ++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  185 +
 arch/arm/mach-k3/Kconfig                      |    1 +
 board/beagle/beagleboneai64/Kconfig           |   59 +
 board/beagle/beagleboneai64/MAINTAINERS       |    6 +
 board/beagle/beagleboneai64/Makefile          |   10 +
 board/beagle/beagleboneai64/beagleboneai64.c  |   30 +
 .../beagle/beagleboneai64/beagleboneai64.env  |   19 +
 board/beagle/beagleboneai64/board-cfg.yaml    |   36 +
 board/beagle/beagleboneai64/pm-cfg.yaml       |   12 +
 board/beagle/beagleboneai64/rm-cfg.yaml       | 3174 +++++++++++++++++
 board/beagle/beagleboneai64/sec-cfg.yaml      |  380 ++
 configs/j721e_beagleboneai64_a72_defconfig    |  171 +
 configs/j721e_beagleboneai64_r5_defconfig     |  131 +
 doc/board/beagle/index.rst                    |    1 +
 doc/board/beagle/j721e_beagleboneai64.rst     |  327 ++
 doc/board/ti/k3.rst                           |    1 +
 20 files changed, 8098 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64.dts
 create mode 100644 arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
 create mode 100644 board/beagle/beagleboneai64/Kconfig
 create mode 100644 board/beagle/beagleboneai64/MAINTAINERS
 create mode 100644 board/beagle/beagleboneai64/Makefile
 create mode 100644 board/beagle/beagleboneai64/beagleboneai64.c
 create mode 100644 board/beagle/beagleboneai64/beagleboneai64.env
 create mode 100644 board/beagle/beagleboneai64/board-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/pm-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/rm-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/sec-cfg.yaml
 create mode 100644 configs/j721e_beagleboneai64_a72_defconfig
 create mode 100644 configs/j721e_beagleboneai64_r5_defconfig
 create mode 100644 doc/board/beagle/j721e_beagleboneai64.rst

-- 
2.37.2

