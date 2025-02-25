Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9364C021B6
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BF380FC2;
	Tue, 25 Feb 2025 12:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d7yB3uTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2780180FA6; Tue, 25 Feb 2025 12:49:24 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FCE807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PBn6up1221222
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Feb 2025 05:49:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740484146;
 bh=0JHfkE8pajUlSWLCZgoQ1u3LzUteEh56HI1k0BTsWn0=;
 h=From:To:CC:Subject:Date;
 b=d7yB3uTNqnavjP0cSnO2wHq165yXyYoL6mMXEB2+9jW2kkG4NO0+lBKCSAQ+SCwtR
 MCTJnx0Zz5mRHx1wZp+LKTrpr9su080n1omUaID1sMKayo1CNRY7vrT4mh7/RbAWGw
 WyQ/VKQVuov/V+fbMTII8ef/mN38EhyW6/j8YWSc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBn6cJ091380;
 Tue, 25 Feb 2025 05:49:06 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 05:49:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 05:49:06 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PBn5n9112249;
 Tue, 25 Feb 2025 05:49:06 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Andrew Davis <afd@ti.com>,
 "Alexander Sverdlin" <alexander.sverdlin@siemens.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Chintan Vankar" <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Jayesh Choudhary" <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, "Bryan Brattlof" <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 00/15] Add support for Ethboot for AM68-SK, AM62p-SK
Date: Tue, 25 Feb 2025 17:18:48 +0530
Message-ID: <20250225114903.2080616-1-c-vankar@ti.com>
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

Hello All,

This series enables ethernet boot support for AM68-SK, AM62p-SK and
J722s_EVM. It is based on commit '5061eab96acd6' of origin/master
branch of U-Boot.

Link to v2:
https://lore.kernel.org/r/20250219104831.2315464-1-c-vankar@ti.com/

Changes from v2 to v3:
- Removed [PATCH v2 01/13] since Alexander Sverdlin has posted the
  fix at:
  https://lore.kernel.org/r/20250220124908.3396843-1-alexander.sverdlin@siemens.com/
- Removed not required if condition from [PATCH v2 02/13] as suggested
  by Alexander Sverdlin.
- Removed not-required config option from am68_sk_r5_ethboot_defconfig.
- Introduce a new patch which enables CONFIG_SPL_SYSCON for CPSW driver
  in Kconfig file.
- Add patches required to enable Ethenet boot on J722s-EVM.


Andreas Dannenberg (3):
  arm: mach-k3: am62p: Update SoC auto-gen data to enable CPSW boot
  board: ti: am62px: evm: Enable cache for AM62p
  configs: am62p: Add configs for enabling ETHBOOT in R5SPL

Chintan Vankar (12):
  net: ti: am65-cpsw-nuss: Define bind method for CPSW driver
  arm: mach-k3: am62x: am625_init: Remove explicit probing of CPSW
    driver
  arm: mach-k3: j721s2: Update SoC auto-gen data to enable Ethernet boot
  arm: mach-k3: j721s2_spl: Alias Ethernet boot to CPGMAC
  net: ti: Kconfig: Enable SPL_SYSCON config for CPSW
  configs: am68: Add configs for enabling Ethboot in R5SPL
  configs: am68: Enable configs required for Ethernet boot
  configs: am62p: Enable configs required for Ethboot
  arch: arm: mach-k3: r5: j722s: Update SoC autogenerated data to enable
    Ethernet boot
  board: ti: j722s: evm: Enable cache for J722s
  configs: j722s_evm_r5: Add configs to enable Ethboot in R5SPL
  configs: j722s_evm_a53: Enable configs required for Ethernet boot

 arch/arm/mach-k3/am62x/am625_init.c        |   9 --
 arch/arm/mach-k3/include/mach/j721s2_spl.h |   1 +
 arch/arm/mach-k3/r5/am62px/clk-data.c      |  44 +++++++-
 arch/arm/mach-k3/r5/am62px/dev-data.c      |  24 +++--
 arch/arm/mach-k3/r5/j721s2/clk-data.c      |  58 +++++++++-
 arch/arm/mach-k3/r5/j721s2/dev-data.c      |   3 +-
 arch/arm/mach-k3/r5/j722s/clk-data.c       |  50 +++++++--
 arch/arm/mach-k3/r5/j722s/dev-data.c       |  34 +++---
 board/ti/am62px/evm.c                      |   8 ++
 board/ti/j722s/evm.c                       |   8 ++
 configs/am62px_evm_a53_ethboot_defconfig   |  13 +++
 configs/am62px_evm_r5_ethboot_defconfig    |  29 +++++
 configs/am68_sk_a72_ethboot_defconfig      |  14 +++
 configs/am68_sk_r5_ethboot_defconfig       |  23 ++++
 configs/j722s_evm_a53_ethboot_defconfig    |  13 +++
 configs/j722s_evm_r5_ethboot_defconfig     |  30 ++++++
 drivers/net/ti/Kconfig                     |   1 +
 drivers/net/ti/am65-cpsw-nuss.c            | 120 ++++++++++++---------
 18 files changed, 374 insertions(+), 108 deletions(-)
 create mode 100644 configs/am62px_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62px_evm_r5_ethboot_defconfig
 create mode 100644 configs/am68_sk_a72_ethboot_defconfig
 create mode 100644 configs/am68_sk_r5_ethboot_defconfig
 create mode 100644 configs/j722s_evm_a53_ethboot_defconfig
 create mode 100644 configs/j722s_evm_r5_ethboot_defconfig

-- 
2.34.1

