Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943FC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 08:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1289881A6;
	Fri, 10 May 2024 10:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d4dJWrLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D80881A6; Fri, 10 May 2024 10:48:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F068818B
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mE5W130790;
 Fri, 10 May 2024 03:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715330894;
 bh=4cfqKFR0SPDqTvt05MzJSaSybkyXtNVNiQQGbBP7Myc=;
 h=From:To:CC:Subject:Date;
 b=d4dJWrLdTi3BMYjYLyWct8Xwd5snqf7AZUg9yAVyNqjw5pE+iVK5/GOzjRmVXXZl8
 TkSt8afndiZ0dr+k9MsOxulgbYrEi0vIc8Hh9PJI+lTZCe3wExAzYYSwrs0tivkwwq
 RO6MXib/tICxjEnHWQholBvrfXFXCAmDFMXUZnhQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A8mEXr007058
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 03:48:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 03:48:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 03:48:13 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mA1Z107745;
 Fri, 10 May 2024 03:48:11 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 0/8] ECC Series
Date: Fri, 10 May 2024 14:16:59 +0530
Message-ID: <20240510084707.1903133-1-s-k6@ti.com>
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

This series is to:

Add support for Inline ECC in DDR for AM64X, AM62X, AM62AX, AM62PX,
J721S2 and J784S4 devices.

(1/8) Enable ECC priming with BIST engine
(2/8) Add a function to store base address and size of RAM's banks
      in a 64-bit device private data
(3/8) Setup the ECC region start and range
(4/8) Enable ECC 1-bit error, 2-bit error and multiple-bit
      error interrupts
(5/8) Add CONFIG_K3_INLINE_ECC
(6/8) Set NR_DRAM_BANKS to 2
(7/8) Pull Redundant DDR functions to a common location and Fixup
      DDR size when ECC is enabled
(8/8) Add ss_cfg reg entry

Changes since v1:
Add support for J7* devices.

v1: https://lore.kernel.org/u-boot/20240131060213.1128024-1-s-k6@ti.com/T/#m19d34d1ebc2802ad80e2412265e7858c98b0510f

Test Results:
https://gist.github.com/santhosh21/53c6f285640c4b6dfb3420d84975d12a

This series contains changes that grab the memory node from the DTS
to set/modify DRAM bank sizes. A kernel patch has been sent [1]
setting the required nodes to be available at bootloader stage. This
patch series can be merged only after the DTS changes have been
reflected in U-Boot either via OF_UPSTREAM (for devices that have
moved to it) or via a sync to U-Boot patch.

[1] https://lore.kernel.org/all/20240506110203.3230255-1-n-francis@ti.com/

Thanks and Regards,
Santhosh.

Georgi Vlaev (1):
  ram: k3-ddrss: Use the DDR controller BIST engine for ECC priming

Neha Malcom Francis (2):
  drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
  configs: j7*_evm_r5_defconfig: Set NR_DRAM_BANKS to 2

Santhosh Kumar K (5):
  ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc() to solve
    'calculations restricted to 32 bits' issue
  ram: k3-ddrss: Setup ECC region start and range
  ram: k3-ddrss: Enable ECC interrupts
  board: ti: Pull redundant DDR functions to a common location and Fixup
    DDR size when ECC is enabled
  arm: dts: k3-*-ddr: Add ss_cfg reg entry

 arch/arm/dts/k3-am62a-ddr.dtsi  |   7 +-
 arch/arm/dts/k3-j721s2-ddr.dtsi |  12 +-
 arch/arm/dts/k3-j784s4-ddr.dtsi |  24 ++--
 board/ti/am62ax/evm.c           |  17 +--
 board/ti/am62px/evm.c           |  18 +--
 board/ti/am62x/evm.c            |  63 ++--------
 board/ti/am64x/evm.c            |  73 ++---------
 board/ti/am65x/evm.c            |  29 +----
 board/ti/common/Makefile        |   1 +
 board/ti/common/k3-ddr-init.c   |  89 +++++++++++++
 board/ti/common/k3-ddr-init.h   |  15 +++
 board/ti/j721e/evm.c            |  29 +----
 board/ti/j721s2/evm.c           |  35 ++----
 board/ti/j784s4/evm.c           |  17 +--
 configs/j7200_evm_r5_defconfig  |   1 +
 configs/j721e_evm_r5_defconfig  |   1 +
 configs/j721s2_evm_r5_defconfig |   1 +
 configs/j784s4_evm_r5_defconfig |   1 +
 drivers/ram/Kconfig             |  11 ++
 drivers/ram/k3-ddrss/k3-ddrss.c | 214 +++++++++++++++++++++++++++-----
 20 files changed, 391 insertions(+), 267 deletions(-)
 create mode 100644 board/ti/common/k3-ddr-init.c
 create mode 100644 board/ti/common/k3-ddr-init.h

-- 
2.34.1

