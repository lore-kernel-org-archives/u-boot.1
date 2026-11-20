Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35F606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RxRWxtYj;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NGcC6h9/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 349BC40A9F;
	Fri, 20 Nov 2026 08:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOVYkzcY43-w; Fri, 20 Nov 2026 08:25:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 553D440A7B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795163109;
	b=skfMbT221EbX257jt18u5h8XEUGybyqh/kHMcAw5zWJMsDsZ/MSukX3vqVTqYK9dOiH8
	 LXXuRsA9zFISpzaMn5tDxJtkohKopazfGil2Gb+4/YfozoeuejbEDxK7Wbp8SY8MRnvz7
	 HbxaGxoEd9tMwOz314SHOHsaHi8RdOvaO24KrzurChVim6eTwCDrlEElTyiuwXzjJlh4e
	 jrgaVuXiPYhWAm24S0G7UGNvhfyAglHCWsHIml59YO92pUi1wk00lDug5rvOsjKjqy1Ap
	 ygAX0ZqRPtMro4jh+eZPMy9uXlJ1YPQBqQ2vZIDBPs/s3baeXhw56HCvrcdmdTSjqgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795163109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
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
	bh=x7VTdtTFXjJ8qvx+KwvaUvcEmbV8T3QQ3NK9sZ0ZCNI=;
	b=lU3f5iFpEEduDSR/DLDAyg3GmL4zsJOHXViJRbLPgaBH93as0suf3cwrcTuFg0qb15t6
	 yfFijbGChlsl+/zW2Epvc2xFtMe75995v++3jySsMYD1YcUVPR4/Jst0hej0GDQ6w45M8
	 S5BCtnYXfTCg52ykUO/1f5GSBYS/16qyngcp25sNnYxqsrCLX/mQfkOirA+7IRBA+A2wQ
	 /806DI6IoQwM7Kb0inGZHUhutSTBWCdi96LQ5WADwRA32QxB7eyYGWjHe/VQEZ/cBZ0qz
	 OcTXJvvHxuiv5uMu/ffqk8Knw2TPFTuXECulnp26t9W30dpKrVe0DAKMoRup26iZ0fQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795163109;
	bh=x7VTdtTFXjJ8qvx+KwvaUvcEmbV8T3QQ3NK9sZ0ZCNI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RxRWxtYjrmPEFLrRq7GpQxi5pGt5W4wCWstebPOBhycbscK1/Rvs0Hjg/zIhvAnWU
	 I27R2ndGz6ft/SCOsn9pikGiJQz2IwKBF08RR1pB+wIEmBNaq7Oh/HF1YDsEGP4Gnl
	 nI0VvCUB7sdEh7e8ULh3bkIJeAUO3XnUnzcnfmpODXRiWL5EaN5R5DKSbVypEA4iDz
	 xf9WGwl1D4C8u5PDILuY6KoPbbgLSvhk6dpsibTpaVvU/pD31tqVUjckxL+QZCrAaJ
	 N+adk6lRVTtJVHDSXCYrubstg9Zu3VKIXrE9nNzlvflbpjQxG8FUTVOUbAY9VsL9Ie
	 p+WQBpu2sGy8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 553D440A7B;
	Fri, 20 Nov 2026 08:25:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4345D1C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34DA24020D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UUZQw6dJ7Zlq for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 08:25:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8689F400D6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NGcC6h9/
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8689F400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7VTdtTFXjJ8qvx+KwvaUvcEmbV8T3QQ3NK9sZ0ZCNI=;
 b=NGcC6h9/Gfef2kFtZ9nt4p5+d/0yeBwsrB1gQtCU8YLDjwIXGGRg00Ju7WR1E4J2nEG2exgUUhSG9gYo8JqAuecLDK/gLl4tS4ucffq779+H/7K9xvjr1vHPj4yigmTuc8h9wVJGCeoXvmg8Mo8b5rOUMldi9bHAn+4px4pWFI6BR2BKoliXkJlwGS4yDIIN7Eq460eAcXjUkwtKzLiyq/FEwMa7m5OoIDTGj6hlpCODrNE9gTZ9F6RigBfxVGT5i7Wj7hJkj+J6aECBQDbhgvBDrBxNljRqMJcQooR0GvdNcvygL5dgYospHl1/v8Upg1MPUfKNvAT5iT70XZuEDw==
Received: from DUZPR01CA0325.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::22) by AS8PR10MB5830.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:50a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:25:00 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::3) by DUZPR01CA0325.outlook.office365.com
 (2603:10a6:10:4ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 08:25:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 20 Nov 2026 08:25:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 09:26:03 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 09:25:00 +0100
Message-ID: <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
Date: Fri, 20 Nov 2026 09:24:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
 <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|AS8PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c8fccf-4d3c-428f-3dc4-08df46dfc518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|4143699003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: FrZqw1a+5uQsv4pZuwoBqzoGLLx8rF3zr0DFN5Qtc9ghVX1ugFvKUmuK9h7OFY0YADbi6Dv7mNc+4ml1nJZnlHKRwPbgaRabSUwDhAiIplPwCtMR1gfdwVxHF3O7aYo4RfUmx6XcCVJMA37XUCJwEdg8nQ5UJGjLqM98OiakE9jzu/dzLYqF6j++Fz/B9ewOke+029posoWE8aMb34d6uyeunW34lnRRHXDgesNxll/WIRdCF+SBOJfN8oyExxW+aiBQNchBrgWTW+qLuvR01aEKxu1E3+/+NwRxtDwRPr1WRP/Kw9vgZReZlBFDpqyQ0d4njjQt7mgJDr1W+uWjnVtEJrzW0cBdw2rfOJRwkyZFT/y3VinW2BE3igY9t2tLsDbfgF+beRWMz4U0rVtItVJDrCLt/toDifOe73FQPm0ApoJ0TLqWduTyS4QJiTt9vPdBUvsWV7LcqVHb94QVcr+vki4DwObBySLe2mliZjHVjRbikmOtDejGQTqwHh5OslihovGkCfXmne9JtJx1SlZLse8mOFCtDE9TON5uFAXivvZnfRFs1mVA20QHWd6I+XXkbHIPYQNEd4t+h+VFAfL5v+uTbbhJboW5Z4tWtDXJR/qDhfxr9R6PAenw2ChgWKa+4jGJ5snYlpcEItFcdg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ZmuaAJ26C7CJECUWQZPLH7u597P+G5++5zfsm/Y30ZbYkDEAoTgSqWh0fcOn57DqsWVyej1fNVQq8gnNKNkn6LTlm1Nj1Nz05B8jW6Hu6r2yg7ZKMClHRyteRPrecudShmaqKPT9PDS5I87fyb5SEFmRGPqDgeue/7ITfYYyRexNdtjOU3WIdUZQppn7nvSbpNAMFhLRKQbYB0vlmoLLqflbRHTknLsq/e1SvmjFx531tfQzBZL+hzlRSKKgwMwoiEFq0HSoyGG8cOHsry5tFatevb/uQazCwS1RZrfyZR3RkKTLW3+LaYf3lN+bj62QEhxGef97FQXhXzzjAfnn0Nj/mVighyzyIQr/JvwyXcIKRl8npdBeHQgL2GVfPev8TwsiLavWUNp1FcP0frTctdgCvZYAO3b6JQYR3xqun5qB5zEcOozHAB7JaOecAsk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:25:00.7093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c8fccf-4d3c-428f-3dc4-08df46dfc518
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5830
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

On 11/19/26 13:14, Marek Vasut wrote:
> On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
>> This hub is powered by digital and analog 3V3 power rails, so provide
>> the possibility to use different regulators for digital (vdd) and analog
>> (vdda) power rails.
>> This is inspired by the Linux driver [1]
>>
>> [1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>   drivers/usb/common/usb_onboard_hub.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
>> index 0c84c1fede03..4b96defc2d93 100644
>> --- a/drivers/usb/common/usb_onboard_hub.c
>> +++ b/drivers/usb/common/usb_onboard_hub.c
>> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>>   static const struct onboard_hub_data usb2514_data = {
>>       .power_on_delay_us = 500,
>>       .reset_us = 1,
>> -    .num_supplies = 1,
>> -    .supply_names = { "vdd-supply" },
>> +    .num_supplies = 2,
>> +    .supply_names = { "vdd-supply", "vdda-supply" },
> Is this an ABI change and does this break existing users ?

Hi Marek,

I've tested with and without on stm32mp157c-ev1. There's no breakage on exiting DT.

BR,
Fabrice
