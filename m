Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE08EC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 09:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017CF87861;
	Tue,  9 Apr 2024 11:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/S91JQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D7288155; Tue,  9 Apr 2024 11:48:42 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6C98785F
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 11:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWtfQNbOgD+5SP7yKusEHeljfAbZOkuAclYQdp1oEeUo6NiTzoOddQXhLdSjxky1C7p8HkkwzmrqNdc92xzQ9fmDFjlFvLcZ0NRkjijjnmPUNCo209+oAtbkPQU1V5KWtK/J8zBCVJmzPcRg1p6nJGVEuvZRsWpNl4Pt1WPIXa0CKqNJJbAYGaH9HW2XmBcPi6RSvr5zq43k26MDAtqA1RHl3vEb6kYW2wEOK6g4hn7PquaFsg2+r/UFQCkiEE0IkMFHCLo5ToKsn7EcngwHlYLmCpRoMDs2MA+VVMZ0RUXdFWoCtNKYrSSQIeL2XsqTug7eXwokwCUugEC6B1Ve0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCMs4w/9E3vOsRx1naGZx7cJn4HYLDlVBcaII+eDP/Q=;
 b=RciDMRzW3LVhVtAwbvnv3CzgiHP61OoROGL5m8L48v0kJEkjyhr35egBkmrpMYnc7ehZOHCTNNhqSN4IHD3baKMOuC/1CpIBO8xlPx9UjgODUbKjRqEjYYbpfjtnzxNxocOvbAK2R5sTxE+2eT04k30VC+4wsjMQ27JEEHawZUAP0uVYDsJF9OO2Il+CFxu1kYW+N3X/F15MzqOjRdOoZbyOqxWsf8NLAvVwzAtk0onHevZvtHQHoRStk/lZEXEa+QWO+rVncjbaMiehkot8LhGzgP2eToDBAGpz0f5ypnW6y04/UBmvFv4LSkJUTJDsHG1t4ryrNK4YBAZ8BIt8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCMs4w/9E3vOsRx1naGZx7cJn4HYLDlVBcaII+eDP/Q=;
 b=g/S91JQlLr6WElAPKva4VwV+0evZZnfAyMja+icz7ED6goOYGuC0haUFU3LhWCbASalmijKtvAwXQkBtxb9hswR1CBi3KuMet9EmGO53LNsvmUQy+I3o0RPMTlf7P9ZhV+OAH6Pq+m9J+bkJbt1BqOg4ILl17RGl0VtwDrSnLxA=
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Tue, 9 Apr 2024 09:48:36 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::25) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 09:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 09:48:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 04:48:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 04:48:35 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Apr 2024 04:48:33 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH v2] configs: zynqmp_kria: Deactivate CONFIG_SPI_FLASH_BAR
Date: Tue, 9 Apr 2024 15:18:26 +0530
Message-ID: <20240409094826.4131643-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4cabb4-27fb-40ee-40f7-08dc587a3a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51W4wnKnMNCbN8saq9tsArbkCsNVSvPrmoCyaGJ5oBbYgAFBFZjEC75hbpxV8G1on+VtSzrFVqQ/hcMnnqndPixXmpxz8j2+6L00CiOcNEGl+2mwzNuQDReMiv7YlqFdueKLZAnB0F17ym4T69eNcIKZnJkH+AWskWJHUUbKssvac9OT50vTpsyTjXdI7OgttBWqbhzDdiDJhyyE8ZGq4jG5eVDyumHL/5skoJDciikKAnvJ0f8ovhxJXoVARTwV7utr3gHVr38MJ8kHGTz/NqCDGv/5I1LoyaJSWyol03VC5za0KMVgvOHWI7GnzMjBepqDmd5dMwKgUlYCF3nUmaPysU4X1cYxnqQO0qF52Hk433s438WunrM0Lefa4g27fzo6r9fC5o5chAZ9nXYGOHBpQDRj3465KmoflFZNcm5pju6XDSkgmaKIK5XzJ+tMrv5iN8Yin/xSgRetmr+Z9fmir8wcWTnCv87HifOhpmF/1Wva62gIjBZOI39w1uXsQ5xxRPKIdjJPhYM8lFDZOOfrhfEXXFv7sHSpX4+3jhnaVTVeYcwyDFXy49Ur3BygkkFTZ+lsZevsu0CQytk62TDJm1GjKRMwvZT4VzLn4ZN7OenXu3y7poYNSiR7WLUS9Jc9/VR0LP41WaV3kjvUgkV7hBLSJdD/X6bAuZg4ceY6P9e2GbRWUWfQJH+fXfbnwftVnkv8AXWUQX3KuzsyPSWVDXIBy+F97t3bSnXVBzlfIs5y6xBiEDXO1ZhNu97E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 09:48:36.2475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4cabb4-27fb-40ee-40f7-08dc587a3a0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

The Kria board features a recovery application that activates
when the FW_EN button is pressed.
Upon power-up flash operates in 3B mode, However, the recovery
application changes it back to 4B mode.
Currently, after a reset, u-boot activates CONFIG_SPI_FLASH_BAR
and assumes the flash is in 3B mode. However, there's no code
or reset lines connected to the flash that could return it to
3B mode. To resolve this issue, changes were made to disable
CONFIG_SPI_FLASH_BAR, which activates 4-byte opcodes.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
Changes in v2: Updated commit message.

 configs/xilinx_zynqmp_kria_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 7cb8b62d32..7af8b27be9 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -155,7 +155,6 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_DM_MTD=y
-CONFIG_SPI_FLASH_BAR=y
 CONFIG_SPI_FLASH_STMICRO=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
-- 
2.27.0

