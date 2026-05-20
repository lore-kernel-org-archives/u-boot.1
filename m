Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C46CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 07:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57239846B0;
	Wed, 20 May 2026 09:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AcPMpGpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D310B846B0; Wed, 20 May 2026 09:05:20 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8845844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 09:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ6KfFxnW3vbmpybri9jaxMT41VUmrQSRyjIsftvjfIYhG0jI/5YADAU3c2AICITB/A8Te8lbvatAIvxQkbvuBoBr7FoYwXnUMoaO0vmQQWT7/Cq1sbLQ3TNfhuJP0XeTx8Tpqm023C1auDyQ9MehYzbe7QsjvXUsHkSjZzDUNipOpFGSTAuFMQUZ8cYeJrwIOwn28mUc0L9xm0a0uDcokwr1pFxXmcxZ43QHPS8cWqqCPDvGXRFu/q0/sbaSizIqtsuQDQtgRtGxCUlMdvE/InVLIlpAgR0bjOPMQw1WabqM4yT6+KGhf6Xz1TJEgvcovA7fcJwi8ZbaDGF9JzzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0ISnAIf1A+orR3b88cFCoM3nkNPEgFro6+Dxme4C1g=;
 b=Hi7yWXQqycPTcFM2zafHgM75sPjTpktlmJi+zYG152ZyV6vO3gK2Utj47a/rQUsCeH3DswMHru+f2tR3PBHvGsymeCpq0STqIBF8fxLagNqtD+1sLnoWLqbUbl4ttyXgB2Dh5df/f8hi+8Xe7YMMEhhMkkbydj1GDqyVncTwJKm0/rWq0LImqB8Mj79k45NY36yPpGoCEBDVRKSuN61JFJGXndNfKnPPT7ONVnCDzds/K96+oex2jNAlEubklfj5ucO76/8JAO3Czqtpjp10sN3yQWTqYEijGeMNCHDRTfhetphlp0mR+fqfkw20shYXtRsryOKcwwJb46Wst3Poqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0ISnAIf1A+orR3b88cFCoM3nkNPEgFro6+Dxme4C1g=;
 b=AcPMpGpMRW8Z4046ArpNrBrPLohUkaIxuBaMEqmRqtBb7f4Sc2eUiHZwGUyHwiSj9CBKVcxSr0WKxZEojeNn4KlvpMjhwdeU+F6YVykRaGvQnkGEfJTmLa9aF6+fHSw2mIvwjaojckL2Rtl/kneXX1lhLzT03r9TH8s5KhfLFaeiGDZS5cNk7h6TzjtGPyydWiJ7MpsyF+3fHDEskGrsRXJm8etwMupLENW5YeuPSUljSH94UY549mb4tUlJKA1gQk8SPFKGytK+slWYP4H2DhkzM5HLvRoQLfktYZqCyssRppWdCEqMRfNaANBT51Ni9+UrS2hMPeeYGtnqhdbDDw==
Received: from DU7P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::6) by
 PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:05:09 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::6a) by DU7P250CA0022.outlook.office365.com
 (2603:10a6:10:54f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 07:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 07:05:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 09:08:38 +0200
Received: from [10.252.1.215] (10.252.1.215) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 09:05:07 +0200
Message-ID: <1aec25d4-3135-433d-8fcd-4ead7a065d40@foss.st.com>
Date: Wed, 20 May 2026 09:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] configs: stm32mp13: activate watchdog
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-3-yann.gautier@foss.st.com>
 <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
Content-Language: en-US, fr
From: Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.1.215]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|PA2PR10MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: f286bf9e-44da-4107-9501-08deb63e2116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 9IgkEeqZKYGXVZRS1/QKQ3oR3MyUQHecY2CQXU8u/6v/bJomQAs88nszTecajQEXWjlfoSzrwCJv6H/ipna1pJaROzHVzjJoHSObuC7ilcxezNk3H7n70THKgpBqdNF+F8zRQn/WvOpw6G16wchdBip7K11oBic89kCDfmfPEASop0tYhMO+jg7u5ErPQki4OQUo3K4YLA+ZxvEG31inG1LWbq2T93M6oZXTIAIPojQDKH2eauhVTFp1hlBSUGvRLM3S/yTSukTGpQuiDH94qXksH+zjyISNfNX7315ZF+SUhgFaUY5BwtZwV/wrBO7lMMYIDV69CZqJb0yy0uUPQ2ebZOOll67JDY3ioRwYmtHPrkYQZ6OyoZZz2oOnVVezKYWekvmKLFNWaFUjJWS9O3zpSUIAilQ6vhpKuQ9TB7s1Grvh9dC3puIdYICTxlS4qKe6QAsI1yvw0efw6ls77xbgFS9LwBY41yfeWBL2EBJ5ZcqbdzGr+JKP4ahLqrxoxwJYNzNmM1kjXsZzHOUFgsxc1VGnVIAGz7xRAMtY922DYo3blZn9XI19xn18HlE4+BqjXcR9HFXQCcaek5GJMwz3yCVFHybAa/26KNPfv/dOtZs/T6Q4aAG0mtk9+2WrN5usuKIM8ffeVQkov4xekXN8GW9PUY7QYojtPAL+xitxPDUA9M+ZGPffRkG8YCBwrv3zakfRm+QYelwxh6cdJRL661uwYwLlMUp5LTRu34I=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dXvd1O2m2ZP+OgRLfUyGjCNGvKyqTKFX3vLPXE0js4Bpd6ZlG7JtC69KMPDXSh3gnNnCDcq1dDmTTGTEQ1bTwaIVVRsKWah+MHqTNS2OxBKYn/Yusceh1iworMbSj5B6shiwe29UXuBrnH4t3ISm92/qi46asLCD0fl4bn1Msdt0o88RjVnfB5rtBYoqjWDrsntPsHu2ir/YSbTx4YxkXO7hBrHmYzQ/4g61hc5EIYmdtlSrqBd+spmKWjBpKEC9VvbZpMgBDksWhuVHh9WXGHihYTszG/YMUMfp+NJVONfEStExIbxYyAlfEL8R5CI0Wv4fOfzHEljvDUCOw832SkH3dZDQOYczHvPZuRl0GZ90Bp7DxC497DGuTMcuROtzr2UUFrFuNj+Sy21/twUmLlyiX2u6MXZeqMO8TzBM6dXjd+016IfX03IO4iqXu8cN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:05:09.1477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f286bf9e-44da-4107-9501-08deb63e2116
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602
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

On 5/19/26 18:58, Marek Vasut wrote:
> On 5/19/26 6:31 PM, Yann Gautier wrote:
>> No watchdog was enabled for STM32MP13 platform. Add the required flags to
>> support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, we use
>> the Arm SMC watchdog. The required nodes were already present in Linux
>> imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>
>> ---
>>
>> Changes in v2:
>> - update commit message
>>
>>   configs/stm32mp13_defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>> index 620a6da2efe3..cc41585097c7 100644
>> --- a/configs/stm32mp13_defconfig
>> +++ b/configs/stm32mp13_defconfig
>> @@ -113,4 +113,7 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>>   CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>>   CONFIG_USB_GADGET_DWC2_OTG=y
>> +CONFIG_WDT=y
>> +CONFIG_WDT_STM32MP=y
> Why is CONFIG_WDT_STM32MP enabled here , is this the ARM SMC watchdog 
> driver ?
This is aligned with stm32mp15 config, and no, this one is the STM32 
IWDG driver.
I'll check that with Patrick (who originally wrote the patch), as it 
seems that this flag could be removed.

Best regards,
Yann
