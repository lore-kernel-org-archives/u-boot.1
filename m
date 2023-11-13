Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F336C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDE78718D;
	Mon, 13 Nov 2023 15:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G7A4n25D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC3287154; Mon, 13 Nov 2023 15:52:00 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679988707C
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEppZe018982;
 Mon, 13 Nov 2023 08:51:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887111;
 bh=4pmhdxLjY3C8VUKUEEFvaP6zA4QqwAXJS9/QKmQi0u0=;
 h=From:To:CC:Subject:Date;
 b=G7A4n25DdEnVVezuTUhsDivEUcf8XXJFtzfonQ00HQH+bkLAAvHrWyK6AvjVRQVwS
 EpKECIW1AoMMAJA549advl8wuvQqIrJ8F231pklOh5UAetDMkPw/f6XF/A5Rz8lL7h
 UCbwfYHwmshkMi6wST5vGOl8OWGIrbqJhrUBgMLc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEpprI013526
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:51:51 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:51:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:51:50 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEpopA034730;
 Mon, 13 Nov 2023 08:51:50 -0600
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/8] arm: dts: am62a: Update to kernel v6.7-rc1
Date: Mon, 13 Nov 2023 08:51:41 -0600
Message-ID: <20231113145149.1926732-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Hi,

Please find the series to do the following:
a) Update kernel dts to v6.7-rc1
b) Enable networking
c) switch to stdboot.
d) Add documentation for the AM62A platform.

Bootlog: https://gist.github.com/nmenon/f1d8d9bf79aefc0938a745d3bf5b2d9f

Baseline: master da2e3196e4dc Merge patch series "arm: dts: k3-am6: Fix Ethernet/DMA"

Jai Luthra (1):
  doc: board: ti: Add AM62A documentation

Nishanth Menon (6):
  arm: mach-k3: am62a: Add main_timer0 id to the dev list
  arm: dts: k3-am62a*: Sync with kernel v6.7-rc1
  configs: am62ax_evm_a53_defconfig: Enable networking
  board: ti: am62ax: env: Use default findfdt
  board: ti: am62ax: env: Set the boot_targets
  configs: am62ax_evm_a53_defconfig: switch to stdboot

Vignesh Raghavendra (1):
  dma: ti: k3-udma: Introduce DMA support for the am62ax

 arch/arm/dts/k3-am62a-main.dtsi       | 585 +++++++++++++++++++++++++-
 arch/arm/dts/k3-am62a-mcu.dtsi        | 131 ++++++
 arch/arm/dts/k3-am62a-thermal.dtsi    |  47 +++
 arch/arm/dts/k3-am62a-wakeup.dtsi     |  21 +-
 arch/arm/dts/k3-am62a.dtsi            |   5 +-
 arch/arm/dts/k3-am62a7-r5-sk.dts      |  74 +---
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 139 ++++--
 arch/arm/dts/k3-am62a7-sk.dts         | 347 ++++++++++++++-
 arch/arm/dts/k3-am62a7.dtsi           |   3 +-
 arch/arm/mach-k3/am62ax/dev-data.c    |   1 +
 board/ti/am62ax/am62ax.env            |   6 +-
 configs/am62ax_evm_a53_defconfig      |  12 +-
 doc/board/ti/am62ax_sk.rst            | 213 ++++++++++
 doc/board/ti/k3.rst                   |   1 +
 drivers/dma/ti/Makefile               |   1 +
 drivers/dma/ti/k3-psil-am62a.c        | 196 +++++++++
 drivers/dma/ti/k3-psil-priv.h         |   1 +
 drivers/dma/ti/k3-psil.c              |   2 +
 18 files changed, 1650 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62a-thermal.dtsi
 create mode 100644 doc/board/ti/am62ax_sk.rst
 create mode 100644 drivers/dma/ti/k3-psil-am62a.c

-- 
2.40.0

