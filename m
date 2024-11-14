Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA0DD65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2B189607;
	Thu, 14 Nov 2024 11:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PfYW6NfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFA88960E; Thu, 14 Nov 2024 11:49:38 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C139689227
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbGsfObfpmouIaKvsgO72+p5xne8oEJAuk9q3igmSIiibZ2pA0Vz0AZQTjFZKzTVdqWbiemullY2PAkOQJsBcG/kkT0PbWruf+9CEklxWNa1iQ4Qx9aT5mE3wPZG2Am6xiNwbCdKZ8gV8ZhwyKCTZlDECNdTuRlqpHXrVVJRTztUvImfkGkfDfOs6+hevyqLrC+auNCdjRz6AcFwOGBmo3x/gbM41fEK3U/jC/cGbn5stryOvQU35VUeXCCa7So4o1XQbd73RhY6BumoA3IYJAaNPHRJEHdRkIxPjNhqAoGq8hE4BRhKr3lqK2MRrlgFj1nBmA+DTxG2ui72eqkcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG3jHUXA0bE17QLzhzZXXswbSemy61EUOYRIQOWZG1Q=;
 b=ZYFjTtsMHO6VEi2yVXPfOR0hgRcja0im7+F0BRfk4KrIjvDML+ygL6jr0FBVap7F3VbPFiDBBxzwyiNAbdem0sKKGzOKB5hfa82YSGI3R4XwvvkEBx3jxhxCqTgRP46hICuPyire1K5Pia7wmQGlRlDn2bX8+FHym3/7pedZqZa72NNQcicg1/9kO8pvPOa3OPP5EvoGRH7OTxKJSHir5+O/kWJZ2IdSXACt8evQtN03JFJY0NmBy3i+YvZ2I+FbjkJyaJmXfxomxN4lj2eT1B5fFckfpW5OA212kcZPkoCHFC7GnMFRkzPrRneN18dPWnyN0r1MPzqnAN+iva7lPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG3jHUXA0bE17QLzhzZXXswbSemy61EUOYRIQOWZG1Q=;
 b=PfYW6NfJ2phCyNnf0/kDRhbX0ftytw1XuaV08tqpRTu/0hpqP7XLBwccH+xndT7WjiMgx+3MDvNb4AZQuS4jslnE2mOCoq1MEDP4D80rbPcjcJxwUNuhcCcRghPxMH/lg3zhTCvv+BDiXfc+kAVkyEW2bo8KMee5qWwC0Wee7lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8283.eurprd04.prod.outlook.com (2603:10a6:10:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 10:49:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 10:49:32 +0000
Message-ID: <f12cedb7-51cc-42b6-abe9-f3b99d3e1956@cherry.de>
Date: Thu, 14 Nov 2024 11:49:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Makefile: detect HOST_ARCH properly when CROSS_COMPILE
 is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
References: <20241114102138.1977060-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241114102138.1977060-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fccb3d-6d15-47ec-c964-08dd049a0573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YURuUnVlMFhYRkVTSzNTdWc0Ni9MVXRsZDFUeDg5ckQwWm9ucXZ2NTFPVmJs?=
 =?utf-8?B?bFV4UVNhSld1VTBzc0hCWmwwMWRlWEIyd04rRXRYSkZBNnRJd3dhQmp3bGFX?=
 =?utf-8?B?aVdjTCtnS2NMTFJhcmkvTm5Icnk1alRaQUFVK1lKSWRRT1pHRTJEZ2pVazIw?=
 =?utf-8?B?ZW13Z0ZHSDZ1OWN2Nk40aTlraDFwbWx0OVZBU0dwOXlxV1NLZDVLWGFTc1Vl?=
 =?utf-8?B?N25haWMzTGh6bUR3S0YreG93S3pVcUJ0eEx5TXJvSkxWQW9EQytXUjhxSEd5?=
 =?utf-8?B?d29rWEVaVUlCbXVkZ05NdEFIcTY3MXVUTG8wWVFNUXpYb0pxa3pVVytmaklL?=
 =?utf-8?B?ZU1pcFIyWnBsTTg0S1NHSVBnbGM5em9QVk13UkVUSDBIYm54WEpPY3lYVUN4?=
 =?utf-8?B?NTNSY08vK0ZRV25PZHVvNHM1MXdaNlUzMU44c2pwbTlsc3BEYmhUenMzUktQ?=
 =?utf-8?B?UWlscWQ4eFd4TVFmR2lzZjhlTkpRcXVzbkVPK2ZCWk56WmhVa0xTbWlvMjdG?=
 =?utf-8?B?YXFTenpudnBQOU9QMzVIZERlZWV1d1hQZGRMSGhOYjNCMlc2cVBLV1RkelpG?=
 =?utf-8?B?UFhicDBDRVB6MktFNlhDY3IxYWZtWFc3OFBjaUZLUUo3ZFAzS1JSaHdSVnoy?=
 =?utf-8?B?SUVhdWZJY2NxdmFrT1YySzdIc205M1pJaVYxSDI2MUcvSWRXZU4yekxLd1k3?=
 =?utf-8?B?akVJSnlhazBHRjhaMU5Kb2hxeXQzbFdxR1RlR1dHK0RhWE0yQy82a1lSbFJl?=
 =?utf-8?B?anlhdlB5bE8vb05Ub1cyQ2lGbzIvbWhrVmFoRDlocXp0UG9EeUhobmcvRFpB?=
 =?utf-8?B?M2Q4VXBUOHZ4WVFteXBxMEtVZ3JFZDhHd1k2TURTRktCT1Y1TTZYeE5DMHB4?=
 =?utf-8?B?U3BncndVa0ExeXlKWFlMc0RoQzRTUzh3QTU1Nzc2L1lVRzBickY5TE02YlN6?=
 =?utf-8?B?eGdNTkFZekJaT2Q2aCt0UHhXTmtLUXlVa1BDL3Y2NzZ3V1JXUnhUay9PeE12?=
 =?utf-8?B?UENyREpJU3R0THp3TFAvTjZuZUpRcHhmYk1ZL0xnQTBKRzFIbWVXd1FKSzRs?=
 =?utf-8?B?VzF3N0R0MXBERjIxSVU1bzVDajROaG0rUVM4cmJMdXBmM2xKbXpmRmR5YUxt?=
 =?utf-8?B?cXNXakx1eXBXZEtHUWt0ckFtVmNYdEFML2M3WlhMMzMxLy9uSndnTFVlbkN1?=
 =?utf-8?B?Ty8reXcrQU5OaVlkZmdwbDFQMDI3dkE5a3h6ZEt6dGpIeXl1OXU5cmdaL1Bu?=
 =?utf-8?B?MmloTzRMcEkwVTZoaUUzZ0k4M3JZVGlUeTZpdFU5ajZmUlJmN1NPUFlHZ05Y?=
 =?utf-8?B?QkJWRUdFcWl2NmRIU3NNY0NvblgvUlpzRGVzYmVIdzdHS21Ta3dSK3FHM1pO?=
 =?utf-8?B?djRlMmlueXdZRThXVnBuTGhuNlVENmRrZ3BMalRYVDZjU0RqUVc4S1ZDdlBw?=
 =?utf-8?B?V3E4b0RZdEtzV0xJaFZoSjdma2M2UU9raEVoaVBKdU1GS3gvUG95Qk1KVnNz?=
 =?utf-8?B?dTZka3owMEMzTWd4OFd6QWdzQUE3TXdNd0RydjI0NTAyOU5IZXQ0OGlzQkQ4?=
 =?utf-8?B?Zm1vVExCUTJ6ZkU2WmVaRXRKY2ExMTBzZ3JKSk1iM1U4aXhsQUpoT0hUZkNU?=
 =?utf-8?B?bzNwdFVibDE5ZUdFWXg5dmsyWEoyNzJuV0J6MG9BSHpqL2RvM2FjczZVTURv?=
 =?utf-8?B?OVd3ODNObG1zdHFNcjN4cGoxSnYrTFVnckc0SW5hWmtHTHZLUHJZN2o0VmlK?=
 =?utf-8?Q?ktxOczQNOB2x6otgbWXxHet+K6rWg9oCqXQz8wP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJTOWNTVjBlL3QwTENpRFpHeDkxNUJQWmlOeTljNVFEREZCb3JRVnlMNm8y?=
 =?utf-8?B?UVBrRUNzeTNMQUlnYnRpVm4vSlNwcnRDbzZNZ0IxNWd3ajkzQUVkWks3RWx5?=
 =?utf-8?B?QXp4UmgybEJ4WjRwZHQwejY3UVMwdmdLc1Z5VGhTejhMNHhOVDZyZTRFMlk1?=
 =?utf-8?B?NHBEUWo0bUwzd0VnTzRYdXdPQzR2a2c5VzFoZ2xDM1Y0bWFjb3U4V2RINEFQ?=
 =?utf-8?B?MGVvam1Ca2ZsbjZ6cnd5YUE2TUpuV3kwbkIyN0toQ3JBWGtaMDYzQVZZb0t5?=
 =?utf-8?B?UHllcThqUDVYTUJLQm5GVFRqZHFvRzRHenNFMDd4TGhpQ3Z2dlMrU1c3ZGVk?=
 =?utf-8?B?aXFYZmJ3ZWIrN0VwTnhDSUp5NnRONE9SZ0w4TXFIKzkyRVRSVkpFYTNiVjRq?=
 =?utf-8?B?MllHQVMwc2NJM0hXNXpzbEdBelNQZU9YUFZ4bE1mYzBqUHRVT3hvdHVYVEhL?=
 =?utf-8?B?NG1YWkR1eVN6SjhJcUUvVWRFTllLY2NoUVhWb2Q4T0ttY0w3TDk3WkhpbHZM?=
 =?utf-8?B?ZHRRWDlYVThGOWt6eDVsajBtUzRUVHJpYlVCd3JZdmtTQUpFWkN3eHBlamZI?=
 =?utf-8?B?TzdaajZnTlNXWFRqTTl0aDJxeVlxR3FOZEI3ZFE5VVYwVTFyUHV5ektMVHk5?=
 =?utf-8?B?R04yejEwczUyV0EwY1FzREZSQnNCdUF5RkxuMDE4Y25INmZ5cVBvcmgzYVJB?=
 =?utf-8?B?aDZORTg2QmZueHlZQW43OHhkSitGNkJoTnBKSWVXZzFpbjBJZTFNZmVaU1VE?=
 =?utf-8?B?VzQ3T1I3eDNYWGtSd2wramNaNjdqSEIzUDY4N2VMN2oxNmljZjRkK0RBT2Q1?=
 =?utf-8?B?aHVkdkhNRWRIVjdJRG5RNWdpTkRvOXQwZWh6UFRGYzkzd1FNNzd2VGRvMW9Y?=
 =?utf-8?B?VHZkM21Xd08xSHZTUW9BRVM1TzgrSWlCVElONW11dnVEQ2d6Z2JocC9UdEJv?=
 =?utf-8?B?bGllZlBYaVJ0d3JKZmJDTHNyWHhsNlBxa1o5a0NEb3JwdFlSNnVGeVRSeEpQ?=
 =?utf-8?B?QjQ0QjZ6ODYvMUlVVVpxQW5iajR1Ti9adjlBSGdrZU44VGk1N1VwYmV5K2J3?=
 =?utf-8?B?VFZPKzBtSHZqNU5QREpvQWR3bDlBaTF0TEhuWE5hYlpZVkxUTmdPb2MxT3Yw?=
 =?utf-8?B?emg3OWlJcEpXdUVmK2RDU0J0Q0xKYStQT2h1UzA1Y21BbGdFVkVueFhQeFdP?=
 =?utf-8?B?UVJWOVBlODRHb0pEaGtXU2prNUtiei9JZHBwc2lHQm9pbHNNcFFSMXRTVCtE?=
 =?utf-8?B?R3JjZVBDN2FjaUxIMCtibVFyNy9rV2dpMkZVV3FEZzRIK1dja1BEcDRUYkRo?=
 =?utf-8?B?UForV0VJbUJJOGFVdUdpeWFCNUFVU0FLeHRKQStqN21CRmtYZ2RRaW82SWhq?=
 =?utf-8?B?U0VxMTRWN1ZaQXR3OUtRTFM2WDhISkVwWnIzVTZicHdvSkRVd0JtUXk2Ny9w?=
 =?utf-8?B?eUZmZG1obnIxSjkwaXAyK0pmTTV0anFabk5NOG8rRDJZZU5QcG1YRUR3MG12?=
 =?utf-8?B?d3orT1pkMnQ5Vng0WHVndlE1ektTbjRucjJUaFdKaFM4T2RPaGJDcDgxUnQ2?=
 =?utf-8?B?NjNGejVWV1lodEZDNmU1V2xtVURsQkJmMm5adjcrUUZieTNCS2lvaERnOVhW?=
 =?utf-8?B?UHAxOGtROTVQSEhlNmhqTVlTZFFGSU0rZlNWYjFxZVRSaWNOMnNvL1VRYmxC?=
 =?utf-8?B?WlFJWXVJQ0xGNVhLQlR6TzYveEx6ZXpKUjVXTXJnV2lrb3I0YlFRa1VrVDR5?=
 =?utf-8?B?dUphNXVBb2F0cEgrZllyYUo2emtMZHhTZTBveXZrZkJsUmVHZUhrdDNzTWpa?=
 =?utf-8?B?clJDWGNDVW4yRkU0YlJhcHl3VUJ3T1RxSm5tTlRjVTBuWlNSd0pEY3BJUjhY?=
 =?utf-8?B?WHNoc2o5MFVBUjlaN1AxTTVxeUJiUnN4TmJpb1FibFl6K0t1TVVrK1ZyeVor?=
 =?utf-8?B?SUgycE1iRTJnS0pyVVJJdmQ5elFvcDVlbmgzdlRaandjK0UzRklBSG8xWmZR?=
 =?utf-8?B?R0NBVWdoaHFER2F3R1grTDg0a3JpcHJtZUErc1hTeUdHaDUzMGRMN212eE0z?=
 =?utf-8?B?UENHY3pWWitkc0JHUDVZUTJoU2Zmd1BhWW4xcm93clo1djdiMUJadW5BNVZK?=
 =?utf-8?B?Qm5lOUN3Z2ZSQW8wTm1qUWV3R0R5RnVYc2lRYWJGZy94WklHOTg5bDhZY2NQ?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fccb3d-6d15-47ec-c964-08dd049a0573
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 10:49:32.1869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCkqftvXh9lHEuubEQ31h2K5RNz9OXDyANoqwuyZMsZvXxrha+OrLt2Mxz7WibFoNEdnpjEkbFazN8BaRHs/CmU0CPTpbRRYQlHTAl8Xp24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8283
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

Hi Jerome,

On 11/14/24 11:21 AM, Jerome Forissier wrote:
> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> detected and the build may fail. It typically happens when using
> ccache. For example:
> 
>   $ make qemu_arm64_defconfig
>   $ make CROSS_COMPILE="ccache aarch64-linux-gnu-"
>     CC      lib/efi_loader/efi_helper.o
>   lib/efi_loader/efi_helper.c:26:15: error: operator '==' has no left operand
>      26 | #if HOST_ARCH == HOST_ARCH_X86_64
>         |               ^~
>   [...]
> 
> Fix the issue by considering only the last word in $(CROSS_COMPILE).
> 

I suggested another fix here: 
https://lore.kernel.org/u-boot/20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de/

We just need one or the other, in in time for v2025.01 :)

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
