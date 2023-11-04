Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88735C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B838746C;
	Sat,  4 Nov 2023 08:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kOgmIsw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0781187119; Sat,  4 Nov 2023 08:23:01 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4DE87158
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LrlV130563;
 Sat, 4 Nov 2023 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082513;
 bh=l9noZza1MvabDzZ+nYL6YHh3rG7TAAOMXcGdRzNoFoU=;
 h=From:To:CC:Subject:Date;
 b=kOgmIsw/KoolowcM5EtdzKHcptGJ9xmOoOqUHj0eH6vZ3AMqf30tCTiva7BlY0bHR
 qYbauxGwZkjOIt8pNety86uyLrtnnRw8sqZnFDc4MGzeZjkjDlLpKGphRyrrjCuTpi
 6FfHpdgiSodsypACdFCV7raeEij/awYqf6j65dKk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LrpI029577
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LrJf103840;
 Sat, 4 Nov 2023 02:21:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 00/12] board: ti: j721e: cleanup
Date: Sat, 4 Nov 2023 02:21:38 -0500
Message-ID: <20231104072150.3339-1-nm@ti.com>
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

This series was originally posted as part of BeagleBone AI-64
enablement, instead, I have spun it off as it's own series on which
BeagleBone AI-64 will depend on.

Changes since V1:
* Moved j7200 to bootstd in addition to j721e
* Dropped a couple of controversial patches around DDR and refactor to
  move eeprom code into it's own file
* Added Kconfig option that makes it feasible to add BeagleBone AI-64
  (mmu refactor)
* Documentation path updates to ease up BeagleBone AI-64 documentation.

V1: https://lore.kernel.org/u-boot/20231103003805.2420005-1-nm@ti.com/

Complete series including this one can be found here:
https://github.com/nmenon/u-boot/commits/beagleboneai64-v2

Boot Logs:
J7200 HSEVM:https://gist.github.com/nmenon/5b5850311c2e23ba746c5e9631fc1380
J7200 EVM (GP): https://gist.github.com/nmenon/6e579b74ba8b2e1e0cc108922486b27a
J721E IDK/EVM: https://gist.github.com/nmenon/8d03e88aeb10b4d8bd02571325762e90

Nishanth Menon (12):
  board: ti: j721e: evm: Drop unused headers
  board: ti: j721e: evm: Drop board check for ESM
  board: ti: j721e: evm: Switch to using IS_ENABLED
  board: ti: j721e: j721e.env: Add explicit boot_targets
  configs: j721e_evm_a72_defconfig: Switch to bootstd
  arm: mach-k3: Kconfig: Introduce a symbol to indicate J7200
  board: ti: j721e: Select SOC_K3_J721E_J7200 for J7200evm
  arm: mach-k3: arm64-mmu: Refactor to be independent of board
  arm: mach-k3: j721e: Improve support for UDA FS
  configs: j7200: Remove HBMC_AM654 config
  configs: j7200_evm_a72_defconfig: Switch to bootstd
  doc: board: ti: j721e_evm: Use board relative path for include
    directives

 arch/arm/mach-k3/Kconfig        |   5 ++
 arch/arm/mach-k3/arm64-mmu.c    |  50 ++++++++--------
 arch/arm/mach-k3/j721e_init.c   |   9 ++-
 board/ti/j721e/Kconfig          |   1 +
 board/ti/j721e/evm.c            | 101 ++++++++++++++------------------
 board/ti/j721e/j721e.env        |   1 +
 configs/j7200_evm_a72_defconfig |   6 +-
 configs/j7200_evm_r5_defconfig  |   1 -
 configs/j721e_evm_a72_defconfig |   5 +-
 doc/board/ti/j721e_evm.rst      |  18 +++---
 10 files changed, 99 insertions(+), 98 deletions(-)

-- 
2.37.2

