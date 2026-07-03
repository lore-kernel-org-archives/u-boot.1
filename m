Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47E7C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A9F84A3A;
	Fri,  3 Jul 2026 14:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="omKi+Dm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD4084A4F; Fri,  3 Jul 2026 14:40:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FFF849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/IkftyB2Ji5CSsXyIpAYxwrSh7NnT70ioxMioB+4FyczUMnmqa3Qs7GOIEAEgmvt7BGfYWAF3Ueh7DeVIWLE8aKojUcPh3NYDfk959bJu33gQfeVtO/FsqotUDtt9B/EucTLS5Io1ufQmY3//h81PJpFucicT0vqBBCIVEC/37VT0gzpAMsp6dmBWQ1iresNL5r1uuJfXQxF8VhKjtTFt6+d8x/tONnCaaldEuFmBnWyrNxn0rYOQyISuUIypov6IMaBqylTsuwfXaCzefwA+qAgeiK5eCTHs3OpewcNYq0Q8QkjCpoK7KvT8VWbXTk/lcBxifxEP8EwBkPrOXdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re1kjTPoSrHbtXNW2bBD3ZZDgQ0Jk8c1Fx+O1R8tifk=;
 b=aHIWc+C8OvmzyaB/38c+S6UgfPz423J91IZzOawQlwAvZ5LgeMnzvCq891jBxpBe9hZ7+361HNgm/TsIu2fqDbPUIAMhCILDpbMx4IZpeLNtX9Rwm9+0xgexh0oZgW5U9lhb67kdCRvy3HGHT2xSPRzCnfxlooYfaURwZGnZWlMH9Wf+dJFFMHsFDkZ3qqInwKRTxs3qvvV08YIml9jU/kicHPdGAhFtBO+mi/Sz0GIGu2e+ZcFNYxqkrNQx+aASTK8OdJz5WbuJXa/LmkWGRnnPApk7gJlMN0TpzEQ4RIRZGR9JisahOOQkJb3nQX0GiGyW9PeTcue8g0s1jPU9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re1kjTPoSrHbtXNW2bBD3ZZDgQ0Jk8c1Fx+O1R8tifk=;
 b=omKi+Dm5wZ8Yf7E11nXa/vJh+nYhzb0WdnvrgTmNsYEbZ6Jqphh/9B+n9sFYoQepVaM4cAYgKY7Cp149VyQHQBzwIRRby9oH6iGtK/zpos7pS8FgUPnbEFSorw1fuDOgsWmXNOPvCbduAeLl7F3EfMoR7sS+3dmr26/QUQfrJrszRALfOm6xHxFT7NPgbkcK+0oFvSuv0BDFRqGbCYaagprLu0cY4WgcPhpkZm29lgzCZ7k820U13zPkLCu3RPb4P6VnvStLH6cG0chdM3LZzAqnfXuGDg8W7hzcGUwVHdZGj0q/n73auHK4JzQSR0Zo/SLLSbRLNX9cXkhxDszMRg==
Received: from AS4P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::19)
 by AM0PR10MB3666.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:40:50 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::1e) by AS4P190CA0029.outlook.office365.com
 (2603:10a6:20b:5d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 12:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 12:40:49 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 14:45:07 +0200
Received: from [10.252.26.28] (10.252.26.28) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 14:40:48 +0200
Message-ID: <2daeaf66-4cb9-4bc5-8632-6a64bccbc84e@foss.st.com>
Date: Fri, 3 Jul 2026 14:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: add U-Boot specific dtsi for
 stm32mp157f-dk2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <linux-amarula@amarulasolutions.com>,
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260529153159.3944049-1-dario.binacchi@amarulasolutions.com>
 <8aab07b8-9a23-4c0d-a2f9-3943f6490a60@foss.st.com>
 <CABGWkvoUa0AHPFmqD-AKfik8oMdBh=JD-1JUcb3cMFDovmdwmg@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CABGWkvoUa0AHPFmqD-AKfik8oMdBh=JD-1JUcb3cMFDovmdwmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|AM0PR10MB3666:EE_
X-MS-Office365-Filtering-Correlation-Id: 2577d38b-93d9-4a32-7bb9-08ded9005006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|13003099007|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sgx7FUt18XLOGfbvWd+KBK0lMHh/GkJdGT4AAM+v04i3VLjeFHpCi/h+C+6XvkMOffWAGXfsJCIrJSXWVBP3LMTAwlQ+N116VlwXG1I+Upjf978tFA4uDy378CEB36WQku9P/nAhbkPi69yAh5orIuhhvd04hSaJt8ukVae/jNrgaocVU9nsdjy+SV+jBDn/qg8r7UKIWfqXOUomEnJuCFQNxp8+Ow/jZQjbxDvXv8gGDlssxuBN4kfpTJMEuTsvhanV9z0R2Tm0YpTlIpuEinTBsDUnrCtHLsC1NbY3PmXw6z5FtHodRgbUIT6O9nFJ7tSoEPoFlvadGyAQlzyp0aPPUeNM1LFuOj1hV5y1GrNgJ8mNluvLkQMKSiZM8C+7CpTlwmDQLr13GNmCafR4CcosRe82+FKpeTmMPjcjHLXq+V4J3GzhXJFGeSouEfjsDGcpyE48v0pFQWxEif0o1/PHwJf0QAG7rUU7nTu6SW6koFsxvJVj0uNxm0D0EDe4Ki+R3YVUORvZKXwnKJMvx3d9wQVM12JnyFQxAaxDgSIYRdNrXTlq4xvRnWcDjEsJPwdr76qIjviaUTCAugfLm7v8n9TlcBwrBNBUULdJBVskd2r25gtQh1+8zR6k8vlkXuxwnWj0VyuzjPUo1+kWqhHtJ/hcRm6TUYOYoglbdwW3j3hwX9MdfMFwyydSZijEjoI/5f/mUb6SXYVVk1/HlQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(13003099007)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tBahtvwaEuKFvAykTZ7cmUZMeib9iR9Y1d6lJ95FgdKW6JwJmJ88DR3RLIJk2WBeKsDSl9/Oz6PXETEvka52bDuG3Vd9Ml1HFx/gXpxcaI7ERsI6aLU4piiq+ys5erM3QQrnulmpY1ABAB7M4bwGR4VVas+j8sHXeBWqeCES9H3JXwPWVloHe77V6gKRE5cmpwcK7MeLQ0/qzBuay44c4le5cT57rson3puGQYl1fvCwPznqVUwfIDp8R02i9l8ORDn1yAqr+RTqhZb9NlWDiiXdjHe11UH07+91xrY9ikONvvy62MEGJdUA27/rdDT2XGhkzxQYat8sco9kr11b4CmaWRee3yiihBmFVs6YRjnl6Md9COXgezQSNZsbBPob7ldzHKn7oMcwqMwFIVXvroQ9e2tjBmVBGypLEatoulDUTLMUOr0JHVWmXEaRIoSW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:40:49.8157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2577d38b-93d9-4a32-7bb9-08ded9005006
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3666
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



On 7/2/26 15:00, Dario Binacchi wrote:
> Hi Patrice
> 
> On Mon, Jun 29, 2026 at 9:29 AM Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>>
>>
>> On 5/29/26 17:31, Dario Binacchi wrote:
>>> The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
>>> As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
>>> STM32MP15 RevZ cut which is the only one available for new product now.
>>> The major differences in this 'F' variant SoC are the increased max
>>> frequency of the Cortex-A7 cores and the correction of some HW bugs
>>> (Device Rev.Z, see errata ES0438)".
>>>
>>> On the software/architecture side, this variant utilizes SCMI (System
>>> Control and Management Interface) for secure world resource management.
>>> As a consequence, the underlying stm32mp15-scmi.dtsi explicitly deletes
>>> several fixed clock nodes (such as clk_hse, clk_hsi, clk_lse, clk_lsi,
>>> and clk_csi), making it impossible to include stm32mp157c-dk2-u-boot.dtsi
>>> without triggering compilation errors due to these missing clock labels.
>>>
>>> So let's introduce a dedicated stm32mp157f-dk2-u-boot.dtsi that directly
>>> defines the fwu-mdata node. This provides the necessary FWU metadata
>>> configuration required to allow automatic A/B bank selection, supported
>>> for STM32MP15 boards by commit 560d8f32703f ("board: st: stm32mp15:
>>> support dynamic A/B bank bootup").
>>>
>>> [1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Drop the inclusion of stm32mp157c-dk2-u-boot.dtsi to avoid compilation
>>>   errors caused by deleted clock nodes in stm32mp15-scmi.dtsi.
>>> - Directly define the fwu-mdata node in stm32mp157f-dk2-u-boot.dtsi to
>>>   properly support automatic A/B bank selection.
>>>
>>>  arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>  create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>>>
>>> diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..77805417bfa9
>>> --- /dev/null
>>> +++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> + */
>>> +
>>> +/ {
>>> +     fwu-mdata {
>>> +             compatible = "u-boot,fwu-mdata-gpt";
>>> +             fwu-mdata-store = <&sdmmc1>;
>>> +     };
>>> +};
>>
>> Hi Dario
>>
>> What about including stm32mp157c-dk2-u-boot.dtsi instead of defining fwu-mdata node ?
> 
> This was actually the approach used in v1. However, as you pointed out in the
> v1 thread [1], it does not build because stm32mp15-scmi.dtsi removes the
> clk_hse, clk_hsi, clk_lse, clk_lsi and clk_csi labels referenced by
> stm32mp157c-dk2-u-boot.dtsi.
> 
> That's why I dropped the include in v2 and defined only the fwu-mdata node
> locally.
> 
> Or am I perhaps missing something?

Hi Dario

Sorry, you are right, it's just following an internal discussion with Patrick and i totally forgot your 
v1 implementation already included  stm32mp157c-dk2-u-boot.dtsi and has compilatioj issue.

Patrice


> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260512071157.564081-1-dario.binacchi@amarulasolutions.com/
> 
> Thanks and regards,
> Dario
> 
>>
>> Thanks
>> Patrice
> 
> 
> 

