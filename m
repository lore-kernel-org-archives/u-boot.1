Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D40C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6712987FAE;
	Mon,  4 Mar 2024 16:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="VjIJLpa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA33B87FB1; Mon,  4 Mar 2024 16:07:52 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231FB87FA6
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/vbKaj0vYMDANM9ObNi/4LZbwftWod1Kuro6VFLPgj+UsQPKgVQxiuV8R+rjU80eGVphStFgO417NG0//MXtpJP/RLH4SE8POKNoQTsM3qzQefMOhvGcVBdqQy5LBTcMhD09fVWMCAvWicTHPZG5+hQ+AygjPRGhv/bOghDRuMlKi69C78iJjTSWAiLetwZtICyctFrRexA1geNcbYCNQPeVRj5YUyWorIUNHWmhSyvtvhpcDQ0+CQmDiPYZRLqGNCApNUsRMTJW215Q4bq+tzSh4Q1PaozU3knndumh51rujue1PG0NrAkXpDCLqlXK//u6R1y1Ktm93DlhH1QLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8QP1qSUrKzvBc7vUORFCNldcCldIUgKLyJOPZhzT38=;
 b=MKeIocCfLUUxMBrwqcTe76w14Izb1Da9vtapTc3Pny3iJ5JL2nBQHbcHPIGIhEfbmPlEZ1b54zQ06A0g5AKk/OEmsePmRmirxbqRa7WtPJ139z9cmNDjrzd7h2v0EjvvHv0pg2GBYUHJgEKZJA2ce3gXus7NC1Tv0ez6osbSngntRFXddmOEuYTvmvmHsctWNnWHEOjEp6NBUguVuKxi24njMOWgoN20KzW0rsickI4qKt1k9Koy7d8t592tYBTf9L2TVKvWOZP912QTtx7+EwGiTSJ8TCefyjOgrfrA0BqRoNLNp6EdJ/Vb+/SgVIdkUiVkaS3etWHPY9XrI+ebdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8QP1qSUrKzvBc7vUORFCNldcCldIUgKLyJOPZhzT38=;
 b=VjIJLpa93TrrkJm56D/8ubvhkSVRbdly/F9YMB/GZNmozeirDIalNt1E/tyywNR8tDK6IAjfaEmbH6HBMEJ9fibDDSpGKCpdKrl2PRgsSREVR/TJ7BanLDMNXUvYLOBwSC6/Wz/jeqxGoWba2A9f3/XtFpeJWrWsV9k7e/vZH6e8WfKd5WgCm3V0VEAVrWsZSYDo957ymNxakk7TQuwIiwWjBaO2l55akmE5wtflqPcLWWMGJ+en8oPPa6b/zX7CKeFuDCTSdEXaYp0gvnRYvB/ZFiOjho3FcYvx820TpKFBm7lvh4KOfKMfzrZxcUZKBBbK84f6/GasKyM7YCvL3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8189.eurprd04.prod.outlook.com (2603:10a6:102:1c2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 15:07:47 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:07:47 +0000
Message-ID: <256fed58-ef2a-44cc-8b99-3452c726ad01@theobroma-systems.com>
Date: Mon, 4 Mar 2024 16:07:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Rockchip Toybrick TB-RK3588X board
Content-Language: en-US
To: Elon Zhang <zhangzj@rock-chips.com>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: weizhao.ouyang@arm.com, trini@konsulko.com, u-boot@lists.denx.de
References: <20240301085004.1005425-1-zhangzj@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240301085004.1005425-1-zhangzj@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0182.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 07972bca-a775-4ed0-c30d-08dc3c5cd9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pRbRewVWaf/HGdWBs+4O89QsSFswyYtfwNUb17AeeIxCdipDYyCaOr+Oj4pazkexg12rUmfh0V+JS6vyFYGbTnnxfb7hXAg6IxvZYXgwFHNA/n+deYFkWCDcHWD04iCKTltE/aYA0sQQRbvw2HWJ/pQ4kX1J5BaZiKYCgeveRMBuTnNERDhn6b/kcywXms6lxsJakQWxFpSbqbftbjVsJIp3w9wPGCNPPB0aaQoGOWAI9w6V7vStkHe3prwgy+zhXf+Qjcf5jd7l4o2Cf0HURbkO1ITL3rk44HppQHW38lv2r0LF3eWelZbyJRU7J9lkjyGBA5Szl5o3hckgNZjOHHzkgJwm3FFJpJW9+TOxKLYkPw+6lZXE72eERvjf4GwhSeDzq8utjDzIkXFJR3lEqHB3Fr/v4H+/ylk7UbKPqHG1PwdJ+300vK8cyNGQ5uckiBhNA0BEgwoUMN4UAvt29UkBYvZMIlrvwsCmD6prvDhn7oLJ8zKenJFXzyH2JlWK+D9e/Kah0QouLUPDNdqnPoWiWU3bJ0KYer4ipgJnxElb0PJ9t9vSP9WYeYOZEySJG/BBJRj1VqB2cA8bXeMqffRBNRjJmjicduBRaRLp6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFpZ0w0VVhzVmg1WHBLeFBvVzZzZ2hvK0QzWEpFM3pMMTlJRzZTRTBORndF?=
 =?utf-8?B?Ykc1c0cvd2hBNW5Rclkzam93UGFGQVo5RVBEUUd3ajJMRnJOU0l4eTdBc1hY?=
 =?utf-8?B?ZUtNb0I0OTBvLzcvVytIRlFEY2dYRFRiRWJSajJuTEJHMkNiaFY5UjZndVBk?=
 =?utf-8?B?TExHeFYxQ09LWkNOYkducTBZQ0lZTHNwWWp1VHZvdEtBZUQ1Y1R1c0lsS2Nx?=
 =?utf-8?B?azM4VXIzU0lIQTBvZG1Qb3hOdFZ2aFBQNCsvZ3hhcjZMYnNLMU9rd0xHZ0Zw?=
 =?utf-8?B?UllEV1V6ZGZsbFZSbG9mR1E1Mm1oVEVwdnR2OVRLOVptb3g3UmdBOUhlOVov?=
 =?utf-8?B?akJRdzNCWW91eG1Genh5dFVUQ3B5WmZVbmdlamw5SmxYdEpoUXhhM3pLU2c2?=
 =?utf-8?B?bTN4d1NaeU1iVWRjTGZoeEczaWM0c3d4ZVdPR011ekdRQzhYVDZKbll3T1ZR?=
 =?utf-8?B?N1ZaRlk4WEJjejJhdXY5OEczODllSzUxYkNNb1I5d1hJVytTZUhoV2JwcUJ0?=
 =?utf-8?B?WnZ2UnRWL3FVeUxVWTByVmk5WWZUbWhFcG1ydDhabkJSUkNjK3Z2QVlEOEtM?=
 =?utf-8?B?Rkwva3U2ektZSk8vQmNXbFkrSC9ZOGdHMFZ4Q0czTkttRVUwTHJTakY3YkVW?=
 =?utf-8?B?bnAvZDU2VGJsb0kzWlJsT3BvT1FWdzBtLzJzZVdqdi9MMG1CVFFuZ0pwQXk3?=
 =?utf-8?B?Q2pyR1Ztam1aaHNlaU0wRkE2clFtY1hhOVUwcFlpZFd3cUt5WmRhQnRVS3Ur?=
 =?utf-8?B?NnNROUdBc1NEV0FJdERXb3RXWGwrMHVZcmhRODZVQlZicjlLK1BJdHhMSFpi?=
 =?utf-8?B?T2VKWnR2M052OFNoRlhUeDhKUSsyakVCZ2MxM1FtOWVyYW5CL3hvenZJY05r?=
 =?utf-8?B?NkQzRGFpTjE4TXpWMys1WEFKd0pqNlJqU3RDVnN4b0wzOW5KSVhKdlU3cnpE?=
 =?utf-8?B?K0d5QzN5V0tSY3d5TTZ1YkM0cisvaGxaOE9Fdm5DdzdFRDN4Z2ZBWGZtSk9Z?=
 =?utf-8?B?Vm9LNllIV0JVUG4xNWpKRFhsdmZoOCtmTnFRa00vNis2U1ZOT3JvSGtQbjll?=
 =?utf-8?B?WVVVcE1DRGxLNUVnTkRqS0toamo1RVNEemNJNVRlNUJtdE9CZDRlbU53Y0hn?=
 =?utf-8?B?Qi9VLzhjQ2IxTy9ESUNuQVhUbXJTaVBuYnI3dFJlU2hCR3EyVDgyb205NWEw?=
 =?utf-8?B?S1E3OTVTK0pQTW1Wa1ZkTTJVTlBzVjhaM25tSlNnbnYzd1dtTUJWS05YYkJ5?=
 =?utf-8?B?ZCtmbVIycjYxZ0UweUlIdThxc3FPaUpWT0lJVzkycWQ3QUZJOWR4R1g2VzhE?=
 =?utf-8?B?QmZWU3JiRmlseWxyd3NWMHFxU3RPVzFhNDJKbFRNcUpzS0pzUldGRGdZUk1m?=
 =?utf-8?B?UkhDWStLclVKajBJUWFaakxmeTdhUUFGYXNCZVNoRUdrWHNDcXUvb2hpVVdt?=
 =?utf-8?B?SmNvdTdCdHVQbFRDaVI3b0dKSi9LRUNXYms0Q052RTdBaWZyZHo3Skx3ZFRK?=
 =?utf-8?B?VVp4SXVZN2ZxN1R6d1NYRmFDOTVRU09WOHVBWnc4aDZWNFVhLzAzTDhlSkQ5?=
 =?utf-8?B?Z1R0SCtVTXBvN3JaL3hjS1BWT3BWOGZZdlhuUzFKMUJsbEd1c2VhdXlQdXVn?=
 =?utf-8?B?eFFhcURWWmo1MUFiMFNrNGpjQ0VBYzRiMG1rUFV0Wm05UlFpNUYxUEp1MTlx?=
 =?utf-8?B?emhKRlFIYUMyMktDRzI2RzZQSUxCNTVPbjRZbysrd0xzT0FSSlNCemhjUEZy?=
 =?utf-8?B?dzh2b3pFNG1kZFN1WjRPdFpOa1RydkhoWnNabUZUZjFQdUpnazRZYWhEU3hy?=
 =?utf-8?B?cXRyZ0pkWWpTNjlKb1NGbWhLelZxY2o1QmNWem9FL0RMWWh2bFNjYWErQmFn?=
 =?utf-8?B?YkVkTGlFV0cvYlg0WkUySmsvUHpMd2tBRXNtbWhxNnVBZXdTNzJDbkpFR21l?=
 =?utf-8?B?cWtnMTZBcWsyMFE4eXRuQ3hBcE1TQ2ZtbDh5SG8zRlpTYU9nUHRqRzdyelFG?=
 =?utf-8?B?MTRSQjduc2VZSnF4QkhlZlNwWHR5YllZeDZmc3dTemdVdUZaRVhTN3h4UFVh?=
 =?utf-8?B?YU9oeTFmUGhiWklnSGM2SFRITFl1YWNBWUFLQ1ZyZk9aVWdPbFJYZzJLeWdP?=
 =?utf-8?B?a1lJbzQ2VlpNaVlpa0ovVStLNHUxZ3YxVmJlcTdvMFRTYVhWQXlWTy9OTDh2?=
 =?utf-8?Q?EmZyUEEqmPj+m7zfwCvZne4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07972bca-a775-4ed0-c30d-08dc3c5cd9eb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:07:47.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y18DDtmPldJS5NmLuD6kyqBtg+jY6HZauvU4mSkTJl8sYjitCCMBlHKBjLtresQ10J6q1RXSKAjFKzJeyV3xddbI3CeKvb6lVCaJasNE8wviNW2BEmluDzdXyZvgIrga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8189
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

Hi Elon,

On 3/1/24 09:50, Elon Zhang wrote:
> [You don't often get email from zhangzj@rock-chips.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> TB-RK3588X board is a Rockchip Toybrick RK3588 based development board.
> 
> Specification:
>          Rockchip Rk3588 SoC
>          4x ARM Cortex-A76, 4x ARM Cortex-A55
>          8/16GB Memory LPDDR4x
>          Mali G610MC4 GPU
>          2× MIPI-CSI0 Connector
>          1x 2Lanes PCIe3.0 Connector
>          1x SATA3.0 Connector
>          32GB eMMC Module
>          2x USB 2.0, 2x USB 3.0
>          1x HDMI Output, 1x HDMI Input
>          2x Ethernet Port
> 
> Functions work normally:
>          [1] USB2.0 Host
>          [2] Ethernet0 with PHY RTL8211F
> 
> More information can be obtained from the following websites:
>          [1] https://t.rock-chips.com/en/wiki/EN/tb-rk3588x_en/index.html
>          [2] http://t.rock-chips.com/
> 
> Kernel commits:
>          8ffe365f8dc7 ("arm64: dts: rockchip: Add devicetree support for TB-RK3588X board")
>          7140387ff49d ("dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X")
> 
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> ---
> Changes since v1:
>    - Remove BOARD_SPECIFIC_OPTIONS in board Kconfig
> ---
>   arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi   |  12 +
>   arch/arm/dts/rk3588-toybrick-x0.dts           | 672 ++++++++++++++++++
>   arch/arm/mach-rockchip/rk3588/Kconfig         |  25 +
>   board/rockchip/toybrick_rk3588/Kconfig        |  12 +
>   board/rockchip/toybrick_rk3588/MAINTAINERS    |   8 +
>   board/rockchip/toybrick_rk3588/Makefile       |   6 +
>   .../toybrick_rk3588/toybrick-rk3588.c         |  39 +
>   configs/toybrick-rk3588_defconfig             |  82 +++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   include/configs/toybrick_rk3588.h             |  15 +
>   10 files changed, 872 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588-toybrick-x0.dts
>   create mode 100644 board/rockchip/toybrick_rk3588/Kconfig
>   create mode 100644 board/rockchip/toybrick_rk3588/MAINTAINERS
>   create mode 100644 board/rockchip/toybrick_rk3588/Makefile
>   create mode 100644 board/rockchip/toybrick_rk3588/toybrick-rk3588.c
>   create mode 100644 configs/toybrick-rk3588_defconfig
>   create mode 100644 include/configs/toybrick_rk3588.h
> 
> diff --git a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> new file mode 100644
> index 0000000000..1aeb5410e4
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +       chosen {
> +               u-boot,spl-boot-order = "same-as-spl", &sdhci;
> +       };
> +};
> diff --git a/arch/arm/dts/rk3588-toybrick-x0.dts b/arch/arm/dts/rk3588-toybrick-x0.dts
> new file mode 100644
> index 0000000000..f3f7c1d35e
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-toybrick-x0.dts

If I'm not mistaken, the DTS in this patch is not the same as the one 
that was merged in upstream Linux, please use the one from upstream 
Linux kernel.

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/tree/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts?h=v6.9-armsoc/dts64

Cheers,
Quentin
