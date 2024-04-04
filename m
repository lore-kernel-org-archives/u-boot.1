Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD0CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC8B882B5;
	Thu,  4 Apr 2024 09:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wtyjcB6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0604688235; Thu,  4 Apr 2024 09:08:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7EC88278
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434787Zj083268;
 Thu, 4 Apr 2024 02:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712214487;
 bh=QpMocZTJaQzqVQ9bDfwOVNOS7UMqTMo8pRrDcOZaj3I=;
 h=From:To:CC:Subject:Date;
 b=wtyjcB6x33KyYJXXq3vgrSQ/IMEsqoP3R23x+7KH7c0tpSztXoeSGnCwKSnDwnBqf
 PGlvmkPo+iwg5jNrLxnvXcylNb0eHbM4MmHeaRtg8f4Ml1/YxIJwtnbcUVMPPyPNLR
 LiKMhCfWWiWuLNnbxfYpILxidAXQOztZ9oBxH6tc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434787qV056967
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 02:08:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 02:08:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 02:08:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434786c0091028;
 Thu, 4 Apr 2024 02:08:06 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4347853p013450;
 Thu, 4 Apr 2024 02:08:06 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 MD Danish Anwar <danishanwar@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Simon Glass
 <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Andrew
 Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v5 0/5] Introduce ICSSG Ethernet driver
Date: Thu, 4 Apr 2024 12:37:58 +0530
Message-ID: <20240404070803.2455207-1-danishanwar@ti.com>
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

Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
AM654 SR2.0.

The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
support for ICSSG driver in uboot.

This series has been tested on AM65x SR2.0, and the ICSSG interface is
able to ping / dhcp and boot kernel using tftp in uboot.

To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to PRU RPROC
cores and RPROC cores need to be booted with the firmware. This step is
done inside driver similar to kernel.

The remoteproc driver uses request_fw_into_buf() API from fs-loader driver
to load and start rproc with the required firmwares.

This series only introduces driver files. The device tree and config
changes to enable ICSSG driver will be introduced later.

This is v5 of the series [1].

Changes from v4 [4] to v5:
*) Fixed URL(s/http/https) in all the patches as asked by
   Ravi Gunasekaran <r-gunasekaran@ti.com>
*) Collected RB tags of Ravi Gunasekaran <r-gunasekaran@ti.com> for patch
   1/5, 3/5 and 5/5.
*) Used PKTSIZE macro instead of hardcoding 1522 in the definition of
   UDMA_RX_BUF_SIZE in patch 4/5

Changes from v3 [3] to v4:
*) Dropped the dependncy patches and posted them seprately.
*) Dropped the DTS and config patches, will post them seprately.
*) Modified patch 4/5 to have multi port independent MAC mode support.
*) Rebased the series on latest u-boot/next.

Changes from v2 [2] to v3:
*) No functional changes.
*) Rebased the series on latest u-boot/next.
*) Dropped the RFC tag.

Changes from v1 [1] to v2:
*) Modified the driver to load the firmware inside the driver only instead
   of loading the firmware using commands at u-boot prompt. Added patch
   3/16 for this.
*) Rebased the series on the latest u-boot/next.
*) Modified conf-0 configuration in k3-am65x-binman.dtsi as suggested by
   Roger.
*) Dropped patch [5] as the patch is no longer needed.
*) Added patch 2/15 to modify fs-loader driver to use fw_storage_interface
   env instead of storage_interface and keep the env storage_interface as
   fallback as suggested by Roger.
*) Added patch 15/15 to set default values to env fw_storage_interface and
   fw_dev_part.

[1] https://lore.kernel.org/all/20231219103418.3445886-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240111070611.342701-1-danishanwar@ti.com/
[3] https://lore.kernel.org/all/20240124064930.1787929-1-danishanwar@ti.com/
[4] https://lore.kernel.org/all/20240327052841.1692469-1-danishanwar@ti.com/
[5] https://lore.kernel.org/all/20231219103418.3445886-16-danishanwar@ti.com/

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (5):
  net: ti: icssg: Add Firmware Interface for ICSSG Ethernet driver.
  net: ti: icssg: Add Firmware config and classification APIs.
  net: ti: icssg: Add icssg queues APIs and macros
  net: ti: icssg: Add ICSSG ethernet driver
  net: ti: icssg: Add support sending FDB command to update rx_flow_id

 arch/arm/mach-k3/common.c         |  11 +
 drivers/net/ti/Kconfig            |  13 +
 drivers/net/ti/Makefile           |   1 +
 drivers/net/ti/icss_mii_rt.h      | 192 +++++++++
 drivers/net/ti/icssg_classifier.c | 376 ++++++++++++++++
 drivers/net/ti/icssg_config.c     | 474 ++++++++++++++++++++
 drivers/net/ti/icssg_config.h     | 195 +++++++++
 drivers/net/ti/icssg_prueth.c     | 691 ++++++++++++++++++++++++++++++
 drivers/net/ti/icssg_prueth.h     |  97 +++++
 drivers/net/ti/icssg_queues.c     |  51 +++
 drivers/net/ti/icssg_switch_map.h | 209 +++++++++
 11 files changed, 2310 insertions(+)
 create mode 100644 drivers/net/ti/icss_mii_rt.h
 create mode 100644 drivers/net/ti/icssg_classifier.c
 create mode 100644 drivers/net/ti/icssg_config.c
 create mode 100644 drivers/net/ti/icssg_config.h
 create mode 100644 drivers/net/ti/icssg_prueth.c
 create mode 100644 drivers/net/ti/icssg_prueth.h
 create mode 100644 drivers/net/ti/icssg_queues.c
 create mode 100644 drivers/net/ti/icssg_switch_map.h


base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8
-- 
2.34.1

