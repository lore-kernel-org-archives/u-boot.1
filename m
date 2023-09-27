Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D50E7F14F
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBFD86D62;
	Wed, 27 Sep 2023 15:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jy7AFhBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF06486D93; Wed, 27 Sep 2023 15:10:07 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F16D86D5A
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RDA2hZ075130;
 Wed, 27 Sep 2023 08:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695820202;
 bh=Nc1kejBn69fMr7BtWkEVIyYPokEf+K4ZlQ3rPkp79Ss=;
 h=From:To:CC:Subject:Date;
 b=jy7AFhBHoBH6djTuzdb4O50CfmeNmlV0mpHk6vxR5pBEPLlk/GhriRuWA960333Av
 TQ1/qgXt3S92Iq38dFMR9wAJm93a1KrdUlaHSLauSyyrUyDxioK4DDu/cEx26viU80
 hK9vLqHMFFQS+JIsLv3FrtEusf4P5rGqrN2Y57C8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RDA2PU003259
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 08:10:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 08:10:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 08:10:02 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RD9uKa025731;
 Wed, 27 Sep 2023 08:09:57 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 0/6] J721E DTS Sync with Kernel v6.6-rc1
Date: Wed, 27 Sep 2023 18:39:50 +0530
Message-ID: <20230927130956.910988-1-n-francis@ti.com>
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
https://gist.github.com/nehamalcom/ca67dd714027a76cc711f41c25d33dfe

Changes in v4:
	- return PTR_ERR instead of int in ti_sci_get_handle_sysfw for
	  error handling
	- Nishanth:
		- Modify commit message to include summary of changes
		- Move wkup_uart0_pins_default and
		  mcu_uart0_pins_default to R5 DTS
		- Remove hbmc node completely
		- Remove ti,cluster-mode override
		- Remove clock-frequency properties that are already
		  accounted for by clk-data
		- Document reason for retaining tps node in commit
		  message
		- Move mcu_ringacc and mcu_udmap before peripherals
		- add bootlogs for patch (3/7) for different boot flows

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

 .../k3-j721e-common-proc-board-u-boot.dtsi    |  159 +--
 arch/arm/dts/k3-j721e-common-proc-board.dts   |  513 ++++++---
 arch/arm/dts/k3-j721e-main.dtsi               | 1018 +++++++++++++++--
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  305 ++++-
 .../k3-j721e-r5-common-proc-board-u-boot.dtsi |   29 -
 .../arm/dts/k3-j721e-r5-common-proc-board.dts |  384 +------
 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       |   31 -
 arch/arm/dts/k3-j721e-r5-sk.dts               |  587 +---------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  180 +--
 arch/arm/dts/k3-j721e-sk.dts                  |  673 +++++++----
 arch/arm/dts/k3-j721e-som-p0.dtsi             |  217 ++--
 arch/arm/dts/k3-j721e-thermal.dtsi            |   75 ++
 arch/arm/dts/k3-j721e.dtsi                    |   32 +-
 arch/arm/mach-k3/j721e/dev-data.c             |    1 +
 arch/arm/mach-k3/j721e_init.c                 |   24 +-
 configs/j721e_evm_a72_defconfig               |    1 -
 configs/j721e_evm_r5_defconfig                |    1 -
 drivers/firmware/ti_sci.c                     |   11 +-
 18 files changed, 2407 insertions(+), 1834 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi

-- 
2.34.1

