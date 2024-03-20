Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6021C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 06:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E687087F5A;
	Wed, 20 Mar 2024 07:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0bnwykJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F50887F13; Wed, 20 Mar 2024 07:41:33 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B2887F5A
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKfEM2+b62Vsr15ITgo+HHRzeQgixDj7sP1t7tLa9MkVK/4zEyJBJLLI84fJn/svgf9/8pdjbF/OF8dZq3PZIwJ9kEbl+7XpErs5zTZBikfJz0vZ1D0uXx3UbSWVReXWoy3LuJec038jl7I1zLwlDvvu4amoJKM1s0vwr1OEYC3v+3QYiz/SO9UNHTJljHLuEFPpV8FQoiIGXIZsn7nMYC8gcN8hk4UNWpiAIj55744upl5SU8cbRbBFMUOk4Aj4l0QVBAKrzaWBiJIrGU/18seWFDG5RITjHYR+mX0U0E6ILzyogrpr2mEmQqHL9V0EHKroAlsfHNFMDBhC4boDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52qm0ifgeAwDywLMlGJTTY7GGUprhSEL7GZaBe3fgSc=;
 b=ZHdBdx0LRx+O75P+UHf1S4U98OB1zO5RddVRIsGhEo9uJEBO00hipbeeQaPed1Co81GYBXNeCmP/DWsPhI7NVWdL/nODWU2QfhMoNSRNlE+RyqEJY2thR9c+GsjnPRga498gs7/WEe4dKKerdTfSEvj3d0B2xnrlWqKynVXshye1lhtz5lp3081gIIywFTXPNeuU8rsJ2ObB9yyqjFzIV9z57Q9EcAuK4CRNEYc8Xvgdir0mcm3LwJ7gSSM3rT4Y1Yu2euE/fVwDOAfevApfZ2+rsv5dOo1nAU2mMRYSOs2ozmdL4y+qjy+nB9T6WKFaDIR5naVLbSGSGKK9teA8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52qm0ifgeAwDywLMlGJTTY7GGUprhSEL7GZaBe3fgSc=;
 b=0bnwykJXs0wThpX2WQznkSIvkKjUrepuJDfBE1COAdZblmpzrejFbnqpD43qWexxisDkDfSQs8HclzIK0KzvISfvy0gWXxwh7eftFay476qgCCqi6SpfS0DtzZpWsVlVQLYmmLOqw2ydPVwpVCY533r39RHnpO+0EcQrcAcrxRI=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.29; Wed, 20 Mar 2024 06:41:27 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::78) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:41:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:41:26 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:41:24 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Disable chip erase for n25q512ax3 flash
Date: Wed, 20 Mar 2024 12:11:12 +0530
Message-ID: <20240320064112.1798827-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d544c13-a50b-4b81-0159-08dc48a8c4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcGhIiMkkpN1sk7V12n3gDbLnIrTCu0DKFUKhbZ2TYLuQw9aXfh8sVjP8oIGySzQKiHuzgJADF8BoOPDBOCP+J4G1nKvDrj7i/yyxgTTK3en+ynbHOSgIoKE6daL38P6VogPL1NmNROlUkS50QADt4FU590sjVmNf5DqWX6FeMLewSUjFKvNDxgQjLYHEPavPt44bev84pgzao+he1zaP32mlZoiSDkw36a+2fwjEjsjDJBQJZL6UBBPcsRjSe+X+xEvRt2CpKc64qLufivqZGs6+dWtmjEhQCs91XLBdmhS/waOhPBEV7nnmBuvunydFXEf8OlBKevzQ+9o/oeH5lJdRpFr34F9s/EPSbHJaFF58jcOyN3ZrSGV1XswpxEBstBqg8ksImvc0MYvuB2gT73Q6Ziazqh8p1cAVnD3ETrjsCQJ1nVeV0G8G6zmJBT59omxGAUNp9bvWoHDbL6i9PYSZWpFmpfYKq+HTkBmuzpabUhzqk9pR9wKAIVIGLm/AWoFNZcyGLBvcVHkCsYcN3RAsspHulXDKy+VGU0tVnQuTj2kVpMl6RB8U6xozoK7YZLu8k7uvSTy+/DgUW7U6aPJdapzGdardIXDg3CjQn24TOpnMCOZb9EqOGL3CvuX+0ht/fmZ1VuK+7IzogQFCYjbVjC5Pw6pxDzj77smSOtz2Dy7veyln+lZJMRUvw6ID3TparXIAtziAJkocajO3UTmHFy/b6WplCGrssNqLlLmnq6sGGEjWOUopMeg2Rr3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:41:27.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d544c13-a50b-4b81-0159-08dc48a8c4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

Chip erase not functioning for n25q512ax3 flash
so enabled sector erase instead.

Tested on: zc1751-dc1 board

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..0ca7c36386 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -318,7 +318,7 @@ const struct flash_info spi_nor_ids[] = {
 		 USE_FSR) },
 	{ INFO("n25q512a",    0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ INFO6("mt25ql512a",  0x20ba20, 0x104400, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ INFO("n25q512ax3",  0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("n25q00",      0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("n25q00a",     0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("mt25ql01g",   0x21ba20, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-- 
2.37.6

