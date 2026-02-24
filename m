Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB9EE9B262
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1D383DEA;
	Tue, 24 Feb 2026 13:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="akZR9ClN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A3583C8C; Tue, 24 Feb 2026 13:57:42 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A3683C8C
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riPBWV0np5vurPz6NAABxYsomEk6PZ+9l0U73FS1KxRnZzMrDLegeUYXyumeMEMA9Q7jxS2I+R/99aDHs0CRqoYXzC9Vn6uwb9yBIfZhONqcGyT3rwDgHDAj0vZLFKghTK2i6X+RinfrvnbfyO/H9TiLM9D51R4leZ+MloKjTLWJjAl/MdJCSTqj4zZgAwkPZq6dqkbZaDy8E8dvs6tJ55h8K3+QXytr9UAB1L7v/e5cLN44VAupYxOyRAIdEipiRVMCz7VlwS601OAS0j6ZvAEaVNS1XBkR20gV5SWVuwE6mjqeHDzmn9a7HYaBq6yh1NL2R5kzqEyZ+JSuogoAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KA/7zEb08tUp4HSgpioibmZTXS6uwcOLtinDgNvG3o=;
 b=LrfcCGsIQ/cmF/0X/Nk0fnwfIgnEAOn2w0Ppbo8kUDLOD3BULkai5JEiCEN6l9MCqy0tVNCenio63Gg7fLi4u+bKsH84FjRzPiVAmaofYgfJFa6xbJeXIugwUSbVZQSIu/FeW26DOX3hUZFKyFT5avom40JQNhbWAPllxYv/YHz0MB1LLaWnplTSn4x14zYJhQ7TH71JuSunAx23ACS0RRwasMm3KIrScA/xBUUtfDJOX8WlfNwQbzP9SInB/aY4rMoADY36Ra6rVkN7G/XPPhGYK3Iy10mJevVmUSuqP35nTe6O5+HvBLXHrpXvcYNBfmMZKJgTqeMvrWrxBqUi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KA/7zEb08tUp4HSgpioibmZTXS6uwcOLtinDgNvG3o=;
 b=akZR9ClN/J60GducUezqMoJQuVBe93po0hno42gg1ogrL9MKo6+dMD9dXYn0358F/9HGY2/ggvXiuAu/M/Sf5BL42h/YLmRUavMukg5b2V0MYTi69pf/V+EEBwkfeevv5C8YBjU6DV8GgKbSBHcGmzNmI4ZBeL+LMdjFOJOuNWQ9H5bXL2gJ+hIv0KLBpd0YawQM+bq/gWDCM8X8E0VHwWwR+vEV2xAIGpYbzr195uv4oiIQvcFcL6DvftLDVX94VjbpYbCjIcCg4Da0gJNz3FdGHUWzJbDApMETR3TEUxyjFsu3JMoVMaMY2pnoVO+VuMXJ46jo94ilAZN2DWpjxQ==
Received: from AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33)
 by AM9PR10MB4120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 12:57:35 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::7e) by AM0P190CA0023.outlook.office365.com
 (2603:10a6:208:190::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 12:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:57:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 13:59:42 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 13:57:34 +0100
Message-ID: <aab98d21-2a9c-4847-ac78-5527469231a2@foss.st.com>
Date: Tue, 24 Feb 2026 13:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: pinctrl_stm32: support IO synchronization
 parameters
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, "Antonio
 Borneo" <antonio.borneo@foss.st.com>
CC: Tom Rini <trini@konsulko.com>, Fabien Dessenne
 <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
References: <20260205-upstream_pinctrl_stm32_update-v1-0-3a3797af498d@foss.st.com>
 <20260205-upstream_pinctrl_stm32_update-v1-3-3a3797af498d@foss.st.com>
 <763fbda1-5372-449f-822b-b53625be5162@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <763fbda1-5372-449f-822b-b53625be5162@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|AM9PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: c885d79e-9e94-45e6-70d7-08de73a44837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmN2VGx4VndicVRGdEdWRFhBbzBGNEl0ZFZoZllJS25MTkFxaXVHSzhVaHZi?=
 =?utf-8?B?Rmp4UVZrUVpLdE5BS2NQelJwU3hNaDFpUlgvUGt1MXRJV0VaNWFjWFFGTEJz?=
 =?utf-8?B?UDY4OHJMR09vTHFZcXlkRHlDd2JobnhEeTZXZk5HUk1ZODI1Vk5MaExYZHVw?=
 =?utf-8?B?Y0NkVllqQ0RDaWNSTGMzNkpNWEFGTy9uSlJUZGU0MFgwcTMxYnV3eFlaK0FG?=
 =?utf-8?B?dzMzZnBVWnNRSVk2QThVT2dZR3M4WkdJeFQzYkZnSCtBRW9mSEZxUFhhNFND?=
 =?utf-8?B?ajNjUmVUWFRjY2p3Q3BlN1dsd1hKRTJSNXZySWNzdXBqSG13QlMzUzFvdVcy?=
 =?utf-8?B?MjE3Zjlsai9VekpISUFwVzhpN2ZyS0drcEY0RWJnalVQck5BZEk0MVFzcXpD?=
 =?utf-8?B?bmhzeEN0MU1jczZQcS9PaHlvRXhhMGY3WStTVEVydDZsbzFzTWY2dk9teUY3?=
 =?utf-8?B?TURzc1pDVjByUWhuSmVrbksxT1R3RDNERWJROVRpclZ5alZyeW9JVGFaTzJ3?=
 =?utf-8?B?QlNJWDZ4b3VNVTJFcmswMUc1VkttQVUxVGloRDNuQmNleVFsb1dXVXVuMStC?=
 =?utf-8?B?bSs3bnk2NmwxL3JFdnRUdnRpMU9qUkw4NW5lZTZPSEJQMXphbVJOZlBzQVJ0?=
 =?utf-8?B?UmlkZnBkaVNhOHUyZ0FIa0JxMTRBcTM2K1h3cTdtaEx6dFhmMG5NRFBlMlBX?=
 =?utf-8?B?RFhnNjlqR0I0QktEYWdYalV6Ym9mSTJBRHZDY2paejJqcC9WbGFIRWlnR3o5?=
 =?utf-8?B?WHJ2N0tBRUpqS0xsaW9WMlBmaWxLckhqMEJXTlVHeldHRGJNbkIySy8xT3Vp?=
 =?utf-8?B?c3hhV2lKTzU4OWV4VnlPbjM3U2RKWUFDdzE1Y2lvV3JQbzRkUk1BY3B4aGh1?=
 =?utf-8?B?QUl3MXhDRDhJQ0lIczRML3pwZWllV2xoZzlPNzUrWWhSNDJtUWJtazB2SWhm?=
 =?utf-8?B?RVAzd0hEMmFpNnQ4c29OYmFxcFVSRGpyL1hDN1lLalUyZFByL2J2bWp1UE5E?=
 =?utf-8?B?bGVqbVJweHJwcnlJK21uSkRyUStvcU1KTXhFT1NwTnhWbEFUM1FuaFg0Ymhp?=
 =?utf-8?B?YlJGQnNZaHZhYTNxVnFZUXJvUjliZmRON2VNTEIrZHNNNWx6SytJcllXbDZx?=
 =?utf-8?B?UjJZTUQzazdwSkJEUFRFVlNZSHlUbFV2bmpKL29KVGZtUXpUbm54QzZWUDFW?=
 =?utf-8?B?ejZ1dzI1SmJmbW03dERSelFRVFM2RWV1U1k5SUdKUWxpWXg5aDFUeTU1Z0NG?=
 =?utf-8?B?ZzNMN3V2eGFRMG1DWWFZWGlrSlQxaU5CbUp5SG1LZmhiMTJhcm5WLzc4Qytp?=
 =?utf-8?B?N25KYUszMVFEbHJSWGY4OWd6K0N3d01jNDBqdnlVVUgwcVRSWUxXQUd6R2NX?=
 =?utf-8?B?THhMYzNpRlhnclVQM244QkJQOGZVaXA1Ym1rV25SRHFUQ0dMRXkwT0lVRkNL?=
 =?utf-8?B?Qm1YanFhZlN0bklVSHRNK2lhZFpHS2xlZ29YazVJWkthMDVCYmY3VzFGZG1J?=
 =?utf-8?B?Z1VFY29OOGJUZW9Mc2ZFYjZ2NmlxK0tpcFFBSHBRZERwbVhvcFVlV2RmYUJ6?=
 =?utf-8?B?YjZ0MUZvN2lzY0xXNXlLdmo4dUduRWFIZnpPdFd4dmVibVlOMTc1S1R6NllO?=
 =?utf-8?B?NEFFRTFhbytuRlFLcXV6Wi9MaUp4eDh1MDB1c2VBVFZtZUZSci93d0xvM2pr?=
 =?utf-8?B?aWFQcVRnYmRzeExnajEvQWxvZlN4UWZ2SHluKzBJUHVXMnhoQ2ZGRlR3M0RX?=
 =?utf-8?B?d0wrNG9xbmR0cXVsOXRLWVRtcTQwMm9RNUJWWE0rYkY1TWNuSUJzQmlrSitv?=
 =?utf-8?B?aXFlL0FpckszTE13NHVLL2pKSVhmUDR6NW03eDVTRFFnK29tOE5sVGdEcUll?=
 =?utf-8?B?N1FJUmlFMityajExVGJkMHNuWHhpRnlIQzQzOE1JbmZGeEdjakpPZjVpUk1z?=
 =?utf-8?B?cTF2R0t3N241ekhnVGVxeU82YTNVZkFxbkVObFBmRllEZjJUcUlJakptN3Zr?=
 =?utf-8?B?UDBlSXhDNGppZFFNZ2R4ZW1JbHVJSkRhdDZIWS84dDlOY3V4TjZGbFdoSHZM?=
 =?utf-8?B?MjYyWlZmM09RNWZyb296VmFnRDZmNmUzV1JVOFE5U1VScGdoM2VET1JpZ2VP?=
 =?utf-8?B?VUFwWjJpdGY3MmFwYjNQbUtOZjJVeEZINi9jQlRRenJ3U0tvSEh6QVoxenVt?=
 =?utf-8?B?S0hrNVBMOE1OeHhoOXF0ODJxTWRLdkpyY0lpUkwwa3VvYzZiaUhka2pkWDE4?=
 =?utf-8?B?ZnAwWGpQN21tYVUrby95Rko4czJRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kWHaTNvsH6Vk4PRKkId21OjEMZdFsy50ZJUektE33BSNPxn1QPuu9ScjAWExHfndJ9H2ol0BCO/XJTHLtznn+sRf/tSwAVVa+iiGvkSofnKED1A5FVdusifuwSdBuLzQue/P/AVlH7xCmGUn3/p19S5U2gSmyhF0hvKk8T5jWKc128OGa+gaxr4RSjH6yiuLd1JrdU6wQcInsgz/Rj7vT70vzUhBc/E2l0oVXXVjV8NPdpGpbSerd/IPuqhthE/HOmpOLwPglEFhMc664mDbUqj+zCfn6KVwYM7Z27ueFjI2hyinEDyFxVvtL3nhUAzuzRsrjyosIZnPtpWL6DreTKzndpp5YIYNLxPITxGpPXjgpBeHr3T7wpi+8VkMiOaorQAOVOsGR/XNAw/yrzbv7Wagy6rPok12cKMPgpfMwYQFepJuXd3xXmmjNUCcwtm0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:57:35.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c885d79e-9e94-45e6-70d7-08de73a44837
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4120
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



On 2/24/26 10:44, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/5/26 09:07, Patrice Chotard wrote:
>> From: Fabien Dessenne <fabien.dessenne@foss.st.com>
>>
>> Support the following IO synchronization parameters:
>> - Delay (in ns)
>> - Delay path (input / output)
>> - Clock edge (single / double edge)
>> - Clock inversion
>> - Retiming
>> These settings allow a fine tuning of the high speed interface signals.
>>
>> Enable this feature for the stm32mp257 SOC.
>>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   drivers/gpio/stm32_gpio_priv.h  | 58 +++++++++++++++++++++++++++---
>>   drivers/pinctrl/pinctrl_stm32.c | 80 +++++++++++++++++++++++++++++++++--------
>>   2 files changed, 119 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpio/stm32_gpio_priv.h b/drivers/gpio/stm32_gpio_priv.h
>> index d89e9b8ed60..69868787af0 100644
>> --- a/drivers/gpio/stm32_gpio_priv.h
>> +++ b/drivers/gpio/stm32_gpio_priv.h
>> @@ -51,7 +51,45 @@ enum stm32_gpio_af {
>>       STM32_GPIO_AF15
>>   };
>>   +enum stm32_gpio_delay_path {
>> +    STM32_GPIO_DELAY_PATH_OUT = 0,
>> +    STM32_GPIO_DELAY_PATH_IN
>> +};
>> +
>> +enum stm32_gpio_clk_edge {
>> +    STM32_GPIO_CLK_EDGE_SINGLE = 0,
>> +    STM32_GPIO_CLK_EDGE_DOUBLE
>> +};
>> +
>> +enum stm32_gpio_clk_type {
>> +    STM32_GPIO_CLK_TYPE_NOT_INVERT = 0,
>> +    STM32_GPIO_CLK_TYPE_INVERT
>> +};
>> +
>> +enum stm32_gpio_retime {
>> +    STM32_GPIO_RETIME_DISABLED = 0,
>> +    STM32_GPIO_RETIME_ENABLED
>> +};
>> +
>> +enum stm32_gpio_delay {
>> +    STM32_GPIO_DELAY_NONE = 0,
>> +    STM32_GPIO_DELAY_0_3,
>> +    STM32_GPIO_DELAY_0_5,
>> +    STM32_GPIO_DELAY_0_75,
>> +    STM32_GPIO_DELAY_1_0,
>> +    STM32_GPIO_DELAY_1_25,
>> +    STM32_GPIO_DELAY_1_5,
>> +    STM32_GPIO_DELAY_1_75,
>> +    STM32_GPIO_DELAY_2_0,
>> +    STM32_GPIO_DELAY_2_25,
>> +    STM32_GPIO_DELAY_2_5,
>> +    STM32_GPIO_DELAY_2_75,
>> +    STM32_GPIO_DELAY_3_0,
>> +    STM32_GPIO_DELAY_3_25
>> +};
>> +
>>   #define STM32_GPIO_FLAG_SEC_CTRL    BIT(0)
>> +#define STM32_GPIO_FLAG_IO_SYNC_CTRL    BIT(1)
>>     struct stm32_gpio_dsc {
>>       u8    port;
>> @@ -59,11 +97,16 @@ struct stm32_gpio_dsc {
>>   };
>>     struct stm32_gpio_ctl {
>> -    enum stm32_gpio_mode    mode;
>> -    enum stm32_gpio_otype    otype;
>> -    enum stm32_gpio_speed    speed;
>> -    enum stm32_gpio_pupd    pupd;
>> -    enum stm32_gpio_af    af;
>> +    enum stm32_gpio_mode        mode;
>> +    enum stm32_gpio_otype        otype;
>> +    enum stm32_gpio_speed        speed;
>> +    enum stm32_gpio_pupd        pupd;
>> +    enum stm32_gpio_af        af;
>> +    enum stm32_gpio_delay_path    delay_path;
>> +    enum stm32_gpio_clk_edge    clk_edge;
>> +    enum stm32_gpio_clk_type    clk_type;
>> +    enum stm32_gpio_retime        retime;
>> +    enum stm32_gpio_delay        delay;
>>   };
>>     struct stm32_gpio_regs {
>> @@ -79,6 +122,11 @@ struct stm32_gpio_regs {
>>       u32 brr;    /* GPIO port bit reset */
>>       u32 rfu;    /* Reserved */
>>       u32 seccfgr;    /* GPIO secure configuration */
>> +    u32 rfu2;    /* Reserved (privcfgr) */
>> +    u32 rfu3;    /* Reserved (rcfglock) */
>> +    u32 rfu4;    /* Reserved */
>> +    u32 delayr[2];    /* GPIO port delay */
>> +    u32 advcfgr[2];    /* GPIO port PIO control */
>>   };
>>     struct stm32_gpio_priv {
>> diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
>> index 1758f9a909c..7d5a0471a65 100644
>> --- a/drivers/pinctrl/pinctrl_stm32.c
>> +++ b/drivers/pinctrl/pinctrl_stm32.c
>> @@ -29,6 +29,12 @@
>>   #define OTYPE_MSK            1
>>   #define AFR_MASK            0xF
>>   #define SECCFG_MSK            1
>> +#define ADVCFGR_MASK            0xF
>> +#define DELAYR_MASK            0xF
>> +#define ADVCFGR_DLYPATH_POS        0
>> +#define ADVCFGR_DE_POS            1
>> +#define ADVCFGR_INVCLK_POS        2
>> +#define ADVCFGR_RET_POS            3
>>     struct stm32_pinctrl_priv {
>>       struct hwspinlock hws;
>> @@ -43,6 +49,7 @@ struct stm32_gpio_bank {
>>     struct stm32_pinctrl_data {
>>       bool secure_control;
>> +    bool io_sync_control;
>>   };
>>     #ifndef CONFIG_XPL_BUILD
>> @@ -304,7 +311,7 @@ static int stm32_gpio_config(ofnode node,
>>       struct stm32_gpio_regs *regs = priv->regs;
>>       struct stm32_pinctrl_priv *ctrl_priv;
>>       int ret;
>> -    u32 index;
>> +    u32 index, io_sync, advcfg;
>>         /* Check access protection */
>>       ret = stm32_pinctrl_get_access(desc->dev, desc->offset);
>> @@ -318,6 +325,14 @@ static int stm32_gpio_config(ofnode node,
>>           ctl->pupd > 2 || ctl->speed > 3)
>>           return -EINVAL;
>>   +    io_sync = dev_get_driver_data(desc->dev) & STM32_GPIO_FLAG_IO_SYNC_CTRL;
>> +    if (io_sync && (ctl->delay_path > STM32_GPIO_DELAY_PATH_IN ||
>> +            ctl->clk_edge > STM32_GPIO_CLK_EDGE_DOUBLE ||
>> +            ctl->clk_type > STM32_GPIO_CLK_TYPE_INVERT ||
>> +            ctl->retime > STM32_GPIO_RETIME_ENABLED ||
>> +            ctl->delay > STM32_GPIO_DELAY_3_25))
>> +        return -EINVAL;
>> +
>>       ctrl_priv = dev_get_priv(dev_get_parent(desc->dev));
>>       ret = hwspinlock_lock_timeout(&ctrl_priv->hws, 10);
>>       if (ret == -ETIME) {
>> @@ -339,6 +354,20 @@ static int stm32_gpio_config(ofnode node,
>>       index = desc->offset;
>>       clrsetbits_le32(&regs->otyper, OTYPE_MSK << index, ctl->otype << index);
>>   +    if (io_sync) {
>> +        index = (desc->offset & 0x07) * 4;
>> +        advcfg = (ctl->delay_path << ADVCFGR_DLYPATH_POS) |
>> +             (ctl->clk_edge << ADVCFGR_DE_POS) |
>> +             (ctl->clk_type << ADVCFGR_INVCLK_POS) |
>> +             (ctl->retime << ADVCFGR_RET_POS);
>> +
>> +        clrsetbits_le32(&regs->advcfgr[desc->offset >> 3],
>> +                ADVCFGR_MASK << index, advcfg << index);
>> +
>> +        clrsetbits_le32(&regs->delayr[desc->offset >> 3],
>> +                DELAYR_MASK << index, ctl->delay << index);
>> +    }
>> +
>>       uc_priv->name[desc->offset] = strdup(ofnode_get_name(node));
>>         hwspinlock_unlock(&ctrl_priv->hws);
>> @@ -391,10 +420,24 @@ static int prep_gpio_ctl(struct stm32_gpio_ctl *gpio_ctl, u32 gpio_fn,
>>       else
>>           gpio_ctl->pupd = STM32_GPIO_PUPD_NO;
>>   +    gpio_ctl->delay_path = ofnode_read_u32_default(node, "st,io-delay-path", 0);
>> +    gpio_ctl->clk_edge = ofnode_read_u32_default(node, "st,io-clk-edge", 0);
>> +    gpio_ctl->clk_type = ofnode_read_u32_default(node, "st,io-clk-type", 0);
>> +    gpio_ctl->retime = ofnode_read_u32_default(node, "st,io-retime", 0);
>> +    gpio_ctl->delay = ofnode_read_u32_default(node, "st,io-delay", 0);
>> +
> 
> 
> The binding seens not aligned with latest proposal done for kernel
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=479156
> 
> 
> 'skew-delay-{in,out}put-ps'
> 
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251023132700.1199871-12-antonio.borneo@foss.st.com/
> 
> 
> I think, it is the old OpenSTLinux downstream binding


Hi Patrick

Good catch, you are right, i wasn't aware of bindings update on kernel's side uypstream vs downstrem.
I will drop this patch and resubmit an update later.

Thanks
Patrice

> 
> 
>>       log_debug("gpio fn= %d, slew-rate= %x, op type= %x, pull-upd is = %x\n",
>>             gpio_fn, gpio_ctl->speed, gpio_ctl->otype,
>>             gpio_ctl->pupd);
>>   +    if (gpio_ctl->retime || gpio_ctl->clk_type || gpio_ctl->clk_edge || gpio_ctl->delay_path ||
>> +        gpio_ctl->delay)
>> +        log_debug("    Retime:%d InvClk:%d DblEdge:%d DelayIn:%d\n",
>> +              gpio_ctl->retime, gpio_ctl->clk_type, gpio_ctl->clk_edge,
>> +              gpio_ctl->delay_path);
>> +    if (gpio_ctl->delay)
>> +        log_debug("    Delay: %d (%d ps)\n", gpio_ctl->delay, gpio_ctl->delay * 250);
>> +
>>       return 0;
>>   }
>>   @@ -466,7 +509,9 @@ static int stm32_pinctrl_bind(struct udevice *dev)
>>           return -EINVAL;
>>       }
>>       if (drv_data->secure_control)
>> -        gpio_data = STM32_GPIO_FLAG_SEC_CTRL;
>> +        gpio_data |= STM32_GPIO_FLAG_SEC_CTRL;
>> +    if (drv_data->io_sync_control)
>> +        gpio_data |= STM32_GPIO_FLAG_IO_SYNC_CTRL;
>>         dev_for_each_subnode(node, dev) {
>>           dev_dbg(dev, "bind %s\n", ofnode_get_name(node));
>> @@ -546,25 +591,32 @@ static struct pinctrl_ops stm32_pinctrl_ops = {
>>   #endif
>>   };
>>   -static const struct stm32_pinctrl_data stm32_pinctrl_no_sec = {
>> +static const struct stm32_pinctrl_data stm32_pinctrl_base = {
>>       .secure_control = false,
>> +    .io_sync_control = false,
>> +};
>> +
>> +static const struct stm32_pinctrl_data stm32_pinctrl_sec = {
>> +    .secure_control = true,
>> +    .io_sync_control = false,
>>   };
>>   -static const struct stm32_pinctrl_data stm32_pinctrl_with_sec = {
>> +static const struct stm32_pinctrl_data stm32_pinctrl_sec_iosync = {
>>       .secure_control = true,
>> +    .io_sync_control = true,
>>   };
>>     static const struct udevice_id stm32_pinctrl_ids[] = {
>> -    { .compatible = "st,stm32f429-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32f469-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32f746-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32f769-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32h743-pinctrl",    .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32mp157-pinctrl",   .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32mp157-z-pinctrl", .data = (ulong)&stm32_pinctrl_no_sec },
>> -    { .compatible = "st,stm32mp135-pinctrl",   .data = (ulong)&stm32_pinctrl_with_sec },
>> -    { .compatible = "st,stm32mp257-pinctrl",   .data = (ulong)&stm32_pinctrl_with_sec },
>> -    { .compatible = "st,stm32mp257-z-pinctrl", .data = (ulong)&stm32_pinctrl_with_sec },
>> +    { .compatible = "st,stm32f429-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32f469-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32f746-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32f769-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32h743-pinctrl",    .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32mp157-pinctrl",   .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32mp157-z-pinctrl", .data = (ulong)&stm32_pinctrl_base },
>> +    { .compatible = "st,stm32mp135-pinctrl",   .data = (ulong)&stm32_pinctrl_sec },
>> +    { .compatible = "st,stm32mp257-pinctrl",   .data = (ulong)&stm32_pinctrl_sec_iosync },
>> +    { .compatible = "st,stm32mp257-z-pinctrl", .data = (ulong)&stm32_pinctrl_sec_iosync },
>>       { }
>>   };
>>  
> Thanks
> 
> Patrick
> 

