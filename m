Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA00D0D785
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 13:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35DA89307;
	Fri, 11 Oct 2024 15:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ra7X+OGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91EE892C6; Fri, 11 Oct 2024 15:03:18 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8A6890F7
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BD3BPw058122;
 Fri, 11 Oct 2024 08:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728651791;
 bh=kbLY2G3RpzV0LoagZ4rJns2/DMJPTiLPM+iHE/o7vTU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ra7X+OGGotTwgmIyzjHYZjGEMvdNOJMXcqsGobSe2pbRDPT7MaNmnjbS16VAxpKT5
 sVvZhtfWSer2CFkm3eWcXSuuPExRM01+AoXZ/WzDTd16IEOTOjahYdYFajdUoPIzJT
 OA5LCM/SK6A3mVTAnD64Md7Q+0BpxQRK1/mWWMEA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BD3Bpj009027
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Oct 2024 08:03:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 08:03:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 08:03:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BD2xiB122812;
 Fri, 11 Oct 2024 08:03:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <n-francis@ti.com>, <a-limaye@ti.com>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <marex@denx.de>,
 <john@phrozen.org>, <ansuelsmth@gmail.com>, <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] configs: j7200_evm_a72_defconfig: Enable configs for
 PCI support
Date: Fri, 11 Oct 2024 18:32:58 +0530
Message-ID: <20241011130258.3452687-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241011130258.3452687-1-s-vadapalli@ti.com>
References: <20241011130258.3452687-1-s-vadapalli@ti.com>
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

TI's J7200 SoC has a single instance of PCIe Controller namely PCIe1 which
is a Cadence PCIe Controller. To support PCIe functionality with the PCIe1
instance of PCIe, enable the corresponding configs.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j7200_evm_a72_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 2fbfda5cf8..12745a9adc 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -32,6 +32,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
+CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
@@ -71,6 +72,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
@@ -153,6 +155,9 @@ CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_NVME_PCI=y
+CONFIG_PCI_CONFIG_HOST_BRIDGE=y
+CONFIG_PCIE_CDNS_TI=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
-- 
2.40.1

