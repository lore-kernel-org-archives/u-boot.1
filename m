Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF51FC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44068796A;
	Fri, 12 Jan 2024 07:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X6iDz0HQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8ADE871C3; Fri, 12 Jan 2024 07:48:09 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35794871C3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C6m4cr057231;
 Fri, 12 Jan 2024 00:48:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705042084;
 bh=lUZ/nmk+eBnccUOjUHudS0nR0GBBN6BNtCCSP42F1RU=;
 h=From:To:CC:Subject:Date;
 b=X6iDz0HQqx5cocUmbOiPB6D8uHdPxMstmhOo1LHMMBSFubALpCbuTw3YcZIddHHWg
 F2hUNQsk/2K4kUTh7/pqIhHe2x4NUpH0rkl0aOCV1329/MuYfdd7EnSNtr/IfLl8xQ
 ZkX5nYlX90RPLphOSfYSm94mLRIm17dIiUbSjdXs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C6m4TU073492
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 00:48:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 00:48:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 00:48:04 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C6lxs7063681; 
 Fri, 12 Jan 2024 00:48:00 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 00/10] Add support for Ethernet Boot on SK-AM62
Date: Fri, 12 Jan 2024 12:17:49 +0530
Message-ID: <20240112064759.1801600-1-s-vadapalli@ti.com>
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

Hello,

This series enables Ethernet Boot on SK-AM62 device.
Product Link: https://www.ti.com/tool/SK-AM62
User Guide: https://www.ti.com/lit/pdf/spruj40

Ethernet Boot flow is as follows:
1. The BOOT MODE pins are configured for Ethernet Boot.
2. On powering on the device, ROM uses the Ethernet Port corresponding
to CPSW3G's MAC Port 1 to transmit "TI K3 Bootp Boot".
3. The TFTP server and DHCP server on the receiver device need to be
configured such that VCI string "TI K3 Bootp Boot" maps to the file
"tiboot3.bin" and the TFTP server should be capable of transferring
it to the device.
4. ROM loads and executes "tiboot3.bin" provided by the TFTP server.
5. The "tiboot3.bin" file is expected to be built using the config:
am62x_evm_r5_ethboot_defconfig
introduced in this series, which shall enable "tispl.bin" to be fetched
over TFTP using "tiboot3.bin".
6. "tiboot3.bin" is configured to transmit "AM62X U-Boot R5 SPL" as its
NET_VCI_STRING, thereby implying that the DHCP server and TFTP server
need to be configured to transfer "tispl.bin" to the device.
7. "tiboot3.bin" loads and executes "tispl.bin" provided by the TFTP
server.
8. The "tispl.bin" file is expected to be built using the config:
am62x_evm_a53_defconfig
which has been updated in this series to enable Ethernet Boot specific
configs, allowing "u-boot.img" to be fetched over TFTP using
"tispl.bin".
9. "tispl.bin" is configured to transmit "AM62X U-Boot A53 SPL" as its
NET_VCI_STRING. The DHCP server and TFTP server need to be configured to
transfer "u-boot.img" to the device for the aforementioned NET_VCI_STRING.
10. "tispl.bin" then fetches "u-boot.img" using TFTP and loads and
executes it on the device, completing the process of Ethernet Boot on the
device.

NOTE: ROM configures CPSW3G's MAC Port 1 for 100 Mbps full-duplex mode
of operation due to which it is expected that the Link Partner also
supports the same mode of operation.
Additionally, enabling "phy_gmii_sel" node at SPL stage will be
necessary and is not added as a part of this series with the aim of
adding the "bootph-all" property to its counterpart in Linux device-tree
first.

This series is based on commit:
f28a77589e Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
of the next branch of u-boot.

Regards,
Siddharth.

Andreas Dannenberg (1):
  arm: mach-k3: am62: Update SoC autogenerated data to enable Ethernet
    Boot

Kishon Vijay Abraham I (7):
  board: ti: am62x: Init DRAM size in R5/A53 SPL
  firmware: ti_sci: Add No-OP for "RX_FL_CFG"
  soc: ti: k3-navss-ringacc: Initialize base address of ring cfg
    registers
  dma: ti: k3-udma: Add support for native configuration of chan/flow
  arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
  configs: am62: Add configs for enabling ETHBOOT in R5SPL
  configs: am62x_evm_a53_defconfig: Enable configs required for Ethboot

Siddharth Vadapalli (1):
  arm: dts: k3-am625-r5-sk: Enable DM services for main_pktdma

Vignesh Raghavendra (1):
  soc: ti: k3-navss-ringacc: Fix reset ring API

 arch/arm/dts/k3-am625-r5-sk.dts          |   5 ++
 arch/arm/mach-k3/am625_init.c            |  10 +++
 arch/arm/mach-k3/r5/am62x/clk-data.c     |  79 ++++++++--------
 board/ti/am62x/evm.c                     |   3 +
 configs/am62x_evm_a53_defconfig          |   8 ++
 configs/am62x_evm_r5_ethboot_defconfig   | 110 +++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c                 |   6 ++
 drivers/firmware/ti_sci.c                |   8 +-
 drivers/soc/ti/k3-navss-ringacc-u-boot.c |   9 +-
 drivers/soc/ti/k3-navss-ringacc.c        |   7 +-
 10 files changed, 202 insertions(+), 43 deletions(-)
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

-- 
2.34.1

