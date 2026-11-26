Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A79606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QENKqnXt;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Af5TLpPz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10236608BD;
	Thu, 26 Nov 2026 07:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UP88kUSpXr31; Thu, 26 Nov 2026 07:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2524C60898
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795679181;
	b=KUYw1f++gf2NBUFdRr1CluVvamufHTFJZnuhqeRR/Cl5ZK4xEMv8eSjriUWo14uUFnqu
	 AqEekAigMroqQECf/IOKGH1rQstsbZ0Plpuq8kxKsun2CgMSPWRZwKnOgzn7+srKbjThK
	 BqkSYW05AqQ6V5KNyv9aoJDnx2KnN0EQSXICnhYZmdZOxcoR7ycKuUZAabkipbWl9QddD
	 bxsDPA2vrfik1fFwd/bDP9GJHm013zRkftAnLxxvNNJIvzXZxLjZCLaG/iZgkcDdKBw29
	 Ur1cij3RB4IP/VLRCiE0zCpXpIOgBv47NctTMgbcMbGQo/YSN/WnD73oNBqNqHIL63g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679181;
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
	bh=HLPOXf6EfbSx3PDYktxSmVoEO5PFuMHoerI0VNFSsWw=;
	b=JtxFYgfEaoGVGjD7t2zA1i8wSDcDGGxWa6pRtfxKh4BDAL8a3GkOr4jM8k4pVx8Va8LC
	 eF9vrOa4ejOVA4+Ln1S31u3BSeqnV/XkGMI49eJ3yBqUpbFyMZzzWT3nfHkbRvveZc944
	 Zt76nFFu7c49P7buIwyb9sJaV8uS5ShVZcpOaLLWivtlSicUg60x40RKYLmcjF0ZVPqBU
	 XmdSaGvjht0/V/fOZqlV6MnkZED/zHfnWj74UX9H6zji4JWl+D9V33e6nWyHXwLB279yh
	 kwQtWMHfyzb7uV5veYuwwwlFK/wD0USmY29spGY3MtK2gwL6AVZE3UWiE5fXtxNjHwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795679181;
	bh=HLPOXf6EfbSx3PDYktxSmVoEO5PFuMHoerI0VNFSsWw=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QENKqnXtDHyoaShyrfa8Ggccec9sZAIlmr9D00O8K0t3rozF5jMHgJL6infiJr+eQ
	 uzr1Javx/lwel2OpFxYfGgqN/KkMXbQz4meMfbSnqoRzXffOkOUDhtWJMXNuH3OWRx
	 we4/E6dbBA0RsxmAKDQkkD8srrYV5Nent4K7PHZM16uNMW87iqAfsG0KoOEOlVIN5c
	 15sUBkl7dTuJCdy9QeUE3IPT0pocPbjliAbpxpUEPy1df7WAUjG4pZs3m3YyED57d5
	 8AkJ4QB/ram/UWeDjumm/xMkSgxvJu6lU+QPMcSjjREPgK/rLHY+omKpRjES8QpwAO
	 z6M96J9mggmeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2524C60898;
	Thu, 26 Nov 2026 07:46:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 384E71C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 295FF40852
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8tp2mcKi2Rk for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB77E4083E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Af5TLpPz
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB77E4083E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLPOXf6EfbSx3PDYktxSmVoEO5PFuMHoerI0VNFSsWw=;
 b=Af5TLpPzn7iAjw1ayu9j4rZ3OvPBkJaKq4V7dVspnQmC+w6tq4/LWKDefTMJy8rkHZcnZF8QysQqUANNAv9msuZ74ED51gRN0c6pgM9Zut6giW1gxzYvFbq6Jj569ZQzKxJETrWu4+SYJa+hPp1q/DrXYrGidhCuIW2UMFJiz4mO8o0hrKgf79YqCwn1iUWmJ80ipuaFkqWeGRzmEl/FGZJzdxBBtbALkRWvpYy731p1EGl6h3aPG82UC+CAOPX1v8hzDfcPF/3h3SvC0SUfOuLjeQ1gKF9KKftsram2cgTsOFHi0+Mu0Nl/QcMQjYXR5f0nL7ZHDOC7lNszzfG02w==
Received: from DU2PR04CA0296.eurprd04.prod.outlook.com (2603:10a6:10:28c::31)
 by VI0PR10MB8488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 07:46:06 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::1) by DU2PR04CA0296.outlook.office365.com
 (2603:10a6:10:28c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:46:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 07:46:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:47:11 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:46:04 +0100
Message-ID: <867bbb5f-c728-4f7c-8f5a-12a746bbce74@foss.st.com>
Date: Thu, 26 Nov 2026 08:46:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH v2 18/35] arm: stm32mp: stm32mp2: fix off by
 one in mmc_get_boot()
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>, "Tom
 Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-19-dario.binacchi@amarulasolutions.com>
 <33b787df-f911-4abc-9120-1b21bafe9c48@foss.st.com>
Content-Language: en-US
In-Reply-To: <33b787df-f911-4abc-9120-1b21bafe9c48@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|VI0PR10MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: d247b2da-063b-4b3e-95a8-08df4b9153e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|261028144727099003|56012099006|4143699003|11063799006|261021121427099003|261026140227099003|261022105027099003|261009223027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6+dwftL6xWbikzsBJvqhnXw19D6g6JCbmyNVGM1cABHXI9NRPgeVGIRPcxoT7fiv6Q2dGOkAMdnx2+NSDG/MFU4kpKkdlzvAXJoEDEhhYDS7qKoKrmWJsDqGJXLzCjgPMKjX2xAe2ule9acAVD62V7DB4BLj1/l1MeHZh/yTdRLWTB9HtdUSNQGEL1F5QlZP8JjMkdhTVn6rCCAhb9Jk8fCgzMJkXcYEcEa49CnPfClFbOkl7iLqefpJj7I+3OSUFw2StfQAejflhCAIKkLusdPSEjaqxDbSLf/XuV0TzYOXyDHQij5yU2mIvzlYMdoHGhH7p1IUc1LF2BmrypBq1bHalx0of1BiLc7sOgWGE9IMpm8H6d2yzSf9JMrRmnYRIR3SjQPvhaN0KU6oZOEAzwTp1LjuoCCxBsOhKE4KE1tkYpQ5ckG4T3Ul8P8lH7pjbkJDlbOWmEQAwBEmoNr6fGiaQ3RCTYLvMQNJwLHdxdhSwd5CQVaSEWTE9WsOnZIuRyzTtib7hagpc+S42PM18dL5LqwYN17GVArn/bsPhYMq7B2s+uZQKmnuil1QwnRw2130pYW7ZLpOpQtkRtCBAnxwM2iUOVVdG4ylSNFhju8zxqTdaKzM8soms0k3hvzyifh953mYfyHVr/Pi+ao407BByqmtLzKGHXDJ8bZgXmA=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(261028144727099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261026140227099003)(261022105027099003)(261009223027099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5IUUSjAkpTolCrdcd9IRhkJ4QQiu+OnhLsECUt/2Sk69vtEKkBoG6ncdeyDSMXM9X5o1fj4lr+IkNcCdqWooJFqDqEJRAfmBrIUwqgIGz89o4WcmDzLujKf4K6uag6kUl7duQESqaZKoX3jh/KRidth9kumtKmCLN5KdzbBs2tdMTY+BiG8DzA02raDwj2xxYKAC6WCjDdmNFtlGnuXzes65kCTT1pNSVqLg2qpOHP3fjzbFXiBeL5BqbdDlsu1YwdiDA57M/D9suY71QAbsZQjlyfKSmxZp5GMRMG+Z9CgIHPkcXvkxHcQRi7xJoaq2dCP3ROugJ6kxkC+PTehEimA7DZYmoI/azaicz/MSxBrnX/3lm6HlHTAddwJzcPeOY+0njr6jdoTjzP3H/hE77+bdsFGlygKZ0oZycv4UbJBcHMxSxWHwa885x2r0EmB3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:46:05.8754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d247b2da-063b-4b3e-95a8-08df4b9153e7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8488
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 11:09, Patrice CHOTARD wrote:
> 
> 
> On 11/7/26 15:32, Dario Binacchi wrote:
>> The > comparison needs to be changed to >= to prevent an out of bounds
>> read of the sdmmc_addr[] array.
>>
>> Fixes: a3be0ccc4746 ("board: st: stm32mp2: add mmc_get_env_dev()")
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>> (no changes since v1)
>>
>>  board/st/stm32mp2/stm32mp2.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
>> index 7bc7d2a608fd..f2575339b990 100644
>> --- a/board/st/stm32mp2/stm32mp2.c
>> +++ b/board/st/stm32mp2/stm32mp2.c
>> @@ -132,7 +132,7 @@ int mmc_get_boot(void)
>>  		STM32_SDMMC3_BASE
>>  	};
>>  
>> -	if (instance > ARRAY_SIZE(sdmmc_addr))
>> +	if (instance >= ARRAY_SIZE(sdmmc_addr))
>>  		return 0;
>>  
>>  	/* search associated sdmmc node in devicetree */
> Hi Dario
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Applied to u-boot-stm32/main

Thanks
Patrice

> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

