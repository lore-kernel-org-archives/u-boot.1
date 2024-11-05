Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECDCD1BDDE
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 07:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D31C88E63;
	Tue,  5 Nov 2024 08:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="YKhIpH6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C737888F41; Tue,  5 Nov 2024 08:42:44 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B6088A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 08:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iekSR4UPnl3TOsYgJ2x0HTOR8j79dCHifJdIlF0H96T6c7xqdTlDr8oIe/SvdSIglPNZBQTD6dxyLziUCuQB87Vf46XVWPq4LkJlN9MW64XUrN5kY3raL1EBh5fP9FDgwn439UlNcQPX0tvbvAgyNUIik3rWG9Gqn5bKQId3mcxcl3SgAD69tqcdIjNzsQlQIGEGbnojFZVbUpZJWFKwiqVvNn2RyAniAIWBBqcJzGzq2toMvtnyEZjV/N8Np0zqWMQNv+W+SrqnfyzAhtWI7NjNflIwFC+ywRSykItXdo8xyZjW4vyTk6jwjEge2RZjoNAiK5dLwGS/x2iB5E1XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95ZH418xt94XDSJSH6RPzE2rRlKqY8XooXTyLyjkwh0=;
 b=BpTZ2/p88HE7tyX5djTxsAL4OWc+MmVCq9KMsZVk6O024IaC6NNTz7FpISX6O8GBcZiNL83eNt0XCKaivKF0J3HR1aAUBxfU9zV6QGWPnDvkzCwf2uudG5Hb9XS9GCkmEc34AiITD2iZPgULKfgjW9nlJO0/tjgM3yqGBSyXX/GLvOZ8b1X7eTnsMDpoS0aw8oFwPwXYc7b7uq5NRg9dV5uyJQ6pqgEdabIpDUbkjfJ+PCVijYUTlUsRDR32PbpieSQsiVDuqxV50OgTh935hlEADJWoago9llx3DV45sUXvlZbjVFRuhe04t9YiUsO8cShMf138M8qRcdTIbWltlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ZH418xt94XDSJSH6RPzE2rRlKqY8XooXTyLyjkwh0=;
 b=YKhIpH6bKG9tVi6UznZ1JNzkc+rTdlLKTz4fGyuys6tCi81COsplJmQod0q0FKkBH5acALnWGE3oA/u2Q3WYuSMdCtSXm+Ch6RQQrYK/RHAs5YfFw+zJlay4y6XRssHK/zTQDxWh7LyJj5lnAfBVO8xNXB+uEZ077Z98i5OVjJ0=
Received: from AS4P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::16)
 by GV1P195MB2478.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:42:37 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::91) by AS4P189CA0027.outlook.office365.com
 (2603:10a6:20b:5db::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 07:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 07:42:36 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 5 Nov 2024
 08:42:36 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 5 Nov 2024
 08:42:35 +0100
Message-ID: <1e96d288-f2ba-42f0-a20c-5527997b5fa6@phytec.de>
Date: Tue, 5 Nov 2024 08:42:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 3/3] board: phytec: imx93: Add phyCORE-i.MX93
 support all SOM variants
To: Christoph Stoidner <c.stoidner@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Mathieu Othacehe <m.othacehe@gmail.com>
References: <20241104112537.752027-1-c.stoidner@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241104112537.752027-1-c.stoidner@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|GV1P195MB2478:EE_
X-MS-Office365-Filtering-Correlation-Id: 229c6495-93c4-49da-ffc8-08dcfd6d6aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STVTVTU2UVpRM2R3M0l1YmhMazVrSjlNQXVyWFcvSzQ0bkV4aEg4MTA5SXMx?=
 =?utf-8?B?OHdNcWtkZE9iNWZvdnUxNDRKRFplSXlKZE4vNzJqWUVqNWhCbjBIdXNONCs3?=
 =?utf-8?B?eURvcjQ2dEMzYlBFek5qTUVrK2ZOUkZnUzZYZVdSMEFWVGoyMVlxSHE1OCsx?=
 =?utf-8?B?bkN4cDZUR3NUNFlReDRqSWhlSC9HV3ZGcWVKSEpNTFc5UVU4V1N4eGdncSty?=
 =?utf-8?B?ek1Gb1Bqa095cE5HUHAwdHpIODR1VVFXbHBUbXpOc0xVMUwxcERQSWJEc1h0?=
 =?utf-8?B?QVZaUUlMcVZZMFNFSlJVZ0svZGxZVm9PTXBqTGJMVERJTW41OWhibHhPbkQy?=
 =?utf-8?B?eTZTa0tsWnJDczYydkt6T1hKbWo4a2FWcTFUTFAvR0ZMa2RYV0V3WEhxZzRr?=
 =?utf-8?B?U2tWR1VrQzNKVnF2cXNvblNLSHRMTUc5dTdGK3RZbEluRUtpZUNFZmpMZkV2?=
 =?utf-8?B?aVBhdGVCVUZ0cnR3S0k4SzAxRnJVcDBjSHo2enBKdmhNU3publA2WGw2WjNI?=
 =?utf-8?B?TUNwN01zRkkwR1hKZXk1eUcrbXBtRSt1YWIxRFQ0QTJqTXJFWURzQUVLVkVX?=
 =?utf-8?B?NkVnQkdxbDVmSENFOFVNK0V5UVZWOGcza3dhN083bG1PZldMMGI3MlJ2aEEz?=
 =?utf-8?B?eXBKaCtRdm92NWVabjZPRE1tYWdvK0V5Mm9kQmoxc2pxN2hkTHRvWDh1Zyt5?=
 =?utf-8?B?UjllVEVJRmtDWUFFeVYwOUp1aXYvR2lTdFlETDAyclJuaHcraWc2a041QlU0?=
 =?utf-8?B?SEJKMnZldENWc0hCczAvY09jejhoOGhHRHJrSEo2Y3hydVRkNTBuUGdpU00z?=
 =?utf-8?B?d1loRUdzYUNORnhYL3FMVFkzdHBZazhEeURJRTRQNDg2NFNOS051UFBUV01n?=
 =?utf-8?B?T0JhREVBTkFwN1hQUmcrTXJzZXZwdkRoTXVPZWtTaUt6aTZCNldxaDMyY1Jv?=
 =?utf-8?B?U3dSOVNNTElOT1JGUmJSWGg4c2xsODZxTEZ5NEtxYStoQ1FrZVgxWEVGVjh6?=
 =?utf-8?B?SnVXZXkxb2ZHamFHdkoxMnVlbkdzMFYwTFlxTUFySXJENnIrTE5yZ1RIdTF2?=
 =?utf-8?B?L0hydXpGd1Y2QnhNYkhOYzlWeGI4QnlyQlFnNUx4Zm1wOEczMWRReENVK2N1?=
 =?utf-8?B?UjhidXJ1VnlaWjBkRFQwcGh6M0tmaWlVaUUreGtIWjY5WTFkTDAxTkFkd0hE?=
 =?utf-8?B?a1BmUU8zOEFTK002TUtNVW1mWXB0U1RlT3hNWG90RWpHbzNsNEhpT3ZmRDZl?=
 =?utf-8?B?V2J6a0NyVXBxRUg3S1Z1TktiMXh3dnBHaGIrbUI2dTNYU0NlMXdUYzBvRVh0?=
 =?utf-8?B?Z2JDdlRTVGpjVkttOGMxaUFZdGhWc0VCSWEyU0U1ZndEc1NseVJKTWIyUCts?=
 =?utf-8?B?OFFJNmxyOWZreGtobW53dkZ5dGo4NWZ0QU5VeFg3NHBMMjY1bDlMUU9XbW5K?=
 =?utf-8?B?dm1tWWVNRHRFRUFqQkpudVh2ek1ISU9TSVpsdWxwS1ZzWW1OOE4wSkdMWHkv?=
 =?utf-8?B?WTZwT3RNOUtDdUFiVUlzbzFVL1FrT3lrMnV5MVZiYXVsbEhGbXg4UVJsR1E0?=
 =?utf-8?B?N1J4ZnlZL2pRNGFPWTBZcTlHYkxIV3BSSUhUUjJuaENDMGRWZGZnUDFaZW4w?=
 =?utf-8?B?RENWREhEZ3JLeVE2WEtxNXI5aDA4L3NqdlZoSzFmZUJqS2VzZC9zdFZwZDF5?=
 =?utf-8?B?QytnajQvajhzZTVDK0tHZlpRZnFJVCtZODdaV29FQ2duejJIVkowL2o3WWZV?=
 =?utf-8?B?N2pxbEJ0RjZYT00xTEZ2N0IzVEg4NWhacVJzT3lGWjQrNm15R05zSXVVYUVC?=
 =?utf-8?Q?1ZHbO2nsizICv69tZrzBBOCAKnPfCToXu84Es=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:42:36.6609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229c6495-93c4-49da-ffc8-08dcfd6d6aee
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2478
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

Hi Christoph,

Am 04.11.24 um 12:25 schrieb Christoph Stoidner:
> The phyCORE-i.MX 93 is available in various variants (e.g. different ram
> sizes, eMMC HS400 yes/no). Add a new SOM-scoped defconfig that makes use
> of the hardware introspection of the phycore-imx93 board-code, to detect
> the SOM module variant, and to configure the hardware accordingly. The
> resulting SPL and u-boot binary shall able to boot each phyCORE-i.MX93
> module variant on each carrier board.

I think it would be better to simply rename the current 
imx93-phyboard-segin_defconfig to phycore_imx93_defconfig. This is less 
confusing and follows the idea of our other SoMs.

> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>, Wadim Egorov <w.egorov@phytec.de>
> ---
>   arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  14 +-
>   board/phytec/phycore_imx93/MAINTAINERS        |   1 +
>   configs/imx93-phycore_defconfig               | 156 ++++++++++++++++++
>   3 files changed, 169 insertions(+), 2 deletions(-)
>   create mode 100644 configs/imx93-phycore_defconfig
> 
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> index 25c778bb07..e84476c38a 100644
> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -2,15 +2,25 @@
>   /*
>    * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>    * Christoph Stoidner <c.stoidner@phytec.de>
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>    *
>    * Product homepage:
> - * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> - * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> +   https://www.phytec.de/produkte/system-on-modules/phycore-imx-91-93/
>    */
>   
>   #include "imx93-u-boot.dtsi"
>   
>   / {
> +
> +	/*
> +	 * If the u-boot build uses the device tree of a phyCORE-i.MX93 carrier
> +	 * board (i.E. imx93-phyboard-segin.dts), then this u-boot.dtsi
> +	 * deactivates all carrier board-specific peripherals. This means that
> +	 * the resulting SPL and u-boot binary can boot the phyCORE-i.MX 93 module
> +	 * on each carrier board.
> +	 */
This comment does not seem to reflect what 
imx93-phyboard-segin-u-boot.dtsi is actually doing.


> +	model = "PHYTEC phyCORE-i.MX93";
> +
>   	wdt-reboot {
>   		compatible = "wdt-reboot";
>   		wdt = <&wdog3>;
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> index cea817ffdc..d6eb5eb287 100644
> --- a/board/phytec/phycore_imx93/MAINTAINERS
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -9,5 +9,6 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>   F:      board/phytec/phycore_imx93/
>   F:      board/phytec/common/imx93_som_detection.c
>   F:      board/phytec/common/imx93_som_detection.h
> +F:      configs/imx93-phycore_defconfig
>   F:      configs/imx93-phyboard-segin_defconfig
>   F:      include/configs/phycore_imx93.h
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig

Looking at the diff between both imx93 configs I can see that 
CONFIG_PHYTEC_SOM_DETECTION is the only relevant differece you added.

The SoM detection should be applied also for the 
imx93-phyboard-segin_defconfig. The detection is not related to anything 
board related.

Why can't we have a single defconfig?

Regards,
Wadim

> new file mode 100644
> index 0000000000..2c818d01b7
> --- /dev/null
> +++ b/configs/imx93-phycore_defconfig
> @@ -0,0 +1,156 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_IMX9=y
> +CONFIG_TEXT_BASE=0x80200000
> +CONFIG_SYS_MALLOC_LEN=0x2000000
> +CONFIG_SYS_MALLOC_F_LEN=0x20000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SOURCE_FILE="phycore_imx93"
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x700000
> +CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> +CONFIG_SPL_TEXT_BASE=0x2049A000
> +CONFIG_PHYTEC_SOM_DETECTION=y
> +CONFIG_TARGET_PHYCORE_IMX93=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_MONITOR_LEN=524288
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_STACK=0x20519dd0
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x720000
> +CONFIG_CMD_DEKBLOB=y
> +CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
> +CONFIG_SYS_LOAD_ADDR=0x80400000
> +CONFIG_SYS_MEMTEST_START=0x80000000
> +CONFIG_SYS_MEMTEST_END=0x90000000
> +CONFIG_REMAKE_ELF=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if test ${doraucboot} = 1; then run raucinit; fi; if run loadimage; then run mmcboot; else run netboot; fi; fi;"
> +CONFIG_DEFAULT_FDT_FILE="oftree"
> +CONFIG_SYS_CBSIZE=2048
> +CONFIG_SYS_PBSIZE=2074
> +CONFIG_ARCH_MISC_INIT=y
> +CONFIG_BOARD_LATE_INIT=y
> +CONFIG_SPL_MAX_SIZE=0x26000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x2051a000
> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_BOOTROM_SUPPORT=y
> +CONFIG_SPL_LOAD_IMX_CONTAINER=y
> +CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SYS_PROMPT="u-boot=> "
> +CONFIG_CMD_ERASEENV=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CRC32_VERIFY=y
> +CONFIG_CMD_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_BUS=2
> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> +CONFIG_SYS_EEPROM_SIZE=4096
> +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
> +CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +CONFIG_CMD_MEMTEST=y
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_FUSE=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_GETTIME=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_HASH=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_USE_ETHPRIME=y
> +CONFIG_ETHPRIME="eth1"
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_SPL_DM=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_CLK_IMX93=y
> +CONFIG_CLK_IMX93=y
> +CONFIG_CPU=y
> +CONFIG_CPU_IMX=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_IMX_RGPIO2P=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_IMX_LPI2C=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_FSL_USDHC=y
> +CONFIG_PHY_TI_GENERIC=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_IMX=y
> +CONFIG_FEC_MXC=y
> +CONFIG_MII=y
> +CONFIG_MIPI_DPHY_HELPERS=y
> +CONFIG_PHY_IMX93_MIPI_DPHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PINCTRL_IMX93=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_IMX93_BLK_CTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_PCA9450=y
> +CONFIG_SPL_DM_PMIC_PCA9450=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_PCA9450=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_RTC=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_FSL_LPUART=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SPL_SYSRESET=y
> +CONFIG_SYSRESET_WATCHDOG=y
> +CONFIG_DM_THERMAL=y
> +CONFIG_IMX_TMU=y
> +CONFIG_USB=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
> +CONFIG_CI_UDC=y
> +CONFIG_USB_PORT_AUTO=y
> +CONFIG_ULP_WATCHDOG=y
> +CONFIG_LZO=y
> +CONFIG_BZIP2=y

