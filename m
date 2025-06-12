Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D550C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924CD82C84;
	Thu, 12 Jun 2025 10:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FXgqGlmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839FE82C67; Thu, 12 Jun 2025 10:55:59 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7215B80050
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C8tpYq2823482;
 Thu, 12 Jun 2025 03:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749718551;
 bh=HycGtoVFMzcS/KeEgIBy38o6FpcSubNSk3M1MbGVPGc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FXgqGlmiard2xk0CYpU+JL57EN74JNa0z6rULd90MPr0jd0LrigakXzghzdktbS8a
 sF+CvHm8rpyyCgn/eTv8xmmjvqpHPDXnl+tYDWw1HXishhX++DZe7IlZHYdGF2MF6n
 wmvNJ+Q44YdKJRC0xQAu1ilYfXnRA2s4xOAf+LAc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C8to7G1682833
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 03:55:50 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 03:55:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 03:55:50 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C8tZ471737313;
 Thu, 12 Jun 2025 03:55:46 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <jm@ti.com>, <s-k6@ti.com>,
 <quentin.schulz@cherry.de>, <afd@ti.com>, <j-humphreys@ti.com>,
 <anshuld@ti.com>, <n-francis@ti.com>, <danishanwar@ti.com>,
 <rogerq@kernel.org>, <w.egorov@phytec.de>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH 2/3] configs: am64x_evm_r5_defconfig: Enable configs for PCIe
 boot
Date: Thu, 12 Jun 2025 14:25:33 +0530
Message-ID: <20250612085534.3457522-3-h-salunke@ti.com>
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
and it supports PCIe boot. Enable configs options for PCIe boot.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/am64x_evm_r5_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index b222bcd6e43..ddf6e0cb606 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -56,9 +56,17 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NET_VCI_STRING="AM64X U-Boot R5 SPL"
+CONFIG_SPL_PCI_ENDPOINT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_PCI_DFU=y
+CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x80800000
+CONFIG_PCI_DFU_BAR_SIZE=0x400000
+CONFIG_PCI_DFU_MAGIC_WORD=0xdeadbeee
+CONFIG_PCI_DFU_VENDOR_ID=0x104c
+CONFIG_PCI_DFU_DEVICE_ID=0xb010
+CONFIG_PCI_DFU_BOOT_PHASE="tiboot3.bin"
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -119,6 +127,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PCIE_CDNS_TI_EP=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_SIERRA=y
-- 
2.34.1

