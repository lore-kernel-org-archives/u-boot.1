Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F555D74964
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 08:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422E980077;
	Fri, 19 Dec 2025 09:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RR6luE6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4353080433; Fri, 19 Dec 2025 09:36:22 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522F48003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 09:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdEb0vQarg8/Ba2ccrIn41Tx3imcUcwXTiZiPuYVZXiSL4JIOLzFVC3MSEXppH7bCqtubt6YdI01Goj3eWh4vhW4vMzEhusnVHp5cQQ57kZT6SkvPVeWHIIRwj8Qnp/CZGFlAmPGa/uWZ3gIg4fqJf6bbVq4y8cTTFL105FXbnjcBFQhEcbWn98UdTQn57zirrW/Nqa3CN2K+x8W9XbQxx7OF+Ce5p6DckFksujbd+YLnB2ab1exKrNJkoAsegxdCJyI91nYloRjC/rgSB1fsf0U7jL8txp82HDqTl92zFvoubXH94r0qXU9PYht/5pUaNyVs33HgTiB632kIkLhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1MXiaN3KOhh+V1DABVC4YamMiCj62Ey2wq73jMaerg=;
 b=y4N2Ih0TskCQUZdVdXopLGdKz1gwTZTsMCy9htSqimsMCJ+FBsM/sT3j/49DUngpkx7tVvO9hJnqvlE6eXJifaP3+tFjXST3Ai6cKdmW1InD8LTyuUfr0gGYdUodHRGj2gtVD1rvp7ZOdRBzGC36r/xUGdEfLdfZd0N5FgdkGlswjFMR0BX1IKTZsRiMTTYMZXtrL0DeLy5VSTSrfr49f4eJhxSHbp9XstTGwkbgjhpJBPJM49M7W/7/w3pBb9egrA6xxGMSxKV2fkV5Y5Wi4dF701DFot+ryVVMiXRE9Fx3aChKQs2BXpDfnEX+gLohr1rh993f8vAm5qCHcxJ3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1MXiaN3KOhh+V1DABVC4YamMiCj62Ey2wq73jMaerg=;
 b=RR6luE6Hy/9YeJHPqeqi7qoP9+wJFYdaFmlo0vdOzHwub4KHYDTTv60LQwlnL9LS1gYfmV4fk3Fp5qbwcH4oX306xO+nW40ZYDC3mxTjaHnBg2lapnn15FrwN5cAX3wJWzAIKWK9E8DzaVJe8ds6QEmx74XxeakxvazQ0Zqmh+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Fri, 19 Dec
 2025 08:36:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 08:36:13 +0000
Message-ID: <c237df33-5f3d-4478-a698-0fafbaf65754@amd.com>
Date: Fri, 19 Dec 2025 09:36:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Enable dynamic MMU page table sizing
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20251212102621.2888015-1-pranav.sanwal@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251212102621.2888015-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0064.eurprd03.prod.outlook.com
 (2603:10a6:803:50::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3b2206-fd39-4517-b596-08de3ed9aac8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1JtUkVHQXFZNkdUbXU2TjIvRmpKQkpDYTRPcEphZUUzZHJEcHVKRGVrdk9O?=
 =?utf-8?B?dmFVMEV3b0QyQnpkR25HUmVVLzJCdzdNYjNRRVJPUCtkdmFJM0N6Z3VXRmc2?=
 =?utf-8?B?MEtKYW14TWQyYTV5cHhGWFJiS25KZklVMVRpSGxBUWZHc1ZXang0MXk1TFVn?=
 =?utf-8?B?SURNOU1jWitxbGVOWC9tZ056RGVVclA1NU12MGlTdGdaZ0c1emlNMGlsUjFY?=
 =?utf-8?B?QnY2V2o0c1I2U2dpb0xNR0dNbzBnOHZ2MFhZY0dVNFFzRWZrT0xYSVd0MWhD?=
 =?utf-8?B?RndzZEZVK1pxcGs3VERYQlBUV2E0ZWFxNFp5Y2xuS3BCdWRpRFZVTGcwYXJZ?=
 =?utf-8?B?SEZzcFVmWDhFbHk2Q3VUWXJyKytoelFnNUwvRGdYMFZjTXBoc0o1OU1EeG1r?=
 =?utf-8?B?RUd1bG5vaGZBcTM2T0dYVUJjUmdtZ2dLZmFvLzdYU0hTZmlEc3pIb2RrSk8y?=
 =?utf-8?B?Skc0SzN4UHZWdDRKZXVlRFpydE5wSDljTkZOWGROODk0dE5MZngybnFla2VX?=
 =?utf-8?B?d0ZtdTlldEYyaTBtUW5VNWVMa3pyV0xDaXhCRngraHU1STV4VzBkV3BjS1hE?=
 =?utf-8?B?U2NmOUhhcnFlbFpaRzg1OE1tTW5pNWg4eFVnWnVUaGpQd2FZOTRjR29nejl1?=
 =?utf-8?B?czB4b1ZHaVo1bVB1SnpUa0VSbUZHZ1h1YnZ4eGl1cS8rOE5DeWdWc3ZIMHR0?=
 =?utf-8?B?MHA0ZCtncTl6K1ZVNjdaMDFTeWtGOUxFdTgwQWgrTEpxYWpmK0xOUmI5b0JJ?=
 =?utf-8?B?NUM4MWw0ZEdEMWhVQndtR3VXQ2ZpeDhud2xoaDZkWnIvSThoQjNTTDg4N01o?=
 =?utf-8?B?eFJna0tlMzRmUDlIbWFLTXpTWkpkT0JPakJqVGNtdWdxNExUbzdDZTFhTzF6?=
 =?utf-8?B?dm5CeGVrU1JRZndNb1NXU1JoRXJqSDFyb0I0U3NHa3FEN0hWZVVaK25hcFMz?=
 =?utf-8?B?Q0RsZHgvSHBPaTBEdUd3STAxdmpWZDRFK01IOWhMT3JleU54UGczelhCUjc4?=
 =?utf-8?B?NDZWR0dPNWErbTlyQ2IzMlNyaEpDaGNUUzE4NldhVUEvOE5aUXVZT2dwc3lh?=
 =?utf-8?B?VS9KZEI0V2dPTFROSE5tVlladVEyT2h2bStkejdFREVmb1hoUHYrSHJ1bkRO?=
 =?utf-8?B?YWE2clNQazA3K3lIL0RFVmo4V0hxaXcrNXNnNExKL1krQml4RnFoVU80MnVN?=
 =?utf-8?B?MTUyYkpXSzl2MW42c2NkZkgrZWorYWpjeXYxTUpackpVcXFSR1BVdHRIMWZ4?=
 =?utf-8?B?Q0p2VU9QZTF0dDlvZUF4TXBJRndmVzNkc0FBVjAyMDVzNldGbWNWTFZwSkpk?=
 =?utf-8?B?WWpDY1ROS0RDcXVCMTh0UldkRm9xUWx5djB4NlpGRE41czBMMDcyYVBHMXV5?=
 =?utf-8?B?VTZacElqK1dtK0JlMGcxbHBjQ25nVS9nOTlOVTdIVjZiYkNmeldOUHVpWjJ6?=
 =?utf-8?B?d3ppVnVWWUF5REVWSERPazR2aFJTcDQvbFliVDZQUUhnSXhiWUR1dW42U29P?=
 =?utf-8?B?eS92dW1QUHA2N2JiZy9pRnBrODQ1VndtZ0pkVEE0b00yeU1zM0xMZnlqUEFT?=
 =?utf-8?B?ZUhBM2hpRlB3dzBUdXF2S052aEVDdTJDb2d5OVJTRmVFVGJXSDRPSkR5VTlX?=
 =?utf-8?B?dzhKTS83QnNLMzVMZ3lhRHhFNHg2RHVyOFlIWjl5dVFDN2I0WVFPbW5HRnNy?=
 =?utf-8?B?a044UUdEU2dWVjI4RTRqQytVbTJoM0xPakdsdTZtSTlJYmZNRzYzUnFNMTZG?=
 =?utf-8?B?OFo1NE0zODhWRXFwT3dtWFdSOVUrRTVQZjh3d2FXcUZ2eEt0c3ZVa1ROSXV4?=
 =?utf-8?B?WVpYZWxMc0UrekFQWTE0TCtJVndPL1BHRzhjRFR1TklQNzFNUDNmUG8wMmVK?=
 =?utf-8?B?OE1SK084eGZnZkF6YzdiYXhhcDBmVVpDK2NsdUtKU2VzU1plY0RXaFloOG5P?=
 =?utf-8?Q?OrNuZTbn3iiON+tjcG98XIMZj5vGun3N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUtQRHR2TFRSV2IxSnJ3WlRGYmlXRVpLTXZrbGc2QXZPY3hHUGUxSk54eTZi?=
 =?utf-8?B?OHFueWdwSVpUYnhTbUZ0ZjhybnVyTVAzTDJKc0xxWXJnbzdLcmZOZVFNZHhu?=
 =?utf-8?B?ZTdQdEJOZWRZQ2pxbmZ0ck01allDZ0Vsdmxxc1dYMWhEZVNCc2RzL3BPSDJj?=
 =?utf-8?B?YzBzT1pSd1dBSVRzeFlhUmpGa29teVdqczhOeVZKRXlPSWZVMk9nSXZaaWJ1?=
 =?utf-8?B?dWg1WnUxb2oyalYvWEVWVjF2eW9Ja1phZUJ1VU5Jd3lYaUY1aEVxUTBiRnZv?=
 =?utf-8?B?STNnU0hDY20yZzJ5K0hXb2hxK2FZekNuRERDY3h4SDIrRlZJZ2xIMWNmL01v?=
 =?utf-8?B?R1prS2Rlc2E5M3NrK0tYMG9QV3lXM2V0QnlkSTBPdUlJb1pEcDRyUzRuSG9W?=
 =?utf-8?B?YWJMOXUwQzJ2TDRtQkM1S1FydjRNK09aemVLMlZna2ZYQWp6ZURZUk1TZW9W?=
 =?utf-8?B?SUVJRWd0bGN5VUZ5OGFOeHZWUmw4Z2NIaDAyQUFtU0g0WXZuR1dZUkdRdVUw?=
 =?utf-8?B?S1hKdmxSVXd6end2MW95REN5MmlEUEluS1JxUDhGalZnTkdXczVxdEk0QnIz?=
 =?utf-8?B?elRWV0c5Wmc5S3VaMG9scEJDdVdjQU9WSkNYVWw1N2QxMzdJUm9RUG5ORGdn?=
 =?utf-8?B?WTNHMkF5SVAyN25jb2U4b3hPdmJzUTlSdjZnNm5GN0pLZElkODladUoyQmlQ?=
 =?utf-8?B?QmVkbVZoZnFhNmZDODdOazhoNnNhb3BwNVpFR3FiVW9NbU9lZE90VmU0YTgx?=
 =?utf-8?B?c1lGcTkxbXNIUHRnSWxTMjhEWlFieWwwZmtmcXRvcXIwOWtOZFFneHRRV1p5?=
 =?utf-8?B?Y3ovM2o2OGVTSTFleklrc3VKalhpZm8ydWNtSEdJVm9QbFM0dUJnQ2hIUnhZ?=
 =?utf-8?B?RTFseHVQNmpNUjJTVFVkY1d2NktHcGV1MXJrSitVNCs5elc1cktTS2F0RTNm?=
 =?utf-8?B?TElpT2V6UWVvb1ZRWHdNZDV2eE1KdVkyZzVaZVNZaEl4MmNGa1JQdm9VS09o?=
 =?utf-8?B?YlJVQWtuWXF5WlhhSXNyTWFtVFZIb0RqUEVMSmUxa0k5dGJPZWswM2RUbWp3?=
 =?utf-8?B?OHVFd3RuVm11ZVU2Z2o3Znl3Q0xhZElDbE1IQ0lsNGZjbDlTRG1SVmVQdE0r?=
 =?utf-8?B?a3kxYXhhalNYamlxb0l0YUgwSDJ5cm14NU5aaERwcDA2VGQ1V3RMcFhrL1pG?=
 =?utf-8?B?TVEzWHJDNEF0UzZ4UXpObVdwOTZmaGo5dzhHTDJxbzZFdm9hQ3M3NDNVVkNw?=
 =?utf-8?B?TUozTnkvSVVPamdIbCtualU3Q0haOVRFSVllL0NIN2lzeFMveXRhSFY5UnFt?=
 =?utf-8?B?MnFHdnVHd2VtZkdBSE9EM3lsekRKMlZ0VWdJQ2dLaWpXcmRNckVBK01TSVpR?=
 =?utf-8?B?dnMvbjMyMnloS1IzK25hSFI4ZzFOVkVPVThERmc4c3g1UmdKRkw3ZnNEdm1y?=
 =?utf-8?B?ZEJGSngwdVhNa2xmU2JVNUFoSkVpTUN6ckhRMUNWd0tjclJQelFLTS9IOUpt?=
 =?utf-8?B?UGd3WlhabGRkTE9BM1ByYmMxMi9QeEpFVHh0ei9MU1RWZVo0eHZEeGhMQzFR?=
 =?utf-8?B?cFdSRmRKMEFzL1ZXV0d1ZFBRaUJOVC9wQy9YMXpvQVVNRFQ2QnYzc1RsUXJH?=
 =?utf-8?B?WjBPTGtodEJKdERuMHhYaXptMXp3NGF5dUhxZXQ4dzJ3VEFFQUpzMVRTUmpP?=
 =?utf-8?B?Uy90WGt4a2xQaUFRZ1phQXl0LzZxTEFqM21JMStMcis1SGQxblhpa1BwMCtV?=
 =?utf-8?B?bEhvVGZ2WnhrbHZubUZGSGpubExRdUtCZHN0TXNZNlRpTHNzTHBDMklmeXZZ?=
 =?utf-8?B?U3p0QkpITXJMZ3ZUQndjSC9DWnpIS1A4Q1pDampKZzAweVI0Z0NzSVdtK0NE?=
 =?utf-8?B?R3J1V0JvUmtvTUxIS3JyM0ZDcEJDRm5hbFAzRVdDQW9GZ1BhaGNBWHFnSUtk?=
 =?utf-8?B?RGE3Y3ZFbkQ3Wkhic0p0b1p1L2NqTzhQYTBVZUVWeHVSeTNQZjEzWVFYZlVW?=
 =?utf-8?B?Rjl1Q0pCY0ZhNnZOVkw2WUpzUWk0b3dPcXh0YkZBREYvSTFkQlNiUXVvemVM?=
 =?utf-8?B?OGwvcCtvQ1ZkZjY4N3pDSTVLZkEyZXhhb211RE55Ykd6VFJ1bmYrSTFzYXlV?=
 =?utf-8?Q?n0if462Q/JRQ+qr5+jiNp2hDb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3b2206-fd39-4517-b596-08de3ed9aac8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:36:13.1586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjf3W3d+v8J7UfZBOzYOh/DiI5mlUXhlceS09iMOA0pBFYTz6E2f2f4D5QGkCzJ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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



On 12/12/25 11:26, Pranav Sanwal wrote:
> This patch series fixes a boot sequence issue in AMD Versal Gen 2,
> where DRAM banks are populated too late during MMU initialization.
> The fdtdec-based approach doesn't provide memory information
> early enough.
> 
> Changes in v4:
> -Better debug logs alignment.
> 
> Changes in v3:
> -Fix DRAM base detection boundary condition (text >= bank_phys)
> 
> Changes in v2:
> -Address boundary case where U-Boot is loaded at the
>   beginning of a memory region.
> -Export get_next_memory_node() helper from fdtdec for reuse
> -Split previous monolithic patch into two focused patches
> -Add comprehensive documentation for new functions
> -Include proper header dependencies (dm/ofnode_decl.h)
> 
> Pranav Sanwal (2):
>    fdtdec: Add declaration for get_next_memory_node() helper
>    arm64: versal2: Populate DRAM banks before page table size calculation
> 
>   arch/arm/mach-versal2/cpu.c                   | 57 ++++++++++++---
>   .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
>   board/amd/versal2/board.c                     | 70 +++++++++++++++----
>   include/fdtdec.h                              | 23 ++++++
>   4 files changed, 130 insertions(+), 24 deletions(-)
> 

Applied.
M

