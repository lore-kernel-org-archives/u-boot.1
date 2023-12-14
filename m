Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5093C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D53787AA4;
	Thu, 14 Dec 2023 17:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qu61WB4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18F887AAE; Thu, 14 Dec 2023 17:36:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27AC387922
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePZP+XovECzdPiCN6MW/GyWNIArCR8Vd8/CEyeX1HBoQjNZsNoBaG9kp6D7XHtBpclz0wGgNHVFDfb3z27hRAnzNBGHZ0bGAM7HpFvQLX+UxJyatRfvn5m1KkAkzLWj7fXCsBnau7WDVOGrT2xICUuFqlmQMFVC0KPOfLrdKlSDPyiUx6uKdc7J6m8bfiT9MLl/TqqiBxRhJRgkGxO+jveCouPuc2ZpLO1aDXY1ClrYtIDKAraOsHS7PPCQsI6I+mjZXIZ/oFdU4QlGpoE89xPXDvweNbm8vDSCrjjVNKAQLbJHWaWkGzVyWwAyqzMX57RPupS7GMhWLVF5+YnLxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GatsOoOiBrWizFwaqxMpMbvNls1wapCvmWWRZyAGXRg=;
 b=e1y1mnc3YuXiDdnPFfRa1wPlqZdNDnxnv0xQCvcARtVmEJLhQwEcM4+SjsoRYyJ7rqbH3RF1U0Nhdpa2K51ghJB5aSevThvz0xXXUD+Zf4gKX+zzxEEbPm5ftsThFYT+9BiNuQ8ciwZcOkDXT4GZrNYkzSgVHMBIXRwDIYWvqu617AK5MNICxlw7uS/VGLujNG40lgQn6Yhaii8D2MeF6pWcOYFuCNkTIEVJP2uculjd6g56ii60IGnMv11/or8ZF0SCjWfWKdTLMrUOFJK1r4xrtKaECf/MRaaHllwYZDw4GZ2LfTZK82Qh1uzwW/mHnMfxUQNwG6yGCa1gpqhVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GatsOoOiBrWizFwaqxMpMbvNls1wapCvmWWRZyAGXRg=;
 b=Qu61WB4/40l/U81WzroLczZ8Rxh9HVQYtQEBQFfHw+BQOPqsOYCzwjg+qdI8JZ5tzdQV163RJnJcjXQ2MZdaUpOYUec6cWT8nay+bLoB0+Pm+z6FiyFGn24VlooVE3QbxrIxj+y51n62OuwiDihMH5wVZrWlxJ7g0gK5fmZHrjA=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:36:33 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::15) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Thu, 14 Dec 2023 16:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 16:36:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 10:36:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 10:36:32 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 10:36:30 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Date: Thu, 14 Dec 2023 22:06:23 +0530
Message-ID: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: cc50977f-7f75-4380-1294-08dbfcc2d524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAo2wQWloyrwweiAzohHzyAggo2jkyCA5npUPzdzgkRSAqcVL40ETDvhTSu7af+u78uiw2UKMHuaVIwfxVhdJTEwzaemGcCOEh9lSps/Tl3BiAzBZpdHEqet8n6MzEkUw2SbtwyzqFBuhBgyDHgx4X4J38glTzRttwBtC3yti2q0jRLfyqLAkWzkGuuneSSr9UpUkF1LOAV9m37SqQNKo1fxhj/65Q1H8YaRWCn2GPqmX/kqa7MnLACE6Jhgmcg8O1/cOAsojJILCK7vRl3hYILugk83uBo4asWmjJZyyngo+QCE0hZjUWv3IEZ8EwwjzdtQsdBLiqYz7pfoVULi+erhElGUa6xlDqVKqKFJxLrwbpuQ6D1pYUTnBvy4xsMk+MQdXMztJ061rg1sCuvSeLYA0y8MwwmeKWmcKWp7MnuUGkpUzt+qEOdBp4wkjGZ0e6UTWCyHmyGJbXMMvwr6cLkveSMfO9bRcb72AcjSycwsEYjv15xga/yYbVvYddQyHqvTj17sVTuBveFDy4+rY+ZFUec3/+6RgbJbmvV9aKdn+MUf44/0UCzPHJO03H6JlO9EvUmqo4vgLVMpw0jvEcTtqzcLBlhpbOzHfuqd+6A1TG5Gozd+nQ8/MiHXVrAwSAbHAtKuhnxt0yyNw4fCuQs9CopszkIfZfvC7UR7Pr7GscMFqlrgoCSeX6E7iJl2ebdVvTQGo3HIHap2sxGjOTKpTR8QMStq+rOoi6zAbC2lXNkRtj1ekCTkbIELPFUOnkuDQuDWWZ87hiJQ+ZKdVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(1076003)(426003)(2616005)(336012)(26005)(47076005)(8936002)(8676002)(4326008)(316002)(5660300002)(2906002)(36860700001)(107886003)(478600001)(6666004)(6916009)(54906003)(70586007)(70206006)(41300700001)(81166007)(36756003)(86362001)(40480700001)(356005)(103116003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:36:33.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc50977f-7f75-4380-1294-08dbfcc2d524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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

Added support for Macronix OSPI flash parts MX25UM51345G
and MX66UM2G45G, with initial testing conducted on the
Tenzing-se1 board using STR mode for basic erase, write,
and readback operations.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index f86e7ff8e5..a08f105549 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -267,6 +267,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
 	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
+	{ INFO("mx25um51345g",   0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES) },
+	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
-- 
2.37.6

