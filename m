Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3204BC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 17:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76A38860D;
	Sat, 13 Jul 2024 19:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="M6cyRH+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2A4887D3; Sat, 13 Jul 2024 18:32:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC7A8853E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 18:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsfnzTESiLkexsqLOVDQnSCdhGVF2zGpyrGx/bW2NkIbwJMRL2X4IBeTQY2SDmqdb/ptNbPggdgg6RnexoUwtH71Dvx/HitobuGfk/dZ6hAgciARcsOAKmOXWhrMGzhjCAlTlw55qaZpZ24xeyD5R0M8qTH04Xed7W5xooVY/6Jnsb54/OGSCelfn73kf1jHWaz/PTKFt5dRF4DlcYkW2qjOLHHd7SMt8fI1Zw7xEVZ0+F0HvBmXPG53oJiP+5CFD5AEqqv4YY0BjRvnz/vvMzeeroxJXRNmdePVBkFQn5u0yMHHb2DdEwNgZbwu5PTL20zu/OeLczbtX9RuZ9K3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aN/eMLu8jJQ5h7oJgSLGpvNdmmcY2IbUXGR5zXbqFQ=;
 b=VFFUfwjy3yGoaNqHW65Y41Fe6ShC/39KFmR3iE50Vb33PkZFrOJHWNp6HiAmNw+282yhl0Aq4QGKXfajBLXZucdqWPK9jNCfQssH/I6HDe72niyrWmcWJJsYFQLHl3NStKeRTHoPwIyNS6QbHheIxUURfL8ShXMFkG9fv0Wjv3oLANElmvMg38fzOH9M0RECWu69EL4+4SsruYI4ZNpvIple7iq2hFhGHHcdj/2PETS4BgERq2nfCurD9vdf0V9wjSkFmndTGAAAKsFTdKL9tl54EGrXk+qpUlLg9i12HqmADeP7rCeQXgIUxmIZX181qJWX809xjCguYxO0hj/DmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aN/eMLu8jJQ5h7oJgSLGpvNdmmcY2IbUXGR5zXbqFQ=;
 b=M6cyRH+9lYsG8+kKI3GiJLrYw+yMQRrEZwDKQzPdlhzWfDAcYihGvVU2J5YKd4Msh5illIABeIYBPmuTkEMtFdSW+Yukhh83EHVCWls/TKlM22Qmy6sDFc1PgreLYrIJLV2rJ0XJm+ERN1HvLL2IFI9XPCsy6ub4i2GXh7nDPGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8683.eurprd08.prod.outlook.com (2603:10a6:20b:563::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sat, 13 Jul
 2024 16:32:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 16:32:22 +0000
Message-ID: <654fbb9b-dcea-4c07-85a1-47e48d3057d0@genexis.eu>
Date: Sat, 13 Jul 2024 19:32:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] led: Add dts property to specify blinking of the
 led
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThBPaojbFHZf_OpJz=Ub+ikcMZeoa11GeJ422HNPa-s9A@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszThBPaojbFHZf_OpJz=Ub+ikcMZeoa11GeJ422HNPa-s9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de87753-4060-4374-052a-08dca3595f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjVLQlA5MlpvbXFmQ1J5UFEvNFByMDdNUmphL0pXQWhGMzQyWXIvZjRCN3hR?=
 =?utf-8?B?VCt1WFJ0S212TXJYaG8yOWExZFlZNW8zYWpOeUs1VFJJUUxGYjhYRjdLQ05M?=
 =?utf-8?B?MHJyTVBtb2swc2JpbDdQb1oyeE9Nd05PaE5xQ1hUYkhyUjN5MC9iTXZzVzhF?=
 =?utf-8?B?QVZUWVFkUHgyd2YraG5MNExZWDE3bE1Od3FxbUUvN3pwc2hjdVJCMzlya0lv?=
 =?utf-8?B?M2E2Mjl6SUtlNnJUZ2FZWDhEUVVFNTdFZjVDeUFSenoyeHJQbVIwZXBRQmcy?=
 =?utf-8?B?U1dIWEZPUjZ3Zi93YXl5VmlkY1U3UnRhbFpUeURNa2FabFBQU29SRk5Fbjdj?=
 =?utf-8?B?ZUhJT2t4NEhpWnduUExWbzlTVUxTRjVGYVc3dzJZOUZHbXBCbGx4VjJqMHdx?=
 =?utf-8?B?b1QxNEp3a3BvOHJ4QWdBVXpuT1FzOVA5MEppa2xzY2VYQzV6MjBHTXpTNWht?=
 =?utf-8?B?SnZjTGFPNlE2TTZBSXE0V0dPYktLbENSMXJVSGZBTUdSV1FHQ20vZnFneW1P?=
 =?utf-8?B?cDF4UTdMS1RLd1JRd1hnSWNpbVc0TmZvSXBjOWhRKzFMZEEzZk4xeG11a3BT?=
 =?utf-8?B?NFJpcXNDQ1l4U3FOMUQ1NDF3YVkzVVMxZ1o3NVJhdWg3ZlYrSWVvYWV1WDBz?=
 =?utf-8?B?dkhVRG9DdUMzWWEvUVlpRHltQTRYV2IyQnA1R25CYWpvZkVnczRvZTg1SkY1?=
 =?utf-8?B?emdZSkJnMTkyUlM5L01PdWxPcDlybzBHVUxuNVJmcSs5clJuM2hvUlhaa1Zs?=
 =?utf-8?B?R2hSbURVaDVOTFgwbHVXenFjYUxCZGVxK1Uzc3RQNm8zTThQU3pjU2d5dGdx?=
 =?utf-8?B?WW5UVlhnU05uZnlxNmN4cGdOU0R1Vk8zVkFBdFBnQmZ1WUNRZ1dreFV0OEN0?=
 =?utf-8?B?c3VXQVJPZVQ4dktQWEhQWm5EeVVRSk5wWXR0aXMvdUtleGFKbmd3VWo0NE1i?=
 =?utf-8?B?MVhMbDZqVnYzN2IvaW5UdHcwMy9yZjNJbnFETVBMVWJTVHdSY0FSWkIwMTlv?=
 =?utf-8?B?bmZxM2RlUndhOENzL0haVE1FdFFpZzlXK3FqcjZ4NmVPYm1lbE5oRTExU2lz?=
 =?utf-8?B?NVA2SWpQelB6NCszUmZlT2VJVXhBRHozdENnQlpsVmg0R2Z1K2cyTlpQbm5D?=
 =?utf-8?B?Uk5SZ1E5UnRZSnAzak91STU2MFhoMTBTVGI0RTVEM2t2QldDdDBKalNjenQ3?=
 =?utf-8?B?czdFamdLVzVmRUVvUk0wck9BVHhqMy9uY2JHY01BbGozL2tlM1NsSUFHbmw4?=
 =?utf-8?B?bHQwL0dWc1gzRmZ6OVZxZFRaS1N4MysvMGZLT2YrQzROS3pRb2RuTy9aL1hO?=
 =?utf-8?B?SmgzVWJaaFUwVUlWcjk0M0RoVmZHV2tvTm84SFRBdm9hbGk0T2pLOXpzQU80?=
 =?utf-8?B?T09yaTc1WVphWVA0d0prT2dxSXhiNmRUVFBteEJva0VoSzllRUg1UDIzOUph?=
 =?utf-8?B?d29GVUMvSUpkYXI5ZHRHWWg2YnJnSS8zMUVvUmlYNkFVV2wzeVhxd3EvMUFl?=
 =?utf-8?B?NnJ1WlRsZmJOMTdqZC9hVndubG42K3FReFJrU3FvZ2VMWTVvazMyeWFvZzYx?=
 =?utf-8?B?Zi9PMjBXMnJUUW1Gbk1yRHAvYmtRVUZiZXFQSERZNHFrSTRTUUp4c0xoVUNX?=
 =?utf-8?B?ekxxRVR0UzBLY0IrZDliTnRhSVo5ZGY1R1ZSYnE1b1MxaW5iU1QrT0ZjVlJF?=
 =?utf-8?B?VmNZcHBtZmY1NXJPQXUvY1Btdis3VXZLOTAzOURURmFqN21kdFR4TXVXQ3Bt?=
 =?utf-8?B?RnRvaVlzZ3YrYTdySHYxLzZ5MVI4YW9lbmwyUzFJRkdqeEcva2tCdStuZ1l3?=
 =?utf-8?B?ZDJ3ek5aa0FoWFNzelMzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3d0SnhzZngwZUNheERwbmdkTDFCTENlTUs1RGxPbmtQV2VDTVcvRzN5SVRa?=
 =?utf-8?B?R2I5RWRVMFphamtNK0ptOStTQXNKQVZHTlV6eWhGdFZRdFVEL0NQcGhCeldU?=
 =?utf-8?B?cHJDTkQwMFVhUHRyam9IZWVBZ1JxYmNmYWJoNVFYSzV6dUhIVHNrRmM1YXgx?=
 =?utf-8?B?TlY2MnZmaDNXUTNRendGaVA1ZERSTW4xVVpmT0hZNzUyT00zdW5YdjlrRU1K?=
 =?utf-8?B?SXZiQVZ1TUZGeUVWeVMxTVZXcDg4UHdJNDVUckR6bzBleU5zenZXdUlrbWdK?=
 =?utf-8?B?anNoeXM5WVJRNGlSS3hWU3Y4eUhpWkFuaXRON1hYSlltNm1Rem80eXhTckZj?=
 =?utf-8?B?N1hWUTVkYWNEcHIwNGFtNkZkNFA0WlRMWnY0dzZoVlNXeTRBbFJnT1FGYkNI?=
 =?utf-8?B?VjJhdk5hNlVkL0E2d0I5akpZckg4bEFvU2o0bzhscnE4NmY5ckh6OERpTzN5?=
 =?utf-8?B?eFZ0NzFodmFoSnNtSWM4bTd0UWVqVHhVanQ4Z0lsakxoZVo5QmlhYk9KRkI1?=
 =?utf-8?B?T0pJakNPQmZJaW4zeFVrZUE3emNaNksyRGo2Wm5lR29SNUpZdDVPYlV1M2hZ?=
 =?utf-8?B?TnBNWFhuSldWMEdPZjhqcmlSMlBrb09aU2R0ZHVsODAyUFY5WUpVYVE4bVpy?=
 =?utf-8?B?UU5NQ084S3Z0TkhEbHBObnR4dkxvMGNrUmRQbjB4czNhaXpOQmZJVGVOcXpU?=
 =?utf-8?B?bTVPNUhBRWNWTlYwdEo0aWxlc0RZSWFUZ1VpbjBQTDliYmZCWWhPNzVBa1pI?=
 =?utf-8?B?RDdJbEY3emNqYnlRaTZkUnhzSWMrT0xrMURzc25GMEZ5U2dWczdGQklldC9I?=
 =?utf-8?B?UytibjhYcG8wN1BxaExPYUlmanVORVB2amorNHBlTk1lNTFwcUY3UkxDd011?=
 =?utf-8?B?QnBMcEdZV1JSbE96T28rM1R5ald2d2Ezb0pIQ1g5N2xDdUo3anhHaTN1R3U3?=
 =?utf-8?B?K1F1TG9XTGJmbGVnNDBmaTZXNk90dEhPRmY2UUtvMTBWdndoV3NzSmc0R3RP?=
 =?utf-8?B?dzlwTTBvUy9EZ2I1RysvWDdUVHc0VDJzNWt1MTdnZEFucXhVd0hUQ3pqaDhX?=
 =?utf-8?B?WlQraDV6K0pWV2lPK29Lb1R4cVRwUVViYVduclNUc2ZubTR5Sy9SWXFaZlJT?=
 =?utf-8?B?WGVWMnhzVWFhbWZ2USs0Z1Z2MVNHYWpjek5nWE1HUjFpazI3VTRvOTNzTGJo?=
 =?utf-8?B?UjRHOHV0R0ZaZndKbDhZSnBJMDlYUUc0a2hFcUlKZDYxejY3L2gwMDgxem9u?=
 =?utf-8?B?QzVtWFBxQ2RBaFYzNFJxUk1OejhiR0tUa1gzejdqWFY3ZGIxNWtRUXhLU3Ev?=
 =?utf-8?B?bDVUQm1CK216cU1PUkc3SndPKzVJeTU5VzgxZWVWRzNxMm9PSitTN0ZCRHYv?=
 =?utf-8?B?c1pQckRvUVZQNzBzNmJ2ZzlqcHVtZlJ3WWdhNVVPbDJkOEVXZllyOXQ3ZDNk?=
 =?utf-8?B?bFZQZTYyY3hRdElqK0dPbmdEMEZLRnZUZWhxUkZJRSsxZ2F5SHBSME9jVmlT?=
 =?utf-8?B?clgrV0RTb1lYVUhaM2xQRE8xTk5DWmZsK2M2Z2JRRXJNMENHUzBzYTM5Sldh?=
 =?utf-8?B?MDhWTWFiZXU5VFozaG9NcWF0TkxRV0RIUkZ4Q1dGNUZUQzJXb2xubzJ3MDIr?=
 =?utf-8?B?ZUJSQUZlTHp2UndmeGNWZ2QrYm9TVFhaYTU3c3plb0YvWXFsN0xEWXZTU2Fu?=
 =?utf-8?B?eHVtNmJtZDZnZGRxVld1akxodysyTVNtTWhXTTYxN040Q256R05jU0p3ank0?=
 =?utf-8?B?RGRBS0Eyb2EwWGFsTWRSNEFnd0I2K3hSTDRiQmM1cnYrOEdiMkppWDBuZUlp?=
 =?utf-8?B?MjIrejJLVThTTCt1U0wzQ1RCbnZwZXIreEhLQ1cyUDhITzNLbjhRaWlPamh2?=
 =?utf-8?B?eFJxUktoTHVWKy9pL2JLUDRHWjZmVEpSMlNFVTVxSjZGVjJ3NmFGWUUzbHRl?=
 =?utf-8?B?aUpsV1ZuSU9iOVQvQmoyOUFPdjYycGh6YkN5d0Yxb3ovR3hQNjBJMm5PWUdy?=
 =?utf-8?B?MHQ5MEZ0UTE4RWRKU3M5d1ZvSjhINXJ2cnUrSEoramlsTzJURFJZSGxydmNp?=
 =?utf-8?B?WnBjam1lY2NoRFJ5VGtPbm0raEhUZVViSW1jWkNqRnN1MU1zc2RSRUxVaGpX?=
 =?utf-8?B?ditJQ0NUTGt4Q0NvcjlCQ21Wa2dwTkcrZkxzTnlGcEVIQ0o4MGw2YmRzM1lN?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de87753-4060-4374-052a-08dca3595f3f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 16:32:22.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFU/rG3sprsUY6nX1bG+JYB3gssnOTxuwnciXoWFXPQHO0FtE8XWohWgMpk2ZDB5y2zTIKp1SNJfLh0plo94t2S4pDOAour3jcRcFMQJWNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8683
X-Mailman-Approved-At: Sat, 13 Jul 2024 19:13:06 +0200
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


On 13.07.2024 18:13, Simon Glass wrote:
> Hi Mikhail,
>
> On Fri, 12 Jul 2024 at 06:25, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>
>> The standard property
>>
>>     linux,default-trigger = "pattern";
>>
>> used to get an effect. No blinking parameters can be set yet.
>>
>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/led/led-uclass.c | 33 +++++++++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index 4f5dd66765e..90047ad35ba 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -100,6 +100,9 @@ static int led_post_bind(struct udevice *dev)
>>  {
>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>         const char *default_state;
>> +#ifdef CONFIG_LED_BLINK
>> +       const char *trigger;
>> +#endif
>>
>>         if (!uc_plat->label)
>>                 uc_plat->label = dev_read_string(dev, "label");
>> @@ -120,6 +123,12 @@ static int led_post_bind(struct udevice *dev)
>>         else
>>                 return 0;
>>
>> +#ifdef CONFIG_LED_BLINK
>> +       trigger = dev_read_string(dev, "linux,default-trigger");
>> +       if (trigger && !strncmp(trigger, "pattern", 7))
>> +               uc_plat->default_state = LEDST_BLINK;
>> +#endif
> I still wonder whether you can use IS_ENABLED() instead of adding #ifdefs?

LEDST_BLINK depends on CONFIG_LED_BLINK, so the code will not compile if CONFIG_LED_BLINK is not defined.
Defining a LEDST_BLINK unconditionally will produce an issue with cmd/led.c

>> +
>>         /*
>>          * In case the LED has default-state DT property, trigger
>>          * probe() to configure its default state during startup.
>> @@ -132,12 +141,28 @@ static int led_post_bind(struct udevice *dev)
>>  static int led_post_probe(struct udevice *dev)
>>  {
>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>> +       int rc = 0;
>>
>> -       if (uc_plat->default_state == LEDST_ON ||
>> -           uc_plat->default_state == LEDST_OFF)
>> -               led_set_state(dev, uc_plat->default_state);
>> +       switch (uc_plat->default_state) {
>> +       case LEDST_ON:
>> +       case LEDST_OFF:
>> +               rc = led_set_state(dev, uc_plat->default_state);
>> +               break;
>> +#ifdef CONFIG_LED_BLINK
>> +       case LEDST_BLINK: {
>> +               const int default_period_ms = 1000;
>>
>> -       return 0;
>> +               rc = led_set_period(dev, default_period_ms);
>> +               if (rc == 0)
>> +                       rc = led_set_state(dev, uc_plat->default_state);
>> +               break;
>> +       }
>> +#endif
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return rc;
>>  }
>>
>>  UCLASS_DRIVER(led) = {
>> --
>> 2.39.2
>>
> Regards,
> Simon
