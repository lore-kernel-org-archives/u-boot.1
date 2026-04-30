Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82613FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2DC3842C7;
	Thu, 30 Apr 2026 09:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JYTMc4M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C74A80433; Thu, 30 Apr 2026 09:01:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7099845D8
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHTJOVu+HVegLcnI/OXaDccGXlhXXKuVDGiMbi1JtepZ73BtJ5KNjNBvBdS7uslgREk267zpR+Xi3vXMjxiTsrj7JUjD6E+H5K/xa+ttDk90MTap/pGz3HKoYcHLqDoZbTioVj/DX9RpTEAdzErgUiEIvOJONgXbIktF++XE2orq0kXcEqn1BOKnhGZwGHe8+S13QPs2ioZrA4A9bQZAhuig9UPn5cM5DbHMw2Tni8hJqQ7vroiNBBNGBhI5GT8aeYN6kSnbOg15aq9PcBr+jvlBPynFWf9+d9fVD/K9llP4jcMLThHA6t52MYuU/CKyFPYMjXAqenYGV63lYlGuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fXkwGl7SEkZr1J+Zspzm8uDdFbILhEmc323/I9j90g=;
 b=todX6/2KuI6Zj3lCA/ijYb6PKv8qps4b5X4mc7Lw+4O2NwhpSsXP6VaH+aRfAMjqsZ4RNoKATOBLNUemUfkQxWqdlxPmzJF2lyPahpvjreQ6Xv8RurQTkmBcD+3lOoYR6uG1BEENAlHebOZ+cAt4AcZSxBpOIrhnqEWMbFApPpKPzGMl0dLzWhZoI9DNjCVDXKvafdfW34r62YH7Z0SACM7ZSq9NdyR3BNN+E47qP2q3c+jfqxo9V3ND88LMakbBfXLYThDJFC01UYeBmdayoYF+rK8dUTyEiHZS+m1RgclBmjeh00vX84XUIT2fM0ZVgXZw+P0mfgKgaoq0UnySLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fXkwGl7SEkZr1J+Zspzm8uDdFbILhEmc323/I9j90g=;
 b=JYTMc4M/quolThk2/mtApmeGUo9KHZxHGQOxiXdCgc1RPk6Z2EM3FjCI1iBTZhuGdOBE+TLDmD1t7laWr0td04xgtdqYN5ZfwXVC+AzN64TGLIL1CE9Wp2hC5m41c8KD/ufracww6LEIsQWMNOBNuJ8VYcgtzFWaAAXlMzZv6O4bk04gNTHl2jHw7oWvKPrO2PmreCtm68YHSJ9++31ezwn4zsUCJduNwRrjlsa8DlwgmsJfEqmKGOGfljuwVq2+F3tmwap0GE7b/zbiHKAnBdD6I1zPmxoVfqagtoBExWjEdwfQ0melzKP+MjwOkvoPGP0dvCWtyR3W73kA3UOh0w==
Received: from DU7P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::31)
 by GV1PR10MB7978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:01:19 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::25) by DU7P250CA0018.outlook.office365.com
 (2603:10a6:10:54f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:01:18 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:04:51 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:01:18 +0200
Message-ID: <95c62e0a-1f47-4256-8312-8e7efe534157@foss.st.com>
Date: Thu, 30 Apr 2026 09:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] arm: stm32mp: Drop unnecessary
 BOARD_EARLY_INIT_F usage
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Dillon Min
 <dillon.minfei@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, "Matteo
 Lisi" <matteo.lisi@engicam.com>
References: <20260325190027.3428596-1-trini@konsulko.com>
 <f6c27c74-1188-4062-9082-d0f3639d3ce0@foss.st.com>
Content-Language: en-US
In-Reply-To: <f6c27c74-1188-4062-9082-d0f3639d3ce0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|GV1PR10MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b09a31b-7966-4343-0fe6-08dea68647a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GKy8IyJKb2Aed4wNK9vTJTPHKyC6PSS1cvJ/m0UCYLpSMwa10Vyifzuy/hDGlq1G6i04+jdiyGoh9hCT9FOuNyQXCjyEwTicY9XXJc+yxtzbJMqXaj003/juCtHv20lNm5Nkd4dAsaSXV/x32D6cs/qc8XnAuo+dgnwfbnntA44INhjEtIEt0xfu4k5jW0256gOPitQJHybA5KglrL8pJoMJkLZ5vCH47j3rLL7dXxivR2XxtYccB59GUIbPmA+UNzPTHFMxmQ78C5hyX0HOrIrXfUtFg8KLRPYYt4nKyE0fxqSw5UnzARFMUlsKvWp3ZWZmq7F6yHjv1g7hWbos8mRtEyCOl2pGO4XXQNH+Y+ywzFlHK+gdNkqD6tTJ5RVW+fP+J5+5WT5GNYiDFSoKUyQ7oBrfQr7jjHlMWxIMkbThus8FN446vnreNroiets0x7J1X1DQ/BVylMCSKP4AnvM6jGUwfTDUD3DL3ZVurvzPYXpKH+ZOYcPZfRnGay6Yl5ammOXzdTNczlisByIV3D/1odKw83FVfVIzK0HdKKxuaTy2ypScOgMQZa9wmjPF6n2kF38SgxNeMxKM6T285Xpl20aD6iVyQpzE77CRxbxrL9Sd9m1GofNVGJuQfUMvq8c5sGzTO9Z/dnq4WEjfSIdReVmbjzhEb9K8jzOmZNGha1tT9xr8JyrENEFCaBAJGCpF55c5wUi1IU6GNVtem3qryYU4NC6P0fJJ6/Q3KcDXe8kEGGJpO0vae6d+UbqfuauWOv59gxzCEokj4khMvw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3M/ljWIdO6cb4ZFWmvk8Y9gb1Db5GV233sDcIoTv0ZyyyS+/9hqwuvkeNTmG/fC3FtjRnKGFO/FMQSo97iWsY7hGFUps859AlutR/j4hfC/PsrMMJjEt4CTTXbuO9alRDqeVwygODCt8JPwzRnsbTS+oRU3Czkc596t3A/0nMOFgDHCK0KM9p3l8uU4is+WAmL3KETvdRlnvk9QuXBQ4MSWvum9E0lwYRB3CH/RR+N59D5wzQydO0GzkD7wQ2QdXBwidowMFkt1zvfLj5Xe4OB4+9/O8HYSgkN2jjQKc3sPfw02coNbiPQxpP/TJW+ZA5qB15GreLW3Wtguqdz8IwXnhPNnQdPOLgjEme6cF47NgLVQYveGm0fDDsKITJ1h6kpavrDxI7xsz9H5zdfsdiabt7xSCjIkc0kbj69pkT7PxF/2q5QJh63eqtGpK6IEx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:01:18.9755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09a31b-7966-4343-0fe6-08dea68647a3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7978
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



On 3/26/26 10:42, Patrice CHOTARD wrote:
> 
> 
> On 3/25/26 20:00, Tom Rini wrote:
>> All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
>> do-nothing board_early_init_f function. Change to not enabling the
>> option and so not needing an empty function.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>> Cc: Dillon Min <dillon.minfei@gmail.com>
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/mach-stm32mp/stm32mp1/spl.c         | 15 ++++++---------
>>  board/engicam/stm32mp1/spl.c                 |  6 ------
>>  board/st/stm32h750-art-pi/stm32h750-art-pi.c |  5 -----
>>  configs/stm32h750-art-pi_defconfig           |  1 -
>>  4 files changed, 6 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> index e63bdaaf42fd..d2e41b8e65ff 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
>> @@ -90,11 +90,6 @@ void spl_display_print(void)
>>  }
>>  #endif
>>  
>> -__weak int board_early_init_f(void)
>> -{
>> -	return 0;
>> -}
>> -
>>  uint32_t stm32mp_get_dram_size(void)
>>  {
>>  	struct ram_info ram;
>> @@ -204,10 +199,12 @@ void board_init_f(ulong dummy)
>>  	/* enable console uart printing */
>>  	preloader_console_init();
>>  
>> -	ret = board_early_init_f();
>> -	if (ret) {
>> -		log_debug("board_early_init_f() failed: %d\n", ret);
>> -		hang();
>> +	if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F)) {
>> +		ret = board_early_init_f();
>> +		if (ret) {
>> +			log_debug("board_early_init_f() failed: %d\n", ret);
>> +			hang();
>> +		}
>>  	}
>>  
>>  	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>> diff --git a/board/engicam/stm32mp1/spl.c b/board/engicam/stm32mp1/spl.c
>> index bb2bd446aa8c..19e5ab0180f9 100644
>> --- a/board/engicam/stm32mp1/spl.c
>> +++ b/board/engicam/stm32mp1/spl.c
>> @@ -15,9 +15,3 @@ void board_vddcore_init(u32 voltage_mv)
>>  	if (IS_ENABLED(CONFIG_PMIC_STPMIC1) && CONFIG_IS_ENABLED(POWER))
>>  		opp_voltage_mv = voltage_mv;
>>  }
>> -
>> -int board_early_init_f(void)
>> -{
>> -	return 0;
>> -}
>> -
>> diff --git a/board/st/stm32h750-art-pi/stm32h750-art-pi.c b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
>> index 244bb5eefb3a..8b1b23337790 100644
>> --- a/board/st/stm32h750-art-pi/stm32h750-art-pi.c
>> +++ b/board/st/stm32h750-art-pi/stm32h750-art-pi.c
>> @@ -32,11 +32,6 @@ int dram_init_banksize(void)
>>  	return 0;
>>  }
>>  
>> -int board_early_init_f(void)
>> -{
>> -	return 0;
>> -}
>> -
>>  int board_late_init(void)
>>  {
>>  	return 0;
>> diff --git a/configs/stm32h750-art-pi_defconfig b/configs/stm32h750-art-pi_defconfig
>> index 971d5c00d88f..0d0dca2511b7 100644
>> --- a/configs/stm32h750-art-pi_defconfig
>> +++ b/configs/stm32h750-art-pi_defconfig
>> @@ -24,7 +24,6 @@ CONFIG_DEFAULT_FDT_FILE="stm32h750i-art-pi"
>>  CONFIG_SYS_CBSIZE=256
>>  CONFIG_SYS_PBSIZE=282
>>  # CONFIG_DISPLAY_CPUINFO is not set
>> -CONFIG_BOARD_EARLY_INIT_F=y
>>  # CONFIG_BOARD_INIT is not set
>>  CONFIG_BOARD_LATE_INIT=y
>>  CONFIG_SYS_PROMPT="U-Boot > "
> 
> Hi Tom
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32


Applied to u-boot-stm32/master

Thanks
Patrice
