Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EFBD637AF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C282A88F70;
	Wed, 13 Nov 2024 20:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ytZm4mRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D27088FB9; Wed, 13 Nov 2024 20:47:42 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F00C88EFB
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heP1AFQTlmEtQd5OAZvMbkhQujPbj2Iv5kEyNC8HNQze0ucBGUyyn/YZXGMN8KC929+wc7vbOyNoBfI+KMgflNe7pabquVVTRNo4kCBXIE1pfM1y9aA0vdB7rfRelWLdLuKBN8Cy5iWYXdGQaCAfhDV9/yjlYTCkCfMsXA3Ey5bGROGPGMczRKd/qbzn1azaCuvtHTdpD+m5a7fherFuSh9olJFSAjc13aB42KltNcRQtek0p8S9IYhH4EHoZj5BThyHqRH07uC0pxwkJ8etrTYzSFmKwaBlpPmqTMI6shpB0wavzusgBi/A3+cClWc3RujYN/SZr+6GORstCiltRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0S7NmJZwMxAqt66fyNtfGxSPM9DYgjG5PK7TGqt2vQ=;
 b=ajFISF0cUeHC0q6zsAPf4q9f70d8hbkMS9ZzGou/uvdqK2utWE/bL77t4DIh7XMjc4SXeAC4AwyTosDnJJ1z8M3ri5Ff+SrtUYiuBJaUK148xFGJEg8yI4lCRlFz4zPxowettXpz1COyzAKrWqV/KFOjLRplpUEtMRK0zMo+2e7pKhjQixkOdrc6Y0WZWsQVigfnVM7Ez3+Svy9uMuquE3wb+RtyB4gjOgWaVQhPQTiNmLKtpWFkLd3eVrITVRNHoUOWbdP+/s50UrzD5Xw8YstTOse4uIZ9eoqIQxJH3LK2CBbi/avTQCrNKlO9crWBhOB+2cs/jbRrGNeGvb4UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0S7NmJZwMxAqt66fyNtfGxSPM9DYgjG5PK7TGqt2vQ=;
 b=ytZm4mRp5BFHmwXBci8dbPtbs5PSD/DgzwhF+JAE8HQ44mNiCQ/ic0iaiHOxeur7TM3w0hvbwVsd3yKvts/z/NTZtgG/dmono0Np3qu3v2qHTrAu+f/CWM/ilzcKNofe2IdMhQblHLlhDRUqrwfo8YPm7sT6wu6684cEGKv7S0M=
Received: from DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) by AM0P195MB0515.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:16a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 19:47:37 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::47) by DUZPR01CA0207.outlook.office365.com
 (2603:10a6:10:4b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Wed, 13 Nov 2024 19:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 19:47:37 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:47:36 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:47:36 +0100
Message-ID: <d4ad41bc-114d-457e-8c5b-58774fad91b6@phytec.de>
Date: Wed, 13 Nov 2024 20:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 0/3] Add support for all variants of the
 phyCORE-i.MX93 SOM
To: Christoph Stoidner <c.stoidner@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241113160037.65679-1-c.stoidner@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|AM0P195MB0515:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e55915-0874-44dc-0fc3-08dd041c06b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVluNVI1emd2QVBSczF2TFJrT0trNnh5YUs0SUNtcVdIWUt0NUorTUo4dkRH?=
 =?utf-8?B?clVPTDA2Z1pDVjdNejdaNjRqajR0eTByWDI5NjMvL0M0UFExcjhhaU51dldC?=
 =?utf-8?B?VURyT2RZanIzdjZDQklVNHVwZ0lDR1VIcUcrUHR0Qjd0ckNhTGhhMk1YS1pV?=
 =?utf-8?B?Q2lvNzdtbDZJOXBhbjdUdnZOSXRua3hrdWZzNkozYy91ODMvcWFiTzNoYk1o?=
 =?utf-8?B?QjUySGlmQlF4bEJuODRoMEdiV0VQNFByd2l1WE1ONGo3alFkS3NNaUppNzBV?=
 =?utf-8?B?Qkl6MGtjZGJEK0pkd3ZUM2FWSEJ0REFMYXh2M25MbEtlOGkrTlBMWlA2QjFm?=
 =?utf-8?B?Y3ExemFLMXZpblBNb3M2WHJLOXR5dEUrcG03Z1BnNG1RN2h3dVRPY2dsUTZX?=
 =?utf-8?B?ejM5UTh2MksrTmlaSkV5S01SUFVtL01QaWZ4UlV0S2RXOXhvL1NHKzRkTzc0?=
 =?utf-8?B?MXVOYUc4U3FSdnlxMFJXTkVPT0FucWRpdWlLS2N3YlA5em9mRXl2ZDMvcENs?=
 =?utf-8?B?c09PNXNJUHRyWlN0eDloY2hsV0t3ejlBLy9xcUhUaUcrSm5HNm9lbnU0Vzcv?=
 =?utf-8?B?a3RpM1pzT1BmREVKSDNDb1lQYWREeHN3LzdCVUdVZ2huUWFsOCtxdzZSRis5?=
 =?utf-8?B?SkFmQURzZmdHcmNhOWVEVmFJKzg4NHJraklNOWVGSFVsVHBOa1ovSUVGMWJn?=
 =?utf-8?B?Y1VjaTZ5ak80WERUenJJQm1FT1AxMlJHVWNOamdFb2NtRW9lWGF2VEpwdTk2?=
 =?utf-8?B?QlRNV2cxZ1I3QUhaV0VmNy9xcUZ4N21PU3owQm9YM1c2SU1uV0laaGEwZXhj?=
 =?utf-8?B?U1dOQk1oNCtvMVhxZS9kM3FzeTVvQ2hwZXcwL3lxZUFPS0MvZ0dHN0NjRDEw?=
 =?utf-8?B?Zk9ueldOYWQ4MUcvNkkybUJmTDFOSnR4WHY5TjlHNnZFd0dENUZuT1Jpc0k5?=
 =?utf-8?B?QmRmVEQrY1lrSWV5OFpnVUNqcTk0VlhtT3hFUk41MGZhMGphT2lOUCtMUzBk?=
 =?utf-8?B?eFNBRmY2THg4UDRzdi8yVjdpSHJFT0hHMjVKRXdjVFRQd2gwQlhBeXpleXln?=
 =?utf-8?B?Rys5UWVtNkdnZVNnYlJjcWpHS3BoRzRRS0R5alFWQmd1TnZNdzI1akpLbitq?=
 =?utf-8?B?M2xUYXBvOThZK3FsNE05NWZYeWpDdkNtUnZMS1p5TWE4UUJFV0lCRDJmdUxW?=
 =?utf-8?B?aElaMkNldUc1dHZhc0RUa2ozdVA2SnduN28zR3Z5UTdFbjFRSFZCNlpveU1F?=
 =?utf-8?B?aENtemJJajZrR3YzUGpjWGFaRUZzYXVaOHNkWFZYZ2tZNEt2UlFrdUFXUGFQ?=
 =?utf-8?B?RjJFTzFHZnVMZWlXenMvVzY3Y2Nqb0l4Z2xlY1BKYzJqT0g2cGhWNjZPR0Vn?=
 =?utf-8?B?R1NVVVdoeWFKNmVNcHdBVHNmOWdWOStYd2ZvYjJDalJNcW14LzMvVis4N295?=
 =?utf-8?B?eW5hdU0wTmpURm96clVHUmJHbGJRNUV0Y2V0K2pFS0p1bWxZZDEyQjJYdDhm?=
 =?utf-8?B?aFlXaEsvbGdyeDZtcko3UmkrYnIvTWMvZW1BZ2VwN1RibWJlQXgxaWkvMjkv?=
 =?utf-8?B?b3IzdWxUVmlwUjhreWpVV0lGYVJtQ2NhQmdWSTdIVVhyMmRNUkdJbHBKZ1Nu?=
 =?utf-8?B?UzZ2Q016enhzQ2w5TmlWcHN2NE9TblBaZVkveTkySFdQV0Y5ZlZxOFIyUExv?=
 =?utf-8?B?akNac29aNFdRbGJhcW1KNmlFSmErSERqaXRNRW9TZ1dqMlllOVJuUG50WlVr?=
 =?utf-8?B?WkxrSEt6Q0RpSDFiZ3NPWFlRTFEvVjl1bDdpRXNjQlZ2aFVlaW1HQlFvOTR0?=
 =?utf-8?B?a282UnNWM3J4aVdjNGFpZXc2OTFPUk5zZkFKeEYzQW1DQTN6U0RRcUE5REUx?=
 =?utf-8?B?V2VLMnFrVzRqWkQ0UW44UmJodmVLVE1CUFQvVE52aXg0ckE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 19:47:37.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e55915-0874-44dc-0fc3-08dd041c06b8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0515
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
> sizes, eMMC HS400 yes/no). It's eeprom contains information which features
> the existing module supports.
> 
> Extend the existing board-code to support all the SOM variants. The spl/u-boot
> evaluates the eeprom information and enables supported features accordingly.
> The resulting spl and u-boot binary is able to boot each phyCORE-i.MX 93 SOM
> variant on each carrier board.
> 
> Changes in v2:
> 
> patch #1:
> - remove multiple blank lines
> - add update of 1GB ram timings to commit message
> 
> patch #2:
> - encapsulate handling of feature flag VOLTAGE into own function
> - move definition of enum phytec_imx93_ddr_eeprom_code into header file
> 
> patch #3:
> - just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
>    instead of creating an entirely new second defconfig

Don't forget to update the docs "Build U-Boot" chapter mentioning the 
new defconfig.


> - remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
> - improve commit message
> 
> Christoph Stoidner (3):
>    board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM timings
>    board: phytec: imx93: Add eeprom-based hardware introspection
>    board: phytec: imx93: Add phyCORE-i.MX 93 support for all SOM variants
> 
>   arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  25 +-
>   arch/arm/mach-imx/imx9/Kconfig                |   2 +
>   arch/arm/mach-imx/imx9/soc.c                  |   2 +-
>   board/phytec/common/Kconfig                   |   8 +
>   board/phytec/common/Makefile                  |   1 +
>   board/phytec/common/imx93_som_detection.c     | 111 +++
>   board/phytec/common/imx93_som_detection.h     |  51 ++
>   board/phytec/phycore_imx93/Kconfig            |  28 +
>   board/phytec/phycore_imx93/MAINTAINERS        |   7 +-
>   board/phytec/phycore_imx93/lpddr4_timing.c    | 793 ++++++++++++++++--
>   board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++
>   board/phytec/phycore_imx93/spl.c              |  48 ++
>   ...egin_defconfig => imx93-phycore_defconfig} |   4 +-
>   13 files changed, 1064 insertions(+), 67 deletions(-)
>   create mode 100644 board/phytec/common/imx93_som_detection.c
>   create mode 100644 board/phytec/common/imx93_som_detection.h
>   rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
> 

