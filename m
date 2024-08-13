Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B31C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2637B8896C;
	Tue, 13 Aug 2024 08:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MZk0Ae17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 192358896B; Tue, 13 Aug 2024 08:10:51 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960708890D
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AkdD042724;
 Tue, 13 Aug 2024 01:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529446;
 bh=4GCUaF+q8puCM58S7ynleIjc8odPDD+xREB4pdEzOtw=;
 h=From:Subject:Date:To:CC;
 b=MZk0Ae17AKo+dExVBR5TgpyJB7Uf6UVXTSiOk4283JmGjjGQCSzkis0TPgDKWc9dz
 FrWpljRoL3bu5nPNcqjtF/1N9z1AM1pKZ92gcF9l/4erNvghGEm8btVim2SB4BqB5r
 g6i3l0QT6dnwAucGRN18NQEnmgeOhye4QXv7Fgcc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6AkeN008958
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:10:46 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:10:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:10:46 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHg016562;
 Tue, 13 Aug 2024 01:10:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/7] Add AVS support for J721S2
Date: Tue, 13 Aug 2024 11:40:40 +0530
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOD4umYC/3XNywrCMBCF4VcpWRuZTNJLXPke4iLmYiP0QlKDU
 vruphV01eU/MN+ZSbTB20hOxUyCTT76oc/BDwXRrervlnqTmyCgAMaB3gR9jnEKVnX0USOLSFW
 KtNGsqQ13FitF8vMYrPOvDb5cc7c+TkN4bzuJrdcviVDtkYnRPFeXILgupazkefJHPXRk9RL+j
 RKbXQOzYZwU4JCDNPAzlmX5ALEOtuH9AAAA
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=1864;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=tv1pApBaHE3fT3Y0L+FB8DOo6iehm8VRG3qEggui6Uc=;
 b=BqjD+aJA8oF2I4iCzbpaNnsT9MoLO5jenwAqPq758Rf3hSVVmtcu8a9/1bIR1efRoyKExpw2a
 OBRSUsrBW7ZDJ3hAm+jOUBDV9ObiwzsavZI2DfnRkHqWDHignZHIRvB
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

This series adds support for AVS on J721S2.

AVS Test for J721S2: https://gist.github.com/manorit2001/c64cf396281806102cae2b45ba84781e
Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a690497d94d012b93c4

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
* Udit
- Change the method of soc_match_device

* Tom
- That code part changed so that error wouldn't exist anymore

- Link to v2: https://lore.kernel.org/r/20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com

---
Manorit Chawdhry (7):
      power: pmic: tps65941: Add DM_PMIC dependency
      drivers: misc: k3_avs: Check return code while programming AVS
      arm: dts: k3-j7*-r5: Add MPU clock in clocks property
      drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
      arm: mach-k3: j721s2_init: Initialize AVS Class 0
      arm: dts: j721s2: Add VTM node in R5
      configs: j721s2_evm_r5_defconfig: Add AVS Configs

 arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
 arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
 arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
 arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 ++++++
 configs/am68_sk_r5_defconfig                    |  4 +++
 configs/j721s2_evm_r5_defconfig                 |  6 ++++
 drivers/misc/k3_avs.c                           | 42 ++++++++++++++++++++++++-
 drivers/power/pmic/Kconfig                      |  1 +
 11 files changed, 81 insertions(+), 6 deletions(-)
---
base-commit: b4cbd1a257d4027038b4f997d73bdb0a066db045
change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

