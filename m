Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F85ECD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9C886B98;
	Fri, 22 Sep 2023 12:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c4cJUBX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C5986B93; Fri, 22 Sep 2023 12:40:06 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBBA86B55
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MAe1Ro024618;
 Fri, 22 Sep 2023 05:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695379201;
 bh=BkCbyKQBZwOXUI0r0hoTU6aQtyN5sTW29sSyM2lG1do=;
 h=From:To:CC:Subject:Date;
 b=c4cJUBX+KVHrPln579TNsfzYcrCfXlikOwnnEhek2lk/W9e0dpYOlDaaYullreZEL
 xoIqEuyTaTTjPTEkPhZXwM28CiWBMeV88ud6mDqz9cex5hFRyy6VjCYKrjEtDofD2W
 GRlpdOqgv0km3Y6TIqjAJZF80fjBDmhsMryoaEUI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MAe1mU013554
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 05:40:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 05:40:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 05:40:00 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MAdtBr034669;
 Fri, 22 Sep 2023 05:39:56 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/6] [PATCH v3 0/6] J721E DTS Sync with Kernel v6.6-rc1
Date: Fri, 22 Sep 2023 16:09:48 +0530
Message-ID: <20230922103954.3454891-1-n-francis@ti.com>
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

This series aims to sync kernel.org v6.6-rc1 DTS with that of U-Boot. It
also includes cleanups where necessary along with certain changes to
ensure boot is unaffected.

Same as with other board series that have taken up this effort, cleanup
of mcu_ringacc and mcu_udmap are dependent on MCU DMA [1] fixes. Also
adding TPS6594 PMIC support is still under review [2] in the Kernel.
These will be taken up after their merge to Linux.

[1] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[2] https://lore.kernel.org/all/20230810-tps6594-v6-0-2b2e2399e2ef@ti.com/

Boot logs:
https://gist.github.com/nehamalcom/52dd8f2b553952108c0d16556f58077a

Changes in v3:
	- Nishanth:
		- synced to v6.6-rc1 from v6.5-rc1
		- reworded commit messages
		- removed patch adding k3_avs compatible since it has
		  been merged to -next separately
		- removed unnecessary #includes
		- added extra comments for OSPI reg overrides
		- removed hbmc node from R5 DTS
		- changed ti_sci_get_cmd_revision to be at a common
		  point for all boot flows
	- Manorit:
		- added Reviewed-by tag for mcu_timer0 ID patch (2/7)
		- removed all aliases
		- removed unnecessary properties

Changes in v2:
	- Nishanth:
		- synced k3-j721e-som-0.dtsi 6.5-rc1
		- delete tick-timer from -u-boot.dtsi
		- remove unnecessary aliases
		- remove SERDES overrides in U-Boot
		- formatting changes
		- drop repeated nodes and properties in U-Boot dts
		- drop nodes and properties not related to U-Boot from
		  U-Boot dts
		- drop all /delete

Neha Malcom Francis (6):
  arm: mach-k3: j721e: dev-data: Add mcu_timer0 ID
  arm: mach-k3: j721e_init: Move clk_k3 probe before loading TIFS
  drivers: firmware: ti_sci: Get SCI revision only if TIFS/SYSFW is up
  configs: j721e: Remove HBMC_AM654 config
  arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
  arm: dts: k3-j721e: Sync with v6.6-rc1

 .../k3-j721e-common-proc-board-u-boot.dtsi    |  153 +--
 arch/arm/dts/k3-j721e-common-proc-board.dts   |  513 ++++++---
 arch/arm/dts/k3-j721e-main.dtsi               | 1018 +++++++++++++++--
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  305 ++++-
 .../k3-j721e-r5-common-proc-board-u-boot.dtsi |   29 -
 .../arm/dts/k3-j721e-r5-common-proc-board.dts |  363 +-----
 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       |   31 -
 arch/arm/dts/k3-j721e-r5-sk.dts               |  572 +--------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  184 +--
 arch/arm/dts/k3-j721e-sk.dts                  |  673 +++++++----
 arch/arm/dts/k3-j721e-som-p0.dtsi             |  217 ++--
 arch/arm/dts/k3-j721e-thermal.dtsi            |   75 ++
 arch/arm/dts/k3-j721e.dtsi                    |   32 +-
 arch/arm/mach-k3/j721e/dev-data.c             |    1 +
 arch/arm/mach-k3/j721e_init.c                 |   24 +-
 configs/j721e_evm_a72_defconfig               |    1 -
 configs/j721e_evm_r5_defconfig                |    1 -
 drivers/firmware/ti_sci.c                     |   11 +-
 18 files changed, 2415 insertions(+), 1788 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi

-- 
2.34.1

