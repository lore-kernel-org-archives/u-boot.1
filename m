Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24995CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5BB846BE;
	Wed, 10 Jun 2026 10:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aiOd1ASZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C36846D3; Wed, 10 Jun 2026 10:49:01 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72C580087
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn8OsHFunVrXGa2pFcd0vIsyzIECmyQdE8pFUkCBqppE34cRgP33iiY44KWeygcu/P6jtz24lNnLokm9mc3GLklC+9qoJJwPJNCGzaJEwDTJxXWj0Upzsrf3yyblu0pg0eRiFFWeUdYPhHWTOn/LSm4zCMk/lg0F6waHlARMDXKPjqFPimVtP7SOfpBlsfgmGL9emdggmX0+54QNpZvva5Bn+aCFz6K9MyMYC/gANyMYGJRpFtE558gdkxR1cJ+ypFOdz3jceCrUtCIBRZ2wuVnckyZGFb8Kr2gybOJYfuSnINTYRX+NI0YgKq3jzJ1lg/rEOPGvzjcG/GeaDlk7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTKuhMQ++vWsIW4fniHzZCOdmhWeKyR2+WB6ZmecFUc=;
 b=PeJyHd3Hy8GUNRHndq3Dfc+fvrnHjGOvBdHXtbDwpEQNwE32/jmQqYiikDJTCkfH3FSKD+u298Y8vmoYyCC09U+oUWPkrP5X6abXK1jZcTI+R0Jjkq/OV11y45kAnhkIG/3jzSXMtd+rpZnsgNHvcsQpLvN3VPPx2EHK8EuUM2v397Z4d2qpmiFTqEcy7zdM9FS9gSAGPoz0fTbyXLv7uyXcukKyntqQK/Npe5rJWnAU9+WvtFHXzgAgAW9oqTAbKbzlQuOiRE+q/ZVJF1OFVxMyPTEvY2mtRlUwAeSuKyyxSwkL9VrYKozsLAoKEwqr19rD2fCxQC7/N5P2lOKOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTKuhMQ++vWsIW4fniHzZCOdmhWeKyR2+WB6ZmecFUc=;
 b=aiOd1ASZkwMzFq8gjtxshBFRLfENggEtXDaPmE+xmzKdv3qtZoCB0zlEdSyn7Ox80c4gif2UptHxFqwcZqFUvDi+718zfyi6uD34p3F8dTeuT2FJfy5LxRsmIWlOtVphAvFAXu99t9Wj4biDH21W+HgNkJEmVftka9dgeQb5M6QxKNoLbOjrfWwsouOLa5/chLQDNkgIEgstlA7N66Fhp20rzKWMNB4Sd/Ig5DLdTHrPl2i30p6QHCoJ2ClF2Sf1J0GxvoosrGfQc7BPgoRgVFHnjigDJsxSO36oiRaxNWuCRlMzJDtSBLTSwr2pPGf2EAFymeFj/NYYAmKhNusGBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:48:55 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:48:55 +0000
Message-ID: <f8a3ece3-6b1e-4373-a92a-a6d912565212@altera.com>
Date: Wed, 10 Jun 2026 16:48:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3a7320-8406-4455-f324-08dec6cd1ad6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 0j5G89eMybYIcli/LARvHIaEDvsbBRmsJ13pHrfJ32NxbisLZonC/vv41t46xLaWJd/3vqo7LSvln/4V5+U91a6X4bqpNkK/7FGKA/OpV5KWFn7Rz76yYKE4PxdfdQ6LujmKxPCEKbomgK6DjUEaiYjMFWkdGBKes11FV3zB4MHX2nM7KD186TDWw7RMHpPVpNWnr8KfTWpUehbFoNp+XfyWD7oO5z0tfl6C/xc4cTb0FrXDflUAcp8OG7JhAyh1QdcOvleCRffjVZjL5FwMuv7e/4SPrSJcu1YMyFIyvuoQ95PR4fWRHB1Y85vqT86cu12+7JvnudQh0u3LEpXqVht7Oldr6Y45Zp9GjD8uNfrXri1SFM7vv2ykRIUakltny61qSVDt9EGNh7FvKTe4KjyCMKrG9eS8WngAF9uxzoUPh8URJ/C+QMiizQvexTNUyKwRY9HXFc/FFkpfGNuMLn8JcNFlFqMbeCkmppcdLWieD2cJMKjyJAJKMs45AxLvRRMHhcar9akO5ojNIORXR0m+4F246xzV3NL8uHZ/+5KyvUlK1mlz9/jXf8rTk74MP92bJgxXo5aUB9GJvvG3N+cOlDcdpoVjwIwvxRepgcUBwZ+HkE6WrzK41wKqzGldF5RXJFneXCEBDxkPm+ujkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndRcFJjRzdKNVQ0R05Ga25xVHNVL0hkYlU5SnV2RXlZRktUNERIUCtGTTdx?=
 =?utf-8?B?OGhyZHZTOGZhc21GTW5zUHozVDk2cGZjRXdCcU0xaEp3c0J6cHlvZmdZKzlh?=
 =?utf-8?B?SVlwUEttdm9BdFF6a0ErM1czdjZlWXdYa0hYRU8zRUpEVmZ6citaVS9PTXd3?=
 =?utf-8?B?a1U2cXhrZFArRlozWGg0bStqU1M3RnhjbDZ3RTBLSWpIdlQ2eHZNSjF0MDRW?=
 =?utf-8?B?LzU2Nzc1YVFLWUd6ak5jOXVKOVhXNTJXdGJ3Rk1rUTYyRVBqbWNyMzZRNTIw?=
 =?utf-8?B?VDZBc3BuRmk2bEVZMXl4M0ZRSXE1dmRycWVCWEZHb0JNUlBNZUdzUXBnenFL?=
 =?utf-8?B?dUxRZEJkZmJIaDFKbHJKV0x1Rk4yeTRFREJZSUNjTytrOUd5WnFBeEdkejVy?=
 =?utf-8?B?NUlxOW5XcEt0TFBvd0lBZExmTU5CTTgrYnNtTW5SMUJDMXZ3aDBGSlMwZXk1?=
 =?utf-8?B?L0tkQ1ZUaXM0MFJrZENTWFh6WXU2OXNONURKRm5kNFNhak5UR1g4cHJza3FD?=
 =?utf-8?B?S3FrSU41Q0I3TFBidU9YTWdRL0RTbFJub1NvZldtaUlSdDlLcnVnT2VHQys1?=
 =?utf-8?B?emVqNkJrMEx6Y1RVYy9HdGl6U2xUMlo4Q29BdTIzMXJZRysydVNxcG5sNmw5?=
 =?utf-8?B?OHZYbjN4TXJQQWkxVzBEU3FYQUcrb0hnUlBpQ0JybXVvSDRneXI2NC9XdWVW?=
 =?utf-8?B?dnM4V1NMdmFZSzBmUm5GaU5BaHdsa010KzRpdnA5UDlGeFVydVUvNnRzQ2tR?=
 =?utf-8?B?dkZrL3greks3aElIZGxhQUM4WDFOYVZVczlEQlhGdFpIcjdDZFR0YXN0Mml0?=
 =?utf-8?B?OE16OVJBdDZGZHZSK0wyVzBDVy9RTm1NbVpQWUZVUXdyVnY1QnByMnNvQnZk?=
 =?utf-8?B?ZWs5VXJDams3bUNxRnRrSWc5THdoZm56NmY4VW5pZVVxZEZZalJCUXZxRW9S?=
 =?utf-8?B?R2ZaYlFieG1HaHZjK1NYVy90eHdOUE1MeFRRVzdLalAxUXg1MitjQjc4a3NP?=
 =?utf-8?B?L0VCTzhIV0xsUVZ5WGZ3NStER05Yc1ZWRUlLUUhXOElDTWlkTGU2RkJHVGtu?=
 =?utf-8?B?STExb05Rd2RXOURHQ05WVEVpRVRaNG81c1YwQTlKTkp6OFJkeXBFR3F3OFNE?=
 =?utf-8?B?UUw4Z2tBdndUcnZnNWdKalExaHhNSk9wSmdJWnovRmZjRXBBOTFiUzhidmRP?=
 =?utf-8?B?dkxSRFpTS0xuY053cHJPQm8vK0xmZ3MvYkNLUmNLbCtxdHRxZmdvUjM0Vytu?=
 =?utf-8?B?bUI2cUc0NDJ6K3JaNjFQb0x2YUZGTnEzRTQzdXJvSTJsUUtBay9YVHpwTFJp?=
 =?utf-8?B?STR4cVdBU0k2MFR0N3ZSZ3dEY2RIbXVCWnRJMnRONTU0cG1GWktxbW9hQnhR?=
 =?utf-8?B?K2EvNVBHTDhqd0JaeHhwcFZsbU1FdnIyTExBQmlJamRmMURoMS8rTGRHMlVK?=
 =?utf-8?B?d001RDJEV3BLYk1MWkczWmlXSkV5VHBvYlI2NGx6Y0F6Nys4YTZqcDdlcTFP?=
 =?utf-8?B?M2M5NU9RSXFyRWRjcnk4UGZHdkRXUkVFOHRIeTJLWjZrOWpWMnJnOGQxUita?=
 =?utf-8?B?NWFtcVZkeFdiQ0M3KzZkMURFYU9MeXR5dTJBZjBmUGhuQStYSStGR1p6aXRW?=
 =?utf-8?B?WVNkMnptZDc1eE5aZER5VWFuMUIrZ2RxbkFXeUdGOFNLUWt1MG5idlhERzg4?=
 =?utf-8?B?Z2tHSEdRc1N1VGhLK2hOWk83Y3IrUU5ueWhSRlV3d1hVbG5ZMlVHL0FQKzQz?=
 =?utf-8?B?QklzSkZobC9lZXJWUlhGTGEyb1dydXpySXlscVlzOWZtaEl3VGFRWDlVYlRn?=
 =?utf-8?B?aFQ0YktDYnY2ODhtcWU0Tzh1V1owT2pENnFMRE5hdlFEb3NoTUgyMktqUlFp?=
 =?utf-8?B?UzZLWWFwaGZjVVNXaVp1S005MVpBMFpPYnJzbkU4UE5YazNZR1p3UUFvU0xD?=
 =?utf-8?B?ZWZadzN1L01VekYvTVc5NzRwYnFuM2Z0eDBTRDVJb3p0bTI1VXV5dkdTTTFP?=
 =?utf-8?B?WEhmeEw1bG90NWRxcElUVHBEbXhHK3A3YS9MSnpPN1MrellhOGl1ZTQyK2Ix?=
 =?utf-8?B?bmpYUUh2QWdkYTZ2TDh0ZGpod21KVDUzK29Rd2tQWS9BcXM3MlZYa1l2Z1pr?=
 =?utf-8?B?SEpZdzdhTDNiWHZ5WGJPaWtLOG44NFRGKzdRY2pkK0loQ2FGT3JyZVFsVkVm?=
 =?utf-8?B?SUtWWXBtK0FpS3dNdU0xWkdDUDU5UTdMamNBTEh1d1UrQlpxSWNNZkN3T1VJ?=
 =?utf-8?B?bzlvRUgwS1dKK0dGazZEWW5TRWlSUE1GR0dna29zNDRVVUoxd0RNbitTckNx?=
 =?utf-8?B?dEM1MGRoS1N2bGhPRjAxK3FVWUhlTm5MZ1lCdThZVU1pNGxXMWZvbkJLdndT?=
 =?utf-8?Q?oyrLnE1v2TC9CfDI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3a7320-8406-4455-f324-08dec6cd1ad6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:48:55.5193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9erS3s1eGJfHu9ZoP9B0LsxX5hTDHJMZa5ej0on7C2mbYzttf97/m/P+uy01lTcLIytzYuC0SIl0iAxidXAng3W5CWNIafhoyXZzzSP/sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:54 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Migrate the CCU, firewall, and high privilege register configurations from
> hardcoded values in the source code to the device tree.
>
> L4 per/sys firewall setup which was previously done by firewall_setup() in
> spl_s10.c is now replaced by DTreg node in socfpga_soc64_u-boot.dtsi as
> Stratix10 is sharing the same tables that Agilex uses.
>
> This helps to centralize hardware configuration, improves maintainability,
> and allows easier customization for different platforms.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v4:
> - Commit message improvement
>
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi | 149 +++++++++++++++++++++
>   arch/arm/mach-socfpga/spl_s10.c            |  29 ++--
>   drivers/ddr/altera/sdram_s10.c             |  44 ------
>   3 files changed, 165 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> index a3b4c0564f9..ad4b383f704 100644
> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> @@ -6,6 +6,7 @@
>    * Copyright (C) 2026 Altera Corporation <www.altera.com>
>    */
>   
> +#include "socfpga_soc64_u-boot.dtsi"
>   #include "socfpga_soc64_fit-u-boot.dtsi"
>   
>   /{
> @@ -134,6 +135,154 @@
>   	bootph-all;
>   };
>   
> +&socfpga_l3interconnect_firewall {
> +	i_ccu_noc_registers@f7000000 {
> +		reg = <0xf7000000 0x00049e60>;
> +		intel,offset-settings =
> +			/* Enable access to DDR reg from CPU */
> +			<0x0004400 0xF8000000 0xffffffff>,
> +
> +			/* Enable access to DDR region from CPU */
> +			<0x00045c0 0x00000000 0xffffffdf>,
> +			<0x00045e0 0x00000000 0xffffffdf>,
> +			<0x0004600 0x00000000 0xffffffdf>,
> +			<0x0004620 0x00000000 0xffffffdf>,
> +			<0x0004640 0x00000000 0xffffffdf>,
> +			<0x0004660 0x00000000 0xffffffdf>,
> +
> +			/* Disable ocram security at CCU for non secure access */
> +			<0x0004688 0xfffc0000 0xffffffcf>,
> +			<0x0018628 0xfffc0000 0xffffffcf>,
> +
> +			/* Enable access to DDR region from IO master */
> +			<0x00018560 0x00000000 0xffffffdf>,
> +			<0x00018580 0x00000000 0xffffffdf>,
> +			<0x000185a0 0x00000000 0xffffffdf>,
> +			<0x000185c0 0x00000000 0xffffffdf>,
> +			<0x000185e0 0x00000000 0xffffffdf>,
> +			<0x00018600 0x00000000 0xffffffdf>,
> +
> +			/* Enable access to DDR region from TCU */
> +			<0x0002c520 0x00000000 0xffffffdf>,
> +			<0x0002c540 0x00000000 0xffffffdf>,
> +			<0x0002c560 0x00000000 0xffffffdf>,
> +			<0x0002c580 0x00000000 0xffffffdf>,
> +			<0x0002c5a0 0x00000000 0xffffffdf>,
> +			<0x0002c5c0 0x00000000 0xffffffdf>,
> +
> +			/* Enable access to DDR region from FPGA */
> +			<0x000105a0 0x00000000 0xffffffdf>,
> +			<0x000105c0 0x00000000 0xffffffdf>,
> +			<0x000105e0 0x00000000 0xffffffdf>,
> +			<0x00010600 0x00000000 0xffffffdf>,
> +			<0x00010620 0x00000000 0xffffffdf>,
> +			<0x00010640 0x00000000 0xffffffdf>;
> +		bootph-all;
> +	};
> +
> +	/*
> +	 * Both firewall and QOS regs accessed by CPU in MPFE has
> +	 * dependency on CCU configuration above.
> +	 *
> +	 * Below are all fpga2sdram firewall settings with default
> +	 * reset value for the sake of easy reference by users.
> +	 * Users may choose to remove any of these register configurations
> +	 * that they do not require in their specific implementation.
> +	 */
> +	soc_noc_fw_ddr_fpga2sdram_inst_0_ddr_scr@f8020200 {
> +		reg = <0xf8020200 0x00000050>;
> +		intel,offset-settings =
> +			<0x0000000 0x00000000 0x0000000f>,
> +			<0x0000004 0x00000000 0x0000000f>,
> +			<0x0000008 0x00000000 0x0000000f>,
> +			<0x0000010 0x00000000 0xffff0000>,
> +			<0x0000014 0x00000000 0x0000001f>,
> +			<0x0000018 0x00000000 0xffff0000>,
> +			<0x000001c 0x00000000 0x0000001f>,
> +			<0x0000020 0x00000000 0xffff0000>,
> +			<0x0000024 0x00000000 0x0000001f>,
> +			<0x0000028 0x00000000 0xffff0000>,
> +			<0x000002c 0x00000000 0x0000001f>,
> +			<0x0000030 0x00000000 0xffff0000>,
> +			<0x0000034 0x00000000 0x0000001f>,
> +			<0x0000038 0x00000000 0xffff0000>,
> +			<0x000003c 0x00000000 0x0000001f>,
> +			<0x0000040 0x00000000 0xffff0000>,
> +			<0x0000044 0x00000000 0x0000001f>,
> +			<0x0000048 0x00000000 0xffff0000>,
> +			<0x000004c 0x00000000 0x0000001f>;
> +		bootph-all;
> +	};
> +
> +	soc_noc_fw_ddr_fpga2sdram_inst_1_ddr_scr@f8020300 {
> +		reg = <0xf8020300 0x00000050>;
> +		intel,offset-settings =
> +			<0x0000000 0x00000000 0x0000000f>,
> +			<0x0000004 0x00000000 0x0000000f>,
> +			<0x0000008 0x00000000 0x0000000f>,
> +			<0x0000010 0x00000000 0xffff0000>,
> +			<0x0000014 0x00000000 0x0000001f>,
> +			<0x0000018 0x00000000 0xffff0000>,
> +			<0x000001c 0x00000000 0x0000001f>,
> +			<0x0000020 0x00000000 0xffff0000>,
> +			<0x0000024 0x00000000 0x0000001f>,
> +			<0x0000028 0x00000000 0xffff0000>,
> +			<0x000002c 0x00000000 0x0000001f>,
> +			<0x0000030 0x00000000 0xffff0000>,
> +			<0x0000034 0x00000000 0x0000001f>,
> +			<0x0000038 0x00000000 0xffff0000>,
> +			<0x000003c 0x00000000 0x0000001f>,
> +			<0x0000040 0x00000000 0xffff0000>,
> +			<0x0000044 0x00000000 0x0000001f>,
> +			<0x0000048 0x00000000 0xffff0000>,
> +			<0x000004c 0x00000000 0x0000001f>;
> +		bootph-all;
> +	};
> +
> +	soc_noc_fw_ddr_fpga2sdram_inst_2_ddr_scr@f8020400 {
> +		reg = <0xf8020400 0x00000050>;
> +		intel,offset-settings =
> +			<0x0000000 0x00000000 0x0000000f>,
> +			<0x0000004 0x00000000 0x0000000f>,
> +			<0x0000008 0x00000000 0x0000000f>,
> +			<0x0000010 0x00000000 0xffff0000>,
> +			<0x0000014 0x00000000 0x0000001f>,
> +			<0x0000018 0x00000000 0xffff0000>,
> +			<0x000001c 0x00000000 0x0000001f>,
> +			<0x0000020 0x00000000 0xffff0000>,
> +			<0x0000024 0x00000000 0x0000001f>,
> +			<0x0000028 0x00000000 0xffff0000>,
> +			<0x000002c 0x00000000 0x0000001f>,
> +			<0x0000030 0x00000000 0xffff0000>,
> +			<0x0000034 0x00000000 0x0000001f>,
> +			<0x0000038 0x00000000 0xffff0000>,
> +			<0x000003c 0x00000000 0x0000001f>,
> +			<0x0000040 0x00000000 0xffff0000>,
> +			<0x0000044 0x00000000 0x0000001f>,
> +			<0x0000048 0x00000000 0xffff0000>,
> +			<0x000004c 0x00000000 0x0000001f>;
> +		bootph-all;
> +	};
> +
> +	/*
> +	 * Example of ccu_mem0_I_main QOS settings with
> +	 * default reset value for the sake of easy reference
> +	 * by users. Users may choose to remove any of these register
> +	 * configurations that they do not require in their specific
> +	 * implementation.
> +	 */
> +	soc_ddr_scheduler_inst_0_ccu_mem0_I_main_QosGenerator@f8022080 {
> +		reg = <0xf8022080 0x0000001c>;
> +		intel,offset-settings =
> +			<0x0000008 0x00000000 0x00000303>,
> +			<0x000000c 0x00000001 0x00000003>,
> +			<0x0000010 0x00000BFE 0x00001fff>,
> +			<0x0000014 0x00000008 0x000003ff>,
> +			<0x0000018 0x00000000 0x00000007>;
> +		bootph-all;
> +	};
> +};
> +
>   &uart0 {
>   	bootph-all;
>   	clock-frequency = <100000000>;
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index a0d3c96d456..8ab80740c6e 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -25,6 +25,7 @@ void board_init_f(ulong dummy)
>   {
>   	const struct cm_config *cm_default_cfg = cm_get_default_config();
>   	int ret;
> +	struct udevice *dev;
>   
>   	ret = spl_early_init();
>   	if (ret)
> @@ -67,22 +68,24 @@ void board_init_f(ulong dummy)
>   	print_reset_info();
>   	cm_print_clock_quick_summary();
>   
> -	firewall_setup();
> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
> +	if (ret) {
> +		printf("System manager firewall configuration failed: %d\n", ret);
> +		hang();
> +	}
>   
> -	/* disable ocram security at CCU for non secure access */
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADMASK_MEM_RAM0),
> -		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADMASK_MEM_RAM0),
> -		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
> +	if (ret) {
> +		printf("L3 interconnect firewall configuration failed: %d\n", ret);
> +		hang();
> +	}
>   
>   #if CONFIG_IS_ENABLED(ALTERA_SDRAM)
> -		struct udevice *dev;
> -
> -		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> -		if (ret) {
> -			debug("DRAM init failed: %d\n", ret);
> -			hang();
> -		}
> +	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +	if (ret) {
> +		debug("DRAM init failed: %d\n", ret);
> +		hang();
> +	}
>   #endif
>   
>   #ifdef CONFIG_CADENCE_QSPI
> diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
> index 4ac4c79e0ac..1497a8e4aab 100644
> --- a/drivers/ddr/altera/sdram_s10.c
> +++ b/drivers/ddr/altera/sdram_s10.c
> @@ -78,50 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
>   	phys_size_t hw_size;
>   	struct bd_info bd = {0};
>   
> -	/* Enable access to DDR from CPU master */
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_DDRREG),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE0),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1A),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1B),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1C),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1D),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADBASE_MEMSPACE1E),
> -		     CCU_ADBASE_DI_MASK);
> -
> -	/* Enable access to DDR from IO master */
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE0),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1A),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1B),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1C),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1D),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_IOM_MPRT_ADBASE_MEMSPACE1E),
> -		     CCU_ADBASE_DI_MASK);
> -
> -	/* Enable access to DDR from TCU */
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE0),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1A),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1B),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1C),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1D),
> -		     CCU_ADBASE_DI_MASK);
> -	clrbits_le32(CCU_REG_ADDR(CCU_TCU_MPRT_ADBASE_MEMSPACE1E),
> -		     CCU_ADBASE_DI_MASK);
> -
>   	/* this enables nonsecure access to DDR */
>   	/* mpuregion0addr_limit */
>   	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

