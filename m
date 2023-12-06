Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF65C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B148187683;
	Wed,  6 Dec 2023 06:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w57n3jD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E74F87683; Wed,  6 Dec 2023 06:32:10 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66C9875F5
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBvpzet3YZKKL8U6RUxQw5LcS6IZGG7DgPw9o1ITXCvrufyMH/G6MENL1QqBrmjlvLklUwwepluJaQKS8XJI0VyWacXwaspywd39f6aeUF8nNkB83IBLU1ORe9rSqunZq0z4C69hCqDqpcj14ej2zqT1UAUqxPbZYXOJUzIgBadCvAfk1lVXyriZ2sd971fbmrSo/Kkl2vuveA/n7OPeY7uenT7q2tOEKYW2qt9Pm+iuMc28WItpwlXeRGIUvH+n6YBzIvmBcQxLOqtjP9XBebsWFEnYet4tGwHZjjECBzKW5buWW+3Q7rn/0FWxgLnxJkXPi/RvyOzJLzbRgHvZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oPu4QdFFbrQ6wLibqYplciXx9ZJAiJ9KGQEtt6qPS8=;
 b=HMa0a9OqPNQMbZ2TXf4IfvST2tgLVUcDc8J6p/6silMs3I/qEoKp8jvFT5eM7FbzYFUhrjQ6cmBf2Rm98K4xvtZONIbrNleBHuJerAmPjtHV5755jsT6yuEEIUy12XUZEk8P8fDdxUVAPBT4gRaP0BZFkAuCBN8goBvtWk6LsSXh9+MyKxzsTbAQBe59DM1QEDNnolEGUFPqLPLNFoX46yqtxbVZ+c6+Fp5BpU/OdNSpI0FqTb2M1Fp9MwjPytY4TBQKAiAHOfIeVp24eLkxH6XZCHmi5FziJMLAi4oa9zEQXwgCQfhI5sqoe6eBsJV+q7vdlvzIAH8+4wb0IGbm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oPu4QdFFbrQ6wLibqYplciXx9ZJAiJ9KGQEtt6qPS8=;
 b=w57n3jD7n/16iuveSWdzCFIrIzl0fyD0fFiPH1KfGJNUyhsYcjRr/AMuBlrM3aUir2ua4RGZw+LmpCYHjVozh/RGSS3UwA/V5DQvZZCRN/E0eVwfw3D4gsFl+ExNq4lgWNIdKylGl9GptgzzXe2uoJ2XepQ27XKCG8+/ppo5mrY=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:32:04 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::25) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:32:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:32:00 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:31:58 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 04/30] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Date: Wed, 6 Dec 2023 11:01:51 +0530
Message-ID: <20231206053151.3745010-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c8fb58-eff9-4c9c-af7d-08dbf61cadaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r0MlLcHq4ZM0angnFbMY3AX6Dg4o+a9D6FnxmGm5Jsx/CnzL2Y+/b6R2FNqgP09ddpDKtA6mVCLa0d/ii+Vhx/dMHTn+vKFY1ydEbRCdNUuWfZfrl7AeiivaSep8Jisd0wK4ihpo1DXKSs013IoL7Mr9JHXYPr5GQPV3h6pSpkFX2khj8RnWbGJp22TKNiEnVsC+qqcYeTL78y2OJsRq1HCCW4tW6LGfgNMqyA1mPlTbxJ6JCraAQ0Efncz3HIUA2bOgQe9dG/eu7H08V2Oou3hy9nNPzVcJcSarlHicNA1jPLxMV8EV1LmICTM+z2//T2udYTgk0MyvQEFdynTraIim7qlfNN3TDAGNsPskkavDF/l9tIO131Tq7npHdo3fu8rx4n0N3KeCz0sLIFJhDgD8kc3mwYLm65TIj43aZ02OkRQYmlVu7eOcG/HYMcu1lHLxzcgXm/iM3uWzZ8YMw1nlD47eW+yf5S/QHn2UDac1ckQSwrg5Vhu+lsBkloL+OZ6IHDZ/2NMO5jAbszqTuZOSdDLe2LHypo3kXwksl9m1hhtOZkVcYh66kiaeBLzfo/FG/11JzyPvSl4HNd4K9HTjJwxBT4DycuIxIEv29TFspVUagL37u9KC2gpgzEA8+oPVj8efc//i7WoaesgwnemJlkLdrZ40lOzyGtGGqrILSi+7L2I96HZcQZLXCT+2NEvYNMZE9EpCMPspdbMkA3iHxo5SJn/uMORNAP0vrHUiiVCx2nxyZNwOHefz7ZhgxIdyhz/X6gZw2H2E3yF9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(103116003)(41300700001)(54906003)(316002)(86362001)(8676002)(70586007)(8936002)(4326008)(478600001)(36756003)(6916009)(70206006)(83380400001)(36860700001)(5660300002)(47076005)(356005)(81166007)(1076003)(2906002)(6666004)(82740400003)(336012)(426003)(2616005)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:32:03.5125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c8fb58-eff9-4c9c-af7d-08dbf61cadaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

