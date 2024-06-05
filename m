Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE55C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A53D87A9C;
	Wed,  5 Jun 2024 16:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7ZH8TcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40E387AD2; Wed,  5 Jun 2024 16:58:37 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F7A87666
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPcaVZniGPtg4O3a4gsWPtRhlRCx9aikgvub7Lr/fAHaw7FgcZukemPvDd7G3uvrGIma6iPqwgruTd53pM//zFYpIA3xuqmFoWoqWJHtXTqvMvoVboB305j+nZvd/KH7uRlGz/A2rhZEPX4gjmZBD6L7w8crqXtM/p1cIUeRF8t7Vj/yxcytcpnFund4LSUlD4UiYUV1Cx6PWb0Qs3yCaPq0uzu4xJofYc7WfvO9CMf8LQMqrxemI3NjT8QVr/yt6eGMNHrv0IzN1J0CNXFlCK2ZlF90x7kSnsMYWUQz3F4F81vragfZB74qZBzOMiPcKKvmJK9soTZa9kXhCsWXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sWKefHi3Vtu5Dx354vQIIj2vsPRfCQYFSJ6c0OM4Xc=;
 b=OZyWG2AyoVUTNw7HVYA5GswI/w/L17eGN3uLuDKXlq6ryNVf2HIWAp+GZw3E1WojmTLxkAAPF2S6DBSH0sVn0fRyUiwFGHqk7rUQ3lXIhKMyFwPj93795u5bS9byqkzUr4/VvBOLCyEI159C8KjpQEnH7ic0qhHot7o1XMnt+x1kgLJZO4PgxMCYf9RYpTm6Z1hYlefBRZcz1YhUqEaKGNpv8yba4RXykWvKMXJZ1JpKdY8LKUNZwI8MLw6LoyKi6xgToeos7PTwuO8nxCLcfwDdJNXVMMEgo2DyKyiFDzD0DP3948em1xpwPVrrykwnqtfCTKm5Xez2aRrqqS1MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sWKefHi3Vtu5Dx354vQIIj2vsPRfCQYFSJ6c0OM4Xc=;
 b=W7ZH8TcBUIEfJ59I8yYhr/fe4ZoAFPQ9VV/AgaL8Lb6s4oo6dZ/MZpNcWjdj51EI6L6Y1QvezzBGD6d8Xrj1K373KGd20mst0Wm/CVdQR+ACtSNC+tQD4dx5Q5zyZjbBHZ7RSDMEs4GLcKqER4NzmcniRta6B0qG0YOpdbZ90NY=
Received: from MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 14:58:31 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::c1) by MN2PR18CA0030.outlook.office365.com
 (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 14:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 14:58:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 09:58:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: fwu: Also print information about size
Date: Wed, 5 Jun 2024 16:58:27 +0200
Message-ID: <0513d382abefaa0cab02bd85e120f544d1ef8e6d.1717599504.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cYbzJTz3grpxeFBzr+hh6tCieqfJJF6Uf1dU6r4TIuU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSEWkGuJXs/v9pxsfawv/ON5VcM+8y7bF6/67vqoCZS2
 /21df69jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR/5YMcwVWrNvoX3XxlfTK
 t1M2v12uy5XdUc4why95dvkN45eTf1utN2c+sEn9u9GzswA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b121df-5728-40c2-1779-08dc856ff73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EOWeYDDoHRCxh5xMRkzabSEgS75W7AuwPOjzihe+pp9kCdRI5NHmrOJ/CAT8?=
 =?us-ascii?Q?RKR43Tf6U68xHg6rdvCgxcfShAtTzTZfXAn0ZXcPVN/6PQxyCtuPuwTdcApp?=
 =?us-ascii?Q?a8txIo9fRZ6Ryo4Zlw0Nd7Y4vjRfEsA7H551qGZs7S8Adn5MMpTfHa9nDK2G?=
 =?us-ascii?Q?IMXJYX1n0cO9UJ8b64/LcD/2fyuF0NXJhlTJSKcrivOvzoIGecWgc0Qd4eCZ?=
 =?us-ascii?Q?yXoe88T5WnV12Fa3uKqhKUZOKPw/5bWw6JPsqC4Kg9zrbBwG51j3ltwp52vs?=
 =?us-ascii?Q?xivVmZV7ZUZ8Ij35XvuFj7nlEX0Vp+us49SezV7nx9msxXddgDXIygiJlzLU?=
 =?us-ascii?Q?JB066Sl8fKHL2X5xOfh3PXrMvkeDyCP0owkYdFz/3Yv7uHoYrlBxJVUiM51b?=
 =?us-ascii?Q?PIo20WqokxVX71dGr46z8kY/XnjVPdHrI4AfqkqNmUxZ7V+zn6mECC1b9y4C?=
 =?us-ascii?Q?mUtQ65M7KD5ngdiXGDmseeTsXRwFvIUHyW3I3E+N57RlLV5CiDSrFZR/G9Sk?=
 =?us-ascii?Q?VGHoSrHGZNiIwxNGowLESHUAQgy0N4WYavwZdkhUTVew+m1rvgmzv+1xsy65?=
 =?us-ascii?Q?llV7EHFo2qmllLYgWhE6a/3Nf6E2SBFDGXPwn3WssdcYnAhjaXlb4DRuJD8u?=
 =?us-ascii?Q?ygFobsjh/Liz5LI5Oz9K7dMPMBkzUTLaCrSojp/53FsxmTtOYGgWG/hWpYq3?=
 =?us-ascii?Q?//nTcpRY3QdxIlgYpjVcxpOKZAPfh1eHCoVH01uAirDwiF1DVXaj8fs9NCCq?=
 =?us-ascii?Q?7olQ5vUEAep8WBoRfVf35isEOMoneHqH7lMmNrG1frnvcC04yeZ9eUoDFC6G?=
 =?us-ascii?Q?X57tsM9ot3sHzr6RCsUwKD7YUFu4+rJkrhNi5XB2y5SOS4JUeHRP0gphGZ7d?=
 =?us-ascii?Q?71INv3BpCSMguke9slsKa8jvCqY+TyyQEHLyZuyqpB0pFavsMpNysOmqrtbe?=
 =?us-ascii?Q?zfChjvMeup7ZZd6larEotbhX/SBneEK36g7wXlC14cdkTZff7aeQjXDpJrvM?=
 =?us-ascii?Q?UNZl0P51+F9XbydUtEUIBMOfkFEnq+qR4R0Ty9mLVUNmOLBocZfQy9Ju/vmy?=
 =?us-ascii?Q?3GHO10F9djBqbQKk02palrb+wjINFlGlc/hT44hF4bc+x2PTZIFe5j0azgRJ?=
 =?us-ascii?Q?yv2mosNzHPRgfvf0iViAIeRH73hna3718tOmMePFqNa1fanpr6uaKleXKgak?=
 =?us-ascii?Q?qo+u7AL+Ane3nXmf0aHxj/lmrmYj4fDiaXjgLKkNL1P7DTR3jJstRbBZLBya?=
 =?us-ascii?Q?sHMwWztUOwBuAoPixJGoGt27ttmkxOsVNxncN5pba1ruT5KXfNi1rwoCiIiD?=
 =?us-ascii?Q?lvzheEF4iqhzi4TWYXqR21JOS5taipfVDG1rNhjFYsZ00mAhwdok9bP+DvMD?=
 =?us-ascii?Q?HdtQBp+u+pqvq/x6TniyKj7Xd6KmhoE8avIt7DrJuRfGpX5+QA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:58:31.4826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b121df-5728-40c2-1779-08dc856ff73d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

It is useful when structure is also used for saving vendor data covered
by CRC32.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/fwu_mdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 3c8be576ac7a..9c048d69a131 100644
--- a/cmd/fwu_mdata.c
+++ b/cmd/fwu_mdata.c
@@ -22,6 +22,7 @@ static void print_mdata(struct fwu_data *data)
 	printf("\tFWU Metadata\n");
 	printf("crc32: %#x\n", data->crc32);
 	printf("version: %#x\n", data->version);
+	printf("size: %#x\n", data->metadata_size);
 	printf("active_index: %#x\n", data->active_index);
 	printf("previous_active_index: %#x\n", data->previous_active_index);
 
-- 
2.40.1

