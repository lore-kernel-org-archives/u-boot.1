Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612F7C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 10:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38AE81FEE;
	Fri,  6 Jun 2025 12:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Nvws4MiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A5382977; Fri,  6 Jun 2025 12:49:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26EF781F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 12:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npt9cVgkgd27AxAA+HxjAG6Jlp0m6//WPx18Uwdp+4x3JRPsUVyFZCx2J7P4M7FKW5KZ6ZfFmT0PMgmViuQx/c446JClo9WUy88+C09Be5R2aEUmvYGjI8UnkuQy1hwuMhqVFt39lkl74A8gUGT8oWi7DdNAxZfWe8WJB4HmH3kr61BC9dv+U1FL3L5qd+puDIhDyxl/TLdrFYZgmRqDM6RgHKV+epFR7HwNjrP9Qkcx6MCvPsDCV4YfEcph3bVtxjSe/f3+lIpspu0fpQwtOfvDBnF3354OY4nnOBPpUNBJC6dRubyppg6mS83dfAr/by1wMhEqrA6Z19D9E8Q7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHSR83bQ+WRipycbi9qzYpI8YpgoV0qrigAaDOljo60=;
 b=QmW0nf9flecqWoD5c0Mg9/pA7GJ9oLsA89TSN5o4TmSbt2YY6ikhCjfGgt68Jjfg+JzCns77qfwneQWxzkzWb5oZWforpkSexSJCZWna2abkKjprItJtTsNkltWZ20x1Z9tQXWDUfyy86PV9x6MYtyAW+VyO7wIPijSoaR/AGAaynQKNicKVUZFiqnubzr5o0BcYmh+3mdT71O5ldkVmanlykgse+oq+yrvpihkLpxPJk8YPhcZTbDZAC87wkVqwscPcuVIOb3dSpQ+e3T2AFeMN83dpZxBFsaR/NrzEsKk/N7oXzC3V6WOPodVfF2BeqZRMYl7SE03zr2MgTfzB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHSR83bQ+WRipycbi9qzYpI8YpgoV0qrigAaDOljo60=;
 b=Nvws4MiNo35SKzwceIqi2VanApoEjxJmcM0oxB1nnGTE0uPU7Y2hAxUOB22j/DZU0X4uDqrMpEUT/aihz+MAxkNQvm2sDswFLgnml5Erh351wl1uzhSRk9d16X1xsU+mBJYt9qTYebDPpFV+I6Zr90TVahqQUttioa3HmeJJ0zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 10:49:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 10:49:06 +0000
Message-ID: <8040c469-5132-4186-9774-857f49f4f076@cherry.de>
Date: Fri, 6 Jun 2025 12:49:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] usb: onboard-hub: Use devm API do automatically
 free the reset GPIO
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
 <20250526-usb_onboard_hub_cypress_hx3-v2-2-f382415da84f@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-2-f382415da84f@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: b07bafa6-de21-41db-ce4f-08dda4e7c231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1d1alBMdGs1UGNKSWk2SWV3N00xRTJGVjJ6NGszK2VqNzlwVDBMUHRzam82?=
 =?utf-8?B?THZtTkdMS2xIZUNQNzBOQjQ5WXpBZHR2aUE1blVsY1Vra3hTQjk4T2tjMFdn?=
 =?utf-8?B?QUhlSlQ3cksrV0VENi9sQjhYK09SZ1lDZlVEMmltdElIMXlzMlduajB0TVNK?=
 =?utf-8?B?aHJnUWpHTzdGcktsanp6TXZtakQwckhaUkxLcWZ5clZqaitwWW5KOTRxZ0p3?=
 =?utf-8?B?cW5RMXM3UWpZT3NSMUZ5L0xKZmFSKzl4Tk5XTUVVRGhJUEFISldxeTJYdWNI?=
 =?utf-8?B?VnM1elZZZU0vdHlBeXJjSmQ5SkdNempVbEYzdEl0aURRM0NuOEhyTVdZMStT?=
 =?utf-8?B?TldhcjQrTWFDTEVWMlJzNGdDRnVXZzVNL1IxV21BWU5JejE5aWh1SC84NTlH?=
 =?utf-8?B?a2x2WXBiYW54TlpuUEEvY1lXM1NwNXhDUzJpcjFlTXFiV3M5QW5iYUZEU0g0?=
 =?utf-8?B?VUZ2dVFwMHEydVZQWHFCMm8veWxNelJBNS82OGFvaDNkc1RDa3BsODM2Rkwy?=
 =?utf-8?B?cDM1UXRKdUtqZjFCT1JOU01YQUJVSndFR2psSmJ4MGgranJPMHVNOGYvT0JE?=
 =?utf-8?B?OFhPZ08xRk1BSXk3QmRCd1RJTzFVai9tQUhJUW82dDJENmYreElNSEptVTNv?=
 =?utf-8?B?ckxTQTVWYnA2cHJ5a3pLYnYraGx4VjVrbktpUDZ0eHhCcitjR2FJR0pjNUEw?=
 =?utf-8?B?SkpmdnE4eXBGZnFMRGtzQVhQaUk4aFpSbzVGZ3JnaEtwMExPNnBnOTRqL2tE?=
 =?utf-8?B?WkZtbCtxQjdwUEV4aytFNjcwTmowZW1LdHZNWVNMNVJTSy9PT2NYZ0JCZENy?=
 =?utf-8?B?ekovcHFnV2sycUFuVXNYMytQMlpaYldkaldlN01DTlY2K0NqNlI2b1FaZTV4?=
 =?utf-8?B?VEpvbTdOQUpUd2orUExPNzlFbmg2dzdSQXpBL0FvRytXVzl4bWpzRzdMQVBL?=
 =?utf-8?B?bStjeGM1bkZVRXJBbWhZU2dwKzR5MG5VUWNxNUN2Mk40ZGlMRXRHc3VKcDBR?=
 =?utf-8?B?YTVzam85TGxlVS9HOVVpRHNKVzBDcld3dmhaNDlrNGg0QXZqZTRZbWZJMFpH?=
 =?utf-8?B?NG1SRHIxY1VodVlJSjNnVkhvMWdsalR4ZW4zWTNXUlBnbDVBUEFhMHpLWEw2?=
 =?utf-8?B?UmxPYlhjTU5vd2U5NHN0TFczbmxPMUVtQXlBWExuZjFsRTMrSTY3YmZrN1V2?=
 =?utf-8?B?b1JTbW9ZM3FPaTVITURtUFdzVHVSajVtTnZhaGlpSDBXZHR6TGFLVVhJZFNL?=
 =?utf-8?B?WkhOVnd0TTFIalhoNWtsMEpsclkxdFh2V0lkWXJMWElHT01PN0JxZDFmeVA3?=
 =?utf-8?B?THVHUTMwV0tDSkdoNzRiMmt0bEF0Mno5RUNteVV3NEx0WWxUUCs0OWUyK0g1?=
 =?utf-8?B?MDlrVzdqajBCaUkrc3M5MkhKUkFVS0t3YlEwR1dGNHVrSmNtUzJjTzA3S3lG?=
 =?utf-8?B?TTYvKzBKbnBpVy8xMmo0aE5BVUUzYzYxYk1yNHRCZFpNMFVrTHU3enFwanpS?=
 =?utf-8?B?blIyZGUvZU95OW5wN1FtcTBpZU54UnQ1YTYrYmp2b0lJTTJkUHRLcHBNcWJk?=
 =?utf-8?B?QUZlZ3FqcVhOSk1EWUM1UisydDJUQVVTaWU5TlZLNmJvQytIZDI1YXhnZzdj?=
 =?utf-8?B?RzFTN3M4ZlJNWWJmSW5vWUxBVjRLeXdzTm1wb0V1T3hOUmYxSDhEcnU5R0Z6?=
 =?utf-8?B?M3hzd0VqcWxJTlc5Y00zVGsxM1Z3Nm5DSHk1SzJwYmhKdFdjVzhDbnlxQlJI?=
 =?utf-8?B?SWhJamh5MzI1WStEbW13bVlvS0p1L1owaXp4WTBpSTJjT2lQSnlNK29mS1Nq?=
 =?utf-8?B?SVVHUk84am51Tk5LQzNCdDVnL0pnQ0hiUy9ISis5VUd2Mmg0Y1puOGg5UUli?=
 =?utf-8?B?bWU1cGFUaDRlYWNBUE9GL0I4NjJNWDlkT1pOOG8yY0ZpL0NZL0IwM0dMSTBy?=
 =?utf-8?Q?xr6Bva+3khQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldoQmFCL3FYYlBmMCtpZzFqTnp4bjc4YWhzcFVabmNRd3ZWMUxhTFphN0Jp?=
 =?utf-8?B?SC9ocmpVdXF4OWdQWHUybnhKeGxvZ3ZyZHd1ZlZOdCtCdXZ4amYrT2tUM2o2?=
 =?utf-8?B?RGZwUEVVL1pCZUZpanRDNS9nQnFCa3Z1UjBLNkp1R2ZkY3JxUnh5cUlpY0JF?=
 =?utf-8?B?cmo4eXZjcERSdmM3UkF5TFpvTU0rVGV2TERjWnl1NlprRitCUUZlK0EvcG9S?=
 =?utf-8?B?blU3N0I1czJLam80U3dGamgxWkhwekpoekt6YVVpY00zVzY0VVpqOGllTzE3?=
 =?utf-8?B?R2ZmdmlRMGwwbE5wVzNaV3RsN0Fma2x6akpUUGliUmZRb1hjdWRzSHoveUpj?=
 =?utf-8?B?T2tyb2dRa3Q2NmNJQmowRmdkM2wvTHRCb2ljSGxPM3dBTE0ycllOMk1KaDF4?=
 =?utf-8?B?K0ZNRGNPam5lNnVKRVBHOW9LS3FrMlEvekdHRk5pUnd4cXFaMUZ1R1dNZEIw?=
 =?utf-8?B?Q3lFbTd2dEJtbDhOM1F3ZXJISU50Y3lQelMyVUY0YzlzTVRvMVhaMTI1TUJO?=
 =?utf-8?B?MHpqeFNITVZraCt6TDNDeGNYbUt3UGRKZG4vTkRVdmNDNnk5TElKanVDY1lF?=
 =?utf-8?B?SmtvRHRnZGNrVHk5ZVcyamhsMWNDVmxnTWViWGNsWXlUT0RXczhtYTVoYlR0?=
 =?utf-8?B?RmtqWmJyMXZvaFpVbTJ4YzNHb1l0WEVmUnp5c2oyMS9pK0Y0L2VYT0hvT2l4?=
 =?utf-8?B?UmVXYWdZWVliY1VUMnh5L2x2Smd3RDdqWEx0b1JLQ2ZsNmpySndFQVJXREly?=
 =?utf-8?B?anpYYTg1S0JtcllTR3RuOXNBUDJnQ25jZ2IwSlpqRm9DUkR0d2hPbW1TU2Vp?=
 =?utf-8?B?ekt1b3ZVSHdsRHh1aHFYcmlXL1ZRVVVRZ3RLK2R1SCsxT0tudUIvaGdzVHBX?=
 =?utf-8?B?c2RuTDA5akJTTWZyMlBXYnVZRXh0WFVwbGZiYUFUdnVxd1d0bHU1Q0xIdzR5?=
 =?utf-8?B?OFVOMnRlMVdWTnIzZkNWQW83SEpiQVR3NzVMUThFd3M1R0YrSXRuLzhOOXFX?=
 =?utf-8?B?c2Q4Z0ZRLytuRlpuK3l2T1ZNbk45Uy9hb1VvNExBUXY2Sy93KzZLd29RbFVD?=
 =?utf-8?B?QkZ3Y0JKcUtHK0RZNFl0SWtXWEJGWENNRTBUUUxaMUxFdDBKMHNTK2Jnallm?=
 =?utf-8?B?aVk4ei9tblA0VFZCb0VQSC9FZ1RGS0NvV2l5Z05PNHVFZGZwejZEeEQxVWN6?=
 =?utf-8?B?MU5oZHBjOGxhRmlNSUQySTVzSXUvd1V3UFlJV3lGdXJZcVg4NHZnR2dzYTBC?=
 =?utf-8?B?OVM0SE1OL0FhL2xzMEVkd1NJUkwvRUVyMFFiQTVKTkVaVTR2RFd6RHFnQkpB?=
 =?utf-8?B?VStPRTBsT3N1ZFB6SldiSk90SGg4WkpPbGw3cjlCT2Y5MTl1djVCeHRsVlZB?=
 =?utf-8?B?YTRvQ0dJMHJqazFYOGZndWZ4aTFROWNuczZRNHhIbHZZVDRqcHU0SWlPblo3?=
 =?utf-8?B?WVVxanhyTjgwaWxlMFhHYXRxMEpwbGYyc3NSSnNMMnU4YXR6SW9tUmpXMUMw?=
 =?utf-8?B?QnE2SFBjaUNBaHBWaG1WMFczNnB6TGJHbDdRZ0xXYlM5VE4wbm5YNFZTVTZm?=
 =?utf-8?B?dHArOEtISXdpWHBrNTdVblIxeUovelMzMmg5b0IwNjJkZ29nWlVteXVDZnRV?=
 =?utf-8?B?aytXb2JYYjhzNHlPYzV2OEU0bXJhVGJnTTB1VlJQUE5WRmhmcEdtK25XWTVp?=
 =?utf-8?B?c1U3VHQrQXlCY1ZOTEQyUTlQTnMyY09ndCt0TG1xTW43VCtTdUhCTjlWemJN?=
 =?utf-8?B?SkhlcU92eCtzb0diNGZCQi93YUtrdmQxUEpLQ2hKa014ZVVuNTk1SFBjNTlx?=
 =?utf-8?B?QTljenh3NmFWYnVZK24wcmZPVGlnWUdIdEJwK28rK1ZhQnF5alhCNTVuUnB5?=
 =?utf-8?B?VStqMzNtSTU0cStXbStQSWR0RWFzTU45ZzEyMWFBdGZBVTZ3N0xKMDIwM1RY?=
 =?utf-8?B?V25WUE5GWUsrVzFWdnAwLzl2WVhkMlU1eTQvcnVxaWR0L1QxRitTS2VSeDFX?=
 =?utf-8?B?VVhtRHZMTTFQeGNQdmFiM1dXZlpqS2NtblAzL2I5ZUNMd1E4ajhQdlk3ejRJ?=
 =?utf-8?B?Wm53Zm1JSjg1R2ZkZmw5dmdwT1hFTlkwc2dSMElPbDAydi9kZExzeEJVZTlM?=
 =?utf-8?B?QUpZMHhIcGpRaWNKOFV6Y3Jldjg2dzFXUWtPR2N5Sk9vMXdHOXVHWWR4RzVX?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b07bafa6-de21-41db-ce4f-08dda4e7c231
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 10:49:06.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klsNPGk54MliB92hpp0CvYR/1PzefPljd5qL/ROrlIyY1xrDdmRsHzMAnIhzeuHCGd3jw6TdL8ecz7uDb8MoNmCFmHOBVPuDh5PHnwkas+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
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

Hi Lukasz,

On 5/26/25 4:24 PM, Lukasz Czechowski wrote:
> The reset GPIO is obtained during driver probing by the function
> devm_gpiod_get_optional, which means the GPIO will be automatically
> freed when the device is removed. Because of this, explicit call
> to free the reset GPIO in hub remove function is not needed.
> To support the Managed device resources, the DEVRES config must
> be enabled, otherwise the devres functions fall back to non-managed
> variants. Set the necessary dependency to DEVRES in Kconfig.
> 

Good catch, but that is a terrifying find.

Unfortunately, this patch and the next ones aren't applying cleanly on 
master anymore because of 77b053502f39 ("usb: onboard-hub: Fix return 
type for regulator APIs"), please rebase.

This patch once the conflict is resolved is fine though :)

Cheers,
Quentin
