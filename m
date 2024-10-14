Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53DBD16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE99F891A0;
	Mon, 14 Oct 2024 15:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X/8Dp3wC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A77891C6; Mon, 14 Oct 2024 15:14:05 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E8C89151
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjQNeGIsF84GOsqTVz02w3EHIgN3K1wIKa+pSD6VtVGO6+4y8uF1IwlyCDq3KIKRpM3tFlHMfAjbB0FiqcLyJMYDbiEdgD+kpOGh5bfqr7DUVam3VpCnM+Gpn+gUGz4upMCw/5hz3FdHyfcokAyuJDwsrDsfyUcJBf3DMZK0DPQqW3zSIQ9vH4amuEwAddKh/9413IPP+SFO5X73yE/aVvn6io/7zIS/Dux8BjfCzVmM0fEDSk8PhvfeqFmcRe+Ss718v85NZCnjTOFtkifwsu4K1nxL8ESY+q9D9XtCL05uF9kqGMGIYvN0HhLa1BIPCwg8o6cpu81ncZlOHjslRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE9g0VTta9mr3lwjIX9CD7lgXh4YHLIBsdKcAj/X5IM=;
 b=srAOH7XJhFmgzdleXe6CpCEL7DUNEbveR93xlG5cHpL2yjXgTsuW0K7UXjtYDGHVsAdwWFPItadI40/B5SDYzN9r+g61BotI/74+OP+QY2EKG2Kzw3Cohaag/P6+s874XkJtFpis4aI4w95DreAmWK4HjX1NkEy4OiMR4G/wmZFu68v26fIWorwk456BJbXtegRi6ieK0Uhwl5xdNXFTmk+zGZcjY8rH62OUG5yj/lxLBErZzmLQZMzofHi8SWZUU+4AKGnM3+H8Hq6QuaYkPXVTWjRM3YWS298IesMQ19qSjCejgdj2izg0weWNleD6Ew0fY1Hc8WJO8ZLHtb18Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE9g0VTta9mr3lwjIX9CD7lgXh4YHLIBsdKcAj/X5IM=;
 b=X/8Dp3wCn469Zp3VeRkGX3J8+kfhTI8cGJY+q/QP9a3FGsXJ7GefEzDBvHuM6w687j0Nmi3iQQfDUXBEPTvYcAooodCALBBAMwt9YQw19CEkDjZmOYLNcrZG1B9VGyhXWOPxXkNpNX4JgktMPK/mAj4IhxIj/RbTYLokNBJPahI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 13:13:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:13:56 +0000
Message-ID: <0edf58a2-0fcb-452b-aecb-a9e894d9d43e@cherry.de>
Date: Mon, 14 Oct 2024 15:13:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/mem.c: fix undefined behavior in mem cmp
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de>
 <87bk09kjsd.fsf@prevas.dk> <73723830-60be-4968-bb88-f518e493361f@cherry.de>
 <8734lhlb56.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8734lhlb56.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a745b42-f6c6-4665-f3c4-08dcec520f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWxCeFVoeHMvVy8wRWRSNjhHRHN2S3Q4WmFmQXR3clRKRmhTUmd4VjVmSm8r?=
 =?utf-8?B?L2FodDJDN2NHc1l6eUE0QWlUK2hucmV2dFp6MkVHYWMrNDZ5aW51RUVCeDRP?=
 =?utf-8?B?Sy8wYlFTWnE5eXhRV0t6c3lON0R0N0g5WHAzQm91QWV2RFFmNkFPVGcyaTdC?=
 =?utf-8?B?TlpWeEh6cWdIdENlNVBWYW9zWE9Ub1pqaXg4V3lEUkk3QlptaGNuaVZzUFRo?=
 =?utf-8?B?WDFXbml5ZC83YmZ5QWdaQjViZXdSUHo0eW0rQ1JuWTBjUDhsSlAvRi9EcndW?=
 =?utf-8?B?VWZzeGxQMlc3TlcrNFppVkxxK3VvcjhkRmxDK21UYTNTeFVpV2xUZXlIQi9P?=
 =?utf-8?B?alNaWjlRL2cxYXRqSi9UMFQwT3FKMWcvcTNuTXFRWGpsTWppV1N6WEhDQVJs?=
 =?utf-8?B?WitseS9aQXBwaEVCMUo2UjAvN2FLNUZZWS9tUHlMeFRjbnI4N0dyUGloS0dr?=
 =?utf-8?B?djFTTnVzNkxVLzlxSXNBdnRHdjdDSU9OQUU1aEUwOEl6bGhVSjQwVmYycU1n?=
 =?utf-8?B?M3B5RUNHTzBZTUY3SWdtWXBJaGwyaWU3L09hSmZuTUJhZ3lXVmYzRlZBbVZ2?=
 =?utf-8?B?UXJscWwrZ3djUDU1OWpqL01NZm50djBwUHh0K2NTSTd1cjQ2WHFZSHROUGNP?=
 =?utf-8?B?WXg5YzAweWdpTkwzM0x2T0VLNk16WWtnZzJwQTRSRUx2S1F1NVNHRXJOWjBu?=
 =?utf-8?B?QnJJSnJIdUVYUVZqNWtScXZnNnpYYmVmcFpZSDBQT1N6eWo4UVd5ckRETmd4?=
 =?utf-8?B?NFlwTWsxSWdaakhWMXJmRmgrQzhyaXhtako3cnloMlpOZFJCSy80VjNyZ1Nm?=
 =?utf-8?B?VjRBQkEwT2xhd0JxcmZGSmIyNGV1dTFULy9BdnlkYlRGZlhjWi9aMVVpZUxk?=
 =?utf-8?B?SHJCbVlibGpnQUJIUFh5R3dBMkRoR3dORTg1dVo4dVV6NVIreTZFZkRLWGtH?=
 =?utf-8?B?UGlEV3BSbWgxOVlzbCsxcFo2UlJPL2lGeW1YRE1lZWhBekRTUGZOdjVIYWl0?=
 =?utf-8?B?WDNrdDlnd09GVHBXVWpVQVI5UXY2VVgxKzRGR2NHc3FhaWRCRlVTN2J6ZVVX?=
 =?utf-8?B?dUtpYWp5QmFZcDBwbDFIRGdpdHJUSVVCbVZmVFlNRzh3UkwxYXdVWVNlcFR1?=
 =?utf-8?B?WDF3Mi9EUlEvTHlwQVFFaWtiMitUa0VwejJzd1lTUk00SWVYeGl3UFpuL1Ix?=
 =?utf-8?B?aHhzWTEyNm1kSWtlZERKNC9VelBiMjVwVEJpNE5WT3R1VVh0Szdmb3Z1ck94?=
 =?utf-8?B?enBEcUxxYk9OYTNBZktKcms1aTJLZ3RWSHM2WGMyUjhPUFg0NFNiQlFLcmdB?=
 =?utf-8?B?YjFYRitFZXVmTEI5Rm1IN1N3TWx2NzVUMitTdytCLy95VTl2NURabVUxUTls?=
 =?utf-8?B?YkxVVGsxOTJOeTBKRUt3QW1vRWNIbnJPTFpHVmZYdHNCcFV3bEhVYkE5Q2lY?=
 =?utf-8?B?YThtQS9SQ2NTczNaLzJHOGJUeFBRemVJUW42Z1R0MVZ1ZUlZZ3JVRElZd29S?=
 =?utf-8?B?NnFrYlpvQkM0MGRzMjlqSDhPV1plMGtUV0hwbWk5bXRBVy9rSitUMUdQNzZx?=
 =?utf-8?B?UW9xN2Z2V0UyNlhtQ2FtTmt3QlJCbzdZRmo2ZlJnL04vdzNnZkwzT2VzS0JE?=
 =?utf-8?Q?LcfodkzFPfmFutzTWIlDrmS76KUQCeJPVjB90SJrggBo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9ITnV2alduZDQ3M2l2SDZkbVIvSHF6ak11VTFGdUpzUVp1aDduUjltcDUx?=
 =?utf-8?B?VlZranJtT3NHdk00TFhKTGw0ZW92a2xlK1EzM0hSMUg0QmdKaFliMGtGbHJp?=
 =?utf-8?B?RkN4OEIzNlBjUjBYK3drMzd6MGhYQ0IzM29DTVlsSHoveEJHRG0yT2lrSkZY?=
 =?utf-8?B?OGZmTFd5THVuWmFiMXZlSE1ZRW5Yd2xhdWd6cWpJTXdIbmJaWFBiNzdNNVNa?=
 =?utf-8?B?cXVuakpXVW8weXVqSWNSTVBnVmpoQXYzclV2dERYcGo2ZHVKVVFJZ29YcHlS?=
 =?utf-8?B?OXFwbk9OTENEZXA0V0VaWndJV29xT0FrTVZBSTVjVEdTbGU2dmFCTVVtS2la?=
 =?utf-8?B?WWxqNEFxeUNpaGYraFcxV2grRG02bEROSzhqSVZ3dmMzOHllM0ZudW9iYzBx?=
 =?utf-8?B?MWJQRVBIaGNLK1dHUWVvSXBuT2tDVVFvUzg2cHFRVzZXbnlHcldEZVRLSm90?=
 =?utf-8?B?d3Nxd0tCUGxNb29jYXFDRVJXL2QrdU10TTJmZmxKNHhPMDlEQ0w0eTFpem5h?=
 =?utf-8?B?YmZibVRzcktESWZ3dnVVU2FDQmJqQVlBaFRKQVlPaFJCZm9VUWphM2VTK2sv?=
 =?utf-8?B?K1BYdk5XaVlaQ08rNlBTeXlLclRidUNWbFhtL0o3OGtSSzRIVm54M25WYzIr?=
 =?utf-8?B?VkxGTzlSZDA0ZmR3bit3ekkwc3g2SUtraVdkTjkxMVZ5NkxYMVlIZEgydG5F?=
 =?utf-8?B?VnROZG5LS1ZmRFJWRjk2bHZHaTEwUmpOd0ZqNS80ZGtpdllRM3BaajlWLzZi?=
 =?utf-8?B?S0lYdjNoLytINXJuNU1aLzVUVGFjVmhQdE41QkN5enBLaUIyZXJuRVFpajJj?=
 =?utf-8?B?YllpSzZEdzhiUXBnNzlMcmRPY2RNWjZ0TUZVUHBJcUY2RVpHbkluQ2N1Y1pW?=
 =?utf-8?B?OGNKbGw2SFZIY2dQNkoxWHIyR0grNTJUa1BtSWlPczNTTVljejFvWGtkN0kz?=
 =?utf-8?B?ZXo3aFRnczQzUkVpSmdHNm1pSEJ0eVFFeVp6ZkdBdnBYNWt2VzVWRnV2Rk1k?=
 =?utf-8?B?MmN6bklGeWdiQ1dIOW5uaFIzZFc0QnNydWZTWTVhQVJlR1dyakIvWnJTd25Y?=
 =?utf-8?B?VkFJR2xNQzl5MUxFQS9vRzhEbUtSOFFSc1d3azVnMVJrZUcreUtuYVFpbEFL?=
 =?utf-8?B?eG45S3JnbExyaHRhVU0yaHo3MHhocTIwRDM1ZllIU3FvcHAxZTdFVHZQdEhm?=
 =?utf-8?B?UXNuN2pmYzdpQlhEditJQ2xTZDNEak5kM0lSM2JHazNaMUZjQkZlU3FIWDNa?=
 =?utf-8?B?NVdwTndrd05lQTZoMGkxS3dYTkFCYWtKb2lRTjc2dGpEWkZpM2pvUmJTS0Ns?=
 =?utf-8?B?QXZtbXl1ZTloOTZ1ajdndTRrT1FFcUVYbUVldktiT2VtVUpBR0QwVXpwakQ5?=
 =?utf-8?B?cVZyYUFEUzVzak9hVlRsSXdMWjBpcnM5RmR2R0NxbDE4QU9pM09OdDJ4Mm5I?=
 =?utf-8?B?NUZ1R012K0dqTCt2eVM1RHkzVk84WmJzRS9vc3h5bnNxZGxQMlJtR29VZWZT?=
 =?utf-8?B?cENuODNQWTZYSzY3MGRZY0VxR29iamN0SlRvc2F4S25vclRkNVhTaHdEcTJ5?=
 =?utf-8?B?VElTdHkvM3RlV05KWE9sVXNEQ3hJZGxUSGRGU3pYVkhRMzBhcDErUGZESzcz?=
 =?utf-8?B?NDNySjZwOUVacXhWWlFkK0RxalFtQ1pNSmFqczR3LzBWUUp2Q0VzK1pqSzVN?=
 =?utf-8?B?aVVyb2NBeit6cm5uOUg0VXNCVU9EYkRma0k3OTQwN0toS1VOZ0FPUmlXQkdx?=
 =?utf-8?B?WmRIb0lzUnNXUmwxREVCU0xGSnZDZDloK1NFUW9lcm1IZXZjSVJ3ZG85WUsz?=
 =?utf-8?B?VlZZSXJHNStnM3AveHJxRHo1NFpIQVVJcG1yMERSbkttSWZBU04zWGVlblRv?=
 =?utf-8?B?RWo0LzBLc0lkSFpuVTAvUnpVOW52UlZjTzVyY1IxMXFzQXVIb2IzK2NHL2VD?=
 =?utf-8?B?MzBFWE9hbkN2RHpFK1lIOGZYN0dzSEloV3VYN2RKQ0pPTityNVQ5cENwMTFs?=
 =?utf-8?B?bnNVeHlLNFBYckhJUktNdjlxaC8wY3pKQmNHN3JCZVYyWnlNY3BzZFZkcjcx?=
 =?utf-8?B?VXZEU282N1hCdkwzNW0vTmoxNEErTlUrSENPOGVkQ3l5R1hISzVJTEhPb1Vn?=
 =?utf-8?B?cldNL0dRU0t0c2N0c0M3VWFhenc0YzhiSDdZZVFIcXk2Wkg4OFFNSVRhQm1D?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a745b42-f6c6-4665-f3c4-08dcec520f24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 13:13:56.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30nHuNBc5jFx3ilkWdckuytfQ5oG9bOwH6xCgTU6lrvnvqUsCSJbUbo6Lc/V/dpejtGTUvgMNm+zI0yivimIJWILvdMqpsYNK+4fIIwT9GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331
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

Hi Rasmus,

On 9/30/24 11:54 AM, Rasmus Villemoes wrote:
> Quentin Schulz <quentin.schulz@cherry.de> writes:
> 
>> Hi Rasmus,
>>
>> On 9/27/24 8:56 PM, Rasmus Villemoes wrote:
>>> Quentin Schulz <foss+uboot@0leil.net> writes:
>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> My linter complains that "When using void pointers in calculations, the
>>>> behaviour is undefined".
>>>>
>>>> GCC does say that "In GNU C, addition and subtraction operations are
>>>> supported on pointers to void"[1] but this hints at this only being
>>>> supported in the GNU flavor of C. And I assume U-Boot may want to be
>>>> compiled with clang/llvm?
>>>>
>>>> Let's fix that warning by casting the void pointer to a u8 pointer since
>>>> the size variable unit is byte.
>>>>
>>>> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
>>>>
>>> No, let's please not. Try enabling -Wpointer-arith and see how much
>>> churn that would require all over the tree (doing it in this one place
>>> would be pointless), and all the casts would make the code much much
>>> harder to read.
>>>
>>
>> That alone is not a justification.
>>
>>> We do rely on lots of gcc extensions, and Clang has documented that it
>>> "aims to support a broad range of GCC extensions". Arithmetic on void is
>>> one of them, and that's not going to go away.
>>>
>>
>> But this very well could/is.
>>
>> 1) is there a way to tell Clang that we want to follow this GNU
>> extension for that case?
> 
> For that case? No. But we do -std=gnu11 which is understood by both
> compilers and tells clang that we do use GNU extensions. I don't know
> the clang internals, but I strongly suspect that that flag would make
> sure that defaults for various warnings are set appropriately (that is,
> not warning for something which is explicitly guaranteed to work in GNU
> C).
> 
>> Is that the default?
> 
> In our build, yes. See CSTD_FLAG. But both gcc and clang default to some
> -std=gnuXX, with the exact value of XX depending on compiler version.
> 
>> 2) do we document somewhere the GNU C extensions we use on the whole
>> tree?
> 
> Not that I know of explicitly, but CSTD_FLAG=-std=gnu11 kind of
> documents that gnu extensions are used.
> 
> Note that typeof() and inline asm() statements are also gnu extensions
> that we make heavy use of, as are various __attribute__(()), statement
> expressions (i.e. ({ stuff; }) ), omitting the middle expression in ?: ,
> special handling of token paste ## after a comma, case ranges 'case LOW
> ... HIGH', etc. etc.
> 

Ack, thanks for the info!

>>
>> 3) is anyone aware of a way to silence some specific warnings at the
>> project level so that clang takes care of it so that linters use those
>> settings so we avoid people sending more commits for that "issue"?
> 
> I don't quite parse that sentence. Are you saying that your linter is
> being invoked by clang, and you want clang to pass certain options to
> the linter to disable certain warnings? I don't know how clang could
> know that options those would be.
> 

My understanding is that my linter is calling clang. So I thought it 
would be a nice thing to have a way to specify options for clang at the 
root of the project so that any linter "wrapping" clang would use those 
options and not warn/error on things we don't want to check.

I spent 5min looking for it and it seems we already have that: 
https://docs.u-boot.org/en/latest/build/gen_compile_commands.html

After running that script, my linter is happy.

Thanks!
Cheers,
Quentin
