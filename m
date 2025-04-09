Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB7EC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6354683909;
	Wed,  9 Apr 2025 18:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fA7Ua654";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A446A838D7; Wed,  9 Apr 2025 18:27:00 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF95838E4
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjxR5u7BA2pXXBpUYuE4xkRVTYEPyyRVw5eFbZ9UreFfljTtdy2zahOz8NvHE/a2jk3H6N8D2/pb/NHMeVEl94HIaa4RNVaXVLQS5atmBCqxknSCvfl5a7U/CSBHBPww6fLnNjrlkC15XPgeeAl9b207Eizn9G9aKNT2YNn/yb+schHpx4ckpccCv4Ae6wtUMLs0QcwiXdvq6BdXw8p8/OkWqDrKPQoohpXkw3nO7vE2nJY7RrWpxGOBOvkArzWkUb1k8pJYYfU00YstwcNF80lOeYp20xCQaY0kkUh0ltJ9Niuq2SMYMShyCEnGiL6Aoe64abQKThwesCkpA7JMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZKJHf7fGAch0GBIetbqtyL7dKJNq7rFZKL16EvMkrc=;
 b=OzJftCwbMM5C2eSqdsznUtWHi3iALB3VOnjqqzvmCZU2gywbcBz470TDOXHu9uFN7KSV6yOnUlquYpeoFJU3C5a8G8zZN31c/ALffUuNzAzBXROzCAl6YA9j09oostvCqmnXXm/21pCJxxSAa79hm8Hv3ctUDiLvHmTDooqyLx25xkUoVSpuYrxrOC9Fq46li9v8KO+MoYjZity9YzPNZOc6R8qvqZqUIcwLnPt/YnUHIwPbEAvEh88ToXSH9PWJ+hDj/yTC92gWKdwYFsXNXFkGWiPNMGEqWfjLUuMbcCbJoXVqrHIAWkDo6ZsfPTsX+/djUS8qmLBjXsn1oL2hLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZKJHf7fGAch0GBIetbqtyL7dKJNq7rFZKL16EvMkrc=;
 b=fA7Ua654bBuMSjhrP53D//F+6fyrupo7fY7M/C8cTKWGyIPncUk4KiROmI1mTfQG+moicODU4edEzVYOos9iC/2y+XaUM6RkpQN0gXYt9VvfHdLTASjfpqPNcj9xCux4UTxKygbbzNSDFiqeuVQYguOZxJaGiS8AK1sx5cfDWYM=
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 16:26:54 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::52) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Wed,
 9 Apr 2025 16:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 16:26:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 11:26:51 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Apr 2025 11:26:49 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] board: amd: Read an eeprom after relocation
Date: Wed, 9 Apr 2025 21:56:39 +0530
Message-ID: <20250409162639.588487-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250409162639.588487-1-padmarao.begari@amd.com>
References: <20250409162639.588487-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: e403f6ea-d452-4565-52f1-08dd77835680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ONiXlq5OcfUZlgcsxgwUooOqKDYBqesDG1Yk6RHxvF5WBEVMpeOmmyXUdICk?=
 =?us-ascii?Q?F7nSrtKT7CdGQ9sRQ/fhsf+bfER3tLxSsoRZWW8i2HEfyoE77dRlkzY6ScVw?=
 =?us-ascii?Q?XKWtkIWQgrjk1uwkF60KBUsdmgZwJj1kNs1q4A5Twf3EYegs3RRNTDRbU6At?=
 =?us-ascii?Q?YQOarjUirMjKRYoGzo7SWPHdlbHb7jmM6I8g228xJhwQGzSqEi7IT+D7pVvU?=
 =?us-ascii?Q?OORvwUjFFegGN0aDDrzG9o3GVAP/Hzyl4eHXcOFUQeLqQMxwk1MCKrYvAyC7?=
 =?us-ascii?Q?jVIP6q04ZUJ7HRbYk6nu1mqcaDNgg/wB8NTrDh6Kp4mWa7nrqu75Rh858PDw?=
 =?us-ascii?Q?4HJY3pXbORLWXOjVIOoLxy+SG7/VD2sAwoIgB/uP/0SQHQypDRQcHk+0cCgR?=
 =?us-ascii?Q?1TW5L7/UUxg6HH9EFTV0tPQ1i0KWrvGdN11DwKFjZ32RUjYq2WbNJFHMdD3t?=
 =?us-ascii?Q?pshPXbj91/KXcaFkFp1hccrOlEmyCzgEOTJEK+GD/23V9kf8bMmEPiDGmbGf?=
 =?us-ascii?Q?+hbWdb108EWCTSZdnd9Q64pbdURtcwCakv3mcBBHNI3nkL4cwmUVn6jikXME?=
 =?us-ascii?Q?EwVW2HCWhTs0rHZbpUL1jlNgZGErc8zxgL4hJnwihUGR+w9nQ7258N/wHw/s?=
 =?us-ascii?Q?3k13sokaS88OwvXAyuHTDaitjmXD6+jpklly+TKwZiaqjwEP51ZzndKJNZTO?=
 =?us-ascii?Q?lDj9o0im7/Zw5LABLYOmADze9BfcdNFHhKgeQB723MTt4J7O5Uj954TOdeya?=
 =?us-ascii?Q?cOtXizKcjPBJ/rcwG70G7Pork3Y+L2SBdYfo+2sUil1JvRy0KP4cjOgPFPCs?=
 =?us-ascii?Q?bs3V2oNHCVUDjWwP20/CX1AtKsUuWZWCQmJ+lwx8uSa/a1PF134ILNs8Pw7Q?=
 =?us-ascii?Q?ZsSJpbqN9R3oUy4EWSp2xbxp01kcCpdnLGRsfgNNmcEizSv6TVzNiSB5w828?=
 =?us-ascii?Q?S5Zct8TZfIrmRVbOnx0PAc1caWjJdjebMMp+imzE75ui9HYTjkG3nN1SVUQf?=
 =?us-ascii?Q?DpIzmC2Ys4W3It4CvZqchW7XGvtk1dmzu6o9g4hinsj6bqt/sfuLorGpWC4d?=
 =?us-ascii?Q?CN5zY0Enn+/k3Tu70LzbAcEbpAqjn0kguKR/+o0m9g8phxoO0rA5JDX3xmxZ?=
 =?us-ascii?Q?LH6MTSiEye3SNZeCGnweAZJII2qoJshGGF0EBNqCRXx8fRAjSRC8arH1u5WU?=
 =?us-ascii?Q?uJMZBECS3naomm4NZyA1LiMgf5XS5haqpUqXWJy9kiBS5HjAJjWnfLQO2SIv?=
 =?us-ascii?Q?spY4tAdamsjJ7iFRa/fMpyZ1oG5s8BrvZuI3VgpmRKZ03s0Fwz5+pJ4gU2np?=
 =?us-ascii?Q?YA4Ox7I9HY55EPabMibZitSpsM/6gSAulzAxgykx98hYSlvLGX4BL7v8xJxs?=
 =?us-ascii?Q?v/vxpIQC/QeCgDdeQjAb5JIlIODxwCQYMhdFMYkWGDVxv0Sx96HuxGFZPVPt?=
 =?us-ascii?Q?ijOaFevMvK/tg25dDGHkLNPiFfJjMhE8H+wMmllGlZhOKnAhwIngHK+D/697?=
 =?us-ascii?Q?ZXuNFKr9tqDTfALdQCU6VqNQx+W8eFgToOyH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:26:53.0743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e403f6ea-d452-4565-52f1-08dd77835680
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

Read an eeprom after relocation which also shows information from
eeprom wired via nvmem aliases.

When DTB reselection is enabled eeprom is read before relocation
too but information is not showed. The issue about two i2c reads
in this case will be address separately.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/amd/versal2/board.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e..5b995aaf9b2 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -32,6 +32,9 @@ int board_init(void)
 {
 	printf("EL Level:\tEL%d\n", current_el());
 
+	if (CONFIG_IS_ENABLED(DM_I2C) && CONFIG_IS_ENABLED(I2C_EEPROM))
+		xilinx_read_eeprom();
+
 	return 0;
 }
 
-- 
2.44.1

