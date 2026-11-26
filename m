Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24028606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C6v4D/oi;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Crj3cLc0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E98208107D;
	Thu, 26 Nov 2026 07:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2W8VrTiyRKQr; Thu, 26 Nov 2026 07:46:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EAACA81046
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795679201;
	b=ljJHYk/xz4jo3HIP85gAbeCUCNpEI26Jt5wrhvr7PbafYMmdntxNoHGVAl1NDKU9UMGM
	 BkKDnjknGGp1QGXsZZ2AwqTZXcjxH7PqNAQ14E3zXhkigWUU1sZ/+dXaW+OxEeNglh0eg
	 3ZtebVsOZahPWq+3FUKmepJsqQAkYmB5gZO2xbinjDqfQeu6HrJ+LlW1CRPOMkg7hJ4Zx
	 SwVmBuo+0V7/v1ebW8hjyod/Z0s0O+qUSaz2WJThCInJMacznT9fcwvswRSW/LHtnjkAL
	 otY0NkENTnDHgtmJXV3yt8CgVGAsE5HnXZWIs/6ZNT49hkGwu1srcp6IZcyXftLEPQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679201;
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
	bh=XENT7DqVAajTJ+97/noGUSaPlCSFHrS1MCh95fXCBG4=;
	b=au/y6AsJnE80YXLnitURLSi+oz2Xc7fvH/osmvCY1wIlmJBw5SHNUpo19dXdGmxwQLJO
	 DuV+e8WSYCjXPPA21D2xrejTgOWnPJMJubDbHfcnQERdS2kX0VXJwyllu9iIh4CrBPuvf
	 x15W2Vadyb9m0tAak7VGwwqxFATAVtWAuOhj6sRQIXuscBU8euCiyx8nxrEbzb6XMwtoh
	 +10qfQnFoW4PzqztNEXpxt807dc+CLt+L2aK8b1zZxeS3FRo3dcyaH9I+09kSk0ZwJ5aR
	 pk1NOmM/zRNDUHaMVe0YIjyuzeryTlTKW9Mr1rr9IMWqD9FggKNghpZO53qB5ullQjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795679201;
	bh=XENT7DqVAajTJ+97/noGUSaPlCSFHrS1MCh95fXCBG4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6v4D/oi/XdzoSGATbECwHkjpOCYsjR5l5E2YNg1sspRziIZTc+28N0qgG9eF34v7
	 NhXPieCgnieCWnB1XIEhErELS6XNPO42UB8lerPgFXHeH6pNXpeRNZwNvHGLC8ALg9
	 cyXrtl26NJwV6TZVboUcdA7dwmCzkBt+l2qLotqcVZXIAVXEI0bhM+2Jpnn+NpB+nG
	 c8VdWwOfeBO9Q6ZRvLHx9uonWJH6wYA+qjkQDRVw9Jd9kFaQJk94/OlAOkoz+LroEU
	 sAHaF+nR0oHhAKjAdBx9hhXok5aC1PR+P58hg/IPl6Ap7VKkBlQ9FZM/9lgDFDtqUI
	 UmkTbhHEQwZvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAACA81046;
	Thu, 26 Nov 2026 07:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEEA0373
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 951B740490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pR3y-U9ND7F for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63E874048E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Crj3cLc0
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63E874048E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XENT7DqVAajTJ+97/noGUSaPlCSFHrS1MCh95fXCBG4=;
 b=Crj3cLc0hRRKxj0lPAFfVjkMj4cv7uNEcCOs/ins0hY2+6tZGMXfiC2lrCVNKVdx7t4sgJ3frsxaPT7KB7txDhlX8TFBd0Cx+AHlp3ADJoRISwRxK1ayrmbdRcpLHkaARdtZqdzsonQChX3Ch4L7/fAo08wvAR6YzpLRoPuIXoVaKPqiCATxSxm7wis5yAJ9+ep9xFspqz6lycshUvl7JRqOu7DXp355zJEf0Pc+Hyz4F9rGEpMO7xdOxBDgNRaisYtOa8BOCrU3T/GTicBT/AwYNeJxDlkV8dg1315b4JK3YvQ7KN7i1os/elOpORtrdTikI29NLCkkzZVkEBVn3Q==
Received: from PAZP264CA0073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::19)
 by AS1PR10MB5337.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 07:46:29 +0000
Received: from MI3PEPF00008499.eurprd03.prod.outlook.com
 (2603:10a6:102:1fa:cafe::72) by PAZP264CA0073.outlook.office365.com
 (2603:10a6:102:1fa::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:46:29 +0000
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
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 07:46:29 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:47:18 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:46:28 +0100
Message-ID: <f591044c-740e-4b1c-8050-291f8bfc3bfa@foss.st.com>
Date: Thu, 26 Nov 2026 08:46:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH v2 20/35] clk: stm32: fix set_rate
 propagation for parent clocks
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Lukasz Majewski
 <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-21-dario.binacchi@amarulasolutions.com>
 <872fafbf-e6ca-4544-abf9-1244049ff0e7@foss.st.com>
Content-Language: en-US
In-Reply-To: <872fafbf-e6ca-4544-abf9-1244049ff0e7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008499:EE_|AS1PR10MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: a4746c57-e731-4da9-98b0-08df4b9161e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4g8Kvo6+Nqv3fz5yxnKIH0195hgKt1qaXK7YOswyDUMAwvBscy/Q0w+ioXnjr1Qchn/sbWQsR+2ta02TtVVmfvFV3fzqWJNoA6tlohOpGVEl0fXIRC0OmtZ9gDEWl3wJHsUu/rzXo2m9k8ZNvqlI8dj6mub+qXwmft2V4Ipaew9fvSeV4cZF4fsYObnl0CQuP8M/ITDC3i49k49K8BJlSVczdGZlqAq54oYF8vAzWWh3QLbY+ztcS6pHLXuNxvkuIt7+CKYlaE+22D64luL62mbw77+LJqTGAfJRgY2h2WI1Q/PnPwfPCCvAQwGnOT2q5wzF3oD7sovUgv9jhhspfSVwRfErM1oOXt05jGukDAcBqhCAgxTCSx+F95Ch5a9XSO0t3/DdTv97wJV9GTu5Szi8+gMTmPRcu0Yj0/Lm5CwhiS+lingCggwGiQPnYsN5gj6UR7Vh4tkpoZk/1nxDcGw0941Alsa98nNg2GirD5mW5b0hRqeFRUreHd6jAJT0s0PDm4osQ2gMbGlbvD7nptyGy9FEw3udNCQ75EF03QTj15VHTzC92gXgF2kNdII5PszxnZ4EUaLtBXhALEQ5jI+mLD1YnivCowH7NkH6LGD7pP17uQryjOsE3Sd7Foi7Pw8+VSZBNtNpEG4I4tPDCDF1UxUswwTpA8XsRodRN40=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NcKWMWFPrJceZy2sohEEF6vqJwoJ9zVo96z3oyf89wF+j5A0FQ7u+gWDgf+iyTHyVvhfbuhmbViGY8SWL43ywNS3dOYWbeZUE8JXYdtdTwJjUGLqydpMTJgNiSkj2UjqJIC6tOrF4x4m7EEZfmjQHI0h6Ot1c6JLO2pSk/VHFAtXUCXi1I/5XTQf/nWWN6AMUMpSkbKSS2IMY4h89g+AcAzExLmKPHLq+aO9n6ZFQ8n8O3RIvukcxX7nzOxW+vMizyaOz3KP7JsdggPEKO+0WMzhYYwXjx7MAsksM9TCN/Np+mAEWuhtYtbgYyJ5fs+ahyye4SRT6b3RpPo2rrFd9etCgzKGChe5s+/VxPyWpjdCkzFRVA492MsrMkZhHvRlhXT16qqpZItcmKGmpl8W4Esugh/PtjAhh2VuqgJwrH7uk1nCuZhsrR7gFdUDzNK3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:46:29.4525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4746c57-e731-4da9-98b0-08df4b9161e9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5337
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 11:16, Patrice CHOTARD wrote:
> 
> 
> On 11/7/26 15:32, Dario Binacchi wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Use the generic clk framework set_rate path in the STM32 RCC wrapper
>> so CLK_SET_RATE_PARENT can propagate rate changes to parent clocks
>> when the leaf clock does not implement set_rate directly.
>>
>> This is the case of the STM32MP25 LTDC kernel clock, whose rate can't
>> be set otherwise:
>>
>>   stm32_display display-controller@48010000: fail to set pixel clock 27000000 hz, ret=-38
>>
>> Fixes: 901e0d95df3b ("clk: stm32: fix clock counter")
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>
>> ---
>>
>> Changes in v2:
>> - Take the original patch from the ST downstream tree, keeping
>>   Gabriel's authorship
>>
>>  drivers/clk/stm32/clk-stm32-core.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
>> index cd6bdee5412f..29d2f64e0c76 100644
>> --- a/drivers/clk/stm32/clk-stm32-core.c
>> +++ b/drivers/clk/stm32/clk-stm32-core.c
>> @@ -168,17 +168,16 @@ static ulong stm32_clk_get_rate(struct clk *clk)
>>  
>>  static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
>>  {
>> -	const struct clk_ops *ops;
>>  	struct clk *c = NULL;
>>  
>>  	if (!clk->id || clk_get_by_id(clk->id, &c))
>>  		return -ENOENT;
>>  
>> -	ops = clk_dev_ops(c->dev);
>> -	if (!ops->set_rate)
>> -		return -ENOSYS;
>> -
>> -	return ops->set_rate(c, clk_rate);
>> +	/*
>> +	 * Let the clk framework handle CLK_SET_RATE_PARENT propagation for
>> +	 * gate clocks that do not implement set_rate directly.
>> +	 */
>> +	return clk_set_rate(c, clk_rate);
>>  }
>>  
>>  const struct clk_ops stm32_clk_ops = {
> 
> 
> Hi Dario
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Applied to u-boot-stm32/main

Thanks
Patrice

> 
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

