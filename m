Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9435DC44501
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCB78490A;
	Sun, 12 Jul 2026 20:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UmBgIryM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E760849A9; Sun, 12 Jul 2026 20:50:27 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C85E848A1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVJFryeK0Kgd6b+B2XWlk/eMyi0bLU1vMGPSx3FpFxdpDRbvBKO4+uwM+7hSyQBVlQCsIe9V0uVHx2AzV9pLFV4i5SCK+KYfnfzJtRWiR3KF3bXucw0TU7UtsZZtbQndxzOMFtQJCzTiC2lo73E+iG/CRx6g5B5FstaPcGe4UuX//DKi/LQL6RS4fHWCmV20Hc0dDXZ94N7CKXzH0QWnfTgFK79BpDbAcRq8yXjsw3FywzeglYFN8jT0F95P4pzcjTuMooBC4y8EO/aFkJ4d9T8+ma/66NB6oyruOE8FIppQlKMFXqK/ZegNYShagj7/C6Kg+ZFVCZJj0XMMfb1Z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qw6haWY5b8zUmoQ/Dl4ic4C1KHLKXk9x0/j0fnUgXA=;
 b=CGpaMqz6aPNJKdxvwkLUyVrqiK4II9JRAIKn3rFb1G5y8uURiSJ6BKFQGn2KRRO35p2kQlZgWMLZJwmFhJV4+/SKdh8qiN1PCXQ+KRYrG5NNjN4O4E/Iwslnaa1WPM2MQiy3MKt4BcZZAfL/WI0+zPPgM0qv7flPJ2nz/x6tLYsaG3GpwvHLFLwM5dKMRZRcmaoe3uYiVg2/FmpREmWkE6HOh7NxO1IJP7TugWjG5atlzzR2BvaMQPTfxd+Qju8KAzktEh3a5aEbgWdW/rjFHsE5HjPyj/qJbi6tEEoOgTVF+dXzot20lFN7awrrBiEJt9KAhVTFRNfh6/7pZnUvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qw6haWY5b8zUmoQ/Dl4ic4C1KHLKXk9x0/j0fnUgXA=;
 b=UmBgIryMT5H2mvvg5aOjCyTNGT3c9tXwrnCf8hc5NAp+istyjZK70+TjzFZT/zp/48KiPFCtpEqxytIrtMMZKepiw2+oefTm3BE/Gnrf483llh69zGiSjYgWhpU+BiU4ahxXIQoBpZAv8IUFWV/xDu2s8x4QPSmWUDUmcfB9WwORI50NvcfJ6MLo/v3CUYr0Iwz9xsSTIH4XIx+HAhUm5QLdKfHuMRkkHE3gRu4pFRFp7OJDvLl91BvBb4UK2/vKiAZEeoUx4/+cvCdAOZEO7BiwzORsK67L+U6/5mbi5O5kLeVTb9/WHboKWzmY0i2EuKxn9ibwktznQwXwPWipFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8427.namprd03.prod.outlook.com (2603:10b6:806:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sun, 12 Jul
 2026 18:50:21 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 18:50:21 +0000
Message-ID: <b86a6dff-b055-490c-88c0-bb320b97fddb@altera.com>
Date: Mon, 13 Jul 2026 00:20:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mmc: sdhci: fix align_buffer memory leak on
 re-initialization
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
 <20260712-mmc-fix-v1-3-99a1136bbe54@nxp.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260712-mmc-fix-v1-3-99a1136bbe54@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0329.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 990335ca-185d-4035-7798-08dee0466be4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|18002099003|4143699003|11063799006|22082099003|56012099006|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: YarL4xlay0Nq3xfpcCM0gUqS4YasaLrXWFatkEmXj1QOAhIYPfiWTCgCT0OR6a+p+WR3bJ81SEdi0Ht+5Hs1LmMQzCQ7JqX4/tUG4NZL3rGC3AqhT4cliZGErcbxDsxJtWfOibvwZZ2vFPGCuDl5uvNalBSfWuHHw4S95afhQ98SumE1YLZkeI0+xkx4Oqxp2sOIYFTwsxFfLM3cTqVfCPi2NiKv7S98q0QyDlTIfjKLT3TZ/4vhFbf7xl+v7rQgmlsiSGMuuraA52kKjS+r6taaJFWJ6H+ySllRX0QlGxr+dqarq37OiGMuZwMMSbzzPzR0bRY3676Vd0H1j9Fn+HKjUSNeoMJfg4iYkhQFTC4MbKdtSa56rshQ/86mXplLu79FHSjxXl6x3I5f+5i5uLg+GGWrhHmnryXViz1sJP1JoSlX3HCpD7g7B5lNbWUmR9poDdaBRWsMFgpHGvSDfMtsXJmI/LpEKQnjXYxs9r1DNmadfQGjUQq0mrZrh66/CVz6x4MJ4OuWGIpJhE9Y+HTBqj8xiuMfZWVr6kwq0SB/nWeutotFZqkKkL7poXKRZdVvOL1DNeRMieMqv1VI2778eqF8rSLnkQG37K65/mcjuEzG5mYVQc0V9rVq5pyh/5mEA8hlZHjsBdw9AiWVY6opWDZXQHo/RpVMSp6quT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(18002099003)(4143699003)(11063799006)(22082099003)(56012099006)(55112099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjB5TmdVdEpZVEJHeFJUdnQraW9vVlNyVDkwL01nQnJYN3ZzanNsVVFMUmd6?=
 =?utf-8?B?V2lmZTZlR0xoKzBJTUF0ZUV0Yi8yOThJdXRTQndFdVVBb25McDJySjcwZHM4?=
 =?utf-8?B?SmdIVUZnaVpMZkNDcnZ1b0FmVXZQdTZhMUV6anRTbUxrblMwOVc2UU4xKy9l?=
 =?utf-8?B?cC9hakpSdGNJVTFLeG42bERzSE84K1RjeWJISVRYbWtkVUlRemJMdXdEZ3pH?=
 =?utf-8?B?VlRBbzE0NkVpNTZlb1hnRHVweEtzN1k5VVp2WXBXOUM4TFY3V2M3dlREeFBP?=
 =?utf-8?B?eWFRY2x3Q2h4VE91aTl0cHlQUEMvNTJQTFVyRnJZd2luUHNhbXkvM2dWaWlt?=
 =?utf-8?B?d0J6LzJUaE9HVG1xdHhHWHllTStYelJwMUE5MDhNVEtBQ2RSY3ZMYlhXMnVo?=
 =?utf-8?B?NVFzQlpWSk5CQjVtV3FqaXZhQk4wT1g0QitObUNKN1orNS8zN2t1K2E5di9n?=
 =?utf-8?B?UmZEbmNCeDNncnBqay9ITExnUVUrQkhFSUZmSHNRSjZ0d1V2ckd5UEhBWGh6?=
 =?utf-8?B?VCtKc3dEdlNFeHNyaUczZTd1Qkx6NitsNUYwLzZzcnFjeVl0R1BscnFxUk9N?=
 =?utf-8?B?OUVwSFE1azJ4ZnJDa3c0azAxeWptRzdGRFJjR0UxQnk5b29GMDIxM0xvN2RC?=
 =?utf-8?B?UU9oVjROZE9sbWhGVzZFZzZ0UnBvZm80dlhoRHFpYnQ1ZWVIa0ZHVDc2aVo3?=
 =?utf-8?B?bDFiUE5EY0xleDBiN0lNNUdsTW05TW5FbCtaSGMrY1h0VFRFZmw2MjZocDhB?=
 =?utf-8?B?cFlPMEpvcnR5ZjI2bUxLVVRQWEtHYWJYajBMMjJmY2p5ZW9yN1pVVk1aZll4?=
 =?utf-8?B?aTdDeUVaOEJOMVRkVzZHN29tNklkc21uRXZtL2V0WkZMUlJGYXVZZGlobzlz?=
 =?utf-8?B?cXRkNTZmTkpmdWVMcTI5VUt4Q1ZlcS91SnRLT0k5cnZMR2dDKzVXcmcyVytw?=
 =?utf-8?B?LytyUFZqTlYwaTZKREQwUkd1Q2k4KzRBV2RKZXlBSmdaZUJsbzRCK2UrVFlX?=
 =?utf-8?B?UXZTVTJDNUNuOWx1Vis2NUpUTFBlZExkZG0xblZlcDZHZlV5OWxYVVdoaGgr?=
 =?utf-8?B?VXZwdW56Z1czckpjbVgzVXBVYUk4dm5NbUNxbWRIbUk1Q2kzZHpxazc4ZG9N?=
 =?utf-8?B?ejkwR2dNMGxSZDAwM1pXbldBRVJCZ1NDOGdyWHBNeGtVV0EvSjF3ZWdOeDZU?=
 =?utf-8?B?OTlSSnBVWnB2TmtsMnhjOEw0anZJSENJQStjV1F0d0xMYTRveWlwVjZ0RzRh?=
 =?utf-8?B?ZDZmTUhDMUtiNHFNQXFBUkliZFRVZjBwbURYeTN1Zy8wYXBMUm5uYkVGcERF?=
 =?utf-8?B?cmlidjBEeGhONlovYkJsVTR0UmN3UHpENnZZQWZlMXE1aUV3UnNQUVpXaW9K?=
 =?utf-8?B?Uzh6REhKclFPbXk1TkNVazRHR0hEK0ZBNkYrekNQTDk4NFJBT0JUeEZpU2ZW?=
 =?utf-8?B?MjhQYmhtWUdXNVFleURnL2dSb21XM0NrckhiQ1RNK1MxZ2ZOU2FPZEhEUzRr?=
 =?utf-8?B?K1dTK3hFLzFyT0QrOVpmSU5BVE1oY2lLWkRqTFRhSml2SmtBZ2hLTkVWUVpI?=
 =?utf-8?B?ZElZQ3haemZaQkEzTHU3SHlScE1qbkJEZWErOGp6MnlkMnFvL1g2OWloK0Rz?=
 =?utf-8?B?elBpamsrZ21xT2JFZ0tQQWx5bVBUN1JVZnNtSENDZHpMaE1zSWtjVkJ5YUxm?=
 =?utf-8?B?cWQwSEZYdnJKTkJMb3V0QzJrZW83aU1aR0Q2Uk5ldmh0Rk1MTnh5ekc5dFh6?=
 =?utf-8?B?ZFoxdzZWd3c0UlRlKy9yVmZsMTB1LzcvNGNUUHhvdWZlcVZhOWV4eHh1KzFK?=
 =?utf-8?B?ZWk3WHVhZisvOC9CMmNtYW9xKzYzcE1PNkRyWmVJVlNZZlJsZit2M3pUSUhE?=
 =?utf-8?B?RmhJTGRkSTJqVUNRVUptTTBOSW9kNUhvdm1ZQUZoLzJPcEl4ZkJ4OG9oUkVj?=
 =?utf-8?B?ZFBiVElNcU95YXBNQ1NhRG1RRzJGR2h6UHgrZFJscnRsc0JPTlkvQk4yNlBm?=
 =?utf-8?B?bCtJeWRybHJlTzJsdzl4bGkvS3pGdW95TjBzcjNLSm8rVklTZWJkU3lnUHRo?=
 =?utf-8?B?SkM2SE5pamhZNW1UekNYZHRrTkhSdmpUL0dDR01BekZZcFl3RDVWNEZYdTYw?=
 =?utf-8?B?eVJUSUJvMWFHTkFwL2lxVGxCZnJHN2hCem5UWjl2elk4VC9hSlIweUhYSWRq?=
 =?utf-8?B?Ni81NGIyTHRUQStESmh2bGxaUktMc0lVYUU4WkJyblRsT0NGQTFkZGVzSTNp?=
 =?utf-8?B?b3pHZVhNZVY0UmUyY0swcVhYNWEvbmdhaE9FUW1mNGZySVo5ajdhYTV1SDRu?=
 =?utf-8?B?RjN0WWdRTkszRzRtNEpaTytoenJYbFpPMUhZdVJxbTRDMHB4czVnK0FaUytP?=
 =?utf-8?Q?nIuFmvKXL++HTqCU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990335ca-185d-4035-7798-08dee0466be4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 18:50:21.2336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLf+uBsNs7pyU0aj4slKcd2WSYME4ujAnZjp/X8MwkLiABLDlXEqqqlPQo7cploSvMg29RIJThKqAYiWyPtcyJ8azGZ2eOtkoac0meo0bEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8427
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


On 7/12/2026 6:37 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> sdhci_init() allocates a 512KB aligned bounce buffer for controllers
> with SDHCI_QUIRK_32BIT_DMA_ADDR. In the non-DM code path, sdhci_init()
> is registered as ops->init and called on every mmc_init(). Each call
> allocates a new buffer without checking or freeing the previous one,
> leaking 512KB per re-initialization.
>
> Fix by guarding the allocation with !host->align_buffer so it only
> allocates on the first call.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

>
