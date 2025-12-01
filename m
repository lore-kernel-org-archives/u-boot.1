Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1FCCFD376
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D69B839DD;
	Mon,  1 Dec 2025 04:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="f9oNlcSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D4883A5B; Mon,  1 Dec 2025 04:10:14 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5866883935
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXBWojL/QnJ+nwFm56NZDg+Voip3JtYFSV3hIKbGt3/4Y9nM8piRmoS4aEG3qdXl6l0RX9n6DakupD3OlLHok9e6/RP3Qtuh/5cxjgezbN1+v9SDrxQt67bssLhSfhlPD2qIAemX6R9ORipX3RhFco55dE1jdkGS6+xznfImzJGm2I74QXBwRo0eJnUSHVnsRvRnKLqIRqDJPfaQT4hmo4tiDY06yGV0lYLNeFBw+oiawOSipadhw1sI3+l1YyV6b7fp7m/HYpja2gl4D4Sawl1OksgUaeuaozq8Z/NQCElh/3HTZKCN7ZUhfyN0cTOOSeSM+7wH/IfAAcqL9GovgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4UkyiCMQi3/C5d4THjzf8+RPhbR0I/f2ppJFw5qKZ8=;
 b=x0deyxRv/667wC7y06LTlhjhSAurMiJXfs1kqOdIzspr27R/fHDmDKq/gnzZWYuPwIoAC15/W7NiC/WRBPjBPNsokJSk24/upObDiVzQsVZ9Ef8EWsNbKd8z4O68nr0k7bLYRopeH1Hh0i4GsHEq7cUJhvKsASKr12WmZ+LKhNeuF2ut636K+EM7ewNtSPmz6W5aQEr7GoTDrAsvhDxAEmkBIZZeiWY0RC0QU6JhHMG1ZsGLIxlAT06LZ+N3J9thM3dnsDZ8hsHyrKMx8+gUotlFZfHvkUaJLskbxAJ8AKcOZE034sQjjjNh3zTWBWdTaZNPoBeAWMIMDj+jwHQ5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4UkyiCMQi3/C5d4THjzf8+RPhbR0I/f2ppJFw5qKZ8=;
 b=f9oNlcSuqYJ/RwyKIZC2xVyeZc6KDMD36AAJKmRUOVEsQftE2pfA4TgKoj5/OdfEHpRNnf9Jl9TQazTIXjaaZP6ivLoXd4m4sn8r0Z9ltX/unGMRZFeTeUewwQDn2I016dp5akOu3p7nC9G/dW0WBW1QACK3Dmp2bc9EDOkXdqV2auIiLx4eqyfdgOHW6hsDMUXW4Pyvua3TRqlUbmc0Q9b4JnHb2PezYKnZ8EKzJpXNtQZIld8W1p3HX4h+LD1Bs1NzaFzyXLekcul7GXAFYw1FwUd9lQnk4vPkPNp0v9yN3mUfPjnO3X0MsINV9S2xpIx+oTWAAOQWl0e/7laF3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:10:10 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:10:10 +0000
Message-ID: <2315080a-e35c-4f77-a4b0-b396ca5a211e@altera.com>
Date: Mon, 1 Dec 2025 11:10:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] configs: cyclone5: Update boot command for CycloneV
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-8-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-8-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: c16dc718-c8c4-4274-9ae4-08de30872308
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnl2TCtpbys3aHQ1R3dzdGN0clRVbDYyaEs0c2w1WmdXMW01QytYTkgwYlo3?=
 =?utf-8?B?a3d1enhJNUFsMjNvMCtWYkpOVlcreTdFbHFRYS81RCsvYTJTeXZicjVOTm5C?=
 =?utf-8?B?SWwvajltVnJiaTlBTkVGM3JMN2JXTk4zbjE2djMxcWRCbDZHU202QlE3OUN3?=
 =?utf-8?B?b1BhWWovUkFTUk9lR25Sa1RQbHdQRm9wRUNvN3dWSmFhZ21BcURVclhOTlA3?=
 =?utf-8?B?U1BlVzdLUHcxdUxDRDNta2ZRL3NBOWFBdnJFSGM0aG5kdzdDYnFKQjI5ZlFB?=
 =?utf-8?B?NWg0aW1pY1hWZTNDbnR1cllqYjdHZUt3cEJSZ0Z2dURqdDJ4U2htQjNmOXpt?=
 =?utf-8?B?anoybW1CWUlmWnRrcElmOTAwMjc3NFM2SlVvc0p6R2lsU2cwejI1Y1B2SnlJ?=
 =?utf-8?B?NU1IN0RqT1hCQXFhWko0bkNMOGs4NmpGWTJFZmkrVDZlZTA4OFJTV1YyL1d5?=
 =?utf-8?B?SVA1YWFrQlBVc0dTdjhZKzRJWGhBUVhROWg1TnJoQUw3ZncvK3BFbi9qQlFB?=
 =?utf-8?B?K05WUWZwWnBBcTdHSm91ZThyRnBHc0x5cDBiemJRR1ptMG9oRFJFazRZR2d2?=
 =?utf-8?B?alNPQXNyZUo1SEgvNlNaSDRHRVFQNkVTWHd4WUw0c3k2SGFPYWhneEdvWVlH?=
 =?utf-8?B?eUJxdGNlTVN3TkVmQlhoQ3RPUjdNaFJPalpXUEJSbHNXVzhCOHRYU293N25q?=
 =?utf-8?B?YUVHWmtGZW9qbngzeFdZOGo3bHk4c2R2K1l3c2xkdE1ESThNRDh4WFRrdm5H?=
 =?utf-8?B?cmI3LzBvOC9TOVhVcGMyaDQwUVVJYnpzMTQxVVJicW1TdjBlNWtnanlKUkFK?=
 =?utf-8?B?VnpmRzExT1FvYXVWTjJOVmxidk4zdXRRdUt5T0Vub3Z0Y3pEeit2MmVQV0lY?=
 =?utf-8?B?c2p1YVJCSEFLSXFXVkVVSkRBS0ZldHZ3dHV1ZE5BUk85dHg0cnZEODA0TUd1?=
 =?utf-8?B?N2lWVzZzamxrSWNNU1dOam9CYThJWnFxdy9iS0EwSHplY2dLQ2dSSTMxL3E3?=
 =?utf-8?B?K1Z6Y0pUcHVXN1RaY2g1cFgwTEFkME5kT2ttSGhZZ3hlMERuTXVqdi9qS3RV?=
 =?utf-8?B?emhDZzlYRWdnbFFFYnQ0b2E5RUlLOFF5bStnNlc4QmdBMGlMdE1KYUVMcHJG?=
 =?utf-8?B?T3RJei96MmhvSVVyRTVxTENmdnNuUmZieXQvOExWRlpJN1ArYndsQWVjWWJR?=
 =?utf-8?B?WjdjeFRBTVhob2EzeWt1aDNhS3h1VmpvaG9TM0x3R09XajNQc3Y1VTJnSjNh?=
 =?utf-8?B?RDFxaXFGdlpwR0lOQm95M2pyMnl6bmhiZVArbVRBTHp0ZktOU09XdUxwYUpU?=
 =?utf-8?B?d3JsOHR4ellEYW5qQU1mVlAydEJVbmVlR3RkSC9SY0dIcVZONnhlS2NWUHN3?=
 =?utf-8?B?Wk1JYWl4KzlxUHE1a3dmRWVzeXo0ZGVQN29vdzlRNkVESkNQTGVkdVp1Rmk0?=
 =?utf-8?B?dTRiSU9tcjM3cDJsUTdNRjNzSGV3aUp3cFh1VzFmM2dnQ1UxOUU5b2EyV1hp?=
 =?utf-8?B?ampjRGNJZnM4MEluNWcwT2ZtMHdCcXk3VFNYWW9aVCtOZVVGd2xldDhQN2lZ?=
 =?utf-8?B?OHk2Y0VYZUlRN01FdkdWWGZ3VW53WkZTYVNSNnRvM08wMHdjbVRNcWZtZVlt?=
 =?utf-8?B?OWtyR0lxTVZubXlwL3ppZ1pBZ0xMbjB2WlFlbFdsdXpZTHE1eVpXQzc0ekJI?=
 =?utf-8?B?dVd2UlVLQzNKaURxY0NGMDRYZ3c5Y1VSMExnWTYrMktmVktKVDhHYUJFRGt4?=
 =?utf-8?B?U3ZpMmc3UFAvOFFDRTE3SUN2d3NzMDRtMXM4Y2hFYnlDWFoycFBMSGk5cUFy?=
 =?utf-8?B?T0R1N3h4Z3VqV2lqeG5HbFJITTF2SFVJV1NGK04ydGdPK2RHMTRnWUNnRm9i?=
 =?utf-8?B?SHpXc0FLS25UZ0kvb2UrbUNjSFVUN0lnQ0szZ0RmUlIwNU83R1YzVnFNbkJN?=
 =?utf-8?Q?lIj6DD+7IooOwEBXr2dTDJIwswmww/Nl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpYRWsySXZveHlnUWhvYkMwbjY1WjNYWHNLMDE0MS94bC9rc25BUXVMNkt3?=
 =?utf-8?B?akpOQnJTUkJMM09pQm9wRW15QXNFNXEyblBQVy90Z3ZiVGFpYnFHcW1Vck1y?=
 =?utf-8?B?NkJqQmdTMUxETC9DL0RPd1BOaXQvcjVwMWdYcVAxN3lPcUdWQ2VZc0FIdXpT?=
 =?utf-8?B?amZzQXJGSzdvR25uY2xnRiszUTFxdzY1SW1pZlQ0L0xQTHI2NmY4L21xekR0?=
 =?utf-8?B?YnhNKzdKRjVZdEZMaEZ2dXdFRk5nN0prenpXMis5d2RPb0M0Q3dlQ3VKeS9s?=
 =?utf-8?B?aDZnSW1ScFVQdHk5MlcrbXpUMUdUSFBTOElxRXQyWG5DalRHcVA5VkF4T1J5?=
 =?utf-8?B?R2JtWTRiNGVCQktLaHlYQ1ZkU2NhVVFsczdQbHQ5aEVkbHNkWHVKejRUQTNC?=
 =?utf-8?B?ZitYdW5aVCtQZjhscHg2N0RIYlFGR2dDK2ZrNXh5ajNjR3VhSGlleis5VGZ2?=
 =?utf-8?B?Rno5VTlWM3RoQlk4R3RyOWl3Qkw0UGo3M3lqNlZ0QUpES1czNnJ1cC9tMzhr?=
 =?utf-8?B?RHJpTnEwRFdWVFYzZUEyME9HZWd3MDh0N0lqSkhaZ2FwMGVTbmVFaWFrRVVH?=
 =?utf-8?B?MWg0UldlWXBuRFhka2xGcExSSExTYmM3NGY1aTIvYXB0U0FjNlBaNUtkYWF5?=
 =?utf-8?B?NDRHQkl1WWZTdHJ2M1JNOUhHb2dQbVpTZUw5MWNkNkRIUW5hZnQ3azZIRFIw?=
 =?utf-8?B?d3ovUnViQytWVFJvUHNXMkkrcDkxTVlhbGxFV2tkM29velpSaFg0SDMyMVFo?=
 =?utf-8?B?MWQyMWdVSkNwV2xWYVNzY252MW5mVjhQU3ppNUJhdHdhSWVnWG9maEsvWDdo?=
 =?utf-8?B?bFlFN1ZFS08xaDBHS2lUazVwNHVsSVpJc2t3dEVub1Q2VTlUZ1FGRmRDa3hu?=
 =?utf-8?B?RFdxOTU0ekJEVW5EVm91dTJpMVJoNlkyLzdrOUR2cDFWUytCZmV0Z3RCVTNJ?=
 =?utf-8?B?VzZodUZ1d3dpeEtvQWJRY3lCcEVGRWw2dU1LTDlRWFFzbUJ5SkdIV29DR3VJ?=
 =?utf-8?B?cUovUE9RR1BXQkxKUnNwZTI4dkVxSVdwRHNoM3I0alNtbjVpMkN2Mm4vV0lz?=
 =?utf-8?B?R1BNNzREVnVMT0tyYklyVFY3RGlZTDdMYWhBb2k5bTkvN2c5KzVtdmNDYVBC?=
 =?utf-8?B?OE9ld21wTnJWZGd5SkM4WVVRN2RJNWVGSmhLUlpQOXFPNEZNb0FCRWMrWGxX?=
 =?utf-8?B?WWllSWNydEJNMVI1L2dDTmhqanhGK2hpZlAzZk5xV3d0WUVTK0M3d282Tk1E?=
 =?utf-8?B?bXF4SmUrY0NHQTkyVXhvSGVETTM1K3VoQzl3a1Y1TFluS3dsaG5UOXMrR1ZH?=
 =?utf-8?B?MktKeUhDTEZXejBUbU5GOVh2aVlwOWR2eVo2OXpoQXhUMUQ0a1d2ZWFtVXRW?=
 =?utf-8?B?Z1FKelZpVHZKRWpiL3hJSVZhcURnR3pOcnlBdmxDbTVCL3kvZENHb1JuU2Ft?=
 =?utf-8?B?SEpSNHMxS0lZVjlYS0R1bXdxTVVmQmdzU0prbEkrMWtFbjBzazg2RkR4TUFw?=
 =?utf-8?B?TjRKdVd6MWRXZW05OXc0SlpNcDRwN3BHMXRlU1BhNnRyenlTN0phYXh0MGtF?=
 =?utf-8?B?a1JEeEd3ejJZcFR3ODVkZ09MdjFGcXdaVy93YU9ncXE2VTZTdVovRW4zQlJU?=
 =?utf-8?B?M3kxWlBUeWwwWkVYSWxNTjlJVm15N3B3cVdaSzdSS2hkMmMwMXk2aWt2Wmtv?=
 =?utf-8?B?ckp6Vzg5NUR0Tmo3YjRwN2NMd2FrMWZLTGo4cy9ZZys3Z05NSHY5c2ZkRy9U?=
 =?utf-8?B?NDFCby8zWXVUZmFJbENGRWpyL0x6cHFxcXJGS1FyNWRqejI4T1FudC9rVzEv?=
 =?utf-8?B?akV3WnBNTUpBQ21URm55cGx3b3Bvb2xPS0JDU1plTllaVDlxRVRXaW5iMFJB?=
 =?utf-8?B?R2tPQ2FJMHhkN2pzSHVHUVQ5M0Q3WWUxT21BUGMrNVQwY2FMOWJFbGNpNTl4?=
 =?utf-8?B?eWtkT25FUXpwMXRscjBIalhjQ1ZVcWk3UlhXSmtlYkh6elUxdTdDWDFRUWxG?=
 =?utf-8?B?SUpZb1I3Y0RsWUlPNTl5dklsa1VJSnlta25JT044TFh3c29QQlRvS0lGdTJH?=
 =?utf-8?B?K0hiTDFJL2JkOUtJL1FFUlZFSXZxRXE2RHBKRmhnVlU2a0cvdWU5MU9ZNFhW?=
 =?utf-8?B?K1RvWDMvZFFWd1A0dWFhdlpOQlc3TUJIR3dSOXJWcmtNT1IrTmdsbDRHQWRx?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16dc718-c8c4-4274-9ae4-08de30872308
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:10:10.3166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCG/QQZSj4z5k1R2WZuKIFXUOCAx121tRq1EEleDeyvi63oFrGeOGJR6GpFBfAQ/hOV/7ZJtqE4THXPPQXut+k8weWyR1e9utqf3E1B46gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Update CycloneV boot command to sync with Altera official release
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_cyclone5_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index 2b2435a27bb..94bb05d20ff 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -16,7 +16,7 @@ CONFIG_SPL_FS_FAT=y
>   CONFIG_TIMESTAMP=y
>   CONFIG_FIT=y
>   CONFIG_DISTRO_DEFAULTS=y
> -# CONFIG_USE_BOOTCOMMAND is not set
> +CONFIG_BOOTCOMMAND="run fatscript;bridge enable; run distro_bootcmd"
>   CONFIG_DEFAULT_FDT_FILE="socfpga_cyclone5_socdk.dtb"
>   CONFIG_SYS_CONSOLE_IS_IN_ENV=y
>   CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

