Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8321E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CBF80141;
	Fri, 13 Dec 2024 11:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x/k4YE6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E98801FE; Fri, 13 Dec 2024 11:32:06 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2888010E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAVtmI2918116
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 04:31:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085915;
 bh=/Qaf1+9S7l2ujXdhfkioodToD7KKZP46TKI76/5GGKk=;
 h=From:To:CC:Subject:Date;
 b=x/k4YE6fM1nXpPj3L77rKg0T2fQ/0w+mqbzuDib+A3mHCUZF6vHCOs8KdvW7SSXPi
 JwQEMHa8oS6cz5S0iI5y2HwYDCEIVrd/URJ7OO6aKWh64hVGLFuiG2VebWwa5/qcqC
 lL/WW+6HXKtEtuTNdMmpxtKWiQI3ft9xzUESjUsM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAVtdb006864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:31:55 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:31:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:31:55 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpq5067253;
 Fri, 13 Dec 2024 04:31:52 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 0/9] Inline ECC Series
Date: Fri, 13 Dec 2024 16:01:20 +0530
Message-ID: <20241213103129.332246-1-s-k6@ti.com>
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

Hello,

This series is to:

Add support for Inline ECC in DDR for AM64X, AM62X, AM62AX, AM62PX,
J721S2 and J784S4 devices.

(1/9) Add ss_cfg reg entry
(2/9) Enable ECC priming with BIST engine
(3/9) Add a function to store base address and size of RAM's banks
      in a 64-bit device private data
(4/9) Setup the ECC region start and range
(5/9) Enable ECC 1-bit error, 2-bit error and multiple-bit
      error interrupts
(6/9) Add CONFIG_K3_INLINE_ECC
(7/9) Remove 'ti,ecc-enable' flag
(8/9) Set default NR_DRAM_BANKS to 2
(9/9) Pull Redundant DDR functions to a common location and Fixup
      DDR size when ECC is enabled
      
Changes since v4:
1. Make dram_init and dram_init_banksize weak at mach-k3/ and define at
   board/ti/
2. Remove 'ti,ecc-enable' flag
3. Minor changes like patch order change (8/8 in v4 to 1/9 in v5),
   use 'u64'

v4: https://lore.kernel.org/u-boot/20241021044024.835846-1-s-k6@ti.com/

Changes since v3:
Pull redundant DDR functions to arch/arm/mach-k3/*

v3: https://lore.kernel.org/all/20240523050430.455201-1-s-k6@ti.com/

Changes since v2:
Removed 'default n' in Kconfig as that is default setting

v2: https://lore.kernel.org/u-boot/20240510084707.1903133-1-s-k6@ti.com/

Changes since v1:
Add support for J7* devices.

v1: https://lore.kernel.org/u-boot/20240131060213.1128024-1-s-k6@ti.com/

Test Results: https://gist.github.com/santhosh21/88de920771ed2efa0463a5a367cb8d7b

Thanks and Regards,
Santhosh.

Georgi Vlaev (1):
  ram: k3-ddrss: Use the DDR controller BIST engine for ECC priming

Neha Malcom Francis (2):
  drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
  arm: mach-k3: Set NR_DRAM_BANKS to 2

Santhosh Kumar K (6):
  arm: dts: k3-*-ddr: Add ss_cfg reg entry
  ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc() to solve
    'calculations restricted to 32 bits' issue
  ram: k3-ddrss: Setup ECC region start and range
  ram: k3-ddrss: Enable ECC interrupts
  ram: k3-ddrss: Remove 'ti,ecc-enable' support
  board: ti: Pull redundant DDR functions to a common location and Fixup
    DDR size when ECC is enabled

 arch/arm/dts/k3-am62a-ddr.dtsi         |   7 +-
 arch/arm/dts/k3-j721s2-ddr.dtsi        |  12 +-
 arch/arm/dts/k3-j784s4-ddr.dtsi        |  24 ++-
 arch/arm/mach-k3/Kconfig               |   3 +
 arch/arm/mach-k3/Makefile              |   2 +-
 arch/arm/mach-k3/include/mach/k3-ddr.h |  15 ++
 arch/arm/mach-k3/k3-ddr.c              |  72 ++++++++
 board/ti/am62ax/evm.c                  |  17 +-
 board/ti/am62px/evm.c                  |  17 +-
 board/ti/am62x/evm.c                   |  63 +------
 board/ti/am64x/evm.c                   |  73 +--------
 board/ti/am65x/evm.c                   |  29 +---
 board/ti/common/Makefile               |   1 +
 board/ti/common/k3-ddr.c               |  33 ++++
 board/ti/common/k3-ddr.h               |  12 ++
 board/ti/j721e/evm.c                   |  29 +---
 board/ti/j721s2/evm.c                  |  35 ++--
 board/ti/j784s4/evm.c                  |  17 +-
 configs/am62ax_evm_a53_defconfig       |   1 -
 configs/am62px_evm_a53_defconfig       |   1 -
 configs/am62x_evm_a53_defconfig        |   1 -
 configs/am62x_evm_r5_defconfig         |   1 -
 configs/am64x_evm_a53_defconfig        |   1 -
 configs/am64x_evm_r5_defconfig         |   1 -
 configs/am65x_evm_a53_defconfig        |   1 -
 configs/am65x_evm_r5_defconfig         |   1 -
 configs/am65x_evm_r5_usbdfu_defconfig  |   1 -
 configs/am65x_evm_r5_usbmsc_defconfig  |   1 -
 configs/j7200_evm_a72_defconfig        |   1 -
 configs/j721e_evm_a72_defconfig        |   1 -
 configs/j721s2_evm_a72_defconfig       |   1 -
 configs/j722s_evm_a53_defconfig        |   1 -
 configs/j784s4_evm_a72_defconfig       |   1 -
 drivers/ram/Kconfig                    |  10 ++
 drivers/ram/k3-ddrss/k3-ddrss.c        | 219 +++++++++++++++++++++----
 35 files changed, 417 insertions(+), 288 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
 create mode 100644 arch/arm/mach-k3/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.h

-- 
2.34.1

