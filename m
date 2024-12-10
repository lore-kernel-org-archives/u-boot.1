Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F45E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 04:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1452897C0;
	Tue, 10 Dec 2024 05:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+o1VOiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58E5896DC; Tue, 10 Dec 2024 05:28:51 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4003897BA
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 05:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz+atyvUEiclg2JtKJ+IAStRrAuGXyTZs+l650dKGgkoj74MHl2yf+olYiVs8xnlcgGorCjVQmHa0i/FWTTNIT0lAHZjdBWPeuP1VJaDpuy2kz+zsMMfNcFtv17Ldx3Z0VM4xMJzj/FvCgnaTXPJF5ns1bFEAqBnxUy1VCUVgLaD+7aP3HiE21D5YEEWAHvNrpvD1HJsNxqhbJEemEbccBUEnH8h1jW9LMZ/mmaz4V09T+lxYiyU8YSSOg3XClDegjGBr6pfiJRmIwB9VNoQeK/RNcUFyIFYjAKUq2Ck6uyFax1UHefttDtyTqPxSXa1gfg/Aerq3GEjyBp/MY9/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yG20C9HLO/hErfMCnUWEuEnk8iA6ID42ub9ciAY+AU=;
 b=nnTThuPjQNyYttBqK6jFMA2ssUEURDv72voaPZOvqhTWesdg4ccPDRuf6KPvmh/JqLK+2rnhAbPXFqb91p6ChgnNr7/9qouuLfeC2iijSRiZpy/y+vfkrq30CtVoc7ekPYy7K3DYmUlK7hgvILfpypPLdL2EP+Twj9r/7jpdEwHlr3Nw+aCI+j2qxJFqDC1hJMegZhArsDzE+/Yf4EtY8hHodivN3NBz0TIBqU7UqJGnxYZRy28Cyg0ykSitdgbVtCXzgRLtjQHS9AoGg6qaIjaaMHjzKLZZbINOT+6h9/LRQa3HcSIOurGeXyw6NLk0JJWe5yaRI0JiJDrPZ568ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yG20C9HLO/hErfMCnUWEuEnk8iA6ID42ub9ciAY+AU=;
 b=H+o1VOiTh3TZUZJwC78h6ZVNaO92X3NATZvsf+R6hx77GcEwI3Kd3gVv/TdkSn8PjWy9DljIVu8BvNxnSEZLxJPXgkBmRmUh8M8FYXbaLXcHCf6L8YVN2l4wcEU9jSJgkV1RilwTetruJmXA/Oy2n9XcOVegg6/wZrgg0mPVEJw=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Tue, 10 Dec 2024 04:28:45 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::2b) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 04:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 04:28:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 22:28:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 22:28:43 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Dec 2024 22:28:39 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>
CC: <j-humphreys@ti.com>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
Date: Tue, 10 Dec 2024 09:58:02 +0530
Message-ID: <20241210042802.632688-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210042802.632688-1-venkatesh.abbarapu@amd.com>
References: <20241210042802.632688-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 3423a893-8956-4777-09f7-08dd18d32267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?04eunx/CmKTM75b6bwx7hCPIEIJQEDWTuYknn/8vqiT0w4Hgq9bC8WBV5ODD?=
 =?us-ascii?Q?MSTuiQV8du511bVKpEgVbZAcTb3CEXCn77sHHsQ0RYIjFuGGnt4Qvo9bLLXX?=
 =?us-ascii?Q?ii2w81bQXM7EopmaRgiyvZQ9DCEhH3ENZeB2dd9RXb7lFWanCk565//8DN7U?=
 =?us-ascii?Q?55hBYGjboT2JZGnfI69242qPs2npa+9C5yafNJ9aod4ux32L8uDe56+Q9lOm?=
 =?us-ascii?Q?1RsW2Mv0wcqh4/iBGEOBzcGjXByijlx1wvCEiuRJwzvwRcR8B2QUt9OeuRIN?=
 =?us-ascii?Q?varEHZ+doOwOzs1m1AG/EFMN+pG954TW5BJYgzByQ/GPEki/hyFQwsDOTdJE?=
 =?us-ascii?Q?G3SCUeTjwQBiTEPUCkiVQPIZY7NxuHcT0xhxRL8j++k/NhcYyf8YsGFOCaVo?=
 =?us-ascii?Q?IAMGu9LdeJMYWxhzXeooZU3XfSLrH18hiW6y5htv7loOGYNk/LWJD1Wxt80L?=
 =?us-ascii?Q?0ouEFbKUIk7yBHufvGkuwWkJvzI5oOpaswnzhXODLYrH2dJL0Kegqj76lDSJ?=
 =?us-ascii?Q?qN0/mWNXNgHdDa/HXa8i33kiNpxe7I0ypx7/lr6DshGx7KWlQ3V9gX7XZ2EX?=
 =?us-ascii?Q?WcC/KjcrSW7NmE1k4QXV5803JFCALboY0silXLn0ATAJPLjDcaFdjabBCLBZ?=
 =?us-ascii?Q?0DTrvqOhPqVy6QuZMWLfJPXl+bgdMrJcRz2h1SUCs0aVXjaNx06Wd9COKT0+?=
 =?us-ascii?Q?ni+hwb/q8LUbz5e1cNXz2JcoVRZxO+CZKXMJroTMBbOK6GPEqWUA1r/5Z92s?=
 =?us-ascii?Q?170ompgL9TF7fqlrVQ0eaqm+Qbdb0qUSFbQoTJgbb4AX42kegpkS5WugeC/B?=
 =?us-ascii?Q?kxPmbj5tTvxKw42nIHuxA5kvNT6SdKhTpkrpfybOYnoVgnllHJ7OicsMMfPY?=
 =?us-ascii?Q?NSey2mONWWPQoIePb9WEukvqqualz2FX67RRnU8Qp8APPlcVbV7Uxh4hw3A5?=
 =?us-ascii?Q?91K7VtO/xT3UrwoSxUBmgVhgyjSUIbvLIgObOglhMBp8m50RPzAbDJ5J+xUd?=
 =?us-ascii?Q?SOct4iT2VaasGY0Fp6DwxJ8OLWaqkvVd6P4eXxzdANQdnl5ARwmwbIZb9PvS?=
 =?us-ascii?Q?Bbm8vUYesQ2FXA06xr07I3OkL0Pi7GUmoVGOB2Y8fTSBBxveE3x5HSg7Sdt2?=
 =?us-ascii?Q?uskRoBgouWHadwBe3Oz4vFCJt+hxhm9VOLFzzXGfDv8jO8ude2q4h45pJQfI?=
 =?us-ascii?Q?VuC3bMljtXMgbfAxXU8QSNo3bfeqQjNWTjQqtpiEzf0nXP88HmwPanLpvvV+?=
 =?us-ascii?Q?7MUmDkooA8PUfRjB20pvCoobLonsHa1mwCC6/xxSeKw3ortOCyArXOFjAhZ3?=
 =?us-ascii?Q?ZX7qaTqnEXNdnUJObqLRD6y2bJ0Ksxm1vNDMXAsu2GrK7Cr1LMZVBLwQ90Pt?=
 =?us-ascii?Q?ZhPFHV6RQS4O8S4ytxgb3qNYPcDtFW0y2OKI3jOP/ZTBqSfGQvcdDRWHMpSh?=
 =?us-ascii?Q?0aWjDZ1EuzhpPpJfdBRG03hQg6+WIqkZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 04:28:44.9260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3423a893-8956-4777-09f7-08dd18d32267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

Enable mt35xu512aba_fixups for all mt35 series flashes.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..5d8ff6ff415 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4404,8 +4404,12 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-- 
2.34.1

