Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11035CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1B5846DD;
	Wed, 20 May 2026 18:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="G3wUG6Nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E7B846F9; Wed, 20 May 2026 18:12:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C0C8464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHIZISkL+WOQpDqgHzlsMP4zXwsei+lREjupjXgt8baJnA4MaKEyQNCZcJUSizoktgpJ3u3MbaCpzlJVKou9eCBgX+UbhZeIV5aQLnISTNqnBsxfUitE4+UJyuMA2A4Xj9G4dRVt0Fsl56pWZWJMXOG/oU718ZjyOrazHjyrSBwqz7NZAnaeKwRTOi1AahYI4LYib/pySW5pF7qLL8Oh0tTF0pVzqVaUlhc265jZE0T1iEnqTrmXk+R9cqQtmf63fEi2xfJ9OBwDzgQJVNxB5TWYY7wwQpkPuNQtdvrsY1mIugHsZwTdEsWnbkLCJDOcboZ7/yjYMs9HrN9H6RVFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7isMdAfGwiqfjDTwmLXG/pVqWGCof8IdrSoU8JtP9NM=;
 b=rJC6O3w1vZ9zps/xWAQJwhiI7Z/8HqYdYDRwKBNVbZD+stuDsNYzyny1ngToYr12uc3rwJfwuknUfttjaf8k9qg9fhjP7BzW0uG2/iCOapxpPKklq4xPQZHwRaoDhok3x2BGyScYd4q/hYqPO5spKtTEceUkS3rJxW2XbiJ1/YY1VqC5dI+hs/AOLnaADtw+M8bbngFN3hKo8Whv0z91ysmcxK3vDV2GlDRomsBp7TxoJE1fw0c0LduzOiEWubT4kiTXIwI1HcBKg66UdALZeoqiGjxKiWWLc2rALJVNYeScI/9qsATn5hmmY6xllBvB+Qbk20y3ODPfBQ6Qsq4B2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7isMdAfGwiqfjDTwmLXG/pVqWGCof8IdrSoU8JtP9NM=;
 b=G3wUG6NuWrW4zTXsqgJ+1zEn28RTPGIwF8v5eac567TzN9SM2TUBKaWwiEfA7DfgvVC6rEofgkrJWqzJa4PU8qGr17up7hcykoSKz2XyiWSYrl0TioBfMJBMbdwf++CgUPet9rcifXsthwlnaHUGz27Pulb4r8o5+KRqATGXS7DoN16zoTKErG88WRcfNG+q+cET1thZ+QyWKTqsHScMVynJEfYept6U6Nf0REPeh3rTkNYr5AMRRXJWgb9W7V3YoCa8Bak+wZxmU9RuAei2YZW2iRDgRjSL75pipCXwFVzeY94iibw83vydV5PIri+5d23r0yGE45CxTVEwpEa9EQ==
Received: from DU6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::6) by
 AS2PR10MB6664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:12:01 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::e2) by DU6P191CA0034.outlook.office365.com
 (2603:10a6:10:53f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 16:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 16:12:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:15:54 +0200
Received: from [10.252.1.215] (10.252.1.215) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:12:00 +0200
Message-ID: <34a3ddd1-aa5c-4544-a202-c1a09eed7331@foss.st.com>
Date: Wed, 20 May 2026 18:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] configs: stm32mp13: activate watchdog
To: Marek Vasut <marek.vasut@mailbox.org>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-3-yann.gautier@foss.st.com>
 <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
 <1aec25d4-3135-433d-8fcd-4ead7a065d40@foss.st.com>
 <9b59c08a-ea36-44b3-9c30-d1bd555f661e@foss.st.com>
 <0d3b1038-f90e-44e5-9b1e-bf9035f32784@mailbox.org>
Content-Language: en-US, fr
From: Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <0d3b1038-f90e-44e5-9b1e-bf9035f32784@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.1.215]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AS2PR10MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: b11d6772-2427-4ccf-87e3-08deb68a8680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: d0Xxde9wdBbDQoOWYUmN/If3FOQTfU9sPRAwfp6KWC+NjRajJ3AsU7Iu+pbKuH9MUsQhoR0429PeZTY8LCK3M34GVjyfBMGk31b5FcW9P8E+iyVNLcA+sxOlspAASP6cwC2DDd7clV4/DDtEKdw/5x/6YHgZegsPXxWBK/OK3wAx+nRRRUgEqWAHLpzPQbd/OjNjlajwpEqrh0nyZX1wBkb6DkXi8N2zaozLtTKVc8zN7WpODFSd/BEM1hD+BYreuAcm6tJNJdE/DaQjc+eHhYHKYwHxyqavrQRW0E/FMDYfZj4dmbzxMefU1wM7VcJsj/lw00ZpmF32w85+YP5GjBXceZZvnvPijm79dcW7mrL/989shDoxbVUDin+vOqRG3Y/ekKrlUFjrTgoDABi7F7Qb2bDjoFV3x1OEXvDBwaD3KkLbAih4KhAx6XS3vZNud7psZdhWeXRGQQh4JGQntAMM0jJU7Nw4mkh3uM6IccFuQMETXPaxdWPwD4/2d7QI3lmVyAM1Rqfe4/H/IbMH+iiGuX59ED3SoSKNAeVQvYaTp8EVCm++H1QJkQtB99RHzO/GnuRIgPLJ2y0kh87Gm5qH9dumvAXLuccgHHQ8SEULtJNSKATwxzwfciGhVbmmUgTaAM3pR3YuiHb2gRexW5mEYnGlAAZBT2MOrVZLLs2cNt/y23ppYO2R+EePZYMWlSxXiaHYohYumy5aDoXPkV8H6PyaZO46kX8ZJAcGScc=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9fVbIot9/Yac28mUv5DrFpUnIlnMT37XmDHHgM0HfnF42PgdLjvGQF4NSldu2ghuvp6bEbi8UULTE1OJU+/bAVgNN7nUn+/zjDKPkvBoyc71W+MCS4BXywEAmAXYItV5NQCh/ELhyHZcFwfbMkukfP8Zr2uVLt9dH5EaTl7rDmGUvVbQY2lI4hIUjTYMQ17zrfpvy10x9spZh9NArqeSVEuiyiMskWwZqI4jxk88kTgL/8uKVU1fcuYYt8f63jIxMT+rRqQqXBVGpOllJVarf+pD+5DE8tgAQy/Nlsw/1k6K/r/KX+56dfVW/vZGA2uQaBtqlSWfCAhIjM9Wdc07EDXaTTHA1efixBextBH05AY/jKOxA+LeZv37wUADmQFcP6bndFF7iUbf5FcFa7CFW/toPuF81B70hMdxvkxCGI3UGwNp+WFopBOuPKtEZZLW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:12:01.0338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11d6772-2427-4ccf-87e3-08deb68a8680
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6664
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

On 5/20/26 14:25, Marek Vasut wrote:
> On 5/20/26 11:04 AM, Patrick DELAUNAY wrote:
>> Hi,
>>
>> On 5/20/26 09:05, Yann Gautier wrote:
>>> On 5/19/26 18:58, Marek Vasut wrote:
>>>> On 5/19/26 6:31 PM, Yann Gautier wrote:
>>>>> No watchdog was enabled for STM32MP13 platform. Add the required 
>>>>> flags to
>>>>> support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, 
>>>>> we use
>>>>> the Arm SMC watchdog. The required nodes were already present in Linux
>>>>> imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
>>>>>
>>>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - update commit message
>>>>>
>>>>>   configs/stm32mp13_defconfig | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>>>>> index 620a6da2efe3..cc41585097c7 100644
>>>>> --- a/configs/stm32mp13_defconfig
>>>>> +++ b/configs/stm32mp13_defconfig
>>>>> @@ -113,4 +113,7 @@ 
>>>>> CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>>>>>   CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>>>>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>>>>>   CONFIG_USB_GADGET_DWC2_OTG=y
>>>>> +CONFIG_WDT=y
>>>>> +CONFIG_WDT_STM32MP=y
>>>> Why is CONFIG_WDT_STM32MP enabled here , is this the ARM SMC 
>>>> watchdog driver ?
>>> This is aligned with stm32mp15 config, and no, this one is the STM32 
>>> IWDG driver.
>>> I'll check that with Patrick (who originally wrote the patch), as it 
>>> seems that this flag could be removed.
>>>
>>
>> I agree with Marek.
>>
>> Today CONFIG_WDT_STM32MP is not really needed as only arm_wdt is 
>> activated in STM32MP13 device tree for ST boards
> 
> Make sure you double-check the stm32mp13xx dhcor too.
> 
> If the WDT is supposed to be activated here, it has to be documented in 
> commit message too .
I've updated the commit message in v3:
https://patchwork.ozlabs.org/project/uboot/patch/20260520160715.175032-3-yann.gautier@foss.st.com/

For stm32mp13xx dhcor, the Linux DT need to be updated, as well as 
stm32mp13_dhcor_defconfig.


Best regards,
Yann
