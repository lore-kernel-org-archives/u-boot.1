Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628BDC021A7
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB9680C6F;
	Thu, 13 Feb 2025 08:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hhzW+3yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0928E80BAA; Thu, 13 Feb 2025 08:37:00 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F01BB806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51D7amt24069870
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Feb 2025 01:36:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739432208;
 bh=er29RYyu1HTXp2mbCpi2YetEZLKhwgnvjnX60WB3XyY=;
 h=From:Subject:Date:To:CC;
 b=hhzW+3yfddrSMhJ2wPRXKefSvHSGmEzmkNsRKQ+TPUKKCk3k/1VdIotE5hi9ewMNO
 trJmDBKRUSobmpO4d+HqWffR/kX/gpExZKmWowbrj5WkdBP/PNslFrfZT8xTOgIQlF
 Ywdd8/1Y2Ci2zaEF6IwdTJfymL2BLGI+ulk0JZeQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7amaP105830;
 Thu, 13 Feb 2025 01:36:48 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 01:36:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 01:36:47 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7agtP101327;
 Thu, 13 Feb 2025 01:36:43 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/8] Introduce J742S2 SoC and EVM
Date: Thu, 13 Feb 2025 13:06:37 +0530
Message-ID: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAahrWcC/22NwQ6CMBAFf4X0bE13W0vqyf8wHqCsUhME20I0h
 H+3QNQLx3nJzBtZIO8osGM2Mk+DC659JJC7jNm6eNyIuyoxQ4EKAAwvFe+7ED0VDb/nCgNybU1
 plCpzYYAlsfN0da8ler6s7OnZp3b8j7ULsfXv5XiAeV0/EPKtjwG44CALXQDmpVTqFN3etg2bW
 wN+/YMAoTd9TL7CSgMaS1LKnz9N0wcWW5j2BgEAAA==
X-Change-ID: 20241119-b4-upstream-j742s2-6c9b944b7091
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Keerthy <j-keerthy@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739432202; l=3513;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ojVikRFtdP1XIR1/v53s0Kka844c3JPog7+6ArAadg8=;
 b=muAsgOWUNc+krJfeS460ZQeyb/fi90fpjAlehPiV1JSbdv9+VmQ5g/YaRstg5WCSrTdj0xwuA
 B6i0jwEId8kAVf/J4Ewm0t1pICtGEnuOfVXZEZjvn+dvXcAoXaatCYq
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

The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

This device is a subset of J784S4 and shares the same memory map and
thus the code is being reused from J784S4 to avoid duplication.

It initially cleans up the J784s4 and AM69 files so that they can be
re-usable for j742s2 and then it introduces J742S2. 

The DT for the following SoC will be coming to U-boot during 6.13 Sync
so the series is kept as RFC till then.

Here are some of the salient features of the J742S2 automotive grade
application processor:

The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive, ADAS and industrial
applications requiring AI at the network edge. This SoC extends the K3
Jacinto 7 family of SoCs with focus on raising performance and
integration while providing interfaces, memory architecture and compute
performance for multi-sensor, high concurrency applications.

Some changes that this devices has from J784S4 are:
* 4x Cortex-A72 vs 8x Cortex-A72
* 3x C7x DSP vs 4x C7x DSP
* 4 port ethernet switch vs 8 port ethernet switch
* 2 DDR controller vs 4 DDR controller

Test logs:
https://gist.github.com/manorit2001/ac51ab7d63cf78e898887efa9631563f

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
- Revert the name change for am69 ( Andrew )

- Remove RFC
- Link to v2: https://lore.kernel.org/r/20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com

---
Manorit Chawdhry (6):
      arm: dts: k3-j784s4-ddr: Refactor J784s4 ddr file to a common file
      soc: Add information to identify the J742S2 SoC family
      arm: mach-k3: j742s2: Introduce clock and device files for J742S2 SoC
      board: ti: Introduce basic board files for the J742S2 family
      arm: dts: Introduce J742S2 U-boot DTS files
      configs: Introduce configs for J742S2

Neha Malcom Francis (2):
      tools: binman: control.py: Delete template nodes after parsing
      arm: dts: k3-j784s4-binman.dtsi: Clean up and templatize boot binaries

 arch/arm/dts/k3-am69-sk-u-boot.dtsi          |   123 +-
 arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi |  8756 ++++++++++++++++
 arch/arm/dts/k3-j742s2-evm-u-boot.dtsi       |    59 +
 arch/arm/dts/k3-j742s2-r5-evm.dts            |    18 +
 arch/arm/dts/k3-j784s4-binman.dtsi           |   116 +-
 arch/arm/dts/k3-j784s4-ddr.dtsi              | 13256 ++++++++-----------------
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi       |    75 +
 arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi       |  4448 +++++++++
 arch/arm/mach-k3/include/mach/hardware.h     |     6 +
 arch/arm/mach-k3/j784s4/Kconfig              |    18 +
 board/ti/j784s4/Kconfig                      |    33 +
 board/ti/j784s4/MAINTAINERS                  |    10 +
 board/ti/j784s4/j784s4.env                   |     4 +
 configs/j742s2_evm_a72_defconfig             |     9 +
 configs/j742s2_evm_r5_defconfig              |     9 +
 drivers/clk/ti/clk-k3.c                      |     4 +
 drivers/power/domain/ti-power-domain.c       |     4 +
 drivers/soc/soc_ti_k3.c                      |    16 +-
 tools/binman/control.py                      |     6 +-
 19 files changed, 18011 insertions(+), 8959 deletions(-)
---
base-commit: 9b35357b95e30fd670869b4348159b65e102cc82
change-id: 20241119-b4-upstream-j742s2-6c9b944b7091

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

