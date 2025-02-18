Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB55C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F6C80207;
	Tue, 18 Feb 2025 06:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5SxN+a/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241EF80207; Tue, 18 Feb 2025 06:25:59 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0B780104
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 06:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGpK3H+7jeFbNyv0JplhsIEV21WVbgYB8wtFHEAF3EE471uGW5qrU46pHGjmYuj+fpXJXpqk6bmeZNb8knmg7omah+DFSL9UH7WPecijdRxalT9nY3z+98IylV7yDAQhF79jJWYvT/rj3QqeDo4OmPFriQTdg5NGZqvwPZp9PaseieWbIg4vfAhe6v2emO1bGG4QzaHpDV37zu6w85duPJddGOl/wIBCIS/L1O7nIoeTL/RJ6wmFLr4pgs/0fZv33zaE4KAonhZGl0zOxnFbMLVqx2iMIj/Lu9qlNZnoBzqNivV0PX7JEABWWpsiK6Gl1M0Zs5nqoC0aui/x5d9JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au/chAVdE9SQOTkM2ypRrQ9JQtHXkPJg78EBOdJduWk=;
 b=QPBfOAC0GxZ/oKabODAl96nC2jp/zGBVnA6RJwpYnJVa/GMnLfY+xJI7Obpf8PREBdu2TT4tD5N/INd8x/oGaG/Vc7MxIfLy5qROx/pHPQquRKdkcxQUxKUmt9X1SAJm+r9LHyeHTDR3KcwXDafrpLAhhJcrxhJ82ROWIcxmEJJ42ISsUiavihp5WXlxIMJjLOIoDsH/tIAFAY24vzkqAJOcVRxPvLCNihUIOWHCKmHWAFsExzRgBlRf7+9EOMdP5AoyP4BKsS3JnQzhDuE7mITFy0+MWxHp3otozfTD8ScDbxlki4TfqadAP68PMQD7M978VBjYnMG0ojXD+aCufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au/chAVdE9SQOTkM2ypRrQ9JQtHXkPJg78EBOdJduWk=;
 b=F5SxN+a/XcKxHQoenw75f3qRIC8mWsy/UNYVV9qIB435dpsaK7gR3cyCuak+Xyy33PwFwd1SeV5TbX2WiNvze9S1wFRAcCwDrxrxA9BFsK3IWtKjh+L6sFVrg2gt/7MYkf/a8vE+Dkf6RBAETJRSjwwjJkXJFcmjTcskH1okTas=
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 05:25:53 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::23) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 18 Feb 2025 05:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 05:25:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:25:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:24:27 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 23:24:26 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] clk: versal: Store driver data in data section
Date: Tue, 18 Feb 2025 10:54:19 +0530
Message-ID: <20250218052419.1141139-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 916492df-9b96-43d4-90ef-08dd4fdcb63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0bhVkByrzGW6Z0xuJOGeFxVHcHROUPvobeZdE0m1W/Ajs94vedct/RO9NXb3?=
 =?us-ascii?Q?EiQvfCZdKOirDtq7zprLUy994WSiwVA11cCaZze6OmNJLI+5EtXkxnS7EwMZ?=
 =?us-ascii?Q?bPC8OBFfwG9Xe49O+wfjMWn12J4x7SMH6OVlDCwbW0jjLXk+r1c7Mh2nOUqw?=
 =?us-ascii?Q?RwhTfCDoOlQ4ecA2YSOktvuVGJyiqO8r2/51t3lWkKVL8Fq1zbEPySBHheG2?=
 =?us-ascii?Q?QQYIBN9dI57FuoepQtI+D3innPlErUUSEB1Ls4PbUwfCQWcTRh8Dnxr0Dh/L?=
 =?us-ascii?Q?Za84uz2EDaM5JQXOBDnvdIoaVGrunTRxXxwH4kIhoQH3tgaj/TC5pYQObyq/?=
 =?us-ascii?Q?MGqVYwRsCdpwtsayEOBxegDOG08+lc94MaC6MW7dg1Fg3a1uySO31iw1Sj8B?=
 =?us-ascii?Q?LRH+/rycOaIs0e2sSI0BHz3JYXGYbrNpZQJf06MKmpP2/EoCmypHmBSEmROp?=
 =?us-ascii?Q?P4bQu03pjOM+wStRCpgu9BGIdQY5zmdbixt708667RJidx9gjhVf0P1NOilv?=
 =?us-ascii?Q?zaIIZ5hXXWWdXLJ67ZeQ1e05KsUwZDSkRhyRhfpI1AZsds/KUbn2tYCrhCeI?=
 =?us-ascii?Q?9Ws91rWETIkuzezmOkEIv/Q29xUyStqGEs3Ip7JwDf2infXMQL/0/UEtOHlI?=
 =?us-ascii?Q?et5EYO1pPMM4B95cQZVSt1+6Pt83YqxJnqtZJoCffp3+uLRA7PGY5Ky8O/oQ?=
 =?us-ascii?Q?9YGyvobzrkAvturcWAqpNYaKX6q/stJwJqxiFBeCvUOJTu2M3B6oPApt3SLh?=
 =?us-ascii?Q?h/ur6yv1XvgeEm3kjt3h6DfFFmks7ZgJjUjHaUVM3FPUHZ5G31+Q0GtaR8xu?=
 =?us-ascii?Q?JZ2eRU/PzlH/A45SLjQjyq407shgL1/0AXA55+N27dutdSiAQUPYwy8GovjZ?=
 =?us-ascii?Q?77/mDVWDlNN3Bh65myTPpiWK00b8/NJzpKyp8YmmGcyS6KlhVU9hAdfp2aYs?=
 =?us-ascii?Q?dxJ2/ywD5Ai4eOHJATkexUuhwwmfQeFzp0W0RbjZo7MRqLtJvRSUozMW+b25?=
 =?us-ascii?Q?kLfsAQ3tnAYxKYx1AR0FQgzp1As0ehDjL05e6vKpEt11QRmOZxRlrUX8v9my?=
 =?us-ascii?Q?g2Ff83IMNMArBVSZpTBn5SIMbgnK+YpcdpiPQdJYroAb05QAqEfuYgwiVouf?=
 =?us-ascii?Q?SGYPSbSjvteHbfhHq6XcARWB1wbbQ8prK97MD4K8tlB48dk0GVa8W95U/NPN?=
 =?us-ascii?Q?KnX5XfbEQ/HaSTokV6kTZU8F/aE1iVHxZHzQzB8HqRHlaiU6nD3Cp6K5L2vk?=
 =?us-ascii?Q?8djvfHrnvnp1d7f6x96vCqhwhB/mPBUO86hiDWH4bVJCJiOmTsq0IGOKuV8r?=
 =?us-ascii?Q?ILSNL8NTBe7vF04r6QUAw//rzoKK0IyazwTCiZStBW+Nk8mHretvbXV+o4ro?=
 =?us-ascii?Q?eF9qrzw8sO1IVS4SIqkHwYnd2JwD/WPyzz7xmUuKLObEBHaWkCBHYevdPZXo?=
 =?us-ascii?Q?l7c62lgLHz4zm1gfEebw5UACYwbanyYPME4XX+QolYxaFRim01AFFWl4PtJI?=
 =?us-ascii?Q?kc/SXzlYJ+CIvw0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:25:52.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916492df-9b96-43d4-90ef-08dd4fdcb63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

Line 171 in README is describing that before relocation
no code should use global variable because global variables
are placed to BSS section which is initialized to 0 after
relocation.

On Versal platforms clock driver is initialized before
relocation (via using dm,bootph-all flag in DT) and global
variables are initialized which works if this is used only
before relocation. But the variables are used after
relocation too but values are zeroed which is ending up
incorrect behavior.

That's why place variables to data section to ensure that
values are not cleared which is for now the quickest
temporary solution. The correct way to do it is to move
all global variables to private data to avoid it.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/clk/clk_versal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 35ee56d0693..675bdb7ac0e 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -106,8 +106,8 @@ struct versal_clk_priv {
 	struct versal_clock *clk;
 };
 
-static ulong pl_alt_ref_clk;
-static ulong ref_clk;
+static ulong pl_alt_ref_clk __section(".data");
+static ulong ref_clk __section(".data");
 
 struct versal_pm_query_data {
 	u32 qid;
@@ -116,8 +116,8 @@ struct versal_pm_query_data {
 	u32 arg3;
 };
 
-static struct versal_clock *clock;
-static unsigned int clock_max_idx;
+static struct versal_clock *clock __section(".data");
+static unsigned int clock_max_idx __section(".data");
 
 #define PM_QUERY_DATA	35
 
-- 
2.25.1

