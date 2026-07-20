Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BF8C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 10:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C69838D7;
	Mon, 20 Jul 2026 12:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n5n8ucIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A3683E76; Mon, 20 Jul 2026 12:24:00 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F200980517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3PQHm7hp941hGI6W7oXbB9MnGGg2ChysOjVXqc5Kp3VhnHG9evlU1tpYp+D29ckrZ9G5YU89zoD6zoGOarSgEHVPm9w/IKkM0edSRRciHJLoFWvoO20H0s6cr5mawAghhTr4qiILmNgPB8vBi+K0qHAa1o+I32GXUkvCUcVBA+WFY7Lyw2d5xPTHsGRR99pfKcbYHYsVXfSLZqHfKEQbLDECcNBrOHg6QwGEeGy+UrVFm4rlKYnj/a81v9Dp1pPjnL81eJuygdRu+iZMRSSpM3xuTM9rnaksBk1Cak8bzcB7aGRwZTzcdFOqereZ3/GkpAG3bd4bmsk41N9DhnhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVhzKbtd7P7p6VRJXq+gQHE0THmJwEPH1Dz0uIwgZd0=;
 b=qbWPD65N1cvOOcQIZO5PhVVtc34l0iMIhIgMpyMvbR0G3RaPR/YVian5ZHxZvilHPQNNAn970e2dlkO5y/xU/5WRkAN+ZFA/gG2/6/LdA5u5kOBPji+NS/YySgFMNQ1ZeN9eD1LUzCyWhQo1Lg/z+aAFKQI3nGpD+efh8h/TCB1+f/9LjIKkN62rwbaCmngTLqpc4a7U60nJfkRGwDMfb7q8kcTSRts9ydefrSgLbHDGUfzCAZZ8Pf5JQB76Vkstl5tzUyARk/1CUvvyRxjMYsmiqRAw3TJHBs5ZUcFpsjoKZ+kCQA7QJ/Wr3w582QQWI5Z563UYhtm8GuNIX6vHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVhzKbtd7P7p6VRJXq+gQHE0THmJwEPH1Dz0uIwgZd0=;
 b=n5n8ucIpN9sqOeVqeODQ/On4seBvn+Wxz2nWWH7fwoV4Mmio4jES5IqYDewtxuVC9F5Uu5E9QHtzAFvIibMZF4Deh+9wujMgka9Qr9jTaEA+MyvvNrKpikx9JsHjQ/G0Zgx4F6fZzEHoCLXexGSoeoJcVt1drkKBVpkpax4wzmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA6PR04MB11952.eurprd04.prod.outlook.com (2603:10a6:102:51b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Mon, 20 Jul
 2026 10:23:54 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 10:23:54 +0000
Message-ID: <aa50425b-96d3-458b-b13d-5fb00efea33d@cherry.de>
Date: Mon, 20 Jul 2026 12:23:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588s: Add support for ROC-PC-RK3588S
To: Fabio Estevam <festevam@gmail.com>, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de
References: <20260626015340.2375163-1-festevam@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260626015340.2375163-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0031.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA6PR04MB11952:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e07e128-f560-43e0-fd2c-08dee6490054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|5023799004|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: MESdwaUcKo2MdJpK7QZ3S42+3tRgki/VzR6FlPhy00ohl0c7ruQ5fvAg+qGhuAV4Y/jvJmQ/4EyCdnIkq22/5qTRTBmtvWfCkRiMZSm7OtXiGzADsoYQxAcDcFuEQBGn9SIYBa6Bq86J81NN91bU0FFjfX6Nk82r5ZOpZCzkcGQfAQ74qsTPQTxW0+otKhhUOvUeD1YULwfsvDx+kbTyt0BV4a/As70SX6ZCPvvuAq3yE8DT9Qnc88NYQ+xq334NTHMAsAJqMeoXlWxvkLf5P/VvA2tgA4MRxta85Vm8rv4uNyWdJUiclxU9KQnZw0mIx7zQW7SNIUUOQvqAp0vdBbs/ZMDHLu7y7mgfn9bjp4Pv4f4+jRdafGiak1K0pb8NSksvowX0ssPvlFOamizrVqSiYFR3UuYUh6oo+nXqV2HNZy2x2J++tp/HLvNZWYZx3dp6o4bXAsKV3jXiO6dI+kHOo22hRJgyKirC20g76QPpV5X7svM1wmh2Se7thkmktlhjyHw3MBqQqZKf7GkTf5q95z97L8604ZumjyyNRDXE2VKDOg+DYhYHYnB7N5kP/BiguGMplVXkAgub/i/gxZRpJ4gCesnAKumvulBA5mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXl3dEs0U3BLQ2hKMktZeEp0cjJGMlhhSFpGaStoNkpxTkhOZGJJVXh3Y1Na?=
 =?utf-8?B?MDhVeDNOcCtqRGsrelVVaXpuMklVNEZQN1FUbUU0NENMU083YzJ0RnA0aEdo?=
 =?utf-8?B?bU0rNml4RGtsbWZVbVVYWEhuOUVqN0dIcGc2eWJYQkhyczZwRG05TUcvcHps?=
 =?utf-8?B?QWk4K2cxV3dKZ0ZMQ3ZVaHc1YzZkU1dycnkxK2M0QldrbVlqMUNleS9GaXNV?=
 =?utf-8?B?enJxZG1yK1FBRitObHJ0L2gvNXkzU3dSaUJZVVAxL3N1dG9qQTQ4eUdtNVUr?=
 =?utf-8?B?QUpNZWNFLytpN3lQZGVtVnBNUUJxcFlwVlQxR1ZmYWpycDlMYU1WNmprVnkz?=
 =?utf-8?B?UVd5WWpKT3BYbC9GbEhIWkY1YUVkN2g0Q0pMb1dTT3hNamlyM1VQRm1HbGp2?=
 =?utf-8?B?cGVuazdma3FTYU9aWTdVMmtrMDErUTg2U2lubElXOUJaSXhJbklPWEtZYWxw?=
 =?utf-8?B?US84ZHc2MDJsSXhUQjZRTHlob2lLa3lwSTVxT1Jzcks4VEEzMTIwNEMzUmZW?=
 =?utf-8?B?TnVGVGlEN2JoQXc3YWVnbmNpMzBqWXk5S2I5UjYwZi9rdU9ucG5BRGFxU0Nu?=
 =?utf-8?B?TDg1TktqRXZaN25DdUUwQkN6SXJGcHdKRUNVaHZOL2JWTjlUWlo3WTUyUExV?=
 =?utf-8?B?aTgwdHFxeDNoTXJMK3VROTlPd096YVc1MGdPdWF0bXBnZHJEL1pXOHNjYWxp?=
 =?utf-8?B?QnBYTThkTjJEQmx6cEhFUVpGODdtRHF5eGY2dHF4MW5WU3Jha1dBczJrNW5j?=
 =?utf-8?B?blJQMU1MU1I2a1pzU096Mytxc2pnTW4zYVYydmY1Ti9xbWlwNXBDT1kwVzdJ?=
 =?utf-8?B?SXhxTEgyeWI4ZVl2V0FkTVUycnV1aEdLOFY4amN2RmJBWEU0c1RLRVBmTGww?=
 =?utf-8?B?NEtKQmFOeU9GRDBjdDl6ZGVqQk5OcGRmMGJDeFhrUE1wQlI5dXFHTlc0VHV1?=
 =?utf-8?B?bmFZMkp0OEI0OEVTS0dhOSsxa212cEp5a2Joa0FBTDVOZFExNHBKWU1kclhM?=
 =?utf-8?B?ejlQeEhsOG40MlBmSjliMlBIdFpabEtRSDE5aVBLcHlpWE1pajk1WE5ZR1Y3?=
 =?utf-8?B?OHdRVXNIMWFZblExdWEwTlg2YmhpR3JmTjFZemc0VEpmQ3ZuZHpuYzhTcXEv?=
 =?utf-8?B?OTY2N2RlUkRzTDNkUEFhN3Y4MEhIUjVQcnJ0RmRIUHFlUWtRRFBNKzFRd05v?=
 =?utf-8?B?NnU5Q0s3dHVsUFBjVWUwSzNzY3p3cG5FTEhac0FqUGQ4anZLV2lWT3AvcjFT?=
 =?utf-8?B?M05SbjBIWEhZZGM2dmJuUE5vdXdRM2EyVEptSDQ3WTF5YUcyY0grVVpKLzdW?=
 =?utf-8?B?SThtUDQvaXNpK3I0bjAzT3RPNmZjdWlwVzdLMzRpbHAwYjFGa2d1cExjY0dB?=
 =?utf-8?B?SWhqTnpTOTcvenBKb3JiRHpFMnh1QnYyNHJPYWpwaE1YdFhTbS8xOHN2Z3N2?=
 =?utf-8?B?SXdxdkZQNDlRaE55cDliZDFVOVBqbjlFeVVtSTdzWjh4Q1BxSHhVUTc2UTFl?=
 =?utf-8?B?MWsreGZGdHdZSkRWZ2xNQ2Z1c2c0Z3hMcFVMMEREK0tham5iSGY0aXFFZnlP?=
 =?utf-8?B?cm5kazBnNGh2TkNPd2c2RUd2dGJITm1UY3pkQ1FweHFFNkpuQTdFbXhwaFZP?=
 =?utf-8?B?NWNpZXFOSk9hdFVRbWxOWXRKK2lQS1F5ZE5aM0ZxNnlzcDgwNmJwU2dCL2lO?=
 =?utf-8?B?ZHVxMnJTZm1IbUh2OTlwd2dxeFZHNzlYVDc4cGtEbEJUYW5mUkMranpRK3FT?=
 =?utf-8?B?SmxCNGNZdVh5V3hsQk0rWWVtMTNpZDBnK2NJOXVCVElvNzVNWmUxNE5tWEpK?=
 =?utf-8?B?emRpajF0cXNidTQxclg2Y0ZiYWdlRTJYTm15djMrZkgxZ0drMFF0VE9laDRu?=
 =?utf-8?B?UjNVZ0VGODk4UmNmQ0J0MDJkbWt0cm4wOG9DamtIelhRWmFKd0JYWjZ0RjZk?=
 =?utf-8?B?cnFyR3VsY0dhU2RodWlSZ2wzbHdwQS9UYWViU2psSmkwQ3YvTGt5U3RlalBQ?=
 =?utf-8?B?R21kU2FPQ3V4L1lmSkkrS2JOYUJYdUlMVWs2WWpFVUZHZ20wK2pnMHRQQklR?=
 =?utf-8?B?Z2tUZkVMSGhiR3hyVnppV2FMVHZsTm9RcC9aTDQwbjh6RlZOSGdNc2xkMXpU?=
 =?utf-8?B?U2JUYWVqWk5NejFPdFJYUHJzKzM2blFyN05Ob3NFMVhxdy9Nd01wRHpIeGpT?=
 =?utf-8?B?ZWJsWFZvUmFFSFU0ODVnZFkveUhWeWh2QWdvVE1rL3BDdTM3b05aZTQrTk0x?=
 =?utf-8?B?VHcxWDNiaDhUVnk5UGFwNnJyQnFHZDZpUGhxcGtlOGJhOTJIYU9NMU14aTVQ?=
 =?utf-8?B?czYxU2ZjRXMydlJ2SUltV2FyaG5PRGd5eVArYTMxNERZRmZWT1J5UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e07e128-f560-43e0-fd2c-08dee6490054
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:54.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGNSw/xg10u+xlX10Llt0TklfE41MP6tJPVt5/9X1H9nrEiNtSmTFr+YdyllICQX6iURq8eEMZcaUE5ZLInBaaWM3yC6mf/tNRln1Ag6jHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11952
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

Hi Fabio,

On 6/26/26 3:53 AM, Fabio Estevam wrote:
> The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
> SoC.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi  |  7 ++
>   arch/arm/mach-rockchip/rk3588/Kconfig    |  7 ++
>   board/firefly/roc-pc-rk3588s/Kconfig     | 12 ++++
>   board/firefly/roc-pc-rk3588s/MAINTAINERS |  7 ++
>   configs/roc-pc-rk3588s_defconfig         | 91 ++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst          |  1 +
>   include/configs/roc-pc-rk3588s.h         |  8 +++
>   7 files changed, 133 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
>   create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
>   create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
>   create mode 100644 configs/roc-pc-rk3588s_defconfig
>   create mode 100644 include/configs/roc-pc-rk3588s.h
> 
> diff --git a/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> new file mode 100644
> index 000000000000..e2ed7ce6232b
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};

Please send this upstream first and sync once it's available in 
devicetree-rebasing or justify why it needs to live in U-Boot only. We 
would like to have everything upstream for Rockchip DTSes (aside from 
the bootph- properties and some exceptions like binman nodes and other 
U-Boot-specific oddities).

> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 675f13ab66d7..841ae490e85a 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -208,6 +208,12 @@ config TARGET_RK3588_NEU6
>   	  IO board and Neu6a needs to mount on top of this IO board in order to
>   	  create complete Edgeble Neural Compute Module 6B(Neu6B) IO platform.
>   
> +config TARGET_ROC_PC_RK3588S
> +	bool "Firefly ROC PC RK3588S"
> +	help
> +	  ROC-PC-RK3588S is a single board computer from Firefly
> +	  using the Rockchip RK3588S.
> +
>   config TARGET_ROCK5A_RK3588
>   	bool "Radxa ROCK5A RK3588 board"
>   	help
> @@ -421,6 +427,7 @@ config SYS_SOC
>   source "board/armsom/sige7-rk3588/Kconfig"
>   source "board/coolpi/genbook_cm5_rk3588/Kconfig"
>   source "board/edgeble/neural-compute-module-6/Kconfig"
> +source "board/firefly/roc-pc-rk3588s/Kconfig"
>   source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
> diff --git a/board/firefly/roc-pc-rk3588s/Kconfig b/board/firefly/roc-pc-rk3588s/Kconfig
> new file mode 100644
> index 000000000000..bded7a2fcba1
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROC_PC_RK3588S
> +
> +config SYS_BOARD
> +	default "roc-pc-rk3588s"
> +
> +config SYS_VENDOR
> +	default "firefly"
> +
> +config SYS_CONFIG_NAME
> +	default "roc-pc-rk3588s"
> +
> +endif
> diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..9a2bb4e69e89
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ROC-PC-RK3588S
> +M:	Fabio Estevam <festevam@nabladev.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> +F:	board/firefly/roc-pc-rk3588s/
> +F:	configs/roc-pc-rk3588s_defconfig
> +F:	include/configs/roc-pc-rk3588s.h
> diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
> new file mode 100644
> index 000000000000..b625c93ad2d3
> --- /dev/null
> +++ b/configs/roc-pc-rk3588s_defconfig
> @@ -0,0 +1,91 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_ENV_OFFSET=0x400000

Historically, the environment has been stored at sector offset 8128, 
c.f. 
https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions. 
That is, it should be 0x3F8000. Sector offset 8192 is marked as 
reserved, so I guess you could store the redundant environment there, so 
have CONFIG_ENV_OFFSET_REDUND at 0x400000.

> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-roc-pc"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROC_PC_RK3588S=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_ENV_OFFSET_REDUND=0x500000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-roc-pc.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

Why do we need to remove clock-names in xPL DTB?

> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_REDUNDANT=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y

Is there really this PHY on the board? I know there's an RTL8211F, but I 
don't see an RTL8169 anywhere?

> +CONFIG_PHY_REALTEK=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y

If we remove the usbdp_phy0 enabling in U-Boot DTS, then this can be 
removed too as nothing supported by this driver will be enabled.

Looks good to me otherwise, thanks!
Cheers,
Quentin
