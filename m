Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406ADC5475B
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 03:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D9B87F7A;
	Mon,  4 Mar 2024 04:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TmrpQNV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E0B87F6A; Mon,  4 Mar 2024 04:11:20 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E2D87F70
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 04:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+uPA8XQRf2+GImI6NuWytPOeZeoq9EPfd359A6PdmZo2Kz7ViZ0fmo8awjwNh4UxlgSuhPcSAnoOXc80XXncDGdM21/8QHBs0zlmm3Zv/o86MhYoSaVcgmLqUpYGa17bgrl+ts7xniWulPzB7MiPHN4cn7h4ygAyCuvQyQ36Pm9Iik7v2Bx8TspRc+geSQkxoQWuaI8cxxGGNhVv2WgpuDDycLfXfloueluBVCMMtsptmoDpcfax88KK3bnpVNzwQLKRcOkkZMROdL0mqC6lt74K955CBOp9v5gnwip7ejQN9NY22FxZXb4yCGSSA5LhkV3QMphbDY76PCX2moehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/eETCWpMhixn05iorcQbxqBkZHeeWH6F1IEN8zfICs=;
 b=enZLG8BlVGGuAew6bPOTW0truzQwfvRLbKsM4xQ7spo4BtrpMGnys2izxV/dFt0bSVLSgxO1bYHBNIaNvH+S2THF3ormsBwSuJ2xEU1laBlGv0Zmd97jGTv+uWXNf/EFAix2o4XQMzg5Da4yvtU0qVCcD9KW8FRtEGFdNbL682G1eD9R78iWIMrkq8krBSHAG9rl1TnVIjMz8SyoCRbHshkx6RiLqW9+YQ7zEEbWdFwNPKW0qZhp275/eKd0Z4wpcctfrnThP2RYaiyVcnU8lq8krDmTqV1uq4Je4B2XW9+G9GPOmRZZBBiRwy5iMLyniBDkwoJPhO6GrtCjZ3DFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/eETCWpMhixn05iorcQbxqBkZHeeWH6F1IEN8zfICs=;
 b=TmrpQNV7WhBkmGPlh+bBlsWHOlFc4Tq5iIADVPtR26wNY/zjg3llKh6IhIKcGIBFjytPf+iHc4LujE0JYLpGURTFGsivVtaKwMkY93M1tDbtY3Q+/YCGyBYOu5B/n5D7wyMUMv3Jy4NdzbSkwmp9ahBzpZvxNe371CnzsB32AWQ=
Received: from BYAPR02CA0022.namprd02.prod.outlook.com (2603:10b6:a02:ee::35)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 03:11:13 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c) by BYAPR02CA0022.outlook.office365.com
 (2603:10b6:a02:ee::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 03:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 03:11:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 21:11:11 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sun, 3 Mar 2024 21:11:10 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH v11 8/8] config: xea: Enable the SPI_ADVANCE config option
Date: Mon, 4 Mar 2024 08:40:46 +0530
Message-ID: <20240304031046.25998-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3be6a7-2fb0-4437-0030-08dc3bf8bf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhyCT0+k6odwik+OVVkeB3HiaVi27HDMGLDy6xR96fvJvstDjSpk6ZrRzEG+I8QBJ+o0VwcJe+pw+FlhO82ZkVO4fNvzZwHKEfZRRAwM1spV6S1aW7Qe6VqLxKKvve2xvYUcxEVQ6Vzexl6Yd99710zBOFu4j33+u68ZaDyeZrXTyV3d/Zz9Mo0hCyBTAkYYjgVu3565G5i3oo7l4We7GcZ5zrtTlkAJMd816hDZlt8E6nEM7NRoFT8GUVx5YoOTECeCVGLk9gX+EkkQDzDwumURTzyA6fyj4NXm5fi8rOjYZL/ci1tofipXDdDCaSxrL3bTgMbh/CDJJVQatzhfuSqotnl/+VkOaczgnbX+LnkIe6KoKZOSZ62f79I4IxZ7uQ2LZm1O/WGbLujTkA0iOAnOej/TueXxFnUmleYuojTT/XidGlql9j3UUxWLq8Wa0spTFe5CDrtJjnk4aXXFIB2yj0it8tWAswsmztuHUDG48K+J+mgpo2D96F4QMaI2hU0UbYhj5XtKLG1Eg0ozmkfJKD1H6jw5nQE34cN9UGPnl8yO4Zd+8UMemBLetms9alyEHb99kXjC5gUHkwu4WgVFohcrUMWNVsGQBij1ANsh+9cmGwv4dPwA4jAric3O8NB9THhQh7vcY+tjQ6WiRMCS8KGOtP+mQLkjWhOffdRCBhOMEtrj+bsLdOvVzN9Sg6a2FxUyWM92+xxSatfU+ovlPbf9z6rp56vLB9ESVPCf6uSwqUIzTQPwbbugdVCm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:11:12.4564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3be6a7-2fb0-4437-0030-08dc3bf8bf38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

Disable the config SPI_ADVANCE, as getting the below error
../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in function
`ofnode_get_property':
/u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/imx28_xea_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 64a0561a34..36d3e73d0a 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -122,6 +122,7 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+# CONFIG_SPI_ADVANCE is not set
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
-- 
2.17.1

