Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC19C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B1682A36;
	Mon,  9 Jun 2025 10:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ask8SxzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AFC82A36; Mon,  9 Jun 2025 10:14:38 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D810E82958
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598EYDF717023;
 Mon, 9 Jun 2025 03:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456874;
 bh=gBnmLmuq2UDwoBMHnQ+GaB410YYsChmqEM0gv5bUcTs=;
 h=From:To:CC:Subject:Date;
 b=ask8SxzNHMkAcZnouIlIpnqIp+gkeQ/UAS+tGC3POs+1p2Z3g/ZHftX0cR2pfje+i
 KJDOtHKTSgb2eQJn7xlkfYodU92QUCHkDNyHex5G2GEjLa82+6IO2ghWLBRCVMf9di
 sk881HKL36qPGNcySNnhVBBD2B/wuXZUfDCxvhKc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598EYmq3552401
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:33 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EUSw1101082;
 Mon, 9 Jun 2025 03:14:31 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v3 0/4] Add IPC support on MCU R5F cluster in Split Mode
Date: Mon, 9 Jun 2025 13:44:25 +0530
Message-ID: <20250609081429.1724643-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds remoteproc support on MCU R5F in Split mode.

During boot, ROM can bring up the boot R5F cores in either lockstep or
split mode based on X509 certificate flags. If booted in lockstep mode,
the MCU R5F cores will run first the R5 SPL, and then once A72 comes up,
will run the Device Manager (DM) firmware. But if booted in split mode, core
0 will run DM firmware and second core sits in WFI. Shut it down so that
other firmwares can later be loaded on them.

The shutdown of MCU R5 Core 1 is invoked at A72 SPL init, as by that
time Device Manager (DM) is up and running on R5 Core 0. The shutdown
of MCU R5 Core 1 is handled by Device Manager itself.

The devicetree patch [PATCH 6/6] need not be merged here, as it will be sent to
the Linux Upstream list.

v3: Changelog:
1. Added check to see if core is powered-on and in WFI, before powering it off
in [PATCH v3 2/4] (Hari)
2. Made message logging better by putting error codes in case of failures in
[PATCH v3 2/4].
3. Carried R/B tags from Neha since v1.

Link to v2:
https://lore.kernel.org/all/20250602145015.1274726-1-b-padhi@ti.com/

v2: Changelog:
1. Dropped patches 5 and 6 from v1. v2 only aims to add the infrastructure to
boot R5 in split mode. [Tom/Nishanth]
2. Used "__maybe_unused" macro for shutdown_mcu_r5_core1() in [PATCH v2 2/4]
(Neha).

Link to v1:
https://lore.kernel.org/all/20250522071828.285462-1-b-padhi@ti.com/

Testing done:
1. Build test on all existing TI K3 platforms.
2. Tested U-Boot and Linux load of MCU R5F core in split mode on all applicable
boards (AM68-SK, AM69-SK, J7200-EVM, J721E-EVM, J721S2-EVM, J784S4-evm,
J742S2-EVM)

Test logs:
https://gist.github.com/3V3RYONE/ee8e3cb9aa5f4c5c00b059b9c14bfa98

Thanks,
Beleswar

Beleswar Padhi (4):
  arm: mach-k3: {am6/j7}*_hardware.h: Expose MCU R5 proc and device ids
  arch: mach-k3: common: Add support to shutdown MCU R5 Core 1
  remoteproc: k3-r5: Acquire processor control before reset ops
  board: ti: j7*: Add firmware for MCU R5 core1

 arch/arm/mach-k3/common.c                     | 69 +++++++++++++++++++
 arch/arm/mach-k3/common.h                     |  1 +
 arch/arm/mach-k3/include/mach/am62_hardware.h |  4 +-
 .../arm/mach-k3/include/mach/am62a_hardware.h |  4 +-
 .../arm/mach-k3/include/mach/am62p_hardware.h |  4 +-
 arch/arm/mach-k3/include/mach/am64_hardware.h |  9 +--
 arch/arm/mach-k3/include/mach/am6_hardware.h  |  9 +--
 .../arm/mach-k3/include/mach/j721e_hardware.h |  9 +--
 .../mach-k3/include/mach/j721s2_hardware.h    |  9 +--
 .../arm/mach-k3/include/mach/j722s_hardware.h |  4 +-
 .../mach-k3/include/mach/j784s4_hardware.h    |  9 +--
 arch/arm/mach-k3/j721e/j721e_init.c           |  9 ++-
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  7 ++
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  7 ++
 board/ti/j7200/j7200.env                      |  2 +-
 board/ti/j721e/j721e.env                      |  2 +-
 board/ti/j721s2/j721s2.env                    |  2 +-
 board/ti/j784s4/j784s4.env                    |  4 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c          |  6 ++
 19 files changed, 136 insertions(+), 34 deletions(-)

-- 
2.34.1

