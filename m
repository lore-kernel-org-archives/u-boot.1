Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1DFC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FA087C7E;
	Tue,  6 Feb 2024 13:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ylmG8LIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCCD87C7E; Tue,  6 Feb 2024 13:21:19 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8591F87C68
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLEAC017293;
 Tue, 6 Feb 2024 06:21:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222074;
 bh=4W0LkmSEGfia7qNr6ghfkf0MgOP1p+cU38TzhXASsVE=;
 h=From:Subject:Date:To:CC;
 b=ylmG8LIACMMCpTkwpg51JbGu++y+LxaS3pitGORyiWo+YaG9wK9I1aX4TjKbZBDKl
 Gy97FAtrGob7Gx1R2A5388IOy9AZCQtBWvsXFc0OO/Um01zEAh1jLo4Z2uhLbCv/Or
 /vpOIbzIbmXAz6J/u8s70CPOM7VUAAK7OG70WpKY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLExi096191
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:14 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:13 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAhx081923;
 Tue, 6 Feb 2024 06:21:10 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 00/10] Add AVS support for J721S2
Date: Tue, 6 Feb 2024 17:51:07 +0530
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMkwmUC/x3M3QpAQBBA4VfRXJvanRXyKnKxGIzy0w5S8u42l
 9/FOQ8oB2GFKnkg8CUq2xph0wS6ya8jo/TRQIYyY53BNsNz1yOwX3AuyCqhvxTLzpZF7wam3EO
 M98CD3P+4bt73A7J97rRoAAAA
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=1930;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ZCUZxfqiwwhzjU4IxJHe1K47yGqUFh1RrVztUmcc6s4=;
 b=mit2qxxMBJQsbwI7YPUBMT+lZeLdbEjsoUwYgDDz0yPP90+IHVKxdJMPtQeeflcikUyBpaSLJ
 wUsH5l4xdTaBxoB9d5e7wxmAdwF6dbCVv6ZHleojWxNYk8hvXoCljdw
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

This series does the DT sync with Linux 6.8-rc1 as that has the pmic
nodes required for AVS support and then adds AVS Support for J721S2.

AVS Test for J721S2: https://gist.github.com/manorit2001/d7690ded6ef685aa8ffa5b16746cc529
Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a690497d94d012b93c4

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (10):
      arm: dts: k3-j721s2*: Sync with 6.8-rc1
      arm: dts: k3-am68*: Sync with 6.8-rc1
      drivers: misc: k3_avs: Use soc_match_device instead of compatible.
      drivers: misc: k3_avs: Check return code while programming AVS
      drivers: misc: k3_avs: Add AVS Support for J721S2.
      drivers: power: pmic: Fix compatible for J721S2
      arm: mach-k3: j721s2_init: Initialize AVS Class 0
      arm: dts: j721s2: Add VTM node in R5
      DONOTMERGE: arm: dts: j721s2: Fix Power domain for VTM node.
      configs: j721s2_evm_r5_defconfig: Add AVS Configs

 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  18 +-
 arch/arm/dts/k3-am68-sk-base-board.dts             |   1 +
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  18 +-
 arch/arm/dts/k3-j721s2-main.dtsi                   |   9 +-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             |  23 ++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    |   9 +
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 193 ++++++++++++++++++
 arch/arm/mach-k3/j721s2_init.c                     |   8 +
 configs/j721s2_evm_r5_defconfig                    |   6 +
 drivers/misc/k3_avs.c                              | 216 ++++++++++++---------
 drivers/power/pmic/tps65941.c                      |   2 +-
 11 files changed, 385 insertions(+), 118 deletions(-)
---
base-commit: 6faba41927bdc8973b59678649ef83c564cc421e
change-id: 20240130-b4-upstream-j721s2-avs-8c187d3fe26a

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

