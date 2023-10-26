Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E824C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 06:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252B987B09;
	Thu, 26 Oct 2023 08:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFLoKrpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B0287AEB; Thu, 26 Oct 2023 08:34:44 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E61487B17
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHaPxgTeto1jcDyWWvsUjDxW6nrscp2cAy/4c6+ODsdUIViBmVF+w6lE4tvlBmCTxthvu4zfYUlvhjcbtogDnYjrqPimchsee3iIUphRA6QO1Gfh03um7RxCq8SOeHCbAr3jp8f6RfSGySKglxm0V/+x6tC/6KJGmkmMxGAD8vnATcu7eEJz3Rq5kEiCMXYFN4sV8nb58NmsQp8z5wWY5Sd4aJtEX6Sy0K5RdNesb6hyAI43HdLBAZq+nI5ZXV7yGyHoqsCUygZfYphRum6vkfKOD1T+DRAtmysfxQOppIfOAMXp0G4V2z9xHuPZkMJOFMvujj1FHyOTmW+s+2xaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJRfPLCnqYtgRDkPlz+qq/Dj0mp5IpMBZMCm9VYypV0=;
 b=hgm0rmhQDucMz6L2n1DsUOysoOVwo+65rqOs8b6dqYYHHIXu4l4dc8XoCKxu6dK9/o77phnzuW7OFuUbojRAbtaLEi7s1/VJo8PTJNiJzfBtzoros8xfmYGvz51lp1JUBHURD/KTYgYOZIQMb7Pkg2HSbGJHdpvEBdLBO3QvSnxfiAHtvlLFF5G5f69Yib2MDB5nISu81dLj0IjzSL0e0Bc22NCUDB5qhvLmMkL6pFPCogZ0K3kaHAUM/tChkF3maIp58qv8N4zskH0G5TSwK+7a1CEEggyThU3gvarYdFPq7vM+Fxrf6phCoeAR4CzyArzk/igShYW/mzreWy3Bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJRfPLCnqYtgRDkPlz+qq/Dj0mp5IpMBZMCm9VYypV0=;
 b=JFLoKrpt2GCGIW7ffIWZuzhXCNM6NYUmqyWuncNzaX4/YYepnsc8fNLRgJ2J7gCcAWecnh5gjNgoFNx1Ck8Gui2/cJHOszKRaKa1ouQgjdfXdJ2W/GESu/riNFLpPlfeDwgKpr4nk4RLZYA+nC4Lwl4eRdDrVhRgBVqOqtM9Fco=
Received: from DM6PR02CA0050.namprd02.prod.outlook.com (2603:10b6:5:177::27)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 06:34:36 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::a5) by DM6PR02CA0050.outlook.office365.com
 (2603:10b6:5:177::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 06:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 06:34:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 01:34:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Fix Kconfig entry indentation
Date: Thu, 26 Oct 2023 08:34:31 +0200
Message-ID: <ff28e719de82258c066f1fedae87f88597f367b5.1698302068.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9tz2lWCQYl8buCVyZSvpBdix4CpBB7tHGuISbCwlnxg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQrjtJ1VXbByl8ElSdUBbC6T6ieqxmTZ9mg3LXoxvrOH
 G39i9s6YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwER+fWWYZ/x+/i6NuG1zPHkD
 dJP+Pt7UG/chmWG+y41pb67scdrMXOPz61dJlF9nTAMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: d989cb93-6fb4-437c-7e1b-08dbd5ed9eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAoj8OtPsjVcItcJUlsedUr+KzuyDUY4dZ6b80OrIGK+7pkIY9OytjO24iOoixiOtyUmLnWQwM00kXb0++vmqiqSVXcjA0fiBP5vr7ulKQ279OPF4T4hAkB2x/Yn4GoD7+91ioutyNT0m2zcHooffgfZssD396QV4SvlxwAgupUeTUVbj3gDZv6SxbixHNtBR2UVI6avq5LQSlDUkVu2wx1ea7We524H2Ka+IDUF6UKSrIIrrDFU+hOQeBTHJJKX+Le4fzHR6s0FDdS25IO6D7oRVdM4DQCeQwoPxastOZ2DLKNO6Y7NY1xNhoA91fs/UO9EeOthzGU8+HmFfv3FtqL0uC2Tv3WSToPrj1YUI1yxSzs7qlMqOsHCST4Xdik/1srLhJSPJXT/pdlNITm4amV//4hEX7SzTor+jWHopyC3RtHVmLv+dFg/fblauK6pgRhyXRuNkR42Bd8EVAyDn0XZKetk3H4TfbkEL8X6eM20ZXHE1qLpNKKvvimk8iuOnd5JV8pQNRem1zrcSlz2DwAcQyH/V0qyBRD/c5c8Zilsq9a8Bo5GpHPSz9ABxGQmJ2XCEYoobvoqmO4ucKBOmIXH648PEl9C2NPEg98g0/hKoXCzRVf7j1nU/GvXxRBpruwRJPAHsZYi2e945nzQpktZ2tB0JsGVbmbFjlacu3z1AZ3o9J+K4akeYNoct3x4klJKYS6TZHLHGctgveUzFnOll6VuMypBKYFdjYW1CODUceYewwprdj3PP1SZpfaLiNQ1X9U2jJP2PmlUIxOJQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(26005)(41300700001)(2906002)(44832011)(40460700003)(36756003)(5660300002)(86362001)(8676002)(8936002)(478600001)(2616005)(36860700001)(356005)(16526019)(82740400003)(70206006)(70586007)(110136005)(83380400001)(40480700001)(336012)(316002)(81166007)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 06:34:34.8910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d989cb93-6fb4-437c-7e1b-08dbd5ed9eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
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

Use tabs instead of space for entry indentation which is standard coding
style.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 26b80b7882c8..7e7c87d16fa9 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -100,30 +100,30 @@ config SPL_ZYNQMP_DRAM_ECC_INIT
 config SPL_ZYNQMP_DRAM_BANK1_BASE
 	depends on SPL_ZYNQMP_DRAM_ECC_INIT
 	hex "DRAM Bank1 address"
-       default 0x00000000
-       help
-         Start address of DRAM ECC bank1
+	default 0x00000000
+	help
+	  Start address of DRAM ECC bank1
 
 config SPL_ZYNQMP_DRAM_BANK1_LEN
 	depends on SPL_ZYNQMP_DRAM_ECC_INIT
 	hex "DRAM Bank1 size"
-       default 0x80000000
-       help
-         Size in bytes of the DRAM ECC bank1
+	default 0x80000000
+	help
+	  Size in bytes of the DRAM ECC bank1
 
 config SPL_ZYNQMP_DRAM_BANK2_BASE
 	depends on SPL_ZYNQMP_DRAM_ECC_INIT
 	hex "DRAM Bank2 address"
-       default 0x800000000
-       help
-         Start address of DRAM ECC bank2
+	default 0x800000000
+	help
+	  Start address of DRAM ECC bank2
 
 config SPL_ZYNQMP_DRAM_BANK2_LEN
 	depends on SPL_ZYNQMP_DRAM_ECC_INIT
 	hex "DRAM Bank2 size"
-       default 0x0
-       help
-         Size in bytes of the DRAM ECC bank2. A null size takes no action.
+	default 0x0
+	help
+	  Size in bytes of the DRAM ECC bank2. A null size takes no action.
 
 config SYS_MALLOC_F_LEN
 	default 0x600
-- 
2.36.1

