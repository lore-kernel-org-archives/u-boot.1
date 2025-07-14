Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5EBC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 05:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB458211F;
	Mon, 14 Jul 2025 07:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gcDon07U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28FF82B07; Mon, 14 Jul 2025 07:32:39 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C4681FEE
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CihUY7PFT4PCiKAhET0w3bsP+SQDY5Q5G7K8JW7Icc+NpTIhP5q5jdzXsC3m7IesKBYrewN4OlnnIsi29KJsqYOBkK+U+atVuvzMTQ/s3pYUg/AlpsjeAzH0jKVHUcfGsGIleM4fbE2idUSLb9BrK/0l4fdxSYmLWxdxHy5IbOxk6a6oBq0yI5NIjodZK+NkHJIS7smx7ms7FVv65hMk8/oEU5ty9DSH+PMRuPIDyt8UHSlbaNOtiEyTan9Jvp3BNO9OrPPcDPsSllyv2H+sjmEMD5tPQEnHeM1lErr+39oWt2IRRiqubMB94kcA2AvNlrXTk2CNG+UVkpOVwna+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VucZ6lMSjdftT9qo8AVGeZ6G8hsqgirnPS6Qs01UmU=;
 b=CI0PKuEEvraSk0+yDgUpZnfgLFKK7ln4KdN51K9UkYXj3qrhmC6ko668SVkAm4ZMYWnQXuOFi+eKeECcxzWotMQmvYFOssgNGnqJzfQbID84qmtCIFW07nqtvMaTGSUvUQ57hgatvInfn8Wt+p+FjURXZDeeatJ/VJnlO9xVoyK03vNUKlLmfxs6WSMqwS+lXtnK6+H6ZAoYnSz6i6WD+cz8dEUMAMRIkav5qdlJ78hVLPgyeKl6VoVgUP07dRkvWoBCQxWMcoTFMGUaZ4nf0OCgU+pnFczDk/7UiXJhnVWhPNJ9E5fvuz35clJO8wA+jFK+XAvmf2W0rfwsN2sX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VucZ6lMSjdftT9qo8AVGeZ6G8hsqgirnPS6Qs01UmU=;
 b=gcDon07UMCA916JHAgoMP0RyTmx35zUBtntDU+OZe8z3KHZOg1TmyiATzokRO0Hyw/hkCmaMXxnClPysAYIJF4Ln8uOOSSxysdl5yI+MwRqCcX44/ruCfj8Os9q7ufK5tmR6osfmVNbe+SzfrIvDasuBAm6rxxw4vXC0lAd0JCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 05:32:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 05:32:22 +0000
Message-ID: <4d0a9e6a-c7b5-4a2f-b8d8-151cdcd99cfa@amd.com>
Date: Mon, 14 Jul 2025 07:32:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kbuild: Avoid including architecture-specific Makefile
 twice
To: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250711085234.23659-1-ziyao@disroot.org>
 <20250711143211.GE6424@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250711143211.GE6424@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: fca9d628-06ac-4cd7-bb9d-08ddc297cf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0poWVBHeTZVc09OWFVVZkk5TnhDb2ltbGNBU1pvQWNNaHhlL0l3RkJYVGd0?=
 =?utf-8?B?ZzgvY0RSVUZLYklKS2xWUkptbnNPaC93RG9PR2w3V0RWUGpJcEhNN3BwSU03?=
 =?utf-8?B?OWhYeUhIamlDaFZ6M3FkWFdKZ3dmeE9wZklLOVU2Mmc0OEVEUyt3Ny8wS3hG?=
 =?utf-8?B?eVRoM3V6SjNiZG5PbGpvbXVyOUVNQ1NiMUMyMGV1MCt6U3V5UVo0V2pJcis4?=
 =?utf-8?B?L2FJSmZYR0NrckxCcU1XSkd5eFp6TDJUU3ZKWEtyY25sU2dQdkJSdVBjNW4w?=
 =?utf-8?B?eUlYQkRxVmpoS2tBc1F3aitkUlptS1Y1eUJQdTM0Wm9CS3paOEx4UlVUVDFV?=
 =?utf-8?B?SVVBdkFiNTdmUEhicjBtMjZ6ZG8wMHpxZUNnTHpaZE5jbEI1YldhNVNLNDVM?=
 =?utf-8?B?ekVwQlQ1RmF5TVJPZzNReGNRYzY3bG54cy9jd1Y4U3duYXpLVGdEOW1JTFEz?=
 =?utf-8?B?OTRsdG5yMGVPMEthVis0OXZmM0hxeFliemdTcUI2VllxcTNqYWpRMGtkMDJ0?=
 =?utf-8?B?ZS9QTjU5Qk5JNC9mTTZKRy83RlBuN1EyckxDSzU4ZndLcDFoakpIQ3RlelNv?=
 =?utf-8?B?WDRIV09qVmszYjM1NnIvcitIb2RmY0p0QjZNeGVaUHRxK3p6TitHYzlyaUhH?=
 =?utf-8?B?Q0h5cEltd1dLZ1VFa2UyODUrZi9oVSs4aE9XRnRMZVdRemhtMFFDcHplT2dP?=
 =?utf-8?B?SDRtTitYQ1BIYUlHWnR4aWdBOFhOblRMNTlLYXZtRFFhUnV4bFptcnZiemxU?=
 =?utf-8?B?bmVCUE5SMkE1UE5QUW5vdUw0S0JEVWQ5WkQ0Q0c1OStvRVcxdmJQcGRsVXJZ?=
 =?utf-8?B?RmFvbnFrb0I1NzN4cTFmdWpWRWZWTWxTcnNmdkZmTDZGMzdqZzh2SFc2akZ6?=
 =?utf-8?B?M0UzSXp5ODBzTnpJaEhaaTZMdk4zR3VVbzRyR0h6R1hPYVRMWFFaZFhTK25V?=
 =?utf-8?B?d0tQM1ZMcWlCOHcvdXo3N25rM2ZsV0RBbUFVb2ttL3VKZjMxMCtTWlcwYWZD?=
 =?utf-8?B?SmlRRHNOWUE3K0ZWTjU1ZzZJTllzdUJOWkxVckZoZlNEWnl5YnJDVDAveUI4?=
 =?utf-8?B?d3l4T3l1ekFoV0hoN3JjYVAwN3RVcEpqUHMzSXVmcDhaL0xMV0ZjaUZFT2Ft?=
 =?utf-8?B?VWh4SWRuYy9FalM5elp0MjR1V3R3Z2VzM1h4ZktxNmlDdXVveU5pOVl2MjAr?=
 =?utf-8?B?UDlCdzNpWnJOd2gvemRtWC8wcUVXb0ptbHZ6cDFUMFZUMFBndHIwdm0vaGFH?=
 =?utf-8?B?Z3JaaHlIQ2NwSXl6Tk5HbUpSOHgwcGxYVWdGanVFTWVnc0pabXFPbUI1UzBn?=
 =?utf-8?B?UFJPeUV6Z2h0ejFxTHZNQlIzQnBVaHVUU0JRdGJCUkM2bVJTTDVhWFg2OElP?=
 =?utf-8?B?MG1jYnk1REFIWmMvTFViSGRod044VWNISURWNlQ2blV4aXlFQ3lRaFBSMGJh?=
 =?utf-8?B?K1VhNGt6VWlheWJzVnFXQXdWN0lkTTJjWkRwMFZEWkFSMGEzeGdFUUVoZXpy?=
 =?utf-8?B?ZytCL0p0eWl3R2lVMi85NTZzc2FqNWNaOU9oU1kxRUFsZ1JCNDIzR1NWMmZ4?=
 =?utf-8?B?RWtoWUNhMmR3TCt1TkxMRzNTbUI2bG4xd2trUjFMSm5ZUkk4NnUzSFlqNGdo?=
 =?utf-8?B?MUNnT2RHSVJESmtmRU1tVWVyTDVWeEtJS2tpMDZjeU85SkVwRnZCbXBhcW5l?=
 =?utf-8?B?ZzJ4NDl1TjJPMVRnTk1sZDBKekw0Sk5EMFZSaldQTmRMN3pUQnljWFNVM0VY?=
 =?utf-8?B?aldIclp0NXltbDdHME9HclAvNUJ4QW5NVC9rckEyMThwKzZyZmxyY0NvaWRP?=
 =?utf-8?B?Tk1qSTNlNDlSZkdQKzRLL3A1Y1RsQnNiUnNHVUNzUUtPYzFTaW1UNFhidjRU?=
 =?utf-8?B?MGt6dERpZHZrdXpha2Z6K2pwVStvbU5ZSHJENEhOblZaWFZldnRzcFdyMVFY?=
 =?utf-8?Q?f+eQLgWXMfI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjd5bFBnWTlMMzhKVWE2UU50QnNXVGFlakVFWWU5cjliK0diRjhKR3pPTVhn?=
 =?utf-8?B?WmdUQS9Tc1p2bmRhVEhSR3VXREVlT1dwY0haSGJJcjd5RGhpRHJJenFLQXQy?=
 =?utf-8?B?eFUvVXhiMlM1Z0wwcCtaaUR3RnZqbnIveGhFaUh4NFpTU3JtUTJwYlRHWUdB?=
 =?utf-8?B?MVhObGhLK2hKSGVmeEFadWd0Nm9pNDFzNXNsVytSVEx2aXR5RzVQU2pNMUVM?=
 =?utf-8?B?Zm5Xc0xhZVMwb3llZmV5dlJFVVVaLzJFOW82STNOcmVobmhLUXU3eFRKMGgx?=
 =?utf-8?B?WFJEWEhVaGFtYStHRG4xYjAwMUtOWGtRS0k5UE0vdktRK2NlMW4xL0h0YWg0?=
 =?utf-8?B?WmVCOFBtcVFBVHExUHptaklEV1A4M0drYjJrQVdFT2lCWnZFait1STNqRDRK?=
 =?utf-8?B?a1AxU0N5Nklzd3ovdGU5VEVKNVg5b0xqWGt0QXpJaVoxQzVla1h3TDVjeFJX?=
 =?utf-8?B?NUtRVUxoM3NwN2VkczdPM2Y0TUtpdG1iWnlxa2FBK3RnUTVFM1krYlFJejVJ?=
 =?utf-8?B?WlBaQytDSU1maWJRK2FoVWwxaHFvVGI4bzVBTGlKdG8xdk4za3NFY3pQRDlt?=
 =?utf-8?B?Ujl2c01GdFdSOWVGTFZ0bHFtVVgvY3BtUjNqZzVrSlhJTHhkZXJTcUpoOTRB?=
 =?utf-8?B?RjBjRGFKWGNJTXMxTUtadzFsQWtwYUF3RDlFQzVCNkRIenB0UHBxTjF4Tzd1?=
 =?utf-8?B?aVpYZTZsNmJSeTdUNW10WHIySDlRVnRsbTlPYjlpUGVDZEJsc2pVTFFPZXFV?=
 =?utf-8?B?U3JzOU1QZlZkT20xQ1F1VWFob1V1UjJVVU5BcjNKYjhiMFIzZGRETXZLYi85?=
 =?utf-8?B?Mnp1VlN3cnNZYmpldVVkQlQ1ZWFCWW8rODVNMEFJaUNucGFmaWJMbzd5UEpD?=
 =?utf-8?B?a2pmOERqSzRDNDE4TmtGVFFxeERrS3crcGlPMUZrZVBaeC95S0JmK2VyeW9u?=
 =?utf-8?B?Z3FKMDZTRlI4VzRLVXJpd0VZQmRTbWpsR05QZGFKbmFlSHJFYXBZZjJTZEVR?=
 =?utf-8?B?TGxlS2k1Umo3aEZuRFl2clNYS1R6Ukd5ZDNxd3VEMFhyaVBmeTNZaDVUTjJK?=
 =?utf-8?B?T0xLc25waGlZVzA5bXNQcFh5bStLWnB5S2d3WkVYTXZZU1RrakRoV2FaU1RH?=
 =?utf-8?B?WjQwOGlpT0F2S0w5UENPMHNTQm42QzdNODhhWnl3UXlhTm1MeTVJSmQxMUxH?=
 =?utf-8?B?ZWI5YTduN1lZczBEYnJsNlM0TVpib2RqbHNUVUV2cXAyUzdaTVJLRXZkbG9Q?=
 =?utf-8?B?SlNRenN0NlJjeTFTUEZvQURGWE96ZDdYTzQvWEt0SVJ1b1kxVmRuVVhmZTYr?=
 =?utf-8?B?dXdkbEk0K0dYeFNPRlBCZmx6ZXFneXlmOHVyRW5ySmNMRkJrMWZ1MTFmQjRx?=
 =?utf-8?B?SU5TWXBLN3JoUDY1YllGZVVvRXgxbGJ3Q1FmL1hFVFcrOGtGSkxSSVpETlhN?=
 =?utf-8?B?ZnE0d1ZOcDRvWEhOemdwd0lzbEtZRmVWblhjR3RVUHRBdWNFNnN2NGtzbUpP?=
 =?utf-8?B?Qk5GTzdKMEhwZFF1OWx3Mzhlb2JJakRmSDRjT2wzR0plWm1telFzNjgxdFNu?=
 =?utf-8?B?bkc4UmpNUFVhczYvaGIvTW5BS2xFeHNhQStHV1p5WHZwQm5yRWpSWW1ES2d0?=
 =?utf-8?B?bGdMV042OVNiRUI1b1pzdE4rMkhFK0lPVkQxb2pXWWgyd2hGSDhJKytPSFVR?=
 =?utf-8?B?VityMm8vSVBHRUh3Y3FQT1F4S1dsM3VWM3F1RFJSUGZyQkFKTFVkK0VSRldW?=
 =?utf-8?B?SFBYRnZ1VnF3NWNVRFVHNVp5YnZ0Q2syOXNYNThaUERCYXVuOEZmS3hCcXhQ?=
 =?utf-8?B?TTdDWXJIanNvempWUHBGZ1JwWHJ6Wk8xVHpuVHExaFFjUTFYamI5V2JxT0Ny?=
 =?utf-8?B?emhYTjFERko3MFJ0MHdVTmVVVHhMMDhRNGZicWlXN1JlVHBKb3FDZEtQcm5p?=
 =?utf-8?B?NFJheVRQN0pEODFDNmVOLzNRbWh3VUFxdlFCYnltdUQ4VFpmL2tPM0lmcm5t?=
 =?utf-8?B?eDMzN2Vva1VCaHZDRVZhaU0yYytVYlZGaFlRVVBaYUVNNXJJQ1pEUUJMRHZC?=
 =?utf-8?B?TWtrNGxkNzlGTzNQRzVVY2dIVnZPcXVaTkVvU0dQenNhaW1JcUtPaVEyekZX?=
 =?utf-8?Q?iCRhzQtvBuA1OnpXVP7/aV2Px?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca9d628-06ac-4cd7-bb9d-08ddc297cf1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:32:22.8615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84SDPAPL1ZimZwI0Cl6ONhpfooiCA9gOVk2btwiINLjjYODAc+nyDRwjsjmw779S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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



On 7/11/25 16:32, Tom Rini wrote:
> On Fri, Jul 11, 2025 at 08:52:34AM +0000, Yao Zi wrote:
> 
>> Stranges errors are observed when building U-Boot master for almost any
>> RISC-V board, the messages are in two types, one is about duplicated
>> symbols,
>>
>> 	u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
>> 	arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
>>
>> and the other is fixdep's complaint about missing dependency files,
>>
>> 	fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
>> 	fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory
>>
>> where the latter could only be reproduced when building parallelly.
>>
>> Both the two types of errors are about files in arch/riscv/cpu, and
>> there's a suspicious slash character in the reported path. Looking
>> through RISC-V-specific Makefiles, there's only one place that may
>> expand to such a path,
>>
>> 	libs-y += arch/riscv/cpu/$(CPU)/
>>
>> The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
>> the time of including. With some debug statement added to
>> arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
>> included twice, once with $(CPU) undefined and once defined correctly
>> according to CONFIG_SYS_CPU.
>>
>> Futher bisecting shows an extra include statement against
>> arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
>> the statement is evaluated before config.mk is included and definition
>> of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
>> (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
>> in the error.
>>
>> Let's simply remove the extra include to fix these nasty errors. For
>> config targets, bumping Kbuild also introduced a new include to
>> arch/$(SRCARCH)/Makefile, which is removed as well for consistency.
>>
>> Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>
>> Changes from v1
>> - Don't describe the problem as RISC-V-specific since it may affect ARM
>>    builds as well.
>> - Prevent config targets from including for architecture-specific
>>    Makefile as well for consistency.
>> - Add comments to explain the removal.
>> - Link to v1: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao@disroot.org/
>>
>>   Makefile | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index da53efa09f1..e745cc618ba 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -635,8 +635,9 @@ ifeq ($(config-targets),1)
>>   # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
>>   # KBUILD_DEFCONFIG may point out an alternative default configuration
>>   # used for 'make defconfig'
>> -# Modified for U-Boot
>> --include arch/$(SRCARCH)/Makefile
>> +# Modified for U-Boot: we don't include arch/$(SRCARCH)/Makefile for config
>> +# targets, which is useless since U-Boot has no architecture defining its own
>> +# KBUILD_{DEF,K}CONFIG, or CROSS_COMPILE.
>>   export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
>>   
>>   config: scripts_basic outputmakefile FORCE
>> @@ -724,8 +725,10 @@ endif
>>   ARCH_CPPFLAGS :=
>>   ARCH_AFLAGS :=
>>   ARCH_CFLAGS :=
>> -# Modified for U-Boot
>> --include arch/$(SRCARCH)/Makefile
>> +# Modified for U-Boot: we put off the include of arch/$(SRCARCH)/Makefile until
>> +# making sure include/config/auto.conf is up-to-date and include of config.mk,
>> +# because the architecture-specific Makefile may make use of variables defined
>> +# in config.mk. See also the comment about autoconf_is_old.
>>   
>>   ifeq ($(dot-config),1)
>>   ifeq ($(may-sync-config),1)
> 
> Since Fabio confirmed this fixes his issue, I'd like one or two more
> tested-by's if I can before the end of the day when I'll apply this.
> Thanks!
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
