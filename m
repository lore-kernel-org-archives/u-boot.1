Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C33EC43638
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A848460E;
	Fri, 26 Jun 2026 17:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ix7KD37m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6F384979; Fri, 26 Jun 2026 17:05:17 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB76C8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veWutpsWMJd2Cl5D4taww/6Wb2ixEzXh6hKLjDk8qXwEipbgx4KJa9R4rR4T4jjgzZ/eM1BT5jva2cPWyzS/24hciC7F9DbyKHq9TaxwzOtRF6qlDuMQm0QErk8OppY3+5lcdWAI+njamQOVmi2piF2RwFaXH2TwcqosVW9PGayWEoZqGzoDAtT97CVzYcqbn1Qv5VqJ+0gPOr3GomsH0XajZxKfSD9WFezk8ingXzmBofpo9y7Nh3dM936Q31iNDPksDZ3WHjSHQpKbtPI0T8CBpnIGlxkOyoKLXtwucRSGBEGkiyasCQtlRAIlUk9lJVcBEMYSQpyagP8IGcZIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1plwpq/MMkVgj6CEe2u/bov9U3Y4y5SRyzLjFdz9fT4=;
 b=CoVHlLoiAJcIyZR0MUBNXsML84ZM9FlxLuhD5cy/K9jc1Ecl7xCudhSGe9NhGUvgqgt3pPrjy3CwO/B2u2G+uEfFlM8ngHgLGD7UUNuwpYp0NGXssMurEBpOxK1Yvc4JrlIX4JfqnJ4lFI1SYJrUIKS4d33hAiGLNTvmeRC69YmiP3yJe1up0/O2LUg9wSDDeR+U/vsy/lYvRvHBIgGYvNlFUpfgguZEaI9i982o7UcAEAHIG6uhBSwJwK18vq0y1aPW+Ki56vx/kuzE53qXK6pKPAsTEJ69O8GvkXcWECQ5UNp5PnjsAy0DS9xCUo7roRLB66SjmAbM2byAQYxc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1plwpq/MMkVgj6CEe2u/bov9U3Y4y5SRyzLjFdz9fT4=;
 b=ix7KD37m+jDKHnbMnUO70ddQfP9vp3VUl+5IfPxaQOv/YSssRimG2P+UjujRn9JHR8ezxHANiBw55wLCgIPrSkdNja95cwNyV+0m2JQL5umPp28xQPI5w7+MCifdJV0T16cOZnupLqZO9HMBGwXN6bOhuzs+7AEf4wISBzlaxY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB12005.eurprd04.prod.outlook.com (2603:10a6:800:310::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 15:05:11 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:05:11 +0000
Message-ID: <1c6df9e1-4c44-46bd-a400-c6ecee9ac5bf@cherry.de>
Date: Fri, 26 Jun 2026 17:05:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] docs: reset: document cold reset option
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-7-dmukhin@ford.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260603070743.1268544-7-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB12005:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c778b7-c32a-4f07-fce5-08ded39451a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: kUzNci0tmLCp3mg//93XuYL3CZNDQA36unCHZa85bXiNAZnba4N2W+YpupAmDCzvAWwA8A6S68+/hbcQweLQBkmnHLz6rmjpNfojPUQkk+U3p2leqkyA1qS9Y3ts0xKV2gbKIrI9CNviLfzmse1+uRIsbEV5dvjPikCG39VO68wCDGpToOCrMBmREGKKCeYVbk3xJQfkrb1kH+HCf0ZCUZWxR04SJ4VJoXA6uTTP7K48JjVEZ3U3LvZ2YtybcCPlw+pCPFP+herNnt7RINtAlqKNl5hyP0+ixhAZcg/sKIaP3wRVlVU0o6XT+/2bN7/KUunRrU6AMqIwz2iiCCBIO9lyodmsdnDGAQ8BXcUuGbZlDY65KMMP4Tu8zTGxN7GQNc6i4BPnEIrDwTm3CfZozkr/pqn3898TXSgRQyJ9cOrjVbwx0HUEppgRAzW4o0MIHA5DN6+6rwMbuIrW4l+19aR1W2GH7xPYj4sVR+TAXLJsGA77y59X0b1UkUbhd82Fq9BpWgT8LlRo1Jab+AV1BbApwdNDqajrkfh206AhgP9bCcSfkxYQjxQproV+ureRlkTD9kFmeU3FPE7cgGJ7GK82KP4Nc5Bcipyu+AIQkgWliDR8JcbPEgD2g+iYMbtXsk8Ns4/f35mRNY8KrkC5q71/X6/oxYxRBy1+hgYk8po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVPdmJzR3ovYzAxVnVjWWJoQW9BcXBuUElTMHp1eExnQXNRMXRtTk90TVM3?=
 =?utf-8?B?dURJdk1KZG4yTm9wN09sai9WN3V5YU12NkNBYk5acURZQjljcUlwMDRjODJR?=
 =?utf-8?B?Q0QzcWZHaTVQdW5oOEMxdU53bWJ5V3ZraEl3bVlYcmEwVzMwQUFSWGFhcmpB?=
 =?utf-8?B?cE1jQkRuWStVbFU3SW83SUIxdThRcXNreEFSYm5Bbm1mSUI0N29SZkZ1ckwz?=
 =?utf-8?B?Z05wejhDTjR1cjJWSVIxdGZPdUlQWU1CNXdnUk1pbUJUUHhtV0IxSGpLanMz?=
 =?utf-8?B?Vi9SRkVEUXgyUnl3Y3dYbkNwWVVaWFFTd2MvcnBlTVdNb1czYjlZQVpiak4r?=
 =?utf-8?B?Kzc5enFpaGFUSXE1bWJZUS9tbUxQQ3plK1NybjJqd1IxRm9UN1J4SkFwYy9V?=
 =?utf-8?B?aEkzTFZrQ1NZY2JjejJvVk4xVTBleWM1dW9HQXhMbTUxL3VDZ0pQNFdGMHA3?=
 =?utf-8?B?OWdIMCtsNHVQYStPZ25ReXJKQzBwSzBZeGZRTUErbWhJUWpreEc0YnY1d1JI?=
 =?utf-8?B?bG9yODFEMzZPTDFGWGFPbmM5c1JMeTZOdnhEb05nWWdDTDFLZmU1eWU4UTdD?=
 =?utf-8?B?eE95ZWVSSCt6aGd4UHREMG1Jd0M0YmtBU0hFSjhlcEZWYTJFNDc0eWhPRWVB?=
 =?utf-8?B?QTk5czg2Q2gxMEFyN1JrdkFtSThXT1FmZ3FLUHZUK1JBUTdWWjduWDdWVS81?=
 =?utf-8?B?UThrTU82SU9lRlBQbmRuMHBjM1VaVWRXU0MrR3RHbkliS1RqZnBMSXQzU2V4?=
 =?utf-8?B?Y2dtdXpMRncvVnE3UHdKamx0YS9OZFJXa3JmbzhjV3NYTWVYK3Zwa0xoSWg0?=
 =?utf-8?B?T00vTFBaSWlTZkxSS0NJaFl0QU1UTGhGVkxhWUx5bTBKWDFrc1FjeFBnb2pq?=
 =?utf-8?B?elZIUFdtNTRsYkN5SWFmNTJuZzdiK1VnOGFSSjRHbWNBVmx2N3c4WGJFTXNw?=
 =?utf-8?B?VEJOaS9sRmcxdGlBdVBMT1lHME9kcHdidEhFVnlhVGdWaHpVWVQ0L2hWY1FO?=
 =?utf-8?B?dzFhMHMxQW5GajJISUlGczd1ZDZ5MWl2OUNxL3UrajN3SU0vcVozMUVCWHR3?=
 =?utf-8?B?bmZJaXRYU0FsUDE3TVhrQ2FnbTZFb2Q3M2JVUGZicEVsQkpjRVFqaGFpd2xX?=
 =?utf-8?B?WWI0aEpvWVJwQlgweXd4Y1lDSmNnWjFYeFY5VVFiSGxORDdGODZFSlI0Wkw1?=
 =?utf-8?B?K081VTFMd21kZXJQZWhwVHdDc3ZwQzhXa0Z3SDZDZGUrZkhPUmJUWHBNd2hH?=
 =?utf-8?B?YWp6LzFDZHVKNWNvTExSZGI5YTN0RlhWRHhmTGpseGZ3RDYwWGZVYXY0QnNK?=
 =?utf-8?B?bFNTMUlCRzhQY1ZEdDBJTWluOXArZ0ttT1hlSnFnNXVBeHJVUW5GSnBtMEtn?=
 =?utf-8?B?NjRCTFM0Umlyb0RDVElQVVdhQnlXaEJLaVM1WGhDWmtQWGNiZDU1em9TTWJB?=
 =?utf-8?B?cU9pMzhJdm81dE9OR1NPSm1jOXN2bHUwZjFmVVJBUEZibnpUbzVGZ2NUUVRx?=
 =?utf-8?B?dGE2YVJ0SG1TTWJjUmZ2eUN5Ryt5aC85YXhhQ1FpQmJxWHRiZDgraktQRU5h?=
 =?utf-8?B?cTc2YWd6SEsrNnI5dkpGTzkzNVJvb09BUGFxRnEwTytJVTNtQ1FHT0ZjUUR6?=
 =?utf-8?B?MHY3UEZGZ3ZteTQ0bXcwQ1EwY0hncXo1Sm1PSGZQUGViZExhQ3h6bHZsRFBF?=
 =?utf-8?B?eEExc01RbmxnSDllcVZFQTB4RzRseUt1bDJpZEl0N0R6TkhjemN0bVBadXll?=
 =?utf-8?B?TzRiUmxDTllsQ2ZFSmFLdlNaVU1ZYzYxeEVnb1FzTUhmR3hPTGpWTC96YUdX?=
 =?utf-8?B?YjRGT0g0Q1I3cVpQWElJdzN5bkI0M0NVakRTSytrQW12SSt6RE03RXc2bCt0?=
 =?utf-8?B?R3ZQdUQ1dXIwdG9MZEVvcEUwT3pTYWF3RFBoeHRFSXRkaHozVjc4bFhBLzIy?=
 =?utf-8?B?Q2wrWjA1Q1hzWGI5Nm9hS2pkTkgzcVRtUHpza2VlQ3RzZmdmaUx0Y0p5eHhW?=
 =?utf-8?B?TTZkcCs4L01WMlVoay9PWDdBckc0YVB4bURFeGtVUDdhaktnaXV4U3g1cjFW?=
 =?utf-8?B?NlFTUWVJL2VDNGtGdXpZaE1jMDZUdTJsRVNGakJtTUxwcTgyTXVjQkc5Tjkr?=
 =?utf-8?B?Tys2WlphNHRnZ2Q3Y2t3MzVIcmVDZWF2RmFEcUVudFY4d2Y3dGNncG5yR3Qz?=
 =?utf-8?B?UGhZWk4xZXpGWTQzVkhCWjVQbjhBZ1Vic2VHbGYwaW5HZ05hVjZPMzRqdmts?=
 =?utf-8?B?UUlncGxiS2pYWldGU1RMelVWRnJydkJzMnZra3JtZXRZMDVydWhTR2NXR1VR?=
 =?utf-8?B?VnBNT2RnNmlWVXNBNXRqQkF4cEtJbktCdlY1SUh0ZERNRE9Fb0RiZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c778b7-c32a-4f07-fce5-08ded39451a4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:05:11.2839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS5i3eSW2/DiV5L1Nxx6HF73zOubqWPUMDHIG5MhWftEEP6k7gZRjG+s5ZMQ+9dXVxm4NktOIVwOjl6BSXf3phl9ATQm14vjX2wFdwySfCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12005
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

On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> Update the reset command documentation to cover 'reset -c' and explain
> that the default reset type can be overridden through the relevant
> Kconfig choice.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v3:
> - corrected description for reset command
> ---
>   doc/usage/cmd/reset.rst | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> index 79bc8b9deca5..660527d0b8f9 100644
> --- a/doc/usage/cmd/reset.rst
> +++ b/doc/usage/cmd/reset.rst
> @@ -11,15 +11,18 @@ Synopsis
>   
>   ::
>   
> -    reset
> -    reset -w
> +    reset [-c|-w]
>       reset -edl
>   
>   Description
>   -----------
>   
> -Perform reset of the CPU. By default does COLD reset, which resets CPU,
> -DDR and peripherals, on some boards also resets external PMIC.
> +Perform reset of the CPU. By default does COLD reset unless overridden via
> +Kconfig CONFIG_SYSRESET_CMD_RESET_DEFAULT_{COLD,WARM,POWER}.
> +
> +-c
> +    Do COLD reset: reset CPU and peripheral/DDR; on some boards also resets
> +    external PMIC.
>   

I really don't like this. I'm afraid we'll end up with very different 
meanings by architecture, vendor or even board. I'm not sure I have 
anything to suggest though (and maybe we've already reached this issue), 
so this is not a NACK but phew, I fear for the future.

Cheers,
Quentin
