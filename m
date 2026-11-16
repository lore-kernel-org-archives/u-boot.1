Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CC606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bwFlpAvg;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PBy2oswW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFC1A405CF;
	Mon, 16 Nov 2026 10:46:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKipg7Prflgk; Mon, 16 Nov 2026 10:46:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 149B0405BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794825963;
	b=lmfh7wi/wIlKwpVxB+e4zcfqDDcp1D8xXNx1UluuGWGVSF/rRTpzf+KFCVtemTZ/wvnD
	 VYS6NGACcW0mZ1Tw0R1fQUZ1KbN6txZ7zhP1IuiH7qexJ0jQGC5UPpalq7ki2tl2HqfYs
	 qcWXUrrkROEUPL6PR5cYd8n685FESvzzgLbgnfvN8WONqthhrFLUJeL6T1sHWoA7o9+8b
	 4YsgvY+6auxrMPMhrCwI00s5lC7NHBl+4GRQjOK1DEI1ywpkNojHPZUmpNP8Xsg1zvxrM
	 aZ9hJMqJMJadMzOmLsJNfG1A5RAvQt0iDfHwuuIe0609QFsEa6HfBg0UWI7Dy/ELX2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794825963;
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
	bh=Jgj7ipLCWXi1mChQTGKLpznmxyj/m5/WrExFYm67Quo=;
	b=Xo55iLi3Rladbh8nEw5SNTkZtCtbKGZG536zsnQfdl++eRLVFLLpZMO9CN5gfg7hpRb5
	 7XMrRQfSCCgSltBaSkTUlBOphrrQv6rSvwDc4L1NLpQzo1HLFe9jmTCSjjLP9FC0ToE2l
	 3P2RRDuOkNmefqQkTuVPYxUxxvTU1FQ6LgAbUatpJg8SN3m7QV24T1icYvyzj2UxnO4Dg
	 bPgRS5FdMpIMMLeMT+kfUSt7rF/THnTzlf7w0K2hOx7PnhKdX/wPly/gn7kD/8MbDBSEe
	 eoLXl9uQxX7iJ4JCe5JF0dgD5rsqq42xx/jNpKrvt4zFIKQj+xPKJ14FtuGkRLNKdPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794825963;
	bh=Jgj7ipLCWXi1mChQTGKLpznmxyj/m5/WrExFYm67Quo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bwFlpAvgjr20IjGTfDWLQprUuvwO+wLgwJzYHQsVZ8JjNsD3PCaUjZQ04bQlmFRQ7
	 4bYJYf21PLsEU+bn/ixCpY4nOHFEGl5kbI62kQhnkzq1vZSW1TWBXx1yL034wWcfkm
	 znMqLxG4QIucffGWg5t9boAX0C6LzursJf1TzdsBQWVmaH83D439Wf6vMHEgRFwZtF
	 kwRC5aVy/oILXTHaz9LY4Oh1+xAMkwOUBmS4LcxjuZl0MWe1yVcLoOnJszS58DmXoi
	 Txz/U0AR1CtQm7ufVon0N863g9v3+u8Gf6ewvcE6GjkvgEzSVtX4y3YvHEDU3amI9n
	 OaS8/5EUJ+FgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 149B0405BD;
	Mon, 16 Nov 2026 10:46:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25DE54DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B342400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:46:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSyLkNw_ueOl for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:46:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9A6E74009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=PBy2oswW
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A6E74009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgj7ipLCWXi1mChQTGKLpznmxyj/m5/WrExFYm67Quo=;
 b=PBy2oswWSv22Oap+mzAIN0zOlX0nBe2ifpwBDcXQMAosfP+b+/75iULKXwPDgumEng4Pq3vHzYRLxCtebY0ePMxmpYErw5zRCb3AkYXSGXpk9DNo/mhmlAwy0JJA68XtSrXTp1kZO1VGRoCxKJM60DhTQHo/bv1L7S6fu2Wp5/JSZniyz6KAR9vgpISra+U8aXZBnsyu/OirToNh5zJL+lBWu/8FLWeuZo4Aziwg/LNHpulc1tGmWLgngVlaG5NWra1iw5P7g4K8PcpX5nPxGvZ3RVEIePwCHGLPzuCQ4p2sbpJmm0Wu2vA93W/0Z6+gUemQXBjotVr6XJOKnGGQxA==
Received: from DU7P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::34)
 by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:45:53 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::74) by DU7P189CA0030.outlook.office365.com
 (2603:10a6:10:552::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 10:45:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 10:45:52 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:46:36 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:45:51 +0100
Message-ID: <98e18d51-45f8-48e3-a4fd-49cd2c6a9cff@foss.st.com>
Date: Mon, 16 Nov 2026 11:45:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/35] spi: stm32: ignore the cs-gpios polarity flags
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-22-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-22-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AS5PR10MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e91c09-5c99-46b1-4875-08df43cec960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wNgoigD2I5GV9dDXWA2fkRZ4Ww/Qvl75PMo0PUrTPvcYEuUX84Dqnil+L1yFjXf81YwVHsclAJ0QAMxSzjC80uSJt2nUMWdtQktAdy0R3u5KLMlEhldDvnpw1xWsBvuvcRPpJTJC6dmDs2jHTBnPdMMn+DmUPRg+Ey8sOg4F9PvWLSoaFCGJ+vzB8irovEDMyOC+FCOHzKsv+oGh2r9kseNSdU68dYiUDCWWJ4plPzAOMx0pOx1qyTmxc7MrHko1AH+1MtlLBNiTDeG9INbA4gVRw4MflGGcDpD1IvxAp/TEhWoNntDVuax7ETKmUfTVA4IyT6MK6ZL2CBvS814hVbrvcMdKcQkGJjk/ODOcPDIrhjFTKqxKuEOQC4bNWJM8b490fyOTKQ7FgT0aml17uRntFCeSsTLAhn18Ecks4OTmvXci2GT91yapfRhR5/iV8W3vw9oGv2hVDyJLUhpvNBgYIZwFcBw3ww11YtW792ZSBWOJ+5qIYJuzaCks8F3X9RHBiGbctwwLUHLwhpCLPh5krH8a/x+TC0G1vwNk4lhkeO/SDt0m1oPgBEnjDLM5/fxGChd0R677foduSlJhC11/2UeaiLoEPfEtDpcHG1DPb+95cYmo7wWeVxK897cYw2IKaSMVM2GYbj2bvdsHgubYrKIYycJ8/sfCyz5l1h6cu66Ym1H0CeBvrTMQqe5VQDJdK9jepWCXimqfqsoIiA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ROLs4KEbvoVfe+QGYxEvYofCTfOpgOO6ZlKi9elvApC71uXb/3q8wZ8pEQseLGmyRi+MSwh6GrRHS/idteUsS2MXQTPoEJcc6++z5ARgjVQDSHzzHaq7M6l80sNn6dF2RRg38nf/hEz8FLiCD2Y4Zx360BEN33dLTn9IMSPbMrAN92AiLy4jvS47bTNc1IHRnZHlEWgEplkwkiTNzCZRxrVtgWBnCbU+LEDlnWXupOA9ai1lc9XbSNvxmAdo9HkWFAaaJFWkjQ+XvJx7sUzyX9tkik9RhruzGUpMvPMdPNnsxRQm0ha0mJRa76aZfbPbCOyXubPcPYpSzDU+vwY0OQB9or9r1eyjXcKsMGKv6dZdmIeFAKgDzGV7BfjCErdV7ia12PFjtc/0VrWuD80WRIkds6t2KPJ0B7v5BMcMFnoTMxyjxKWHRj0j0Y6UEr1H
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:45:52.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e91c09-5c99-46b1-4875-08df43cec960
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8243
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



On 11/7/26 15:32, Dario Binacchi wrote:
> As in Linux, clear the GPIOD_ACTIVE_LOW flag of the chip select GPIOs,
> so that their polarity is given by the SPI_CS_HIGH mode only. Otherwise,
> a chip select described as GPIO_ACTIVE_LOW, as on the Engicam
> MicroGEA-STM32MP257D-RMM board, is never asserted:
> 
>   cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
> 
> Fixes: a2a89b2e21db ("spi: stm32: Add Serial Peripheral Interface driver for STM32MP")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/spi/stm32_spi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
> index c93a749cd5bf..776d88736a42 100644
> --- a/drivers/spi/stm32_spi.c
> +++ b/drivers/spi/stm32_spi.c
> @@ -624,8 +624,13 @@ static int stm32_spi_probe(struct udevice *dev)
>  		if (!dm_gpio_is_valid(&plat->cs_gpios[i]))
>  			continue;
>  
> -		dm_gpio_set_dir_flags(&plat->cs_gpios[i],
> -				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +		/*
> +		 * As in Linux, the chip select polarity is given by the
> +		 * SPI_CS_HIGH mode only, the cs-gpios flags are ignored.
> +		 */
> +		dm_gpio_clrset_flags(&plat->cs_gpios[i],
> +				     GPIOD_MASK_DIR | GPIOD_ACTIVE_LOW,
> +				     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>  	}
>  
>  	/* Ensure I2SMOD bit is kept cleared */

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

