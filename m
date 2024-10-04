Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010FFCFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904DD88DB2;
	Fri,  4 Oct 2024 08:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qZ8eO25Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065F688CE5; Fri,  4 Oct 2024 08:24:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442A8882B7
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4946OZGw010045;
 Fri, 4 Oct 2024 01:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728023075;
 bh=9J49XhVvpSqwcJ5B9FZmGzMYXn42PQ7QKeuR03ZHjws=;
 h=From:Subject:Date:To:CC;
 b=qZ8eO25YkYfcaah6rBF2hGSe/QbwqBBXoWsqaiLTyKYC1hL5cmrl9GnPBT0HLZqpT
 E6794+PgOwjhrN5hp7VO0kdPXR7oxhnoxBxQwKwxYvuNgxRxTr480rCfzBTsiRYh4Y
 44tT+HSlvjh//uCXzG1CvI0CcDt0ozOr4StFYH3g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4946OZrU116761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 01:24:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 01:24:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 01:24:35 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4946OVYv100112;
 Fri, 4 Oct 2024 01:24:32 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/7] Add AVS support for J721S2
Date: Fri, 4 Oct 2024 11:54:28 +0530
Message-ID: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByK/2YC/3XNSw7CIBSF4a0YxmLgAm1x5D6MA8rDYtJHoBJN0
 71La2LjoMP/Jvc7E4o2eBvR+TChYJOPvu9y8OMB6UZ1d4u9yY2AACeUEVxz/BziGKxq8aMEGgG
 rFHGlaVUa5iwUCuXnIVjnXyt8veVufBz78F53El2uXxJIsUcmivNcKQhnWkhZyMvoT7pv0eIl2
 AwB1a4B2TBOcuKAEWnIn8E2o6Js12DZEJQKI5k2toafMc/zByYMkahBAQAA
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728023071; l=1871;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=v3uIVB+0BvRBm7nyObW5u1WIBXfbQavLHAKJlCD2ii0=;
 b=2hS3BD8xWKJjFt/80GWKcWj1EJeucy1fxh8Wwf96G52xlCT5kUJXy7rWxbJqXQRQcgW378jNY
 txBMUzq7TeDCAJbZmLAuDBNFg6Yyk815Kn7oYrtLvI6ZFOF22tpBCID
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

This series adds support for AVS on J721S2.

AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
Boot Test results: https://gist.github.com/manorit2001/15e45f6c421aeeb93effde023a537762

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v4:

* Udit
- Use the compatible for finding the node rather than alias.
- Remove debug print
- Add ret value in error prints

- Link to v3: https://lore.kernel.org/r/20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com

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
 arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
 configs/am68_sk_r5_defconfig                    |  4 +++
 configs/j721s2_evm_r5_defconfig                 |  6 ++++
 drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
 drivers/power/pmic/Kconfig                      |  1 +
 11 files changed, 79 insertions(+), 6 deletions(-)
---
base-commit: 3a0b829efc35227b1079a444f00e0729502197ad
change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

