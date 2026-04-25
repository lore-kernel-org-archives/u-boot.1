Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C7CFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDEA84011;
	Sat, 25 Apr 2026 18:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jaIgUFJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A8F8412A; Sat, 25 Apr 2026 18:25:07 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB11083FB0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12)
 by CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 13:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIa4ked+omC2QLpEG90q0c6esIYGIbLRu3AUbxj+dHWO8doYlpevn9CASCEfPoDshCEK4EvoO0YGc1AaYo3zn/Mdw6dVH4GzMkDACTffZgaAvb6My8fT7L1GI0QyW2LEZPrQdORVVY4QS+MGbbVIzCzva50olpT7pEYVHfEc0g+v+0l5g5PI5r2LKHtNQGwW5szZa4Fm67vjVNrOuv9uSSa8Q2M0OBaIxF0C+ZqFU9CvYNTnfJ+fp/PBozqmDfTkmi5dDwxDXclKyYFkOYm4UqesqWUdyj5a3NRPstnSTTkLBRHlADznuKWsg6ezlPyuq+mmNJGqHcT4WlML8z8Bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVUz8jVvyl3aQlbdD2jl6mZPXLfz5fMoty3I2e0mnnA=;
 b=S9tHx/DmUt++t/uxwrgG2/VwNDPNCqliTaPFx7NQjuQhFiRPJjlssO6IJ5RIClURO2ThbpmiZnxxRwusLJeblevmPQx5r6TAopjFfn1DaCBRSYUXFCtSLTisB/ewt0etxvISAjlMLpx+DQRynVbA27BQjUAjjwK3kNEgImiJCImXzXLklxZ0WEXNbVmJMPF7XaiyFYA+a8NLBPWMwAsJ2GBKqRpZK/kzSduN42z5Vrzw0btfrNOMgACf3ZUtPyrRXblG4yhpJBnGQjEreM+QJ1ZE3kvepjhWSs98YdrnrYVg5tmHNOi+d59qF/Mfydc9eC/yrkKk2m5z4eWkmosluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVUz8jVvyl3aQlbdD2jl6mZPXLfz5fMoty3I2e0mnnA=;
 b=jaIgUFJJY2Ob8oNFgyM2SeaduUngVIVkqxmk09gDItSTsym3WAbwmtTlD/GCVWaMXkyfzfaBC6FF8mknVvl76Cbwgi5NgBlrgBhc7FVIfwIOKKoWDsSqHRittTaQ0vjnAWjLSEP3ToUDCk5tzluSvzHXDOyJAgZb/mIN1rlAtEc=
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 03:38:09 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::ab) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 03:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Sat, 25 Apr 2026 03:38:07 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:07 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk832903263; Fri, 24 Apr 2026 22:38:04 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 04/11] arm: mach-k3: Add config option for packaging HSM
 firmware
Date: Sat, 25 Apr 2026 09:07:35 +0530
Message-ID: <20260425033742.1519298-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CO6PR10MB5617:EE_|CH0PR10MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b081270-86b6-4ec8-f8a8-08dea27c111c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 46sucvd0XWtb0XNaWpBSmzcrgA6bwk1NZ6jAqJB4V07ArRoXXkNaAWcx/Iw3KywW3KNk5/RsQyx9URpc2MR2hQq1sP/hGzQa3eYa5rK3BFErqeBrxTGv8rdGVhshokqYMMgqGxCXl1RoCaa1PzbMoowjbPx7ZUyP7AW6+KSxa0IdaWVFZirN/pmPKWI0uy0q++mnBczVuqPLpojaybbxN9EbHBsS/IHcgWzxVB+2u1ksk4EsRZMh9m050D063gcLJZjUGTuthi5FUsZ4uPSJ/LnDwutnWgaTFsWvcMl2RUkBnBK877VjcjFTU08yHLz3dzlGeOzBx4sipkMiXp2YVNR2uhQ7KdweWTT/HDJ+vFNvu+ySPf7Af0bp6cmweHG0A8Gysi8xlsUvqtVlvmw5LccFagCCD3luwbGs3+654FCYIELIyMfS886wvPlFpBJC9IrzvCTKOX/4ovp4vrqqWNk09ey26H+OtgCWs1oLsjXpCeIlkAsdC8VgQxb/qNCs/ampmYIsW5eLiBfgOqqyYZ2vmSRuqyTBs8w34BnlySZYhYPTh8j+2tmvQBHOLZX9+A4ewpy5vNCkvooasHSzhuNyOB9ERMruKEsq+oc4uQ9YM29zyrPQ+Iq6IdUv5zFmrUxKrGk2YeZgu6HO2BNXmmE+6icr8QYqunMeqGt5j860c8+2gCdn4Yr3woOtpAf2e2ZVJz46oc9Z2ELhfzapTgBGQZU0+4ohWMEZFE5s48Aq7ZMX0EHxXyl6O34jehXLt23VuJ5WpIqszfPGnilzTuNgtcTyIkvixgRDHs9MuvI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +rirvC+HZ0ZiWOITlhqcZZ8B4KghDRTc8lJddMGyJeQzQ9AMb0NmTGKGiNB6mB6EfpWwiDf6kkmuxc3A+UfmPsznhdaIe1JsEP04E9Vctre7/SR2p4M26+6Nv+cGv47RgCIWe/gupU0o8eYR9WMMq4aHN+/OXwEyf6FOv+JtF4s1L611tveSXBkMdvPK+2/LbOrrbZBl0GdBrL7D7IITtwUcoWB1soPzl/IS1RzeyAVwX/b8yLPBjUcVol93k19xFyMf3iS1BsW+d1Jt7m7p/bXbHdwc+4ULk1HHgO5uCV8owyGX697xot0wPD48bpeEZSPTfqzBGoY7V0WCC0R8Y99Oa1a/QxZxQgLJ2X5y5Do5YK33LfoOYgETqBtyc70O86JLAfQGIa7gIHL7IhgMixVv0DF0CoY27cIacXHe0zFE66Uc/CgrM8/PJ6X/mm7h
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:07.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b081270-86b6-4ec8-f8a8-08dea27c111c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-OriginatorOrg: ti.com
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

Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
M4F core in the Wakeup Voltage Domain which could be used to run secure
services like Authentication. Add a config option which indicates that
the SoC has a HSM core and the firmware for the core is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-5-b-padhi@ti.com/

v3: Changelog:
1. Updated description of config to match with functionality.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-2-b-padhi@ti.com/

v2: Changelog:
1. Removed 'default = n' line from CONFIG.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-2-b-padhi@ti.com/

 arch/arm/mach-k3/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683..df7290f74e0 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -198,6 +198,13 @@ config K3_REMOTEPROC_PRU
 	imply REMOTEPROC_TI_PRU
 	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
+config K3_HSM_FW
+	bool "Package firmware for HSM core"
+	help
+	  Enabling this will indicate that the system has a HSM (High Security
+	  Module) M4 Core and the firmware for the core is available. When
+	  enabled, the firmware for HSM core will be packaged inside tispl.bin.
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
-- 
2.34.1

