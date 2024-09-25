Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E311C369A0
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 07:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1101388B8F;
	Wed, 25 Sep 2024 09:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpfvg5IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1833688B8F; Wed, 25 Sep 2024 09:04:25 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0E988B59
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 09:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjzpXdfA3rTg+tpY7lGVuB5CT7zTkbNZvdWRbX0epTRmLFC2Q97GUrPAkvbJGLZHwksS22giYb1WuP1k93DLRcp39QkhKtDGdXMzpkw6EgUX18RpUTCXhkaWwNNNWAZEKq6N17puo1yblnnLNKfOC9aVp5PRU2Fl9p3uBsdI9JeOZe02JlSduSRkNozS5lqCw79NDJSGL97WJu2XAfvOjZFu+ITBQzZHysGTBpsfiCo1vKF/Fr6jR2jE9T5AIBfGLxCjZ5/xed/VcAp24zWeBnYy3giaIcloHbpMam5HSG/vTPa3PHRiBkmy+RUqpJcvIMfY10c3HpqsTa0RtrCU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCDd/up2ZqgOpxuTsz79ixfmKZhgto6A3SQtWQgkixQ=;
 b=jnJJNt5ARrIw3bYTB0Ayalsn/JhSJVlqqS+ZAUZSAWgymiqsPwzM1p19bQ4Ad/1RR9Wv/Y5hxSTEOcn2G9Repn24CGpLxgkQ3rSNJntAhk9fqGu/3ldCA/q9XjCM9eQCiLk7aEkCg/nJlILNJNzjot17Nx6BopEhWS9fqt6FUVah3kkJ1T/eic3juLGQnDuPng9fGFoGsvuTDXv5Ao0H7edOiKdL6yiXo/jYJqkiHEo5h43UBODCn1229DJT18LKp1ckuVyNzh1NYiaLgEg4GfjVAf1VD8ppwroDt56brEfNJMEk0b1Gjr4ORyCuKOTWvyzcccfznyrutZLRnF5ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCDd/up2ZqgOpxuTsz79ixfmKZhgto6A3SQtWQgkixQ=;
 b=zpfvg5IVnXVhzClEP7yqTNDevLLmB71zMa+PiTRtdj104nicV7kziPzXGIUI0Nk2Q2biQGX9SAKwTKg7jqyNKL2ezn9if4M8cckyYy26Mz5v814rAEoYOsTe76PxY6vQKAbzJ8rVMR3uG5FsZyjhTJq5K9d5XNRdRIlDS8IFcig=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 07:04:08 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::4) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 07:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:04:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:04:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal-net: Remove current-speed from mini
Date: Wed, 25 Sep 2024 09:03:59 +0200
Message-ID: <3de28cc8bbf9571d24673a60809c2075fe2f44c3.1727247837.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VAiFgDfNIchP+AqWHoGTrX4DqWmvTVJz+OMI4vdaoDU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTPWx+w60j9erYlOb716PT+FcqtU4Rv6E+9cnOBeNux9
 J7s8j9FHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi8bcZ5ulstnWO/y/eIMH1
 csu1l9oyYTvvWTLM0z/Mvjzgw8cff1QnrvtYFbL+z89cZQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0480130e-7921-4a08-211b-08dcdd304043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x6j2AYr8cXvxUC0xHTzoW3stVhSbJnTHxV01Abbrmb0+HDzXNLbv4kMxKByP?=
 =?us-ascii?Q?xAWgdv0l/Ne/zAv58BAUayWcrpb7qryIa3SuIm46KvmGz6jnt87ffiV3wxm3?=
 =?us-ascii?Q?51Ql2lvi8cLyYoZT7fIoyi7N+/RQX1AqgVHZs5qmbDR2oDf1e/AR6VbsbUU/?=
 =?us-ascii?Q?9QAjcB064JQr1wSsH+E5OoWxx6r8Ko7AiArkjtmqVh2UuRFlnCg5HJMaehU5?=
 =?us-ascii?Q?wsjAaD4E9t0j33s8LAUi49ztI98lwVqnl+Vo8g/kLkOe7PKkxOfbJw9vv5Tc?=
 =?us-ascii?Q?qBkJZoaJEpfxJ30Dgr0VxrD6EVS1qdI9c7M7dV1hXjiQ+B4AsM7ckAZNuOi1?=
 =?us-ascii?Q?ZsI/sI1TMRQV9rAaSFeJFTI9YbUuJiZ4nGnY1KBy2SC/g+opLo3H2qo8udMN?=
 =?us-ascii?Q?WS0I9HaXkeGLsXPgFVaKOTMGdy23tf1v5S8kwWJLES9QBkyk6HN4k08Bj0U7?=
 =?us-ascii?Q?HOnXYOkXKLdxWKu2jsromuq/05O68AHpmr8HGjnE2A8s8k9YZPAP26BQAHyI?=
 =?us-ascii?Q?4YWMH6CcSrtmLJyL2RzvVXH/bn4rwUgCIOjKYWBXCo9JKNK22ckVGORHMbDJ?=
 =?us-ascii?Q?E/5LkPQHpi0u4L0eNZ5a3xH8th+31fPqMc5GUf3Bah86dXK8TD2I2yYfyiI6?=
 =?us-ascii?Q?YKQAtJXHcCO3i11yNnsRHL5pPJq8rQCM2ZHKl4rLr5yYfcvwRGa12BxDqt1a?=
 =?us-ascii?Q?8BwNCMnxE3ekzj0wZq89wH/gVilEIZ50rmdPOwFHie4+X10KA4Owao/sAcr4?=
 =?us-ascii?Q?McmejQzFac53eOK0h2Gh6Se3gwOUUJX4bh00W/SrYakcrfZDGhMBSfSweuIg?=
 =?us-ascii?Q?ii45k+cWUg0wJ/DzL88yyxs1GP4VqpPIln89PdnZzPMnwhkaOhH+q2Gwb60H?=
 =?us-ascii?Q?cPZ1fexe6TOA+maciF8bWnY6UOQZx4gQkWwS+JlfEPeXp7te3au9E2p4Pqh+?=
 =?us-ascii?Q?uitBdtlz75IOdCfPZ7bSSr85LMah5vcM3Uo5EarwngyqoW/UJBavltF7WwoK?=
 =?us-ascii?Q?6Q2NAo8eExPmK+SRbua3Qua7EvkZ2IXutu3T5pIJpBDqReMAKsWjAFjmruz4?=
 =?us-ascii?Q?K7mr31r8nkKe1FqAS1Endl6014OK+1oYd8Umfadgr6d4tUpA7bBto+aXxd2/?=
 =?us-ascii?Q?+2j43u7Xsj+j5HRosM6+wL+3yl533iFMxfE55w09Lb7UBeqA04BwvoaWuq6h?=
 =?us-ascii?Q?XDXbBlpes1g8ztpzwiF1DHCWlmiHkRGn5+fKq3vMFJ5uIi60m7LuDUfgaspl?=
 =?us-ascii?Q?UUiw4lqP0QDsDU6rCXhCoAuH8klHJRNy3AN0lK4y0WkCxGWB4n0JWAndOFd6?=
 =?us-ascii?Q?5GfQmbKGgi5gOhSpFlBC1ga/53yNExbpFC8YcwwD+kVF4ua/VbmDYc1pmIf4?=
 =?us-ascii?Q?ggBjWtJi9o97qZqzMQbBkwCY7ARMNIFEIvw/xOaNDW2lRAGHc11LBGvX8nAP?=
 =?us-ascii?Q?d4gI5DxR4DdauEroURmMgBE6+DhG1eyd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:04:08.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0480130e-7921-4a08-211b-08dcdd304043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

U-Boot code is not reading this variable that's why remove it from DT.
PL011 code is automatically using CONFIG_BAUDRATE instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-net-mini.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/versal-net-mini.dts b/arch/arm/dts/versal-net-mini.dts
index 9365efbe9fed..f98f95a5c2fc 100644
--- a/arch/arm/dts/versal-net-mini.dts
+++ b/arch/arm/dts/versal-net-mini.dts
@@ -60,7 +60,6 @@
 			clock-names = "uartclk", "apb_pclk";
 			clocks = <&clk1>, <&clk1>;
 			clock = <1000000>;
-			current-speed = <115200>;
 			skip-init;
 		};
 	};
-- 
2.43.0

