Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D70DC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F4582A1C;
	Fri, 18 Apr 2025 15:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MWefC2x3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5048322F; Fri, 18 Apr 2025 15:51:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 265BB810EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waWEmcC3ErLVy78v45YF0aJRU2CxfQMb2+mDdgfc6qpAG4WqxhIvzoUvVE1OlZqe7YmWdv+yQChVAeeGL+oj2Sw5Rdp7nSU7OBcrUYQ1epdG+eb1OF6J8NyhCI90uIgKfPj7FbL6QJAgdSYfB9jnw9JZJD61hB8H3Vg7JpgzTvIJDzeqAsNgLmZr0eIza8o5aLy1N7PH0iQVfeA0pXEc2WKP2gMzZrlVrJ3PzXAe4hYzRntV1taopAVE0fRUQ0eWJ1sJ8/o3BHMhI3yWnUj5ghKO4JTfmZkAsfGH6hqmz9WLEs9+wX7ynZ8WeefFX5nXl6xCXiI9TNxV1RsKLSyKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dbgEWRjLZ1lYn+K1DdepC05M3jd0WD1nPnEll18qWs=;
 b=m9vp15BAPqzrSIpX3+Ipe3RMxaPwjlAQqk6IQjZiYRk0S8ROsp4pfiqOaMC+9ilopHdjiOeerimWCp1JBZnRVFU458g/bz7jBoNdYhKrYIXx88ZDo/rwFl5FjsPmj4pBRVhusaYjxUkr0HEcXMTTYeXFIZgchycQ6f8Y75zSCDcOX8QzZ6bKKejE9iKhVkGMAWlFoJFLrstPK7EMOTsU03HC4855jpKyqr03wspC0+yQsUBeU24tZAB5N7QK8GeoyZg0It/EqVTvPueBNrP+mR6fhYu8OyPT1VAjG/fZr5Ny9WOOgrGwrbEfD6URS/Fx5kavgxwAC3VEALmg7jVoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dbgEWRjLZ1lYn+K1DdepC05M3jd0WD1nPnEll18qWs=;
 b=MWefC2x3Iaqiyy60BVFUcjgd0cXvboC2PgWPNs7UjcwV9Uh3xZJOUBgx1YT+lMJzEnO0gqeDzoHcjJI61kMD9HDJnyZSgiWSxDnjH4nuga179uNgBUkFYVofNS4gukU1GPAMl301h1uLNPnW3pwDR83gAfLIoJbHhTv7lc0zWKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:51:45 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:51:45 +0000
Message-ID: <ebd844d2-fa08-4e5c-b5c1-554d1e86ea27@cherry.de>
Date: Fri, 18 Apr 2025 15:51:42 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] scripts: Fix potential null-deref
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 592efdff-e558-4ea4-e159-08dd7e8027fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTB0ejNLR2pxRTEzbU01WU1yZno5cUh5QXIyRFhPUEI2Vys0djVwdUlxTjRO?=
 =?utf-8?B?aHIycElpQWIxa0hkWloyaDNPNEdIQlVVd05vLytqekN3cS96YnlIclVoMVBI?=
 =?utf-8?B?RlVzZXNWOWJiN0tpcWtFdUdXWHFDZ2xZLzhRN0NMMHh5Y2xCWGFPTUVHT1Jy?=
 =?utf-8?B?QmRDQStNeUFtYUNndjNNOEkrdGo2R0EzYnpYcWtPRDByVnFndG8zL0pWWUFp?=
 =?utf-8?B?bnIxVEs2amdSNS9ZRVVYVGVZUi8wVXRmNWJlZEp0aEg3TU1aZnZJWVd5c2Fr?=
 =?utf-8?B?cGw3VW9yc3NBNjF4cEw5SFdoOC9XSUg0cmpIT3JEOWVjQUIwUHEvN2hUeCs1?=
 =?utf-8?B?QUU5ZElTTXUrdWs5WWRQUHYwU2Z3NjFiY0NmZUhxaEpuQlR1VHM0NTJLN1k0?=
 =?utf-8?B?OENZZ2hBY2ZnVFlpV3RaQjNRRlVlek1XY3Q5dTlhRE5PU0orR24yNnJMZGNF?=
 =?utf-8?B?MlFScTNrdzI4UlhSMG9nQW5yQ0NDa2dSbjZlSmxhYjExbW9Hclc3RGNmcW5V?=
 =?utf-8?B?UjZqYXRkZkhYWnMzQjJGU1IrTk5zejRRcEFzRWovbnREd3A1WHY2NnVWU0pX?=
 =?utf-8?B?UXhZZW9EeVFlbHVhc3pWT0FPd0R6cUpwZHR0SFRhR3JkTW9ieStHcXZDYVpM?=
 =?utf-8?B?dE5SOFg0NE5icFVaTk83UnIzdmV5SmxFemFvQXRGSnBLUnQxRVdoY1pvZGFk?=
 =?utf-8?B?UEt3UTY4VzNhcmYvTWhEcy9PbkxiUTFKa2k2Z3FraHJiZmlMSThnZjErMUtu?=
 =?utf-8?B?NytNWGlxVUJuZlNwWW9FRS9CSGFLQ1gzbHZJMCtBakFrOVJZZFFWSEtUMVdI?=
 =?utf-8?B?TGF5R1FLaXI2WWtoM3JkeWdMUHlvd201dmJUMTdpcWhvN091dlFHWFh5OHV2?=
 =?utf-8?B?THg2ekxXZklNalo5MWNXU3Zwb005OWluNUl2VGpmUzNIRzAvY3VCTnB4WlFY?=
 =?utf-8?B?KzdqcU5pN0tOTkpGSDF5ZC9NU3dtNktweWorY1drbi9mejQvQjBjYlV2YjdQ?=
 =?utf-8?B?NmttSjdvaWZvNEZYWHNqMG1HMmx0bHdwMFNVUkFJYkZZbFNZdDFCOVArSTg1?=
 =?utf-8?B?NExyUmg1a3Jnbit1WDRGZHBqdzRJeFpualNHcHpWbE1PZEFLZjE3M25DTFJm?=
 =?utf-8?B?TGtjaEw4MHN2L1YyTnNzSytlL0VVM3ZQbG9hK1FrRFFSdkdsMW1DdW11ZTZF?=
 =?utf-8?B?SkI4eHJwYkEvVE9ZWG1EdDQ3aUhLOUVoUlNKTnFkREY2ZzZJcUlhMEFQTm1k?=
 =?utf-8?B?VWdzTUFRd0JWby9VeGtwMk5WUkVlUzRBYWZvaS95R3Z1c2hIWnE2VkJNbEhv?=
 =?utf-8?B?TVViSUpEVVdpY2lGWUhXKzdiR3JrWlk5LzZxbWpacW1mSit0WjdvcEFmVStD?=
 =?utf-8?B?c0dKaXdSdGJSdmh1NTFwWDRXckxHOUxnWmNsS1pnVTN3elhnNmFEb2FIekxz?=
 =?utf-8?B?aG0yak5jVDRXd3dGUVl3TTAzcG1jQVkyOHVxZFlTakQ2ZmxIcVJyZHJUL2RO?=
 =?utf-8?B?eWlyNkdrNk9KTkJCWmtzd1pFU0hFelhQbVU2MW1yRkdPUWpCcEo1RXFVc3pu?=
 =?utf-8?B?Q21aL3BNMnljaWFuY2pWdW9OTDRRb1h3TGpuMVM4dGJnN2NNd2ZkL0Njc1ZE?=
 =?utf-8?B?aWJVRHE3VWJEeW5jdWhOL3prWlRuZE1XVWZKN3BYRDhlejNHdlZMTE5jZVJL?=
 =?utf-8?B?NFB3blluWXAyNThWWllTblRjcDAwL0ZveFBHbG4vYXVYYjhLQ0hoSEEvYkRr?=
 =?utf-8?B?K0p0Wk5ENnk3UWxFazU1SFhGbWVUOVRiOE5jNzB4UmhYb1ZVcmZNSzdqWlVB?=
 =?utf-8?B?OWxJMEl3bExvVG5sVUlQSlN0NGt3bGVoU0x0bXJMUVc3UUtHRTBESUlQYjhL?=
 =?utf-8?B?NTRNeDZwREo1M3orZjBFM05pbWdpMVMyUlIxQUZQR0NGRDZNMnM4TWJ3M29E?=
 =?utf-8?Q?y97rj0ZqaD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1HbEJ1M3JGbmE0OXlXWDNHSU1EaStpTWk0eE42cmpIQ2lPSHZubnZOR0RO?=
 =?utf-8?B?WUdIMWQzSWE4V0lPckYrYW1FaEU3NmxjUVptb3UvRWw1Zy8xYmErRzlwMy9O?=
 =?utf-8?B?aWJqbWVNdmdlb2ZMWFZGZlNEdUpkTU5OMW44azJMeUg5OXNocGxhM1J4ZFRl?=
 =?utf-8?B?ZlJkOTFQK1NqY0ZpbUxHelYxa3Q0U3dkM213YWtiTTZDME5ZMm0vOWNTY1JQ?=
 =?utf-8?B?S096R1lqb3dqK1dKUnBlT0VpN1dpTG5XYklwSkJWbDU5bE1oc3V3NWJqc1dz?=
 =?utf-8?B?dzA1VmJNQ0dmamQ4NDU4NFJhMVpUZVRSN0M4UmpQQlFURjVGb25vaHd0akJ5?=
 =?utf-8?B?Q0htVk9TaDRBREQ3enJ4NVhNN2k1alpGZ2VreUdNVjgrT0dnams4d2F4NnRU?=
 =?utf-8?B?Q0lDV3BibmNURGNobEdSR1g1UDN6ZXNhZTNldUpUUDhCSHhiSnA0N29Memoz?=
 =?utf-8?B?WUZCaExPa2cvZXdMRC9OYllPQWE3UHhZTkNRb0w5eVltWGFJTEhFZ0hEbTNE?=
 =?utf-8?B?L3BPSzM3VnNMbE9ndlpheUpkVWkwZCtIOTdMMjdEUENaRERUMTkraS9KZCt1?=
 =?utf-8?B?dURxbmF3NVdYVE1IaVZIcWZ1WkZhUGRTejNsMjRTcG5FMHlqaWIwSUZ3ajJ5?=
 =?utf-8?B?WWUvcXJoMEQ0T1pGcGgwRHRBZm9tbDJ2OFlxOXRhM1Q4eldpWFBQTGZTUU9K?=
 =?utf-8?B?bThpb05jUE9Qc3E4UXlSaUhWQ1B6a2c0VWFPNTh3N3lnQy9ZZ05TZnBJZ2pa?=
 =?utf-8?B?TlpuMWdFZDBqeC9MYkRwejhwdlJyWHFmcldXL1BibEcySSt5ajRuVUxZbUFj?=
 =?utf-8?B?dG5COXpmL3JzTXBFUnJZcmhVTTlHVEE1ZTFXbUd0MTJVTElxWFJxWDlvZUtN?=
 =?utf-8?B?dzdCcExReU1pTXpkdUF2b3ZmdzVwc2lZckoyUENkanRmTndKdU12dVhneWZR?=
 =?utf-8?B?emJEbU5CT29Vb2RmNUdCd1BDeWFhUkh3ZTFtM01YRTN5NHlrdXdRUWcxMmRi?=
 =?utf-8?B?NVNac0hMM0NkSG5ieGJWVmtVOVZaTzZNR2o0UHQ5enBzdGdqRTZEbTVIc3ps?=
 =?utf-8?B?cDMycnFPYXJURzJIand4bXZUVEYvbmtrbkNVMlhNQklEMG1MNE1SSytMSjBF?=
 =?utf-8?B?UTFKREgzU3kreWJrQ011bE9maFd3dW1IZW1ZdmNBYnFHVUMvQTVYeHV5YVFK?=
 =?utf-8?B?T0ZYUUcyN3VkT0R0SEl2Y2l3MFZRWm83eE54SloySExWa08wWVRENjBKWFFS?=
 =?utf-8?B?S1lGOWpEMTJsOU9hczZ5OVVRMzZrUi9VN3JHV1pwZk94cDRkeThHS0JvbHgv?=
 =?utf-8?B?Wml4Qmc4dzExb2xNK1NvbVQ2QXJDMEdKOFQ5UlUwZ2xabWNTRTRWVFBXemJk?=
 =?utf-8?B?UG9jbzNTVG5ZTjZLbC8zZENqekxhVnNjcHp4N2ttYTBaaUc0VUdUWkY1N1Vi?=
 =?utf-8?B?T1Q4b3BVY0JFa3B4aHRuOG9oSE0yMDF1YTRnK09YNlllYUpQblAvRE9tbzJy?=
 =?utf-8?B?a1l3Ym5WWVVsbG5SOWFseHErTE9Ud25tMDRoRk5pRnhQcmEyTXJ4cTBXOXFm?=
 =?utf-8?B?WW1qVy92U1Q2Ny91TU1IWE8zQ3pmcEgxLzRiZno1QVExSGdJWWppVFlYL0gr?=
 =?utf-8?B?U2h4ZDF5U2J5ckVpTmZaRGlaSlJ4K3lvd1RPY0FkK3k5Sk1xTUFYdmRuOE9w?=
 =?utf-8?B?MThrMHZjVU1KWEZJRUg3K0RqS1QzRUdmdzBLMDN3YnRDdTNpV2E2dlcwcnFy?=
 =?utf-8?B?a2c4OWx0Yms1VGdYYnF5dXNLTDUrQ0EyM1BOOFR3RlVhSDBMMytwaU9GYm9M?=
 =?utf-8?B?dEJhV0ttWDRkMnlOVkxtMkx0K1NxVlRVbEpLMVNwa0RabHVsRW9XUUNsRjVS?=
 =?utf-8?B?QUJyL0FLaTdrOGl3ZmxaYnVMRUhSdGJGSlJkS1g4TkkvSUZGaE5Ob24vWEFk?=
 =?utf-8?B?WDFmb2c5MUtZZk0rZWV0eGwwM1pnaGdpdTRMZ09sa0hVbUdRckp0VW1WTnFI?=
 =?utf-8?B?UHowUXJJYVdEcUxIV1RDbU5qMHU3bkpIb0V6V2tGU01hVVZuK2tZQVdTU2di?=
 =?utf-8?B?cVpYT2tIcDNxV1IwR2FITkUvQk95dVNGV25KZnFRT0svOFhQeWJLWnR0VS9j?=
 =?utf-8?B?RzZlZnBCRFJLeThsSDNDMFJ3OFJKczhKci9ITUV2K0ZsUnhzWURSS3dKeEsy?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 592efdff-e558-4ea4-e159-08dd7e8027fb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:51:44.9962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FL0aGyMW7GHBBvdJuU4sPasHQ/2u+5GqXYH64bqflXG6u6u5T55Cc1MUQXWmdiOfwdpHrMtZuNL1xS7ZmJlGOjNiXJFnxORAInOjkQB5Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

Hi Maks(?)

On 4/18/25 10:19 AM, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

This seems to differ from the sender. Are you Maks? If not, you need to 
add your Signed-off-by to fulfill the DCO requirements.

> ---
>   scripts/kconfig/menu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 5c5c1374..a0d0d2af 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -812,8 +812,10 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
>   			}
>   		}
>   	}
> -	for_all_prompts(sym, prop)
> -		get_prompt_str(r, prop, head);
> +	if (sym) {
> +		for_all_prompts(sym, prop)
> +			get_prompt_str(r, prop, head);
> +	}
>   
>   	prop = get_symbol_prop(sym);

This one too can do a null-deref.

And same for some other functions after as well.

Wondering if we shouldn't update the macros to not enter the for loops 
if sym is NULL? So we don't have to patch every caller?

Cheers,
Quentin
