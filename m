Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979AD0C602
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55EE88BB2;
	Fri, 25 Oct 2024 13:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UQNNIRMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69DA88F68; Fri, 25 Oct 2024 13:56:24 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856E3888EB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej5gJ/b+Nj/g9ZDxEvM07nBTQVH3fqkyeVFo1whj1bftKy7ep/q+9cHFmZW5Po+rkxE63dt8dytx8BSXk62QPpy3MdC0B2Pt7UbBHNknIfRRxiLzvVoIVHycX/bUqGBU5AS1632EdbQJiqq2uKGCgnWQjYfr5y7pz1o/NcgrvfiQf35enFPtBzi0TY2HkHSg62lQ3W9l4CPFxdbgmyumqN8DUStwUxU910p7JlmKs7/+pONvJKmuZuBazLaPk8HvP+JdAgCprIIJnPWeiHFruYAArTXcOD51pAWR17v/CFJ68bqS0yfH7JUAYHAJxfXm+9zWL7+ms4w38LvQcXd1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REsxIwMF7u8Wu0wDluhw2TaGFjp2CtXtFuE/09tFMVE=;
 b=sUlEmDYiDmIsGppbClRIWKbZRLmDbEOeXdq2yzcl27gfG+RfO7DZSnr58hG8wDIiy1FjDGeQEVXBMzx3xJ4yzyiX7h5Hqkh7ORPBw7keZuiGMVJb/WhNFHRbRdpJ7IqD+n3aFpIorko/A6JpwoaNwWmANGwVUAmANNeKZVdBP3Q6zs6E1EaLAh9Y/D4DPRFwoLk/m6Q2Nig6Nn0X5sc4EQ/LdiI1S+CJNThz2xA7O9tZu8Ajv5jxUpHZXD/G1rBu1t3JlMVqnVWOkP2g+d3EPu5rVtp7yIzgUK6hxrd2N94eltXnrwzSG7zjOIpWawD4Qwh5dPMPnuVpzLqEzzBVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REsxIwMF7u8Wu0wDluhw2TaGFjp2CtXtFuE/09tFMVE=;
 b=UQNNIRMskxcMUfH8oF+r3vJpyYsM78eZu837206YT/lQ9Tip4hNNOuQm1UFHsc8b8yROB1tJv55Km9qUFM3I0I6R31mDn/jypM2EHJx5DcmLB1YEg62k+7F8O94+hSsCueihEZbNQtD4bralcTYgq+jwfk6Ckz4eqZtRjq0oGQY=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 25 Oct
 2024 11:56:19 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::a) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:56:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:56:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] arm64: versal: Do not define do_reset() if sysreset is
 enabled
Date: Fri, 25 Oct 2024 13:56:07 +0200
Message-ID: <8c1a5d6148c5e6c46790b725e8148a4e12d393ba.1729857366.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tY0ECNra0pBArUjWsO0S6NtLzv2RxxWbZurSW2zRo1A=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTp9og691cfclKfZD0Jl5CXL7Y51HLWfDFTppPy3fclc
 27cLGXtiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOZqMYwT9EqQyJ2Ye/Gw3sm
 zAyJ4vQIW1u7hmF+XuF2VY6ipE3nhGevOcViWX2DMe0KAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 848940db-9849-48ac-6a4e-08dcf4ec0984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BiZNzSNpol+xB/JVSotuTQbYg0sU/NtpBQ0j1vp4cS0wF3AeOYIU2gHtYSdj?=
 =?us-ascii?Q?1NadKHb1zLHMGDmTbmRP9xQXSID29xxZSP88R5hgadl4hcmbx6fDX0NnVnej?=
 =?us-ascii?Q?pLkfjDKZ9Cm3nej+rMe3v82MtlWcR+lgKFgFGFl0jtMVqx4mtW8DsgymylBN?=
 =?us-ascii?Q?4Fgr9y12MbDot6YJLZDKvrTJR5Nt0YCJAFFkwquoHJNZAG/2v95/RXWIkpTl?=
 =?us-ascii?Q?hVAck1NWXCkdhibP5DsoOULLt/tkHQY4FEb2XPQ6QAu7qPeiMndlFvxXGlf2?=
 =?us-ascii?Q?Js0z8QTsdMwAeBxtmyHkchWcEJm21gTB1Zft+A9n81rbzUpjkh7jjNSwZpVa?=
 =?us-ascii?Q?tZPtQPBG5LrZtAdYiL7vTR6kUHcnhocLD4NEkQQlTy+ih2rB6D2xR/2+3VMX?=
 =?us-ascii?Q?fjnpJm8+Qn3ydNpEB146wei8ReNQD/Pj0bbz52sLO1WWzR41vmYUpJ2J5Q6R?=
 =?us-ascii?Q?v7+43+lEAZrdod+HjkbAl2754635EYNAeXKkLh2Z2eOjUM+gu7eGyOrJmVPS?=
 =?us-ascii?Q?4i9FXUASVZ8VWZTa8nCD0xlsgPJfbNLuYlNDtnzQ+6pV/GGUQDkQIYELRxlQ?=
 =?us-ascii?Q?Zn4/eQEEmyP9QHHU7Dy0en3essdWUgQdBtw3bpGoAnjAdcCidSrEvaLcTCpd?=
 =?us-ascii?Q?eJ6uW1lDjihbH22DfSsS/gWbtM/3JMgEBsC2FYUF1CC/Hytp8wxREDJMtidX?=
 =?us-ascii?Q?8lSuGRdJ1bKUnFQQa4jgAIW5Q6DK5PMoZXRSSpTFNHCxYrPbpdoIS1LkvCyE?=
 =?us-ascii?Q?YewtdpKMz4w1ZMZYeis117VVcfGIU03WzNCKDBinydSP4y5rUy43YdjhCoiM?=
 =?us-ascii?Q?87CDLkxwLv6uUuFjKM1bcmop6ZhCmPGHFqf+vf0mHoIveu5p9ptWah1rztQa?=
 =?us-ascii?Q?CV+jox4A8mDS+VxEDVL3kRRFEaTu1gbVAqLJpFREn+9uXNFT3ujPgWSTLr7N?=
 =?us-ascii?Q?QnHuh0cx2qKl20t1Tb4f7Ho1ISh2T1zOcAK5uu0JdcWZUQopD8rIdUzrNC5z?=
 =?us-ascii?Q?CgMGlLmgnbgfUrbl+bqX5j76xTkkEPrNkNYsM1/xswWGeEDvVahSkGIwQv2G?=
 =?us-ascii?Q?Wb8aUf3ARX8Ul1IefmsiWyX4JK9YBwGJJWaaA3XFVJyCoL5CJnX0prwHlZmD?=
 =?us-ascii?Q?v1v2Ms9fmD16vqjBBNygkIdia6gM3j28iqdfyEdD4sWF2qw6cg5azKfAa9aJ?=
 =?us-ascii?Q?EryNLHJ7qRojwPgUOew6rjGtdaeA0sjsiFyUIY+z+a8672XGt8aRVNBjPG36?=
 =?us-ascii?Q?W20HhsQaQImKSmV68G6NOAF2v0nz5H2rjxp1+zJiuf8wvm2/R302DjbZm2/v?=
 =?us-ascii?Q?HmL5KuCw8PYl+hraNUCfOa3s9Xi/mlHVon+P4b+/7cpQaNKsJDICT55NTSw+?=
 =?us-ascii?Q?hzBGbIoaYj/9Xvjsiz8OyLGKy+/30iNmATa6KqzSkrTRzImCRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:56:18.7024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848940db-9849-48ac-6a4e-08dcf4ec0984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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

If sysreset is enabled reset_cpu is defined in sysreset uclass that's why
it can't be in platform/board code.
The same change was done by commit f1bc214b0024 ("arm64: zynqmp: Do not
define do_reset() if sysreset is enabled").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 39474674cca2..27c1cfc6558a 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -301,9 +301,11 @@ int dram_init(void)
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
2.43.0

