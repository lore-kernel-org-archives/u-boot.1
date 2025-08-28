Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41D3C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C7983321;
	Thu, 28 Aug 2025 15:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSCjCO/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3570E8331C; Thu, 28 Aug 2025 15:42:43 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310848328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRaUHMWfOhgjCdCC6HIRJY0V6K1iiiCH4MT2wVGvgiD3gTKbfi+DLBdbaG+sJXJl2qVJHnE+Go0HJqKw+lVSsOdbHe5R7qOyREbstXKihLZVK10EvW+g77twsbyvPw8Alnl3MKw3EG6qAxW31vRmnGIhjlYxaUjI74QXWcqH/UhaaZ1vDuGDo3OxHqBfRTDp1gpmVTnUqBVZA1H7d8vmzwkhxAt7KjqvaokKvvWBcaRKPY53ouW20x1eq6gKV2M0pSMVhR0s+QP+4GVHKd2xJCRJxVq3kiRIudUk7TRsIXVoC0tULdjtEQF297w87fsnlwWNVkyOTYpIWfyu+DTUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52iy9u6xmBnTlq+6WbTz7RzUeBLBFfkxB9eKfHIdbKI=;
 b=rzH38XGFkXnaAjUp/7XubF1iQ3KguyJSDVf8npGbeXK8LQvqV60bfsUiXGAomAqGqM0BUa6huSTDQLCJvVJoF1E/4L4eoo5/JTSyrXoH6SXa/juHp+XtGcO1DwvfkNmRJBDyeiPM+LkSI6X9/bNQNvCunqlHf0F3CLX+LppaAYn0BksjfakGTd1SpB7ooOGrWtwR2yAffQtZM0Co4LrmLgnomKlZd75u2KA0hh8IeFFPw01wAUcvp9gWtdKy6rkOQRnD+uxURZqns1DPNfqC2btHxwJ7On4A0HNuFJ4EYTjwvT3qXyWkGgJo0e8GGHARsdwGM3RuClDtokXLKOPRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52iy9u6xmBnTlq+6WbTz7RzUeBLBFfkxB9eKfHIdbKI=;
 b=nSCjCO/ymTHWbm0NQwHDSsopPvpm7VRp2EBsTb3hHRHvnUCraU7Ih4kTY1v+CH10lb9w6+841PhEV4EnhrsMv4qBci6zIf+hjObxF8Y79y3aIPZHP6TTzqTf+BjL4Op3WKxr1xbeVlqwoMYHPQ1J1jnHCgijAdzgMAXZiiz9+tg=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Thu, 28 Aug
 2025 13:42:30 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::cd) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 13:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:42:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 08:42:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 06:42:28 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 08:42:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Majewski <lukma@denx.de>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] clk: xilinx: Call generic smc_call_handler()
Date: Thu, 28 Aug 2025 15:42:20 +0200
Message-ID: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FDxoW76D2ZPg1LgbDTc9/w61g+b9bkfun9RIyPVZczU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsiDkweeUy5/ic/z/cdnwJ4DriwbTBLk7Aj3P2moj3T
 4Qrn/d6dJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEWowY/pf1uXHMPCl/s0Dh
 +wOJ7/E2FQe9C+RObfXLmmV0uVTs0QFGhplPn0786hTD//TQmp/lEz+rCuVEGyQwcTDsi37cKZK
 RyAcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dbd3b1-dc9d-4bbd-2a80-08dde638bbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Y3EXkhU9V8ojiJJPYREb+j8ZSYHBLjVT5e/C/4NBXAY+3n/+ZqucHrLf0Ws?=
 =?us-ascii?Q?cX/U99lfLR0yQtFietGnsS32BCgmw5mBAXAs7tFIOWyIGuhcaIHM7aJCV7nE?=
 =?us-ascii?Q?r9E8ynGOA9ngXYVQf76DO1SUFZvxFpenZvXINUm1qHRvJuGHYkQ+Kv5E1EKl?=
 =?us-ascii?Q?lhJphUzUsocmF3/Frfl1gxLb3Mrt73AW1socduCqavjuwxl8bjCrbQqYDxBg?=
 =?us-ascii?Q?tea4nFo1Xg2P6CpwC2Ci27IvtRWurYXtmQpPxLZT+0/yCi3o/R3o7yFL//Up?=
 =?us-ascii?Q?oiAO4Szi0TVRncgXbkZjmStut0ySM7z1wGSkoWjc8FOp0vce+8HJWqfno6rf?=
 =?us-ascii?Q?7Pr1Y5MWFtSpLRa/XXyMvkFyRMmA4lLETGaBmFPjHr5h1oE7Ym83YoTOTY/c?=
 =?us-ascii?Q?wqHF9pkGergeyUpEXp3b64Mv12AX5g5LqyGzH4Y6zMRrVv6Q8M/SrvJYlK81?=
 =?us-ascii?Q?ibTllggKBWz9m3s3cGyzatQZYom/fdLpTLPX4KjxrpUv+/PuH9XOob9ouoRj?=
 =?us-ascii?Q?V2qNyxLh0J/OCSGNXdSq2jjHbbse9XVHckvMLEqXV/mtCtbYIxEumxsP/UCl?=
 =?us-ascii?Q?4XvqtTWcuMqAgHXFN1dd5TWzwUIsikHi0gdyLfDQ7I7m4aL4F3YTbQyAFT1q?=
 =?us-ascii?Q?gmHN7jfgNKPF+ulrwK/oRl7JkLH2ocCNgkwz2e6d5Bp/IGbX1Ub46YpVitGf?=
 =?us-ascii?Q?sH/zHQIWOJY7KhaxAGUKvEeelyr5y1zx5nqL4feNTbkyPF3bkkFDQ4Kzyl9k?=
 =?us-ascii?Q?WYoHJtHI92NL29YugmuVJswGkgZZrIBW1YHND9+/KolR3fPQ/spzWdqxcfY8?=
 =?us-ascii?Q?pmbdW1YnLN03/pGMguEZN27TUmL6Lyrvs51wO8YmCPgGg/QBajms73Vlby4M?=
 =?us-ascii?Q?12d7gkeE3WIF7xQAae5rcojjYFt5ivICBHLsqEqprn9Q6sng4eIFHZuEeXie?=
 =?us-ascii?Q?R8dZ2XA2WkXE0CmLSrhk1yUEd/EsqdeeB6+xpITbSuvFo/RT8sT7hEBhX/at?=
 =?us-ascii?Q?7Z0249urrc53gFOPSfEz5NcfqAaIazPKk4bU9SoXNeCTo1iwfyL66xJIK9JM?=
 =?us-ascii?Q?/D/uW4cL9+D++/M31xXHs3rGNbTtgNGmJBzWovvcZnvN37cW1u9L49omekvR?=
 =?us-ascii?Q?3OUh5ZB2DrqMzhDg+B858ubPjEuh7lTA/yhUvkhyOp3B3+CDJ2c2AqNwGZJJ?=
 =?us-ascii?Q?UTsv61rojYE/Eu2a9nxaYzLOJwTMLRdVYa9cBeJh5uLCx+fMHJKRratupKnp?=
 =?us-ascii?Q?39viemFz5rLNatsVVOwJahmMlM75CglNIVjplbI6kXqqrZLub3nPDRUx+z86?=
 =?us-ascii?Q?7hQSNghtRvB9CFjIYNXKTLPaxIdB1xs/QlTRMi8MAXw3MZZa5R7n5xnBGm5m?=
 =?us-ascii?Q?dvcBzB9cfgEHVnlfEIqZDKzGcjqcTNUvFnpubMZW3NRWVJN1tSb+9/+T32Ot?=
 =?us-ascii?Q?pMjYHbea4RqpxPGEYL/H7AeEoSHa1puyjsjGGSd7+0tgdZMCiyLTVF+eJkNX?=
 =?us-ascii?Q?ZC61ukfjIDc0pfpMaRe9MCXT4vF9g1hfA0E0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:42:30.2139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dbd3b1-dc9d-4bbd-2a80-08dde638bbf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

There is no reason to call SMC from clock driver directly when clock driver
is a child of firmware driver which is providing it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index cb98f34b5ecb..116dfc98f416 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -123,23 +123,12 @@ static unsigned int clock_max_idx __section(".data");
 
 static int versal_pm_query(struct versal_pm_query_data qdata, u32 *ret_payload)
 {
-	struct pt_regs regs;
-
-	regs.regs[0] = PM_SIP_SVC | PM_QUERY_DATA;
-	regs.regs[1] = ((u64)qdata.arg1 << 32) | qdata.qid;
-	regs.regs[2] = ((u64)qdata.arg3 << 32) | qdata.arg2;
-
-	smc_call(&regs);
+	int ret;
 
-	if (ret_payload) {
-		ret_payload[0] = (u32)regs.regs[0];
-		ret_payload[1] = upper_32_bits(regs.regs[0]);
-		ret_payload[2] = (u32)regs.regs[1];
-		ret_payload[3] = upper_32_bits(regs.regs[1]);
-		ret_payload[4] = (u32)regs.regs[2];
-	}
+	ret = smc_call_handler(PM_QUERY_DATA, qdata.qid, qdata.arg1, qdata.arg2,
+			       qdata.arg3, ret_payload);
 
-	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : regs.regs[0];
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
 }
 
 static inline int versal_is_valid_clock(u32 clk_id)
-- 
2.43.0

base-commit: a51b7dfc6fec0aa76367114af59a7114b040b090
branch: debian-sent3
