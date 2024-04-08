Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7635CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA05188343;
	Tue,  9 Apr 2024 00:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SoD6RtGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666CC8815E; Tue,  9 Apr 2024 00:32:08 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FFE880F4
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 00:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438MVwkZ107735;
 Mon, 8 Apr 2024 17:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712615518;
 bh=IRrUQ2dSnpCIdRwQpxHjy5Ec15KqC7lFUnKOwEjGKfA=;
 h=From:To:CC:Subject:Date;
 b=SoD6RtGez1x9znynZ+ubI4hgB/nvpGvo5tRyXmUgssx80bqdyotEHWn41oc6gGkYX
 JXockMGBCORvzSSFGnHlhrIjpxBZi0Bdh24KOYuIcV3b7UhbpAucXWoiYSd+2Ki2GL
 y80Ye5LlUa5l4V+nWFEebd3iGaK2sNRsUfc5lrSM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438MVwQG116267
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 17:31:58 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 17:31:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 17:31:57 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438MVvEP081161;
 Mon, 8 Apr 2024 17:31:57 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 00/16] EFI: ti: Enable EFI capsule updates
Date: Mon, 8 Apr 2024 17:31:18 -0500
Message-ID: <20240408223134.165877-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Enable on disk capsule updates, which includes defining the firmware components
(tiboot3, spl, u-boot) and enabling processing of raw capsule updates.

This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
BeaglePlay, J7, and BeagleboneAI.

This series also includes enabling seral flash DFU for AM62 and MMC DFU for
beagleplay, and adding the sysreset controller node for AM62 to enable system
reset.

Changes from v1:
- Added sysfw.itb capsule definition to beagleboneai64
- removed extra commas in structure definitions

Jonathan Humphreys (16):
  board: Define GUIDs for firmware images
  board: am64x: Define capsule update firmware info
  configs: am64x: Enable EFI capsule update
  board: j721e: Define capsule update firmware info
  configs: j721e: Enable EFI capsule update
  board: beagleplay: Define capsule update firmware info
  configs: beagleplay: Enable DFU for MMC
  configs: beagleplay: Enable EFI capsule update
  board: am62px: Define capsule update firmware info
  configs: am62px: Enable EFI capsule update
  configs: am62x: Enable serial flash DFU
  arm: dts: k3-am625-sk-u-boot: Add sysreset-controller node
  board: am62x: Define capsule update firmware info
  configs: am62x: Enable EFI capsule update
  board: beagleboneai64: Define capsule update firmware info
  configs: beagleboneai64: Enable EFI capsule update

 arch/arm/dts/k3-am625-sk-u-boot.dtsi         |  9 +++++
 board/beagle/beagleboneai64/beagleboneai64.c | 38 ++++++++++++++++++++
 board/beagle/beagleplay/beagleplay.c         | 33 +++++++++++++++++
 board/ti/am62px/evm.c                        | 32 +++++++++++++++++
 board/ti/am62x/evm.c                         | 32 +++++++++++++++++
 board/ti/am64x/evm.c                         | 33 +++++++++++++++++
 board/ti/j721e/evm.c                         | 38 ++++++++++++++++++++
 configs/am62px_evm_a53_defconfig             |  2 ++
 configs/am62x_beagleplay_a53_defconfig       |  5 +++
 configs/am62x_evm_a53_defconfig              |  3 ++
 configs/am64x_evm_a53_defconfig              |  2 ++
 configs/j721e_beagleboneai64_a72_defconfig   |  2 ++
 configs/j721e_evm_a72_defconfig              |  2 ++
 include/configs/ti_armv7_common.h            | 17 +++++++++
 14 files changed, 248 insertions(+)

-- 
2.34.1

