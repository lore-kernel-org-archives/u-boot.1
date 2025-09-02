Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74E1CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7602583ACE;
	Tue,  2 Sep 2025 11:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l0m6wbZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47ED83A6A; Tue,  2 Sep 2025 08:07:26 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B23A83A1A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 08:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58267M5g2519352
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 01:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756793242;
 bh=cTpCfsb52+qL4k/5xsrW5VbpTqlfwZGoBz1inbj26GY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l0m6wbZC+AV+AbOQ+j5zS/2CC1AYrDdMPPiPWWnG9ELC/LEoQQexTvn67hYS8yDVe
 bHkAl9lZuheRvV+MFV+YKuwwmiainOHr1twzkFRGiI/Mbeo71qM98ksgNI/CJBngJ+
 62kIwrkogdaGTJTyXLv6tXMnljsA/yqW+megbTqk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58267Mjx2067876
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 2 Sep 2025 01:07:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 01:07:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 01:07:22 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58267LdZ3604272;
 Tue, 2 Sep 2025 01:07:21 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [RFC PATCH 4/5] arch: mach-k3: Introduce support for AM62D2-EVM
Date: Tue, 2 Sep 2025 11:37:02 +0530
Message-ID: <20250902060703.191688-5-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902060703.191688-1-p-bhagat@ti.com>
References: <20250902060703.191688-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:12:53 +0200
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

