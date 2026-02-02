Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E9CD79779
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 07:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD33783CEE;
	Mon,  2 Feb 2026 08:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q8n9H2zW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D214D83D17; Mon,  2 Feb 2026 08:52:03 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED7A83C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 08:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9KfymvbSJge0b8yfnYoMP0DlnX3FrBXaK3l/FSbeNE/LtzjoS6oSAxWrJBHCB/jtdvP53pavmb26+5dw66gqtV/+SJC8W7sYS9CVPbO/7Me2C9ckNRGY5YKxNwAE57sEyfC9nWDQXbceJNtRQD98Kys8irwy6DGFmgb1e7i+vIoVrQgZY4g5cqVJttS4U39dKJ98muccOaaC4O0T1fVszRTCnbbvmU9aJo4MF4ybGWfnbNJ4zEEo6w51kkQ8gmiIPcd9GiOwGmvvkEQcqp+0KMJQIm+5mRxVnBHAPP82xe5Jc6VtYqgF+5vQm1uXDOTDDfP3SEoFFzNvBkQYFlrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8UGmD5wsbnB6z1VY80U3AwqkrmruMrodEA05/nXJF8=;
 b=U17grUfuu/1cdnhyyjnF3CJL4VOQUUAocfm9zZdeeYXGC5NoQBVF3+jveN8YMfqKGxtMVHHH82efDFm2MgGY8B54E9Qsa+9ARd27UUQgwohtzOyFBkalJ/Xx/BG26podMl5MrhYEG7MkxkYriJlcese1/dnOISogKiUx9wImzdEL+9s17FQX38LZ0ITpJ17bz3T7KPc/2borBzsrern1n0kvFzioB6lj5P1zlTk84srKChHBQa2RLrGrIH+0gLCkFgmX30WpAtc+G9qNEkut5Mh35BR7szVzm4+Yb0oA4GNFzme+7Lv/AI8AfePMnSP68a8qy7SCG3OKX/Tz5NZUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8UGmD5wsbnB6z1VY80U3AwqkrmruMrodEA05/nXJF8=;
 b=q8n9H2zWU0n2spB1VNgLhTsyBQ5+UFGmlouOSisNHPgDKa6+V7DqIZkreaIXRGsO1yPfNibhrb1We/7ePPQm+gl9VWd1XRuZEFAYQYe5gtnl9M8hSEeVXIu6p3aA/C/9HGdApklnYIV6tresU19bTskJWG0KllOXdaVIzmrMzsc=
Received: from CH0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:610:b2::15)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:51:50 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::fa) by CH0PR13CA0040.outlook.office365.com
 (2603:10b6:610:b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.10 via Frontend
 Transport; Mon, 2 Feb 2026 07:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 07:51:48 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:51:33 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 01:51:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 01:51:33 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6127pWTr1348986;
 Mon, 2 Feb 2026 01:51:32 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 2 Feb 2026 13:21:31 +0530
Message-ID: <DG4B9DIU56WR.1RQ3344R6CL1E@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] Code improvements and argument checks for mmc dev
 subcommand
From: Anshul Dalal <anshuld@ti.com>
To: Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260130180353.42205-1-me@ziyao.cc>
In-Reply-To: <20260130180353.42205-1-me@ziyao.cc>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS7PR10MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d5280f-293b-4246-f1f1-08de622feb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE1Mc0hwMzhVMFVXaEF2SkJPbjdiODliU0loUWtNU0wxekgxbzMxNUFhNWky?=
 =?utf-8?B?OXE0Zi83a2xKb3JhNXZWNkF6SytqbllVRElyZU1OSzQxcjFTQ2dCV0Z4SDJC?=
 =?utf-8?B?QXBzMkhOSWpoWUVnRmdYcHNIa1IxUjQxdzkrWnZkTjkwd3RNaVZTYnd5Wnpo?=
 =?utf-8?B?VTNvV3V4OHdqYzUwSVBFLzdNd2VWS2RTS3VtNG83UlI1YlV6RSt1dTdCSVdJ?=
 =?utf-8?B?ODQrU3I1bTI2bUVPaU5DTnVYWGNLaWdCMGZJSENVWGVPLy9kTHd1REVMSW0r?=
 =?utf-8?B?VTBYSVNkNDljWXZkNFdnZHRMbmVrRStLTlpGT0ZSeVhnbnVYUlRwUkdaN3VC?=
 =?utf-8?B?KzZBb0NQRHppc3JKVFlIMmZRanZqV2pXTDdhMXVIV1NmTlMrS1cxd21QeG1w?=
 =?utf-8?B?U1ZzWEVWTC8xWmQ5eTdERGk3K01KbnR6T3Y2RXNrTnZXNWFIVW1valZHZzhN?=
 =?utf-8?B?Ris3MGkrNmVSMGtaVkFGZ3p0WEFuZlM1K1JOMDkzY3QrMkVkNFJYUkZJbWhs?=
 =?utf-8?B?SVJsbVB3U2lZRUtOQm8yRktnZTNZd29FQU4xZkloNG1SM2hMdXl5M3RNaExC?=
 =?utf-8?B?QVAyMlNpL1VtQmJFVzdEd2RaVWFPV1pTMGRldGdPcnlNT3p5UE1jV2xqaDhz?=
 =?utf-8?B?czl4QnJmalpOWks4UE9QOFVmaGE4aU1iS3ovWE9oSG1HRTNaR3BpQmhPVkFp?=
 =?utf-8?B?cDhva096SEcrNVlRdzRhYVFTcjFsV21ETzlpR3MrMDl1U2pselNnTldnckY1?=
 =?utf-8?B?WSs1bXdqWkUwNXNzNWs2anNMQ3JJcVE2RDAvUTJVS2Z3NFFKWFhJMkdOTk5y?=
 =?utf-8?B?ZDQwMEx3bVVPZmxtV2JNeGwza1VDQ3FlcDJmRTJRQkVFSXJyTW1aQUR1bi9E?=
 =?utf-8?B?STI5UXJ2WlhjMnpvYUVBeUZ1RzMvVW5yRkZncWduZjY2M2tHdlZyQWlVQVdO?=
 =?utf-8?B?MkRadVpPVEhCTnlTWUVwcEhwc1FtV0xaNVJQb3pMUzNBbm55eU1vZktVUnlY?=
 =?utf-8?B?R1BTV1ppWkM4MTgwQy83UXlyaDRVejRQa0tTdGxpM1FkYm1kOGtRcG5tS2RG?=
 =?utf-8?B?RTBjcFhENTJwWGhQZUxjRHUyNzlXaVFYRnZVeGNneGYya1pJdW16aVkrcnJG?=
 =?utf-8?B?TTh5djcwZXlOTDllY1paUGg2QXM1RC9BakZFNUFEaHlMbXpxMUYxaXQ4MDhF?=
 =?utf-8?B?eWcyNGpweE5zdHNRdW1UUUtmTHk4WHo0ejRrQ05JNzNwVUlER2V3OUxmT2xJ?=
 =?utf-8?B?NldTQ0dDVXJLRHBzMWVpa0JCUHo4NUtQMGFOdGtmNU5xQ3AzOEVaTG8yYlRq?=
 =?utf-8?B?bUg4eFRsTi9KZDAwRGFKQjFnblY5Nmtvd3h2QXFBNjRKNTdZeVhaTUVmMVlI?=
 =?utf-8?B?TFAvS1YwODBzZFNaTWs5ck42YWZFZjNLbE0rMG9CVEpaYzVOVThhcmFVck9K?=
 =?utf-8?B?ZG5JNjJCU3N3dkhwdzNTY1NGempyZUJ4bzBMbjVDQUVrNk9mZFcwS3Jpb2to?=
 =?utf-8?B?Zk84NkR2bng0SXhadUttWU4xa00wZysyY3dkQkwvWTBaZXZoSWdjbVBaZHVM?=
 =?utf-8?B?bW5NaHNITHFjWC95ZHVjVUFYM1FBVTgxdk9xS1FoUy9VVWE3dTV0VkcxcXFU?=
 =?utf-8?B?QW5VVlN4VFZ3M2hKaG8zOGMzclhiLzFWSkx6UjExMjZtRDkxak1zYmdta05u?=
 =?utf-8?B?OUJOUGZSM1k2TW1uLzFIOHQ5dEtaNVpsVUhXQjZtbktwamVRSnRYKzAwdjR2?=
 =?utf-8?B?c0J4RnI3VFNWNmROa0p5NG1jS2ZUOGhzNEpOeHVRS2NTTmg4Ym55cGZpTGJa?=
 =?utf-8?B?aXhydkQ0VkhHYUdNdUlYdDRLT0YyclErcWI5RTQ3VWVUUFhlNkdzNU5yTGdl?=
 =?utf-8?B?RHQzMFUvcW9YY3dyditMUEswN2c4bUhJVWRMNG4zTWVlTDZuYStyWkUreFZN?=
 =?utf-8?B?Sm9HQmxyNUl3N0J4L1NhVDMyZGVFM2w3OW5SemJjRkJZeUhhWkpDektDQnEw?=
 =?utf-8?B?dDRodGRpMmFDSUszUGdqK1U4RzZPOGZrblZBZlBxb1p1dFFzOStSSnJrb1dn?=
 =?utf-8?B?QUpTTUt2TURNZmhCNWVjU1pHRTVnb21ZZ0V2WXdCV04vTW44T1U5aUZrYnFp?=
 =?utf-8?B?RkhMTExlS2NRYmMwOTd6YnVnd0lkV2JHWjBsemFGcVR3R0luSDhIZHU1TVds?=
 =?utf-8?B?alluL3FZU0w4d2RGOElHOHIxTy9aY2JEeGVFcTdONDBHNWpNOVJHMmlJM1lk?=
 =?utf-8?B?SVFDVEo1WXlxQ1NuRGdsSUM0eW9BPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3cWp390Tq10/GijIU8RjrSRrYJ09ReqXNqqFqe9IBLgzlWDJuHUcTax+1ML257rmWgrUOfEuS0NIkZGPbbCv1hh7ko7m/s59Jr9OnAqTNWGIJvO1oGo4I8BHiaC8GrIRUsVOQoCUg3jBiAurVzmXmIdgJl9Qmw9g62nEKehmkHC/mTcAivukKj3xoF940WUPXYDNZ2XxX+ROEFHPhJ1CTUk6KW+HfRsSJIBlUPVklfaSk15yTcP90GsbbCK+m0ftLQb9+jFPqeYQBO1/oBOMwX8G1Qp+3WgWuqYWHKCy8M/8DXiR49amyG7MD/rODvICHO6ZpGTr6y/CT8hXvriGMfS/J60R9QrHNSkF4rxGCjJNpkcQyzB0QJ1ooXUyf2PlMGlz9KiqdAUuS3VwWIPvkhCiwycOCIezXk5tmDZU376j6w0vt4Csr4CkVL4cwLCS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:51:48.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d5280f-293b-4246-f1f1-08de622feb59
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
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

On Fri Jan 30, 2026 at 11:33 PM IST, Yao Zi wrote:
> This series reduces code duplication by utilizing fallthrough, then adds
> extra checks for arguments of mmc dev to ensure they're valid numbers,
> preventing unexpected behavior.
>
> The last patch replaces an integer literal returned in do_mmc_dev() by
> its corresponding symbolic constant, CMD_RET_FAILURE to improve
> readability, no function change is involved.

The overall patch series looks good to me, thanks for the cleanup!

Tested-by: Anshul Dalal <anshuld@ti.com>

>
> Yao Zi (3):
>   cmd: mmc: Simplify dev subcommand handling
>   cmd: mmc: Check whether arguments are valid numbers in dev subcommand
>   cmd: mmc: Return symbolic value when part switching fails in mmc dev
>
>  cmd/mmc.c | 55 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 23 deletions(-)

