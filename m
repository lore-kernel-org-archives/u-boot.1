Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF39BCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 09:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B93888C8;
	Mon,  2 Sep 2024 11:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDoEvER3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D52A889A6; Mon,  2 Sep 2024 11:54:12 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19583885B9
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 11:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufqv0wtKWeDMy/HUpI8zC3rsYtnsEqVBZl6GzKjSEZDWauLWXQOiOTuVMrr7F5aQhwo7kP1gfx6MSrOMTi6ABNdanA0OfbsOf5AasCd4mSmY1OE5RUVJ0oTfi9pr8RGGUzcHwX/mzqh48g5g78Cg0Nc3SH6D3gsFpDP2gduUOrhP9gNRwoZNx3w2BmsNbHVIiCAguGXOdVOYlxTpODGBt0ziOWQOu3zjSalXATtv0jKpjmhFUFRIh14mhomLBa6QYqvI5KZPpsba3Xk4iE14/a48FsISLIJdzVOcTObZviakPdAMR088izVQ1bG6RyHcCiNcF25mx3MBUxhh5xfSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UAocs2oMz7Gvs7xbMF8q/I7Iyr+SmiNWo2fHULFD1s=;
 b=kmhtxGKP1SMu6icNtuOohTOIYAWxuGdjAOj5V5o1PA2Rp3mIwRN5Z8rYM8lIOW7ox+3Q7p5M3II/DJ4qXByf5jKPlcKdUnWrMuVymAdBbbuBZABGXNT1gDRyJ+HJfu656itk/leQRXSEkxz6GOHAmXpTMHGt3zXAn7KXnXdw6tI2boEdT3I0rLH7G/YjWV2zCdC1KRzIgKDGJPfK/OkzyeTaL89gp8u9tSnG1wa8k5ANSjjwSNvlvvpGTmZpXW9MdEBPHHlsXgf5ocFNesKcyJofEOaiYz7O5Efd8E0M7n8GFsuf3zCgGX0Ks2/5rJMruwfyiVm+Jl1tXDY6+T+CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UAocs2oMz7Gvs7xbMF8q/I7Iyr+SmiNWo2fHULFD1s=;
 b=SDoEvER38O5YOEQbF4Zr60rd5RpQfrONx0s/hlaF9H4gMPfYFMjsBeZG7Pjky98dMoWy2p/A50lsA1Gz9NJEtS6nbSk+UctF8h1i/Ot13HXRjlEuV9jatKn/Qu5ubK/W64E85EXdujxK0zocxV+sAQ1u2kZl3NA81cBZ6KJA8lQ=
Received: from SA9PR13CA0039.namprd13.prod.outlook.com (2603:10b6:806:22::14)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 09:54:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::e) by SA9PR13CA0039.outlook.office365.com
 (2603:10b6:806:22::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Mon, 2 Sep 2024 09:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 09:54:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 04:54:05 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 04:54:04 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <git@amd.com>
Subject: [u-boot-test-hooks][PATCH] travis-ci: Skip the saveenv and reset test
 cases on xilinx zynq qemu
Date: Mon, 2 Sep 2024 15:23:57 +0530
Message-ID: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d8f44-5c80-40f4-1086-08dccb352f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wqb6r1gCX+ktELlQ4PvBBChcvRHl/UTuCxRiJQvVYISGvebs9ic8oF3d49Br?=
 =?us-ascii?Q?ANGgqaFXmql3s3K01L81aAVhsXvQScR2k96UxnO+57P0NwNElUtW08SLiQ7X?=
 =?us-ascii?Q?4e+HTMdxllm+8E1JIFRkHEjjzHvZ9vfK4R0YSZUEyuehAOfJUQhbpTH3cVSF?=
 =?us-ascii?Q?rAJFEjK8toRTBwHzilekoeQehxnzkitnyEyTnnvNozdp0gmwuTEV8eOsiNSZ?=
 =?us-ascii?Q?8kmGMYeAIzcyF8SVXjNhT61bjaVvj1tzrq9B3RmT3a23Tj8kF+I9P4hBussO?=
 =?us-ascii?Q?oKGy25NeZjsprFcsD3LOMCWj/RZwC+9FLi9q0N5FmtO+2GPzLnhjHt41tsvY?=
 =?us-ascii?Q?IxtXpDuTLKc8KOCLFsHSPGDdGIE/CyFIKc7DTg2GjWwRHquyUETp4Zw12qPY?=
 =?us-ascii?Q?yb/szawJkMzPut65E4Lx7JwiCU+63zJ8sLj/8dybLDq9XBQauu2hGu14BUAL?=
 =?us-ascii?Q?35w4Nq51ruQ5s/vOz5RvsmyuZecgi3390A3wLU5VY1Q+le2PWcd6j9ZJgmnr?=
 =?us-ascii?Q?I6F9qa27E8arYqY1qUyCqHkYvnnVLQNAkSwfb0+qeHKv4mXprMcFATqDNlKK?=
 =?us-ascii?Q?xHGEtLXuMItwfQIG3Xs6dseGmhStxSJj1V85VBfYkr4JHyZNGgKmku1AoIdj?=
 =?us-ascii?Q?8Mq0FpD1QdSttsnmy6MbFWRwP6xN94zykcnHDsDRP73zbB+Kzv/5PJNvPzeg?=
 =?us-ascii?Q?Gj3aBbBH++H9MK3StKjcRH/V16csGdegUKpKlWjGYTNjO2tegEv+vCgKyO7F?=
 =?us-ascii?Q?NIQj0symCRUcDRtxSVPQZs8jilr2iDpBDW+ElZe9lQhW6PG2aO82ZziAP49Y?=
 =?us-ascii?Q?Urp0Fv4jHJ8Vixh2XK235SN7UkMtecn/zLJWIlmxd+94nIptAcvUZJWKlIe1?=
 =?us-ascii?Q?/amlFiuGsfBvtOW3LVlbBG9G29gggZs7DNm/48d9OZ4n9DhCxJIQshYOH/r+?=
 =?us-ascii?Q?3jqCup9DZwt7H6tQVtbApWEZsKHEPHLi2mFmX69BTGHgY935aEvCCEQkou20?=
 =?us-ascii?Q?No/FGUtfaa27lzyFsUp8HKaSETpuT/2R8wPFW0F5ypTN/BJ4Uwms6PS35ipe?=
 =?us-ascii?Q?cUf67/2Tg4HU9/7ins1Ht9O8EW7NpTS43/2zhJDRka0GMyHCHyqhTwGtSKSw?=
 =?us-ascii?Q?pCd5I0jdeE9U75MOcTT5ah/U9G3Ta9pku7uvMwHc/UYUH4GH7/WmGH2WXHUd?=
 =?us-ascii?Q?IHlZN+vIQwX4noOnmzmi81BgVqrUKXlj0K50oBcq310Bz7q0JrCG35Nxcfo+?=
 =?us-ascii?Q?WYi9xvhMf8qbEtqDotTHvzH56UWiG/vuDqSYWre3YKq6eUs7BCbhTAYWmuwP?=
 =?us-ascii?Q?+bHVVtmTOcaFW1kOgO4hU3E6nX3pvofOqMRYmoewrJL0lb/Xs+nh3yu6V0JY?=
 =?us-ascii?Q?3nNdiQDscMCHXeE5vHr8U21s73qKSUWY0l3jDQLKjaUZjYlXZG3v+5fytSE4?=
 =?us-ascii?Q?Pm3OzXoICuea/xcuzF3YyinImEihL8L2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:54:06.7188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d8f44-5c80-40f4-1086-08dccb352f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

There is an issue with the xilinx zynq qemu qspi driver during the erase
operation in dual parallel configuration, so skip these
tests for now.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py | 2 ++
 py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py b/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
index 267285f..42685ad 100644
--- a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
+++ b/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
@@ -1 +1,3 @@
 env__spl_skipped = True
+env__saveenv_test_skip = True
+env__reset_test_skip = True
diff --git a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py b/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
index 267285f..42685ad 100644
--- a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
+++ b/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
@@ -1 +1,3 @@
 env__spl_skipped = True
+env__saveenv_test_skip = True
+env__reset_test_skip = True
-- 
2.17.1

