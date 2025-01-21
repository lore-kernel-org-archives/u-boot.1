Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C0C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16C2801F5;
	Tue, 21 Jan 2025 14:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i024O2+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B188078B; Tue, 21 Jan 2025 14:48:15 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035DC801CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpssxPmk6o5hiz7ccgs4Ia63XnLWov5YOuc2Eqy0NqpRzUi9EzYKVdzoY1vjQ9YBROqldlVvHfE3VosA4s/B3VGwHnNuLWr17s3bRZa7uAsJvonl0LUXTxfDAHvljzz+7V+pw0lR7nLTQ0MsDuMhbxADfSIq+yygikivg95HHl/Pzdto1z2lpbnti5hC10+J1+6P1AY4G76FgnrPMIN9L/1xYhM2hheYzuYF60q1heSAeF0xn0IRNyChBkiRPGlgb4hV7iEiHX60MAnMsSvSK5z+wCSvE+1xoYfkHPOyfxFQkRKXFNKsikdx+3zFBM0y2otLtJqHIA4VGPVOLHdgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzFXayN8ZuNHERHtlvma3U4sV1N/Ba/c7QzTVoQzM30=;
 b=sF/0e823X616PWgLTsu0Fs5ozkVXaEZRZLs5VhnZzSKQXZqe7AhOKy+3fymkOrNsG6P5q/pYYJe0qBksyIxkFOIhjDwvHcDpDe1bNUu/Ft+QTHalhDoXzNy0N6ypFrHvawTdZwcSEcusXOLfZudDIbHtkuFCCD1VEonpIwAEpSFfzHuYTs6htLU8wb/94HkM7imKgmrXq7MvyG/XajQtxopiEXco1yK3L1SxI5aweq3Rvm2Sn0pLa/tUtkTxnRbB7uhKau+Xe5INZAG5SgVYqBaItT+oScebUilins0VnmLjTHaTCZunnV8S30oT0GS2yu4UozHls0plVNWNPeX9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzFXayN8ZuNHERHtlvma3U4sV1N/Ba/c7QzTVoQzM30=;
 b=i024O2+iGl0/Rb7dI/MhK75EuhVHr7nj3g4f0iwOVNv0PSAYeR7j8mrYfKmo2PY8hDSBmTzGqvYhvyclqTwi8afI6UoUcYAkLz2dnxC978uc/y0YT7hllu90SuhNjSyTZPGoGvCX1kWzXZjGnYVwr5UP3CNHE2jrje/SM9sV1Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:48:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:48:09 +0000
Message-ID: <cb7f0317-b0a3-46a3-8765-fd05d0cd3aa5@amd.com>
Date: Tue, 21 Jan 2025 14:48:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Enable the OPTEE command
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250117064556.673369-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250117064556.673369-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0156.eurprd07.prod.outlook.com
 (2603:10a6:802:16::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2378fc6a-8182-47e4-7d38-08dd3a223d66
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm10cGVlaFdjRklaSHptaEY5b0ZKTklPbWtnYTA5UWxBc0RVZFlXQ2ozQ1Jy?=
 =?utf-8?B?STdkY1NtNk9GNVZWaVBrYmxFWXlZNmVxV0s2MGV4ZTZoWEY1cUpuTDBIalVm?=
 =?utf-8?B?SEpxaHhaeUVlZUJUN3gyV0dKSnUrbTNHanVsYXlEblBsVUxSeUZrWHRVWnJq?=
 =?utf-8?B?TnpJTFcybEFESUlleml2cEtIQjV2bWcxVEw5RE1FeTNQdENlL25aeDZrQ2R3?=
 =?utf-8?B?SnRwWDlHaDJoTVZGSDlUdWNWVVREL0hlRGMraHZGdy9vZWlKelFSZlJTNmpk?=
 =?utf-8?B?b3MvZkVzN0dvY0FnWUt5NjVMdEgzSVNBNzRRdURxZlg4T0VmZnlOdEpmZyt2?=
 =?utf-8?B?a0V6YnVDM0dpY2ZtRk1lN0dFMEVIcEZJazVPU1RmRndWMnoxdFZrMzYxWVdV?=
 =?utf-8?B?RDIxRVY0Zk1ZNHNxalZMTVNwVCttRU1OV1BHaFJOOHlRUk1wajNiL0sxeUhU?=
 =?utf-8?B?dWVXS2FjcG00dXNMOU8raCtIZVVaUWFHMW9jZEpXNTE0RWxJR2hIdzNSWlZZ?=
 =?utf-8?B?M1JhcHZkRVhVVWZ3V3NhdWI5NzZNc2JSeDBJamRtamVGbnVTVGFuSXpwaVdG?=
 =?utf-8?B?bnI5ZmlNQVV2WDFKL1JDTWYrNmJ0QVR4dks1ZDUydUJobHk5SWVVUXJ6LzBX?=
 =?utf-8?B?cVJQc2FZb0UzZ3F4MzRTODVCNzJodUM1L3crTFRWMGRCc2k1ME5zaTV4bkU1?=
 =?utf-8?B?REloY09sdDZ0Y1UyaUNwK2lyQkxMMkdFRzRxeTZZWjQ0M2oyYVFhVUZhUnFs?=
 =?utf-8?B?eDJyVURHQ3NBak1uaFlPeG4rUkhNVTBONWdqc2FubmFad1E3ZVc4bUJKRTdX?=
 =?utf-8?B?bzdVd1gxSXNwZnl1NFM0Q2J2ZnNTUVhpeThSNlhnZXdCN3pNZmN6NklBVkIz?=
 =?utf-8?B?TVpvZEZRTWY5OWZ6RGdRZjErWXJBT2h1SmVvTnh5Rmhka3NFQ3hka2FZcXVD?=
 =?utf-8?B?TTZPcDlpVzdVa3JCM2Y3Rjk0ZXJ1bWFSajRuNjZSYXJKSENybGRUUHZvdWIz?=
 =?utf-8?B?bGU4S1NzS0JNcjRjZTVTMzViMExqMEozRDErM3U4eTFDRDlpK0RmWnN1VjdU?=
 =?utf-8?B?Qk5odkNZRWU2VUV6TldtMlV2UEVycEt2bWZuODNUekVKZnQ3MVQzdU45UGVZ?=
 =?utf-8?B?K2ttV2c2QTREbDk0eDNZWkxWQXMwZEJtZFBCSnphNWgra0thTVNzYVJNelNO?=
 =?utf-8?B?RE5QZjNIaUMzc1Q3TXNPNTZuQ3FtZHRiMzd6UFNjbFhiTWk0VDFOZlo1Lzg4?=
 =?utf-8?B?ZFd5UzRXa0tld1pmQTZpdE1MMW8wc3BScHBtR2x3dFZ5ZWtTa2JjS1hIUmxM?=
 =?utf-8?B?REcvK2x1ZzVFellINWs3aDZ1clQ2YzkwcmV0aHc3R01uTFlCb2taZFpSaWlo?=
 =?utf-8?B?YnZiMlNIR29jTGpXbnRTb2pXL1Vwai9oZ1Fhd1FZVUV0NjJQaENSL2dRb3lX?=
 =?utf-8?B?STM0YWt4WCthUG9yOWZGRkZwNE1JQUMrYmtoQ2YxVUpKOTdQTTkyR0hka2t0?=
 =?utf-8?B?Mi90STNKN0VDQXVhM3FXb0pnSUJPSEdGTHhsMWZDL2pNbUZtWkJ2TnE5RWll?=
 =?utf-8?B?WXNDMi9KN0FjbThOUWZxczFESXdIbU5kbEVNaUh0bmliSml1bzNnOXZ5TTRL?=
 =?utf-8?B?S3B1RkhFZjNSRkRDd0NqZVZxK1l5V0lWRmZpZUNOeFZNR3hOaWRxUjFQYTl1?=
 =?utf-8?B?eFdJSDhGdnNWYllHM3BHTDh4dXpMT2JURFhiZXdkMFFJcjNOK0QxMGtPTHZv?=
 =?utf-8?B?bWpEQTZjRlIzZDNJQTVHb0l6VXEyWjhqVlJkQ2Z6b240akJ1cHp0S2ErcGpW?=
 =?utf-8?B?Tkg3RnlmRFdEUjA3YnZYdjR3WS9URTU0VE8vck9KbnF2bEVlbi8yWGxtbW5r?=
 =?utf-8?Q?tnDFMSh34cAcx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBrT08zQm45em82Q2Y1cmpSNFRRdzgvdWlnVlFFU3pWOGJiTjN2L0RVdnJK?=
 =?utf-8?B?TGhlRHd4K0dERU04Z1RlbGt0eUVrY0ZHb1JCRVVCZDdPQ1N1eW1iMWRwbk0x?=
 =?utf-8?B?dEYybS9CdXhQTnJ1UEF6eWUwUGR5VnU3NElzRHp4d1UzZk5ZNE1wZTYzS1RR?=
 =?utf-8?B?Mm5qSGt0Zld1dGd0NlZobklaamFKNUxPWEt2VE13eTdndUZXVnNXNU96bE9k?=
 =?utf-8?B?a2ZGVXBvcEFnT2E2ODM5blNPcm4xL3kza0dTejZVSFpYT29LVVFiRWp4RmpT?=
 =?utf-8?B?QVh4MjY4UU5VUVB0WkJyWVFCcmFsTmRpWFNGUlFVTjVZYk0vWEVJb2RiQy9P?=
 =?utf-8?B?bEROWGNFaEdpeVE4eW94ZEdrOXNJSHRmbFB5VHFtNytwUm5wSjZlTkt3S3RM?=
 =?utf-8?B?aFB0T0xicWJNeVJkaTN2RGpOS040NnVGTjBMTmE4ZHJiTTV1L1AyeWZyOTNn?=
 =?utf-8?B?RTlaYnFjUjBGYUdoTXpBUDErU0xXRFA2bXU5MEFjVlg0WkhZZk1KNW1CS0RR?=
 =?utf-8?B?VndGd0xERFFTOFdsUmd0Rk4yRUVRQlJzSjVQY0Mrb25vQ053bFgwYmFUVXBH?=
 =?utf-8?B?NU9pclBhVFIzc1BobTVNSExJSkYycGxsOFowNTZXQmpkNlcycGJKZGFmUlRw?=
 =?utf-8?B?anpZaEFVTHdsS2dpcnZQNG5aTFVzYldFL3JXQ1dhbUJLclRVeGpWNU1wQ1I1?=
 =?utf-8?B?MGdWT3lkbjYvT3NqNU9KQXMyeXVNcDJtc0xPVzZMZFpCWGVRZTZhdGd2WFFZ?=
 =?utf-8?B?T1oyTjFOd3Z4b29KSHV5cHNmMFJ0d21KNWNrNUVrL1IrQm1tMmFrdFM0amtp?=
 =?utf-8?B?Q3pvOVdEOTNuVUZoZGhFbXp3WGFwWnBqVFV1S05xbklEVEs2M3NjR0hDY0k4?=
 =?utf-8?B?YUE4VGpiQWZaSUNRVGl3VDRmTEJqeHdvcm9PSXJySTZhNUtMQm53bUxrZW41?=
 =?utf-8?B?UHM0WGJHcnZ0WWNnN2tqZy9neWFUYmYxdXM3VFUrNXZuYUREQUtmK3R0TXNm?=
 =?utf-8?B?T3ViVnBrTkdWdlgwcWNOblRFaVJyTnptVVUzTXNPNSswcXdhY1Uva2Y4OFo5?=
 =?utf-8?B?bVQ2aXV1V1pUR0NXYUNmQjZXSm1heHBSTjBGVUlWakNTR2I1aHNYVUJHODFX?=
 =?utf-8?B?b1FqU1lZWmdVSWVYVGZTdTBzazNEZkorODBVV2h6TDdZOEM3RGFFZGp2QlMz?=
 =?utf-8?B?UFBPR0dsU0h2ckwyRjNwUzJ2cml1L204bVJZYlorRkFxckhueVNMTUpaeEE3?=
 =?utf-8?B?OTRNSE1WZWFjdkhDQmQ1bUdnMkFzNm1tMnlpVC94WXBDbnNrajh4LzlncXpo?=
 =?utf-8?B?VWVhV2RVd0ZiMEtvanhiQ2Fpbi9XYVd2UkNrb3liVHNoZTI0VGQwS21lL1ZY?=
 =?utf-8?B?dGhTTTBjTmNObnBCNEk1b01LbGRLUnN0Zzk4M0FNcFo0dkRnV2pmS3dGejcx?=
 =?utf-8?B?alhRSUUyQzBZdGJ3MmFSZWR1U0xHamlCZU5ScVFpS2loVEpFMFJ2OUtubWo0?=
 =?utf-8?B?U1ZpQXZuam5YeEVRbFVLZkZVQzZIdytLL3NMd1l2aWt4Y0VVdjZNZG92RXdE?=
 =?utf-8?B?YUhUWG5RTlZDOEN4YTBRcExpTldGWXlTTzRXSDZTZDF4b2VQbVdHeTJaWTh4?=
 =?utf-8?B?aG1tQ0JXSGtXaWZLa0ZZTG9FTHV5VGlaL3QzMmUyTlQvV1BkUzNFMTRNZmJB?=
 =?utf-8?B?aElaM1QwaWZtekszZmtPVVkxYk1rdmZ4WVFETTRsV2NBQTcyYUU5eUZLWWZP?=
 =?utf-8?B?cTFaRDBmSFNabXlVakdmMGMwamJVTzJSMkNvdmdUdGlwUUM1NDNhV0JnSk9m?=
 =?utf-8?B?N0tyS0RkMkQ3VWpvNEdYbkdRTnRjZkpobDBXU0x4MlBmYXM4QVBqNkFvemli?=
 =?utf-8?B?OUlrODZsd2h3b3B1ajQzY2JPa0xCOGkyWHBPYjVETE14d1VjV1R4RVpFWk5j?=
 =?utf-8?B?ZENRZ0tIcUNHVWYrVUhvaWVjaTcvcFB2Y2NnSVdEZU5BNVE1SHFHSDM4WHl5?=
 =?utf-8?B?ZFNmYUpqZXphSllZMzZZaThLcXg0UXBhTmV3YTVEVGlUbS84NW9vdit2Q2VX?=
 =?utf-8?B?QTV4b0dVZURCZlN4Sk4ydUg5QTF6dzl2WHVCcDlURWYvZkFDSW9jQVI0UmZR?=
 =?utf-8?Q?/1zwR3dM8e6uRNDWhdhSnqP8q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2378fc6a-8182-47e4-7d38-08dd3a223d66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:48:09.2537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ4YOpM2pdO2YvxipNJRZNgG8K5/PtV4KQYhZVmmEqllLEQsCHJb8EIEdDONBS4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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



On 1/17/25 07:45, Venkatesh Yadav Abbarapu wrote:
> Enable the command OPTEE which runs the basic 'hello world ta'.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index b4aebf3e9fb..22dad1b7076 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -39,6 +39,7 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_MMC_SPEED_MODE_SET=y
> +CONFIG_CMD_OPTEE=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y

Applied.
M
