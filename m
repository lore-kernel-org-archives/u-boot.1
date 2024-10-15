Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C341DCFC287
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8088913A;
	Tue, 15 Oct 2024 12:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PHK7cZ0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6508913A; Tue, 15 Oct 2024 12:52:29 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFF1890F2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqNrj112715;
 Tue, 15 Oct 2024 05:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989543;
 bh=LttjltBCtqD2PL9uleEaAbLWTR5yIk27aVAnoRd/rpw=;
 h=From:Subject:Date:To:CC;
 b=PHK7cZ0BFPh7Wh+u+SaAW3TdOcdBd8TnKH45l0Lrl/68JaTg6h7xOIyGPpHuhKfdz
 H1hRQIaayr7HP0ejj6Tba+3nBXvwuuv+/4nFkh2MjGL65klTvCybMviu1PWzNlXwWX
 PGUAXhHJw+YMozRuJzlZ+j1we8YeZw8Z2GZ9HWyQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FAqNe2043910
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 05:52:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:23 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbe044559;
 Tue, 15 Oct 2024 05:52:19 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v5 0/7] Add AVS support for J721S2
Date: Tue, 15 Oct 2024 16:22:16 +0530
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBJDmcC/3XNy27CMBCF4VdBXuNqZnxJzIr3qLpwfClGgiA7W
 K2ivHsdKoFYZPmPNN+ZWQk5hcIOu5nlUFNJ47WF2u+YO9nrd+DJt2YEJAEF8EHy+61MOdgLP3e
 EhbithfcO+86LGEhb1p5vOcT084A/v1qfUpnG/PvYqbhe/0kCvUVW5G2uUyCFU8Zoc5zShxsvb
 PUqvQxF/aZBzfDRSIgkwHh4M8TL6FFsGqIZClF5I5wPA70Z8mkggNw0ZDO079DpwQ4myqexLMs
 fddxHT4UBAAA=
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=2532;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=fLcgZE6BSJrActfx2sOJXvcgFi3SP9Td8BHqKsu1rBo=;
 b=AREX89pvqbO732wd2GjFWEB73B12fSvKKu8M2M20C+xlkAxlfTKBPaQuVrhqz1YiKScOoLnzn
 Pz1TLexzZCGBOeu381N4kpYwmSzXQIl3e63lA4I56wiynb0zGCg9s3g
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

This series adds support for Adaptive voltage scaling on J721S2 device [0].

[0]: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.4.1 AVS Support)

AVS Test for J721S2: https://gist.github.com/manorit2001/b2fd9f6764a863294d4aa0755c83c84f
Boot Test results: https://gist.github.com/manorit2001/d44e035552cb19aadeb0d928d5cb5f26

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v5:
* Nishanth
- Update the commit message for defconfig update
- Add MPU clock to all devicetree node

* Simon
- Update the commit messages to be more helpful

- Link to v4: https://lore.kernel.org/r/20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com

---
Manorit Chawdhry (7):
      power: pmic: tps65941: Add DM_PMIC dependency
      drivers: misc: k3_avs: Check return code while programming AVS
      arm: dts: k3-*-r5: Add MPU clock in clocks property
      drivers: misc: k3_avs: Extract MPU clk and dev ID from DT
      arm: mach-k3: j721s2_init: Initialize AVS Class 0
      arm: dts: j721s2: Add VTM node in R5
      configs: j721s2_evm_r5_defconfig: Add AVS Configs

 arch/arm/dts/k3-am62-r5-lp-sk.dts               |  3 +-
 arch/arm/dts/k3-am625-r5-beagleplay.dts         |  3 +-
 arch/arm/dts/k3-am625-r5-sk.dts                 |  3 +-
 arch/arm/dts/k3-am62a7-r5-sk.dts                |  3 +-
 arch/arm/dts/k3-am62p5-r5-sk.dts                |  3 +-
 arch/arm/dts/k3-am642-r5-evm.dts                |  3 +-
 arch/arm/dts/k3-am642-r5-sk.dts                 |  3 +-
 arch/arm/dts/k3-am654-r5-base-board.dts         |  3 +-
 arch/arm/dts/k3-am69-r5-sk.dts                  |  3 +-
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts  |  3 +-
 arch/arm/dts/k3-j721e-r5.dtsi                   |  3 +-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts |  9 ++++++
 arch/arm/dts/k3-j721s2-r5.dtsi                  |  3 +-
 arch/arm/dts/k3-j722s-r5-evm.dts                |  3 +-
 arch/arm/dts/k3-j784s4-r5-evm.dts               |  3 +-
 arch/arm/mach-k3/j721s2/j721s2_init.c           | 10 +++++++
 configs/am68_sk_r5_defconfig                    |  4 +++
 configs/j721s2_evm_r5_defconfig                 |  6 ++++
 drivers/misc/k3_avs.c                           | 40 ++++++++++++++++++++++++-
 drivers/power/pmic/Kconfig                      |  1 +
 20 files changed, 97 insertions(+), 15 deletions(-)
---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

