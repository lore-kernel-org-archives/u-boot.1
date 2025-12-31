Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519FDEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66CA8410C;
	Wed, 31 Dec 2025 18:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OgEXWIdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D3B840DE; Wed, 31 Dec 2025 18:36:51 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3C284109
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDR4CuWqTzoCMOrM2Kx16ubCBaX3X3HbrTjmqdtTjlG6XRqcswli+QPIE6YYDPm2VYtmVK+DoDHlVrm2yzxtRNK93K64d2Ufy69mscDAQ1o0up26ZZtdXpSRkkuM5tCmcr/gDw7C4kn1ZQMDZVFOuPXTmZQ+l4ett3iIIAoOfwHNJbh3DNARq3wMIvoPuQZf79L0lrr+gHKFO0O/uBocbnYq3XbYtSdSBJm3mgbK6mGO4G0o1FeGGIXlqMICP2+Wz9Hept/+Aoy+20MLDiQp1TfjldcG0ghPjTH4aD87UiSFY3ZaZw6nkFs/tXdKdR+c53woMJ4Tl/W+uj/JCtQSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJwTLsrL6VThUca9k6DoIAEdCCYToRa1FkJOpypAPPk=;
 b=YdHvUZYOZTGEAoK5yaEOcM7z+njNyokO3kxD2mIxzoE6azcm0e9TlsPPLSbsNTyBgySCNToVT85/St1yxBjk8t/4Egu/g3mF65mwHK4m4eij7XKboIhSi46EgoTXxwyW6qOIsQRmuEPNOyeMKQibUL93BMfXqtk4QmgRqyTuq6C2v3l5wq83i2rpVPN7MkLpYYEL57m0aGRXYURSrUNwVBoBH69Rihj+JGfFGQRCHGuW7aq/Cu70KevIKW1Ji07O4P7ppJC4OgzE0tqE92XQJ/E9XAXVgt7+Fa6R0yhbTtm7nxFqwFvi82mzu+7CGjgbiVcHqkuDcYwsBllrfhLcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJwTLsrL6VThUca9k6DoIAEdCCYToRa1FkJOpypAPPk=;
 b=OgEXWIdcT3DG0gaSFAknNdNHSEYUS/+LHbrb2arPG+JtjGgJoW8z2k2ax99G61v0U+IyAchnbr01XT7+o7YBi2HiOtTDS0l6XVJVIRLmkHHhAOdgE3aHscCcQ7KuQi4BZDivV4o03j9mzhG1l+2PwySjEaurPjZ9C00XAlEM1es=
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 17:36:45 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::bd) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Wed,
 31 Dec 2025 17:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:44 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:43 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:43 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqt2541396;
 Wed, 31 Dec 2025 11:36:40 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 04/11] arm: mach-k3: Add config option for packaging HSM
 firmware
Date: Wed, 31 Dec 2025 23:06:14 +0530
Message-ID: <20251231173621.1069988-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c0f212-03f9-4a29-5728-08de48932a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVDFfbPyJBuUkS7fWQNprMmG05Howjya6wSFAejRgIIWEU+jin7vv4/a3KE4?=
 =?us-ascii?Q?sfmlQHL/KiVIemDSnnoFwSawqfHYbyxOXRNANCs6a97D5XfC/BvCsayKOtGR?=
 =?us-ascii?Q?5/N3VtzqJaeEyGyJLZacCFMRrbA1j1r7I4oydxeJCn5BnDyD3HklSkglgpOx?=
 =?us-ascii?Q?ePhd4V1nm6Cfwn7LwwMaUjZyoxRwJGSjzYJCz9OWcvt2TZT+GWd26oEBlJxk?=
 =?us-ascii?Q?gkQcezRttaLA12Bv0TZGUPUVEUF1lCj8i5mv0qLtNgWS+PLkU6qNHI8UE6fJ?=
 =?us-ascii?Q?cW1KwZsHT+NJYEHFSOnR0l5msrtUpyvceI95gzyXgsRGIceEh96ixJ8Sv4SB?=
 =?us-ascii?Q?DnxepETiKHWuNB4tZtYl+mgwqu5eVsnKlm3gHcqSaMIs1s3rPXWf9uADzgVQ?=
 =?us-ascii?Q?9UHGRWZRTbOwRLCCjj8Fqr1MCZ/t1v2yAfSMaW1DyVO3uUo5L1Ouv+wTFMGu?=
 =?us-ascii?Q?pmz2sSRiY6AWlYaYJnX5UqSjfVq2HardGqBEPdc8mY4EIdbp6IKj6ujqzu+/?=
 =?us-ascii?Q?rtKYGVntVxpt3+TGgUP7HW1NVDR5MWcaEdGhAtMPtxyWEIpLHtmuf6ac51vx?=
 =?us-ascii?Q?2xzfYMaFHqnt0flpSZoElPf2waWOJTt2fpySW2jw+l+EtdEGBA+1f3x0/sDW?=
 =?us-ascii?Q?i0kqw1+CJgBQzFjng3QXa5BMU3TttDRT9fetUlcOlT7uWvAvbnmG+/8mfAm3?=
 =?us-ascii?Q?Z1vtK8l7+6Cj1Nij+RvexQtBCtJBBsvs7IvLZQ0bavCyDmjq0wDwEljiCxfp?=
 =?us-ascii?Q?XdCdwTyTLbC03CbQOLy9yHd7m0TdystPV1FWH2HCdcl2ybO96Ol98bXcz5Or?=
 =?us-ascii?Q?VW7nX/ew1QeaQL1Vf1jCj40hAK60DBxL+Po9I80IYv0YWEUZdia40tdfKHTT?=
 =?us-ascii?Q?GUKMvfSoz/tg8O9YGfF4UqsPTl9Tv61QMoVlHDtZg/uhkcy1jkWpkiu1pAnt?=
 =?us-ascii?Q?Sbjjx6iOyTLOGELBHAu+o4/+zaKWZ1MNb4/W58BEULRfd/1Ij+j6ZFV0O8hp?=
 =?us-ascii?Q?BTZ8qDteN6nBefpY+eitVwe35kzEyYSYCiDpiLyP/9uVW1URJfD6njsqB5Jw?=
 =?us-ascii?Q?3TlMCK7kMwlFEfjrDO0E3y+9QJys3ujQoE1DekXmSygI9XJBK/F/mO3MchkK?=
 =?us-ascii?Q?Ww3d5SYxJTEZDj5A2Szgh4n54yjyvAa1eRWCkzpU2TQEkOIzYf0RFFTedOz4?=
 =?us-ascii?Q?BQd2Vn7wDM0U+VcoFI70SqsEP98PmR2exwaV/llihp2Rl24rOmL/sMT3lXf9?=
 =?us-ascii?Q?fv6cSj4eAmtV5/GOsVCogvSobc8j7z8hEAdECfB3no+9EIHt5wVR3J7o6rcD?=
 =?us-ascii?Q?4o/KJ1tA/YZ/04n/RK68PYoVPl0Z1ITWx7eeHwClIBvThEZ7rEdGbrsbuN+e?=
 =?us-ascii?Q?4/neDK+iz6e6bLSNyGYTL9T5KntKubnX1JtEiKa5AiakYWVA938Pxgf/nwwg?=
 =?us-ascii?Q?hjBI1ldOpwQIcDsvxzmTuAtj6Yh6qcOsvfBYYdT8Pk9whH5UJvU1CZcriw68?=
 =?us-ascii?Q?XTTYM8lDpyHYbtclF6feokuFHsmiw+Kg93fwaclJahegD0y6ymJDAws6cuOu?=
 =?us-ascii?Q?hnv5XpXl2f/e8gosSEgK9N2ZAw6NZcb/drgNCrVf?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:44.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c0f212-03f9-4a29-5728-08de48932a9f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
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
index 1b8c0b1eb96..33666c1e97f 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -181,6 +181,13 @@ config K3_REMOTEPROC_PRU
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

