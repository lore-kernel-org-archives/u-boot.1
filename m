Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080D3C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAB78794F;
	Fri, 12 Jan 2024 07:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3znAewU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212E58795E; Fri, 12 Jan 2024 07:11:23 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBB586F42
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM9q+UCeJG/Fe7BdfY7/r5SyuUDFaL19V0Hgrl/g7VPcHdw1lE0G6/xfcKH4JBEdEUt0DuT+lE35jtgeTFrVGzH6hS7FKHylNXLJNHRayTQ/EwMlqYstOWi25kT8uj0bYxoozBoOEL22V//Am3YDT1bSSenqC7RxRvUGHd7yEI+loTCK8SB2U53Hq4BDEsXj9gaohIzwkQTnYHDVukVGl5jr1+bDFoBtASliiKDWw77UNxvFh3yK1n7x4hJNrO5kSKlqr3LUPu72pyA7qOrBrsndr9fKLJ9Ujxz6i2L5omqwsEDik1Fl/7RaqbIPwooYuimrXGNH8CP8omI4ERQX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=aRCPrGe4OzODZJk4HUuyoxDy44p3how8znEtAPGnqT03aWNYSUzSvgKUKYSRn4+wHa2P3kvzOV/JsSgV7MnRlyCKTr7RSmPvVM0vBkUVX0XgKL82MaSsWsuJLgXm334SWu+oAxTFjx9h1BncjK2WDpm0fauW3/1FqQjS25iSQvc0rXNGyyvR12oDq/neph9l8WsQilQsftOtCJjAYUkCVceXBbO8oezVolfz4vttzHZaTVLMDgLjVFTMtLlVj9udaRrySS7kNcnN8F1u6D2MNs4m5+uNq2JjqXxtwROdaeZjyEsmrrDk8+/rFUdv7NGgnAmpbN0Ny3WGNDposLuv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QKqfmvC1dgo6J9313x7TjlpLxCHC/SAl7Ai6Bvp/zU=;
 b=3znAewU2gWHhfNdU0qddu6Y8R+m+/sNkcX/ybjQx0MqESH5XBE1wB3S12ws4FOxU5eUfV561Wijqiure/c/meE3gsSwEGaYr1Hr+lv/W63TW82qrUcU1WlMZgaV+ziDfguqIpd9wNFrI1uCpE7dPgr3pcIu5KIti4xIlKTF76xs=
Received: from DM5PR08CA0030.namprd08.prod.outlook.com (2603:10b6:4:60::19) by
 DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Fri, 12 Jan 2024 06:11:17 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::61) by DM5PR08CA0030.outlook.office365.com
 (2603:10b6:4:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 06:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 06:11:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:11:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:11:13 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 00:11:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 2/2] configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP
Date: Fri, 12 Jan 2024 11:40:18 +0530
Message-ID: <20240112061018.3280962-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
References: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a74082-04ba-486c-5279-08dc133549b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAYypbm1AfMYQ2g7xvkniuWV+UU/dJfyuiK6G6Wy+EZj3m6goq2HCCxsrdcDOFoH0DocKaZHVcYKVeHmRf0QAJf3gfK+E/0GFrMMjXzc1TvDbqwEniy1bq+QTP0ck96l4FyrZIN73rcsJg2TdkQFii+dcAMrMe86ztbXxtPXNZS4Ak31t7NCcoYr3DxsHg6gHp8gBeebSspvluucA7pkBov+0uVfYXGrp9IW236oUKLUV4kh9hubLP1vrB0uMZyBBRGC8ujJwQDGOyI8E0fSmkB4Nr5R5wKs54ToN/AlC4QrIlpAB6ny0ZXjUg5dNR6ex4dPegi1iisCpy6/N1ClriiSgLRq17VG7nbPCVzrzJyE1lyFdlDr/7HOH0LGmmyhxyTeKRIyfs9EHLJM+6soR7CYALPue29YRsvl1Zpc+5TehiKmkN/YwZXmkrrmgy8xz8hgKf/qTxH+gO/lgwjSDBgALdyvT5Z82h3NWb7KWuPfa9HDaCigiuMCC3kp+S83AuUIKgIlEU1IBcLzvWIGcKaFah/JSy0h8yCJn7hbYWhowJ0OadJruSsBEOamAShhU0uE5UY71pPX8Zi2EgQB8F4dgqKsc3i0jkeR5ru/LJHVBAwiXgvSMCjW7kQzTMaphPBuL6pbjh28/u8XPQMES05hMXZSAnUYKwd2+AsDqLx3XDVDP7RmPXBFz9bAU96iWYqOkrxSmk3e6Xm3HDqM7U79y3FUuSyt2U2t3whmr4z1+D1LrgSlCndA4ejPGyPrg+tc4qpwjdqVv/9fnr6RMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(47076005)(1076003)(2616005)(336012)(107886003)(26005)(426003)(5660300002)(8676002)(36860700001)(4326008)(82740400003)(41300700001)(2906002)(4744005)(8936002)(6916009)(54906003)(478600001)(316002)(70206006)(70586007)(81166007)(86362001)(36756003)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 06:11:16.9291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a74082-04ba-486c-5279-08dc133549b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

Enable CONFIG_OF_BOARD_SETUP, so we could use ft_board_setup()
to enable the kaslr-seed and pass to kernel.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index a65a59c1ae..86741f1773 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=2073
-- 
2.25.1

