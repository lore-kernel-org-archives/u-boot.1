Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B3AE75435
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B25087206;
	Tue,  3 Oct 2023 10:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jWfGvZ7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B323A87228; Tue,  3 Oct 2023 10:10:50 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FF986BE1
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938AkMO046994;
 Tue, 3 Oct 2023 03:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320646;
 bh=j0Ohd2K6m+8rCfhOaNLAOT0Ljuo4Fcy60BoND1hNOpE=;
 h=From:To:CC:Subject:Date;
 b=jWfGvZ7UEmAYRRDtdN3z8Y76ypS+ipl8J9GsrGhF5d6ecswE3ah4Iqkb+fATrzrXN
 Sg1NsDLCAOcgcwanRpB82irdCMnIQxhu/5wDhU2vEM/Ariv17xnvZixOQTK+U3rfFM
 phrYRmE7KnlTUbaNCv2tx5sUexctezdfCVSIHHIM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938AkUZ031811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:10:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:10:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:10:46 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEA110453;
 Tue, 3 Oct 2023 03:10:44 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 00/10] arm: dts: j7200/j721s2: Enable the ESM and PMIC ESM
Date: Tue, 3 Oct 2023 13:40:28 +0530
Message-ID: <20231003081038.24299-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This patch series is RFC. This is enabling ESM/PMIC_ESM modules
needed for watchdog functionality.

Keerthy (10):
  arm64: dts: ti: k3-j721s2: Add ESM instances
  arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
  arm: dts: k3-j721s2-r5-common-proc-board: Add ESM PMIC and dependent
    nodes
  arm64: dts: ti: k3-j721e: Add MCU domain ESM instance
  board: ti: j721e: Initialize MCU ESM
  board: ti: j721s2: Initialize the ESM & PMIC ESM
  configs: j721s2_evm_r5_defconfig: Enable ESM & PMIC ESM configs
  arm: dts: k3-j7200-r5-common-proc-board: Add PMIC ESM node
  configs: j7200_evm_r5_defconfig: Enable the ESM configs
  board: ti: j721e: Enable ESM initialization for J7200

 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |  7 ++++
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 14 +++++++
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  7 ++++
 arch/arm/dts/k3-j721s2-main.dtsi              |  7 ++++
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi        | 14 +++++++
 .../dts/k3-j721s2-r5-common-proc-board.dts    | 39 +++++++++++++++++++
 board/ti/j721e/evm.c                          | 11 +++++-
 board/ti/j721s2/evm.c                         | 27 +++++++++++++
 configs/j7200_evm_r5_defconfig                |  2 +
 configs/j721s2_evm_r5_defconfig               |  7 ++++
 10 files changed, 133 insertions(+), 2 deletions(-)

-- 
2.17.1

