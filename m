Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D32CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57313831B4;
	Tue,  9 Sep 2025 07:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cMdqA7Se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E080830B4; Tue,  9 Sep 2025 07:34:50 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C01180422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5895Ylm0215509
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757396087;
 bh=cTpCfsb52+qL4k/5xsrW5VbpTqlfwZGoBz1inbj26GY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cMdqA7Se4GqJ0xNnjGIxTJ9ztOMycub6VqfSL/x8IF2uMZdjWMuWOEsSA0k6VLLpW
 2RGDUKT4d0Wv8p5SseNk6SLzYvd483tr3WIyUMRuv3MSfPPTE1NY7NlGOQD1y4ktbF
 YV2knNU8VVKGpZr0WtN8eoSgp+X30uGIr3rthTgM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5895Yls4122888
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 00:34:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 00:34:46 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5895YjAf1800534;
 Tue, 9 Sep 2025 00:34:46 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [RFC PATCH v2 3/5] arch: mach-k3: Introduce support for AM62D2-EVM
Date: Tue, 9 Sep 2025 11:04:27 +0530
Message-ID: <20250909053429.444854-4-p-bhagat@ti.com>
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

Introduce the basic functions and definitions needed to properly
initialize TI's AM62D2-EVM.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/am62ax/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index f8cdcdca57a..e7ab299fe5d 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -50,9 +50,34 @@ config TARGET_PHYCORE_AM62AX_R5
 	select BINMAN
 	imply SYS_K3_SPL_ATF
 
+config TARGET_AM62D2_A53_EVM
+	bool "TI K3 based AM62D2 EVM running on A53"
+	select ARM64
+	select BINMAN
+	imply BOARD
+	imply SPL_BOARD
+	imply TI_I2C_BOARD_DETECT
+
+config TARGET_AM62D2_R5_EVM
+	bool "TI K3 based AM62D2 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
+
 endchoice
 
+if TARGET_AM62A7_A53_EVM || TARGET_AM62A7_R5_EVM
 source "board/ti/am62ax/Kconfig"
 source "board/phytec/phycore_am62ax/Kconfig"
+endif
 
+if TARGET_AM62D2_A53_EVM || TARGET_AM62D2_R5_EVM
+source "board/ti/am62dx/Kconfig"
+endif
 endif
-- 
2.34.1

