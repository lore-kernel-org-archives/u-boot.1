Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D5CEEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB6386A80;
	Fri,  8 Sep 2023 19:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mT5hE8Fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0169E86A35; Fri,  8 Sep 2023 19:29:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40FC86A81
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388HTjZD094508;
 Fri, 8 Sep 2023 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694194185;
 bh=S5Xv+qRhEaMEu4bwkLYJLegNUmshwyF8hXU99jcmW/w=;
 h=From:To:CC:Subject:Date;
 b=mT5hE8Fi3BJBgqSD9uNyKOcuJd0mYQ8XvpZy7TiXmreiwUzaQfNisx+cmt+mCrRu3
 r3cS+qOeM1ks8ahT7O4xmuKxYuP0/yh7mgdnu2UKQdf11jIrWKPEGU6cDlRkXWS/fZ
 FzFeJ88h3x5Ajmy+cNnElnGv9tODhSC62FrFn01U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388HTjFm035752
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:29:45 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:29:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:29:45 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388HTfxI052571;
 Fri, 8 Sep 2023 12:29:42 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH v2 0/3] thermal: Integrate VTM and AVS driver
Date: Fri, 8 Sep 2023 22:59:12 +0530
Message-ID: <20230908172914.436194-1-u-kumar1@ti.com>
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

VTM (Voltage and Thermal Manager) IP is used for following purpose
1) AVS class 0
2) Thermal management (setting thermal shutdown TSHUT) temperature.
3) SoC temperature reporting.

In origin boot flow, R5/SPL sets the AVS voltage using
by AVS driver, residing under UCLASS_MISC.

In this series At top level, following changes are done
- Moved avs driver to Thermal class
- Ported kernel driver (drivers/thermal/k3_j72xx_bandgap.c) which
supports TSHUT and temperature reporting
- Merged these two driver as one under UCLASS_THERMAL.

This series aims to
- set avs and thermal shutdown at R5/SPL stage
- At main u-boot stage, support thermal shutdown and temperature reporting


Also, j72xx_bandgap does complex math to get ADC value to temperature
conversion, This table is pretty static.
So at R5 SPL stage, instead of calculation, fixed values is used
for TSHUT values.
and #ifdef is used skip non needed code for SPL/R5 to reduce code size.

Change log
Changes in v2:
v1 : https://lore.kernel.org/all/20230901061500.2342452-1-u-kumar1@ti.com/
- Trying to merge AVS and kernel driver into 1
- Mark as RFC


Udit Kumar (3):
  thermal: k3: Add support for thermal in vtm
  arm: mach-k3: update board file to use thermal device
  arm: dts: k3: update device tree for vtm node

 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |   9 +
 .../arm/dts/k3-j7200-r5-common-proc-board.dts |   6 -
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  10 +
 .../arm/dts/k3-j721e-r5-common-proc-board.dts |   7 -
 arch/arm/dts/k3-j721e-r5-sk.dts               |   7 -
 arch/arm/mach-k3/am654_init.c                 |   2 +-
 arch/arm/mach-k3/j721e_init.c                 |   2 +-
 configs/am65x_evm_r5_defconfig                |   3 +
 configs/am65x_evm_r5_usbdfu_defconfig         |   3 +
 configs/am65x_evm_r5_usbmsc_defconfig         |   3 +
 configs/am65x_hs_evm_r5_defconfig             |   3 +
 configs/j7200_evm_a72_defconfig               |   3 +
 configs/j7200_evm_r5_defconfig                |   3 +
 configs/j721e_evm_a72_defconfig               |   3 +
 configs/j721e_evm_r5_defconfig                |   3 +
 drivers/misc/Makefile                         |   1 -
 drivers/misc/k3_avs.c                         | 394 --------
 drivers/thermal/Kconfig                       |   7 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/k3_thermal.c                  | 928 ++++++++++++++++++
 20 files changed, 981 insertions(+), 417 deletions(-)
 delete mode 100644 drivers/misc/k3_avs.c
 create mode 100644 drivers/thermal/k3_thermal.c

-- 
2.34.1

