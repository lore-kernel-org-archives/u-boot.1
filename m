Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0F5C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D17A881C1;
	Tue,  6 Aug 2024 15:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IKdtEYfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB70988A11; Tue,  6 Aug 2024 15:07:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8CE8811C
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 15:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUP3Yg0kEAiGJgiLJWsHK1zk59jW11kpNmhRcf06mjp2x80+aYChu1aiJtrh3/ai/VUC1EGQutnTvv1UwluHDRQ0I3u/bOKzFTQfQYYHSOAiKYLy8YcU7i47UimjmpN38/gSc/l5S6AsxhocA5/2Y17aHVcA3VtYpAAjj/1Wb7nRhwnXWRtp+5ZjJC6V/X84lxAfgcIXQvqVHEFL9MzQD4Qn0N1CA1QdLb2oBGthZieYA4nKDrgjZGf/dn1SVWWSYWVUzT7xxizFofNYKC/Yez5qy2n27q//1dMLggOez9kEGDdplv8eLZGbgSkPVhIsi+cXQR1/FCSMU+7DxqzVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=683uSYFLM2XHRhY5+pvPzFpTOuNbxVjGWSbR0lqBeeo=;
 b=TkMFgsYLZvu94VixyIKdZGGALBwhSd/H5EjOwx4t4n6dOqh9j92vv+nDBdez99LKvR36udZx2oR743QAqfB3F03Wa7srCjFjTpG4bUugdsF2datV8ekd7oYRinBrh2+xT8mqWL+5ean0YwNatguIMR6coeJIGrslsirekhaaTIJJPCsM1iGwPxkDlScQEPTdo42lF3uFEbsbiqPzFxC0EErLuzwdN8s5d1ouQR+ENzcgFhxYuJrZCoR2AoBy/oGOcqr2Twt6/9S9nPC2UEPnKM1rs3NhtPnz9/tDZsoREWZzBS3/LDt4ijFNEc1gkvCJOxgeMm998scWl8+uTlZrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=683uSYFLM2XHRhY5+pvPzFpTOuNbxVjGWSbR0lqBeeo=;
 b=IKdtEYfaxezNTgqs3cV5rCII7u6xpSdgXPOZPXtQjAudmjAx0qlH/Ogo74RcULbmN+cnKUagqVHGx6BCO6+sbwU63reCxLNOlLTt/Tm/nBRMVZcq4N4TRtpzFfHPcrUu3qT4MtXxGDFrPf3PwDA1pxlxF0I8n1L5r9AqfLUeJcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 13:07:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 13:07:47 +0000
Message-ID: <b96b6e01-b072-478c-9792-e53e3695c88a@cherry.de>
Date: Tue, 6 Aug 2024 15:07:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] rockchip: Move the default timer init to a
 common file
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Jeffy Chen
 <jeffy.chen@rock-chips.com>, huang lin <hl@rock-chips.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::27)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: e79a3188-0cce-4817-7d13-08dcb618c463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmNpZDVNWjJOL1JZMzNqYjJpbk9Od1hsRVNDWmdaakNrdklKTGNzbDEwaEZh?=
 =?utf-8?B?MnBZdkk1L0J1SjFaMFN0WEVJZFpPdWY3bEtXUnBNVUIzVEd4aXdyaVNVYUZC?=
 =?utf-8?B?RjZoN2szSUJkUW81MVUvS0ZER1RUdXZiL0RMRmxkcUd5VjZ0NDZaek01N2pF?=
 =?utf-8?B?YS8yVmo0d3orR09kU0dlUWt5a1huZlh2cEl6eFFSZEpWR0JnTFdsSUFzTXNX?=
 =?utf-8?B?MFJQdG1pSWp1NDdRVlBkZlpFVW1naWVLbE52bUNsVG1CbjZUMTdtVTdZVlBJ?=
 =?utf-8?B?VldRaitmdURzWW1pakg5aG5JWU9LOEZBY1NsZXEzT1JQTHpNbmJiUEFwQ3dV?=
 =?utf-8?B?RVBIV2dHSkQ2ZVYxZ1FMYXdUOURTOFBYRmJ2S25BSEF0QTRyVlJ4b1pEd2xC?=
 =?utf-8?B?d1hoanJjTWVBbVBJVU55dEFRU2ZzczhadVIyWCs3WHFkRXkrQldnNUYzL29F?=
 =?utf-8?B?MmJNTVR4MzUrT2c5bDZUL1lNOGlSaEhsbnNlLzVXMDRUdjlJdDZBYmVSQTQv?=
 =?utf-8?B?c0RvVzFvSU9lU21kOEhrTWVtWVVkQ0NUdGF1TnVlbitESGRTdWtHelVGdTlZ?=
 =?utf-8?B?WGFlRGpqeDFOd0lYWHlQbjBQWnpSSTFXSkI4QzYwQm9zWXdVRkRLTmtJLzU2?=
 =?utf-8?B?WkU0VmcvYjdobDdLNHlCYzdmNnJVd3VkMWRhQVdUSTVsY20rUEMvRzdNQStP?=
 =?utf-8?B?b0hVUGlkdTUrQUE1djVEOFlDWDdkRmZ3Y2JVenREdHV2RUZRTVBBSzQwOWlv?=
 =?utf-8?B?ZytyWjlzMEpNVW9uSWticWV3QmF0SU8welQzeWRpYk5TdEZtNVZnejN2VENm?=
 =?utf-8?B?MGZFc1FyQlB2Y1prZWpCNzhqQmdVV3dnSnA2RGdRUWpDYzkwNTRObTc4TTZQ?=
 =?utf-8?B?aWlIcmg0bmhBLzh6NEliSEZxVndka01ZRnp1WlNSMTV5amNqRTRadjRTOWdx?=
 =?utf-8?B?eTB0THdxVGJjckJwWGlXaXgrT2NFMEhUaDBURHZzQ1d1Q1BkbFJHMDJJZTkv?=
 =?utf-8?B?ZFJoaWx2RmRsVFl2NVBuQXgzRXVnR0x4SnczSS9TVTAydDRKTmc5M2wxaUdR?=
 =?utf-8?B?OXgwWnhDWWlxOWdlRUF6N1UvZFZac1JqUjQ3L0dUaytLaHZ0czJGSjBxMFNu?=
 =?utf-8?B?OEdXeitXVFVLWDBXR3J5OUcvbk9BZHhQM1FhUXAvaU5wRVJNK285TUJNeXJt?=
 =?utf-8?B?RkpROGVlTXp6MGwrSnA4WDZ3N1lxcVJFMUgvWFZqV1VlTHNqWitzOWpoV0Fs?=
 =?utf-8?B?d25VRHo2TkFTbDlmeTRFdlBwYUIzZE43K3FrNjN1NE80YXBkc2NndFZIWFFG?=
 =?utf-8?B?cGg1cWFkLzAyTnRTeU1acUVaTThBbENFM2J6MEM0WWwrT3k2Z3d3SnhCQ2ZF?=
 =?utf-8?B?d25KTU5oTmQxd1A2Y2lwZkYxUjVJODZGWjRnMk5mWldybDZENnkwazlQWUwv?=
 =?utf-8?B?a0Q5U2l6aXF4YUVlV2MvUkhPWUppTmdmdmhMNENSbjd0MjVVaGlYeFhHSkEz?=
 =?utf-8?B?eWlzZ0JWOHgrb1Z2bXBZRHQ0Zjg5ZWxITisrQldlU1V2VkltNkw2TlJPd3Nk?=
 =?utf-8?B?R0dOVXM1cTR0VEp3SWNWNnpYN0hqTEZGNG5ndms2U2pQQkhPUG8wNVpWb2kw?=
 =?utf-8?B?eXZGWFNINlc2NDJRb1BJa213V2R1SVlYYnNGNjZJR2J3NkhZaE1kdHNaQmpv?=
 =?utf-8?B?WEV2WlpkNmlkTjVTT1RNUkdFMUlsS1BvRGtVUTNnQklvaXllSlBSdXJUVlZJ?=
 =?utf-8?B?SmtZVkw2S2N2aUNuY0VMZXNvcWdTOUpnVndhK0E1VTc0Z01MNzFFRnYxbW5L?=
 =?utf-8?B?U1N0VlI3Q1QwUUFnbGNWdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZLVWE1dCszNi91cWpZRWY4VGFDZkJGeXFmWnhOM0ZIdXRTTmRvZUl2MXZu?=
 =?utf-8?B?QUFwVXJtcm9GSEVjRnU4Tm1hMzgrOEdTUmp5VGU3RkFrTllqRVY2TUFnWUNJ?=
 =?utf-8?B?UmpmaUZtcEZnLzBmSk8vcG03NUIrVU9ob0NrUytpWm05MndDdlZKeDZaWHd3?=
 =?utf-8?B?VFdBbkhSWTBRaVBnOXZyazVWVHNJNVJHUFNTdHByMS8wTUJwbkE1azVTRitM?=
 =?utf-8?B?MGZKZEpFRHFzdTVPZ1NpMmNhN1hrQmtmMVBsR2FDL3dWdzF2WEZVSFBtN3NN?=
 =?utf-8?B?VE04NElKR0dOL2ppcHJId21YZlFtQ0V0TWRZNnU5T1p0TE5BNVNabGtmeGNx?=
 =?utf-8?B?MEdGNlV6UzdZUU9VcWlobEZZcWpaRm92eFFsWXRpMldxRnVVZTFBSHNhdUpD?=
 =?utf-8?B?dDltL09xZ1dFNUlzN2JHNlgyVVRzNVJQcy8wbzFQV1gxS0hHZVVDbDUzakZh?=
 =?utf-8?B?dHlYSHY0cXRLM3drL2xQM090Y1dIM3h2YmI5cnVIbjRRdU05V2g4YTQwczRa?=
 =?utf-8?B?UVN4T0pjdWRmbnhiZUN6UFpZV1pkVWRMZkJXdlRGK29sOWljUUJVSFlXd1Rs?=
 =?utf-8?B?bnh4SEZQRzRxZFRsTUZUMVBMM2NjQksxYkRPOGNDMHlKUWhKTHk4Q3dHdjU3?=
 =?utf-8?B?Q3J3V1lnUFhBd2pIODVoL2pQWE5DNzFLR1lzYXNtanNxUk5TWndIRlUwVVNX?=
 =?utf-8?B?QjliRy9lZzVDQStIc0NoKzBnNzRLVThUb2tHT2ZYbGVLd0F6eWJNaGhNZU5k?=
 =?utf-8?B?eHlTWEt3bkdmMHNUSlRWcThnMGpUcDVGY1RZdzVDNmlrdXhNMkpUSDRtNC8w?=
 =?utf-8?B?RkI3RHVVSEkrT1pOQkFOZGRTWkNINmpMbmU1VVZ5U3JycHlsaXQxU0FTbFlj?=
 =?utf-8?B?WmVEd3ZVNExQZ0Nrd3JDZDRoRkgrcVBESFQybW9DMzk4M2RxQjV2c0dMZzhN?=
 =?utf-8?B?YWxad1hBS2dEM3REWVF2d3Q5eXdZR0J1aUFrY0xHZ1BqN0xJM2YzK05KNUUr?=
 =?utf-8?B?NHpvcjJ2MEQ2eTZSYndJWmNSRFlHSjhPMHRXcnpqbWh1cEFIOUhxcXIzVE10?=
 =?utf-8?B?WXF2eUp1NW80cDIzZlZQek5IT1FNK2o5VTcxamNNTGdwc1Z0NFVyVVNSeHVx?=
 =?utf-8?B?NCtnck45cHVnWC9IRmRmUjBHbUw5Z2NMTWNvZFBIeTFvVDZ2MmpMUUFSMDdk?=
 =?utf-8?B?QUhEVHBzTXMxV2JQVGZhdm5jQ3BaVnVGOE03cXJmeWc1Lzh0SVdkRnYvamdD?=
 =?utf-8?B?Vmt0NkhpeUhqRTlBUnh6d1lMeU9wNThDM2hBOFllMmtZa3h1VEsvZ3FYeFRo?=
 =?utf-8?B?M3Ryck9pR3JSNm03MjBMTlEycGpZa1k3QW9GS0FRV2RWQU1RYm44QUZxQmVN?=
 =?utf-8?B?bk9henRhZ1k4Z1BMZGtIRjMrbCsvQXREQ3hNWEpqL0R5ZFp0TmF1NzBLbkJl?=
 =?utf-8?B?Y1lsLzdvSjRtUVRJOWFncGp6Y3BCNURZZHQyeUczdS9ha0FGL2lwR2lKaWJN?=
 =?utf-8?B?VkdhcmZvbW8ySjNhanlCV1Y2UnBpNTdxb1gzQzA2VlBOSmVwVVliOWo3TndD?=
 =?utf-8?B?RHRSMzFoRGFlQzF3akt5QmMxWDM2UXhVK0VpakovWFBSeWY0ZXplSVJVTHRM?=
 =?utf-8?B?cEdqSXFUeWlPRDh3ZnBReDBSbUFOM3NiMDNHZ0Z5SCsrMGs0K3VJU3FydE1p?=
 =?utf-8?B?YWRCZHlCc01lRHJraTFEYUFQU21kTlp3clBTTXBweVovYjBFMlgwTWJFcFEy?=
 =?utf-8?B?Vi94em5ORXFhN1FMT0VrNDE4d1FiSFhWNTFKWVhjaVRrZUtSWGtWM29MNVh3?=
 =?utf-8?B?TGJPY09TQk84aTd6VWFIcjJrTG5MckxMd3BpR1Y3c0NzbHprNFM4Q2pLOS84?=
 =?utf-8?B?QkxpeE00WVRZZkREOVJ1NEVjRkhycHlyUENHeElBY1Z5cE9DcjZLNjlmY0ox?=
 =?utf-8?B?T1ZjZkN0VDl0bElQTndmVTBqZE1ZTmtETThJeHY5UmhDYm9FOGoxZG8wNGRB?=
 =?utf-8?B?VGJVMERQOElCT25Ud2gxc2tDei9RaXY5Y0p4eW5sZXc0L1J5MXgzL2RqMDZh?=
 =?utf-8?B?TDQ1a0V4a0hxUE5mdU1KTDl1WGpUQlhrb1o1N29oNWwrTnVHS3p1bUl4ZUxt?=
 =?utf-8?B?d3pLWllMRnZIWElseFh4eENodTBRTmdBNG5KekVHMUNWamlJQ1ZnZHJpN3BR?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e79a3188-0cce-4817-7d13-08dcb618c463
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:07:47.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWmVXZmv9n3ClqaPvXkG9pkmJN1mR/4EtNRssaC+Jxe+U3b1vMJFRXFjPITYxzIoiXJ+Bsrln+SM0/rRJM32J3N6fY8BeC72EPOgjgq5I5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> Rather than repeating the same code in two files (SPL and TPL), move it
> to a shared filed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/include/asm/arch-rockchip/timer.h |  3 ++
>   arch/arm/mach-rockchip/Makefile            |  4 +--
>   arch/arm/mach-rockchip/spl.c               | 21 +------------
>   arch/arm/mach-rockchip/spl_common.c        | 36 ++++++++++++++++++++++
>   arch/arm/mach-rockchip/tpl.c               | 30 +-----------------
>   5 files changed, 43 insertions(+), 51 deletions(-)
>   create mode 100644 arch/arm/mach-rockchip/spl_common.c
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/timer.h b/arch/arm/include/asm/arch-rockchip/timer.h
> index 77b54220447..b5fc738c98c 100644
> --- a/arch/arm/include/asm/arch-rockchip/timer.h
> +++ b/arch/arm/include/asm/arch-rockchip/timer.h
> @@ -15,4 +15,7 @@ struct rk_timer {
>   	u32 timer_int_status;
>   };
>   
> +/** rockchip_stimer_init() - Set up the timer ready for use */
> +void rockchip_stimer_init(void);
> +
>   #endif
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index c07bdaee4c3..3b13891ec24 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -8,9 +8,9 @@
>   # inaccessible/protected memory (and the bootrom-helper assumes that
>   # the stack-pointer is valid before switching to the U-Boot stack).
>   obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
> +obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
>   obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o
> +obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
>   obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
>   
>   obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 3ce7e792b5a..bbd223bc524 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -13,6 +13,7 @@
>   #include <ram.h>
>   #include <spl.h>
>   #include <asm/arch-rockchip/bootrom.h>
> +#include <asm/arch-rockchip/timer.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> @@ -86,26 +87,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   #define	TIMER_FMODE	BIT(0)
>   #define	TIMER_RMODE	BIT(1)
>   

Please also remove the now unused constants just above this line, the 
same way you did for the tpl file.

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
