Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F85EEE2084
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 11:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF99A838FA;
	Fri,  6 Feb 2026 12:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s9YbXRxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A30F83AAD; Fri,  6 Feb 2026 12:05:22 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7578352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 12:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=t-pratham@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzXLr/SPgkVngT01LnrXr4LT6yrorfGZK39CyYmdITtkJg1mq2gClopLArftg3odaMUHr0iUv1bTm+62n5EoSVZEZtq7iINMQCz6h/ORAu9dac/HwSOlZQlmJG3KZt7pxZom5qXCyHVRccXQclTM5NGH2QYCdOnnnN2dhvmA9oqwM9+EjDsJWlggQgBFwAOo3H+dArDXYPhnXlr8gt9UTcqvqMi3MlsohoEd1ZFbmrajXnKbOf4jjugqO6QkgPVb9XqGERwEASR9PRvGhoQJowXWGdB1IhdXFeIc5MFfy0lc5lgF3hyJ4qMlIGptM6v8vN7waQalRRmFgHR52wuuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPZijXe3PGYC5tzLYZdH348oSeo/AUrOckv9WhxypGg=;
 b=s+cmlp/I9SXSp6f/x7EJNI9/GLPqd4hNxx9rM9RsJTLc9XNW6gpumeomo9yyJXzCxWiGkzaP76Cu1wKPgT+F9JW/Cnl92SbvS7/3OQEMuTrM8GheKE8qzMSgwmgX0HFj2mQiNz294vc+3mBsbZocuaA8abYFuX3914+MIZ8D0uZkpE+nlfRL8FEyg6AYqNhLRue2o233K1joqEGkrXQZQ19CVs0WBFg3yJx451R1kGL02WEfu/vwY0LO6L4HCm/JuVsI5dFMRYSkOFNHINLyP2zLRAf2WGJwXVecbwYEgNzB4Xt/gZobKdHNnZuyR1WUb6AkB63ZXvQ44iuYnhg5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPZijXe3PGYC5tzLYZdH348oSeo/AUrOckv9WhxypGg=;
 b=s9YbXRxBilcI1RXZlaNDuowBVveEiikDcXalo500I3AB5qNR9sUu5u2XRidc6voWsOo3b42bqLgX0hi0TG6AfJMw6FGVYHAvPMTk5h8Z8bAGkHbO05FLGXylL3NGk0MjVkrqfdcXbB8GGDhqN9Q4Ag/iDqDbnmCd+u5CaRIeXA0=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 11:05:12 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::df) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:05:12 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:11 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 05:05:11 -0600
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com
 [10.24.69.191])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616B5AGk686676;
 Fri, 6 Feb 2026 05:05:10 -0600
From: T Pratham <t-pratham@ti.com>
To: <u-boot@lists.denx.de>
CC: T Pratham <t-pratham@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Shiva
 Tripathi" <s-tripathi1@ti.com>, Vishal Mahaveer <vishalm@ti.com>, "Praneeth
 Bajjuri" <praneeth@ti.com>, Andrew Davis <afd@ti.com>, Ryan Eatmon
 <reatmon@ti.com>, Neha Francis <n-francis@ti.com>, Anshul Dalal
 <anshuld@ti.com>
Subject: [PATCH 0/2] Add a build time parameter to accept custom signing key
Date: Fri, 6 Feb 2026 16:34:37 +0530
Message-ID: <20260206110439.1236201-1-t-pratham@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 283627ad-a704-46f6-34fc-08de656f996b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxGmntqp0hjF4zD0cfRqrZi8rv+mUPYGP2owwCsC0n6FW4CFA8mbm/9bwZLj?=
 =?us-ascii?Q?hLsTEDes/1m0gEk6reanU8S2goTtawET+0Ioqw2gy8hPST0lJ0vHxOZVlg8J?=
 =?us-ascii?Q?MUwDVkNI/LKRb1jx2lzCg383a26w7knlqDE3i1lu5fL2APBDCWyCFEnjNn5W?=
 =?us-ascii?Q?0hUMQqk6+XjDyRPDr1GwwRBAPPf0lMvj8o9v96v0Cr5bTBC972Eet6ylhz3Y?=
 =?us-ascii?Q?Ca3xacmLT9wznK0c98LC5N8rLenpLpcMRPbO1UWIoSlfB9lJG4n2XgvaTx1O?=
 =?us-ascii?Q?/5aevDfMzQ3JkAObzXO6iSAN0knSyCTjcStCxPZp+4dJlstJFWXVVd6VgxKh?=
 =?us-ascii?Q?IAR27hb84LQO7OsRTxGLf7C4KLn4e3zTgtgr+hw1iuAPQmSiSzKUdPJcz9uF?=
 =?us-ascii?Q?z6Lly4omYBxb6SXDrlS6dPPg120Wz+IyjEfPeqFGGUq/ngqAnhcYER9qsyqA?=
 =?us-ascii?Q?EfDUyZbrsDRKMuXU+VWUIySsdkc2+qIdN6aYYdPtStM3PwppmpNOtolzNSGV?=
 =?us-ascii?Q?Ba+VdAHqFuikmLiHXrJCt440Lstpx9jH8cLXc3hAnsQ0tBh20BqXEdQn9TzF?=
 =?us-ascii?Q?efmTclOjkWc0MLLdiumRpAkerwPG8QgFbl8fmvzCC5scEuCqYmkSnXNAvdXK?=
 =?us-ascii?Q?z1udenhYkWLiNxdE+8y68glrSnfNjjxEpewsNiBK9Xsxnje9s/pVwr/k2/6Z?=
 =?us-ascii?Q?NLKOYQ2AWV+9UYJ8bvO+HmeZJYP2D1AZ5QuHt7d1HJB2EwR6swAfpSNXD6Vv?=
 =?us-ascii?Q?ghes3CTY1I7Ol3DN7fLTV7ZkGHnYrC2+2CpkLKrgBre3zkBcpna4I+FHpXN0?=
 =?us-ascii?Q?/yAJp6Nrib2asiEV9HGV9Gc7FCsF7HkWmoJZ0E0bPdbL3zDyCVbbPN12TQ74?=
 =?us-ascii?Q?Q+gWuxzFLTh5e0ugpUV+Ct+rqiRHGmX+SsMCs7qxwfIMswGNcsr8VQ9l0ApQ?=
 =?us-ascii?Q?fzxg+2S5AnPfiPB04i14iQ1+hUh3L5w+nY+TWFDdILQkYkFWJPZwm39Q3spz?=
 =?us-ascii?Q?MmRPZJpFrLDZ6rxvAY2FQddRwQx2tcjam14dru2ITN43oCVyffM80t4YfL8Y?=
 =?us-ascii?Q?0sSYj4ykiwsnJVVbXqgbE+RNSf7r4U9OXV1dm8gQX8e835uh070R5tU0ogvy?=
 =?us-ascii?Q?6m0j4vAM3jx9HVOIHvCTzY4a6qggNBg13Weyrt+i2SWcHL8CDalxOYcLfNYR?=
 =?us-ascii?Q?agbHoz3ki+xZww8y4CbinwAeqdHPY2cb69nKRoEJzKK1Zli4ndZ/7yH26OX5?=
 =?us-ascii?Q?q2S/aF3EQQC++9Pn28c5nG/51lO93Wf85uJ8xpQDagHeEMsATWE+Llj7nNva?=
 =?us-ascii?Q?9nstwTXcNoENwLXCyDqVOvReJc4bdlGGnCfPzpOspcUxekk/Koe79qsIsBRN?=
 =?us-ascii?Q?X7lVSBipTcstAfvmJWRsvy+LV7r6W7b7e2xAPLyD+Yv0nRlZ6FwtMTCN/EMm?=
 =?us-ascii?Q?ek3mcJGIrt9pJk1yQiX53V8ydgVjGgawiq9l8ANdrwWyAvdhCmLt77TgUQF2?=
 =?us-ascii?Q?xf/Y57BMpRE87S1Ha0ycA8gwWG46nvngfK9LuM1juY8hmL742XaWfy3nptZg?=
 =?us-ascii?Q?X8lSctpFKStmjP1bTSZUuvpljFHNNaQ3D1mp1h0Mq/v010b84Az38JrrDl1C?=
 =?us-ascii?Q?+khtBe0D9T8vYF4iKRjiQJ5+RRHjbMjBa/mMUNz5ni4MY1rtD4ebhIa9xMW9?=
 =?us-ascii?Q?NC9SvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yFdhEHfqdsVjnQqfPmZjN9pNgQUsjoyoxWxvNXh/izjALf4U6b3n6L16+AB5mBheWQ14Pd8qMCTyPYVP14Lm+gZ6JE2S6ylrlnch6Nkh9ckZ8eCOThO7rDpRkXjUAuNmZzg4KDfKvyv8/fiKhbntcsL461ufWJt+2ThYQbawwwOW2WT1lCv3yNXmIx7r0VsHdth3SOgvj+myFjU56ORQ++J1y85lT81C2GgfpJAIIjcbF8JPYxzZFhOG8mdRaMlgvY7A+Vze8wbovKDPXPYX1yNBm51zysce1EpKCLS9C0HnWU+oSUchYwZhMs70R3qU97JYa4Xd83E8+hTUDbc9Yo+3JC3AxgArHd0Y2bI6nQFytW52JoQ24aZZIB0U380zX/YQAyryq2hwDjB3/HAarIt8bUgFI6goZfUTDugn/5S5rMIVMisRNZNK+cOwq55s
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:05:12.1679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283627ad-a704-46f6-34fc-08de656f996b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
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

This series adds support to use a custom key provided via Make during
build for signing the bootloader binaries, and updates the k3-binman to
use it. 

This parameter is optional and not using it will simply cause the build
to fallback to the key provided in the filename property (e.g the
example keys in arch/arm/mach-k3/keys/custMpk.pem for k3 SoCs) for
signing. Any existing methods for replacing the example keys stil remain
same and can be used. For supplying a key at build, the full path to the
key file needs to be provided while running make to the parameter
SIGNING_KEY:

make SIGNING_KEY=<path to a key> [other make options]

Signed-off-by: T Pratham <t-pratham@ti.com>
---

T Pratham (2):
  binman: introduce signing-key-path etype
  arm: dts: k3-binman: update custMpk to use signing-key-path node

 Makefile                               |  1 +
 arch/arm/dts/k3-binman.dtsi            |  2 +-
 tools/binman/entries.rst               | 23 ++++++++++++++++++++
 tools/binman/etype/signing_key_path.py | 30 ++++++++++++++++++++++++++
 tools/binman/ftest.py                  |  7 ++++++
 tools/binman/test/351_signing_key.dts  | 12 +++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/etype/signing_key_path.py
 create mode 100644 tools/binman/test/351_signing_key.dts

-- 
2.34.1

