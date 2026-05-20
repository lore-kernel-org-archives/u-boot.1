Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D65CCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 09:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956FC8460E;
	Wed, 20 May 2026 11:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="HcmnEkM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D88846AD; Wed, 20 May 2026 11:04:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA60844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 11:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyN2w91CDQz+9X/e7w2tdzlfPprpHiKttFgOE1Fzd+5BtDaaKevWlPjdc467kjx6FNkrYEMMM+rAIQSSm9w8ocdvDLcfQcHLOYZZPd/r55fzThCtV9CzXPTLj9/8ZoBhO681wTrlGcpV3G3nenvGK5aOqvPrlJM/BBJ/LWwjqMHa5znbcNc1hRTupcsD31D96N1YsbctRsrpMA2d2pggF6EXyMs+1B8gGB7XG6+FwMXQwj6N4jsrEywr5a8rQJvVbgFmJBOZND9aa+vcO1vQcgRXK3fL2E4TGYV8nEnGpeDtVra8nv4xMwkrbrBCnNYlI2zmal3IriCf9Z0+9ZWwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsZ3DFKJC7UXaHeO0WZWY63+eAglK7KS7fdOnEkPyPY=;
 b=HFc6k2L4kI0m/D71u4GrdJz4eQidbt/XWf5XpBka4jQjK2YUBuf3IKIGR281hl1Ie7GB+GwVk8JfoKa0914PzfqAJduXtls4wFN5pu40HjdezxoVADm/DKB/utkjssuPPIx7SIj/vr44cSa0kMPeR3sN+iSnP6dhVCiHByLodu7HipVZ0QXaIb/WVju5hAW5m6F9lL4GMIqN30hG0CxvP763KIk4V4OFHEooqzVZ6TaP23jjCRlygSwY1QFo/cC4Gn4cCobiSXZNg+BcOXZcSJZT9opMK6QIDjpsTHCwDFToVcQkS/SMKy4lN9q8uGFmu5XLj73P0UUr6o4msk138A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsZ3DFKJC7UXaHeO0WZWY63+eAglK7KS7fdOnEkPyPY=;
 b=HcmnEkM7v8SI4r0cXFbNFrOHCIoZqpOb0FBVq5qxK1RM70LT4Xr7rL/XyMO0RDtH6+Y33s8gzzatzYsnkKaXcJEj2dsu94xl3lMnHdfCpsuL6a+VkDKiwqr3A5huJSGcWES2TRz3AzfHsvyjF1WtkFfoNUW+LHPOzkNw8IstuYSluCjEUtwzcDumegZyUvWhLtznZOA1515NmEPYHbn6OKGk+ZYHQe95MqsZYc4jfpts0LGob2V6OsB9CjpDuJxxv9Z5pWlhKJXQPqxDU1sy9f9Y5xPcdoPGASmouShYUGik8canoMkT/UZBcAO25W49YmlDOlfcw0HBArwktaAH3g==
Received: from AM8P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::24)
 by AS2PR10MB7396.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:603::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:04:08 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:219::4) by AM8P190CA0019.outlook.office365.com
 (2603:10a6:20b:219::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 09:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 09:04:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 11:08:01 +0200
Received: from [10.48.87.227] (10.48.87.227) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 11:04:06 +0200
Message-ID: <9b59c08a-ea36-44b3-9c30-d1bd555f661e@foss.st.com>
Date: Wed, 20 May 2026 11:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] configs: stm32mp13: activate watchdog
To: Yann Gautier <yann.gautier@foss.st.com>, Marek Vasut
 <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-3-yann.gautier@foss.st.com>
 <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
 <1aec25d4-3135-433d-8fcd-4ead7a065d40@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <1aec25d4-3135-433d-8fcd-4ead7a065d40@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.227]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|AS2PR10MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 19245b81-6505-4e77-8815-08deb64ebfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: SbUYZjJcPSpydh8o3OOEfv3j/FRLf0AZOleuHVVvOjzvjWV/OQ4xN4jONZ/Xu4pqkhzXN/CuZUPYjKFJphkoVXHpvYY0YyvYLQaWClNO0uZlOhV7h2KDPV1A+9LLqH8vB0gAzReKEeSDafBdIKt+3q3M3bUKixJImA/Et9r7Hdl4nYDANs4DS2Qy+b9VQCSQ2rTX5vSIci5NfC9SgOpM2l+xq7JC6/OsueHOEHgF5UXFlcAGHKfMaQt97CpxFWiunZUEWTiUCvVw6AKFT0L/qTOjrHZlWuRyZsHM+jMNqxNT7B+RUKXCV/Y7xwK6o5M5mP74QxAFHSoBUIDNYGYCZ9WSH9y718BP4yXIzs2B7NFcE5z8KOMxAcCWho1VktQWohjXh8iR/41+982J6dYaLZd0Df/wgoi5AaqEuq1b7CG2TI+Mv7PV1BOmvAzJygL4kQPczeHAHyRpMIwdVm1MXARhU2op+YkehhpewKQiOIhZOnXG0QgW02ZTHuDrrS6cimXWUNxVZQOADWgTPth3e5lLVWXj1bO17Pmb9+EOI2I2D9IXkaQJLCKyj2mIFfKLxa60H4oJnWuR6jdgB398cEfu8jU+T/6VDlmYcrOZ4fIxHnFLXa6vNHkEXsOmtfFLgbBjIdy4Pm1FZeFigqyVB8jvC0P4ZlMuWn0Nfbxdoj+LJEVUdlaH57fd8VA9/dVyONArBS+6LNnT4ruW0V36p0du5XG+XpZhXH4qwDooHfQ=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UhL9WfcNDSJwKvC28Sm0pU7M2jPWiUocljqrf4YngVxoZCamPW0deDESPY4aKhk6JPxTeMu1SLtRAy0xVKoVCfTK3609FpIpDvjHsKzLspI15StonxOUKqREw2sxOaDM8adit0vga/IBo0pzH730AMvVWgloT/OCbGfONcUEXkzAFfdwDSIs3MciSmhHPs49JwJRHBIV7GCFuSprz7gZNB55czsJJZz4PWDX20PWmAt52qY8U+WnJiD8Wt6Ndew2wmUT1/dkjIOt16MZiixCUdKpQIDEe9qnOHfX4fwRKSoLaVpGvnalSBLtmo+yuJWaDOelDdUCrNdhqn1Svceuj3/ddsC4B7U4fknIhvvyrz0EDTVp7/ZdOXcwW4s+Gqaz3/fh05cqCh4TEsRcax9er9nvrCcq+m8dCDDbBhXcm7Lc7sYYjPRSVbulqx9kTciv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:04:07.5102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19245b81-6505-4e77-8815-08deb64ebfdf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7396
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

On 5/20/26 09:05, Yann Gautier wrote:
> On 5/19/26 18:58, Marek Vasut wrote:
>> On 5/19/26 6:31 PM, Yann Gautier wrote:
>>> No watchdog was enabled for STM32MP13 platform. Add the required 
>>> flags to
>>> support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, we 
>>> use
>>> the Arm SMC watchdog. The required nodes were already present in Linux
>>> imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - update commit message
>>>
>>>   configs/stm32mp13_defconfig | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>>> index 620a6da2efe3..cc41585097c7 100644
>>> --- a/configs/stm32mp13_defconfig
>>> +++ b/configs/stm32mp13_defconfig
>>> @@ -113,4 +113,7 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>>>   CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>>>   CONFIG_USB_GADGET_DWC2_OTG=y
>>> +CONFIG_WDT=y
>>> +CONFIG_WDT_STM32MP=y
>> Why is CONFIG_WDT_STM32MP enabled here , is this the ARM SMC watchdog 
>> driver ?
> This is aligned with stm32mp15 config, and no, this one is the STM32 
> IWDG driver.
> I'll check that with Patrick (who originally wrote the patch), as it 
> seems that this flag could be removed.
>

I agree with Marek.

Today CONFIG_WDT_STM32MP is not really needed as only arm_wdt is 
activated in STM32MP13 device tree for ST boards

with secure watchdog managed in OP-TEE = iwdg1.

in fact, I activated this driver in U-Boot for STM32MP15 alignment

and because the watchdog topology wasn't not yet clear for STM32 boards;

it was perhaps planed to manage 2 watchdogs:

  * iwdg1 => secure watchdog managed by OP-TEE
  * iwdg2 => non secure watchdog managed by U-Boot/Linux


But finally we activate only one watchdog in secure world, exported with 
ARM SMC to non-secure world.

So this flag can be dropped (to avoid to have a unused driver) in all 
STM32MP defconfig files

except for "stm32mp15_basic_defconfig" (i.e. when OP-TEE is not used for 
ST boards).


> Best regards,
> Yann


Regards

Patrick

