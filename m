Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DBEC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 15:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4215C88124;
	Tue,  2 Apr 2024 17:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZTxpIwtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17718812B; Tue,  2 Apr 2024 17:13:17 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA4088123
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc3DknTNJlNraYbIhMG8RmeQaPOuocJUkoqG/mxNXyujQ77y1A5pA1E4E4RYGfDNW3SP23/t1uHjK3US/1pA8gOqfI6Iil5mw3AF2dn3tVs5MTMKOwUdLD9N1m8P7BBouAeZYbglkHN9IrLN1AG8JOePNSacCn8h85UbJx759WSfzX7Efr+9xYFanaGcJworImBmJvUyJYjvcq1O8bb1TRE6DGmGvWUOjKW+nU3ieIbHGhXHjyvzVBDvYghL/0at2NSJNrudg1fVGQgv3gv6e4CcCXDfOPXyebCqM/WjEoUeevYlJp24yVrlB9TU35si/OSt4B7qkDoV0Cs/G7FcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+bhg1ehwBMNeDgd/GbzRAQZfQYTXaGbVOVWBXcqZ5k=;
 b=hVJbEcyOT0R6fFsmaUhsdh/FOJpTewVHWvTkV2yMNlbMlPsrUda1Uc1dQXm6x0+6D8VjYRXTtVIlQZaxf1v4RMnCgVfF3N9ex+Jc+SIEaOMCYrhOpt+vzltDcEkdJTnZ8BoLNfm0x87E7igRoJZZfszxMS/znfg+d3oyTE8u8W2AnMaLTJVrIv8mvV8s49X9Sx1fYeiDo9k/8JLKzJKRv87LGnLpoBjeDup0/qVM2JuVEHhzQzcGy+HaRSJ/wkm0aNvf+F9hv9Bs6k9Zhnx8ytVfBeedsZKvsUQf93HFgXavF5T5MHqkzDmo5Nc4Bep86Dql5ems8vYRu5dx14VHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+bhg1ehwBMNeDgd/GbzRAQZfQYTXaGbVOVWBXcqZ5k=;
 b=ZTxpIwtBXgqDHkacsHJdaLpWSt1snB9TglTkKHQuWogM3gLWNQDqy7LBK6/mUnI2Ii+gN/o8yMw7wMohf7lcqIwq/N0ipP7xTxp7j4BG1C8Om6UDSXMyJqc27+At6Mr9hp82QFa74Gt7YL9rgRN+SRjxHetNFk5BRrrTxAGEl/vr4LLLPrJDyJZO5wJEwQs8jRWYHbx1n5V+16O4SOrJ8HtOF1Lu4wyifhvJ7t/Ff4FwIrhDQD67JvF3C9mbzUFqW1gH9/lDuAMBE5YmjrAEKJG/pHr+CugRofjHrY8+SNHSuFWxRKzPxCAhEtAmNtkewQH7w0SEkUHaogI6aJMfiQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by GVXPR04MB10247.eurprd04.prod.outlook.com (2603:10a6:150:1c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:13:11 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:13:11 +0000
Message-ID: <741196d4-044b-4cde-aa92-cc81bf375745@theobroma-systems.com>
Date: Tue, 2 Apr 2024 17:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/31] rockchip: rk3399-puma: Sync DT from linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-18-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-18-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|GVXPR04MB10247:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cv1JgRAM7tvD/16lzGSDCmsJmKMU8sZgrN0vImBYeYg7vYKy/ox4Q/5rpFdsh2AEmO60aVMlcr+M1s55ejnpis9gnjDFbF3VnafrLuX9D+AJ6njGt9fJ4ViWwY3A15VfPpfDffBAftxa8PVhBaOdHG3xwKGAh4njkOebmS1e8wL+Pw+a52UjSNov8mcePcVCCIpfDEZFMQW45wZvLBNd3L9hp/pbhwA2WZCtE+MSPYVWV+rl0UXDuVmQt+bqeyT5u+EgBgYcQ6LtlislcPpH5oKcXl3eWHn6O21swnooygYV+p3welqhNvsAa305IS8XNFtEjALecnx0I253du/FCSfpnKJ4sghfGEAU4LfZndE+896wjJ+Kcahp4hgl/qEQhZxUuLjSD2kgwoZCXFnCmAXgU+V15qcREYPeMKH5YYk+Fj3OYlbjtl/60Kt1mHYIkKvm/xi/kciHd6Ps4K8f6IiRoUgu03NzWdikaSb9+Qap6KvynNKu/ltvcgszu9/thKbgFN4zXenzDS92nbOmCKLwT1PNdSwu+roex7wibcXEVC9OsejMVEDl7X4vX3aHBnTuDLQCGvEOmMYsLiU4Sa0wN+Upe+dckPWjwlLZI5U/0yEC8Rd+TyYwGyApu4QDghD+ZEB7OFumbyVQfy8yWqOr1GQMUcWCjOoMncDWyRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lrQVV4S2pVLzNKZzJ1SWxJRzJGVjNiRERKdmRQZzVvdS9EV0pSeCtXTFdJ?=
 =?utf-8?B?VTVSSDFTdWNhQWovRmM0VHVKanMvU2tRNk1waXFrSjE4OTVBTk1Rd3l6REox?=
 =?utf-8?B?YWR1bklVb3BESHJwZXdMclhReFZxZjcwUU5oNkNwVDlSQ2xhYVJVeFJNUkRa?=
 =?utf-8?B?YmRpOWtYcHc2RFloVG1Nb0JyLzFlVEpnakl3SnRJZ2lzQSs2NDl4aWJLRCty?=
 =?utf-8?B?QlFzWXlmN3RQdjNHRjBhUGFGbjA4amJnZVNvZG5mc01UNVkwd3JmUUVSMkpx?=
 =?utf-8?B?dEhFMjIxOTNYVDdBRkhyL3p1OThHb04wK2o3MzNXNCs2QzU4cEZZb3Ezb3B1?=
 =?utf-8?B?eVdzYzVLTnlKaDZibzgxRVcxdEtnd2crODl0OUlVRWczcGV0dHcraHZsZEVs?=
 =?utf-8?B?ZHl5Q2h1dmxwZ001RWtNaEZLeEdIRFo3MHdtcUJvaUd0b3NNa2MyUEhYaGxp?=
 =?utf-8?B?aDNiRndGUmNaN3pDazI2QXJaYmNjTDhQaHI5eUtzeXFEOFlCTU0vTENKcE1l?=
 =?utf-8?B?aGpNL0haNDBibnJuV1dYZzVJL1V2VVVaVmZCVHZYK3BJVWlsMCt2eDZkWXhH?=
 =?utf-8?B?SXZETEt2TlJRakR4OHhna3JoNU1hZ0NURmM1ZVNEalhWbTAvMW9OTDloOUZZ?=
 =?utf-8?B?a29SWmVValVCbHdHVmhFY3Rzck1Uc2ZHS2lsdUJITlhNVHpXNHg2a3pSdEph?=
 =?utf-8?B?VG1GaGZ0Y01SblltWU9ob3NCYmNUNWRuY09iNUhackhnMFVCUzlBRjAzVmRI?=
 =?utf-8?B?TVA4UDVQTk5UQUl1WFkrTUxRWDlackV0b1BYTmR4YUw0ZWhrTzZZTkNic1Ni?=
 =?utf-8?B?VDZvelhPNTlLUjFnL2grNVVUbjVrbThPZ2dFOGxjYUpRU0xuODYya1VZQkJO?=
 =?utf-8?B?bHlsSXljY0pic3RnazBpSTdRSUtrWGJrZkRjY2QvNTVkc2ZCK3J5RHhNK0JV?=
 =?utf-8?B?NUFOYno1WlJKVzhPV1huTDhROXZmUmRpYVBCTVpQazliZVF1cm1jMGtKVVdw?=
 =?utf-8?B?YjFXQy9HRVdPbER3bUdTKzB4bFdrOU9yVi9ER2hFaGFjZlpDdGdrc3V2TXcr?=
 =?utf-8?B?QXluUzRDWXA0L1hkQkVzMzBZdTJpMFJkMFNVVXYvb0NtUlhWTXlFMnFxYjJE?=
 =?utf-8?B?WnR6NStOOXBDbEpsTG4raWt6VThGa0pBaExXN3pyZUZ5SHdUZFBuR1hvNlMr?=
 =?utf-8?B?dXF3WmthTEJUZXFqRTlQcmJNWDJWOThDWTVCVUdqOXFwWm1BQmV5eUVXd1B5?=
 =?utf-8?B?bWptRWNCdDRBa1B2NmlOeE44TG9WUVpOWXJqNWNoUzRoL1d1Zmw5a1hEaUpD?=
 =?utf-8?B?L1dsYnFYVkppYW95cG1mTVVqLytoaG1zcnRaVGtuNkU1d0Nyb3gwLzFoVEEw?=
 =?utf-8?B?T3NDQ3pFaGdROUxWVG9tOGpCTWZEejFYc3ZzcGh1M1RCSUpOd3JDbTNRNS9o?=
 =?utf-8?B?MlBxcTJ1RGdoNVNnNDN2eG9EV3JiZ3VtMzFNY3Q5NVpST1dDc2RFeTRyWjBi?=
 =?utf-8?B?RTY3VlhYeS93R3VMVituZjg0UFA4NkJGalZ4SFNQU3RoNjUyZGI5VGdGTTlx?=
 =?utf-8?B?WEo3a20rcUZKVjVwT21yRjVhc3N0UzlrWFBST01VU3Awb2Z3L2orNDFyWHow?=
 =?utf-8?B?RHVrbVlEVjFXN2hDK3FYVVRoUEwyVEF6QXFmZnlZNEF2NzJFQWpoeHV0M2s0?=
 =?utf-8?B?MDM0KzFsVDBEMDVQMzFjR1k0d09pazZmWmMrNjg2dXV1Yzg4Y2JjZUVwdnBQ?=
 =?utf-8?B?RGFEaHBuQkJJQk5rUEUxekNFMmZnK2xuSDY5OEorbm1GQTJLTlFCR3lBZEZP?=
 =?utf-8?B?RWp1NlpKQ2ZyQy9sanBEVnZDNEpSQUh4bVJvS2o3c3BCMThnYlEzQXIrazk2?=
 =?utf-8?B?MUR0RUl3by8rSzltMW9BYlVuM0dqaEJTZUxtdmVQc3BQMkVHT1dweEJkcXh0?=
 =?utf-8?B?Q0JzU3doVVU2bDlrVjNZeHFwQVBWWlJhZnpiUEhCZHkrQmd4L29IdnM5cmp2?=
 =?utf-8?B?bWIxZ2JpMTdDUWRhOW1VbkowY1c1L3VneUlQQzBKZnpPNnBWVEtUWU01b3py?=
 =?utf-8?B?NllucWNFM0JtWURRZ3VkNWtWcWJrWmFWV2Q5YmhNYnEvaGdpV0F6MTlSdUZu?=
 =?utf-8?B?VzJlWW84MHc0ZWpMRHRyRzVBWGluNVR4czVwamxEbkttb0NMRGR5WjluM2dG?=
 =?utf-8?Q?RHwO9EbnpjKEWu0Vt1Srf/8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac022c82-6535-4427-71bc-08dc532768e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:13:10.9708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WeCkwIS0K9VXW3eim1KMaE5KZMsTrYKnlxrOkVTAzIfwV3fSserkYOa7pUUYfirIh83m6EUseugvq+HCJx5DgH26XdWc4Xg1pQXFlwHloZHeiqbnIkvgi5uSEgxZzID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10247
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

On 3/31/24 22:28, Jonas Karlman wrote:
> Sync rk3399-puma related device tree from linux v6.8.
> 
> SPL_MAX_SIZE is not adjusted to the now common 0x40000 (256 KiB) due to
> TPL+SPL combined (idbloader.img) is limited to max 224 KiB because of:
> 
>    SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
> 
> Because FIT payload is located at sector 0x200 instead of the more
> Rockchip common 0x4000, TPL+SPL cannot take up more than 224 KiB:
> 
>    (0x200 - 64) x 512 = 0x38000 (224 KiB)
> 
> Also adjust SPL_PAD_TO to match the 0x200 sector offset.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 20 ++--------
>   arch/arm/dts/rk3399-puma-haikou.dts         | 42 ++++++++++++++++++---
>   arch/arm/dts/rk3399-puma.dtsi               | 17 ++++++++-
>   configs/puma-rk3399_defconfig               |  2 +-
>   4 files changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> index f48d395f972a..65340f98d595 100644
> --- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> @@ -30,18 +30,6 @@
>   	aliases {
>   		spi5 = &spi5;
>   	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-init-microvolt = <950000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
>   };
>   
>   &binman {
> @@ -87,10 +75,6 @@
>   	bootph-all;
>   };
>   
> -&haikou_pin_hog {
> -	bootph-all;
> -};
> -
>   &norflash {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> @@ -111,3 +95,7 @@
>   &uart0_xfer {
>   	bootph-all;
>   };
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
> diff --git a/arch/arm/dts/rk3399-puma-haikou.dts b/arch/arm/dts/rk3399-puma-haikou.dts
> index 115c14c0a3c6..18a98c4648ea 100644
> --- a/arch/arm/dts/rk3399-puma-haikou.dts
> +++ b/arch/arm/dts/rk3399-puma-haikou.dts
> @@ -5,6 +5,7 @@
>   
>   /dts-v1/;
>   #include "rk3399-puma.dtsi"
> +#include <dt-bindings/input/input.h>
>   
>   / {
>   	model = "Theobroma Systems RK3399-Q7 SoM";
> @@ -18,6 +19,38 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&haikou_keys_pin>;
> +		pinctrl-names = "default";
> +

To make sure we keep the same behavior, we would need to enable 
CONFIG_BUTTON_GPIO in the defconfig for it to do the pinmuxing.

The impact would be limited, so that's something we could deal with 
later on if you mind having a commit for that in this series.

> +		button-batlow-n {
> +			gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +			label = "BATLOW#";
> +			linux,code = <KEY_BATTERY>;
> +		};
> +
> +		button-slp-btn-n {
> +			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
> +			label = "SLP_BTN#";
> +			linux,code = <KEY_SLEEP>;
> +		};
> +
> +		button-wake-n {
> +			gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
> +			label = "WAKE#";
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +
> +		switch-lid-btn-n {
> +			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +			label = "LID_BTN#";
> +			linux,code = <SW_LID>;
> +			linux,input-type = <EV_SW>;
> +		};
> +	};
> +
>   	leds {
>   		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
>   
> @@ -165,11 +198,8 @@
>   };
>   
>   &pinctrl {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&haikou_pin_hog>;
> -
> -	hog {
> -		haikou_pin_hog: haikou-pin-hog {
> +	buttons {
> +		haikou_keys_pin: haikou-keys-pin {
>   			rockchip,pins =
>   			  /* LID_BTN */
>   			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
> @@ -177,7 +207,7 @@
>   			  <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
>   			  /* SLP_BTN# */
>   			  <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
> -			  /* BIOS_DISABLE# */
> +			  /* WAKE# */
>   			  <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
>   	};
> diff --git a/arch/arm/dts/rk3399-puma.dtsi b/arch/arm/dts/rk3399-puma.dtsi
> index aa3e21bd6c8f..c08e69391c01 100644
> --- a/arch/arm/dts/rk3399-puma.dtsi
> +++ b/arch/arm/dts/rk3399-puma.dtsi
> @@ -9,6 +9,7 @@
>   
>   / {
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdhci;
>   	};
>   
> @@ -27,7 +28,7 @@
>   
>   	extcon_usb3: extcon-usb3 {
>   		compatible = "linux,extcon-usb-gpio";
> -		id-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		id-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&usb3_id>;
>   	};
> @@ -119,6 +120,20 @@
>   	drive-impedance-ohm = <33>;
>   };
>   
> +&gpio0 {
> +	/*
> +	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
> +	 * signal. This usually represents the state of a switch on the baseboard.
> +	 * The pin has a 10k pull-up resistor connected, so no pull-up setting is needed.
> +	 */
> +	bios-disable-hog {
> +		gpios = <RK_PB0 GPIO_ACTIVE_HIGH>;
> +		gpio-hog;
> +		input;
> +		line-name = "bios_disable";
> +	};
> +};
> +
>   &gmac {
>   	assigned-clocks = <&cru SCLK_RMII_SRC>;
>   	assigned-clock-parents = <&clkin_gmac>;
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index cc3d2cf3755d..26d524cabb06 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -27,7 +27,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
> -CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_PAD_TO=0x38000

Those are unrelated changes, please in a different commit (but thanks 
for catching my mistakes :) ).

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
