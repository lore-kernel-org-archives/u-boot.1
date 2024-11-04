Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7113D132CB
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D34488A0A;
	Mon,  4 Nov 2024 14:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="oAtVmfCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF64B88C75; Mon,  4 Nov 2024 14:54:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F5888936
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMgMe20ifPaf51RI3HgLw0dBHamgiJ/MuX8KyAsnzCnFHamSpYqALBskOeeaVJdEe8yTqEUKgUYLU1JHZlK4qR5lfYgJhyvx8QnFEnL2bHwNIBcPLFFYPm+buqL9ZvcQ+6ahyY1HUzL2PKvefxtiOeqpzalFMAi4kRG07Jxh3j5KhLJUWhiv8G6Bj6XAgX0sy06TAS6CUDjA7JZjO++JqwnxlNRu8n14ITmD7br1IN5POJnZ6k0EaAgWL2w7S0aCEAvSU/CgCpOj0CTh85NfLlOC+uYnQ3RUazBxn3M8HRIc9AjKAGIxkx+logKr/x0w3oAXqKurWdYS+uxUUIJa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPjObroP1wpU5SaaBKUt6kAkYsXtOIAHmWJ6Eu0A2lk=;
 b=ZrW1GZzKv+xAKDnMllk0lwEhIjcU0B92w+MS3weHMppjZJh0Eo+49TyGrHwalVUugulsIxJl34p1rBombJrBfHvKFacH/WRseMy0gAHCo9Aefp+giVP33Gdy3mX8XgqHAA8BdhktlhooOpP8sm7HiK79O9bcDIGa+InItv0DFIEL2ZyGZ7eWQCJ6mBuu9VGkiJ/xhdmZGC9lvwPLUJ1ju4m374iJKfro8jqUaK7dPRUxQmz+eky+bjqP6jdMrv/GC52mA7kz7H+9SVgLXJTxhNYqsOMNorfWDPh6jXU7e6Uc1iVEtPmbuG5pnUg+aKLdh1njqQ25F+2lKIV1dhlASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPjObroP1wpU5SaaBKUt6kAkYsXtOIAHmWJ6Eu0A2lk=;
 b=oAtVmfCoxtW/pL1Mryovb6HIE+ZeHFQ7PKBpluClrxiaDRfCRBMcxP6fVYq4ATk9qmLIofzFGIl164aAWc6Po+GNQ4kXScBELje2SRO9NYj6oM5D8nZYEKQzDc8akx9+vnpor7Tn++BfXlsW6+GYemyRrJhOKnpURB/sXhM1zz0=
Received: from DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) by GVXP195MB2556.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:1d8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 13:54:01 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::a5) by DUZPR01CA0348.outlook.office365.com
 (2603:10a6:10:4b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 13:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 13:54:00 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 14:54:00 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 14:53:59 +0100
Message-ID: <aa8f4b25-64f2-4ad1-9cc0-db1ed96cbc58@phytec.de>
Date: Mon, 4 Nov 2024 14:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 2/3] board: phytec: imx93: Add eeprom-based
 hardware introspection
To: Christoph Stoidner <c.stoidner@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Mathieu Othacehe <m.othacehe@gmail.com>
References: <20241104104148.748331-1-c.stoidner@phytec.de>
 <20241104104148.748331-3-c.stoidner@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241104104148.748331-3-c.stoidner@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EA:EE_|GVXP195MB2556:EE_
X-MS-Office365-Filtering-Correlation-Id: a65a8666-2cd7-46b7-b23b-08dcfcd82306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGl4TnB2UmhCKzkzdTlpaEFFT0ppd3kvcmpTL2RKTHA0OVhGR2xsWWs4M1hz?=
 =?utf-8?B?QlVPVmExSS9nWGc5WUVuVXFvY0Y3WEFmZmlIZFMyUGJSU3dFRGxWUW9DWlRU?=
 =?utf-8?B?Mk1JS3pGZ0Fsdk44dUFFUXIyeGF5N2VSenpjekdpWDhYakhDT2JUOFZ4WkhK?=
 =?utf-8?B?MjhrdTU0eFc4RUxCUWlDMWJWUUtPSE8vUmxTTE1NbEZJS2ZGS2kvcVJSQWNF?=
 =?utf-8?B?OEpPdmQ3eTBqWlg0MHFldTJQQ083TEtsaGNjaW0xMVVzTXNxTUFoZkU5L1dz?=
 =?utf-8?B?QVY3UWJQKzZaSm5oczM5VlJBR0Jhb1BDYWw0TFBTNlhKYkQ4dHc1b3NGOW42?=
 =?utf-8?B?cXV3TS9aaUhKdmtQUDJ1SnkxZWd4a2pteThRa2xiTDVrdklNNnE0enpSdkkx?=
 =?utf-8?B?WjhPQVlmcDE2MXVJUXgxVjd2T3hWRC95V3Z2dzFqbWJYV1dZT2NjeUxBN3Rh?=
 =?utf-8?B?ZE5aUTVqVFRHRmNFcGozL09yWjRMb2paU0RNZzluQS9CY2pvWHdHRVZMWWRZ?=
 =?utf-8?B?aUk2M1grNzVDajJ4YytxS1F0RGRjeldOUlc0M0hpZ2w1bnpOMWtyeG9BUEdB?=
 =?utf-8?B?R2NoUWxZbHJ2a3Z6TktJYU15b2wzQnZQOEEzR3pEcUQvWm15RGlGd0Iza1pr?=
 =?utf-8?B?em9NYS9PM25XUm42SXlLWUl1d3VINVJvUVNHelFjVE9uMTdSTXU5QjNMbHNr?=
 =?utf-8?B?a0RqMlQrc0QvR25leUh5OVBJeTF1d0luaW54RHV6VHRpY3BXWUVyT2phcTV2?=
 =?utf-8?B?aGxVT1RBZ253Qzh4WmtQbFhOQ1c0WHgwVmlTQzZNWnZVVFN0Y2Q3RDNPaGJi?=
 =?utf-8?B?dnBYdDJlbTNYYVk3RTdwcGxRTU9PWkFxWW5iRzM0YXoxZlZGdDJhbEdTRGxp?=
 =?utf-8?B?amNYRnk5aVBEQzYxNmFnY2NRcDVxaFBRTFNZdTlyejFkWWJqYW9XT0poS1JR?=
 =?utf-8?B?eVg3RklmUXNXRHIrVWsrc1M1cHFKSHozcmdrV3IrbHlRZFRUc0V0aDhTM080?=
 =?utf-8?B?emxJQytsN2ZGeUdXaktlQXpTVUZjOGN0VWJmTyswV0hDWUplR2lZNFVSNHZq?=
 =?utf-8?B?RWM1Z3k1T1ZzSXB4cmtJQkxNTGUyOG8wTldrTVhETnFGODVDcEFSMC9TZXBD?=
 =?utf-8?B?N0plM3R5Rkw2UXJWcXFLUVlSSW5uNUtYV0srS0VOc3U0ekJES2RNRDZ6RUtq?=
 =?utf-8?B?RkQxQVhtZ2JRRXlRRkdQLzVIcjFCOGtsVTkxaXZRQlY4WTJEbnNIMmxmRWJB?=
 =?utf-8?B?OXRtOUxSNnVuejNEeE4zcDNXT0RDS1VPTXArWnBNRm9jdm5xTUlMTVUwallu?=
 =?utf-8?B?TlJNQ3lIRTA1ZWlNSFk4dHVibE5aWU9scnU2MGQySldjYkdlR21oWnNpL1VG?=
 =?utf-8?B?ZThtSGV6NmY3TENzRFA4Yi9rL0RpVHMrQk9yM3NvWmhDNTBWYnFHQ3pXUDhn?=
 =?utf-8?B?SWZrKzBjbjlZd1pRZExvZ0FPZ1NIcHRqRG1HWnMrR3I0U1duYjBjUE9BR2Rw?=
 =?utf-8?B?ZlNadGE0aFA4YjY4Y3JVYWFvRWUzalBocklMdUg5T1ZlbFMvNmlXZUtQQ1RG?=
 =?utf-8?B?dll1NnBIcTFnY1ltWTFGOE1sMFQ3Ykl6VFhGd2dIbVpIVGxvN1p0TGNlMUlH?=
 =?utf-8?B?Z1N5SDNHM3RSRE51dnZMY0JPdjQ4dllBaEZWdFA1SENRb1h0UlEvc1hFb2tL?=
 =?utf-8?B?eUo0Ry8zME9vT3NMbFVBSWRGaHEyYkxiR1NXZitjUUZMT2NudUFsdnhWUVZy?=
 =?utf-8?B?aWNVRW52WTluajNRbmJZTVQ4NndNdnc3WFJMbFdnNUxpKzdiOUt2dkZoanky?=
 =?utf-8?B?K1ZCTnMvWDJUU2Yyb3BubGxqWExnUkh3elZLMjRVeXJSRzJ3YWp3WHkyWmla?=
 =?utf-8?B?by9lbmVUUUtleHB3RHJ4Zjh3cXN6NVFhalkxR2hCaHhZUkE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:54:00.9919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65a8666-2cd7-46b7-b23b-08dcfcd82306
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2556
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

Am 04.11.24 um 11:41 schrieb Christoph Stoidner:
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

<snip>

> --- a/board/phytec/phycore_imx93/phycore-imx93.c
> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>    * Author: Christoph Stoidner <c.stoidner@phytec.de>
>    * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>    */
>   
>   #include <asm/arch-imx9/ccm_regs.h>
> @@ -12,11 +13,21 @@
>   #include <asm/global_data.h>
>   #include <asm/mach-imx/boot_mode.h>
>   #include <env.h>
> +#include <fdt_support.h>
> +
> +#include "../common/imx93_som_detection.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +#define EEPROM_ADDR            0x50
> +
>   int board_init(void)
>   {
> +	int ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
> +
> +	if (ret)
> +		printf("%s: EEPROM data init failed\n", __func__);
> +
>   	return 0;
>   }
>   
> @@ -40,3 +51,44 @@ int board_late_init(void)
>   
>   	return 0;
>   }
> +
> +static void emmc_fixup(void *blob, struct phytec_eeprom_data *data)
> +{
> +	u8 option = phytec_imx93_get_opt(data, PHYTEC_IMX93_OPT_FEAT);

I am thinking about future SoMs using similar variants.



> +	int offset;
> +
> +	if (option == PHYTEC_EEPROM_INVAL)
> +		goto err;
> +
> +	/* Check "IO Voltage 1v8" flag is set */
> +	if (option & 0x01) {
If you abstract away the option details into an own function, e.g. 
phytec_get_imx93_io_volt(), you could reduce the amount of code in your 
board files. Also, if SoMs change the option layouts for a specific 
detail (for whatever reason), you would have an abstraction layer to 
details with it.


> +		offset = fdt_node_offset_by_compat_reg(blob, "fsl,imx93-usdhc",
> +						       0x42850000);
> +		if (offset)
> +			fdt_delprop(blob, offset, "no-1-8-v");
> +		else
> +			goto err;
> +	}
> +
> +	return;
> +err:
> +	printf("Could not detect eMMC VDD-IO. Fall back to default.\n");
> +}
> +
> +int board_fix_fdt(void *blob)
> +{
> +	struct phytec_eeprom_data data;
> +
> +	phytec_eeprom_data_setup(&data, 2, EEPROM_ADDR);
> +
> +	emmc_fixup(blob, &data);
> +
> +	return 0;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	emmc_fixup(blob, NULL);
> +
> +	return 0;
> +}
> diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
> index 17a8736c73..cf9c94eb45 100644
> --- a/board/phytec/phycore_imx93/spl.c
> +++ b/board/phytec/phycore_imx93/spl.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>    * Author: Christoph Stoidner <c.stoidner@phytec.de>
>    * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>    */
>   
>   #include <asm/arch/clock.h>
> @@ -20,6 +21,8 @@
>   #include <power/pca9450.h>
>   #include <spl.h>
>   
> +#include "../common/imx93_som_detection.h"
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   /*
> @@ -27,6 +30,13 @@ DECLARE_GLOBAL_DATA_PTR;
>    * when pca9451a support is added.
>    */
>   #define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
> +#define EEPROM_ADDR            0x50
> +
> +/*
> + * Prototypes of automatically generated ram config file
> + */
> +void set_dram_timings_2gb_lpddr4x(void);
> +void set_dram_timings_1gb_lpddr4x_900mhz(void);
>   
>   int spl_board_boot_device(enum boot_device boot_dev_spl)
>   {
> @@ -44,8 +54,56 @@ void spl_board_init(void)
>   	puts("Normal Boot\n");
>   }
>   
> +enum phytec_imx93_ddr_eeprom_code {
> +	INVALID = PHYTEC_EEPROM_INVAL,
> +	PHYTEC_IMX93_LPDDR4X_512MB = 0,
> +	PHYTEC_IMX93_LPDDR4X_1GB = 1,
> +	PHYTEC_IMX93_LPDDR4X_2GB = 2,
> +	PHYTEC_IMX93_LPDDR4_512MB = 3,
> +	PHYTEC_IMX93_LPDDR4_1GB = 4,
> +	PHYTEC_IMX93_LPDDR4_2GB = 5,
> +};
^ IMO this belongs into imx93_som_detection.h file

Regards,
Wadim
> +
>   void spl_dram_init(void)
>   {
> +	int ret;
> +	enum phytec_imx93_ddr_eeprom_code ddr_opt = INVALID;
> +
> +	/* NOTE: In SPL lpi2c3 is mapped to bus 0 */
> +	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
> +	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
> +		goto out;
> +
> +	ret = phytec_imx93_detect(NULL);
> +	if (!ret)
> +		phytec_print_som_info(NULL);
> +
> +	if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX)) {
> +		if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_1GB))
> +			ddr_opt = PHYTEC_IMX93_LPDDR4X_1GB;
> +		else if (IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_LPDDR4X_2GB))
> +			ddr_opt = PHYTEC_IMX93_LPDDR4X_2GB;
> +	} else {
> +		ddr_opt = phytec_imx93_get_opt(NULL, PHYTEC_IMX93_OPT_DDR);
> +	}
> +
> +	switch (ddr_opt) {
> +	case PHYTEC_IMX93_LPDDR4X_1GB:
> +		if (is_voltage_mode(VOLT_LOW_DRIVE))
> +			set_dram_timings_1gb_lpddr4x_900mhz();
> +		break;
> +	case PHYTEC_IMX93_LPDDR4X_2GB:
> +		set_dram_timings_2gb_lpddr4x();
> +		break;
> +	default:
> +		goto out;
> +	}
> +	ddr_init(&dram_timing);
> +	return;
> +out:
> +	puts("Could not detect correct RAM type and size. Fall back to default.\n");
> +	if (is_voltage_mode(VOLT_LOW_DRIVE))
> +		set_dram_timings_1gb_lpddr4x_900mhz();
>   	ddr_init(&dram_timing);
>   }
>   

