Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61FC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFAD820E2;
	Tue,  1 Apr 2025 14:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NLGM/685";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF42820F0; Tue,  1 Apr 2025 14:42:06 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140C18209D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdIuEsZlXsPciYiMAFYQx30famV0DV4OxnwtktuqJ7GRhMjJMwV/1ezkjdKwoZE4tUh6OUk/bW9pFXbdxLLt2JKwFzCYXeQHs9X4cSHJ/OcpytfiZnEyBN7sV3qaNb1gdtiFNIi/b6UidDt2v+2xsqIDMtujwKiUji/agHwDkBQCNyOJFUIsnpF4oIvju3Op3Gxg4hEqHRpvpL/SzS5yo0ow/Tc82ervVWvwvZGYc/m0vA4XoGBhAX7tByZ/q+/uonjZkCegqDvEh1AG66Tr6e/URihxGBl2KDXKfrfAX0CktpDP00OxvWohfkOdhGCfJBvdteMucFd/39Ymg8lsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP6NcHj+CV26MOW0vOnjTMF4yr0/8VOjVbaSEmIIOKg=;
 b=I0Vh5a5FTBVFHst96BTiQcsErfTOAM0wJu/L+zl4SK2pz9xpng6Qk76wj3M8LHo8FhpAdqT9v/rnLoMTE/029NuEl30TzOtRfX3VVAD8AwF6b8byNKBdg1IbVDG47KYY/QmuT3G2iPkbjTtADuwGKD/+yR4KKUaznBvVN8KXstfSowR6KjfSzI6n/IJkfQWsHvHyeCV513aRt2nTgsmp+WUOzv5i15CAmzrWk7qzSHNOV6u6l//5hxzEqY+DNMGNtzIjUM8VhNVqd6SUNGYw31QYQrHTqRleV9WuRzAoRN8QhWpBwJYnHijlyc0RpZ05zmOV7o6SCPZ2fEPp+m/+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP6NcHj+CV26MOW0vOnjTMF4yr0/8VOjVbaSEmIIOKg=;
 b=NLGM/685OMwlSkQhtneW+3LAMCYvxT6NP0IRMTatxSu0+eZUcQ3ZLD83Ullx5crHQu/szAL9izH2OFCLjHohjfUJZdeCq5dwtZ1urKog9do2m/6qPb/p1rLRL+D1yJxW+NMDMoUMXoQZe7rDJXWNblIrIQFM2a8qjIY2G+m4D1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 12:42:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.052; Tue, 1 Apr 2025
 12:42:01 +0000
Message-ID: <bcc6c1a8-bbcd-49b3-b3ca-f05805373a4b@cherry.de>
Date: Tue, 1 Apr 2025 14:42:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] doc: build: docker: Fix code highlighting syntax
To: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, upstream@lists.phytec.de
References: <20250401122811.14806-1-l.anderweit@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250401122811.14806-1-l.anderweit@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f4cd72-b378-44bc-5560-08dd711a9936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rmh3UXYyUzBLZitLU1JORUlwcnVVVm9DdDkrQjJ0RG02b0VNZVg0aWFKUnZJ?=
 =?utf-8?B?ZzhkWjlPbWVZbmxvcXoxOTlCdUM4NU1oWlJGaVI2Uy9kdWhldzFCTUZ6S0ph?=
 =?utf-8?B?dFhXNTRrNW9zd1VHL3Q3cFBDSGJEaFlrcGdHQk8xS0lwNDFUM2FwdkxONS95?=
 =?utf-8?B?L3F6LytBdTMzYW94Y2FSTEs3RU05eG9vTXlpQTF3TzFlVUdHM3FmTjNkemZB?=
 =?utf-8?B?dkhFQXNycDFkdlMzVWJBTWxBaWNmRXM5TG91ZDVuL0tQQklncHM0ZGN1VVcz?=
 =?utf-8?B?V2UzYTYxbmNNbFJkME9ocWF6MTh2SUZ3ODhHbVhZTGFKS3dFcm5vUG1mTVdt?=
 =?utf-8?B?Rk1PbDhzaEk4WGh1ZGlQbWI1U1FtWjRSNVlDb3IyaitxOHo3d29OZERLUUtW?=
 =?utf-8?B?NGNYaVJyeEM5Z2tubWpaZk82NW5LMjZFbEFBQ1phaEVCZDJoSFRVVmFGNS81?=
 =?utf-8?B?YTZ6VmYxK00wQ0s5Y1RpQmZIUHJtOWl6dXFiTmxDZlJSY09oU3N5RmVBZ1ox?=
 =?utf-8?B?SHFReHBIQUF3WEJkUXNMNHZPUXlRTzlPVDlMZllkcHNjeGtaU2Z0dWw1L3pW?=
 =?utf-8?B?Uy9OaXA3aEkwVmJXM0ZBcDRja0hBalI1alhQYTRVZG5ZdkVhMVFGaytRSVFK?=
 =?utf-8?B?a3JmK0pqSFBuZlBlNkpwQXE4NmovVU1INVErTU05c0JER1dveTloUjMxTEt5?=
 =?utf-8?B?cTRZRHExTlpLSXlNMzNCNGlvdVNYeGphcnUrR0NtQWNHdEhlWmZOemxFTSt1?=
 =?utf-8?B?cGN1S2hoK3FKelY4VXdpMnRYSDY5dEVtd0NhUGQ3MzVDamJzRXNYM2hOOEx4?=
 =?utf-8?B?YzZhNjdIYVh2d2FPUk9aU3phZ3hjVllLZUJiSHhxOUFxUnVvL05HREFrb0du?=
 =?utf-8?B?UHFKNnJIRnN3UVhzdkl0Tmp2Si9salFES0E1bFdnY2ZZalk2UktsK09WK2pr?=
 =?utf-8?B?RVJGQWgweDIrcGxwZENkVVBhV3RxQ2xJUGc4QkRpZXg3NWN5S2x1VnQwcUhQ?=
 =?utf-8?B?VnNnMk9nOUMyRTlIY2JCK2xiU29FYXA2RTR3c3Z1UitGd2ZXRXdaUTI4UjR1?=
 =?utf-8?B?a29WS2R4R1lMeVMwbUx4WWN5bXdKemltZHgwL21lVHNQZFJwbU41czJtaWUr?=
 =?utf-8?B?MkM4WEtMaHBpNGhwNnRSZDNSM1dGTHhUdWIyUnJSSE83eVJsS0lqZ09pZklD?=
 =?utf-8?B?K1V2RDRVejcyRUJpKzdLRkIyejM5eGVtcGFKaDg2eElnNG93bFA4QzJaT3Fo?=
 =?utf-8?B?aURuZjJwQWJZd3F4ak5ETUVQZjVPWHNmS2ExWUhGOGxMQ1NmckNVRkNTOGZL?=
 =?utf-8?B?cklnNzdLdXQ3VEdndmNVRnc3SFlzN3hyVEtmb0FiN1Qxc2NEdjVLR0l1OTdY?=
 =?utf-8?B?YjBGTUhoVmZoQmVnNmtYTlJ0aC9zOXIwWkhCbUxNcExYek1TbWJkaVdKVUVz?=
 =?utf-8?B?enFjNFI2dFhFYk9HSUhiQjE5SGNhTTljeXY1QzQzM3AzS09vRTBTalR6RWFs?=
 =?utf-8?B?a2RXZWJOTW9VWllMaXZjcjBzV29xb2s1ZnVaTlpiTXFIZ2REaDdkdEdRZTRy?=
 =?utf-8?B?a1R2VXJuNEs1Qzg3T0ljRmJyK3FZYzVKL2o4a3NISTBBTi9wSGRFZjE0K2pZ?=
 =?utf-8?B?bnZSUW9TUjBEY1RPUERQdmNIT2RGMXpnOElnaTF4Ti9WdlNrRS8wOEJkTWl0?=
 =?utf-8?B?ZHJGRkZmTy8wQWJzOUZCRENHZHBvRTBtam9CVzJLQkhoT0Z1Y2ZOdHBUbFly?=
 =?utf-8?B?QkFlQXZxRU95L1VRM0Y1aE5hZ1EzYTcrQ1lzekZWWXRNbGpmNlJEcXdxakJV?=
 =?utf-8?B?OEJpa2hqK29XSWY2UDhrRlhLYXZIUFRZcUJXVzlMRUkvTmhkUzFnLzQ2L2Rq?=
 =?utf-8?Q?OZQ7gJlSxaKzm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNjOWN3YVRGSkM1ZlozY0NVRmoxQWxJQzJqVEU4bGdKbWNaQUlMWUxCNG0w?=
 =?utf-8?B?eUQzMm1lUTR5SzVuS1A2eVAzMlRkRW5DL3dWYk9GZUZQNFRpczBsdHBkdzZ3?=
 =?utf-8?B?Wnp4K1F4QUc4R2dmYWIreVBYODlGZVZVdnhrOEp1MDdiRHlaSnc2dCsxdzNK?=
 =?utf-8?B?OTFEWVRjRlhhMjQ2YUVQRnhUOW1UWjFiWnB2cmNMdHo2bVF0Sm9neGZDTEYz?=
 =?utf-8?B?Vjd6bExsd1dOKzJCZ29aN3FUdUxhNFNHQXIwYXNpMXpyUWtJWFIyVjg3SktZ?=
 =?utf-8?B?VFRBdDN1YmZQYjNuYUpmY3JIOE1kdGZ1bmFkT1d2MFQ5eXptbjEvMEVZVTRu?=
 =?utf-8?B?TE01Tnh0WEgydUN4R01UMlQySUVDbGdoc2ZqZFhTOU9FY0dEeFZXdHJ5NzBU?=
 =?utf-8?B?ZHZRc2xEKzArMm03YVU4UngzWlpSdjU0NlZUSDliUGFGajNTNWlMcUp1UzBV?=
 =?utf-8?B?WlpkaEpiK0ovaWxYT3BBVXpuQldsWUVIdWgxb2NRSjhXYTBBbTF6NFN1bnF4?=
 =?utf-8?B?U05qb1EybmMrK1ozRjZVTjdmK3QvVGtFN0VvMTlnMkZER3JqVXFmRjN3THVa?=
 =?utf-8?B?UFBNV0ZXQmZZUXFKb3h3VWhHYlc2QzZmd3ZaU0FIWU5CS3NCbWVlNHpwaG94?=
 =?utf-8?B?SC8rNkYyb0VNeHNYbGhhTmhTNEh6Q25aN3hXZjEyNjRramtYbllLMVdrQVhK?=
 =?utf-8?B?akdYbTE5VEI4Y3kyeEZKRm5NZG55eEtjRkZyb1FuWUNHYmphQ3kvT3MrTzM1?=
 =?utf-8?B?cnlvN0tBTWlXL0VkL2J5YVpyVHQ2bTR3K1YrUlAxZmhRT0plT0RmOTR6RVY2?=
 =?utf-8?B?bDFSMUtKVzNPUFhrMWtDSUgrME1LbzJPVVlrT1kyMG03UUdYSHJieU1EcFIx?=
 =?utf-8?B?Y0VOVlJ2MjYvWWJ6eVRFb0hJbG1vc1c3dDRxOVZlcGJZL0U4WTV3R2RXU2RM?=
 =?utf-8?B?UEhUZ1JYTzh6bUdwSGJyYnFkaktHMUtVdTVLZm1nYldHTzJYaElWYXh0Vjlz?=
 =?utf-8?B?TzRya3crVm1ISDgyT0Z1cWdlTkRxZ0tZL2dQR29XQU1NdnRqVWM1ckxGZm9B?=
 =?utf-8?B?cmN3UjNURHpqZS85VzEzYUN3OGZ6OVRPVUE1L0RqWUhhSGdxTkJVTXREZ1lE?=
 =?utf-8?B?UTNBQWxOQWx1NUt6U0tvR3c1L0tJSTlpc2xQY1BWWGQ4Q0VwaXR3Y2VPVS8x?=
 =?utf-8?B?eVVHa2RTNkJiNlJBVlFZRGxkeE5yYWRzM3Q2cnN3UXAwZlBLRk9Ia0tOMHMw?=
 =?utf-8?B?Zml0REFhOTdLVmlOYnJOVHRpZXlBS2J6Y212SGt0NE84RWEveGdndndFTVFj?=
 =?utf-8?B?M3Jsd2ltb0VYYUpkMklXQWJubUQ3L2hHZ3AyOHVDZE5zN0pkblErenpOMWUr?=
 =?utf-8?B?RHJnNDNCRnYyTU16TkdEZjMyb2hma3BMTnRrMW9SNzZxS294WnZwSFBQRU0r?=
 =?utf-8?B?Rmp1bi9sYmU4ZVcwd09zcjdXQnRvdXllWHM4RVgrakp4djlxNlR0WnF2cGdv?=
 =?utf-8?B?Qm1yNFFzMFU1c1Q2VjNZVFZuU2FZUnVjSWtyUVBOWkM1bGtTRUlQMVYyb2hT?=
 =?utf-8?B?dTVLUExoU2pJSVJDT2w1L01QR1VzZ2tFazByOVR1RlV2RTZyZVZabXpUb3p2?=
 =?utf-8?B?QjFPY3o3cUVLSTZSalZaeUVhRzIxbmgvV3RPQU0wZ0N1VE1IUDdTWFNVOUtJ?=
 =?utf-8?B?Q1NCZVRSODl0UlBMSW8yczJJaUw2UWFpSTc4QjNjbmFtWkY0ZERiUUticllB?=
 =?utf-8?B?THhTTVNvRkJxVHZEUFBBTTExQmdUbk5ENVBEaEJyQ0JYbS8zMnAyMFBhMmJT?=
 =?utf-8?B?MlpWUlVEQktGRE8wZzFNYUh2anFleWhMU1VVYnB6eUNnN1VYV3g2TnhwdUJY?=
 =?utf-8?B?TTc0RWluZGtLbWpmeVM1WmRDWU10VXc0NVg1RGczbllMcHJMd3NOdlRsS3Yx?=
 =?utf-8?B?TGZsV0k3eTJkY0Y3YXd3dWdOa3NXNnVpV252Wjc2U2VtdGt2eFhNVkN6ekZu?=
 =?utf-8?B?RWg3YUVFOTR0S1V0RCtvMG5mclFXU1JKK1F5VzJ5ZjYwZS85ZmM4VXVLN3Ji?=
 =?utf-8?B?TGluazJxUUNFcmk4bTFUTGliOEJhdUZ4K3ArMWRYSzJEREdjRVZvTDYrcWxy?=
 =?utf-8?B?NmtYbStCTlJIWTJJRlE4Zmd5bXVNV2JWTWlHZHJQS3NmVk5BSzdjZHBzUmNO?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f4cd72-b378-44bc-5560-08dd711a9936
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 12:42:01.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /687Li2aS6zitjTtnJ7Fi6rCc++wtG60cyNR6G86DUzGTvYSXnc+MLDZXK7NLyi95pPYiDiR56NkBCqM14pzsmlO4ewZyAA10uaYKZm6IqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070
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

Hi Leonard,

On 4/1/25 2:28 PM, Leonard Anderweit wrote:
> Remove double :: before .. code-block:: bash to correctly highlight the
> following commands.
> 
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
