Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE8CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFC488429;
	Thu,  4 Apr 2024 11:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LkNEnnNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330AE88422; Thu,  4 Apr 2024 11:01:04 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3818841B
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490hEs069953;
 Thu, 4 Apr 2024 04:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221244;
 bh=6mdtkJQLdcTZQyFuNKv5KoNgiGqNOnVdYKmvdPzptQ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LkNEnnNzvringKX+/koUZ2hf86922Wq6eW2YKtTv3oSVM3ds8+tlRINwystS9gEiv
 AbXtLgCHABABirm0C7DKbIoO79uP7TTQFdMKAuUPGwMe8mQdtxA2NaLAV45NBCy70W
 lWm0sbhyDBa8DFDECe0/7v0ofoPl/oJRnqDPT8UY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490hCB022345
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:43 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490gCE057817;
 Thu, 4 Apr 2024 04:00:43 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 02/15] arm: mach-k3: Sort CONFIG_SOC* and K3_SOC_ID entries
Date: Thu, 4 Apr 2024 14:30:26 +0530
Message-ID: <20240404090039.87458-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Sort CONFIG_SOC* and K3_SOC_ID alphabetically.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 37 ++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index af982e70d1..bbe1fe5c80 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -8,37 +8,38 @@
 
 #include <asm/io.h>
 
-#ifdef CONFIG_SOC_K3_AM654
-#include "am6_hardware.h"
+#ifdef CONFIG_SOC_K3_AM625
+#include "am62_hardware.h"
 #endif
 
-#ifdef CONFIG_SOC_K3_J721E
-#include "j721e_hardware.h"
+#ifdef CONFIG_SOC_K3_AM62A7
+#include "am62a_hardware.h"
 #endif
 
-#ifdef CONFIG_SOC_K3_J721S2
-#include "j721s2_hardware.h"
+#ifdef CONFIG_SOC_K3_AM62P5
+#include "am62p_hardware.h"
 #endif
 
 #ifdef CONFIG_SOC_K3_AM642
 #include "am64_hardware.h"
 #endif
 
-#ifdef CONFIG_SOC_K3_AM625
-#include "am62_hardware.h"
+#ifdef CONFIG_SOC_K3_AM654
+#include "am6_hardware.h"
 #endif
 
-#ifdef CONFIG_SOC_K3_AM62A7
-#include "am62a_hardware.h"
+#ifdef CONFIG_SOC_K3_J721E
+#include "j721e_hardware.h"
+#endif
+
+#ifdef CONFIG_SOC_K3_J721S2
+#include "j721s2_hardware.h"
 #endif
 
 #ifdef CONFIG_SOC_K3_J784S4
 #include "j784s4_hardware.h"
 #endif
 
-#ifdef CONFIG_SOC_K3_AM62P5
-#include "am62p_hardware.h"
-#endif
 
 /* Assuming these addresses and definitions stay common across K3 devices */
 #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
@@ -63,14 +64,14 @@ static inline bool soc_is_##id(void) \
 		JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT; \
 	return soc == JTAG_ID_PARTNO_##ID; \
 }
-K3_SOC_ID(am65x, AM65X)
-K3_SOC_ID(j721e, J721E)
-K3_SOC_ID(j7200, J7200)
-K3_SOC_ID(am64x, AM64X)
-K3_SOC_ID(j721s2, J721S2)
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
 K3_SOC_ID(am62px, AM62PX)
+K3_SOC_ID(am64x, AM64X)
+K3_SOC_ID(am65x, AM65X)
+K3_SOC_ID(j7200, J7200)
+K3_SOC_ID(j721e, J721E)
+K3_SOC_ID(j721s2, J721S2)
 
 #define K3_SEC_MGR_SYS_STATUS		0x44234100
 #define SYS_STATUS_DEV_TYPE_SHIFT	0
-- 
2.25.1

