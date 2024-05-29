Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4084FC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4924885C5;
	Wed, 29 May 2024 15:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HC5MFdHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CAF987EB4; Wed, 29 May 2024 15:25:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF128844E
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOpqi001475;
 Wed, 29 May 2024 08:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716989091;
 bh=RiRlZqcQDT7ahbW3OZa+W4/Dfe3x08/24uLl27c+Pz0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HC5MFdHxNgNH2RJS37L6KLx6QbO7f32SXX61q5+o2tawylOIZYo/Fn7qL1cByAxSI
 L1Bx0eMYWemv4X/xnlgl2w0mfaDUEkBel4EaCqPhJP8VnTA1EaetVhbzCUZhmDphXO
 9JXyFcJvsMhY7qe4NiHw4jiww0ryRaxR+u3fmj/4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TDOpb7068072
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 08:24:51 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 08:24:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 08:24:51 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.102])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOoUg002132;
 Wed, 29 May 2024 08:24:50 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH 01/14] arm: mach-k3: Sort CONFIG_SOC* and K3_SOC_ID entries
Date: Wed, 29 May 2024 18:54:35 +0530
Message-ID: <20240529132448.459330-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529132448.459330-1-j-choudhary@ti.com>
References: <20240529132448.459330-1-j-choudhary@ti.com>
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
index c724450638..c3aaded8dc 100644
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

