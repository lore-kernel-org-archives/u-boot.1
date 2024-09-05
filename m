Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23458CD4F4E
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B95B88BB0;
	Thu,  5 Sep 2024 05:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aR8KMJws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C83988B94; Thu,  5 Sep 2024 05:22:45 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580DB889C3
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP5Dk3IcLvCRavdRiT/V5PHjL73sPM+AdbYpssiOJEWMNczAlmhJZsLEEoBrJHC749nW60dR/XiTnSkL5YBj4huwYShlXVZh8SoxjZa+xgBB9wpqgOfVBKOxT7l91gcUpV/mUhSLfynapmLg1sOdp+2aeO87saqSL1ICegSKDbC4+KetWGPB3GLQpllOfTGZgKQ+647sv2Mi8xBjIH+KSIH6jXmnjT7mJOkCJ5a1QV1TkKniLnocsyf+KVxilAiktAYQlCs7oebVDkIHBC/nuAE9Opksk2fAc4on8MT7fkjp60LriXBfiwsE/AMgHbbz16XVCvoxwP3VogGrWMWj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwJWLzOT05kw4o2GE1j0jxs9y5+k22BUbHqu70IOmyw=;
 b=msipy9j6pLb7S6+ks1PMNXCa/6RAZw4QQd2ZPF/Be+UG9O9WVy/M6WlGjWNW/eSLRdDuE0HKrjFn4S2I8+AgprCPOQOZJcMXIuaMPoNFJrqwmrmkn1i/NcWgFyFka8okQ5nJ9ivRBLuJhz6+5inaY0ECuEdKODJB/xXzxuQkc3W9Awp7Xj29P3C21jvuuWouieFq/LyQRXDYVNWkdwM72ojTXVNMw6C0tTV6eli83fNgvE5nF+cYyqApG8lYDRaDSg4uR7/1is77JefxtNaWJMqmTu6XEQ8rzMpf6AJ4HnZsQQhMwU4vOOcJ8ASpuG5xIXwp0IMA42ieQR6+0Pun9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwJWLzOT05kw4o2GE1j0jxs9y5+k22BUbHqu70IOmyw=;
 b=aR8KMJwsSkqfHcOLAPbKFsYCGI0XLLdiBTI83iskxreWb/uhRlTAMJ9/smzqrJ+D7IqC43URIpzTuXM+AVFdvCHY1Aug6offvmFgYCPW2a0lqgjbAjt8VOrn3sT6REkH27fYUIall9L+S4LkP4xeN4NDitn9at6DRMx6hPcbVfE=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 03:22:39 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::fc) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 03:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 03:22:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:22:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:21:57 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:21:55 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v13 1/8] config: mx6sabresd: Default don't enable the flash
 lock
Date: Thu, 5 Sep 2024 08:51:39 +0530
Message-ID: <20240905032146.2470396-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: c111a7f5-a485-4b69-fc34-08dccd59fee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VfMCGjjuh6juoiaocDCh9qIpSxYsVrGhNs8PgnAcWredANZB8HaShAZ+GSDx?=
 =?us-ascii?Q?7YgVxlgcqUvvkeOfD/7f/Xc1pTHhRF6xSVGKPqaYjF2n9uhVNPZKCMBHmLDb?=
 =?us-ascii?Q?0jDX2ZtDlpFKEbzEnC84ecgofWpQM3fMSFEmNsDmw0KiYV9WqD3m7qkdNtvb?=
 =?us-ascii?Q?uvtQTaQrdXBZLzQzUmSM5UFe2sWlDnX0A9/uFG+K6W9/lfpi/KdMxduKu/f6?=
 =?us-ascii?Q?KXEfdVhkPirzafE+3GuRZqou+6HZpZyusBl6e+qikg1s7XXIGsCb0XBKVi0t?=
 =?us-ascii?Q?5PGChpSY4w8xST6uo3Lr7lqkUk8aBMdB/qulRM+pv8bmljy3hw0vtGDe9usr?=
 =?us-ascii?Q?th39Cyngk+flmw3nYULDQ+OJLQcS49MiOAVFsSRmmzMyA/VJWN/amsf5n+by?=
 =?us-ascii?Q?tZW61XI6zYGVeSokyrgpRLmIotQy26mRhWmVEgLqHe/Xxw5r7cIRsasLM7hy?=
 =?us-ascii?Q?1ki6IA5a9QxTYUMoMS7988/XiZ6lKA0bJt5U1flFoIVcFt1JyFRpkGYKsRfO?=
 =?us-ascii?Q?WQf4/63w4UVv+j81ebnB0FvgqDB+H7X2msFGqp3iL0a61GeUjr+4YpVKnntN?=
 =?us-ascii?Q?eJfluWYneqSPxxaMmcvFRIDeM4ad7g4MY9+x2sQWhk5nr0J5XBMuarW1MNtT?=
 =?us-ascii?Q?dGUMFrNLxSUTBoKjO6253tkkm+/Tk+nQSPv/F4Bq4tfhFPsXneVPQ7LP1Yml?=
 =?us-ascii?Q?lbMGta6S7bDH8f2K1TyqUoExSXKZnEGHWVyGB3i0uUG9BbfULHbcw2Aqiyqb?=
 =?us-ascii?Q?oNkJb9cuomuXUT3T/eltRebkhTHIPmxaplHHyzBQ93Plv56VflsuoL6fqXd0?=
 =?us-ascii?Q?wDYnuJxWJ7BlwQcfks3om2KWffKUDTQD5eyqg0nlovJThaGYOCaFujEbVQzM?=
 =?us-ascii?Q?6WTd83XH72/3GNYqVzbq8mo17OEHzRxbDsS/eKBXP1X3DZh+/KeIS/oJsdRp?=
 =?us-ascii?Q?inIB5GUWysJUzyhWsiD7hM0OW1f+45jmz9fYVcm6bn7FWyOfOtLL8JxsET+L?=
 =?us-ascii?Q?TwL2V6b63XI9S5HwrwcNEPRctCoPGuXBjYDdjacxVfD/jgSkvHTxsSpYz3Qa?=
 =?us-ascii?Q?dEzq1TQpUpgV8qzwo0KtbjRacAESDPlamWmfY1hvw5kOn5hAh9dvdRB8QnOp?=
 =?us-ascii?Q?j17+damUtaE704p164zkbp+CZMv0QRuwmv5gZE5ctkD3ViUulWiomKdGyRXo?=
 =?us-ascii?Q?7Oq2OoQovvbosVRnrjUzVxKLX34EXH8kCcrbsNUbGeb7fgawSxP4NbQORlwI?=
 =?us-ascii?Q?ZoKwVry/XdN/IGPMbdnSLgfwaHaf9Fb6d/N+Ut1nDxJ2XSD5VZ29sd8LnHuk?=
 =?us-ascii?Q?d1ra3Jv07d0fDbHqwV/HARnIIBAdvGVvfvSPqSCHm7VM2ADhDHQf/9btml6n?=
 =?us-ascii?Q?4YPEs78DKi858UlbV/r198oXp0wj/ks4M6xRU+k3d1Jt3fXujQXXaYZE9YQI?=
 =?us-ascii?Q?nSlU/POEuQbClKa18tgDdbdl7PniFx8y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:22:39.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c111a7f5-a485-4b69-fc34-08dccd59fee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

By default flash lock option is enabled, enable this option only
when it is required. By disabling the lock config will save some
amount of memory.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/mx6sabresd_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index 80f7cd60b5..2a83b8cd06 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -86,6 +86,7 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+# CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ATHEROS=y
-- 
2.25.1

