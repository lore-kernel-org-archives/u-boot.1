Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA6FC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 06:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC3D889ED;
	Thu, 25 Jul 2024 08:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OEbEqMD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A96A889ED; Thu, 25 Jul 2024 08:22:49 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A218875F
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYTak66LqCecvcuHiix5G0dKiLgSWPggQykMX0cuPjD46tRePAKl8R+gW1VgkurKy9paC+gusEKOzSx+gSfs/iz0laBNR2+f3gbBEZtDrJdDxBl4sMgKeyTc2+0N/zBGPHxUrc4mJGR27+NipXj7P3OCgDfVkmFLpwI9I/qFsonY7zW3ANjNFU+fgr9GavM/AnSVacd9FBmwGLEemwWC2XABh/vFUkCrhC4kQ+QtUygct/g0iV/uDICsBDgXZ3wMPSNJ8BLuLXY7oIlm9dA8Gib/LLfNdjSlcT2iPrn+Ar1UQptgzBCspCyi223zUP937GjZW4CoXmayBaAnS9bZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGVjO4dNr4aBCMzltQrGo11e8c3UN+I3HVZ7kH3MRU8=;
 b=AEWRezQrusrK1/l3dkcyBYJje6Yf+/uJoO9t1oR/Xoo7JV0OjUL0OmRYM62TFuFkmLTilKc4Ed1md9yEugnfSEJoBLCs+V7wBEcF9LkKf++y+lxHL18ndeoIfp3OXtedGSnWcnBq6aArZL5hyLQ6u7WeLb4g1Dju4bVwi9w+Vmd0JxAwesZK+iZIPNVtKld8tQE3k67tYr7QOMZJmXIe4onMHwBEfDeyzqkbDbojLE5dwNehkb9XXKqFcjl2k54Iz+FCDSSwyQks+2UGt3XGpAGpSPGS5VB0uvBFp64J6XrZxP/3p55DrxZn/HJh3Uo6jQSdyaGmpsSFr9mKon5x3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGVjO4dNr4aBCMzltQrGo11e8c3UN+I3HVZ7kH3MRU8=;
 b=OEbEqMD3OJnX4dyZCq7O48nNCu41iNKukAwm0v9QZm5D3kcmiNrSfM3co+NAYh/rsi5qq1UH2+9NHhVJ8odwK62WNA8lTkEUv9ouqvVIubLtSacrMAFtft5zGKNreTu4EZ68yxq/7nb75g4leECK3b8jWLMvf35xzE8s/n83B90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 06:22:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 06:22:44 +0000
Message-ID: <dc1d5a96-fab5-4a5c-80cd-aa4da974d97f@amd.com>
Date: Thu, 25 Jul 2024 08:22:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/40] lmb: config: make lmb config symbol def_bool
To: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Thomas Chou <thomas@wytron.com.tw>,
 Rick Chen <rick@andestech.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-29-sughosh.ganu@linaro.org>
 <20240724205541.GN989285@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240724205541.GN989285@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0136.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5750ee-3779-45e6-b2f4-08dcac7231a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUNLZUxkWlB0YmFTZWhRdkFtUU9TWjdRUGZadUFablpmTFdGVlVvNnJIT3NW?=
 =?utf-8?B?aXBiVmVPNk9SZWEwMEJ1S3lOZFBoMzlRT2NXRnlHUmIxbDY1b0xERm91NTBv?=
 =?utf-8?B?NnNvM2pVdVdzRUxreUdIWVBJZ2Rxc2kzekJkdUZHVDNXWFAzV2tlcFgzOUdP?=
 =?utf-8?B?c3NST3FVMlEyRllUQ1RsWGxxSEJXbGJRR1hNa1lWZFVGY0lvdEFJTTFPS29j?=
 =?utf-8?B?ejlBcGV2TFhQSnFRclZKNFVhRnArV2UyYXFqRjZGT1JtQ0t1d3R0VTZ3clJR?=
 =?utf-8?B?ak9GNHJ2c0F6RHpJWmp0RjREQ1pHMnZ1dHYreFNOYi9IT1REZjlOUHEvN3RI?=
 =?utf-8?B?YVR6N0kzQzNyQjYzTnNoUTJhMDJEK3lwNlBrNjJFY0dnbm1qWWp5djFpTUVo?=
 =?utf-8?B?VklUODE0c1Q3S3lrYm9HNVJWa3JOU215QU5BM0dYR3NtdXo1SkpmY2xlcDhX?=
 =?utf-8?B?R0MyOXpFUmZGZU1oVlp5MjBqRVdlWGhad29xb09heUVuZjVQaXdabXIwS1dp?=
 =?utf-8?B?QjErUGdlTGlWaHM0cXZpbnZSb1hwVDF1RHYvNmxVKzFZSWpSQm9Vb1pDdktL?=
 =?utf-8?B?N21TWm4yaW5jVE9KYXJiOUxHOEluMC9vVnN0Z3F5Q1pjUTl1Uk5GV2dzelVP?=
 =?utf-8?B?RHhvUjNXZ252SzluQUIrTUpnQUEzOUttNmR3QXM5VGd1TmlGLy9lSHJSWXBQ?=
 =?utf-8?B?YlV0NjlyenFzVE8vRXdkbHU1ZDZFQjFXMnI1TlhQUy9RNjNHMVpHSnRGbS9C?=
 =?utf-8?B?VE1HMzNZUmlmbmVRZVo4TkNaREprUWZXeDgveDlqM3ZwcXBiSFN5b3VzWWlq?=
 =?utf-8?B?K21tMklaaEFlVXZVZzhleUdrc3VUOG1HWTN1a0xLVDR1RFpCd0VxZ0VieEc5?=
 =?utf-8?B?SnlnUG9iN1BYOW5yZFBISmVNTjN5Y2FQRnZ3aE45ckpQRnVhaFp3MW9IcktG?=
 =?utf-8?B?WFNaMGE3MWFhWFVxcWh3K1FyWDc2WjJRbjcxTGVGSHZZN1VBajNJMjk3UmtY?=
 =?utf-8?B?MHVlWU9ZcUFFekNWbVRTaFFZMUVwRVpxOTRuOXBydy9mbEF4YWtzUlZwRXND?=
 =?utf-8?B?Umc0VjJzbDZJNC8xSUhheld5dTJwaTBuUXphc1R3US9UTDA4TXFnWGsvUVR3?=
 =?utf-8?B?VWVYQmZZSUhpSkliZ2FSMUl6QjZwaGFmV1BXMTBlaGt1K2FUb2djdjVyb01w?=
 =?utf-8?B?VisydmlFQWlpOHVwc3ZTYytvckY0TW9vUTFOQmwrV2hkS01RWGVYckhQSzly?=
 =?utf-8?B?RWRRVEV2TmhyUS9Ba0VhbzROSnF6bDRmS0pyRUZuYTYxaXIySUtIMUhrVXpm?=
 =?utf-8?B?NDVTa3ZBVzd6M3pndmM4aEdrRmlPQ0wrTFU1VWZYNklIM2lNcmJIZlBUbkR4?=
 =?utf-8?B?YStuUmw1UDM1S09CVml6RnUwWnpZYzR0NmViV29ubWFyUmpHbXhZYjl5QVE2?=
 =?utf-8?B?SzhxNGFXbVg5T0pockxvOW93UmtaQklYUndiV0pqSlA1ZnJQMFRIQWRSS0Zt?=
 =?utf-8?B?N3ErbVE1NG54TTdBTnJqQm5kRU1Sck9XYklhN0d6eXdMS25kWXQ0VzhhQXh3?=
 =?utf-8?B?TnF5bmtucHp3VEV2aEE4QWcrM3RCUlFKcFpvMXNJYkxSVnB3cHhGTVo5bDVJ?=
 =?utf-8?B?OUVSekQ3TkN1ZnMycTdzV2dXQVNXT2dmNFdOQXplUUJlRDlHdlQrUk56VDlQ?=
 =?utf-8?B?U1RkdzZGWklUM1ZiV2ViNGZGaGxrTTV1OTRVS2k3WFhRMlVBdEx5M0RvMXdm?=
 =?utf-8?B?Z0cvSm9DWEkyZFE2ckRIbnBlT3NxNnF4WXd2MndKN0FZelRpc0RKS09FNnow?=
 =?utf-8?B?Ly9XeEM4NTgrbXUwNlZ6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlyTmxMVi9UbUVZZldoRGhMelMzdGJRb2hMYldsY3NrdWhmTFcvYzVHYW9Y?=
 =?utf-8?B?N2FaNXpSUHluZ2VZUkpIejNpazVvV2NsNndPb3lJZjQwRjU0RjJPZFk1TWtF?=
 =?utf-8?B?dU1TeUxSaWR1UDd1aVdZVmFaT0ZpZElwMFRLWDc4ZzVzaDdocTdEdGNuNFlM?=
 =?utf-8?B?dExXOElMbzBQYThVMFpCak5vRzhNaVJGRlU0NVZjQlFWZ3k5V3VJcis5RXJx?=
 =?utf-8?B?eHU0RzFBUkRSc0psQmRORXlXc0NjV0dMNHB4WGIvMEFsMWc5c2xzUEpCSkFv?=
 =?utf-8?B?b3RBZ2ltbXV5dC9zTlZMRXhEaVRvQ1pEQmpWc0NYY0loRE04WkRSYnNsWGdP?=
 =?utf-8?B?MUdDY2k2UG9wbjVzNjZESWFLd2JQWGUrWTlvRmYzUC9HSks3R201QWR2Vnhw?=
 =?utf-8?B?ZTlKYTFOZDlOVE81VlBkQ3ZNK2ZJTEFNYzdxdEhCaXBSYjFoNEZqREZqOFJR?=
 =?utf-8?B?T0xZSzlMbGhQNFJEdnFQM1N4TUxLbVAxd0J5aTdNbnVmLzQ5dThRSEtYRnBY?=
 =?utf-8?B?NzNCWUtkam1Wb3BXOEkrTlJ1ZTdaRE40aXRnYTNFenowM21iQTZoNFFDdno0?=
 =?utf-8?B?a0ZNTjNuc3JxQkNSb1E1NG5aQW9CdTB4ODZSYkJ6ZENaMThPTkZYc1ZDRFFN?=
 =?utf-8?B?RlltRmlSU2ZDMDQ4dnR0SnVJUVBhQmVEcUdYblRTZGZjVmxRbjl5REhoRmV1?=
 =?utf-8?B?ekk3eVBkTForUkU5ZXpERUtkU1p3bCtkQXZxaXc5b1ZtSjlsbnhCQ21TbFlI?=
 =?utf-8?B?bFN4WGhJWlBkTVpsdkRwQ3JRVXU2a0YrUkxQc2k2U3haZmZiRGVsWGtyT2J2?=
 =?utf-8?B?VllRbG1FTE00MHVQNXQ3Z3hQNUNwS3ZlaE9oSEF1SGJkdkhZZ2RSUmhxelRN?=
 =?utf-8?B?VUpLN2NROXpVQXR1anJWY3RaRy94bkZzMnIyVnNna2dFSlNCK01GbHJ1WjNp?=
 =?utf-8?B?S3hFWUUyS3M2T0xNSlk0a3ZKMGVsQm5lOHNVQVFMZVhDRUV2d1MxNC84WUVy?=
 =?utf-8?B?cWJUV2RDRWNxYVp3clNjQjkrL3lsTWJFTkljM0dMMzN4RkxsbDBDalhZYTkr?=
 =?utf-8?B?aVhhSDdKL3FRcm04dENxbEc5NS9wS3F5QlppQ1RBcDNKY09ya3hSU3VodUNv?=
 =?utf-8?B?ODdwaEkzYlVnbEdwVWZlTXIyS2JIWEdleVE4TWFlK0s1NkIwVWQ3NTRpWjZQ?=
 =?utf-8?B?WmdYRGNqbTB0QUJlenVKaTdUU2pURC8ySDRNU2dlL29VaXNzTVRmU1lETU9B?=
 =?utf-8?B?dzYxWkpIa2Q0R2NGZ1lWZzJtOGdKSUlZREhxMVJSZ21Cc2k3YjdpcmVwcjl1?=
 =?utf-8?B?RlVoUnA2UjhIVGE1VTBDa09UTHVCTUZRdFJPTXBWWlhjUTFVYTNlM08xQ01h?=
 =?utf-8?B?LzNxMENZa3FGTml3VUdUWWFBNGxZaWhzVnFCaXp4TFE1MTBrclNuMmRnNU9C?=
 =?utf-8?B?bXcvNnlrSERYODA5bjNSWWp0YTJMMkJwZTdKQXNMRzRpc0duMk9BSlJmN3Mv?=
 =?utf-8?B?b0dXbGExUk9JTTNjeDRGYnc2a0RSSnZZV2xEQlJ1MzVVTlZJUHMrUm02MHFa?=
 =?utf-8?B?TUpZbE4rUmgvYUZoOFBBc21rZXZLbDY2c1hQZXJRY0VEazBXV2FYR25wd3Z2?=
 =?utf-8?B?cGorTEpvbktDa0JWSmdhZEJlcngzdmxIZHBHQTk0NElUam42WEw1WHZnUFQz?=
 =?utf-8?B?RjBsY1N6ZGNrbVp1V3dUdGZJQlZWdm52amhPYjRqUlFEdEpLZGFDamJweHBF?=
 =?utf-8?B?akgveS9VNm8yQ2hIN3RZM0pRd0NOL2NTekJBenZKcFg2RWkvdm04b1BhcjRk?=
 =?utf-8?B?a2pFWi9mNkxnTUpqTUJvNUJ3TmJEMlFXektMU25INDg2NGt3TlJZMW5SVXg4?=
 =?utf-8?B?VFdyZ2ZBR01pRGg0ZHZ0cTFmUHRzMFl0ZU5ocWJITVVvY1drRDJNVVk2Rlhv?=
 =?utf-8?B?aTRrUTJoZDBRZTZUNHlyVU9SNXYvWUFKTThVTFZzelBkaXBvUk9CMmU2ZEo2?=
 =?utf-8?B?REptVGhuc0JHS2haRzdnWDJjMmlpYTc2eGV4NndkVEhidU94aDkvSExjdWhF?=
 =?utf-8?B?OEhMUXRGK2N4cjlaMFpDZjEwRU40YUhtSGFVNHpkb09UOXgxMWNCQVNXbFBq?=
 =?utf-8?Q?dKMizFW1cR697i9n5e8Obha8A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5750ee-3779-45e6-b2f4-08dcac7231a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:22:44.1303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 348VsCLipyUdh0YXEQf86GjxAyylz8Jvq0W4Edd4QnWc1ydrXmsOXvgOr4U2Te+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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



On 7/24/24 22:55, Tom Rini wrote:
> On Wed, Jul 24, 2024 at 11:32:12AM +0530, Sughosh Ganu wrote:
> 
>> The LMB module provides allocation/reservation API's, primarily for
>> loading images to memory. This is functionality which is used by all
>> boards. Make the config symbol used for the main U-Boot image as
>> def_bool and enable it by default.
>>
>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>> Changes since rfc: New patch
>>
>>   lib/Kconfig | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> OK, I asked for this, but, some platforms had special enough uses where
> they disabled it and so we get more growth here too, so, lets drop this
> concept for now.

Our mini configurations are disabling it because it consumes a lot of space ad 
we don't need it. Commit message should be definitely updated.

Thanks,
Michal

