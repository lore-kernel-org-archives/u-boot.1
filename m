Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6001CCD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9432988AE8;
	Tue,  3 Sep 2024 13:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h/jA1Ec2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8DF88AE8; Tue,  3 Sep 2024 13:44:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 486D8888AA
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483Bi7Iw020984;
 Tue, 3 Sep 2024 06:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725363847;
 bh=zNniZhHGm/gdJpJOdPWcwVES6Jl6x1c2SQEovi3RbhA=;
 h=From:To:CC:Subject:Date;
 b=h/jA1Ec21eK8T0ERqYoTtjiF0Jixs/sCIObtek5k/pPKMdq0Xtdo03U5NYin+ekUI
 YgqfdJm3Q4st9XY2Dbc2hSm1xRWs5u0jvZjtQcSRwykRpVwvDCChXZIHncssPfsBDd
 JCsMyxVGyPBrGBQI12Ew8N79G6R1vV0sh7Jd9j7E=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483Bi7B5013700
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Sep 2024 06:44:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 06:44:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 06:44:06 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483Bi2R2056540;
 Tue, 3 Sep 2024 06:44:03 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [RFC PATCH 0/6] Add support for K3 BIST
Date: Tue, 3 Sep 2024 17:13:56 +0530
Message-ID: <20240903114402.2155740-1-n-francis@ti.com>
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

This is an RFC series that aims to implement a driver for the BIST
(Built-In Self Test) module for K3 devices. The BIST driver must ideally
support triggering of BIST tests, both PBIST (Memory BIST) and LBIST
(Logic BIST) on a core. Both tests are destructive in nature. Please see
links [1] and [2] for further information regarding the two.

At boot up, BIST is executed by hardware for the MCU domain
automatically as part of HW POST. So BIST has been checked only for the
MCU domain, and it makes sense to include our driver for BIST at the MCU
R5 SPL stage. The driver can trigger BIST runs for the rest of the cores
before loading and running any firmware on the cores.

The general procedure for triggering BIST on a core is:
	1. Power on the core under test
	2. Trigger the BIST test
	3. Reset the core under test

This series, triggers PBIST tests on the MAIN_R5_2_x cores.

This is marked as RFC for a couple of WIP reasons:
	- the core under test is confirmed to be accessible (powered on)
	  before running the test, and unaccessible after running the
	  test by connecting the debugger to the core, however the
	  firmware calls that check if a core is running or not at A72
	  U-Boot stage responds as the core is still running. Due to
	  this, before loading or running firmware, an explicit 'stop'
	  needs to be issued by the remoteproc framework (which does not
	  work at the earlier R5 stage as the DM firmware is not up
	  yet). Please see the boot logs to understand. This is under
	  debug.
	- the driver currently implements all three PBIST tests (PBIST,
	  PBIST failure insertion and PBIST ROM); LBIST is WIP but will
	  be more or less similar to how PBIST has been implemented

Would appreciate reviews/comments on how this driver is modelled.

Boot logs:
https://gist.github.com/nehamalcom/63e94dbfc8a9b9fcaba6f45210e20cea

[1] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/pbist.html#introduction
[2] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/lbist.html#introduction

Neha Malcom Francis (6):
  arm: mach-k3: j784s4: Add clk and power support for MAIN_R5_2_x PBIST
  arm: dts: k3-j784s4-main: Add PBIST_14 node
  arm: dts: k3-j784s4-main: Add clock and power domains for MAIN_R5_2_x
  drivers: misc: k3_bist: Add K3 BIST driver
  arm: mach-k3: j784s4_init: Trigger BIST
  configs: j784s4_evm_r5_defconfig: Enable BIST

 arch/arm/mach-k3/j784s4/j784s4_init.c         |  11 +
 arch/arm/mach-k3/r5/j784s4/clk-data.c         |  13 +
 arch/arm/mach-k3/r5/j784s4/dev-data.c         |   7 +
 configs/j784s4_evm_r5_defconfig               |   2 +
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/k3_bist.c                        | 507 ++++++++++++++++
 drivers/misc/k3_bist_static_data.h            | 551 ++++++++++++++++++
 dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi |  19 +
 9 files changed, 1119 insertions(+)
 create mode 100644 drivers/misc/k3_bist.c
 create mode 100644 drivers/misc/k3_bist_static_data.h

-- 
2.34.1

