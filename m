Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A62D637AC
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AB688FB9;
	Wed, 13 Nov 2024 20:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="u5gupYCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F5D88F70; Wed, 13 Nov 2024 20:42:23 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA6088FB9
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8mLCkZrw2jFkNzkt6TwrL7anB3zyCiFmcLT9B1iE2/buZ/vXyCDDeKkTFOUZllzNECH3WBuaKPBwh4LkfZFXgF53h3CICOLz9PKWsaBqDt1rnhTF8z7kF+c6YPPCNNvA1BlnYykHJ7VQA8bejS6Dvx/5+i8ksOk5nBzP86ER7OFx1wNVF0B4o04N9ExqOWR7yqluuqZSCIH7i3/4n8NYh1s8+dMwvssOR9Pokue0N9c/l+xd5lNJsm9tqAfSsurhHA0dxmY1sd51Xqd2+7YfT2dAy2m2Jvsx+s2ZMvLFSkYJrICzOXcXNZoxnq+9h35snReFB0xsHBf+oUL2EfV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoRdjs+qaezVqQu5VQA8IXlebfjJ7mZPtXS/Btt05ys=;
 b=m7PNNADNmtFYSjRy2M0P851/TTxKK2ULVEqyDn/+EF+c3LX4F90Y5dyc9VoEBv3WGEhZRy18iLIwQWokyaVmUI42BGaQJsbARMfHNQqCI5dnG/3P/dKRETlYHuRy+FJbL0i7kQygqirgiQJcLYIyYNvuJHvMNTF4Bq5aeH7YbekYYcnTBLDkQ8HpdWpBK/EizDDU0DSS8MlVf4ZaGgj5LgNdfe2IxpzCtrF5P/CRcRmRaRVtV2rh/WtGZ29wZ/vPCx1ez5FG5Sgk9pqXLqoSOwmo7CqERMWKl297aeWaxj8TNDjBesDhWrSe59jwv9gXuzU4MiCJUg/BALIbah7kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoRdjs+qaezVqQu5VQA8IXlebfjJ7mZPtXS/Btt05ys=;
 b=u5gupYCUTxTlAsorKsRduDsD48VFf6e2X2lBte3belM6bEzd7pDMZo5Occ9uagM657w+QBhUViW/f+iKbz6PbfxuBlTajRu0WPHNeyYXuo3DM0OpDERjPOc6mcAHKvR1pRqaW9YIgl/ehAbQ6JdcOKT4aSmm+D2P2YxZW4fJ5rM=
Received: from DUZP191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::24)
 by AM8P195MB1058.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 19:42:18 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::7c) by DUZP191CA0001.outlook.office365.com
 (2603:10a6:10:4f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 19:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 19:42:18 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:42:18 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 20:42:16 +0100
Message-ID: <ede9c065-04d3-47de-9d68-0b2c4659a834@phytec.de>
Date: Wed, 13 Nov 2024 20:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
To: Christoph Stoidner <c.stoidner@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-3-c.stoidner@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241113160037.65679-3-c.stoidner@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM8P195MB1058:EE_
X-MS-Office365-Filtering-Correlation-Id: a00da2fa-d7e2-4726-4bc3-08dd041b48a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDBqUFcxUFFmSVYvT1Z1M3F0bkJ2ZHdwZ3NKRkZqMEZ6ZDFKbmtDRGFJSnpm?=
 =?utf-8?B?Rjd0R2JPbDJ1d2ErOHg3SDJYd2VNcTdnb0hPcmlxeWR5WTFiT2JqSVBxQVZY?=
 =?utf-8?B?Rld0c250YWRoV0wxWjAzQ29kcVM3U0EzMDRtbU5TZ3RnZFFFelNIRnhybFEx?=
 =?utf-8?B?TTlZMFBaM1pudCtQZjQ0N28reGFQbzZIZnpSZjZCeE1XcnNKQ0dvQXI1S2NV?=
 =?utf-8?B?aG0vVHplT0ZDcnkzYVlrT0hEUS9FOUZTbGVSTE9WVnRjaTRHYkh6YVh0MUo4?=
 =?utf-8?B?K1pkQzRzaGJETUtMVU4vQ0hXUjQ5eDkraEpzV1ZGMTJ2cHowT0prOEhzT2xz?=
 =?utf-8?B?SGRmZERlRXdreUFoR2ZKWHV4ZlVsY25UeFVDTE5tMzlZR1k0MjJaaEJrQUoy?=
 =?utf-8?B?WUlLVkxKeGo1NlRGQzFLV3gxT1dDN0JQZEozaG0vMHh3VzZxUC9EdTFwZWdK?=
 =?utf-8?B?UUdMU2FBbXRld2wvYXI0WmJ5a1hLbS9YQXBHak1WeUZPbWxzSTBieUhiM0xt?=
 =?utf-8?B?UFVYT0x1MUxiY2dBUngzenRqbXJpQmlvaUwwRmprS3JXSWYrdEpkSm1aNkRz?=
 =?utf-8?B?cmhsUDRkTXVWcmo5Z0duOGZUTFBUaEVIVXdzSVEzNml4YUh3UFozem43NWxj?=
 =?utf-8?B?L2ZzZG52d2Z2WDA0NlkxUklieFc2UUhFQys0WS9XSGNqa0NqYkxWWWtpdWlz?=
 =?utf-8?B?MWdQWDJJYk9lZndGOWVETzRlcFMxQWNUanFwKzIxMjI2Z3FxZGFSV1RpYXVr?=
 =?utf-8?B?QkF0bklETkJVOHJmMUxhZTFuVlNPWmg3WjVOOXUvMGdOcmhXaGRSbGJ0WWZ4?=
 =?utf-8?B?V3ppa0pUY0xnbUp2RlpZTjB6NG02YU9oYkQ2NHRUbDdtT0RWQmtKbjQraGpV?=
 =?utf-8?B?Qk9ITnRBcjM1Z0NHNHk2LzdpTE9xZnlMall2TUl2aEJaanhvNWRUdXhNaStB?=
 =?utf-8?B?Y08xNCs2bi91QWtNc3VQeC9RaDcwZEpyQmZMRS9KTklYZ0xwTkwzYkQ0WWJE?=
 =?utf-8?B?WEZxejNLbGdPTWpBTFVXNXpaYk9sb1JrOFU2K25XNlBpWlFEbEsrQVlKZmhS?=
 =?utf-8?B?NWkweWIxc0ZvMkNnazRZK1RQc2ttbVBYbnE0anM1eXN0YWdDOTRmV0ovUTZk?=
 =?utf-8?B?Vkh3eWZTYWo4dHl5UGRhQUhPcVR6TTVXaFFaQnA5WDJObUxlWWtSVDZLZ040?=
 =?utf-8?B?elV6M0FjZitIcmNNVkdiOU11dWsyaDFZd3oyU21tTkx3VHpYakNVUnBacFZj?=
 =?utf-8?B?L0VmSlUyZGo4QUNIeThUQkk2V3VCL1pyU3Q3T0pRalNIMDFaaXQxWURsT1ZU?=
 =?utf-8?B?QnJ6UzlpeXR2M0I2Z1NIUHdxNmQ3R1B0YnNLck1yZk55cjhsdXU2TjJ4UDdF?=
 =?utf-8?B?NWE1bUkxSTVmMXdpaUtDUll5ajJaelRmQ3RkcG11KzNyYkxqMDZNREVENk9N?=
 =?utf-8?B?dkRUWEFVdGhVM1JZZUl5OFRFZ0RtSU5HU2VVUmxhclJQVUV2UEptTHdzRHN5?=
 =?utf-8?B?d3diZEppL0RYVmhKZWpjZXNHZUhxT3NzRVZFcmh1cHFMeEJNWVVaT1dVU1Fh?=
 =?utf-8?B?aEMwYVJaaWlhK3poRFptQzltWGFMZ29wQ2R0U2l6VU1nYVJmZlVqRDVnRkpU?=
 =?utf-8?B?NmFudkFqdzZ6MGNXS3RQTGxxZ0R1MDZLZ0IySkFTdndCY1JrUXNnMS9hODJV?=
 =?utf-8?B?d2MydzVKYmRtU1FBRWxIL2l1VGFUL3hIRFc1aFdCMjZqeVVhR3VYcWpqVVJX?=
 =?utf-8?B?UG02a1d4aEVNTGNHUWpUQkpLdEhWQ0Y2TEtYMUxvbFp5SFVLRFdQNHFTTVda?=
 =?utf-8?Q?S67DOtscM652fG+81kXeveHNBJ8TdFxn+nxOc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 19:42:18.5077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00da2fa-d7e2-4726-4bc3-08dd041b48a2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB1058
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
> The phyCORE-i.MX 93 is available in various variants. Relevant variant
> options for the spl/u-boot are:
> - with or without HS400 support for the eMMC
> - with 1GB ram chip, or 2GB ram chip
> 
> The phyCORE's eeprom contains all information about the existing variant
> options. Add evaluation of the eeprom data to the spl/u-boot to
> enable/disable HS400 and to select the appropriate ram configuration at
> startup.
> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
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
> - encapsulate handling of feature flag VOLTAGE into own function
> - move definition of enum phytec_imx93_ddr_eeprom_code into header file
> 
>   arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  19 +++
>   arch/arm/mach-imx/imx9/Kconfig                |   2 +
>   arch/arm/mach-imx/imx9/soc.c                  |   2 +-
>   board/phytec/common/Kconfig                   |   8 ++
>   board/phytec/common/Makefile                  |   1 +
>   board/phytec/common/imx93_som_detection.c     | 111 ++++++++++++++++++
>   board/phytec/common/imx93_som_detection.h     |  51 ++++++++
>   board/phytec/phycore_imx93/Kconfig            |  28 +++++
>   board/phytec/phycore_imx93/MAINTAINERS        |   5 +-
>   board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++++++++
>   board/phytec/phycore_imx93/spl.c              |  48 ++++++++
>   11 files changed, 324 insertions(+), 2 deletions(-)
>   create mode 100644 board/phytec/common/imx93_som_detection.c
>   create mode 100644 board/phytec/common/imx93_som_detection.h
> 
> diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> index 6897c91f4d..25c778bb07 100644
> --- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
> @@ -305,4 +305,23 @@
>   			};
>   		};
>   	};
> +
> +	eeprom@50 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +		vcc-supply = <&buck4>;
> +	};
> +
> +	eepromid@58 {

Please use a generic node name, 
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

With that fixed,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
