Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B7C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 05:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC0286B0A;
	Mon,  6 Nov 2023 06:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUndBii5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9849086B0A; Mon,  6 Nov 2023 06:25:10 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FAFF86828
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 06:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVEc2F9ZJu6u7Vqmd33D9vNrjYHUXNxBUyIYZYu1xWPO9QQLgPaL2DmV0m9GHjzVny0arY4GRv2nQIhX+X1CrFMfNbxJBbrEI3VM1tvlFMxXsdnNjPgtzkVJsPoHvWud5ikfy/Bu+dvnILTBm7ZMZxFlmqTaJlxLTbj8AnlnCr59a7CJu9Q+dJQLxRLFs1NxsjxcnZipAJuCeef0WcqP3vh5GG8HpoNlGinxBH7PeS8zc5AZWuN2vURvfH+6cEFvrdcXoehRVQ4/fxVOX78LwBSuxtDlwvtU/rSZbHoek7VNfsZrEp/hru5XwhraKbNynjGSB5Fgtfe3QiJ6fQYYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w29cXG5G0lHtaUWVSi1AOcsKpliiBTuBRnBWYSbM06U=;
 b=XzCNXB2G1Z9WEb5r7xZ7lPsVNk2jnk+i87FRQuXjNeNG9a5Xosc3dVRUpp6EK/H6x3nuafMF0Z4egkIE0JZecJx1ZACBrR9EUab0TOaxX6HV6Q2k3Z8dzqU9g0BY8wReZ4ZmmaUNV2mM8xshBtkydzLWKA6Ie6c/0OF0PefF93CFD89xnjkVmMIjz4uuFufDVqiFpZ/2Pl8oDOBXfPyJ+MsBpwqGssGDEO6dec0VY3uYp2/fsUwTd3GuDa+iYF14/Sp91sngRCAhFC9dck6d6iavxUwUKSfyXsiGMTfAmTssPcBGJZBm1yhKtCKg0z5rcNPxKCUzy6JlAyzDf+hxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w29cXG5G0lHtaUWVSi1AOcsKpliiBTuBRnBWYSbM06U=;
 b=bUndBii5q/XmQoUbX8ApoXCXXcGg7qNLscWB3IhUR7WpANKoB+D+eYN6lCSc4FL7KZ4MchzJioUdddl8VBo6HH1P1aqdSPtY0x7Gsm/A2a70xiF6rReh5peFa9snGzojunuseUFd8yUddNaOJm5oPkzQ5ABJKIQI4zHb0Yq/yaI=
Received: from SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 05:24:59 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::22) by SA0PR11CA0207.outlook.office365.com
 (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 05:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 05:24:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 5 Nov
 2023 23:24:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 5 Nov
 2023 23:24:46 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Sun, 5 Nov 2023 23:24:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: Update block protection flags for ospi flash
 parts
Date: Mon, 6 Nov 2023 10:54:38 +0530
Message-ID: <20231106052438.12903-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4fa5cc-a12b-4970-ceaf-08dbde88b7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GR9DY83qAPZWCBfT0qvdmcR2i/ELR6/H2vB60mASRkRaxG72ltwdjIY9YDMhy/dO9vkYzCmX0YyrzoFCSqXXhQghAzdgDEhb6KVsAkRObZ6z5+95hhX/FHU5IaMyFtCMwvhU2dhaIqQ0e5rIX8NpRjx/qNRIoB992UwxCFl1ogjqTDgJGcDuGL/z+hbOY9+iD0v4mbPQRnJeUcMXUiXlupIpJF7UgkaZ0LutpTDyKniB0J3uwLBasex0kPuoXqcG6/LjvAInCaV5dBIzhgF0URpMl6IkvquRPa2B3kZ5O0xbEoriktfntAcStWOToq5aYo6OPiyiq77Kq0gEi5+3x3qD5EXB8JcJL4fQVCOHKZndZ+dRl75BIZMtM4HfDTpXDinRNw6yC6/yuPL5wb9AUJvEzfIhZGr6qTCtNG76qDt5OGRZD2+8cwuJ3AL8QCqxNt1xGLMiqhR5ZIDoD2r2SEhr9U0VIKWCM3u3VqNyq+M7uRmbLVdPMq/ngPe/8QwKNwnQUmvs7Fa37o0VXxLmNjJIrx0Y7tMcjkktWwpA2ppvG7JXHe42Oj9FGygUT8m3/e5a73sGdhsdZsj77KhHobrZP/t3dA5ixtsGcISrxx5WqOwaTF9VmrK3h8u5JHMnvLBojESCKVIHEdj/8+mJipTxaseSR4Tp+bwm+Bhguj/K0ct88UmU16Yt1xgQpECY+Hon58cieQ++dtyTxUo8NnQGUJz9VlyMlsp7MLMVktnqkxdCFG03G1PgO6HTLoV4etTFZj6EXSBUtjTtCqY78w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(107886003)(1076003)(2616005)(70586007)(40460700003)(336012)(426003)(70206006)(82740400003)(26005)(478600001)(36756003)(6916009)(54906003)(316002)(6666004)(8936002)(5660300002)(8676002)(4326008)(40480700001)(2906002)(36860700001)(47076005)(41300700001)(83380400001)(81166007)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 05:24:58.4944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4fa5cc-a12b-4970-ceaf-08dbde88b7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

Updating the block protection flags for Gigadevice gd25lx256e and
ISSI is25wx256 OSPI flash parts.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 77eb9f352c..b939780889 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -191,7 +191,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{
 		INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
-		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
+		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES |
+		     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
 	/* adding these 1.8V OSPI flash parts */
 	{INFO("gd25lx512", 0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
@@ -233,7 +234,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
-			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES |
+			SPI_NOR_HAS_TB) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
-- 
2.17.1

