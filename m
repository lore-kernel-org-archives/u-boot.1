Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E2BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 12:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56ECC884F4;
	Mon, 10 Jun 2024 14:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="CBL5tLIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937D288516; Mon, 10 Jun 2024 14:46:51 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB334884F4
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hug7+DtYGHkdM8XphpgLeU+KOP4XyLs6wUwJJWZ1inGpFPalZKLTlSBoeFDYJun0o2MkWXMVnZXfUQIUMtJ3kCatOcM80KUQPPRft5GzL4sTEjYRsXWx3ZGyT+srwCoiqV3zExiQB/ZJdb2+T7vJcFq5tPKRH9ENA7PXhdV/EGFLKMF1QXuUGScTsv7YpWPlPlCB3XcUyrpAA1iy8KRYxOaKKI8W7rfbnpO/dGPW412ui5it4VZUperISpNhF36QITdtDVlvBEtLig0FsdDHSMwHsZxDHUMoflGJ/huGDAjdRwh3nj6P/lWlL7gyuhPsinGUlSmVjDYKtym5zJKlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvPuLj/OI4DD5X1qvgxMOwiYopu0R2gR4KXdsPoT7mM=;
 b=fXVcMTTmrRb5VlnRFk05/qBr1UlWn1yFKzlGkY2zWH6uakrPr2DErvxW8/U+20dZ4yABJalmvH3ZLESfAl58kkJ8y4IlJ8mQdlEtDzYTfAaReDL4sP53lw2xKT4oTgIj1Yb7FfHrfPlyPbYvVZDz155lE34eMb/ufvEDnWAmu96soDdF2LZI7hss93gd9Qh4K+fWygDZ5mvO4QkwkOovqvuvPqPrTfqfrNV6a5l5FHCeWxXfmXDN08T5+By39K9piURzbFaqR1BaBzoJNiQIcX9fpmNGp2F9N7pIIyQG+Fqe7mUuyziG4elr7v0lw0zTqIp4+tYP5B/ncJxuX9pusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvPuLj/OI4DD5X1qvgxMOwiYopu0R2gR4KXdsPoT7mM=;
 b=CBL5tLIoLHX3XTAhh1+/3RCjEpcbIqCOlRqy7S7lB9qTs2oZzKEH6082HXmbWNt6uSvhdllRpiKhKNv+DxGburFjDa+3K07f0wI++7h1ZGcYUNAoHXEcJl6MNB1pPt4JRQ43YhBt0ZH40x4VpZbkRu/fPLNkqBn7zrtlWLRxAl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 12:46:47 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 12:46:47 +0000
Message-ID: <934a3406-0c51-4929-b9fd-08ebd469ed54@kontron.de>
Date: Mon, 10 Jun 2024 14:46:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] spinand: bind UBI block
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 kmpark@infradead.org, hs@denx.de, joe.hershberger@ni.com, dunaev@tecon.ru,
 sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240603155740.1840571-1-avromanov@salutedevices.com>
 <20240603155740.1840571-7-avromanov@salutedevices.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240603155740.1840571-7-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: a0883155-43c4-494a-214c-08dc894b63e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|7416005|376005|366007|1800799015|921011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SERtcVB6R0tSWlg2TVlaL20zWWFEMURmTlo4emtTYzZLdXZoUmlWWnBqcDEx?=
 =?utf-8?B?bWc1THRNNy9abi9ZNzAwM0tnd2U0K0wwZ0E5bUluNXJaSFZibW1sTzdwQVUy?=
 =?utf-8?B?WjZZTVUyWlZpVS9vdm9aMHUwc2t3MDRwK0xkdmFRV0IvR1M2OVFwa2Npb0xE?=
 =?utf-8?B?ck9HdGRjaGJOZVZ6a2FWYndHdWl2S3NoVy9CMTI1b0o4N0g2by8vQ0g1TVRt?=
 =?utf-8?B?dlBScmdtMHdibVlYRzlhV3Z3eHE5SkZLUEhhQk9CdEFQSjdTUmRXNXNDWmxu?=
 =?utf-8?B?K3VESi9oSmVMNDRPQmJTaGVVc0dYdm1HNDBFYWdyNElUY2ZBSXhrclNuK3RE?=
 =?utf-8?B?N1hIaXlXaTZQOXNBYkU2NVdMTTg4QWZkTW5mVUo0VE1ITWUvZDc3d0NwM1hr?=
 =?utf-8?B?dlFveXVKZ0F2ZTBuZmEvYmxlNGMxTEFZOVNraHZMeTVuVHZvazhLUWs5NDV6?=
 =?utf-8?B?M01TaUZadzBvK28yQzdCeWFBYkI1NFNuYTFjWUY4UFZGekRBcGtJVU5IOW5R?=
 =?utf-8?B?ZEwwZU9sVU1OT05JSUs2bVJUdFU0WncrbXhta1lJeWd5eVYzRnkwSHM3STVr?=
 =?utf-8?B?eHNXSGpWb3FIL0tjaEhzVTBUODR1NDVaTWlyanhsdXFhcUluejVWOFhXQ3lE?=
 =?utf-8?B?NXo2L0l4ZGg3Y0xtdVBzVDM4NXY3dklieEJYVzhIUHBDdkVMSGpSay9QSEh2?=
 =?utf-8?B?eGswdEs5TjYvWUgyWHVJQUZDT0NlUWthc3Y3bWNJS0s0RzhWYzRIMU9XVXZF?=
 =?utf-8?B?cnZFZjdMSk02TXlaSHNtWktnNUJYVWNoYmJHbzZEaUdWQjQ4aElkTVN5Q3dY?=
 =?utf-8?B?M0F5N2g2NXNYQUdXdXNzMVo1UURHSnRCMVFqT3NVS3gxSVYwN3Q2ZFNYUXNC?=
 =?utf-8?B?a0RHdTlsZEV1RFV0WkNpSndqN2FoZzNhYjdjaVppV29QZTdNeWx0a04yRHR4?=
 =?utf-8?B?Vit2eU95aFJCelpuUnhjYjJ4aVJEODIxWG95VHRqdFpoRUlyRTRBL0JpNS9k?=
 =?utf-8?B?YUVvMDlvSHRkRXpGTW0yUkMyQWtEaGxXVllRZ0NMbjlCZDFBK0ExOU9VeHZF?=
 =?utf-8?B?a3JnZHV3OEh0RW9nTTBKR2FGQ1gvL3I2WFU5UVRPVTBHc0MvdHE5ZTZUL0xq?=
 =?utf-8?B?RHlRRURTWGpTNU9aRzk3WjhOY0pBTlA3YmtvT1JFNUdDelVGdnd4akV6TytT?=
 =?utf-8?B?M2NDZ3JsSDdpOERCODEvQVk3RFY3bWtHcHlDOTNYK0dKUVUxcUJManlsT21v?=
 =?utf-8?B?MzRXVXdQelVpZzBjQy9JUWNEVkhMMFBmVThySmRCeXJTUHFiVHU4NHdJMitL?=
 =?utf-8?B?Z3BJbGYvdDZCa21SMlljdVRiSDMzSmV6TFltMmZTNFJEYzl3WEVycnhHS0gw?=
 =?utf-8?B?eGlVMzdxU2hJV1lRTWt2Q3lXNHR6MWF0YU5FSWN2S1MwL3FNNEhBU28zc2R2?=
 =?utf-8?B?QjduY2VKR21hVG5rMDdGZmh3aDlRbjM5eW13MFptdW81SVhxdEg4NlFGRDJH?=
 =?utf-8?B?VFp4T3pZZnBnaXJYNlpYNGVRb3loaTY0YW5abzNORm1PQ2lrd0Y5ZTlUMHZT?=
 =?utf-8?B?a1dlOHp6MURBWk1vZ1Z3bFlydURnVTM4czNTTGFlY09QbEU0ZWFjUWU3NUFr?=
 =?utf-8?B?UUxaSU50TzNwcHZuZDNTdGhWaGIzbEVEZjUyUzlqRlV4S0tBSm1tbEtPTEhQ?=
 =?utf-8?B?ZG1heEdjV1FKd0k0UHRCNndveVgyMmd0bFEzYy9rSXplMlR4bHZ4MUFRTkZO?=
 =?utf-8?B?UjFpZ1BrSDlkMWt3a3pGUXMvZ1dhaWNhQm9PenRSZHI3NzJHNXY4c1JRVTJX?=
 =?utf-8?Q?XH8eKRbMwlBjPiCBPxL+CZJjxFlIoS0P+YGTU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhLVGN4VURTNHorQzBRajN6T0dLaER4KzkxOFJSbzlVV2MxVVo0MGN4dEJM?=
 =?utf-8?B?MnhCZEpSRG1NQTIvV2xKS0xBOHE3VGpJYUxjeUM5cyttMWhseHpjbk12by9s?=
 =?utf-8?B?QkhtaGZEUmJBNFdyb2dZaGFRR3VWVzVjSFJXSDExTWx5c0xZNEJZdFp3NlZ4?=
 =?utf-8?B?QVV4Tm1GeFhvei9DejR3cXZUcWZtYnhBcUFXVFRDaFcvYmpSbEVHcnhSZGd3?=
 =?utf-8?B?ZlRDN1dDKzlzQ3JFenNGQkUxR2hqdFJ3WFBNNUlRR05uU01HaGNyU2lLdzJh?=
 =?utf-8?B?cUdCOUlPY044WWg5RHJGWFgzN0w4OWdETEdLTUhBTG4zbDUzR1ZPQWRKMkJx?=
 =?utf-8?B?MzRVaG5EMjJRalV2bU80UEFTWGNXWnZKYk1ITjJ5S1oxbk1iaDhZTWRLVHQr?=
 =?utf-8?B?RjgrSk5qdk41S2s1OE9jK0JubDZ2d0hydWNkWk5SSUpWMnJmV0Vaa2wzV0dp?=
 =?utf-8?B?V214c00wbnk4ZUhMQkl6SUJyK1Jac1llQ2xubEQvTitWRWRTRzhKM0RSSjdJ?=
 =?utf-8?B?eXlmRzh1TmxwenJmM0FNS2RraGNIVzZlSGpXR3ErdENuNlJJMUlmdE5VUmhX?=
 =?utf-8?B?QTBFRUZxTjc5REhYbTFMbDJhdTYvYUtGUFduaTZWUkFSc29WOHRvRUxsUXZM?=
 =?utf-8?B?cUh6ZUlrTDFISEROYUowT01XTUhEYXZ2SE9SZktac21qaVEvTW1SU2ZOYlBo?=
 =?utf-8?B?ZDA4UUhkVDgyQUpieG1NREF4Qk5iSGJ0Qkg3UmRRZzJXZDg2UHg5S3BiOGFq?=
 =?utf-8?B?Z3hwa0wyd3VQOG1VWlFhc2tNVGRwbkZzMmJYa1ZaNlpnRGRwZVoydjB0eVhj?=
 =?utf-8?B?L1pHNnhhemNtVWRpMWppRU1oUDNoc1lsQi9GWThOUjZ3RTVwLzlMMmx3N0xZ?=
 =?utf-8?B?LzQyTGF0OU05T0hPRlZuTWNLZFBOVTByNU44dTdHUHRpVmUyejdCQWNqRFhT?=
 =?utf-8?B?VEFabDdoRWJIOUZidTBENmpaS1NoSmovUmYxdnpyZHd5YWNoLzRmdFRQc2Yw?=
 =?utf-8?B?alhYSHpSbm81WTNnV0ZPUUlKYXlzSzVMTkZKKzhNOVN1TmN6ZSs4TVA2N1VH?=
 =?utf-8?B?UkdyZ1JRcUpvUEMwU2hhTGU3OEsrN3pqeTVjS2t6YWhEcG4yRUVxSGNzYWsv?=
 =?utf-8?B?b3pyVmhEQ1J1bnhRSUg5cnd6bXp2bmRZVVhnNkY0dWQ4TExtbkk1aysyZllk?=
 =?utf-8?B?MU5ON1ppQVVZcVIwT0RrUm9wSXgxVDRKb1k3MkpwREE1VXRvSmtPL2xYcEJZ?=
 =?utf-8?B?alZBNWszV1M5N2x0VzFyUkh0WXk0L05vMlJIRHdUY2dWZWNDblliWHZEQUlt?=
 =?utf-8?B?QmFyUWpEdnVweXNMS0F5Vy9wNFlDaGdDRFZlcHlLV1J1NTFJaGJRTWF4RlVY?=
 =?utf-8?B?RENQWUdxa0lQbndtcDRjWHloZm1nWWpGR2ZpZWpwWm5PSnVGZEJSTkQ0NjZ2?=
 =?utf-8?B?dnNzQ0dJMytUN1F5MVBxZldzbHRCZ3ZkUjZnYmtaUzJtUFhEdTBObEFDM2lp?=
 =?utf-8?B?bHVMZEw5Z2lGMVcrQm40Qk5Ja0E2Sk5zQkZCUENBcVhYbkJIbzA5UHAyWFBH?=
 =?utf-8?B?RFROeURjMVI3MzdRcFdUZktwajJKaithdHNDa2creXEzdjdoTjRFbmIwSFJN?=
 =?utf-8?B?UTgvMEQ5QUs5YVMrWWQweUlOUHZpNFg2RmhkdmpBSUtXUDNoVThPaVFYMVNw?=
 =?utf-8?B?YTQ4UTM2am85UWEzRVJERlFOa2ttZXY0OGlFcWRiU0pSKzZxQlMzZGNqVWo1?=
 =?utf-8?B?WjRuaW5hY2dtTElhZFFSTmFHaENBMG84cStUV3VUbUpzZ0dzUFl1K0NRdS90?=
 =?utf-8?B?NE5XSXZZOFBvNDlTQ084RHJ1S09DWWV2dEtDa0xTbzlMeEZ2OWhpMUU5WnRT?=
 =?utf-8?B?RmNoZVJkclVEODVTTEJoUjdzWncyWHFkYVJ4bzlTOXNKd3V4di9QVnBpamhW?=
 =?utf-8?B?YmxaaDN6ak52aUdkaWUrZmNZQldncExWM3Jibmx1TTBHK3dsNTQrWTZ5S3g3?=
 =?utf-8?B?U3hwelVOYlMxNFlNOVNFVnd0QXVxNHZ1czFtN1lxVlFLWmRVd3Vma2JtZjhZ?=
 =?utf-8?B?TW9sMDk5U0poZmhTblVJa1NKUWhRem5QaUcrUlYrdW5JeXpnaXdKMjREd3Fx?=
 =?utf-8?B?OExudGNibVprNGpEY0pOc25GY1VIaTQxNGk1bVZPL0J5dmtGS1ZFWEUrRWNH?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a0883155-43c4-494a-214c-08dc894b63e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 12:46:47.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLxBEDo1+4WauHmaHw4Gxq1hmodcF4sKa0G6syyWbHmoWfSivorRZXMsXIeJBzTOZgRiBOCVPfKHR6euIg6QJalsqDsaq+BSxJmegkQdrlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3715
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

On 03.06.24 5:57 PM, Alexey Romanov wrote:
> UBI block is virtual block device, which is an abstraction
> over MTD layer. Therefore it is logical to use it in
> combination with MTD drivers.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

I think I already sent a review tag for v2, but anyway:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8edb468aed..db71e0627b 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -26,6 +26,7 @@
>  #include <watchdog.h>
>  #include <spi.h>
>  #include <spi-mem.h>
> +#include <ubi_uboot.h>
>  #include <dm/device_compat.h>
>  #include <dm/devres.h>
>  #include <linux/bitops.h>
> @@ -1181,8 +1182,13 @@ static int spinand_bind(struct udevice *dev)
>  {
>  	if (blk_enabled()) {
>  		struct spinand_plat *plat = dev_get_plat(dev);
> +		int ret;
> +
> +		ret = mtd_bind(dev, &plat->mtd);
> +		if (ret)
> +			return ret;
>  
> -		return mtd_bind(dev, &plat->mtd);
> +		return ubi_bind(dev);
>  	}
>  
>  	return 0;
