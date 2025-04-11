Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968C2C369A6
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6761E8323A;
	Fri, 11 Apr 2025 04:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pEDaZtqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153FB83A3A; Fri, 11 Apr 2025 04:46:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190EC830E4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlN0xmuylYKFAhRlHi0fJ7fClpStBSKiew5UbuJupVY7bqrdd17AdX7sdOPFSHPM5g+JTG1R0yP6KZAbKPs9GXiT667TXOPrYmmGtr92EClC67olHMJSlrJt+4faV4XBQB25YGfbrPfVMnezFEyQOdLY3unKez9gxAMKINkhtFCtuP3iJdhrtS+kyWAVqkG5PXSlrA5gFh3RW4/uqmoqd6Ofd6zEcgStvAYEA9FhTWjLCW/KvxhYdWs9fOHi+lWA3+gBwm4aZfNCEfSDHLlRt7AeKljWIm9e7LngcTpOGKlnQP+F6/p1sjybzdTFpjwgtXxblMO1PODWJ16EL4GFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94Fv2ctVpQg5uXG72GWxmobeekOVJpPdMXdcixlalfI=;
 b=na63o+s3Ju2VHqoZUebEA3HDJeB2tPx9fyYO1ktB0FzabniTRE9ECUAKzz7usMjzNIlIvxZlhrBi6BYwIvgTgDAUlpFOEdirMKoMylVd3lEXXFEE1OLPhgT0bR6N2fAvD67KAFMcE+N6EWsct1psDGN9aBkU622YUtAnWZBe8UkwgKgPBMl7ToHk37cFEGo5nXRDhazweXbq6InA4cVdRu4y+vfAeVWxy+EIJ5pGcdOAQDaxI8kQXPc6IBj4um38yrdM60uBI4ZQETKM9B9BpXD1zFw2xPntAO/x2BfdI0ixw95g18v6b3QqgN8EAAR8W3Bj1jamrxa0kCPDBgI5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94Fv2ctVpQg5uXG72GWxmobeekOVJpPdMXdcixlalfI=;
 b=pEDaZtqEwrGewYMHpG9vKgWoS//n75zho81RqFUu/aANo1rHDw/WOp0NLeUWDNZrQ5hfbF4oYuDAOM8cymNPxDGGyTc+tVm899oUIwXZ3gjwQT7jW/tFUVMSlaBpW6V8SEJVYriEHeS1iP845JSluyJ43AFaCkn8PoVfCMdMDswweqByjxr1+q/PvwqxS4I82mQ0+RKSstdhKLvXOq5B2IboFm+f/qMdcHoqTOzX4qioViqaZ1UZ0GYH0j77QZoigl4Eajv6TQyQQCd+FW/C52eYeHBTdedM2UdesrC3LLTY4gPzO91B0eLXAvxh+VeB2eMNTeG2/XBD4flBt+8jIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: Avoid uniniting twice
Date: Fri, 11 Apr 2025 11:54:20 +0800
Message-Id: <174434362345.24440.7410557389884833385.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250216125604.626298-1-sjg@chromium.org>
References: <20250216125604.626298-1-sjg@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: f893e0bc-d74e-47e1-ef41-08dd78a30c64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0tSdHFlMWNIcnZ0dFVIdEswcGQzd2R6VzFtUWozeDNyQmRKNytjMVAxV0lm?=
 =?utf-8?B?aHdJT1ZQbUNpa1dzcSt2VkFKQ2JXZk9XSGNLZm9KNG5xeEQvSXZ2aGdJeHp5?=
 =?utf-8?B?MzYxY25mbEx4VGxPVjQ0Z3ZwSzJ3aEtlR3dXbDlUck9JUnBuUHgyWXEwTkJ2?=
 =?utf-8?B?NG5pUWQ1ZzJoTjBWaUJLa3ZWOS9LRjJPaG40WFJEN3l2VjJmOC9Tc0xUS05V?=
 =?utf-8?B?bG5XVGo0c3JjcHNzaGF5UzUxOUxmdGhsSDVvZVNnT3hzRmdZVkhBY3ZFWkt3?=
 =?utf-8?B?enFPeHVKSm9BN1l6RkxJYkNZUlZLdWRyenRBUFlKdjhBMC9yVFQ2ZENpZzh0?=
 =?utf-8?B?cndCVU1GTko0M2Y1ZEU4NGdaV1dHUVhra2JuaGpXa3pNSVZtSmlMMnBFclpn?=
 =?utf-8?B?ODNRcDVYSnhKTEtvNVcreE51WHovWnJSUEpkYmtUZGZpT1hXdFBwRTE0eGw2?=
 =?utf-8?B?NjN4RDAwNnlVNU4ycHZ1OUFFemNXcGEyc2lvWFNvM3V5a1ZHNnJqajFCWHI3?=
 =?utf-8?B?bVhqNVMvMUcyRExiY3V1Z1YwTFhscTNBT1M3bnRzWVMwdDIzdnpSTHNyN05S?=
 =?utf-8?B?UDhER2Faa2t1WUVyR056TkFWVHZvZlQrNDY2YmVWWnlza2tTazlXNmEyV3hL?=
 =?utf-8?B?d0FzMDNTRDVJREJNemhnVkZES1haZTJ2YzdjRE5iVW9WekJBbW9sbWpGSEZJ?=
 =?utf-8?B?T1QvbVFKQU9IYzRrYmNEcENhUnN5cGdNQWZ5RjNTQ3RwbGpuSnBJRzZHV1k2?=
 =?utf-8?B?RHprMGY4eGhxd1NmTUZyK2ExSlJ4V0xjL2RmOU9WQXhUdE9VNmVodERrL0VS?=
 =?utf-8?B?ZFdscmdKQlZ0VVNRUDA0c2hweEpiZEZSeUJXV1dqVWxncVJtMUZLZ3RDYVF0?=
 =?utf-8?B?ZmNTcC9QU29ZcVZaYmJjSHNvd29weEhnVW9JMmI1UnZ5c3hoMG51RFIvSlAz?=
 =?utf-8?B?V25oR3JUcXZyWmJmNFJBUkFEZ08vL3JPR3lCTVQ4bG4xNThMMXRXTVc3eUow?=
 =?utf-8?B?M3I2MnFneU9qTlNWK1lyZDJ0Vk9Pek82M3o3VjBKL3cySktTKzRLRzhDRUhi?=
 =?utf-8?B?ZFJlMkNRRTFOVGVUd002aFdmZUI0ZDJmVDVNcGh2Z1ZYb291Yy9Md1RDY1p3?=
 =?utf-8?B?bE1WT21iVm5SdElHVUFNUXdzN0x2TGpjUElMYjcwcUZ3VTVXc3lXRlBzY09i?=
 =?utf-8?B?Qk9MMGFGbHRFS0QzYlFGWmRlV0pTNUF3UVExTUZjSE83UEdYTGZHUC9NaVpm?=
 =?utf-8?B?ZlZHNkh4R05ERkpjaitxcFZIUnpPeng0a2ZQeHNjMzFMOXo4MDlFdVViaGYz?=
 =?utf-8?B?QXJjOXp0dXkxcUtRbldVYjBzcndWUFdWUzEyODBsN3FLTnFJWjFqaXFnTDdW?=
 =?utf-8?B?azZJREc3cGZZa29pK3BKM2xRTW5PSit2NzVrNUhid1BSV3BkR0VyZGlBemhT?=
 =?utf-8?B?SDFjWVZtbzNNbDBnand1NzU5SkdEem9FYUh3bWZUZkhFVnhWZFNrd29tckpQ?=
 =?utf-8?B?Tndlci9oR291QmxYdk1JMGlSMEdiVDVVY3piakszeFg2bmxHVGRwQWxNMENX?=
 =?utf-8?B?SGhMTzVLZjNMcjd0S2xEOGp4ejFJNUFoN29JQmxhR3hMK0J0TTA2ci9RVVBt?=
 =?utf-8?B?cmxUM2ZIU0lLT2JHUTYvQjlyb0ZiSXl2L0xkUHVrV3JuYkdDaWpKUFlrYm5B?=
 =?utf-8?B?ZGVkNEJCMDFxNVRLU0tyekF3N09hZW15MmNOMVgrOWFQTzhUVFBLazRtUXJa?=
 =?utf-8?B?alhEZ2ZZRGJGTmVnNWhlTmVScjArUzNjVVZuaTBvNk0zK3JJeURMa1VKZkw4?=
 =?utf-8?B?eEN4SUtsY294OXdQUFFZTmFvMERRcG1pdm9waVJkVGNCTGRneTZ0YTQ0VDh0?=
 =?utf-8?B?SEhEU3JyT2FVVVJPUkNKZkVmZ0ZtVjhyNmxCWW1jNmV2M3ZTSWZMM0wvV3BX?=
 =?utf-8?B?VXZOb2I4eHZKTjZGVTNwNXNhMy9PUnVmRHZlSEZXYmI0SUxZcmVHTEpDNWNV?=
 =?utf-8?B?TWNnRzhBeTh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c054L3pNbUV2Z0ViM2ZWd3o2SEQ3RDZhUFhDc1VLSVcrMlFLckxQUmVIWXEy?=
 =?utf-8?B?WlF0R3QyVmVWNUU5T2d5MllXV2VOUHkwWXhpQS9KaExtRkdQOWZzdE9FNWJF?=
 =?utf-8?B?TXpleGVDOWpvL0xkZjd1N0ozeUJMQWE0V0lRamtHRVFEVVRScWZ0NkcxREs4?=
 =?utf-8?B?NHBFcWhkSVVpeDVWTitnaVhqUVZhOG9hcTFROVd3R2dJSXhoU2MyV0N4a1Z2?=
 =?utf-8?B?aFE4U3pwWFZJalhNQ2pNZTcwNXp0UjljZnIxYWZqeGcvTDJ3b0U0NU9qWUF1?=
 =?utf-8?B?TnpmTVJlcGgxSmJIUmI2TUdGaGpORHQ5TEZRc2k5VElJb1EyZGh4V1V2dTRa?=
 =?utf-8?B?bDRVU2pMVFBVWU1sZkk3d2RudUJpck5EK0MydE0zTTBqNHRyMkVMWUYwdmxX?=
 =?utf-8?B?T2tpVkpOakRNZjdLSkxXeHZCZHlxYzFvSEpzUGFyZ2RCQnFRZWpLT2hyZEFy?=
 =?utf-8?B?SVZoMENzWXRRa3o2Rko4SThJVnVrTEY5ZmdiYWQxWENJRzNWQ2VMOUR2UVhj?=
 =?utf-8?B?akRKSkJTQzRveDJCaHdudUs4eFZoWEdpR2RWenk0VnFBdDZMem1FWWU0eExk?=
 =?utf-8?B?cTBOUTI2N2lwQ1hxUGQ0Sk1EUitHMU1saEIrNVNFVzhNb0J0WEFnQkJacjRZ?=
 =?utf-8?B?M2pxRE44Rkc5ZlZaTmJFNS9EaHlEaUdweXRNcEZ6UDg5WUdLcjgzV1diam9j?=
 =?utf-8?B?WEpncWtabXlLQVdiVnpqNU81a1VISHd4VHhsY2VvM2dHSldIdmU4aXBDNGpT?=
 =?utf-8?B?RHhBcHY3UTNEdG1mR1gzWHNuOXR1aUN1d2VvbmZ6YnRYWDEvNUg4QldFODZ1?=
 =?utf-8?B?V3FxWEpoRHFjdUdIUjNNY0FXSi83MU9XRldXRjByd2ZRSWFxKzFZeWxBMk9V?=
 =?utf-8?B?VjUxU003YjNFYjNYSTZmVFhVYXBqZnpHdURMeld4Rkp4L0dMRUp0RnRoQnJ3?=
 =?utf-8?B?M01HaXhNcjd4YTAwNjRBTk51cVMzcUFleXo0SHJ0NWFRSTkrWHdCZFJoNDJV?=
 =?utf-8?B?d1NFL1NNdnl2czZEUzMzZnZSaGJ5aW4ySG90b0VaankrVTBhV0RSZTRtY3V2?=
 =?utf-8?B?Y0c0RzQ1M0gwaTZqa3FUYythaFErSlZ1ejZ5Y1hBOVdjQTgvNmdxM1V5N3FS?=
 =?utf-8?B?c0Z3UXBSQmpId0J1emlONjVBWEhZakhDSmw3UVNna0NocVNmOHZBb25iTUNz?=
 =?utf-8?B?bHo0ZWdIYlBrRDdXVTBMc3g0RnpOZE5USXQ2OVVtU0xnRGdnNHdhOTFzY3pm?=
 =?utf-8?B?VmREOFBFQ1MxSWt5VmxFNFRlMGVhR2MxZDdwZUI5cENlUWd3Tkd6LzR0bnQ5?=
 =?utf-8?B?RmV4USsyTjRCc1pDUFRBNXdqdE5pV3pEc2lRaCtuZTNkYVEvZUdmVW13RE80?=
 =?utf-8?B?ZXdIQVJJcmRCTUtJUkU2REEyQmIwVEx4QlZvLzJBQ1NjcnRmUnBOTlVKMlpU?=
 =?utf-8?B?QlEvWjQzWWNXazN3aWlhb1JTR1VQTVIycTAwdklYMWxpaU8vVjBGRUpvK3pm?=
 =?utf-8?B?V25vZUdKMjRyRHY1RDl4Unpiam5EUEtBK1FWRkV6ZmZXaGhyRzBYd0UxY0ZO?=
 =?utf-8?B?L2hXb2pPZTR6RFh5YVJGYmxBcUJVU2R1enVsdStYWk1YMjE0blZZN2ZmRDVU?=
 =?utf-8?B?TWRsUzhTZ0VodjhlWXdwNUo1NmlYZWRIYlFCRGxwK00vTEdYWG9qRER4ZU5l?=
 =?utf-8?B?Um9xbnpzTEgxWHhscVFVZkp5QUgxT1dLMXRwcHc5Z0NsOFRNU0ovcjZCekNW?=
 =?utf-8?B?OHVCbng0eUZqY292SFR1bHRhQ0JOZm9UUzMrOGRrT0F2K0lGUUl4Q3J3a2pG?=
 =?utf-8?B?YlRPSVlEdWc1SFJJMW1SVTZsZzBWdmFiL1N0VUkyL2Uza2xXUFVtNXB4QmJD?=
 =?utf-8?B?cXFmMmJiQ3d2bHF6blVTeE9ZSEpJVTNCdkFwTVFqa3NnNVRpb21vUXA0UW9M?=
 =?utf-8?B?NUtGcTdnRjc3ejBZRHNCNlB6TllrOGJJejZIdk12N0gyS3lFT2ZDeEJNbG4x?=
 =?utf-8?B?aFdETjhPeGJwc2tLZENFMzBVbDBqamJlZTZ3YXJvakxrODNGU2p5aEdJWWh5?=
 =?utf-8?B?bFdaeWFHazhTdDh3L3JTTFJqc0lwa0pVejBkWEFhdXEwL252NmNqeGY2NFZH?=
 =?utf-8?Q?IzDzkLNuQxx/rAVeYz3h5oDJf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f893e0bc-d74e-47e1-ef41-08dd78a30c64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:24.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhWHieq2MkyXw4soJF8+azqaHL0zPbhoJEXSYYD8GcSdARx+UMseKwo8ZygXnP7dPrJ+11SOyUhY6pRweTRuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

From: Peng Fan <peng.fan@nxp.com>


On Sun, 16 Feb 2025 05:55:59 -0700, Simon Glass wrote:
> Each MMC device has a child which ihs a block device. At present we call
> mmc_deinit() when the block device is removed.
> 
> But the MMC struct (i.e. struct mmc) is attached to the MMC's device,
> not its child.
> 
> So at present, when an MMC device is removed, mmc_deinit() is called
> twice, once for the MMC device and once for its block device. This
> results in a double call to cyclic_unregister().
> 
> [...]

Applied, thanks!

[1/1] mmc: Avoid uniniting twice
      commit: d99f8d2d749c0e1b352766281f5f5d71fa845f76

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
