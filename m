Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE33C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 05:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E1F8803B;
	Wed, 27 Mar 2024 06:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OfzQ7RiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9318F88099; Wed, 27 Mar 2024 06:28:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54E087E3D
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 06:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R5SjkG078192;
 Wed, 27 Mar 2024 00:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711517325;
 bh=rRpvDaT4HbKl1dKuRcws0p5RZGzcvK8OXTpEMSgZzB0=;
 h=From:To:CC:Subject:Date;
 b=OfzQ7RiJSWz/9O1gTOf8mVt1RZaku6Rp7BvI2YtCd06+v0WMc/09i0ce0lebCCAs2
 aJvVIYLTuvR2/8AYhK4UFpTKJIsIES855VHw7xmIeaL594kXQvB0w6U2jLdelXKZJQ
 CAgbvsE0w8QXVHqp5LiP6nbRLRKIyu6S90iNDqW0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R5Sjda021689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Mar 2024 00:28:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 00:28:45 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 00:28:45 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R5Sjc1087317;
 Wed, 27 Mar 2024 00:28:45 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 42R5Si2x017285;
 Wed, 27 Mar 2024 00:28:44 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, MD
 Danish Anwar <danishanwar@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v4 0/5] Introduce ICSSG Ethernet driver
Date: Wed, 27 Mar 2024 10:58:36 +0530
Message-ID: <20240327052841.1692469-1-danishanwar@ti.com>
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

This is v4 of the series [1].

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
*) Dropped patch [4] as the patch is no longer needed.
*) Added patch 2/15 to modify fs-loader driver to use fw_storage_interface
   env instead of storage_interface and keep the env storage_interface as
   fallback as suggested by Roger.
*) Added patch 15/15 to set default values to env fw_storage_interface and
   fw_dev_part.

[1] https://lore.kernel.org/all/20231219103418.3445886-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240111070611.342701-1-danishanwar@ti.com/
[3] https://lore.kernel.org/all/20240124064930.1787929-1-danishanwar@ti.com/
[4] https://lore.kernel.org/all/20231219103418.3445886-16-danishanwar@ti.com/

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


base-commit: 8ef8dcc54a0d507912ee57e15a541c5cebcfca76
-- 
2.34.1

