Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007A2C7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B508923E;
	Fri, 20 Sep 2024 15:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Trmd0Rsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B618923E; Fri, 20 Sep 2024 15:29:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C6B89194
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipEjpUe5Fa/fSCGHojENzbN0OOi00FG0iHQpfztKE5Gut/TZN3tZO93PvRX6qpvMPEnwLS0+w+ZD/Gxy/YrdlHOntOtJ//Uuh0U1tgg/AxOmz4AkZ9K1oN/FG5tKvzb3k1xyESwHztCpIT0eOHHQ7bwJh69RznTh1m4RynNSwHmV57OUfLEZ8TNH14gVcoQAmaYXsltd5lxSdo7KA00paMhiec57sjue/TrgEy/TAKXIk/hIIrGkf2Ky4LA+Svzgd325QM1xXJ66btTsb4Y2N2Pb3My1eq0Z9qLnETOLHumensLn+dUxAUMSNKF9+/43kpl8sFYvZ2lFrrr6Y7NNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iliHt7uLng2k+utV1dy9yKtzH41z0rDxYhRT05+lFj0=;
 b=TWXtKXFeO7JISTztAyssB6lrZMZbDSCnxPfGAfE52ijv2ozl+khSuJkWEYPrwR/siSYWRsAE6akSxuc/RrQZewDZEFs+iihnqzEuRbc4TDVqp4mOxL7v7xuefHBopCsWG+4XWpZIF8VZ98fb5tjnLG4awplDkxiIWg8YKPQOf2J1NYwTAbNBeHTti2aBunXMCQqqpOJZN7VyuZW72pHlc4Gz//N8oXJOYM/2z+pNAzWKyRsNPZhVTbUAWyPOdlKIqI7lwILlEq0kCQF7kF0N4rbBNFiqVmPCDd8PT7PJM3r74PbxCTMT77iiFx8JVoqmb54oRMClki4mXT8J6tc1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iliHt7uLng2k+utV1dy9yKtzH41z0rDxYhRT05+lFj0=;
 b=Trmd0Rsj+H4PWB6Z9uOP0Rrt+Y1DUqdJU5ObxruL8sJFTdLJAwz4npCBuJzRhGBmZnyNk5AFPjRybydu2Bk/37NlgqU8WvHzcDKsax2nk7ydx9jk6AFtBM1piZWXT6+HPdG4ORiow+7UMzAcxCBir3SbA7DceGg60AEkkmg6w68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 13:28:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:28:39 +0000
Message-ID: <45abef09-e581-41b4-9ec9-f8f8b4b94933@amd.com>
Date: Fri, 20 Sep 2024 15:28:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Define only one revision in zcu106-rev1.0
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <c5214b1a01032b88a394104a57624e0d91a22f29.1726221517.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c5214b1a01032b88a394104a57624e0d91a22f29.1726221517.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:803:1::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a02942-e052-40ef-4b08-08dcd978235e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVo4TTZXb2x3bGpuSVZ2Q0ZRelRXREFsUlliNjYvMVFGd0gzRjR0N2JHMUtm?=
 =?utf-8?B?VGloTEJPOUdLL0FKOExRbGRiNHRlNk9zVWc3V0Z4S2xEOG51V2VuOTArcGJ0?=
 =?utf-8?B?c256WGQ3bXh6Y2RvZkdVeGFWbFAxdEorQ2tHSElyTmFpbU5FVTlCUExLYkF1?=
 =?utf-8?B?V096MXJ2Vm12bjNDVzhlaHVxcEk1YzdjbmRGOFR3ZkRmbGVsN1FNdml4ejdC?=
 =?utf-8?B?K2JxMFJjeDhCWlVwcVpjNE82Qm9TTmFJcWRSeUNQUllMcVk0RUs0KzliK1NI?=
 =?utf-8?B?aHErbHZyUG1JREZaN0JNZ2N0TWQyVVJ6dDJhZHVQMWc5dXdFWHVQaWl4MGtU?=
 =?utf-8?B?RS96QWpuYy9UVmxpSUVabnREQTJyR2dVTE5kdGFCL0VqbUVJODNrMWdMN1JU?=
 =?utf-8?B?eUNQMFhVMStuOER4SFQ2M0l5cCt2bWJUcWpqNmM5eTNWMVFGbWNQNkI1aFRT?=
 =?utf-8?B?d25SL2tSSElmOGRNaWM4d0RUbk4zN2wveDZCcUo2VW5WbWozRE9rMnpnVW85?=
 =?utf-8?B?UWlYMTJCT1N5RlVlWGhSSVQ4cHhpcVIyR1gyK3RCemlEV000T0M4N1dIcGJ4?=
 =?utf-8?B?NmdGWmxNaDRUNHR4VnpzY2JwYjdMZVVOOGZkdmRoYWZMY3Y5d2p2eWxuWGQ3?=
 =?utf-8?B?SHh0VWUzNHVsWnVVYktGUUtUcklxQWpkV0QrdHc4ZDZkRkhkTldkdGhMaDVI?=
 =?utf-8?B?M0RPM0NWU0h2K2lUQ0ErcHlRTCsrVE8vc2s5dUQ1TzRjZDA5MFpydUNISkpw?=
 =?utf-8?B?NkcxZHhMQ1FoL0dNU1c4QmVzMG5jK3psWmNPY0JZNTJrK1R4QnVRTTQrQ2ln?=
 =?utf-8?B?bTNYTkozeUhnOVBrUVpsV2MrOVpvMHMydUlyeVdLWm1maEp2bWpYOGFDOHh6?=
 =?utf-8?B?VzNxYmVDZFE4MHlPV1RFZ1A5U3hkdTAyYjZnWlZZVXJFOThNclJ0a2dkQXRz?=
 =?utf-8?B?cVFvYW1ZeVFPOEJtdVJLV2RidWhtNVd1ZHIvdW1SSnlMUHdVbjRJSi91aFc1?=
 =?utf-8?B?YzRtNU9OSi9iTXliYjg2TUNsZTFXWk1JUHA4OFlWVnowNktDQnZEWmMzMWxk?=
 =?utf-8?B?K1JLc09QMmIzRk5XRXdaRmltSXNzbm5yYStjUHdzQ1g1Y2xlTDB1b2ZpUzBw?=
 =?utf-8?B?eGNuZ2cxOFJWMHdRbVNkY1djVXJkYU5Id3R4RFlvd2QyZWUyaWxYSlo4M2du?=
 =?utf-8?B?bncwcWp0ZGFROTEvOXRYalRvakZYNXJzNHFZc3g4dGhIbXczN0J5aDdUZUV3?=
 =?utf-8?B?dFR3Z3pKamIvREtaQ0ZrVmtrcUYyLyt3TzFNSVFNU241MVBCTFo5N3pRUDZS?=
 =?utf-8?B?TjJVbnR0Ujk4dXZQSjcwWVRUakpYcTZoeE1YRTVYMU9RMmp1ZERzL1J0UU9s?=
 =?utf-8?B?RytYMzg0WEFNaTJCSy9IemJaRWlyODRyUlh5YUc1cmk4K0gzR0lQMm5qL0ND?=
 =?utf-8?B?VHR0TVFvQkFxVlZiaWhEekkwd0hYUHgwOS9HTjJyRHRqMit3VlVpNFlsUXpX?=
 =?utf-8?B?aW5BNU1NVzJ1OTByU0tqOUZvc1FMTzI4ZG1TUGhUVlF6MkV5alVwd2p0aFdh?=
 =?utf-8?B?SFBnOXhTRVRZaGhITnlnVmxMenZHbHo4WWR1dkZMMjJZZ1VKazltZjZId2lX?=
 =?utf-8?B?d09HUU1tRUlGMnNERDc3c2xaeSs2YkZXRFpxbTcyTXJoTXZsU3hrUDhJMERx?=
 =?utf-8?B?VG9vQWpzV2RKOHFpcWRFMEQwVWVMK3c2alVhbmlkUmZjdy9BdG5JcjlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhhLzd6VGc3bjBhRERVREVORnFVR3BsWmo0UVlLc0NHbXhMMFp1ZkhSZzcw?=
 =?utf-8?B?SXNFVHJxYml2aE0vWlE4ZmVndmgzN2lVN2JWbXliUWl4U3VqYVR6NmZOdGYz?=
 =?utf-8?B?RHN0MFBEZjY0akpZa1NKc290V2FvWHA3R0xFNWNCSUZWVjRGMGF4TkJ4UDNZ?=
 =?utf-8?B?Q29hbGc3RHZLWXZTTEt4a2MzR29HTlJQZUZqcmNhVnZPKzBjaWZqZUl2MGRz?=
 =?utf-8?B?aGtJZ2Jic3pnT2UzSFkyUkcxY2ZZeTIreHRZTEl5eWZlMk1KdXhEMS9xcnYv?=
 =?utf-8?B?MCtJdDM2S3ZrclI2d0ZhVVQydUw5c01JUzFVVko0cjNXSXJxSVE3WlgyOWJC?=
 =?utf-8?B?Y2xDazkxQkp2ZGp0SzliTDA1ZitzQmJFWVV2YnZwcUpqMjEwNTdpWFZpOUN0?=
 =?utf-8?B?NTZDYWRtSVE5ZG5OMTZpV1ZISjNwUHhrMXZtdTJGMmd2b0hYRHErZVozOVlp?=
 =?utf-8?B?TzArYWM0MmhQMHBReEF1ZTE5UUZ6TmxKOWNzUmZjbncvdllrZmlHWUd0aURF?=
 =?utf-8?B?cTB5VXVjbG9LMms0aFA3NmZaTjdSVXA4MzY0VXArMmtyc1RMR2F1R0o2NG5s?=
 =?utf-8?B?R05UcUlabi9sekEvK0U5YWF0N0UyQW0rS1h5UXZyekJja2JTQ3dqRVhaTVgz?=
 =?utf-8?B?TkdvSmUwaGNZbjhOaHlVdE9JaWU5ZnRCNVpzS1N3VDZqMjJHdlBJZTFaUEtD?=
 =?utf-8?B?NFlNRW1wZi9lbVZFakEvc3lPU3Jta1EvQ3B1TzJNQTN2czRicklmWHNmbXdB?=
 =?utf-8?B?MXl1OWs2Y3ByVHFTbllkcGJDYW5JYTlram5FK3A5cXJGNTZYYi9XcVpVYWNK?=
 =?utf-8?B?K0NKQlNwc0lGdDFtUCtRZ1YrSnpUWS91ZWF1cU04b3lIZHhsS0ttdjB0WTZD?=
 =?utf-8?B?OVhLcGFqc084NUYrV0VBUE5iemlzSUwyRDNIVU1pMjFqUFV5M1QxbjZ0K2h2?=
 =?utf-8?B?bjlZYzE1WTY0VmUzTHVpa21iaHlYaXpkMG9UMEs1L1JjZ2dSTEVMdFBzM2Rv?=
 =?utf-8?B?S29ERUFIM0tMTVhycnBuWkM3U0Eyd1NyWXgrUXpySTUyMmZqMEtRYnpHcnFV?=
 =?utf-8?B?eDhrOHRvR3R3TGNVRmpiclNwSE15ZUZQUEJIZzQxSTI3bytuclZVSDRDdk5k?=
 =?utf-8?B?VWd5U1lOZUZLaWFGWEhVcDlHK0dIZkVXRzNpc1NqTStLZDRFNWpRYWdyMjla?=
 =?utf-8?B?TDNCUld3NjJjd3JpaUdVblBsMmhBbXdPeEYwKytUbzZuZEFuODZHdndtWmJG?=
 =?utf-8?B?QWFUUmxKM0VSTE93ckpRVEwvSVhVZ1VKKzVxZUYxdEtNQ2JzbUNRNS9nUlNk?=
 =?utf-8?B?UDBPaUNyOWk4d2pPYWlkamNhZ3FoTnNvQVEzNnppQXJXVUJWTlk3YjZwajdO?=
 =?utf-8?B?eU9GZlVCMXZPa0RaQTNpR0tCWkx4NXRjaTNuUXI2MktRa09KMWRUSGN6aEJz?=
 =?utf-8?B?RkZGbzFydWd0eFZBR1VTVVVGREVVSVNvdmlnZ1RXZUwwWmJKcHFDeWZuc1VM?=
 =?utf-8?B?V3VBS2ZNRFdFdFJQb1pBelBGelZ2SHY3TXFXa3d2cFd3ZjZyQUpiZmZoZmlz?=
 =?utf-8?B?WXZFQlRoTEg2UXJCellkOGVpaWxmM08rWEtWd2cyRFYvc2wxblNKamozTnN0?=
 =?utf-8?B?a0FLaTF4R1U5NnJ3UmxyVWthbDJIYWc3OVdxTDlqWGlJQWVCMmRFZHd6L1Vo?=
 =?utf-8?B?TWllaVJHWXBZN2F1cVpwbEYvYU03VXpDOE8rTHhMVEJzVXk0RTB5NlRHNThP?=
 =?utf-8?B?blc4dHFDa0l5Rk9aV0gzNkRoTVM1VTh5VWtJVFFxdFgyUmUrUFVxbWF0WWc4?=
 =?utf-8?B?bUlhcGx3VUhzUE4zTEtzVjVkVUQrSDZ5QjllQlA2STZpTUVuc3ltY2s5bGYy?=
 =?utf-8?B?TmVMOVZrSFRtSExTWHNQVWFOQ1ZWaTlhVmRhQjJiSTE0eWxJQkI0dXdQelNz?=
 =?utf-8?B?NkV6clpqTi9nRHllSjhYdHViNHNMcGxJb1k2dkhPamNnS2luNTRDOTB5SUQr?=
 =?utf-8?B?c1JpZXVQcmMwczhqTmU2Qk1DMmViTG9odEhsUSswckt1RzdBVUVSM0lCbXgr?=
 =?utf-8?B?OFRvejYzQWduV3l6eGVCRDJuWlpzQm5UWEhzd0Z5UjhaSVNuSGtBRTBIUHdN?=
 =?utf-8?Q?DW6T7iqhKjX/6M3uDt5JBMA95?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a02942-e052-40ef-4b08-08dcd978235e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:28:39.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEKgmQ1pl3ib8mBjYGmi+3k10MubUcWACGCpOy0SlIwt3sMcmbvSqKFQdlWPF294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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



On 9/13/24 11:58, Michal Simek wrote:
> zcu106 rev1.0 is sw compatible with revA but only one revision should be
> listed in compatible string that's why remove revA and keep only rev1.0.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-zcu106-rev1.0.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-zcu106-rev1.0.dts b/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
> index a9b5826a777d..f1ec314fdefc 100644
> --- a/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
> +++ b/arch/arm/dts/zynqmp-zcu106-rev1.0.dts
> @@ -11,6 +11,6 @@
>   
>   / {
>   	model = "ZynqMP ZCU106 Rev1.0";
> -	compatible = "xlnx,zynqmp-zcu106-rev1.0", "xlnx,zynqmp-zcu106-revA",
> +	compatible = "xlnx,zynqmp-zcu106-rev1.0",
>   		     "xlnx,zynqmp-zcu106", "xlnx,zynqmp";
>   };

Applied.
M
