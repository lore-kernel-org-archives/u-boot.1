Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A160FC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 07:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61C580562;
	Wed,  5 Feb 2025 08:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UeChHwm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4399B806DC; Wed,  5 Feb 2025 08:46:13 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A956680207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlyLfoizSL/k8qHvW6dRxh4utCoja+Vl1P+RUsnBujS1Gqu1c2qZ43i55VMEhwOpsTWoZuRL6YbnpMEtIsfu5x3qhAiPKXDkQgtBLkbdm9JD7u3lh0Ac4pN4e+2Z4x/lIvcuXO65Qq3YILZRrrJj03Ta6Xkq4rmLYA1oPXHS9wOXvAxEqBTWZ2lfRDiS1HzPtji+euS5Cf2Qn3UFLZd23jOff1DGYJqIbDzPP9kwI2epRlcUPTOxEggxwg1T1cENZHPzcNp4VtHRzVkktrEQEUlbBQr4sMy6kSnzXwGWIp9Ih295hkRocQ3TV2gkq3QlT/z4BNGKfWmgEIrLZPvwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/FBCGB4cFFEWy97jvnw1EarmwoYEDAtkIgPBEHbApU=;
 b=XSkAv1VfHCLISCUyq5vGptSdn4cxeWI25T6ap/eoxluZasTIR7aTdqsp1/bBKVVt9rnrkysTP6FvagyT8R23S6a+BBRM+yyHSfLXEjYVRmhhfX+hWQaWIprUmfvNrkwpm72ccKAqe0hrvENeTZjlVXMYdSvzPp4Fuyc12SExlnw14955Pr7Umj73TH/hml920JwIbT3SPXiJj4Y3KTYaCGf9JHNYNuk1HdR4Yk4R5DBAxijbqpnxSj/QbBjOkcVAB1dN/BM+QtFAtRMHE3zLlM6Sq8T5kxT6sBKClc/cVJETTfvfJUR1+UlonDW5EsqpWhfobj6wFSCdWBqrnAT8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/FBCGB4cFFEWy97jvnw1EarmwoYEDAtkIgPBEHbApU=;
 b=UeChHwm2SZHWWu58OaGD6GDeuG7fcUHchaSGYTjnt3UrtpUBvhhSgXd9m7NhR5YKifqz23gV4qIWFick47Bb8p2mWadr6iWy0QPDNvd+ymvAnQhK7F2Q0bmAY+EcX0OPIpMrPlMipPIg3gGwkrEhbMLQ2uQVt/FadnBEFDzz4+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:46:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 07:46:08 +0000
Message-ID: <0ea3a2ba-54ea-402f-849b-f4bc82b6df9d@amd.com>
Date: Wed, 5 Feb 2025 08:45:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: Make do_fpga_loads() static
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Alexander Dahl <ada@thorsis.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Tom Rini <trini@konsulko.com>
References: <cbe93e4eb33752aaddc943b15fd04731d4f75b68.1738574893.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cbe93e4eb33752aaddc943b15fd04731d4f75b68.1738574893.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: fd189760-6487-423c-22c6-08dd45b926bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUt4QTJkMndvbWthbmZLbFFXTTRrTzUwSXVlWVUxWU1TL0w5NGdlUW1vMlRu?=
 =?utf-8?B?L056cnNDZWZkZkx1SS9WeHlZMkU1WDhhQXVYUTBrWXM3ekhtNVkvSXkxZkpN?=
 =?utf-8?B?SXpvbkQxUDQ3b3FQZHIzYnIvcEFSRDNITWlSVHNyVFU4Tk5uTUNZRGlVVzUr?=
 =?utf-8?B?ZUllRm9YOHRtd3lIdVRsNFFsREFrcFJaU0VIdmJZUnp0NWwyVlkwakJNNk1Y?=
 =?utf-8?B?OXNSRUhYRW56RTFIMlVVOTRmSFlreXpvOVFJRUlzVmMxUXJScVFYa3JEOFRI?=
 =?utf-8?B?eDJmZmNQWVJveHRDbDhxWi91aEVVYWtCSHVTVHJvUlhXY09BMkprd3d4OVRu?=
 =?utf-8?B?VVRFdmI1VXNuYi9jTU1SNVhhQmtseHBMMWMwVzFRbUtwa2RTR0JFY244d01u?=
 =?utf-8?B?ZGRxNVpXQTBMUHljV1BCUUpqVmo0WHVqcWxHelJCcGhFSFZYSk02WVJjb2dU?=
 =?utf-8?B?V0h0VDJlMnZlb0cvVHdESDVVSDFYRWMxZjFwaUhWb1piWVA3QndwYWg4a2RY?=
 =?utf-8?B?d1B5Tm5uUEhkNEowZXRTdjI1OGpGU2hZS2l3ZU1BMVBub1ZxVDRyQ0ZnVVlF?=
 =?utf-8?B?bEt0azNJT0lRajd5RFNWczU3SGkxTUpzUytGdUpEVXRlaHhGV2FjbUxTZWNS?=
 =?utf-8?B?WC92bll3S1dHb1R5TVZtVjRuTXhPNHNNZzN2dzI4NWd4VUlXUlh1Q2JlcHRU?=
 =?utf-8?B?UlJNMlBSZDNwS2tRV281WW10amFnL3k3MlRwalkvRWdsTG9BMzhtQ0NGcnc2?=
 =?utf-8?B?ckxhNEFSWkR4ZXg2YlZhcll3UVhveEFvcFlUcUZqZzhYL1Z6MHN5YnlIMTZa?=
 =?utf-8?B?ekh5aFA5ZmZvZXBoMXQ1cWtlcnJ4NW1mZzdBQ1BQU0hDS2s1MHpKcXAxdGdi?=
 =?utf-8?B?dHc0SXpNa0dkVGRmRzZsanEySnJ0K0xUTjJKZ2RjQlR4VjJoc1ZJa1kzd2Uv?=
 =?utf-8?B?ekRJY3FCSUVxTW1la2wrNnRrRkxLT2U1M1d5eWM3MGkrM1I3QVEyZHdmbWZv?=
 =?utf-8?B?NW5MTDFpQVo2cmdETTNEY3VXRE1ZakxQeHdhN0Q3Wlc2SHlocHNXWC9VaXFt?=
 =?utf-8?B?SUl4bTFkcnZhb0dxU1Y4eTlPcjFzdmY2VmJoK1hWSjEzeUJFOWcvbXRMNnBs?=
 =?utf-8?B?ZFFySVRzT3lCOCtrZytNTS9TNm8vdmlHZjZOQ0RrdlU0dGFYRlpIMXFqYW90?=
 =?utf-8?B?TFdEZEU5WkcvbmRXS0VXbzlPMzIyTm1EUG55a2FlWW4ya3doWllyU0hxazFY?=
 =?utf-8?B?V2dreGlaSTVCR2R6S0lQRGJEZk8xdWo3NUZldXQyTWNHM3dKaS9mUnp4WDgx?=
 =?utf-8?B?MGNBSlZmb3o0cDdMSlhoQzZSa0daelBDaitUZzNaZFJRYldJM3BiU1Fya1lS?=
 =?utf-8?B?Wms0cXVLMFNmZW8zQWNiV0RRekVBZWdvMWM3M0JsRS9FMnRGQTIybTdxWXdU?=
 =?utf-8?B?WXN1UFdNSWEzMGFpdVJ4TUFqcVQ3czZjUE9rSGs1bWhNMXBJc3J0eHl4V2Mr?=
 =?utf-8?B?bGdTdG93Mmt2d2dINExlbTBtc1hsUXYzVHliWlUwN24ydjBmckxSeEhCQVVE?=
 =?utf-8?B?MEt6cmRzTVhXTiswL3VXWnJ2cnk0dnkvMWxaYkZ0czlKNTQ0dmdyN1ZQRTM3?=
 =?utf-8?B?Mmw5clpXbnp3TVB4VGVtZVFEczIyejcxaDgwSTlPRmRWMFpuRktvMWp3ZS9k?=
 =?utf-8?B?dzhTUG93VkVIWjY5NC9RNzA1WGdZUCt4eXFZZWJHMjVXaENRYzVlVGlYRVVu?=
 =?utf-8?B?VDRYOHZnVmZwaW9zd0JidVhLZHlXR2JMb1k2eG9tU3Jxeit0YmM4c3hGbUJK?=
 =?utf-8?B?ZmRObHhuK1gzNjQzVzFuVGVRREF4YXF2V3R2cGUzWlJrKy8zbTBBc1lJRXBH?=
 =?utf-8?Q?HiYF7OOomxN0/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWs3UmxoZTN0MlhRTjNUOGFzeFprY01jbzRFaG00NmtrZ3c2NkVqRWh5cHJS?=
 =?utf-8?B?aWtmUGU4dlFucS9GSjFrUkRTOHBBckRvaWhVamgzbjJ4cnV3WkkzVnpKU3lv?=
 =?utf-8?B?MnJnSnZtclNzWUlZV2NIbzc4b21lU1VBV3FwRFdXRUZBNm91aE5HbmpXUkRY?=
 =?utf-8?B?VnExZDNJZXcxOEp5dTl6UCtaeU1RckxPR2NiRkt1M0hmZkxuOXpDS3grUUNU?=
 =?utf-8?B?bWw5Zmg4VzlaUk05bFRrcTY0WEw4K0NqRG5ibzlOZ3g4MmxuL0VUbVhTMW5a?=
 =?utf-8?B?a09wenBrWGY1Y2hUcklldDJxVVlQcm1IaDFMOGpHeUFRdFBaclhBcjNHaXVI?=
 =?utf-8?B?enZZZmI2S1VGSjl0OE9rL2p3bEIzYnQvMXJGd0w2R1VEcFJWNVZsaUcwczd6?=
 =?utf-8?B?dmJ5THUrckNWU2g4M204STlOTFBROXhyeUlVSXNwVUZSa0hKQ2ZjbXovNDBv?=
 =?utf-8?B?TllVY2xMaXVFT0MzSDgyZXlDaU5iVkVvMU9TSDVnTStVaEwxQThBbnNpdzBU?=
 =?utf-8?B?V2VicmYwODVKYlpPV01ZWlE4RGpvSWpudVVmT0VKbGw5eHQ3dU9mdGxMTFNh?=
 =?utf-8?B?ZTR4UjRyWW5SdElIN05mSXMwUXJkREF2TlFnVkNqSjVxUEQxckNybC9TUUdp?=
 =?utf-8?B?bFg2MmRJVlU4S2ZDUWZPZHNrOXkzRWxQNUpGb1B2VEVldWQ2MXdvNEFaNm1i?=
 =?utf-8?B?UTJuSTJUYldTMjNWREpIdk4rUmJwV2ZWdW0vc2NydjZMKzZyd244M3NUWWpU?=
 =?utf-8?B?Ri9CVFNic2hyUGZiVTFDUUdjQXBIN25QNzBTb2lESDVmTFNSTVZUZS8wenJW?=
 =?utf-8?B?NkdKTlNaNGFkRlpIVXRzOHZ1SWhEUGx6SjNvZjl0RDR5Z3FjZCtOcGR0aGRz?=
 =?utf-8?B?YXBZbDUrQXRyQlFpR2VNY2FWdXNnclFXUkRYOWdCTHEyUC9Xd1IyRTJYelpB?=
 =?utf-8?B?a2FjVFhhN0l6aDRiZ2Y5K3JYNzNnaFl4Kzl1L0dDVTJwMTFtditULzZSQTl3?=
 =?utf-8?B?Tmp0cE84ZGFhUGZYWkZteGpnTllLN3YzRjZPbkkzL2VLazBaR2h6azM0cXhB?=
 =?utf-8?B?dWc2RHZXNXRLVCs3ZFVSRER5L3B3OEU5aS82U1M4U0pzYlFJMjF0OHRwZkpU?=
 =?utf-8?B?eVIwZElzN21PVUdHNC9wQUd0MGZwaVNQdWFlMEdjZDQyeFB0M0piT3lpUng5?=
 =?utf-8?B?RlhqZXFjSFJWTklaalNZbHNKT2QyK3BSR1ptbkpZZ0RmazhFZXB6M0M1clJm?=
 =?utf-8?B?QWtuV2lNdm5ab0xpVTI3amlLRUppREFhUm1DZ1ZUQm9OOGRzSGtIM1kyVHZt?=
 =?utf-8?B?K0JETHQ3YVFhdTZCK2pmcU0zdmRidG9wVXVNUkx4Um1WelVPOE4vSEpBM2lH?=
 =?utf-8?B?azNTbW5NbmozaWhGWHhLMEhKQUY0S3g2VnVuTWttWW5iRGdQcnhqVDdYcy9H?=
 =?utf-8?B?aGczMldzTmZLQ3NUa0FWSGpwVVJUbUd5UEdZU3BoZVdhT21mWVdZMlhGc1FS?=
 =?utf-8?B?aXdxUE8xMzcrWUE1d04zVFo1ckszVU5tVXUwbnpBRnJmYkJDc3YweTlwNUtU?=
 =?utf-8?B?eWh3L1JoUXpTUHVQajRSRkptdVVNMTZwbnpvd1VXQjlxR3ZjSGpUN1NyMktu?=
 =?utf-8?B?bnBac1JuNkt3aW14cE9XZXJBRDI5dG9UYXZVQUpUcGtnYkYxKzRxbGJTaDdn?=
 =?utf-8?B?NWc1UUxXeVpVelI3SFJKbmNJNitMZUJ2UFJSU3lMTDBxemNoYTczNGZ2VHI1?=
 =?utf-8?B?ZzFpZEQxVDdtay9zVkdwa1BvOENiSVpaUDVzd0UyaUJ0Nld2YysvRmJLbXZY?=
 =?utf-8?B?K1plY3ZONi9WeDNWSnZCbkhQbTl0MjYrQ0JVeEYyWmQzZDdTNlhyRk9ZczVY?=
 =?utf-8?B?Z3doRXoybFU0N1lmUHNaeUlZaXcxOTFFc2duWndKbEJ3VCtJQ3JNby9pRld3?=
 =?utf-8?B?OVRObFpMVnVydVhHZUN1Y280RHJGY3BXV01jUElYOTJmRU4rS3Jray9lcmZS?=
 =?utf-8?B?ZlJDRWdlOG5NTElha2hkNzVyOU1uaEpkV2h3WkFoQ3E0RXFRcFdnSXZwQTFp?=
 =?utf-8?B?eXhCQ2xVTWROb0NCaSs1b3R5bHJ0TER5b3NuaG96d2NVYWxKdVFQaUtPRkJ0?=
 =?utf-8?Q?n7kKWamDx9Q8NvwoY0qWTnCib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd189760-6487-423c-22c6-08dd45b926bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:46:08.0142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mYpjnxpf0D5QENrNe0NZI4GHiWJmI/xWMUAtQWUysnXMxDiZZ/hBAAlLIpSCTTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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



On 2/3/25 10:28, Michal Simek wrote:
> do_fpga_loads() is not called from anywhere else that's why make it static.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   cmd/fpga.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 212f421739fa..9dc7b63db5d1 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -67,7 +67,8 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   }
>   
>   #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
> -int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
> +			 char *const argv[])
>   {
>   	size_t data_size = 0;
>   	long fpga_data, dev;

Applied.
M
