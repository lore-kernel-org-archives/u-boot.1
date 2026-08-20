Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962BBC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D08F80DCD;
	Thu, 20 Aug 2026 15:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28193eBQzhmr; Thu, 20 Aug 2026 15:49:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787240958;
	bh=aGxU5wd7a2fvw4VGJ6FQFCrJVoCiRmwzTL7+a5IvjDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZM62s22ok3rVSlK/xygT4u8aXjQUhKtwVdT+VfcBhumgVA38Lnt1d2mhJ47fKCUrJ
	 V8EUxZqedCuWA8Iq19UCJpoh/Qfmy6Dj5BaIU5Ibfy9lrdQX/9UDwwfIzv5x5Oiww8
	 TPobTkvUchv8iG+jHU4e2M5GWUsZYmgnYkvc1CYuJQCtwKGs1URdI/NjsHoObGZom4
	 1p5w844gDGhqnh0/xGTvRU2Ln/4cNMi2iTsftou4XtW2csxFbZMxMlvRuoVOLajmv0
	 t2OmBLnqDr/1vIkOC3XIfMmzAZUN9kGfX0wjmQGvM1P39gqRSDCbBKu8Cln23KYwmF
	 hBEgGpD1efYtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AF1A80DB5;
	Thu, 20 Aug 2026 15:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E699B29D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E410860739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRgCPtEUyLL8 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:49:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=B1R/Xwys
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F7A960624
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS9qlPcsTspoAITp+FMyMraiyBnRkd5WT7VhqWj9mHTQb+V5u0qhCK0b9p3mOQPeZOj86VdfvEovZgPtNsppK+b1WdJC9qDXPin5N3mD15TYR0LX1NZ4wXm+itHsXGztWWEH54KN5TVZAUrXSH651AQVnSiBXy8P9mixU+TJQ3+bUm46FG9w9u8rkKQN/4k+eD+eSZGxBDTykjhNWH9h6A6hmXIpKF4hhCcNUtFmkBbh6EoqWQ0KUzL2kVG0wZChnibDqQvwegSTeBvQrVqM7FqX0CcJ9FyDMmWOlFq6/0V9DLUSUlhsBDqpmJ3FajTCVGiQqI4b9JpX4ZC+qTWtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGxU5wd7a2fvw4VGJ6FQFCrJVoCiRmwzTL7+a5IvjDk=;
 b=hiwfOe4uFTVrw37AgZqaWtrczEb/RWXzXWKc6b6nVXc9EJENeZ4T4HKHwAB3OnNPhNwNIgM5EhNANzUfcDmns7/uNzymBOijkCRw21Xukp8aGyc7Wu6ZtlbKJv5ktIaitziKOLPchxCZ7ehYY4G36YRnLPwsj9m78CzsWo03qv0+UAD8q+54AF6/iREakOGmOe+d/SbLDZqjlZwpGD9TZQZhEZ70nMCRqPfGE+WsV1maFpCWWIm7NtL8uyUv5Vmu8VsGepspspMTjwEJ85hqj5yv4rVkcRhWghzyxI2kgsxuEYpGiGfIUjnHM6QvPNbPUbCvlp4B8KN0UWPz6IX1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGxU5wd7a2fvw4VGJ6FQFCrJVoCiRmwzTL7+a5IvjDk=;
 b=B1R/XwysuVS/Y+lPIcmEd5Q7dIl4RMhdjLe4U9vEQOAEipL5ZwKV1zmmHAvHV4wQwuKCGzslNiPo0DWvLAEfA4nMT/GlDQEwgySj34qW7MPG5hk+krNuKkA+GZSbA7ty83BGlFKKQCjhzSfVxLHOAS55LN8yL/u11Ll8NvB/74Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:49:07 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:49:07 +0000
Message-ID: <10d3c284-8789-41b6-868d-c251fa557bca@cherry.de>
Date: Thu, 20 Aug 2026 17:49:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: Handle spi-{tx,rx}-bus-width 0 as
 SPI_NO_TX/SPI_NO_RX
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
References: <cover.1787238071.git.Munzzyy1@proton.me>
 <47d4692da2501e61daf9e6ad13959430d8334f85.1787238071.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <47d4692da2501e61daf9e6ad13959430d8334f85.1787238071.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::20) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d2bfd-ead9-454f-3375-08defed2916d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10070799003|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: vFMPMFDa8RF3pGCuSVkBMQsD8LRg9oFEhY7BTiG/1GeLefhjPOWcewcsaV72u8He0/TmXPmV62oGAXqNgC69KCg9SOPsxeuoEtmi/gwWI4WBXJByXxHHqAK2bmRjimYJeJAP5UeE3ORKyAaQKk8fCjNSpLuP9mwmeHzcouxLHoODEM0yRSLyCV7vvhv9jtfGALY7YCbiqkfaztrEOmNcTSOFX8z1RZDQqImKc2qKM8P3nbWyhp0JA5U15Hq5mtuaiUCq3Nut5Le/xhzIGlHqhruvMT5ivv4qQF8Ohb+K9G4fXPg3MRdHSWiU6H7Jq/TzUktJi1jBdWnbO1h8X628zOTOKxMH0zbXRyCwSreREddoKvsS2ha6rW3Z1w/KpenpYFdwfhlqTzjMR/FIVNhjdLfcV3LyPWI+k/XaO7yxmO2Qa9Wbph8xjAF7+swsmxuPcr0ALoKIpMhXKY9xjaZ9xCFfpNBh4kCl9Jj7l5STnxD6Duw0nCwRGbmZzk3xRdKPKLl4g5JoUMvEo4gSbLp4Qj1FuV5Uu5ykySwq80L0faYcXGdyAYTjIYMKA365M51pd9904OdjN5PGBvnkzpKqU8VY1Ftkr9YxzgEKC1/tQ36jCAORPMZTHTQvpfPfdtoOW8u9NpS85ktz343pGRiB1S9SLtktdRYGJw8KVeI4hrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10070799003)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9zOC8yUkcwRXIyVWF6SEVlTlU0T1ZYT3FoMEc3Nm56ME1oM092U0dUcGd3?=
 =?utf-8?B?OW04SDNiRHVvUE1pVnRZVjFvOWV1ZEFjamEzNThKWkNzc2Q3ditwQW8yQmxU?=
 =?utf-8?B?ZDNFY21odHhwM3ZwNzR2eVl0MVlQMHJ0a1dJT3hhZ1lhTU1uQ0dkM2RuamtK?=
 =?utf-8?B?ajRPSWZQTks2RExHZVB5cytVbFp6VkdwVjR3UjBpMFhYOWJwWDBEd2wvQVBD?=
 =?utf-8?B?bzlEeUNiRmNXNmNSTFZ1c3hnclcwVi9JRktEWXVxN2tDTHFGMGF2a2dUVmxC?=
 =?utf-8?B?SnBQSFlaVzFmeW5qRW9YcHNzVFRvK3JuOTFqQ0s5Y20zMGZ6cDJuWmMzK3hQ?=
 =?utf-8?B?U01mbTJDY1RGQWhteVE2ZTVOWEJtRGpIcEhmaGIvWWlBKzBuaFNNQmZRcVkw?=
 =?utf-8?B?SnZHUWYrQlNvQWZ2SEU3VDRqL3NzOGFaWVZaRjh3UEIvNTlkOSthd285Yk5C?=
 =?utf-8?B?OGJNRnJxd2RueDQ1WlAzSEpjTkxacE1RTmdpQm41UHYrejc4NHd0QlNrcDd5?=
 =?utf-8?B?M29TaGhxMXgxc1l0NHlkSkY0Q3JIVGZVQUtpNUZpK0VKZExVeTFEWVBtQUln?=
 =?utf-8?B?VDN3REJJUVpCWkVFYzlTamVMVCtCTU05SVZ4UnlOeWN0SnFleWg3bllqVXBt?=
 =?utf-8?B?dUVHUmxZRGpMaW55NkRadExaQkw2cFgxRmlPTWkzbVBKK2NYWVQwR3g2My9q?=
 =?utf-8?B?OHFpOVRvS3ZmbVNMa25ja3djZms1ZWtGWTN3TVRGeXpjMzdESXlkczJBb0J0?=
 =?utf-8?B?bUhSK25XZGM4K0dNQm50SnR4d05RTXk1Ym5xSVpQVE1uSlhySTVtTGs1UWo1?=
 =?utf-8?B?ZHp6dVhpM25TbWQzbGFibVBTeU9pYm5kRHFDdEFYZlVJOTJTMk9YYXNUeTNB?=
 =?utf-8?B?dXZ3T2M4UHoyMWRTWVYwaVJ3eCtnYzdlaXFxSlNnL3kyQzBnSk5nODdtQ1Jr?=
 =?utf-8?B?c2EvSWJIUmE4Nm9MRmV3aEVGcGVvdGRpL1RhMWd1dEZQSkI5aE82a3BKZ282?=
 =?utf-8?B?bXdaS09XWGVMdGtUamFOMXVIWHFIUTZYdnBmYitSNnV3dnoySnFRSy9pR1lm?=
 =?utf-8?B?KzBaSE5jYndhWjhhcUp3OG9BVXRreGlnM0Q2eWRIdXowN1g2YmpkblhyMENw?=
 =?utf-8?B?VXM2TWFrdlUveUZub3VFaVYwUHFzaUhJOEZhSDAwcnFOM0k1dWl1aEZXb0Vr?=
 =?utf-8?B?WEN1K2ZEb0Y0WERka3cyL2oyTUxSY2g2cU5DRG8xUnRzRVRGcXJuZUtoaHhm?=
 =?utf-8?B?MC9Ka2ZlVUE4Nk9BQmdNS2Q5bXluSFVsMFY4RXJTbDJwTmxOZWdUWlBOS3R6?=
 =?utf-8?B?RURJVkpHTzNUZ2oxcGhlMUJWejBlYlZsTkZJY1JTcDE5TWV6UnpRT3VvVDZo?=
 =?utf-8?B?aXZHb0NhLyt4MlZoc1lLUkVyVllhaG0zRERISk55U3JjVFZtNHNTeG5WSkdI?=
 =?utf-8?B?d0s5a1k1dDM0ODdxdG90aVNWempNQkt1bndFU0VrSXVOMU1ORGkrMlU4cUsx?=
 =?utf-8?B?ZzZnMERVdzFjS2ROZkdYMmZiZHYzbHJaQ2V0NmR5MlR3aWVlM3FsYXV4OFcv?=
 =?utf-8?B?aHV1QjExVlZ1QjdwYWxrczlCRm1aWk1WQXJXTVZCbXJHai9pT1YyWEkvdXJP?=
 =?utf-8?B?S2NneVJ0WS9yVmY4V3JiY0hvSWlDNWpXUFVLcDlzSHY2YXhUV2cxbkhhdTZK?=
 =?utf-8?B?bmtEa3J0RnlUc3luU0RSd3hpK084T0JRaWYybDg5R3ZFRG1UYU42L2ZzSDVm?=
 =?utf-8?B?ZEtUaUdWcjBuNDFwTGRyZzd3NURNK0tsRG5Kc08xVGVaSEhkWXFuY0RjeERK?=
 =?utf-8?B?OFpKRFNDWWl3SXErMkg5UThQSTBOY3hnU0RCRjAvWWtIaXBUdTU5SjVPR0Ft?=
 =?utf-8?B?andGWnFjSDdtVlhYR3RiblFXYkhLbEMyMUNXWlp5T09WbVNoLy81N3lZTm9V?=
 =?utf-8?B?V2RwK05JVjdMWFAxbE10UmpSNHM1Vk9HRW85WTBVaFdxdEdMK3YwVUNxZ2Ru?=
 =?utf-8?B?cWpEOGQ3SkFRbG1BcDVnYVBKeW9SY2xIcHNVK29Ba3JJMUttblJkUEI5a3dv?=
 =?utf-8?B?WGdLUEJDcDdZSkgwNFVSSXdIRHRUaVBUamxJY25oZ2tFRUt3ME80bzBTZERr?=
 =?utf-8?B?SEYrbTRXVHI0ZERTNW1YSCtXRkRDOFNPVnZwN2xBdkNYWnBWbG5MWGxldE95?=
 =?utf-8?B?TmhVN01LK0VibVNQcGhsM2lRK0MzOWhTQmVhcmFScnhMYlRNMk1ZTkVGU2Jr?=
 =?utf-8?B?eERFVDR1Ukg4dmVuMk5NZG04KzAwcUVSNzdUU0h0SFd4cW4wcXB4KzRuYWFJ?=
 =?utf-8?B?R25VMXNpZW1qTTNMQWIvd3Q1YlNMRUZDenBOYngzOHh4RVZKWEdUN0Izdyti?=
 =?utf-8?Q?oUXlJitZakqOwGntek269afgH5IBD41UuqWFSfaJGXEsa?=
X-MS-Exchange-AntiSpam-MessageData-1: kdTI2Pvz4PmzMQ==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d2bfd-ead9-454f-3375-08defed2916d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:49:07.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvHdtYDBVps4BrvX5u6QhKX47xlewZ/DnbxngHonVzHYXgJKfmB79kID5CneZisUBpYt8Xb733ue0yjKEuHKrOj8+e3RC7wZA0bKAUamDz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Cole,

On 8/20/26 5:26 PM, Cole Munz wrote:
> The spi-peripheral-props binding shipped in dts/upstream allows a bus
> width of 0, meaning no RX or TX is possible on this device. The
> switches in spi_slave_of_to_plat() only handle 1/2/4/8, so a width of
> 0 falls through to the default case and warns "spi-rx-bus-width 0 not
> supported" on every boot, even though the devicetree is valid per the
> binding. The fact that the wire is missing is then dropped from
> plat->mode.
> 
> Map 0 to new SPI_NO_TX/SPI_NO_RX mode bits, as Linux has done since
> v5.12 ("spi: Add SPI_NO_TX/RX support", mainline d962608ce218).
> Bits 16 and 17 are the first free mode bits.
> 
> Mapping the bits is not enough on its own, as Quentin pointed out:
> nothing would stop a caller from asking for a transfer in a direction
> that has no wire, and every controller driver would need its own
> guard. Validate centrally in dm_spi_xfer() instead, matching Linux's
> __spi_validate(): a din on a SPI_NO_RX device or a dout on a SPI_NO_TX
> device fails with -EINVAL before it reaches the driver. A new sandbox
> test covers both rejections and the accepted case.
> 
> This comes up on devices with no MISO line at all, such as a
> write-only SPI display described with spi-rx-bus-width = <0>.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> Changes in v2: added the dm_spi_xfer() validation and the sandbox
> test. Rerun on this branch:
> 
>    $ ./u-boot -T -c "ut dm dm_test_spi_xfer_no_rx_tx"   failures: 0
>    (spi_xfer, spi_flash, spi_find, spi_claim_bus, spi_set_wordlen
>    also all failures: 0)
> 
> With the dm_spi_xfer() hunk reverted the new test fails both -EINVAL
> assertions, so it does test the right thing.
> 
> checkpatch flags the #if CONFIG_IS_ENABLED(DM_SPI_FLASH) guard and the
> DM_TEST-after-brace placement in the test; both copy the idiom the
> existing tests in test/dm/spi.c use, so I kept them consistent.

Agreed.

> 
>   drivers/spi/spi-uclass.c | 16 ++++++++++++++++
>   include/spi.h            |  2 ++
>   test/dm/spi.c            | 41 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index 120565df1497..dd1843ffac19 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -105,6 +105,7 @@ int dm_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
>   int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		const void *dout, void *din, unsigned long flags)
>   {
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
>   	struct udevice *bus = dev->parent;
>   	struct dm_spi_ops *ops = spi_get_ops(bus);
>   
> @@ -113,6 +114,15 @@ int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   	if (!ops->xfer)
>   		return -ENOSYS;
>   
> +	/*
> +	 * A device with no wire in one direction cannot transfer in it,
> +	 * so reject the request here rather than in every driver.
> +	 */
> +	if (din && (slave_plat->mode & SPI_NO_RX))
> +		return -EINVAL;
> +	if (dout && (slave_plat->mode & SPI_NO_TX))
> +		return -EINVAL;
> +
>   	return ops->xfer(dev, bitlen, dout, din, flags);
>   }
>   
> @@ -229,6 +239,9 @@ static int spi_child_post_bind(struct udevice *dev)
>   	/* Device DUAL/QUAD mode */
>   	value = dev_read_u32_default(dev, "spi-tx-bus-width", 1);
>   	switch (value) {
> +	case 0:
> +		mode |= SPI_NO_TX;
> +		break;
>   	case 1:
>   		break;
>   	case 2:
> @@ -247,6 +260,9 @@ static int spi_child_post_bind(struct udevice *dev)
>   
>   	value = dev_read_u32_default(dev, "spi-rx-bus-width", 1);
>   	switch (value) {
> +	case 0:
> +		mode |= SPI_NO_RX;
> +		break;
>   	case 1:
>   		break;
>   	case 2:
> diff --git a/include/spi.h b/include/spi.h
> index 97096a775262..f477763bdc60 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -34,6 +34,8 @@ struct spinand_info;
>   #define SPI_RX_QUAD	BIT(13)			/* receive with 4 wires */
>   #define SPI_TX_OCTAL	BIT(14)			/* transmit with 8 wires */
>   #define SPI_RX_OCTAL	BIT(15)			/* receive with 8 wires */
> +#define SPI_NO_TX	BIT(16)			/* no transmit wire */
> +#define SPI_NO_RX	BIT(17)			/* no receive wire */
>   
>   /* Header byte that marks the start of the message */
>   #define SPI_PREAMBLE_END_BYTE	0xec
> diff --git a/test/dm/spi.c b/test/dm/spi.c
> index a89ba06274fc..cb8f88713a9e 100644
> --- a/test/dm/spi.c
> +++ b/test/dm/spi.c
> @@ -216,3 +216,44 @@ static int dm_test_spi_xfer(struct unit_test_state *uts)
>   	return 0;
>   }
>   DM_TEST(dm_test_spi_xfer, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
> +/* Test that a transfer is rejected when the device has no wire for it */
> +static int dm_test_spi_xfer_no_rx_tx(struct unit_test_state *uts)
> +{
> +	struct dm_spi_slave_plat *plat;
> +	struct spi_slave *slave;
> +	struct udevice *bus;
> +	const int busnum = 0, cs = 0;
> +	const char dout[5] = {0x9f};
> +	unsigned char din[5];
> +	uint saved_mode;
> +
> +	ut_assertok(spi_get_bus_and_cs(busnum, cs, &bus, &slave));
> +	ut_assertok(spi_claim_bus(slave));
> +	plat = dev_get_parent_plat(slave->dev);
> +	saved_mode = plat->mode;
> +
> +	plat->mode |= SPI_NO_RX;
> +	ut_asserteq(-EINVAL, spi_xfer(slave, 40, dout, din,
> +				      SPI_XFER_BEGIN | SPI_XFER_END));
> +
> +	plat->mode = saved_mode | SPI_NO_TX;
> +	ut_asserteq(-EINVAL, spi_xfer(slave, 40, dout, din,
> +				      SPI_XFER_BEGIN | SPI_XFER_END));
> +
> +	plat->mode = saved_mode;
> +	ut_assertok(spi_xfer(slave, 40, dout, din,
> +			     SPI_XFER_BEGIN | SPI_XFER_END));

Please remove the happy path, it's already tested in dm_test_spi_xfer().

I'm wondering if we cannot simply merge the unhappy paths into 
dm_test_spi_xfer() and have only one test. No strong opinion here.

This looks ok to me, with either of the above done, so:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
