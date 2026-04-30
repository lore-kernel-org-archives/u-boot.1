Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C393FCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2C8842D7;
	Thu, 30 Apr 2026 09:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WgW5Ifu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB39F845E3; Thu, 30 Apr 2026 09:00:42 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A91680433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4IPiQ3YnAWbyYNRTXRpGcqfVzHAC25QXBNwQz0xxEqefLZj3MAANaVJFEalboTof4rfmNNWM74x9OPE9r8msJry3VdfjWBRTxrLTT5aRCncINc7xJnBwljcs/WuMkAJrxraSCsmqxmIC/5lEvBYykqNWiYkX4QnRapNcZoBe6pyGCeoqp0hAT+yehTtqurTZSJuCnYxW7bVq2IwImlFroiZFieZk1dnl+U+zWyzxRY0khhwUgq+Kc1ZselFs/hu3GKTN6PrNJiSZKkBnjzlivS9sWc0JeYrCW8Vwri/qko0eeCkiMUGm/yfRmSTpwrM901xMx5QFBEAfyUYKzCiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4e78ncseY4KqresTgeMMp5WKffLH2Oak4IL+TYuY3E=;
 b=OxRr93edG0nVxUl99ztL0hc9K4PvyHo5ofDz7jHO1UrccXVcJMVRQsVOk3oUnl5g+CyCRYEAHej1jKsJbdUto+86Xy6+yhw72w9mypDKAmea5sAZRWYE0Fy1mPgeTz2lhVQbvZpnT9QUSYh5Ekdcw2s3nOMyFXODaFJxh/tL2VuKa/8KD4HCyVtfYW6l7fe5TnAgNjCInHBqVrAiTRcTgj4vQb4451mwx+00d3UfUtyGiCTB4pW/+yq2S7yyIo6o6t8kfVQ86vIHyWDv9bFI1SbJzZlyLQ34NnMmbFcFW89VmIwLX9SjcpyTMaiHK4WPCBA6QjPVXxhIlK74S3J9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4e78ncseY4KqresTgeMMp5WKffLH2Oak4IL+TYuY3E=;
 b=WgW5Ifu1bw02g3+iEY51G/03sNDuFt7dwp5wovvWKtmvBIHwS400c8xXulPLHvZVV8kk3XppqhF++aio8Qnw6g5kK5SoFKITIoRoDKClf6+YAMpcFFfu9Vg/tGYG7dxQn3B7mq8+49GlFrL1lnFZRU/l5kR1vI5vQfcj5YzGZDAfMlGV9GDzDnkP2eBTx7dnRVlwufPYyotMPT4tsBMKiZeCzC+tIwpz6EivmaWmMpe/CWCv7meq5xpd+iTRUdsxX7pTaEdy2u8a+oKd8PWWko4QBX1tpmHZS7++fsrGAACl7Iq2+10ImLe+Aj1n7qzMRFUabTPQAnSPu0/dl605Ug==
Received: from CWLP123CA0240.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::13)
 by AS1PR10MB5142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:00:35 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:400:19f:cafe::79) by CWLP123CA0240.outlook.office365.com
 (2603:10a6:400:19f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:00:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:04:01 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:00:28 +0200
Message-ID: <d70e58e0-3a40-4ff8-a241-4a0b1a0342c1@foss.st.com>
Date: Thu, 30 Apr 2026 09:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] clk: stm32: Add STM32MP23 support
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Lukasz Majewski <lukma@denx.de>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20260401-add_stm32mp23_clock_support-v1-1-ff5fa33d8b67@foss.st.com>
 <c4b646c5-7038-4fd8-b794-f304502452c0@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c4b646c5-7038-4fd8-b794-f304502452c0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS1PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6122651b-40b6-48d3-47aa-08dea6862cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: sl16T0XaYQCCNfamQ0KumaUXLSNNOSZjsuBSbFeI4HhKlk+aGid1z1eQ6cvnPbiG4D1Af96QL+KNIXJfp8lAgh4rZ9XC5d0hpHimlJ0fZUk5PePvC1AnR3KvX5vl9MNr96wCO0porQPPTWPzkLNfwbjGW8Q7k5TryX07dZmrvx7WPa7wjLntGQ9WTervzCDrrh8MFbSHzPKWn20dLpIQ/oGSD7BAnYt8JcKJAS1nevd4BsG/aTVydojXREvwd+qkSycmNnHc2V11Yd+kHi8cPZrl5Pe7WU7w1B+4FPDUEY3jqs1Arg6CoDRDgQE1N9mPgp17YM4kOoXhDrZK/2rBnKMtzNgnZAzF0g0bjteez7IaphcOyHd+13bZ++f68DaHknIRAvRpON0IvdDueKTF5vwFA/XzkqA82XD0tlsuS4e3iHqSKO6hu+zV28mC7m14zRzW87n57RjVJRXbFgSxBnP+9LuU7sq2LNlS1I8waJgTIj6MiX51iH6s+yr1XyUBa5sOqDz5Vi6zpRRzY4k+z2jlh76tMbutcPVeQVAlRNPWgB1aakCht7sG6MhToVWovsZ5dKWEF98Gsm6aP9QG1pHamn7jT/BT0dB+h2zzfRIRI9dLzJCZO6smVzfTLQ4+Wo9ave9eorq9ZqC81GObRKVNHc+NhuGqZZ95mMd376Pjyr/WOs/yn29bnSHhsDXI3J77NccARDXn+vRvxb2oo2+FxyFwxIfqw0gQ/ATI8jw690y97NpeXVHKqI2Mrd/1yx0SWiy8XW6nI3W5bS57GQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bICI63uTm0URa74dnwcBsrGGSTU49car7ap62FTZGGqoQdu9jp+NX20tW4ZHbVF0Pj1SeH6ZF5/8GDsRU0dodJjdqDLswVkOMrMS0vTL8wQdl3yeQ/fD8suWRMopLRlUTjra2RsWd68Y8enghYCjsO8KRGLp7qAVfboebyZZEreXh1Pps33bkPHi/xQyteedYWM7II6HJEQOumfiPLEvc5aVc1GlnrDatgMshlwv5hl+vqa3OOWiqcdblWYp7d2jbzyazWu1BZUrjWS83bu2ZlCVZzSM/hspgY8Bt552yd8m9amEjBNdFbn7NIBlkCPreJzgBqgqvya61iy0sM1wdR8dwCdiY7XmIozdMNM7Zt4sh8mnroA474Q44hGmZp5WW4RmUUow0p+HisFU9btBAuDSYEI6iAvSed0g4jsbvblcaVV3d2yS0cNTEk7T1Srv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:00:33.8362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122651b-40b6-48d3-47aa-08dea6862cbc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5142
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



On 4/12/26 22:11, Raphaël Gallais-Pou wrote:
> 
> 
> On 4/1/26 11:34, Patrice Chotard wrote:
>> Add STM32MP23 support.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Hi Patrice,
>> ---
>>   drivers/clk/stm32/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>
> 
> Best regards,
> 
>>
>> diff --git a/drivers/clk/stm32/Kconfig b/drivers/clk/stm32/Kconfig
>> index 4e488136eac..e63385d3051 100644
>> --- a/drivers/clk/stm32/Kconfig
>> +++ b/drivers/clk/stm32/Kconfig
>> @@ -49,7 +49,7 @@ config CLK_STM32MP21
>>   config CLK_STM32MP25
>>       bool "Enable RCC clock driver for STM32MP25"
>>       depends on ARCH_STM32MP && CLK
>> -    default y if STM32MP25X
>> +    default y if STM32MP23X || STM32MP25X
>>       select CLK_STM32_CORE
>>       help
>>         Enable the STM32 clock (RCC) driver. Enable support for
>>
>> ---
>> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
>> change-id: 20260401-add_stm32mp23_clock_support-bb1480914811
>>
>> Best regards,
> 
Applied to u-boot-stm32/master

Thanks
Patrice
