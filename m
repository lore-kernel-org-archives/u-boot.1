Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A079C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AC6800D7;
	Mon,  2 Jun 2025 16:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EMkYqPVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955688006D; Mon,  2 Jun 2025 16:50:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1CB82A8B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552EoW1p3227601;
 Mon, 2 Jun 2025 09:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748875832;
 bh=laVBBZlIuO4us69SFeJGRElqdQmGixJkHSx0zdSHiag=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EMkYqPVLyx46cCect+5hLpDRxoS34gJtGxJ1ibF8q5H2vcTKFxskEDQsbWu3IwURP
 bH2cLcxpUxKMx7AEOyQX0HCQTYXTqG0gmy3u+6t6xFiIebtHmxclyihmZdQxEsQqoL
 pqY2XClUc7oHsfNsmGpoiomVppC7C71efMnI/BMQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552EoWY7677930
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 09:50:32 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 09:50:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 09:50:31 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552EoGpN3118869;
 Mon, 2 Jun 2025 09:50:29 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 4/4] board: ti: j7*: Add firmware for MCU R5 core1
Date: Mon, 2 Jun 2025 20:20:15 +0530
Message-ID: <20250602145015.1274726-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602145015.1274726-1-b-padhi@ti.com>
References: <20250602145015.1274726-1-b-padhi@ti.com>
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

Link the default firmware in the environment variable for MCU R5 core1
for all J7 platforms.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 board/ti/j7200/j7200.env   | 2 +-
 board/ti/j721e/j721e.env   | 2 +-
 board/ti/j721s2/j721s2.env | 2 +-
 board/ti/j784s4/j784s4.env | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/ti/j7200/j7200.env b/board/ti/j7200/j7200.env
index 6cc92bf0d8d..292fc72fd58 100644
--- a/board/ti/j7200/j7200.env
+++ b/board/ti/j7200/j7200.env
@@ -36,5 +36,5 @@ main_cpsw0_qsgmii_phyinit=
 #endif
 
 #if CONFIG_TARGET_J7200_A72_EVM
-rproc_fw_binaries=2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
+rproc_fw_binaries= 1 /lib/firmware/j7200-mcu-r5f0_1-fw 2 /lib/firmware/j7200-main-r5f0_0-fw 3 /lib/firmware/j7200-main-r5f0_1-fw
 #endif
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index e5b4225b3ce..ead7fbdb212 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -38,5 +38,5 @@ main_cpsw0_qsgmii_phyinit=
 #endif
 
 #if CONFIG_TARGET_J721E_A72_EVM
-rproc_fw_binaries=2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
+rproc_fw_binaries= 1 /lib/firmware/j7-mcu-r5f0_1-fw 2 /lib/firmware/j7-main-r5f0_0-fw 3 /lib/firmware/j7-main-r5f0_1-fw 4 /lib/firmware/j7-main-r5f1_0-fw 5 /lib/firmware/j7-main-r5f1_1-fw 6 /lib/firmware/j7-c66_0-fw 7 /lib/firmware/j7-c66_1-fw 8 /lib/firmware/j7-c71_0-fw
 #endif
diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index a6b22550809..abd4faea6ee 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -24,6 +24,6 @@ name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
 #endif
 rd_spec=-
 
-rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
+rproc_fw_binaries= 1 /lib/firmware/j721s2-mcu-r5f0_1-fw 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
 
 
diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
index 9e1741be424..2f1a5f549d1 100644
--- a/board/ti/j784s4/j784s4.env
+++ b/board/ti/j784s4/j784s4.env
@@ -21,7 +21,7 @@ bootdir=/boot
 rd_spec=-
 
 #if CONFIG_TARGET_J784S4_A72_EVM
-rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
+rproc_fw_binaries= 1 /lib/firmware/j784s4-mcu-r5f0_1-fw 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
 #elif CONFIG_TARGET_J742S2_A72_EVM
-rproc_fw_binaries= 2 /lib/firmware/j742s2-main-r5f0_0-fw 3 /lib/firmware/j742s2-main-r5f0_1-fw 4 /lib/firmware/j742s2-main-r5f1_0-fw 5 /lib/firmware/j742s2-main-r5f1_1-fw 6 /lib/firmware/j742s2-main-r5f2_0-fw 7 /lib/firmware/j742s2-main-r5f2_1-fw 8 /lib/firmware/j742s2-c71_0-fw 9 /lib/firmware/j742s2-c71_1-fw 10 /lib/firmware/j742s2-c71_2-fw
+rproc_fw_binaries= 1 /lib/firmware/j742s2-mcu-r5f0_1-fw 2 /lib/firmware/j742s2-main-r5f0_0-fw 3 /lib/firmware/j742s2-main-r5f0_1-fw 4 /lib/firmware/j742s2-main-r5f1_0-fw 5 /lib/firmware/j742s2-main-r5f1_1-fw 6 /lib/firmware/j742s2-main-r5f2_0-fw 7 /lib/firmware/j742s2-main-r5f2_1-fw 8 /lib/firmware/j742s2-c71_0-fw 9 /lib/firmware/j742s2-c71_1-fw 10 /lib/firmware/j742s2-c71_2-fw
 #endif
-- 
2.34.1

