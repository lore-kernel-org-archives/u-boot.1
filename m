Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBFC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078E088F44;
	Thu, 25 Apr 2024 14:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jm9pJv78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD74088F0D; Thu, 25 Apr 2024 14:09:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B43488F32
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8xbS022856;
 Thu, 25 Apr 2024 07:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714046939;
 bh=DSKteBNt4QaIzkJdigcmhmx7OmrukEhYxxLIRnTyqjs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Jm9pJv781U5qi+wDu2mYEdXN1mfhRl8F7JsQFuzAZC8GLYm0GJoqj+LIe0qnEJIIA
 YhbqOqEGUxcXPRJHE5Mk1JsQmzKZHrOwUCEN+JjdhsQUb7TtyaU0bT0LjT/PklYbbH
 Uh+gj1h3XHQZabC+0+WRFTIvu2kqTPyn5Y2qtiY0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PC8xrS033934
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:08:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:08:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:08:58 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8vl6062054;
 Thu, 25 Apr 2024 07:08:58 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Vignesh Raghavendra <vigneshr@ti.com>, "MD Danish
 Anwar" <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Wadim Egorov <w.egorov@phytec.de>, "Joao
 Paulo Goncalves" <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Chintan Vankar <c-vankar@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Andrew
 Davis" <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 07/10] configs: am62: Add configs for enabling ETHBOOT in
 R5SPL
Date: Thu, 25 Apr 2024 17:38:19 +0530
Message-ID: <20240425120822.2048012-8-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425120822.2048012-1-c-vankar@ti.com>
References: <20240425120822.2048012-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Add configs for enabling ETHBOOT in R5SPL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20240112064759.1801600-9-s-vadapalli@ti.com/

Changes from v1 to v2:
- Removed independent defconfig files for R5 configs and created a config
  fragment for them as suggested by Nishanth.

 configs/am62x_evm_r5_ethboot_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
new file mode 100644
index 0000000000..5100165aa2
--- /dev/null
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -0,0 +1,19 @@
+#include<configs/am62x_evm_r5_defconfig>
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot R5 SPL"
+CONFIG_CMD_DHCP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1

