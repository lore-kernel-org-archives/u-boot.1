Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5567C36001
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C403881B42;
	Thu, 20 Mar 2025 07:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ITTpXyTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D142D8141E; Thu, 20 Mar 2025 07:30:23 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAE081B4B
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6UJaN3144347
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Mar 2025 01:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742452219;
 bh=JJNNwZpqN4oKnUFp/mp4ZhMdRLQaLvjIMf1YVIEUCbU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ITTpXyTK4nK7jN5ajt12yszkR9GEY0yiXhXu2RdQU6RXBY+p2txEcRf8yk+F6GZmV
 ceb7uN7QQU6UKUOvGe9SpPBMPfeTpkyUgjqeuxuQhn3nO+u3AsGaZ34e9Ny7AcTiLM
 qcbu5egc+GOwwEtDm+5VkvDmA+upPDUevFuNX8fY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6UJ9H012687;
 Thu, 20 Mar 2025 01:30:19 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 01:30:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 01:30:18 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6U5Xw055186;
 Thu, 20 Mar 2025 01:30:15 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <s-vadapalli@ti.com>, <vaishnav.a@ti.com>,
 <a-limaye@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
Subject: [PATCH 3/3] configs: j721e_evm_a72_defconfig: Enable MUX_MMIO at SPL
Date: Thu, 20 Mar 2025 12:00:04 +0530
Message-ID: <20250320063004.1069653-4-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320063004.1069653-1-a-dutta@ti.com>
References: <20250320063004.1069653-1-a-dutta@ti.com>
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

MUX_MMIO is required in SPL stage in order to boot hyperflash
successfully. Add configs to enable MUX_MMIO in SPL stage.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 configs/j721e_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 71e6c2061b3..6bc716650cf 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -151,6 +151,7 @@ CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1

