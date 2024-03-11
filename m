Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB334C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BFC87F58;
	Mon, 11 Mar 2024 18:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5qT1Qdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548D487FB9; Mon, 11 Mar 2024 18:23:47 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10CE87F95
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEKSRXXM5Bb73zRpLMY6qcgH3vlVR8lPGu/bEa4UbE1sfFql84fvekkdP15gVtpK2OOKjOg3SrzERCWvl1Vry/IN/vt263L2EVhJRQKRACttgQW2vqxiQktQt3E4kJNf5BS5bGwJ/zefbHqaADgCXPhCJC6+Dctw9NPfyzVM5cHYUCHB00en6RtsQ/qofwJUa3kab06LkSzgJEkXr8cOgEDMA+GSvvL/fNY0RVTIH5R+kTfKlL2S0banXZd9ZjyhR00fr8vH+jYQbXrWPiFzCXH4YF6NxTbqf1fQb0MSCFHD5tHoMdi3PtLzsaLp6v7Xw2FsPivPfA4GUixZiHfr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uayo5F32SGEBTRYig8w2xjDA0WDQd4Reqk6waaRLE9Q=;
 b=Ks69LAwKg4DClFgoINSlxnhgEh9q69gb7O8dU0IqNgTqUtSYgx3Jzk6kNF8coojSdTnB3pa8wglX9ELSd/Mxvw5u0Z6dbMTUQz7VsDXUQckcqZsMmP7L6WmXr72g9IzS8VNlupxbkTTIvERMkZNASb8fpTTdofms13ij9wVlD8B6sl1nQ7BYAqSwudPI4laVXV19IKZhB2gWn6Kc2rC0i6tehePWUIo9Ame8jdpLh4a/RkX3ZmvToTFUSJ+s02yFiUSG+bMArjoZCtxDgelhfKPePMfWvsu8eJtJMHdEdlJen3x84I1MktRyRfu6ayUEmrg/qXiHjVN+QVWI7bk1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uayo5F32SGEBTRYig8w2xjDA0WDQd4Reqk6waaRLE9Q=;
 b=C5qT1QdiSGF9y8At9uTIovZhuHqv6wHznLLgnpbc4+55PISZDK3fkkZb3sDrzhiLOb/C2MeTind7qALm7J9hS0pHyaD/NwZ5Y6SDGA4i4Xu8m3vJ+EznWhXO6EPD9rtrQFc41eRU6aEQixsVQH7dd8PtL27fowq8trfw7ayiSQM=
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 17:23:37 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::b3) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:36 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:33 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 15/19] spi: mtd: Use split reads if multi-die flag is set
Date: Mon, 11 Mar 2024 22:52:45 +0530
Message-ID: <c0159f6805ac6c7f29e21e36a3ab81e598cf65ce.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: c01596dd-a4d0-4c3a-daca-08dc41effc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b09xSbAqIdaIjfmkENWCtNoeit4mE9/HFt/ph3mD+GXUKHCECqAYuik0DyExCXOoRY2huGVBVqS1cmUeifGRLD+4MWZY6c7SLAf8DzcvY7xXSJvriPxheCEwjoewWGTUon/egNleVHZr1dX8HRGwSbdP2lgELy8J4tGWJSebAPQE9lqzfAsRacRZSeTQ/ox9LZ56ZZ2UJnQi1S+7C+aPE7vQWIUTqqpVTJNRqfP1fqbaUHXU9Nk9Akpht1RU0JCbZWsKbd9RKndATSYn3MNsncxZB7AqwQ0dy5KHRSS7+EvNTRZtpJz4DaaVjYl5ZeflOhpFRb1PrtKNmcD6KlZsqgba6kBBPhw+4TR6BSEvu04CChhR/7/JJBY+IBViULxmCvLlw6/XfXXTtjJQ6Dy4B5X/atDZJmmEl650aQnucw67Sj4X+wEh5SU2lKnRJxtamLI6Gh23YRDX2ciwyFjStZ1j++qjEy3nXDaow8pgzJbRn7lenHalc8+Lu/3HeSJMZFZwT29OjXpVFnqk/ekKs4xydlc9QaYi9fFPPuUof7TsJOSrNzbYXRM5+u7lodZduNbPT7lihtgd+H7GCX+LAz20eRM7RDxjgTBkr038JIYHSPVx67eDvPifKA9c0oJsb2OlDEpCq4stb/dhltT7Y+0c19v3zQG25mVTmdFoCr0UNVfbZ1aPpwPAuO7GnhpdO0MFQFvmlRcQyljLZyEj7qGQdeY1DTSQgpRx8T2aBsMQBpu5Wn46z7DQXce97+Fm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:36.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01596dd-a4d0-4c3a-daca-08dc41effc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

Some flash devices have multiple dies in it & has die cross over
issue. When SPI_NOR_MULTI_DIE flag is set in flash id table use
it to enable split reads to avoid above issue. Define SPI_NOR_MULTI_DIE
new flag to flash id flags. Remove SPI_FLASH_SPLIT_READ config and
related code from the zynq and zynqmp qspi drivers as it is redundant.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  | 1 +
 drivers/mtd/spi/spi-nor-core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 9c09f97ce2..2cbdea60b0 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -70,6 +70,7 @@ struct flash_info {
 #define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 #define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
+#define SPI_NOR_MULTI_DIE	BIT(19) /* Flash has multi dies & need split reads*/
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8a3cff94db..f1dbeb4725 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4470,6 +4470,9 @@ int spi_nor_scan(struct spi_nor *nor)
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 
+	if (info->flags & SPI_NOR_MULTI_DIE)
+		nor->spi->multi_die = true;
+
 	nor->page_size = params.page_size;
 	mtd->writebufsize = nor->page_size;
 
-- 
2.27.0

