Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57830C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D63487654;
	Wed,  6 Dec 2023 10:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCC4Ogby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C378764D; Wed,  6 Dec 2023 10:32:20 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8CF875EE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhzaSXjUoSWuERxAKgwYHESq1glSvIZgWpy1+1CwCrbtONhCEZFOc+bGsEEbw9SKaaKnmRdoSrJgRLFPU0xoPrtmI4KiMXc4+JVl4z6lOLNgkjYAYWsoXSL/JgalG/Z+S5snWoowbzQH6mnYVMt3gkDrVQoaR9mR7SGlzuZLrrPkghiFmIYmoyhXDm+Q+xTjJdlPwcELJJ+pwW7P2OSmwf+3EMNw0U4vzda8gkekkDrSxL9etxywBdE9/MNl053Div1yWx/PaFvEmU2aSqKLE30ZW4JXPlZdp8PsrNJPI+weJHlMHfIFNBRU3Csaya4my/Y2IZg/SEAoz/y2HWSm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oPu4QdFFbrQ6wLibqYplciXx9ZJAiJ9KGQEtt6qPS8=;
 b=Q0ZDxMf4JtnNPWMYuUH4tBjKn/TtYjA+yN7c1uaFGIDQK+W3KSvK1ZXUmvLr/hTiQYiXftwfkjw5MwnyQc14PyECvUYXLETBtDz6sKnrb5oaXBr3XHaD2adaq2l2Vizek6I5ZM2WfOnLGPFZSW5t/o7ztj6YSp1glW/cV9fFK6UNYPjtFm0FHujEZ+E0+oxDfdunP6bcM+YS4/2fLHlChCoZNTo4aol9xXhs3lHYhabgge2qDUWezkeHIaqmaOVneEzuB4e25ysmyvwd9Es1mBHh2mOkbROcmXWtqaCww2UY6suK1tm87iA0kNOVu/moK3gPzgBaX5o+Q6FKnwAq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oPu4QdFFbrQ6wLibqYplciXx9ZJAiJ9KGQEtt6qPS8=;
 b=qCC4Ogbyfj8SCTFi1KP9gEZp4i+izT5zqU98McePIIEktX/lYKnmwWOPxFKUqn6SV001N+OXtlWx2ojIAbPo8Zr1/xEq7YgYlQAHk25cx1gxIYpQtWPCsD8oBs2pRmwIW9cJzbKusWTF8re6l8W6Nym/FspBUeRM+PLCf5yoD+M=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:32:12 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::b) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:32:06 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:04 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 04/30] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Date: Wed, 6 Dec 2023 15:01:15 +0530
Message-ID: <d1e0d1e6a6e0e51988fb8ac671bc173743a165b0.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aec1c28-031f-42a2-2b29-08dbf63e39b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyDn/NWJh/wR5avmp3wSC1h2Br4n5R4r05IycYDw6AL+Z6SB2FPbGHU+aTaFrOZNDHvzuV5NTbr8YYDGjCfz6wZxlxP6RZ1EabwW7LAsue/Iafg00MTN9nRiLWGpHTaMKu0QzLEIlhWEDXbBmRijgZNQoR0KDUK/3juDwPwfj/4/uHOFNDHTXImKG1JeKTaa2+4pXbyCSkWcyekP+Boq+l5ZDWsA1EQsjyzkBUgY4ubxVQ6unGxkSgc0oZ6HkVi4GgBnnpktO7ZC8pnD6MXj1NY79N82O1wvxNNItlde9yuE+DyTOtI1i1OLV+xQy/y5T0tlm0XLkpQaBKy0tOuE6yKhBYM3htK92RzNi+YWiOLzFJdPZLcyCtQxVmoSgIBRnCtek7lxbuy5u98OnYb2GeTRBw+/W5MYKhQKAqv18SbRAa2KqopSXbxMh6HCVGy9J+Ikq634lVOIK0CgxGNQOxFdnuEpqR1a53RtMzUPt5UTKtmidnRntd4CoJwndDH/W0z7qjf89pGfYbOgrK3sDQ5HpJON0vb4wb0wFLDe4kcl6+nUBcjlcK9AzkdgmrbKEVhH9mYpQqzVfKO45jBODQ7kQiIbPwnk4jITs8zwKVMi5DYg8qtPb9uKpXy8IC+Ww50nh/5eYVbN7i6N0P53JtwrqgMJuAb2tvjSUCCT/Rq7ggdVjknYo7JgQ4fF4bmfiu+xlKwqDFp2F1KYr0eSGi+cbYRhcMB+xOwBilfY1Yj4o8Xa4TwH9NINdVPbRCS9mirywEym6leji0By2NGj8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(70586007)(70206006)(36860700001)(356005)(83380400001)(82740400003)(426003)(336012)(26005)(2616005)(6666004)(478600001)(316002)(6916009)(54906003)(86362001)(8676002)(4326008)(8936002)(5660300002)(2906002)(40480700001)(36756003)(41300700001)(47076005)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:11.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aec1c28-031f-42a2-2b29-08dbf63e39b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Enable mt35xu512aba_fixups for all mt35 series flashes to work
in DTR mode, and return after nor->fixups is updated, otherwise
it will get overwritten with macronix_octal_fixups.
This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.

Additionally, a new flag, "SPI_XFER_SET_DDR," has been introduced
to instruct the Ospi controller driver to switch to DDR mode.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
 include/spi.h                  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8949dab548..e505648e5d 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3991,6 +3991,7 @@ static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	nor->spi->flags |= SPI_XFER_SET_DDR;
 	buf = SPINOR_MT_OCT_DTR;
 	op = (struct spi_mem_op)
 		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
@@ -4305,8 +4306,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
diff --git a/include/spi.h b/include/spi.h
index 6bc8808bb9..eb015ecbf5 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -171,6 +171,7 @@ struct spi_slave {
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
+#define SPI_XFER_SET_DDR	BIT(6)
 	/*
 	 * Flag indicating that the spi-controller has multi chip select
 	 * capability and can assert/de-assert more than one chip select
-- 
2.27.0

