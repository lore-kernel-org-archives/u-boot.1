Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD360EFD20B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE6B83AA9;
	Wed, 25 Feb 2026 09:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Fxhh1zHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3DD83D8A; Wed, 25 Feb 2026 09:44:32 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E47A82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW+qUtzHBNnUWUdheMITkpxlN3T1QDLNH+zZwYHn3yjmFwqvyv/D69houPVI8vc0ggTIVqDIckhIhFLTTZNXGGy5phozATMX8+qz1RGOi60kCUMHumXY+WMPLyZ/twtPwRLa+eCYkSZHHQRECAj/VJNXhbRM3HkENx/twCyXEusJIvE6YutPM5Rum7FtQl3VVW6nYC3blaeBTo1t1qGmC3HZdpDri6FT9rmw1ebqhEmuR5vFNASGT8DSGW1/me9aHQahtDjG4r9gqc1dCCrGCX0qtk5qkhiqhTY2uZHs2xBuV4cj72WK3loXkNmz8n+1Yq21nfqjP49+OZ1DJbHA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYAaDWdZqwOWTfZCRAJ+UPojr2NsHR2IsrzbdtWbKTg=;
 b=oQOdVKaodB42euYtJUF+d1YApitnxNXXYwgdNcCdJUlFDniGgOW/a5OjQcKyNiNH9zg0h9cHufAHFnB1S2Fxq4wTmyaszwDZr7MESBSf525hPoTAzuT5o+uXEIYnm4fY475PvDGjdhm2tX/C9Mbfyvp7KdCCMQAM/dNa+gcZPQmBmGWWaCYN+tEZPTBvjMNbSKCCiWPqC+qXJy50xPmslxqzPCEP8ryEyLcUuFa+fWpyJKUBmFFTGXvWDduPg10fCqasQYmN0PFOQ3DtOXI12vXQ2BE7/wvk12YKNAj0wMg0V+9FEdcHEyo7U9w82fxUI+IM/SYArmPF1joavM9WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=canonical.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYAaDWdZqwOWTfZCRAJ+UPojr2NsHR2IsrzbdtWbKTg=;
 b=Fxhh1zHC2fM8gF9kp9KZrvA/PK8SxR2tuxycKbTQJY1XF4pIZNjutsy+wBDA/6AMpBzFiXkmvgjJ4751VDyKy3RParVukCmtk8T4ucNFNvx2dNdkPh0y6oFPc1QVnXJFPyhSvkphuSjuLpVeG2zX763cpC3jvXL+QOFjQrynifvUwuy8iHTUwXUhMiIFbiJXLSAUuSHOnPSoROdPxja7X2optxldQIW3Dah9WGJ3kOB1LiagI1+diW2YHzUxWfnWtBgFHhlDnkrhzK6D5zbHXX5CWCKsP9Up7EnvL3fKaaen/n7Bzr6fm6ZZXhKY/6fGKLKoVo0Fk+IZwp8Li9wo2Q==
Received: from AS8PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:20b:31e::8)
 by AS8PR10MB6819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:44:26 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:20b:31e:cafe::8c) by AS8PR04CA0093.outlook.office365.com
 (2603:10a6:20b:31e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 08:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 08:44:25 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 09:46:32 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 09:44:24 +0100
Message-ID: <d6801cfe-4dca-42bf-83b3-083e996b25f6@foss.st.com>
Date: Wed, 25 Feb 2026 09:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm/mach-stm32: don't select non-existent STM32_RESET
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
References: <20260225070224.49099-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260225070224.49099-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008D:EE_|AS8PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 235ddac8-4755-439e-ba16-08de744a14d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE15Z3d6aFRieHhZNGdlbFNmY1hzYWJFSk1ZKzg1V1c0OUJudlc0NkZIamdW?=
 =?utf-8?B?eXhMRVdmOGJaT040MXRUQzhtdEQzK0JzYjV6emN6YWp6OURDL0FUTlhJRkRV?=
 =?utf-8?B?Q29QSnh0UWlIeGNITE40UDZVN2RTbEcvczVMNHhCdDNaVUVJNzZBVjZKVkdj?=
 =?utf-8?B?dzA1UkxXYXdCRjUwZFRMeFRyVVlEbkxhTm9hdHMvN3FVRTgwNm1oWkNmekti?=
 =?utf-8?B?SVNNd00rNzVZTzBJdXhHWk9BZjliOFVoNmJETno4dldpR1NJL2pJOXBFTS9m?=
 =?utf-8?B?ajQyVDV5OWcwNHBYaU80eSthMndpeGJYcmVVV1hYbHJVWXFPVklKOGFTVENF?=
 =?utf-8?B?TEY2ZlJmenE3Z01oSTBQWXlMK1l5aWJvWjJLeUxJMGRldlRwOEw1cTBvREtr?=
 =?utf-8?B?bGM2cUhGckF3OGoxNWFxOXREVjdVTWQwTVZpamx2NXlDSFY5SThibXdyN3BV?=
 =?utf-8?B?N1lDYUdMelYrY3pYcERsMWcrRGZyZllObnZhcGZBVWl2bFdEWDljZ3pmd0Uz?=
 =?utf-8?B?OXY3VlU5UlJWUXNwaGhJdFhtZWYvSzJEckkxZFlONmQxbGZrYmNyOEZCc3Vm?=
 =?utf-8?B?WDl0ZHFWUFFIMGRSSEFqUmlPSFVUWlZZTFdRRUMzS2lSSDlGV2JRTGpQUzJ4?=
 =?utf-8?B?SVFVa29SbVVpcHBBeHZqWVIzdXBCdFNWSDI1eDhaR1FzbXN4OVlHcjBBaHdR?=
 =?utf-8?B?Mmo1V3ZLcVN1QXVOSStpd0FyYlk4c3RObERmM1hEMmp1QkRYWXJjRzZtcW90?=
 =?utf-8?B?L0NWZXAyYlFPMWs3RzBLclcrTVRKRnVGMmRMUlhNMUdHTldncll2bEhtMUxY?=
 =?utf-8?B?T2g4ZDUza0k1c0xDc1F2Tm45ZFNNSmVkWk1tRGxlM1R6N0E5ZjBNcldmR3Y2?=
 =?utf-8?B?Vk5lNjBVbS96cUdlcW42NVh1MVJlNnNBN1NBZExrTDFiNXdaTWNoN2VOSG94?=
 =?utf-8?B?TGJRa2VCcW1YaU5FcmZKUWd5RWpjYzQyZ3JTNHBRNThYL25HeUNTZU5NRU9Z?=
 =?utf-8?B?SjQ4U2lHNTdQWERaWFpFM1oyTXErQkJOZ3V2N0FBSVBrS0RqNVVFdDZyaklz?=
 =?utf-8?B?MTIrZWdySWhuSzRWNU5mWlF6U0VzQVNGd1g0cFRTd3IveXAzUTJYcm1OT05s?=
 =?utf-8?B?dHoreDJaY29HWG5ZWWtlS2ZaMWlNNjZTaGJJZ0k5eUFhamIxWjNxSEdzaHNa?=
 =?utf-8?B?eVdUbjcyaGlYd2ZoWi9LamF3T21NUXB0WmFsVWdJMzNiMCtBZFgzMjJDc25o?=
 =?utf-8?B?dGlSWW44VGlBcFlWMjB2S3o4QUtIeTd2ZFJSMlNNZG1qVlZWbE4yR2tnWEY0?=
 =?utf-8?B?ZXk2SitOa0hVWkMxQ3JqYVBaWm90bXpqS2FZS2wybFBIZ2hsQ1EvYXpBbVYx?=
 =?utf-8?B?TTZJTHczV29oaW0zanV4KzUxbWNmUkFhalNNazVEOEdidVRjcC8xTCtEOUtY?=
 =?utf-8?B?Z01MaVRkeWt4WnVNOUg1RWczNE1pNURFelpna29XaURhRG1rR3FPdG1iMzd2?=
 =?utf-8?B?WUxBd0ErTWpSSlh2M3pmQm50d25nOE03OTlBN3F3bTdvSzZ5c3BLL3BiTFpU?=
 =?utf-8?B?ZXJrMDduL25jSE1VeGd2YklENXNqSml2bWZxalRJNXFQKy9MeUNuVmR6Vnk5?=
 =?utf-8?B?V0g3QkZHaUNnTXhiMEJscktpL2lSaXRyUXdoMlQ2K1BkUVZDTk9JNWhzb2o1?=
 =?utf-8?B?YU55NElGWk8veDRIeWdCckdJUzZpOExCbVF5bWQ0bzZjRHhqZi9kNzI0a2RF?=
 =?utf-8?B?SWhLVlNCYTNhaVptZnI2cDZMc1lqMklpaERIQ2pnRm5VUTZyajZTTVJBT1BG?=
 =?utf-8?B?UWovYkg1UVVKaU5CaW1PblFLeVBCVUpVSGc0WWtWM3JtVUFIeXFRamFqSzZy?=
 =?utf-8?B?V2tjTUZVVW43bVVlc1BUbGhNdjZIcEFEYmlvTEM3M01palN4U2ZXQTQ4QTha?=
 =?utf-8?B?M2I1c1BBNHluWWtvS1V0cnltTUZwVjdkZ0syTWZSQVQzallvQXBBamFzWjZv?=
 =?utf-8?B?RnY4MGhQb1pEZnVCZkZmL1k3NEhTa2duZnpzWWpJNXBjM3lrRWJYOHdveS9H?=
 =?utf-8?B?UWJRZ0FPdGsxOEZ4MVRtZ0h4NmthV2xuSndzQXphajFGdGpDTEpQZ1VoS1lU?=
 =?utf-8?B?QlUrRmNhdDZoNkhuUE9LQlphVFAzdjQrb1piVEo2NWhyWGpETThta0NVWlJV?=
 =?utf-8?B?VHdzQWVzRFVzcEhWaUo4ODA4bUpwdXZGang3NGpDaFpwdzRMNXZJWEtKeU1Z?=
 =?utf-8?B?Nmp0aEhpNGFtcDFlODhpYjV4Tjd3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBeqGEZijOtdgACgFzxUCNIpbmqKbfOZcM+6ooybk/VsYvcE7J+8ph0IFKODbXGm98p2k7PxNKXQmOGW/VqRXu7fjcvMaNEk+9u7eRRnT3lP+Q2/VC5YzWnr2Vc49GeJzDGxswckNxJV5P9kHQTYieDu5mO1v538ArkIIrh7w8t9rEDeg/CiOEMwrCEjQOn3CAXks7VllimPC9g7MOvEuHr9VfCiWIIkVhOAqrd4derTz0W19POkAAVbLR/WsFXaKBklhvzAvyZU4d9QmsOYml0qXM3Kj2mRbpb4D95R9Ywad/ON0hw3AQTlJGdGmf66q7eEczdNcVFG6xRCp0q901LeZf/uaD4M9NKjZ/K3yv7ddaIE3nkF+MXe0/ciJ3KXc1MH4dR72TB747etocMHdoVhShUJOoH2z5jxltmO4xE2G2GZZXIrEyBZP03jNUZ5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:44:25.7919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235ddac8-4755-439e-ba16-08de744a14d0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6819
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



On 2/25/26 08:02, Heinrich Schuchardt wrote:
> Symbol CONFIG_STM32_RESET does not exist.
> Don't select it.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/mach-stm32/Kconfig   | 3 ---
>  arch/arm/mach-stm32mp/Kconfig | 4 ----
>  2 files changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> index de9d8547e61..1c6de559142 100644
> --- a/arch/arm/mach-stm32/Kconfig
> +++ b/arch/arm/mach-stm32/Kconfig
> @@ -10,7 +10,6 @@ config STM32F4
>  	select PINCTRL_STM32
>  	select RAM
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SDRAM
>  	select STM32_SERIAL
>  	select STM32_TIMER
> @@ -27,7 +26,6 @@ config STM32F7
>  	select PINCTRL_STM32
>  	select RAM
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SDRAM
>  	select STM32_SERIAL
>  	select STM32_TIMER
> @@ -47,7 +45,6 @@ config STM32H7
>  	select RAM
>  	select REGMAP
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SDRAM
>  	select STM32_SERIAL
>  	select STM32_TIMER
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 2716844b259..8ade36e4fbb 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -50,7 +50,6 @@ config STM32MP13X
>  	select OF_BOARD_SETUP
>  	select PINCTRL_STM32
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SERIAL
>  	select SUPPORT_SPL if !TFABOOT
>  	select SYS_ARCH_TIMER
> @@ -72,7 +71,6 @@ config STM32MP15X
>  	select OF_BOARD_SETUP
>  	select PINCTRL_STM32
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SERIAL
>  	select SUPPORT_SPL
>  	select SYS_ARCH_TIMER
> @@ -91,7 +89,6 @@ config STM32MP23X
>  	select OF_BOARD
>  	select PINCTRL_STM32
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SERIAL
>  	select STM32MP_TAMP_NVMEM
>  	select SYS_ARCH_TIMER
> @@ -117,7 +114,6 @@ config STM32MP25X
>  	select OF_BOARD
>  	select PINCTRL_STM32
>  	select STM32_RCC
> -	select STM32_RESET
>  	select STM32_SERIAL
>  	select SYS_ARCH_TIMER
>  	select TFABOOT

Hi Heinrich

I noticed that i will need to send an additional patch similar to yours when my last pull request will be 
merged by Tom as i was still using STM32_RESET when adding STM32MP21 support:

https://patchwork.ozlabs.org/project/uboot/patch/20260203-upstream_add_stm32mp21_support-v1-5-48ca3409cce1@foss.st.com/

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
