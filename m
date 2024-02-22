Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A12C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 10:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFD888076;
	Thu, 22 Feb 2024 11:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="R2/tUPYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44A28807B; Thu, 22 Feb 2024 11:18:20 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D746188076
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 11:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYfF8eU6uUCeRS5ep3p/o9TsfcVsVVtdEk9JdQYU0l+Krlnb5EqagSdg7JGeSFfU1nVGCWz8RalGFS6kcL5rHSi92B2MoOmtgeqqYI5bRYUYf5zFVZmh/GkGvvGGw+j2rfS005pR8KO3cnur+gz+Fdohd1viXhOBzoo1y4Qng3Etw30PCHN9SQkVUeJjXupNQ28e5QjOt8qDNPChxEdZ3rnCwH3EKgjTQelB8sR0G98O/r+CufeUC01ynxb1Vlyc/LmSiVZbL+3yyu7kYyp8/2lnkZXknWswk66PzFBp0TZBpM+BNoMEl0ifyMdExrxe5q5JcndIVqHId3JzwJY9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbF2/g2MuXFgoDBv9yPcgPu9XYyYCHXjbL8JUOnbq98=;
 b=eIu7uOHic5Sl/vYIBepLpABIas57nF0vtEFAODpn1rNQz9V9J9JSJsSpi0+VTivZesxPbCqTdICrXqUkABe738S1o2ICmT8jrwoRnK9A8rWFzDJE7uRZzh4NXh5BDsIO0Ci7GFXmCen7EnZrdAGWxxWKgD4dnQWYqnmlneQc0K/FA/btqfxs0ZE3wWfAuDBTyqjjOPnPLSbE5vlJNHRkLAPL6f0KuTuKCkO9zbn3Sw6VeiTW+jBVmzwpKqPDotu7cXz5/+HVYdG3n3b2phO+Q8qtW7ome3ZA0cyAkw/Nhbmkyn7w1iaDsB/2pskwR45cnNTAO3kFGnLZ18NgU3FhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbF2/g2MuXFgoDBv9yPcgPu9XYyYCHXjbL8JUOnbq98=;
 b=R2/tUPYNFvcWRlLvRsprdbCBOcPTC27T9uDv+uEAw6UfdO/6eum1JWAbx6qHUur+tPFDm5Ghaxvzp4ziCllFeBzD8Wi7JyosLSJF0bdieVAnRN3bya4FlqFYclXsDPM1oA6GMO624c0HsND7T4Q55SaarhBxg/ibLA1iK3Biuo/4eVq8v9Q+OA1i1+qF0txpQuA51NBPmpIinAl9SIFb/q26Z47CVtWnaLFtN4AbPDElVtYIKxK0ybhfDjuh3yd8xBzKjgs7KvZO18dL/fjOjTOWj43/vR3MxBzTvG/+ZybzsD7r4IBzIT2C6E4C3ffDaqBULOSlvXuLJEeQczS7OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 10:18:15 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 10:18:15 +0000
Message-ID: <0e9e554f-18c6-4f00-b717-b5c5151b06a5@theobroma-systems.com>
Date: Thu, 22 Feb 2024 11:18:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] rockchip: rk3328: Add support to build bootable
 SPI image
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-14-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240217002304.2141064-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: cd355bd7-1604-439f-e9f4-08dc338f952e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pyhjl+MhSBbSI8Hjlp0xUt0XVNFPcPdnpZzxksy4jydvSHr7DVaPc/aMLhLNhnfsPnvsJXZaSN+GnbGWV/ggaPdfH0CzIyrVWbSyD+JJCjtEiv2FIaJZdQ00/YrGsVExzQIcTgy2NdTGyXHcoScDq198ovePouOuomS+wugx/eEaYi03jo+yyjeOxuQPIbL0gZsBmpR3lQQ1g4kt5ELCYY/bB6cNVKQqnTbJVatUS4hQ1Bn0CxYJC1+ewFxpkTqprkN3JohxvR/cAn/qbjO6kQfFC3mh08+t9oVc3Cz7YbdXEXEU/BR+kH10PJmcw6dGnblGoM5H3k7MmHuWeBdDDJvLwhqBD90V+gaW5fyVFz1KciMb3zty78n06mLlmO7TlObGIupLO/IFjfy1HdODE6Bb2E3ePWGlOAwscLeKRNYyiAYslHYTEQ9CYoZujOkbvP0TpwHzPlmgSeUjiz+Qwh9LdIpiKK9c+LY8PHa/NR31dRuhE3TYAzFFIDFNwgQ0svwwIZUtDbxU55QUGtwupphRYfwIvuMjR8hoZr3JQNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjMxTnlNTlh2QUlsTFpIT1ZkZEhQdlQwdERDS2c4RHArcmozT2tpZUxpSjE3?=
 =?utf-8?B?ODNwU3lKeTJVT3M2RkRDWS9TaFJPcUJpNTUyV29kSk16SnV0Z3pHSHdCaGlh?=
 =?utf-8?B?QnNZamhNQXBCa3VPYXVIUnAzMkcxUTN3YmpjQlNyaHpTN01YTm1aOENtSFQ0?=
 =?utf-8?B?Q2FLS3ljcU9uZDdRZHl3SndHN1RCdVNFaFJCcm92Ulg1bXYybVNGdmNUbHNG?=
 =?utf-8?B?RnhqSDliaGJPcDIzSTBaanB4bWJsbGxxZGxOSEd5SUl0ZUZ3SWdLTEhKaWJF?=
 =?utf-8?B?YmtOeVNzL0dNbzY5anphemtDc0dkRy81MnNkV0RRTU5TakpXT21uVSt3cGQr?=
 =?utf-8?B?VE1EZUF6UytUWEhkNTJoYm40TTZabndlRzdFUkRXMlVnSlZsaHVOb0sxUmVr?=
 =?utf-8?B?b2FUY0MwMGoyTFhOSHRCZk0vSk5MRTBUZE9CY0Y4WG15MGprdEk3V0N1WGpE?=
 =?utf-8?B?N0daVDZGNXNpNGdjQ2pBcVBQYjVsTisxaENkMFAvTEgwb0tmN3gxclQvMExj?=
 =?utf-8?B?QWFnZGk4Z1U2M05mTHBZYk1YZHU1dkV5SktLa3ArbzQ1OGx1eXRKdWVyd2lJ?=
 =?utf-8?B?bkRMZVBNK00zZVFSUmVyRjU4V3dUU0Yzc1gvSWNBMVBOWjQyb2tJUHFGUG43?=
 =?utf-8?B?dXRwN0ZveU41dThOS1BZSWpBL0llNERnOWZhbkFNdUt6QmVJZHVmYkVHaVVX?=
 =?utf-8?B?aGwrQjlFTnRyOGZqeDNDUy83OWVVd0ZKdHNPdUtIUlNKOCtrbmVVL1ZIRWh3?=
 =?utf-8?B?NGxDU25HRjc1VzcxYkhPSjd0R3FRbC9hSTFDZy9TNmxRcWhDNEc4U3lTaVZT?=
 =?utf-8?B?NXQyS2oyUlBBQUJzcGNwTTFZYXBMbXhyS0FDcVc2b1JvVER4VG5yMVVIRE5O?=
 =?utf-8?B?aExwT3B6Y1NoclZQQmlBRVYyazltSHc2MEhURE5GdVhrTnVhUjZIVjNDWDlk?=
 =?utf-8?B?R1BzcDA0dHo3aFIrcENLamRaQ0hnbE5yU0VNV0J2TFUrTUVINlRvVzNVOTRq?=
 =?utf-8?B?L3RBSmNHRDJTSFZhZXBRN0ZXNEg4VlNrSEJWS1FyUHlOaTYzVTVDTG9HdXNM?=
 =?utf-8?B?cFRFQy9SWHVPcDNxZkIwcGVsdkNVSHJLL1pNdFNwV3JaRFJsVHlzMDdodnVM?=
 =?utf-8?B?QU9LeGttUEhMYjByMlNoU0JueGFkVDRGZ2tLeXp5UWJwUERnYmdwVFllVFpj?=
 =?utf-8?B?QkM1ZzY0clZ0bHRtK3ErZjl4WUpDWUpZVW9lK3ovU1NXVVBzQm51VFU3dHgr?=
 =?utf-8?B?eHZRTC9VVURxbXBHZytBeUhYZDRJOUdwTmc3S2d5SlBlYmxYMzFXdFJTTDdY?=
 =?utf-8?B?clBiY0FVSGFBM3FwMjF3SWY0UXdzaER4TFhlK0NOdm5DTHh2M09pN3BPdXlG?=
 =?utf-8?B?WXZVZTZqMytidFg3L05zOHRzbTY3Sms5ejVsZU81OXVpUW5aemMrSGpUcGxm?=
 =?utf-8?B?Ni9UUmZZVDgzVkRMaFlIN0UvM0tzeWxYbis3L1hNUW5WMm9qZXlaNG1HUVFw?=
 =?utf-8?B?dmZWMTZKcXVOSG5XOXVjL0J5ckRIRDd2cHdWcmRPZVUwa2pGWGRRRkVOckt6?=
 =?utf-8?B?ejc0ck5aOE1NRnp4MFAvN1RRd3l6OTBqUCtJTmtPR0UyblMxc3hZZFNhQ0Jl?=
 =?utf-8?B?T0tVTS9jVTgrQVRUNkdOMC9PZWFrb0xtN2N3VXc0Rk40cFdicldKUjh0d1BJ?=
 =?utf-8?B?STBJeUVNditUZW9yd2VyYWRxaTVHQlpIVVYzSjFLcC9FYWR1c1V6TE1sN3Nj?=
 =?utf-8?B?Q2l5OS9pM05iZUQ4RG5HMXhXVURMMm5hQUdrakx2VXpiQis4cm5pTExvUldh?=
 =?utf-8?B?YlNvWTI0VDlQRUhKY1BIZXMway90b2wxSlhCbVd5dU1QaEFkQ0lnblVUMEdG?=
 =?utf-8?B?bmZxcjZqZFV1emptdW05VzU0Y0d3MHlBSEhPNVluTE5lcGlaUlJKQnluampM?=
 =?utf-8?B?alFuUWVGK3lCNkthb2owYThKSk9QOHVPT2FTNWJ3Wk0rbFlhMUR4aHRvTzZI?=
 =?utf-8?B?cDA5cSsyMU5xYUp0c3NSSDNnODNqZi8ySVZONzF4ZzRRemRad20rRXVQUUMw?=
 =?utf-8?B?bUhCbDhobTF6NTZjQlZvTFVMOGNhWFRYV0pHU2swdkdreS9mWWU5cVRmeFp4?=
 =?utf-8?B?T25jR0toaXNTRGtJWnh6aFloV1FHU3E1cFhDMS9wMnhuMXVZMi82dU4xY2d3?=
 =?utf-8?B?WVFYQ1FDRURDWml2NTFhdEZKWFJ3L2dtRVpNcDMyaUsybzRDN1Z6Zk8wWEdh?=
 =?utf-8?B?OFkzQ0lwTXVmVzFhcmNlc0k1eFVnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd355bd7-1604-439f-e9f4-08dc338f952e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:18:15.6992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNOcnzzBwIoSJ78her9otBSoTxvdmkLeJ3t0dhT7YIBYrtdnmJuUflVvSDlmgGevwL3HVxv5LGzQLv6hMZcNLJuDgvv+6+gijn/M9ZUajokw22xTFJr/BJ7q/J4ZmjIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
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

Hi Jonas,

On 2/17/24 01:22, Jonas Karlman wrote:
> Similar to RK35xx the BootRom in RK3328 can read all data and look for
> idbloader at 0x8000, same as it does for SD and eMMC.
> 
> Use the rksd format and modify the mkimage offset to generate a bootable
> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - No change
> ---
>   arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>   arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>   2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index a030f1a5e51d..4d43fe2fb51a 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -133,3 +133,14 @@
>   &usb20_otg {
>   	hnp-srp-disable;
>   };
> +
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif

Do we have a list of SoCs that need to use rkspi type for booting from 
SPI flashes? I would much rather have rksd the default in 
rockchip-u-boot.dtsi instead of having to add it for each and every SoC 
which is not impacted by this change (which I assume should be now all 
new SoCs?).

I could also imagine a Kconfig symbol just for that, one that would NOT 
appear in menuconfig because it makes no sense to make it selectable (I 
think this can be achieved without a prompt?), e.g. (not tested):
"""
config ROCKCHIP_SPI_IMAGE_TYPE
     string
     depends on ROCKCHIP_SPI_IMAGE
     default "rksd"
     default "rkspi" if ROCKCHIP_RK3399
     help
       The type passed to mkimage to generate a TPL+SPL image bootable 
from SPI flash on Rockchip SoCs.
"""

and then have
"""
args = "-n", CONFIG_SYS_SOC, "-T", CONFIG_ROCKCHIP_SPI_IMAGE_TYPE;
"""

in rockchip-u-boot.dtsi instead?

I've missed those changes for other SoCs but did you explain why the SPI 
image is expected to start at offset 0x8000? We don't have that in 
rockchip-u-boot.dtsi by default, so offset 0 I assume.

Cheers,
Quentin
