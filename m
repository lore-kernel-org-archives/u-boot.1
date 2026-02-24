Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5A2E9B262
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9298182BF2;
	Tue, 24 Feb 2026 14:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FitpAO1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1B083981; Tue, 24 Feb 2026 14:30:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D277F82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPl2EJtiHnMwyWLy/Hu8RcYuz/dw390x/wYTW6qG9/WHRFGD9V5M9wW1TP+eC9LpCm7XN2JoLuiOLL10Ooq+jsFB71teenin6f4FTkaOfKd6qfw7kYYq2LzHtjOLFBfDdquAz9hLKMx4RmRm6rNhfAgkKV30UmIHQne6cGpfMlins8RS8YmdT3dunj7/FBaklePQ1ScHk3HRQlwssbKyv3N26kCeNvdTxHubcVlRc1dsWPf8h78OxwvujZhDiYO8rE5N2v3A2mCy7C9viA4E9t5ab/sOKxGXcUrMC8NImZi3bKskxtgpQcrXNx5hrAfoybc9E8VFDsa+AfK45F7q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rPrrXjDg61JRzzTgwcZqUf2YLsJmWbeW8wlzQcalUc=;
 b=vHQuLMjIkgZSqhuiJXsL8+UjHGhz+4VvvcE5JQmRzg1UV+zauJw1A+wDq/A2IHCHNL1/yv54aPwGtXXHHAMWdlCHpIgfVHp1i+oKix+qlxtpNNbzusAZh/3G2afDueIB21klrGdR6xjQOyIe0Bn971rwG03mGqUvgzS2lTy5RgWq1U7hd9WDF0BQujLiSdg1YLA1lZgGEPVQXKYTGrLctd7XjRFRLYb7gtg1g9XAYatZmuUD+rCYNhBNf2pBq482HStpGKlDipUuxcOwMN/676PDYbHtiVy7Up4f6BXCRWf+uB+/V6btsZlhmtMwdCwGstEtaqvIghLTPhkf3qyGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rPrrXjDg61JRzzTgwcZqUf2YLsJmWbeW8wlzQcalUc=;
 b=FitpAO1y62NHzCILWtGKyEPS9STmMb87Q8FpejjW/QDbhGfZXo5Pjp/UElUOVFAKgP/GevC4uwSI5Alt6O7T+5BHIRcmfX+OikxAXzC9v4M8wLTzAn9W9IvGwtXiBftsWpIV0ldcSX38Msl28JfJYup6zpfE7HJCViZl302nClR6uz4DGU8HA846/aOrIGL1FSPdIkFopKW/2Kc+XeAIjs4MtgtPZtpxafQ2rKomZqcXQgQ/4ndrpvGrVlbD8p3tez7TiGZlg+YbuInzSIr5RC23D19O718hWg5OaKY0MAMld4iUX6iPbzUObZfdgo4ZkJBpkN+qw+pWlKxKBMzc2Q==
Received: from DU7P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::34)
 by VI0PR10MB8498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:30:36 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::ab) by DU7P250CA0030.outlook.office365.com
 (2603:10a6:10:54f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:30:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:32:51 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:30:34 +0100
Message-ID: <3c678260-1859-42cc-8f84-0e0682f64b59@foss.st.com>
Date: Tue, 24 Feb 2026 14:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ARM: stm32mp: Add STM32MP21 support
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Valentin
 Caron" <valentin.caron@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
 <20260203-upstream_add_stm32mp21_support-v1-5-48ca3409cce1@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-5-48ca3409cce1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|VI0PR10MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dda75e1-3525-463b-0dfd-08de73a8e49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1FaS3QzTTZkakVsQndmV0UzUFMwdnVJQS9HOXIwZmpOWjdtYVI4RDE3dzNR?=
 =?utf-8?B?ZDd4TjBSaG5pTU9mWUdObE1VZDY2RHA2NEp6WUJxRTJZRDVCWUhFbDlKaXR2?=
 =?utf-8?B?Z0VRNnc3VXFrTU5haE83WE44Yy9FMitKUXBSOTJsVVZGY0h3NUlCYkN6MXZD?=
 =?utf-8?B?TEFqbW1YYmRVUTNSM0FwazgwbndJUXpaRnIrVG50cFNVMDNreDZPVEx4OVRr?=
 =?utf-8?B?NHdOeE1iNXV6d1hwNTdqMUJqcm1wblZuemhYdE1ZeTUra2VqNC92Uy9ST2FL?=
 =?utf-8?B?aSt3ZWk1VDZmUE0wQ1daUUZRSUJLbE1COWlDMlY0UUxHU0VYUVhSVFV0Y0M4?=
 =?utf-8?B?dEVpbjVpM2I3ZFhIRC9lZnk5bDJYbFZ0VmdGR2hleDVrMUpNQ3l1SlJlR0J3?=
 =?utf-8?B?aGQzbnd3Ri9FajV4YndGY2ErSXRaUk1oaE91RmQwY0VNa0l5alk4SGxJc0pi?=
 =?utf-8?B?TktMeE1GVmJEWnRkdk5KQWlOallZMGFwVjVxQVpPbW05WjUzamJ1ZUhNZnBh?=
 =?utf-8?B?akVwKytSR3VxVVRNMzcwbkxwV1FaZUk2UElQK0pVcHpFa2Fiei9NbTlDVEkw?=
 =?utf-8?B?WC9qZXVMaUZSYVZJSmlMRENObUJvS2NYY2JrNWcxT2ZkbFp3RjVTU25uQWJY?=
 =?utf-8?B?ODIzN05nb3c0ZWJUYlRxRWpRa0xxMW5pVzZnWlJRRWFKQkRORUpvdHBmTG5D?=
 =?utf-8?B?aGVZcTBoaTk3NXdRZFBqbjZxdnc1MmlrTWtISDNxeUxhWStrQVdWYldhcjha?=
 =?utf-8?B?RzhOU0ZISy9GUkx2OGx0VXlBaW9oRllyc3JhRjZOSFQ1ZjNzc1RrMytvTHJE?=
 =?utf-8?B?NEc5d3NhRVlicHNTak9ZRXpWb0NFZmExWUNtdTRab3pIbldpWXdNZElOVjlt?=
 =?utf-8?B?MDRxaXVSN2h3NlIrbU1KNVhuMXhkajFaWUlYOXVDVzF5L0EzZWJoS0VHRDdn?=
 =?utf-8?B?V28wYjhVWXZLSkxFc0I1ZkcwdTNiMlFNZnJESkhSN09DbDZUYVVHUXVidlBy?=
 =?utf-8?B?WGtBby8xZitBL3FvRlNmb1U4c2ZTMVdWYlJJY01CdkoxSXNKaG5OSlN2Z3po?=
 =?utf-8?B?N0Rhd1VKdjRBcjA2NE02US80YWlucHFNaTkxY0t4QWVRTUlCb01WVStVZThH?=
 =?utf-8?B?VXBIdFR1QVhKS3JVUGt5cmYzbi8rMXFzM2VjcytZOUpYMFlzZkxHQ1FJeitZ?=
 =?utf-8?B?VW1XUmo2Q0M3UVRFbGlLWGk3VEQ5R2lDdHpEaUVjbmZPa1dNMXN4Tm5JV2NY?=
 =?utf-8?B?RnpPWEVydFpSVGRSVU5HZkRWOVBiTkFUbDV6UnBVNmV5dWZuWTFDZEhMSlBJ?=
 =?utf-8?B?ZDZPc0I0TGdJNWI2N3dFYmVha2Z3WHFKQ1dSenZjVTdNbkVBQTBMOW9ZMnBU?=
 =?utf-8?B?TklVYkIwTWdSeDBObC9ydGxHMmFTUVZwVUdiL3pISUtrcm1CN3BTclhwNjZH?=
 =?utf-8?B?bHJXbTlvcHhHU05pbDh1Unp5UTdENE5uanNydEFNYURyUVl3aSsyNFc2dkdZ?=
 =?utf-8?B?MHhiTEZPRFVheUZEWm1Gb25kcW12ajlLYXpBTGpvMUZ6RmZhMGswNnhtVkRt?=
 =?utf-8?B?cXhOZzBoc2NtOGIzU3ozSGg2cnpXTTJKblNjT1cwK2RTT2FlV2huY2YyTzJj?=
 =?utf-8?B?dTg4TXlmdFFERkRRQ09ISXFVYUlTZTh3ZURNNXdNMWJ2UHl4T09jSjVvMW4z?=
 =?utf-8?B?Q0UxVGxHQ2wwMDhRL0tpcmJubEpiQ09sUEN0WFN0RS84dHpIK0prdnRITFRo?=
 =?utf-8?B?MG92RFErcGVRdmVSankvemFwZkE1VFFkTUlUZ2tBNnI1ZEJKWnd5dURRanBi?=
 =?utf-8?B?VzNvaUVadzV5SWZjeFM1QytqUnBSdDg4a3RQODhGUHdXZTJlSGd6U0NZWGZC?=
 =?utf-8?B?V2pjVFIxUnF2NStJWW9yVEJTSWtjYzVtaTJmc1BsNGZ1TTlrRytoa29oQU1L?=
 =?utf-8?B?RVpuRUgwYzV6aXFyV3F6MFNoLzlIckkyTnlNblUyaEcvWTVLbWdMbDI2Yklm?=
 =?utf-8?B?U1Q3ZGdrZTRaNCsxQ2xIc05zZlVpRjVnaWtpZ2hTSXgzT3ZYM0U2cGZtMEpC?=
 =?utf-8?B?d1p2Y1JkTFhwS29PQk4vM1RCdDlhRmxPM0dmakE1clpQcVBmL0pHWWZldERr?=
 =?utf-8?B?alE0N0lhNUJ1QlovZjMwZEdQRE9UUG9BekJIejErSm0yVVFFOHc5N1V5eDF5?=
 =?utf-8?B?MUxGdkJFTldwSFY4Y00yd08zV2hyazNldFcxaENkVCtIeTF0dktpWGNPRGg2?=
 =?utf-8?B?bHRJL2JwM1FPdzRjcFZaRWMxSE1RPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hIgFEvpOSVWqDen7HMKBNOlqNvV49tD+9Gv8kf6Zsg4lTqZUdVktt1TarG61lQc0Hw9DY5i3UEa/DXeXae5rGIT/ic+wU232qMB5GkUCFPJKjT79xeImiq/PhkMUp0EakZ+2D7/WvmK3P8sG6KnK9fK+zIOXb0WtcKZAQFIJ5m2xvmnlJ19fvSYu8zm5KAEu7GGH52kxgMle+M17Fk9HKgLplxtT6qTDJQGSsHRsGZ146WUv0rEc8tEwdyOadNO+uFXuD0YNmUcENhPRIjuhhlLdBzR8f3QeHCgEaFY0XRj+qKHR9CuismRxFu64z/5PmVO6VwZH8Y3tXqyrkwKnMzBIWDDVQmrfqlPRaQQJoR6N7H4AHeofEnS+tmHgHgV6j0GLvU68T/8ffZiAKZLalVvEZ0KTiPEGMf75PlpCPo0H0QFz71bg4L+1REFgXf4+
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:30:35.7556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dda75e1-3525-463b-0dfd-08de73a8e49c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8498
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

Hi,

one error for CPU_STM32MP215Fxx value....

On 2/3/26 17:49, Patrice Chotard wrote:
> STM32MP21 application processors (STM32 MPUs) based on a single
> Arm Cortex®-A35 core running up to 1.5 GHz and Cortex®-M33 core
> running at 300 MHz.
>
> It is pin-compatible with the STM32MP2 series in the VFBGA361
> 10×10 mm package: the STM32MP21 uses a subset of the STM32MP23
> pinout, which itself is a subset of the STM32MP25.
>
> More details available here :
> https://www.st.com/en/microcontrollers-microprocessors/stm32mp2-series.html
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/Kconfig                  |  27 ++++
>   arch/arm/mach-stm32mp/Kconfig.21x              |  37 +++++
>   arch/arm/mach-stm32mp/Makefile                 |   3 +-
>   arch/arm/mach-stm32mp/include/mach/stm32.h     |  12 +-
>   arch/arm/mach-stm32mp/include/mach/sys_proto.h |  22 +++
>   arch/arm/mach-stm32mp/stm32mp2/Makefile        |   1 +
>   arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c     |   2 +
>   arch/arm/mach-stm32mp/stm32mp2/cpu.c           |   2 +
>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c         |   1 +
>   arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c    | 192 +++++++++++++++++++++++++
>   board/st/common/Kconfig                        |   2 +-
>   board/st/stm32mp2/Kconfig                      |  14 ++
>   configs/stm32mp21_defconfig                    |  78 ++++++++++
>   include/configs/stm32mp21_common.h             | 126 ++++++++++++++++
>   include/configs/stm32mp21_st_common.h          |  51 +++++++
>   15 files changed, 564 insertions(+), 6 deletions(-)
>

....


>   
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 90f06a052d3..7f349f3b68d 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -165,16 +165,20 @@ enum forced_boot_mode {
>   #endif /* __ASSEMBLY__ */
>   #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
>   
> -#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
> +#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>   #define STM32_USART2_BASE		0x400E0000
>   #define STM32_USART3_BASE		0x400F0000
>   #define STM32_UART4_BASE		0x40100000
>   #define STM32_UART5_BASE		0x40110000
>   #define STM32_USART6_BASE		0x40220000
> +#ifdef CONFIG_STM32MP25X
>   #define STM32_UART9_BASE		0x402C0000
> +#endif
>   #define STM32_USART1_BASE		0x40330000
>   #define STM32_UART7_BASE		0x40370000
> +#ifdef CONFIG_STM32MP25X
>   #define STM32_UART8_BASE		0x40380000
> +#endif
>   #define STM32_RCC_BASE			0x44200000
>   #define STM32_TAMP_BASE			0x46010000
>   #define STM32_SDMMC1_BASE		0x48220000
> @@ -194,7 +198,7 @@ enum forced_boot_mode {
>   
>   #define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
>   #define TAMP_FWU_BOOT_IDX_OFFSET	0
> -#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
> +#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>   
>   /* offset used for BSEC driver: misc_read and misc_write */
>   #define STM32_BSEC_SHADOW_OFFSET	0x0
> @@ -218,14 +222,14 @@ enum forced_boot_mode {
>   #define BSEC_OTP_MAC	57
>   #define BSEC_OTP_BOARD	60
>   #endif
> -#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
> +#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>   #define BSEC_OTP_SERIAL	5
>   #define BSEC_OTP_RPN	9
>   #define BSEC_OTP_REVID	102
>   #define BSEC_OTP_PKG	122
>   #define BSEC_OTP_BOARD	246
>   #define BSEC_OTP_MAC	247
> -#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
> +#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>   
>   #ifndef __ASSEMBLY__
>   #include <asm/types.h>
> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> index 2a4837184fc..47a6db79bca 100644
> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> @@ -30,6 +30,20 @@
>   #define CPU_STM32MP131Fxx	0x05010EC8
>   #define CPU_STM32MP131Dxx	0x05010EC9
>   
> +/* ID for STM32MP21x = Device Part Number (RPN) (bit31:0) */
> +#define CPU_STM32MP211Axx	0x40073E7D
> +#define CPU_STM32MP211Cxx	0x0007307D
> +#define CPU_STM32MP211Dxx	0xC0073E7D
> +#define CPU_STM32MP211Fxx	0x8007307D
> +#define CPU_STM32MP213Axx	0x40073E1D
> +#define CPU_STM32MP213Cxx	0x0007301D
> +#define CPU_STM32MP213Dxx	0xC0073E1D
> +#define CPU_STM32MP213Fxx	0x8007301D
> +#define CPU_STM32MP215Axx	0x40033E0D
> +#define CPU_STM32MP215Cxx	0x0003300D
> +#define CPU_STM32MP215Dxx	0xC0033E0D
> +#define CPU_STM32MP215Fxx	0x80


Strange value this part number, I assume:

#define CPU_STM32MP215Fxx	0x8003300D


> +CPU_STM32MP215Fxx
>
>   /* ID for STM32MP23x = Device Part Number (RPN) (bit31:0) */
>   #define CPU_STM32MP235Cxx	0x00082182
>   #define CPU_STM32MP233Cxx	0x000B318E
> @@ -67,6 +81,7 @@ u32 get_cpu_type(void);
>   
>   #define CPU_DEV_STM32MP15	0x500
>   #define CPU_DEV_STM32MP13	0x501
> +#define CPU_DEV_STM32MP21	0x503
>   #define CPU_DEV_STM32MP23	0x505
>   #define CPU_DEV_STM32MP25	0x505
>   
> @@ -102,6 +117,13 @@ u32 get_cpu_package(void);
>   #define STM32MP15_PKG_AD_TFBGA257	1
>   #define STM32MP15_PKG_UNKNOWN		0
>   
> +/* package used for STM32MP21x */
> +#define STM32MP21_PKG_CUSTOM		0
> +#define STM32MP21_PKG_AL_VFBGA361	1
> +#define STM32MP21_PKG_AN_VFBGA273	3
> +#define STM32MP21_PKG_AO_VFBGA225	4
> +#define STM32MP21_PKG_AM_TFBGA289	5
> +
>   /* package used for STM32MP23x */
>   #define STM32MP23_PKG_CUSTOM		0
>   #define STM32MP23_PKG_AL_VFBGA361	1


with the proposal for the define CPU_STM32MP215Fxx


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


