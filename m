Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFB7E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84305801E8;
	Mon,  6 Jan 2025 10:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OFC0Bbbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53900801E8; Mon,  6 Jan 2025 10:35:37 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC5C8007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5069ZOM82772022
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:35:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736156125;
 bh=qxnJqye8236xFjuqHbDDcZ6kn9VNwBHfhKAfAN8gTY4=;
 h=From:Subject:Date:To:CC;
 b=OFC0BbbvhVdQ5qiZlCderFzsHYbR3CA3+szLu6Uo5If+oMy+JuIWgL6O9MtzuUf7N
 CMjBAigtsI0ThB5yX+LCEM2MtlgurAK4yJsYbaHaBN+t3CWG8Guy/7cBqPgic9rKqT
 /1RQZu4HqzzdEveB9Hc6CMsU4SHnqHkEEqpAzz2c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5069ZOag019702
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:35:24 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:35:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:35:24 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5069ZJEw028930;
 Mon, 6 Jan 2025 03:35:20 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH RFC v2 0/8] Introduce J742S2 SoC and EVM
Date: Mon, 6 Jan 2025 15:04:56 +0530
Message-ID: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCje2cC/22OzQrCMBCEX6Xs2Ug3jS3pSRB8AK/SQxK3NkJ/T
 NKilL67IXr0ODs7M98KnpwlD3W2gqPFejsOUfBdBqZTw52YvUUNPOcCESXTgs2TD45Uzx6V4J6
 z0kgthdBVLhFicHLU2lcqvcLlfILme3T0nONA+DlaeWJm7Hsb6oyM5GWhRYsHk/4768Po3glsw
 RRIDByrfwwLspxhoUqFvNKFEMdg97Ecmm3bPgAropLmAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736156119; l=3650;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=YGyhI3ibxONQXkrTkbZWzt/1Y114BL7USqH/I4T8Su0=;
 b=MPhH9JDuX3z6wJgtJpHELNcyYU9xGU1sejeP14eU+ULr66pp3pyLpVAdMkZu/HfKiw35RyqeK
 exSJkZJu8VxB+vDMrryeoU0SP3+VuAj3fragtmW19uuGaNjL1ZE3dX9
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

Test logs with manual sync of 6.13-rc5 DTS from Linux: 
https://gist.github.com/manorit2001/a9ab219307499efb3704185f336cc658

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
* Udit
- Change the copyright year
- Change !defined(CONFIG_ARM64) to defined(CONFIG_CPU_V7R)
- Fix the JTAG detection code to not break other SoCs

- Link to v1: https://lore.kernel.org/r/20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com

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
 arch/arm/dts/k3-j784s4-ddr.dtsi              | 13246 ++++++++-----------------
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi       |    75 +
 arch/arm/dts/k3-j784s4-j742s2-ddr.dtsi       |  4446 +++++++++
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
 19 files changed, 18007 insertions(+), 8951 deletions(-)
---
base-commit: ec9263b4f15c4cf82eb6a211c67baa6385065b8e
change-id: 20241119-b4-upstream-j742s2-6c9b944b7091

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

