Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEBC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 14:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C65087DD4;
	Wed, 14 Feb 2024 15:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Wd9xnDeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 125D687527; Wed, 14 Feb 2024 15:13:18 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D0F87DE6
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 15:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN14ktQZDtF/1YlQ+cdOo2Z0n+roQ8Gmo3GBeaxJbyqQWR8FOzKcjK0C70TymMdGM+M40LjvrnlFJZkQeaPL/pPIEnKqng02tP4YHprE1dyhr1nbdOCuekUAj0Q9sHjxaSaWe3KayEWbx5ujgojwIpdgTT+bcyhmng/UUGdh4y3FAf3b+GsxeNYjWcFs581+4pgMgl0BozvgQdxTFtV14qK+KzfiF/M/GVBvOhDV+c7AXndbikHQS9pnBdgQYOmbzeyqXrN4ux99Li7xnPHAz9TIdKTL5pPf0ORpD6U2PqA18MJlxk1hEZEvbHdtL6L7HLOT5pC6KFZ4rJ1Mrprgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oztsoh5zolHNq+MUZ+7zcl4n2pZOwKFFvN99S+TgG+Y=;
 b=iBlOUpwuv10TGlKmKDpdlDVjVTvz6EpZ35jgDvJKo19gC1y3ym90PPpM0ydzxw1dEl9RItbk6MV8sUsvGh7eePXP4GPFl/AEueb7ta3JdlAbXJfxZLVT2iPA4Omw5ps4iOW8U6ihBkceBt9vu9bSV34tGQ1g66OlOProP3MfLJeQHRVG33kexqF43P9vxtZOT977HL5j19QGcCYbAnS8a6WFsgR/YzaAbwWOJJoXCt9zUIAi6BqyP3lWRsR62sv+sJho7XbVOnUXsaksG1dVnkUgXamXSOd6c4v+6h9Ck7uRRJFVEtrZyEMyu8T0nr/6eBc35wPPnCyuzP2Lw324kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oztsoh5zolHNq+MUZ+7zcl4n2pZOwKFFvN99S+TgG+Y=;
 b=Wd9xnDeFUPP5Rd1twWFRTn94CuxqRcZMKriqg4hH0Uz+5vvLn6wJhP1viZq/MHxAR4X8CM/S/i/bFFqJ7oFu3NYwEb9SdB3j8YmwPqreB8a9z7kdFr/r9LaXoXnoi+PPGVjdV1/rGXXoMsNYX/Zb2fD8Zy0BfgueRZrM3972b1mUcOvlGeEJEDHV2RHlMKSio4aYlgN3FG81Gzg4lU03svB+iVWqw5qMj7XbuaPTpr8gumpOfMXUowGVKPR/EUb8neFV7bls2j7upT+42ZEiC7g3snAmhHzcWSuhu+Ni897GuTcFZw8uhyE20/eq3FOjGrnKT2ZlFMtGyCZkyw0DRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS5PR04MB9970.eurprd04.prod.outlook.com (2603:10a6:20b:67e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 14:13:11 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Wed, 14 Feb 2024
 14:13:10 +0000
Message-ID: <918dfa17-3c32-44d4-8d16-87bab10cc138@theobroma-systems.com>
Date: Wed, 14 Feb 2024 15:13:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] board: rockchip: Add support for rk3588s based
 Cool Pi 4B
Content-Language: en-US
To: Andy Yan <andyshrk@163.com>, kever.yang@rock-chips.com
Cc: jonas@kwiboo.se, u-boot@lists.denx.de
References: <20240214093126.329717-1-andyshrk@163.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240214093126.329717-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS5PR04MB9970:EE_
X-MS-Office365-Filtering-Correlation-Id: 100b66bc-166d-496e-d9e6-08dc2d671331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBexL4htHF2CCvD3ZpHrlkeHOCTtSZ3so6EZ3W7Bzkb5m8/Psgn7DAncLyGeM45qtjMlZ4BnhfGP74/b56h7TRV3wH3uXLt3UUNo8e4jCqLhiBmz8qoRliSVw7yLyJgQdIzqHtqjWHvuQYq4QKgUSNprHRhScN2JNhsGm/2x2sA4UuAiAsrN7519wG8pvTMCG9vBIoJQzP+xGXsvcIYN9IwTZ5YiCSyyJ+fCZLKCeVo+ddbJEwaQqJQTBQNYLAJ36EH0ctfZkQdav6MckEi206abkMsRyaeyTWleC3VuZ+1S1348EJfH5ft59+mc2ks3mkSTqnvq546s2+L8loCI6bnPAXYPKlhT8WtXfT7KLX8NSp0qLAvX/TDoB+4vm2e8LS9uM1PuoNAzuxoK3nA7yniLipm9Em/wuTq9+YimZye9AXBSEs/JZlLCoSRYU7p5Ez6i9Wvmm7i+i+WkU2zAvmaelipS8aLVLXVhXyMp75X0/y13Jbtx5LeAm6qzOOjze0IYwARfHMx++yUnJ9qPLXUqWsy9wG7UqJh8xL7UBrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230273577357003)(230922051799003)(230473577357003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(44832011)(8676002)(4326008)(66556008)(66946007)(8936002)(66476007)(30864003)(2906002)(83380400001)(36756003)(86362001)(38100700002)(31696002)(316002)(41300700001)(2616005)(6512007)(53546011)(478600001)(6486002)(6506007)(966005)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNEZmlaczkycUQxamtOQzJKcDlzTzc4dG9MR0hvdDRaTTJXU0gvL1llZlRW?=
 =?utf-8?B?RGRDelNNS3lSY2lvMWZHWm41Qkx3WXZxaEtTWnFPOFVPcDRLWnI5YW9LUm9O?=
 =?utf-8?B?WkFTcUd3c2lZZERvK0NvcWduRk1BNjkrcVZQcjVnTVcvK3k0QjBPanIxeWY3?=
 =?utf-8?B?UzJOY2RZRzZlU1BveldVcXpJWnBYTFdLQ01CbU9xRDJFMEQwTEdVWnRYZHdS?=
 =?utf-8?B?VGtBTFBlWFZmcGhVUWFFZ3JWRmQ2MEMrL1E4UVpKbFo5VnlRaXRkd3YyZFlN?=
 =?utf-8?B?ZWNQRCtaclFlWUJQVjZtcU82Wnh4RzZEOUw0WUVEN0lWSjlmQitoRE05V2dH?=
 =?utf-8?B?UTFQQXJPYjBTbCtQOWZRNEVqUmFTMWhzYVZIVFFIVHRaRGR4c3kzVCtoQ1o4?=
 =?utf-8?B?YnhMYXJKeS8xSlEvSXZzZkRtV1JIODByVTVNREJUcjZKdUxRcE84V0psSFh6?=
 =?utf-8?B?cVhaTmk1WmJNTEVHTVlCYjZOdktSRFJQRi9CMUlHTGF1aXZ4YUI5MTRCaUJi?=
 =?utf-8?B?L0RkL0huWm50cTdLMXhDNzlGUXdUd2EzUzFaSXRXcXZ5SFBDYzE2WUd6QWpW?=
 =?utf-8?B?d2Zqa2h4VnNROWRrL0FrckdpK3dSL0NVNzdESjA3VE1seFh2WlpzOGhVS1hv?=
 =?utf-8?B?NXRVTjRDK1BIUjY2eUtjZ1liMDFETWhZa1JPTDRtUjVyWEVPeXFWdm5zaUtF?=
 =?utf-8?B?V2tDMHVjNitnZUY0cmhnWGFRb1pGcG9OZWdYQm9Ld0VuUDh1VDdMcThkTzlM?=
 =?utf-8?B?UTc4YVNaajNKR2xhSkU0bHkwV1pLZUFyM3REOFh4dFp2RWliZ2sxTkEvTGE4?=
 =?utf-8?B?NnZZdWhjaS93eUg2WnVBRE44NG1CQzZXelV5cy96aUw4R1dCK2pqZ1JvS28y?=
 =?utf-8?B?QW82ZkJqTlArR3dWU043ZXdid0JCMHF3SFhHNmZ3RHB5dnJIWk83T1hxYnhY?=
 =?utf-8?B?cUNnQk15US9ycG1teXBuYUxPaWxvOEowMm40VVdNZ3dUa3NJZTMvaWNvOE9X?=
 =?utf-8?B?RHo1RHFUUWZ6TW5QUW5QbFBxNDEvd1g2VGlhT0QyeTNsdlVoV3JCekVwMnRO?=
 =?utf-8?B?M3NUeGtqZ2lpQ0JkWFNJVDdacTIvWlZIOUo4dHp0aVlVVHhNNzJEUTFzdllp?=
 =?utf-8?B?U24rUk12SjdSZ05KVG1NSDNNRFRPLy9XTU1XYmw0UHNwME9qdFVNdVY2RHBz?=
 =?utf-8?B?K1NGbnZMdENBVWQyVFJqaUNTcU9tR01qVTlFSUhjVkhUbGdYZ2xOMkpXcjk2?=
 =?utf-8?B?NDZGZkdjU2NHVTlkblBiUTZKNFVRVnpzK0dsL3BacmdjMWZSR3k1ekh4MmJL?=
 =?utf-8?B?QVFpTVE4Y0NaK1FZcnIxS25uTndKSzdrRVQyYUtMOFpXMVZ3WDdpTU1SbnU5?=
 =?utf-8?B?WVFsb2ljdDVyRDRoSmpjNVJXNWhaZlJRMitwQStNMHEwblhaZUM1MitmOFQw?=
 =?utf-8?B?dWtqOG1DQmppMVJjMDYwdGordUcwUm9maUEwSjlta3UzOWdGMmFuL2VlZmhZ?=
 =?utf-8?B?djZ0MW5LaVFxbHYxS1JwUDRkeDBOY1pZdHFlNWJ4TWpnSXdSYzNGOTNuK25H?=
 =?utf-8?B?OWZheVE1Q1BtZ0hWSVhqWXJibERKQXdMYXFNMUJ1Mmp2YW44Ync0SUFQVFZh?=
 =?utf-8?B?bEVQV2JsY1o5aVRUNkpEdzVaQ2NNMXNSVEdaeXUySjVuYUo1RDdwaFZQL3N0?=
 =?utf-8?B?Z1I5bWsxT3VtQWlFRU5qYXRiRkx2QjVBUzNMaWduN0kyNmpiR2FRVGVTZzlC?=
 =?utf-8?B?QWM3aVBBWHg4SmZlMHpxQ0lQV0crbHNrRjhFSGw2Z3JTNUlycnRIVm93L09R?=
 =?utf-8?B?Y1hCNGhlT09KTStTa3JkaXBxZWNOM3ZSaDViaEdWbHdWQklKRHdSd042OVFD?=
 =?utf-8?B?NStRWEpGSld6Z3J0Q3l3RmM4aEdYNjNuMzYwcS9GTzJ0TlJvVEc2c3Vid1Bp?=
 =?utf-8?B?dExwdzJPemxkdDR1Vy9XZ0NQdkdYREhkT3dGaGxjZ3EwQnl4SXFMQjRMYnh2?=
 =?utf-8?B?R2dXcm4vbjEwc1dDTWd5ZWxjYnl0dGNNRFB5VXZaSnZqUDFEZjhjREpMU1dT?=
 =?utf-8?B?aUZmWGlISHgwWVZQN1cyTnpycENuSERKNGUxSk4zUUIxK2xuL1FFb2ZYTW85?=
 =?utf-8?B?cU95RXNETUIvU0U0YlV0QnZ3SE9TM1U2aUtCWXVuT0VVZGRoSW9jWGtiUjI3?=
 =?utf-8?B?MHBDN0ExdHljYjBoMFl3MHdqZXB5MGoveEcrUUZuVk9IaGFIRnpVRkE3NHZm?=
 =?utf-8?B?VVpTOEppNlN2dHoyMjZ0K29LTjd3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100b66bc-166d-496e-d9e6-08dc2d671331
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:13:10.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwDPyW2u25pD0kEBgtzujkhqNINiLsGx+oS6OoXLqB+RMIuffoMLN51ds7BYaD7ZZqcTKCgp6uC6kss8c9x4D4KuVDrYMqPaHMYVR7+uXZE3DUh0lEWLjsQWUM428oxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9970
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

Hi Andy,

On 2/14/24 10:31, Andy Yan wrote:
> [You don't often get email from andyshrk@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> CoolPi 4B is a rk3588s based SBC.
> 
> Specification:
> - Rockchip RK3588S
> - LPDDR4 2/4/8/16 GB
> - TF scard slot
> - eMMC 8/32/64/128 GB module
> - SPI Nor 8MB
> - Gigabit ethernet drived by PCIE with RTL8111HS
> - HDMI Type D out
> - Mini DP out
> - USB 2.0 Host x 2
> - USB 3.0 OTG x 1
> - USB 3.0 Host x 1
> - WIFI/BT module AIC8800
> - 40 pin header
> 
> The dts is from linux-6.8 rc1.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - sync dts from linux-rockchip which will be in linux-6.8 rc6[0]
> 
> [0]https://patchwork.kernel.org/project/linux-rockchip/patch/2450634.jE0xQCEvom@phil/
>   arch/arm/dts/Makefile                      |   1 +
>   arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi |  30 +
>   arch/arm/dts/rk3588s-coolpi-4b.dts         | 812 +++++++++++++++++++++
>   board/rockchip/evb_rk3588/MAINTAINERS      |   7 +
>   configs/coolpi-4b-rk3588s_defconfig        | 105 +++
>   5 files changed, 955 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-coolpi-4b.dts
>   create mode 100644 configs/coolpi-4b-rk3588s_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index ce10d3dbb0..ae7c088ceb 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -190,6 +190,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>          rk3568-rock-3a.dtb
> 
>   dtb-$(CONFIG_ROCKCHIP_RK3588) += \
> +       rk3588s-coolpi-4b.dts \
>          rk3588-edgeble-neu6a-io.dtb \
>          rk3588-edgeble-neu6b-io.dtb \
>          rk3588-evb1-v10.dtb \
> diff --git a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
> new file mode 100644
> index 0000000000..6b69ff424f
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +       };

This is already in rk3588s-u-boot.dtsi

> +};
> +
> +&fspim2_pins {
> +       bootph-all;
> +};
> +
> +&sfc {
> +       bootph-pre-ram;
> +       u-boot,spl-sfc-no-dma;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&fspim2_pins>;
> +       status = "okay";
> +
> +       flash@0 {
> +               bootph-pre-ram;
> +               compatible = "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <24000000>;
> +               spi-rx-bus-width = <4>;
> +               spi-tx-bus-width = <1>;
> +       };
> +};
> diff --git a/arch/arm/dts/rk3588s-coolpi-4b.dts b/arch/arm/dts/rk3588s-coolpi-4b.dts
> new file mode 100644
> index 0000000000..e037bf9db7
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-coolpi-4b.dts
> @@ -0,0 +1,812 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
> + *
> + * https://cool-pi.com/topic/130/coolpi-4b-product-spec-introduction
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +       model = "RK3588S CoolPi 4 Model B";
> +       compatible = "coolpi,pi-4b", "rockchip,rk3588s";
> +
> +       aliases {
> +               mmc0 = &sdhci;
> +               mmc1 = &sdmmc;
> +               mmc2 = &sdio;
> +       };
> +
> +       analog-sound {
> +               compatible = "audio-graph-card";
> +               dais = <&i2s0_8ch_p0>;
> +               label = "rk3588-es8316";
> +               routing = "MIC2", "Mic Jack",
> +                         "Headphones", "HPOL",
> +                         "Headphones", "HPOR";
> +               widgets = "Microphone", "Mic Jack",
> +                         "Headphone", "Headphones";
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +
> +       leds: leds {
> +               compatible = "gpio-leds";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&gpio_leds>;
> +
> +               led0: led-green {
> +                       color = <LED_COLOR_ID_GREEN>;
> +                       function = LED_FUNCTION_STATUS;
> +                       gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               led1: led-red {
> +                       color = <LED_COLOR_ID_RED>;
> +                       default-state = "off";
> +                       function = LED_FUNCTION_WLAN;
> +                       gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "phy0tx";
> +               };
> +       };
> +
> +       sdio_pwrseq: sdio-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&hym8563>;
> +               clock-names = "ext_clock";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_enable_h>;
> +               /*
> +                * On the module itself this is one of these (depending
> +                * on the actual card populated):
> +                * - SDIO_RESET_L_WL_REG_ON
> +                * - PDN (power down when low)
> +                */
> +               post-power-on-delay-ms = <200>;
> +               reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
> +       };
> +
> +       vcc12v_dcin: vcc12v-dcin-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc12v_dcin";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <12000000>;
> +               regulator-max-microvolt = <12000000>;
> +       };
> +
> +       vcc5v0_sys: vcc5v0-sys-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc12v_dcin>;
> +       };
> +
> +       vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_usbdcin";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc12v_dcin>;
> +       };
> +
> +       vcc5v0_usb: vcc5v0-usb-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc5v0_usb";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_usbdcin>;
> +       };
> +
> +       avdd0v85_pcie20: avdd0v85-pcie20-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "avdd0v85_pcie20";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <850000>;
> +               regulator-max-microvolt = <850000>;
> +               vin-supply = <&vdd_0v85_s0>;
> +       };
> +
> +       avdd1v8_pcie20: avdd1v8-pcie20-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "avdd1v8_pcie20";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               vin-supply = <&avcc_1v8_s0>;
> +       };
> +
> +       vcc3v3_mipi: vcc3v3-mipi-regulator {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
> +               regulator-name = "vcc3v3_mipi";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               vin-supply = <&vcc_3v3_s3>;
> +       };
> +
> +       vcc5v0_host: vcc5v0-host-regulator {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vcc5v0_host_en>;
> +               regulator-name = "vcc5v0_host";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_otg: vcc5v0-otg-regulator {
> +               compatible = "regulator-fixed";
> +               enable-active-high;
> +               gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vcc5v0_u3host_en>;
> +               regulator-name = "vcc5v0_otg";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
> +       vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc_1v1_nldo_s3";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1100000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +};
> +
> +&combphy0_ps {
> +       status = "okay";
> +};
> +
> +&combphy2_psu {
> +       status = "okay";
> +};
> +
> +&cpu_l0 {
> +       cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_b0 {
> +       cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +       cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&i2c0 {
> +       pinctrl-0 = <&i2c0m2_xfer>;
> +       status = "okay";
> +
> +       vdd_cpu_big0_s0: regulator@42 {
> +               compatible = "rockchip,rk8602";
> +               reg = <0x42>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_cpu_big0_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <550000>;
> +               regulator-max-microvolt = <1050000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_cpu_big1_s0: regulator@43 {
> +               compatible = "rockchip,rk8603", "rockchip,rk8602";
> +               reg = <0x43>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_cpu_big1_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <550000>;
> +               regulator-max-microvolt = <1050000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +
> +       vdd_npu_s0: regulator@42 {
> +               compatible = "rockchip,rk8602";
> +               reg = <0x42>;
> +               fcs,suspend-voltage-selector = <1>;
> +               regulator-name = "vdd_npu_s0";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <550000>;
> +               regulator-max-microvolt = <950000>;
> +               regulator-ramp-delay = <2300>;
> +               vin-supply = <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c6 {
> +       pinctrl-0 = <&i2c6m3_xfer>;
> +       status = "okay";
> +
> +       hym8563: rtc@51 {
> +               compatible = "haoyu,hym8563";
> +               reg = <0x51>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +               #clock-cells = <0>;
> +               clock-output-names = "hym8563";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hym8563_int>;
> +       };
> +};
> +
> +&i2c7 {
> +       pinctrl-0 = <&i2c7m0_xfer>;
> +       status = "okay";
> +
> +       es8316: audio-codec@11 {
> +               compatible = "everest,es8316";
> +               reg = <0x11>;
> +               assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> +               assigned-clock-rates = <12288000>;
> +               clocks = <&cru I2S0_8CH_MCLKOUT>;
> +               clock-names = "mclk";
> +               #sound-dai-cells = <0>;
> +
> +               port {
> +                       es8316_p0_0: endpoint {
> +                               remote-endpoint = <&i2s0_8ch_p0_0>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2s0_8ch {
> +       pinctrl-0 = <&i2s0_lrck
> +                    &i2s0_mclk
> +                    &i2s0_sclk
> +                    &i2s0_sdi0
> +                    &i2s0_sdo0>;
> +       status = "okay";
> +
> +       i2s0_8ch_p0: port {
> +               i2s0_8ch_p0_0: endpoint {
> +                       dai-format = "i2s";
> +                       mclk-fs = <256>;
> +                       remote-endpoint = <&es8316_p0_0>;
> +               };
> +       };
> +};
> +
> +&pcie2x1l2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&rtl8111_isolate>;
> +       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
> +
> +&pinctrl {
> +       hym8563 {
> +               hym8563_int: hym8563-int {
> +                       rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +
> +       led {
> +               gpio_leds: gpio-leds {
> +                       rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>,
> +                                       <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
> +               };
> +       };
> +
> +       rtl8111 {
> +               rtl8111_isolate: rtl8111-isolate {
> +                       rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +
> +       sdio-pwrseq {
> +               wifi_enable_h: wifi-enable-h {
> +                       rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +
> +       usb {
> +               vcc5v0_host_en: vcc5v0-host-en {
> +                       rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>,
> +                                       <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +
> +               vcc5v0_u3host_en: vcc5v0-u3host-en {
> +                       rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       wireless-bluetooth {
> +               bt_reset_gpio: bt-reset-pin {
> +                       rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_wake_gpio: bt-wake-pin {
> +                       rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_wake_host_irq: bt-wake-host-irq {
> +                       rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
> +               };
> +       };
> +
> +       wireless-wlan {
> +               wifi_host_wake_irq: wifi-host-wake-irq {
> +                       rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
> +               };
> +
> +               wifi_poweren_pin: wifi-poweren-pin {
> +                       rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +};
> +
> +&pwm2 {
> +       pinctrl-0 = <&pwm2m1_pins>;
> +       status = "okay";
> +};
> +
> +&pwm13 {
> +       pinctrl-names = "active";
> +       pinctrl-0 = <&pwm13m2_pins>;
> +       status = "okay";
> +};
> +
> +&saradc {
> +       vref-supply = <&vcc_1v8_s0>;
> +       status = "okay";
> +};
> +
> +&sdhci {
> +       bus-width = <8>;
> +       max-frequency = <200000000>;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       status = "okay";
> +};
> +
> +&sdio {
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       cap-sdio-irq;
> +       disable-wp;
> +       keep-power-in-suspend;
> +       max-frequency = <150000000>;
> +       mmc-pwrseq = <&sdio_pwrseq>;
> +       no-sd;
> +       no-mmc;
> +       non-removable;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdiom1_pins>,<&wifi_poweren_pin>;
> +       status = "okay";
> +};
> +
> +&sdmmc {
> +       bus-width = <4>;
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       disable-wp;
> +       max-frequency = <150000000>;
> +       no-sdio;
> +       no-mmc;
> +       sd-uhs-sdr104;
> +       vmmc-supply = <&vcc_3v3_s3>;
> +       vqmmc-supply = <&vccio_sd_s0>;
> +       status = "okay";
> +};
> +
> +&spi2 {
> +       assigned-clocks = <&cru CLK_SPI2>;
> +       assigned-clock-rates = <200000000>;
> +       num-cs = <1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +       status = "okay";
> +
> +       pmic@0 {
> +               compatible = "rockchip,rk806";
> +               reg = <0x0>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +                           <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +               spi-max-frequency = <1000000>;
> +               vcc1-supply = <&vcc5v0_sys>;
> +               vcc2-supply = <&vcc5v0_sys>;
> +               vcc3-supply = <&vcc5v0_sys>;
> +               vcc4-supply = <&vcc5v0_sys>;
> +               vcc5-supply = <&vcc5v0_sys>;
> +               vcc6-supply = <&vcc5v0_sys>;
> +               vcc7-supply = <&vcc5v0_sys>;
> +               vcc8-supply = <&vcc5v0_sys>;
> +               vcc9-supply = <&vcc5v0_sys>;
> +               vcc10-supply = <&vcc5v0_sys>;
> +               vcc11-supply = <&vcc_2v0_pldo_s3>;
> +               vcc12-supply = <&vcc5v0_sys>;
> +               vcc13-supply = <&vcc_1v1_nldo_s3>;
> +               vcc14-supply = <&vcc_1v1_nldo_s3>;
> +               vcca-supply = <&vcc5v0_sys>;
> +
> +               rk806_dvs1_null: dvs1-null-pins {
> +                       pins = "gpio_pwrctrl2";
> +                       function = "pin_fun0";
> +               };
> +
> +               rk806_dvs2_null: dvs2-null-pins {
> +                       pins = "gpio_pwrctrl2";
> +                       function = "pin_fun0";
> +               };
> +
> +               rk806_dvs3_null: dvs3-null-pins {
> +                       pins = "gpio_pwrctrl3";
> +                       function = "pin_fun0";
> +               };
> +
> +               regulators {
> +                       vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +                               regulator-name = "vdd_gpu_s0";
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <400>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +                               regulator-name = "vdd_cpu_lit_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_log_s0: dcdc-reg3 {
> +                               regulator-name = "vdd_log_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <675000>;
> +                               regulator-max-microvolt = <750000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <750000>;
> +                               };
> +                       };
> +
> +                       vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +                               regulator-name = "vdd_vdenc_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <550000>;
> +                               regulator-max-microvolt = <950000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_ddr_s0: dcdc-reg5 {
> +                               regulator-name = "vdd_ddr_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <675000>;
> +                               regulator-max-microvolt = <900000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <850000>;
> +                               };
> +                       };
> +
> +                       vdd2_ddr_s3: dcdc-reg6 {
> +                               regulator-name = "vdd2_ddr_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_2v0_pldo_s3: dcdc-reg7 {
> +                               regulator-name = "vdd_2v0_pldo_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <2000000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <2000000>;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s3: dcdc-reg8 {
> +                               regulator-name = "vcc_3v3_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <3300000>;
> +                               };
> +                       };
> +
> +                       vddq_ddr_s0: dcdc-reg9 {
> +                               regulator-name = "vddq_ddr_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s3: dcdc-reg10 {
> +                               regulator-name = "vcc_1v8_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       avcc_1v8_s0: pldo-reg1 {
> +                               regulator-name = "avcc_1v8_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s0: pldo-reg2 {
> +                               regulator-name = "vcc_1v8_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       avdd_1v2_s0: pldo-reg3 {
> +                               regulator-name = "avdd_1v2_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s0: pldo-reg4 {
> +                               regulator-name = "vcc_3v3_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vccio_sd_s0: pldo-reg5 {
> +                               regulator-name = "vccio_sd_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-ramp-delay = <12500>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       pldo6_s3: pldo-reg6 {
> +                               regulator-name = "pldo6_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <1800000>;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s3: nldo-reg1 {
> +                               regulator-name = "vdd_0v75_s3";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt = <750000>;
> +                               };
> +                       };
> +
> +                       vdd_ddr_pll_s0: nldo-reg2 {
> +                               regulator-name = "vdd_ddr_pll_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <850000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt = <850000>;
> +                               };
> +                       };
> +
> +                       avdd_0v75_s0: nldo-reg3 {
> +                               regulator-name = "avdd_0v75_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v85_s0: nldo-reg4 {
> +                               regulator-name = "vdd_0v85_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <850000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_0v75_s0: nldo-reg5 {
> +                               regulator-name = "vdd_0v75_s0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <750000>;
> +                               regulator-max-microvolt = <750000>;
> +
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&tsadc {
> +       status = "okay";
> +};
> +
> +&u2phy2 {
> +       status = "okay";
> +};
> +
> +&u2phy3 {
> +       status = "okay";
> +};
> +
> +&u2phy2_host {
> +       phy-supply = <&vcc5v0_host>;
> +       status = "okay";
> +};
> +
> +&u2phy3_host {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-0 = <&uart2m0_xfer>;
> +       status = "okay";
> +};
> +
> +/* bt */
> +&uart9 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
> +};
> +
> +&usb_host0_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +       status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 2bd44bc587..1604229759 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -1,3 +1,10 @@
> +COOLPI-4B-RK3588S
> +M:     Andy Yan <andyshrk@163.com>
> +S:     Maintained
> +F:     configs/coolpi-4b-rk3588s_defconfig
> +F:     arch/arm/dts/rk3588s-coolpi-4b.dts
> +F:     arch/arm/dts/rk3588s-coolpi-u-boot.dtsi
> +
>   EVB-RK3588
>   M:     Kever Yang <kever.yang@rock-chips.com>
>   S:     Maintained
> diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
> new file mode 100644
> index 0000000000..3e3e5abc86
> --- /dev/null
> +++ b/configs/coolpi-4b-rk3588s_defconfig
> @@ -0,0 +1,105 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-coolpi-4b"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y

Is there any reason for NOT enabling MMC_HS400_ES?

Cheers,
Quentin
