Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E575CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F8B84A81;
	Thu,  7 May 2026 13:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ffDges61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4569384A85; Thu,  7 May 2026 13:30:27 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC96B84A6B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nurmMjzmEgJ8XCA0SFgUpCfjctO4aVaGix9EcyCSeYJ1f75/CyabibLN2TIKxZsLUE94y8N8UBAEMmf/lT33KPwH3e9swdWgvMiDWm8CPHCeSLLpfQFmm4MaPXORBtua+6E86qB8L9ckcbD/9z1Qun5ZFJmRIXgtu/5olfoxKNQib8BCfL8UYGfjFS8hbtkYOviwMuFs5A79t0xdDltRnXSZV/vTzEwshu5El02z/nw/tynifCotWxk2Amt8l6KXJVI5ZNZV6Jo++swxOsZOW7Emsd7B64SeHtUAorTwZ8/7HxFDVcqE1gk88WBHOEUN+RPUSfaJz1se8L33yR5fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiNliZSGHscYjUle0DzDeGjtpa7zYau1QES4xU76p9Y=;
 b=Zkm8bN6WYa34MiTMghamNEcoI7HyRFZVHEpslOz3spFwgi1C/dyecePlr6QKDG5XFBHGhjihN+Aq+g/l7WTOTdUU4UVT4/gcqtTlyNEdSicR0jhUHxjFT3f5Kg10UXkkGk0AvsnmT2FIfsQpXLeK1UyRWhaXWPmpJSsolQDmqGvjnDnNCXykZIdzSsHhOOdNzzmZ2Zch9pyQzkQibg8/ZkM9WULPfQwYRL8QxYMwBbK9s1bUGvl1IGVuX68xb3z106Eh8nc+omVDiL7u9QmTsefuRkBkttaU1tIWFRXJQZqf2+Z0qX6PBw40dtb9BfgZCYXSi2opLApp6j+I/6zEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiNliZSGHscYjUle0DzDeGjtpa7zYau1QES4xU76p9Y=;
 b=ffDges6120u1lBo1yrbpYw5dNbUbAwb2j+pRZ2h+Z9jkmmtletoTJdIrsMVgYWIu+lFXWd7a0q8ZkRfss1IHX+CrNJWf5fF41UlIGtI4vtNI9mAFkNKr899ZXRjAjoq2ecNNg5aPC9KWU9qRwwYy9JLk1eq5vhV6cepRDMbmvAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by FRRPR04MB12569.eurprd04.prod.outlook.com (2603:10a6:d10:1cd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:30:22 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:30:22 +0000
Message-ID: <553ba73c-8a90-44e3-9809-185b0fdfd2ce@cherry.de>
Date: Thu, 7 May 2026 13:30:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] sunxi: extend binman FIT description for signed
 SPL images
To: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-6-lukas.schmid@netcube.li>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430223319.2663939-6-lukas.schmid@netcube.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|FRRPR04MB12569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae91386-dcf3-460a-ae95-08deac2c06c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: Xax3CDxN5AbEMWJa0C2XeLRFIkymH8HM+03Kk8DNK1rSVCJ3lWXsx/Pe9/XLorqjCmsELaZ5RYvjKUUnbf02TLeeoEFh+22hWMSKfsExGYd5am0B2L4RQYJ4zhTGVp7nL+adzUh11mKTIeKVUQ+nHzQqF2beu1zEBSlbheE6RHdnk3D1B19CPgS4QMJjFnRO6CR23cjDqVQMXlYSh2YfNQyRt1S1/vTmo7yJ5jyAqqcowpegA+b/NOyQuuAIEwu1K0DRg0B/yZLxYG1stpfsUQ7JdZ8RxtKAFco1+oay41hgG4JWwVFekKJ6gFu63MXJa2zpe+h50PNyGZYvmN16nRaQdQic00nlfgj2IB69fB9Dtc94pQcwlalZdxYQ8blrifPOQkp6sDY8ijaOZz5ywrzZrkz+5AvyGbgGBPWO1vl9jBGtYV2RA2QGP0jCDtBmq/dma2dLEruQwPNonouUQHLU29IF6N/r899JzLnjPkTLMcb0j7fhCUw/iqTWTfAUs6gufph5JUVaZE9sFAUV40cWHy+Dzfjj6ZJe2dAzVvU2skbFB6n9WBrMW9UDLonSXcW7MQjCAW23QccDVZMvn84EsktXSk0jcRzvPL3fOwl4xkLKdiW9pJ7it6C1uNFJTD1tZtRMbzSZAdoZT2lnEdh+uN7FfhGjH79K7NSwXuFDlCNLGkLiTEwH48lK2u+1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxwWUp2VWlNUDN5ZE15TThVcGR4ZWR2dTRCaUZDQUVMcjVnQmUzQWtQdlV5?=
 =?utf-8?B?WUdLaDRiTmhBYkZQalptTWFibi8yU2NCdkNTKzVrclU3aVYxOFdITGMxUUFv?=
 =?utf-8?B?S213MXB4a1R3Zm4rN0FXZzNZR0kvZDh1RXhKTEthV0t1UGRnVVBWck5YYmZi?=
 =?utf-8?B?WXhEdW0ySmZwSGF6cFlmTm9STEF6UmY5QkZORzg3b3ZjMmpDekVHdUFRYzI2?=
 =?utf-8?B?YW8rVmszaGxYMmF0UThOS3VTS2hENU5ndnQ3STBtQ1pYUnQrM0dyNEJPNHhp?=
 =?utf-8?B?VnZQZkNnT3RJbzJiOXdhamZNSVd1NTdwbS96TnFpUy80Wnc4UXhxM2Q0emU4?=
 =?utf-8?B?ZHpqaHREU0p6akhHQThmU2VMZG9rampvL3dPcGVpLzlENlZMQllTckIvZkZ1?=
 =?utf-8?B?SEMwZzE0eG1WSml2ZEF4RndzdnU3Y1dYeWhMOWxRQ05vYnF3dGQ2RG05ZnF0?=
 =?utf-8?B?ck90eTF5QTIxSGRFbERuVUh5Q1BiVTlDM1g2UnBUcHZMYUltQlYxTUxqRDN6?=
 =?utf-8?B?UUdlbExMZnhSVVZNUFZjblFnTGJlTDFlQ1N5UDNnbjdZWm5uU3Y0c2ppYnJv?=
 =?utf-8?B?bVVza2FQYm9rRVY1eFNyMHQxYjg1dGZheko0QTBtM01NYnVkRFpKUW1CZ0xI?=
 =?utf-8?B?WFRJN0pBZElCaTZRSUFSSFVSU1R6ZjdFTXJhUGl6bnJqS3pmUjFGcFlSL0FB?=
 =?utf-8?B?UkZWc1JUNFJtak01NVk2SXM2cFBCOWdJSnNVSHdjV0VtVUIrbjdaUkZIQy90?=
 =?utf-8?B?bTVESkIyQ2ptVjM2SkdwRGpCeTZFMkRRMGpMeHB2VmFyZ01nRjN6QjFkSCs0?=
 =?utf-8?B?Zk9zQ3JJTUgzczhxRXFKMm1UUnBBb05TOWl6cG5HZ3VBbG5GTTNDRnNsUmp3?=
 =?utf-8?B?T0FTT25Cc1lzVFRSYW0xL1o3QTRoTm9pVzY3dTZpbzBDazhzSm5CcFpNUHN4?=
 =?utf-8?B?OVhhaUhYYzhZRmRtYWJmNitzNXIvcFJJMW80NHRETFdHbXVEdmpHTWZJSS8y?=
 =?utf-8?B?aUhZd3hlVlZyQ054UVhrNWNuN3NmN0Yrakw4RzFLTG1zYmlsN2l4R0NIaWFn?=
 =?utf-8?B?cEJXSGU5WXptRy9ZWDhYcXRZMVhRSTQwN0RxY3RrTUtJSFJueFhiS1N1S0Nt?=
 =?utf-8?B?YWFEWjdSUmRpbENGaE1QeUhhUk0xUGpiYzBqMk9mMnArZmtHb1lwV2lCejNo?=
 =?utf-8?B?cjVyeVhiVk1JaTEwWlB5WW16ZXd0OVZnV3V2VlByM052UGdBaDNxWmsvb1ZJ?=
 =?utf-8?B?cDRSOTFyTU5pQU94b0RQWGRCdXZxNUZmMWEyS3NlSVU5YlRtTmJHM1hObTFo?=
 =?utf-8?B?QmZ4cFQ1ald6WVBrVmZJVjlwZEg0K1J1OThDSGhKMkxpeTJ6d05ZeUtzYllV?=
 =?utf-8?B?ZzVtdWMrRW9mT1NycGZnNVhialB5QWUyRDM1QVo3ZkhHRm52TGtHbElDYU9O?=
 =?utf-8?B?ZWVIQmNhbXRmdnRrVHYwbWc3MEZ6STdvdlIxaXFzYkJDODlURUVJYXl2Tzl2?=
 =?utf-8?B?OFZkdkR6SHlVWjJkb2NFb0tGRU50NjdqbjJrS3NpMVo2WC9CdUc2emJMTGJG?=
 =?utf-8?B?d29EUjIxN3puZFlXazQzNVpJMzhhblhTbU5MNnBkZEZ6WitJWVdab2Flb3dO?=
 =?utf-8?B?SGEyQ3hCNjRpYjQzb2h4dlpEM0s3cGpRdTI4ellnL3dNeThjVmVEbzhkbkEv?=
 =?utf-8?B?M2Fpcncyalhab1JHRVlrWnpFNmQ0MFA3ZkhvR0pPTHplb1g3ZFdKbXpZaytF?=
 =?utf-8?B?bVNxS1M1VUgwRG90TmlFdFBhZlZqQ2VZa1BlZWk3NjhEM1ZheUZnbkRYNlNu?=
 =?utf-8?B?aE9HKzVERzFaVm96bVVCZVhZRnIvVnB0bmEvSmtVdXNLbGN2VmJKN2ZVSGhu?=
 =?utf-8?B?bGE3NXhHeTViL0dUS3hOaGk2aGdML0FsUHJ0YnNzRjl6WHhNdEIxMW5aRGY1?=
 =?utf-8?B?L1BxekNGM2FKc2J2Wk9wdkNCVy9IQkx2aytHblJIOVhuRkhXemFaV2NtNnVW?=
 =?utf-8?B?ZUpmM2gwQzROUUhvaUJSMTh2eFY4QkZNWmZKVDR5OWNqUUVrNmMxdHJTN3dr?=
 =?utf-8?B?ZVFlNVJOY3ZjbnF6aWlETkdIQTJvcFFmMzgycjNmd3RnaVp5QU9wOWYrMEh4?=
 =?utf-8?B?M0dhcEV6M1lCMTd4N21pY1Y1MjBXTkc0SWFNSmhCRXE1dFdkdmVEZWFJYklF?=
 =?utf-8?B?R29iU2ZXcW1ncVZVZllJd0xWUEVZZGtCbDdET1MyY3YzUVNlOWNTZ1M2d1U3?=
 =?utf-8?B?a1N1RlpjS0NMWXl2WWpKVWlPT2Z3Zks5UE9MUFllUHlKajkvNDlxSFprMEZo?=
 =?utf-8?B?WFVrcVFVL1FXMnp2OXVTVE1pYWUyNXJGbGplN3Zxakl0MVpkZXA0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae91386-dcf3-460a-ae95-08deac2c06c1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:30:22.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iVABCdaOH7m672dbNtvE7AnMMrfC0VX5bJ5Dq5I4qLyVRwsItDw2FjTynb/wX2+G+CwCSgt1x+NqpFjIqvYhVEK2OLFr7iifnPGxWwnEhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12569
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

Hi Lukas,

On 5/1/26 12:33 AM, Lukas Schmid wrote:
> Extend the sunxi binman/FIT description to support signed SPL FIT
> images. Add an SPL public-key DTB image, per-image hash nodes,
> fit,sign support, and a configuration signature that covers
> firmware, loadables and the selected FDT.
> 
> Handle TOC0 SPL output as well by adding the required filename and
> mkimage wrapping so the generated sunxi image remains verifiable.
> 

I sympathize with the effort as I'd like something similar on Rockchip 
but I don't think this is right.

> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>   arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
> index e1a9a7f5d4c..313fcad3922 100644
> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> @@ -27,6 +27,38 @@
>   #endif
>   
>   &binman {
> +#ifdef CONFIG_SPL_FIT_SIGNATURE
> +	spl {
> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> +		filename = "spl/u-boot-spl.bin";
> +#else
> +		filename = "spl/sunxi-spl.bin";
> +#endif
> +
> +		u-boot-spl-nodtb {
> +		};
> +

You're missing

#if !IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)
                         u-boot-spl-bss-pad {
                         };
#endif /* !CONFIG_SPL_SEPARATE_BSS */

here.


> +		u-boot-spl-pubkey-dtb {
> +			algo = "sha256,rsa2048";
> +			required = "conf";
> +			key-name-hint = "dev";
> +		};

You're forcing the use of an RSA2048 key which is not recommended 
nowadays anymore as far as I know. RSA4096 is "better" when using RSA.

This also forces the user to have a dev.crt certificate to be able to 
build the image. It's not a secret or sensitive info so I guess that's fine.

> +	};
> +
> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> +	image {
> +		filename = "spl/sunxi-spl.bin";
> +
> +		mkimage {
> +			args = "-a 0x20060 -T sunxi_toc0";
> +			data-to-imagename;
> +
> +			u-boot-spl {
> +			};
> +		};
> +	};
> +#endif
> +#endif
>   	u-boot-sunxi-with-spl {
>   		filename = "u-boot-sunxi-with-spl.bin";
>   		pad-byte = <0xff>;
> @@ -45,6 +77,9 @@
>   			description = "Configuration to load U-Boot and firmware";
>   			#address-cells = <1>;
>   			fit,fdt-list = "of-list";
> +#ifdef CONFIG_SPL_FIT_SIGNATURE
> +			fit,sign;
> +#endif
>   

This requires the user to sign as part of building U-Boot and therefore 
have access to the private key. Some users may want to sign separately 
from their U-Boot building step such that building can be done anywhere 
but signing is only done on specific infrastructure.

This also doesn't allow the user to use OpenSSL engines for signing (yes 
engines are deprecated and replaced by providers, but the same likely 
apply for providers once we'll support that).

You definitely need to document this somewhere, likely in 
doc/board/allwinner?

I'll try to keep an eye on this and see if there's something we can take 
for Rockchip as well :) But I don't know how to do this nicely and make 
it "safer" to set up FIT signature verification for devices and avoid 
common pitfalls or misconfigurations while still allowing out-of-build 
signing and configuration of keys.

Cheers,
Quentin
