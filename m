Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96FED2F326
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B54980433;
	Tue, 13 Jan 2026 17:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oA7Hb84M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B59680B98; Tue, 13 Jan 2026 17:18:31 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BABB80325
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZhlR+yw6XjgpPciur2rTYqaZITyAUncZnhN8CeNknmV2Kmk0TzTeudAzH1nVcxWZsPgSHusXNZ9wd9hTbeXXeHDGpcCKKy1xaojuE1D61aM6etTiwe0JK32SjJbcvdtrQtNKDZQNSe+u7c0oaNBBe6JzgileINHktdtcSBeezbhlaqj9gel0d+f8hFuSU7CyrPARQlylYBPYwZrs/Jhu6KNCxOQ4lPBdNSOJTsplomD2j8Fcc5YSTJMpe/jByXmmrKvJ2cU1Ium4ggnt6n+9CYF08d32n0GyzRRhRfP7DK0UIYbIjHSAE7PoJswmWh6KS2abvaMXGw7sHDqbQQgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv1F7iu1BR5TsDKMi96by+lxQtdaP/gZa8F/gKDOMCA=;
 b=u4rLAxSoan1gRTTs3X4dI5A2W6t4w65vTDE7p1CKuO2Itm0pqk84h9PTH87ODl12JBfPCKfC0T/Zj6giLeUjSWi5bSPNIEe487g/XubCZi4PFMilyPDcKP3+fnz+r42ShaP3Ek6L2jnz2P1hA72j/V32KUUW2rBqLsZxUaNrnk4D+UAUN+L71UukCYcuth877s46zr9xGGPH5xZ9e3PsG08nci31JXs0XULXh/IgUmiDvP80mdn5TJN8levErm6hXsh4ZzoV49g3vRc6zAzgpokyiVDNZwET4RHWzh6VdEXzafeqEJw6eBKQL+XlhpCK2gRd/KVTjoqpVGYbponVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv1F7iu1BR5TsDKMi96by+lxQtdaP/gZa8F/gKDOMCA=;
 b=oA7Hb84MVGFSEKsTdOIHUx7HeB7NhHCozkKzyhTSG3SDoEoCV7C5R7Sdu8PIet5oYp4dWRFI6xzrdQbrS/n7UzW0xBzRGrrO1E2Nzh1egevZRifCO3zT5w6de9gocFPZ28VKjd5uIBsFK6/dAG6WxGOHO5r1v7XVPYHm5j6gjfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 16:18:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:18:27 +0000
Message-ID: <2457f2e2-e094-48c5-bb06-54a9f5634932@cherry.de>
Date: Tue, 13 Jan 2026 17:18:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] video: correct label for cyclic video_idle
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20251231192157.248090-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251231192157.248090-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbdfc2b-8b75-4653-fb75-08de52bf6254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWQyVURSV1BnbVJXMkRIbkQ2SUR0NlgxNHlMUGRVMW5KNEZiWWVwNzBRK0da?=
 =?utf-8?B?TWNxeVF2K1N0cGxsSzc2djdsVVl5bkpJeHhQUXR0d0dBUEdDSStQRy9ub1Iy?=
 =?utf-8?B?NmVaS2tBWkpUblM3ZDZDa0ZKM3lEYklyUWxid3hEMmN6cHUxR1pVeFhqUEw4?=
 =?utf-8?B?QVA5TmhnUm9zQzFHZXMwaVlZTkNuSUN2RDRpRFNkQ2YwRHhGRkpGQ2pkR1Uv?=
 =?utf-8?B?WGNjQnJlbW9mMUJmbWsvdExuaXQwTmQ4czZRSTE0R0JyVUNQcThnSnNJN28y?=
 =?utf-8?B?dGJUQ2FPSllRMWZPT1MvUk1lVHo5WGc3N3ZFbHE1YjJTeG9IZXVUaU8yNHVu?=
 =?utf-8?B?a20vbzZjLys3cXRvanMwTjBBdis0ME5ONnV1eDNBbytvL3pKeDA2QWc5SGVY?=
 =?utf-8?B?TE91aXIwYllLNnF5dktxZ25UYm5ySXY5S1NEM0VScFNrRlNJYmJiS2xvdXFZ?=
 =?utf-8?B?eWxRVWVVZmpYL2pTa2xORm83N3RUbTBHY1VrK2tqaVYwOVFCemZtZ0VKNmh1?=
 =?utf-8?B?MDVvSTQra1ZKWjdhVXM2bklDM3cwaWR6NmZCR3VQYUUwMmVweW9TWXFRc29m?=
 =?utf-8?B?WEU3UnAxb2hzTE5mbEhHMjZPTXlVZVdaZUdaUzdMY3pYVGdBdWZZUE4zd2Zo?=
 =?utf-8?B?WmY0eWkxVkpLZy9zRVNOT0ZJbmd6VWpkZmhrVXc5NERFRW15Y3dXRVFVeHBY?=
 =?utf-8?B?QjlaTFJEVmM4blRVY3dDN3Myd0lsdmRWVUhCWGFWQlplRloxeDVCTUF0WjVB?=
 =?utf-8?B?c3p6MThRVk92dHY2dlBRRHN4ZGFteko3ODlsWks1OTBLMjAzZGVLQ3NMdGpl?=
 =?utf-8?B?WXV0c1VONkVGaVJtK1NqaGFpM3IxTDhuc0FjTkgxM1hRVXlnUkgydDNyWnFJ?=
 =?utf-8?B?WHhDaml5UVArT2pCM05nY2JLRE9FWVhOcytZemVQQi9yNFBCVDNwN3h6b1N6?=
 =?utf-8?B?RzNKZnkvaVBhN3BkYUVqbU9wNGk3U3FudkcvUmZGbmc2VFg4N2I4MDliYXJW?=
 =?utf-8?B?UDdtT3NNTHRRNmc4Q01Ha1FRRTZ3dE1PWndPc0YyNVNubHJzUzRSb09mWTZB?=
 =?utf-8?B?SElkQW5hK1hoVGk1eit5TVZteFZmN1JqQ3hwOHJPNVRpaEpUZzJlQVR6bmtK?=
 =?utf-8?B?MEFuUjBXWE1qV3V1eFZ6VjBQdkFQazdzWGsveGxRdlg0V1JwTFo0UHEwTDdU?=
 =?utf-8?B?VXNUNXMwK04reU9EM0ErSFp5QjMzUSs1Z2VUa3VEWUZqT1MrQWFEMFRjZjVo?=
 =?utf-8?B?ODFCVHU5Um9EOWVNRVd0UU94bTNydW85Y1VoQnAzTkkwT0pXL1hXbmEwZVNs?=
 =?utf-8?B?VW84T2dxaGJpeE9taWRhRDc0NStweE1PTXdmMElYTktBZHJVN0xKTk1zWUk2?=
 =?utf-8?B?bytRUWVQT1RXSnlJWFN5eUxqYUtLSHMycHkrU01NNER3eWZOdytBazNaREE4?=
 =?utf-8?B?Uk5kSDEwWFhqbmtEdGN4ZHdBNG14YjVsb1BnakNmTEJKcWJKdXpNa0FWcWFI?=
 =?utf-8?B?SnRTdE1ZVjNVdVpEQ1F5ZzN3c29Ca0RYZUttZUVmOTdnUFgraElZRjZWcXV3?=
 =?utf-8?B?dCt6QzVrUGczZ2huQUEzYmRmZU80MGh5OEkyTW5HZ3ZoQkZvV0ZGUXlCb3RI?=
 =?utf-8?B?N2dpbmo3RlBHTzZ2eGtGOVkrbkM3N2ptSWtvTHNpcnhoUXRSWmkrc05oYktp?=
 =?utf-8?B?WFZJNmFOSStkczM4TTRtQTBHM0I5RC9HeHJZdkFFVExwZXVrb0h0WW5jcXdH?=
 =?utf-8?B?RUVoM0pxRVBKY0VwVkNHOVp3Z0p5aEdZUHJEaVhOcXhaMExsaHowYVFwbFVD?=
 =?utf-8?B?dWVvdXhGWEFaQUdNOTRYSDhOaVNtYWd5NC9PS3YvTUQwWTZuNGhQL3dmQmpG?=
 =?utf-8?B?Qmc3ZDNmb3k1Z0gxOVRwRmh6NWtjT3lBYUp3K0tUcHdIVExNdW16VWJkNkxN?=
 =?utf-8?Q?gMIkkL774Tq3ivKpknANBny8RIhn0hnt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkk1SjJQS2JaMWoxSVA3NHFsdG5acFowajVpTDBMVVlYdHJURC9WWU1ySkhx?=
 =?utf-8?B?bThNS1dhN0dxam45VFhjSnJoLzhpRWdvTytiaDVNNmFtRkFxMWZ1QStqOWFa?=
 =?utf-8?B?N1BieDhuTnY3aWVZVFdtZlJZZWE2TURFd2pHUjl3MGp2bVpsQmVvR3ZYREZh?=
 =?utf-8?B?L3lFbE01YUplL3NlbnZzeXZJQmNlZHBXYnJoQ0V6cEU5NnV2L200NjBYVWFN?=
 =?utf-8?B?djg0VWZ2WVM2NW5CNkdTOVFHd0dhY1p4K2xqbHpHZUtYSzNBbnpVT0hiOWs2?=
 =?utf-8?B?YUg0RUtPcmpFNzhaNi9zaTFpcHlFSmFKemNITCtFYVlncnpKRFFadExNRy9m?=
 =?utf-8?B?NEZYcUZCd2NWbXNpZWlxcXAyZVBxMDR1aVFteVp6UEJ0WGFEN1hEN2ppdzVT?=
 =?utf-8?B?OU1CVDlrc3FhRW5EYUtvVHNqSkJBZStQUG1ROTRsUGZPY0w1Q0M5V2RzZCtr?=
 =?utf-8?B?ZjhZa3c4VVJVeWZBZ0JRTkFzN3VXOXlpQlFuUWxldXFzSUU1T1ZzMHFwL2ZL?=
 =?utf-8?B?czkvMFVCYmEzNHB5dTFSUjNzdGlTU21FZUxVM3MvK3JjZHVkU0dSYlcvNEVN?=
 =?utf-8?B?NlRwTlJwSDZ2cERwMU1HNzJ0RGtGT0FNQ2VQUHlPbUxKSWdremFwM1hxYTEv?=
 =?utf-8?B?V0oveTlycjRiTlhwbndZd1g3ajh0U2pmNWFKNDQwM0ZqQXlJTFIvNUM2cmNk?=
 =?utf-8?B?eDhTc2Qvd3VnWnhCcEh4K3NwNzMxUHo0NkJTUk1URDJwM3JPNjEzdDBVR2xR?=
 =?utf-8?B?L1dQU1k3Q09rWlhxUFpiNkFLRFZrY0VpRUEwWlRvMmlmN09BNjdYQXVOZUJw?=
 =?utf-8?B?cm92K3VUajhoeVRhbzBHVkgyb2tpcExsR1lZclFiQnBXVE03T3laMmlFUE9z?=
 =?utf-8?B?aGt5VkxXUXl1aFM2TnpNVHVtTlhoK3BUSmhlakt0b2MvcHN3NERhbm8rQ3lC?=
 =?utf-8?B?STl0Z3pObXdsS1ExV2hURU94WTl2aUhMdGJvZGhoSjhzb1Nsb2VNN1hDb2tI?=
 =?utf-8?B?VU0wNG9kN0wrMk9rYzN6WFNoNGhzMXVIY0VBVWZpTmNwZHFsSEJDa2tianE2?=
 =?utf-8?B?MFhiajlXdjFFekZmTkxoNitUQ0g0WCtFVlIraFFOWlp4VWRLSkVUeXh2V2Ro?=
 =?utf-8?B?SWVQMUYydmhzRWFycFVGL0pBRlY3QW10T1c2TmlzMGtXbzJTSEEwWDVyWjh3?=
 =?utf-8?B?OTFRVjFxRlhhNmpUaytpSWllRTRnV2ZnOWQ1SlhrbkhPUG0wQ3FmYmJVeGVN?=
 =?utf-8?B?MktsRmJ3QUxPM0QxamVOdEh3Sk02MkpYUzJyYnNxSTdNZWRRdWVvcFdJUElC?=
 =?utf-8?B?cmxtZS9oWFpGOTl3RDA5dGhidXExcmZBZDFZdjJLTXZLQUpUNDgvS09vY3c5?=
 =?utf-8?B?YVlqNmxwa0FPN1BjdXNuMTNHZWJSY3NSWFUzVFpFZkIzMmxvOVNTS3g1VjND?=
 =?utf-8?B?MXdoUnBlcXFoVzkzaWVzRkZvVWlXRFpIOFF4a01mZWFxTExCOGpFclpYR0gx?=
 =?utf-8?B?RUZsQTFCcGFTOVVBS2ZOc205QUdHTXlFbjB1eXptNitzaXU1K0hDZ0JDbnZt?=
 =?utf-8?B?MTc2cnV6VDFEQTNYMEFOVGdFaGJlTkhoVWhVYm5ERGJXZHNhWW0rcldmQ2V5?=
 =?utf-8?B?YjhBK3JZR0hwQjNYeUxEWWxjQUp6NWZNSGduUUw3SXRPT2hhUFpNbTJmVUpY?=
 =?utf-8?B?Rnd6enJvZUEwOWFwakVPNitxQXJYNkF5My9pRTg1bFhMZDRpRlNGUjdjZXVI?=
 =?utf-8?B?aVJBN00rS0lJMjRyMmdLS3N0QlJjL2JvZnpKcndMeVZIeTZBd252R2F6MzdK?=
 =?utf-8?B?azZqYTN0WFoxY09Od1J6T3FtTGNGRHlpVUowbDNUb2l2LzdsMkVhdWE5OEtY?=
 =?utf-8?B?cWRscXRYTWcrK254Y1dBVHNiQVBjaTRuUlJQZElHZ2ZTQWFlSm92NjFxa1NK?=
 =?utf-8?B?Y2FHclQ4UUhna3VRakM1T1I3a0JxVmRqaW5TN1U3RGw5Y1ZsNk9WL0t6bVZS?=
 =?utf-8?B?ZUJSL2pqSFY1SlJzSjJKblMzUkV2Q0VqWSs4aVVDREVoZUtqVUJrQ0ZwMFBm?=
 =?utf-8?B?MmtoQXNpZG55ZDByT1pJcEhCOEdBaVdvUkJ1Q1ZlUWduVVNzSlBHa0xsc0xJ?=
 =?utf-8?B?YXJhbEJiVGxka2xQaCtRL3FlQ1g1YXZXV0RpVnNmZzF2aW1zOU9OZXNndlFn?=
 =?utf-8?B?M29PdFR5WlNGVWllVWtJU0NUbjFTbmFPMTlnSXNlVW9oUzlpVkF3OXAvT0sx?=
 =?utf-8?B?bi9KWUFSbHZzSUZkbk9hc3Jxbk82RzlaSUwzZkFFNHdtaEs0WHc2Q29RbDIr?=
 =?utf-8?B?UU1PMVhsMlNoYnlISkk5cnlNVW9MWXJRbVZvaHAyWGthSWVWT0R0QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbdfc2b-8b75-4653-fb75-08de52bf6254
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:18:27.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/46XPXMaxoeIVSTYCBhzM1Wq5z0EgnF1ANb3lcvi1GTKc7AxXSptJIsxdtXaRMXcrR83CAFUxFk29e0esLzMJ8FyguupF+pA168PIs+Bho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
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

Hi Heinrich,

On 12/31/25 8:21 PM, Heinrich Schuchardt wrote:
> When the cyclic function video_idle() takes too long, a message like the
> following is displayed:
> 
>     cyclic function video_init took too long: 87707us vs 5000us max
> 
> The text "video_init" is misleading. Replace it by "video_idle".
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
