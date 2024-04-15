Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC216C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B86288193;
	Mon, 15 Apr 2024 10:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="cHdkXdvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B4D881EF; Mon, 15 Apr 2024 10:46:54 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3307C88153
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I41y3a7ZuQrmC1p8AQLbq3wQEVxA/NgD5FkzAfwkO1lcJmwZ/njBOlJo2E/Mh57YAC/THuz9rfxhh2nC9/125C7mFkOF4j8ODR8CMOnocuL3m5xZ+ym3bRIldvZBICEX2Jrvkx5o3Lm03GxQTQT9zsRmZ6II6J6IK+R9/25PI4sJGD0OfW1CZ49jD3d/zkhGH4u/sKv3ivhYZ7J/PL4nArMo5qP/P52mUDKTKwrJ5N9asOaUaQ0lswNinntW0vXLmGJ1YjgFkiBj5p4Ztfswn6NB70BLanARZGGUHikPjy34bui03xVLVuwCNKbJoIqjH71t+84NwnnQRSIYp/Ihhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y46r4j+3d0E4GnwfB71eomSwrA3WevRFRrewpfHpdZo=;
 b=XVDP/45b+KhmAgbEsd9Nhcr3GtBDayFqOj7OO0uzf71okA3zlhFDaOzGiQTZP73/6hQuEE0YZl9d8c4lTLRP5/mHCGrVwM6KP6ho4Z2zRja69GVYuWaBFXIwPgk4K79yu0z5iaFX+XukhTl38oyepnC0amX/3eFKCPoHiJGZzzbr75Jk+xAYAl79XznsyHTmZyZnZx5Rhibn2+poxZv47FNp9rV8gsRJiDjLcZuD54tOfgRE18zWKelbIj3E/oqoPMurIl+HALZKgeeR5lpEwZEfaboB6BWjhX7HMVPoCZl+eZSljywEXqM6xq5NC6I08ZRtzU6M8etSrea+nf0Ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y46r4j+3d0E4GnwfB71eomSwrA3WevRFRrewpfHpdZo=;
 b=cHdkXdvD0qgCHlIYX+3F1OrLAHRWpuDq/wxBii3aWffrqWi5K2q+pYtUSHaCPMNSVhsHxDGicomE1JxWtFvGa637KN2avUqtYTSZiUAUfMMtepOX08J5avphfUGt309j3qNSXp7nwSfbKuvqxqqtPz44GGOskoR+mHlZZFQoKWJQweolSSjT5EVEDXr24cmhUXzmil78k4znMwa/xjCyIvtpVIUZOolpFvqI5NtMdxo8wl3ljT/tWv0Bb5BZ7RNeCtW6p0ZAyRvkNXAuEUC+3xO3rhMZpcc5wFtDR9d4wSv9xSIumdLfWcBhIK2ifFvd8aP2nt5SACef9YB7d95ZgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:46:48 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:46:48 +0000
Message-ID: <3d710c01-c602-447d-b652-c9e613e8b3ee@theobroma-systems.com>
Date: Mon, 15 Apr 2024 10:46:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] rockchip: rk35xx: Sort soc u-boot.dtsi
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240413181425.1384357-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PR3PR04MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4142d437-1223-430d-4b26-08dc5d28969a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuKcFe5rQkVmjmkRX4aYHyz1xjNXv2t7a0N8+pdzFvAWM9oX+SMQdEMuYwhHUkp+CA7vE2wfWH0J1K0qq5nMa88Fy/Cc5MefnpNnQTs6Xd+3FLchooUr2J310xzO348rsEPXFCUrHfk6Z75gYLGfa7ytjIPnpB5wRr6R9IiU3ZdQzAC0LqN0b58Ff3bhEC7n34QOFMO6OWwXPGlR2tpu+in9H6K8bv3bz24hmPgmSrz/fSHSbIkKbAsXV+LdCRhZn54pC5lEtQQKRektGYOgHnP7yUaaY6q4XD+YPrAH6S8kFaU2Z72enQN8JOd+1NpIuyfO76bm2pY5WuggfJ5mtYPSjzsS+BqaR7aPHUpEC/pMHyFs//s+/obBGIu8LTuBc+2ZTeme39LqAnf+J+lMK+h9sE7ynInuSmQS9vXmD531lZrUBYhTh1BG3k3EzenZDS5hmN74QzEaF6HAU3sJ1AnRGUFxyIkLjB8uA9TBmUw91wRUQ/FaiGSB3tMB85LFvC6HJCtgqMCYxXWxpWobOgKyfAssNyPxpLOLv+zM7/K4Xix3KrFLMAwCxyW4UbleDls4RGWSSyDN1qfKlJgGe1Vk+2DnMProQjSal8AYn88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2gxZjFYek1HaEFuU25Ya1Q3Y1VCdEEzcGhlcjA2Q0hWNzh3dEI4QTk5UVJQ?=
 =?utf-8?B?SFVDc2VaVTdUOC8zZTBoZ3dZYldsRHZlbDZBYkorR01OV01qWXNGSFVZRE1X?=
 =?utf-8?B?K1BTR3dUM2lRTVY4bHVMTmsxSFIrbmZNMUppczBENHFxYkZhUDNZUmNyRnlT?=
 =?utf-8?B?c1ZuVVJSUzRSbTNKZys4eE1CdjhJUnFGN2pzRzkvTDE3dERyaGROYkkzeEsy?=
 =?utf-8?B?dEhNbWRYWVBHaCs4eDZKQVdyY3FjMkZrcEF0bGhlcllEb3lQKzdlOUZNZ1Vz?=
 =?utf-8?B?MFgwQWNZNkVtNVlPUDFUYU1BSUQyNjMvMUViK1R0aG1BWGpiVDhCUHhtWU1W?=
 =?utf-8?B?UStvajVXQXcxSFZ5M2JnUzFjb01XQVhoaWNYdXl3cG9TS0tubUNET0dvOEpx?=
 =?utf-8?B?STl3cCs0ZHM3MkgyTUxuN2lkcHVEZjBrUFZnY2pScXE5MExXQ2JsN2tiZSt0?=
 =?utf-8?B?bDlxTzJiVGp0eTh0Q0J0TGF3cnVua1JubDdkZ200TFAvaExQQVZpTXAwMVcw?=
 =?utf-8?B?RHZidzV3RTBVU0JvYkxoeGxPRDZrZlo3VHlSUHZ2TlU0TnFlV1RlM0kyZFB1?=
 =?utf-8?B?SjNaTmQrUzBEbjBzOUFhdTNBdHM1NzBjNXI1S1Q2alVEQzRyR3FtVTZnQlZo?=
 =?utf-8?B?NDdrWVltZHlES3M3SFdoUTFDdThBK1VQZm5LTzlZYWRTYTR0ak5raUVqNm9t?=
 =?utf-8?B?TTlTMlhkQXhjR3F6YmM4VDNJaEFsSDBFbk1CZVQ2Qm90QjdiN29OdWpRTXRE?=
 =?utf-8?B?Tmo5OVBlYVZlOEU4R1JOZkVzRU9OWEZTeWhYN3pYdlJjclRmOXBIejJWSDVE?=
 =?utf-8?B?dmV1MFJXaVBTeERVNlVHMUc2OU5veU1FWHQ5cnZjeDcxYzRSaXFLZmpoaitR?=
 =?utf-8?B?amh2b1NoZEVJdUZtQkFnc1lRcFhWMW9oUE5td0hmTDBlQnNzTUZzU2dObkpw?=
 =?utf-8?B?M0xza1I3cGlqbnRrYW1KOW9tV05RbmJkQmsxb2tSZXJGdk1vVXVDa2FOSkdM?=
 =?utf-8?B?QVFXOFlYU2xHM3BoZFVmaVVXZTJrVUZwcFc0V013KzFtLzgvcHlSZTVDTDFT?=
 =?utf-8?B?dENZTnFmVERVRklrcUtGTjU4dzFVZnNCbEZkS3NTTGRqR3pMVGd3UFo5WW1J?=
 =?utf-8?B?M0Z4cWtCaUs4Nms0dzI5MjMvb21MVmZZR29OZVNvdmNWMEU3TFpCZEUzZWow?=
 =?utf-8?B?VmlKS2hTb1AvK0tMNllVMWtRZ0ovL0RXOHNzSWxleisrZTREeW4yYUFqbjlH?=
 =?utf-8?B?d0I3NTNEVkp1MFErdS90QTY1ZW81b041dGdWQ1NaMm9WUzZ5N250MFEremd3?=
 =?utf-8?B?QkJlNWpTNXhwVHJpb1BZUXpNMHlsSHg3NHh6M0hKRTBxYmxYbCtJU05jZlhJ?=
 =?utf-8?B?OEYzOU1LVldoRkg5KzRndlFTT0lvUU90amRCWTI2U1ZDdExCSm9aQ3FpbGdS?=
 =?utf-8?B?cHVRYW1xU2c3Q1ExTFpKYWhJa0JCMHdtQmRYVjdUZFBqYnFzNWhWNjEvdnJC?=
 =?utf-8?B?dUo2am5ockF5N3pIb1dPVEt2NmVXemNuL0ZmblpGaDFBajBtMk1OTmdCdnV3?=
 =?utf-8?B?QnQrTkNQWWE0cUYrYnFXem1iMnJCeTl5MTNlOXRYU0FlQ2VnWWFxdVVEYjhH?=
 =?utf-8?B?bkpXZk9kTWwvU3FZTE5RTitJZ3JJUG1KTzZRK3FFWmRBdEFPVzl4bnd2NXRX?=
 =?utf-8?B?TE1GSG8xQ2h1Qmw1cmZSOWJoS2tiRUVCdjdVY3ZpTHRCdVNGWmZ5NjU2eFov?=
 =?utf-8?B?dHFLQVFrbm5ISTBYMlJ1LzBIVXRxL3dMd2p6OGp6V25taDZJUDNsV3dNMmVZ?=
 =?utf-8?B?WUhTR2tlQTB1R2QxZ3J6VkRWUE1rcVNaMXlFamVIZnV1MDNodVJKZG03b0Jt?=
 =?utf-8?B?YWJHRmxDdTdVckYxaG02ai96eWdwK2VyZGFsSmhtT3l5dGZBSVVtaS9NdGEz?=
 =?utf-8?B?eUxhcVlXdTU2ZXQ0ZGltWU44MnprNXdOaGM4aHdRRWdLekJKamJLZms4UWNL?=
 =?utf-8?B?WDdndlpuZk9NU1J6RUFiRWYxODE1S0VnK2lHTmtEMDQ4ZFpCN3dHd2Vta3pW?=
 =?utf-8?B?cGZwYWI3RlJhMjNpQzRQUlpBZm5ETXNHT1lYR0I2K21ZVExZT3YwbU5Od2Iz?=
 =?utf-8?B?VVovZFlhWnB3TUNYK3hHeVU2U0c0OTRkclVDeEc1U2Y1d1BBNURaNzlvQkpn?=
 =?utf-8?Q?f0Zi/lnwIfgNz89sy9a9tTA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4142d437-1223-430d-4b26-08dc5d28969a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:46:48.8491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exl8bxVA+moStZaeoeHIzmZzRxEOzYd/8Z131ZUFSLGXBXIbla12A1IGD2yXUhRZTVqjMCvrfpXZ2QV9vLV9un8gSNVJ3kH5SihE9RuJIzRjra+PqaIj1ivEL+bUrhJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212
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

On 4/13/24 20:13, Jonas Karlman wrote:
> Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
> is sorted by reg addr then by alphabetical order.
> 
> This has no intended change beside sorting existing nodes and removing
> a duplicated usbdpphy0_grf node.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Follow kernel sort order (Quentin)
> 
> [1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi  | 98 ++++++++++++++++----------------
>   arch/arm/dts/rk3588s-u-boot.dtsi | 69 +++++++++++-----------
>   2 files changed, 81 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 05367216e118..1ecf719202e9 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -38,46 +38,10 @@

[...]

>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>   &binman {
>   	simple-bin-spi {

We could also alphabetically sort the binman node if we wanted.

> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 233eb79d9ba2..543327954b1a 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -41,6 +41,17 @@
>   		status = "disabled";
>   	};
>   
> +	vo0_grf: syscon@fd5a6000 {
> +		compatible = "rockchip,rk3588-vo-grf", "syscon";
> +		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> +		clocks = <&cru PCLK_VO0GRF>;
> +	};
> +
> +	usb_grf: syscon@fd5ac000 {
> +		compatible = "rockchip,rk3588-usb-grf", "syscon";
> +		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> +	};
> +
>   	usbdpphy0_grf: syscon@fd5c8000 {
>   		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
>   		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> @@ -72,22 +83,6 @@
>   		};
>   	};
>   
> -	vo0_grf: syscon@fd5a6000 {
> -		compatible = "rockchip,rk3588-vo-grf", "syscon";
> -		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> -		clocks = <&cru PCLK_VO0GRF>;
> -	};
> -
> -	usb_grf: syscon@fd5ac000 {
> -		compatible = "rockchip,rk3588-usb-grf", "syscon";
> -		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> -	};
> -
> -	usbdpphy0_grf: syscon@fd5c8000 {
> -		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> -		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> -	};
> -

Would have been nice to at least mention this node is removed because it 
is duplicated (or have it removed in a different commit to make it more 
explicit).

[...]

>   #ifdef CONFIG_ROCKCHIP_SPI_IMAGE

What's below this git context is &binman, which we could also 
alphabetically sort if we wanted.

Did the change manually and it matches, so:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks!
Quentin
