Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF77AD58E73
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 07:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C69383F2D;
	Mon,  2 Mar 2026 08:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yqq0PmOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A51B83F37; Mon,  2 Mar 2026 08:44:08 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 009B083F20
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 08:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcI9weix2sekwCN52C8O2Qlw0Y7/b0g3Wh5nDBqcIGE9MV8w3Gr5jz7Zyq4qMGNplYq3wBeQY3rXshQxDtCQzPZuva+g6hESmptZsG1NR0B+OcAN419r/51gb+nqz4/siGxMSMK0y0/EcSfQZplbOVhf0BuLzgv9hYPoJghSYLTbpqc9kbqQQ9uo6kLqSBYniudjPMl2g50Bq+qOZE8Goud8VsMrxftxLYQaYrweuUMmL8kftS7LpNy+EwvcA8iLDZGCD23BkvCNk1jxuoFxAl2vjI8gh00R9vtmBAOfEmJ21QD9t5dffn86Nkn4Hxc+nXjxv+sWnNlBdrSgvJ5RRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Df89ncAPQe8RQdszyUWt1KaptpKSo4VWJAiLuc9zF4=;
 b=kvNlDkCi3L1qo7nDyaJmbVCnRymkSjp3eTRZ7xzOwS2d1z+AOSaZgE80LJdgsFhnod20Tq06ZCGo/7ON7FK7yhH8k58zYNuYl3iiWQ2Box4oPcVB/V/jV1NWLhUOspl97uI5uvN/niMWzUYrgWJnWplu09b+maE3q3ID/YQLW/aJsv/rFMFlQWd/D+L2pYcyMP3cg3Z3fwOXBnRcP/mdiQ/stMLnAKXJk/Ls8KeUQIwfseiKruhZY48osxgwQP7EWZCPR2F0qV4Vz0cP9lu22PZZmkPH+jcwsQ31AEcBH07ZKZMFU9PM7UCSjJAjpR/wdRd0JfqnsC06hiz8mFQdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Df89ncAPQe8RQdszyUWt1KaptpKSo4VWJAiLuc9zF4=;
 b=yqq0PmOYPBhvb5VNjdEz7XXe8Q2rfBQnwcw8V3I8U8YhLRZCi3LlO9xgXGSVkJGgrzuBVyyevP1b2x4EBcT/wiyDjjg5VsPbvyOhG37cVaTDQNK1UrR9+NJaYNr17lup+LqRD+7qtg7iEfZ8O5FwCyo99e41OY1QbdeXiQLSjd4=
Received: from BY5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:180::15)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Mon, 2 Mar
 2026 07:43:52 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::58) by BY5PR13CA0002.outlook.office365.com
 (2603:10b6:a03:180::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 07:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 07:43:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 2 Mar
 2026 01:43:45 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Mar
 2026 01:43:44 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 01:43:43 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Harini Katakam <harini.katakam@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Martin Kaistra <martin.kaistra@linutronix.de>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] net: zynq_gem: Disable broadcast packets
Date: Mon, 2 Mar 2026 08:43:32 +0100
Message-ID: <6e10793b7d72668343756edb66221f1415570250.1772437409.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772437409.git.michal.simek@amd.com>
References: <cover.1772437409.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=uwYjva/8WVj0P25Y3HwU+741qarVryuj/n603g8d2yQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQutV/h97vpmVFCw9FLDMYm1mHXXVO+8OSYZorMn6/uG
 V3FZLW7o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACYSbsrwP35BSGtJbpDv7sUO
 /juMZMTEhW5PXC2q1Cd6tf9y6eMb/xj+Ch7ISil5MW+b4rlQ8/2rnlzO1Fm8rOyN4b/Yc3fYVt8
 8wAIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: a26710a8-4182-4b69-37be-08de782f72df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: zAdA0k2T/D8FWKgqPBWVG2QA3fQ40bFVmOCvcwJQLtwc8+WTVuqKZB3pc8HZmXwv58VHcx72murQYuL2yYPbhApwOifr0r1fBk/DOyRJb9iN5fUQwD2kiy5KcyoHyWTHaRq5bo9buJjZMY30eB9kUA/71gcUJqMOCd+9kPosCKMemiN6CMChjiPDyM9a53mZ8sM5Nu7SuzhEBo4qiAUlEmHEyKsWkjHPNORB2AvGwJoZb67i1kB7JaJgvrQEo9WSO47HIBzGpZmPZPXHj7TQbtP2D37hERsevzAGg7LGH9fnjH+eWBYRkHo7Izgc2yptXfsW8l5Y8NaK/DSfy8t1kEWUyBrds7a34SK2OcVk0wCy4GrFcYOWQX/G2oZC2j64H8g535l18/SGuBc5BMIN5DqoS2Hjlavd5S3Yu1YxXc2hd2ZuTcRaF9/wyH4I9eshDFBa+fKrpMGisWjSCPlNQlBys/+UqIYqW9x0v9UY0ZoUWJr4yF+F9z+bA1u8+SkxMbbroJjIpfoWWHR7KbdLVOAzCGixD7HN1+nq4yVgV5hFuzS8fNoU6SXkRFgWGBKioA/2G2WwgA3VB82qaqGvz6TABA9GSa8bF/BQOXP6AdaHL+fPTZNIZFf1nX7qTtyNsUTc4iDmnJUDInoYZFtSTKgP4ptUyMSxrL1UKlRukgHHkmcDiykPHwjpyKqmwnYAduu6NCB2e2jT69PYzdcHB5V+gjv5eBJra5lHFelcXUvmFUX0F/FEhN/zj8BZpKEQBmz9qfE76BmrECijhQ8HoNfB3zmk8HAaPLBB7eB5F8UPaqFoHZAOt6NEsT43r4p4ipDq4CoIjvk7e+8TuDi7DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZP4sNfbkNss5o69hoSwgAYNYHHhT4nAhso0qmQOP4/3vucG+7d8BdpQpHOrDuVgvC4QAhqrEhyvUK+EY9f6rlnscm/hLeR2mqiTl0QmR3sgX4BfVYaqbYqM8lX//9Oj/hs8COFsl32Imipf+1YselZg9WRz5g6MUoW+WcnItjMBWNFOypCbIizU9xvmJeWbflAkJbR+FH04YWeBtlgLQNoTdEazSHuPU20jIELq0nguwc0lnEoirDGOhK4eq9i4q6TvNicFd5aHN8Mr0x/hiu5ivYlQ8nnSLy8qM40yOKbPMjBYbPpuMc7fsAVQG5+Gkm2FdnC8kXwI+Dd4QApFiPmxRX+SkRfG78N4BcmSPzOQPk9xytPpAtMNA7oyZds145wT6EjxnPStHlKwgwsHjS3weuOebY2DoGAEivUHp7RJ1+P+WRw096Ai6Q7lVCucB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:43:51.7853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26710a8-4182-4b69-37be-08de782f72df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

There is no reason to react on broadcast packets that's why just ignore
them not to waste cycles on packets which are not for the platform.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/zynq_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 407b022508ca..b05c752b17eb 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -64,6 +64,7 @@
 #define ZYNQ_GEM_NWCFG_SPEED100		0x00000001 /* 100 Mbps operation */
 #define ZYNQ_GEM_NWCFG_SPEED1000	0x00000400 /* 1Gbps operation */
 #define ZYNQ_GEM_NWCFG_FDEN		0x00000002 /* Full Duplex mode */
+#define ZYNQ_GEM_NWCFG_NBC		0x00000020 /* No broadcast */
 #define ZYNQ_GEM_NWCFG_FSREM		0x00020000 /* FCS removal */
 #define ZYNQ_GEM_NWCFG_SGMII_ENBL	0x08000000 /* SGMII Enable */
 #define ZYNQ_GEM_NWCFG_PCS_SEL		0x00000800 /* PCS select */
@@ -76,6 +77,7 @@
 
 #define ZYNQ_GEM_NWCFG_INIT		(ZYNQ_GEM_DBUS_WIDTH | \
 					ZYNQ_GEM_NWCFG_FDEN | \
+					ZYNQ_GEM_NWCFG_NBC | \
 					ZYNQ_GEM_NWCFG_FSREM)
 
 #define ZYNQ_GEM_NWSR_MDIOIDLE_MASK	0x00000004 /* PHY management idle */
-- 
2.43.0

