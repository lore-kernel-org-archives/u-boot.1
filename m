Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0FC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 10:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AA780F5C;
	Wed, 19 Feb 2025 11:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xQxvYDdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EC880017; Wed, 19 Feb 2025 11:48:53 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9DA800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmYFU258764
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 04:48:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739962114;
 bh=wBMvTxm1KbjaGWV9bPWLEV0Xhv/apgRrR5ulqXwXoY8=;
 h=From:To:CC:Subject:Date;
 b=xQxvYDdIn6euMO3mkOC/wbtGIwmP6RhE7jVCXMmUlCLcqCjJJ7Ybxs6QXeuuwt7NG
 P8VwyYpRDSBv4BAzJAltAO7MtMNexJFD8H6K6z1dnot5FFOvphZmjY84CMFPqYqzYT
 ZIVyx1/Vv0OJ6pycNyPSsIK7vNZZnQN+MbmHrUrE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmYBU096831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 04:48:34 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 04:48:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 04:48:34 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JAmXTQ030159;
 Wed, 19 Feb 2025 04:48:34 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Santhosh Kumar K <s-k6@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Nishanth Menon <nm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 00/13] Add support for Ethboot for AM68-SK AM62p-SK
Date: Wed, 19 Feb 2025 16:18:18 +0530
Message-ID: <20250219104831.2315464-1-c-vankar@ti.com>
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

This series adds support to enable Ethernet boot for AM68-SK and AM62p-SK
devices.

This seies is based on commit '7a45cb4ffeff0' of origin/master branch of
U-Boot.

Link to v1:
https://lore.kernel.org/r/20250107093840.2211381-1-c-vankar@ti.com/

Logs for Ethernet boot:
AM68: https://gist.github.com/chintan013/3117d2bc8b589154a7d5d47b8d8c0920
AM62p: https://gist.github.com/chintan013/39802b693a15776e7f696df401999a79
AM62x: https://gist.github.com/chintan013/d35ca61f7fa57cedd3c34d5639886186

Changes from v1 to v2:
-> Updated commit message for [PATCH 01/13] in this series.
-> Defined bind method and replace it with probe method for CPSW driver.
-> Added new patch [PATCH v2 03/16] in this series which removes
   explicit probing of CPSW driver
-> Added Reviewed-by tag for [PATCH 02/13] from Bryan Brattlof.
-> Removed unnecessary config options and updated commit message to add
   configs for AM62p and AM68.
-> Updated commit message for [PATCH 08/13].

Andreas Dannenberg (3):
  arm: mach-k3: am62p: Update SoC auto-gen data to enable CPSW boot
  board: ti: am62px: evm: Enable cache for AM62p
  configs: am62p: Add configs for enabling ETHBOOT in R5SPL

Chintan Vankar (10):
  net: tftp: Increase TFTP pkt string length to include null character
  net: ti: am65-cpsw-nuss: Define and switch to bind method for CPSW
    driver
  arm: mach-k3: am62x: am625_init: Remove explicit probing of CPSW
    driver
  arm: mach-k3: j721s2: Update SoC auto-gen data to enable Ethernet boot
  arm: mach-k3: j721s2_spl: Alias Ethernet boot to CPGMAC
  configs: am68: Add configs for enabling Ethboot in R5SPL
  configs: am68: Enable configs required for Ethernet boot
  arm: dts: k3-am68-sk-base-board-u-boot: Add bootph-all property to
    necessary nodes
  configs: am62p: Enable configs required for Ethboot
  arch: arm: dts: k3-am62p5-sk-u-boot: Add bootph-all property to
    necessary nodes

 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |  32 +++++
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  28 ++++
 arch/arm/mach-k3/am62x/am625_init.c           |   9 --
 arch/arm/mach-k3/include/mach/j721s2_spl.h    |   1 +
 arch/arm/mach-k3/r5/am62px/clk-data.c         |  44 +++++-
 arch/arm/mach-k3/r5/am62px/dev-data.c         |  24 ++--
 arch/arm/mach-k3/r5/j721s2/clk-data.c         |  58 +++++++-
 arch/arm/mach-k3/r5/j721s2/dev-data.c         |   3 +-
 board/ti/am62px/evm.c                         |   8 ++
 configs/am62px_evm_a53_ethboot_defconfig      |  14 ++
 configs/am62px_evm_r5_ethboot_defconfig       |  30 ++++
 configs/am68_sk_a72_ethboot_defconfig         |  15 ++
 configs/am68_sk_r5_ethboot_defconfig          |  60 ++++++++
 drivers/net/ti/am65-cpsw-nuss.c               | 129 ++++++++++--------
 net/tftp.c                                    |   6 +-
 15 files changed, 377 insertions(+), 84 deletions(-)
 create mode 100644 configs/am62px_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62px_evm_r5_ethboot_defconfig
 create mode 100644 configs/am68_sk_a72_ethboot_defconfig
 create mode 100644 configs/am68_sk_r5_ethboot_defconfig

-- 
2.34.1

