Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A7C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 07:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCA787061;
	Fri, 23 Feb 2024 08:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5FY3Mm8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F9D876D3; Fri, 23 Feb 2024 08:46:29 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 202F88701B
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abCEWhvmXiesUdVy0lU/BQg9s1j0knk6O2b0UfDRtxEUdPbansz4eRqM70ArSeUMxONy5rA2BUrzXtbHRbHPFKcl7D2kOdZlAk3WRtJ/H+wvCZyhDeLDbVQfu1d6adx5fwNmt7EswoJLBhnVYrTeZ2iWtRTpRcjxiMoa6VTPDv5CRe+reRTtMD5/J7dta9oJIJw0Rrdov486HObPEruXRKlbcoEcDkTaa2XMlZCwVQ4acGN9OcldRGPSyj1xMTk1XIAm6ASXgSRziwffHFKIeRNJhAu51MEm22CE/Gfn/eFw1N829bICH1yEt/idoq27CY4hBFUTw9CaJO+Yd9CXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykP6FSAH0EoycR3lKcxVEW/u0QSi8GxMeDFqd9wYznE=;
 b=Kgnq3+P5EU7KX4NgX9OIjAnpRsfP8fsMykFf0WzmmLbvO9jv5YV5rz1/F8w+cJKPWLO88ngAAVc6BFYgDOXzsZ8R7y8zTBfJd6wblXICmOoLlC65egxSydhGiNVq0b35DDjGJNHAUi81iR2DzTfKU/KGz/O/CWcgFgapdlqWpIH3+70yi09xv32GOo89p7dOkJEwPLaP5OhtNHxw2WVJjbTyOMXyGjWcFvTZrYX8JsRIj19oz/sxGHsd5ruBubMFrcwzwwsiZcE4hXfNAZr0rfCeW0iOHiS8Pm56bd5TDfUfW97ImbqGq+mks4E3B56xX90NGjjcqZX4YbXRQ/TeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykP6FSAH0EoycR3lKcxVEW/u0QSi8GxMeDFqd9wYznE=;
 b=5FY3Mm8uL/PNkp73VBocmunBBgq2MralE1rvXQKxq5L/REXvL13hWo1mZuYvH+roua5Z7/3EzLcW1nOGuRn8QHwRCy63MUyqtBoip9LCvVlvmZ+EthMlzL+oHaAVxwEMXSmM4s0METskgOkAmQZVsTcOdvUkqlfNHBmGSX915fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 07:46:24 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 07:46:24 +0000
Message-ID: <3b4cca93-2fba-46c9-94a5-654f1db8faba@amd.com>
Date: Fri, 23 Feb 2024 08:46:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] arm64: zynqmp: Support semihosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
Cc: Sean Anderson <sean.anderson@seco.com>
References: <20240222200512.2679830-1-sean.anderson@linux.dev>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240222200512.2679830-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::25) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 177bcc1b-cd0e-4ad5-b6bc-08dc3443887f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ1Sh/Y/TTpm9eOJ5+sOZCI4mMW2V4Fl0zJjBTCbX9TMBUkIfW/Xc8H7kd+6BkKN5uFB9/lWIruSGj9ZWF0dYPb6o8NZkmEporp7Mf2vP1Qp7wVe3xSobqs+gtcuk60vQqfuNvTBWADKFslR6cH8N5hcUu6YiGxwe/25SlU4i32VOItzmKT0KXlw1NPexb7rB68LWmU6zlPlf9FRAr/0tAX03j0z95ttkJKijnd1CEetTL1QDa/g3cN1D/4Fu/RSBridC12WBbMZ1fgu60koShT4TDT/+1Eh2+YX+EYoYb4xwqyPCsl46hloalkMwLALzEGq9AduuCjCqcH+KuAio3+kfLbvo+DzLE5OO5//5n85LoozhdPZB19xj/d/n9/2CZzkNnJPCUkN6L8YjR617dfYa6T4rVMO8U6Q0r+a8A8ileFvyzEjrp6nyYBce4W7sQQy7SdSJ/jMCrlt6t9Uv3VfYSQYV0WBR3KmOlFz5Svd9Hq/hNtcww3nz/BGAFVWbTFt1zyfFDv9dgWM2XoLb3n6cRBznOsglG2BoaVHaR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUREVVhuY3JNaEU3cmU0NE9CSjhMTGlZaTJsOVJaSnlOaTR4dWcva3BvYlVl?=
 =?utf-8?B?d1lKd2p0aFBwS2RFY0RKb2NkK1lkRFQ0R09CMTFsTHZsSHVEZGk0VUlNVkMw?=
 =?utf-8?B?MStLUHppZWNUR3BrSmgwdjl2T0JGUEtHQllVaVAxcFMzU1hoTEdrRWMra2tt?=
 =?utf-8?B?S2lXRENPWEoxbUJpOGRxQUpZKyt6a1JzMDUzaC9FbHRyOHkxTFV4VVhUODN5?=
 =?utf-8?B?Ulp4YmhuVG1LcWlUamN2c3FwQ01KaGVOS3NvVi85SC9JdWh3UmtTVTVMcTN6?=
 =?utf-8?B?Tzk0SHlZMlNoNDU0TEYyMVBta21zTFlkUldjV1VvWHFyTklYZjAxTHFiVVZN?=
 =?utf-8?B?eFBWTDI4TmtzTFVyOEZobExkSGE1djVGQkIrMFc0R0VTeTFHMXR2YVl4YlR1?=
 =?utf-8?B?QlBJTXdDVG5jcGtqMFVaTThwTVltRTZuV2hFT3Awa29hQm83TmtGckVFT0ZO?=
 =?utf-8?B?Y2xzSXJGVmNlZjJ0LzliMjNiWldlWWRnc2NRK1dYYW9nMkx3Z0FhaS9aNW5t?=
 =?utf-8?B?SUIvdW94L1VlZHZqMVp5bGpLc2tpL3pBYWFKYmZjeUtrZWYrUGlqbU5wNDNT?=
 =?utf-8?B?eWF3TkNOUmR4TmNCS05tMmhtS0tHSENUVkF6Ly9IQUd5dWdCZ2l1WnhmVk9O?=
 =?utf-8?B?YUxGVzJUNWVIZEdGQTBJbXFRZ2FnS1ROUGx6ZnJmYUFab3NjSG5rV29xRkdX?=
 =?utf-8?B?dUNnZ204U2NCT09aU3pMaWVIczc3SEN0U2lGTjBjWTdFVlR2T09Fc3ljU2NY?=
 =?utf-8?B?SmVLdSt4VnNweTFNSWUvVWFSNUVXQjBpS29yMjNiSjkzeW1JT2Q5aVBqaDlm?=
 =?utf-8?B?Qk1DcWVGdXZDQ3VRM0hDUVRvY3hxejRWeWVTRG0xamhSRWNvZm9aazVTTEZ0?=
 =?utf-8?B?MTV0cFlIMldHV1RSeHlnMlNhU2FjOHpzMk10Qm1UbW9hTEp5d25CQ2ptaFZP?=
 =?utf-8?B?b3lHTzdNemlOeWw3Nk9zRTJZVEZ1dHhMK3BBUjBPektEVllIOE9ScUNKZjFD?=
 =?utf-8?B?WC9ZRk0yZ1dmclM2aG84b0hlV3g2YjVHaWxLMk4ySkN4L3lRUWVMQTloT0F1?=
 =?utf-8?B?bGFzVzhZMWlRQm1xSXJVcVhWT2xLS1VXLzBFWWlWY2s0ZVl4RktnZGVCYjhY?=
 =?utf-8?B?bDd0Yy9NSW9YSlhQZUVueDdkUlZsQkZCd1VnaEtzdGZDaURXcUxhZm9oenlK?=
 =?utf-8?B?VW5TRUZmckhaZXdKK29vWDFWOTE4dWJLcm5ZUVhBN1JJTHpLUWpsNE03WWFj?=
 =?utf-8?B?d3gwUmY3eCtOSFQrQzFPbGZuMk1JSXdpMXJ1ZmQ1S0Jza2pkNnZhRllGWnFN?=
 =?utf-8?B?MVBhQ3VubG1hVS9ENmRHUnBDbGt4dzBXbUxxZHFKRU9ORERUWUxscVZNY0lm?=
 =?utf-8?B?SmliWUJSS3lWQURSTHdySmRNa2JOalk4RnRmdU1wa0RnYklwQkJSQWdRZUZo?=
 =?utf-8?B?L21TZ3ZnSHRNVjBwTDFXaDU4YXQ0aUYxWFhrcjA0dGdiL1BQVVNtQ3ltelJJ?=
 =?utf-8?B?S21HanVoOHFxN1N6MGRjZ0lUZld2YXduays3c01JS1FBUi8zWDdjWGlscmhq?=
 =?utf-8?B?YVhRamdJMlBwT3MvaHFqWmJpOUVFd0ZZUzhmTFFxcFl2QytuK09wYjlCUy9O?=
 =?utf-8?B?a0s2Y1FlTjV2TXEzQzNVQy9oSFB1Q3lEdXNmZDZsU3JsWnQrZmRvMTlZMGdU?=
 =?utf-8?B?SDg0dFNSRXJYekJScFJET3dzdkk0eHM5WU9oeVhQUWhvTFM2Nk1XS1kzZHdt?=
 =?utf-8?B?azN6MHJ3VDlKYXRSZnRwVGNiUWhYMFBNbHA3d2hhWEN6dmxueVFON3NjcXNo?=
 =?utf-8?B?bEF4RjRtV0dIcnovQ3FnaUFHM3RlVVNKak9JTjZjWGhsTFRMQkRLWlNlQmdl?=
 =?utf-8?B?R3hZc2ZtUG9Xay9FSDFSVUVMcjlzQ2hrNGtkL3RtZmcraFAxSTkvTXY4ZjB2?=
 =?utf-8?B?OWFPTEVmWmpNalY1NjBZaXhXaHBWaGpSUzluTDdwcjNnQjJwZDR4b1d6L0ow?=
 =?utf-8?B?YzUxT3JyRGVjNmxONzdSd3hhb2k2YmVNd1VtdENWTnZTVUFVdGtuTzJEaFJN?=
 =?utf-8?B?VktOSnJpWjhvKzNkTXJzUEZ2SWxlNFgrQk0zSHB3MlFaOFJQZjc4K1J6bzVi?=
 =?utf-8?Q?vRgWzAwI5w+vkYTiWNoq9qzeO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177bcc1b-cd0e-4ad5-b6bc-08dc3443887f
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 07:46:23.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGptJT6NYDjyDu+tEJ0a7IDd05GS+BKEobu2+Qi/A0caogssGKqqudUHZMAaLQ9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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



On 2/22/24 21:05, Sean Anderson wrote:
> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
> However, this is a bit tricky to time, since the debugger has to wait
> for SPL to initialize RAM before it can load U-Boot. This can result in
> long waits, since occasionally initializing RAM (and other things in
> psu_init) takes a long time to complete and the debugger must wait for
> this worst case.
> 
> Support semihosting if it is enabled, as it lets U-Boot tell the
> debugger when we are ready for the image. This means we don't have to
> wait any more than necessary. We don't change the default config to
> ensure we don't break compatibility with existing debuggers that don't
> expect us to hit semihosting breakpoints.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> I'm resending this from my linux.dev email as my regular email is
> mangling my patches.
> 
> Changes in v2:
> - Fix typo in subject
> 
>   arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index a0f35f36faa..5af735aa5ce 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -9,6 +9,7 @@
>   #include <image.h>
>   #include <init.h>
>   #include <log.h>
> +#include <semihosting.h>
>   #include <spl.h>
>   #include <linux/delay.h>
>   
> @@ -66,6 +67,11 @@ void spl_board_init(void)
>   }
>   #endif
>   
> +static u32 jtag_boot_device(void)
> +{
> +	return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
> +}
> +
>   void board_boot_order(u32 *spl_boot_list)
>   {
>   	spl_boot_list[0] = spl_boot_device();
> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>   	if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>   		spl_boot_list[1] = BOOT_DEVICE_MMC1;
>   
> -	spl_boot_list[2] = BOOT_DEVICE_RAM;
> +	spl_boot_list[2] = jtag_boot_device();
>   }
>   
>   u32 spl_boot_device(void)
> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>   
>   	switch (bootmode) {
>   	case JTAG_MODE:
> -		return BOOT_DEVICE_RAM;
> +		return jtag_boot_device();
>   #ifdef CONFIG_SPL_MMC
>   	case SD_MODE1:
>   	case SD1_LSHFT_MODE: /* not working on silicon v1 */


Applied.
M
