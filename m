Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C666F43834
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E40F84129;
	Wed, 15 Apr 2026 17:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="onfByP/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0C783936; Wed, 15 Apr 2026 17:22:10 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F3383936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds04x6Ixmwl1kTdgt7VRheVshLnpX+fuLwOef4tukkAK7EeMR2TrUwXyufD0QYD8LWbECh2cYM9ozgaB7RRa1QG41jnxNx1QHkZZgBK7EBpuxcd82/9ulL4blQmJLL04wrxgWMBIa2wJrngwmebNySmErVQjUs7CzRz8/w27HS53oSaxiQjVQo9eiHEomyWvPIHFuWEcuJuU0p6o++GNsHfRIcXOobuU6DHdgcCxfa8nULVWiz/tsFvVDRBniy09zM+IF2o8lBOqsrIjJbVk0XZ74crbzo1B0rdyP0W+e2LJA5IdWotZEnW0KI9zE+jugaIv4FOl/5DfmsF9awbRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I7y/hoO7ZtSNVVPnq9LvFkza7T1GzvADNSljoN05DQ=;
 b=Y7WYVykNWkUYCqScpQPL5XxJ3L8dkxLk/4yLeTVvvbkKFPLmp/CaJZ35Xxi47yA9hKDRz37RaEkD45KWOJohKKJOFuRtTnTleLxpR+L45vPxzB/YW4gOUf3kZOvqHE/tnPmUs4JhTERuANFe1tTueuGlIVUbQlynp9n0on0UCKF5DwDBl/AcVc5KuFLJxRx71AKnEFbdzue8W2o70Enyrp/yPvpKy30Mydyd9cWfZUEzNhtUPCnX7aXRZ8Cai8SKxEC5To/GepBUS0Hk8KFul+B0jsiER9lEnUzOwlHT795TjUtBtiZoNWT5EVIBxFHLa+bcIYmlf6weR/EesZz5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I7y/hoO7ZtSNVVPnq9LvFkza7T1GzvADNSljoN05DQ=;
 b=onfByP/D53sIbjmYSuiH0LTBVN+qNiKYJHW3/12yMXAyWPcEV203IuVvyFyfcEtlM74DYDcNrbsjE/KzIy4ERQen6Z5LJr78MXCdOouEsYSb4rG80UkZ5pvgoY643d36HBTBRDRepAIRk0eAU+R53C8j+hRhhfmvCXJjohDxj4A=
Received: from CYZPR14CA0047.namprd14.prod.outlook.com (2603:10b6:930:a0::29)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:22:04 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::e4) by CYZPR14CA0047.outlook.office365.com
 (2603:10b6:930:a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 15:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:22:04 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:03 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 10:22:03 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FFM0ui2222771;
 Wed, 15 Apr 2026 10:22:00 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <bb@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <gehariprasath@ti.com>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 0/3] j721s2: j784s4: Add workaround for errata i2437
Date: Wed, 15 Apr 2026 20:51:49 +0530
Message-ID: <20260415152152.3048491-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd3a545-8f5a-4ea5-3663-08de9b02bfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: iJsMDFBMIWGdqGuls75mZI4uQhk794Qjd54XKOmCjP+GllfOSbfZjHwJq3AL7KFslhHb4p572NeFBmv3VVRkUGkPVQtRbHO/WzZWf5kGDRBiZD+OLEYOWIhaY11jTE57G8tBB0WFqI9LhQtWwc/pvTy1tw9XOVFwUtuU4duY+xmLZCQsJaFuBkEt9kMGmhgFO+58DrL8XSlY+9qdqzcxdmC3/kqJPNiMqJmJpj7CValg7S/spwUtXAdNnrqwHZU2ZnFtj2VwUtN22ifnVvKWFQ0+8YyhlPLJv/bh9C/hwiUBEFnDDfnn3uK9vccaeawBySGLq6J8u4gYAa89yH8vl8y0snxlXrIGkoP56bTlRGrM77hz1X/0pQR5d0bNy3f2tEVFzQ7vC8/BMemDH1IZaYsN6l5XRFRE14KNW6UuvJ8cExGrX3DxENmGhVbOWEyLXMI2dbPPYpxwDEHj9pZ+3/E3R2wlSit2XkZZbMfjG4R1QilV0XZaTKNIdkoiH3r5W/dBiXic3OasOp5vb2Wu2QVVoxU2qWAEp2RUM+iNsb7pVxTCNgYKzDL38OG0rId4vBJO6nsI2knmRGAZJFQSh8WiZ8q+N2tQ0vUdC3Ey//Uz1bNyx1FBYiTqg1SH+3/1ZkW6Tp9ab+2av6gBdWxrfKJaJQUrj0F7mipjn4ri6u8RFxibIv25/Yd18I2SIoYbEY2S+UFB+R4A1rShfO9muiwkor6zp4xPwFnGoWJ88Hr/4pq6Oqy6GCXUQFNmt08ePIxsVIMODM1PGx+8p1DsYQ1VvjKpMNsUEpbn9dVa2hs=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w5n3cIh3brB9w9/vgU+ONjMTTSRKtPMPpUkNEkbeCUmXGxVyEf0jGrABgGbBfyoPf8AzxhXKIps/yY9vapF49ioidsR+joOtyCKDnRlqawf37F/gVN2ZgeyWk3FCRTsaAoF7mNo9PbqMJ3/w8YnzX2GHz0dcG0iTC15CAuOUdUCK+f4rFpVuN8TPgqOEyALyxB0GKpBNEO+7NB/9itheG8gTjmKZeLyCp9iEaJy+mcJrEzRK007n2VuZMAqkLE4H43ZzEo7HCPAEKG/iDABvmoTKBo0Brb4UsU0fzVw5ChTFnjE5ssfeUVVoYEm51sFifUToF89H8CZYczqAA+LpKGnS36ATotQ/tSURPTgbF/NETZHv1Wt8TSPa5oIopT3ZX/OSCzz4ULFuM+XSbnwxsrwq5Vu5P5Gx0PxoHgy2pjmLYl9IAzjynWOB08an+mL8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:22:04.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3a545-8f5a-4ea5-3663-08de9b02bfb2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
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

Add a necessary hardware errata workaround for J721S2 and J784S4.

Bootlogs
https://gist.github.com/uditkumarti/da2a489a78d3241ecd2791c9df1c1317

Changelog:
Changes in v2:
1- Added verified macro (this is new patch)
2- updated macro from ERRATA2437 to ERRATA_2437
3- instead of using hardcoded write, used verified write macro

Link to v1:
https://lore.kernel.org/u-boot/20251106063929.2232788-1-n-francis@ti.com/

Neha Malcom Francis (2):
  arch: mach-k3: j721s2_init: Add workaround for errata i2437
  arch: mach-k3: j784s4_init: Add workaround for errata i2437

Udit Kumar (1):
  arm: mach-k3: arm: mach-k3: Add writel_verify macro for register write
    verification

 arch/arm/mach-k3/include/mach/hardware.h | 10 ++++++
 arch/arm/mach-k3/j721s2/j721s2_init.c    | 39 ++++++++++++++++++++++++
 arch/arm/mach-k3/j784s4/j784s4_init.c    | 39 ++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

-- 
2.34.1

