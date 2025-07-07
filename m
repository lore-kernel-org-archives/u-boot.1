Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB11C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861CC81D6A;
	Mon,  7 Jul 2025 06:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kNSNu+Ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BC38301E; Mon,  7 Jul 2025 06:30:55 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E91281D6A
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgR8JdkqtFiuuwNC1gcbyGszlLQ78/b2bzOoTBT/cOJ+Uvvvma8KKqsk5Lp4vRbyYw6TEgsuP5Z+BHP9lyN2rMbzlUqz/Sk4QJz6uA2DEz4YqmsromZnu5AvdTDp0T3WEGw2QxlHddeoL6ymyvjeOcz7vXizbs7laFFauMHcnW9JXhmB4LB29hq4/FC6IYMiVmyDSQvplyzahTeluiNZptv/VAxFP+NUaz5lfuio4G7AoZMj640O9+kd/fIsmybbPqjzJrjbyb1369xLDTzdV1KRtYMWsau1bxBdTFEvycluEfEtVoGsLoAml4a2hIHczGl/YkxbGgc+agmplqb2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LEe4SqWScv1abi8nP5zVpDRQYRjEAST7W2qTUbT4kw=;
 b=Rb64FLT3J7zVQEiknSXFymW+JRuEntBLS5YonxJqZp35YtyuxfR+FM/RPWBSX9GNIe7VHQZkt4sjKZ2MocqnKyItXy411t6I4QTfM1I1OItgHdKGHE4/dQofyCdETgs1LFF4h4wMiFPqsUFQlg01HDdUgVN3E1uyek0v4xR0BD5+5oNTaq+qgh9PehlzYXSl4dTfhvaTbAvLByYIHSD2JwIZX8/xeK7G7GakRqxZ5BCEd3LDh9z091VhVMgDVj9GlP5mzJQn6MckwOXg+3Fvcay3pKpGHQP5awNNTkJWmVsNZ0w4VOgwwGslDX3MiJr1GswNhLNlGi7tBHGZyXXT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LEe4SqWScv1abi8nP5zVpDRQYRjEAST7W2qTUbT4kw=;
 b=kNSNu+Ay23gIss6gBKn0hYJtU8MK3MHKnKx6tJtHQkTbKQGG6lRnVgUsV3xDjKtnEGim8Xd0ArveqUEgwbddt1aJ+9peOXj6xd8pV79BB2YjLdcwjWV95Omb6Z3/ZNFV+xquHdbrpES8E2qsU+j1qQ5X0+jJk4QeEOeYzBQVZN4=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 04:30:48 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:70:cafe::9) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 04:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.1 via Frontend Transport; Mon, 7 Jul 2025 04:30:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:30:45 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:30:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] config: amd: Enable the SPI_STACKED_PARALLEL config option
Date: Mon, 7 Jul 2025 10:00:37 +0530
Message-ID: <20250707043037.792987-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f256d5-3b64-4462-44c6-08ddbd0f0bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?610sHW/U5N+DyhFvTwQGAqnsfiyL0YdwMH/SnqYI//lvmUGYonl6j6eQOSs1?=
 =?us-ascii?Q?1isakzl46Euta5bz/y5Wp8f2fr9hXDDP/2fGuONthmnnKVgF26hM37/3sxS2?=
 =?us-ascii?Q?jQvfTsmPw+8o14nNnH0bUE6t8Nn9UUHLiC7MUYxCyX/SnKz5c1QLhsGWp/j0?=
 =?us-ascii?Q?wHdBmCrrixTmiYeI+we+0ISd+WMa4EUiTLtcnw+Gnkg0K5+m6d3iBgWeUzcE?=
 =?us-ascii?Q?i6E49hOItyZshM9u4azGUuFClkAJ6N28pNhWIKGQBGXIHccJykJCsZbtU1Up?=
 =?us-ascii?Q?qC1abR3yHTxavXcOAfpFqQJJvFIEHIeHkf1oqnYCHB2n/VOQgbn6cpjnHJBo?=
 =?us-ascii?Q?DbAYSiVzoUGKfMmmfHu3ouxXNumrcPh/qV92+4Xjv22YUmOoxjJuPMcVdzpc?=
 =?us-ascii?Q?Hpb+z3F+jUypB9OhviIiUTr6efNXQJc1RbPfivh49q84bmzEj1YJ9Ap1C284?=
 =?us-ascii?Q?kBQF4CEEAROezp4Cdk6NwQhRQFRxWyaWU7pxIADqhLBTFY7S5nyd6g3oqQXB?=
 =?us-ascii?Q?fkbRwjBoBEEz+Q800SpHEDv9i87mO/uZHIHt+GfYN9xs9y8wNqUCVxy026Za?=
 =?us-ascii?Q?fM9gwfuymIefNg2VD1csm+I7ma8kuVa9gou1wTm41wOACKl8AewgLCVIswss?=
 =?us-ascii?Q?fqRKDt228N8n7lhzYiG02s2pwZkks5oqUOzz2PUw5H0HxmPshzeuPe9P8oWd?=
 =?us-ascii?Q?pl7vp0FWjk+XTGDBh86bNSJnymCnqHuXpYuONjW2tQRs4Wc0YaAxC7XOxKBw?=
 =?us-ascii?Q?LVxmZXOpel9oXZNZTL68pIneV8f4ATTk64WsduOdpQuJrzKOIClnTqmBwTDW?=
 =?us-ascii?Q?vQ9qoeEZwzMtgKTWVx3oxiMDjpTWB77be3XF1HuPbn12kB8dEgkE7WjDM5KD?=
 =?us-ascii?Q?7ERxO89fTUHFDbnw9wEIeALG//rXD5ugvxrjwGT/QnMPedj5/9S4XfSp3Pjj?=
 =?us-ascii?Q?Fc8pH8vBDOsYSNU2nMKOy504CN/XA3kcyk8Yi74+/67AL5KAVkhMpMEE7kLh?=
 =?us-ascii?Q?pBKZHTGnYhVsGQaDKxVu6Gs0NskPqr3y8tJ7RskA3lR/4n/lUusCzRlJ1+7O?=
 =?us-ascii?Q?U2a3uJcz3ywiXVn3kPqmi7SuZtkgsWEwxMXTKX2kOf57RAnN5qI2Nqrn7o/k?=
 =?us-ascii?Q?4dVsfa5lK3yF/xX9CySTBNacRSSA5i3/9/Twakm7Gs71iOuTfs1sA6prw4K6?=
 =?us-ascii?Q?iikIwWE1evqVkq7n61vezlmdmIlkV1RIgdS5n16JHH7uOFHZXSEahtPkDeIp?=
 =?us-ascii?Q?0XSWFUSm9ekc95PABIfES+7b5/tcytHRa7AQAuYt5RJARBjikSjnHnqqxypq?=
 =?us-ascii?Q?8P3WzXniWPIZvq55jlnFwHFBAt0mIDkYv2WNyTz5W/yHkGMoaETw7GiqSH02?=
 =?us-ascii?Q?EzR7oqw5o/YPxCqtxkKTCqhIg+/Chf/2LF6aSZc+LjULe6sO2u+wSJrHrSO3?=
 =?us-ascii?Q?pHhTLn+0Q8GOdTsHCHcuDfVB6NgVaAxHIOCtLzkPIVZ++08zMZwL3NTSEDP5?=
 =?us-ascii?Q?uojwVr75r5FWwPwhhI5eCbUKP6yOerIJnUrG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:30:47.8128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f256d5-3b64-4462-44c6-08ddbd0f0bea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

Enable the SPI_STACKED_PARALLEL config option for
AMD versal2 platform, as this is required for parallel and
stacked memories.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 15ac0211828..fc4fa571087 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -130,6 +130,7 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_SPI_STACKED_PARALLEL=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_TPM2_TIS_SPI=y
-- 
2.34.1

