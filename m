Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1C4C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 09:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B83807D9;
	Thu,  6 Feb 2025 10:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="igN33O8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642DC807E0; Thu,  6 Feb 2025 10:15:57 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5815807D7
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 10:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etBpjpXus8yRDZG8Y6eN3N3rD9x+ZzJSPTucYwzz2SsJLBohlAIMPDOXiIek5ys9j1nhKMso7tbz3XIN8eb0CylvsxkKODSmFSrmIVmwWdt5fOqixXYVkeE/G9mscCcNoYkLNAe8c+B64iS0F6wzPScHVq7Hh8S/zQNJcY1IgNUYb+shUxmiViWI7cHY8G+yiowRUOUH87QqRKvRg0oCzi99VBozl+n3bhYYMe7qggWwQWeXkxKTq6EHbUMBNpVQPC4ajjhcrfr//HltOqFCaekkpD3A9rpbZrFQkIwTUr3em4o1OIhmP6f+SbBlqlovh04iEvsPmhPQo2GDrfLVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaOVvDDZJYN7svEX5o4yltYy64s9+oyIeY4y/d9SzEM=;
 b=vmvhWPmNKqunbqbenMin3ee9JwGp3U26hzYOzI6+5aBXUVokZLTmnCsLOjp3ZxCHgenZyKe1E2OUoOrG7FImYfZ9OFymGiuA6kRZrpBQ8r8gO2RKZ8xrJowgPuV0hymvIw8+O+QtTgwb6Q1e2bwnZx7f9bM8ImB7ZYb+0rTkUX4VVr4v26IZDYTVTHLHQZGdz0eRfJ1WkPbDLumWAH1hatQ4iAXtfmne28kIv0Of5+QFyrQ2XdvUFoP+42mOTfuvAcwJ1NJVJSs4FDBHRtP2o0a0ftfVl29Wp19W2JHS+BHF69od6Y1H9gzW2hAWUv4GxgibrN9werVSD9BrPty56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaOVvDDZJYN7svEX5o4yltYy64s9+oyIeY4y/d9SzEM=;
 b=igN33O8TAIP4PHpoiIztBcNmG3gQzy1DetK5sVcZiEgA1JtK9naoq4Pm3WU85ttA3E7fSLsCKniTgp6JnZIOLVwAm/Em1kpCO5jUHo29NYgD+lzEM9WV4w5Mtu5M1K5lr1ja+JhBuN+92YxgOd6QFfqSL3TYMUg8RiMGpz8pkRg=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 09:15:49 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::80) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Thu,
 6 Feb 2025 09:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 09:15:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 03:15:47 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 03:15:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <lukma@denx.de>, <seanga2@gmail.com>, <git@amd.com>
Subject: [PATCH] clk: versal: Update the reference clocks as per bindings
Date: Thu, 6 Feb 2025 14:45:33 +0530
Message-ID: <20250206091533.1447234-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0489ea-8bae-4d3f-83dc-08dd468ed8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QtX4c+GJ6FKm+FEzZCR90+cXfrEO2caJQ5skcLkunMdZvJlPpEe084CDY5I4?=
 =?us-ascii?Q?piemA04Afcd5LDL6oA9Bv2zPDptppVxf/Sro/6Mizj55s8jyMuFH6oU5cS7l?=
 =?us-ascii?Q?T2UFPJLRWIh+nMeGsSwmlnqTRZudlg7bGjT/9BOEOpNFWiKoCWaB6Xhu7kVS?=
 =?us-ascii?Q?JuTsJGH3pePAVkzrE8he3ahBEyusu4yB7NqC9A9qpnEIgZp0yDgA11WR5koQ?=
 =?us-ascii?Q?q0oQ2+2bl+iCS8SmG3NPrm966aBqEXTqU9IWykwU/5EnIJQI80DbGxFk/buZ?=
 =?us-ascii?Q?4WV7jjQqu9ftUeplvXnEbLCjVyP55tDuhEAbIWZl4jiX19M5KQobs0T0qxbv?=
 =?us-ascii?Q?pneUHyrrGZKEzGry5iF7AvvVrtn9xclqittHy61zyfOuJ134IXpwIRvMg7Ku?=
 =?us-ascii?Q?wSBRIpZvVpKbIBA1pS7Alt1ZEL/XgXpBqwfeILBtTD/Uv9dhPUvHxu2ixV3R?=
 =?us-ascii?Q?9Q7XxHL9O9F3dltVnPq3x5IImj9t4Fa8SC8fZvkjNwy7ZKXyAzNw2khJllFv?=
 =?us-ascii?Q?NFQgDEsPQg3f584bDe4d1jb2MaKKXuTIIqly/r+XXSDfkA/4sR7HNjez0QuL?=
 =?us-ascii?Q?3mCGQsqUcIOtTlS06jjhOYX5r41hpuY9LzkRNACcQ7R+bp/tAZQcImYe/tIq?=
 =?us-ascii?Q?/SqMVsAIx4suJI69mgRgJgSUZlBI2mGo4uf64P9byz//COT4cBT+0DFEGTxo?=
 =?us-ascii?Q?KQOnco1O0MtG6UO+Yhzz8GlNIJVBWDnLxnV5IwrhbZxS4bvccIFb7hfnhWMe?=
 =?us-ascii?Q?anVChDQeLlRyWl6N7xuYtdUtJW3r72WL9kXUh/0A8y81X3nihD+y2ZasfWU4?=
 =?us-ascii?Q?qXRSCjCH/LYM840fDm9fKwd6pF6RIEPOeXlVeiGd73Nv+TjbwqsG4b22aMjq?=
 =?us-ascii?Q?GeWD73AKuXEBVaazej6p5OHneF8K+4df5/npIfSYeciAyfjQZhCzMeZsV2T4?=
 =?us-ascii?Q?yw0Lc3QWxjIMTHw2Wy+Yb7A+w+J03xiO2F7u58qz9NEfnfeiZiFCHyjbhr4T?=
 =?us-ascii?Q?GjWLytBiB08G7LxSz3nGkDRV0CkkU2MH3U9cjMW/JKZoEmtR85ew42cfDrIT?=
 =?us-ascii?Q?R9kI2cWYOyfynK32Gkdvofw3bwMaJcqWYBv16XiWzkUU5QVtQa0QPprEVM9i?=
 =?us-ascii?Q?FjDIW/m52pqBqcOnLl1K+Z+HDgk9OvqIJeh+j3Sl4J30bI/oKFl8fx7Cynfy?=
 =?us-ascii?Q?bvKoYWvig5QoZYrHDWOC0BTamYDpkTGOGUm1APP+E18/7OCviSV8v23/OBUK?=
 =?us-ascii?Q?oqlCDj3zE08UlGQtFd27gFrEx3gqlijy/ZW4Sr6BAbGKEIpKFp5OSrWOXqSZ?=
 =?us-ascii?Q?qqqd2sMB5g1S2ZdsSi7585jIYe8KrGUPL/Gx4rwQjoH4IdDNi5S4FFLMd/2r?=
 =?us-ascii?Q?jzbhmpgtXdkOKK8dsGGFVoCzP5ZHDRmYAdrB6U2EG+oxPTIVDwUp6hDhZavp?=
 =?us-ascii?Q?9NF+GyyGROc18q9D+kvNDyHysTMPYUzipzHRhFyvuMU6ZJyHb45HwybDHA0k?=
 =?us-ascii?Q?8coOKEpB5ycyk6A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:15:49.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0489ea-8bae-4d3f-83dc-08dd468ed8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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

As per the bindings the reference clocks naming has changed
from "pl_alt_ref_clk" to "pl_alt_ref" and "ref_clk" to "ref".
Update the same in the clock driver. Also add the fallback option
for older DT bindings.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/clk/clk_versal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 35ee56d0693..3e471670a87 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -679,12 +679,21 @@ static int versal_clk_probe(struct udevice *dev)
 
 	debug("%s\n", __func__);
 
-	ret = versal_clock_get_freq_by_name("pl_alt_ref_clk",
+	ret = versal_clock_get_freq_by_name("pl_alt_ref",
 					    dev, &pl_alt_ref_clk);
+	if (ret == -ENODATA) {
+		/* Fallback to old DT binding clk name "pl_alt_ref_clk"	*/
+		ret = versal_clock_get_freq_by_name("pl_alt_ref_clk",
+						    dev, &pl_alt_ref_clk);
+	}
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = versal_clock_get_freq_by_name("ref_clk", dev, &ref_clk);
+	ret = versal_clock_get_freq_by_name("ref", dev, &ref_clk);
+	if (ret == -ENODATA) {
+		/* Fallback to old DT binding clk name "ref_clk" */
+		ret = versal_clock_get_freq_by_name("ref_clk", dev, &ref_clk);
+	}
 	if (ret < 0)
 		return -EINVAL;
 
-- 
2.25.1

