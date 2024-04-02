Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4263C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBC687C77;
	Tue,  2 Apr 2024 12:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HdIbdkT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258C487DDE; Tue,  2 Apr 2024 12:23:43 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC21879F3
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcIaJZ14OeLVWgDQ2kn/BCQ8b9VjCr56LW+q9HCotAa2gMpr3kWBoBBaqhH67/4E5v5Fq+fcLAZJiphcw0LYd5X68dfwSsmjs63QqVsn0T7QC58Z1f2SsFafJDuFIRCqFVnijXjt4YHolSnl9fmZO4SRG6w17nlYq8dW98tEsDhWip6eNCGVJtTjVKzRc/yQZ17fhmiCmDNd1ZzRhkGXXL8XdAKe6s4vNZRkd7c2Z1wAV//zryQsLe6f9ooFkcCW/oow1dKlACPE6YEfSbE/CGMHYuH2PFDKPmDOKr8WH6OvcsfD75RfGVlk/w0gKtMmirsxb12cjr/b/yjT+IeW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htf+cGpuk0cY4LKT8sTc7kxMLEDJtCQnv2EwMdaKEyk=;
 b=ii9GGGjvsU9zHzAUkYTIIKm3OW2/WczBYaSKheSq415gFjJwGLAOzqyMUJJal0d+pa6OYvOxB2YhhNP84Hvw/b1Ywq5JQbrc8qpUsbFuOSHPFWmby7MwFEEsb+AaB7eAbbsb5DJtNy5YbPjDsZnhtKSo/KwBHOGCh00Ll5Q9DD01/kpg+ifhDzWgfGyKXTg91WRy4j9GhEIB3lhSft1lz/4IfbRnD/lMBWBATOUc0R4o+utaQF11EUAOpbvn/wxmbBcoaY9XqGFTnSy/cPmF+B1iqSZyre/lBDMKAOKGTvQ1MnBXG4qX9vdQLw4HU9B+syKncI31Qps8aa954YSsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htf+cGpuk0cY4LKT8sTc7kxMLEDJtCQnv2EwMdaKEyk=;
 b=HdIbdkT8KcgksBPrxa2dX7zEruh34DY0xMal8O19qbpICKWV1QoPEMcQXAnVGFiSjMFKlB5v0mERJdKtKrnvhb6436jm0I4eObIpniGDKARwgGuqJ9UZXhd5WpOLKyH/wjO3nP2Cpp/NY3G8Ihjo9BXQHKK01cmODWHbHULaw6pcUhuQDKibLNzacY85OaH0YWXvKYFLItrLGf5llIUcOqM5rE/oiYZGtnvSvAYIeriSi9g+JQQE8Yu9xyk5NirV6/tLpFGItAs4y0n4rtcqjvhYyY1b2dip3FvR2ZNXYjYrvX2RAK6bZBsPXp8k7Aqy+u/JsFsBJkluDeKHzFY1LA==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAWPR04MB9839.eurprd04.prod.outlook.com (2603:10a6:102:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:23:32 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:23:32 +0000
Message-ID: <fba5eb23-3f52-4e99-9aca-47142189d553@theobroma-systems.com>
Date: Tue, 2 Apr 2024 12:23:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] rockchip: rk35xx: Sort soc u-boot.dtsi
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAWPR04MB9839:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZtyeqFofjUOhjzppQ/P6pICRFnGL30k9+M3vVw97lIU7oY5CQBUQx3kzIBNxzdiG1xktuVZUtnw+x+FpYyCLWG5nq0ryAZz29szI/2xIYJFuv8vkr0oERyCPU6v7kHYBMmlvOV5f4LbycjPyO2R/wodPt+cMR/Y1s3TxrprCr5dvCLESW+Py8S57eGsfRxksRgSHKtH2zCKY6rZFkfAbQwH8OKnIQUV6kAsZmCaG6CsGbjHXLBUhG30/C3SqEhSkuYLf9tLRy02jZzW/1nvAoKTFnDcmEzLzuQ/n9fAmg2eZMTvwDagweqnjCJ+2kywj+371urAzgXgOvcySQya9YMAxM1+ZkcD6w4to07t9eKf7mhN4NYvI8SdcjGvKN7sYar0dAs+HMod79QWl3M0zYCNyL4NTVIkcIuuaIM2QwfTAciSPmCogGo5JxAYBKW9GxK1IN9k6H7rP4wEoyC6t3kmVYpP2D/k3qXnG/lwzHmlynSeo9VlX2rIkhRgm+/7G2sQbDEOz/Uxp95NL3VsV94ZreNCmR+o7uRMI4A5zWKHpW+YvYiOwrsR7r7vEL9xKWIQbOmuAPTEppeXJ2v2B9T+wGQTY84v0ednrar+YBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRpTDY3ODlPaFRmcE9MOVN6Qk5IUzk1U01yVUp5NDVzRFBkU1p4V01sTWw4?=
 =?utf-8?B?Wi9pSnNoTUlYd21jM09waTRSOWMwbFNuUUFYekw2dVBjU05YcHhlUW9JUCtv?=
 =?utf-8?B?OTVOUDhCNWFPblNqMmxIb3dLcFJSTkJEektGWmVzemlFcUVEZ05FNlNtRlA2?=
 =?utf-8?B?SXp4bE52WEY4ZnFkSy9xc1I5a1VjVXVqN0RUOXBXU1Eva3JGOVlFQlFpajdZ?=
 =?utf-8?B?Y0tSOU03bDVaem9nMTJCNjJDdjR5N05uZXVjNm8rVnRtckg3Q1lFMGN1b2dH?=
 =?utf-8?B?TndOM3FSZ2U5WE5uTGFtbHp2ak5FRUpocFhvRmVIcG1xaDdZWWpPbVAzcDBT?=
 =?utf-8?B?SDNRTzVDUVErek9mYkU0cmd5U2pTT3g0R3JUdzhpZUJwdDJjMUxzRGpWQ3lZ?=
 =?utf-8?B?MEQwOXJCK3JNKzFzbmo3aEJ4MjM0KzZpemNuUDZ1anBETGsvM2pGclBCdDU2?=
 =?utf-8?B?RUoyQzNPY3RaODZyTlF2eWcxV1cwbFlFekZVSVVGajJtRFhOTDR4MGJrZXZD?=
 =?utf-8?B?V1FiOERUTUhHS2RldGZJUk9HamZpT1dlY2xtMkF1TU1hNXBiRkhNN0FpU3da?=
 =?utf-8?B?QjFmZy91RTdoMm1ZWmZPbDZicGp1UWtBWDllallyRklFSVBVRmdwT2JpWUE4?=
 =?utf-8?B?VUpTREhib3ljbWhHZDNYL0NvM1R4NDJQWU0xeFEzelVNRzdRaW8xRk5lZW53?=
 =?utf-8?B?andCYWwwckJnaHdQNzBScHhPdyt4SzBnQ0VZajhvdUgreC9FTkdCVUllanJK?=
 =?utf-8?B?REJSWmQwOUJiajFjVEZScnZTcEVxSmNqUElCVG5qRy8ycWRuTTBvSFh4K0ph?=
 =?utf-8?B?bGtUTFljVjIzbDBwZWRzb0NHa2VuSWIxTElDajlNWjFveWVjcXBWaWE0dUxF?=
 =?utf-8?B?ankzV3lBMEIwSzB6TEdBOCtCckIzTFl0ZWFQZTNXUkhMKy9IUDJHT2RSajVP?=
 =?utf-8?B?c2Z3eXV3dGljaW9yS21FTFluZ2k3MnM0d0FhZ3NjdGlCbmdiaTFyNlpROU5v?=
 =?utf-8?B?Vlc3a2xSbWRFZEdMZjNsMjU4bmkwa0R2UnJxcytWcVZaQUxuMU53ZzNyYWVB?=
 =?utf-8?B?aDhiV0w3M011cy8yc28va0RjU1ZRQTF2dDVWWUEyZlgvL1NjZmFYSGs1Z3Uz?=
 =?utf-8?B?VERtZzNRQit4UXlyaTczRXZwczhrYjYxQkRDZ2I5cGZKYXNWak03V3Q3Yndv?=
 =?utf-8?B?Q3U5TjViWTk4U3BCZHV1K09wdHRRTUJNSUxNVC9xL3V6TDFCOHJhN3hxRVlm?=
 =?utf-8?B?cmFTMlljc2paY0xxYnZQYmovc3daUW5qc25wTGppOGhaTnJqU05jQmVtNWxU?=
 =?utf-8?B?ZFAvODdDU0VzY2JHd1ZqOFFqS1pMYmQ5Vk9jUEJFTkoraS9hMDhnLzkyaU9l?=
 =?utf-8?B?SUxISXREVGsxeUx1cEdNZHA4KytYb0xjTjYzRjhRcWFwY0dEN3J2NGp2a1Y4?=
 =?utf-8?B?M3V6dERuNDZ2MGl5dEZMUjNUR2poVDRqRU5zNFRUSFp6eGZYQXVoTEV6TTFh?=
 =?utf-8?B?VGFvLzlRYVppQ2I0RWdnVllEM3hhNzlnUEl6aE03alFZQi9mU2xyZnM5RXNj?=
 =?utf-8?B?d2FHbjg3dnh3d3RnRThhRmtuTjBma2xaV1ZyeWRJTmhTamJidEFCcm9rOVJE?=
 =?utf-8?B?S003UCtWdnVEZWNyejlhMU5wdDdFaVptZjdPS0xCYjlKNjhLSDZlV1RxbGNw?=
 =?utf-8?B?VEZlSStxVW1uSGR1bk40dzNaUWpmT3lxSUxZeFVxZE40K3ptOE9qWWZNSDNn?=
 =?utf-8?B?bEFMcjJ0Z0E3S0ZvWUpFYzhDNXQra1E0S0dQb0UrZUhzNTIwL0ZSdWpkWEJ3?=
 =?utf-8?B?QS9DTWw4MWI1ZU5VdjZzRTRrVk52ZWhoc0k3eWdoL2YrUkZwT00xN2NJU1RC?=
 =?utf-8?B?M2twV3BjLzltSVl6bE5rK3JzQTcrSVU0ZlFrQ2ltK21YdnRkdXJwQlMrMFo0?=
 =?utf-8?B?ci9SVG56dmNldlkwSXNUa2k5MHp2TE1uVVloc3M1Vyt1YkpsUmdNcEgzbjNs?=
 =?utf-8?B?UCtSNlFuQnY4TGhKSFdjQjVaNzcvQVk0QWdYRmVRWVFEeGNRWTdUc0tMSWNx?=
 =?utf-8?B?SmpiTVV1NWxRSXJQWTRMWFovTURiZnh0UWxUVEZSb25SZno3QnV6SW1NRUJW?=
 =?utf-8?B?eHhtL01YSjFVQUlLRFZrTmVBSHJGQXIwU1UwS2JXbUQrd3JkMG5SdEVMZ1VC?=
 =?utf-8?Q?OkXG+LMBqC3kud0fjRDDsBg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c313b-63e8-4607-d382-08dc52fef268
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:23:32.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY6hbtMW5/ArrLzH/cMZZYGKfy2aaxkUVCkCF7LLSbGZZSpLNAH6VIPNzdcpsIGT7WsLGhh7pA2cNoXufoU1ep4YFKMtatTUL6S/oXV0dV9IZ2oxQFpM+p1reyyg3qq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9839
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

On 3/29/24 20:01, Jonas Karlman wrote:
> Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
> is sorted by reg addr then by alphabetical order.
> 
> This has no intended change beside sorting existing nodes and removing
> a duplicated usbdpphy0_grf node.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi  | 100 +++++++++++++++----------------
>   arch/arm/dts/rk3588s-u-boot.dtsi |  71 ++++++++++------------
>   2 files changed, 83 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 05367216e118..a0c630326217 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -17,8 +17,8 @@
>   	};
>   
>   	dmc: dmc {
> -		compatible = "rockchip,rk3568-dmc";
>   		bootph-all;
> +		compatible = "rockchip,rk3568-dmc";

This doesn't follow the kernel's DT coding style:

https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

[...]

> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 233eb79d9ba2..e4171bd24d2a 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -15,8 +15,8 @@
>   	};
>   
>   	dmc {
> -		compatible = "rockchip,rk3588-dmc";
>   		bootph-all;
> +		compatible = "rockchip,rk3588-dmc";

Ditto.

Cheers,
Quentin
