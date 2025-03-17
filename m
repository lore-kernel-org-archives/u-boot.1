Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB5AC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C0A817EC;
	Mon, 17 Mar 2025 05:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KN8au3Vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D772B81100; Mon, 17 Mar 2025 05:54:49 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3922B810F4
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 05:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4sck52231282
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Mar 2025 23:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742187278;
 bh=A0RSgE7YFjrsKeOAlxw0SqbGYtCoztk2Pd2t/zPvTJI=;
 h=From:Subject:Date:To:CC;
 b=KN8au3VjxThVLRa64PEBcSypDbW7/Vzg2z1slDeSJbW4cnMPVp7yYljaGWpbWF56b
 VFqqGEeGETC1ySM3rLKbmLhET8ProQt1g7xw5X/frmitBIqSdsqgr08VP0KoDVwBcV
 lKz0b5nVzafXPwbavBF5RhLaqeYBWhX0dDrqR6mU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4scSq127304
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Mar 2025 23:54:38 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 23:54:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 23:54:38 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4sXBb058287;
 Sun, 16 Mar 2025 23:54:34 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/8] Introduce J742S2 SoC and EVM
Date: Mon, 17 Mar 2025 10:24:19 +0530
Message-ID: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyq12cC/23NTQrCMBQE4KtI1kbyfmyIK+8hLpL6qhG0mtSiS
 O9uVFSELmfgm7mrLClKVovJXSXpY47tsQSeTlS988et6LgpWaFBBgCnA+vLKXdJ/EHvLWNGXdU
 uOOZgjQNV4ClJE6+v0dX6nZOcL2W7+5W7mLs23V7HPTzb9weCHfvoQRsN5CsPaAMxL7s4q9uDe
 m71+PFzA6Ya9Vg846YCdLUQ0Z+nn0egUU/FizENekvSBPP1wzA8AJ9aVuhGAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742187273; l=3674;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=y94RWypyd7k0zrkoZ5/+UM3dPK27dlnD03fIrJFnewQ=;
 b=s0vz/zcPdlFUXxYY7xaRF/F6Fxsu5cTVtbSe0JO+EsK1eBtJjxogtgEzJlWdugfL0kj6eMOA2
 RTaxvZKbytLDWOAjpEK53rjy4OFTU7tzSYoHmf+kL2yOtbhedr4k+Gn
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
https://gist.github.com/manorit2001/f7df0e8cca1e9973b4361f0559c6f53d

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v4:
- Include a test for binman fix ( Simon )

- Add hs node in binman for j742s2
- Fix a checkpatch warning
- Link to v3: https://lore.kernel.org/r/20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com

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
 arch/arm/dts/k3-j742s2-evm-u-boot.dtsi       |    72 +
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
 tools/binman/ftest.py                        |     7 +
 tools/binman/test/346_remove_template.dts    |    49 +
 21 files changed, 18080 insertions(+), 8959 deletions(-)
---
base-commit: 0e1fc465fea62ebae91f2f56cb823e8b37ee1077
change-id: 20241119-b4-upstream-j742s2-6c9b944b7091

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

