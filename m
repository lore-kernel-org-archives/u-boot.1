Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F36D65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 17:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3336083B49;
	Wed, 17 Dec 2025 18:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dK7v08YH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107B78367F; Wed, 17 Dec 2025 18:03:08 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4EC83B49
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 18:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABzz5fCv5GhQ0jrCrKbQ9n3hTdB5ljOWe1JEoyYoZg7ku90Sa6VHBXRjfJwaM4r1cye+6aVNW4vNg9MNlgeWlwzk+7Xa75LzlLK29hxyJiZAK5s3vxwwTtETUZKDyTrwNU+nj6qtBAWcc+dACBcAZskiNYdv5roc52pOw36gFMF/whmtVj92DwkUiBIipjyv+aS+2StvjXP7rEoxtYO3CqymlVlbzYztfeLY5EQLhDcFTwQBtnQQ+1IZlO/BLKmryIGyBxhxThgYXtMfoMk2sZ1bQ2Rj5O7b1Gf3syejIIxpk6ZFOuRAe4mA6R5HQs70SfIzGKLI+jiIr9LISvI7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFTMsfUB0Tnf6h+za2oEf2YTmBxz6SdmhCPVP4whK7E=;
 b=pkjXPOt/wu2d01491JdtfL2uAdtWv+TJxhjYVgZYP6wpBPWAxHpCYDg9IzypmBr5RO3EfiuHQqo3nN6ojOM/9aV9OmmAcfsCwQt87Hekkrnyf3cwdbDxd8jQnPwfPIsvk7Pq9aztmHgJsTc8aACa+lrGckQ+44EaIOeAffkQT9Hdns01LtzZ/NHKDxfB19BQG8Ak+EukB0zEMPIa71CHwoluh8bY4WiNd8s2cDlV9t0SzvcoOsmsEaZQdcPcpGn89URMRCIr50nn6PWa+PEkjMBgYwrILll/s6rUtRx80jzG/GSi9mOWIkP0S8vUqmou5wu0OlqQHrfxm+nkR310Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFTMsfUB0Tnf6h+za2oEf2YTmBxz6SdmhCPVP4whK7E=;
 b=dK7v08YHwdzWxmOU8yz+Z5hiYGu+vxDSfWRfhgQnZUhpZJGgsFxGgNvAdoWP9LQNq/oqZhHkGUfljIEeYwJBx9ZP7eqPIblTUg/R11dGaqbDI69Y6JwDNx/cdmaVDVOgVVwN4O083S6vDQIVUPuNMrxt2wYOm9V2+2X01puOppI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10463.eurprd04.prod.outlook.com (2603:10a6:800:238::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 17:02:59 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 17:02:58 +0000
Message-ID: <f5007ce0-e5b7-403a-8f1a-8c6f69239235@cherry.de>
Date: Wed, 17 Dec 2025 18:02:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Rockchip RK3399 SOC is very slow
To: Victor Krawiec <victor.krawiec@arturia.com>, u-boot@lists.denx.de
References: <0d8cb0a2-5581-4885-b7bc-34402a4ec3c8@arturia.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0d8cb0a2-5581-4885-b7bc-34402a4ec3c8@arturia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10463:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c29022-f2cb-45d1-1a6a-08de3d8e2150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWw0R2VObzdpZWtpWTN6RDZLVkttRVliNWozRDhjcW5DSjJSdCtpSkszK05l?=
 =?utf-8?B?Y095L2x6VEFYcTBWSkpIM21nUXFuQ00zdEVxUEVEZi9KTnNJTjFIM3k5RDNk?=
 =?utf-8?B?L3hhUGx0WDQ4OVlHdkIrWk5Db25TTHNhckl5TFJOQnQxZjh2MkN2V3BsQmlB?=
 =?utf-8?B?WFA1bnJ6QUFqWE1mQVhmTzNaM3dFQzFDS3hhdHBraVE2TkpqTTJyYzdkcUJx?=
 =?utf-8?B?Mys3d0hHd3NiOXlMbnJTMXV1ZW1taGROQStIaXk3bGF4YWpQZFpHQ1dXb0VY?=
 =?utf-8?B?RWQwM0hlN1RtRDE3YWx2SjJoOXdGeTdDUTdWRU5kdVJOZVlzcEFVWmc2VWhM?=
 =?utf-8?B?QlU0VEtCaGxCWGIrYmR0cGpNdU1waW9nMGsremRCWWdVUjlBNzdUMDkrS3pE?=
 =?utf-8?B?R0t3OXZJV2VBL0l1NGZPVFVnaE5QZll1d1dYRnpUamdTbnpmek0wdEp5SFUx?=
 =?utf-8?B?cS9DbjdaYWlSWFRrdG8rRjZiMzFwSi9yYVY4Qi9DZHdaQitsZVhmTHhMbWtr?=
 =?utf-8?B?dCtHUDJuZTlyWDhFUFFMVG1FK0hLZ2RvL0RSOHpXMUJiUHVoZFlBcFhSdlNQ?=
 =?utf-8?B?eTZLTHpLa1llenRpRjVpTGhPYW8wdkowVVFIVVJwL3hMVDlzbUQ2WWdxS1lk?=
 =?utf-8?B?dmhvZno3alQ5VlVsY0pLYXpmNTVNNVdXSkpiN3lDVWZtNS9OVlZwUEpTMFpt?=
 =?utf-8?B?OGVvNWdzNU13dmluSGpQaHQza3RYbUJzN01ocVJCd0w4SFhaQmR4ckRTZVhV?=
 =?utf-8?B?VFZzdWZKbnFsWkZVL0N0eStWbzV4TFA2bWp6WVFjTzVjSDRjZ1RCQ3dCYU1s?=
 =?utf-8?B?WGpBUnNhMmpDT3QxbTk4d1VrenRLZHY4bkIwcDlQbG80T0RpeWRwS2daR2Yv?=
 =?utf-8?B?dGVLOWU2MkdZSERjNFh1TDlqMER2ZS96eTJ1anJjZDFHZ3oybWpQMExlR3hG?=
 =?utf-8?B?bGZtNXNVcjlsNWFMT2N2aFRraGdFZEY5QjQrQ1ZLVERucXJCRG9PbTNlb1NP?=
 =?utf-8?B?Q1EzSmJxeWc3UFNuNXdPanRzSjNWdGJDcnZIT1VuRVgxMjdvaHV5YlIyMnFo?=
 =?utf-8?B?aDhzNUY5UkJVUHVab3luRHNuYTQrdmlyRFRUM0hHMFFDNEtYcDVFTmYwWnRu?=
 =?utf-8?B?MmpuNmVRb0ZOOFlyT0hYZ2ROQ0lHT3lzOEZsSmpKczU1MWF6MUlkWVN2WlEv?=
 =?utf-8?B?cjF0TllZdEVTSTU1WUYxL1E3UGpTTnRMZFZ6L2swZ05jcE5HOTd1SndhVGc3?=
 =?utf-8?B?dHN0R0pqM3lHcU9WMENxMzZpcUhkUGFPdnhEa2huVFg1cHpPVHdDdWNmd1ZQ?=
 =?utf-8?B?dTExMlZiN2EwV0tlbDZ5KzlRWlg1WWhPRVlCRVhodTFOenVtOU1mSlgrQkN0?=
 =?utf-8?B?cjBRUzhUekx4Sm9TRXM4UmdLVXpHZnBYZzk4ZEFHbzhFRkE2L3R2Q3MxeHN6?=
 =?utf-8?B?VENYdUJleXRGYlNqZDVZTnpMUWRXUkpQazl4NnYwa0Voa1BCMHRhak45MG1P?=
 =?utf-8?B?NU1hRUhPbVFtZ1dBb3NiSkMzZGx2NnlDWEV6NXNzejB4R1dXNnhJdVJZaVlY?=
 =?utf-8?B?a3JqRktDTGNNRlkxNCtQUU56a2dONHZMWkJXWE9KSVdEZEJJWGlRb0h4TkZN?=
 =?utf-8?B?aDBnNkF5ZXdDT0xvc2RiYlpUb29lc1Q3YzkxNThjY1NFSkk0VzJQQjF6VWk2?=
 =?utf-8?B?dDJSbTNaNlR0RUNhL2d2Ti9kQkZROUY4VFNLeHhOVWpwc09yZGNVREFjeGR4?=
 =?utf-8?B?V0ZUNEhEd04xSXRpVUFWNnZOd250Rll2ODkySllPbGN5NWJ6cHUvTlZzNjJH?=
 =?utf-8?B?UFRPbStLcElwOStuZ1pXdlNqUTJjNUt4aEhQNXBmbnlNckVaaGdzY0NkTkU5?=
 =?utf-8?B?OFpKaWlDdWdYOFpkdVlqakJ4SDRHenpKUDU3TzhYQXNJQmR1RWpzN283czNZ?=
 =?utf-8?Q?2KJGjZpVF+ubsq9DpyH5KPic+wzlUOhD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBTS1diVml2aHlNbzFIYnRqL055M0JKN28rd2FDMFlYV3A3cVhDMkEvWW94?=
 =?utf-8?B?YWNDSFhyVXoxQytabkxrUWlNbFdNZEt2ZDI2R3dseTl1VHhLMWJ6WVJERGkw?=
 =?utf-8?B?S2xMamlNeXdZVGZmdkdIWlVIZFpaS2tGY3kzNWxDMlFqMXFuUUI2WHR0YkNm?=
 =?utf-8?B?QThobW1xYTA2Z0pDTTQ4ZWI4UXJQenRIck1remJvdnBpK2llU3ZtT2hONVpt?=
 =?utf-8?B?bEg1dkpReWtOQ2RwWGU5YWxyTHg1bVpPOTk3RDVzL1Q1bEJIYys1SXMrOXpt?=
 =?utf-8?B?TnJWbzlPazVCU21jVkczdzUvRDA2TFpDMHMyMHFoWFArckkvemowdHc2OTdF?=
 =?utf-8?B?a2pXQVZYZUdvNlZvTjBJMEN3R1VlQmV2TzMzQW8wZ0o0elF3Q2lxVktoZm1Y?=
 =?utf-8?B?RmlRUVNtaUt5ZXBjbVNReDlEeG1rWnNPdlA3bHlTVVczZ3hqUTlRWHlES2lR?=
 =?utf-8?B?L2NHZWM1QWhsZ0twYkJBWXJJY2N5bkc3WDBaeE5xanFCWENoMzE4Y1JzV0c5?=
 =?utf-8?B?bUtyVUR1M0l2d2pJYmpTWVFQOXVNYW5wcVZqRmptaUtTM2U4cWI4dkV1WXZn?=
 =?utf-8?B?ejkrRTRGN1BNbGtLY011aHhWdS94Y2JuUmFoQU80TlM1NCtDd0FUWkNHNWhK?=
 =?utf-8?B?Rnh4N2J1UEpjbzc2amZidVhIekxCbTJkYjlyZUVQV0NIL0l3U1oyVFRFMXhL?=
 =?utf-8?B?RHp0a2NRSnVFYjlUeFZRLy84WlFQdXY0NzdFUm0xUlcxWXE3MUJWaUJ6Yis2?=
 =?utf-8?B?dGRIcFZtUXp6SVliaVN0ejNzVUtuYWtjTmtIcm9rUE9ZWGVhdWhxeE5wWUNy?=
 =?utf-8?B?ajdyaldOa0Z0MDI1ZHkyb2lkQlorZ0pRYm14Q01YMzQzUW9LZ3Q0WTZzOW1S?=
 =?utf-8?B?RTIxaWtTYlBOSDRoQy9Ma3ZHZjNoVUREUnk3bG1USHRYNzl6TXNKeWc1Smcv?=
 =?utf-8?B?akJ4N2ptY3Jmb1JySTlSdzVWVmxzNERSb2t3ME1iL3VMVEJ0ZDlSckxuVmFJ?=
 =?utf-8?B?WEZpUWsreUU3ZGpNMXdPa0tOYjFPMURQaEJNNG9tcUdKYjNaWXNpY05LTUtj?=
 =?utf-8?B?ZTI5djVMOWl1bm9HOENQVmtNbW1WYXQ1UXc2dS9PK0VhR0xOYkhWQU1JbGdz?=
 =?utf-8?B?TzhveGt4aGQrNFJScUVTSUhWZkVTbm1odWxaOXgvT21TTHBkN1c2eUVnYnR5?=
 =?utf-8?B?Y0cyNzcxL3VQN09ndUxJZS81bnRxN25LTTVDUnVCSUV2SlE2SXlCNjJrSy8w?=
 =?utf-8?B?NjV6dVZmR3kycUpPK2lkQ0p2a2c2THRpSVJybFlLL3N4SzJYS3llQnZlbU1T?=
 =?utf-8?B?bXArUWNtbGNrNXVKdEFQc0UyVDBtRkZvMDd3NGlzOFNYbk9weVBXTzBWOGFo?=
 =?utf-8?B?Q2o5bmlBRFVIaHorU3lXN3R5ZVhyWXpZSU0zTmxnZFRaOWNoNU4rMWdGbEFR?=
 =?utf-8?B?TmFUMjZqSnFsSVJaVEE3d0Q0OVdYelgzYjllMUpBVGcrQnJaNFFmbHhkNG9r?=
 =?utf-8?B?ckRmdm1KaVY2SVliMGRCQ1NGbm1CSUJha1VoaUdCVDNWNGRjcXkvcTUrWVBM?=
 =?utf-8?B?L1hCd0ZYRlk5d0d3dVhrYXpOTzBsR1pJd3J1c2FBVUdPMC9aSGRtWXo3T0pa?=
 =?utf-8?B?S3VOVHF2a21BeERaZG90NzdGM1ArVURiQzhGVjNzaU1iUGtSUTI3ZG9wR0Nq?=
 =?utf-8?B?aXhKT1JzZGNGelRFcE5YNStHaXNUNHRFc2xuMGNSRkRGQ29uVUNhOGwvRUFq?=
 =?utf-8?B?YlIwaStiMzcvb3cxS3ZkQ2NiOXZaK1hwSVJzZno3VHVHWTZXSkVSeDNvTHkw?=
 =?utf-8?B?enVlNnpoZUxDNDhGNFlzZHRwYkwvRlgreWg5U1JwdDAxSGpyQkoycWw0T1VH?=
 =?utf-8?B?YldGenczRjdoek9zN0ZMeElQYXNvamhSWGFMOWtuanRtZDZRQ1l6SUtzemQ2?=
 =?utf-8?B?cFcyYjc0NGM4WHhRS1hnMHVIVDU0RE1BMmczVFR6cTY1Ymd3K05UbFUySGdm?=
 =?utf-8?B?V29uTDJKL016VmtTUkNzVmJtYkhSb1A2L1dhSjIzQnlDNWx4Vk95UGVUTjl2?=
 =?utf-8?B?aWVsYng4bWo4VUkxRWlxdGNYdzNzL0tPSmU2cC9JUHV3KzFjUUFyblJpMmVR?=
 =?utf-8?B?RUZ6SHZNbDNjcmJLVmkra1Rxbnoxak0rVG91ZUpjVEh1bWtMa1lXeU5yeVpM?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c29022-f2cb-45d1-1a6a-08de3d8e2150
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 17:02:58.7694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxR7hk1xRa8PyGi61YbqQ1awAAD5z7QmOy/RHGyifN1H80iA+FYMnim7/0XoMS181hKjXV/+HWMrc6QEExpKnnkIMlXphyIqgz/57Ohkahs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10463
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

Hi Victor,

On 12/17/25 5:09 PM, Victor Krawiec wrote:
> [You don't often get email from victor.krawiec@arturia.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello U-Boot community,
> 
> I recently moved from Rockchip's vendor U-Boot to mainline U-Boot. I noticed that the boot time on RK3399 is very slow compared to the vendor version. It takes around 8 seconds from power up to kernel start while the vendor one takes 2 seconds.
> 
> In README.rockchip "Future work" section it is written "Run CPU at full speed (code exists but we only see ~60 DMIPS maximum)" which implies that the current mainline implementation lacks CPU configuration to make it fast.
> 

Is Rockchip's fork actually running at a different frequency? I will bet 
that not.

> I'm very interested in a fix for this problem. The vendor Rockchip tree is based on U-Boot 2017 and its getting more and more difficult to use it.
> 
> Therefore I have some questions to start working on this topic:
> - Could anyone point me in which part of the code to start digging for a potential fix ? Is it related to the PMIC or another subsystem ?

We default to 600MHz for both the LITTLE and big clusters on RK3399 as 
far as I remember. I believe it's because it's the default frequency of 
the cores and so, if we have booted into U-Boot it means the power is 
stable enough and at the proper clock frequency. Can't confirm, it was a 
long time ago I looked at that. c.f. drivers/clk/rockchip/clk_rk3399.c 
rk3399_configure_cpu_l and rk3399_configure_cpu_b and specifically 
PLL_DIVISORS in apll_b_600_cfg and apll_l_600_cfg. One of the issues we 
have is that this driver is the same for all variants of RK3399 and they 
don't all have the same OPPs (OP1, RK3399K, RK3399T, ...) except for the 
default which has worked nicely until now it seems.

The issue is that you need to configure the regulator for the LITTLE 
and/or big clusters to what is required for the higher frequency to work 
reliably. We don't have cpufreq support in U-Boot so it'll essentially 
be stuck to one OPP at this time. If for some reason you're running at 
that OPP for a long time and you don't have appropriate cooling, we also 
do not have thermal devfreq for the CPU which means it won't slow down 
to not burn itself. Therefore, only the HW thermal limit will kill the 
CPU (usually around 115°C if I remember correctly). When you change the 
frequency of a clock used by other devices, you need to make sure the 
other ones aren't modified in a way it breaks other devices (which is 
something the clock subsystem hopefully should be doing for you, but I 
don't know if it's as advanced as in the Linux kernel).

If you want something fast, you can also look into falcon boot, which 
skips U-Boot proper entirely and loads a FIT from SPL with the Linux 
kernel (you also need TF-A in it). I haven't done this as it limits what 
you can do with the board and we're selling SoM with BSP, not final 
products so we don't know how it'll be used, better have something 
casting a wider net and have less to support customers.

You can check also if you have enabled everything that makes your 
devices go fast enough. If you're using eMMC, does it support 
HS200/HS400/HS400-ES? If yes, did you enable support in U-Boot for it? 
In the Device Tree? Same for SD card with SDR-104, etc...

> - Has anyone tried to fix this problem and if yes why was the development abandoned ?
> 

On RK3399 Puma, with master, it takes slightly more than 5 seconds to 
jump into the kernel by loading everything from SD card (so, typically 
slower than eMMC), see the log at the end of the mail. I have not 
optimized the defconfig for speed right now. Note that I'm using 
baudrate 115200 which is much slower than Rockchip's typical default of 
1500000, so it probably is at least a few hundreds of ms faster with 
that baudrate.

You can see from the logs that BL31 takes 1.5 seconds to jump back to 
U-Boot proper... that's something you need to optimize in TF-A directly. 
I guess you can disable bootflow/distroboot and avoid a bunch of device 
probing and configuration.

You can disable what you don't need and optimize away. We have 
CONFIG_BOOTSTAGE + CONFIG_CMD_BOOSTAGE that may help you figuring out 
what is taking the most time I believe?

There are easier steps to take than go play with higher CPU OPPs right 
now I think, so start with that or identify places where we can improve?

Cheers,
Quentin

[2025-12-17 17:31:42.073] U-Boot TPL 2026.01-rc4-00036-g5ae0219650f7 
(Dec 17 2025 - 17:25:03)
[2025-12-17 17:31:42.173] Channel 0: DDR3, 666MHz
[2025-12-17 17:31:42.173] BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 
Size=2048MB
[2025-12-17 17:31:42.178] Channel 1: DDR3, 666MHz
[2025-12-17 17:31:42.178] BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 
Size=2048MB
[2025-12-17 17:31:42.184] 256B stride
[2025-12-17 17:31:42.199] Trying to boot from BOOTROM
[2025-12-17 17:31:42.199] Returning to boot ROM...
[2025-12-17 17:31:42.341]
[2025-12-17 17:31:42.341] U-Boot SPL 2026.01-rc4-00036-g5ae0219650f7 
(Dec 17 2025 - 17:25:03 +0100)
[2025-12-17 17:31:42.346] Trying to boot from MMC2
[2025-12-17 17:31:42.396] ## Checking hash(es) for config config-1 ... OK
[2025-12-17 17:31:42.416] ## Checking hash(es) for Image atf-1 ... 
sha256+ OK
[2025-12-17 17:31:42.512] ## Checking hash(es) for Image u-boot ... 
sha256+ OK
[2025-12-17 17:31:42.531] ## Checking hash(es) for Image fdt-1 ... 
sha256+ OK
[2025-12-17 17:31:42.547] ## Checking hash(es) for Image atf-2 ... 
sha256+ OK
[2025-12-17 17:31:42.565] ## Checking hash(es) for Image atf-3 ... 
sha256+ OK
[2025-12-17 17:31:42.587] ## Checking hash(es) for Image atf-4 ... 
sha256+ OK
[2025-12-17 17:31:42.598] load_simple_fit: Skip load 'atf-5': image size 
is 0!
[2025-12-17 17:31:42.761] NOTICE:  BL31: 
v2.13.0(release):v2.13.0-1145-g6251d6ed1
[2025-12-17 17:31:42.761] NOTICE:  BL31: Built : 10:54:48, Nov 11 2025
[2025-12-17 17:31:44.136]
[2025-12-17 17:31:44.136]
[2025-12-17 17:31:44.136] U-Boot 2026.01-rc4-00036-g5ae0219650f7 (Dec 17 
2025 - 17:25:03 +0100)
[2025-12-17 17:31:44.139]
[2025-12-17 17:31:44.239] SoC: Rockchip rk3399
[2025-12-17 17:31:44.239] Reset cause: POR
[2025-12-17 17:31:44.239] Model: Theobroma Systems RK3399-Q7 SoM
[2025-12-17 17:31:44.245] DRAM:  4 GiB (total 3.9 GiB)
[2025-12-17 17:31:44.336] PMIC:  RK808
[2025-12-17 17:31:44.358] Core:  311 devices, 31 uclasses, devicetree: 
separate
[2025-12-17 17:31:44.358] MMC:   mmc@fe320000: 1, mmc@fe330000: 0
[2025-12-17 17:31:44.374] Loading Environment from MMC... Reading from 
MMC(1)... OK
[2025-12-17 17:31:44.648] In:    serial
[2025-12-17 17:31:44.648] Out:   serial
[2025-12-17 17:31:44.648] Err:   serial
[2025-12-17 17:31:44.648] Model: Theobroma Systems RK3399-Q7 SoM
[2025-12-17 17:31:44.652] Net:   eth0: ethernet@fe300000
[2025-12-17 17:31:44.738] Hit any key to stop autoboot:  0
[2025-12-17 17:31:44.738] Scanning for bootflows in all bootdevs
[2025-12-17 17:31:44.744] Seq  Method       State   Uclass    Part  Name 
                      Filename
[2025-12-17 17:31:44.749] ---  -----------  ------  --------  ---- 
------------------------  ----------------
[2025-12-17 17:31:44.760] Scanning global bootmeth 'efi_mgr':
[2025-12-17 17:31:44.760] Cannot persist EFI variables without system 
partition
[2025-12-17 17:31:44.978]   0  efi_mgr      ready   (none)       0  <NULL>
[2025-12-17 17:31:44.984] ** Booting bootflow '<NULL>' with efi_mgr
[2025-12-17 17:31:44.999] Loading Boot0000 'mmc 1' failed
[2025-12-17 17:31:44.999] Loading Boot0001 'mmc 0' failed
[2025-12-17 17:31:45.004] EFI boot manager: Cannot load any image
[2025-12-17 17:31:45.004] Boot failed (err=-14)
[2025-12-17 17:31:45.010] Scanning bootdev 'mmc@fe320000.bootdev':
[2025-12-17 17:31:45.650]   1  extlinux     ready   mmc          1 
mmc@fe320000.bootdev.part /boot/extlinux/extlinux.conf
[2025-12-17 17:31:45.655] ** Booting bootflow 
'mmc@fe320000.bootdev.part_1' with extlinux
[2025-12-17 17:31:45.660] 1:    rk3399-puma-haikou
[2025-12-17 17:31:45.660] Retrieving file: /boot/Image
[2025-12-17 17:31:47.068] append: root=/dev/mmcblk1p1 rw rootwait
[2025-12-17 17:31:47.068] Retrieving file: 
/boot/rk3399-puma-haikou-video-demo.dtb
[2025-12-17 17:31:47.088] ## Flattened Device Tree blob at 12000000
[2025-12-17 17:31:47.088]    Booting using the fdt blob at 0x12000000
[2025-12-17 17:31:47.095] Working FDT set to 12000000
[2025-12-17 17:31:47.100]    Loading Device Tree to 00000000f4ebe000, 
end 00000000f4ed1065 ... OK
[2025-12-17 17:31:47.105] Working FDT set to f4ebe000
[2025-12-17 17:31:47.119]
[2025-12-17 17:31:47.119] Starting kernel ...
[2025-12-17 17:31:47.119]
[2025-12-17 17:31:47.900] [    0.000000] Booting Linux on physical CPU 
0x0000000000 [0x410fd034]
