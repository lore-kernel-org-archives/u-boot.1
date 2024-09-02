Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C6CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 14:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727D388AD3;
	Mon,  2 Sep 2024 16:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VRMAdo6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDF888AD2; Mon,  2 Sep 2024 16:41:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8E28876E
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 16:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9XusNgdIlTGx+qD6X8hnSTb7MiWOCRs/WJgjOf4Keg0WfqMp5oOE988arQ0t2jgfLs95ckow31z3c7o8IPkQwakYKno2+Y06RApvnyavvMz4AFHnxC1/ZvKhML4Qcxbq1i5KA5wZN15YFXbUT1u3SKL0s/rEsRmg0Nb7G0KH/zxwLDyxFMeHvlfO0GV/gyGvXkN8Oh5axRaSKXuPOCb94hctGZZWhfVxDRf/EEWSlwFgpMj68Vb/BzBC5yC11cDVV2fQT8hZKQuQ6hFT8R9Wb6VxxoJDZXp6cEGTLejdNz8Psv87w/Wh8nj5FN8l9kl62H40Sndzum4MclfKvv0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2vwZRBYebQzIOvb7UxC1uqu3qp5fLgn99AX65Sn3ds=;
 b=zSYv6o5kinejgRF0JJxZnAWiIldEqLFNDiz+AxFeBzBcUuHpF54Pp8A8jyhrBXhZ5//i/fetQGH5fT7l6f48wzSJxmqnJglhMAFCg7PrQSwGG53q+CGOSXDmGi4owYKJmVRyxd0UCn2zLHkfu9ElupEwQPz0TSfSudSO05Xct50Bq0dmrKO02+c68Aw7lhPBfdAgYiJRmVUXZ6ycetO7Te9cBF7qQ4oRdBQoc7FKGs3+OT0/n0XQZX/gdF/lsy4o7/m99zCgjxI8A5G5YYqp8eEv5M/2oZAYHVkrG54woH43D4V+1/bxq+EjHMrgrGbwkAFLSevcE+z67YaOhDeomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2vwZRBYebQzIOvb7UxC1uqu3qp5fLgn99AX65Sn3ds=;
 b=VRMAdo6AFm8nRSJJy+HVaAFiwcE+UGEIOCViwxBZwppj/AFSxgjWP9ct2Ox7XcG4GVAv2RT7jjYXxhGaoDlGMnFPYEhUg067Z5SvcB2mAHIAUROxRK1ht0DXZ506to6rmmLqNwpxAcVq1ZSaxvbkWixWz/AqfemfCDdcosOZjro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 14:41:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:41:15 +0000
Message-ID: <4003f097-15f8-439f-a1e2-ab3d1e9c8812@cherry.de>
Date: Mon, 2 Sep 2024 16:41:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: rk8xx: Fix buck get and set enabled state on
 RK806
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240830224207.2568205-1-jonas@kwiboo.se>
 <c88ecb98-b5e1-40aa-9a25-3739642e4ea0@cherry.de>
 <c776c7d6-3455-4d82-9541-b5ecd18775df@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c776c7d6-3455-4d82-9541-b5ecd18775df@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 747022d3-9993-4de3-95d6-08dccb5d4c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVZGRmlvTHFhYjJUei8yNXJSaWJtRWxRZ2Z6bDlmNThiOWpJUDJNc3RSQW45?=
 =?utf-8?B?RU5mK1QzdGxKbk1XdElZeC85WURXT0FUY3pPWThrMU1VZVc4TXY0R3RaeG02?=
 =?utf-8?B?QjJ0UHRocWlmSDRSbWhPSVV2VitDdkFKeVdLeXVpZ0kzK1RuYy9MeU1yYUVv?=
 =?utf-8?B?ODlodjc3aHkwWHB3T05CY2xnYnRkMkRpeE9McVMxLzlHNWhwVUs5RXQ0d2Mv?=
 =?utf-8?B?dVU4VDJsTFZhQ0VYa0JqZEVMM2ZUL2x6WUM4T3hsdnZBOWkrMDNDNjUzVFp2?=
 =?utf-8?B?aDI2aGZ1VVJZRDJxZTQvRXZIVTJYd2E4VmNhTFZXdVZzOEtMV1Nxcmx2UUxo?=
 =?utf-8?B?cTNrYkpna0UvUzRFTlUwOUErN0RYc1laNlFRTTA5UGVKbkdHVDYxYk5sVEhD?=
 =?utf-8?B?OWMwdU02cTh6NzhJd3FTMmhJRmpJdGdGOGt4Vm5lWFM3cy9zdmEwd2IzMTRW?=
 =?utf-8?B?RVlORGVJRjhHS2tSakt3MTZaOHRoSVV2VjBXcHZNZzZsRmtDUGQ4MFljOEV1?=
 =?utf-8?B?a1RRTTRBOUFEYkg3aGltQVprYm5CcFBDWEV0bzh3MUN3NURleGM2N000VDk5?=
 =?utf-8?B?RE0wUnBKL0FYLzNpYkpuektyRXBwc2hWcmFYNkJjZ3g5aHBQNUpnZlhLMWNP?=
 =?utf-8?B?b01qNGxDN2ltaUZoYkRaYW9CVmxHQ3JhcEphc253Qzl4UnNSemVmUTRxVHhT?=
 =?utf-8?B?WVpERUpicmpTOGtFVllad1BnWmVkRU9pdkwxWTd0NHhGeGIxNTBBR25NTFM5?=
 =?utf-8?B?d2tHKzZ2ZFV1NzNSZlBCbmNGKzZwMmVtdUp5dndJR0JHdDYyemxveU9GcUpz?=
 =?utf-8?B?ei81N0lIZENiVFlqVkZZcmdaQWNVdnp5c3h1QkNET2t3RW96VEFMZ2V3bzR5?=
 =?utf-8?B?Nm9xcldPYUxxdGNQWnNyNlRnMjA3UG1PZDF5RElEdTNjcnlFQUVpcE9DM1ZX?=
 =?utf-8?B?OUliUzk5UDJtaWpFdFIyT0FxTUhWZ2VTdFJCVkZlcm5vQnMxNnZOUnltSURp?=
 =?utf-8?B?ZmRhMUhvak00cmlvMnZLT05wZW1SQTZLNXMrWXl0Y1FUbXIwSXg3Zm9QZHdK?=
 =?utf-8?B?NXJ1cU95VVFEeHJGRG1TT2Rac3dzVCtuTjlJYWxFQjkwQ3RmdzRZTUxnazdN?=
 =?utf-8?B?a1dyZmVjdENlQURjU3Q5Ky9TYkEyclA4MGFxbVd2ejRxRjRxbDdFTmFVZXZP?=
 =?utf-8?B?VHd0cjVkYzl2TjBxR0lzNTZoK2MvcW5iL0dZaWRRa3dWeFlsZnF4OTR4cnFI?=
 =?utf-8?B?emJic3JoTUhuYm1OdUF5VjZXSmpUYTMwVGJod3dicnIvZnUrVXRJdXdQcmJs?=
 =?utf-8?B?T1pXOE1XcEU1VzMrb0wzQVpWcGRoV2pNUUdRSjBxUkRMR2hVb1VSOVJ3MDlv?=
 =?utf-8?B?dHhWei8wT3c4RzF3Uys5QUN6QWlpc0tKSnBpbTcwWTgrdzFHR3QrbDhrTWpN?=
 =?utf-8?B?S2Jpejl4N05RRnlpSEVsSzBiMEoxNWRWd3BFMkFYNXZKVXErV1YyNVdUb05J?=
 =?utf-8?B?aCtXY01DTkR4aURiWUJNWnRpUG9jNFZ2aEdUVE1WeFNZVWhwY1FzVWlwd09T?=
 =?utf-8?B?R2U4M3JiZFF6ODlSVk5HbXExMjN1YTg2SXNPNkhwZ1dKMFRwUVlKZThVN2dx?=
 =?utf-8?B?V1hyek5TTmxQSGRLbjFsRlFMR2hHdjVqNitBVW54Y1RaYTkyRWh4TGNMdXc1?=
 =?utf-8?B?TklpMlg5OUJ5TnMrMHVURytFb0d5OThvWGd1V3RmV2h3UEhTRUZndWR3Qm9D?=
 =?utf-8?B?ZEYyVDl3dzc1K1hMQXF4RDdoVEFicTJ4MC9EOGQ5RWpoZE1yU0s5WS91UE4r?=
 =?utf-8?B?dkQyeFc0Q3F6QWZxKzJEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGw3cHB4b1J2SGdMUXJ2QUhqQlk5Z3E5YzBXamhvMEY1VEZKY0Y4UUlab3VV?=
 =?utf-8?B?S1BpeS9EWUpURnFnK3VhemY2TGxLdVpwOVRaUWRtUkpubUpsTllFTFJRZGdU?=
 =?utf-8?B?ajZhSS84R25tTUwwOWMvYU1WcjY1dUtvVC9ON2tPdVB0Ti9YdnV0S0RLd0Va?=
 =?utf-8?B?MFBIbld1REE3ZnpoK2RaMFZRaGV6VytPN0tHMWRFUDdEMmgzSlJYY1J1NGxM?=
 =?utf-8?B?enZ1Q3JHZjZPQlJxc0hKMkVQZTJoSy85YzhBb3BMZEdnQytGRzRCdm90bUZw?=
 =?utf-8?B?enJmSmRmNWczOVU1MHVmVHZKS29NRy8zVWdLSFl6QW55alJTaEhncW1qN2VK?=
 =?utf-8?B?RHd5cStEblRUZWM0SElEcnBQKzl0YUtNaVFhWlBmOVJTT05vRVViNzhvVlpN?=
 =?utf-8?B?RGFGM2EvYVlQSzVrSGpWY2tuOU96YmxEam1Ec3N3RzdHanAwd2FLZUF4QmRK?=
 =?utf-8?B?STVGSUc5dlhWSlhPVXdQS2lKTjNRRVZXWkpIdjNXZXlOb3ROMGwwUEZUWG9i?=
 =?utf-8?B?Nml2ZTNORVp4OWdTQWZDRjFrLzI5MU9WN09TbnhEemFTMWV4MHlzdDBBZ3Jv?=
 =?utf-8?B?Q1Rxb1poNENqZ3g3NXYrRzVKSE1iQ0pkcE9yT0gzak04cnp1LzFTYUkvKzYx?=
 =?utf-8?B?OGovQ1hxZ1NCS1hRZC92NnUzcE5TMUg1djd0eHNJUVZ4TEdSdGhTZCt0UmVs?=
 =?utf-8?B?aytsWGE1SHJQOGRsYS9TOW1ROTZISHpQdDdGd29FV1ZDcEJQSU40M1lWRUNr?=
 =?utf-8?B?UytvMHlpMVdEblVBYStlTnlENUpZUGpDd2N4RG12RzU5eEs1SHFqUVdWbjNM?=
 =?utf-8?B?Ym8vZHl5S3pMRGJnR0tIenZhK0tZcnNlSWxhays3N2Znb09hM0JIOGlldmg4?=
 =?utf-8?B?T01OVysrU09zMlRSZG10dzlXL0NXSjhGWnBodmFWYWpmdDgvbFdwREZWRmZI?=
 =?utf-8?B?dkVRRkVOWkFzMnFTajVmU0x6ZTF1WUJMNjV4QldYVGpqZkVwdzVqckN0dFBk?=
 =?utf-8?B?YTRQZ0NLQi9KTlF2U3d1VXRjUkM2eGFJektGbjZpLzR4RVVvNVp0bWVDMHFj?=
 =?utf-8?B?V2xkVTN3anFhVXp2MWhXZlBuSkFPZ0JOZTA2eDc1dlFibHhWbmZtSmZDdmVO?=
 =?utf-8?B?NFBTMGNTbDBzMmFud293bTJYeDh0VmYwWUdhMmdWK0o5K284UkNzbG1BY1Iz?=
 =?utf-8?B?TlZBWXRrOGgyN3laeWFyMkxNekUzU3U3dVhHc2xzYk9pZEozMlR2OXJvdXUw?=
 =?utf-8?B?azNHUm5saHN4NG55dVN2UDlDaHJpT3VMc21mQUs5bFpuSExMWHRIQWIycXgw?=
 =?utf-8?B?bWFtK2tFdzhpenVBUTEwczdOYXBtaWp0M2xRREZJdXFiNHROR0RBVnNtZjBu?=
 =?utf-8?B?cFhwWkZRSGZkVWlwKy9WbTFmMWpGdEVvTG9QVU5ORTcwR2R0UzBLNStKV08w?=
 =?utf-8?B?TXQrRXZnMWxRcVRTcmVZN3FqMU12QkxzNXVqVU05bElvZnZjbFUzaVlCd1Fl?=
 =?utf-8?B?TTVVSUZnRDZyRTB2KzlEbFBjdS85WnpxL1d0eU01MnY1bmhhZTd6R1BHWURz?=
 =?utf-8?B?WEFtVjZVOUJxWlh0ZUo0Wi9NNk16ZWtOeG5BVStKdzIydXBLNzU4dHdDeVNR?=
 =?utf-8?B?Q1F1cFlZK1dvMFltaVEvdzU1TkRsU0M2eUlIZjlRSFlCUWtFaE1mb054MG9N?=
 =?utf-8?B?Q2dxZmg2elBGVDJoejBzSG1lV0dBVXZ6bU1NY0toYUl4aTRKRytzeVZTRHpZ?=
 =?utf-8?B?OGNaYW1BRUl5V1Q3Ukc4MVZuUEVGcW4zR3RNNVlHa3dxeVdUMi9BTWVxREdX?=
 =?utf-8?B?dnVUdTU3NXNPYmxXalpzYjU0d0xRdnBEcUtEamljRExkSmMvZDQwNFZVVENT?=
 =?utf-8?B?cFcrNEdkdjRTMzE0N2ZkTHpLTHdoK3JNOFBNVWZBVG1XS3BiNWFLZjJLQ2x2?=
 =?utf-8?B?d25vbzJyTi9uZmtVRzI5a09JdmVmNTVCM0VlOWlZUGZDRkJkVmZDYzFFY0da?=
 =?utf-8?B?RFloOFpKVmFFVnJqNVhMTHg0WFppbHkyNEJ4WEF4cG9ib3ZueGl0cDZIRWsx?=
 =?utf-8?B?U3pneG5OV3lMam51cFN4Z1BQa1V3SVJFZDNmdnYyVEdyejN6djllUCtwZWly?=
 =?utf-8?B?S0tnQjdUazVNSXBxaFVSandhekdHV1BYMy9TM3F5L3JDeFVJTW9VTDliUUcr?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 747022d3-9993-4de3-95d6-08dccb5d4c42
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 14:41:15.2577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O67TytRNc+KO5Xv01y5QRB/1kl7VtOQQI/cgBGPoFvn9Ei7sUoTDO09bqO3m5yKYTUp1vAEV8TlraXEBzAeVRZcQ+9NAeiAqNYn6dLc4A68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
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

Hi Jonas,

On 9/2/24 4:28 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-09-02 13:14, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/31/24 12:42 AM, Jonas Karlman wrote:
>>> Wrong POWER_EN reg is used to get and set enabled state for the RK806
>>> buck 4 and 8 regulators, also wrong POWER_SLP_EN0 bit is used for
>>> suspend state for the RK806 buck 1-8 regulators.
>>>
>>> Fix this by not adding one to the zero based buck variable.
>>>
>>> Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
>>
>> Shoot, I made a lot of mistakes in that driver :/
>>
>> Thanks for catching those :)
>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/power/regulator/rk8xx.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
>>> index 34e61511d884..3f5ec02b3824 100644
>>> --- a/drivers/power/regulator/rk8xx.c
>>> +++ b/drivers/power/regulator/rk8xx.c
>>> @@ -415,7 +415,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>>>    		break;
>>>    	case RK806_ID:
>>>    		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
>>> -		en_reg = RK806_POWER_EN((buck + 1) / 4);
>>> +		en_reg = RK806_POWER_EN(buck / 4);
>>>    		ret = pmic_reg_write(pmic, en_reg, value);
>>>    		break;
>>>    	case RK808_ID:
>>> @@ -494,7 +494,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>>>    		break;
>>>    	case RK806_ID:
>>>    		mask = BIT(buck % 4);
>>> -		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
>>> +		ret = pmic_reg_read(pmic, RK806_POWER_EN(buck / 4));
>>>    		break;
>>>    	case RK808_ID:
>>>    	case RK818_ID:
>>> @@ -541,10 +541,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>>>    
>>>    			if (buck + 1 >= 9) {
>>>    				reg = RK806_POWER_SLP_EN1;
>>> -				mask = BIT(buck + 1 - 3);
>>> +				mask = BIT(buck - 2);
>>
>> I like my (+ 1 - 3) here to match buck + 1 above. buck + 1 represents
>> the buck number in the datasheet (index starts at one), so you need to
>> subtract 3 to that index to find the bit index in the register.
> 
> I understand this reasoning and would fully agree if this was the only
> use of buck in BIT(), however each time I tried to scan over this code,
> (with buck is 0-based in mind) this buck + 1 - 3 made me stop and
> re-think if this really was correct.
> 

Fair enough. Should we migrate buck + 1 >= 9 to buck >= 8 with an 
additional comment explaining this is for BUCK9/BUCK10?

> I have no strong opinion and can revert this change if you like.
> 
>>
>>>    			} else {
>>>    				reg = RK806_POWER_SLP_EN0;
>>> -				mask = BIT(buck + 1);
>>> +				mask = BIT(buck);
>>>    			}
>>>    			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
>>>    		}
>>> @@ -592,10 +592,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>>>    
>>>    			if (buck + 1 >= 9) {
>>>    				reg = RK806_POWER_SLP_EN1;
>>> -				mask = BIT(buck + 1 - 3);
>>> +				mask = BIT(buck - 2);
>>
>> Ditto.
>>
>> Just a matter of taste though!
> 
> Let me know if you want me to send a v2 with this change reverted.
> 

It just creeps in along changes that are actually bugs and I had to do a 
double take on the diff to make sure it was correct.

I could suggest two separate commits:
1) bug fixes from buck + 1 to buck (basically everything but the buck - 
2 changes)
2) change buck + 1 that I added for "readability" to buck by subtracting 
one elsewhere and maybe adding a comment for better readability?

What do you think?

Cheers,
Quentin
