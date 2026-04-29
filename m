Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E3FFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CABD8470B;
	Wed, 29 Apr 2026 11:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PZlLZZV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA1584711; Wed, 29 Apr 2026 11:49:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DDA84709
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN+i4kBwhXWOI8f+D36wDdHnx/VKlbJHIpYvAJsgkg9pAfri0dAmaWjG+Yo/JM/XdT5ED4GPa/Q+dydX0ezGYr2V739jviC2aoo6nYELJeUoIC/4q/AwWg9hLUloPuiMX8PdkppOsY6yk81Lk/GO3a18fQDMLBS6d7c84tdiLkt9ofMzcfiuuJV0DUUtCuR6ExuH/LZ8WNxyL1l34htNqp255Kkseh46JQSR3G5QIwfGuNaNQ6mTgCBz7Vi9xVoeOLPXKS3SILwAWwXZvXOAiGDPl1dFtBOmnoKKWeG3pkRQnn3JWyhtuscfzTJD/9DyQpEKxVfv3VOmRqkpg0IB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHtWRwENf4vn5D6HKX2S/myNngtxJqyeT4H4aNgES9s=;
 b=kUrib5rz0cNQuhl3kAe9d9PBH9Biq+M85RKygB3poKGXamu9Zh5uBe0u0Pl01NZ4IDYA90hbMBAp7SYDY2znD4mPpx9ljKlQBDEMjn3hqJr5XmGWqB/jA8l1Y9La6vofgRvbSKUK7TInGZFjTrWJGNqij0Z4SP4FJFqbPVjNzllg0WgD9udqo9MibqUOlv5QbMWC+LhXaPzYiBkDsEQOCg8upy9oTZ54yoYvlCk5u6dwjzUoEkBIlRf1l7zAZnQFF+/JN+PgSW/yYPXTnuMqn2aQ3vPpF3x4I+0ndME4YKNKEq6Tg+rqzGi7nPlpdaGYCFINsxHAZ1LNDWs5ZNyoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHtWRwENf4vn5D6HKX2S/myNngtxJqyeT4H4aNgES9s=;
 b=PZlLZZV/zVdTzz6CHMfUeZeNXX0Ne0v4BBdFITmP6P29FPaj9d8GES8r3PtfKYiaLWo40tR5O+F+Pm7YFCm1++omhjYLRWjBH00wux6uQsF4DyAR5PuF/oD3dCHA2qXZh0u1arc2JK6AZRx9GxgjBoJjrmO5XEyshsiHEUtXkfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10807.eurprd04.prod.outlook.com (2603:10a6:800:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 09:49:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:49:14 +0000
Message-ID: <3ace7546-3f98-4a14-9b8e-98be2b9c044a@cherry.de>
Date: Wed, 29 Apr 2026 11:49:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sunxi: spl: fix SPL_SUNXI_LED active low
 configuration
To: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev
References: <20260429092828.3076719-1-andre.przywara@arm.com>
 <20260429092828.3076719-2-andre.przywara@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429092828.3076719-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: c4512160-2dcb-4079-ec20-08dea5d492ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: s/Y1YpO8LG+L24JPs+d44ClaWuOuubslfJnfmirNDjrvAqPZ2Rv8SvDwgpGswAsKe+sPSYdOjYJ4dTGa90aZ+6ID5rTBC7smv1BIXg2ZnacV0a6d1l/N3XSlsoB2QE3TK7iCxYHRXo334NlDSVlD/FZ4qNZOoct7R8WpGYoybzw9/cC2BzL8QdDLBNr7YqZVin0Gf4A1IC9vl+1WA9NKXVeCpeLaZN8kw0Q9fA/WlpIQnYiiIjdIT9mxIsHCFMjez4e0xOx3aetOODOsR+i+a/I0qozt97P1REZZ8LtfM2hADxUgMJoFBgUIlFr5fwmGV+yfivDhdLezCcBc3BmInM6xKcPKxmaOtEBLTHFqHdgupgAUWuX3nzeIPAUWZG6Kzgh6NNFi+7ByO+Gl+PWtmcn/ufesaea2sE/TtNzAo0iIO+FKylBod/ErnXmFf0TBRo0Mu0Bpl0ZihcPaAZ/RNRMzw18OY2lp897KztLIf6Nr54smoPBn5kDaf239zaS48ytO5k1ixND0F5gw3uBrPvdXFt7T37icfF174KeL5VRDkQjalpOJvO+rf5oFWp9HeZwRHT3sifAeZtLOje+XhAcFxaRWUBMxg5OzPTRWMS3YbLssY8e4efxfao5G/lHDetwJUFLql6s3gYY60rtV69g2QidWlb1WZmEpkcyXoLZ0j6oX68dgO8+zsRUbF09Bwk6Z1F+OV0M7eSe2B3IF+is7FkwwQxHTPhFuSZUvPjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmEwZzQ5K3NTbTUrK0hOQXF0WE91cnNTMXhheEEwTzlUeXk2ZHhSZFdKa0Fq?=
 =?utf-8?B?YVU5Ym5oSjEvcFk5Q00yQldZUUxFL3QvVTBmVXhRdjE5OWhZN1VSRmxIbnNt?=
 =?utf-8?B?UXVWL3BMeUswUjZtYVRUYmZPTytKSnd4NnpvZUpoMnZzazkrRnIxdC9tWFhY?=
 =?utf-8?B?OVZVQUZSakRlbHdHVDR2eFFMUEZHUlRQSUhyVFZMUy9WekVJUTZ3NHVtVVB5?=
 =?utf-8?B?NDBsWnQrR2J2Nmx5Nm5DZFkrN2wxVEJ2QXV0SDcrc2twZitKV2Y5bUs5SHNu?=
 =?utf-8?B?cVhuTE8va25zakFoYU01OU5ROUptSVI0eUszQzZ5TFI4OVNhaWVZV2pybTYy?=
 =?utf-8?B?cEtVWlFvZW5PVSt6NzRnK2haeWtteGROZURQNi9qWGMrcHd5dVQ3TUlqemxG?=
 =?utf-8?B?dTh5VWF1RHhEZjNFanFlb0x5bXYzbWZBSDZLNzVXN0ZqeHRWTm50OUc1LzV4?=
 =?utf-8?B?a2NwNUkrSWRhVHJsUVYxZU5Tckd1b0N0TDRBZUs3Q3QrMkVMQndGN3lkbkJj?=
 =?utf-8?B?eXBIckxRbTVDRWtZcWkySUZMNjg2Q3VrZ0VMb1NyN2E3Z0tpeVprVkRoY3Np?=
 =?utf-8?B?TDJrMFBrcVBlVkE2bG01dEpTcWRTUjcyL1J0bVBNNUhreGxXNndaaERlMEZW?=
 =?utf-8?B?QmxUSHpXdGhVOWZ4Rms0SkhIMWhhQTBNYlZFeWhXWkI0bEZ4c3IrdTNUT3c2?=
 =?utf-8?B?bUN3eGNYMDE2Nnc3NGJ1NUJBMWhmYWx2K2hoL05tYndrWXpUUGpWSUNzZ3BK?=
 =?utf-8?B?RElxd09YSW9ORVIyL2MrWW8rSmtJcS9MTVpnRWp2aDVCRy9tei9xZ0EwUkhK?=
 =?utf-8?B?MlpQb0lOallSeGpKWGVRZzlPVnIyY3RyQUhCeW1ZNVF5QVV1Rk9IcGlrVm9j?=
 =?utf-8?B?bkhuY1Z4Wkd2VG5jK2RQYmRFUzEyWTJaVG1BdnpsdnNTZ0ZBcjJId1pLenQr?=
 =?utf-8?B?SHY3Qngzd3hlaE1ZbUFySldOQkpDT0ROSzAyZXpxMUtrei9SWjlZZWNQMTls?=
 =?utf-8?B?V3NWMDdEZ2VrM2VoZk5oRVpLME1TSS84cTFldmxFMEhOUUpFY1N6R2MxRmhs?=
 =?utf-8?B?SUxJTUpQMDlIOHN5TFRHRFY0STZlY1hCdmdxTDZYTXh1cWZQZWN6R2l4Zi9q?=
 =?utf-8?B?dzNBd1JYUE1UTnlLWkZ0d2VZVlpLZzZ0Mk15QU9IdGJkc3VKTDNjQW9BbldF?=
 =?utf-8?B?YVBFVU1DN1l1MUg1MnVJZUVqRjQzQ21xMm00aFBvMkM3Z0taTEtHL05OaFJk?=
 =?utf-8?B?bk5zRFZzRkhhZngrN01QNXlrTWxQZXN1LzlWcnozeFlDeW1GTDBWbzFGV1Ju?=
 =?utf-8?B?b2hrREFlR3ViR0VTaXBuS3c5UGx4eWZxWDBsbmo2bjJsTWxYRERRdlQ4WGtQ?=
 =?utf-8?B?YXpxejBnYkdKY2h5cTlHMW5WY2dkMmVCQzFmeUhtbU9Ddmo2dlpZQWVIZnBE?=
 =?utf-8?B?N0dsKzhIL2dBNjIvSGZvNUtJSHo2UXFoLzBTd0lsZExVTTIyRHpSQ2tQaGhr?=
 =?utf-8?B?Ym1CZnJZUG1meHI2QVdSTkVwbDJGNy9mRlZLZ2wwWEZnSmYxdmtFeWVVWHpm?=
 =?utf-8?B?Z3krTkpoZlphVTd4bk8zeGk1MG9rL1loYW5mNjQreTRYa2Zpc2FhV2dFL3VQ?=
 =?utf-8?B?R2cxUUM5SVRHblNGbjVlY3VseHZndmZXcWF2MG5KZ1k0SkNUVXZQMVJISFFX?=
 =?utf-8?B?NnFDaC9meU9VaWVxN0JYL2VzUjVYVGxtZE42WjZiY0RQTmVTVUJxb1k4WTFE?=
 =?utf-8?B?UXJCWEdNVUlNZUZ2ZkRtdTRzQXJKMmtVb2E5Vlg0OCs1UGdvays1WmFJQnha?=
 =?utf-8?B?Q0J3aENodjdGNnByRWlVWTEzVHFLa2I3SDIzeVE0WkZ3WXZ2OC9sVGhhQkE2?=
 =?utf-8?B?czJGdW8rUzFYYU1CREpVNmREZ250K2t4eEtpdjUzLzV3b3ZhUUR3OEVRUU4v?=
 =?utf-8?B?ZVZiYmhMVGNwclM5RjQ0ZmVUSjB3aVBRZnRQamZHc05OaEpoMzQzWm9Lb1VI?=
 =?utf-8?B?cmFGSHBkS0dsc3dZTS96aUhNZXVTRkFoZCtvM3BXcmI0dXBjc0xSbjdxdXlD?=
 =?utf-8?B?KzJRdGU5aEx2Ymw0TWVZcFBkOW9XMWFJSm1RR05raXNQaUJzK3JiNzVIclQ4?=
 =?utf-8?B?QnQrK1RzRmJjeEpIOGZxMnJ6QW9hZnlDajk0SnhNNGUydHIwcW0wdmlHQW9j?=
 =?utf-8?B?YlV2VGlzY25LWC9jTVExT0dxMHVmak1zUmhnSXFBOC85d1N6dXczRGJQakhE?=
 =?utf-8?B?OFFzZTQ0dkh1OG9kcjlyN3B5SVlTY0FSdVdPeHkwWGR5RGJFVVVYVGt6eUFj?=
 =?utf-8?B?TjY1bzE0Tm5veW04Vm01dGJqdk1BWkNpMktOZVpncSs2aHdDbGtBZVl4eC9K?=
 =?utf-8?Q?c0dqhzlsXBJarh/zKY075zy3NcF4tzl8yCG/l?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c4512160-2dcb-4079-ec20-08dea5d492ae
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:49:14.8354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sv1qaR6BJmrG42Pg96eHad6ZM5Mj4sy1D1ryi3gP7tB2H34ECL91fP/jf+/+rOnSJntW0jL6wqaP6QBztg0XaA/9/wFjTltifyKKXrwwoAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10807
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

Hi Andre,

On 4/29/26 11:28 AM, Andre Przywara wrote:
> The newly introduced Allwinner SPL LED "framework" defined a
> SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
> the active-low vs. active-high polarity of the LED. However this is
> a bool symbol, so it will simply vanish if not defined, and we cannot use
> it directly inside a C statement.
> 
> Filter the symbol through the IS_ENABLED() macro, which will return 0 if
> the symbol is not defined, which is the intended value here.
> 
> Since the STATUS_STATE name is a bit confusing, rename it to ACTIVE_HIGH
> on the way, because that is its real meaning. Also the LED_STATUS_BIT
> name for the GPIO number is similarly a remnant of the old status LED
> code, so rename it to LED_STATUS_GPIO as well.
> 
> This fixes configuring LEDs with active-low polarity.
> 

Individual patches would have been better.

> Fixes: 256557dd9aae ("sunxi: remove usage of legacy LED API")

Reported-by: Paul Kocialkowski <paulk@sys-base.io>
Closes: https://lore.kernel.org/u-boot/adfMQBPdntWy1KIq@shepard/

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
