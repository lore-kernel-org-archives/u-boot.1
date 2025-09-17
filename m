Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E983CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 09:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E3E835BF;
	Wed, 17 Sep 2025 11:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="utU8np45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D908357F; Wed, 17 Sep 2025 11:47:11 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DDC8004F
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H9l7Ol222084;
 Wed, 17 Sep 2025 04:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758102427;
 bh=LxzBESrmqGCTufFzmDC2BMDHb+yE6vyFyGTssXiL6Jo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=utU8np45Qu1V/fHlQ4TrebqZFxCJSXbIWo/Q6L0mad5F3yrD6oFVJzgNyV7rNVx+B
 nbyFJE0kHd1xfaPGtAbeoUMoO407iMy0g3egcHGbeG5y4qw4QNvR2N7EaXBzu1qFbq
 hN5sQfIiYF3JS8o5DfQCvX6LOuEFVBa1/tWo1Tqw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H9l7vn1443839
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 17 Sep 2025 04:47:07 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 04:47:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 04:47:07 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H9l0Bw3103753;
 Wed, 17 Sep 2025 04:47:05 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <a-dutta@ti.com>
Subject: [PATCH v4 2/4] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at SPL
Date: Wed, 17 Sep 2025 15:16:57 +0530
Message-ID: <20250917094659.3922343-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917094659.3922343-1-a-dutta@ti.com>
References: <20250917094659.3922343-1-a-dutta@ti.com>
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

Add the HBMC and MUX_MMIO configs in the R5 SPL stage for
successful HBMC boot.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 configs/j721e_evm_r5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index ceb2e273b54..52290722686 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -124,6 +124,7 @@ CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
+CONFIG_HBMC_AM654=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
@@ -133,6 +134,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
-- 
2.34.1

