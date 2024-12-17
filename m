Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7503EE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2F180224;
	Tue, 17 Dec 2024 12:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rnDV5zAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB8D8022E; Tue, 17 Dec 2024 12:07:49 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011E5801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHB7b0V3696290
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Dec 2024 05:07:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734433657;
 bh=AFEKUWw7iwlFyIs69Agmrw4heDIHeqC3Bb+r2K1FjVk=;
 h=From:Subject:Date:To:CC;
 b=rnDV5zAFN44lGbVyQQ7XOgUJfjUOwIuX4Yri+lhojd//VYKnanBfuY6YBLxy8Ssky
 UB//Lb2N6pU1vmBK6WyrBV6lgC14eRD557hkXoza7F9TLm8nC0r8oeBQjo6fLY6E4+
 Pb+ppHEgNewj9d3ul8Z/Ne/E1fNmbza1C8baED7Y=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHB7bt9070232;
 Tue, 17 Dec 2024 05:07:37 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 05:07:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 05:07:37 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHB7WbZ013855;
 Tue, 17 Dec 2024 05:07:33 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH RFC 0/8] Introduce J742S2 SoC and EVM
Date: Tue, 17 Dec 2024 16:37:17 +0530
Message-ID: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZbYWcC/1WNQU4DMQxFrzLKGqM4TZNmVkhIPQBb1EXseCCId
 NpkWiFVvTthYMPO31//vZtqUrM0NQ43VeWaW56PPeDDoPg9Ht8EcupZGW0sIgYgC5dTW6rEAh/
 emmbAcaBgLXkdUPXhqcqUv1boq3rZP6vD77PK+dIFy19TpLW4CsZhxRv0//CpQF9Blc+Z4YqAw
 JxMQLclIve05Eeey4+QYhPod8nLOARiZzjsdLK4m3R03m1MJBM4bbYatTecyE1aHe73b0CJ9B3
 /AAAA
X-Change-ID: 20241119-b4-upstream-j742s2-6c9b944b7091
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Keerthy
 <j-keerthy@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734433652; l=2789;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=1pQHDwOxdrmFsToFx7rNIht8nKj71KYpFTqTZpALBt0=;
 b=dP1uZQEkIRgc6udt0cpJY91gf6BjKyyaoos2bcxFvG/+4Whjhsb7j2CKAVMllJLxB5Fz6MJbd
 DQXvReY8XA6A3FlQ+1OtxHmmBaUdo1K+FawzT0cUaArQ51fuq1K+00h
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

The series adds support for J742S2 family of SoCs. Also adds J742S2 board
Support and re-uses most of the stuff from the superset device J784s4.

It initially cleans up the J784s4 and AM69 files so that they can be
re-usable for j742s2 and then it introduces J742S2. 

The DT for the following SoC will be coming to U-boot during 6.13 Sync
so the series is kept as RFC till then.

Test logs with manual sync of 6.13-rc2 and dependent patches: 
https://gist.github.com/manorit2001/1a222ab8b92961eb6dc829cfd5600be4

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
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

 arch/arm/dts/k3-am69-sk-u-boot.dtsi             |   120 +-
 arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi    |  8756 ++++++++++++++
 arch/arm/dts/k3-j742s2-evm-u-boot.dtsi          |    59 +
 arch/arm/dts/k3-j742s2-r5-evm.dts               |    18 +
 arch/arm/dts/k3-j784s4-binman.dtsi              |   116 +-
 arch/arm/dts/k3-j784s4-ddr.dtsi                 | 13246 +++++++---------------
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi          |    74 +
 arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi          |  4446 ++++++++
 arch/arm/mach-k3/include/mach/hardware.h        |     2 +
 arch/arm/mach-k3/include/mach/j784s4_hardware.h |     4 +
 arch/arm/mach-k3/j784s4/Kconfig                 |    18 +
 board/ti/j784s4/Kconfig                         |    33 +
 board/ti/j784s4/MAINTAINERS                     |    10 +
 board/ti/j784s4/j784s4.env                      |     4 +
 configs/j742s2_evm_a72_defconfig                |     9 +
 configs/j742s2_evm_r5_defconfig                 |     9 +
 drivers/clk/ti/clk-k3.c                         |     4 +
 drivers/power/domain/ti-power-domain.c          |     4 +
 drivers/soc/soc_ti_k3.c                         |    17 +-
 tools/binman/control.py                         |     6 +-
 20 files changed, 18005 insertions(+), 8950 deletions(-)
---
base-commit: 9bc62c980d418f0a67632ab29cd3501072cdb6f0
change-id: 20241119-b4-upstream-j742s2-6c9b944b7091
prerequisite-message-id: 20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com
prerequisite-patch-id: fdbddb1d9fdaadb7551e99caf5e93e22836dd8c3

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

