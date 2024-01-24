Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41FCC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7F087C61;
	Wed, 24 Jan 2024 13:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ofgfFWv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81D087887; Wed, 24 Jan 2024 07:49:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E47787BD4
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6naSk022607;
 Wed, 24 Jan 2024 00:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078976;
 bh=TSpCI+lqc9DjqrZlUw4U1xcs4kcWN/5fU40SOe/fL9A=;
 h=From:To:CC:Subject:Date;
 b=ofgfFWv8sKLYyhCdcBvRznceqzR2oTaXIHh9qMGCHRCyuA6D1etdOTGax9A2ScoYh
 3qi96px0a4HO56OMzMFIk3g9Cmf/AXlanE5IrD9J2h2NzzXOwBUWz0xkmKjEivyx8g
 ygUynTICF1hCV6EYaQrk82wjCEbupJqSGm0oSmW0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6na3U054823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:36 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:35 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nZhA071098;
 Wed, 24 Jan 2024 00:49:35 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6nYni024457;
 Wed, 24 Jan 2024 00:49:35 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 00/15] Introduce ICSSG Ethernet driver
Date: Wed, 24 Jan 2024 12:19:15 +0530
Message-ID: <20240124064930.1787929-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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
done inside driver similar to kernel.

The remoteproc driver uses request_fw_into_buf() API from fs-loader driver
to load and start rproc with the required firmwares.

The users need to set env variables fw_storage_interface, fw_dev_part,
fw_ubi_mtdpart, fw_ubi_volume to indicate which storage medium and
partition they want to use to load firmware files from. By default the env
fw_storage_interface=mmc and fw_dev_part=1:2 but users can modify these
envs as per their requirements.

Log while running dhcp at u-boot:

k3-navss-ringacc ringacc@3c000000: Ring Accelerator probed rings:818, gp-rings[304,100] sci-dev-id:187
k3-navss-ringacc ringacc@3c000000: dma-ring-reset-quirk: disabled
prueth icssg2-eth: K3 ICSSG: rflow_id_base: 8, chn_name = rx0
link up on port 0, speed 1000, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 192.168.4.97 (1037 ms)

This is v3 of the series [1].

Changes from v2 [2] to v3:
*) No functional changes.
*) Rebased the series on latest u-boot/next.
*) Dropped the RFC tag.

Changes from v1 to v2:
*) Modified the driver to load the firmware inside the driver only instead
   of loading the firmware using commands at u-boot prompt. Added patch
   3/16 for this.
*) Rebased the series on the latest u-boot/next.
*) Modified conf-0 configuration in k3-am65x-binman.dtsi as suggested by
   Roger.
*) Dropped patch [3] as the patch is no longer needed.
*) Added patch 2/15 to modify fs-loader driver to use fw_storage_interface
   env instead of storage_interface and keep the env storage_interface as
   fallback as suggested by Roger.
*) Added patch 15/15 to set default values to env fw_storage_interface and
   fw_dev_part.

[1] https://lore.kernel.org/all/20231219103418.3445886-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240111070611.342701-1-danishanwar@ti.com/
[3] https://lore.kernel.org/all/20231219103418.3445886-16-danishanwar@ti.com/

NOTE: All the device tree changes introduced in this patch are already
part of upstream linux kernel.

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (15):
  dma: ti: k3-udma: Use ring_idx to pair k3 nav rings
  misc: fs-loader: Use fw_storage_interface instead of storage_interface
  remoteproc: uclass: Add methods to load firmware to rproc and boot
    rproc
  net: ti: icssg: Add Firmware Interface for ICSSG Ethernet driver.
  net: ti: icssg: Add Firmware config and classification APIs.
  net: ti: icssg: Add icssg queues APIs and macros
  net: ti: icssg: Add ICSSG ethernet driver
  net: ti: icssg: Add support sending FDB command to update rx_flow_id
  net: ti: icssg: Enforce pinctrl state on the MDIO child node
  arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet support
  arm: dts: k3-am65x-binman: Add ICSSG2 overlay and configuration
  configs: am65x_evm_a53: Enable ICSSG Driver
  configs: am65x_evm_a53: add SPL_LOAD_FIT_APPLY_OVERLAY
  board: ti: am65x: Add check for k3-am654-icssg2 in
    board_fit_config_match()
  board: ti: am65x: Set fw_storage_interface and fw_dev_part ENVs

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/k3-am654-icssg2.dtso             | 145 ++++
 arch/arm/dts/k3-am65x-binman.dtsi             |  65 +-
 board/ti/am65x/am65x.env                      |   4 +
 board/ti/am65x/evm.c                          |  11 +-
 configs/am65x_evm_a53_defconfig               |   2 +
 .../driver-model/fs_firmware_loader.rst       |   5 +-
 drivers/dma/ti/k3-udma.c                      |  11 +-
 drivers/misc/fs_loader.c                      |   5 +-
 drivers/net/ti/Kconfig                        |   9 +
 drivers/net/ti/Makefile                       |   1 +
 drivers/net/ti/icss_mii_rt.h                  | 192 +++++
 drivers/net/ti/icssg_classifier.c             | 376 +++++++++
 drivers/net/ti/icssg_config.c                 | 463 +++++++++++
 drivers/net/ti/icssg_config.h                 | 195 +++++
 drivers/net/ti/icssg_prueth.c                 | 762 ++++++++++++++++++
 drivers/net/ti/icssg_prueth.h                 |  92 +++
 drivers/net/ti/icssg_queues.c                 |  51 ++
 drivers/net/ti/icssg_switch_map.h             | 209 +++++
 drivers/remoteproc/Kconfig                    |   1 +
 drivers/remoteproc/rproc-uclass.c             |  85 ++
 include/remoteproc.h                          |  35 +
 22 files changed, 2709 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso
 create mode 100644 drivers/net/ti/icss_mii_rt.h
 create mode 100644 drivers/net/ti/icssg_classifier.c
 create mode 100644 drivers/net/ti/icssg_config.c
 create mode 100644 drivers/net/ti/icssg_config.h
 create mode 100644 drivers/net/ti/icssg_prueth.c
 create mode 100644 drivers/net/ti/icssg_prueth.h
 create mode 100644 drivers/net/ti/icssg_queues.c
 create mode 100644 drivers/net/ti/icssg_switch_map.h

base-commit: f28a77589e7505535a4eebdc7269df98f67dbe68
-- 
2.34.1

