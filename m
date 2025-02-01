Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B5C0218A
	for <u-boot@archiver.kernel.org>; Sat,  1 Feb 2025 09:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C888380F92;
	Sat,  1 Feb 2025 10:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n0MMogK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F04C80FBA; Sat,  1 Feb 2025 10:18:38 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8325680FD4
 for <u-boot@lists.denx.de>; Sat,  1 Feb 2025 10:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5119IXwF1855806
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Feb 2025 03:18:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738401513;
 bh=SyigtP0/UblOr1Q37Pbixj+0CFD0+DcV1i0bGL5ok7k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=n0MMogK4pIb5sKj8hVtQ6dMSfImgMUgcbQQPkZAjkaoQ2JqpmshajvgJyIpQ1F/51
 DnS0IemQIsgUPnc1hA/bjSiYAxgdy51dqZy/wMPBlIlweA+XKp+Y1qPPWpqqTujP43
 7QEoHlU9Lo9rS2h7LqKH6PWB/pZNEaVeCldBoqRQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5119IXYn046985
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Feb 2025 03:18:33 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Feb 2025 03:18:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Feb 2025 03:18:32 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5119IAgD096497; 
 Sat, 1 Feb 2025 03:18:14 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <a-limaye@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <a-dutta@ti.com>, <vaishnav.a@ti.com>, <j-humphreys@ti.com>,
 <p-mantena@ti.com>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] configs: j721e_evm_a72_defconfig: Re-enable MUX_MMIO
 at U-Boot proper
Date: Sat, 1 Feb 2025 14:47:59 +0530
Message-ID: <20250201091809.1894892-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250201091809.1894892-1-s-vadapalli@ti.com>
References: <20250201091809.1894892-1-s-vadapalli@ti.com>
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

Commit under Fixes introduced support for Hyperflash boot but also disabled
MUX_MMIO support at U-Boot proper. MUX_MMIO is required at U-Boot proper
to setup the SERDES Lane Mapping as described by the device-tree.

Fix this regression by re-enabling MUX_MMIO.

Fixes: fd7fcd4098d5 ("configs: j721e_evm_*_defconfig: Add configs for Hyperflash boot")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch has been newly introduced in this series and has no v1.

 configs/j721e_evm_a72_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 3928430f16..1ddb1965d8 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -151,7 +151,7 @@ CONFIG_SPI_FLASH_MT35XU=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
-CONFIG_SPL_MUX_MMIO=y
+CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.43.0

