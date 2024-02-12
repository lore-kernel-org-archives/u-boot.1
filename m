Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294EDC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 04:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC9987EA2;
	Mon, 12 Feb 2024 05:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ofsG3TaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71EC87EB9; Mon, 12 Feb 2024 05:32:51 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B4387CF8
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPb/VL/N+JYtfEq2qUPTLfc7yXPayMzytrSDyB5LAkiGXyDK9aDo1SpG6TeURcQy93jSgL3L4PCyrfEgDoLnnsIa26PQs9cCCLL9zUqtVhWHn62ZpGRyR7xOndCKDhz2JDneQi1H/C5XapiIJvcLH+fmOS6KCK1PJFjwkR/8BHag5P359EZGinRE9kyA/wkFkSl8lZHcEyAPpGe4CD7sxaMqmrCZT66lDjxopAbrdXE1tycvhG5WsEFeGWT3GjQwBlcVvFYf48dLFsVp4kPywXGTRw9ZWPADVHxmxmDdhd6Gpyxu9XHobr/gaF+dvaoP+tNguD7wyouwt/QhMpSI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjUz9BNognrArSIwyYZJLdvho1bNyQvSs9rEfgp0KeE=;
 b=FGjmIYaCt8qqK/7VPnvh6hsGyJ4mC2gJYXup0YJ3Cf0/XVDVWar4SedLPo1Ft7hXWWN8BE9yW8AF7yNjbopeoxlkysPNzcxwMcImScC1tWxEexD48UXpffYhyV1KzW0OqXt1HB6jowHPOxa01KJtMdHsc558hhAGRGDNy9D4aIOH1pe7dXPAe7AH5fIu+cy8h9gDmcS+YOiDDy+UYdGFyj2NcaeNZP7o7WdVoxQyua8q6h1S4bVubdoEwjS3Ut6NwroiB5WZVov0dS32je8TMt+9tJfadDvBjlNWMuQNXLBh9G5G0bJ2+qyLWWB5FrZvDPQX/IxAnqXGj8NOxiFR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjUz9BNognrArSIwyYZJLdvho1bNyQvSs9rEfgp0KeE=;
 b=ofsG3TaRMOdXujd6+V47NhgCb5qvYqbRm586qL405Rz/7KmGkTRsfGMcTfde8jCWWZ4uk9C9HkzAhcg4Ej9S5GdZuv1vlY+4BV6JI4L8OGDjgy305XKopyMOUAmrwy2Cdyr+SVBKaOXPZN80NNsZcKd3E04lYc3afemFn9HB3rY=
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Mon, 12 Feb
 2024 04:32:45 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::6) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 04:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 04:32:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 11 Feb
 2024 22:32:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 11 Feb
 2024 20:32:40 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sun, 11 Feb 2024 22:32:39 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <michal.simek@amd.com>,
 <venkatesh.abbarapu@amd.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: Add NO_CHIP_ERASE flag
Date: Mon, 12 Feb 2024 10:02:27 +0530
Message-ID: <20240212043227.151246-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: b67d88d2-bfcc-4888-6e58-08dc2b83a88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOgeClLrW0WsmVPRXE4hRFM27IuJYD5I7Wiwk2S/RYP+W4FWWz9MNGz2CBTisGGDU4iy7xGsfa4/PmjS+xEHPaAdb8Tb4wY8tnyH24JpZ+3Bx8vWhiX00azhFbOuSo+0O7V5hPDdZ9gXqFIXZEQscfwwrBMfl4TxvtEd0CDz3/gIyd+PNKcxqxlCsZy+36KnntrzfPLC25IcrziHqLX580idAAdG2dlzG5Pf/ZtLN9HnxL0bXkhvi4qKueMQp6wbIkJ19hewTI5XzDbz6tyNujLmYNiThgG+gnYhE63eeDwMvg7n5iW2kFi4XIIhGOP5S+Av8QkPCX5AkNqrmIczjcpnDwA3MhBDiAh5MzmYn6Rncc75+e30vnNuormr0u4uswld1Gm4aQzdgOYZe3JS1DGglXNZC4+hPgc9XBAkgUHmOiQ+h/Bss6yNJ1jukCTZ1J1NZp53QtqShmQIjrWBaZ3mkeKnILy2JmABA/p/02jVa0SieOh5xeg2kjPTGZWqYlXvj2mNMrrzQ/kmRfLqtpAqSTcsrQ8DXdKEfRaxn+5nUS86DBr8yLfZaOBsDRujzciwxxgGL5sOzM1zpuLCMqKAppR4OyFkI99K3AODfPQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(2906002)(426003)(1076003)(2616005)(41300700001)(107886003)(336012)(478600001)(8936002)(26005)(4326008)(5660300002)(6916009)(54906003)(70586007)(8676002)(70206006)(83380400001)(103116003)(36756003)(86362001)(6666004)(316002)(81166007)(356005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 04:32:44.7981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d88d2-bfcc-4888-6e58-08dc2b83a88f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
for the mt35xu02g flash, the NO_CHIP_ERASE flag has been added
to enable sector erase functionality instead.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 38a287487e..bfbdf7570b 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -329,7 +329,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
 	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
-- 
2.27.0

