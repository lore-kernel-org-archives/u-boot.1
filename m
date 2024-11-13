Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28649D637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5768935C;
	Wed, 13 Nov 2024 20:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="zRcVnE1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2E989417; Wed, 13 Nov 2024 20:17:39 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE6C891E8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrQZn+V1WnSSyAjl7DZxk859dBLDaBVmvCZV+Qb7WjOyAwuOlFX1ax+Dzo/BTsYgTPjuxyQKL8xDZeJkF8NENo8M0XcyzblZXzWa2KJW24z8PlBc4Qdjj5RcCgjJy/OzaoeqjxJtpBKs/dGNRSOfIlg72GS0nRdqCCXr1z3cypDdjOtYxvU8RUjJVLhcXD8ZOz7PhOyU8Iue9ofOVkwWBKao1EExn5yE2Ooks5JrtuoTyEI+Xh1fkhiDzKlibPLWA2shn9OasvK428vWjDN3iFdOP/3mgXr3HAnNTZYyGbsAwtkf0jXhqK+i980TFPC026BDuF6mBbdasiWnZbI61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwGriB7080Dy5uAK1rAgsTUi5IaDlvmKoreY3WcoXdg=;
 b=sF+MHUUevaCcn14Fiy/qjc4XhF9SQmJsJNBeYJu/1/9+WbiVjdWQWuwsCDDgsrW+j1NMSpuICiuqlSGYqkVs8okiMNOttPlUP3Snx2myiR5p+xWZbJE67upLAAsHq1IqaYuAh1afaMBier+duoCcJXONBh+URE2DCqf+GJNsL8F3kegqkTHC010qkqcxVMGzOyln3ZaJSXU6ExIIQk5ByjmekIgwXiI/Prov3ePcaVr4/DL2SvqCgIB1B+saOs36VHyDgEUJUjCmN1m5s+mKoscPut9WmWwFk8WbS8mdG+SHMzXxyTc+YAklipSWH43PbLvb1I26EYAumJT0cnAa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwGriB7080Dy5uAK1rAgsTUi5IaDlvmKoreY3WcoXdg=;
 b=zRcVnE1UF5vzHnWIWvVYxT6BzJgMuEHD5AtYRD34OTE3I5nmhZwoMn5tXNR/9wf+VXDahhd1gQ62hZUd+fKmYENmUEMLdHbJYfVYwKPcSriBj7r5qjUTidCJ3yV1VWKOkx0HkBJBGsutcRD8ZipasvckwhJLRaiPlRjDlNUME1U=
Received: from DB9PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:10:1db::30)
 by DU0P195MB1842.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 19:17:31 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::8f) by DB9PR06CA0025.outlook.office365.com
 (2603:10a6:10:1db::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 19:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 19:17:30 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:17:30 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:17:29 +0100
Message-ID: <fa439d19-1553-472a-9d14-2be5dcbb9dde@phytec.de>
Date: Wed, 13 Nov 2024 20:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
To: Christoph Stoidner <c.stoidner@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241113160037.65679-4-c.stoidner@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|DU0P195MB1842:EE_
X-MS-Office365-Filtering-Correlation-Id: 696d4a06-45ea-40db-74cc-08dd0417d1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnlJRjByRmZoazRnMjdyODV0UVRGVU9OZW9iMUpDdTlPckh4cnk0dFVYSFZo?=
 =?utf-8?B?TWtidnZrMFJxempzR3VGMmlzdGVlcGdJQkwycnBJc3hlTWRoZWpoTksrNkpz?=
 =?utf-8?B?dDBKSnVLZlBUUnp2aDlER1Bta3dvTmFUVExLLzF3Nzdlb0JPcHJRcEo3NjNF?=
 =?utf-8?B?bUZUTXRKRmltdURGM1hwOEoraXd1QTdPOHJDT0Z0Ui83TjBFM3FBZGFIUUEw?=
 =?utf-8?B?bVE2ZFB5cEd6bEFsUHN3UGpLbTdjYzlIWndNYTNEeHR1SVNOVUEraWRTcEZk?=
 =?utf-8?B?SThCOUpXN3NjZU9ZRzFnV09jRUxqdC9GRlM5NCtJY1prQnc3N0xrVmZseUtI?=
 =?utf-8?B?Tll6ZkxDZUxBdnRFa2hsK1VlV3FYL3NCVnFERkhWUkJRV1p4c2RBay9WZVoy?=
 =?utf-8?B?ZGh2Y1FYT0NUYXZSQkNzcVAwOEJFZWlLbUpEdUFRdkhDM3dsZU1hcDJ4OHdo?=
 =?utf-8?B?Tms1L0QyMlUzVHN3N0VoKzVxaDMzOXpPdzBrY2VzVkI0NFpjeGpYeTVXcFZ2?=
 =?utf-8?B?TENsSVNISGdYUGxIUHBtVEFuOFFaQ2NicFVwMlpLaFBZd014eTk0RTNVa3Ix?=
 =?utf-8?B?L1hnS3YvWjUrckQrVHFkV2k3bWJ5N1lQWWVZejFrRkNOTjZjQ0szSkgyL2lj?=
 =?utf-8?B?OXNLOGptbEJyZ2dZaWY2TkM5emhuMU9Ec1dVMlU3MkkrY082ekh2OTJvVWNJ?=
 =?utf-8?B?aUxndCs0dXMxaHVwQ3VMTmpRNjgzaWRrRUprdmM4ckYwNUFiVjM4dG9RTTEz?=
 =?utf-8?B?RmZORi94dDVlczBncWZteVhsV2ZwTlVQak9BbTF1ME9Ea3pLQUpwQnJIMmVh?=
 =?utf-8?B?TjNROFVxeXovQ24rcmx2TVJ6bFpiZ3EwWjJGbFJSZGV5eUpOL1F3TU8yYmkr?=
 =?utf-8?B?bGZ0SnVSK21tQUQwaTFZUFBQYWNaTzhCTFdkVndVOW5KNVU3aXZMTGhobHh2?=
 =?utf-8?B?U1BQUFlKKytaMDd1aE9ydWlXTDNmZE5aTHV3VDEvbUVJTVkreDQ0ZGFINVh6?=
 =?utf-8?B?cDkxaXQ3N1VYY0xhRG5nVVBNcUtGWnFvRnVjQmRJd2tmeCt1T0JhQWtzZUlv?=
 =?utf-8?B?dDBrKytzYzBjSUhuVGE2WUxFNVd2cWV1dmpwU3JCWTEvdTQrYVJQS2pBRUl5?=
 =?utf-8?B?SnpmZnVVUkxna0xsRDFRdUhiZ1VCMkNpTlhiSit1cHU1c3pIcG1ST0tCYVNJ?=
 =?utf-8?B?VnhvcmFrS3d3RzZ5REx1ZkcxUmJncGhFN3BHdXRBSmlMTlFXejczMHNuaC9j?=
 =?utf-8?B?ZGx5bXg2dHUvUkhkN3NzYmlGRHVXNW1uS1VRTGgxUlpPYjhTTmpUV09jS1Jo?=
 =?utf-8?B?a0MzSVo3V2ZtVWtOZUJxV09DWndYNGxHWmhEYnJhdUJXSFc4endGUU4wbzNs?=
 =?utf-8?B?SEFIUHNzKzNiWGl6dFQ0QjY5RHBaR20ydFhTWUxNL2VsSE1PdHlyMzVicnZN?=
 =?utf-8?B?a3RGMHlHSGJrZ1JaZ3NEWjIzYnFkSlcrbUNJV0VtMTFHSkk5RUJtd3FPM2pH?=
 =?utf-8?B?ZVhXcm51Wk9XazU1MUpLZTRzcWlrMWNVNGEwK2NkdnowaFBJTEJ3b094LzZI?=
 =?utf-8?B?VTEybnNaQUtTS051WVpvSVJ5QUJabVRISzNUcW0yOUJ4WEUzQ084U3JVY20x?=
 =?utf-8?B?RkNvRUR6dTNRajB0OG9HRURPVjVnRzZ2S2dHRHpneGdKeG13alFBRlNmUUdK?=
 =?utf-8?B?dm01UE56Vis4VSsvWkhiL0F0Qmc2aCt6ZEg4aENINk5pSzd2ZUhWMkQ2dVEv?=
 =?utf-8?B?Wm1ISkh6UFdKbDF2eG9pbFpvNXJKVjdVM0tiR0xid3JVODcyRnB5OEJsK0lI?=
 =?utf-8?Q?QC23S5iifAvbfP/7DwlE3EceyI0xgrjgX/Ow4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 19:17:30.9398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696d4a06-45ea-40db-74cc-08dd0417d1f9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1842
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



Am 13.11.24 um 17:00 schrieb Christoph Stoidner:
> The phyCORE-i.MX 93 is available in various variants (e.g. different ram
> sizes, eMMC HS400 yes/no). Enable hardware introspection for the
> imx93-phyboard-segin_defconfig, so that during startup the SOM module
> variant can be detected, and the hardware can be configured accordingly.
> The resulting SPL and u-boot binary shall able to boot each
> phyCORE-i.MX 93 module variant on each carrier board. Finally rename
> imx93-phyboard-segin_defconfig to imx93-phycore_defconfig, to highlight
> its SOM scope.
> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: Primoz Fiser <primoz.fiser@norik.com>
> Cc: Andrej Picej <andrej.picej@norik.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> ---
> Changes in v2:
> - just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
>    instead of creating an entirely new second defconfig
> - remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
> - improve commit message
> 
>   arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi               | 6 ++++--
>   board/phytec/phycore_imx93/MAINTAINERS                      | 2 +-
>   ...x93-phyboard-segin_defconfig => imx93-phycore_defconfig} | 4 +++-
>   3 files changed, 8 insertions(+), 4 deletions(-)
>   rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
> 
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> index 25c778bb07..2245461032 100644
> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -2,15 +2,17 @@
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
> +	model = "PHYTEC phyCORE-i.MX93";
> +
>   	wdt-reboot {
>   		compatible = "wdt-reboot";
>   		wdt = <&wdog3>;
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> index cea817ffdc..718f89a084 100644
> --- a/board/phytec/phycore_imx93/MAINTAINERS
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -9,5 +9,5 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>   F:      board/phytec/phycore_imx93/
>   F:      board/phytec/common/imx93_som_detection.c
>   F:      board/phytec/common/imx93_som_detection.h
> -F:      configs/imx93-phyboard-segin_defconfig
> +F:      configs/imx93-phycore_defconfig
>   F:      include/configs/phycore_imx93.h
> diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phycore_defconfig
> similarity index 98%
> rename from configs/imx93-phyboard-segin_defconfig
> rename to configs/imx93-phycore_defconfig
> index 18a4087e4b..cf9800118a 100644
> --- a/configs/imx93-phyboard-segin_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -6,13 +6,13 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> +CONFIG_PHYTEC_SOM_DETECTION=y
>   CONFIG_ENV_SOURCE_FILE="phycore_imx93"
>   CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x700000
>   CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> -CONFIG_SPL_TEXT_BASE=0x2049A000
>   CONFIG_AHAB_BOOT=y
>   CONFIG_TARGET_PHYCORE_IMX93=y
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -20,6 +20,7 @@ CONFIG_SYS_MONITOR_LEN=524288
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_SPL_STACK=0x20519dd0
> +CONFIG_SPL_TEXT_BASE=0x2049A000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x2051a000
>   CONFIG_SPL_BSS_MAX_SIZE=0x2000
> @@ -31,6 +32,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>   CONFIG_SYS_MEMTEST_START=0x80000000
>   CONFIG_SYS_MEMTEST_END=0x90000000
>   CONFIG_REMAKE_ELF=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_OF_SYSTEM_SETUP=y
>   CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"

