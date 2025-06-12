Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD92C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3208082C49;
	Thu, 12 Jun 2025 10:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YNsRc4m/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7610E82CA4; Thu, 12 Jun 2025 10:56:05 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ADC80050
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C8tuE81620419;
 Thu, 12 Jun 2025 03:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749718556;
 bh=io079ulbiwcmJ24Pxkw+/PK73aeIcX3OJR6ugjlRacU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YNsRc4m/crkGGtFB5kTCus282xKwpkCag89TA4CV7TZuykZ2oASQtITr8Hk/ZPGHg
 KcIBYUys6ALJkWTPY4PVDkTNX7prncAIx0eO2o4Hvsxv7l1pmBpBushi95k2ZVr+Du
 U86iRp9juVP6bttENrh12bHdZ6QCKGKnUrqKth+0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C8ttUr1806655
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 03:55:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 03:55:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Jun 2025 03:55:55 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C8tZ481737313;
 Thu, 12 Jun 2025 03:55:51 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH 3/3] configs: am64x_evm_a53_defconfig: Enable configs for PCIe
 boot
Date: Thu, 12 Jun 2025 14:25:34 +0530
Message-ID: <20250612085534.3457522-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612085534.3457522-1-h-salunke@ti.com>
References: <20250612085534.3457522-1-h-salunke@ti.com>
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

TI's AM64x SoC has a single instance of PCIe Controller namely PCIe0
and it supports PCIe boot. Enable config options for PCIe boot.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/am64x_evm_a53_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 5c3b46d710f..f14caef955d 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -56,9 +56,17 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NET_VCI_STRING="AM64X U-Boot A53 SPL"
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_PCI_DFU_MAGIC_WORD=0xdeadbeee
+CONFIG_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_PCI_DFU_BOOT_PHASE="tispl.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-- 
2.34.1

