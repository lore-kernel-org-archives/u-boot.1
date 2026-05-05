Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10220CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 06:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545BA84683;
	Tue,  5 May 2026 08:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQVs25tI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87925846A1; Tue,  5 May 2026 08:34:24 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A5DE8467E
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JV82rMfnMeLCnFuW+Q6cJjEvhEc6Xm9rKcQX8/tA8c3XJ1Nd/m3rrbOUQgic66Lv1nALZ8JDIj7OvCfhUMXxAZDn8LIEGW3EC1PKhVvWq5JO10DXK4Q7tPGeQ3V1IIDF9Z6oLm4e/NN+dtXFS9abSY+d/dHOeACe4xwAjySjbuHvcWz/OGhlKju9la0F7COxMCeVgV1F5OElerJNghBZJPMMbIIe2b3sKxLxDvZ17eUQeJXEyx+MYZg2Eyl4cB2gluXe4sKVN1A29622p3FpDGBJXTYnmbeELs3kiht71UaivazeXga11wMm9IgFlQDHwBfJwRETQw/THbd4/b1j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKLOkUAAvlLwlt2WzIr1pNhNYldO1fZvGCgHavDcxcg=;
 b=lQZXDUlmcLIl2oM0CfVrwTmGHfgjWh1LdRmN3eBMdm4lPTDYwg5CiepYkGoKVz1j/kgNruvwe8mWPwfnNQHWnEQiHLHbx3/YOYjuTiI9VEKhOssSCVwTQQD9JYuSRuUseAKda2t5U24gCSB4Grje8dIk+dxmxqq5WCd52yppaNyByN3tXcCiU09vzGzefInFM/eu5/pX2mc3jVxha337qPBD65kz8WcPp/0UuKR4SHCOB9CL+3GEqwohfwLz5caHhOdj/Gy4QVijxNPXDQRvGTOjkEfSqIEscEzHVjGy3dHIiB7sQI5+EmzERryGGAsLVrohWUnPqeqo3gbMIXSiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKLOkUAAvlLwlt2WzIr1pNhNYldO1fZvGCgHavDcxcg=;
 b=AQVs25tIudzJY0suHwlNSDT2s3jg/4kvT+H6M1wM5kx1oJuEyDPQWRojG7r6zoN3lL6ptIMjdZ0m0DljyKaE0LwYHhgnzxxrXA/DehxcnAFRXRWBBOgFjSAFKKLsjGKWjSkgm4co374HajLx5IHo/Nt6KWL+Q+LKKGtu534fMPE=
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:34:17 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::d7) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 06:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 06:34:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 01:34:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 23:34:14 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 01:34:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <michael.srba@seznam.cz>
CC: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Martin Herren
 <sputnik@on-the-web.ch>, Padmarao Begari <padmarao.begari@amd.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Enable SPL_REMAKE_ELF support
Date: Tue, 5 May 2026 08:34:07 +0200
Message-ID: <aa144c8002ba86154dcb62624a1d9d7cbe8c2cdf.1777962845.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+y6aJC0rnll/3kOfl+NOpvD9K4NiSFdZ9T29bjQyEog=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+7E9oF9nTdeNAS5hDf7FUUYXO/fYTbUr388V3Kj/Yt
 IL5XBFTRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExEOZ6RYYpN7kPPDfv8qt6w
 fLtv+6lYwifi5MGS+TcfLjDSDOKddJmR4ZaQfOPZB9dCDrp4H/5wucnDtyRdh2V3w/GaR50rYnr
 V2AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 999dadbb-2aaa-4b9b-9733-08deaa70550d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kRDoT1yvJph72mKOnJdZ4SOXXbicYwyFMUKo0jgYdmj5bkanYXwG4cn4Uc9G6RDD3HErGznPF8wHdgvKGXGXicCh3eydzPOcsMLjQfkPXEuulVMqVOtUVLmZa+tVmsx1JpUHh34xFrCHNwGkqtcwkdXea9DkEZCPzu3EIkH6X71Ng+szXXnl9OC9Nlbm6BHVrJVUxMy40VLwKkqkY6pWud4rQVP9SEUi7nDhaV2li+R//Y+t3nQMFC99nV4a4Am7PPk4e68o+kpfiZhTmksak3hCI9GjzQ4HXH5KWT0ftMSejv92PuT1J6pkz2L+XHM+xZjibsZ1PtOiInPsc848vN633I+BGX5z7IgCyuM0uO+8l3nTmMugoXmh/7CQrnaBSEM64WWL3CuLdTJufK8rgruTyEZfVL2bwyTUSJ9I5HkAJeQrMtbwXAID0zOFajeh42rYbasdl5BKPP/Ie6Lg5d62+AhLgV1l/5p21riqwvcgjlBYwUBLVsrTinlRXf5VZdLvmUS3hdYX3sz+jAvN9FHBVLcQ5qSzv9QGWBZBePliwJ/kuVv/KbttuF92ImhenBWHFXWel1nSnwtK8ckM0lJwyPndjQ71liEFj+17OV5yckXrMVsvM8Qccj7xafD0i1Lm0Jmp8eOXLiMH6mOdDaW3Y+0BUCPHVH9aLiIQ1rfaIRHLKfRp2GIjiMDY62e93nZDiGiGLK3N+RSCJfmcclkSMMwDJKZE5CWUY2Yyqw0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IvuR72uovDTV312LrQU2q6N9HzIBaz9R/vF/hZMXTjYaoQZLM3KGpemHKE4YKu1Tp1lZ23Dzq4GfXDW9xlYXEdhB2/PvSjZjs/G9Cm4w6QUsi/SAsg6VsijpTy5KaSjao8phANlyQOU/o9Cf0ok9lOvOkpYjqvZDUz7XZBQBM3p2gS1igQkpMTYwb3iceXLVo4kGHkeOpAtMwwQ+1fT9NAvk2KEHx7Hs6xRKCI/5NPtmufDNxqS1oiOPxMEG2UXO7h2mHDbX5rwNXRYaON99ea3QRjeXqWRLByBuKy28ycmBW+AyaYZLP/qILdBVKQndphgyu7TkdjtsCGVDZ9nEDV+3DvyOZNFATbDGHzbRtCz1GMGWstOaXKmnb83vTbV+I9ZW2bQWxC573rdryATemaDxktXgZlu30E5I4zm+7yIPR4apFxAlw9jFV5k+POny
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:34:17.2862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999dadbb-2aaa-4b9b-9733-08deaa70550d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
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

From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

For MicroBlaze-V SPI boot, the u-boot-spl.elf should be embedded into
the BRAM (Block RAM) of bitstream or rcdo. This requires SPL_REMAKE_ELF
to be enabled so that the SPL ELF is generated during the build.

Enable SPL_REMAKE_ELF for MB-V devices to support this flow.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 4ff3bd6b6875..0f88826687ff 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
+CONFIG_SPL_REMAKE_ELF=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
-- 
2.43.0

base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
