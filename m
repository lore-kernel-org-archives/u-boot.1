Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93049CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E90D839D6;
	Wed, 12 Nov 2025 15:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nqR0tbmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAAE83C98; Wed, 12 Nov 2025 15:44:54 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF4183015
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghy4bAdGSmm7TdfN13KkDhOwsUQUIbeDn7DdRyRRnGNKkLNDzoO9Sb1IL/AoRsBrSRpxJHytD9hYGTSkUGQ6UxL53o4lYuNWkoIZSZgvDEOnh69K0qPnc2s0EVZ9SIcAPwmk4UBzgyeHDO0FwpSkFjZ8ykZjJVgm1ab8QycqX3jv7NL9WY+kZoCyNjMjneK3EQBOovMDXiEVtb4dyKMZOt1511AjeaacQjGYEjhz4SIWbPxNvMqpMpoVZJEeO1KkE3vm84ZpjIML7ozV2ce5/fjncgMDHAxGLMS02WcCtebaTAIb9YYDQhpUAoPyRMD36BAB1jbk/2c29fQw4Oaohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad00oQHdbmQbEbQiuIEvT4Q1d0Sqli54CVKxELS7Ph0=;
 b=G32Ngjcm8d5EvBbMwpq43q+xlPLJ8ibAzRtMIpiRQ5iBf+EqrIngUc8aJo4muVAaZ6WAcpiUW0vqyoXz8WuPqeDa2fKg2KTptIIKo4pHGbf4xNEBNEFBtr9neECMnkaiMQMp3wBE5drKj3WAYqJWB9dJ5l+DmZgE2IpBWYrB8oDzf2R5q0BqXQKHm3rjGiAUHCyVSZ+lhL7TAEGBf+g2/Bh9tybXVTAm1P0CSSdsDFGshMm3AdB2vS7mSR5uo3Kni2YhDYe9LO8Yu7IhP317vMtVCpbBclZA5nkrqRr02qyjJmTkIxIXk1NGJ5090drEqaic4VbvmAT2VtBE57bE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad00oQHdbmQbEbQiuIEvT4Q1d0Sqli54CVKxELS7Ph0=;
 b=nqR0tbmAKS+PDjiWoxN1IY5wpWSKCTKQ0gI5lL6R31vI2w8agsVIJTcpvQt4JSwhZpZqM3XzEh29v3wev2Mk+wl9ir8+N3f6YdSMG+7oZtu8TTMMOO7Z+B1AKq0Ex8/74vIHK+gSB4O5uN0D57EhRBSy/lAB/aCGGHmAa1QSNoQ=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 14:44:45 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::37) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 14:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:44:45 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 08:44:41 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 08:44:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 08:44:41 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACEifZZ2851813;
 Wed, 12 Nov 2025 08:44:41 -0600
Date: Wed, 12 Nov 2025 08:44:41 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH] doc: board: ti: k3: Update TI firmware repository URL to
 GitHub
Message-ID: <20251112144441.xppqpgrlnru65usl@aging>
References: <20251112104218.487754-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112104218.487754-1-vigneshr@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd422d2-8e9c-415a-908a-08de21fa05ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l5NPiowWZFgX8OyqgPVQpxmhReYtGBaQJyQAJWWxUjU5KPhGx9ub0pmQnQJp?=
 =?us-ascii?Q?9rLQDCfhfUtzQ4fVjSkTUVTp/Y6bjHfNZLLRLyxqElpUy0+yQz/Bosul9f+3?=
 =?us-ascii?Q?BaRqWqqWlyB1nAMd8NPxhuF8t7cEddJHJ8pa6Ueb0eG6vOwovCheb8mqVYJT?=
 =?us-ascii?Q?fKyYRJ5dZCJrydjjfFFOXIlglxWSYXERDAU5BJ9L6x/fOOxHhm59rGN+cZKl?=
 =?us-ascii?Q?N2i4p4yzaT4G0tnK7RpF2WFVQUEKSCFo/rUr6QIliOd/dD2kg8ySEr2Q5tca?=
 =?us-ascii?Q?wIjCEiISawK3uLwhUBYO3aVOHRQ417zJQx5aZky5gdhl4cJKShoZZXUv+ph6?=
 =?us-ascii?Q?z/wov+Us79xk9WZc9LfCrxEbjst2Lxf7dpBawSRysTM2n6Yirvic5DpuASr+?=
 =?us-ascii?Q?woNe3LYGAwL27kxX89kZU30bJyiPdBSYjPLJgtRiEzzHCc7ce2WSt2vOjlfk?=
 =?us-ascii?Q?1q51I89/rFsSv5oxqRYGYVY0l9ngmhbR9YQt3tT0Zp9o0Kf3ULojeg2t8cUq?=
 =?us-ascii?Q?lk8qysqgtc6SsgUd1c/z8VBM3kyodI1JzlRHAS6bUNVbNhIp+LzbGONnzqSf?=
 =?us-ascii?Q?AAvw7Gph7j5XPuh1bQzVgfYbVTnBGf8nLFHXMoO8C6rRIVKVKEUKuZcWZ3bp?=
 =?us-ascii?Q?UmTgVOcbWLKwS85dVncYMQElwetpRh2KPci1bZ6gK/uk3ruwRtOcG1ms1xua?=
 =?us-ascii?Q?MPYicT8Qlm1stPF/3oGzPfDSM+oAo6d446ER6RjWJiwiNuLq6VbVY4bk9dCD?=
 =?us-ascii?Q?ZcMOoQ3nLfDekWxoQFGvtH1xUxiDEs4O+iEETDOalTFwvaEPglekIysZ4DIe?=
 =?us-ascii?Q?oL4gUkgCAvcVFFVKyZJNOMYz/cXFwpM1ZqdVYfvKOHVR5ZrvdhGFlQg1YddA?=
 =?us-ascii?Q?U0Ecvp7/+wz9H0swtqWbe5CymWfoTnaSmzrZnO0LDMfULuGEQihx3TN6wvBs?=
 =?us-ascii?Q?mO2QRfACOxkRnA8trZfSqpgp/Naq6Fj9uOyb6FkTCxtM3aXXDUYZakaBc5aT?=
 =?us-ascii?Q?vrKHUZ8FQH5KYQKHy+f4MjIqBWv0Xd4bwxEJrHAUB+2Mhhg/OCNVEbrVCWHT?=
 =?us-ascii?Q?upbrfd+JChW8AbEgB+fQyNQJ2IoUcXvwBSHTG8sCx2oazbsMxioSdx1aV+2K?=
 =?us-ascii?Q?BRyj0QCl6N5TL7pEYQSJRHRhBhUTH4ep3PBmCz87mESVVHebC4Gj7RBQdQIg?=
 =?us-ascii?Q?cMA8w76k76Duk3DqaGlQBtfejLv1KtAX3Wp0U55xCCrjJ0J/lMemSju25/ge?=
 =?us-ascii?Q?NAE1j6agcqkaufSiAcQpAayAA+UR79TlhInlHVEU9vqa5+IPjjziTzL/8pR9?=
 =?us-ascii?Q?suHjHpp/a8VrSNlROLPdlNKboDe0hzDjnVAM2AqW/RKRmSm5QZLNfzpmLa24?=
 =?us-ascii?Q?nKUd1M+ySdPx8lK3Uj3VONp6vt9CD3N1fMrydE3SJ4g9yOI3U5HmuhmuCUAf?=
 =?us-ascii?Q?XYMdfQA894f8OzC20T4pzvW5LzVcG/OfUUoeDv45qQHwVnStozlBEaagtcDn?=
 =?us-ascii?Q?5zkaKPLbZbXxGck2P3BXIZDxf+1C2XRxe3Tx?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:44:45.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd422d2-8e9c-415a-908a-08de21fa05ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
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

On 16:12-20251112, Vignesh Raghavendra wrote:
> Update the TI firmware repository URL from git.ti.com to the
> GitHub mirror at github.com/TexasInstruments/ti-linux-firmware
> which is much more reliable.

Agree that the infra is a bit eccentric, but as a canonical reference
point, I would suggest ti.com, though having the github mirror
documented would be good as an alternate source.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  doc/board/ti/k3.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 01fb94116887..d9d802393923 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -183,7 +183,7 @@ online
>  
>  * **TI Firmware (TIFS, DM, SYSFW)**
>  
> -  | **source:** https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
> +  | **source:** https://github.com/TexasInstruments/ti-linux-firmware

Since most of the distros use git.ti.com at this stage, I
suggest https://git.ti.com/cgit/processor-firmware/ti-linux-firmware

I'd suggest not to rock that boat at the moment.. unless, ofcourse we do
a mass migration like we did when we deprecated arago-project.org
(uggh.. horrible memories from then)..

While at this, I also recommend updating doc/board/toradex/verdin-am62p.rst

>    | **branch:** ti-linux-firmware
>  
>  .. note::
> -- 
> 2.49.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
