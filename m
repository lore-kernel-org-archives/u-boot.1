Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52650CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC598320C;
	Tue,  9 Sep 2025 07:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ClZe7Cov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AACA80422; Tue,  9 Sep 2025 07:34:57 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CB983257
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5895YrM64030248
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757396093;
 bh=nfMSDSI9uTL7W5Ans1SfMyf2lYCVxrwoqxDV6nNHDAQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ClZe7CovPXECSsghUDVGj0W1CEgbs1loQgPTbuBmpVg3sqx4BBPKRgVt06HGQjeRK
 JXqcZLFVEQwe4QxFr5gWA8dTr9w0pOWZQvvgpfz2Cx6WnQ9H6ZKvfkDBh8Mt6vKVrM
 BZYqK5wSexVg7jRUfmUpXyJPMiZUEbiAB6BR0yPQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5895Yr413486491
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 00:34:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 00:34:53 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5895YpUx2100479;
 Tue, 9 Sep 2025 00:34:52 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [RFC PATCH v2 5/5] configs: Introduce configs for the AM62D2-EVM
Date: Tue, 9 Sep 2025 11:04:29 +0530
Message-ID: <20250909053429.444854-6-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909053429.444854-1-p-bhagat@ti.com>
References: <20250909053429.444854-1-p-bhagat@ti.com>
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

Introduce the initial configs, including SD-MMC, UART and OSPI boot
related settings, to serve as a good starting point for the am62d.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 configs/am62dx_evm_a53_defconfig | 22 ++++++++++++++++++++++
 configs/am62dx_evm_r5_defconfig  | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 configs/am62dx_evm_a53_defconfig
 create mode 100644 configs/am62dx_evm_r5_defconfig

diff --git a/configs/am62dx_evm_a53_defconfig b/configs/am62dx_evm_a53_defconfig
new file mode 100644
index 00000000000..302f8c5e936
--- /dev/null
+++ b/configs/am62dx_evm_a53_defconfig
@@ -0,0 +1,22 @@
+#include <configs/am62ax_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_AM62D2_A53_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62d2-evm"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_DFU_SF=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
diff --git a/configs/am62dx_evm_r5_defconfig b/configs/am62dx_evm_r5_defconfig
new file mode 100644
index 00000000000..7a3ecee7ec1
--- /dev/null
+++ b/configs/am62dx_evm_r5_defconfig
@@ -0,0 +1,20 @@
+#include <configs/am62ax_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_AM62D2_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62d2-r5-evm"
+# CONFIG_SPL_DMA is not set
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_SF_DEFAULT_MODE=0
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
-- 
2.34.1

