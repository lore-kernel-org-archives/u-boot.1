Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D64E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F0680570;
	Mon,  6 Jan 2025 10:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A6oLr2La";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D01805D5; Mon,  6 Jan 2025 10:07:29 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FCC8007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50697Nni2768661
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:07:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736154443;
 bh=w/2hB0Koy+yQbJtTaT+vCVEz5ExUxliLMQFfJHQTIUI=;
 h=From:To:CC:Subject:Date;
 b=A6oLr2La5QpwnC6e5GLBElN/EOK+8DeZ3HxbvZlKyMzJYZBlJ+aJiZ5IPiwXagWTY
 QbxmppeY4aK+PK867meOTV7QF0/mSzTaDmKc6LCV2HvtEymEh/zegLhMG5GipUZBbF
 WVH79S5oXomHs5n7C5Bp48/S4n/38JkXipIVg9/Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50697Nas029600
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:07:23 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:07:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:07:23 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50697JuV103050;
 Mon, 6 Jan 2025 03:07:20 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v6 0/9] Inline ECC Series
Date: Mon, 6 Jan 2025 14:36:59 +0530
Message-ID: <20250106090708.1541212-1-s-k6@ti.com>
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

This series adds support for Inline ECC in DDR for AM64X, AM62X,
AM62AX, AM62PX, J721E, J721S2, J722S and J784S4 devices.

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

Test Results: https://gist.github.com/santhosh21/88de920771ed2efa0463a5a367cb8d7b

Changes since v5:

Add support for J722S EVM

v5: https://lore.kernel.org/u-boot/20241213103129.332246-1-s-k6@ti.com/

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

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>

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
 board/ti/j722s/evm.c                   |  17 +-
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
 36 files changed, 427 insertions(+), 295 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
 create mode 100644 arch/arm/mach-k3/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.h

-- 
2.34.1

