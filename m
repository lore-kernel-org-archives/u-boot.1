Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC4D6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82FB8943C;
	Fri, 29 Nov 2024 13:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OaVzn8et";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA5489392; Fri, 29 Nov 2024 12:32:27 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655DE891AB
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBWCBM083560;
 Fri, 29 Nov 2024 05:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879932;
 bh=Enk2QG+5Rd+5s+sGD670c1gQ3HLTcBuYb5RPjwGHfs8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OaVzn8etomyAH7ECghyUfahHiVkJ+pndXwfBnylYC2OsBsS4QzHn7rxVX5ewGefiZ
 vQAlt6J0yDhp5TpUyCoXlSOcDZgxHDEfx2crSsLzyjQLhuO0ZBYdANW7qjUQPRY+Cd
 6WdJOq2y+BysmjyXI5EvxNaBL3T6z0O7v/YB6b1M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBWCdr040866;
 Fri, 29 Nov 2024 05:32:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:32:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:32:12 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabT106135;
 Fri, 29 Nov 2024 05:32:07 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 6/8] include: configs: j721e_evm: Increase memory offset for
 tiboot3.bin in HyperFlash
Date: Fri, 29 Nov 2024 17:01:34 +0530
Message-ID: <20241129113136.383277-7-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

From: Aswath Govindraju <a-govindraju@ti.com>

The size of J7200 tiboot3.bin is 516KB but the memory reserved for it in
HyperFlash was 512KB. This led to overlap of tiboot3.bin over tispl.bin
region and break in HyperFlash boot mode.

Therefore, fix this by increasing the memory allocated for tiboot3.bin
to 1MB for J7200.

Fixes: cf1d6867f774 ("board: ti: j7200: Introduce support for j7200 build targets")

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/j721e_evm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/configs/j721e_evm.h b/include/configs/j721e_evm.h
index bdf12ee8f7..8512062952 100644
--- a/include/configs/j721e_evm.h
+++ b/include/configs/j721e_evm.h
@@ -15,11 +15,14 @@
 #define CFG_SYS_FLASH_BASE		0x000000000
 
 /* SPL Loader Configuration */
-#if defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J7200_A72_EVM)
+#if defined(CONFIG_TARGET_J721E_A72_EVM)
 #define CFG_SYS_UBOOT_BASE		0x50280000
-/* Image load address in RAM for DFU boot*/
-#else
+#elif defined(CONFIG_TARGET_J7200_A72_EVM)
+#define CFG_SYS_UBOOT_BASE		0x50300000
+#elif defined(CONFIG_TARGET_J721E_R5_EVM)
 #define CFG_SYS_UBOOT_BASE		0x50080000
+#else
+#define CFG_SYS_UBOOT_BASE		0x50100000
 #endif
 
 /**
-- 
2.34.1

