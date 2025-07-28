Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE1BC87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECE38338D;
	Mon, 28 Jul 2025 17:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P8ksFVwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B37282E34; Mon, 28 Jul 2025 16:57:17 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596CD82E26
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56SEv0Xk2327970;
 Mon, 28 Jul 2025 09:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753714620;
 bh=hw2ak8+sIhyBB1Mlo+nBa5f/AG1+vzSnX2fgrkSvmXs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=P8ksFVwLN+kp0mZqOjgQz85HaK0d6GW2pclgM9VpgGAXlDwxHZ3dLfT02wQPq+fZS
 jLZRwBb0SVQlaPJ0Y8YnpuHPiMid5agAaHHMrT72Fp81+YS2kKFwuRWa4wkrII4m9W
 W6M4NiDSnJJpj9RNV6EqL8FQ6rBOkogaMHBpbwc8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56SEv0JO2096010
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 28 Jul 2025 09:57:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 28
 Jul 2025 09:56:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 28 Jul 2025 09:56:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 56SEoZuR1924403; Mon, 28 Jul 2025 09:56:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <yegorslists@googlemail.com>, <afd@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <a-nandan@ti.com>, <ggiordano@phytec.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <paulk@sys-base.io>,
 <marek.vasut+renesas@mailbox.org>, <romain.gantois@bootlin.com>,
 <kory.maincent@bootlin.com>, <mkorpershoek@kernel.org>,
 <festevam@gmail.com>, <a-dutta@ti.com>, <ddrokosov@salutedevices.com>,
 <anshuld@ti.com>, <jm@ti.com>, <sjg@chromium.org>, <p-mantena@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>,
 <seanga2@gmail.com>, <kamlesh@ti.com>, <a-shenai@ti.com>,
 <c-vankar@ti.com>, <kishon@ti.com>, <dannenberg@ti.com>,
 <e@freeshell.de>, <h-salunke@ti.com>, <semen.protsenko@linaro.org>,
 <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quentin.schulz@cherry.de>,
 <sumit.garg@kernel.org>, <d.schultz@phytec.de>,
 <emanuele.ghidoli@toradex.com>, <hiago.franco@toradex.com>,
 <joao.goncalves@toradex.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 28/45] configs: j721s2_evm_a72_defconfig: Increase aneg
 timeout to 20000 ms
Date: Mon, 28 Jul 2025 20:20:17 +0530
Message-ID: <20250728145034.225997-29-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728145034.225997-1-s-vadapalli@ti.com>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 28 Jul 2025 17:14:15 +0200
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

Increase the PHY Auto-Negotiation timeout to 20,000 ms from the current
default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.

The motivation for this change is that existing devices will continue
working as-is (timeout is an upper bound and auto-negotiation can be
done earlier), while older Hardware connected to the board that might
occasionally take longer than 4,000 ms for the Auto-Negotiation process
will benefit from an increased timeout.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j721s2_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 8ea9decf15b..318ea362f17 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -140,6 +140,7 @@ CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1

