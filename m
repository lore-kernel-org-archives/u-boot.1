Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7C7C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4B6885B6;
	Thu, 23 May 2024 16:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MSDN91+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0119887F8C; Thu, 23 May 2024 16:53:48 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D85885CF
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3U/ieeEaJESDnBtZ3gYffUL+cvVD/K7u1BoVm2Qlz6KiBcnW6Mdi2a46E3rbE5tOWPDElLvnTurYSw0jHsIbcVT77Ze4bfoug69hfLLEnOGNrSHqf4LIZgO6l57EkF+wFgJ78Qet4Q5CJacuMVkYo96oMaEN34jrn3G4QX6bfuU6RJjAj2BMBS1lvtHtct0FhcQ1C1rYPQnuVKoq90iruBvWDKs//Ojj/RHTCdYg9SaB8+y6pE/8dWAIJNYkNIjd+biuceAN733icOJWIypCsu+V36wQfFtWmWIDLspcLWqcUwtxr3SVGm0+Sa+wygKFU6/f+2GUe71O68qmoW9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCZiGVEe8UM6pwYOnTE47z6y+g09QaAGx/3CvUBYd4E=;
 b=EEyOfO5HPUzei12ofFRmZEp4Soqy9InKejPqjXHWC3NvIgGZpjZu4Oz0Dkn4GbpqEWa8uY/3q/Uw9danYp6F6lC5KVyQk3F0c67QHXCCglFmlb4WqmdmrUSQzr8e0jsb6p4lB/HAS99tsL8IEitfASWUVgL1fLiVRatkc2wMMolp2htNTn35bEoiknWdBwc2vNgIZRzRKLEHY7V95cBqwav5apW8R+UTOCtoA3DJRi7XtIw5YbMQrzENbdqWPIurQxsTiZI9x0gUk4QPajDwDW0ixz25rjIWhUEJWFpY0lD3Tk/owcWjx6KLXbrbCS1YTKq1bU/BzWpArBC35c+pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCZiGVEe8UM6pwYOnTE47z6y+g09QaAGx/3CvUBYd4E=;
 b=MSDN91+cvF7tgXjLUR+GjXg1mJf/XL/2MWaHWIoPApB1UEunfbzJFXIqRtb4foD/j1d18QM6gvPg28pb8ImEYULRbX1sSk8ZGO62zh8Ox3M+TmO448vOc44he5D1pKUHofj7eTAnx7tqdw4X/hCLXxwjK63VgplAIaWDJx/AKRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VI0PR04MB10370.eurprd04.prod.outlook.com (2603:10a6:800:214::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 14:53:42 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:53:42 +0000
Message-ID: <7eaaecca-4603-4fce-ac0d-2407321185c5@cherry.de>
Date: Thu, 23 May 2024 16:53:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/42] mmc: dw_mmc: Extract setting the DMA descriptor
 into a separate routine
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-10-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-10-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VI0PR04MB10370:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b8cd6d-0539-4120-9a3b-08dc7b38234d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGZhVTRvRVRjV3pEbktlUk8reWlyaWpxRHlyZjczYU82RE5RZ0NRb3c5REJz?=
 =?utf-8?B?d0NhZGxKNGhxbXVEVjl3TFUyaVRRVWIvaENsbFBtelJscmhXcW0rRXgzbVJU?=
 =?utf-8?B?cTVuczNHUU4xbFdWcWF0Qk5tSkw5RUc2YW90ODVlM2lMamNSYjFJTjBiaTdk?=
 =?utf-8?B?bTd1ZUpvZE1GSDZkUEVTQXdNNkhPN0ZocC9oR0JEUitJeFlmR2hhbVJLRWZV?=
 =?utf-8?B?cDlnVVlzNXNDNDNINml1YzNNOUIwWG51ZXdJZHlXSmVvS2lQVE1lejQ4RlhP?=
 =?utf-8?B?N2tTOHFWcVU1emVxYlRLRTYvTnlIbkxOa1dySzZXRE9OUVpZSG9LOXhmN0ZX?=
 =?utf-8?B?b25BdVMxNVRQS3NNTWN3M1V5ZlNPR094NTJxRDVDMnlhNzd3TjluZXVJR3Z4?=
 =?utf-8?B?UkIzUTZydXZVVldDQ1pWaWFKUHJ3YjJMS0VWOCs4c0psYXVpSzArVGdlczhK?=
 =?utf-8?B?OGE1LzNSdlZIR1JPV2dQVElQUm1yaitCTXR0TnZWampqYkpWalE2NHVMM0VC?=
 =?utf-8?B?bVJKUEJiUmx0TDB2dnMydkZZdkl6bmY2eS80djRIMDdTYjBPOFZEaWUralh0?=
 =?utf-8?B?UEY2R1ZabzdJTlBZU2ZxZ01Dd1VzTW1HbE9iOFloVmJycDZabmNBbHowVzZr?=
 =?utf-8?B?REhyYTdTblYyZEkxb0l0aElPT0MzaTMzOWRjZGVuWldZdGFLT1lYRERQK1Fn?=
 =?utf-8?B?NXYra29FNUtKczIvdVJkTHRpa2U5cGtTMUlGK0pzcnpMbDZ6bGR2Uy9yMkFs?=
 =?utf-8?B?RHNkWVJSNS83VVpuaGQ0M3VPV2E0blhvVTVEMUhlV0RQV0orV0s3NzFIQ0Jn?=
 =?utf-8?B?SFB1dlErTjI3bUUvNHVBSlg3RjRBMTdvQ1VRZ0FkMW5zN0lLZndOZUxMY1I5?=
 =?utf-8?B?Nzl2ZkxBMytBRWxobU9CR1E1R0pOVzNnWDVRS05MWTFHTjdJWDJmZXhTTEV1?=
 =?utf-8?B?RWE2NEhjbEpLL1RYR2xKZEtIN3hUQ1p2UXVXU04ra29YdFNGOUlTK0ZPUE5v?=
 =?utf-8?B?WG5HWTB1K21YbmNjd1JON01mL01PUGJ4aDQrZnZUa1M5Z2lMVmxpVVRPcE1a?=
 =?utf-8?B?NVBJWEZFOFoyeHNnQjMzNGJSeFZIdTd6ajNRNVM5UWtHUXN2MHkrMUZORjJN?=
 =?utf-8?B?VzlDSGhxMUpNbzlKN0o3QmxRUTJvSFRwcjh1M2E2Y2R4WUdabE5USzNPcm1N?=
 =?utf-8?B?bGJwQTFWR3c1bGdITkJ6NTZmWU1ldEdNYjg4WnUwTWFjejlrVUkwZG1HVmkx?=
 =?utf-8?B?UzBzMlZwWHo0K3lrZ1ptQ3dON1NVcFFGUDRtTzFwZ1hKVUtYRlk4RWxOaGtX?=
 =?utf-8?B?SnF2U1lTVmZRaUFWT2phSFZNWU9ZaWNtTWlrL2ZDRUg4bHpnQnpXV1JoRGov?=
 =?utf-8?B?TUp6QmVJTkNISUlsUmdOL3FuM09TUitISExWbGhYVm5iMGY2bXp4bDRpYUJq?=
 =?utf-8?B?QlZuVC93bHQ4UTJyZ0dDK2ZDazZpOGdzcE1xTE9BS0hnd0c1SDE4OVVPWXNN?=
 =?utf-8?B?Uys1SXVFY1lOVmxxa3BybXp4Nm1WTGZDdkpuQXM5Q2ZjdkxWSnpySzlqd2ta?=
 =?utf-8?B?anBDa2MrNjhzLzRReDRENHpWOFdJZHZHcWZrZzIwRVRWaHBTT1FTcUFuZVhz?=
 =?utf-8?B?cCtBMVVVSjF2Uyt1T0NpV3NFQTBOZ255SzBKWXYxeVVUMDh2aUNtOTkrQUFZ?=
 =?utf-8?B?ckphMFhXcHMzYTlYcFZwSEllOFBweVdCZFF1MVJScGhBSlR3V3FNck93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlM5NWFEa29DQ29vSW5WbU0rYkVLdHBnZXgrb1NBOEtZUUF1QkNTUXFxbHYx?=
 =?utf-8?B?eDNsQUN0YkxIZ09uUGZBaHVpTmJNSE9oV0dld3FuUFA2bVA0MHh3ZWQzQ1Jq?=
 =?utf-8?B?U2MwWXA5L00ybW9JTkFyZ2VQWGN2dVV0STJ0SCtXOXR2OXZpSGNHbFU5bGN0?=
 =?utf-8?B?MitHNHFuV1docEV6S3pSUzE3K0premxIMy9sdTlZdlVhcjgvb0UrcTg4OVNw?=
 =?utf-8?B?bmMvVHczN0VsSkk0SXFlOUlzQm9WMktWMlJLTWJjb3dFdmhaWTBmZWNXdTBU?=
 =?utf-8?B?Zk1KU202UzYzL0NxcVZOVmp3TmZRa0pmR0tZZ1oySG44bnJnRXBXb1JzSnZ6?=
 =?utf-8?B?YUhvV1J3RWQ4czBEMWZMUDZWemhKNGhJY1lnc1Y4M1p2bVVDWk8zWHJIa243?=
 =?utf-8?B?QTlQOUFtS0FqaGZRblprMWxoZ0taT0FTWFoxTU96QStJRFNvSVE3RkZMcGlT?=
 =?utf-8?B?MUg5WDlPOEZObnBLNVpNYlR6NkNIeTdmN2RGQUFWZ3kyV1FVMVhYeEFwUnRr?=
 =?utf-8?B?QTVzWEhsUXQ3RERzTFB5TWhXMHIwM3E2T1JURDQrTUNwcjVJbllTRGg4T0o2?=
 =?utf-8?B?T3UzYzRYSENRK0FuUERRUmlWQndrVnRybS9SUTNXVkhKWUZhaUt3M0N5elFY?=
 =?utf-8?B?RFFqR0NjRjlDNmJyejNWWnFNZkcwUGFRa3JNa0RyQm5WNWgzMU5zMTdqeHd5?=
 =?utf-8?B?OWxIZmI4dUFHZHdvWlhtMEZpSURkcEFjQWRIWmZlZVVNSTRleW1zNWovQWgy?=
 =?utf-8?B?dkVjOEEyV2dxdmozM3RqNnprV1FhSkxvYm1ZODRwNXBrU0FkL21nU0d6UU1H?=
 =?utf-8?B?akZhKzJLNVlhU0k0aUNEMGY3MlZSbXMyK0xZVUN0bEQ4UEdEZlpQSGJmWHpj?=
 =?utf-8?B?b1hOT3hUTmNXSGQ3OHg1WWlnMnBTMFR5OFgySk41eXlCVlpUSmJnNlZ1OUpz?=
 =?utf-8?B?VGpZbi8xMDFyY2VicmhaZE5TZlBkeXNhdkc3WU1FcjhxSjlaeWEyb1JLdDU3?=
 =?utf-8?B?Ym4yaENDTXViSXZzRkRCS2ExcUlYK2MxRkZnL3dFTjVLL2EydWY4V2ZPUzJQ?=
 =?utf-8?B?cDFOMFlBMzMvRVJJQWZmbmZhUFNwbnppc3FtTGlQbzN1SUFIUTlkR0V6YVBO?=
 =?utf-8?B?KzJjY3daY1J4Z1Z1a3FlZ1huWGJlME9DdUpRZlVnUzJELyswMUdQVHdsV1Z1?=
 =?utf-8?B?MlJ3K0kvcldPTzdWU3U1VnBoNHhlZWZKcFpLNERiTEdhWDVUcjJrNDF2T0pB?=
 =?utf-8?B?bHdTZjFQOWpqb2tLZjFnL2pIN1FmTkZ3OS9NWW1lMUhTNUJVK0RuSVhjSXkr?=
 =?utf-8?B?OU1DNkZsY3YydUkvMUllOTF2RUxKU3EyVTMxdmJYbk04b24wR0ZXYXpCdW81?=
 =?utf-8?B?RUVLS3Bic3NtZk5sblJ6Qmlxam9ETHA1cGcySHJJNmxId3JqS3VIV24wZTd4?=
 =?utf-8?B?aEpzK0dsSjlFS1lkaW1ONHUxNjVYNGJoWEQrWi9GeXd5UzlFODZUOG43SitD?=
 =?utf-8?B?c0oreTFDVmV3VERlZDY0TVEvNlJCK1dFRmdiSzJha0Z5MUhnYUZRZUxSTjJE?=
 =?utf-8?B?UUZqaUFqUXhueURGWlpBSk5pRGZsWEZnb0dJYWhyRE1ETTBHRVZwNUFaNUgr?=
 =?utf-8?B?eFJqeU9rZjJUYjgzdHJhV0hUYWxFbEtGS0pycDJUbS9TdmR4b21hOUI4ZFhG?=
 =?utf-8?B?cXNoSVNuOUF0M0JpRmZFVUJhUEpIYXphYStWVmVJcDYvdktxNmprOUVQM3lN?=
 =?utf-8?B?WWxKaWRZMjVqL0VqTFcvMVVqYnE4MEpHWld3ZGxzNVVEWVFTdXZVUHZzdXNK?=
 =?utf-8?B?dDBFVXBnaUlQSFBtUm5FQUNHV0xzN2h5VEIwS0dhK05ZOTVONlNkN21Gdk55?=
 =?utf-8?B?eGVqRXQyZUdnZTRGM2Vab0VrM2R3T0dUeVlmekYxWmkrazQwQ0NNL2J5NWg5?=
 =?utf-8?B?K09qL0xhYVJEa2Y4eVZqNlgzWXN3bXVJRC9kK2c0bUIwN1JoVm95OEpqR1Zq?=
 =?utf-8?B?KzMwMlkwdmhBWVhEaXJNRFZBM2xOMHA4ZGdKYmkvTHlSbkZwUkV0WVNDbzFv?=
 =?utf-8?B?aGZORmFvcVlKWExxMm9KdjNsc3haa0lPS09pYmZoaVVKMmk1bUpkN1Bsb3JJ?=
 =?utf-8?B?VzB1d05lZVNCR2lwTFZnLzZHU2ZYR0M2NElCSnVBMXBhM3hrVGhUcU9VbXc5?=
 =?utf-8?Q?78GFPRu6kukkbyUc3ZpYBz8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b8cd6d-0539-4120-9a3b-08dc7b38234d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:53:42.1321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3oeERmPsB9xtXaPrlmCL53dDz25QGuQgxH0/bfrzfWSd6SvAO6HkT91cTxkwLkY82wKv1ISkenZ+moDTTD4Z6zGSC1t+G5vwGJLFmv20EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10370
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

Hi Sam,

On 5/23/24 1:31 AM, Sam Protsenko wrote:
> Make dwmci_prepare_data() function easier to read by extracting the
> preparation of IDMAC descriptor into a dedicated function.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
