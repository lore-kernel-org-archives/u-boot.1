Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E32684B58;
	Thu,  7 May 2026 18:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UAmNSGuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3996284B95; Thu,  7 May 2026 18:51:50 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1772784B02
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJjppmXXy6SnnXsJCNS/NTtpFWvLjb/HxiPtmlmtSWPxe/c/Mu6ex1qZ/xRTtbi64AL2t4qyg9PKuG+711jM72jXFwAPYH34JVLn8ua7akq61PbvpDxjfvI7/TxQ4LkavmVtQMSbfkxCSwt4wZvmcQFvg8fZM09JMXnOXlrL8qEMkJ7WRydfbdy9HBiUKc+Laj0rJ6BrO1NdDHV+Jd18Ed21E0oLa+NL+eW1Cg11Lo34Cg4Sm4y6VsW6WUReS8EtU/op+XO5Ukeo9PfInu4bFdhQ8HnmC2OYfKWfP0b6Vcw7QeChq4hCPWuTSMfmGZ03akMjYnFd670HHcVxjXIgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m6Xhq5d/Ii/BurtuTUaX+REhdNj0CiKsd2P18+d54A=;
 b=Yzj8ruZPDl05elimo4vsZ60p7U5zbdd4kDMv5VQvh2mdbInM2D0KCCv3ruQy35txLQxQI//f4tR4t/RLrndQmjxjh/9/Ag6QsaXFsLvYJ+i6Fp0SsJV0H4+Ad6l/OG6FHz+V/ZpfKAKrfJ9J4laAvpp+88ube3v44G2YnmwPG0mkruoRETsiRoWpkzANwZWoKwA6bAPm6gsfdnzsxluT+oa7YPvtSZva1xx+s93Bwz45iHeNX0zfByK0uAILjQlA0IjtsD0Ww8Va9zzIjxKwyoKnBAnJN0fsHd4V5oVC+hbEOg+xcc2yyeija+o1Je9rCsABElMQV7zXJN8cN7gx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m6Xhq5d/Ii/BurtuTUaX+REhdNj0CiKsd2P18+d54A=;
 b=UAmNSGuc6OooaJxz74EZMseQOWTuz66yzDGbGR+grgPxFAJUSWajwmaSTTis0jgg+7v9GLQJ2cg+ZoyPB8jOHEGpttghExjWppEY40wA5YplAAjBKr0GXIrRXLAdcVNCQxkLkGlgE0Qx81uellKvtaM6yR5WHmEvwCaUjzYjseA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB12110.eurprd04.prod.outlook.com (2603:10a6:10:63f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:51:46 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:51:46 +0000
Message-ID: <aaab90be-cef8-4ef7-a355-62557f8459ea@cherry.de>
Date: Thu, 7 May 2026 18:51:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: Correct dependencies for MCP230xx
To: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Eoin Dickson <eoin.dickson@microchip.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <20260505133427.2647028-1-charles.perry@microchip.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260505133427.2647028-1-charles.perry@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB12110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5dca6a-3392-4fbd-37ab-08deac58ecdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3aMGf2QwO6h+rF1f+NABuX5i6nbH/iBeLxwg/Xo5A461BFZexTmDBv0Sji6xRvVOmhbL8aQLSISh+h0dCCkj1YZrwcJcWPhc3usIjx5e4IGa1YaNwZGJNwMXL7nFT/O8/qmvQlhK3LVcGWnQrIDHLguXTk7+Ll37+miWzyE43RykRMSeo91N9Qr6e2PtP5Zuk4jGpCphUgRMNqQ/6SUYKf/1opyR+rXqDFacq56QJOQLZxWPBgtg3f69+m9VqnFAjVAv+S2d1BD4r1nt6TA2Lj/yHFGwxFANYePrmUjWob62XS4H1pKCLe/K6Bk3gknsPiQ+Ct6fZ9n7WhzPQgGB6CH1LKME42yDDZILfmqvo5nX+Hhm7rphBKyZdedEMEpiCMaVVsPGpZg5XV3nyxAiolC+Eillh+d590QMbdIHEXkjXS8Ui3Izb2tg7Zo9JG3anXXPeRrK+L0vVjqP9y6qx8BWHRboPcOxXwSeToAyfEXKMU9zI4sOmRUCRsSJZJ+ymmZym5pafKYL/KOrBCGn6C34nHeVCkiV87xLmWPOv5XRsgw3A2XNdYb1SCY5hqUe2haOzYI/HwkYk60bZ85QmMEWiFWKhyinlCZB6Y4ZTEXbihy/z0V6Sn6FDa2AysOSp/gKOt8eTJbthLfAPigMP1PtUmbgmHEgDry9lr7IWnm+GVIYIo/IqsQUKHRpdTg2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRZK3krWlU5cGRsRlRUK041Uk1CQi8yYWV5VWtSa0RYTXpzTU1zVmdUS211?=
 =?utf-8?B?dTdDK0NSZWN5cHpWcEVMVE5tdmk4ZDF1R2pIeWNhSmlYbzNJN3FRZGxNckNM?=
 =?utf-8?B?T3h1OGZPUkdMZUJuZlFJTWpUSDhyK1IyYjUwZjBsaWl0bG1QaUlUdGE2U0kw?=
 =?utf-8?B?OWRnZHliN0d2TldtZlZKT1NyTnUvVXdRWWJzdGg3Tm1NZVBMRWMwR1BKNnNz?=
 =?utf-8?B?bk9MTlZlZ1hyY1MrVzdITU1rTzl6bE9UVEY1UFMybmM1Y3I2a0I5dmVHSHFL?=
 =?utf-8?B?ZDFxdzRFVy9pT1ZnRlFUeHAwaWsvRWgzWmVtV01YdFV1SWMwbHZMUHZSNkc1?=
 =?utf-8?B?OHpCM2NGZFhDaEI2OE9MWnNNdDNOaDdabnEzMEU0a21pYnRMd1k0MERiZEdZ?=
 =?utf-8?B?ZUpLeldXajhFZ1VuUGNwcWhhZ1VFcHg1cDNLSlJTc053N3lseE1EYUh4MUpq?=
 =?utf-8?B?WExrNTFNL1BUeHprbUpXaDRtYUF3dVJWbUltb2JiaWJBTjh5NXVpZFJpQzY5?=
 =?utf-8?B?YXBwMmllTkNTNzRnWWVWMDU2Ym9pTFZhU29TdGpJUGRxVFBjV2JQelNybkwz?=
 =?utf-8?B?alpJQUlGcytvbnVIQi9rdW14WUdCZ3ZKNUY4NEJTeHg4OUN2eWtOMFNBRncx?=
 =?utf-8?B?UmlOSGxLTXNmNktkZFovYWNSY1djVTZLTnd3Y3VFcDBWRzNhbVBwVHFFVEQz?=
 =?utf-8?B?NlpQaEhGdHA1TWxKV1haOTZuUDlXZ3duc0VKTFN3RXRhY1ZscWllVkJFR2RS?=
 =?utf-8?B?eUFLNjNlZmN3SDlvUkRMWk1iMXExa2cySE1pVnZZZ0llRUhDaEhhYUFjWEVk?=
 =?utf-8?B?MytPOU9LVlFCSkhMeVd5SDBNT2tBTkxmczhxM1BnMSs2dUNObThhSEFLRnJO?=
 =?utf-8?B?VzZoRnVMTzFMWFFPSWpYR0doSC9ldVlkeFNxcGJTVEVIRUFMeFR6UzlicjRy?=
 =?utf-8?B?SGlsTG42WVhhSUpNNUpIblEyNDVyL1h3R25zbHBFOFRaaE1NMFY3U25LK1ov?=
 =?utf-8?B?cXNjcytEcm5QeFBtRzdXbVZyQklKWFRPWjJ2L1lURWkzUnM0RW5wcFNsZExq?=
 =?utf-8?B?dFVyOE1NUnNLdjdLQVRRNk5zNDJSSjQ4aVhsWFdZeUxYek45N3VON3EvVGZO?=
 =?utf-8?B?d2k0QndHRE9IVFVCM0R1RnJXVEdFNHN0SkFsR01HWm9tOE1OVFBjanAwN0FQ?=
 =?utf-8?B?YmZrYThYV3BVb2NHZ3Roc05ET1g1ejlMUVd6K1VPKzNVdHZYSDdUeWdQR3hq?=
 =?utf-8?B?T0FVV1h4UUxraThIdkR0eG9rSHZKQjQ0eUdCOVJ5UlYwRk9tS0lRYk9MSE1D?=
 =?utf-8?B?TjlGK1YyRGYzMmxiSTRTNWhUelN3T1U0MTFMb3Q3TkdKdGtxOGpMb1IyakFK?=
 =?utf-8?B?emVnK0ZGWDcwT3pRZGd4VGhnWkNHRUJNeGFpdEpvcmxtZmNJTmF0dUYzRUFN?=
 =?utf-8?B?SGk1QXFacEZZQXBmQ0RRZEhXZjJPa2IzRGNRdURtNVk0dkJUd3dXU2FLTmVZ?=
 =?utf-8?B?VmhJbVlHK2tRS2ovOGFYVHJrRmFKZGlwVDRndEVJTjdKam5namY4RXpLRDBl?=
 =?utf-8?B?SFd6M1Z6T1hZVTdOTTc2V0o1SUNGKzBzRVNsZjE3YWt4YXNMblhYbE9TajBu?=
 =?utf-8?B?TXNrWFJ3WmdyaFg0WlV5TXRzRE1US2l3S0prZmpiMkJOUDZqMmJ5Tks0T0VF?=
 =?utf-8?B?ZGZzNER6dWdTM0lGMG9kTXl1RFA5MU9RV2Mrd3BoNFMwMGRBZ1laTXhvNlhu?=
 =?utf-8?B?eWFwODZqaXRyZmdnc0I4cDRYUEUxL0pCTWRkaHlzZVZBY2FqVnRSbC9Ieml2?=
 =?utf-8?B?MDVRUWJEZkFCeHhGWFZjK01DeUpKZEdOWTNHT3dWUWNRVzIweUY3azZtUWF5?=
 =?utf-8?B?RUZXVTY2MEpWQitST0w1QytyUU8vRDBldEx2OWkzd0Y4SGlhL1BjeVp3LzFX?=
 =?utf-8?B?SGlYSDJvd1JKK0g4NEVGWmNoRkRpamhCTy9iNjBmYVhOckpiY2JrdzAvTE9t?=
 =?utf-8?B?bHdlZ2JEUlZBOUErbkRROURFRjlmZ1FIUjJoc2FVT3ZBOEdJZXJudlZHSWFi?=
 =?utf-8?B?M0xweWo2a2NmdDBOOEhEaUc3ZERncXFEOUJtQUpjM1N1eXpFM1BzaGtKVnpG?=
 =?utf-8?B?OVNBeXVCOUp5eGNlcVNvaTRqa1YxVEhIenFrdEpxajY3NHBxTzR1OFZWdmxu?=
 =?utf-8?B?eWd0YzgyZXVyejlvNERET0xBVU5sTC8xZ2NNSDhxVlN3NDB2d0QxVXVQOEg1?=
 =?utf-8?B?ejJ4dUZyZDJwNlhYTTllbFYwZjdDV3p0OTlpK1VlOXhndkcvd3pkWVZxNHJK?=
 =?utf-8?B?bkNyN3EwZ1JwbUZxbkIrSE9HWG9IcHlKT1IrQ05SWG5FM3BONFdvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5dca6a-3392-4fbd-37ab-08deac58ecdc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:51:46.5319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5es+H3fPZHkA4Yr4V9oCRpFzNi5c6obSGEckuWkUmgNXtAF50by+S7DvZjep5m4BDR5KxTkoodX9Qxy9CXIVEzy53k78WW8WRectY1zIYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12110
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

Hi Charles,

On 5/5/26 3:34 PM, Charles Perry wrote:
> [You don't often get email from charles.perry@microchip.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> This driver depends on DM_I2C and DM_SPI, add it.
> 

Wondering if we shouldn't split that driver in two symbols, one for I2C 
and one for SPI such that you don't need both if you only have a device 
over I2C/SPI.

> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>   drivers/gpio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 37cb672697c0..3ced3fb32f24 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -309,7 +309,7 @@ config MAX77663_GPIO
> 
>   config MCP230XX_GPIO
>          bool "MCP230XX GPIO driver"
> -       depends on DM
> +       depends on DM && DM_I2C && DM_SPI
>          help
>            Support for Microchip's MCP230XX I2C connected GPIO devices.

Can you update the help text to say this supports SPI-connected GPIO 
devices as well (the SPI-connected devices are listed below, outside the 
git context but if someone doesn't know better, it'll be difficult to 
figure this out)?

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
