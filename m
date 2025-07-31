Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44635C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728F7833F8;
	Thu, 31 Jul 2025 10:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u9aKQKoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B7E833EC; Thu, 31 Jul 2025 10:00:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A890A8334A
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V802712954324;
 Thu, 31 Jul 2025 03:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948802;
 bh=L0B6SuGT0uUSErToD1OWOEoNVQoHwFJ82W1k3/ddXVI=;
 h=From:To:CC:Subject:Date;
 b=u9aKQKoai/LwRSCZZ40sw8gJ30SrAo/GC6W0p+/12AGzzigXRRIU3RiM+Xc/v6CrX
 Etjo1hbXUSXKY9/CRSsnAQ4JYwRpBYTvZApi3FT+NyG3YgOQVPpdD9r/kIibe5hi0f
 vbh7stvqhwcZTa1syhx7oRMrcnmJLhA8Ng7qaBfI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V802iI4068118
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:00:02 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:00:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:00:00 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V7xxC52564516;
 Thu, 31 Jul 2025 03:00:00 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 00/21] Add support for Ethernet boot
Date: Thu, 31 Jul 2025 13:29:35 +0530
Message-ID: <20250731075956.605474-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:00:51 +0200
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

This series adds bind method for CPSW to avoid explicit probing, removes
explicit probing of CPSW, adds support for Ethernet boot on SK-AM68,
SK-AM62P-LP, J722S, SK-AM69.

This series is based on commit 'a8f20bb6650df56d' of origin/master
branch of U-Boot.

Link to v3: 
https://lore.kernel.org/u-boot/20250225114903.2080616-1-c-vankar@ti.com/

Changes from v3 to v4: 
- Updated bind method to avoid initializing fields in cpsw data structure.
- Revert commits to avoid explicit probing of CPSW driver as per Roger's
  suggestion.
- Updated commit messages of adding SoC auto-gen data for J721s2.
- Collected Reviewed-by tag from Alexander Sverdlin on [PATCH v3 05/15]
  and [PATCH v3 13/15].
- Added support of Ethernet boot for SK-AM69.

Andreas Dannenberg (3):
  arm: mach-k3: am62p: Update SoC auto-gen data to enable Ethernet boot
  board: ti: am62px: evm: Enable cache for AM62p
  configs: am62px_evm_r5_ethboot: Add configs to enable Ethernet boot in
    R5SPL

Chintan Vankar (18):
  net: ti: am65-cpsw-nuss: Define bind method for CPSW driver
  arch: mach-k3: common: Remove explicit probing of CPSW driver
  Revert "mach-k3: am642_init: Probe AM65 CPSW NUSS for R5/A53 SPL"
  Revert "arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS"
  arm: mach-k3: j721s2: Update SoC auto-gen data to enable Ethernet boot
  arm: mach-k3: j721s2_spl: Alias Ethernet boot to CPGMAC
  net: ti: Kconfig: Enable SPL_SYSCON config for CPSW
  configs: am68_sk_r5_ethboot: Add configs for enabling Ethernet boot in
    R5SPL
  configs: am68_sk_a72_ethboot: Enable configs required for Ethernet
    boot
  configs: am62px_evm_a53_ethboot: Enable configs required for Ethboot
  arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet
    boot
  board: ti: j722s: evm: Enable cache for J722s
  configs: j722s_evm_r5_ethboot: Add configs to enable Ethernet boot in
    R5SPL
  configs: j722s_evm_a53_ethboot: Enable configs required for Ethernet
    boot
  arm: mach-k3: j784s4: Update SoC auto-gen data to enable Ethernet boot
  arm: mach-k3: j784s4_spl: Alias Ethernet boot to CPGMAC
  configs: am69_sk_r5_ethboot: Add configs to enable Ethernet boot in
    R5SPL
  configs: am69_sk_a72_ethboot: Add configs to enable Ethernet boot

 arch/arm/mach-k3/am62x/am625_init.c        |  9 ----
 arch/arm/mach-k3/am64x/am642_init.c        |  7 ---
 arch/arm/mach-k3/common.c                  | 11 ----
 arch/arm/mach-k3/include/mach/j721s2_spl.h |  1 +
 arch/arm/mach-k3/include/mach/j784s4_spl.h |  2 +
 arch/arm/mach-k3/r5/am62px/clk-data.c      | 44 ++++++++++++++--
 arch/arm/mach-k3/r5/am62px/dev-data.c      | 24 +++++----
 arch/arm/mach-k3/r5/j721s2/clk-data.c      | 58 ++++++++++++++++++++--
 arch/arm/mach-k3/r5/j721s2/dev-data.c      |  3 +-
 arch/arm/mach-k3/r5/j722s/clk-data.c       | 50 +++++++++++++++----
 arch/arm/mach-k3/r5/j722s/dev-data.c       | 34 ++++++-------
 arch/arm/mach-k3/r5/j784s4/clk-data.c      | 54 ++++++++++++++++++--
 arch/arm/mach-k3/r5/j784s4/dev-data.c      |  1 +
 board/ti/am62px/evm.c                      |  8 +++
 board/ti/j722s/evm.c                       |  8 +++
 configs/am62px_evm_a53_ethboot_defconfig   | 13 +++++
 configs/am62px_evm_r5_ethboot_defconfig    | 29 +++++++++++
 configs/am68_sk_a72_ethboot_defconfig      | 14 ++++++
 configs/am68_sk_r5_ethboot_defconfig       | 23 +++++++++
 configs/am69_sk_a72_ethboot_defconfig      | 11 ++++
 configs/am69_sk_r5_ethboot_defconfig       | 15 ++++++
 configs/j722s_evm_a53_ethboot_defconfig    | 13 +++++
 configs/j722s_evm_r5_ethboot_defconfig     | 30 +++++++++++
 drivers/net/ti/Kconfig                     |  1 +
 drivers/net/ti/am65-cpsw-nuss.c            | 40 ++++++++++++---
 25 files changed, 418 insertions(+), 85 deletions(-)
 create mode 100644 configs/am62px_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62px_evm_r5_ethboot_defconfig
 create mode 100644 configs/am68_sk_a72_ethboot_defconfig
 create mode 100644 configs/am68_sk_r5_ethboot_defconfig
 create mode 100644 configs/am69_sk_a72_ethboot_defconfig
 create mode 100644 configs/am69_sk_r5_ethboot_defconfig
 create mode 100644 configs/j722s_evm_a53_ethboot_defconfig
 create mode 100644 configs/j722s_evm_r5_ethboot_defconfig

-- 
2.34.1

