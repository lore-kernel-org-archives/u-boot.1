Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6F5C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26B582BBF;
	Mon,  9 Jun 2025 10:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gsryf2YS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B70682BAF; Mon,  9 Jun 2025 10:14:41 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548F082958
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598EbSM1934743;
 Mon, 9 Jun 2025 03:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456877;
 bh=XsCb7sc2/+SM+Y4aHbQvpPrDuwOKNnjrIUiKuqElGT4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Gsryf2YShf9S6cpCDJZinygbuoV4fLXfk4pJWBeTSOX5O4CG+LyZS5qccdxI6/fdO
 3LyG8QYM1P9cpB6zm35v/RbMRDX0uerSHK+AVP/ui2Iix+8Ug0HeX0xEgloT9sRFvj
 YN6+qBgkSgeTM4rz9kHUiQ2nAq9yH92fnMENB/Io=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598EbG04125645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:37 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EUSx1101082;
 Mon, 9 Jun 2025 03:14:34 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v3 1/4] arm: mach-k3: {am6/j7}*_hardware.h: Expose MCU R5 proc
 and device ids
Date: Mon, 9 Jun 2025 13:44:26 +0530
Message-ID: <20250609081429.1724643-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609081429.1724643-1-b-padhi@ti.com>
References: <20250609081429.1724643-1-b-padhi@ti.com>
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

Currently the MCU R5 processor ids and device ids are only defined for
R5 SPL Stage. Expose these ids always so that A72 SPL can utilize this
information to shutdown MCU R5 Core 1 when booted in Split mode.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/include/mach/am62_hardware.h   | 4 ++--
 arch/arm/mach-k3/include/mach/am62a_hardware.h  | 4 ++--
 arch/arm/mach-k3/include/mach/am62p_hardware.h  | 4 ++--
 arch/arm/mach-k3/include/mach/am64_hardware.h   | 9 +++++----
 arch/arm/mach-k3/include/mach/am6_hardware.h    | 9 +++++----
 arch/arm/mach-k3/include/mach/j721e_hardware.h  | 9 +++++----
 arch/arm/mach-k3/include/mach/j721s2_hardware.h | 9 +++++----
 arch/arm/mach-k3/include/mach/j722s_hardware.h  | 4 ++--
 arch/arm/mach-k3/include/mach/j784s4_hardware.h | 9 +++++----
 9 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index bcbc4821c82..d44342d43d4 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -158,8 +158,8 @@ static inline int k3_has_gpu(void)
 
 static const u32 put_device_ids[] = {};
 
-static const u32 put_core_ids[] = {};
-
 #endif
 
+static const u32 put_core_ids[] = {};
+
 #endif /* __ASM_ARCH_AM62_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index cd61abe0185..f3fd736f31b 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -90,8 +90,8 @@
 
 static const u32 put_device_ids[] = {};
 
-static const u32 put_core_ids[] = {};
-
 #endif
 
+static const u32 put_core_ids[] = {};
+
 #endif /* __ASM_ARCH_AM62A_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
index 95af5c5c547..a310b52b45d 100644
--- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -141,8 +141,8 @@ static inline int k3_get_a53_max_frequency(void)
 
 static const u32 put_device_ids[] = {};
 
-static const u32 put_core_ids[] = {};
-
 #endif
 
+static const u32 put_core_ids[] = {};
+
 #endif /* __ASM_ARCH_AM62P_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
index 44df887d5df..105b42986de 100644
--- a/arch/arm/mach-k3/include/mach/am64_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
@@ -50,19 +50,20 @@
 
 #define AM64X_DEV_RTI8			127
 #define AM64X_DEV_RTI9			128
-#define AM64X_DEV_R5FSS0_CORE0		121
-#define AM64X_DEV_R5FSS0_CORE1		122
 
 static const u32 put_device_ids[] = {
 	AM64X_DEV_RTI9,
 	AM64X_DEV_RTI8,
 };
 
+#endif
+
+#define AM64X_DEV_R5FSS0_CORE0		121
+#define AM64X_DEV_R5FSS0_CORE1		122
+
 static const u32 put_core_ids[] = {
 	AM64X_DEV_R5FSS0_CORE1,
 	AM64X_DEV_R5FSS0_CORE0, /* Handle CPU0 after CPU1 */
 };
 
-#endif
-
 #endif /* __ASM_ARCH_DRA8_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am6_hardware.h b/arch/arm/mach-k3/include/mach/am6_hardware.h
index 9913964c46b..8169584a372 100644
--- a/arch/arm/mach-k3/include/mach/am6_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am6_hardware.h
@@ -43,19 +43,20 @@
 
 #define AM6_DEV_MCU_RTI0			134
 #define AM6_DEV_MCU_RTI1			135
-#define AM6_DEV_MCU_ARMSS0_CPU0			159
-#define AM6_DEV_MCU_ARMSS0_CPU1			245
 
 static const u32 put_device_ids[] = {
 	AM6_DEV_MCU_RTI0,
 	AM6_DEV_MCU_RTI1,
 };
 
+#endif
+
+#define AM6_DEV_MCU_ARMSS0_CPU0			159
+#define AM6_DEV_MCU_ARMSS0_CPU1			245
+
 static const u32 put_core_ids[] = {
 	AM6_DEV_MCU_ARMSS0_CPU1,
 	AM6_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
 };
 
-#endif
-
 #endif /* __ASM_ARCH_AM6_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 2b5ec771e18..5bef309af0a 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -41,19 +41,20 @@
 
 #define J721E_DEV_MCU_RTI0			262
 #define J721E_DEV_MCU_RTI1			263
-#define J721E_DEV_MCU_ARMSS0_CPU0		250
-#define J721E_DEV_MCU_ARMSS0_CPU1		251
 
 static const u32 put_device_ids[] = {
 	J721E_DEV_MCU_RTI0,
 	J721E_DEV_MCU_RTI1,
 };
 
+#endif
+
+#define J721E_DEV_MCU_ARMSS0_CPU0		250
+#define J721E_DEV_MCU_ARMSS0_CPU1		251
+
 static const u32 put_core_ids[] = {
 	J721E_DEV_MCU_ARMSS0_CPU1,
 	J721E_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
 };
 
-#endif
-
 #endif /* __ASM_ARCH_J721E_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
index 8daea82a77e..82f076a45e0 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
@@ -41,19 +41,20 @@
 
 #define J721S2_DEV_MCU_RTI0			295
 #define J721S2_DEV_MCU_RTI1			296
-#define J721S2_DEV_MCU_ARMSS0_CPU0		284
-#define J721S2_DEV_MCU_ARMSS0_CPU1		285
 
 static const u32 put_device_ids[] = {
 	J721S2_DEV_MCU_RTI0,
 	J721S2_DEV_MCU_RTI1,
 };
 
+#endif
+
+#define J721S2_DEV_MCU_ARMSS0_CPU0		284
+#define J721S2_DEV_MCU_ARMSS0_CPU1		285
+
 static const u32 put_core_ids[] = {
 	J721S2_DEV_MCU_ARMSS0_CPU1,
 	J721S2_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
 };
 
-#endif
-
 #endif /* __ASM_ARCH_J721S2_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j722s_hardware.h b/arch/arm/mach-k3/include/mach/j722s_hardware.h
index 8d0bec22068..0c695134c28 100644
--- a/arch/arm/mach-k3/include/mach/j722s_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j722s_hardware.h
@@ -76,8 +76,8 @@
 
 static const u32 put_device_ids[] = {};
 
-static const u32 put_core_ids[] = {};
-
 #endif
 
+static const u32 put_core_ids[] = {};
+
 #endif /* __ASM_ARCH_J722S_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 0ffe238cdae..29a894baed3 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -41,19 +41,20 @@
 
 #define J784S4_DEV_MCU_RTI0			367
 #define J784S4_DEV_MCU_RTI1			368
-#define J784S4_DEV_MCU_ARMSS0_CPU0		346
-#define J784S4_DEV_MCU_ARMSS0_CPU1		347
 
 static const u32 put_device_ids[] = {
 	J784S4_DEV_MCU_RTI0,
 	J784S4_DEV_MCU_RTI1,
 };
 
+#endif
+
+#define J784S4_DEV_MCU_ARMSS0_CPU0		346
+#define J784S4_DEV_MCU_ARMSS0_CPU1		347
+
 static const u32 put_core_ids[] = {
 	J784S4_DEV_MCU_ARMSS0_CPU1,
 	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
 };
 
-#endif
-
 #endif /* __ASM_ARCH_J784S4_HARDWARE_H */
-- 
2.34.1

