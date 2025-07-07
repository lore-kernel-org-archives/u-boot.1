Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E6C83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076D983015;
	Mon,  7 Jul 2025 06:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMny4KbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F9682F83; Mon,  7 Jul 2025 06:06:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BF382F83
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBmx1X3o2Ha7d7scaiU4sVUYyWke+QyN5wiMM/LHJECw+IlkxC3aiiw73Bj+rMN1AgPCZp8dHKvckzj/cP+iUFCJmi8czBxu6V9o69dZ4SWqGspwl3u22Um3/Y0jJBL5CZDBhZQu6lR7oAZiJQ5P+w/JK0Qzd0WbNhM86+UNAhMOdTmQw9SIi7HMXpxVPzLeuzUeyEKGpMjCyWXaPPbapd4lO8AL8XpmiO/CKRYN2p85+ETeLuqeZSWLIJR08wFdPakQk2qWMA3aqP5oYGcxVeel7M7IvMDc8xmt/G7pJ1Ji6xuiMfpQjdXO4I0EvSLc63OCC4ENZMsXthwaXZqUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ZbW56oks1S2UdAa18X/kHmIlnonuapzysrzP4locc=;
 b=BI6ulMbGV4G6TweYudVZAe5p3kPGLZng8sstH3doHxDFYj1isa18/DVmpa75mBcmPLsBwuY2zrn0w4Mu/Spuaf5DJKk/LNYUbmTbf3c/42NK3YLhcO12DS91CYS9y8pkdFZEXGBIrsxPCsI+B22INWkcv6xmpHYKBia2dUH8UwUgNFM68DKcGiOutDNln1UiIvhHM3HaMeAmcQuIuG6PF+o7sd0FOqv/xW1A1J3vv3L/wvMHnSdes57Em5fIQSCNnVKJLpd+akt2Fo1MPwEk+WhlOERSWvTZiGiOk2j7rSdroMibX3zz78cMqzhQMWQ7MNkEDMBDiXqaSdrEMXeM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ZbW56oks1S2UdAa18X/kHmIlnonuapzysrzP4locc=;
 b=MMny4KbAl2BuiiMDNNNRGWwFnA2vsQAqVIv7Th3mb4i+esioQ2dOG3ay7S3r1j5vZYQbZsKzU7bAzG7CDUHbihnpGM1r0eOCIo9YYNeWOoQTLhobycCMlZWTc/wMz6V6XkyLRwv5naNwlCvOP9CEMzLA06EH0zmbgZyD006o8Vs=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 7 Jul
 2025 04:06:22 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::4f) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Mon,
 7 Jul 2025 04:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 04:06:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:06:18 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:06:17 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 2/2] arm64: versal2: Do not define do_reset() if sysreset is
 enabled
Date: Mon, 7 Jul 2025 09:36:07 +0530
Message-ID: <20250707040607.758919-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
References: <20250707040607.758919-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4775459b-a182-4977-8157-08ddbd0ba220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6xd3j8ddtp0Gv5QYSHj3FQrgInD2ZAToEGF+oJnrHjXHycfS93SKhzD0bHRg?=
 =?us-ascii?Q?bJDI/qkYly1t1A7u9Qeuv0YKaalRMr2uPVyylMxRFQnHZI1at3UpGhcKU9ne?=
 =?us-ascii?Q?DzFuU80Ui6MsMo5CJJ9qLlnU3w1kEaEBjKPeu7IxvUoW4AVKaISWsJHQObQm?=
 =?us-ascii?Q?pseWIiOcd5z9tPrbUiBV1aO03hcgm/kFdn2GJSQHzXXvxhBu/YZtnymQ4VPz?=
 =?us-ascii?Q?NY2HOy0GBryYMyx3PnEbms0Flb9x+5+F7t1ZXFXSbiMKHUI/PNzO6V01d96G?=
 =?us-ascii?Q?qDck1S1xJB0jHjwBOSrukbSIM9vOP5pteB3xiEkQOkR9hKQL9X71q1sIsLbA?=
 =?us-ascii?Q?N5fCG7AtWnOgFcMSd2NHw8TEh+pb7iOtoGlGDQ/Dag4YAMG5TM0xQ7hLl531?=
 =?us-ascii?Q?AReIsM19YPFhpjMZpFhzMaYyeuoY2bCpNVHG6dkvKQ9dkvvPspocoYEe0RXH?=
 =?us-ascii?Q?WaFI1QNyK9W+STcJGGzmgZwwicHMmzbwjJgOg7NbCGhz/TeOQEZSgiPG3fM8?=
 =?us-ascii?Q?/P4Gk0QgEPX3QpQzJQ4N+8k/BY6EAMDI8L1xhXJIwxwY+82fob+OnjW7JgG1?=
 =?us-ascii?Q?ArnEOc++GqNtgnQnukS/NEUl0dnGwAw2QWeWpPHQhvUSCG5teXeAM4vA3R+A?=
 =?us-ascii?Q?eK574DVhMbn6T4mOrxswS+IJoypnTdr4z+L6Sb6k7d1QwYOp021fFT5IPRdb?=
 =?us-ascii?Q?J7oDMIuMqvcRhNZxj69QzFpAt8WQ2A8jg33kJ/onvSZjRmZPi9zPZLkLmSqk?=
 =?us-ascii?Q?jCxCVHdFG0pj7uNb/XGKcySngfMxnLAu2qtobRYBb4jPbZkHiofK9JSIVxpb?=
 =?us-ascii?Q?c/e6wYueYI5oZabtRzfEGrPgsMYiYTAWFHKfAO0AaR2cCw7lg9Gr3c6JHF8P?=
 =?us-ascii?Q?nulmzCgz9InexdfIim+beY0ddFfekfBNhu3sn1O1rJgYdw283NZMcOLVFm9o?=
 =?us-ascii?Q?thOzC85inN8xwkHql3q43r382UPullrqamaBexoZrnQb5M5Ch5A8HEQEkZuW?=
 =?us-ascii?Q?30ABf8Nn3reoFN+Olh+8RdzacTh5a+HJew/HT+iT9LbEpO4Aw51svvtTnyxB?=
 =?us-ascii?Q?wxcVMVf+yq8NWz27H5gNgEQxG6kPV1BfZLnvEJlN3siPc7S1DsBeKPuHgrxS?=
 =?us-ascii?Q?W77DsJcXVZt4nXElmZkyFkZEw8khk97OoEQim6sB1jaINhjRv+6lbdnYEcJr?=
 =?us-ascii?Q?k37jBP//LRhPFf1caFIEIX6NsV7rcYO1BpHcGg4oIpNbEKFuMHuiUk8lO0cB?=
 =?us-ascii?Q?iiS//sUE0ncbCw75fydBR1aY3uuuFxEI3r+yB2c3nblY58QO0eBguxGw0/aT?=
 =?us-ascii?Q?yRe/YNOy88Lhe6dwVBp4ONtOaTDt6VgsKeF6Bk12qX5ZqKTc44Dy4TbjtgoO?=
 =?us-ascii?Q?EvbYNrGE8AUPP/jlNy1qcYRr8W9SQU6hnJBMeZtKP94L6XsUzuRuTym+i3S5?=
 =?us-ascii?Q?PgQMBb6nYDf27MmVZQoVBxW5vbWNVe4gQpRG/i3ejLOzedVcWWkcfwtov2tZ?=
 =?us-ascii?Q?YtfVWJBvFsoASrGR2m1DygQksSNp1K6qFc7l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:06:21.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4775459b-a182-4977-8157-08ddbd0ba220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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

If sysreset is enabled reset_cpu is defined in sysreset uclass
that's why it can't be in platform/board code.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/amd/versal2/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 72967e69a84..7d91d288d2e 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -365,9 +365,11 @@ int dram_init(void)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
 }
+#endif
 
 #if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
-- 
2.34.1

