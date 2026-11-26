Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14438606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ab1UunlH;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RqNY5Fz1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 017BE40863;
	Thu, 26 Nov 2026 07:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fsgFjg4nZY7x; Thu, 26 Nov 2026 07:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B4A774085D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795678748;
	b=DBdQdGzoSEI2Zj+icjvIa9cZWeB75RQ680cFOxAd3F2AYxjwIRGK0N4sxta/IVYlpGrF
	 87H8BuZN514p1sldy4s7pVrrG/tq4NAyu7d5diCD4CA9uQdVfTPKZivNTkpwk4m453iIY
	 9B3yDLsq1bh4np5LOURqdnJRRDnjXTmwu/cWOq25WFVkL7LQQ3mbcvUrqCFuT0toXiPhg
	 x2ix6pzHBQlqnSZnaOqm9/jbu1RagooakS6+Zb1GpPJtdhCYJTV2hC9m9tqH56MhOZp1N
	 Z/lHzCiHtjMWKUSrOiCsqttirhSRojsQfJxHjafS3of2rbivbuajtqQh5yIpLcubRpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795678748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=NFgdci8pSe33kE9r8Cmb1rmjaFHHRKlDqXHgCsjEoGY=;
	b=J4k78SSp/nS0PYF+RbxC9IqhAo7zsmWyx6XDpReUyldASNS3J6ve5MzjPthkCLrSsz6o
	 zkh+qlxWvesGoY3GT9Aqaq0X6itHNoQOUbuhAMJjBME85akwGZU1Dl7N2PEF5QFvqV26K
	 FOnBHS5iTly2/HJgGIwuualzHqhaigQUpuUp/qYuB9e7PlxaY/Y7W1uzkKneG5Uus4DLo
	 yP1y0eH+5P2drqKHPkt7ZhOhr6qRhBvu/ioxnkreZAfN3WjmzN+VI5u1tw8yGTtm/52sA
	 YT4lsv8GUqsb4OeIymRN1Mds4bnw7Gb784PDs7xgQC1/14FSBtiVGGGrmBc8HBBZv6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795678748;
	bh=NFgdci8pSe33kE9r8Cmb1rmjaFHHRKlDqXHgCsjEoGY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ab1UunlHFmxO4TIfw+gQhsJH/sSgwYUG9nMEcIPS4NabbBu4Xi6GIYWiggL4B/ABK
	 BsacdAzrAPihCzT39LVSnq8rCbACYSi7lLDfPr1ZuIaLYjD0uvIbQTxD46v4teVFVg
	 ONNIwEbsYudQYrBF7P38a92vp9LJ8ei17OtNzjW7R2Bwx84aAr/0YfnQzjWRe5M+kk
	 HpLuajEWz27CS3RY/iO8i+K15rZF3XzbVp9LxcuaUghcimc7y9DcpyuHBOTlnqmLvD
	 BLs4pICQue4DkJqx3HIUXZHtQBJOeJRO4P2WgKJeD9jw/Q8LmiANWmh5ha2CnUJQBd
	 HVUYgdCNGYtOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4A774085D;
	Thu, 26 Nov 2026 07:39:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9782C22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DFAF40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufPzuOvo7kTB for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:39:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E3CD840493
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=RqNY5Fz1
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3CD840493
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFgdci8pSe33kE9r8Cmb1rmjaFHHRKlDqXHgCsjEoGY=;
 b=RqNY5Fz1ad3jlIyp98GazR3ffkxix2u865t2U9B9I73WmfbCQoxfZP4aUGkkxSPC94RnzRxaxvyzbTgRxuuNAGW/V8+m7ZDsBckQz1X/g8emu5hR07ak9FWsdHqzHou/BoQPc8pz403YNyISZyheTuyjgWR3WsZqFld4BYmsWBIFtd2mgzhI83sNX+bKupp0SE3SQaKeE+Ed1GkGhRj1WTEyfQkFT9upIW4ILmfVvkq4Xmp966/b7T0qrNWPqZ85b1rlq8BHWfWEky311xMSQHcAozDOS1TfQb2qLlhYtMr+1t+jOPQPg3iMHiIRQzxeZsqun11/pSzUfaa9yA/8Jw==
Received: from PR1P264CA0155.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::15)
 by PA4PR10MB7937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 07:38:54 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:102:346:cafe::4b) by PR1P264CA0155.outlook.office365.com
 (2603:10a6:102:346::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:38:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 26 Nov 2026 07:38:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:39:52 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:38:45 +0100
Message-ID: <cffbd5df-9782-4faa-80e2-0aaa01fdaf7f@foss.st.com>
Date: Thu, 26 Nov 2026 08:38:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: stm32: Fix division by zero for 32-bit timers
To: Thomas Perrot <thomas.perrot@bootlin.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Cheick Traore
 <cheick.traore@foss.st.com>
References: <20261102-tprrt-pwm-stm32-32bit-timer-div-v2-1-352fe74a27d7@tupi.fr>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261102-tprrt-pwm-stm32-32bit-timer-div-v2-1-352fe74a27d7@tupi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000052:EE_|PA4PR10MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e89c070-4e7e-47d9-8884-08df4b90526b
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|261021123027099003|261009223027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: VhBHekeBh/GUXX7Kt7Y9zPPr9fF1WXGm+1aIyL6jGlOckYLlH/9DGn8I/toXLwDWMbitcGnH3LNKDj5Cp5r/9nlkcSDGj0JyIOnfjIDNiuhAgWDw8y8CvgVe0wegiZvGeu1Dq91S2nNijz2DOMfsQw3G53fgKQ00i/r4V4UwDl9cyXl7sHTubYP+XfT0FLkGu9BeCcjGpup7bnpgXcWEzgTGWFEJ0T3SmYQSwEpG3I1y98Nbaw4Dt4FsPLfDBwwPfrl7tZZ4Ta4wYPlha458r9Cb4jZc5a4f/Ftdv+Q8jaKmxqnpbd3C5P14Ea7MQZEtKcZFqRZeY9We5scduRI8a9C3U8+GcJNAQ/vDsGPc7dXDiprOdP5wz+JU3qD+ji4YP9v8eXZqgu805rOspzD8tyGrcSlZZtIlQUVKMmjfjycgp4G6uk2uRjTpjm1nnxdAl3JbhHfJz29ZgTA14pJKUmYnD+9x7vqzWTieQrlGLnQAZErpnFXj01WJyT6kIAkUNETwdeSUgGs1NbP5gjxjqHOnu95wo0srhSc7Bv7b+PItie0KyI8JyMzKJFF7wfh8UAGmr29HLpwBCULWTR6vNRkGnTRX2z6kkKGjZUm6wKuNXIWVPmrCFlkQBv7XfwBtSP2pHFDm8rzKiLrJiubSjQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XR99VaRGXV9kjlylgMsze35q5AUzKbPvqsuJL5kZV2jT8OgLbSa1RBqzPPQrVVTLyfEkfgkaOqM2tZJcGRp81UcZsModl5iMP59Oj2jyMY21aYxAZH5dTT+nRYppWxRW2p2FhK6tMtWs6U2Vr/PHtQq/U0N0nwWwuNn96TXZ12APt6uc19+P1NKcfBPjUeXY/1/l6Xi0Cyt19C3vY2vUrdHczD4lKrUMklNirJd1MriiFKehyLyNJ9quRTavI4CKZbK4UadzrgrBhsl9M/DTXNA+cK6IFeRXd2ERRgmpcCRTusJ5a5VBxb0Fs06bQiP638QewcTYwEk4/elu/b2yx1tdkRsIm3HnrDjhNA1ztZBNvmGpC6yp9znaYl6VYyhaPwbDetvfpySFOxRD6lq4ONbznJMXYG+cvVD9B1YOvLq28HqY3nnkVXmMaWmkQ7UG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:38:53.9292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e89c070-4e7e-47d9-8884-08df4b90526b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7937
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



On 11/2/26 11:32, Thomas Perrot wrote:
> stm32_pwm_set_config() derives the prescaler with
> do_div(div, priv->max_arr + 1). max_arr is a u32, so on a 32-bit timer
> (max_arr = 0xFFFFFFFF, e.g. TIM5 on STM32MP15) the sum wraps to 0 and
> do_div() divides by zero. Configuring a PWM on such a timer, for
> instance for a backlight, resets the board.
> 
> do_div() takes a 32-bit divisor, so widening the operand is not enough.
> Use div64_u64() with a 64-bit divisor. The prescaler then comes out as
> 0, which is right since the period fits in ARR without prescaling.
> 
> Fixes: be5523d38296 ("pwm: stm32: add driver to support pwm with timer")
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> On a 32-bit timer such as TIM5 on STM32MP15, stm32_pwm_set_config()
> divides by max_arr + 1, which wraps to 0 in a u32. Seen when a
> backlight on TIM5 is configured from U-Boot.
> 
> I first implemented this fix on ST's U-Boot v2023.10-stm32mp tree.
> ---
> Changes in v2:
> - Drop the div variable and derive the prescaler from prd directly
> - Collect Tested-by and Reviewed-by from Fabrice
> - Reword the note on where the fix was first implemented
> - Link to v1: https://lore.kernel.org/r/20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com
> ---
>  drivers/pwm/pwm-stm32.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index a691f75e4a71..212389088f74 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -13,6 +13,7 @@
>  #include <asm/arch/timers.h>
>  #include <dm/device_compat.h>
>  #include <linux/bitfield.h>
> +#include <linux/math64.h>
>  #include <linux/time.h>
>  
>  #define CCMR_CHANNEL_SHIFT	8
> @@ -33,7 +34,7 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
>  {
>  	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
>  	struct stm32_timers_priv *priv = dev_get_priv(dev_get_parent(dev));
> -	unsigned long long prd, div, dty;
> +	unsigned long long prd, dty;
>  	unsigned int prescaler = 0;
>  	u32 ccmr, mask, shift;
>  
> @@ -60,12 +61,10 @@ static int stm32_pwm_set_config(struct udevice *dev, uint channel,
>  	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
>  	 */
>  
> -	div = (unsigned long long)priv->rate * period_ns;
> -	do_div(div, NSEC_PER_SEC);
> -	prd = div;
> +	prd = (unsigned long long)priv->rate * period_ns;
> +	do_div(prd, NSEC_PER_SEC);
>  
> -	do_div(div, priv->max_arr + 1);
> -	prescaler = div;
> +	prescaler = div64_u64(prd, (u64)priv->max_arr + 1);
>  	if (prescaler > MAX_TIM_PSC)
>  		return -EINVAL;
>  
> 
> ---
> base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> change-id: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061
> 
> Best regards,

Hi Thomas

Applied to u-boot-stm32/main

Thanks
Patrice
