Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E89EEC2B5
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F5F83E13;
	Tue, 24 Feb 2026 17:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mCGULqgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F282283E13; Tue, 24 Feb 2026 17:45:08 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0469083642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnkFMfC92gzxBo3t0DdWFu5fh0N4k9gcKvKlr9smGy/KenCVlr5pbXTVxYl5pYZlZs0cc0h+XgZBrEckLUfG5tBhwMGB1DcS2LnQCcfnSXH7HwWrwgY7GGhhuszML9vc54myN6oQNB2AKedDcncRa3hbIN1t6iFAlUiO12H8GNztpznGZQwlL9CAl4pueB3Vvj1RE7vfFS9Q+LqahPkKm7EvwIeGu7rVB3xBe3SveUp/LoOME+ckkFPALQ0OwbXq3L1d1jCCIXmXz45MiFKdaZ2Qe10JPd2B/rOD40GyHWtGCrj2nRaErZS64TCtH3PWlnVfHdA81+czyKhrhP6vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnvQeaBrUV8ujfYczlCwB291dQfkDJ9w/AEqRhHEpuk=;
 b=JUpUY57TpZGKvzMMaV51YxZOjQhAcmph7lIhHKqgMDsMJ4WlvGvaG1SzElaCLZZJgK0LZCNr2u8J7AL2/EjS/Afp3gR00hqWLDB3Bm1+Zp363cOXp0nGZHLTJTWxaCpfXvWoMYFQBXvSKEPlUDcsKOsVDfQGVFH94Vu+CBRvZoFQZYjES0p/gg5yUH+llXraN1uX4AVoD5CK/T9uhRcj8RwH10+oSM4frMCO9Lw5vJyIJVFupZ3Y9VR0wHpJSlXoHHeRAa/x38bHTtducD3tftvNVxo30ielGk14EMqfv2gNLqjuMllcOlthoQzZgcaJWkfOdDmMXjiyti4PcHqADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnvQeaBrUV8ujfYczlCwB291dQfkDJ9w/AEqRhHEpuk=;
 b=mCGULqggpE+LXg8gJvM8o5Up5/Aa/bJbKz9PxR6H7CL3vF+v6d5q3A0nGadSt4bhgWJ5Q2TEBhB+Of5K0dh1UMERE6jSiucQby08rzzYaUJ2DOgI/GilimjucxTuibnDEu2aMbFUDneJNLwkNSiTFA4pw8faRyEGWs6fbkpFeRtciHooWePrYtIQ19Jvc1aSwe1Xf+yzdWVwyxOGsFQJgn489x9ZNRCvYIypNClInckK3H7TGUyZKBJ95agvhQUOUvOR4WzwszLc83sSrjO7GaYNGUCl2wfPfO1cH1SMrk7m0AIkAkV0kSAd/YyB8lwGWnatBvUjk1XGUqe22rCY6g==
Received: from DU7P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::20)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:45:02 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::54) by DU7P195CA0027.outlook.office365.com
 (2603:10a6:10:54d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:45:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:47:07 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:44:49 +0100
Message-ID: <5a0dc899-7d6b-4b65-9343-5631ceb4e303@foss.st.com>
Date: Tue, 24 Feb 2026 17:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] stm32mp1: Add check on syscon_get_first_range()
 return value
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Asadeds <md.asadullah@eds-india.com>, "Marek
 Vasut" <marek.vasut@mailbox.org>
References: <20260204-upstream_factorize_and_update_read_idc-v2-0-7f0baa41d2f1@foss.st.com>
 <20260204-upstream_factorize_and_update_read_idc-v2-3-7f0baa41d2f1@foss.st.com>
 <584c4aa5-e7b9-4c90-8cc1-7c4f7c3477e9@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <584c4aa5-e7b9-4c90-8cc1-7c4f7c3477e9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d1358f-551f-4712-7924-08de73c40e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlRvV0EybHhRdFJkenk1eDFNM25iSTdhY1hPYjlxbklObGZmcloyQ25oTHZF?=
 =?utf-8?B?TElVRjlrcnNmQnh5KzhaektIcldGSGdXZGJPNnRrOWVGdy9jS1F0MERReEpD?=
 =?utf-8?B?a0xoWW8wd0JaUElKak9jZWlXMy94b2xieExTZ0pndWlPVlQ4aWU0a3ovWk5T?=
 =?utf-8?B?aTJjcFY3RUEyNkZpemxac3BZWXlQT2dNK0tzc3VDWnE5V3VPY2NTR0pBSi9z?=
 =?utf-8?B?Y2xDekdNdDlrbVVXdks0aXpML1BHaFFwbFJDcm1qelQ5ZVIrd0xnTG5KRWwv?=
 =?utf-8?B?VDRmZ1ZXRXpxa1c0YUg5SWM4TDdXbEtpQ2tZditNVlBwM2M2U0RISmlkRXQ4?=
 =?utf-8?B?TThHVTJSUWQ0aGV5bGF0eGsvTUxnMS9tSGYweVZKMkc0MUFuQlhWWUp5STRq?=
 =?utf-8?B?SU9hMStqTGNoTXRiK2I0MldkMDJYZldpa3h5N0RaeUQ4UW9HdlRqWmpZRGV2?=
 =?utf-8?B?OXFDWGpyN1hPOVJhVjVIZ0szSVlIN3ozcytDMjEwaGpsNSthd0RGTktDajNt?=
 =?utf-8?B?YVk4Y0VndTlVcmtQUWpQVXRSZFY5aFA0ZVVKRUNUYndlbjNaRlJ5MlE5Z0gy?=
 =?utf-8?B?YTRZNjN0UU9ZbFNzbVI4TXpLdVhQZ2RoQzNiblJ3anZqMENwTEtRczcrY1dY?=
 =?utf-8?B?Ti9tZkpobStVZ1pMMXIySUhhL0hsWU82Q3BZNnZiSFVaajhLU3BkWWhIdm52?=
 =?utf-8?B?WjhZTXR3M0MyLzFTMGsycW1rQzJzTDM1MDJVbEV1S0VJZUIxcTA5SWUxVUJv?=
 =?utf-8?B?cjdJanQxUk5JWVU3a2Z5MWxQOFA4MkYvcnlTcmc3UEIrR0hmZlRmcDUvOGhF?=
 =?utf-8?B?WmNZcnFFNEI0ZHpZcWVlREo3MjB4Y2tNT2NlKytNTUdwd2dzbDhTcXg0QXBt?=
 =?utf-8?B?UDFJT25YbnhBTTdBZXJaSmtreGNzT25XUW0wUUs5YS92dGRhbXU0UkxNSUNY?=
 =?utf-8?B?ZW9FNHAyc1BYK2NzM3UzK2hLdjNwamFQN0VaNzVGUFhmTUo4RkRhZnFZeUQ3?=
 =?utf-8?B?S25jSndFbVZmeGFraUhJYmhyRUNmbHJWUzQxUVlhWGxLc3V4ejRnemd2Umt5?=
 =?utf-8?B?dDh6NjRvaGlxSTZKQTQvell6cDVyTnRLNGJTSFl3aklkN09BUkZ6c2xxMmpT?=
 =?utf-8?B?QVN0cFdBV0hyaDlwN05GRlNqb2NWL1VESHJUSmwvTlBZdGRZYTRyVFZkSWJ0?=
 =?utf-8?B?T2tJODlsa3h1WldJK2NrSmJtL3lnb2VrT3B3OW9jbDUycm04VDhWQzUvR2VM?=
 =?utf-8?B?cll1dmx3b0FSK2s2U1pHckJYV05qNHRxZXdBWG9aQzVHMmZRZFF0clhIM0tG?=
 =?utf-8?B?S0NHTElsVTA2VnBPd0I2bDlId2FFRTVPWnNsMlBKbktjME92NzNkb1lKK3Za?=
 =?utf-8?B?L2N4UEIyckV2TktBMVgzcng4dUlrZmNiZFZob1FkYTNkNjBIL0J3L0E4cU5E?=
 =?utf-8?B?MUdoYzBNazNwd3RvcHJhcGxzU0Q1bmh1aldiSEVkVUNqcnhCYUJEYkRZelov?=
 =?utf-8?B?czZMWUw1RFlpTW9iTEhjejhOL2pyUWVVV1ZvN0dueG1jTlNOeTByd0FCNDdD?=
 =?utf-8?B?UVFyWndFT25FelVUMkEzY1JvTllBaDZWMlFmUUhLd0d1VlZWb1ZhNlowSC9k?=
 =?utf-8?B?NlZyZGY2WkNGdnVHZ2NqaVNjaFFDd2Q5UEV2Nmt0YXhSUFJjKytaL2NFUnow?=
 =?utf-8?B?TmxnenM2NDFpMG1xS3IrVHFJalR4dHp1ekdFekdhZ085eXJmYk5TbUcyTCt0?=
 =?utf-8?B?UzhLK1ZFV1ZNai9TUk8rTzMzNEs5K056SnhjcEJwM1d6M0ZlSFVUemM0VTJY?=
 =?utf-8?B?OERFMjhBR3lTQ211NDhBVWNyT3dVd3B2NCtkaERnN3ZvVnpYVjZkc3RlTlZO?=
 =?utf-8?B?SXoweGtJOWt3dFdHYzZPQmtWT2NOczBtNUVuTStqSlJrZVVEOGtwTjdaeHN4?=
 =?utf-8?B?ZGRBMmMxN1BINmpVK2ZWLzJHRUtXekdRNFlybi9rOExNbERMTURqdXYyVnU2?=
 =?utf-8?B?YVlEOUV0MVFGYUY0VXF1TS9aaFhvdFprdkk3VmFzOGxKY1FZNFd6UmlYVitZ?=
 =?utf-8?B?VFlDM3BiRUZGRmlrWkxhVFFpOUdMN2VFTE9FZGdtNWFDRjFId245ckdMTEJ2?=
 =?utf-8?B?RkRCL3I5WmMxbFMzSmZKbHpnQXRVWVJBcG1qKzZmQ2E5SmhIZEQ3VnVxekY3?=
 =?utf-8?B?OGRxc3NnQndFa0lRRDQyWHIxejVTaWtKOU9YQmdXc0lqMVVrY3VySjhNZXBt?=
 =?utf-8?B?SHhVdG5vNmJqYmVyWXJGVzNFZmFRPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GXIeewwf2cM/HjQEXtSCQddya/L4V6DR3n58Rksn90vMdgrxUYP7xKLTTLQp/UYGyS/xoFuQ+92FodaAfIXsXboOtovQdLX7ip5HgMSEl21kClxAvOr1i2+bNuUYTduCvJNpTD3ANM0WKQ/AsirchHKGAEcq9XA0O7sZdY3cTx9uTUqPrYj4rKrrvCv7LDnJMYvvcwV7QtiAWCAyMn5qpS/0g/qnO46jOUB9Pc8WMZAEa8384qftb8UnoJFWoRLkatrvW4iukWrxY/aM+1Kmt7/85z5xstEF8Ufp1XyZph8DuySAth+y3bnsEBkr+5Ig1BrRXSq4KKiOf88rmcTllbnWZQ7Vkn5RycqpkwsMg5yb0esHnBWgAcbL0hVEPCdHMD3pjjTBvjZ/1Copg8NLbD4zbOXsVllXKAamlOvsReW7GwR1F8Pna1acO8Ui8cT0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:45:01.8860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1358f-551f-4712-7924-08de73c40e12
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366
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



On 2/24/26 13:56, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:16, Patrice Chotard wrote:
>> syscon_get_first_range()'s return value is used as base address to perform
>> a read, without any checks.
>> In case stmp32mp_syscon is not binded, syscon_get_first_range() returns
>> -ENODEV which leads to a "Synchronous abort".
>>
>> Add syscon_get_first_range() check on return value.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
>> index 79b2f2d0bba..6d2d69f3442 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c
>> @@ -17,6 +17,7 @@
>>   #include <dm/device.h>
>>   #include <dm/uclass.h>
>>   #include <linux/bitfield.h>
>> +#include <linux/err.h>
>>   #include <malloc.h>
>>     /* RCC register */
>> @@ -231,6 +232,12 @@ static u32 read_idc(void)
>>   {
>>       void *syscfg = syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>>   +    if (IS_ERR(syscfg)) {
>> +        pr_err("Error, can't get SYSCON range (%ld)\n", PTR_ERR(syscfg));
>> +
>> +        return PTR_ERR(syscfg);
>> +    }
>> +
>>       return readl(syscfg + SYSCFG_IDC_OFFSET);
>>   }
>>  
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/master

Thanks
Patrice
