Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q3M4Om8C;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=U6F4eVyH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A76240869;
	Thu, 26 Nov 2026 07:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIgo9EGFDR9s; Thu, 26 Nov 2026 07:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8513B40855
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795679215;
	b=jsauHvnCYb5siP/dZOsHL9kjCma6EbNsy8tigF6aEgoWhb0JHrnui2Wktg6IPNWkqEh2
	 Kj/bklP9MsT3tPZGQmQMSU2M9oYcOS790iwxOsG+JpZqhcdVbq2AeiyIyF/8TfmapT0tV
	 jhMnEzBVo6dnm03NtRVXqU+z6EIaBCqsjGC0akBQjz2FFAh1zAJFnTDyH/B1eyDtDzWzl
	 YaQLB3UTWJP2phs9/jFuWjbmCPPqULVYOzuiyO8nnWiLY4arLlu1NdhYhD3Hgz40lqmqu
	 OYb6kGw9fyPyk10M7QWt7Wwle1g9Ch8Lu7hQcps14sGTkZJFZEFK9UEQgaZMwPkq0Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VKIumJ+kxhKNfiLaqMkfpaTv2JKtQaf90akdwQuP8gA=;
	b=YfweqACa2F8R5acwQ7vcn0KZF5Y1oLSI6yktHywt5jToXtkQHaqHL1IvmsQJ97Fl6UcR
	 GoFap5xjCBZKVoBuEOrZsS+ojohtcQSfEQ1KuUhndWlHohfChzkXZ/wPJeOYeCEpHb2LB
	 6moUncc6OtSLj9rPtauW91LULYHcrEJGBvHX4Qh7WKYNa+Z+XZkDAYNVRpA0mJg9CCXWF
	 NmtYh+SwKhjwZ0oIrsgD7bIjB9qjdG2qNv7TzqTW2tF5FSb9QW5isKbT7Be56U+PXG/pV
	 02GZ5tSFh34ZT5MNTSifkO6YqaPX8wX4ma7i2tNLXjRDC+3mNPLQhJXoSTraGuXwOUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795679215;
	bh=VKIumJ+kxhKNfiLaqMkfpaTv2JKtQaf90akdwQuP8gA=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3M4Om8C49feXfnDKxkl6u7Z/oXP5jT0EXz1P4gaBkfHWIN2GJku4PV3ubk+GXcx5
	 SHNp+/AXhm1mkqcjSMpGwrYr12GwlvyUkQmaKuHtHzt7C9eiMYMQUdATYzSHgRsyFW
	 QVzWk8baHMuLj+JVhKUNzv8FZveQkZhVKJCIRj2TU3+qyDMX+AzU3fDA/BmErGhCfR
	 qOmbBEBibioL6S0Yt41GOd6UnrIzTncQTuTZb/epx3XopJg+GC2E7cNtBDbdTd5n/h
	 dzIGe/bvui38P/vtnlu+rwUBY6+1NyTwvpChOIZy//iU5fyDYD4h3C1SZahO6ATkv5
	 LdwGqxl9tCwEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8513B40855;
	Thu, 26 Nov 2026 07:46:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03085260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCDCB8100F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dTtdxUxBlRri for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0AE98100A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=U6F4eVyH
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0AE98100A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKIumJ+kxhKNfiLaqMkfpaTv2JKtQaf90akdwQuP8gA=;
 b=U6F4eVyHuME+VFLaMszZEBAhG2QqP26JhvmxHWrHsIQXXT+S39uXplMANAiuImxCdPt/SWlXelnnW0QV17ro65N/ZxG2frpRUbWFXrBFuxQw5Hz+7EY2reHLlMONdL+AAfeBO1AxOZ+dbtp9JDDS8DwG+pDjDPGwc2FjLOUP4g5Ngw9cEB3o6SSFMmMgS47JQaO/8oO0n2NLfkMPHcRjdy7grIKFg/i3e5vw4IQbjoFRRIH+qbGMVM+rE+ZZv7dB2pVcXTOhRp5sMZdt+LEnIE07TiMmp9mPYofCd7Ei0vYUTBtm8WcuMpNuomnhA180mtN6pdtUFjXlTMC7WSQ+wA==
Received: from PAZP264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::16)
 by AM0PR10MB3185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:187::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Thu, 26 Nov
 2026 07:46:46 +0000
Received: from MI3PEPF00008499.eurprd03.prod.outlook.com
 (2603:10a6:102:1fa:cafe::4b) by PAZP264CA0086.outlook.office365.com
 (2603:10a6:102:1fa::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:46:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008499.mail.protection.outlook.com (10.167.240.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 07:46:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:47:33 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:46:43 +0100
Message-ID: <a441c60b-38d5-4cba-bab2-6fb25a282980@foss.st.com>
Date: Thu, 26 Nov 2026 08:46:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH v2 21/35] spi: stm32: ignore the cs-gpios
 polarity flags
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-22-dario.binacchi@amarulasolutions.com>
 <98e18d51-45f8-48e3-a4fd-49cd2c6a9cff@foss.st.com>
Content-Language: en-US
In-Reply-To: <98e18d51-45f8-48e3-a4fd-49cd2c6a9cff@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008499:EE_|AM0PR10MB3185:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf7e4fe-9700-4e2b-cde5-08df4b916b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|13003099007|18002099003|22082099003|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5KiqqAptum8uul9mKA+Le2QRP/zdmNMzmKiS8fdMxZj58zxnAPmrb0423t0Q/t+rQ60XT/lKZ4erkuFdz81xEwNaR7/vkDaUQPVJ05F5DJ3EwBmlDjiQnDEIbFfQXBOqKg3ZlndpjefpPSCWfztP3gEDJjKXs0sndYqMJfi0xJtFC/rZy66fcgKxxMSpC9Y3YNPUSNwvKlxyRhg86Jsvz4JdRYiL5pVmYtfdegOWwU8QhDJjekkAJjv3pd0Yb9DL/udB71UPtYEY1o+5yNy9nDgQwxlujXO1S3BvshxnPr1kLm1puS1/jHvLF/wasGPo4yL8AoBKZu19VwNroYB1NKOPOKjlybWnWW6138Ioy7Rwei60k1MSJ6kuV8WyXtgziefxBhMuhzJ56wE3c6VYTJqMqxmywbCW/7ysxgnkz8bRWX3x1ZXv1vzICZUhmFY+pkAheXvX9tSzNIYhtG3I3Q1lGEog+AArVTe+DqOzBp+sWa+wL9zeV8kpcbSEY2ZqFXUvqVCBH3sVZq1AuDTejK1zOlrfqq+iXVNey94zjtMSRI8UOFvNcodzkurF34/l+4SuWzNa8jp65IxVWHLP5nB9TUI/K6qMKY/3wdCP8NN8b4B/CgI1zym3g3a3WQH3EkgxjoGiRGDkjVdOeF70xq3+Rvge/0ySGihgIJTVHCA=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xuxDN1pbbSUN2NFvViBsNKz41fsyWvujM3HMG4zAAFGlFwfN8qVZrnqcWjL7uzc8L42xN5WDCH7ZJG2U9i3BVSz5kv/YpTnzjbOEOpNcdHp/XcwvbXakMRuma+Tk0Qzl4nJdvv/vgICwXe1q2ZfVBoK9BZtUqLw07Nexkhdvc9kmgqG639VjQmbGHiteFMpcgZnVOIHiCQ6TOCoWWrZ+rpFl+LhUfCVWVrp2HLjWJzoQbNTX9tGmgnqHlnv6qD6BCv2/AJ/zeT2AGtdmjxhuaK5Qf+XOuGBGRUrw7/VfxBU3nzxaBVNjZI+seSGaEUD/VxTAAYN16QYXLiZX7lc3GM6bfK3n+kmc0WiWmG9WAv4OScj7r8NFdqFczRslqoXQHrchpjkAu/YEFUHWXNhnjXWp5tDSAAnz2ZKAFU5lpO1rtIknedocb/OZp7K7bEph
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:46:45.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf7e4fe-9700-4e2b-cde5-08df4b916b4e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3185
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 11:45, Patrice CHOTARD wrote:
> 
> 
> On 11/7/26 15:32, Dario Binacchi wrote:
>> As in Linux, clear the GPIOD_ACTIVE_LOW flag of the chip select GPIOs,
>> so that their polarity is given by the SPI_CS_HIGH mode only. Otherwise,
>> a chip select described as GPIO_ACTIVE_LOW, as on the Engicam
>> MicroGEA-STM32MP257D-RMM board, is never asserted:
>>
>>   cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
>>
>> Fixes: a2a89b2e21db ("spi: stm32: Add Serial Peripheral Interface driver for STM32MP")
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/spi/stm32_spi.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
>> index c93a749cd5bf..776d88736a42 100644
>> --- a/drivers/spi/stm32_spi.c
>> +++ b/drivers/spi/stm32_spi.c
>> @@ -624,8 +624,13 @@ static int stm32_spi_probe(struct udevice *dev)
>>  		if (!dm_gpio_is_valid(&plat->cs_gpios[i]))
>>  			continue;
>>  
>> -		dm_gpio_set_dir_flags(&plat->cs_gpios[i],
>> -				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> +		/*
>> +		 * As in Linux, the chip select polarity is given by the
>> +		 * SPI_CS_HIGH mode only, the cs-gpios flags are ignored.
>> +		 */
>> +		dm_gpio_clrset_flags(&plat->cs_gpios[i],
>> +				     GPIOD_MASK_DIR | GPIOD_ACTIVE_LOW,
>> +				     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>  	}
>>  
>>  	/* Ensure I2SMOD bit is kept cleared */
> 
> Hi Dario
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> 

Applied to u-boot-stm32/main

Thanks
Patrice

> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

