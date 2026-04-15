Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48AF43832
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A587384119;
	Wed, 15 Apr 2026 17:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IzXHukuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E245A841B9; Wed, 15 Apr 2026 17:22:12 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDF384119
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJCQr6RFL3M83CNkOI3+sq4fV5rK07eOI8/uUgqHpA05vlFTKlAL07e2O1EDk897tWbCWC0VHt0bBvBHMQZfi1dr8MOHdlCP3Z2MMDvmuEZoSz3PI6GNVUihdUcTORRzVfPScQepepwGCNlfe2qykTuQi4JvNBSHYHf4Uqm+eJz9RY+utDrlGAsIDPu4efMCjQmXmsSUaLPMzqSis/YPAzfM7LHhY7tJ9L0QgmvwA22dfYsiPIBZg5BqwTbo7+xwAlaJ6Nrs1a4LbFe8TmzSQOxhYhOs+t209ujI0t6lQedq7TjkzaMn32vxRE8bosQhiBsLJdSq9N3D1hJCRKinZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Qf7plybJ2t23QSHb8vCKo9c0H4mXLpgFXOU4TAEXc=;
 b=ebNMzU4nnVybKPQ8lshF1wMxSx5/a7371UaNy8QCPaBQ5rLmpChAAsX1lEcTpBFYMJloEWScHpBQNOjOUtdusxhcHsDXVOFnnMs+/HsyLeOWRTZam3X5fx5JSANjQDRHQ1i8uuQ7XB1C+Sm2sPPqV1q7y2O7fYWTf8tUhJCs2ZFhV40mSdS+tTf5hQQqc5jlt0JHb9GF56kPskvGGZKal2gZ69xJY2nwHIQY2sajfbaDY+BfNA6d5XGaLA7ayT+/BfNRfIkE9fZx48npI5L1VBPAJBQbRG7rpgRdltLHHl0qqEkScv1OPRRx1flRIySL6zBSEyXdI9WG/BuxdJhmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Qf7plybJ2t23QSHb8vCKo9c0H4mXLpgFXOU4TAEXc=;
 b=IzXHukuUfwmdeDIMcE64kmoPfatdZMf3yFG9Jic7+7AYxU25uq9NnE3kXSfEx/FAKNz+jgoMi1BjKJE/DvwGqU/OFq9yhDhnjjyqbTDQBTvXEMAwcZ3+BWnVmzmtqjzDCcBm+Hjgy2fYRx3lBNO6TbSXKCoivH01o5vR/AvGiCo=
Received: from PH1PEPF00013314.namprd07.prod.outlook.com (2603:10b6:518:1::6)
 by DS0PR10MB997603.namprd10.prod.outlook.com (2603:10b6:8:314::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 15:22:07 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF00013314.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 15:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:22:07 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:06 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 10:22:06 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FFM0uj2222771;
 Wed, 15 Apr 2026 10:22:03 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <bb@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <gehariprasath@ti.com>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 1/3] arm: mach-k3: arm: mach-k3: Add writel_verify macro
 for register write verification
Date: Wed, 15 Apr 2026 20:51:50 +0530
Message-ID: <20260415152152.3048491-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415152152.3048491-1-u-kumar1@ti.com>
References: <20260415152152.3048491-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS0PR10MB997603:EE_
X-MS-Office365-Filtering-Correlation-Id: fea9189a-f2fa-4933-ddad-08de9b02c189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: A0x5txkKXlqsdxgeh5iiXSY5VSRt1BFM4eQFmQP8YgebjGBA14b4JiSwJG3MO2lWPttt7TQIlkDVSREemLihNrYUnuEcAxZV/jcLm+QK8YyYbj0YQsH31kxdU7v5kE0UZkooktGUxXKn9aMNCGja9Y3tSfEUkTEmNvvNeoetmezKibWc3ftkJKpS6AWo4ARbDNokqmXXTUtbVVUrDmNjsngZ2QXK8EJ2yKtzmgpLhdl9jnwgoB3h3cyPmOUB1WbHgdZ8Wv5yE+an7M0dM1I3lRENW1VWAFs1eLw3Og/ZsW/kWpjRB5ffMNhtQwWVJLAk1K4PqS1wsAtOPEts9hvQ9PFBZTMoCSiicAGFrsFFW9BblIeT7oOkJmpAvB+x4UAg+tMg8sN28ihM5gpeL4k9kGeNTv5V4RiNnWEs+LCUWUnaSwTjaN+t5yKffEdnrlkdE0s/6efq9BmG9GN1XB/NllQ6tlrSxnhmamXEDLEWrZxCtfy77g5xsvHGIgfblnTGk065hZbp+nDdZgGLf1P1Ro4OORXV/plL8i013X/iyzkhUM42MiVQz0Wg3O26iTt31QLHCWKKTyjzBmTHvg/qIkouHfxDdtviBj78pchDzyggX4dSrahV7OMK2djdqjqbhzWfawJSAuy8deUInhBgXddYw7eMyRIDgBNLkplccBhypPbKGKAxhEfVWEokG4q4bXvt3iC5wL+ZigZPzVEDrxCwk72kew6VFbpVbm6ujzrKSaCJ0R4mf6za2V0fxIEHL4a12r0q7h/Q7ldz+4Zuag==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8QasytWIXOymeamJMTGufccPMTbtHP0+X3ghqzHgNOmASjWnj+MzIkc22EhaZkRos4xr7zSDb1HSxR3kH4A6sgaOsF2xrAcliWpU4TSfwTuBzHKAKKqMCl0iXDFQjaV7ujRo4J9FHM1Wi2AU1XRAV/ZUD4FOm5o0VCocchLilFLAgNPcgwsl4t1nPq9Ld6hTLFn3Bc1yzLrFDOo8lJoBE86IPvoMNVAxrrOR35EUSOBjd9x5TTORHu5tv2NdPgiDtYOX4Y9ZPeykBWXR509g6H5aR8Pgocx7tZjVOkXMU8lF4HCPsaICk7LczkFOZuxkpaLtXyFv7rPPRVm4aWZqdteZQ7vXItaAJH0gKvL++ZuTuQcDh8FU8GK4l7fJyGbPn4bvmEWuUaEBOZFAS6N0TH3pbP8knGLbdleJWx6eWWOSdNUErzV/U1A5O+XF39wE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:22:07.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea9189a-f2fa-4933-ddad-08de9b02c189
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997603
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

Add a helper macro to write and verify a 32-bit value to a memory-mapped
register. This is essential for hardware errata workarounds that require
confirmation that register writes have taken effect before proceeding with
initialization.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 81b5f1fa45e..b337a71956f 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -126,4 +126,14 @@ struct rom_extended_boot_data {
 
 u32 get_boot_device(void);
 const char *get_reset_reason(void);
+
+#define writel_verify(val, addr) \
+do { \
+	u32 readback; \
+	writel(val, addr); \
+	readback = readl(addr); \
+	if (readback != val) \
+		printf("writel_verify failed: addr=0x%p, expected=0x%x, got=0x%x\n", \
+		       (void *)(addr), (val), readback); \
+} while (0)
 #endif /* _ASM_ARCH_HARDWARE_H_ */
-- 
2.34.1

