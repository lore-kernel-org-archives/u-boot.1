Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CB3C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088C788B2A;
	Mon, 26 Aug 2024 12:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QOkO+prE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D485688AB1; Mon, 26 Aug 2024 12:25:51 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836C088ABA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPZC7001365;
 Mon, 26 Aug 2024 05:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667935;
 bh=50tGib5J4oxo6Qym+UU0xjKLNV7lH+AkrxpKDiUyerg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QOkO+prEcFE0r6X9FMPTjhIdq0ytRgaNB0CSQumEKuqg96A8l8NweGm3JkmoUzAdr
 6A2vpKuE8do9f1+ISkvdp5LSG8uuDYDzPwvWoOBtwRI0j7Ay8iv8mR9wdiGPzvbVNS
 olL3ih1+v/086+97567bBRoDMFdSvtgyNpnJHTD4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPZDi024885
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:34 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPXgW041860;
 Mon, 26 Aug 2024 05:25:34 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I
 <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, "Chintan
 Vankar" <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v6 08/11] configs: am62: Add configs for enabling ETHBOOT in
 R5SPL
Date: Mon, 26 Aug 2024 15:55:12 +0530
Message-ID: <20240826102515.2774296-9-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826102515.2774296-1-c-vankar@ti.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
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

Link to v5:
https://lore.kernel.org/r/20240813105400.4054657-8-c-vankar@ti.com/

Changes from v5 to v6:
- No changes.

 configs/am62x_evm_r5_ethboot_defconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 configs/am62x_evm_r5_ethboot_defconfig

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..0d823743907
--- /dev/null
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -0,0 +1,25 @@
+#include<configs/am62x_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_DEFAULT_DEVICEC_TREE="k3-am625-r5-sk"
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_BSS_MAX_SIZE=0X3100
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

