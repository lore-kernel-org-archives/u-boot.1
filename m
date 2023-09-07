Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B163EC8731
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6244786494;
	Thu,  7 Sep 2023 16:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uyDVLj9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10B1869A0; Thu,  7 Sep 2023 16:14:19 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD7D863F9
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EECRF048323;
 Thu, 7 Sep 2023 09:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694096052;
 bh=WVZa7sRHFBqWqEOieop7QV+NWTh5i9x7ayvOdpQMZwc=;
 h=From:To:CC:Subject:Date;
 b=uyDVLj9eavKAXVAx802NqLEBPdVM9iTVesj64xOaVg26JVvlgm5svxgyfdlIZyW/r
 dorOOVsss7juPitN7OsVk7XRhHCYsOBv6xjuS10FxXw1no9v909MT2/qUt0K1qswm2
 9/ZZZlD1u1yavX6FZT6In1xYMnIIDBYuL2maWMSk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EECMV027160
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 09:14:12 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:14:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:14:12 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EE70e046139;
 Thu, 7 Sep 2023 09:14:08 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 0/7] J721E DTS Sync with Kernel v6.5-rc1
Date: Thu, 7 Sep 2023 19:44:00 +0530
Message-ID: <20230907141407.382215-1-n-francis@ti.com>
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

This series aims to sync kernel.org v6.5-rc1 DTS with that of U-Boot. It
also includes cleanups where necessary along with certain changes to
ensure boot is unaffected.

Same as with other board series that have taken up this effort, cleanup
of mcu_ringacc and mcu_udmap are dependent on MCU Ringacc [1] and DMA
[2] fixes. This will be taken up after their merge to Linux.

[1] https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
[2] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/

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
		- drop all /delete-property/ from U-Boot dts by adding
		  needed dev-data and ensuring it works for J721E that
		  follows legacy boot flow
			- add dev-data for mcu_timer0 (new patch)
			- push clk_k3 probe to happen before TIFS comes
			  up (new patch)
			- get TISCI revision only if TIFS/SYSFW is up
			  (new patch)

Neha Malcom Francis (7):
  drivers: misc: k3_avs: Add linux compatible to maintain sync
  arm: mach-k3: j721e: dev-data: Add mcu_timer0 ID
  arm: mach-k3: j721e_init: Move clk_k3 probe before loading TIFS
  drivers: firmware: ti_sci: Get SCI revision only if TIFS/SYSFW is up
  configs: j721e: Remove HBMC_AM654 config
  arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
  arm: dts: k3-j721e: Sync with v6.5-rc1

 .../k3-j721e-common-proc-board-u-boot.dtsi    | 146 +--
 arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
 arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
 .../k3-j721e-r5-common-proc-board-u-boot.dtsi |  29 -
 .../arm/dts/k3-j721e-r5-common-proc-board.dts | 340 +-----
 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       |  31 -
 arch/arm/dts/k3-j721e-r5-sk.dts               | 565 +---------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 177 +---
 arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
 arch/arm/dts/k3-j721e-som-p0.dtsi             | 226 ++--
 arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
 arch/arm/dts/k3-j721e.dtsi                    |  32 +-
 arch/arm/mach-k3/j721e/dev-data.c             |   1 +
 arch/arm/mach-k3/j721e_init.c                 |  24 +-
 configs/j721e_evm_a72_defconfig               |   1 -
 configs/j721e_evm_r5_defconfig                |   1 -
 drivers/firmware/ti_sci.c                     |   9 +-
 drivers/misc/k3_avs.c                         |   1 +
 19 files changed, 2401 insertions(+), 1657 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi

-- 
2.34.1

