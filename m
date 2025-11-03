Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB2BCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4C7838CE;
	Mon,  3 Nov 2025 15:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h2hAIYrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15758838D7; Mon,  3 Nov 2025 15:14:16 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B4483700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maFpqncMNjPUo2EUKTMZodhVVs0M3/r9xEt+jBHuh/1rBwRglL7Mc/qx7KA6+ASA9lPNP4NccRh0eoLs5P7uwwFCVKGEPJp3zgXNERRFEBGRhknfrDZHsYHoM+xuo2fI8ybUin3LWcJW0LxMFx4ck6o6En0ruoj/uW4F7yHk9kqDyX9XYGBG739y0ygMZN4Rd1HVSojh9slkpQLAoByvb1EAVUebhbSOLpmaT6SOUBiPBXxD5WrVDcRYjo2CGbolXjEYxtFo2MbsJ8ywWH6YeeprXew3bfC3YFAWStSy3FgTvbntZZMidTh+Ijrk12VFPgb9/7CQshLMY4ghvVdtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1oBeOOmWUW6rWT9pC+f4iMY7diLXeHrfZyFrQWd8pw=;
 b=LHpywYdYK+WqH3L+wS0TIYwQnd0O0Mcw19vOIlXnLm+nxGrHU670XwU5pUreQZN1/55IsL411Fg8rhipoz57ronAfUVl63uoMD8o5ZDH/TAUp5pCfODTag9Gjtuqm8lbEho3IAarpUsIYvbHEZ+f5zV7Ras2eeuJqeho9R+9fRVl9UYzy+/EcASPUhFW0qrT1hZ/gsvRX+qk7enKZwxcwI40rlnT5iy8b8zYMwffs+v46Bm7GBGaUj4GxB8uW4Z0osoLAYaS7oWcmDInLsvTD3VmWdUMW/eR43I7okaXM1KxLlsSyFCr90bobTCo5cT+trjSAmk85wE2jJOYB1Wecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1oBeOOmWUW6rWT9pC+f4iMY7diLXeHrfZyFrQWd8pw=;
 b=h2hAIYrE6msrqB+ilxND41lu+83PbdMKT2Jha4+POUi2W38illUPnMWU5qGCOmA3qP62mvWMyIQ95MJPxkmslJUs1bw1Pz/0h40pBgXAPlJmBjHlaQ0oai/xJ1zt7XZNvKRGttIjHE5jm0WopYoaagprXFOXOYvBOgf6AA7ZdUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:14:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:14:12 +0000
Message-ID: <fc2149cf-97ee-4ac4-ada3-c4797607a5ec@cherry.de>
Date: Mon, 3 Nov 2025 15:14:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cmd/part.c: implement "part name" subcommand
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251020121100.1742812-3-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251020121100.1742812-3-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a160525-2d69-4e62-cce1-08de1ae34319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZtQUgwZW1SckR6TDZCb1E1eG9PT2FPVGlHZG9maU0wUURMZjFxWFVrTFdJ?=
 =?utf-8?B?bU5PSzJJUXU5MW5nQktUZ1BpTVNIU2hXSmVGVmEyc3hTNXNJR1dSa1E3elQ4?=
 =?utf-8?B?NWhmNHhaTG9rYWo0OFhuczhrUWllNTVMa3VFMW1sQWplV2tqbTB5cVFnY1lk?=
 =?utf-8?B?Y2pnTURoUE5mYzFaajhQcTFqdjc5RHJsUDFyRTZUZzhKYytidk10bmxSSmh6?=
 =?utf-8?B?N0lWR0pEK1IvZER5QTVJYTNobmVPYTRIaU5veU9qclpuVXlIQ29KNlAwU2E1?=
 =?utf-8?B?WXc3Y2dPWmdZdnlVNkxhakwrOFdlNlBrcHJrYWlCQ2EvSmdZTGFuWEF1aHJG?=
 =?utf-8?B?RW1aaWVZTlgwVVZoRnNzS2VQbnRXaFVTS3Q0dWRiamg1bFd3cGVOM1ZRSmtn?=
 =?utf-8?B?ellIR0VxVFhvTklteHN5Ui9uQzFPdG15aHYrMHdKTStWV3RBTHBqVVhyY0xS?=
 =?utf-8?B?Ynp6K1JIYWl6Uld5WHFkSGpCK0NLZm1CSkw2MUhQYXN4WmwzdWx4L0YwY01N?=
 =?utf-8?B?Qy9CQS9BaVdjaWNGWTRHekJqVjAzNy9NTXptcVpRcFh5QlRLV09TSDFVMUZW?=
 =?utf-8?B?aXBlaTg3aTJaaFcyTmZ3YjIrMG1ZVGMwN0ltSWgyeFNrVTZUTkx3cVJxa2Mr?=
 =?utf-8?B?RGZVbnV0WDZmMUl0eGVxQWJVT0gwS0k4ZzNFRStxd2g5TUxyZFZwN29pSDJo?=
 =?utf-8?B?cFlEM2MzWlN3U2thMng4NWdwdEFBRmZFbHduOEorYTFBN0EycFhkbWhpQVBs?=
 =?utf-8?B?NFd6OGZxU1BxbTBjSzM4SEM0UGtPOXU2eW1CVExPN1BETWdPdzRQR010U1Qz?=
 =?utf-8?B?SFdYNkh0YWR1MHBQZ3kxWFNOZkliZTd3UUl5UVJ3RWE1U0RXQnJIMHVMak8r?=
 =?utf-8?B?MWl3dWNBR0JjUUpRclpQYVhzSlY4Sm9McnMyT0lYeTQrM0ZZVERGcFFOaGQz?=
 =?utf-8?B?WlFyOXUvVkdhRWdUVUM3UjZqekpDa1JhQ2J2NkhsUWV3VUMvSm1kLy9jdW1p?=
 =?utf-8?B?RlpkWHVkUG1yUWt5dkRjcGY2NVpCZDE1dWpSY3h0RzBPK3pZYVo0Z2NYeUdt?=
 =?utf-8?B?N3RUV2s0OVJxQlFoYitpbTh5Vnc3UURrNjRXb01sUkl5RDlGVmt3U1VaN0tG?=
 =?utf-8?B?aEVrUFpTWm4wdHhmWUo3T1QrVExOV2hvZHBRaUJ2KzAxdzhQWHFDczNxNUZF?=
 =?utf-8?B?MXFMeWg3c2VmY0FXbjZPSXFjeUZ5UDhPaFZxR29BMXhYQlNEQzlvdlVLUXN2?=
 =?utf-8?B?WEl5NnZZSVNqTkkxNnQ2akthcTlIZ3dJdHFFVllHYVBTOU52QmVvYXlpNWMz?=
 =?utf-8?B?WmF2ZTV5MXFkcDhGdC9kTzF3TXkvUVlxUW1oczNmbGVUY2d1UmlTcTVHcUho?=
 =?utf-8?B?bU5rVjh1N0liVmZDbGZLYnBnd3NEeHBqRUE4UkJtMEo3S0UvZmh1cHV0OW5m?=
 =?utf-8?B?RUdUd08xcnF4SFlYbUdJUlRGQVVSQTZSZDNwektIei9rdnhIRExRenlHN3VG?=
 =?utf-8?B?THVFN09qOHVBTWU5dThGaGEzODhMemZ6QVM4b3U0ZUd5b0tyQVVNWHY2b0Iw?=
 =?utf-8?B?UzlrWjlBV29scFRBVzZEamlrVnlIZkxHN1RkTXVkb0EwWnFGRWVkTTNkQVpt?=
 =?utf-8?B?RmRkcGtPSzNoakhsRVlBck9kd2QyRXdSUWhGbmRPZFZjOVdwZXVWN2JKc2Vn?=
 =?utf-8?B?Q3R2RmZIVHlqcEFJR2pKQVR1UlByeXVQVy9FWDk1Z1lmSU9zelk4L1RIODFZ?=
 =?utf-8?B?azVwTi9CclhLSnVxRWt2bXJDVDZ3VDdoMUQ5d1dkZW51TWsyanp6bDB4M2li?=
 =?utf-8?B?c2RTTWhIZTVNRklJdTcvajZtOVZ6QWd4UVpnM1VyYTVzcElmTWFpSU9ybnBv?=
 =?utf-8?B?Z3VpRnY3eDhZYTJtbnB1UEFtRndlYkxQT3ZuOGZMRUlTNE55OEdIVVpTanZ3?=
 =?utf-8?Q?B4Vd9of5/GAv1dF6qHuo1TKwUdF3yCAQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnA4L0luS0d1eXJxMElGZHluUDJtQ1lWaXFaYVUzOUxFYjRSZVlVcC9XS0Nw?=
 =?utf-8?B?WFE2cmNqUndIVDhtKy95cFVwUXorbFJVYUlGUEhuQ2xUZjVVU3RHZSt3OUow?=
 =?utf-8?B?Q1lhSUs4MHd2cDduNjUxcWJtTFdBU2ZZdE90K3FtNFd4YTJ6OWVPZk1RSFJF?=
 =?utf-8?B?T1FpajE5SnFkZ3BkdVRiRWRpTm4rZFlBNy95bUVmdG8wbzVhVmpHdnFQMm56?=
 =?utf-8?B?MWVVZHBBbW9aN2pTSkdZMkVBdUVZUlFxK015dnFPRmw5d0pHTVZSVXlJRnpW?=
 =?utf-8?B?LzdtU2tIZ0t6OHNTUDdvSmNscnN2S2FHNUdFVWJhOFNSenp4WmtPZnRrNHNw?=
 =?utf-8?B?Zk1pN091Wnd1eWkzdjZobGx1Uk5NUkREQTNHRHpQVWJ0UkdsQ2NEZStuVDBr?=
 =?utf-8?B?aHg4cFZQRUJNY2hQTUdDVHNEeTBvNlZmOW9ROUNMb3ZpVXNsWXgrcTBEMzdj?=
 =?utf-8?B?MmV1cENBOXJnT3dKS2w5Y2pHZi8vZjdLeUZ3WERNMjNYLzc5ODdUZGRHSTE0?=
 =?utf-8?B?Ry9GUVd1Z3VidWpOTHRxeUdGdlhHTjhvbFBPSUVpQmFVeVVqM2RVQ0h1U3Bu?=
 =?utf-8?B?dTV1V0hsV0tlYk1YRGhIemVQa2p5UVFBVXBsbTdDaTFFL2tHUnI0SFVjbmla?=
 =?utf-8?B?T29yQlJabFRwS2JhNkF6SnJYWTNsVktCeUMwNnVDdmV3dEFwNmRtVVhPdnZy?=
 =?utf-8?B?WGJuOGs2cE9rclJwUGpOOEVGUzJPY0xpYzd5eXFlbTBEYTRrY2hJb2NOS0VI?=
 =?utf-8?B?QlF3M3Y4TFh1QktiYkx6UjYrNExDejZ1V2JTSTJqMGRBdVp5Uy96cWZ2ZkZM?=
 =?utf-8?B?amNadi8rblVsQ0MyUUJac2hFa3BvbVVOY0pHQkpJYlBid1FHK2JiZ2Y4Tk80?=
 =?utf-8?B?OFpMWXJVNkd2bmhZejByOWxCQUpTa2t0UGlvMm1jZ0h1WGloTnVaKy9UR01R?=
 =?utf-8?B?UENibDJmT1M2QUNwSktsTWUrb0o2aTBsUHZ3Qm5QYXRTUVNhTU9oa1haTHYv?=
 =?utf-8?B?RUYwVGtML3pQTXJENS80SEtnck9VOTVDc2VXLzE5aFNSQWUybytjMzdKTHQr?=
 =?utf-8?B?WlRucVBJN09mOXVxTEc3Y1FGSWVMWkZkM1BJcFRKUkV1UnZGUkxadnBLQThW?=
 =?utf-8?B?RkpWMUJnaUFrSExpNjFYclA2RVdubXNOVHBSNVJJWGE2OXpPWHYrb3U5bnZy?=
 =?utf-8?B?ellsNVgycU5wNUNLdDgrMm90L1BkUHdza0JHUTByRU9RS3BJQ1pYcXZGUGRp?=
 =?utf-8?B?emJ1UEhPUTVXelpZeDg2SndNSzllS1hOd25kTWRNMHRJb2VRRGhxc0dHdUFq?=
 =?utf-8?B?VWJTYWhQR2dJTURCMjdWV1VVczF1alhMN1RmS2pJVDVuaFc3eE0zUnE2V3hj?=
 =?utf-8?B?OE9jamRLU2tkQU1KY2c1Y2JoSXdqdjhxZzBsNDd2UUJRVGdabDdCS1I0aitX?=
 =?utf-8?B?MFZCNG80bDRVYm4xSFc0RHgvRS95WTlveVVlN2ZUMzVYMHZGOXY2NW1jZlF1?=
 =?utf-8?B?RDd5eEVZaVVMU2t0VWtuQ2ljMUtTSlp1VGJYM2tadG53bDVyek56dFlNOXI1?=
 =?utf-8?B?TWo1NFIwL3p3K0svakdBSXhKRHpzazdEdnZXUXZuMURZT3A0STQrWkNDajBQ?=
 =?utf-8?B?a2dvQzlHMUFoK3p6RzZCUGZEKzZ1enJEclZrSmxIdlpwMmN4SzVMRUFxQ3dK?=
 =?utf-8?B?SVZJNlZXa1AvT3dlS3VmS1o3bitPcE9ITmxRL08yWml4aVd1SUw5Q2IyTlQr?=
 =?utf-8?B?djZaL3ZaNzM0L04xcnhFb09ERW5lOWZFenh4YjhGdmhhdTB2TlN0c2xRVFhh?=
 =?utf-8?B?SW5Xa1VWVzZrZ2QycnQ2b2lrcTVPS1FYWTlwcEkrZVpMbkZlTTJzQmpHUXYw?=
 =?utf-8?B?Z25xSU1vZTF0RE1hOTVlcEtVeEZnbmM4NkNHWEZUUjFCTnBmcHY5cGFPV1k4?=
 =?utf-8?B?NDA2RzVPWE1qVUNERDdxZjhrOVJ6QVlTRm5tMlVzNlN0cnpaQ21iVDUwSUpJ?=
 =?utf-8?B?OUR1dWI0UkZMcFcydUlzUGN0YXhJbDZhMVlvV2MxMlBwODZrL2dBTWh3UmFJ?=
 =?utf-8?B?WjJTdmE5elVYMGNhVHo4TWY1VFoxU2NlMFE0RlNLY2s5cWlwdnByWURhYy9j?=
 =?utf-8?B?NnJmTUtWTGVFQndGUnlIM2tTYzAxK256aUFDRWNQSlhsTEZCSTJvSFhpNGwz?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a160525-2d69-4e62-cce1-08de1ae34319
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:14:12.0659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL9kc3KQzV71LpLyioA1jOvX3cfRyfZaNOQuu+/SUdKQ5QljG3f4QmKqhUprvVgAuSttgrlBZfiO+r4xsx4+VihZURoPXb74RiuXs7E2biw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

On 10/20/25 2:11 PM, Rasmus Villemoes wrote:
> This is a natural buddy to the existing "part number", allowing one to
> get the partition name for a given partition number.
> 

Acked-by: Quentin Schuloz <quentin.schulz@cherry.de>

Reading the code, it seems the part command tries to auto-detect the 
base of the part number as passed by the user, which isn't that usual I 
believe in U-Boot (usually either forced hex or dec?), so maybe it's 
worth mentioning in the docs.

Thanks!
Quentin
