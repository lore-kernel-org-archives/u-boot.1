Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CC6C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4088781B;
	Tue, 19 Dec 2023 12:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vh3R55uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983B686D82; Tue, 19 Dec 2023 11:34:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C38C86C68
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYMi4055887;
 Tue, 19 Dec 2023 04:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702982062;
 bh=7KKtKRn5e7FRq4rxn1y6L4+ewf4ySPZMAAzW77jJ2z8=;
 h=From:To:CC:Subject:Date;
 b=vh3R55uQ9hRPNGlWn4RdqnSr1QTrEIibvHZ7LPlQS4YDUKz+Ao1WAEJh7rksA4XuX
 R0rsjE+OT1hZR8J+NfHfOZ1te9IBPjYo3ICjvbfJwG8HeRWpU8NhxHFQmzCYSPwFOv
 k43iXexMnrm5JdDXON55R8XnZtYCZ3Ypz9nQCeOw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJAYLoL057366
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:34:22 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:34:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:34:21 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAYLcM011278;
 Tue, 19 Dec 2023 04:34:21 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJAYK2V022757;
 Tue, 19 Dec 2023 04:34:21 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Date: Tue, 19 Dec 2023 16:04:02 +0530
Message-ID: <20231219103418.3445886-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
AM654 SR2.0.

The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
support for ICSSG driver in uboot. This series also adds the driver's
dependencies.

The ICSSG2 node is added in device tree overlay so that it remains in
sync with linux kernel.

The series introduces device tree and config changes and AM65x
to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
for AM65x in order to load overlay over spl.

This series has been tested on AM65x SR2.0, and the ICSSG interface is
able to ping / dhcp and boot kernel using tftp in uboot.

To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to PRU RPROC
cores and RPROC cores need to be booted with the firmware. This step is
done inside driver in kernel as kernel supports APIs like
rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't have these
APIs, the same needs to be done via u-boot cmds.

To make sure icssg-eth works we need to
do below steps.

1. Initialize rproc cores i.e. rproc_init()
2. Load $firmware_file from partition '1:2' (root) on device (mmc in this
   example)
3. Load the firmware file to rproc cores passing. i.e. rproc_load()
   taking rproc_id, loadaddr and file size as arguments.
4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments

The above steps are done by running the below commands at u-boot prompt.

=> setenv start_icssg2 'rproc start 14; rproc start 15; rproc start 16; rproc start 17; rproc start 18; rproc start 19'
=> setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop 16; rproc stop 17; rproc stop 18; rproc stop 19'
=> setenv firmware_dir '/lib/firmware/ti-pruss'
=> setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr} ${firmware_dir}/${firmware_file}'

=> setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload no; rproc init; setenv loadaddr 0x80000000; \
    setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
    setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15 0x89000000 ${filesize}; \
    setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load 16 0x90000000 ${filesize}; \
    setenv loadaddr 0x80000000; setenv firmware_file am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17 0x80000000 ${filesize}; \
    setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18 0x89000000 ${filesize}; \
    setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load 19 0x90000000 ${filesize}; \
    run start_icssg2;'

=> run init_icssg2
=> dhcp
k3-navss-ringacc ringacc@3c000000: Ring Accelerator probed rings:818, gp-rings[304,100] sci-dev-id:187
k3-navss-ringacc ringacc@3c000000: dma-ring-reset-quirk: disabled
prueth icssg2-eth: K3 ICSSG: rflow_id_base: 8, chn_name = rx0
link up on port 0, speed 1000, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 192.168.4.58 (1020 ms)

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (16):
  dma: ti: k3-udma: Use ring_idx to pair k3 nav rings
  net: ti: icssg: Add Firmware Interface for ICSSG Ethernet driver.
  net: ti: icssg: Add Firmware config and classification APIs.
  net: ti: icssg: Add icssg queues APIs and macros
  net: ti: icssg: Add ICSSG ethernet driver
  net: ti: icssg: Add support sending FDB command to update rx_flow_id
  net: ti: icssg: Enforce pinctrl state on the MDIO child node
  arm: dts: k3-am65: Add additional regs for DMA components
  arm: dts: k3-am65: Add cfg reg region to ringacc node
  arm: dts: k3-am65-main: Add ICSSG IEP nodes
  arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet support
  arm: dts: k3-am65x-binman: Add ICSSG2 overlay and configuration
  configs: am65x_evm_a53: Enable ICSSG Driver
  configs: am65x_evm_a53_defconfig: add SPL_LOAD_FIT_APPLY_OVERLAY
  tools/fdtgrep: Include __symbols__ table
  board: ti: am65x: Add check for k3-am654-icssg2 in
    board_fit_config_match()

 arch/arm/dts/Makefile             |   3 +-
 arch/arm/dts/k3-am65-main.dtsi    |  49 ++-
 arch/arm/dts/k3-am65-mcu.dtsi     |  13 +-
 arch/arm/dts/k3-am654-icssg2.dtso | 145 +++++++
 arch/arm/dts/k3-am65x-binman.dtsi |  85 ++++
 board/ti/am65x/evm.c              |  11 +-
 configs/am65x_evm_a53_defconfig   |   4 +
 drivers/dma/ti/k3-udma.c          |  11 +-
 drivers/net/ti/Kconfig            |   9 +
 drivers/net/ti/Makefile           |   1 +
 drivers/net/ti/icss_mii_rt.h      | 192 +++++++++
 drivers/net/ti/icssg_classifier.c | 376 +++++++++++++++++
 drivers/net/ti/icssg_config.c     | 469 +++++++++++++++++++++
 drivers/net/ti/icssg_config.h     | 195 +++++++++
 drivers/net/ti/icssg_prueth.c     | 654 ++++++++++++++++++++++++++++++
 drivers/net/ti/icssg_prueth.h     |  89 ++++
 drivers/net/ti/icssg_queues.c     |  51 +++
 drivers/net/ti/icssg_switch_map.h | 209 ++++++++++
 tools/fdtgrep.c                   |   8 +
 19 files changed, 2559 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso
 create mode 100644 drivers/net/ti/icss_mii_rt.h
 create mode 100644 drivers/net/ti/icssg_classifier.c
 create mode 100644 drivers/net/ti/icssg_config.c
 create mode 100644 drivers/net/ti/icssg_config.h
 create mode 100644 drivers/net/ti/icssg_prueth.c
 create mode 100644 drivers/net/ti/icssg_prueth.h
 create mode 100644 drivers/net/ti/icssg_queues.c
 create mode 100644 drivers/net/ti/icssg_switch_map.h

base:commit: a6f86132e30a407c7f96461df53c62fbe52e2b54
-- 
2.34.1

