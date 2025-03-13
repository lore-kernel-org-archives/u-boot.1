Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51681C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 10:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDA8810F4;
	Thu, 13 Mar 2025 11:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="j462g+oA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78830810F4; Thu, 13 Mar 2025 11:10:36 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3A980756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6HjFNvgYdFywvGQUR7krjZJ3IdURiXhYxtWhVFQZhnWavNpSrGea9CTC3T8Cj4lL45s2IEqfCbTvLYB612lWUXPopRfy43OA8IE0RQEF2pGbzX+Ytm1A9pUB98Fjd5ce6ozSAJCRrpyTb0n/8npmULf9Ay+dXyH+N1aoRtdqDWSAd6xmqSnWMXxRo5WBqit/6HWKrpVS+zwk2UpSjErgXfumR7O68JhYYj43QrCKvhoZ5C9y5HhGzHoeZMWcDer/ufuUYWo1yHcfNjfFo97b4waiX307FPyiQ/+djluBox33sbRFUTd6ySr/5Jmm4wCiHVkdzNe8ejsBBQJ7RlVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai5u5sXZZ6kRYMyk9Xu45r6Q+fLojuXirEK8GobLM7I=;
 b=N4I/x1aiQPkTH7W+PGY+QvskUW3LGdWh2qO1aRWlP4o4Rw0ABhrF/zdDC5iDpq3ly7vJlEa/bvO/HcBFNfVzHvE6pLUokJ/q0RGeUDO1xxGaXx2TceoUH2BwmcwsaAd+hg7dyFD67/68+2FWpc6ZZhDtA4N03uWxRdMNOyvuUjZdycXk1csUOl2M37kfHYFuVm6wI1rgFHC+hg7qFVsxbQQ31Jdj+vQOjHRYqtU7jmWmUlpOtFYfLM4aqtVzaaM1Tdtlsjh/rV6Ef9KPqDcdfeOol18Ato1+klakeN1A0dxhEV4T8qNFq5iUkf3cX3keh8DdcINct4EIcRjWXf1rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai5u5sXZZ6kRYMyk9Xu45r6Q+fLojuXirEK8GobLM7I=;
 b=j462g+oAdhvm1LbK5pitN1sOa2G7r1lCAMwnUt0b/gqmShG2UWxHS2qy81RXhvPLlmuDW0a1ytiJk2M15XQ2o7jiwacJigV5SKb6jtlr400L6fhoK56mw/LxqNZuzeagNz2ULz88vE9mqv7bQnT0FMCYImPECp9DFl+lb5Fx8V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 10:10:29 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:10:29 +0000
Message-ID: <82d9ca8e-14e9-45a0-ba09-9101d6264585@cherry.de>
Date: Thu, 13 Mar 2025 11:10:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Kbuild: Always use $(PHASE_)
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250312010021.1671010-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250312010021.1671010-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa93a78-58a7-47c6-8498-08dd6217484c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVQU2dGYTRzNkJTb2c5akhUYm9adkNUQ0xka0x2STd4QWZCMVN1K1lGWGJn?=
 =?utf-8?B?MVk1NjUwekVBRlZBbHhOeEY5dDNOYXV4SHRYMG9uUzVDcUxvRGczSXE4NlY0?=
 =?utf-8?B?VG9IM0Rvb2ZKenl2NmtIVDZaZkM4M2J1dUF2NVZhZUZzOGtoOThqek0wS2oz?=
 =?utf-8?B?L0hqTDAvSzR0N2hVSUd3c2NPejBhWU1YSzMydTBZd1FyNHY2N21aZ2g4Sk9j?=
 =?utf-8?B?L01TUnB2TGJFTVdUZEZYRTFsb090dGlyb2xESHl2b0JKSGU2VDFEZU02VkNk?=
 =?utf-8?B?cVJOTnBPSUlMUWVENStjWlpXMjBUQmE5cS9NcDM4TFdOWU9JWGVZZ2R5eHc0?=
 =?utf-8?B?S0ZIWkdTNDFZcXhYMjZMeU5RNlZEVDZObS9VTjBzbUFHSklIUm1zaGdNNkty?=
 =?utf-8?B?Snk2U1FWT2FQZkhMSjZyQ2VXZFhuSlhrZ1J5VjZCbUtBdElFcGxsNXdsTXVa?=
 =?utf-8?B?SnEwZkUyYU02Q0Q4cXM3bE4waVJpaEhkVFhOdXVrenF6djZTYklhUU5UY0hN?=
 =?utf-8?B?WGtoMGdkd2tGVHRHajVXZmMyb0QvckF4b0NMZjRFdUJ1SnhrMStpNUVhVmIy?=
 =?utf-8?B?eEdEeC9GbXJjZC9jT1dPeVJkZ1c3QTk3bzQycVVJNzRDUHRRTGZ3UGxmYnk1?=
 =?utf-8?B?QXYzK0VBRmlrWUxpZCtTYkM4S1ZTZVhCWXdHdHNQVWdoVk1uWGxtTFpKbnVV?=
 =?utf-8?B?NUhhQW13Y1h2RXJ3clU4bHV3bUM3bVBUOTlDaWorbFdIVWlNNnZKQTZNeGF0?=
 =?utf-8?B?Sy81UktFOHZ0alowMFNuVGxpLzZQbEp2OFp6eHBlZGZCb3h0YUdIU01TOEFs?=
 =?utf-8?B?M3FTUDVEOXRRZmZ2eTRueVhUSENEclNpVURqRWtaMEFNc1FBSVlTTTA2bXRj?=
 =?utf-8?B?R2ZhRnNqSjA5K1N6TGp4eGR6RXZlWnNjZzRHNEhSVUtYc3ZqRkdiWER2WG1y?=
 =?utf-8?B?WlczMWFVb21pcll0eVdjNmJldTVCaGN0YmRYSmhVWkN5NHBxQ1BCTWM4cE9m?=
 =?utf-8?B?RVBDeXZtakI0MkhmWWx0NmlSSmNadC9CUmtWakkwMnZoUWNBOU92ZjV3SEhy?=
 =?utf-8?B?djBBZXBXM1I4U3orTzRGRy83NkRoU3J6R1NiZXQ0aGxoVnF1Q09jd3krN2gy?=
 =?utf-8?B?Mm1Qemo3S2UrK3ZGdFp2RmZKQVJiam1na1dLOHU1OFpPZlNvUm5XYUVVbHll?=
 =?utf-8?B?SW0rOXhGUGVueWNRanQvR2tidmFhWnRHUzRFMkQrbDI0QkVNbWR5ODZKc1dH?=
 =?utf-8?B?V1RrU2gybUdiM1pxTW9NaXkzYnRlS3FleDBGR3JKSG43QmdPSElFRWt0aDBV?=
 =?utf-8?B?bUQ3WnJsMUp5eTl1L1dDT0srMXN3NEFQQ05PcG02MFFMbVZjM05xS1dtS0p1?=
 =?utf-8?B?bHB2OXRCb1hKdVk3N3VZeTZGeGxHT0VkS3I1T2liVE1vRnlVeHNUQ2plMUVE?=
 =?utf-8?B?NFh6VTJFSTVvNHBKZEhXRm9qSzZoU2RmNGZ4RDVUdmJrQzV2bzdQL0RhcmtL?=
 =?utf-8?B?bVJuYy9rUUF0NWJmZWxGNnp2V1pDdkpGYnBTYitIN2ZzekVHQzdSTjh3ZDB6?=
 =?utf-8?B?aVBSTHBVUHF6VjhDSkVRUm14aHlFRFdPQlFsSHZHWmg0SGpVL29vYXdMYk1i?=
 =?utf-8?B?WGo3QUx3RlJGT1g2cHVMMG9rcUFGY0JTakFPUEExbUw0NFYzYkVmdEpwWXEr?=
 =?utf-8?B?aHVSa1VjWDFYaTRSYzJqbm92ZUc1NktGM1pDeXgxa20zWTVuL0ZYWndJWXI3?=
 =?utf-8?B?eG9OdTF1cEcrWFB3aXZzeFJWckFYRXZuMC9oU0l2ZEZYQjM3V1A5b0J0ZzNS?=
 =?utf-8?B?WUhmRUxRelp2YVZQZXAxa1JTSDl3TlN2bXlnWUZtWEQ5N0Y2SjJOS2dwRjNH?=
 =?utf-8?Q?uBgtJm2P3QfTA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU5zM0w0M1JHQ2Ntd096QjlJc1NMcGREWWp2TFNoRGwxeHZ4aEt2UU9XRUox?=
 =?utf-8?B?bHR1eFdpK3Z5NlQrMVcvdlJjNzQvV25wTHVzZ0QyaXM1R0JaZGVScG5GTFJq?=
 =?utf-8?B?Ykd6OEw3NlFZQk9QUmdCU2tUeTRKcnNoR2JPNWVENDVpcE54ekFRRGlNQlJK?=
 =?utf-8?B?eXF5RTFybnVvWlU4VVFiZ1lybURySURWNEg5VVQwLzlxK0p5cm9SbkYvdTRj?=
 =?utf-8?B?K283MXZpOHhablEyT0tHNXk2U3ROVk40blcyVWo1UG11eE1rV1JpeHhvdWtU?=
 =?utf-8?B?VWE1TSt6d3VuekgvVzFLb3dQdkQ1ZHpRTi9XcnFJOW9qZkpSNmlZVzVXMmJp?=
 =?utf-8?B?cXVQNmxmWmhjRi9yTUNoRGtDblJ2US9NUENicjQzOVI1bHd1WFA0dk0vNXZO?=
 =?utf-8?B?N1FOaTJmVjVlT2FXUVpEY1BqbjNmSVNTK3VUcVVFTEJObjkwSzJYWmJmMXda?=
 =?utf-8?B?cDh4aEVHZm1KY1J5TUMzVEJpNnhFZGpuUWN6NEpQVWMvaDdXSGZveDdyTTZh?=
 =?utf-8?B?czhEdnFyczRUVnIwT3lmUmpzemdzK0FwUHRrdUdIQ2k5WUliSms5M3JwblV0?=
 =?utf-8?B?VkJSaFppYWpZNzl4Nnd4amlMZ0hnQVJFMEMycXo2Rm5JSVdWNmF2TG43cFU1?=
 =?utf-8?B?WG50YXVuelBrWk5KRXRhZ29CZHBickxBeXJsVDdUMm4vYUoyaVpSSitjRW04?=
 =?utf-8?B?U01yTHc5aE5JaGpPS3QwZHBJUGZBTUtlSXpXREpldmxCd3lrSTEvV0Rnb2gz?=
 =?utf-8?B?SnJPamdhQ1NzcmhOSk1wQmE1ZUova29UZThMbnJYMlhUWXRPWmtTRzFvd1hJ?=
 =?utf-8?B?VmJrcHphZnpQY0dxNDE2Z2dSYmo0OTBVMTBoN3F0MitpRGhGS3JpeVZ0aGxJ?=
 =?utf-8?B?MVlNVCt6NDQ1R2dUZG0yRDlTL2E2N1RVbncreE5EcjlDSEZoTVNjWmNweWNw?=
 =?utf-8?B?S0ZhOWtUcGlRY3JDcmxQTUcvakZXWnBQNHQzblZHVGFhSE1KL01RZkZSTWVR?=
 =?utf-8?B?cUxFUmk0Q3NPMWdtVVpNRkhtUThrL0k1Y25kKzNUaGtkOWxIZTF4SUs5a2dx?=
 =?utf-8?B?aVNhc21TYVk3aS94WGJhYnRBZlZ4VVFmcHd5cG1mUnFJcVpZKzZyUzFMTU9C?=
 =?utf-8?B?NngvOGwyL2MxYkt2NFk2dGM5eGhxNWJlQVQxZXFqYU4wejBETDM2Ui9ubzFm?=
 =?utf-8?B?NmZuUWNrZnkxak95NWpCVmU5Z28xcWxpMTM4T2xudWlockZlbFZpZmR1azhk?=
 =?utf-8?B?QlZ1N1pwK1BWTG5Hc05ZdEQxSjZPS2hjRDRYS2s3UzEwbW9FV0NiL1NCMWdO?=
 =?utf-8?B?cVBqOTQ0WW1seHdRcG5HclVCVjRIcjVvNWRIL2NlUVBrb3BiQXBick5XNTZ6?=
 =?utf-8?B?cnR5V2FNQXVLSUJqZlBmOGNRanpuUm5HbFY1U3VIZTBKRUhyMnVaNjhBbGZk?=
 =?utf-8?B?RUdNSTBmM0RqWlhPek9VK1JqWXFMZVhXRjc4Zkw3RkNtRS9NWk1vTStyUzBw?=
 =?utf-8?B?OGpkQnYvdGZTc09mVjEraVk3b0dhMnBEeDFSdWQ3Y215VTlIaXhBaytXZWZp?=
 =?utf-8?B?dHA5bklhbjZFUDJtQ3NyZlN6MUVpMGFnTXNkQThyZVpzci9XdnViTHJmd3dp?=
 =?utf-8?B?QmFwSFNMNUVqRFdEN1JzZitLcDBKMWV0NThCc0ZGNzNHMkd4L0Rtci9JOS8r?=
 =?utf-8?B?UlMzVjNhMEtKSFlIcktQR01PNGt2eXptOXllNGtpa0FhQXFCbTEwOUhzdkUr?=
 =?utf-8?B?WUxjd3dXb2F4dDFjTW1OTFFCc3Q5Z21nVmtMbkcyUU1MOElhbUlJeXN3MzZn?=
 =?utf-8?B?Z3ZEOC9sREFlWW84NW9KYkF0QWRzcHBvSnF5Nnpia2gxNy9YUUk4OUpuOXdx?=
 =?utf-8?B?MEVZdHhuTHI4VThkKzExZWprTVhkTXlwSlY5S284Ukx6aTZuaUg4VG1kbnla?=
 =?utf-8?B?VVdES2ROL1VveUlLSi9ja0ZMbTNqNkRBMUtyTTBGM2ExMk95Smp1QzMwZi9J?=
 =?utf-8?B?ektSeThDK1F4QUh5b3dIc1FuN3J0Y0lRbE5GME9GUjZGQVBmb0ZVYlN1ZzAr?=
 =?utf-8?B?TlB2RUdoYjJsNW1ET21pSDF1VHJmc1g0WTd3bThUSjF6TjN6VmhQMmR2L0J0?=
 =?utf-8?B?d3V2RUJSNFBBRnM1LzdBTVBVQU13eDlEeWwvdG93VnduQkFtcTZQL2swdG1Z?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa93a78-58a7-47c6-8498-08dd6217484c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:10:29.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX5tOQQLVKUSKhGLEoKifS/oUta+dvp9TXrqAZxDQD6d8PQFInZS1FFK4FaDBw+SZ7PLZU30w9BWKVSzMLH/2lBe+5uCuiDSMMost8V+JpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
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

Hi Tom,

On 3/12/25 2:00 AM, Tom Rini wrote:
> It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
> Makefiles as part of the macros to determine when to do something in our
> Makefiles based on what phase of the build we are in. For consistency,
> bring this down to a single macro and use "$(PHASE_)" only.
> 

Haven't gone through the whole thing, but caught a typo at the end, see 
below.

I assume you did a simple sed here? Or was it more involved than that?

It doesn't seem like any driver has code guards using $(XPL_) so that 
should limit the number of fallouts if any.

[...]
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index abc49fbe6c93..43f27874f9fe 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -58,20 +58,18 @@ endif
>   
>   export SPL_NAME
>   
> -ifdef CONFIG_XPL_BUILD
> -XPL_ := SPL_
> +ifeq ($(CONFIG_SPL_BUILD),y)
> +PHASE_ := SPL_
> +else
>   ifeq ($(CONFIG_VPL_BUILD),y)
>   PHASE_ := VPL_
>   else
>   ifeq ($(CONFIG_TPL_BUILD),y)
>   PHASE_ := TPL_
>   else
> -PHASE_ := SPL_
> +PHASE_ :=
>   endif
>   endif
> -else
> -XPL_ :=
> -PHASE_ :=
>   endif
>   
>   ifeq ($(obj)$(CONFIG_SUPPORT_SPL),spl)

Should the same be done in scripts/Kbuild.include ?

[...]
> diff --git a/tools/qconfig.py b/tools/qconfig.py
> index 259adbe1bc9e..544254f6e78f 100755
> --- a/tools/qconfig.py
> +++ b/tools/qconfig.py
> @@ -1220,8 +1220,6 @@ def scan_makefiles(fnames):
>   
>       >>> RE_MK_CONFIGS.search('CONFIG_FRED').groups()
>       (None, 'FRED')
> -    >>> RE_MK_CONFIGS.search('CONFIG_$(XPL_)MARY').groups()
> -    ('$(XPL_)', 'MARY')

Can we update RE_MK_CONFIGS re as well to remove \$\(XPL_\) from it? No 
clue if applicable, just stumbled upon it and wondered.

>       >>> RE_MK_CONFIGS.search('CONFIG_$(PHASE_)MARY').groups()
>       ('$(PHASE_)', 'MARY')
>       """
> @@ -1321,7 +1319,7 @@ def do_scan_source(path, do_update):
>               spl_mode (int): If MODE_SPL, look at source code which implies
>                   an xPL_ option, but for which there is none;
>                   for MOD_PROPER, look at source code which implies a Proper
> -                option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
> +                option (i.e. use of CONFIG_IS_ENABLED() or $(PHASE_) or
>                   $(PHASE_) but for which there none;

You can remove one of the "or $(PHASE_)" here.

Cheers,
Quentin
