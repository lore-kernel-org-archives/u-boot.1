Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82191C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 10:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F5A80F86;
	Wed, 19 Feb 2025 11:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z0LoByZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A37280EBD; Wed, 19 Feb 2025 11:49:08 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB5B80FB9
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmpDl258799
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 04:48:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739962131;
 bh=J1jKYYx2Dz1h5e3LYgvT5aGbWNqt7p+i7d+KuQDpbwM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Z0LoByZY/GU3O7TDrm5HmAZjmkYW4cQRsDZKQUClhhlRvKOE9cVvJaqhObbVFyuBW
 X8gp/p53CzMmMtJaBENQ35GTyYBtY5k1ua1kS0vtu4LsJLUIc5bk7M17trOWzTKQmb
 1lNaU1LYwrofhHOMxTlNahkJIu9aV3cIyI1fdxUc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JAmpRO013368
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 04:48:51 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 04:48:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 04:48:50 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JAmnt1118851;
 Wed, 19 Feb 2025 04:48:50 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Walle <mwalle@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Santhosh Kumar K <s-k6@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Nishanth Menon <nm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, "Kishon Vijay
 Abraham I" <kishon@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 11/13] configs: am62p: Add configs for enabling ETHBOOT in
 R5SPL
Date: Wed, 19 Feb 2025 16:18:29 +0530
Message-ID: <20250219104831.2315464-12-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219104831.2315464-1-c-vankar@ti.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Andreas Dannenberg <dannenberg@ti.com>

Add configs for enabling ETHBOOT in R5SPL, also disable not required
configs to avoid memory limitation.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20250107093840.2211381-12-c-vankar@ti.com/

Changes from v1 to v2:
- Updated commit message.

 configs/am62px_evm_r5_ethboot_defconfig | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 configs/am62px_evm_r5_ethboot_defconfig

diff --git a/configs/am62px_evm_r5_ethboot_defconfig b/configs/am62px_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..3513d6436f1
--- /dev/null
+++ b/configs/am62px_evm_r5_ethboot_defconfig
@@ -0,0 +1,30 @@
+#include<configs/am62px_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62P5=y
+CONFIG_TARGET_AM62P5_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62p5-r5-sk"
+CONFIG_NET=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62PX U-Boot R5 SPL"
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SYSCON=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_SPL_SPI=n
+CONFIG_SPL_MMC=n
+CONFIG_SPL_MTD_LOAD=n
+CONFIG_SPL_NAND_SPI_SUPPORT=n
+CONFIG_SPL_DM_DEVICE_REMOVE=n
+CONFIG_DM_MTD=n
+CONFIG_MTD_SPI_NAND=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
-- 
2.34.1

